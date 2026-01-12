Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D827CD25050
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfE1P-00047D-Q3; Mon, 12 Jan 2026 04:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfE1M-00043V-FT
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:15:32 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfE1K-0006VG-Kz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:15:32 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b83949fdaso10126582a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768209328; x=1768814128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqD8zWYx6VXAE5aU9umR0x8lAwEafog5aHkZic2HdNg=;
 b=JZYAItQTEpEMG9j2/XqU2F0TPFC4KmY+LUqxfA/O9H7v9WDzu4OSlOuyKVRh+2gMfy
 T/vv+ZS6Ux3VdxWEELxeps55/AP0aCOkl7/q4sGcIFTbDAfeqhnSPUDMSqvNCFlf3MG/
 ZpbqXuKL35idhpdMhXKvwW1QBFuEapBS2Pj2aDGv5wGSsramn6G6xgy3195axj6uGudK
 zhQNvakcq5wKk4xHnNXky0kG/whVWV9fglrtf4eFCH4zIOnNRk1tiOhH6e1Ts5fmsIhP
 7ChP+t2a4uknrR2dQdXjxOm6ZyB6geyuePQ9vAFzkzeA4/8W0LFRnXP5BpRiCpxejuve
 qWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768209328; x=1768814128;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wqD8zWYx6VXAE5aU9umR0x8lAwEafog5aHkZic2HdNg=;
 b=T656bK+L6VUkDxRRWzV7UdfCeGqHnn7+rnWlOqQJCEh0DNpklQTUbD72wtDIUh5p0R
 rYoOxFW9P8bKU/5Lr1HeoMNoSsoutLlbCTkQ3xzMlF9IOtsMILqQKRzmyxmTeG+6Y3ya
 dGQOcvTOtR8QVEeupMgiSUcWogyouPunzyqnmVz9I3OwBgLu2o60E2MYTVo0CAO6bMn/
 r+dnQPCoIAhyDofTsHt13TJd2QR3yV3iF1umUxF0+zZomHOsBi6gUBW4F0wCD3LoOE0R
 gSHYnsZ0EJCmMEuVlIC4jdSAuHDuA0r+aL2HVHIORu+7jEoZpOnoVqoUqRnjm/C1EH0c
 gRYQ==
X-Gm-Message-State: AOJu0Yzwj7ff8CRw5VUjSkfJknvWC49m1SEC1p2KTWQpfznGgkmRzBMf
 4bTEfmtG1WjQcOmnrxawGlIJzRpdMd8DkB9A6WhttuUMUzwb0gggeByiEqDkXQ==
X-Gm-Gg: AY/fxX7kWUTWQKgLPdW6SJzVzsxFMmafNp8ldlOWHr6NMvgKKnVbmpIV9k3RgM5ekU1
 k2e1AwDMCWcoWktFz5RhcxEo1wJ0nqaBHUOLvLaPYMnsZcx6Vmmg/ykKAQg/M7qzU234I48+ixi
 cqydaHzjAmZsuPsv0H70zsddiZUdYWZdCqJtIg8dmlDU50mq2ahPeronU1jIIIoZptwGg8kRKbO
 0J54wsmmSWNV/IfwZXcKD81G4o473KFhnIV6BfvXqujPUeW8ynCr2GH38Gy42PGe86P4mHh169Z
 4grhh6PHJuaS4UcujHwOdJHPayXbADmuYSLZDzGPT99V5xddCqkBQ30/oKaLn3oSzxyOkO4DgaL
 sEX5poYR7q1KwiIIewZq0ACn3LRkfTV2/l2WXA4sEbu+BXYMrytf0tkp3/ttMbjX9tTOyWZ6IzN
 KpTSLsXrmcBTnMbuX+m8Pmm+p330eEa7HHw8jN1MFTKfEeblSeTP0djzXkQ0B+aXyRUWi+Zskwg
 wyi89B/WLKPnZeBAELQ99oHYZiGlglecwQ=
X-Google-Smtp-Source: AGHT+IF8/ICo/NLges2oBOMGn0sjGlQE8N8Ubc7/epr4Cebj37Qj0bykb4ANVqUxdxUBMkqaCq4uEQ==
X-Received: by 2002:a17:906:59a7:b0:b86:fca7:3dc5 with SMTP id
 a640c23a62f3a-b86fca73f83mr422562466b.28.1768209327446; 
 Mon, 12 Jan 2026 01:15:27 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-299b-b200-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:299b:b200:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a5180bdsm1825825366b.57.2026.01.12.01.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 01:15:27 -0800 (PST)
Date: Mon, 12 Jan 2026 09:15:22 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_15/15=5D_hw/arm/fsl-imx8mm=3A_Add?=
 =?US-ASCII?Q?ing_functional_testing_of_iMX8MM_emulation?=
In-Reply-To: <20251205053819.2021772-16-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-16-gaurav.sharma_7@nxp.com>
Message-ID: <58E2AC3A-C08B-4A97-93EE-96276DCD0C1B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 5=2E Dezember 2025 05:38:19 UTC schrieb Gaurav Sharma <gaurav=2Esharma_=
7@nxp=2Ecom>:
>Added script that would validate the iMX8MM emulation by checking the
>linux console log=2E If it succeeds, it will return:-
>
>ok 1 test_imx8mm_evk=2EImx8mmEvkMachine=2Etest_aarch64_imx8mm_evk_usdhc
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> tests/functional/aarch64/meson=2Ebuild        |  2 +
> tests/functional/aarch64/test_imx8mm_evk=2Epy | 67 +++++++++++++++++++++
> 2 files changed, 69 insertions(+)
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>
>diff --git a/tests/functional/aarch64/meson=2Ebuild b/tests/functional/aa=
rch64/meson=2Ebuild
>index 5ad52f93e1=2E=2Ec0e5be1b58 100644
>--- a/tests/functional/aarch64/meson=2Ebuild
>+++ b/tests/functional/aarch64/meson=2Ebuild
>@@ -4,6 +4,7 @@ test_aarch64_timeouts =3D {
>   'aspeed_ast2700' : 600,
>   'aspeed_ast2700fc' : 600,
>   'device_passthrough' : 720,
>+  'imx8mm_evk' : 240,
>   'imx8mp_evk' : 240,
>   'raspi4' : 480,
>   'reverse_debug' : 180,
>@@ -27,6 +28,7 @@ tests_aarch64_system_thorough =3D [
>   'aspeed_ast2700fc',
>   'device_passthrough',
>   'hotplug_pci',
>+  'imx8mm_evk',
>   'imx8mp_evk',
>   'kvm',
>   'multiprocess',
>diff --git a/tests/functional/aarch64/test_imx8mm_evk=2Epy b/tests/functi=
onal/aarch64/test_imx8mm_evk=2Epy
>new file mode 100755
>index 0000000000=2E=2E224fe4669e
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
>+    DTB_OFFSET =3D 0x64DB5000
>+    DTB_SIZE =3D 36812

The only difference to test_imx8mp_evk=2Epy is the DTB=2E Can we share the=
 test between both SoCs by extracting both DTBs there? The test function te=
st_aarch64_imx8mp_evk_usdhc() could get an additional parameter for the DTB=
 and one could drop the "p" (and possibly the "test_" prefix) from the func=
tion name=2E Then two new functions test_aarch64_imx8m*_evk_usdhc() take th=
e role as test functions=2E

Does this work?

Best regards,
Bernhard

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

