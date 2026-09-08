Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D46FC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI1-0008QA-Ji; Tue, 08 Sep 2026 06:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHz-0008I0-6k; Tue, 08 Sep 2026 06:42:55 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHt-0006bO-V7; Tue, 08 Sep 2026 06:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/20MEBRI+HSNv+rSvb7jBbcvihM9uSiDaKp/sHajYnqT759J/4HJAYwIeuoYvtSFXcBmmbc/AISUF9BdvYJNfeqvYuf9+rYNEqcvU1LV/pDpPyWHTF+g3nVWIt9BUYGGFQcE6cIRfQbRqWGG5CBh3uSwXipsZvVdLvoRNyHY1DIuapOP7qRlbxhH56etEyFnPfITDyX0LA7BFNee5L4cJ9c4WT2VfPcRzqrlhoIGtjECkpaLaVxqzj+w8LufZhLYYxcju+kFTBCj1Kl2F5ITllqDhLq7WxQHPQnypYtE3o1+qR5d2X5LSTCDyoVLvTFtsRKClnlzmR2I6LvDDRysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj8wqFaXiFBELak56jKNTwo+xW7G7j92x2Ga1KS56hg=;
 b=Q4D4eY3A7+zV5aebOVMfhaGz5z18KDblzZ8JrqDnaj0yAP9pH2MFVO3Sd/PwQr/O96EMhxXWXbNkcnAR0xe4ZzDYpYq3EtErgHPsDdpguBami4IHyavbqNa5mn1EA2XdwIolanKtIdpjv3EPuADMwCSwOABgFEpjTRhr6CvzBr6MSgkkvX0ldI3M/zZIDdlUMfXvhvMFY0J0Hq+YewHugPZbXyJyAEOuHFuoDvpLXP3N9ZgYIpoWv8qF4ri6jSqborMLYPdEsppNJVdeVrOJQVJqFWTyTRgimeMoLQvVEDRRH8huTL8NSsMSH64PpF5FpT8CpbmSIKx1/oTOUIKuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj8wqFaXiFBELak56jKNTwo+xW7G7j92x2Ga1KS56hg=;
 b=TWWf9LZEmwUNigREUz9Y+UsDo/NAB0SZn4m5Z6uz4Ngg2PyLbH+INm0oaDpPZRyLbPaiYdkt3Etm7EWXXcus4ycfp9zBeGa5AoI8+LW75gGNWpmSVy4KVDQ2bw8yN5Zj8l2+cPAOoBWzVoL8AcjZDG0YPXHY7XXzc4WLbPvbokiqdZudCGxvd6xzjKDSq4WQRqRJ7NUDYQ9efIKHhxIJYjXAVi5CDn7/ZRTBOxxTnlBdWv/7VdlPf6UTrQoDnwIC1ooFJr1xRbKIbYCfSb04LMywpfI7Vfn0jkcyxYq+SlqQR+85TgGjzb0ZW0hNmL3mBNOLEPlrileWvFD/vbwgEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:41 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:41 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 14/32] hw/misc: Add Phytium E2000 PBR model
Date: Tue,  8 Sep 2026 18:41:23 +0800
Message-ID: <20260908104159.1621764-15-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0c6e4e-78d2-4a7d-60a5-08df0d95e7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 45apQp+9BVs/WnwltxgDmSeBz7f6qN6qRmSX6KPHPVBHt6Bf1e5oNCTUIYPcMiZMsYVZJCHEILhtWf4pejNGtUWGQJkAH4S8VNnHHYpQEHpVSI1bKr1Vgx8cX2rSon0ug7IjWbxxVx3igdTthtBjBW/Vst69Af2jiPRiYGWhvWg5iDVBWOFR7xpXeNUZKfaNqaa42rfqgOsd/SYDcMxVEWV66gqc7XH0BNVMzCO1aQvsjFGzoMaDGnBzmGqlaLOlNe9N6z80zZLE4XdoC6hw/86b4MLeXypTHFlsKZHAS/DIPCN7RXAGrTRWU6lZNQP+t9se+I++H6Eq7GRsLplO8BcU0KRFfAPwkjk3OOBgn2OkdWUleJtriVhlvoU2eLPlsad+yR78xm4jxTyDrFOmeuaMwBtWzULSpXPAL+0eHox9/1kNqUigD8XpqSvgtAIWTjCYuKR86Ml927MmJxDgDx+hVU/R3tXFlTiuSr4i4XdsEgKak80G0eXbrBsEZTyOrqfYqlv9QKvl3/75PFGB+6GmRoIAHLVDIMvs9nKWAUg4yG6BrXVBnthxpBySz97khFm0eo35exCkmdTVq+58KuMtYru9jIwOKZyjQc1g9s75aPgGPDgBxE1zGQvMfu83cvsUFRs+xKuWd/vfNMgfYMkE3qeIPPdIgmOvPjlqq24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeJjcDlx+E58Yw39HFMrJJYrlQSMvatdAgJg/GEHhM15wwoAR6DVVaHJO2q7?=
 =?us-ascii?Q?3owD60ieDDNTjQSodDHgdPL4lMCmIRrSA/F6OPC4ah/EYGqUdYuvfxC32DUS?=
 =?us-ascii?Q?HDYiW0rI8JuNCo0TdaMUWCu4stmdLq8vbHjKx/sPnh3eHpnJc6KBUPZqPY7E?=
 =?us-ascii?Q?lLpigZlgvs5ipmmeTJXU4yOhzO59cRGHsgRFiL0P+t8U9wUfazDEvTlMcdra?=
 =?us-ascii?Q?bNdF/YGax5ECP63DLVzobPmp8EirzPJU8kwIQtcGSw8tUsQM6N0kJ8n4ENmr?=
 =?us-ascii?Q?CD9zERBR45ER0MHbnd3ImqHlbAWfpz7dGUZbERSrhUech3AJIvkEBX/xW9GB?=
 =?us-ascii?Q?mO6u/v+ShOO67xu5LmS9lQUhw6yVB/UjQYqsuDSWcwzKru0CWN1caB/ANeQr?=
 =?us-ascii?Q?wqkt3p30VFFSn+OtMvTtGViX286FFxsHF4qO3L0dt/UpxvVe69BNIWwuK/Oz?=
 =?us-ascii?Q?oQU0XiBJsSltMjrCXNpKgByqb1MUt6UZYgegtlJZT6J0/de8KZzov1UnsaaF?=
 =?us-ascii?Q?lEpQK4g48EvJ4C0VwtHbgL2KgzO0J50l80cs7v/JwDoN7Y5PJXMF3z/bGA39?=
 =?us-ascii?Q?y4Ca90rG+Pb6Woti//QAoJKBui7veW8/+ZEDX4f0D5VAMA2szEKqpcKnOMzm?=
 =?us-ascii?Q?rcuQwiqgSYcqKB7FK9aWwLhZTybuo8r/yMQ4pKUzNVX4zcQY82CVITNRRMbZ?=
 =?us-ascii?Q?vvjMDu6pl/IYqUGu1a1fUrYzUDBh4OpxwuPE7cOsA3zP+BfrPhMZOM7vwkTm?=
 =?us-ascii?Q?efEctSYq/A8IfQoco+16uBudFzmxIVVfNHl0Neiu8aEE2Qj3RFAcdrXb0jXA?=
 =?us-ascii?Q?R5D5HukDq3YNcqih8bxKzoLGrN3UHGSjHTrAC9RDluT1LbF0V+P1pGOugbiE?=
 =?us-ascii?Q?vmNhNyPw+V/jvFUdl0iJcLsAvQZp9LeCPoaFnxOm/F/xBbkqee0+nIgfAC2+?=
 =?us-ascii?Q?CIfShA69DixRMIsaWqzC22FKlBYxXEhQ3Ahw0AZP7HUCNfj4JfNvB+Qgtzig?=
 =?us-ascii?Q?xjT/0In514eiSzCKDBtgH9UW+vW2qjyrp9ONT/bcEc08gOqz29S/mPxEdVn/?=
 =?us-ascii?Q?kbZS04TQEBgNs1hh6KLsOuDN3HBtgJR1abqAIWsG3lXWkFztuVZjLiONOTkl?=
 =?us-ascii?Q?v1nGCWVUr/hyHai8MjudDUhjSquG5Js6+nIJ82T91xJPKd5V1OcnofhwlbCf?=
 =?us-ascii?Q?QSzQpF4asG4WpitgwqaIkwzBtzHkQib9gB/8D9GgVNdXkIGVQRAZrwxoECIC?=
 =?us-ascii?Q?kZrd7ryeMzVbL8WRgH0gaEqIG9tkO9S8nC7XuHiX25kUkd0ZLEPc1yT3bXOX?=
 =?us-ascii?Q?WhO68UFEw1WOnBfki7bn55IjDbDTicfpHK35u3CEQUbKRjBqtTFJt7hSLH8e?=
 =?us-ascii?Q?6U71q2aY4rCw1tyrT+pxzKMAJPAxTTVYnLLSUy/Y5D2jMtHQhNWnYvisfIk0?=
 =?us-ascii?Q?yc61wa7p0JFEAq1kOeISnl/NsSx1HEQ6XlleBne2y+OJuzu8mwlaCs4qs2wh?=
 =?us-ascii?Q?0Vx0XShREpoSRwDfLcYXd6mOFj/zj2syPYZlnmrRYJwOXKmIf+6IH7Lwf+wB?=
 =?us-ascii?Q?d3rw6i979voYi6+Wv7ogzM3dZJYJaUmIfbyzQDY6k1lEY7rP4V0xezdFWcH9?=
 =?us-ascii?Q?5V0ZTR9NgTUoE1TUvL1VYsfQVKIGtppIcI5U7K81+XM08yHe7J4mKOcG7hmA?=
 =?us-ascii?Q?hLPCVtTZ6ULsLZzAtXifkvX5gu1ClVZA+nckw0V00GL3sw0OXXZJYnxUw0Zh?=
 =?us-ascii?Q?tb7jrAfP995gSviyT+AVy/1RT0fmnCI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c6e4e-78d2-4a7d-60a5-08df0d95e7ec
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:40.4307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxDolu+yNjJ1ak6ru6iYuf9d75k7YkACE48WmV/Htc5pRQniEzb08TLYPXxELjK6PKw2qZwFwqKos2VouAWMQIvrXXQj8kSTQoQ0KTNDw08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
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

Model the E2000 Phytium Boot ROM as a standalone device. Parse the
selected fip-all.bin medium and validate its PBF, TF-A FIP, and
platform parameter records.

Use the common PBF parameter header to validate exact E2000 PLL, PCIe,
DDR/MCU, and COMMON records, their declared sizes, and slot bounds.
Stage the opaque records without interpreting service-specific
payloads or selecting handoff addresses from their versions.

Locate the embedded TF-A FIP and memmap drivers from their
data-structure relationships. Validate the documented vendor-private
handoff relations instead of maintaining unexplained firmware-version
address tables.

Expose the board strap as a PBR boot-mode property and derive the
firmware-visible boot-media status inside the device. Stage IACC,
relocate BL1, build the firmware handoff state, and release the
primary CPU selected by the firmware. Keep status, boot SRAM, IACC,
reset sequencing, and migration state inside the device so board
code only supplies topology and the selected boot backend.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/misc/phytium_e2000_pbr.h |   55 ++
 hw/misc/phytium_e2000_pbr.c         | 1221 +++++++++++++++++++++++++++
 hw/misc/meson.build                 |    1 +
 3 files changed, 1277 insertions(+)
 create mode 100644 include/hw/misc/phytium_e2000_pbr.h
 create mode 100644 hw/misc/phytium_e2000_pbr.c

diff --git a/include/hw/misc/phytium_e2000_pbr.h b/include/hw/misc/phytium_e2000_pbr.h
new file mode 100644
index 0000000000..890d419254
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_pbr.h
@@ -0,0 +1,55 @@
+/*
+ * Phytium E2000 PBR (Phytium Boot ROM) model
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_PBR_H
+#define HW_MISC_PHYTIUM_E2000_PBR_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_PBR "phytium-e2000-pbr"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000PBRState, PHYTIUM_E2000_PBR)
+
+/*
+ * These are E2000 physical addresses, not locations chosen by a particular
+ * PBF build. Keep them with the PBR device so that the machine memory map and
+ * the firmware parser do not grow independent copies of the same constants.
+ *
+ * The boot SRAM contains the handoff left by the on-chip PBR. IACC is the
+ * vendor-named boot-time execution window into which PBR places fip-all.bin.
+ * The status window is consumed by PBF as a snapshot of PBR-owned state.
+ */
+#define PHYTIUM_E2000_PBR_STATUS_BASE       0x32a11804
+#define PHYTIUM_E2000_PBR_BOOT_SRAM_BASE    0x30c00000
+#define PHYTIUM_E2000_PBR_IACC_BASE         0x38000000
+
+#define PHYTIUM_E2000_PBR_MMIO_SIZE         0x64
+#define PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE    0x00100000
+#define PHYTIUM_E2000_PBR_IACC_SIZE         0x08000000
+#define PHYTIUM_E2000_PBR_MAX_CPUS          4
+
+#define PHYTIUM_E2000_PBR_BOOT_MEDIA_QSPI   0x1
+#define PHYTIUM_E2000_PBR_BOOT_MEDIA_SD0    0x4
+
+#define PHYTIUM_E2000_PBR_BOOT_MODE_QSPI    "qspi"
+#define PHYTIUM_E2000_PBR_BOOT_MODE_SD0     "sd"
+
+void phytium_e2000_pbr_configure(PhytiumE2000PBRState *s,
+                                 BlockBackend *boot_blk,
+                                 hwaddr ram_base, uint64_t ram_size,
+                                 const uint64_t *cpu_mpidrs,
+                                 unsigned int num_cpus);
+bool phytium_e2000_pbr_firmware_loaded(PhytiumE2000PBRState *s);
+int phytium_e2000_pbr_primary_cpu(PhytiumE2000PBRState *s);
+void phytium_e2000_pbr_connect_cpu(PhytiumE2000PBRState *s,
+                                   unsigned int index, CPUState *cpu);
+
+#endif
diff --git a/hw/misc/phytium_e2000_pbr.c b/hw/misc/phytium_e2000_pbr.c
new file mode 100644
index 0000000000..4485f073e1
--- /dev/null
+++ b/hw/misc/phytium_e2000_pbr.c
@@ -0,0 +1,1221 @@
+/*
+ * Phytium E2000 PBR (Phytium Boot ROM) model
+ *
+ * The on-chip PBR does not execute Arm instructions in QEMU. This device
+ * reproduces its boot-medium loading and handoff behavior before releasing
+ * PBF on the primary CPU selected by the firmware container.
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
+#include "hw/misc/phytium_e2000_pbr.h"
+
+#include "hw/core/cpu.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/register.h"
+#include "hw/misc/phytium_e2000_mhu.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/host-utils.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "system/address-spaces.h"
+#include "system/block-backend-io.h"
+
+REG32(RESET_SOURCE, 0x00)
+REG32(SCP_READY, 0x04)
+REG32(BOOT_MEDIA, 0x08)
+REG32(ETH_TRAINING_STATUS, 0x60)
+
+#define PHYTIUM_E2000_PBR_R_MAX \
+    (PHYTIUM_E2000_PBR_MMIO_SIZE / sizeof(uint32_t))
+
+#define PHYTIUM_E2000_FIP_ALL_HEADER_SIZE           0x000f4c10
+#define PHYTIUM_E2000_FIP_ALL_PAYLOAD_INFO_OFFSET   0x000f4c00
+#define PHYTIUM_E2000_FIP_ALL_MIN_SIZE              0x00100000
+#define PHYTIUM_E2000_FIP_ALL_MAX_SIZE              (4 * MiB)
+#define PHYTIUM_E2000_TFA_FIP_OFFSET                0x000d0000
+#define PHYTIUM_E2000_TFA_FIP_MAGIC                 0xaa640001
+#define PHYTIUM_E2000_TFA_FIP_HEADER_SIZE           16
+#define PHYTIUM_E2000_TFA_FIP_UUID_SIZE             16
+#define PHYTIUM_E2000_TFA_FIP_ENTRY_SIZE            40
+#define PHYTIUM_E2000_TFA_FIP_MAX_ENTRIES           64
+
+#define PHYTIUM_E2000_PBF_PARAMETER_OFFSET          0x000f4000
+#define PHYTIUM_E2000_PBF_MAGIC                     0x54460000
+#define PHYTIUM_E2000_PBF_PRIMARY_CORE_OFFSET       0x1c
+#define PHYTIUM_E2000_BL1_FLASH_OFFSET              0x00040000
+#define PHYTIUM_E2000_BL1_SIZE                      0x00090000
+#define PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE          0xf8c40000
+
+#define PHYTIUM_E2000_PBR_ROOT_OFFSET 0x00000f00
+#define PHYTIUM_E2000_PBR_ROOT        \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1000)
+#define PHYTIUM_E2000_PBR_PARAM_NODE  \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x10a0)
+#define PHYTIUM_E2000_PBR_PARAM_SLOT  \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1200)
+#define PHYTIUM_E2000_PBR_PLL_DESC    \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1220)
+#define PHYTIUM_E2000_PBR_MCU_DESC    \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1240)
+#define PHYTIUM_E2000_PBR_PCIE_DESC   \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1260)
+#define PHYTIUM_E2000_PBR_COMMON_DESC \
+    (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0x1280)
+
+#define PHYTIUM_E2000_PBR_SCP_PARAM_BASE  0x32a10c00
+#define PHYTIUM_E2000_PBR_PLL_PAYLOAD     \
+    (PHYTIUM_E2000_PBR_SCP_PARAM_BASE + 0x000)
+#define PHYTIUM_E2000_PBR_MCU_PAYLOAD     \
+    (PHYTIUM_E2000_PBR_SCP_PARAM_BASE + 0x100)
+#define PHYTIUM_E2000_PBR_PCIE_PAYLOAD    \
+    (PHYTIUM_E2000_PBR_SCP_PARAM_BASE + 0x200)
+#define PHYTIUM_E2000_PBR_COMMON_PAYLOAD  \
+    (PHYTIUM_E2000_PBR_SCP_PARAM_BASE + 0x300)
+#define PHYTIUM_E2000_PBR_PARAM_COPY      0xf1801300
+#define PHYTIUM_E2000_PBR_PARAM_COPY_SIZE 0x20
+
+#define PHYTIUM_E2000_PARAM_BASE      0x000f5000
+#define PHYTIUM_E2000_PARAM_SLOT_SIZE 0x100
+#define PHYTIUM_PBF_PARAM_SIZE_OFFSET 0x08
+#define PHYTIUM_PBF_PARAM_HEADER_SIZE 0x10
+
+typedef enum PhytiumE2000PbfParameter {
+    PHYTIUM_E2000_PBF_PARAM_PLL,
+    PHYTIUM_E2000_PBF_PARAM_DDR,
+    PHYTIUM_E2000_PBF_PARAM_PCIE,
+    PHYTIUM_E2000_PBF_PARAM_COMMON,
+    PHYTIUM_E2000_PBF_PARAM_COUNT,
+} PhytiumE2000PbfParameter;
+
+typedef struct PhytiumE2000PbfParameterSpec {
+    const char *name;
+    size_t source_offset;
+    hwaddr destination;
+    uint32_t magic;
+    uint32_t minimum_size;
+    uint32_t slot_size;
+} PhytiumE2000PbfParameterSpec;
+
+/*
+ * The PBF interface specification publishes the common parameter-record
+ * header, but not this E2000 fip-all.bin placement or the PBR-owned SCP SRAM
+ * handoff.  Keep the documented record shape separate from this
+ * firmware-derived E2000 profile.
+ *
+ * The specification's older PLL/PCIe/DDR magics are 0x54460010,
+ * 0x54460011, and 0x54460014.  Every inspected E2000 image instead uses the
+ * exact values below.  Do not infer compatibility from the common prefix:
+ * recognizing a record class does not prove that this PBF accepts its
+ * payload format.
+ */
+static const PhytiumE2000PbfParameterSpec
+phytium_e2000_pbf_parameters[PHYTIUM_E2000_PBF_PARAM_COUNT] = {
+    [PHYTIUM_E2000_PBF_PARAM_PLL] = {
+        .name = "PLL",
+        .source_offset = PHYTIUM_E2000_PARAM_BASE,
+        .destination = PHYTIUM_E2000_PBR_PLL_PAYLOAD,
+        .magic = 0x54460020,
+        .minimum_size = PHYTIUM_PBF_PARAM_HEADER_SIZE,
+        .slot_size = PHYTIUM_E2000_PARAM_SLOT_SIZE,
+    },
+    [PHYTIUM_E2000_PBF_PARAM_DDR] = {
+        /* MCU is Memory Controller Unit, not a microcontroller */
+        .name = "DDR/MCU",
+        .source_offset = PHYTIUM_E2000_PARAM_BASE + 0x300,
+        .destination = PHYTIUM_E2000_PBR_MCU_PAYLOAD,
+        .magic = 0x54460024,
+        .minimum_size = PHYTIUM_PBF_PARAM_HEADER_SIZE,
+        .slot_size = PHYTIUM_E2000_PARAM_SLOT_SIZE,
+    },
+    [PHYTIUM_E2000_PBF_PARAM_PCIE] = {
+        .name = "PCIe",
+        .source_offset = PHYTIUM_E2000_PARAM_BASE + 0x100,
+        .destination = PHYTIUM_E2000_PBR_PCIE_PAYLOAD,
+        .magic = 0x54460021,
+        .minimum_size = PHYTIUM_PBF_PARAM_HEADER_SIZE,
+        .slot_size = PHYTIUM_E2000_PARAM_SLOT_SIZE,
+    },
+    [PHYTIUM_E2000_PBF_PARAM_COMMON] = {
+        .name = "COMMON",
+        .source_offset = PHYTIUM_E2000_PARAM_BASE + 0x200,
+        .destination = PHYTIUM_E2000_PBR_COMMON_PAYLOAD,
+        .magic = 0x54460013,
+        .minimum_size = PHYTIUM_PBF_PARAM_HEADER_SIZE,
+        .slot_size = PHYTIUM_E2000_PARAM_SLOT_SIZE,
+    },
+};
+
+static const PhytiumE2000PbfParameterSpec
+phytium_e2000_pbf_summary = {
+    /*
+     * The public service specification does not describe this container
+     * summary.  All inspected E2000 images nevertheless use the same common
+     * header, followed by the PBR-to-PBF fields consumed below.
+     */
+    .name = "PBF",
+    .source_offset = PHYTIUM_E2000_PBF_PARAMETER_OFFSET,
+    .magic = PHYTIUM_E2000_PBF_MAGIC,
+    .minimum_size = PHYTIUM_E2000_PBR_PARAM_COPY_SIZE,
+    .slot_size = PHYTIUM_E2000_PARAM_SLOT_SIZE,
+};
+
+/*
+ * TF-A v2.3 represents an I/O driver as an io_dev_connector_t followed by
+ * io_dev_funcs_t.  The former contains one pointer and the latter contains
+ * nine function pointers on AArch64.  PBF embeds a FIP driver, a memmap
+ * driver, and the memmap driver's static io_dev_info_t consecutively.
+ *
+ * These sizes come from the public TF-A v2.3 io_driver.h ABI.  They are not
+ * Phytium guesses and must stay expressed in terms of the TF-A types instead
+ * of unexplained offsets such as 0x50, 0xa0, and 0xb0.
+ */
+#define PHYTIUM_E2000_TFA_IO_CONNECTOR_SIZE      sizeof(uint64_t)
+#define PHYTIUM_E2000_TFA_IO_FUNC_COUNT          9
+#define PHYTIUM_E2000_TFA_IO_FUNCS_SIZE          \
+    (PHYTIUM_E2000_TFA_IO_FUNC_COUNT * sizeof(uint64_t))
+#define PHYTIUM_E2000_TFA_IO_DRIVER_SIZE         \
+    (PHYTIUM_E2000_TFA_IO_CONNECTOR_SIZE + PHYTIUM_E2000_TFA_IO_FUNCS_SIZE)
+#define PHYTIUM_E2000_TFA_FIP_DRIVER_OFFSET      0
+#define PHYTIUM_E2000_TFA_MEMMAP_DRIVER_OFFSET   \
+    PHYTIUM_E2000_TFA_IO_DRIVER_SIZE
+#define PHYTIUM_E2000_TFA_MEMMAP_DEV_INFO_OFFSET \
+    (2 * PHYTIUM_E2000_TFA_IO_DRIVER_SIZE)
+#define PHYTIUM_E2000_TFA_IO_DEV_INFO_SIZE       (2 * sizeof(uint64_t))
+#define PHYTIUM_E2000_TFA_IO_DRIVER_GROUP_SIZE   \
+    (PHYTIUM_E2000_TFA_MEMMAP_DEV_INFO_OFFSET +  \
+     PHYTIUM_E2000_TFA_IO_DEV_INFO_SIZE)
+
+/*
+ * A TF-A platform I/O policy entry contains dev_handle, image_spec, and
+ * check.  Three entries are sufficient to distinguish the leading memmap
+ * policy from the following FIP policies in every inspected PBF.
+ */
+#define PHYTIUM_E2000_TFA_IO_POLICY_ENTRY_SIZE  (3 * sizeof(uint64_t))
+#define PHYTIUM_E2000_TFA_IO_POLICY_PREFIX_SIZE \
+    (3 * PHYTIUM_E2000_TFA_IO_POLICY_ENTRY_SIZE)
+
+/*
+ * The address of fip_dev_info is not present as data in the PBF image.  PBR
+ * obtains it by calling the FIP driver's dev_open callback.  Disassembly of
+ * that callback in the 2 GiB and 4 GiB Phytium Pi SDK PBFs and the COMe SDK
+ * PBF shows the compiler-emitted object 0xb0 bytes before the fip_dev_con
+ * slot.  This is a property of those firmware builds, not a TF-A or hardware
+ * ABI.
+ *
+ * Executing an arbitrary PBF callback inside QEMU's reset path is neither a
+ * safe parser nor an emulation of the ROM.  Keep this one empirical relation
+ * explicit and reject images whose surrounding TF-A structures do not match,
+ * rather than silently selecting an address from the DDR/MCU record version.
+ */
+#define PHYTIUM_E2000_PBR_FIP_DEV_INFO_BACKOFF 0xb0
+#define PHYTIUM_E2000_PBR_FIP_DEV_STATE_OFFSET 0x10
+
+typedef struct PhytiumE2000TfaIoHandoff {
+    hwaddr fip_connector_slot;
+    hwaddr fip_handle_slot;
+    hwaddr fip_dev_info;
+    hwaddr fip_dev_state;
+    hwaddr fip_connector;
+    hwaddr fip_funcs;
+    hwaddr memmap_connector_slot;
+    hwaddr memmap_handle_slot;
+    hwaddr memmap_connector;
+    hwaddr memmap_dev_info;
+} PhytiumE2000TfaIoHandoff;
+
+struct PhytiumE2000PBRState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_PBR_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_PBR_R_MAX];
+    MemoryRegion boot_sram;
+    MemoryRegion iacc;
+    uint32_t boot_media;
+    BlockBackend *boot_blk;
+    char *boot_mode;
+    hwaddr ram_base;
+    uint64_t ram_size;
+    uint64_t cpu_mpidrs[PHYTIUM_E2000_PBR_MAX_CPUS];
+    CPUState *cpus[PHYTIUM_E2000_PBR_MAX_CPUS];
+    unsigned int num_cpus;
+    bool firmware_loaded;
+    int32_t primary_cpu;
+    uint32_t parameter_sizes[PHYTIUM_E2000_PBF_PARAM_COUNT];
+    PhytiumE2000TfaIoHandoff tfa_io;
+    uint8_t *iacc_image;
+    size_t iacc_image_size;
+    uint8_t *bl1;
+    size_t bl1_size;
+};
+
+static const char *phytium_e2000_pbr_boot_medium(PhytiumE2000PBRState *s)
+{
+    if (!strcmp(s->boot_mode, PHYTIUM_E2000_PBR_BOOT_MODE_QSPI)) {
+        return "QSPI";
+    }
+
+    return "SD";
+}
+
+static const RegisterAccessInfo phytium_e2000_pbr_regs_info[] = {
+    /*
+     * These reset values are the boot contract observed by the vendor PBF:
+     * reset source 1 selects the power-on path, 0xabcdef releases the SCP
+     * ready wait, boot media reflects the board strap selected by PBR, and
+     * 0x0c reports the Ethernet training state expected by the tested
+     * firmware.
+     *
+     * They remain read-only because software is consuming PBR-owned status,
+     * not configuring a live peripheral.
+     */
+    { .name = "RESET_SOURCE", .addr = A_RESET_SOURCE,
+      .reset = 0x1, .ro = UINT32_MAX },
+    { .name = "SCP_READY", .addr = A_SCP_READY,
+      .reset = 0x00abcdef, .ro = UINT32_MAX },
+    { .name = "BOOT_MEDIA", .addr = A_BOOT_MEDIA,
+      .ro = UINT32_MAX },
+    { .name = "ETH_TRAINING_STATUS", .addr = A_ETH_TRAINING_STATUS,
+      .reset = 0x0c, .ro = UINT32_MAX },
+};
+
+static const MemoryRegionOps phytium_e2000_pbr_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        /*
+         * PBF byte-copies the complete status structure into SCP SRAM,
+         * including reserved holes such as base + 0x10. Accept subword and
+         * unaligned reads even though the defined status fields are 32-bit.
+         */
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
+};
+
+static bool phytium_e2000_pbr_ranges_overlap(uint64_t first_offset,
+                                             uint64_t first_size,
+                                             uint64_t second_offset,
+                                             uint64_t second_size)
+{
+    if (!first_size || !second_size) {
+        return false;
+    }
+
+    return first_offset < second_offset + second_size &&
+           second_offset < first_offset + first_size;
+}
+
+static bool phytium_e2000_pbr_fip_extent(const uint8_t *header,
+                                         uint64_t medium_size,
+                                         size_t *extent, Error **errp)
+{
+    const uint8_t *info =
+        header + PHYTIUM_E2000_FIP_ALL_PAYLOAD_INFO_OFFSET;
+    uint32_t bl33_offset = ldl_le_p(info);
+    uint32_t bl33_size = ldl_le_p(info + 4);
+    uint32_t bl32_offset = ldl_le_p(info + 8);
+    uint32_t bl32_size = ldl_le_p(info + 12);
+    uint32_t bl33_end;
+    uint32_t bl32_end;
+    uint64_t image_extent;
+
+    if (ldl_le_p(header + PHYTIUM_E2000_PBF_PARAMETER_OFFSET) !=
+        PHYTIUM_E2000_PBF_MAGIC) {
+        error_setg(errp, "PBF magic at 0x%x is not 0x%08x",
+                   PHYTIUM_E2000_PBF_PARAMETER_OFFSET,
+                   PHYTIUM_E2000_PBF_MAGIC);
+        return false;
+    }
+
+    if (uadd32_overflow(bl33_offset, bl33_size, &bl33_end) ||
+        uadd32_overflow(bl32_offset, bl32_size, &bl32_end)) {
+        error_setg(errp, "BL32/BL33 metadata overflows its address range");
+        return false;
+    }
+
+    if (bl33_end > medium_size || bl32_end > medium_size) {
+        error_setg(errp, "BL32/BL33 range exceeds the boot medium");
+        return false;
+    }
+
+    if (phytium_e2000_pbr_ranges_overlap(bl33_offset, bl33_size,
+                                         bl32_offset, bl32_size)) {
+        error_setg(errp, "BL32 and BL33 payload ranges overlap");
+        return false;
+    }
+
+    image_extent = MAX((uint64_t)PHYTIUM_E2000_FIP_ALL_MIN_SIZE,
+                       MAX(bl33_end, bl32_end));
+    if (image_extent > medium_size) {
+        error_setg(errp, "computed fip-all.bin extent 0x%" PRIx64
+                   " exceeds the boot medium size 0x%" PRIx64,
+                   image_extent, medium_size);
+        return false;
+    }
+    if (image_extent > PHYTIUM_E2000_FIP_ALL_MAX_SIZE) {
+        error_setg(errp, "computed fip-all.bin extent 0x%" PRIx64
+                   " exceeds the 4 MiB firmware region", image_extent);
+        return false;
+    }
+
+    *extent = image_extent;
+    return true;
+}
+
+static bool phytium_e2000_pbr_tfa_fip_valid(const uint8_t *data, size_t size,
+                                            Error **errp)
+{
+    const uint8_t *fip = data + PHYTIUM_E2000_TFA_FIP_OFFSET;
+    uint64_t max_payload_end = 0;
+    uint64_t min_payload_offset = UINT64_MAX;
+    uint64_t available;
+    size_t entry_offset;
+    unsigned int i;
+    bool has_entry = false;
+
+    if (size < PHYTIUM_E2000_TFA_FIP_OFFSET +
+               PHYTIUM_E2000_TFA_FIP_HEADER_SIZE +
+               PHYTIUM_E2000_TFA_FIP_ENTRY_SIZE) {
+        error_setg(errp, "image is too small for the TF-A FIP header");
+        return false;
+    }
+    if (ldl_le_p(fip) != PHYTIUM_E2000_TFA_FIP_MAGIC) {
+        error_setg(errp, "TF-A FIP magic at 0x%x is not 0x%08x",
+                   PHYTIUM_E2000_TFA_FIP_OFFSET,
+                   PHYTIUM_E2000_TFA_FIP_MAGIC);
+        return false;
+    }
+    if (!ldl_le_p(fip + sizeof(uint32_t))) {
+        error_setg(errp, "TF-A FIP serial number is zero");
+        return false;
+    }
+
+    available = size - PHYTIUM_E2000_TFA_FIP_OFFSET;
+    entry_offset = PHYTIUM_E2000_TFA_FIP_HEADER_SIZE;
+    for (i = 0; i < PHYTIUM_E2000_TFA_FIP_MAX_ENTRIES; i++) {
+        const uint8_t *entry;
+        uint64_t payload_offset;
+        uint64_t payload_size;
+        uint64_t payload_end;
+        uint64_t payload_flags;
+
+        if (entry_offset + PHYTIUM_E2000_TFA_FIP_ENTRY_SIZE > available) {
+            error_setg(errp, "TF-A FIP TOC has no in-bounds terminator");
+            return false;
+        }
+
+        entry = fip + entry_offset;
+        payload_offset = ldq_le_p(entry + PHYTIUM_E2000_TFA_FIP_UUID_SIZE);
+        payload_size = ldq_le_p(entry +
+                                PHYTIUM_E2000_TFA_FIP_UUID_SIZE + 8);
+        payload_flags = ldq_le_p(entry +
+                                 PHYTIUM_E2000_TFA_FIP_UUID_SIZE + 16);
+        if (buffer_is_zero(entry, PHYTIUM_E2000_TFA_FIP_UUID_SIZE)) {
+            uint64_t toc_end = entry_offset +
+                               PHYTIUM_E2000_TFA_FIP_ENTRY_SIZE;
+
+            /*
+             * A zero UUID terminates the TF-A TOC. Its offset records the end
+             * of the package rather than another payload start, so all prior
+             * payloads and the TOC itself must fit below that boundary.
+             */
+            if (!has_entry) {
+                error_setg(errp, "TF-A FIP TOC has no payload entries");
+                return false;
+            }
+            if (payload_size || payload_flags || payload_offset < toc_end ||
+                payload_offset > available ||
+                max_payload_end > payload_offset ||
+                min_payload_offset < toc_end) {
+                error_setg(errp, "TF-A FIP TOC terminator is out of bounds");
+                return false;
+            }
+            return true;
+        }
+
+        if (uadd64_overflow(payload_offset, payload_size, &payload_end) ||
+            payload_offset < PHYTIUM_E2000_TFA_FIP_HEADER_SIZE ||
+            payload_end > available) {
+            error_setg(errp, "TF-A FIP payload range is out of bounds");
+            return false;
+        }
+        has_entry = true;
+        min_payload_offset = MIN(min_payload_offset, payload_offset);
+        max_payload_end = MAX(max_payload_end, payload_end);
+        entry_offset += PHYTIUM_E2000_TFA_FIP_ENTRY_SIZE;
+    }
+
+    error_setg(errp, "TF-A FIP TOC exceeds %u entries",
+               PHYTIUM_E2000_TFA_FIP_MAX_ENTRIES);
+    return false;
+}
+
+static bool phytium_e2000_pbr_parameter_valid(
+    const uint8_t *data, size_t size,
+    const PhytiumE2000PbfParameterSpec *spec, uint32_t *validated_size,
+    Error **errp)
+{
+    const uint8_t *parameter;
+    uint32_t record_size;
+
+    if (spec->source_offset > size ||
+        size - spec->source_offset < PHYTIUM_PBF_PARAM_HEADER_SIZE) {
+        error_setg(errp, "%s parameter record at 0x%zx is out of bounds",
+                   spec->name, spec->source_offset);
+        return false;
+    }
+
+    parameter = data + spec->source_offset;
+    if (ldl_le_p(parameter) != spec->magic) {
+        error_setg(errp, "%s parameter magic at 0x%zx is not 0x%08x",
+                   spec->name, spec->source_offset, spec->magic);
+        return false;
+    }
+
+    record_size = ldl_le_p(parameter + PHYTIUM_PBF_PARAM_SIZE_OFFSET);
+    if (record_size < spec->minimum_size ||
+        record_size > spec->slot_size ||
+        record_size > size - spec->source_offset) {
+        error_setg(errp, "%s parameter size 0x%x is outside the "
+                   "0x%x-byte parameter slot", spec->name, record_size,
+                   spec->slot_size);
+        return false;
+    }
+
+    /*
+     * The public PBF ABI defines magic, version, size, and reserved as a
+     * common 16-byte header for PLL, PCIe, DDR, and COMMON parameters.  It
+     * passes each service-specific payload to PBF by address rather than
+     * defining it as part of a PBR layout.  In particular, the DDR record
+     * contains firmware-owned SPD and training data.
+     *
+     * GET_PARAMETER_VERSION reports a separate version for each PBF service.
+     * Consequently, a record version describes that service's payload, not
+     * the PBR handoff graph or TF-A object placement.  Preserve the payload
+     * and reserved word verbatim and accept an otherwise valid future
+     * version instead of inventing version-specific PBR layouts.
+     */
+    if (validated_size) {
+        *validated_size = record_size;
+    }
+
+    return true;
+}
+
+static bool phytium_e2000_pbr_pbf_code_pointer(uint64_t value)
+{
+    return value >= PHYTIUM_E2000_PBR_IACC_BASE +
+                    PHYTIUM_E2000_BL1_FLASH_OFFSET &&
+           value < PHYTIUM_E2000_PBR_IACC_BASE +
+                   PHYTIUM_E2000_TFA_FIP_OFFSET &&
+           !(value & 3);
+}
+
+static bool phytium_e2000_pbr_boot_sram_qword(uint64_t value)
+{
+    return value >= PHYTIUM_E2000_PBR_BOOT_SRAM_BASE &&
+           value <= PHYTIUM_E2000_PBR_BOOT_SRAM_BASE +
+                    PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE - sizeof(uint64_t) &&
+           !(value & 7);
+}
+
+static bool phytium_e2000_pbr_tfa_io_driver_candidate(const uint8_t *data,
+                                                      size_t offset)
+{
+    unsigned int implemented = 0;
+    unsigned int i;
+
+    /*
+     * connector->dev_open is mandatory.  Individual io_dev_funcs_t entries
+     * may be NULL: for example, TF-A's FIP driver has no size/write methods
+     * and its memmap driver has no dev_close method in the inspected builds.
+     * Requiring every slot to be non-NULL would encode one implementation,
+     * while accepting non-code values would make the scan match random data.
+     */
+    if (!phytium_e2000_pbr_pbf_code_pointer(ldq_le_p(data + offset))) {
+        return false;
+    }
+
+    for (i = 0; i < PHYTIUM_E2000_TFA_IO_FUNC_COUNT; i++) {
+        uint64_t function = ldq_le_p(
+            data + offset + PHYTIUM_E2000_TFA_IO_CONNECTOR_SIZE +
+            i * sizeof(uint64_t));
+
+        if (!function) {
+            continue;
+        }
+        if (!phytium_e2000_pbr_pbf_code_pointer(function)) {
+            return false;
+        }
+        implemented++;
+    }
+
+    /*
+     * All known TF-A I/O drivers used here implement substantially more than
+     * a connector.  This lower bound is a parser discriminator, not an ABI
+     * promise about which particular callbacks must exist.
+     */
+    return implemented >= 4;
+}
+
+static bool phytium_e2000_pbr_tfa_io_driver_group_candidate(
+    const uint8_t *data, size_t offset)
+{
+    size_t memmap = offset + PHYTIUM_E2000_TFA_MEMMAP_DRIVER_OFFSET;
+    size_t dev_info = offset + PHYTIUM_E2000_TFA_MEMMAP_DEV_INFO_OFFSET;
+    uint64_t expected_funcs =
+        PHYTIUM_E2000_PBR_IACC_BASE + memmap +
+        PHYTIUM_E2000_TFA_IO_CONNECTOR_SIZE;
+
+    if (!phytium_e2000_pbr_tfa_io_driver_candidate(
+            data, offset + PHYTIUM_E2000_TFA_FIP_DRIVER_OFFSET) ||
+        !phytium_e2000_pbr_tfa_io_driver_candidate(data, memmap)) {
+        return false;
+    }
+
+    /*
+     * The memmap driver uses a static io_dev_info_t immediately after both
+     * drivers.  Its funcs member points at the memmap io_dev_funcs_t and its
+     * info member is zero.  This relation is defined by TF-A source and makes
+     * the otherwise relocatable driver group uniquely identifiable.
+     */
+    return ldq_le_p(data + dev_info) == expected_funcs &&
+           !ldq_le_p(data + dev_info + sizeof(uint64_t));
+}
+
+static bool phytium_e2000_pbr_tfa_io_policy_candidate(
+    const uint8_t *data, size_t offset, hwaddr *memmap_handle_slot,
+    hwaddr *fip_handle_slot)
+{
+    const uint8_t *memmap_policy = data + offset;
+    const uint8_t *fip_policy = memmap_policy +
+                                PHYTIUM_E2000_TFA_IO_POLICY_ENTRY_SIZE;
+    const uint8_t *second_fip_policy =
+        fip_policy + PHYTIUM_E2000_TFA_IO_POLICY_ENTRY_SIZE;
+    uint64_t memmap_handle = ldq_le_p(memmap_policy);
+    uint64_t fip_handle = ldq_le_p(fip_policy);
+    uint64_t second_fip_handle = ldq_le_p(second_fip_policy);
+    const uint8_t *policies[] = {
+        memmap_policy, fip_policy, second_fip_policy,
+    };
+    unsigned int i;
+
+    /*
+     * TF-A's plat_io_policy[] stores a pointer to each driver's handle slot,
+     * not the handle value itself.  The first policy maps the FIP container
+     * through the memmap device; image policies that follow use the FIP
+     * device.  This ordering is visible in arm_io_storage.c and is shared by
+     * all three inspected PBF images.
+     *
+     * The complete vendor table has 28 entries and contains sparse zero
+     * holes, but neither its length nor a terminator is self-describing.
+     * Depending on that sample-specific count would merely replace one magic
+     * address with a magic array length, so only the semantically meaningful
+     * three-entry prefix is used to locate the two handle slots.
+     */
+    if (!phytium_e2000_pbr_boot_sram_qword(memmap_handle) ||
+        !phytium_e2000_pbr_boot_sram_qword(fip_handle) ||
+        memmap_handle == fip_handle || second_fip_handle != fip_handle ||
+        memmap_handle < PHYTIUM_E2000_PBR_BOOT_SRAM_BASE +
+                        sizeof(uint64_t) ||
+        fip_handle < PHYTIUM_E2000_PBR_BOOT_SRAM_BASE +
+                     sizeof(uint64_t)) {
+        return false;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(policies); i++) {
+        if (!phytium_e2000_pbr_pbf_code_pointer(
+                ldq_le_p(policies[i] + sizeof(uint64_t))) ||
+            !phytium_e2000_pbr_pbf_code_pointer(
+                ldq_le_p(policies[i] + 2 * sizeof(uint64_t)))) {
+            return false;
+        }
+    }
+
+    *memmap_handle_slot = memmap_handle;
+    *fip_handle_slot = fip_handle;
+    return true;
+}
+
+static bool phytium_e2000_pbr_tfa_io_handoff_valid(
+    const uint8_t *data, size_t size, PhytiumE2000TfaIoHandoff *handoff,
+    Error **errp)
+{
+    size_t scan_end = MIN(size, (size_t)PHYTIUM_E2000_TFA_FIP_OFFSET);
+    size_t driver_offset = 0;
+    hwaddr memmap_handle_slot = 0;
+    hwaddr fip_handle_slot = 0;
+    size_t offset;
+
+    /*
+     * Real PBR registers and opens the TF-A memmap and FIP I/O devices before
+     * releasing PBF.  QEMU intentionally models that ROM-visible result
+     * instead of executing undocumented PBR instructions.
+     *
+     * The PBF image contains the relocatable driver definitions and policy
+     * table, so scan for their public TF-A structural relationships.  This is
+     * why no DDR/MCU record-version address table appears here: even the two
+     * version 4 builds put these objects at different IACC offsets.
+     */
+    for (offset = PHYTIUM_E2000_BL1_FLASH_OFFSET;
+         offset + PHYTIUM_E2000_TFA_IO_DRIVER_GROUP_SIZE <= scan_end;
+         offset += sizeof(uint64_t)) {
+        if (!phytium_e2000_pbr_tfa_io_driver_group_candidate(data,
+                                                             offset)) {
+            continue;
+        }
+        if (driver_offset) {
+            error_setg(errp, "PBF contains multiple TF-A I/O driver groups");
+            return false;
+        }
+        driver_offset = offset;
+    }
+    if (!driver_offset) {
+        error_setg(errp, "PBF does not contain a valid TF-A I/O driver "
+                   "group");
+        return false;
+    }
+
+    for (offset = PHYTIUM_E2000_BL1_FLASH_OFFSET;
+         offset + PHYTIUM_E2000_TFA_IO_POLICY_PREFIX_SIZE <= scan_end;
+         offset += sizeof(uint64_t)) {
+        hwaddr candidate_memmap_handle;
+        hwaddr candidate_fip_handle;
+
+        if (!phytium_e2000_pbr_tfa_io_policy_candidate(
+                data, offset, &candidate_memmap_handle,
+                &candidate_fip_handle)) {
+            continue;
+        }
+        if (fip_handle_slot) {
+            error_setg(errp, "PBF contains multiple TF-A I/O policy "
+                       "tables");
+            return false;
+        }
+        memmap_handle_slot = candidate_memmap_handle;
+        fip_handle_slot = candidate_fip_handle;
+    }
+    if (!fip_handle_slot) {
+        error_setg(errp, "PBF does not contain a valid TF-A I/O policy "
+                   "table");
+        return false;
+    }
+
+    handoff->fip_connector_slot = fip_handle_slot - sizeof(uint64_t);
+    handoff->fip_handle_slot = fip_handle_slot;
+    if (handoff->fip_connector_slot <
+        PHYTIUM_E2000_PBR_BOOT_SRAM_BASE +
+        PHYTIUM_E2000_PBR_FIP_DEV_INFO_BACKOFF) {
+        error_setg(errp, "PBF TF-A FIP connector slot is too low for its "
+                   "device state");
+        return false;
+    }
+    handoff->fip_dev_info = handoff->fip_connector_slot -
+                            PHYTIUM_E2000_PBR_FIP_DEV_INFO_BACKOFF;
+    handoff->fip_dev_state = handoff->fip_dev_info +
+                             PHYTIUM_E2000_PBR_FIP_DEV_STATE_OFFSET;
+    handoff->memmap_connector_slot =
+        memmap_handle_slot - sizeof(uint64_t);
+    handoff->memmap_handle_slot = memmap_handle_slot;
+
+    if (!phytium_e2000_pbr_boot_sram_qword(handoff->fip_dev_info) ||
+        !phytium_e2000_pbr_boot_sram_qword(handoff->fip_dev_state) ||
+        !phytium_e2000_pbr_boot_sram_qword(
+            handoff->memmap_connector_slot)) {
+        error_setg(errp, "PBF TF-A I/O handoff objects are outside boot "
+                   "SRAM");
+        return false;
+    }
+
+    handoff->fip_connector =
+        PHYTIUM_E2000_PBR_IACC_BASE + driver_offset +
+        PHYTIUM_E2000_TFA_FIP_DRIVER_OFFSET;
+    handoff->fip_funcs =
+        handoff->fip_connector + PHYTIUM_E2000_TFA_IO_CONNECTOR_SIZE;
+    handoff->memmap_connector =
+        PHYTIUM_E2000_PBR_IACC_BASE + driver_offset +
+        PHYTIUM_E2000_TFA_MEMMAP_DRIVER_OFFSET;
+    handoff->memmap_dev_info =
+        PHYTIUM_E2000_PBR_IACC_BASE + driver_offset +
+        PHYTIUM_E2000_TFA_MEMMAP_DEV_INFO_OFFSET;
+    return true;
+}
+
+static bool phytium_e2000_pbr_parse_firmware(PhytiumE2000PBRState *s,
+                                             const uint8_t *data,
+                                             size_t size, Error **errp)
+{
+    uint32_t primary_mpidr;
+    uint64_t bl1_end;
+    int primary_cpu = -1;
+    unsigned int i;
+
+    if (size < PHYTIUM_E2000_BL1_FLASH_OFFSET +
+               PHYTIUM_E2000_BL1_SIZE) {
+        error_setg(errp, "image is too small for the PBF handoff data");
+        return false;
+    }
+
+    if (!phytium_e2000_pbr_parameter_valid(data, size,
+                                           &phytium_e2000_pbf_summary,
+                                           NULL, errp)) {
+        return false;
+    }
+
+    for (i = 0; i < PHYTIUM_E2000_PBF_PARAM_COUNT; i++) {
+        if (!phytium_e2000_pbr_parameter_valid(
+                data, size, &phytium_e2000_pbf_parameters[i],
+                &s->parameter_sizes[i], errp)) {
+            return false;
+        }
+    }
+    if (!phytium_e2000_pbr_tfa_io_handoff_valid(data, size, &s->tfa_io,
+                                                errp)) {
+        return false;
+    }
+
+    primary_mpidr = lduw_le_p(data + PHYTIUM_E2000_PBF_PARAMETER_OFFSET +
+                              PHYTIUM_E2000_PBF_PRIMARY_CORE_OFFSET);
+    /*
+     * The PBF container stores only Aff1:Aff0 in this 16-bit field. Compare
+     * the same affinities from each complete architectural MPIDR.
+     */
+    for (i = 0; i < s->num_cpus; i++) {
+        if ((s->cpu_mpidrs[i] & 0xffff) == primary_mpidr) {
+            primary_cpu = i;
+            break;
+        }
+    }
+    if (primary_cpu < 0) {
+        error_setg(errp, "PBR firmware primary core 0x%x is not present; "
+                   "use at least -smp 3", primary_mpidr);
+        return false;
+    }
+
+    bl1_end = PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE +
+              PHYTIUM_E2000_BL1_SIZE;
+    if (s->ram_size < bl1_end - s->ram_base) {
+        error_setg(errp, "PBR firmware requires RAM to cover PBF runtime "
+                   "address 0x%" HWADDR_PRIx "; use -m 2G",
+                   (hwaddr)PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE);
+        return false;
+    }
+
+    if (size > PHYTIUM_E2000_PBR_IACC_SIZE) {
+        error_setg(errp, "PBR firmware image does not fit in boot IACC");
+        return false;
+    }
+
+    s->firmware_loaded = true;
+    s->primary_cpu = primary_cpu;
+    s->iacc_image_size = size;
+    s->iacc_image = g_memdup2(data, size);
+    s->bl1_size = PHYTIUM_E2000_BL1_SIZE;
+    s->bl1 = g_memdup2(data + PHYTIUM_E2000_BL1_FLASH_OFFSET,
+                       s->bl1_size);
+    return true;
+}
+
+static bool phytium_e2000_pbr_load_firmware(PhytiumE2000PBRState *s,
+                                            Error **errp)
+{
+    g_autofree uint8_t *contents = NULL;
+    const char *boot_medium = phytium_e2000_pbr_boot_medium(s);
+    Error *local_err = NULL;
+    int64_t backend_size;
+    size_t extent;
+
+    if (!s->boot_blk) {
+        /*
+         * A missing backend is valid for direct -kernel boot. Leave
+         * firmware_loaded clear so the machine selects the generic Arm
+         * loader instead of the PBR reset handoff.
+         */
+        return true;
+    }
+
+    backend_size = blk_getlength(s->boot_blk);
+    if (backend_size < 0) {
+        error_setg_errno(errp, -backend_size,
+                         "failed to determine %s boot-medium size",
+                         boot_medium);
+        return false;
+    }
+    if (backend_size < PHYTIUM_E2000_FIP_ALL_HEADER_SIZE) {
+        error_setg(errp, "%s is too small for the fip-all.bin metadata",
+                   boot_medium);
+        return false;
+    }
+
+    contents = g_malloc(PHYTIUM_E2000_FIP_ALL_HEADER_SIZE);
+    if (blk_pread(s->boot_blk, 0, PHYTIUM_E2000_FIP_ALL_HEADER_SIZE,
+                  contents, 0) < 0) {
+        error_setg(errp, "failed to read fip-all.bin metadata at %s "
+                   "offset 0", boot_medium);
+        return false;
+    }
+
+    if (!phytium_e2000_pbr_fip_extent(contents, backend_size, &extent,
+                                      &local_err)) {
+        error_prepend(&local_err, "invalid fip-all.bin at %s offset 0: ",
+                      boot_medium);
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    contents = g_realloc(contents, extent);
+    if (extent > PHYTIUM_E2000_FIP_ALL_HEADER_SIZE &&
+        blk_pread(s->boot_blk, PHYTIUM_E2000_FIP_ALL_HEADER_SIZE,
+                  extent - PHYTIUM_E2000_FIP_ALL_HEADER_SIZE,
+                  contents + PHYTIUM_E2000_FIP_ALL_HEADER_SIZE, 0) < 0) {
+        error_setg(errp, "failed to read fip-all.bin extent 0x%zx from %s "
+                   "offset 0", extent, boot_medium);
+        return false;
+    }
+
+    if (!phytium_e2000_pbr_tfa_fip_valid(contents, extent, &local_err)) {
+        error_prepend(&local_err, "invalid fip-all.bin at %s offset 0: ",
+                      boot_medium);
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    if (!phytium_e2000_pbr_parse_firmware(s, contents, extent, &local_err)) {
+        error_prepend(&local_err, "invalid fip-all.bin at %s offset 0: ",
+                      boot_medium);
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    return true;
+}
+
+static void phytium_e2000_pbr_seed_shared(PhytiumE2000PBRState *s)
+{
+    const PhytiumE2000TfaIoHandoff *tfa_io = &s->tfa_io;
+    uint8_t *sram = memory_region_get_ram_ptr(&s->boot_sram);
+    uint8_t *iacc = memory_region_get_ram_ptr(&s->iacc);
+    uint8_t parameter[PHYTIUM_E2000_PARAM_SLOT_SIZE];
+    hwaddr sram_base = PHYTIUM_E2000_PBR_BOOT_SRAM_BASE;
+    unsigned int i;
+
+    /*
+     * This graph is a firmware-private PBR-to-PBF handoff, not a device-tree
+     * description or a public E2000 register ABI.  It was reconstructed by
+     * tracing the early loads performed by the 2 GiB and 4 GiB Phytium Pi SDK
+     * PBFs and the COMe SDK PBF.  All three use the same boot-SRAM
+     * descriptors, SCP-SRAM parameter slots, and 0xf1801300 parameter copy.
+     *
+     * The addresses cannot be read from fip-all.bin as a documented table.
+     * They appear as constants in vendor PBF instructions.  Teaching the
+     * parser to recognize arbitrary compiler-generated AArch64 instruction
+     * sequences would be more fragile than recording the observed ROM ABI
+     * here.  Keep the graph together and heavily annotated so that a future
+     * firmware failure is treated as missing evidence, not "fixed" by an
+     * unexplained per-version address.
+     */
+    stq_le_p(sram + PHYTIUM_E2000_PBR_ROOT_OFFSET,
+             PHYTIUM_E2000_PBR_ROOT);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_ROOT - sram_base) + 0x10,
+             PHYTIUM_E2000_PBR_PARAM_NODE);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_NODE - sram_base) + 0x18,
+             PHYTIUM_E2000_PBR_PLL_DESC);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PLL_DESC - sram_base) + 0x08,
+             PHYTIUM_E2000_PBR_PLL_PAYLOAD);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_NODE - sram_base) + 0x20,
+             PHYTIUM_E2000_PBR_PCIE_DESC);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PCIE_DESC - sram_base) + 0x08,
+             PHYTIUM_E2000_PBR_PCIE_PAYLOAD);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_NODE - sram_base) + 0x28,
+             PHYTIUM_E2000_PBR_COMMON_DESC);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_COMMON_DESC - sram_base),
+             PHYTIUM_E2000_PBR_COMMON_PAYLOAD);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_COMMON_DESC - sram_base) + 0x08,
+             PHYTIUM_E2000_PBR_COMMON_PAYLOAD);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_NODE - sram_base) + 0x30,
+             PHYTIUM_E2000_PBR_MCU_DESC);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_MCU_DESC - sram_base),
+             PHYTIUM_E2000_PBR_MCU_PAYLOAD);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_MCU_DESC - sram_base) + 0x08,
+             PHYTIUM_E2000_PBR_MCU_PAYLOAD);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_NODE - sram_base) + 0x38,
+             PHYTIUM_E2000_PBR_PARAM_SLOT);
+    stq_le_p(sram + (PHYTIUM_E2000_PBR_PARAM_SLOT - sram_base) + 0x08,
+             PHYTIUM_E2000_PBR_PARAM_COPY);
+
+    /*
+     * Reproduce the result of TF-A register_io_dev_*() and dev_open():
+     *
+     *   *_dev_con       -> embedded io_dev_connector_t
+     *   *_dev_handle    -> initialized io_dev_info_t
+     *   fip_dev_info    = { &fip_dev_funcs, &fip_dev_state }
+     *
+     * The memmap driver owns a static io_dev_info_t in the PBF image, while
+     * the FIP driver creates its state in boot SRAM.  plat_io_policy[] points
+     * at the two *_dev_handle slots populated below.
+     */
+    stq_le_p(sram + (tfa_io->fip_connector_slot - sram_base),
+             tfa_io->fip_connector);
+    stq_le_p(sram + (tfa_io->fip_handle_slot - sram_base),
+             tfa_io->fip_dev_info);
+    stq_le_p(sram + (tfa_io->fip_dev_info - sram_base),
+             tfa_io->fip_funcs);
+    stq_le_p(sram + (tfa_io->fip_dev_info - sram_base) +
+             sizeof(uint64_t), tfa_io->fip_dev_state);
+    stq_le_p(sram + (tfa_io->fip_dev_state - sram_base), 0);
+    stq_le_p(sram + (tfa_io->memmap_connector_slot - sram_base),
+             tfa_io->memmap_connector);
+    stq_le_p(sram + (tfa_io->memmap_handle_slot - sram_base),
+             tfa_io->memmap_dev_info);
+
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBR_PARAM_COPY,
+                        MEMTXATTRS_UNSPECIFIED,
+                        iacc + PHYTIUM_E2000_PBF_PARAMETER_OFFSET,
+                        PHYTIUM_E2000_PBR_PARAM_COPY_SIZE);
+
+    /*
+     * PBF consumes each service parameter through the same public record
+     * header, while the payload remains service- and version-specific.  Copy
+     * every validated record without interpretation and clear the rest of
+     * its PBR-owned slot so that a shorter future format cannot expose stale
+     * reset data.
+     *
+     * This also stages PLL at 0x32a10c00.  Inspected PBFs follow the boot-SRAM
+     * PLL descriptor and require magic 0x54460020 there, just as they require
+     * the PCIe, COMMON, and DDR/MCU records in the following slots.
+     */
+    for (i = 0; i < PHYTIUM_E2000_PBF_PARAM_COUNT; i++) {
+        const PhytiumE2000PbfParameterSpec *spec =
+            &phytium_e2000_pbf_parameters[i];
+
+        memset(parameter, 0, sizeof(parameter));
+        memcpy(parameter, iacc + spec->source_offset,
+               s->parameter_sizes[i]);
+        address_space_write(&address_space_memory, spec->destination,
+                            MEMTXATTRS_UNSPECIFIED, parameter,
+                            spec->slot_size);
+    }
+}
+
+static void phytium_e2000_pbr_reset_enter(Object *obj, ResetType type)
+{
+    PhytiumE2000PBRState *s = PHYTIUM_E2000_PBR(obj);
+    int i;
+
+    (void)type;
+
+    /*
+     * Only architected handoff words have RegisterAccessInfo entries. The
+     * reserved holes stay zero-filled in the backing register array.
+     */
+    for (i = 0; i < ARRAY_SIZE(phytium_e2000_pbr_regs_info); i++) {
+        register_reset(&s->regs_info[
+            phytium_e2000_pbr_regs_info[i].addr / sizeof(uint32_t)]);
+    }
+    s->regs[R_BOOT_MEDIA] = s->boot_media;
+}
+
+static void phytium_e2000_pbr_reset_hold(Object *obj, ResetType type)
+{
+    PhytiumE2000PBRState *s = PHYTIUM_E2000_PBR(obj);
+    uint8_t *sram = memory_region_get_ram_ptr(&s->boot_sram);
+    uint8_t *iacc = memory_region_get_ram_ptr(&s->iacc);
+
+    (void)type;
+    memset(sram, 0, PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE);
+    memset(iacc, 0, PHYTIUM_E2000_PBR_IACC_SIZE);
+    memory_region_set_dirty(&s->boot_sram, 0,
+                            PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE);
+    memory_region_set_dirty(&s->iacc, 0, PHYTIUM_E2000_PBR_IACC_SIZE);
+
+    if (!s->firmware_loaded) {
+        return;
+    }
+
+    memcpy(iacc, s->iacc_image, s->iacc_image_size);
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE,
+                        MEMTXATTRS_UNSPECIFIED, s->bl1, s->bl1_size);
+    phytium_e2000_pbr_seed_shared(s);
+    phytium_e2000_mhu_seed_mailbox();
+}
+
+static void phytium_e2000_pbr_reset_exit(Object *obj, ResetType type)
+{
+    PhytiumE2000PBRState *s = PHYTIUM_E2000_PBR(obj);
+
+    (void)type;
+    if (!s->firmware_loaded) {
+        return;
+    }
+
+    g_assert(s->primary_cpu >= 0 && s->primary_cpu < s->num_cpus);
+    g_assert(s->cpus[s->primary_cpu]);
+    cpu_set_pc(s->cpus[s->primary_cpu],
+               PHYTIUM_E2000_PBR_BL1_RUNTIME_BASE);
+}
+
+void phytium_e2000_pbr_configure(PhytiumE2000PBRState *s,
+                                 BlockBackend *boot_blk,
+                                 hwaddr ram_base, uint64_t ram_size,
+                                 const uint64_t *cpu_mpidrs,
+                                 unsigned int num_cpus)
+{
+    g_assert(!DEVICE(s)->realized);
+    g_assert(num_cpus <= PHYTIUM_E2000_PBR_MAX_CPUS);
+
+    s->boot_blk = boot_blk;
+    s->ram_base = ram_base;
+    s->ram_size = ram_size;
+    s->num_cpus = num_cpus;
+    memcpy(s->cpu_mpidrs, cpu_mpidrs,
+           num_cpus * sizeof(s->cpu_mpidrs[0]));
+}
+
+bool phytium_e2000_pbr_firmware_loaded(PhytiumE2000PBRState *s)
+{
+    return s->firmware_loaded;
+}
+
+int phytium_e2000_pbr_primary_cpu(PhytiumE2000PBRState *s)
+{
+    g_assert(s->firmware_loaded);
+    return s->primary_cpu;
+}
+
+void phytium_e2000_pbr_connect_cpu(PhytiumE2000PBRState *s,
+                                   unsigned int index, CPUState *cpu)
+{
+    g_assert(index < s->num_cpus);
+    g_assert(cpu);
+    g_assert(!s->cpus[index]);
+    object_ref(OBJECT(cpu));
+    s->cpus[index] = cpu;
+}
+
+static void phytium_e2000_pbr_realize(DeviceState *dev, Error **errp)
+{
+    PhytiumE2000PBRState *s = PHYTIUM_E2000_PBR(dev);
+    bool loaded;
+
+    if (!s->boot_mode) {
+        error_setg(errp, "boot-mode was not configured");
+        return;
+    }
+    if (!strcmp(s->boot_mode, PHYTIUM_E2000_PBR_BOOT_MODE_QSPI)) {
+        s->boot_media = PHYTIUM_E2000_PBR_BOOT_MEDIA_QSPI;
+    } else if (!strcmp(s->boot_mode, PHYTIUM_E2000_PBR_BOOT_MODE_SD0)) {
+        s->boot_media = PHYTIUM_E2000_PBR_BOOT_MEDIA_SD0;
+    } else {
+        error_setg(errp, "invalid boot-mode '%s'; valid values are "
+                   "'qspi' and 'sd'", s->boot_mode);
+        return;
+    }
+    if (!s->num_cpus) {
+        error_setg(errp, "CPU topology was not configured");
+        return;
+    }
+    loaded = phytium_e2000_pbr_load_firmware(s, errp);
+    s->boot_blk = NULL;
+    if (!loaded) {
+        return;
+    }
+}
+
+static const Property phytium_e2000_pbr_properties[] = {
+    DEFINE_PROP_STRING("boot-mode", PhytiumE2000PBRState, boot_mode),
+};
+
+static void phytium_e2000_pbr_init(Object *obj)
+{
+    PhytiumE2000PBRState *s = PHYTIUM_E2000_PBR(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array = register_init_block32(
+        DEVICE(obj), phytium_e2000_pbr_regs_info,
+        ARRAY_SIZE(phytium_e2000_pbr_regs_info), s->regs_info, s->regs,
+        &phytium_e2000_pbr_ops, false, PHYTIUM_E2000_PBR_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &reg_array->mem);
+
+    memory_region_init_ram(&s->boot_sram, obj, "phytium-e2000.boot-sram",
+                           PHYTIUM_E2000_PBR_BOOT_SRAM_SIZE, &error_abort);
+    sysbus_init_mmio(sbd, &s->boot_sram);
+    memory_region_init_ram(&s->iacc, obj, "phytium-e2000.iacc",
+                           PHYTIUM_E2000_PBR_IACC_SIZE, &error_abort);
+    sysbus_init_mmio(sbd, &s->iacc);
+    s->primary_cpu = -1;
+}
+
+static void phytium_e2000_pbr_finalize(Object *obj)
+{
+    PhytiumE2000PBRState *s = PHYTIUM_E2000_PBR(obj);
+    unsigned int i;
+
+    for (i = 0; i < s->num_cpus; i++) {
+        if (s->cpus[i]) {
+            object_unref(OBJECT(s->cpus[i]));
+        }
+    }
+    g_free(s->iacc_image);
+    g_free(s->bl1);
+}
+
+/*
+ * boot_sram and iacc are RAMBlocks and migrate independently. The parsed
+ * image buffers remain immutable reset sources reconstructed from the boot
+ * backend while the destination machine is realized.
+ */
+static const VMStateDescription phytium_e2000_pbr_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_PBR,
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000PBRState,
+                             PHYTIUM_E2000_PBR_R_MAX),
+        VMSTATE_BOOL_V(firmware_loaded, PhytiumE2000PBRState, 2),
+        VMSTATE_INT32_V(primary_cpu, PhytiumE2000PBRState, 2),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_pbr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_pbr_vmsd;
+    dc->realize = phytium_e2000_pbr_realize;
+    device_class_set_props(dc, phytium_e2000_pbr_properties);
+    rc->phases.enter = phytium_e2000_pbr_reset_enter;
+    rc->phases.hold = phytium_e2000_pbr_reset_hold;
+    rc->phases.exit = phytium_e2000_pbr_reset_exit;
+}
+
+static const TypeInfo phytium_e2000_pbr_info = {
+    .name = TYPE_PHYTIUM_E2000_PBR,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000PBRState),
+    .instance_init = phytium_e2000_pbr_init,
+    .instance_finalize = phytium_e2000_pbr_finalize,
+    .class_init = phytium_e2000_pbr_class_init,
+};
+
+static void phytium_e2000_pbr_register_types(void)
+{
+    type_register_static(&phytium_e2000_pbr_info);
+}
+
+type_init(phytium_e2000_pbr_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 149ec8e797..8579004e88 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -18,6 +18,7 @@ system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mhu.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_pbr.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.53.0


