Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C326C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxuJ-0008BJ-S9; Tue, 11 Aug 2026 21:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxuH-0008Ab-GG; Tue, 11 Aug 2026 21:37:25 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxuF-0001Yf-No; Tue, 11 Aug 2026 21:37:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtV4g0l7KXSF/EO2vJiReSGAdUrIF0sERn3VVIZx+xwACGB6qiLoLw7w6OhgTdkwuKIQIjZljPrhFH12ViTP/atbrgImV/gfhQsdDVMVNDEg3D70EIIi9jE9n+iw2WTWkyljnmDBCzWhwb5WcqfShd2Dw9set01OMfUTJkzyQbIGK2iLw3LW5uw2eWaJONkAmRVqeYxdjsmKJrv7xD2CIBmAs+Mwm5EzjbcMCVYLoGxHSNyt567/YmaMZ32ojNge8rd/aOT0ddqXivn+YPIHoIqs2A2me8Xka3n012dNk6w6m/zRrVg3dXHsWT2pCsual3GV7r0LJu+04SyctoyCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCkHlWOZAsi6jLicvlBFZLA1OwVmTJQWLh8Nx89+y8k=;
 b=H2REcpzazP6YqpwgVQlGB72o7e3XJNOuuU9V6QbmgF9tR7RiR83qcHVX6fDOTfx0umHy7yiOyAM6qpGdb/GwmGfRv+culpDT1yuq5tj8bQw2pETWCzODgElNUjQVCtIf+c8Xb70kuXmcEPqWkiqs6sw2DVh4JD6P5KZlUH+rG3Pbv4Foz+yJsst+ihhIoF7TLhI6Hri5b/RIgKBjDOUweo4A4s2KkWFAfHwWYZ5/zXMuKoo0Hvi3fIsHMcjtYIOrFYbKCIgP33/uavPA5YzoJJF2C4/F43ZJcpypoM5wgGTj6LFhp/KE62ZpvZVRCUzbf+Qx9uZIWO98LmB7cpaEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCkHlWOZAsi6jLicvlBFZLA1OwVmTJQWLh8Nx89+y8k=;
 b=pVlM8BN4URdYb0FT04X1UQEX4m7GX70a5H32a9h7tYKXCzqkCbviUz/7HPC5QBQhcPvG7R3pyvqP+0UeW9A/GE4EeAY4vXJwJEUavrouuaxvDxaPjGuVTtzQX4W1x74i/o4uWNGk6mN+jrtb7UzrLFBwy99/xt6zKZ+EFS+6/n+hsA02CykPG50j8ez+vEUqynQljBQysU4BRSwmrfiVnMsCTHXmbJYfQW1HlknrBJxLazD9A8SeLzh/wt9x1a9SYTqm+wqYHmC8ArS5moPmWUOtoSFMtYsOyNyGMjLhbgwopRYbcHumtNWVQaXtewTeJj4Y4CTpI4d632LcMI7xTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:37:21 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:37:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 10/10] tests/functional/arm: Add MCIMX6UL-EVK boot tests
Date: Wed, 12 Aug 2026 09:36:13 +0800
Message-ID: <20260812013619.2134092-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: e1994f86-dcbc-403f-7128-08def81240c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3r8G5tf7eUGmn59JvspZOw6YtGZC6bXE8nfZuilEKOCx07kqIXzwrwaBn6K7W3H0+S99k4TXmAXF4OgDHg861Qzv8uNBYN8EQoEO6vUeRWHIqRGHJ9+lpOTuIrBSBYAGMHlWA64txCNmS8IuO0ZG5SJr0ZajfmV92g0wTyBC7/pIzUBnXzlWVu3LPxta0cBhrWx0rKQ1VOdRpgKYBw3P9m2s+qdaicvrc0Gvh85jbLc1xhe/6i5ZmhvpcMIbffL3pQn0MbxRhNnxaN6GWs3h7lgNZTMvDjFAGgHS7FuVZrpbkqBpzvFEf/NuX/TH1EaC+XVsg0XU8fjo0TOYCfwJR8CcBkAS2bdgI3DNs3C4iFGfGgkPpKZZiPvt2MhmEdp5Ka5QMr/7dhRDNfP4zK7KEA8PO23RGOaW6fHmooy2e7nP8wGx/6qmfD69vVlGZAe8o3PYyULzU57RTsLzZ3uWSKoe0+8ltM3WFuWqFl/Whw0nGX/VqyrHj2pRMWTfkF+OJhR8O+Y0sxyR//LsFjSbVXXE6Y0Jma8Pd5IQ1PImClzRPhNF9XW9riRS7ZJtT7SMsndB0a8yeFryxvMUJLeHfPpLJ2CZW0zupPZmuz+6VIgJlGg29+MGt9rHGutcpMw6k3OytZEBDCEiEVwfOz46waTPOW5UCwk+cTxeIFYobA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIKwHHp1PHW2RSVZrvE6wS6Q4QIHiCYfVmQSGF6LZgXq3eXug0iN56DSgyhA?=
 =?us-ascii?Q?IP1YhhPmunq3gk4tp/2Ur8ZFhcgV1FKj0tstcn1nTrPJbzXP0Ywu1E0Vw8pT?=
 =?us-ascii?Q?jpnWeLdc68mTSdVwLP0oGZUydhh4FSAZ+miojpEz5XcxscD6NIDWwEPHm1ID?=
 =?us-ascii?Q?7/nOECz/GQxuH6TygHzHQF9sRQVTyVHkQQchC0U80o1K1DZZnaVb/BBF4lDL?=
 =?us-ascii?Q?69GZXa47vztmHl+IRJhSfG+z1b+A8ZBgPqyN9WJQ6KlfcL/VgQmQP3EEmkHU?=
 =?us-ascii?Q?71zfE63y+oB4VAzleuptdHYfphYWKwYAsTERsM/o4vLQqRwOamMM4LpleRT8?=
 =?us-ascii?Q?LmFZy+ziuMvF9hq0aW0pYOwJhrSnaW+nVGAUd2Lit8mnSIxHgzFo7EgcT+Qz?=
 =?us-ascii?Q?B4FLnGsc8ep2TGGEK3jCd1j0viWKbEp6dQUK1swb/Wz25qW5J8NeqjKzBwZY?=
 =?us-ascii?Q?cN+9hegZQ2pj08uAMVu16gaEEhbMml44x5mOV/L8JC2smyO+wsTa+As05Zzt?=
 =?us-ascii?Q?r2GaGvjuF5AjnstwOku38aj7sdNoX4oW8P4bnnKltV/l1BUIit+YHwUNUIUY?=
 =?us-ascii?Q?QppDnv+cZdLLDO0iACqJdqg+qO9hey6L/KbHOdD6YSFRoDpDkwlv4WCqDgNc?=
 =?us-ascii?Q?mTHZCA/m5HMwo7Jcz0Kvq0EHNFpvkkjzEEbXFdNKYaEGEytXroCte8/7YE50?=
 =?us-ascii?Q?V7qXQtDO7wanAidCs1YUetyw/FC2DnTms70lKo9G8GkXj1tQebVEERgWaVTw?=
 =?us-ascii?Q?9C2VVZa+GmeHK4mSXY0hEcbnaGDgzFicVLK/bl5FYd8TG9tllNsYGBz0wCcS?=
 =?us-ascii?Q?+wPQ3i/w/vkIfX15/bgwial3TYvaQV/EwlOyrnGMWZx6RM6QegoTPlCK+HZI?=
 =?us-ascii?Q?A5B2szPRLktPMmk/tMrKUusrrVEgb6Tgmve6GubfOJI/hviX8dsZtAqsGmNB?=
 =?us-ascii?Q?pY2Jg+nwBYLhm31VUgqeiB6Iu/YV2HzNxnhNikvZXG415tAtR5H+XWp99EwZ?=
 =?us-ascii?Q?lLhjJIq18rBGM88khgZbfNr1Gue/ywVyAuJ0t4385bCyna2uOp7hQx2+/9sJ?=
 =?us-ascii?Q?8SrwyuKYuOjPxp2k1ri6uS1pn7zriSZJd/hx+7gj09AyehfUPQ1tcaUKn2Pl?=
 =?us-ascii?Q?6SnYTMpzmqH+jQOaCuZgi4v2O/Zk5q9B0NIUq+zydxqi7CSR5mzSKGE3SOnY?=
 =?us-ascii?Q?pNCBFdFtPxW2V7B8YDK43v3odNcFY/ux157Y/LewNf4uCRenB7TPc1hhcsUl?=
 =?us-ascii?Q?rhc6wKbQUOxhR+F9hKeyWckES8hGj9UeNDtL6p9yo8k9m1OJd8G3ALo+tqoT?=
 =?us-ascii?Q?PwxIuEPaYCvoF5l0/CeSMJRVeb3GVve0RfMybLNdIbJu8QUJcHuLUzHVfYsL?=
 =?us-ascii?Q?twkG6Ojqz2oiR2NbdoFzUvAoMgyPuSQiJdDNp8mioDffueKKaM87SLSK/3GQ?=
 =?us-ascii?Q?dD9b3TXgNJAP/YXNZBOrXs2oFBD2THHMQxchj/z/5lydfXDfaVH7a01sL35C?=
 =?us-ascii?Q?YqcAooWQGX5pv/8y7E1iD5DXo1LeHLPPWRW5T+TWrgWe4c6ON4zqa1i3jXYG?=
 =?us-ascii?Q?JyI2OvLDWrH7fJDgelNi8jG8DgY15JtxKBy5N8u4sJXGxYmdtHz7pElT+JkA?=
 =?us-ascii?Q?e9jQ2YoCs827YWX28rOQrMrdBJUxhtpQVqcdTRUsCbysEFRNgJrYXbGnaelj?=
 =?us-ascii?Q?wCUfeERe+IC+ABl+h6D9Rvk+7Lj2MxdUgY7WbpzZWWgVGQlLgTO3+kSQgZti?=
 =?us-ascii?Q?BvkBTsKO23CM5iUo+WNm5mDbKW701Uw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1994f86-dcbc-403f-7128-08def81240c3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:37:21.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiASD0T+0AEVwtmDQdqmXLLuQ0NPf301GgXWYJPbkNpayPy990TF0E4HA1rWaVfcNuega6ElDYT1ZlYR2xp+Kimnjcly0rbEdsRvFxZ+KtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7871
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The MCIMX6UL-EVK machine supports loading U-Boot proper with the
generic loader and booting Linux directly, but neither path has
functional coverage.

Add a versioned Buildroot asset containing U-Boot, a Linux kernel,
the board DTB, and a 128 MiB SD card image. Exercise both boot paths
and verify that they reach the Buildroot login prompt.

Cover the new test in the existing MCIMX6UL EVK MAINTAINERS entry.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 MAINTAINERS                               |  1 +
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 70 +++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 tests/functional/arm/test_mcimx6ul_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4628793dde..45288fb5b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -909,6 +909,7 @@ F: include/hw/arm/fsl-imx6ul.h
 F: include/hw/display/imx6ul_lcdif.h
 F: include/hw/misc/imx6ul_ccm.h
 F: docs/system/arm/mcimx6ul-evk.rst
+F: tests/functional/arm/test_mcimx6ul_evk.py
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..d8b1408b13 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx6ul_evk' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
   'raspi2' : 120,
@@ -59,6 +60,7 @@ tests_arm_system_thorough = [
   'emcraft_sf2',
   'integratorcp',
   'max78000fthr',
+  'mcimx6ul_evk',
   'microbit',
   'orangepi',
   'quanta_gsj',
diff --git a/tests/functional/arm/test_mcimx6ul_evk.py b/tests/functional/arm/test_mcimx6ul_evk.py
new file mode 100644
index 0000000000..687a0e9032
--- /dev/null
+++ b/tests/functional/arm/test_mcimx6ul_evk.py
@@ -0,0 +1,70 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the NXP MCIMX6UL-EVK machine
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
+class MCIMX6ULEVKMachine(LinuxKernelTest):
+
+    ASSET_BUILDROOT = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/download/'
+         'v1.0.0/arm-mcimx6ul-evk-v1.0.0.tar.zst'),
+        'bedda89c848224dfc5108629975bc379ae5f4d8896d681521f2d485a0fb517aa')
+
+    def _prepare_images(self):
+        self.set_machine('mcimx6ul-evk')
+
+        archive_path = self.uncompress(
+            self.ASSET_BUILDROOT,
+            target='arm-mcimx6ul-evk-v1.0.0.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+
+        self.vm.set_console()
+        self.vm.add_args(
+            '-m', '512M',
+            '-drive',
+            'file=' + self.scratch_file('images', 'sdcard.img') +
+            ',if=sd,index=1,format=raw',
+            '-no-reboot')
+
+    @skipIfMissingCommands('zstd')
+    def test_uboot_boot(self):
+        self._prepare_images()
+
+        self.vm.add_args(
+            '-device',
+            'loader,file=' + self.scratch_file('images', 'u-boot.bin') +
+            ',addr=0x87800000,cpu-num=0')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2024.07')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('buildroot login:')
+
+    @skipIfMissingCommands('zstd')
+    def test_linux_boot(self):
+        self._prepare_images()
+
+        self.vm.add_args(
+            '-kernel', self.scratch_file('images', 'zImage'),
+            '-dtb', self.scratch_file('images',
+                                      'imx6ul-14x14-evk.dtb'),
+            '-append',
+            'console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('buildroot login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


