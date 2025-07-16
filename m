Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B76DC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyt2-0005aa-7B; Wed, 16 Jul 2025 05:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrs-0001eA-TR; Wed, 16 Jul 2025 05:56:07 -0400
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2405::600]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrl-0006eJ-JY; Wed, 16 Jul 2025 05:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx6I3UwTksZ3nei2FDMNP3kDGCQlmGL80NS/F5bWr0zSd/oQoDb2zFyfoEARtF8cppymkY6HupuqESt6w/ojygAmsK+vuwXgqkXALLpTZqIQTUwi3wtV65jv1TO++GOAabbSuNJYLAIdmqW3Ji6M+pfPLdFhebW5vacYGtUXLr37z8GZc9zUqvJXu7AdRm8w/YdYfuVoJ/ECWdWF3CQwrUa84ZvN88/NS9xmbpvgXFnhL2ltZcbanjRkljfykNCpV4MIJ9w4mVcnmDv2lBzaww1qxTDReZTy1L6lwvU2TZl/thZy/nZVJIfEl90ey82mqynk9MPA61+G1z8I8I2E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xolzy+AYw3Xsb6mhZA9SNnpmJgHHTFqvGJZmeY+yCN4=;
 b=FmDTIGmEmjW7aM85wdQvfZH3SsFI0G82s8oJn+ubyl7BscXUBJTXrZqtp0UpNY3DKU+8LpEkvKtIvEOrwson6iTejB9hhswB3bvQ2f3KYN30buCNcn3E4MPUnOP9cz9+F1DOBkCNZ2lD8ZYV94NO4qgOhTw8FzbM5vRZ/uY0iZIIBpzG88vCsBUo8l6muSmItqs+FKFN1cUJXfVnlei/fLoUZuumr5Qw32pMbCEOMC7DQapVdf/9eEzao5xtcDNMJASQSQLmVO8lKTAeVWedcAD+zpRt1bFT1cdue87Yy6z1NOgrt/k046yFAE7e8z2vhRJn4Z4gXHE2kO9NVP42uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xolzy+AYw3Xsb6mhZA9SNnpmJgHHTFqvGJZmeY+yCN4=;
 b=My4rA6zi0i6l3ehN1SevefW/nddTHquYsVl/US9wBnxFEhvyEA+aiN4dlhcnDGOxdCLWC2n3KMKDGAGVhmVpKuHahZsJM8i5LsDoiF7YmwWcKD0MLEVJhb9XnCMpL6M7GBl4CAL9ep2fTDgA7qD/R+p4PkQRAJBIbFu6hU/tQQM=
Received: from BYAPR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:74::28)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 09:55:49 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::6a) by BYAPR05CA0051.outlook.office365.com
 (2603:10b6:a03:74::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Wed,
 16 Jul 2025 09:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 09:55:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:48 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:47 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 25/48] hw/arm/xlnx-versal: add support for multiple GICs
Date: Wed, 16 Jul 2025 11:54:07 +0200
Message-ID: <20250716095432.81923-26-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a53c26-b340-4022-3ca6-08ddc44ef1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RvQNxzYEbI4cOTdYI3CGcagEVGNqfl0Wc3PGe89UwcXXo0VIV9qbEFSZc/FX?=
 =?us-ascii?Q?IOFWYqoW+Y72flv9l/BgvFtYtP4pQECVG8zgi8aENbgx/q9TIwKq2qsuZ33G?=
 =?us-ascii?Q?Y4LUtJfcZ1lBtkW1ZJDieoXBrGEaKf4hyujL+NVSVAcS9WnTkGcxvvSb8T20?=
 =?us-ascii?Q?+70kllDgJmtuiv9CwO8XTICc6b79bdTDGMxgF8iD2jOJRtIBgOM9IkncuO4w?=
 =?us-ascii?Q?KunIGZKEUo/TWJS4NtYz+qLVNQ7S0J8LaxBmdBu5NyccD3vnMmu0QWj6MIZe?=
 =?us-ascii?Q?NOi4TehOp6kij4JVxi/0d/aEUiOdaj2hQ2UlC74tb/9dELeA8FrIOPagmtPT?=
 =?us-ascii?Q?LgVTFu4ZJJmh3WuTPGaAwdeIVvb6vkJN0SeFCKapOV6+SaejSefaEn+SsOXY?=
 =?us-ascii?Q?yCt+oYgW6B9h9QnouDazsy/7PGDTcUd4OXbO7RtD0b1BBNaGcftFpsR+rE6I?=
 =?us-ascii?Q?nmVDdxgwc3rpitctjASTKO/mZiQ6qe2glLplCQzs4euR1vh/mEXDHDa+an6M?=
 =?us-ascii?Q?YKUUdtzZvZjAE0uod9aqnAq/iduq/pY5UOGgw0fGjIhKPb+iMRBGjW2dfaoA?=
 =?us-ascii?Q?4wwhmHFAbjZOZq/ZZFa7rS1U/gQs3wvuojgprDXG3AnxBh9QTiJ7Wmb/orm4?=
 =?us-ascii?Q?8eM2UMfsRtwrYqsc0MDW6tDbz6wJiyufadIKtz6SyP3I7VH+jcq70CjustnI?=
 =?us-ascii?Q?CDCwfDY+wQHUJXDoAmzWUxVtv1sLDicFLaDXWGfGloNLYj/MkQEJT8RFDvCZ?=
 =?us-ascii?Q?Z9Lwf35ZNQ57gK49ySYpgc6smJLzmnUTCM7vsOIDO7DzO9m43kBkYNRo1IBg?=
 =?us-ascii?Q?TEp2NmwdcSODAnoJVu1ECWlgu8J5RWPFA76Tie+a5dvEwttb87AquXZRA7zK?=
 =?us-ascii?Q?vf+2gk/J17lnDEsptnN28n3lMF0oOmVcVO0Gej1s3FvG/t3C3+/Gkbrt2S3S?=
 =?us-ascii?Q?TdItmfS6A1Var8dounntr4CCU5vKBUPlU7+89Xm2Rnx7khfD0xrQDkfe1Lea?=
 =?us-ascii?Q?fbFnRNdhsuIxEvyiUUXRT7lW4Vyq+m40AAvaDnFF1TrFjCmcio2oYdjNbj8f?=
 =?us-ascii?Q?V5gCoebFrbTICiv5akMZrvcf9HD0Osi1JI+R5R+J/mNS/Ph3QmdXboNVP9Ua?=
 =?us-ascii?Q?+Go2KqMwmRiGNX9ftFpuce4u8daBEDcbec6AkaLdato23lM+xHihPGBdhhEd?=
 =?us-ascii?Q?l553XWSkTWI7d4NKypDZcDgDwC87Y9nXD+GaIUujpGX+b12NPebG4jFxfaE6?=
 =?us-ascii?Q?WA3hnmQRov7E4uaDrWSY+TmseHXYhTza4iZpv08ozOk1f1jrHfdjmUqYbyTG?=
 =?us-ascii?Q?8agigbtn5JY02FPfqiVz/EIHq8oBDJiNkJkOWzKAnVh2noT8AEMhfvVzDezK?=
 =?us-ascii?Q?TbgI0ywPFtfxSpDbRt8ol54/k6g3+h6VjEVvu0+q9C9nH6WUiXDaoX0uIsPh?=
 =?us-ascii?Q?+UfDthF35deet3wdZz6ERvRFsgmJcA6lfmnAzKKZbMZ1MZBM4jrU9Dmf83yx?=
 =?us-ascii?Q?8+a0Vcj3EhHHvk5wPmcYD2HOrX2BHWkgE4dc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:49.6425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a53c26-b340-4022-3ca6-08ddc44ef1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
Received-SPF: permerror client-ip=2a01:111:f403:2405::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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
2.50.0


