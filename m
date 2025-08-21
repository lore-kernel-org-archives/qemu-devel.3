Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A49CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4ye-0001jR-Pz; Thu, 21 Aug 2025 09:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yV-0001cR-3H; Thu, 21 Aug 2025 09:05:05 -0400
Received: from mail-dm6nam12on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2417::624]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yP-0002z7-ED; Thu, 21 Aug 2025 09:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1cOBGZ0Gzm1LF7phA+vQX/yksYiOnxhEBXyvsvqdtC3Qfif6OSezj2z10OLKlTag5pyV5AAe7Dw74wJf3MkOtHuIm4uCQ1ksr7iZBXkdOO5k7VJgQ6oMhKzDTzByBzf9hs4SoSu0oNmS5mCGapRiQSgZfBIsVNkiNjAxuWjNiaoZnYlXlK0uc/XKFdMCO5aAFjiRRIKPhFz3JSJciFWuQBJ52jHmwsCCJTsHobNyfb1mhd0REQ/P/NLjWIlt2asHnVSF5ILHG4IJqsJ7d2DeELo+/XchmwoV0Xls1vOn6y/gGPCPKvl4HQ/A/ShIHAURS8oWZkTY/RjAXG93fOX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuGRzt5VRpzcpdibJyUHjs6cwUriejOeP4zgtjy86Qc=;
 b=cPncobS9ceWyyRxe4cEVebvG2INwGwBxoWmFB53IlWD2BNYnz286DOHohFcQRlFhn5XWeUb4JOrg0IiEfd8KFG5gpPB2hEth79HewCedlGIE6UF40wYRzlfedOZt5dO+q7TiLnbptSiCrXwtQcpivLcVvBY3yV29ML2BjYa/kp6ofQcSalvmFgcKK0dBT8Ro526NnwpKtS6cbZdxsL2/MlEn70lz98wkB7EuL9DAxASzS9UVluFpgzQH+iQsT5swMl9yeaPIGbYUniEj/E4BySiiVycTekGtjhZfTCx/UqUN5WvbpFcKSz4pdDuc7z4rNDnxgQ2HviAs/jx2QzNnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuGRzt5VRpzcpdibJyUHjs6cwUriejOeP4zgtjy86Qc=;
 b=0mbWCsGVgjCA22p+vC4uI69oP64+j9rhfVDgyQxSxxh91xNvlliB67DtYICx5tNKbKJ/iyjLo3O8szXvAJLoipZ9s/dYTljB+zpgHIeAiWBqp3y2Gy6gAmOj/NJwiieNJNK9vaLHbg3PWMc7HeFh5NdHO/xn+p/P5tH7C6mC09w=
Received: from SN7PR04CA0079.namprd04.prod.outlook.com (2603:10b6:806:121::24)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:48 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::b1) by SN7PR04CA0079.outlook.office365.com
 (2603:10b6:806:121::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:47 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:45 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 24/47] hw/arm/xlnx-versal: add support for multiple GICs
Date: Thu, 21 Aug 2025 15:03:23 +0200
Message-ID: <20250821130354.125971-25-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 016471fe-12d6-483a-0524-08dde0b34edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VdNmN2iiB1J66MeYpvlkS4uBLSHwp/nfLsiPIUSRnymnEMWvXGXa/jQT+ePN?=
 =?us-ascii?Q?dkGFpmAL6tHojM5XaVNTYPsH7qWJtSlbgft26Fierysw0JtBuPRAYZCOCeEI?=
 =?us-ascii?Q?+k2Vriq4Ls+NuGLxdsieuTVlDspyCNFBWnLODaoeKQrkx8aVXK/bK2uRGbDe?=
 =?us-ascii?Q?h4e6amwpMNJYWyVwZS5qWERUkl4iKpKHCDHW+YsuBpcq1RwMmaiUfhSD7Xvj?=
 =?us-ascii?Q?Infs7kfduW6pkvrNP1zcswcS3sPQytHZEbMpytuzRNc6n7es2f+TW+tk/pml?=
 =?us-ascii?Q?BEOHGylo2StOM+MOkQHQSC4fqr9Bbm9JAv3K5vl9KOsGaLHuGlyPcmWd7Nnr?=
 =?us-ascii?Q?KD0zubM095OlUO5mtfRtTjBV0QOqPuvdEilRZUXLgTQ6iu9FpQ7Bg4urVSKQ?=
 =?us-ascii?Q?6uaSh28p6DDXQArBcIx1SdYZvq+XutxWhfk+IRZtF4jPXrDjh0J6x9JbTR++?=
 =?us-ascii?Q?QvlgP/7thfxu62ddivJHryTiA5pb8aYOe+4FVxwJko7ZTjJc+kot132Kcaug?=
 =?us-ascii?Q?ypmAHVFAfdgZqydNaRZ+7oECeFVffCHO/fp43JywOAJcK+osYJew7Mi2axZN?=
 =?us-ascii?Q?mGuOjqxNPDD7S1y7d4CaUl6u+JrDe3UhKIYSjZLXyzaZehOh2/acv3MAhjBe?=
 =?us-ascii?Q?QVZHL6ShWQoSRriUHpn0RUOpB87CzZKi8eLbNAeUHFQ2UJ+ZiNFsPyXEC8Zn?=
 =?us-ascii?Q?9i9mtjh6YheSBPgrHKW+jgr3DXxDfvPXUFqJRJUNVIRSaDgfuqgpzjDvtqOI?=
 =?us-ascii?Q?FMgjntxUYstAj+mU94ckIska+E0XsdIcnHHACzMY0fV3tmNIDyWCeQ4EwsKT?=
 =?us-ascii?Q?5S6yPz0UG7WzaAOml7LfE2CN5jPHgEH0K9sbevq9WkDNw6dKyxVGlHSJccR5?=
 =?us-ascii?Q?jgwbDnulNgVOmbCtcoeCE8Q91Yva/WtYy0V5BJRfmtx7YIweZCp09stUth9P?=
 =?us-ascii?Q?p0oGbIkORDXUnMgdlfVUHvUBKcsKjOKgBlu/yq4BdgfBY7CNJaJvU/narzne?=
 =?us-ascii?Q?ocRsCkklxzm8YjX5kDUIPHuXWGldY5f01Uq/YwY70YkcrOcQXeJRiq+RPg0I?=
 =?us-ascii?Q?gd55/yu1CgWisBkq/REsUqLCaadnj2K0zCDC1v7yxHuS+iCJCAnZQ2hJp0VU?=
 =?us-ascii?Q?M8UtzDIktLjINqSOCa8gkHMahExQpixiaEf+v2E48pUyVfOZEh7UCIR1225s?=
 =?us-ascii?Q?jig52/+5p/XD0Pli8oiApoEkU+fPGbOHs+QgE3IY0zeaAzoPSNef68J1bg9+?=
 =?us-ascii?Q?qfaxVxqvx7vT3tPs5Jl2KLFOgKtIpNOjaYyU8wJGfMhEB5+IEb0ZlHDL6xl+?=
 =?us-ascii?Q?NIAE/x887dv5Lrkfb9SSWw8NCdIypqC6LWyswZChgbW5Pw+cVwqX55uKPbNM?=
 =?us-ascii?Q?ap71QnlKfKs8dCiRJGRGxt/t+cZp9/WV43ORzIC2uWnVhuqxR3t78PAta6M3?=
 =?us-ascii?Q?I+OZcTby15dxryqnKdUAwmK6OVNbqG/9G9Ejt63dvnMWmGWR/qlmnYp2HROS?=
 =?us-ascii?Q?p3mB+sdAIw5vQ4rwmReRwbUez6Hn6ALyG+NV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:48.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016471fe-12d6-483a-0524-08dde0b34edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
Received-SPF: permerror client-ip=2a01:111:f403:2417::624;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
index d11ff5aaf24..60e90356b57 100644
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
-    irq = qdev_get_gpio_in(gic, irq_idx);
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
@@ -1535,10 +1577,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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


