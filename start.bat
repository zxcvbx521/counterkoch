@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Counter-KOCH: запуск локального сервера на http://localhost:8765
echo Не закрывай это окно, пока играешь.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$l=New-Object Net.HttpListener;$l.Prefixes.Add('http://localhost:8765/');$l.Start();Start-Process 'http://localhost:8765/index.html';$root=(Get-Location).Path;$types=@{'.html'='text/html; charset=utf-8';'.png'='image/png';'.jpg'='image/jpeg';'.jpeg'='image/jpeg';'.mp3'='audio/mpeg';'.js'='text/javascript'};while($l.IsListening){$c=$l.GetContext();try{$p=[Uri]::UnescapeDataString($c.Request.Url.AbsolutePath.TrimStart('/'));if($p -eq ''){$p='index.html'};$f=Join-Path $root $p;if(Test-Path -LiteralPath $f -PathType Leaf){$b=[IO.File]::ReadAllBytes($f);$t=$types[[IO.Path]::GetExtension($f).ToLower()];if(-not $t){$t='application/octet-stream'};$c.Response.ContentType=$t;$c.Response.ContentLength64=$b.Length;$c.Response.OutputStream.Write($b,0,$b.Length)}else{$c.Response.StatusCode=404}}catch{};$c.Response.Close()}"
