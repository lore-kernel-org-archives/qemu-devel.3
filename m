Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD5DCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eJ-0001Ja-GQ; Fri, 12 Sep 2025 06:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007R7-Ti; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-bn1nam02on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2407::62b]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cg-0001Ne-76; Fri, 12 Sep 2025 06:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Azz3YrdKMCisoGv9q8VFpK1aRQ8xfOQ92cTygktjivdDcdD0H+jnwLQ2O3nqod6oNjiZBD9dYSDC3TN+I9TSnm7c62jTocjxSXuTepCzjMUMYllxKG9f1TIxWV6K1XSX52e/rWuAhcvEGSC8K1NR1yonYPEbbHX9PIvnA2n/f1l6UJwSdpBtFog7ENtAPBcSQKj34aPgeCOPp8V4+MX5sNUtvH6oxomcMIFOTK0WCERYj0iu5S0+kkh1WwVbDwMghHoAHlhZAuD0stdbkjQMahrFp+xbMxW45qeJpf5BvOHtDHsW9ZP03xgMsTAt14t2GGFjNSORz9K/6cGsUVW4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jnUuYnGZsm3ArRPefWeeMNDQPdajweP+a3dfiA44Yc=;
 b=nXrpPtedLE1lSNaIDaLFjex/cEi+UCf17kGtPFnsCLVFwMBW6SJ6GKKjymGvl687dLNMKOsiS6OZ6tatqSdXZ5Frttnl6xGC3hJNHxA6UL5jlypw4EC1+FKUyKrunl2Cq1oPuzpJoMmc+nz3do+qvXl6iXLLWfjt1aSNJqh6O6JePC58dA4UCFEGRBqboNsU9uWhksCbZrwkxJateYDpLgcuKzEPpOUzFOt75SJntMQve9lIshYVIpmjPB+XVeJGSS/dKO017PchZv066bAFkeHFsY02RNo+DscL1TLxAUFsu07ykmU/CALGgqMt/jRKxZXAPbCoONXm5hBJe4UYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jnUuYnGZsm3ArRPefWeeMNDQPdajweP+a3dfiA44Yc=;
 b=O95fKyIYm8jYQdb1T386RY0VhIcR9+toNqwwAUCosIYAqDPDZDXyWI5aZRzU2NJpm2O0aklknZGp4dUfw1LuFzHtx1e2zdTCliv08WyIFfdzcFKEtm3IeuDeJ64bsmZYPjh9gLqRssllImMwPeQ3JNcqX40krw8/H8Xxwua7JXQ=
Received: from DM6PR02CA0059.namprd02.prod.outlook.com (2603:10b6:5:177::36)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 10:03:13 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::c9) by DM6PR02CA0059.outlook.office365.com
 (2603:10b6:5:177::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:29 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:27 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Fri, 12 Sep 2025 12:00:47 +0200
Message-ID: <20250912100059.103997-39-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cea645c-3214-4bb4-729a-08ddf1e395d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F6RlRrpqqVOH8X9flIor02s9lGm/UCZSAzpB0n4ToYy62TD59YU6miLOw/Pz?=
 =?us-ascii?Q?EYpunyLfK7JBGzGX1QSP9MBTHmtlRE8w6SYtNJPjk+NMD9p/+7izeA2vAwCm?=
 =?us-ascii?Q?KPCZEs2dRFMVBE0dfUdxNveWSLNxtuFquzlq5biJtLnV/GAZCIW6mlfBTyfG?=
 =?us-ascii?Q?UtWYISfsZeGPBCOP8lE2TlIlO9LO0DVeCWiWjpz6w+T3vs0gCkZ/z67UCrTJ?=
 =?us-ascii?Q?thkP3yRnEJDdOD2u19OubP/wvLJxVhRNb5EHJuDTPiREY4oX2ICACLWNY7iV?=
 =?us-ascii?Q?+eyGpS/o+Em2P+jZElt74QXJfapi8H4t8EKT3EMbtWNmF5o0bJunimSyZLSE?=
 =?us-ascii?Q?AUzIHyQYCa3KEzzObt+4u6hPhfzQXaJvqcsekUKGx0yO4UnCiQfslaigWjaX?=
 =?us-ascii?Q?cuOhzgNpvPrjoTeaC6wcgOV42rDmCBN8b6P+hxe4lRj9VFQ/VIr+kPxX3yiX?=
 =?us-ascii?Q?X6vP4XcgjORsZ/YPLK3tL0Lq+HfXe/QQYRxgMDSNPwGibyMZ+ZAafpPr6RRN?=
 =?us-ascii?Q?cAGpOBlO2Z0ZEGrMScFGymq1Knxcxq0Rt0v6Dk2yHB+y1hfaCYFYUvlg32TO?=
 =?us-ascii?Q?47SU+kfcLqVdqiAuA+dnE6urylOgb//ddxExM7gWYP4awtoa1jA0NdcuTNZ5?=
 =?us-ascii?Q?HWqTr7avLsr6Zo6hF1ED8ELbSskja+bxPGQHN8a5zAHOqyF3yT9RH061BT/a?=
 =?us-ascii?Q?iLCaNO+pRA986wvu9Y1uztWfCeQHThjAi2dp8BfEwv324+yAzxwBvcNPqd5E?=
 =?us-ascii?Q?/jhQO6K5ysgJMLJeBBY+FuJah8g6kXJRsoq7xaF3aLIvFOK6uvndZPvKrHrw?=
 =?us-ascii?Q?r2QeS/453MXdPvomZr0g80nW1rHU/QFoHsd/rpukt37kIuxjMcMK3ykJH7wC?=
 =?us-ascii?Q?UD4A7Uar5A0QN4uwK6sDnKZwhK0pFYgFph58CVuW6H/Kq/zh9pcNwiSbNVEP?=
 =?us-ascii?Q?CdDxowgCStPSzsDmC2kSx3mdasT9vGEekt/ZmuUVOGHNi9D7Y/kvQX57j3ND?=
 =?us-ascii?Q?Yt7UaQScQot7iiLdxcOmOZHEV6fncNg3PZ8wXVUA4QaO80TesxS6K3NlY9HG?=
 =?us-ascii?Q?e+rnisXKf7NT3l0ktzLzt47oL51wPxwc5d8CjMVNlX24ubUiHe/YkEpPkTFj?=
 =?us-ascii?Q?LrCaoPZd7PYDJIGrxEUuo8bEr+oFfqOmdWyqpF23ryLcQeCflDm1ocDf6OQV?=
 =?us-ascii?Q?WNAs5yCTvIWqokVRa//qxnPOSkUIIrqAV+9trTXCdlOMgiRo8H1hWQl2yD6X?=
 =?us-ascii?Q?I7OjN+jpIZzdn9g/GieJcZgVC5dWnpP5LF/gmqrx1pl1u0yZsGGFzHpIZBty?=
 =?us-ascii?Q?RH1y10tV7dlE1JTzn94mqxYV32e7iWbY7dIENu7F3yrqMU9RBLbcEG/DQPGm?=
 =?us-ascii?Q?QDh5TzO+piTRX3UFO4QG1Fhe7XnCLiTQEL8nU/sk9WQLp/mnKhWZKb4+lE6A?=
 =?us-ascii?Q?2JlJOx9re2iA9KS71AW/RGYeqfvPv1bNbmtXzPjl+P1UKq0NpuYDx7qOkcUt?=
 =?us-ascii?Q?37LDShXnHtF+K4jgA+NUrQYQFZgl2i/cRAmh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:12.9592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cea645c-3214-4bb4-729a-08ddf1e395d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
Received-SPF: permerror client-ip=2a01:111:f403:2407::62b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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
index bf474bdf37d..d92d8117498 100644
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


