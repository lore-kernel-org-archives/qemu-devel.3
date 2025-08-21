Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A879CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50f-0005F7-08; Thu, 21 Aug 2025 09:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zH-0002e0-1Z; Thu, 21 Aug 2025 09:05:51 -0400
Received: from mail-mw2nam12on20624.outbound.protection.outlook.com
 ([2a01:111:f403:200a::624]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z3-0003FK-6E; Thu, 21 Aug 2025 09:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFYT8WhDgnyihCsd3LQWs94FHGFjRK7QrWa87vScBWPUnDv26YcC75XuyeA0gLplFfXFLE1c4AwdmCS4hDOpUyh4ULwzJrEDikqcdjF1pYM5rtsYsrLmJXrFgapA6R4VZ/FtDahnCRoVv4lP7qi4Hfuzo+1n+NJO99Z1wvUAkSU3va0dmpXtxb84xKtScMWN6xuvepvej3d2bHrYfeXEXnxzzYeQdgGbbxKwzvOllb+f0tlEMepPS7EptlVcMRFilSHopTcH56VkOaBF7LfV29BMX3LHz40uymo/Ow7j3myVYsLodEs1IBF3n9rH61YVu3nhq3IDqZc52egTNMlwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZeVxnLszDN4uFL1fKILiZosZ+n34rz4u7SiBYAGGOk=;
 b=fT7ESrWkd8C9c10fBZ06vKFmKSLC/96iRYur3qea5uQg4mjSyqv2NUWd7bqqOLotc7X8EmoTMKKco2vDF8BMHwW+uw4EgcX+8a3ailMDOld32MsMeZO+lGOx/MK18Crt+5gOiySqg8T8WadsuGLaYhsC/4/XnJwMB5wzqRrxkP9m913xdoF4vd2aBIFO8MywAyWo6Q70WAueqxewbzBBOIywhqkpMw+wr8PKDs9ndMW4yEoo0eG6xBr1AhM9sPzsb8JJpGXbfA7X5INYGOtyqn5J0BohTq1qDa45gZjGfjFqWFrdiRkIWPy6eKqubCy1SVKN8E2rPaLcweGJAowteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZeVxnLszDN4uFL1fKILiZosZ+n34rz4u7SiBYAGGOk=;
 b=NvQemFkyLmT/7A3SajTA/NWKLeIGQYtdymBI58rlth4vivt8LR6QSmxmTVtPJAEO/fUwo7Dv7mMyqvAgvCeyQwtGU3te3taEwDksU12WCYwGOIrKiuZMyx53qKiZmharUrPWY7zXV1va1g2+gfKF3+REsoNLlgiaOPWOA9S3WxM=
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Thu, 21 Aug
 2025 13:05:27 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d4) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:15 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:13 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Thu, 21 Aug 2025 15:03:37 +0200
Message-ID: <20250821130354.125971-39-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3934b5-b976-43b4-5b49-08dde0b365aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DJnEZ/kr9RGZWSYoXVwOAAXWuojfydlsGlGBthF4MTtVLbdOFXNwuImTyFmy?=
 =?us-ascii?Q?4r1XLavo1GucUdIafIKRYUHBLo03IyPxP5SGbfgKtdCfoTxhDsIAcz0Ig1D7?=
 =?us-ascii?Q?z6Z23YEkLcTNMzvJiokqQxfyo0ut3CbmRYJfdhAj9j1Nuh087DrdWwrtlBcK?=
 =?us-ascii?Q?NJL76fRasXJwbivAdGwos26lhXK112Utq3wKXO/XDuCeBsfoqZPdwxIbuH14?=
 =?us-ascii?Q?gW2BLsop51MZBA2qKY5vZMmrQqXuuqSPryl42LmUMH4R992u+s5gsnSF5giQ?=
 =?us-ascii?Q?XHL0+ALZWVRL1Hql0qpThtShUerWmZqCJoS82ipnL8b8nZOsOXQdRhhwsMrb?=
 =?us-ascii?Q?cyDtSiVNCKxGqogdZvsIgvvJER+uYPvCjLkCM/Tl3Xv8cw7smgov6ZF/r0cj?=
 =?us-ascii?Q?EplLJM0/WDYmBZ6Q66vus44FZz5bSRWjsq02fOmCK967Dsq6Y1ndiqha/A4C?=
 =?us-ascii?Q?CvoXo/Uo4qQczOXgC13eKiWPOL+SZf+GfjrK32m2zeKx8ous5hh7apJKYXP7?=
 =?us-ascii?Q?mkZ9yTf2mknXnA6QnONtJjtJS3VLDQrgpWVsjvHc9R/5tn9ApGYLVhGgzWKn?=
 =?us-ascii?Q?QOZFm04ROaW3iX5kvJQvu2y76/sC1NZ3fbMov3/4uzeSV3CMEdn/ona3volo?=
 =?us-ascii?Q?vEHbs/npgGP/U8vOmUDglKPapXLsVctHIgIJgiTSmZtk1HYBXApzWkIixtBE?=
 =?us-ascii?Q?ROX5XyWU//QfluwrVGMOxRUVOKzEPu5q1UDi7SBK/ICKEcjqESVBM/iYEz7I?=
 =?us-ascii?Q?mTf0UlYuQPKAqe7zvM4k18HPXDqRvGKk5A4HxpX9p9bZOnsNTMst6m0BcsrP?=
 =?us-ascii?Q?ql+FjXgtXwoQRXMgfkEEY41QBR9JNUwXOycT5ayncqqtb85A9ZfAqAdVKuDW?=
 =?us-ascii?Q?a0UbfPCcHDoz7DK3VwuNVfIHyob5wrq0NtbG9L1iqzNDnBow2nTlRbyhBqV9?=
 =?us-ascii?Q?7kJ7mAFHQjyyGq6vBBVo/35G1/4azMwErhrlzDlzi5ab+KIkotyCzw9nC5oG?=
 =?us-ascii?Q?F4bc/cXph1+qU+JKdNcRC6nEYuk1CWmypvOn+abGgZpzpiXuOmAxpXgz0lCI?=
 =?us-ascii?Q?XRdWuimSSPaN6G6CYBdVO6xGY6r9a1CN+4qBMRF+ZzVNhislmCL7x+9v5yiL?=
 =?us-ascii?Q?gE9d2FmesMlkHlseolQxYuOTwt65q3w404xA3WsVIrzIL8pIQ2pr3Yhro12U?=
 =?us-ascii?Q?tuYAPrUDhO9zKNZBab/qdVbKXALHhghXeexKsviDnxWQeYKlarzO+baueHA0?=
 =?us-ascii?Q?2xS6TGGBdxpGZa5/QVcFtJfHjF7pQbLId2sKAWAL5WSaqNKCZE5749S4nvnI?=
 =?us-ascii?Q?BOwzX/IJPlNg1pf1A5g7eLAHsFHL6q1uBAIIjnVLi5dZTKuY3wiS4NAJPME2?=
 =?us-ascii?Q?D91mE8igoCfXlrZmRN3bHc+NsmtWg/8RmSdRE5Wl89mE7hDI/YfzfP2HG8uo?=
 =?us-ascii?Q?r3haX+BrIH0QjTK8/R5XupurGXvXNiZxiVgBga3YFt9ogcKo2Hkj18TFOqS7?=
 =?us-ascii?Q?MvZZeR5cpjMPfFDZVubH1054DxFiMYPsHohs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:26.5101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3934b5-b976-43b4-5b49-08dde0b365aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
Received-SPF: permerror client-ip=2a01:111:f403:200a::624;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the target field in the IRQ descriptor. This allows to target an IRQ
to another IRQ controller than the GIC(s). Other supported targets are
the PMC PPU1 CPU interrupt controller and the EAM (Error management)
device. Those two devices are currently not implemented so IRQs
targeting those will be left unconnected. This is in preparation for
versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2eb0fa77515..b6d99f5e103 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -50,18 +50,30 @@
 #include "hw/cpu/cluster.h"
 #include "hw/arm/bsa.h"
 
 /*
  * IRQ descriptor to catch the following cases:
+ *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
  *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
  */
 FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, TARGET, 16, 2)
 FIELD(VERSAL_IRQ, ORED, 18, 1)
 FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 
+typedef enum VersalIrqTarget {
+    IRQ_TARGET_GIC,
+    IRQ_TARGET_PPU1,
+    IRQ_TARGET_EAM,
+} VersalIrqTarget;
+
+#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
+#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
 #define OR_IRQ(irq, or_idx) \
     (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+#define PPU1_OR_IRQ(irq, or_idx) \
+    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
 
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
@@ -412,19 +424,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
  * Or gates are placed under the /soc/irq-or-gates QOM container.
  */
 static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
                                           qemu_irq target_irq)
 {
+    static const char *TARGET_STR[] = {
+        [IRQ_TARGET_GIC] = "gic",
+        [IRQ_TARGET_PPU1] = "ppu1",
+        [IRQ_TARGET_EAM] = "eam",
+    };
+
+    VersalIrqTarget target;
     Object *container = versal_get_child(s, "irq-or-gates");
     DeviceState *dev;
     g_autofree char *name;
     int idx, or_idx;
 
     idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
     or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
 
-    name = g_strdup_printf("irq[%d]", idx);
+    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
         dev = qdev_new(TYPE_OR_IRQ);
         object_property_add_child(container, name, OBJECT(dev));
@@ -436,16 +456,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
     return qdev_get_gpio_in(dev, or_idx);
 }
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
+    VersalIrqTarget target;
     qemu_irq irq;
     bool ored;
 
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = versal_get_gic_irq(s, irq_idx);
+    switch (target) {
+    case IRQ_TARGET_EAM:
+        /* EAM not implemented */
+        return NULL;
+
+    case IRQ_TARGET_PPU1:
+        /* PPU1 CPU not implemented */
+        return NULL;
+
+    case IRQ_TARGET_GIC:
+        irq = versal_get_gic_irq(s, irq_idx);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
-- 
2.50.1


