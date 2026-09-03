Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E17C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aL-0005bB-0R; Thu, 03 Sep 2026 07:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aJ-0005aa-UT; Thu, 03 Sep 2026 07:26:23 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aH-0006gK-MT; Thu, 03 Sep 2026 07:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK8WYhgVUVNFd2JOACJak05mPhhYqKZol8gv5RKxrCBmASiteIHpX9LmcEhdlO2UbXB+nCNTU7eBSmx0xIJSxzVuLNFjIMD9LH+0NNjZwYw09fXLCzmHQDnVBWdV/bkDIv9Z9Qg4AdNqdamXDb9f5VktxHammGMCpbxL3hGeDIGarC/fgakhGvxl/2EmQCxt5XKjY8sgnHrxeH8H8lNKkfpjMaMGdRdzesLbUW+gtWXz1Pc4f9e2N8Z9KiKcTK7taRSwqCac7rF68vQJ9uM4SixMjAxjVkQ3wyxB8CITJgg72JXLeaGb/5Y0FuG06EKHranSHvBYAV3o+xWuzbtJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bwt5xuT8uavNLv9mvjSW+ertxOy/H7bnmDCr4wucNg=;
 b=uzlIexzuJS5QYKBT/KM75pg3JOupig2wqXcm6YMbozjWeXLWAChZKvpEBRIQu8WBIAm6Cr7AdWNpP2bUjAIr8hZi6yBbulghkMPkjQ67fceUbw5dRESb+LbyN/AMJ0is+WWwqYyE6uG/jT17/hvMTW99vXKpkUpICFSSuKRgQYX+d23MLbBX18KNvx0EO9QimhNy4CwVK2wnBUl706m2UlUIYJQWuQkPlkdUX5MFJZaJ9KdftrPpo/rYxLSOgq6qsZ9KsdSwqr/fr+vxAecHdh/Sm+Xd5Hci7dF6OoRonNRh77z0IOFPT8gjfHXiUrFbtwJUevy0TRMgilMf6UXROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bwt5xuT8uavNLv9mvjSW+ertxOy/H7bnmDCr4wucNg=;
 b=ndD3b1feUBCN/vBR8yyXrMU+VlJ9qe0pxLAm80FcsyGFsRb14MQ4Kc3GpZael5zZw+WB70Jywrex1LHfpHdm/B7ffVhsLJZcY5hRBM3TRxPUCHv/qBhfgA7CHQSccM7KZPX/yoqihHHdjwhbjnA8nMF1Z1vjLsdl4upaWyOB5gswHKiI2m/CYYMxdcdhBUY57zEFRSWi7yxcj1RZcgOYkpy2W1OHBKbzRxqgJdiKUQPndJENqCMCdHlFZb3dbmMyqWcvdhVaaP5UjKspoN+7uATd1T6fa8tlwjw6cPseE7rOEn/uxIuGTbD2vdzbmYIlziohJz9dYxrhEXkFNcOnrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:09 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:09 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/33] hw/misc: Add Phytium E2000 DDR status
Date: Thu,  3 Sep 2026 19:24:49 +0800
Message-ID: <20260903112532.3276678-10-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 436745a2-8d39-48f7-a1b2-08df09ae2716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8sYhFw/MbrThknwhZ7xh3BqP2aNYpbLa83H2y/Tg9aVBFlqwgwR4Ts1ULZLndfSNb9HTF/RcHMWgyyHMIM4OzWqWT6VoSCzeJ3nc3ry19Tw+F+/5G24bm2lubANVe8TJNLsSZzI+KYY1fVqQcjbc2W6GG4Fr2q7IVFfuCU/WCyYjEpswAq/OiU8NrlxsyiPvosRXkQubh2kB0Shn9bp23TT8I4pe5Z1N8FtR1TWHu+Bk8sgzkHUtTAivsTRFgD3Ie+PqgEVhlMUhYiVjanAXbOjcwDPn427VfOkHwm1XVQpNRhn8XX5OZmkVKAtvZHxr7j1hoe0RnRDyq61FKjpvZGSajuWMiyc0Xbc/r3IDjD2hdCbzzRqwMxyRf1P1tOhB3Z1oAou8l3qwASTF2rrywCKn0ezpL+mRtPaUrJXBW/UePLVTr0Um6ik/nxvI7F2bra7kMjBNI2vq4lXPJ7Nab3WJeeb1+ZVvato08IIZqd1x4QBQEPSHDCJBoIhYUXKY/dzJkMIgBAMoCz6JJTlUg13BEJjRZWOO+KACHIsf6XD+tqG+75EMgOeBxoFBA3Za5+hcj/xleUonz8xKySvGtsYIU2xqlulG9cRIu6ICUfCvvZMYpEi+sAMIX3fiHu2zG8kWYUwpjeRZ7c706qPIRlRwocoBAi6o+OmlIIQkgEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dK+mYCYl+gM54XM52jG3DQKOfUbKakT9ukKMvbnRCOgV6tgDRLHebkt9zqMi?=
 =?us-ascii?Q?MvdcB0xt1s8Fwx9i6u3ioYBLGNrkBVY/KhrFQK0bjP5iRgqEglN26nQSw67q?=
 =?us-ascii?Q?ugP5rJYkJJzol9civBTQecjhfnJ5pZpvvluZqBUrb0uoJWwPEfDyzWwtxWtE?=
 =?us-ascii?Q?eG2GVmv/NlvjUdNt7xlge5KI5sabUtmNZeZ3V3bFM3s8y8+VSOHiKfraqFPi?=
 =?us-ascii?Q?53JO6/MM+CBaC/kLKkaFuahWqqSSQ9L9c4k3MoszSW7uv0ByqsHi1R8tiseu?=
 =?us-ascii?Q?jGpARcuowannSXQylgDnM1IFMBo187VzYKIy8NDk/ZpWFd94djbaC3C/+1Sv?=
 =?us-ascii?Q?cceG45x5w0evXfHmaamZc+1oVWVn+xqlZ5qLm2/5BTsJtgOZzKlWSTBRaO+f?=
 =?us-ascii?Q?+MC4AwW3bZDXl5qCt5lwkBQkD3zf74YL2uBGmKL1IsQpiq3xKCobwLHl3BdY?=
 =?us-ascii?Q?+GS3afJz9kVUdyQ6HKYSvA5fGdtqUETLvS7eHhNzz6UP5jRHzn+YYnDaPQF3?=
 =?us-ascii?Q?irrXWa2tKEqPMEplggTD/WeIaNbFwBi43Bg3cKmjW6qzG+9dsB+pb5Lmmxn+?=
 =?us-ascii?Q?G2ygxJOc39OMiXOZ3gmJaqdJ2wt+VPbbBuKSdboryEPcqrRwyAuL0GAZiPEt?=
 =?us-ascii?Q?fepdsuxEnJUbdUErJMqi5Uj6Zss7K3s0WsKkvjPyupKY2L2y8mLl/ne3eFqR?=
 =?us-ascii?Q?4QhLM8gtQh3wu8s72W53rBGa66Vh6ffAEZIuq8YyGUXPVlYBMBN7VkaXVRSD?=
 =?us-ascii?Q?JHZY91NL9VjT9SbxSq74GrcS4u+UT/H0tmDPdit2lVpcJchC36UrM4dfC/2j?=
 =?us-ascii?Q?zlf9tU2tPrzaSJw5k+GOk/3ubvT7wWSqQCHbCYCWQok+MQzQZ0shiJjIxFDu?=
 =?us-ascii?Q?tSAXHYt3WHo53UHlUDFhbtxxNyJ1mDLHAjyVFls4y1PDdQwOnGR2z8PiRrVw?=
 =?us-ascii?Q?cTiM2ZXe9h76xivTv58AXmxxiXQJqygDWqMf2VyA3Hj1mTs3Qq0bMvwcLk5O?=
 =?us-ascii?Q?bEKxH1kXdclOsLCHkrSZM9csGxEo25J/X/Q4d4AcqVONMwUmNIb2RuboXLAt?=
 =?us-ascii?Q?OzK93sUarJl4zhi1kyMnPoSZIGwir6d/TWsSCbScqjPLa6Yv8294rqPEAJIo?=
 =?us-ascii?Q?J9EYceodwaWBZzj1uk9jM3v5aHuNg8/fTUS79Kof/G8+vOxpJSeOJ1tJEoNb?=
 =?us-ascii?Q?vc9W3mK4OlDgurf8dn5H6wriozLrCPlWsBe2l8OWJ/VTirhvQ5KiRIfTjkrd?=
 =?us-ascii?Q?89hSALbURZL/ZJJA1kvniKLSqU3ZppRHiU2Xp2eqdUmZnxSOO5eASeS7CvpT?=
 =?us-ascii?Q?jXomluK5XQSIzgeR5q3hbv7H4TeCSvjJssiVH9BZy6LIIOuwioiKnpPIdxmt?=
 =?us-ascii?Q?ZE9kW7xcvC+HmjkH6KfmRTyFumg97l2vJ7eoUlCLPz4uPKb9AyJ79qjycI48?=
 =?us-ascii?Q?kyl7vpPdJO12ovHnKIQmUn+paA19HRIHn2v0hE+J5/0c1ZhHCxLMI+kw5LXn?=
 =?us-ascii?Q?QLHbiHC/KqBxDMR+6YH+Fl67DA9aMYLzUeVxRM9JwHWu4zvaGB1B8NpA2x4b?=
 =?us-ascii?Q?7tI1wkLd5Ax8ei/qtp7wGp1JKh8j95zdLOuaP6sea0ToV5c+tvMRKyMEwe2t?=
 =?us-ascii?Q?dux7tyoRmw2Woqmp3LtSTISFmlJAUXKzURvEKbZxoo+3AqOVfFYasqEp5BWD?=
 =?us-ascii?Q?FM3op87K0WkME3+g1athcyynWOa+KccrxFi8k/FfErI+k7jI2CXCYJNt1DIg?=
 =?us-ascii?Q?CB1uj5l4upG2UY4vXSquqjXDOQ/uIPI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436745a2-8d39-48f7-a1b2-08df09ae2716
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:09.5978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUb/h7ykS8N+vyZyLSKZdZpQZ2WEw/E7olFjDBL3yGJnaMehQjxxGUNv5MAnRQ/D/0SU/z/KEw3kC7/tSUEobu18nNbTG9JliyBnHtpRvfY=
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

Move the E2000 DDR initialization and training compatibility window into
a first-class registerinfo device. Keep ordinary aligned registers as
persistent storage and implement the indirect selector/value interface
used by the vendor PBF.

Return the expected initialization, PHY training, update, and BIST
results, including the training-error range. This models the firmware
contract without attempting a timing-accurate DDR PHY.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/misc/meson.build                 |   1 +
 hw/misc/phytium_e2000_ddr.c         | 197 ++++++++++++++++++++++++++++
 include/hw/misc/phytium_e2000_ddr.h |  23 ++++
 3 files changed, 221 insertions(+)
 create mode 100644 hw/misc/phytium_e2000_ddr.c
 create mode 100644 include/hw/misc/phytium_e2000_ddr.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 54e07aacda..898cf6ea87 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -16,6 +16,7 @@ system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
 system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
diff --git a/hw/misc/phytium_e2000_ddr.c b/hw/misc/phytium_e2000_ddr.c
new file mode 100644
index 0000000000..ab46a46961
--- /dev/null
+++ b/hw/misc/phytium_e2000_ddr.c
@@ -0,0 +1,197 @@
+/*
+ * Phytium E2000 DDR training status
+ *
+ * The vendor firmware accesses controller and PHY state through an indexed
+ * selector/value window. This functional model reproduces the completion and
+ * error predicates used during boot; it does not simulate analog DDR training
+ * or generate physical calibration results.
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
+#include "hw/misc/phytium_e2000_ddr.h"
+
+#include "hw/core/register.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+REG32(SELECTOR, 0x80)
+REG32(VALUE, 0x84)
+
+#define PHYTIUM_E2000_DDR_R_MAX                  \
+    (PHYTIUM_E2000_DDR_MMIO_SIZE / sizeof(uint32_t))
+/*
+ * Selectors encode a register index as a byte offset. PBF uses separate
+ * direct, indirect, and training banks distinguished by 0x800 and 0x1000
+ * index biases.
+ */
+#define PHYTIUM_E2000_DDR_SELECTOR(reg)          ((reg) * 4)
+#define PHYTIUM_E2000_DDR_INDIRECT_SELECTOR(reg) (((reg) + 0x800) * 4)
+#define PHYTIUM_E2000_DDR_TRAINING_SELECTOR(reg) (((reg) + 0x1000) * 4)
+#define PHYTIUM_E2000_DDR_TRAINING_ERR_FIRST     0xc72
+#define PHYTIUM_E2000_DDR_TRAINING_ERR_LAST      0xc79
+
+struct PhytiumE2000DDRState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_DDR_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_DDR_R_MAX];
+    RegisterAccessInfo regs_access_info[PHYTIUM_E2000_DDR_R_MAX];
+};
+
+static uint64_t phytium_e2000_ddr_value_post_read(RegisterInfo *reg,
+                                                  uint64_t value)
+{
+    PhytiumE2000DDRState *s = PHYTIUM_E2000_DDR(reg->opaque);
+    uint32_t selector = s->regs[R_SELECTOR];
+
+    /*
+     * These fixed selectors are controller/PHY polls observed in the tested
+     * firmware. Return only the ready and completion bits that its loops
+     * require, without assigning behavior to the surrounding register bank.
+     */
+    switch (selector) {
+    case PHYTIUM_E2000_DDR_INDIRECT_SELECTOR(0xdc):
+        return BIT(0);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x256):
+        return BIT(0) | BIT(25);
+    case PHYTIUM_E2000_DDR_INDIRECT_SELECTOR(0x76):
+        return BIT(0) | BIT(14) | BIT(27);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x10f):
+        return 0x40U << 24;
+    case PHYTIUM_E2000_DDR_SELECTOR(0x229):
+        return BIT(0);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x257):
+        return BIT(3);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x255):
+        return BIT(16);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x1d5):
+        return BIT(16) | BIT(24) | BIT(25);
+    default:
+        /*
+         * The training bank is read repeatedly for lane state and error
+         * summaries. Error selectors report no failure; the remaining values
+         * are deterministic so repeated sweeps see stable lane data.
+         */
+        if (selector >= PHYTIUM_E2000_DDR_TRAINING_SELECTOR(0) &&
+            selector < PHYTIUM_E2000_DDR_TRAINING_SELECTOR(0x1000)) {
+            uint32_t index = selector / sizeof(uint32_t) - 0x1000;
+
+            if (index >= PHYTIUM_E2000_DDR_TRAINING_ERR_FIRST &&
+                index <= PHYTIUM_E2000_DDR_TRAINING_ERR_LAST) {
+                return 0;
+            }
+            /*
+             * Preserve the masks and flag combinations checked by the PBF
+             * training algorithm for these recurring low-byte selectors.
+             */
+            if ((index & 0xff) == 0x34) {
+                return 0x00000fff;
+            }
+            if ((index & 0xff) == 0x38) {
+                return BIT(4) | BIT(5);
+            }
+            if ((index & 0xff) == 0x83) {
+                return 0;
+            }
+            if ((index & 0xff) == 0x3b) {
+                return 0x01234567U | BIT(26) | BIT(27);
+            }
+            return 0x01234567U;
+        }
+        /*
+         * Unclassified offsets retain ordinary register storage. This keeps
+         * setup writes readable without pretending they affect DDR timing.
+         */
+        return value;
+    }
+}
+
+static const MemoryRegionOps phytium_e2000_ddr_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void phytium_e2000_ddr_reset(DeviceState *dev)
+{
+    PhytiumE2000DDRState *s = PHYTIUM_E2000_DDR(dev);
+    int i;
+
+    for (i = 0; i < PHYTIUM_E2000_DDR_R_MAX; i++) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static void phytium_e2000_ddr_init(Object *obj)
+{
+    PhytiumE2000DDRState *s = PHYTIUM_E2000_DDR(obj);
+    RegisterInfoArray *reg_array;
+    int i;
+
+    /*
+     * Firmware may touch any word in this compact window before selecting a
+     * status source, so create registerinfo metadata for the full aperture and
+     * specialize only SELECTOR and VALUE.
+     */
+    for (i = 0; i < PHYTIUM_E2000_DDR_R_MAX; i++) {
+        s->regs_access_info[i].name = "DDR_STATUS";
+        s->regs_access_info[i].addr = i * sizeof(uint32_t);
+    }
+    s->regs_access_info[R_SELECTOR].name = "SELECTOR";
+    s->regs_access_info[R_VALUE].name = "VALUE";
+    s->regs_access_info[R_VALUE].ro = UINT32_MAX;
+    s->regs_access_info[R_VALUE].post_read =
+        phytium_e2000_ddr_value_post_read;
+
+    reg_array = register_init_block32(
+        DEVICE(obj), s->regs_access_info, PHYTIUM_E2000_DDR_R_MAX,
+        s->regs_info, s->regs, &phytium_e2000_ddr_ops, false,
+        PHYTIUM_E2000_DDR_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static const VMStateDescription phytium_e2000_ddr_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_DDR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000DDRState,
+                             PHYTIUM_E2000_DDR_R_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_ddr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_ddr_vmsd;
+    device_class_set_legacy_reset(dc, phytium_e2000_ddr_reset);
+}
+
+static const TypeInfo phytium_e2000_ddr_info = {
+    .name = TYPE_PHYTIUM_E2000_DDR,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000DDRState),
+    .instance_init = phytium_e2000_ddr_init,
+    .class_init = phytium_e2000_ddr_class_init,
+};
+
+static void phytium_e2000_ddr_register_types(void)
+{
+    type_register_static(&phytium_e2000_ddr_info);
+}
+
+type_init(phytium_e2000_ddr_register_types)
diff --git a/include/hw/misc/phytium_e2000_ddr.h b/include/hw/misc/phytium_e2000_ddr.h
new file mode 100644
index 0000000000..91dc661106
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_ddr.h
@@ -0,0 +1,23 @@
+/*
+ * Phytium E2000 DDR training status
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_DDR_H
+#define HW_MISC_PHYTIUM_E2000_DDR_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_DDR "phytium-e2000-ddr"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000DDRState, PHYTIUM_E2000_DDR)
+
+#define PHYTIUM_E2000_DDR_MMIO_SIZE 0x400
+
+#endif
-- 
2.53.0


