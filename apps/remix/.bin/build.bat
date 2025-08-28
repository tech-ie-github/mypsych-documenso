@echo off
REM Exit on error.
setlocal enabledelayedexpansion

REM Store the original directory
set ORIGINAL_DIR=%CD%

REM Change to the web app directory
cd /d "%~dp0.."

echo [Build]: Extracting and compiling translations
call npm run translate --prefix ../../

echo [Build]: Building app
call npm run build:app

echo [Build]: Building server
call npm run build:server

REM Copy over the entry point for the server.
copy server\main.js build\server\main.js

REM Copy over all web.js translations
xcopy /E /I /Y "..\..\packages\lib\translations" "build\server\hono\packages\lib\translations"

echo [Build]: Done

REM Return to original directory
cd /d "%ORIGINAL_DIR%"
