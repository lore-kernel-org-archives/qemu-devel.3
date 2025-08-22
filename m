Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37290CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXK-0000vb-Sr; Fri, 22 Aug 2025 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWU-00084I-1g; Fri, 22 Aug 2025 11:17:49 -0400
Received: from mail-co1nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2416::60b]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW9-0007Ca-Sh; Fri, 22 Aug 2025 11:17:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFb7hcP/HpzrQMboeFl5aaqu2Ejh0g3F4qKs4oCbhDMbzuJNPi2Yb5mAYaiPiYKj7b5HqRZxwCV7DIHPh/hYVYvmAOT6KfP+QhhJJJ/HSHuE9L8CDoOYSRMU0a9DsRnpsGBk2iT0fzMv5nsnwSJD+HRfvBt8r3j3yix45Pgvvnahk5rHFkxWcRpiAaKCtsS5tz/iAbtuYYM6mwDmCfIibd7A7FUhjZWxbqR+IwVZ5YLYM9r3eEYE3ZpcjM9bCsdRtMJKHqvVlALcOceUctP2WJJAtgyBbcgkJ+UOPQWQzK0L9JmAJ3aGzYxDuF/4vhSUEuhmDw+R4RugGMSH/JDY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0b8gCpRrvg2C0sh0PFYvCzZCk8xoCJvqffXLiwFehs=;
 b=h6rolYpjchReQkESa8ywWgOlSoewvL+3RBauEDTZ2Oy9MAcz0+B8jgpYmTl6hFS+e7mMBc8Aq2gqfcbNi5LDIAtqajxMgLQH1NhfXEkeAJCOlppG4KWBOkcN8tTRcefp4vMlbWCiMPlZS1WSr6lanO4rua4z5CiSEKIVBud6yAKgNW7xkVr/+rhHJ8YDK/Al15Za2gLWf2rKANPjz+shfmLkZZA5HgCMOKfRcvg90A+6un26Wj+uaf2NFFXDbqtLLenzAnpCNZv8jM1Jy2HJez5frDgUKpltZNOeVB0DdDGfMWPtDwr4keAOxmugWc4InJIRW6QSwpQC4P07lg4giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0b8gCpRrvg2C0sh0PFYvCzZCk8xoCJvqffXLiwFehs=;
 b=H//3d3HUiCXgF/YlQfoh5LZG3NpAlIXNSAKkMB0TS9fA2TNSgCh4vI2Pqm9f5yq/UtcnnJAhmoHMEadz4fyUkLg95wbgYIcyh3//AptU3mvdGRakUkS0P/+yKFPezCsDbTWAC1Z5JZlcqc0YFsMI3ftbly/7gZzYMA9DQiCV4qs=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:17:17 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::63) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:12 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:11 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 24/47] hw/arm/xlnx-versal: add support for multiple GICs
Date: Fri, 22 Aug 2025 17:15:49 +0200
Message-ID: <20250822151614.187856-25-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 308230ca-dc17-4c90-8ddf-08dde18efad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bzZsykjgrNubyawAFFRx1uTnoQUpxfFQHCJpYPYb+oAklBA1DzVzVQUDkt/i?=
 =?us-ascii?Q?EKNci58gr1C5t/LuWuRigm3GkZpi3OfS5fB3OUeUtqrtT2qMrE/Y6FEGpQgY?=
 =?us-ascii?Q?6HioNclHtHkroX9wY+OO3oSeRh+Kb1MOuVElZMfUEeHy7imy21omAR0ru7OE?=
 =?us-ascii?Q?FM2ra07mlGqqs6RTPxSjvL+AoclZ7me3RYmxQVS3MHbvfZo4wzak2vDbhMq+?=
 =?us-ascii?Q?JAdxT3maBR8WFbSsjnWam2Hzpv35E7pXgXprZHWHayh572lTXgyZt2XHjxST?=
 =?us-ascii?Q?5gVQh/lscwl+YgzoI7L6WCppPQci7eFumbmLrOxeAVN+YRMwDZ2pXESdo5ml?=
 =?us-ascii?Q?WSzeSGUE3emqrdLDCwGjhwuisZh87cDrez9Nebo94EHaqC8gvg9Z27nzHkWM?=
 =?us-ascii?Q?sLXYjwMUtUaWgmR9AMGcXArt7RkaVxHXXmLaUvxiTkdIY54iRjWLyJOc5d7m?=
 =?us-ascii?Q?Rh2akB0n/MmwpkTqYYIBTAeJ3yymxKxawlvyZuChT6Q6Iazon8k6KEKDed6T?=
 =?us-ascii?Q?wPx/FzmJNgdo5iV6etrm5nooQLKMH9R/R7PoD+br7U2rTHLJ+i7aC6x6Fkcq?=
 =?us-ascii?Q?bRBn6dfMXU2L4bX4SzNODOQjvyi8XtDLamdmpe3vxzJNAZ/RjiRyZncUoJ6m?=
 =?us-ascii?Q?MvoyRPa3jL+L/XEz836ETpOyr3PvTgbHX0Nb1hnlAxRgUuJDeNGttHFEXZs5?=
 =?us-ascii?Q?VpltPBwyDiUF8NTmAusYXdeXbJxdOBcAxtFSk5V7vEEoJ5oKgHDxTn9mMP6U?=
 =?us-ascii?Q?1BsRTKJxJ4Pr+MJD+iGRz56wPr6PUedMvnvZPVzbvZU5aYqxWN03yiFiE4uW?=
 =?us-ascii?Q?cbNivxCnG+8CH71S9BJbU+UhUh2Qq7fFdQGQ8ELuUArwagpQ0dAA6RVy8O8y?=
 =?us-ascii?Q?cd+Um8ebgKiZdv65SlidJRhK3w3WXApBaSvj6GJ44ZRqXDkVny2eJgpm9+/z?=
 =?us-ascii?Q?lG5pprgZ5Nx3Km69AIwH7ixlhDRAv+VbLMUjlrDnj8Cvua0RsnMvszlCgHXA?=
 =?us-ascii?Q?j2rTwgT7spiwPlcxok/cl9SWaAmAXpw41NDdIb0Zfkxx7yqLAj04hZ+XkFMJ?=
 =?us-ascii?Q?tWFVtxYfBGziiVB4pMJYjTFjfLTcmX3bl/NMJCelSqR1aQ0GJoX0S6T2UCa7?=
 =?us-ascii?Q?Ng0JKrhCufJXtuEBT0GgqZGCDxMi3q6KCSWu8i7RVQG4mpwz1SReSWyxrP7G?=
 =?us-ascii?Q?zuTI3R6Kqu3oRYhY1Vp6/yUnI9lmvJTIY5iBiwhOlVwzPzm/UM/UwgcPoFRI?=
 =?us-ascii?Q?hqTFwv1DAiGlgPmfjvY3meCFpIJDlYwkZi6LIL69A66pSex09gqSwssMLGFg?=
 =?us-ascii?Q?zu4lFvtYY5BinXViOZAzmE7lDkLRFgIhBBU7lUpsfRiyg4iTyYQ0gSWnE+eb?=
 =?us-ascii?Q?WBKmJP6sJDiAEPEkrg53I8djAaYqMTknnjCrLiF8tXUZmRsHn0bGs3nJCe55?=
 =?us-ascii?Q?UIpUjEymcoreShXgdd6iQie+Pmdlcp28mPbQDf9YSqi1XCoRLluRwyOJF7no?=
 =?us-ascii?Q?muLfZSzfrc91xK5UcvR3aRQ6mtitz7/Tq6RV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:16.5291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308230ca-dc17-4c90-8ddf-08dde18efad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
Received-SPF: permerror client-ip=2a01:111:f403:2416::60b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

The Versal SoC contains two GICs: one GICv3 in the APU and one GICv2 in
the RPU (currently not instantiated). To prepare for the GICv2
instantiation, add support for multiple GICs when connecting interrupts.

When a GIC is created, the first-cpu-index property is set on it, and a
pointer to the GIC is stored in the intc array. When connecting an IRQ,
a TYPE_SPLIT_IRQ device is created with its num-lines property set to
the number of GICs in the SoC. The split device is used to fan out the
IRQ to all the GICs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  1 +
 hw/arm/xlnx-versal.c         | 55 +++++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9d9ccfb0014..984f9f2ccdd 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -40,10 +40,11 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
+    GArray *intc;
     MemoryRegion mr_ps;
 
     struct {
         /* 4 ranges to access DDR.  */
         MemoryRegion mr_ddr_ranges[4];
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 79dbafe3a7c..706d4eb733f 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -43,10 +43,11 @@
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/core/split-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -315,10 +316,47 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
     g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
 
     return versal_get_child(s, n);
 }
 
+/*
+ * The SoC embeds multiple GICs. They all receives the same IRQ lines at the
+ * same index. This function creates a TYPE_SPLIT_IRQ device to fan out the
+ * given IRQ input to all the GICs.
+ *
+ * The TYPE_SPLIT_IRQ devices lie in the /soc/irq-splits QOM container
+ */
+static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
+{
+    DeviceState *split;
+    Object *container = versal_get_child(s, "irq-splits");
+    int idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
+    g_autofree char *name = g_strdup_printf("irq[%d]", idx);
+
+    split = DEVICE(object_resolve_path_at(container, name));
+
+    if (split == NULL) {
+        size_t i;
+
+        split = qdev_new(TYPE_SPLIT_IRQ);
+        qdev_prop_set_uint16(split, "num-lines", s->intc->len);
+        object_property_add_child(container, name, OBJECT(split));
+        qdev_realize_and_unref(split, NULL, &error_abort);
+
+        for (i = 0; i < s->intc->len; i++) {
+            DeviceState *gic;
+
+            gic = g_array_index(s->intc, DeviceState *, i);
+            qdev_connect_gpio_out(split, i, qdev_get_gpio_in(gic, idx));
+        }
+    } else {
+        g_assert(FIELD_EX32(irq_idx, VERSAL_IRQ, ORED));
+    }
+
+    return qdev_get_gpio_in(split, 0);
+}
+
 /*
  * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
  * used to return the corresponding or gate input IRQ. The or gate is created if
  * not already existant.
  *
@@ -351,16 +389,14 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
-    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
-    irq = qdev_get_gpio_in(gic, FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+    irq = versal_get_gic_irq(s, irq_idx);
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
@@ -499,10 +535,11 @@ static void versal_create_gic_its(Versal *s,
 }
 
 static DeviceState *versal_create_gic(Versal *s,
                                       const VersalCpuClusterMap *map,
                                       MemoryRegion *mr,
+                                      int first_cpu_idx,
                                       size_t num_cpu)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
     QList *redist_region_count;
@@ -523,10 +560,11 @@ static DeviceState *versal_create_gic(Versal *s,
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
     qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
+    qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -549,10 +587,12 @@ static DeviceState *versal_create_gic(Versal *s,
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
     versal_create_gic_its(s, map, dev, mr, node);
 
+    g_array_append_val(s->intc, dev);
+
     return dev;
 }
 
 static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
                                DeviceState *gic, DeviceState *cpu, size_t idx,
@@ -606,13 +646,15 @@ static inline void versal_create_and_connect_gic(Versal *s,
                                                  MemoryRegion *mr,
                                                  DeviceState **cpus,
                                                  size_t num_cpu)
 {
     DeviceState *gic;
+    int first_cpu_idx;
     size_t i;
 
-    gic = versal_create_gic(s, map, mr, num_cpu);
+    first_cpu_idx = CPU(cpus[0])->cpu_index;
+    gic = versal_create_gic(s, map, mr, first_cpu_idx, num_cpu);
 
     for (i = 0; i < num_cpu; i++) {
         connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
     }
 }
@@ -1541,10 +1583,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
     s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
 
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "irq-splits", container);
+    object_unref(container);
+
     container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(s), "irq-or-gates", container);
     object_unref(container);
 
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
@@ -1722,10 +1768,11 @@ static void versal_base_init(Object *obj)
 
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+    s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
     s->cfg.canbus = g_new0(CanBusState *, num_can);
 
     for (i = 0; i < num_can; i++) {
-- 
2.50.1


