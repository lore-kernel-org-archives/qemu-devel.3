Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBA8CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9y-0004mD-Cu; Wed, 20 Aug 2025 04:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9v-0004kB-LI; Wed, 20 Aug 2025 04:27:03 -0400
Received: from mail-bn7nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2009::628]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9t-00011D-8X; Wed, 20 Aug 2025 04:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi/agASkHKljaktkUaS6jzW08+fLBCsUdi3+r+eeP6Y6OKyyW8DU4ZHLz8E8mVC09PyfoM/5GVkMwGWvGnz254nr18STpv/UV3U8xbcvebvDkz/HNHzewzvNY5kI4b1rlgcHqs7JaYCIiJHUmUCx0AjtWwfd+tXtiXuk3UgtoPVWLbj7UbsxZPUbEQt7XJ61UW7LOYcYoxHJQ9SG96+O6aJKLYjU5kzXrIhGxkmGZg3490CjE8TsXPB//JT2SDQV0Hh+kbWojLCcKcS7yYzAsFRovbYwL/Exwteq1vX/gzZwCcOzgIKKsID9wrhdAAXfieju63DjW+RkhWBnBrgf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=watG/97eQ7wPhNeOyIDn9UphwU8T+vE1HTtGeyYOoBk=;
 b=i1hSeP2qywZtdSH+/HWmqrPOUCQKE3qctyhad7X4aTB8P9yZ3oxlqgzUAi+ziJzKMRKMiHjRG3cnPLbmXVXE+1y6j3U7MYSU/Z1ElS3S9jkwlYI/TRpPRfvOgMLrcXFBcjvPaUVaIsZmbmefGT86t7cZydyvmqrK5q9T5XxN8GRdgWMu/AqSKA9dGsbBGKxtiKpZO/wUPYHQ+PHuBX2buFGhJ08opoucm7gFFoXvJyoRiXaATOx6dx362mAlL4ju89sUCq1VAjQIYFFz4TlQkcyEtSuXsmlsCyBt+aSHfV0Y7xET+Q2ZYCPPfLSl/mewIJpErkaG9RsdDU2y9x8JPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=watG/97eQ7wPhNeOyIDn9UphwU8T+vE1HTtGeyYOoBk=;
 b=JTYcWQffRCUYPi2Kxgv2R+4Zt+lnYEH6Rqg1Mym0uOneEaWwZGRbAnWxu5gLc6Ec8yo9RNV5Dh7t8egur0B5vN34O4TVZrEkJIXgmHtMfPdKlnrw9FkvQ/U/63Nyj7cq3E4gzcPmz7gqYpCd7d9BCJtq2eBmhubfIF8WPJfd/aI=
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 20 Aug
 2025 08:26:56 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a7) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:54 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:53 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 24/47] hw/arm/xlnx-versal: add support for multiple GICs
Date: Wed, 20 Aug 2025 10:25:23 +0200
Message-ID: <20250820082549.69724-25-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: f68e0c7e-60be-4e13-e2ae-08dddfc352ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|30052699003|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eJ3VOB8cGH7/Nn6GgINCxRGmC/fUCoGLHhIWB+q/wsphlzAoh5hIveSN1uwP?=
 =?us-ascii?Q?fZVxyzVOzhJ9ra/3xyLb+cTcbR2tp4uUiVX2akl9+A+kia+lQZK5dTGhk7uP?=
 =?us-ascii?Q?yP98FAOpZ6rPmf0BG7oBvf10mYNqSkbPrnLGqhkCoAdks9/Rj6zevJjqEQKx?=
 =?us-ascii?Q?LaTc46yOzX7SFNW29zDPi9Pp9HXAvAN9fjEWR7cPD4eyinvDQEK19M+dNMIC?=
 =?us-ascii?Q?FO4RFJOKIvCwPUXzZ8g5thyIYdA7ZioDTQ5+0zxvzZ0uOrNfSn9+RdUGQfQV?=
 =?us-ascii?Q?dfUNK39mBMzyEwaQ36sl7XYfKBfkcEGG0f92Ntw5uJKx8l9yudUojVcjQZB0?=
 =?us-ascii?Q?FcqDcCHuCyttzkzXE4poShQPIFLvCvjm6+0G2TcWBYtPzdvU3j5c7n7erO/N?=
 =?us-ascii?Q?F3JEjQBCDIALZy805s9MBPwI1aLmpx0sjGMV5uPfn6ptGKbiDflX4wrJAC6X?=
 =?us-ascii?Q?CLBBGnfrnqjRMDvOT+yFTcMxxZSkMPM7mvqJTGwCuoeVqzmtfw0XTgD8SCs7?=
 =?us-ascii?Q?B7AkrwqX6kMR1qYsNk3gtGLjULW4qq9x7/nZNTn+X1F0ArrqiiNDYe74bzO4?=
 =?us-ascii?Q?D7jjqFhWKvKTcRa+NzCaY4lbwoJgl/QKAo5FOkClAzfvL1Ihp9BG7p9OFAMc?=
 =?us-ascii?Q?860EFCdA2ILSbaxOahhgFjl+qUN0pav+Eca0TJZJCllW/OVcZesclISCdqL2?=
 =?us-ascii?Q?4nWhvnEFQJidi/dq4H4SjQCkmLJQETZFjarmGgnyxHan4K98YDBJGZWSQejr?=
 =?us-ascii?Q?wHhSfv9xeYmpr/LBGj3+Ju2vuRJn2T7vglRc862znAAVDU+r2PoWCycqHxvt?=
 =?us-ascii?Q?t1QbJnQeyMbOfhQ9ciKeZ9aQJ14r6EiTVg2rUbnHLpcdA69p1TdzylW9eNYr?=
 =?us-ascii?Q?QJ2E1N2FsS4F2NpT7c+f/y1k+7wZ3+HQO/BoH3xNLfu1izuO8mTz4g67lTrc?=
 =?us-ascii?Q?DNM/lu1qBKu9hEHymzJCrFGwdltVsB2utNk5nnvMuBDDdfHhePXRfOupQ9gf?=
 =?us-ascii?Q?1svFrIkwIJ2DCg35rdnMH2ujkEBDWzj76rrZMYB7YnE0w08QGTSe177PAWac?=
 =?us-ascii?Q?brFbegH8AMIw/bzxBplAx5/lW6W96j5CyLLWYktn3TKWN3vpHdLVgPVFR+v+?=
 =?us-ascii?Q?qhAQVFQusv7sUGYiFISjBQ7uzuFXozJq0Ys9+19cXJqhfddoVUm/1FNVeYb+?=
 =?us-ascii?Q?AMfWEhHYV5NN89mkcUEl5l5f5MMG1FgQ4bfHlU1K97Y6pJi96olI7+Ntla84?=
 =?us-ascii?Q?TvYAvjgIHVuQerXHReN7E3IVSiKDCozNPcn0tKx2Q8/HF9LfG5R9cxH5jna+?=
 =?us-ascii?Q?NE3bQNVkZ/pamkKb7XR6XkQm7tHxyXKr5ka3V3Utw4HDj0gM235csAk5tupf?=
 =?us-ascii?Q?E2hDlSB4KMhltXVqsyftr9P68aCnrO5jwZ755RtTvaPcyGvvfPL0n6lF8dUn?=
 =?us-ascii?Q?Ti1yLydjBqLRcCv2sf1gqFm6Plw/B3n5svDS/Pa13cdXz1Wuh7L2Cll+ImVT?=
 =?us-ascii?Q?n7gd0gx2TSmiaIO8fQwydhnobFhcbdFA8nYm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(30052699003)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:55.9215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68e0c7e-60be-4e13-e2ae-08dddfc352ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
Received-SPF: permerror client-ip=2a01:111:f403:2009::628;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
index ba5719d80f5..9b11ffb845d 100644
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
index ba8c69bd435..58cd874f81f 100644
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
 
@@ -318,10 +319,47 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
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
@@ -354,16 +392,14 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
-    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
-    irq = qdev_get_gpio_in(gic, irq_idx);
+    irq = versal_get_gic_irq(s, irq_idx);
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
@@ -502,10 +538,11 @@ static void versal_create_gic_its(Versal *s,
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
@@ -526,10 +563,11 @@ static DeviceState *versal_create_gic(Versal *s,
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
     qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
+    qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -552,10 +590,12 @@ static DeviceState *versal_create_gic(Versal *s,
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
     versal_create_gic_its(s, map, dev, mr, node);
 
+    g_array_append_val(s->intc, dev);
+
     return dev;
 }
 
 static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
                                DeviceState *gic, DeviceState *cpu, size_t idx,
@@ -609,13 +649,15 @@ static inline void versal_create_and_connect_gic(Versal *s,
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
@@ -1540,10 +1582,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
@@ -1710,10 +1756,11 @@ static void versal_base_init(Object *obj)
 
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


