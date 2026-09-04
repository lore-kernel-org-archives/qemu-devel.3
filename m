Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F92C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKM-0006pD-2J; Fri, 04 Sep 2026 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKJ-0006b5-M2; Fri, 04 Sep 2026 11:59:39 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKH-0004Wv-H0; Fri, 04 Sep 2026 11:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG/HEWBjqBQhqIYS9e0HkakvcTjoC0mHNFc8JNccx02/rnhzEYnahu57CQNCEO/lqPzjHK11vsior8ugxTIqFVMG/q1gcQOyTayWbwElRajAn3nzxb2xCtOcNv1e9mdlw48Q40PqZci9hzMNjXVxZUnE3vPJbMzAWi2Xp9RsCwXb5xLk4h/maYqMf69kP4f4wU1j+rx7XXabK1LkKi5dcmj1X2R5oci0T823IpymKa7hkJNIBYnIUEZpflDkVA0NvFkwVEQeCDhsAwor9vdt4+cFxoYTBoI2zikyHFm0ehMNQEaVbQX/cEo4z2YMWdZIwUsZaMHStRvSLopYrksrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TYbwZtCVwJ/rqnadG8uS2qTRWpTwKy0h3gteLBbTjM=;
 b=HJQhU9ItuKz0I4Ns7nlDVgouPwy/nL3QARkF8k8pN4yy9MZyqtyhd7uTaQFmdvZME7tXQ3MaQQDGbzB62yCjYsQCIb1jYknLMV7swE/28zhKLFNhZXRdvYxW+XxVNytr60hwTXf87adIXNBU1jHwLpeCOEwsYnMQSpR0T5+cglKtg5FwvaKoK4qIS2t1oWGK9zGHN5OCOxwY/Q+3zK060nXRF4gEVq2PkBVG+IZPu7/kooYQAHtylxO+NwJ/JeYj3WqDuKJb/0JOMZI4aX+d29YYTT3N3z6YXRpqLBc9o5U+L8TcPE7H9J/pwARtJetDwS1dZfzzgXUpOcQENqtRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TYbwZtCVwJ/rqnadG8uS2qTRWpTwKy0h3gteLBbTjM=;
 b=C3Z7IKxl86OlxxGvlpgsq/FuN+hsBPOidrATxAQmqZkW4eO1BMTp6TvJcMYsHuLO5Sr3b+C+Xnpkz4SPW72+O8JmETM2qEC+LWjqWxrgktPmhDX9Qfp8EKBpAfGHavcGrIWdm9r96GUuhAyyk004Xd1PXTN6/zMmpokvBHw2bLzbPhx3fUlfUAGOs8gkjfG0sGmB9fr6O1D77cofhJtW4uj8SpYGOgJc4osMLdxw8z7s1s0t44O2P5FAdfjuCzAkniB7IOnJUS0gHGzXCsj3kwD3l+Kd6NESsOFtIWg8LZ1PajSy2F4BQxGisAmVQs/F13BLF63rGcIdWTvaKmzvMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:16 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 22/24] tests/functional/riscv64: Add Icicle Kit firmware
 boot test
Date: Fri,  4 Sep 2026 23:57:41 +0800
Message-ID: <20260904155758.3833179-23-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 259c1587-3f89-425f-5786-08df0a9d789c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|6133799003|10067099003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: L+JbuzHhvQe1sw+4cTQXdoPsef8TCoT9vxz377ro/tKMWyV1VAJ9jDGFh9Zcq8UH5WquvFtq+ov6qw8VLP9CBplyZif4NwVeNj6Wkq2v1gk6f5a96v4VS0bkaG7nqS161aec/j3qtFko+pd2mruQ9DP2fDDEqRFzPDaGAg3QqRGBTJHKkFGL6kihyDC/yT23uzIFeWSunj79vd3/NW69qOoBZjAJXROaQu/7AHteX4uXGwFvzpCK2F6EOkkt5xPsOtjS5r8pw669mSPEn/WtIk2QJKzQWbulhiKSjA6QHNsjG6Zx0cvp8mtSa+q5DsHl732MjdFdGZFVPbY0ZbzK+XLJmAi7D3n48jGJtl6lwHgulDOpgJpWnOsLlTn/L2yNsA5pWL92IdBcRbstUIj62WHTPvC2XzObPgTERQmUuQy79/w+v1A1MzuQoWndbSBJBpyDzMzzFhWvkzcoSet3HNq1Eksj/Vce2MeAhhIQJKzJ706qoaFI7E+BQrVo9pXL5F3t8UmkjurbIqrPaq45CzPbBEEizMQu849nyorO9Y0OgNBkq7GVyuQfcZJQVpM0y3yrPAZNPeIJjZCHUdkTs1XVCUeEYSzFwVUgMwytFGhH96kNqB9/vvF9NhNNbXzZEtUwetjoGWZoX5WAYszwn74R17GRQT987aa0McgkhQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wol57RJhFXtqRBuBX9SHe8yZmKmpuU6sbSVNOpms1B0V7CD10Y2iJERP1Vvq?=
 =?us-ascii?Q?XZCUgg8XgnVMB9MjY4Pmrew/3ic5Jmft3HbrvGnEiQWvu8b1BDOO6TNiEDGD?=
 =?us-ascii?Q?Kg0nhiDfhGHEHdXYunFuuW6d3NHzaYlOaXOw9tmMdfixiKu2W0+VLFiH0LYq?=
 =?us-ascii?Q?AhlbQnKB8zu/jV+VUugkdiTnJFqljuHMd75qK+aLV5pANL0109Nzl16AX2me?=
 =?us-ascii?Q?xpWT7xUTZE+f0RYCCbbZGhaIaIPf83H2vzgTBKOkM6ranS0YSk86/7HdwsDN?=
 =?us-ascii?Q?4EIdkK9x2TZbulMSbrWoRz8rBsx7mY/mUy7xN7qO2bgTpdI5esexGr9df2Vl?=
 =?us-ascii?Q?jHpLE5EQUdeSQVvFL4MPWBVlRy+d6GiBwOZfofjdGHjsfK937baPxdQJ10jR?=
 =?us-ascii?Q?9t6mxBcsTkqCOp92RIC4pImGPQFStq/u49PHFb3tGA2T/skefZtKli10imiE?=
 =?us-ascii?Q?3dsFeHuAPMlLvZceJCosJ4U15y8kaUhiZf3BqCf+aLky7da6rXLFAplgTeGR?=
 =?us-ascii?Q?fzj11uYKUSnhRrut1bhYyAnK45ILYYNzGZOfDizyxWTb1R9QBRUTH2V8kCeG?=
 =?us-ascii?Q?3yAyB50t9kAs7P5ZzffRdWaWc0AFBxNa5k9frNMYI3m5lbutc7fl0d4+aZrK?=
 =?us-ascii?Q?u3oAqQ483oRL9+zRGDwBnEp+cRCv//leMDRTCNKnoew6TXj4PdF+TxcHdMdT?=
 =?us-ascii?Q?HLEh3azNbNRI/oYIBLIi4nTr5hR7/MSwb7TuQiDnuc6lvYdNmZ49DSk3Nvmb?=
 =?us-ascii?Q?WX1a6xe+mzSYx55mYpxsroCxwSLwUrNhN14nmLBlFrQJmoretCpbQpRrk7OE?=
 =?us-ascii?Q?2NX91Q47X00lM4ZBudzPl/haeQDX4bg0j+e1yN7BYEXTdmtZEZ/S5Ja0ocXe?=
 =?us-ascii?Q?ysh54B7r04rxknff/L3gD+p4HgWRVbICNyTmy/sY0eb3QjVJfxAtHNFPLBhu?=
 =?us-ascii?Q?5oKZB33fz9+xG3nN/TsJCenZ7Oir+SDKmJYSm6cP1uhTHSeY76LvnQ1A4Czi?=
 =?us-ascii?Q?hx35QwCxUfnREjL8u3kYgmHV6pmQMiktXh4r9lSONWDeQ8zY0V88PjTUhPII?=
 =?us-ascii?Q?uf957qD1U3ARjm3SZFjEuoDbGvvhPjnHaoyhO7yO7nwXQ2wTBgMg7lLONfkc?=
 =?us-ascii?Q?HISMwrmyUwe+4f7SyufjT53re9UnoCco8zEo48K3hmNW098uSCar69btPXbu?=
 =?us-ascii?Q?pz5zPU/1cpwuQBlk9ROZsI1vdUlxy8zikoFUA9aia4G/SnV7qyU4DzMasJn8?=
 =?us-ascii?Q?c54/PDyjuW5/bVcSrW4RP2Zq9Sj3lcqpaj9BaZQ/W9FuUpI6Ba8I/fDqYNLD?=
 =?us-ascii?Q?l0f/2hi/QDnP2Vj1+nwgyluWEySjCFIFhJjULfMsfjZ8Lt9g2KuslLw8eKe1?=
 =?us-ascii?Q?jxtyZKlKlB56Zydk+J+d3jTbumSyyBKn6Z7XHU38Go2XDdUORIZ8AK5AJ10P?=
 =?us-ascii?Q?QVa4yGJ2Mg39SrPO1/hIfgZagVy2iT9koSG/it71h8U1xN3gbHBpmbdw8hNA?=
 =?us-ascii?Q?ZeT4K79QmGV5NS1dABVRbEdcsQjUxWS6993IwVcnt8JltVZKEjpsZgcGDQwk?=
 =?us-ascii?Q?goz0FUol6VXJG9iGEy5GcqlXSkb887jlvl+oICPISGF70xZoWwC2VsAgd4oz?=
 =?us-ascii?Q?vnQaZBDEhh0Gb2xIoRjXyIceJNb5reGqdFkbX9OOSlWLbaeSj+663dy6Zfu9?=
 =?us-ascii?Q?BKyJUVJcvbOUU+C5l4GfVh7hDejX6N5igBZScAZNoGWWYbRMx3XCw94m+XYg?=
 =?us-ascii?Q?sskXY+9ZAByW2gU7btf58SRG1X8yORg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259c1587-3f89-425f-5786-08df0a9d789c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:16.0936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgb/CIUO2+X8C+eskDc1Rlsb8yNuWuFSGFsn1nwp+yYUX2sfkoD2rz2ns6HTeLzTEBS0dmc0KZeJsnR3IBtN3H4BL7C0Kqp9XWY0sSc+u8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add functional coverage using prebuilt HSS and SD card images.

Boot HSS and U-Boot with five harts and 2 GiB of RAM. Connect
the test console to MMUART1 and let U-Boot start Linux.

The complete boot exercises the SDHCI controller in the DMA modes
used at each stage. HSS uses Version 4 64-bit SDMA to load U-Boot.
U-Boot uses ADMA2-64 to read the boot script and the large FIT
image. Linux then selects 64-bit ADMA for SD card and rootfs I/O.

Check the machine identity, kernel ADMA initialization, root
filesystem mount, and login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 MAINTAINERS                                   |  1 +
 tests/functional/riscv64/meson.build          |  2 +
 .../riscv64/test_microchip_icicle_kit.py      | 56 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1856c67feb..319b436480 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1805,6 +1805,7 @@ F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
+F: tests/functional/riscv64/test_microchip_icicle_kit.py
 F: tests/qtest/mchp_pfsoc_l2cc_test.c
 F: tests/qtest/mchp_pfsoc_rtc_test.c
 
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index d1a3e6c2bf..cbf61d9535 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -3,6 +3,7 @@
 test_riscv64_timeouts = {
   'boston' : 120,
   'k230' : 120,
+  'microchip_icicle_kit' : 180,
   'tuxrun' : 120,
 }
 
@@ -15,6 +16,7 @@ tests_riscv64_system_thorough = [
   'endianness',
   'boston',
   'k230',
+  'microchip_icicle_kit',
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_microchip_icicle_kit.py b/tests/functional/riscv64/test_microchip_icicle_kit.py
new file mode 100644
index 0000000000..559ae1f651
--- /dev/null
+++ b/tests/functional/riscv64/test_microchip_icicle_kit.py
@@ -0,0 +1,56 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots HSS, U-Boot, and Linux on an Icicle Kit.
+#
+# Copyright (c) 2026 Process Mission
+#
+# Author:
+#   Bin Meng <bin.meng@processmission.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest, skipIfMissingCommands
+
+
+class MicrochipIcicleKitMachine(LinuxKernelTest):
+
+    ASSET_IMAGES = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.0.0/'
+         'riscv64-microchip-icicle-kit-v1.0.0.tar.zst'),
+        'fe7eb3ee737fd15d6d5a8480822b070923ae4d611b19ed03983e11f35b6aac04')
+
+    @skipIfMissingCommands('zstd')
+    def test_microchip_icicle_kit_boot(self):
+        self.set_machine('microchip-icicle-kit')
+
+        archive_path = self.uncompress(
+            self.ASSET_IMAGES,
+            target='microchip_icicle_kit_images.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+        firmware_path = self.scratch_file('images', 'hss.bin')
+        sdcard_path = self.scratch_file('images', 'sdcard.img')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args(
+            '-smp', '5',
+            '-m', '2G',
+            '-display', 'none',
+            '-bios', firmware_path,
+            '-snapshot',
+            '-drive', f'file={sdcard_path},format=raw,if=sd,index=0',
+            '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot ')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern(
+            'Machine model: Microchip PolarFire-SoC Icicle Kit')
+        self.wait_for_console_pattern('using ADMA 64-bit')
+        self.wait_for_console_pattern('VFS: Mounted root')
+        self.wait_for_console_pattern('mpfs_icicle login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


