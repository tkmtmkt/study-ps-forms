<#
start powershell -ArgumentList "-NoLogo","-NoProfile","-WindowStyle Hidden","-File",".\main.ps1"
#>
# �A�Z���u���̓ǂݍ���
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#�X�g�b�v�E�H�b�`
$Watch = New-Object System.Diagnostics.Stopwatch

#�^�C�}�[
$Timer = New-Object System.Windows.Forms.Timer
$Timer.Interval = 10
$Time = {
    $Now = $Watch.Elapsed
    $Label.Text = "$Now".substring(0,11)
}
$Timer.Add_Tick($Time)

# �t�H�[���̍쐬
$MainForm = New-Object System.Windows.Forms.Form
$MainForm.Size = "190,170"
$MainForm.font = New-Object System.Drawing.Font("���C���I",9)
$MainForm.StartPosition = "CenterScreen"
$MainForm.MinimizeBox = $False
$MainForm.MaximizeBox = $False
$MainForm.TopLevel = $True
$MainForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
#FixedSingle�AFixed3D�AFixedDialog�AFixedToolWindow
$MainForm.Modal = $True
$MainForm.Text = "�X�g�b�v�E�H�b�`"

# ���ԕ\�����x��
$Label = New-Object System.Windows.Forms.Label
$Label.Location = "10,10"
$Label.Size = "150,50"
$Label.text = "00:00:00.00"
$Label.Font = New-Object System.Drawing.Font("���C���I",16)
$Label.textAlign = "MiddleCenter"

# �J�n�E��~���p�{�^��
$Button = New-Object System.Windows.Forms.Button
$Button.Location = "10,70"
$Button.Size = "70,50"
$Button.Text = "�J �n"
$Click = {
    IF ( $Watch.IsRunning -eq $False ) #�X�g�b�v�E�H�b�`���N�����Ă��Ȃ��� = �v�����J�n
    {
        $Timer.Start()
        $Watch.Start()
        $Button.Text = "�� �~"
    }else{ #�X�g�b�v�E�H�b�`���N�����Ă��鎞 = �v�����~
        $Timer.Stop()
        $Watch.Stop()
        $ResetButton.Enabled = $true
        $Button.Text = "�� �J"
    }
}
$Button.Add_Click($Click)

# ���Z�b�g�{�^��
$ResetButton = New-Object System.Windows.Forms.Button
$ResetButton.Location = "90,70"
$ResetButton.Size = "70,50"
$ResetButton.Text = "���Z�b�g"
$ResetButton.Enabled = $False
$Reset = {
    $Label.text = "00:00:00.00"
    $Watch.Reset()
    $Button.Text = "�J �n"
    $ResetButton.Enabled = $False
}
$ResetButton.Add_Click($Reset)

# �t�H�[���Ɋe�A�C�e����ݒu 
$MainForm.Controls.AddRange(@($Label,$Button,$ResetButton))

# �t�H�[����\�� 
$MainForm.ShowDialog()
