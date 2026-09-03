Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C5C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25bn-0008OF-U7; Thu, 03 Sep 2026 07:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bg-00080F-7B; Thu, 03 Sep 2026 07:27:50 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bd-0006vi-DZ; Thu, 03 Sep 2026 07:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPsA5sjPrvb1wNn3OfcOn39EQiSBSy7fGxG/bWdlVr8T+Y9wUwJM98p532Yaajx82TkPgVJcpkv2Y+wJZeQPrX5xFOik0MPfycvLLJXnv0kHdY1uem19UjJdxidn6JJtU5jY1/wMIRFI3kUMxnTIUnwAn2X01/X0GrSlBTIiuIRIP3gcwsz1vFvVr0NvRqheR2I0Eqr++ti4lfWHpFdCgUSeGTV3IAGdqraFPbORlOBe0Yn0Emw3m+BqFu+Td/xngkdWOvB7np+uGf+qBHySwFHS6ksDeStz1hVhXthz5nE31CcEXLKHtNtOZ+qscywohwic/OtQuGEZuet6bYvvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVqKloa/c5/aUT0o4faKTAF3AZyUGR9cnw1olxP9meQ=;
 b=s089g0WyQUzD3OqQrPEiN5YfkVNk4xtN3mGOdWwP0o2m7inWxARrHwcl/x9J9Vo0IPumCL4h4cU1TIfZwsdlXeie5kouqwZtt5b5fpCZ2v2oqcziL/MHVAcSxMa0TuGGboXiU4t3RFDVjIoHIi4EBBHn6rE0txq2yllki9cu1LyeBBr4UtOgFkLaeckMXjEahlIurfJIDtqkgRT0wrThrOyibZZgS5JF5humiU5t5RVHtPuGnKhw80WKrI1PlswFDxw5bSx5FI2n136qgq8NkIvempiPi+GH9qxy8MFDN4zloxX7Hgeh0NRrcMaV4N3fYeFciiUH/tLZGRXLgLxsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVqKloa/c5/aUT0o4faKTAF3AZyUGR9cnw1olxP9meQ=;
 b=V3fe74G2/Qt8cH/akjMJLv4PR+A1p0LiCWgQbB+wFf5pPB9jyRkKaWe9beuB+6JH+lUXBdzU9+Hy5qwEs9kGExSKcxFZs/sHirJbr13fji7l1zOkkyUsgcv2z2/ekHIkUO2uxkDAkc1z4uWUe58kiotxEYehQXB+nHqkCjSaxmKvrVys2Ncd/yTiZelXaLsYCSo6ZUZWCegJjoCFa+ygeK3rA2EPD4IBMe0Cebt2mXJUwYkvJStcC7nb4U+3mP0MojK5WiC7911OASNvhtvmyndNlfVmsAxF0hsMGtwqYMKrPe/RdSQ/pkCoZMexAUMCX7EOQdpiF0+0dLFWhcMsgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by PS1PPFF2E6AB00E.apcprd02.prod.outlook.com (2603:1096:308::2b1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:27:20 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:27:20 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 32/33] tests/functional/aarch64: Add Phytium Pi boot tests
Date: Thu,  3 Sep 2026 19:25:12 +0800
Message-ID: <20260903112532.3276678-33-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|PS1PPFF2E6AB00E:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bce17f-b4b2-4ec9-72a4-08df09ae409f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L9VQgoUTecowAH6faBvHu/xXgWPQOFNqGIsxEjFB6egyj8FO1+b+9ieV2PPNcV+0yO3wZHANYF8G2U9Usp/DZ3Ffzx2uuhSTZCZ4a/DVIpuaIFLlhxgKub/tKydXAGmvQsg+4EhdUA+IL/ZnOrOYlUgho6sW3kHsQwir5AJSi128S49QKZz5gopcqhPv3ByaVyaiHMa3BV0w2uZazWZgz7l5W5SOIjykHe+qXO81O3H8z5YXH7lOKWFU5B1Mug/HIZaj11X5CQK/Ih8wqiu/TlArrwYYlb/U4yWlEWx7nfpbNtgP6HmPPhbHlfDptmkm8Ekkn9ho9fwsK02G8eD7CwyiueGfJ1UQBM0O7nW+nPQBkNodC9tlqUhe2W/IyoaDADQGfqU41sgIawgkUkqoFolSJQdH+DzG/snEx4rC/SdTLCqXe5BsmKOo6WN6Tn8oFoNPu+49A4qDQx4h0m1B+MD1PNIUtHOKKGipl4TdzJ2cZTRpsyh+Ukml7SkSK4lV2OiN1Zf22hr9lZ7cePjJRXCpqHAICcHJuczD4IQRTfhZyxeP1M//H+TfQRQN0/lbZQCne4UWBGIa4DUsm0A+jOyHvfzMh1k1AB0/G5/xUxzPBStkoXd0bxtKmVyDaqNEXoNRMa7MPdze/PXJ4oS6BZpup1Ul0oXZRWWZsgbqZvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CuulGdTeAGA/bRoPnFMYKmRiGMbz7pMFFGD0RdhYLZ7nYCd/gMAxgMs4WVGW?=
 =?us-ascii?Q?fjwqkq7cAhWEfcJUMWE0e9+nLGvfwfq/oaFCQz2qi3fXMi8T+W+N9lbZetD/?=
 =?us-ascii?Q?f12YCO09ASEm4gIfhUP3Wr4/txYQpBAaW3aX2LHNTGcKdYcIkPfA0iCr1gW9?=
 =?us-ascii?Q?l9Pk9DeObYCVYKiKs1an0FZswl4bDLWd7zgt2oB0Cyx/PPqanbPtyh/SZWju?=
 =?us-ascii?Q?EqU3ZzoFibubYdLFczWABXGA+zcyT6jicwpDsVb79zYLaYPn44pEO8ggg/th?=
 =?us-ascii?Q?sJJAT8sqwx6/Z3JIC9gyWvnScs/Xa1/UR/MwtcLxrZqh43oMd0AZQHMgv+Eh?=
 =?us-ascii?Q?WaNAOhei78batnRhyIqm6nBCD0KveMtPiXYEd9SC3CDCL/yPe5ehYkXCvGtW?=
 =?us-ascii?Q?wRKIWV3VhQFISvtl0GzJVr6C9pTpNotURaiFsUj/oXd1eOq9/KqtBB6Mvpur?=
 =?us-ascii?Q?tHZTzMR/pCRvXwu+t2H1UjxH8r3brymyo+e/NQbS3+TXTb4phl+rH4MQe+sS?=
 =?us-ascii?Q?IBJ+BIiuk+KS9TnNdWfelqgG1zt8ujF+HUHEaxctwZfo6jbFmfH6zwKyn9t2?=
 =?us-ascii?Q?a3YzC8B5fLo29saT0iKCaxBrfPpF5CSOUK/y5Vlna7MVOvPYsZo8qTXfYedH?=
 =?us-ascii?Q?ZQAzpM59R8C2GE/K3+vz2mIAwmbiTEVJCZTwphqfbJa6kb2vFNwzQEYPLr4n?=
 =?us-ascii?Q?7IHbsVEKjAy4gO3nqXc+Gmy1oDV1KCUgZxGr6PlJ3/EGWrgcKyEVCIJ014J6?=
 =?us-ascii?Q?sGEdTxG/ZXT5vXtcpKWqo2cY5wS/4MzrB8pcIfYAiVFAIKevODgmZ6FBEWY5?=
 =?us-ascii?Q?iIzSLIxA4eu1dNMoolP+Wnxx5UY6g+xOAUaPh9wqOyhsGy4+9EiPi6mE87Va?=
 =?us-ascii?Q?Tcsql3/He5KfNa6XjWUUZtTuQVeywfwJ6amjWAuypq39qEU6glXeyfYBGwKB?=
 =?us-ascii?Q?alExrSagEdomrf0EgticR1q9LTfpjtO5NUFetnKcSL8klkR2WqSqcD6kIWZT?=
 =?us-ascii?Q?ktKnFhbOYxKyr37LL3MQnlbUEK4uztMAVHndduRl/tFcJOUvoxSV0T7RBf7+?=
 =?us-ascii?Q?TCkONYh65XiTWuTrg2mxWZN07JhjxGmVhIz6Lq0Jafx8zVMEkvNibpId6Kdy?=
 =?us-ascii?Q?XXZ1y5KHZvk5uk2fPDBsG5Sncl8SmIIEdzs1Ysa2UT1/U36cW9IfFRxw4ySK?=
 =?us-ascii?Q?9vE+jeam+xNo2IRO3S4y3tSI5r4jGTDbhEQEfkSobOrtf4ds4qwgSM4bdxZU?=
 =?us-ascii?Q?28AGhv6vXJhUGDHIseb3hKwu+ogTgVHydGTo6D6lvB/g0GzJJNf2sCjTYemV?=
 =?us-ascii?Q?Wx/C19eFlnNeHS3+P10fxoPqmGOpsuv2x6vThoIehl9D8c9phVCXE9zjmtSX?=
 =?us-ascii?Q?nopv1lfMINQS/L9zkcPiwM6L0FSGleK9y9EB4JGn1Qq/en9pQ3WmV0TkB7wt?=
 =?us-ascii?Q?0/eWAWPiucQOA+7w0OeCZO5+wPK+IfAPoAlov2Dc9CKUj2LGLHy8Mn2KqPhs?=
 =?us-ascii?Q?v9qztqeEV/m0R7gUP5SW+9JTHF5P7Bsfc3U5rV4wdjX+0QCb/sn9IS2RCaF8?=
 =?us-ascii?Q?dABnTFpzA+AV1ORRZz9Fr1128HXaWIFUOVLq39rZHY4zTwBcX9SglhS+zkey?=
 =?us-ascii?Q?tJySMK9l1eFgHxHVP4FbptsKn5uGnI2CL7fmKLwXsTh3o2r/6FW2JtYgOz48?=
 =?us-ascii?Q?CC4PW3McxOJSYCCwJ9oNz1jPlVsJ5fT7sD/YoU9Uf9EdJjSgozlLxk2nriSr?=
 =?us-ascii?Q?vOixWJlyFzvQzwEajO2CzRKenFaYOs4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bce17f-b4b2-4ec9-72a4-08df09ae409f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:52.4498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1dSnYYYK4xHUbH6I/39jKfnXW46XOFoAW/ehBeMQRbInQ/mlOPiEUACXTZDrO0rb6kxZ+3eKx3DAZg/cl7WNg79/kbELGmqalzvJ9jWYbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF2E6AB00E
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The Phytium Pi machine supports both the board firmware flow from SD
and direct Linux boot. Exercise both paths with an SDK image bundle so
firmware handoff and kernel loading regressions are caught.

Verify U-Boot, PBF relocation, the Linux handoff, and login for the
firmware path. The Linux test loads the bundled kernel, DTB, and
initramfs and waits for the same login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 tests/functional/aarch64/meson.build        |  2 +
 tests/functional/aarch64/test_phytium_pi.py | 77 +++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tests/functional/aarch64/test_phytium_pi.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index f0881bed16..71bf45e4ea 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -7,6 +7,7 @@ test_aarch64_timeouts = {
   'device_passthrough' : 720,
   'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
+  'phytium_pi' : 600,
   'raspi4' : 480,
   'reverse_debug' : 180,
   'rme_virt' : 1200,
@@ -39,6 +40,7 @@ tests_aarch64_system_thorough = [
   'imx8mp_evk',
   'kvm',
   'multiprocess',
+  'phytium_pi',
   'raspi3',
   'raspi4',
   'replay',
diff --git a/tests/functional/aarch64/test_phytium_pi.py b/tests/functional/aarch64/test_phytium_pi.py
new file mode 100644
index 0000000000..4ae0392bdd
--- /dev/null
+++ b/tests/functional/aarch64/test_phytium_pi.py
@@ -0,0 +1,77 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the Phytium Pi machine
+#
+# Copyright (c) 2026 Process Mission
+#
+# Author:
+#   Bin Meng <bin.meng@processmission.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest
+from qemu_test import skipBigDataTest, skipIfMissingCommands
+
+
+class PhytiumPiMachine(LinuxKernelTest):
+
+    ASSET_BUILDROOT = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.0.0/aarch64-phytium-pi-v1.0.0.tar.zst'),
+        '5219d52b862e1245b12f79ba72e9a6144f5e0cf1a50061f8fda2db0aeeb92428')
+
+    def _prepare_images(self):
+        self.set_machine('phytium-pi')
+
+        archive_path = self.uncompress(
+            self.ASSET_BUILDROOT,
+            target='aarch64-phytium-pi-v1.0.0.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-smp', '4',
+                         '-m', '4G',
+                         '-display', 'none',
+                         '-nic', 'none',
+                         '-no-reboot')
+
+    @skipIfMissingCommands('zstd')
+    @skipBigDataTest()
+    def test_firmware_boot(self):
+        self._prepare_images()
+        sdcard = self.scratch_file('images', 'sdcard.img')
+
+        self.vm.add_args(
+            '-snapshot',
+            '-drive', f'file={sdcard},format=raw,if=sd,index=0')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2022.01')
+        self.wait_for_console_pattern('PBF relocate done')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('Phytium login:')
+
+    @skipIfMissingCommands('zstd')
+    @skipBigDataTest()
+    def test_linux_boot(self):
+        self._prepare_images()
+        kernel = self.scratch_file('images', 'Image.gz')
+        dtb = self.scratch_file('images', 'phytiumpi_firefly.dtb')
+        initrd = self.scratch_file('images', 'rootfs.cpio.gz')
+
+        self.vm.add_args(
+            '-kernel', kernel,
+            '-dtb', dtb,
+            '-initrd', initrd,
+            '-append', 'console=ttyAMA1,115200 '
+                       'earlycon=pl011,mmio32,0x2800d000 rdinit=/init')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Booting Linux on physical CPU')
+        self.wait_for_console_pattern('Machine model: Phytium Pi Board')
+        self.wait_for_console_pattern('Phytium login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


