Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC3DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXb-0001Rc-2X; Fri, 22 Aug 2025 11:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWv-0008Ve-32; Fri, 22 Aug 2025 11:18:16 -0400
Received: from mail-bn7nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2009::629]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWZ-0007G1-RX; Fri, 22 Aug 2025 11:18:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OV2ybqgvuqWMUd1PBi1Uxnlol8+4h/GN44rJPa9Y2dHwUbK01WV6qE4KilnJcXU9R0NVE7oDKosqaE0mbWykhFOWXnTX+FWx5Tz9xNQ+m9SjYm6AICsdtCGaSV957TbCpE+3UciN2JKbLIPq8cQBz3o2F8VVta1CxW5aBWYn9GRzG2FMtzEmTqcLdcKjeN11DvOScdFQPbqz4IQNH74t/eF2lZHpyh1cYvYIiRbX4BaIvsN34aowUTlxjWHzIsLBAfu1XoUPDbmzJycIjEqsbLpkqM8u1HCKsgqJc7xSBOODVK52gsU7E2uWY4KaHFoGkYSKpHaW6k4hXClgA2p4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYryKv9h4DiRfjB9e7aCXGDAvFWXEEooZGZPgg3Lbio=;
 b=VVdocU13enttp4XWNAVXoAdRtpKfunxZVM3ngt29IjOI9DUh67jBBBAKejxmEtlGHuy4z05TusqyjolzCSHiHdJ3r5MX5drUxStVUNmaGK5O2T16vREnoeYA9q97DWAbVJbRTLt20VldwwDX0YNVoXqANV4wZUv3/bjDOS2dpRYQbIwPI8IbeYSRyyHbQc4iI7qM0vI+x4QN95xSn4eM7Dgxe9R5Rm34nzpibIjF76rf86dL+5/24WkwxDVktAuu8HRHHm8bZ/aRzQCXURNSZSbzH0/+ACms2uZRcx8j4msryCn3YizgFoz76OOsMuExrbKEbpPVSwdwVoECI05ccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYryKv9h4DiRfjB9e7aCXGDAvFWXEEooZGZPgg3Lbio=;
 b=mrTGJ4TU9KYSCAoslyx/+UduCnKCslnFSCz8PYmLWbSfiEFSN7eQS+Ddbv7sCeKwp5Jdm0FXnOxbFK0/2WicHIXta3dd6K/Bi2EWmhaPLFcVgLXzasXQ6487c+Q0oHK1drwPw+Z2UXRORexsomV7+rDu6ccENQ1HhTV9aDSufqk=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:17:42 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::53) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:41 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:39 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Fri, 22 Aug 2025 17:16:03 +0200
Message-ID: <20250822151614.187856-39-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: c66582cb-69ec-47e6-36e4-08dde18f0a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ATYgetqlYfkHEPK0mSoaavzehkXKOej4op8SHT/Lqlqn0dN1RPDiQVfNgwIN?=
 =?us-ascii?Q?0PBgSbqvjQxbCwq3F6poS520vnZmTJhSysMHOYsVGZcgUv9gj8d6XKDw6O6M?=
 =?us-ascii?Q?E89UDnF7MQxLD0I43RyCiSMUFQosfuVp4sNxKzbXcr+QJN+R8cQtk8c6uKoX?=
 =?us-ascii?Q?+JZu2ZWFqJy82wbZfViEOC+J6H0zz37ogDjib48gNYAM2k6HbRIN1TC0ImTL?=
 =?us-ascii?Q?9KrAhmier9bsdjbS0Jp6oUKQPANAZHgygu6HxQT2R9nx9Ni5+oJVx3B2bTBM?=
 =?us-ascii?Q?XWZZUNAY9cIhpqISb8M6bppLazygVl3twjmvpgQ9+Fx8fmzH+rvGBhi8bB8V?=
 =?us-ascii?Q?uAOAdrnUbH2iVazzxtGVVZ4vJeYVIiYXWGUH59HgGgZYoRi/tEaVwFt+JVmL?=
 =?us-ascii?Q?EW1QUWxLjOnjEBinLqFN2Nj3F1w7yRX+1wh65DbneDkL/as5rjabsFWjja88?=
 =?us-ascii?Q?ZP4nWiswI8CgxiWeyai53QIbGbnJOrACZHotrEGW+3a4RNoZFOl02UfXDEjl?=
 =?us-ascii?Q?JYIHbTUFo2dEqTlHuqjviJq/BmkcO0lDveAFvpwsmp1Qj5+skjLaiPd2TiOT?=
 =?us-ascii?Q?vJ54eN6yD29VW6kAjAQ9FwkdapHm47q41lVaCJoMs14gZIarOa91TrEizwdR?=
 =?us-ascii?Q?D7/XABlfbhzcfnQor4twhNzRcdgNXpiw850dzIasDn6Gg2RUoNv0XTDIsN0O?=
 =?us-ascii?Q?ZFT8BTWN6b1L9P1gaTBc3zwby2oxd04IA5SHitIWeQ6Y7k+GcrflLr92ZPOq?=
 =?us-ascii?Q?Y47XEL7ClL/kmpqfNv/stKX/X7A49/pYQvLT2fwxhagOtDvRX6+D/eAck9Cr?=
 =?us-ascii?Q?dBVEjwdGvuDr3qrw3bjfVMd10WzA6LoyFu6/2CEiBpSkBvJ0J2dl15DaFe8b?=
 =?us-ascii?Q?zOzTVatmbqHwyC0PDH4x8X4eUfWsSBGu4XABAxQlpyaEP7F90jiQwivjgPZA?=
 =?us-ascii?Q?/fRiiK77fYs+Gt83eIdY4BhXvTWMVstBCsfg5CPtqObrU/BBfltGfNZZ+U9l?=
 =?us-ascii?Q?JF/2j3CJPEakvnTifhPRqGd+rST44UY8mnbjyQPGu4ompeP29GzPFb0FOD1J?=
 =?us-ascii?Q?ck5EgAJc4zF1jQgoB67hWtGI8Ib4emt6vu9iyc4UGKsDqYITaZneZZudRvkD?=
 =?us-ascii?Q?XKprvpT7t+3wUhcS2QGtHeLoOohTlKfzVRRRf4QjsQN1fHH29k7hwGxIinxx?=
 =?us-ascii?Q?5U81gjiwMvEJqU1ewpyLZV6J2tPN/NsGFYuplC9taBdwb3M/VWpvUz91QJsW?=
 =?us-ascii?Q?ozAxdrc++6P0yQFn3xrYHtMfSnF2q4eASWdxAbCh50cKKEEM1YeVAnbwjxIg?=
 =?us-ascii?Q?O2rqJLKO5XvDEpRGIg1TAAyjyTy73zpsRiybMR14iQzn7kZBEOjXFZlDhxiW?=
 =?us-ascii?Q?cB0lyub/IK+g8KWCRIDLqNyL7H6vKMk+GiTRnA3sjak9AwBixRm7PYPi8SJi?=
 =?us-ascii?Q?i0tHDJLw+NNNqPRs7ZQKrDlQ90CwJqkSLx9UH/rlsRYuysH55dMs8BpR8+EV?=
 =?us-ascii?Q?Fz4efhL0z6SHusL57Nz7pIaHg/tUQnX1OCx5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:42.3717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66582cb-69ec-47e6-36e4-08dde18f0a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
Received-SPF: permerror client-ip=2a01:111:f403:2009::629;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 81732a80c6f..4ba3fcc4176 100644
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


