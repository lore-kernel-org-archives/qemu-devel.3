Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8ACC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCu-00044L-Ma; Thu, 23 Jul 2026 11:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCt-00043b-Qv; Thu, 23 Jul 2026 11:19:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCr-00081v-44; Thu, 23 Jul 2026 11:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loeyDrWHT+cw5cZCZqn4y4aL2kSvD2zYF16jHAuQoSuv94NwELI4RDx8rWMHlQ4KXHKzG+SOUG9L0W6KA1db0AmkfVNWrIzJCM8G2ukmGUIPeJh9qY79wqcLK/QRRo+GP5vkYoLWG7yPhrls4m3MAT6zD9M71ELuC7unX+0/Bl/5kAKpI7MZH/lXYgVe/oACVjYUwaCmN5VI+ZE0C1ApWH1t7BxTHvZWSe5bnFmMDb0lEV1hL1749zMM6s0qOZWMepaY98S6S2sNtZ7GDj7ueMuZ9xEa9lB1Ev/Rw8WgKpykTCC9qeZkySYW5HUNYwiyzLicuSNRmesy46PmReeb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wYrVDiK0b+IKPefObTgD4xoi35IUbw4JoICN7zd96s=;
 b=v9BrAJxAEf7U1JoNME+1qN5YjKXhV7tPHP83f4O4+WsEK7UtvuxTiPmNOxL2bl4yR4sUUdeeQqNmK5xZsL1CJBkqLfFGiDu0bLvVkqNXqWcic3qE+nO1v8JD5Su0zAFU9z6J3s6/f9R+sfnJww1mWyKPzEi/EzvkngIS1QH2+dN/x2dcrDy4QcXYSYtRQzTtv1B79nuBA5+NdS2XMirzG8+WjeGK5bZF58dZO186BNHHi3DZbQyN0UbjrA0zpx/I2JvD85mI2AWQGatgvDF4kffCstrNXncjDaDTfXQElN8iuRnEip9pxg2uS0JDDsrx22/zJtAiGXf7mTGBQCJs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wYrVDiK0b+IKPefObTgD4xoi35IUbw4JoICN7zd96s=;
 b=jmaDugTM6QwWuhAiT2DiMMehzjHuxEHuC7kD7JAhUVG75ltwapxicT8KY3nLbpSBPlGo7BRNdWuG9z0ZnPkaCziP5ZKeMc2B9EA6Q0sGCigMziozfYoJTpnvpJQQdT0/boyu49h4zUqp6S01AXBOM6beDg43X7kwworS2Nfj6h2esfVyOhV9rOBFW4vBxQPMUA4DyvT+TZX5AcW0g8vxiNyzSsEUfi0he9ZtSTxWCIHdQS1dCFabq1WxZAzRdRQEzOLyrZiQptaCD6B6WEZQYTFbM7whcLeCN7gNhC8fBiCSpEnAlEw+QpzxsMwG3CVkfHJBRNI3dpDPTyKd0Z2Fwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:17 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 03/26] hw/misc: pfsoc: Support PolarFire SoC DDR training with
 newer version HSS
Date: Thu, 23 Jul 2026 23:18:30 +0800
Message-Id: <20260723151853.2143177-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: a0967dd5-2d8e-47dc-7c49-08dee8cdc2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info: 7iuhxewvljDNoCZC62DpByJbxGJekPChog35fGYtSdu//kc9ARJuphCD842QXanU5MPa2BdiUTnzXl4h5cbxaiECisHn+hKAlbU18WsFRlKLTSsm7uhJNRXzvGq85K241jT93mix82j6pX5awuUQrWhEG59cMkUBr3ryyVpyRov50faw98+yLwRFYnXmZ9zgiAtSvYVS7mVGuNLYDN/mwxFRMKky7KnbnvdQumlQEV9kh81A47ktG5/Ci+WAlIgwoFu/xa0alcmpIb3hc/tL38jbyGPIQGLFYDu78zvBgh0bBQKQQMLbNk+wMUv5PC8TO1vGm4xgBK3Qzh1g+/98VOjOGE4Fu5IVapV1L0w5ngsMcJ6UAQx6o7ZiNCF4uX0FkZpV0NPfC/AGUTMCxm4mgTt70FwauQfdP5/TKhR0k8wqx4R2TlpUPXeKKAjOceD2CA8KFoyiSGx6d7ZfrCvWCNH6oKCNAvaDN5czrVNQYVlxv5/D5JiPFJvfO2SczMII/No+xYswvvk2uwJ2h+3Va24gHU7YZdaIW9oum7YblU3PSqmWI7nyd23MM/VIyZwKODP4AMktTh6wJb+tiG3t4Ht5U1FRhKEPswuWzCBB+jRkaD8u90C5sJFEBHE4zWJLh4AKP/aMo1JCBRnjv4YqlhNUR+jGtXFM/Ru3KXQN0Cc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(5023799004)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDbrO9IdS1XvsulntiYrFa4CL+LymuF0OQkA5mK+29sHlm4583vDw7i8R7tI?=
 =?us-ascii?Q?sZIqEgOb6lEK3F62FJyMMuvJRTaGDnd+XcyHO4iYaupC7ANTZdPi/hrzVsW5?=
 =?us-ascii?Q?IlNav5Idxr2i3FS/Xzw5PkoalJX7ksTOTt0Mhm967xdE8n47Nqb7ah6urcYH?=
 =?us-ascii?Q?sToiswyd8Z6gtw4EulSbRxlz7AkIayfV7QD4HjBlSoKlzp/LIUcq0N9/mXZ8?=
 =?us-ascii?Q?gQgIeJGrI+PULfoE7bvH856/jDpvMGDOkZ6aAztHmkG76PzmHJbA9aWX4mxL?=
 =?us-ascii?Q?LE+QtwW+y8wYKjBWxMUcFr8S89hin45mfsltf+syfE3JyuGkaZVHSKUkkfR6?=
 =?us-ascii?Q?ydlj5H3EGqlDVbP1sTTXxXWCmJ292J8S7UP7Z6minQlmlr5OJvEccRgtx2b+?=
 =?us-ascii?Q?RcAkqd2eFjd0j3keaxjgJQaLqdOLq0Ww2uFoddvZsIAC6JHSknjoIOt7OMd1?=
 =?us-ascii?Q?ATAAaylbB2spQiwETlS3/X++Cx02U/bdZQoxY3U5QvMyr+rDlUPfQK3FLFaP?=
 =?us-ascii?Q?MvGmrnmx6cy7R/UL+TaeBoyWX3Esi2LyuupLbhR7VrrvQ0oUZpKBuKWnYshG?=
 =?us-ascii?Q?54N0MB6u70ZjIbcvIaSgOnzmfuYjfx287k2RPPIaB8BHpUqpTqPgTk53PCHS?=
 =?us-ascii?Q?cLbVcCNBhSmz8nuZ8GnN8e6ZJckcER2IBDWZhNZysJn/FTkHIRBgrqIP9srO?=
 =?us-ascii?Q?PZIHJMQKT2FJDbalzOMj6KIEtu6o0YAEH6d9ZbImJRCBaIyveKhiyqI4rIVu?=
 =?us-ascii?Q?kZb7MPN7vr4whzEIRqB1rZ+zTQ828ROQ1keOsSZ1Y4xg30hbfqbu8iLQk7vO?=
 =?us-ascii?Q?JasKH806GPcPQgnn1NmaYENVV66wSIyw6Q7wMgdz29Cv56tObOCzwpScsESQ?=
 =?us-ascii?Q?pe5aB7SDbqvES7AFYVHWNqdeJHk/fXNAwxpFPpO55aoIymGkQlyqGE2LF+1p?=
 =?us-ascii?Q?2KI5ZMKdedl7qiAAyr/vy1GWas65h7TFe0qCoPZwDpeYEY4rEdsRRY25nZKu?=
 =?us-ascii?Q?+/n50R+9/b/iI+FAuvLil44hdrapugXiOkTLJeL9Vif2qeNE/x/E+BHkaX6j?=
 =?us-ascii?Q?wVw5uuSq9JADkUtcWeUMAvvYMuYUzomI3v6ms7AfLb6uIv9Ear4nZ/Djqb5L?=
 =?us-ascii?Q?jqX9zS/jJVizdvQRRxhsOJrUts5V5rHX3Jw9p3iPpSG05a9RI9u6KqEx6lUa?=
 =?us-ascii?Q?KFzvKVIg/h7IldnIpkFF+1LXyk42XNWK0gnuKAQo3RQ1y6l1B6fzc7NFUuB9?=
 =?us-ascii?Q?UDr8+rxN5PYjIt+s1qrLrMTjYHnKVpS7pDbbQ+bfpJzjkl00Cw70IaBudq7U?=
 =?us-ascii?Q?YkmdWHUQi130RvSzknwEwr0eckWK3PJ4yTFvAiDhRYp9UImCHCYWAur0g6Eb?=
 =?us-ascii?Q?lvmU9+PKjTKaN4cEXLP0lhymBHMGjAk3lYq/TEkLXTMVircMS5McZT5sOVMK?=
 =?us-ascii?Q?NNHC3tyICPck8r//Bqa2rQ1O+hwEEFBwCVqqdsRV0xvbNh2A4tFgEGNHIk2U?=
 =?us-ascii?Q?lqEPAr9s62ZurKdFBRH7ckJpI+eY10DizWaoRwnMrXDHrXdR0o5w4AFPUELy?=
 =?us-ascii?Q?xctBXa81J2UciKZ6xO0qD1aW49zXL5Jt+4H1UPIIDpw8pn9TpQVpHwFDi5uk?=
 =?us-ascii?Q?Se9N7EL5FDOO23tqRLevMcNymNro1WRS3FSjdGAYSvtH/vfOqL0PdHBuLSyT?=
 =?us-ascii?Q?0ncTxDnukr2/AfrUssokvH6cTg+aKp2DBV9cGs1Xvxida/GXwirEbTuJYT6T?=
 =?us-ascii?Q?rHOkHBGI/VcXJaIWKyY98uXC3qbhZ+w=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0967dd5-2d8e-47dc-7c49-08dee8cdc2ea
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:17.1103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCbzX3wjx2MJt+g5RLbvlWIJNhZp9TbcIF9vs4Ovt7JKFo3jK752400oKNHvNkSNHGeR25/CWrYU9LffmAiqKPUcA0D0lv+SIcTnLnh/4Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
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

HSS v2024.06 performs DDR and SGMII initialization through the DMC
register window before it can complete platform startup. The existing
model, which was validated against older version HSS in the early days,
exposes only a few fixed training results, so newer version HSS stalls
while waiting for PVT, PLL, DLL, ADDCMD, and verification status.

Update the DMC model by adding the minimum state and status behavior
needed by that firmware flow. Model the SGMII control registers,
main DDR PLL lock, deterministic ADDCMD transitions, and successful
gate and DQ/DQS verification. Keep training progress and writable
controls per device and clear them on reset.

These values are compatibility responses for HSS v2024.06 rather than
a cycle-accurate description of the DDR PHY. Document that limitation
in the source.

While we are here, update the license text to use the SPDX format.

Note at the time being there is an HSS bug [1] that consistenly blocks
the DDR traning from succeed when using an HSS image built from certain
version compiler like GCC 8.3.0. A patch [2] was proposed and verified
against HSS v2024.06.

[1] https://github.com/polarfire-soc/platform/issues/36
[2] https://github.com/processmission/qemu-machine-images/blob/main/
    machine/riscv64/microchip-icicle-kit/
    0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/misc/mchp_pfsoc_dmc.h |   6 +
 hw/misc/mchp_pfsoc_dmc.c         | 272 ++++++++++++++++++++++++++++---
 2 files changed, 254 insertions(+), 24 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_dmc.h b/include/hw/misc/mchp_pfsoc_dmc.h
index 2ed582fb8c..6a1986c2c2 100644
--- a/include/hw/misc/mchp_pfsoc_dmc.h
+++ b/include/hw/misc/mchp_pfsoc_dmc.h
@@ -28,10 +28,16 @@
 /* DDR SGMII PHY module */
 
 #define MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE   0x1000
+#define MCHP_PFSOC_DDR_SGMII_PHY_REG_NUM \
+    (MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE / sizeof(uint32_t))
 
 typedef struct MchpPfSoCDdrSgmiiPhyState {
     SysBusDevice parent;
     MemoryRegion sgmii_phy;
+    uint32_t regs[MCHP_PFSOC_DDR_SGMII_PHY_REG_NUM];
+    uint8_t training_status_bit;
+    uint8_t addcmd_tap;
+    bool addcmd_move_active;
 } MchpPfSoCDdrSgmiiPhyState;
 
 #define TYPE_MCHP_PFSOC_DDR_SGMII_PHY "mchp.pfsoc.ddr_sgmii_phy"
diff --git a/hw/misc/mchp_pfsoc_dmc.c b/hw/misc/mchp_pfsoc_dmc.c
index 1fe4535464..443de5ddd1 100644
--- a/hw/misc/mchp_pfsoc_dmc.c
+++ b/hw/misc/mchp_pfsoc_dmc.c
@@ -2,22 +2,20 @@
  * Microchip PolarFire SoC DDR Memory Controller module emulation
  *
  * Copyright (c) 2020 Wind River Systems, Inc.
+ * Copyright (c) 2026 Process Mission
  *
  * Author:
  *   Bin Meng <bin.meng@windriver.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
+ * Updated by Bin Meng <bin.meng@processmission.com> to support DDR
+ * training emulation for with newer version Hart Software Services,
+ * aka HSS.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * The DMC register model is based on HSS v2024.06. Its read/write
+ * behavior is the minimum needed for DDR training to complete and
+ * may not reflect actual hardware register behavior.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -29,17 +27,56 @@
 
 /* DDR SGMII PHY module */
 
-#define SGMII_PHY_IOC_REG1              0x208
-#define SGMII_PHY_TRAINING_STATUS       0x814
-#define SGMII_PHY_DQ_DQS_ERR_DONE       0x834
-#define SGMII_PHY_DQDQS_STATUS1         0x84c
-#define SGMII_PHY_PVT_STAT              0xc20
+#define PHY_ADDCMD_CK_TRANSITION_TAP              12
+#define PHY_ADDCMD_A5_TRANSITION_TAP              20
+#define PHY_ADDCMD_CK_READBACK                    5
+#define PHY_ADDCMD_A5_READBACK                    (3 << 8)
+#define PHY_GT_TXDLY_VALUE                        0x01010101
+#define PHY_DQDQS_STATUS2_VALUE                   5
+
+#define SGMII_PHY_PLL_CTRL_MAIN                   0x084
+#define SGMII_PHY_PLL_CTRL_MAIN_CONTROL_LO_MASK   0x0000007f
+#define SGMII_PHY_PLL_CTRL_MAIN_LP_REQUIRES_LOCK  BIT(24)
+#define SGMII_PHY_PLL_CTRL_MAIN_LOCK              BIT(25)
+#define SGMII_PHY_IOC_REG1                        0x208
+#define SGMII_PHY_TRAINING_STATUS                 0x814
+#define SGMII_PHY_GT_ERR_COMB                     0x81c
+#define SGMII_PHY_GT_CLK_SEL                      0x820
+#define SGMII_PHY_GT_TXDLY                        0x824
+#define SGMII_PHY_DQ_DQS_ERR_DONE                 0x834
+#define SGMII_PHY_DQDQS_STATUS1                   0x84c
+#define SGMII_PHY_DQDQS_STATUS2                   0x850
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1         0x880
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_CONTROL_MASK 0x001fffff
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_ADDCMD_MASK  0x00180000
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1         0x890
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_CONTROL_MASK 0x001fffff
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_ADDCMD_MASK  0x00180000
+#define SGMII_PHY_EXPERT_ADDCMD_LN_READBACK       0x8ac
+#define SGMII_PHY_SOFT_RESET_SGMII                0xc00
+#define SGMII_PHY_SGMII_MODE                      0xc04
+#define SGMII_PHY_PLL_CNTL                        0xc08
+#define SGMII_PHY_PLL_CNTL_LOCK                   BIT(7)
+#define SGMII_PHY_CH0_CNTL                        0xc0c
+#define SGMII_PHY_CH1_CNTL                        0xc10
+#define SGMII_PHY_RECAL_CNTL                      0xc14
+#define SGMII_PHY_RECAL_CNTL_STATUS_MASK          0xffff0000
+#define SGMII_PHY_RECAL_CNTL_LOCK                 BIT(23)
+#define SGMII_PHY_CLK_CNTL                        0xc18
+#define SGMII_PHY_DYN_CNTL                        0xc1c
+#define SGMII_PHY_PVT_STAT                        0xc20
+#define SGMII_PHY_PVT_STAT_IO_ENABLE              BIT(6)
+#define SGMII_PHY_PVT_STAT_CALIBRATED             BIT(14)
+#define SGMII_PHY_PVT_STAT_GUEST_CTRL_MASK        0xc0000000
+#define SGMII_PHY_SPARE_CNTL                      0xc24
+#define SGMII_PHY_SPARE_STAT                      0xc28
 
 static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     uint32_t val = 0;
-    static int training_status_bit;
+    MchpPfSoCDdrSgmiiPhyState *s = opaque;
+    uint32_t index = offset / sizeof(uint32_t);
 
     switch (offset) {
     case SGMII_PHY_IOC_REG1:
@@ -53,8 +90,8 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
          *
          * See ddr_setup() in mss_ddr.c in the HSS source codes.
          */
-        val = 1 << training_status_bit;
-        training_status_bit = (training_status_bit + 1) % 5;
+        val = BIT(s->training_status_bit);
+        s->training_status_bit = (s->training_status_bit + 1) % 5;
         break;
     case SGMII_PHY_DQ_DQS_ERR_DONE:
         /*
@@ -71,8 +108,106 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
         val = 0xff;
         break;
     case SGMII_PHY_PVT_STAT:
-        /* See sgmii_channel_setup() in HSS */
-        val = BIT(14) | BIT(6);
+        /*
+         * HSS polls IO enable and calibration status, then writes the
+         * calibration lock. The HSS register definitions mark bits 31:30
+         * as writable controls.
+         *
+         * See sgmii_channel_setup() in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PVT_STAT_IO_ENABLE |
+              SGMII_PHY_PVT_STAT_CALIBRATED;
+        break;
+    case SGMII_PHY_PLL_CTRL_MAIN:
+        /*
+         * HSS programs the main DDR PLL controls and polls LOCK after
+         * changing the PLL dividers during LPDDR4 manual training. The
+         * HSS register definitions mark bits 6:0 and 24 as writable.
+         *
+         * See ddr_pll_config() in mss_pll.c and
+         * lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PLL_CTRL_MAIN_LOCK;
+        break;
+    case SGMII_PHY_PLL_CNTL:
+        /*
+         * HSS programs the SGMII PLL controls and polls aro_pll0_lock.
+         *
+         * See setup_sgmii_rpc_per_config() and sgmii_channel_setup()
+         * in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PLL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_RECAL_CNTL:
+        /*
+         * HSS programs the low control half, polls sro_dll_lock, and
+         * reads sro_dll_90_code from the read-only status half.
+         *
+         * See setup_sgmii_rpc_per_config() and sgmii_channel_setup()
+         * in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_RECAL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_EXPERT_ADDCMD_LN_READBACK:
+        /*
+         * HSS pulses the ADDCMD move controls while sampling CK from
+         * bits 3:0 and A5 from bits 9:8. The transition tap positions
+         * below are deterministic QEMU model choices.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        if (s->addcmd_tap >= PHY_ADDCMD_CK_TRANSITION_TAP) {
+            val |= PHY_ADDCMD_CK_READBACK;
+        }
+        if (s->addcmd_tap >= PHY_ADDCMD_A5_TRANSITION_TAP) {
+            val |= PHY_ADDCMD_A5_READBACK;
+        }
+        break;
+    case SGMII_PHY_GT_ERR_COMB:
+    case SGMII_PHY_GT_CLK_SEL:
+        /*
+         * HSS fails DDR verification on any gate error, a zero delay
+         * selected by gt_clk_sel, or more than one zero delay byte.
+         * Model no gate errors; the all-nonzero delay below makes the
+         * deterministic clock selection immaterial.
+         *
+         * See DDR_TRAINING_IP_SM_VERIFY in ddr_setup() in mss_ddr.c
+         * in HSS.
+         */
+        val = 0;
+        break;
+    case SGMII_PHY_GT_TXDLY:
+        val = PHY_GT_TXDLY_VALUE;
+        break;
+    case SGMII_PHY_DQDQS_STATUS2:
+        /*
+         * HSS requires the calculated DQ/DQS window to be at least
+         * DQ_DQS_NUM_TAPS, which is 5. Return the minimum pass value.
+         *
+         * See DDR_TRAINING_IP_SM_VERIFY in ddr_setup() and the
+         * DQ_DQS_NUM_TAPS definition in mss_ddr.h in HSS.
+         */
+        val = PHY_DQDQS_STATUS2_VALUE;
+        break;
+    case SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1:
+    case SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1:
+    case SGMII_PHY_SOFT_RESET_SGMII:
+    case SGMII_PHY_SGMII_MODE:
+    case SGMII_PHY_CH0_CNTL:
+    case SGMII_PHY_CH1_CNTL:
+    case SGMII_PHY_CLK_CNTL:
+    case SGMII_PHY_DYN_CNTL:
+    case SGMII_PHY_SPARE_CNTL:
+    case SGMII_PHY_SPARE_STAT:
+        /*
+         * HSS programs the ADDCMD and SGMII controls and reads
+         * SPARE_STAT to classify the silicon and select eye-width
+         * thresholds.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c and the SGMII setup
+         * functions in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index];
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
@@ -87,10 +222,88 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
 static void mchp_pfsoc_ddr_sgmii_phy_write(void *opaque, hwaddr offset,
                                            uint64_t value, unsigned size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, value 0x%" PRIx64
-                  ", offset 0x%" HWADDR_PRIx ")\n",
-                  __func__, size, value, offset);
+    MchpPfSoCDdrSgmiiPhyState *s = opaque;
+    uint32_t index = offset / sizeof(uint32_t);
+
+    switch (offset) {
+    case SGMII_PHY_IOC_REG1:
+    case SGMII_PHY_TRAINING_STATUS:
+    case SGMII_PHY_GT_ERR_COMB:
+    case SGMII_PHY_GT_CLK_SEL:
+    case SGMII_PHY_GT_TXDLY:
+    case SGMII_PHY_DQ_DQS_ERR_DONE:
+    case SGMII_PHY_DQDQS_STATUS1:
+    case SGMII_PHY_DQDQS_STATUS2:
+    case SGMII_PHY_EXPERT_ADDCMD_LN_READBACK:
+    case SGMII_PHY_SPARE_STAT:
+        /*
+         * The HSS register definitions declare these status and
+         * readback registers read-only.
+         *
+         * See mss_ddr_sgmii_phy_defs.h in HSS.
+         */
+        return;
+    case SGMII_PHY_PLL_CTRL_MAIN:
+        value &= SGMII_PHY_PLL_CTRL_MAIN_CONTROL_LO_MASK |
+                 SGMII_PHY_PLL_CTRL_MAIN_LP_REQUIRES_LOCK;
+        break;
+    case SGMII_PHY_PLL_CNTL:
+        value &= ~SGMII_PHY_PLL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_RECAL_CNTL:
+        value &= ~SGMII_PHY_RECAL_CNTL_STATUS_MASK;
+        break;
+    case SGMII_PHY_PVT_STAT:
+        value &= SGMII_PHY_PVT_STAT_GUEST_CTRL_MASK;
+        break;
+    case SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1: {
+        bool active;
+
+        /*
+         * HSS pulses 0 -> 0x180000 -> 0 while scanning the ADDCMD eye.
+         * Count each rising pulse as one abstract delay tap.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        value &= SGMII_PHY_EXPERT_DLYCNT_MOVE_CONTROL_MASK;
+        active = value & SGMII_PHY_EXPERT_DLYCNT_MOVE_ADDCMD_MASK;
+        if (active && !s->addcmd_move_active &&
+            s->addcmd_tap != UINT8_MAX) {
+            s->addcmd_tap++;
+        }
+        s->addcmd_move_active = active;
+        break;
+    }
+    case SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1:
+        /*
+         * HSS pulses 0x180000 before each ADDCMD scan. Restart the
+         * abstract QEMU tap position when that load pulse is asserted.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        value &= SGMII_PHY_EXPERT_DLYCNT_LOAD_CONTROL_MASK;
+        if (value & SGMII_PHY_EXPERT_DLYCNT_LOAD_ADDCMD_MASK) {
+            s->addcmd_tap = 0;
+            s->addcmd_move_active = false;
+        }
+        break;
+    case SGMII_PHY_SOFT_RESET_SGMII:
+    case SGMII_PHY_SGMII_MODE:
+    case SGMII_PHY_CH0_CNTL:
+    case SGMII_PHY_CH1_CNTL:
+    case SGMII_PHY_CLK_CNTL:
+    case SGMII_PHY_DYN_CNTL:
+    case SGMII_PHY_SPARE_CNTL:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                      "(size %d, value 0x%" PRIx64
+                      ", offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, value, offset);
+        return;
+    }
+
+    s->regs[index] = value;
 }
 
 static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
@@ -99,6 +312,16 @@ static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void mchp_pfsoc_ddr_sgmii_phy_reset(DeviceState *dev)
+{
+    MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->training_status_bit = 0;
+    s->addcmd_tap = 0;
+    s->addcmd_move_active = false;
+}
+
 static void mchp_pfsoc_ddr_sgmii_phy_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(dev);
@@ -117,6 +340,7 @@ static void mchp_pfsoc_ddr_sgmii_phy_class_init(ObjectClass *klass,
 
     dc->desc = "Microchip PolarFire SoC DDR SGMII PHY module";
     dc->realize = mchp_pfsoc_ddr_sgmii_phy_realize;
+    device_class_set_legacy_reset(dc, mchp_pfsoc_ddr_sgmii_phy_reset);
 }
 
 static const TypeInfo mchp_pfsoc_ddr_sgmii_phy_info = {
-- 
2.34.1


