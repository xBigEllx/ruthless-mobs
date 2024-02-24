#Example Usage:
#powershell/build.ps1 -MinecraftVersion 1.20.0 -ModVersion 1.0.0 -ModName RuthlessMobs

param(
        [Parameter(Mandatory=$true)]     
        [String]$MinecraftVersion,

        [Parameter(Mandatory=$true)]     
        [String]$ModVersion,

        [Parameter(Mandatory=$true)]     
        [String]$ModName
)

$full_version = $MinecraftVersion + '-' + $ModVersion
$project_root = $PSScriptRoot + '\..\'
$src_path = $project_root + '\src\'
$dist_path = $project_root + '\dist\'

$file_name = $ModName + '-' + $full_version
$source_path = $src_path
$destination_path_zip = $dist_path + $file_name + '.zip'

# Create 'dist' directory
if (Test-Path -Path $dist_path) {
        Remove-Item -LiteralPath $dist_path -Recurse
}
New-Item -Path $project_root -Name "dist" -ItemType "directory" -Force

# Build the file
Add-Type -Assembly "System.IO.Compression.FileSystem" ;
[System.IO.Compression.ZipFile]::CreateFromDirectory($source_path, $destination_path_zip);
Rename-Item -Path $destination_path_zip -NewName ($file_name + '.mcaddon')