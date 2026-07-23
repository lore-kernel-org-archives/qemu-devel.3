Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F3C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCv-00045F-AN; Thu, 23 Jul 2026 11:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCt-00043d-T7; Thu, 23 Jul 2026 11:19:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCr-0007zZ-Om; Thu, 23 Jul 2026 11:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPVKISsaFe2UJHArRAqQelFvVGR7r5PASHiW4tepH+daoZI/5t9tcX2PUyD5wXy4CxwdiiA8k45E9kVBR1le75b8mTXDCA5xpGDHLlaKdFkMexcGQ7Xg4KoA5un+VccBRUtZgLjzu6Qf/XliojWvdrIYZoVbiF7YGRUOLHGcat5LFYD5N7UsxJyJjsEbN6aHuPculGkopIizkY1LppVbqaS9PRhUliky3oinh5b0MMOOzLYwlslDb+nmuR3VzMxR6+fne9JsL0cyT5BFuWw+aDHxZOpswYfV9FldvOCT2D5p5sYdEIuBcrVJU+HuZ3N+ZZ++Zbxsxcx2/E3D5e0qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZvOV3ut1QdLAcN2OD7T9+m98yaure4yYaH425c2XSE=;
 b=qEPNbDjCR4dLyiUtNeKye1pOi4gcGmcSX5KodzLOns5QyookvkuhHz4MUAmGapfG/6dtKqmfCT3QuyvF+UvKZ4d+G4KWnRRvA1njujNbR4wyWj7/DDoAnnmrD/FsVQ/kcksr33yTu0+66NbbBrGodN2G1pnjz6zWFOab9/oz2crj+RfteOE4RckiuQX2XNnhHP/WyRG1U3ROAigCshhytlqhkJLtT55/UcxEk/f1aimxumkyTF16CjjzQSc225gw7OzD63hD0d2yD/v2MvHiZeNb5pfpzJKCqx4+pFc2YI40T1ff1U+MBz9MW9fk48O54nnrjljENsTRZYaB0GHVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZvOV3ut1QdLAcN2OD7T9+m98yaure4yYaH425c2XSE=;
 b=AnDWw9S8cMfObJ3deyoikfz4ezENZE0GfJjbZQCn9yIGpNAwv3D4WwGtthBs4LIIEK9kw4BNBQuohHksEmqn6rdqHoknTo7e7sATMm5t3D/raso6haFv9DI0/8CS1ia9GHsjAEOIf9Sy+QNyqOU/WojKIga0eICNg1qbvcatV0yMwYb5+wxW1W4p/xI70N0JdOVoItizaWYW1LtEQzV1Zy+Zyd/26MkKTQFSHOVecZztkRqYl6RUVr/8tijcZclLJajJt8TBySgPFUB8Z9hV3QNSgSfveaEsTnYxZuxxjjPLNvElaf4WufTpMye+tsHcbetbOSp+Tg6Or+rVgcqkhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:20 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 04/26] hw/misc: pfsoc: Model L2 cache controller registers
Date: Thu, 23 Jul 2026 23:18:31 +0800
Message-Id: <20260723151853.2143177-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4c32e0c-a006-4e7b-a13b-08dee8cdc3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9/1NXUN296kMPP2Wl7liHtvyRajJ3auoQQKWjpCB32/I3L+Z5Mg0aGM+SNi/zkRJuRfBCGp9vKX2xPYPdoqFZLrNCCQOmMm0FVO/19nKXSNIa7ZQSDXsCctQn9bYQHAbGXvlSJYo+fvJOaCfY+usBSno+vhj/n8XH8TFPRAthi6sYcabCGdiQR7+gnwK7aXoMsrwyFrzn4c4oGup8zefKT+KZDav7ri8quJSDTky0Oyu2npBohycCkWWCu2a6FG/nxQcqyGz1RfkbsTWfDi5W9iH/uq38ypEWvxr7AuwbNeL9BEnZlDuYEyHcxvxxitwluw71GYMxeXLuRMqqcAchcEm1PbPBhbSl+5NWD9Xyzq2UFT+0IN6eOg5HIe697QUWeP52BnRyt7s5+74WjatuTuaKI9Fv8F7KnZByB5zvJbTmepRcusG/R5z1ihJzDN7r53NWIYfd5s00Lkwr7plTM6+Vcq5Xatrn8hm3u/3HihCHM2tsN65hZO26/W+PSDKA9ZwyDK3OzCh9qKz4Rz0DohflObn7i8IY+0qKlnOJLcwBMigym66psUHKAkwte3svMf7Q6YUbN4jW0c5ku2ltoz6z9GlaVpA6KBR0wFHI5kNQK2KmJc8QuHJCKyolc9ATniQV1Vp+qzX1ftM98xrgYR/jTqdDELQJiph4McThsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmPjHNaYjUn76/tdhx0nCcX7wXexG12IS4oeSkbyKhuySehN34XiA+Ahwpq2?=
 =?us-ascii?Q?YB6zqeVb6KxJ9+rZK60aD1MHmNVHeKZhRjUj1+dgosH8AOSAOkHMSB1Z9d48?=
 =?us-ascii?Q?q+Xx1m9zTNeAfL6jKxkLLuvhdgs0/fElFLUEJrJLgNOvDZXSiaGYtVqMrsQl?=
 =?us-ascii?Q?4O0vPjDjW/GQNW8FJZlegah/agxr5wS79Q3BwQPT6SwLUPQ69/K/2FfXahK1?=
 =?us-ascii?Q?8gd77MFlRfVXx50/8uJDaqDA5O2w2j7klOt4SvVRtLQYvp4Z51a6NJblyH74?=
 =?us-ascii?Q?6mG5ijPoXV+sl0kTqYwqELIJ4nRMk8aoNS3o7QWW1/OIIoKk9rW6K0Pr9HHB?=
 =?us-ascii?Q?dUqFz02vXe54axEUrPt6oYlbCTmL7Rqfjdt0qlRfaWHPVUJ9X3aKuooU097s?=
 =?us-ascii?Q?AYnYHWJJtpQLDva9u76Qy6E9WaOwFMBeV728FtBxVPOPm4HbNdlak/uDil72?=
 =?us-ascii?Q?/fF+iIFSsQ0c1CW1+lI7797/UCDKvPO2IJsCM/+5/MP43fl0qtje0hz5OAFD?=
 =?us-ascii?Q?og/r1zNbCHdXg0I2LMdXDtFxS7cnf1LOmsFfagDWlOgT5vm96+wraO5V4Rhc?=
 =?us-ascii?Q?077aoUEN0UHQJ8GnVRUxcIPT/peBFwopwN8LS/0Fl+FNiq1CT0kQdDGTY2es?=
 =?us-ascii?Q?kn7sqxi2DRtWFzG1sHtyI0wdND/PHwclSKgR0FI2ysn6qqzEmg8F8KPWb1oE?=
 =?us-ascii?Q?9HmBjoZ5cb4iN8lZW0OQroDW75tuAJ13UoIr4UCgmD3hV07SwaaBWSlXt/28?=
 =?us-ascii?Q?f28eeeregPDL4u0ywqJQyuVTfNhDEHGFV7A8HEnMLgE48qp16xuHHWqRQm7f?=
 =?us-ascii?Q?juiJYfiFoduW+BKARTzfiiUtooQF0Bz/kSh2NLUMx5+gfpC6TVuXjavbaw8A?=
 =?us-ascii?Q?XQy0ylArVrj50w6U0yrBfQdlmhvaKkqx2z837RjBOB5RS2Zg9l8WjjTKyxSk?=
 =?us-ascii?Q?X6b61ygBXXxsefihRbRH8nB25Ro7txr0nyY/PneS7y2ypjEuTr7aFP8Eoc2C?=
 =?us-ascii?Q?gHm9dfvo5Y1+Qa+jvrHyNCRRn9pMcXpyJgs+FnMi4V+g9xnqeOKEECYPPpoK?=
 =?us-ascii?Q?3s4iE0qcArY6Zvw0N+NGowSHBYdqGwxyStmug6Q6fITW7LkB37m7tSaN2eua?=
 =?us-ascii?Q?NsIwI/u4GYcJB3hYReyuvtoqqKgq7W0QNmJofuOmyCvyCwv0fBXj0wUvzh3f?=
 =?us-ascii?Q?BTCTHpRmEJNlzplKhy4xrUa9TkgEgWjMYvsg0nhUNMtijA0CRZjefj/JPn2R?=
 =?us-ascii?Q?ADT6iIiO3mCge+ErmUiDzH8Gr/H9d4tauPbwMZ0oxCeY694om6FcJ5xGEyCQ?=
 =?us-ascii?Q?qqzwgpJwKWQK4BgzeRW2xaix32mDO2mCODAC/xX7EgU7157BXzYZuMjn6+C4?=
 =?us-ascii?Q?3GGGpVhBJIuIZnsDbAWi1OroZEUDaiJecuzx9uVld7qRRwNNkq/qs/m4G0js?=
 =?us-ascii?Q?ucqsP7QJy+vN4yWX/2/upfkx50a0U7/7A7Z/Yjg97AwsQC86lnHvL2bBs8HN?=
 =?us-ascii?Q?wUMBHSpt/+VTU0LVEwQcj5E7WchgTH5yjyNrFHszLE4aGtrlSyVIuVZlYVz0?=
 =?us-ascii?Q?iPErdVDOXrrkKnlPH/wbCqgUwo/apABhYyFPT6PPB8akGYXo7fw5OItcBsx5?=
 =?us-ascii?Q?Zx4n/9NTsbckPbUtXYjPnRUnNPy8oY1Aizb3iAIouckZGSsQyJOegeHoSFdt?=
 =?us-ascii?Q?Yx8TCb9bNGaSCJKOSmgdGXFoQX03Jg99L2ecWR0MaHyQbRBflGv1gsMJ5Ru+?=
 =?us-ascii?Q?Ofew5HeHLaob+u6Y1orXfZXqOtAGMOI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c32e0c-a006-4e7b-a13b-08dee8cdc3db
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:18.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xj0f/l1HnqXocDrpapiOiTXmossQ7cn5pXfD73DK25AjYY8UwFHMcKuOxUAHc9jr5mkKS8JxektQITlU1nFZ57OCiqdykaxw8wPhLF4No4M=
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

Implement the Config, WayEnable, and per-master WayMask registers
described by the PolarFire SoC MSS reference manual. Make WayEnable
monotonic and report the remaining register space as unimplemented.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS                       |   2 +
 include/hw/misc/mchp_pfsoc_l2cc.h |  30 +++++
 hw/misc/mchp_pfsoc_l2cc.c         | 180 ++++++++++++++++++++++++++++++
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 5 files changed, 216 insertions(+)
 create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
 create mode 100644 hw/misc/mchp_pfsoc_l2cc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a28935c898..c0bb18c47a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1770,11 +1770,13 @@ F: hw/riscv/microchip_pfsoc.c
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
index 0000000000..b320356572
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
+static void mchp_pfsoc_l2cc_reset(DeviceState *dev)
+{
+    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(dev);
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
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, mchp_pfsoc_l2cc_reset);
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
index 1543ee6653..772a2d87b3 100644
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
index 23265f6035..5f45861d8a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -30,6 +30,7 @@ system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
 # RISC-V devices
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
+system_ss.add(when: 'CONFIG_MCHP_PFSOC_L2CC', if_true: files('mchp_pfsoc_l2cc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
-- 
2.34.1


