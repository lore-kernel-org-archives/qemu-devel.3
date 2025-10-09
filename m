Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4ADCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tXS-0001x3-KH; Thu, 09 Oct 2025 12:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v6tXP-0001vi-N3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:30:44 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v6tXM-0002MW-CC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:30:43 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-57bd482dfd2so1206423e87.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760027436; x=1760632236; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yfy1uw0tzBmzu04ewmVK3e/c3N9puNn3+f72CIFjysA=;
 b=D9dXiex3EElDkLQjyVyoo21ZOPxXIRN6Fwi/hL3O6CVjmH84bt4uB1fHfdo7L1IqR7
 jLSYhgmXSIz4ilwcghoGHR2kdVsIDehb4zG2fJElmEp5Uu/7RndwbOACISdOEOboY/pk
 DTQ3YPyDYV3bV5iZh9ej+hNdIx3QJrz8dGi4i+32zgtbjr7RTe+W7bDVIfKYrZkpMd/R
 88Bc9Ds6QGm1ml2JvJEZPNmHYsUXqjPyV36SMrnyu7ZOTlR0wCSXHi3gH/U+l1y6/yhr
 07fZKPS6CMOrpxCFqgO0xFG1eWPT58KsFIF37335IPvc4xLSuci2xW9rMmd3u/wzFzvE
 f3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760027436; x=1760632236;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfy1uw0tzBmzu04ewmVK3e/c3N9puNn3+f72CIFjysA=;
 b=lryfTSQVfu0c9sDVlWE9PELx7eSwfLO673Kg9bdmJX3FjGNBgAJdRkyLdEYp8vYy8k
 4b9YRMzcgy+spbU2e9ynRl3WdKJaFCJUcEkHv9OQdCTk8SVRBuEfdtXYSos8joSLA0RA
 /j5FAiaKvMvTNFfLRbwZoajPgReuEyXEph84jc0pBjoYi/kdAu1/WHBzOrsNM4Qf4N4K
 CGRKOChEEwrm/AQjZ5xY5PTVrfZ+PFmC1Q8tW7hLJ0SKswPfmYdnLDIeUdqtTtAT5RA8
 0lDlK014KjC3F6GhrzuUY9uZ7Lkk7xLsZN5ydGh5VzpUuu5PwMbYuiM8xPHxBJnOPVWT
 t/XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtWBa8odT44+4E5PQ7NGpl5Kti4Jm3psSGqQqONQqj0ms8PSusisTqua7n5ByCKiMKeSAtadTPc7if@nongnu.org
X-Gm-Message-State: AOJu0Yx3A5pmV6YtbAXVApPQFpwCIU3IAVrKIiNF4pUbrzaUD1P6JNFc
 U5h1PFOmj54dciFFaDDuWzzcARMsx6ffaqs13qvSz7opUXmVYooLj+Hk
X-Gm-Gg: ASbGncsSSCYE6TLjhw84wbvUnMmwSgwXKOXTmPgTFCPl0B7BWdP6rd7a9OxC5sWz7im
 2laTu32Ctdolh0m0NX2AcQ9dPEWBxs48+DkgAO5F5uSwqNUBjHW5YH0H2rbGUoYDTWc3ZgqTvfb
 7NpFybw7TjXd6OzT0cQJsJY/xvnmE2CRgPE5+E2V85QeJTQDAaOOtpx7GwCPuoU+LyBrg4HpEDY
 vnK5knbz5VwSueyeQn3YKB2265okFH6HTXeNNRYD5HxrhivlpPqTpubipUFax6kMxRsVb7KUgAQ
 WjSAurvk9sNTc9F8nahEUJmR+j0NosMACz5zSMvf2bnBwqy6BZL8eoqELRcLCDp861QjIbIQuLw
 8r2+6Ga23mgl/4p33JFvDZ1FXdTRHg4Kzaxs/Bz/ZoyUiHwyqpB1t72Zrb/1Tu3mElAI=
X-Google-Smtp-Source: AGHT+IGzqIY4dPGYrbYxu/CCBHusrsqXTvTd8Wx7c0VenbOJgmwj4rXH4wzN5pDtmQ1ba5+dut1SEA==
X-Received: by 2002:a05:6512:3e1d:b0:571:86bc:423b with SMTP id
 2adb3069b0e04-5906d9e8a5fmr2291928e87.44.1760027435679; 
 Thu, 09 Oct 2025 09:30:35 -0700 (PDT)
Received: from smtpclient.apple ([2a02:6bf:8011:f00:6191:211a:2507:cf35])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5907ac2349fsm1174239e87.56.2025.10.09.09.30.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:30:34 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
Message-Id: <9961189C-3A61-4767-B620-C1B7315495CA@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_5F9C7B1A-F043-4F6D-A059-7892AC94ABF2"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
Date: Thu, 9 Oct 2025 19:30:22 +0300
In-Reply-To: <CAFEAcA8LQi+nVztx7oz6yGaYgKvnECj_0Xom3NbxLAFK82hWTQ@mail.gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org
To: Peter Maydell <peter.maydell@linaro.org>
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
 <20251007151157.5a601c3e@fedora>
 <DFAE42FB-786F-45D3-9FC5-C72DEC5A4301@gmail.com>
 <CAFEAcA8LQi+nVztx7oz6yGaYgKvnECj_0Xom3NbxLAFK82hWTQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_5F9C7B1A-F043-4F6D-A059-7892AC94ABF2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 9 Oct 2025, at 16:29, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Thu, 9 Oct 2025 at 14:26, Alexander Gryanko <xpahos@gmail.com =
<mailto:xpahos@gmail.com>> wrote:
>>=20
>>=20
>>=20
>>> On 7 Oct 2025, at 16:11, Igor Mammedov <imammedo@redhat.com> wrote:
>>>=20
>>> On Sat, 4 Oct 2025 23:19:09 +0300
>>> Alexander Gryanko <xpahos@gmail.com> wrote:
>>>=20
>>>> Currently, pvpanic is available in three device types: ISA,
>>>> MMIO, and PCI. For early stages of system initialisation
>>>> before PCI enumeration, only ISA and MMIO are suitable.
>>>> ISA is specific to the x86 platform; only MMIO devices
>>>> can be used for ARM. It is not possible to specify a
>>>> device as on the x86 platform (-device pvpanic); the
>>>=20
>>> perhaps ARM folsk know better, don't we have some
>>> user create-able sysbus devices? Can it be implemented
>>> as such, so we would avoid creating built-in device?
>>=20
>> As a QEMU user, I expected there to be a way to specify a dtb from a =
file that could be used as the actual device tree inside the virtual =
machine. Perhaps there is a way to do this, but I am not very familiar =
with the QEMU code and do not know how it should work.
>=20
> You can generally use '-machine dtb=3Dfile.dtb'. But note that
> this entirely overrides any internally generated dtb file
> for machines that do that, so for those machine types it's
> mostly a helpful debugging tool.

I added '-machine dumpdtb=3Dqemu.dtb', then converted dtb to dts 'dtc -I =
dtb -O dts -o qemu.dts qemu.dtb', added=20

        pvpanic@9060000 {
                reg =3D <0x0 0x09060000 0x0 0x2>;
                compatible =3D "qemu,pvpanic-mmio";
        };

Then I compiled qemu without optimisation and set a breakpoint in =
=E2=80=98pvpanic_mmio_initfn'. It was never called with '-machine =
dtb=3Dfile.dtb'. 'info qtree' also does not show the device. Perhaps I =
have configured something incorrectly?

/opt/qemu10/bin/qemu-system-aarch64 \
  -S -d guest_errors,unimp -trace enable=3Ddevice_* -D $CWD/qemu.log \
  -trace memory_region_ops_write \
  -cpu cortex-a72 \
  -m 2048 \
  -bios $CWD/QEMU_EFI.fd \
  -nographic \
  -qmp unix:$CWD/qmp.sock,server,nowait \
  -drive if=3Dvirtio,format=3Draw,file=3D$CWD/market.img \
  -chardev =
socket,id=3Dch0,path=3D$CWD/serial0.sock,reconnect=3D1,logfile=3D$CWD/seri=
al0.log \
  -serial chardev:ch0 \
  -blockdev =
driver=3Dfile,filename=3D"$CWD/OVMF_VARS.fd",node-name=3Duefi-vars,read-on=
ly=3Don \
  -vnc :0 \
  -display none \
  -audiodev none,id=3Dnone \
  -machine virt,dtb=3Duefi.dtb \
  -monitor stdio \

>=20
> -- PMM


--Apple-Mail=_5F9C7B1A-F043-4F6D-A059-7892AC94ABF2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 9 Oct 2025, at 16:29, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">On Thu, =
9 Oct 2025 at 14:26, Alexander Gryanko &lt;</span><a =
href=3D"mailto:xpahos@gmail.com" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">xpahos@gmail.com</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">&gt; =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br><br><br><blockquote type=3D"cite">On 7 Oct =
2025, at 16:11, Igor Mammedov &lt;imammedo@redhat.com&gt; =
wrote:<br><br>On Sat, 4 Oct 2025 23:19:09 +0300<br>Alexander Gryanko =
&lt;xpahos@gmail.com&gt; wrote:<br><br><blockquote =
type=3D"cite">Currently, pvpanic is available in three device types: =
ISA,<br>MMIO, and PCI. For early stages of system =
initialisation<br>before PCI enumeration, only ISA and MMIO are =
suitable.<br>ISA is specific to the x86 platform; only MMIO =
devices<br>can be used for ARM. It is not possible to specify =
a<br>device as on the x86 platform (-device pvpanic); =
the<br></blockquote><br>perhaps ARM folsk know better, don't we have =
some<br>user create-able sysbus devices? Can it be implemented<br>as =
such, so we would avoid creating built-in device?<br></blockquote><br>As =
a QEMU user, I expected there to be a way to specify a dtb from a file =
that could be used as the actual device tree inside the virtual machine. =
Perhaps there is a way to do this, but I am not very familiar with the =
QEMU code and do not know how it should work.<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">You can generally use '-machine =
dtb=3Dfile.dtb'. But note that</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">this =
entirely overrides any internally generated dtb file</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">for machines that do that, so for those =
machine types it's</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">mostly =
a helpful debugging tool.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote><div><br></div><div><div>I =
added '-machine dumpdtb=3Dqemu.dtb', then converted dtb to dts 'dtc -I =
dtb -O dts -o qemu.dts qemu.dtb', =
added&nbsp;</div><div><br></div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
pvpanic@9060000 {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; reg =3D &lt;0x0 0x09060000 0x0 0x2&gt;;</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible =3D =
"qemu,pvpanic-mmio";</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
};</div><div><br></div><div>Then I compiled qemu without optimisation =
and set a breakpoint in =E2=80=98pvpanic_mmio_initfn'. It was never =
called with '-machine dtb=3Dfile.dtb'. 'info qtree' also does not show =
the device.&nbsp;Perhaps I have configured something =
incorrectly?</div><div><br></div><div><div>/opt/qemu10/bin/qemu-system-aar=
ch64 \</div><div>&nbsp; -S -d guest_errors,unimp -trace enable=3Ddevice_* =
-D $CWD/qemu.log \</div><div>&nbsp; -trace memory_region_ops_write =
\</div><div>&nbsp; -cpu cortex-a72 \</div><div>&nbsp; -m 2048 =
\</div><div>&nbsp; -bios $CWD/QEMU_EFI.fd \</div><div>&nbsp; -nographic =
\</div><div>&nbsp; -qmp unix:$CWD/qmp.sock,server,nowait =
\</div><div>&nbsp; -drive if=3Dvirtio,format=3Draw,file=3D$CWD/market.img =
\</div><div>&nbsp; -chardev =
socket,id=3Dch0,path=3D$CWD/serial0.sock,reconnect=3D1,logfile=3D$CWD/seri=
al0.log \</div><div>&nbsp; -serial chardev:ch0 \</div><div>&nbsp; =
-blockdev =
driver=3Dfile,filename=3D"$CWD/OVMF_VARS.fd",node-name=3Duefi-vars,read-on=
ly=3Don \</div><div>&nbsp; -vnc :0 \</div><div>&nbsp; -display none =
\</div><div>&nbsp; -audiodev none,id=3Dnone \</div><div>&nbsp; -machine =
virt,dtb=3Duefi.dtb \</div><div>&nbsp; -monitor stdio =
\</div></div></div><br><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">-- =
PMM</span></div></blockquote></div><br></body></html>=

--Apple-Mail=_5F9C7B1A-F043-4F6D-A059-7892AC94ABF2--

