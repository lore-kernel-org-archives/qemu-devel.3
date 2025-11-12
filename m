Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B9FCD4853
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 22:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJIz7-0000ZY-7N; Wed, 12 Nov 2025 17:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vJIfn-0006Dk-Ux
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 16:46:51 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vJIfk-0001pE-6F
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 16:46:38 -0500
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso214406a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 13:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762983994; x=1763588794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+K0CQ5cTVI5rouzPoAFMVICrxC8BrBaLBaJXESjPzuk=;
 b=RzTZazDriQ8XPySMA5HQjTJahIQXCgD5epV90ONlZSA9RGcDu32vi9PfjdFgCRUiRi
 ybCCGfUXVg/j4hVd3fB16bg68JBKO07VKc2tBL/IsFJv4/Hx/TMoZlnLYJqMxskwpdmK
 yYu0tAGMK2WF3Kl2qvVSrDPXy74XlmlTqDglAV7fQ/rV5erLPrzE9x3w6ZrVAWBt+Cln
 uEo+icRcIo98+THArr+VQFff+HW0/NqTPj1c0Wa4E5H2y8+SZZ2ewHDLXcabh+A6IPlv
 V0PWd4ESdY2w8zcXCf/231RfZtW7LVyBAq2OteKxknuqLyuYnmt7eq3znA9QgV7Y1PyY
 hydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762983994; x=1763588794;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+K0CQ5cTVI5rouzPoAFMVICrxC8BrBaLBaJXESjPzuk=;
 b=o73SM9lIg8Sek3Jk2iPXmM+Bf4J5xpo6Rd25eFa71zWRgzuM9G9JGKo58Wr8Le2kDV
 waMzXuzSf0WWECIrkdEWeOeZOEwKR2Ozm8cMcmx8gCs199kgbsP+i68a/KFMmQ99bzy5
 hOfnst6cOtnpb9O/bHBSSFbVHhmhL8ypp6ehaZ5NBqn4kxQueap7ZuEH25Lg2rtXyNGb
 vE6U54k8mHeakl52erem/SiMTYA95iLvYLfUeAAiO5gwKoE36XIRnByMI8QjJgqw1Mzx
 +bQkQvEqMXIJXPXTP+10+8vdHBfDkCGfexst3e7fhFUXx/QHFggROsy0VDshz2AeE4T6
 AK0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqKM0+FqtHXchfK16qRVTG0Jzz8hjWTyf8fBNTcjeIfMnlgxSJz1kGEKSAePRmiD1i6kQjKy0FSiqh@nongnu.org
X-Gm-Message-State: AOJu0Yz1XRzzVjbNULU3vpTf2kAW8eps6ygOd4IM/il96pLHIrEGkbSx
 ij51nS5XpyX2mmAzaHHqXInyIEmb3eRIlFgX976VwIziMq4ReWuXjrWlfw7J1Q==
X-Gm-Gg: ASbGncsvRu0svlVlN6G2fDm4YK5GULLS5ya4XPUTFr1ia0Igs1j91Oye/oF8EMJs1+v
 Yf2Ph55VUBiHLan+WHh975za9ZkB8Of+nshRYOY79P6k6r6KTaF6oJJ8yKdQTMsavcrWRq7Uo9F
 eWNcSfVkpI1v8wOFk1zXbsx3r6PSLoAdYqUWXT/s1JRocF7cXeyh4S/qqXlchUg68f2aIWrIFu2
 2beJGTQ4JxieJSa3dJEXJ7ou333TSiw9EBBvQKZNdPNSM2LMqLhqQ4xi3mUyc7LmmnyEd8ldpaw
 US+IHK4YcTJ3AxsUq1butLmkWhXzn4004j00GrmU2Dy/z+8zl4agplBP+RdDTfMMz4eodm4JEWS
 9qvoELdHbRHigbXRnFO1iKwgsG76GI95XrgIaeFOGM56fO20FJlFU5mf7I498/DA+zmE6J992wW
 df/iQOndHxaS/6H9ZPq6pD7MCg9A5Z7zcrg6mPx3j/tL82KJ1jhY25OQw7rvSCtW0Qw0QOL7orN
 3opl06lj8O1kEwaLgLTCOQs
X-Google-Smtp-Source: AGHT+IFX13QHzGDwFuL5P2yjVScSF4iyfQIMkp2bMrNYGXpgOLoSpOIiwG63Jdn2/C5nBmmYUEvs+w==
X-Received: by 2002:a05:6402:27c8:b0:637:e2b8:605b with SMTP id
 4fb4d7f45d1cf-6431a39740dmr4143417a12.5.1762983993908; 
 Wed, 12 Nov 2025 13:46:33 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2416-f400-bdbc-21c7-75fc-dd84.310.pool.telefonica.de.
 [2a02:3100:2416:f400:bdbc:21c7:75fc:dd84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64169852018sm10629631a12.16.2025.11.12.13.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 13:46:32 -0800 (PST)
Date: Wed, 12 Nov 2025 21:46:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_Re=3A_=5BPATCH_13/13=5D_hw/arm/fsl-imx8mm=3A?=
 =?US-ASCII?Q?_Adding_functional_testing_of_iMX8MM_emulation?=
In-Reply-To: <AM9PR04MB8487096A518874924AC17DEB87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
 <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
 <AM9PR04MB8487682307D0672DA3F5345B87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB84874E537D542ED6CD0216F387CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB8487096A518874924AC17DEB87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
Message-ID: <D361607E-6F67-4FEC-BC68-A71BB1823B9C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.48; envelope-from=shentey@gmail.com;
 helo=mail-ed1-f48.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 12=2E November 2025 11:02:13 UTC schrieb Gaurav Sharma <gaurav=2Esharma=
_7@nxp=2Ecom>:
>@'Bernhard Beschow' looks like I was referring to the hex dump of a diffe=
rent Debian disk image=2E I have got the offset for iMX8MM now=2E I have te=
sted it as well=2E The console looks good=2E Now the only question remains:=
- shall we continue using offset based method to extract dtb or download it=
 from the cloud instead?

Nice! I'd slightly prefer extracring the DTB from the image for consistenc=
y and to have only one URL that could break in the future=2E Does this work=
 for you?

>
>-----Original Message-----
>From: Gaurav Sharma
>Sent: 12 November 2025 12:35
>To: 'Bernhard Beschow' <shentey@gmail=2Ecom>; 'qemu-devel@nongnu=2Eorg' <=
qemu-devel@nongnu=2Eorg>
>Cc: 'pbonzini@redhat=2Ecom' <pbonzini@redhat=2Ecom>; 'peter=2Emaydell@lin=
aro=2Eorg' <peter=2Emaydell@linaro=2Eorg>
>Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional=
 testing of iMX8MM emulation
>
>Sorry The correct xxd dump for dtb offset 0x64F51000:- xxd -s 0x64F51000 =
-l 4 disk=2Eraw
>64f51000: e103 16aa                                =2E=2E=2E=2E
>
>
>-----Original Message-----
>From: Gaurav Sharma
>Sent: 12 November 2025 12:28
>To: 'Bernhard Beschow' <shentey@gmail=2Ecom>; qemu-devel@nongnu=2Eorg
>Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional=
 testing of iMX8MM emulation
>
>Thank you for reviewing Bernhard=2E Yes, iMX8MM is very close to iMX8MP t=
hat's why I chose to stick to that structure=2E
>
>" Looks like these lists are sorted alphabetically=2E Shall we preserve t=
hat?"
>
>-- yes "tests_aarch64_system_thorough" should be sorted alphabetically pr=
eserving the original order - - will modify it in v2 patch
>
>"This DTB offset is the one for the imx8mp-evk, and in fact the console l=
og confirms it=2E Both machines seem to be so similar that the test passes =
anyway"
>
>-- yes, I just found out in the console log=2E The test was giving a fals=
e positive=2E Thank you for the heads up!  I have now modified it to fetch =
the dtb from the Debian stable repository=2E Verified it's working correctl=
y via console log
>
>What you need is the offset in the "disk=2Eraw" image that gets extracted=
 from above file=2E Open "disk=2Eraw" in a hex editor and search for "imx8m=
m-evk", then determine the offset of the preceeding "d00df00d" DTB magic=2E=
 That is your offset=2E
>
>-- do you mean the DTB magic "d00dfeed" instead of "d00df00d"? Also, whil=
e I was analysing the DTB offset of the mainlined imx8mp functional testing=
 'disk=2Eraw' which has debian-12-generic-arm64-20231210-1590=2E The script=
 mentions the DTB_OFFSET at 0x64F51000=2E Dumping this offset using xxd[als=
o verified it via hex editor]:- # xxd -s 0x51000000 -l 4 disk=2Eraw
>51000000: 6cff 0060
>It doesn't mention the DTB magic number at this offset=2E Please let me k=
now if I am missing anything here =2E
>Can we choose not to rely on the hardcoded offset and instead download th=
e dtb from the Debian stable repository itself? This way the same functiona=
l test can be used easily for the future imx board porting as well=2E
>Looking forward to your guidance=2E
>
>
>
>-----Original Message-----
>From: Bernhard Beschow <shentey@gmail=2Ecom>
>Sent: 12 November 2025 04:51
>To: qemu-devel@nongnu=2Eorg; Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>Subject: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional tes=
ting of iMX8MM emulation
>
>[You don't often get email from shentey@gmail=2Ecom=2E Learn why this is =
important at https://aka=2Ems/LearnAboutSenderIdentification ]
>
>Caution: This is an external email=2E Please take care when clicking link=
s or opening attachments=2E When in doubt, report the message using the 'Re=
port this email' button
>
>
>Am 10=2E November 2025 11:22:57 UTC schrieb Gaurav Sharma <gaurav=2Esharm=
a_7@nxp=2Ecom>:
>>Added script that would validate the iMX8MM emulation by checking the
>>linux console log=2E If it succeeds, it will return:-
>>
>>ok 1 test_imx8mm_evk=2EImx8mmEvkMachine=2Etest_aarch64_imx8mm_evk_usdhc
>>
>>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>
>>Hi Gaurav!
>
>>Nice to see another imx8 machine being contributed! I'm impressed how cl=
ose you stick to the imx8mp, both in terms of structuring this series as we=
ll as the code=2E
>
>>I've built your series and ran the functional test=2E Comments below=2E
>
>
>
>
>--
>
>>---
>> tests/functional/aarch64/meson=2Ebuild        |  2 +
>> tests/functional/aarch64/test_imx8mm_evk=2Epy | 67 ++++++++++++++++++++=
+
>> 2 files changed, 69 insertions(+)
>> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>>
>>diff --git a/tests/functional/aarch64/meson=2Ebuild
>>b/tests/functional/aarch64/meson=2Ebuild
>>index 5ad52f93e1=2E=2E31ecedbf6f 100644
>>--- a/tests/functional/aarch64/meson=2Ebuild
>>+++ b/tests/functional/aarch64/meson=2Ebuild
>>@@ -5,6 +5,7 @@ test_aarch64_timeouts =3D {
>>   'aspeed_ast2700fc' : 600,
>>   'device_passthrough' : 720,
>>   'imx8mp_evk' : 240,
>>+  'imx8mm_evk' : 240,
>>   'raspi4' : 480,
>>   'reverse_debug' : 180,
>>   'rme_virt' : 1200,
>>@@ -28,6 +29,7 @@ tests_aarch64_system_thorough =3D [
>>   'device_passthrough',
>>   'hotplug_pci',
>>   'imx8mp_evk',
>>+  'imx8mm_evk',
>
>Looks like these lists are sorted alphabetically=2E Shall we preserve tha=
t?
>
>>   'kvm',
>>   'multiprocess',
>>   'raspi3',
>>diff --git a/tests/functional/aarch64/test_imx8mm_evk=2Epy
>>b/tests/functional/aarch64/test_imx8mm_evk=2Epy
>>new file mode 100755
>>index 0000000000=2E=2Ed5eb43afc6
>>--- /dev/null
>>+++ b/tests/functional/aarch64/test_imx8mm_evk=2Epy
>>@@ -0,0 +1,67 @@
>>+#!/usr/bin/env python3
>>+#
>>+# Functional test that boots a Linux kernel and checks the console # #
>>+SPDX-License-Identifier: GPL-2=2E0-or-later
>>+
>>+from qemu_test import LinuxKernelTest, Asset
>>+
>>+class Imx8mmEvkMachine(LinuxKernelTest):
>>+
>>+    ASSET_IMAGE =3D Asset(
>>+        ('https://cloud=2Edebian=2Eorg/images/cloud/bookworm/20231210-1=
590/'
>>+         'debian-12-generic-arm64-20231210-1590=2Etar=2Exz'),
>>+
>>+ '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
>>+
>>+    KERNEL_OFFSET =3D 0x51000000
>>+    KERNEL_SIZE =3D 32622528
>>+    INITRD_OFFSET =3D 0x76000000
>>+    INITRD_SIZE =3D 30987766
>>+    DTB_OFFSET =3D 0x64F51000
>
>This DTB offset is the one for the imx8mp-evk, and in fact the console lo=
g confirms it=2E Both machines seem to be so similar that the test passes a=
nyway=2E
>
>What you need is the offset in the "disk=2Eraw" image that gets extracted=
 from above file=2E Open "disk=2Eraw" in a hex editor and search for "imx8m=
m-evk", then determine the offset of the preceeding "d00df00d" DTB magic=2E=
 That is your offset=2E
>
>Best regards,
>Bernhard
>
>>+    DTB_SIZE =3D 45 * 1024
>>+
>>+    def extract(self, in_path, out_path, offset, size):
>>+        try:
>>+            with open(in_path, "rb") as source:
>>+                source=2Eseek(offset)
>>+                data =3D source=2Eread(size)
>>+            with open(out_path, "wb") as target:
>>+                target=2Ewrite(data)
>>+        except (IOError, ValueError) as e:
>>+            self=2Elog=2Eerror(f"Failed to extract {out_path}: {e}")
>>+            raise
>>+
>>+    def setUp(self):
>>+        super()=2EsetUp()
>>+
>>+        self=2Eimage_path =3D self=2Escratch_file("disk=2Eraw")
>>+        self=2Ekernel_path =3D self=2Escratch_file("linux")
>>+        self=2Einitrd_path =3D self=2Escratch_file("initrd=2Ezstd")
>>+        self=2Edtb_path =3D self=2Escratch_file("imx8mm-evk=2Edtb")
>>+
>>+        self=2Earchive_extract(self=2EASSET_IMAGE)
>>+        self=2Eextract(self=2Eimage_path, self=2Ekernel_path,
>>+                     self=2EKERNEL_OFFSET, self=2EKERNEL_SIZE)
>>+        self=2Eextract(self=2Eimage_path, self=2Einitrd_path,
>>+                     self=2EINITRD_OFFSET, self=2EINITRD_SIZE)
>>+        self=2Eextract(self=2Eimage_path, self=2Edtb_path,
>>+                     self=2EDTB_OFFSET, self=2EDTB_SIZE)
>>+
>>+    def test_aarch64_imx8mm_evk_usdhc(self):
>>+        self=2Erequire_accelerator("tcg")
>>+        self=2Eset_machine('imx8mm-evk')
>>+        self=2Evm=2Eset_console(console_index=3D1)
>>+        self=2Evm=2Eadd_args('-m', '2G',
>>+                         '-smp', '4',
>>+                         '-kernel', self=2Ekernel_path,
>>+                         '-initrd', self=2Einitrd_path,
>>+                         '-dtb', self=2Edtb_path,
>>+                         '-append', 'root=3D/dev/mmcblk2p1',
>>+                         '-drive', f'file=3D{self=2Eimage_path},if=3Dsd=
,bus=3D2,'
>>+
>>+ 'format=3Draw,id=3Dmmcblk2,snapshot=3Don')
>>+
>>+        self=2Evm=2Elaunch()
>>+        self=2Ewait_for_console_pattern('Welcome to ')
>>+
>>+if __name__ =3D=3D '__main__':
>>+    LinuxKernelTest=2Emain()

