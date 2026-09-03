Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A63C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aB-0005W6-EE; Thu, 03 Sep 2026 07:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aA-0005VS-Ck; Thu, 03 Sep 2026 07:26:14 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a8-0006gK-K4; Thu, 03 Sep 2026 07:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMOhYb6A1HYT8RF0aS3gDh86rOxWcBCDIz3ZhN5KPFqXfhd2x1XjYp0XEufQe5adcaSPpQqpuhHJGF9bdh8ihAgIwl/fWQ9XeKMEoaXaqpwOWzzM0M5wfTaACtA9Cw2HI0uObRb59tlRoe9xU0ZMymvSPeM3xm9lAKJAKBIBNKw9XXSraqUF4gmz/NpzV9ZrcITeMlQNV3ZwMBxZlVBHgSTZOipaUkVI16piqi9KKZiw1O0Ejzk1Ohj0EYiHOz3udzkvEE9BXbbk5XEAnsT5tA1wgxsU4KI7lLYKFefFpIgAnsXEIKNb5rJkQm3PJD7ikt3iI0G4S5vHMdl+5XDrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trH1bEPf7Ar2UjDMwSViLFlOWdW+dkJyF+6cHG1jzNo=;
 b=ETRTwG5NUo0pMCPboLILxBQRx20QaGpivpoFYJwMTwGDHVURS9W9CC90hEV5JrX02C24dhtZHpNhm9akVq1nXyeFnT7M38MyGKdtBCEnR2KtyMKoFnzKDVJe95kNeZ9pkaGmf7LZ2FuPQ3B+ZY32fdwbEC9bpMjQmimieohSOWDTZt39QWy/dzuMfdLB8MszHJfwPJqHAlkDnf0+goYgVWghoy1q0XI3fBXEwAxgYeG/iHflXx/OfSgs35ENwFeqyuD5DVzGeA5thV1RrUPieleyif4NKr4D1BrFbfBFykSaa0SJjV/bb1BE6gmnv3HRQ9DYe/Sgq8VdHQJqD/izIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trH1bEPf7Ar2UjDMwSViLFlOWdW+dkJyF+6cHG1jzNo=;
 b=lA4x0xR0InLjWQCvu3kyjLEjhYbn0NdeR5jWfRNVsX72qsyOh8Df3+JlMHK358wh2GnKeiTmyVza+eWhQlHApcC6E6wY41evLYkGXBU0b9KooeF4mMTM776Cii3en0TlVG5+VBVMt1/04zjO8nt8s3K29MOpdIWh3nDwoyo82JeFO+8854HfVnRri2hKKZ3cCH2zAy6rjmrGiNWK2WFHer2TvSOGUWOOVKestoRplCFi9Pp+1GpQ17Z+SLULCQ705qFfRuuIiYU27LjXTMWv/Te8vQGjoq6fB6fU6hJNezvaiV9SzattPQcT8dhUKGJikOB7zYcpbviyc+nCusT0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:01 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 05/33] hw/sd: Add Phytium E2000 MCI controller
Date: Thu,  3 Sep 2026 19:24:45 +0800
Message-ID: <20260903112532.3276678-6-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3f05b9-7b8a-4b09-815d-08df09ae223b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: USr/MXcNS4RSmv2nrT/aW/8tnUZihRg44jB749ZTdRJXOHJ/Jrq4MELoN39ALf1O6mhMzwaTCVswIxfo/8Hm0KQLePQSDJn9vGeMeRMOlMtETE6mALkFh8JlkmNbPvFVv/tubhcucEm3g72WV74ocgJcxKxgmIr3BFMMdhgov1xa2o/rqIEIDF4wqyz52t71zCiL+VQpeMeK7J6J8v0a7aY9ajlLPLIhHRtIzFNuAgInvHkTTmfss2uOYRzUcp3ZtzsDkocxyLi8Vk/hqnXb0j+Yn33bkWxQub8n2vgclLFyf3hrOjjWNmidNpBhIQLleXZWyi9vLmiCr2S58O8pcoSZWAkh0IDlZZvt21VvAV9K7DQ2n1WvIae7vTgbrmlArNS7uIfYXcLAG9Tzy+C5HRpm1er/vgv5m8LQ/DS5vFbhZSo9nF2iI2E3ZrYCEBeJgf6zoljAgRm9bV31894Ug3YxMnYcv6NmikxINAxYT0TzRakfz+cr59/JYuBG5d1ZUl4CLB7xs8xC6IEB5USxxeJ09QQf1nuFICDSvsNyrADVhXbXovPli70PmR1F95dgBTkWrh4KhdoxJr3ODRcckOJzGY/7FlxJeDTuo3pZIpmoYPS0glc1oeHlo8BBLlYLaRVP8E0NN0kxiSV7qhZkehsnEaBVS7TVvV3PeckUEKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9Pv4/TC4EXzmD8MT7NqSo/xxhzbRM3DdbFPa6b7GsvLkJnnZlV7tJ26shJ0?=
 =?us-ascii?Q?LOWt1N/wTGOHIS8YmEyjDVEfyl3JtG6afIjEOXwd8fRQX1c7J0mmPcI+wQGt?=
 =?us-ascii?Q?5iF4jVZQ/TNvM3Yy6icKZBkK01rf/Z+f5t6M7GhGMzKFMbW4KfmIZjYAeg12?=
 =?us-ascii?Q?LL4ZxIbDpwIh/0vDCYF6OfJxL8m3e+oMbRfm8A72uUeaFhB4F8Zn8xYl8Dco?=
 =?us-ascii?Q?jfRLvfbav2OoxsUl3ugZGM46Lx2v9QPzZvOo+TUAF5ZG+U8lD3rlz3qYJCUx?=
 =?us-ascii?Q?UqWamBkXs4vFoE4jx3xSUmsIYtEc0TcXul1PE0QWvho34GFx/zsTh631i0/U?=
 =?us-ascii?Q?TYtcMc6SRTgAQWOxeuKmtzrbeKvKZXH0qX4aW4RHdcbyoMOj4BHHEiQkl9vf?=
 =?us-ascii?Q?4Q9B2lZDH36gV98w++PSFG0pKKIDEyrBJKnnFIVKzy+IOqmtgVYvJzzixnQG?=
 =?us-ascii?Q?qZF0mTizolDYIAVDhV8YN8RPcH/cja4l0H4fwxFpb/jTEyTOPn61cTFRfbcZ?=
 =?us-ascii?Q?LzX3O7wNFbB7McLgJf5IlDIsA1XMahnrqHw1sa76PxZncvD7aoia7L0PmwCK?=
 =?us-ascii?Q?RZRmH3tCCixBGbgGhY6fLxRoVzLB4Syoz9aeZndZJ2LBjDIMjh2fPc24YB4c?=
 =?us-ascii?Q?P0z8woRsNzz4aVkxN+xCbOF0WY18zFgbeIwQEFBKxb/hqMTfbB8XuVo7hwkI?=
 =?us-ascii?Q?LoXlbA1vIYjhWsV1txd6lnXfD121ZctajV5qEv1Dk2GRyLyZ+g2VDYY7Bv6k?=
 =?us-ascii?Q?UiCIaLoksJFtLQOVIW3E3uFkbU3vC4kPFIzml2YvKyq3JUJnXm9rTBo1I93x?=
 =?us-ascii?Q?sSWbVCIcZayhcwIbc0WHRug9K9XyAIAOzd7dyXccM8nD34pkZFmkKX8sXVaF?=
 =?us-ascii?Q?jknKgj3FlKWLd5vP5lYqEip5gxjVUV08gtlBO6e/78BXAhfqJPGRtoFIkAiU?=
 =?us-ascii?Q?duKAorQfHG8tS/K+gQRtI5eBDrZoP1zZVI+hx7vnPtVXXhyDm9O4+sRyZOCV?=
 =?us-ascii?Q?0EGGDuMW4WqmEVCchVhAst1kKBKjBiasPxSLO8XTxkEYexq/4sh/JnY1DzHF?=
 =?us-ascii?Q?mPGRf6oeNEArAkpCYVymF2Sbn9P4LKJYR2JvT7CnOU1xNk11pavRNJrXm083?=
 =?us-ascii?Q?H9gBh8/xZplHb3iZF4JNxXbPIhG/asuihZxKOSok78UHDHGRbAxIVRboEjxN?=
 =?us-ascii?Q?ymxW3kM4hffq8i2teYpIubu2VlxNhHvOqvpUPAZ2s6MZBmjR3XStTExUkkGP?=
 =?us-ascii?Q?KdD3LvITpwyOZZSWYFC0yrypj0FDcG3IlzmtBUDdxZX0mNBRMaYiTxXoIrSG?=
 =?us-ascii?Q?UXncvN6gOb7ZVudukqcuqUN+gQ/2OEeYxrObSSsQ6uZsMlg9CseTP2LemCfD?=
 =?us-ascii?Q?M1nT7gaY7lt2HOM8vuBA4n9C5XRoOaz1zLE0BXl7j/O9zTQcU7cqFN+an0B+?=
 =?us-ascii?Q?8MxKy7+f9mNeyDH5VxEw9tkNEAUeEfvAjXPKnHjJ6GiFc59gLQB76Rv2DA+f?=
 =?us-ascii?Q?j3JplCpsF/Zgml5e8q29sRMcHVYym96s78KLalXKRJR4d3cXN0mBzsjB97CU?=
 =?us-ascii?Q?CwTRTtwBdV+dNI7ShVKp1v0uTv1dLcpfy5DdkzjMNP4p72AVaYgCos46QwmV?=
 =?us-ascii?Q?Tku/p7OnvOqR6Jli5MgNlVJPYEsDlfcci+kHVthjIRSEL/eW4Pa3i4ONViVU?=
 =?us-ascii?Q?q1z/fEUyx+4PvBxgf0DHJI3ICrc3DHErQMNwTzKTglWF9Cmiv6CVT+zUq40d?=
 =?us-ascii?Q?35idVtMjI6oqdNgg2kFYT22xDsnqERw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3f05b9-7b8a-4b09-815d-08df09ae223b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:01.4542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x6I1dP3RTBRG1b0iKu0S5XP7goXyLpZdWcJluJ3Fr3K+LhfECJO35SZtjmup+n9hg7jtXhc2j2IEoNA1GjOPBe7gdYkNu65G0tUNyQGg0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
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

Model the E2000 SD/MMC controller as a subclass of the reusable
DesignWare MCI implementation. Supply the E2000 hardware configuration,
FIFO depth, data window, clock-ready behavior, and vendor divider
register while inheriting the standard command and DMA paths.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig                    |  1 +
 hw/sd/meson.build                 |  1 +
 hw/sd/phytium_e2000_mci.c         | 95 +++++++++++++++++++++++++++++++
 include/hw/sd/phytium_e2000_mci.h | 21 +++++++
 4 files changed, 118 insertions(+)
 create mode 100644 hw/sd/phytium_e2000_mci.c
 create mode 100644 include/hw/sd/phytium_e2000_mci.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e68f137a66..99a5799b22 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -132,6 +132,7 @@ config PHYTIUM_E2000
     depends on TCG && AARCH64
     imply PCI_DEVICES
     select ARM_GIC
+    select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PL011
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index d7b97cdca4..5792d0c923 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
 system_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
 
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mci.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
diff --git a/hw/sd/phytium_e2000_mci.c b/hw/sd/phytium_e2000_mci.c
new file mode 100644
index 0000000000..84cfc213de
--- /dev/null
+++ b/hw/sd/phytium_e2000_mci.c
@@ -0,0 +1,95 @@
+/*
+ * Phytium E2000 extension to the Synopsys DesignWare MCI
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/phytium_e2000_mci.h"
+
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+
+#define PHYTIUM_E2000_MCI_CCLK_RDY       0x058
+#define PHYTIUM_E2000_MCI_CLK_DIVIDER    0x114
+#define PHYTIUM_E2000_MCI_VERID          0x280a
+#define PHYTIUM_E2000_MCI_HCON           (BIT(27) | BIT(7))
+#define PHYTIUM_E2000_MCI_DATA_OFFSET    0x200
+#define PHYTIUM_E2000_MCI_FIFO_DEPTH     512
+
+struct PhytiumE2000MciState {
+    DwMciState parent_obj;
+};
+
+/*
+ * The vendor driver polls CCLK_RDY after programming its private divider.
+ * QEMU has no controller clock tree, so completion is immediate while the
+ * divider remains ordinary storage for firmware readback.
+ */
+static bool phytium_e2000_mci_read(DwMciState *s, hwaddr offset,
+                                   uint64_t *value, unsigned size)
+{
+    if (size != sizeof(uint32_t)) {
+        return false;
+    }
+
+    switch (offset) {
+    case PHYTIUM_E2000_MCI_CCLK_RDY:
+        *value = 1;
+        return true;
+    case PHYTIUM_E2000_MCI_CLK_DIVIDER:
+        *value = s->regs[offset / sizeof(uint32_t)];
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool phytium_e2000_mci_write(DwMciState *s, hwaddr offset,
+                                    uint64_t value, unsigned size)
+{
+    if (size != sizeof(uint32_t)) {
+        return false;
+    }
+
+    switch (offset) {
+    case PHYTIUM_E2000_MCI_CCLK_RDY:
+        return true;
+    case PHYTIUM_E2000_MCI_CLK_DIVIDER:
+        s->regs[offset / sizeof(uint32_t)] = value;
+        return true;
+    default:
+        return false;
+    }
+}
+
+static void phytium_e2000_mci_class_init(ObjectClass *klass, const void *data)
+{
+    DwMciClass *dmc = DW_MCI_CLASS(klass);
+
+    dmc->verid = PHYTIUM_E2000_MCI_VERID;
+    dmc->hcon = PHYTIUM_E2000_MCI_HCON;
+    dmc->data_offset = PHYTIUM_E2000_MCI_DATA_OFFSET;
+    dmc->fifo_depth = PHYTIUM_E2000_MCI_FIFO_DEPTH;
+    dmc->vendor_read = phytium_e2000_mci_read;
+    dmc->vendor_write = phytium_e2000_mci_write;
+}
+
+static const TypeInfo phytium_e2000_mci_info = {
+    .name = TYPE_PHYTIUM_E2000_MCI,
+    .parent = TYPE_DW_MCI,
+    .instance_size = sizeof(PhytiumE2000MciState),
+    .class_init = phytium_e2000_mci_class_init,
+};
+
+static void phytium_e2000_mci_register_types(void)
+{
+    type_register_static(&phytium_e2000_mci_info);
+}
+
+type_init(phytium_e2000_mci_register_types)
diff --git a/include/hw/sd/phytium_e2000_mci.h b/include/hw/sd/phytium_e2000_mci.h
new file mode 100644
index 0000000000..cc6fce06d0
--- /dev/null
+++ b/include/hw/sd/phytium_e2000_mci.h
@@ -0,0 +1,21 @@
+/*
+ * Phytium E2000 SD/MMC controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SD_PHYTIUM_E2000_MCI_H
+#define HW_SD_PHYTIUM_E2000_MCI_H
+
+#include "hw/sd/dw_mci.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_MCI "phytium-e2000-mci"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000MciState, PHYTIUM_E2000_MCI)
+
+#endif
-- 
2.53.0


