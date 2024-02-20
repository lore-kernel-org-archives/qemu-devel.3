Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361EDC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 13:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQEL-000390-Du; Tue, 20 Feb 2024 08:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcQED-00038P-2R
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 08:32:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcQE3-0001mW-4e
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 08:32:08 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso5439151a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708435917; x=1709040717; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BAJGdYtpYyL/Q1kNF26aw0+oXulhkKJp6xrIWjfrmSo=;
 b=XAd1hWmChmDS/VS8VhW+iTo+0KE9fUHDA820lfkJRJ5SgRX5D6mrrFBPpxP/GVMDHD
 eRsz6pRlojT0IUW0wZhod9IUQgJNH1kCnMSqMNHBMKezB5O+B0eeLMJOiEuKmEiXl+v/
 8MK+m5Ol38N9qBd4n4viYOXFR6zF+pjaJv8c+kX7stxpvuAmqa514dPszVWDYjLRERn8
 9QTUhX879Qz2YoNKdMaVlp7CAejX8YF8fBQeB7d7qjkqG90Cqkc3GdCRfKEeliwb7YN2
 r2jjuf/Lyk+OZorfGz/KrJp7skAZGYGop+YCUOgQmLR6R98EVegQ8LiE06HFnFgGj7/F
 tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708435917; x=1709040717;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BAJGdYtpYyL/Q1kNF26aw0+oXulhkKJp6xrIWjfrmSo=;
 b=Hkcf6Y/eHzKZji2rY/8gR0K2mo0dGFVL8a4N6t6LIy0dsUWyym+cmbH45C8Bcj/vOw
 5Oexsa9BSaIQsPJCa0jvMxNq5Neqgnj9betCeCMJTKgh1VFJ6tvjIlO7oB9ZqV/sfY4r
 RflmJCQYBQTu7B8dbgohZkt7T0cagw94nSlr6S44aka0O5I5nK8QP6T5Pjqep4TIagjh
 miX5MSHVQ5uBkxtv2tsIAZt9Gdyt+RWlg4UgHXio1i6gHHrwcgP1v6vdWx7dUYwcmRsa
 8nBMNieWud42xja1Xp3QnA2cN2EhoCGVUqGdfyClwFotDhUNByOQJa49DiQ0fho1A1Wd
 C06w==
X-Gm-Message-State: AOJu0YzDpqTR2fMqipDIormjy/IdlGSj0cUMih7dgAK47K2b2meCb4j9
 rDGAb58/q8FBIh/Px/b/sf6f0mE6kv81Dw5Qd7r9aEg5XKorsuxFvME7N51y0D4368EGTuIEMku
 uIFnLW9I2OTakwYC4wLdLom+MMSVEwfLG0A4=
X-Google-Smtp-Source: AGHT+IFWTShOIGmjQqc36ujn7nmHcUMw4pVHlwVHCoyZ2wzSnytJ3UqWEp2tiBykhOZ4k0htmRq9/FME2cOhysNoiZA=
X-Received: by 2002:a05:6402:38a:b0:563:dd8f:996d with SMTP id
 o10-20020a056402038a00b00563dd8f996dmr8321029edv.9.1708435917083; Tue, 20 Feb
 2024 05:31:57 -0800 (PST)
MIME-Version: 1.0
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Tue, 20 Feb 2024 14:31:46 +0100
Message-ID: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
Subject: QNX VM hang on Qemu
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f59aae0611d03bd4"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f59aae0611d03bd4
Content-Type: text/plain; charset="UTF-8"

Hi everyone,
I am facing an issue during booting QNX VM using Qemu,
I have an image to Boot the VM. and when I trigger a Qemu command to create
a VM it is stuck.
I also used a debugger to investigate but I can not see any result by GDB.

Here is the output of first windows

qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display none
-device loader,file=QNX-IFS,addr=0x00100000,cpu-num=0 -drive
file=/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img,if=sd,format=raw,index=1
-boot mode=5 -net nic,model=cadence_gem -net nic,model=cadence_gem -net
nic,model=cadence_gem -net nic,model=cadence_gem,netdev=xzynq0 -netdev
user,id=xzynq0,tftp=/tftpboot  -nographic -global
xlnx,zynqmp-boot.cpu-num=0 -global 'xlnx,zynqmp-boot.use-pmufw=true' -s -S

qemu-system-aarch64: warning: hub 0 is not connected to host network

on the other hand, here is the output of GDB:

(gdb) target remote :1234
Remote debugging using :1234
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
0x0000000000100000 in ?? ()
(gdb) c
Continuing.

-- 
Kind Regard-
Faiq Ali Sayed

--000000000000f59aae0611d03bd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi everyone, <br></div><div>I am facing an issue duri=
ng booting QNX VM using Qemu,</div><div>I have an image to Boot the VM. and=
 when I trigger a Qemu command to create a VM it is stuck.</div><div>I also=
 used a debugger to investigate but I can not see any result by GDB.</div><=
div><br></div><div>Here is the output of first windows</div><div><br></div>=
<div><div><span style=3D"background-color:rgb(238,238,238)">qemu-system-aar=
ch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display none -device loader,f=
ile=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive file=3D/home/faiq/Downlo=
ads/install/BootSD/qemu-boot_sd.img,if=3Dsd,format=3Draw,index=3D1
 -boot mode=3D5 -net nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -=
net
 nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netd=
ev user,id=3Dxzynq0,tftp=3D/tftpboot =C2=A0-nographic -global xlnx,zynqmp-b=
oot.cpu-num=3D0 -global &#39;xlnx,zynqmp-boot.use-pmufw=3Dtrue&#39; -s -S</=
span></div><span class=3D"gmail-im"><div><span style=3D"background-color:rg=
b(238,238,238)"><br></span></div><div><span style=3D"background-color:rgb(2=
38,238,238)">qemu-system-aarch64: warning: hub 0 is not connected to host n=
etwork</span><br></div><div><br></div></span><div>on the other hand, here i=
s the output of GDB:</div><div><span style=3D"background-color:rgb(204,204,=
204)"><br></span></div><div><span style=3D"background-color:rgb(238,238,238=
)">(gdb) target remote :1234<br>Remote debugging using :1234<br>warning: No=
 executable has been specified and target does not support<br>determining e=
xecutable automatically.=C2=A0 Try using the &quot;file&quot; command.<br>0=
x0000000000100000 in ?? ()<br>(gdb) c<br>Continuing.</span></div></div><div=
><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" =
class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"lt=
r"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:#ffffff" size=3D"1"><br></font></div><=
br></div></div></div></div></div>

--000000000000f59aae0611d03bd4--

