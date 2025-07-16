Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF593C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyu9-00015Q-UD; Wed, 16 Jul 2025 05:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrp-0001aW-IL; Wed, 16 Jul 2025 05:56:03 -0400
Received: from mail-dm3nam02on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2405::615]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrh-0006dH-IU; Wed, 16 Jul 2025 05:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE93XUJalSdHzv/6JXJJA/bZPvWtSYRbLjc87ejLtSKaJzE0gdaR8usxl0bWhJ+TYflIxfDZXoCs0/78Bygh1Zukie5pby0MhbFZqyqHFEwLF6rxrHWRa7Nb9phuOI3yqCgmpFi0c/uCOfOqHky3pluYQzHjGYs0LOJ7x3nkUXqXfRlyw4gg6h44znrEl9dSYgAmRW6ogySaYTv1ZRSeTj0hKY6/keEhKJ70rLE8dVidtGlguQhLD9pdPHsKvyy13ZDLOgekBaAuzbSvZSgJTLbj0R/F2mmeJa771ifS0wAC4UiImYDvEnlViN9iPWOUKCMKv5R9qgqf93uGw3ZnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqBzpzviTqRBj2ud2c4AWXwQ47o1ho49gMHV6iG8BrY=;
 b=kTO+erObDr0UjyB4zZiFPWIz4ZIjYXiQRke2VAGbPkmoWWZBp5QwBbP/e+4UVTn06nCuOQI2/KF5t9lwjMQW8qkAdz5GWwbA7QPO1sDR9Fhp6xv4pdj1mGfnXXrQWh9pyXzXGGLFdcGeEp4A9aAIUghf6PVIf/ocLB1Iz2o/zCEVGUtKLk0h+H5cgJkms260UOsTNnLAXA3jA0iD5AEW59nJiqRPwA6MydCiIahpmqKAhTixXRmadpMJ19hqN7dPN9HBn+4KutdAuce+9xAM5bGCUshqF03HSoiZoBzb7lghAOIk5V0ysAA552aQucJtC380uzHfzCcBsRpY3ZAM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqBzpzviTqRBj2ud2c4AWXwQ47o1ho49gMHV6iG8BrY=;
 b=tbLeaGCYUf8/rnAQ0KLUjxDYsGejJO6hVTln8Zyw3utL7vLJLsN809yJBoIR4GNT5H418UX8FkIXhyvMYugY9h9l+gOHyIcLeJyd9HyNZeBUJ92g7hIf4dKb1bCa/7KtziOQjZxJSsdrnd/yGCNleGKdBv7UIFSrcUXMbKI3byQ=
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:55:46 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::26) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:44 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:42 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 23/48] hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
Date: Wed, 16 Jul 2025 11:54:05 +0200
Message-ID: <20250716095432.81923-24-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 064d3600-39a8-458a-6211-08ddc44eef6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2wYHOZJQTT8E166dMzE5Ls8PVvb/IrnBH4MIyCv68esCpYIutfDjXysGUQC0?=
 =?us-ascii?Q?SUX2BxuACRLJnvRtll7zKO7Hb3kmtW3y8YdE6T3pN6LDfagV1IB8bCx7Z4oW?=
 =?us-ascii?Q?ouJnK31XEjGlc5GBdHl6NjlJX9SJeoWjanqcJ36EPl3gKekc4mmNHV4DB2uf?=
 =?us-ascii?Q?I1bXfAQzQhkjvpTJQnxSST9qsHwGFvgDGrayeqYwwwQMOVlYaJ2PF0LGVOTp?=
 =?us-ascii?Q?x6BXSLTLpBAscJOpXippzLwwoQ/BH98c9mS6ZftojlPIiz8WtGW+D5ysA4vg?=
 =?us-ascii?Q?BVWZOC6VxIbuppbxRA7kqG92a6SxT6iR0ZsGc1M1JneFdRcalCjLHiqRTKvL?=
 =?us-ascii?Q?ozLZ4S1LJBoVBas6vf0IFz44tRTdBFjE0XZDOqKvnuWbKosmCB8JBn4jiGmB?=
 =?us-ascii?Q?pnlZB8ExY20kYh5i8S0P5vWLEfhJE1IHeaFFOwSLDvIjKHkkUHOlD6LO4lXE?=
 =?us-ascii?Q?eC32dcHZQ80Eih/gmgT9yGgK4rwZHcCnov10oi4zC77yEJyZjkkcRDKW+NNs?=
 =?us-ascii?Q?DzdPKcY6proqFt1OAYBTxMJP57NL79pCeFAOeW5S5jnHgoMj2EvdT5B/gmrN?=
 =?us-ascii?Q?gHG1+ynRfLvK4YtRqTcVTDsm6OOb429yAod5ehkXI033W4riVbQRgDCUM/Oe?=
 =?us-ascii?Q?VrlNhhe+mH+140LtQQS76ad44Smenfpk+vymrXrvXcbzoBc5MdcgE6ph6F5T?=
 =?us-ascii?Q?FfV6Qxwyid5ezd5T5Grw2NxuRbG3tvgCXC7VwNOLrVdxK1KJvvmkQUqH/lKV?=
 =?us-ascii?Q?0/thTlIftYOYVu51GgDuyopcom/WY6D6B6tJO7Fvju5gBHeypNel5LuNPAtz?=
 =?us-ascii?Q?MOKsOMbg2G3b6qqv+InpaTZp91kPZsrnFWbyDIcMFoQj3Fpn1G4ZuiXwhTgH?=
 =?us-ascii?Q?gXp6Mj/6sjFjruaLZy9XVJANHTF9zBhwGJgyzNUioPCtg82OZs1LisUdCBXM?=
 =?us-ascii?Q?kHiJ6Tk9No0ViP3RUPDCaKzLkcHC0FUMIP1JnyIwinseNZT9UL4DjZuDCGkU?=
 =?us-ascii?Q?hzvxKzjbnDGdQ6e3u0+QQNkj79ijrj70OMDQWe5haSKHIHQIa7weXQsBj/7U?=
 =?us-ascii?Q?QA2X3hZkikEDb3saWLbt1/m6JHwbKSvVxpONYyzXEashjKS3nR2kkAW3x9fz?=
 =?us-ascii?Q?HMJzHnCUSPe7klHssEuTEPwtq9fM7/ZYgMm5TyIB2UDXgdOtiu5pQU3ce+qf?=
 =?us-ascii?Q?ZDyJ9MGhCbcU0BFx02P6QDfcRyZSU3JOmc7oDEQ6C6V8i7flRDae1pryk0QV?=
 =?us-ascii?Q?Y3T6Ho0Qv0T3I4LLT2t3m8FwgoyPS2ro23yyUZ/RIFE8rkhhPEIQUhC8V5ua?=
 =?us-ascii?Q?KqAj7vawCRhut+JtnT/zF1izTDnXLePFQRbiTXglhflfYoCS2XO6TDXa0X0F?=
 =?us-ascii?Q?7DePhTGZds/bHcoXUSnOUfH7OaAx5kbyJxlT/UOMjzi0mWnpmnK8F3JVyrlP?=
 =?us-ascii?Q?dpOWaIF2vHqXItXs+aYW2crqqkViwhI4Euhs+fXiTPSZxoVecMaDuV7YDdXg?=
 =?us-ascii?Q?MeE3OspdGna/CtpUdkRCB25Mhj7vzEb/UB2A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:45.8353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064d3600-39a8-458a-6211-08ddc44eef6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
Received-SPF: permerror client-ip=2a01:111:f403:2405::615;
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

Add the instance of the GIC ITS in the APU.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 35c32de0159..ba8c69bd435 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -42,10 +42,11 @@
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -70,11 +71,13 @@ typedef struct VersalSimplePeriphMap {
 
 typedef struct VersalGicMap {
     int version;
     uint64_t dist;
     uint64_t redist;
+    uint64_t its;
     size_t num_irq;
+    bool has_its;
 } VersalGicMap;
 
 enum StartPoweredOffMode {
     SPO_SECONDARIES,
     SPO_ALL,
@@ -216,10 +219,12 @@ static const VersalMap VERSAL_MAP = {
         .gic = {
             .version = 3,
             .dist = 0xf9000000,
             .redist = 0xf9080000,
             .num_irq = 192,
+            .has_its = true,
+            .its = 0xf9020000,
         },
     },
 
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -452,10 +457,52 @@ static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
     memory_region_add_subregion(mr, 0, root_alias);
 
     return mr;
 }
 
+static void versal_create_gic_its(Versal *s,
+                                  const VersalCpuClusterMap *map,
+                                  DeviceState *gic,
+                                  MemoryRegion *mr,
+                                  char *gic_node)
+{
+    DeviceState *dev;
+    SysBusDevice *sbd;
+    g_autofree char *node_pat = NULL, *node = NULL;
+    const char compatible[] = "arm,gic-v3-its";
+
+    if (!map->gic.has_its) {
+        return;
+    }
+
+    dev = qdev_new(TYPE_ARM_GICV3_ITS);
+    sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(gic), "its", OBJECT(dev));
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(gic),
+                             &error_abort);
+
+    sysbus_realize_and_unref(sbd, &error_abort);
+
+    memory_region_add_subregion(mr, map->gic.its,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    if (!map->dtb_expose) {
+        return;
+    }
+
+    qemu_fdt_setprop(s->cfg.fdt, gic_node, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#size-cells", 2);
+
+    node_pat = g_strdup_printf("%s/its", gic_node);
+    node = versal_fdt_add_simple_subnode(s, node_pat, map->gic.its, 0x20000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop(s->cfg.fdt, node, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#msi-cells", 1);
+}
+
 static DeviceState *versal_create_gic(Versal *s,
                                       const VersalCpuClusterMap *map,
                                       MemoryRegion *mr,
                                       size_t num_cpu)
 {
@@ -477,10 +524,11 @@ static DeviceState *versal_create_gic(Versal *s,
     redist_region_count = qlist_new();
     qlist_append_int(redist_region_count, num_cpu);
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
@@ -502,10 +550,12 @@ static DeviceState *versal_create_gic(Versal *s,
                                GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
+    versal_create_gic_its(s, map, dev, mr, node);
+
     return dev;
 }
 
 static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
                                DeviceState *gic, DeviceState *cpu, size_t idx,
-- 
2.50.0


