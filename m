Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ED7CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 23:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIxg8-0001Ox-9i; Tue, 11 Nov 2025 18:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vIxg6-0001OU-F8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:21:34 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vIxg4-00046K-Ji
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:21:34 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b73301e6ab5so45561666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 15:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762903290; x=1763508090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqBlJ9Cjw2ySFQc5WCljyQb9YRLRi7RZ6MKIh39D8o8=;
 b=URqQD3KpPq3YMhRg+MKAnyCiNdb1br3WKAtPxMnVBUDoPzCcHZ06vj3ktrg5+COUq8
 x9sPcJrW4MU5raGFB+9F5QlZDKSDxO7nDp71rVmCYflkbfZFkIEvAwTJq9p+Uk8jjhsj
 RjUroI/RNyJBwK2HAceZslL0/eU09J9W7RuyAF60UYmOdbpoQcmvDIZ1+sWaI9yN4t85
 xCo7/4XGNfR71yTyjajTZBze4cw6UTkC+v9mylIiUEfWQSKG/AS8Q5dEJgogya6WHKai
 LRGkwxjhiepHS36HeoP7A6h5F7vtcMTtoZcPj0pmTX9O7UVbsrcD+VzVI+vO64h6xyRL
 CmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762903290; x=1763508090;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oqBlJ9Cjw2ySFQc5WCljyQb9YRLRi7RZ6MKIh39D8o8=;
 b=kz8HZ95IoCZcWkI9RLNWGegjVdijU5WZEnd/JaS9PbhX9BPUie1kTKWBiCU15/xOld
 hwzWqkzYFU2z8d467hiAFp/JXRWjjflx0R11pgxaTk0n2bbstcQn5TcuxX2K6gw+8jLb
 KNXxAbjhsg+/3EkjUaC5ntQbjYTgp+cuTiNxo7uS3O+MC01DPwRu62sMVq+suDZr5ruZ
 J4KW5FlOgKh+OaVlV0yMwlc+jGj4G+Cj7hdIz6gOsTgJ9RFpMGsrOPAKDU+WYmL4AdJG
 UWvbDRqOxID/3F3ZUAtdrCv9vbDhAp//KgGXU05hoSdfDxhPDBQbvmZPA7mcYA7v83CW
 65SA==
X-Gm-Message-State: AOJu0Ywyxq1KdXatN2EgGFzimV2WBYJS/HOL5M8H3mwcqxQmlAG2KhlL
 aeoC6IvPJ3CpGvfPgjUAc68sNQjAjY8FDEoWXUWmRg2ziaqxpyrArrAn9glVzQ==
X-Gm-Gg: ASbGncuY7W7XR/6uKZeW9W4RPgDelwwZiW6emPlxa+QzbA5t2wuQViqMXfKNVbYFzE1
 yP8Imz2zV0v68MtpK6Wdq36FLjHxMrk+o9WxE/1TgKRUq/VIQcjo4jpayKSpxS9gugE/Qov9lt2
 jLRBQHAPqDioJqgmBVkOUOewNhhLaxqhokv8ks0ClVJfVZmkHxT6zbchyu98D2OuOCVtK8jqvst
 4PcaPxmYqOEUWmIXCJsiYKBBz2XF2snomQ/hBsKkMAn7LwYiomZgeg5Dj2a8Dq93VdtfpjSoWGn
 zP174JDbRIrm9hbkdqHdR3p0n9MuU7es45VH559JA3gZQouQHIoG7+Jk+wRbPeF1wr3xLnp18bd
 q2dflEwZ0Xp0OSwkMY+ISoAV4eKyLAYP77SpmX/yRTomwNLjL0+7Qu2DyP45brv7AF1tPhMIbGK
 lgX9IQokv8r17XYP2cGklfK5nNYhoSxDAMtR+pQYbVEow2XwO6sYRS0Wjcx5GtkAUZGg1vxWgc
X-Google-Smtp-Source: AGHT+IEJlD0iUSXb2aZeiXpEKRjNErkqADXqdXlx/yfoqQZPSnq32E7kF9djYD4Do2L7ZfxHMI9PPg==
X-Received: by 2002:a17:906:794b:b0:b73:222b:4d04 with SMTP id
 a640c23a62f3a-b7331a80e64mr85439466b.29.1762903290034; 
 Tue, 11 Nov 2025 15:21:30 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-089-012-236-180.89.12.pool.telefonica.de. [89.12.236.180])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf312240sm1466991066b.18.2025.11.11.15.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 15:21:29 -0800 (PST)
Date: Tue, 11 Nov 2025 23:21:27 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_13/13=5D_hw/arm/fsl-imx8mm=3A_Addi?=
 =?US-ASCII?Q?ng_functional_testing_of_iMX8MM_emulation?=
In-Reply-To: <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
Message-ID: <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 10=2E November 2025 11:22:57 UTC schrieb Gaurav Sharma <gaurav=2Esharma=
_7@nxp=2Ecom>:
>Added script that would validate the iMX8MM emulation by checking the
>linux console log=2E If it succeeds, it will return:-
>
>ok 1 test_imx8mm_evk=2EImx8mmEvkMachine=2Etest_aarch64_imx8mm_evk_usdhc
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>

Hi Gaurav!

Nice to see another imx8 machine being contributed! I'm impressed how clos=
e you stick to the imx8mp, both in terms of structuring this series as well=
 as the code=2E

I've built your series and ran the functional test=2E Comments below=2E

>---
> tests/functional/aarch64/meson=2Ebuild        |  2 +
> tests/functional/aarch64/test_imx8mm_evk=2Epy | 67 +++++++++++++++++++++
> 2 files changed, 69 insertions(+)
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>
>diff --git a/tests/functional/aarch64/meson=2Ebuild b/tests/functional/aa=
rch64/meson=2Ebuild
>index 5ad52f93e1=2E=2E31ecedbf6f 100644
>--- a/tests/functional/aarch64/meson=2Ebuild
>+++ b/tests/functional/aarch64/meson=2Ebuild
>@@ -5,6 +5,7 @@ test_aarch64_timeouts =3D {
>   'aspeed_ast2700fc' : 600,
>   'device_passthrough' : 720,
>   'imx8mp_evk' : 240,
>+  'imx8mm_evk' : 240,
>   'raspi4' : 480,
>   'reverse_debug' : 180,
>   'rme_virt' : 1200,
>@@ -28,6 +29,7 @@ tests_aarch64_system_thorough =3D [
>   'device_passthrough',
>   'hotplug_pci',
>   'imx8mp_evk',
>+  'imx8mm_evk',

Looks like these lists are sorted alphabetically=2E Shall we preserve that=
?

>   'kvm',
>   'multiprocess',
>   'raspi3',
>diff --git a/tests/functional/aarch64/test_imx8mm_evk=2Epy b/tests/functi=
onal/aarch64/test_imx8mm_evk=2Epy
>new file mode 100755
>index 0000000000=2E=2Ed5eb43afc6
>--- /dev/null
>+++ b/tests/functional/aarch64/test_imx8mm_evk=2Epy
>@@ -0,0 +1,67 @@
>+#!/usr/bin/env python3
>+#
>+# Functional test that boots a Linux kernel and checks the console
>+#
>+# SPDX-License-Identifier: GPL-2=2E0-or-later
>+
>+from qemu_test import LinuxKernelTest, Asset
>+
>+class Imx8mmEvkMachine(LinuxKernelTest):
>+
>+    ASSET_IMAGE =3D Asset(
>+        ('https://cloud=2Edebian=2Eorg/images/cloud/bookworm/20231210-15=
90/'
>+         'debian-12-generic-arm64-20231210-1590=2Etar=2Exz'),
>+        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b35=
9')
>+
>+    KERNEL_OFFSET =3D 0x51000000
>+    KERNEL_SIZE =3D 32622528
>+    INITRD_OFFSET =3D 0x76000000
>+    INITRD_SIZE =3D 30987766
>+    DTB_OFFSET =3D 0x64F51000

This DTB offset is the one for the imx8mp-evk, and in fact the console log=
 confirms it=2E Both machines seem to be so similar that the test passes an=
yway=2E

What you need is the offset in the "disk=2Eraw" image that gets extracted =
from above file=2E Open "disk=2Eraw" in a hex editor and search for "imx8mm=
-evk", then determine the offset of the preceeding "d00df00d" DTB magic=2E =
That is your offset=2E

Best regards,
Bernhard

>+    DTB_SIZE =3D 45 * 1024
>+
>+    def extract(self, in_path, out_path, offset, size):
>+        try:
>+            with open(in_path, "rb") as source:
>+                source=2Eseek(offset)
>+                data =3D source=2Eread(size)
>+            with open(out_path, "wb") as target:
>+                target=2Ewrite(data)
>+        except (IOError, ValueError) as e:
>+            self=2Elog=2Eerror(f"Failed to extract {out_path}: {e}")
>+            raise
>+
>+    def setUp(self):
>+        super()=2EsetUp()
>+
>+        self=2Eimage_path =3D self=2Escratch_file("disk=2Eraw")
>+        self=2Ekernel_path =3D self=2Escratch_file("linux")
>+        self=2Einitrd_path =3D self=2Escratch_file("initrd=2Ezstd")
>+        self=2Edtb_path =3D self=2Escratch_file("imx8mm-evk=2Edtb")
>+
>+        self=2Earchive_extract(self=2EASSET_IMAGE)
>+        self=2Eextract(self=2Eimage_path, self=2Ekernel_path,
>+                     self=2EKERNEL_OFFSET, self=2EKERNEL_SIZE)
>+        self=2Eextract(self=2Eimage_path, self=2Einitrd_path,
>+                     self=2EINITRD_OFFSET, self=2EINITRD_SIZE)
>+        self=2Eextract(self=2Eimage_path, self=2Edtb_path,
>+                     self=2EDTB_OFFSET, self=2EDTB_SIZE)
>+
>+    def test_aarch64_imx8mm_evk_usdhc(self):
>+        self=2Erequire_accelerator("tcg")
>+        self=2Eset_machine('imx8mm-evk')
>+        self=2Evm=2Eset_console(console_index=3D1)
>+        self=2Evm=2Eadd_args('-m', '2G',
>+                         '-smp', '4',
>+                         '-kernel', self=2Ekernel_path,
>+                         '-initrd', self=2Einitrd_path,
>+                         '-dtb', self=2Edtb_path,
>+                         '-append', 'root=3D/dev/mmcblk2p1',
>+                         '-drive', f'file=3D{self=2Eimage_path},if=3Dsd,=
bus=3D2,'
>+                                    'format=3Draw,id=3Dmmcblk2,snapshot=
=3Don')
>+
>+        self=2Evm=2Elaunch()
>+        self=2Ewait_for_console_pattern('Welcome to ')
>+
>+if __name__ =3D=3D '__main__':
>+    LinuxKernelTest=2Emain()

