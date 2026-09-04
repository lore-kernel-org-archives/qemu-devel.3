Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C61C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJR-0004N7-Ub; Fri, 04 Sep 2026 11:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJQ-0004Ma-Cp; Fri, 04 Sep 2026 11:58:44 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJO-0004Pg-3c; Fri, 04 Sep 2026 11:58:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5H7sCzN53UdbGBD6BoiVBF8OQ84vNJ7Yig96M07Ac2p9rfVY9s2GXRqEsRtSf9eJFlMiBHAkKRELIWjQj+aNqTIWglQ31RH0X3ePDjDKXK3DDeBjJL20qqPlgzWxI3LD3gzcz3KWnxsJ2D29+FBjO5HmeUhDoctlTyORSqLL6CO0Gdm21i7Zjslxz8Cba8LudoixJD9W9eO4MMOZAdeBIdn6oNELEf+fhrE9w4G/7kV1+/cumPtdHYS2m+V/LfiQI2O1KOHYNH90mVqkyjzCwIk2Lcv8L5z2xvbtDSNXHrjrjtjIje7HVrBxGbquCUwz3hzHmDszlbh88vDhQsKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xuUviNuJ+2CtSIAjQO+vMl64TqmcpDViUkqcGG57f4=;
 b=fjZ23crywIeoJQXg1gdG8XpTNG8rDOsHroR8Tp5xQvZo01KpDJbRQrXzV1GmgBPUfEs8VoNfw8IE4ZPK0VVCxISgcUBH5J/pyLwBkvXAVJZtpkZbZWt9OJWBjEgadtuz38/GPodbVeUZAEZ7X9YziR+xoxC6L+dgjnaCTb5jRJ+WikCaG4VsFZlXLLRqDMdYi3fpY9iUBOKbg++pKkJM3Pi6/tardQxPB5/huH7mF1+7zdWeDzGHYrg4Omi7LtDEyo/Ce2p0gii5iTbCw9ToliXdM0gjUNEuXHiPRZHG5UtZTsFS1iXXpGdW+h6HNpq0rQYlYUgx7pyo6ZzJVZy1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xuUviNuJ+2CtSIAjQO+vMl64TqmcpDViUkqcGG57f4=;
 b=Ku5Fwabke2xjqLhyAqxVPBmdJIVHJ0Vby/CdHpc0UI4yVCyMTI/dJYM0PZkhMvLnPHRvafOVlMFpKXtKFTGzZIS1cC8SGTzmz17V2Pr9Fd7VCBcVJ+0D9mTSzvagZ9N6Zq4Sk8ge6OqSypF2/HIw6SPIA6NWBzgwW70oUltmUYWalOZDSQiT4t0iSrh385ZnfI5dEJbM4BN79FrCsWVCSFseHnA1F5kEJod5K+oqH9rnRdBgdO1Vyjg/hg+udBkR/zHzz1U2IseNk8Oh/YEVAbLSTrin9mXKzOkU+Frh9LzW61pMxVqGQ1J067o6u2aucW5GPyoNeStW63u0asBgyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:29 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 04/24] hw/misc: pfsoc: Model L2 cache controller registers
Date: Fri,  4 Sep 2026 23:57:23 +0800
Message-ID: <20260904155758.3833179-5-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc973c5-2742-4c2b-ae72-08df0a9d5cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vOyg7Tzof3PYbEH7ACy4qUWvF7ZFHYL9JYa283TcFd0H3R2/oKfJIjVNBJohUgivVuRe/FmLBG9Apyp1eoY24crNwm3HBK60cXQO5qq7IJYi/ib4hHJy2leqzAXKbVz96Wg2BIomh2DqjqfysFwg6Fm9rIyjKP5CqHtfoandxVU20rtftlkTtRbGBNjItMjLVzfEh6tV7BLajsLYjYEAOSynw3kO2Td9ouNJLU/VIGz8ShLx9mZTJp0TSFGd+dFGUYJG+26qq+92QNWR1+30VQkDVzqETb8VtA5k96RMcXhURP0W3SFWd9vXX/aLqlQo5pORxPWodLchTB+BlddmUInkNSI3dl3nwTvIZavIZxUQ1gVoMPO3xDwxFJNbyI4yXbaW0PcPJtdx95yn6GnsrcI8CkF1vN2FVqux0slzYY4XRrhufoQEieIb0/K8Q8BnsLZtpFaJ7QvNpcCg9AstdErAay6VDKY2KeRbgBdwcL3xMqGPx3w4V3pBbZbZXszlRhf1UGH+igIxFsKel6lw2+EkUCVVTWmONCC+zGMEGBqrGYvoGS+P0ZSFbLHOwEyNFuCjwynIzkpCmM+W9Ulxr+Bp9IIy26waFzbKby1pmZwdf7fmei6O9B5gNrZxIuq3w9LgXMUbhFxHdPYJo2EEG7xH1gyxiM0ZfNBbnthxrDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgZF3xAqrAnW1VVhn5ZVFOTP9Vu+ZZ89UNNhgMUCnorGVCMLp63ccWYpg1wN?=
 =?us-ascii?Q?N+tieZkeGOSU2gAGQF+lA/DV78stNu8X8GleyC3Lkqzskae23YmJS3on0OjH?=
 =?us-ascii?Q?pDBZy0J0COPbNC05BuORzHILrKSH3nr3hpm8+hdgcAcXNayVUg34z0kyTXTi?=
 =?us-ascii?Q?2XxcV3unWXks6muMiz4UrMVENRoKwIrtfTqBEb/b6s2p3aDjI0rfW/aWQa0U?=
 =?us-ascii?Q?4AP5OiIhwugn5UICJi0mKtrVyWS4evnSEUp3Rd5GQmb92AZJWFnOF7AT6jo+?=
 =?us-ascii?Q?oHepT0hteLxZVips9pDjwS21q162uu+CKLIEooYIcYwDfgMh42Yg65huQOP6?=
 =?us-ascii?Q?pCERQZWS2M+3/DgRtN3fcSKhu0VRKNFBMkEbETPBgp8oGoi/uv92Za3wjLL4?=
 =?us-ascii?Q?km6taVNg+RhPEEssu7yGmSNCl3LJsnAN8/N64Y+6tZifYhddqmZX+CHXGMqt?=
 =?us-ascii?Q?DWj7blGIp5nHwA1klvp6lHqnNb52+SI2dTicOBjBTGdwZsKSK0u73bl2zflV?=
 =?us-ascii?Q?8Jq0gi6aw8DcP5N94x2sB/Ofc1uO9JXKIp0QcwNZjlECn+M6z5KagWRGT+5T?=
 =?us-ascii?Q?7yba92tVD3uyCxVclaK6kbGjtD7AKh2B+NdUL5VgRC0dpa5axOJyRv8QzHmE?=
 =?us-ascii?Q?QodfN2jiS4AZCGFF2vECUhD0C14LHvC5XPNr//LAZszuJFRrjeKm8yCNJSxW?=
 =?us-ascii?Q?1niha4/kVwRZhmQyXovyo3cP7AvfBddCRFvlnQSRZvNMyXkoL99Q321/+ySl?=
 =?us-ascii?Q?FdYfjvc+aWYQjtYjMTPv2+e/xs7m2RV9TjT/e9srTmaY0wbjnp4g4pnJuACL?=
 =?us-ascii?Q?swgQbkSGsk+1hf7r3iWNP6YxRbewzRkrqmtrV3i0CiLue/rRN8xmm6WvoX8h?=
 =?us-ascii?Q?mn0n3zYYLcNtrn7zg4OLk8QfgTFnCeBibI7FSwwTgeFfba43z5syDTv1wFrR?=
 =?us-ascii?Q?M2K92EJTRuALvVquV9b4i+Ug9LN3rnaQ2NhfpNmrZJ0BaxZgmtl/XZnGUm7L?=
 =?us-ascii?Q?iC/DMbx8l7hanMqcpNWS26qCI2VfdzZ+bry+EORdg1cQWY+iwhvEl3/O/oZ0?=
 =?us-ascii?Q?usvFbQkgoxOrn0u95TS9aRsNlA/cqWC8mTwLeUUs0pA6u2tV9N9ZyoqmowBi?=
 =?us-ascii?Q?6FF9Kw6gbB7VAEIEPlgOS9U73ajUnCkGvDKnYT1a5Py5UnQ117pzq4dxUI8U?=
 =?us-ascii?Q?6ctfTCjTaFCcYpWG0YbD5GpJSoAKXfgxvHZCzwDNHyr5VNvaTOs/OaDCJtSF?=
 =?us-ascii?Q?MHYbfq/8v2HUrP4M9VtkmuvdKqgehV/GbQtinvxe2VJhJSMwUCD0g0v7Z+6u?=
 =?us-ascii?Q?2orIMiR7W3m1vg24ubZ5eCSEY3sEuwNiMYORVYhmqYJixt1nPCn4YVbuNMeo?=
 =?us-ascii?Q?rb7jcDvGLhGSkonbedRWLaROXvPENh1V1CqFfJOXEfVYLTuFM0faGXAvPmiT?=
 =?us-ascii?Q?XBm6R54ZbWtwkklPnrtkg9hIBNY6My1m/diPuM4Wra3e6lh/H5yC6A00h3RY?=
 =?us-ascii?Q?sDcgbGKlEFS62bbHuCy8qDwzx9q2YEXZAoOpX2WGwCpKBb9By0NPSbYsZGxc?=
 =?us-ascii?Q?5450FhKUv3Z1y0Q1RVU8oedxmEWe4qS3tllQmVQw3eXDGh80UE0zZe5IAVom?=
 =?us-ascii?Q?8J8A57pe5Ro7zfCPZL2zMBOuOQUG2ftmkgbN2H4wRon3YkduIBXuCFjTEk0P?=
 =?us-ascii?Q?XQ1UsBdmJHY6E//KoVjdfPvY8yYTqIJYC5x6p90l2CPYfUEsfU7NmGanYMCE?=
 =?us-ascii?Q?IxjgK7ymCcc/PybSuCB5/bOdLueWV88=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc973c5-2742-4c2b-ae72-08df0a9d5cb0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:29.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjUQIdCvgsBf0/r2uJsO/8JQcmHuFFR6PZZMth2pPUjbon5IEDi+Mbnl9YpsJV9lVD7Xuz1p1kKPQC6R1LuCpUwNUSldS7mFzXwdmc5L/B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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

Implement the Config, WayEnable, and per-master WayMask registers
described by the PolarFire SoC MSS reference manual. Make WayEnable
monotonic and report the remaining register space as unimplemented.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v2:
- Use the Resettable API instead of a legacy reset handler

 MAINTAINERS                       |   2 +
 include/hw/misc/mchp_pfsoc_l2cc.h |  30 +++++
 hw/misc/mchp_pfsoc_l2cc.c         | 180 ++++++++++++++++++++++++++++++
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 5 files changed, 216 insertions(+)
 create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
 create mode 100644 hw/misc/mchp_pfsoc_l2cc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f524d90523..d7615b2c2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1795,11 +1795,13 @@ F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
 F: hw/misc/mchp_pfsoc_dmc.c
 F: hw/misc/mchp_pfsoc_ioscb.c
+F: hw/misc/mchp_pfsoc_l2cc.c
 F: hw/misc/mchp_pfsoc_sysreg.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
 F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
+F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 
 Shakti C class SoC
diff --git a/include/hw/misc/mchp_pfsoc_l2cc.h b/include/hw/misc/mchp_pfsoc_l2cc.h
new file mode 100644
index 0000000000..1b5b3888d5
--- /dev/null
+++ b/include/hw/misc/mchp_pfsoc_l2cc.h
@@ -0,0 +1,30 @@
+/*
+ * Microchip PolarFire SoC L2 cache controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef MCHP_PFSOC_L2CC_H
+#define MCHP_PFSOC_L2CC_H
+
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+
+#define MCHP_PFSOC_L2CC_REG_SIZE 0x1000
+#define MCHP_PFSOC_L2CC_REG_NUM  (MCHP_PFSOC_L2CC_REG_SIZE / 8)
+
+typedef struct MchpPfSoCL2ccState {
+    SysBusDevice parent;
+    uint64_t regs[MCHP_PFSOC_L2CC_REG_NUM];
+    RegisterInfo regs_info[MCHP_PFSOC_L2CC_REG_NUM];
+} MchpPfSoCL2ccState;
+
+#define TYPE_MCHP_PFSOC_L2CC "mchp.pfsoc.l2cc"
+OBJECT_DECLARE_SIMPLE_TYPE(MchpPfSoCL2ccState, MCHP_PFSOC_L2CC)
+
+#endif
diff --git a/hw/misc/mchp_pfsoc_l2cc.c b/hw/misc/mchp_pfsoc_l2cc.c
new file mode 100644
index 0000000000..979d904676
--- /dev/null
+++ b/hw/misc/mchp_pfsoc_l2cc.c
@@ -0,0 +1,180 @@
+/*
+ * Microchip PolarFire SoC L2 cache controller
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
+#include "qemu/log.h"
+#include "hw/core/register.h"
+#include "hw/core/registerfields.h"
+#include "hw/misc/mchp_pfsoc_l2cc.h"
+
+REG64(L2_CONFIG, 0x000)
+    FIELD(L2_CONFIG, BANKS, 0, 8)
+    FIELD(L2_CONFIG, WAYS, 8, 8)
+    FIELD(L2_CONFIG, SETS, 16, 8)
+    FIELD(L2_CONFIG, BYTES, 24, 8)
+REG64(L2_WAY_ENABLE, 0x008)
+    FIELD(L2_WAY_ENABLE, VALUE, 0, 8)
+REG64(L2_WAY_MASK_DMA, 0x800)
+REG64(L2_WAY_MASK_AXI4_PORT_0, 0x808)
+REG64(L2_WAY_MASK_AXI4_PORT_1, 0x810)
+REG64(L2_WAY_MASK_AXI4_PORT_2, 0x818)
+REG64(L2_WAY_MASK_AXI4_PORT_3, 0x820)
+REG64(L2_WAY_MASK_HART0_DCACHE, 0x828)
+REG64(L2_WAY_MASK_HART0_ICACHE, 0x830)
+REG64(L2_WAY_MASK_HART1_DCACHE, 0x838)
+REG64(L2_WAY_MASK_HART1_ICACHE, 0x840)
+REG64(L2_WAY_MASK_HART2_DCACHE, 0x848)
+REG64(L2_WAY_MASK_HART2_ICACHE, 0x850)
+REG64(L2_WAY_MASK_HART3_DCACHE, 0x858)
+REG64(L2_WAY_MASK_HART3_ICACHE, 0x860)
+REG64(L2_WAY_MASK_HART4_DCACHE, 0x868)
+REG64(L2_WAY_MASK_HART4_ICACHE, 0x870)
+
+#define L2_CONFIG_RESET         0x06091004
+
+static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
+                                                     uint64_t value)
+{
+    uint64_t current = *(uint64_t *)reg->data;
+
+    return MAX(current, value);
+}
+
+#define WAY_MASK_REGISTER(_name)                \
+    {                                           \
+        .name = "WAY_MASK_" #_name,             \
+        .addr = A_L2_WAY_MASK_ ## _name,        \
+        .reset = UINT64_MAX,                    \
+    }
+
+static const RegisterAccessInfo mchp_pfsoc_l2cc_regs_info[] = {
+    {
+        .name = "CONFIG",
+        .addr = A_L2_CONFIG,
+        .reset = L2_CONFIG_RESET,
+        .ro = UINT64_MAX,
+    }, {
+        .name = "WAY_ENABLE",
+        .addr = A_L2_WAY_ENABLE,
+        .rsvd = ~R_L2_WAY_ENABLE_VALUE_MASK,
+        .pre_write = mchp_pfsoc_l2cc_way_enable_pre_write,
+    },
+    WAY_MASK_REGISTER(DMA),
+    WAY_MASK_REGISTER(AXI4_PORT_0),
+    WAY_MASK_REGISTER(AXI4_PORT_1),
+    WAY_MASK_REGISTER(AXI4_PORT_2),
+    WAY_MASK_REGISTER(AXI4_PORT_3),
+    WAY_MASK_REGISTER(HART0_DCACHE),
+    WAY_MASK_REGISTER(HART0_ICACHE),
+    WAY_MASK_REGISTER(HART1_DCACHE),
+    WAY_MASK_REGISTER(HART1_ICACHE),
+    WAY_MASK_REGISTER(HART2_DCACHE),
+    WAY_MASK_REGISTER(HART2_ICACHE),
+    WAY_MASK_REGISTER(HART3_DCACHE),
+    WAY_MASK_REGISTER(HART3_ICACHE),
+    WAY_MASK_REGISTER(HART4_DCACHE),
+    WAY_MASK_REGISTER(HART4_ICACHE),
+};
+
+static bool mchp_pfsoc_l2cc_register_implemented(hwaddr offset)
+{
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(mchp_pfsoc_l2cc_regs_info); i++) {
+        if (mchp_pfsoc_l2cc_regs_info[i].addr == offset) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static uint64_t mchp_pfsoc_l2cc_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    if (mchp_pfsoc_l2cc_register_implemented(offset)) {
+        return register_read_memory(opaque, offset, size);
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                  "(size %u, offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, offset);
+    return 0;
+}
+
+static void mchp_pfsoc_l2cc_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    if (mchp_pfsoc_l2cc_register_implemented(offset)) {
+        register_write_memory(opaque, offset, value, size);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                  "(size %u, value 0x%" PRIx64
+                  ", offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, value, offset);
+}
+
+static const MemoryRegionOps mchp_pfsoc_l2cc_ops = {
+    .read = mchp_pfsoc_l2cc_read,
+    .write = mchp_pfsoc_l2cc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 1, .max_access_size = 8 },
+    .impl = { .min_access_size = 1, .max_access_size = 8 },
+};
+
+static void mchp_pfsoc_l2cc_reset_hold(Object *obj, ResetType type)
+{
+    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(obj);
+    size_t i;
+
+    memset(s->regs, 0, sizeof(s->regs));
+    for (i = 0; i < ARRAY_SIZE(mchp_pfsoc_l2cc_regs_info); i++) {
+        hwaddr addr = mchp_pfsoc_l2cc_regs_info[i].addr;
+
+        register_reset(&s->regs_info[addr / sizeof(uint64_t)]);
+    }
+}
+
+static void mchp_pfsoc_l2cc_init(Object *obj)
+{
+    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array = register_init_block64(
+        DEVICE(obj), mchp_pfsoc_l2cc_regs_info,
+        ARRAY_SIZE(mchp_pfsoc_l2cc_regs_info), s->regs_info, s->regs,
+        &mchp_pfsoc_l2cc_ops, false, MCHP_PFSOC_L2CC_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static void mchp_pfsoc_l2cc_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = mchp_pfsoc_l2cc_reset_hold;
+}
+
+static const TypeInfo mchp_pfsoc_l2cc_info = {
+    .name = TYPE_MCHP_PFSOC_L2CC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCL2ccState),
+    .instance_init = mchp_pfsoc_l2cc_init,
+    .class_init = mchp_pfsoc_l2cc_class_init,
+};
+
+static void mchp_pfsoc_l2cc_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_l2cc_info);
+}
+
+type_init(mchp_pfsoc_l2cc_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..d78880d5b3 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -203,6 +203,9 @@ config MCHP_PFSOC_DMC
 config MCHP_PFSOC_IOSCB
     bool
 
+config MCHP_PFSOC_L2CC
+    bool
+
 config MCHP_PFSOC_SYSREG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 54e07aacda..3eeb204f56 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -32,6 +32,7 @@ system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
 system_ss.add(when: 'CONFIG_K230', if_true: files('k230_ddr.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
+system_ss.add(when: 'CONFIG_MCHP_PFSOC_L2CC', if_true: files('mchp_pfsoc_l2cc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
-- 
2.53.0


