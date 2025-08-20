Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7ABCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9z-0004nK-6U; Wed, 20 Aug 2025 04:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9w-0004l5-I0; Wed, 20 Aug 2025 04:27:04 -0400
Received: from mail-bn8nam04on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2408::616]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9u-00011n-64; Wed, 20 Aug 2025 04:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrScvwZGGg+p7bWu3pSD8ix5yOt6qOM6t94X/vUVAqVGOuljQF3dzG1thJfOFeBx0+yvsgYQmfig5t2R2pVJNIAnlQskbJsbfbDt5STPKJC4Frd5+uTsDab3hHEYIHrACvlM4dfLCSynUqwFUq7jfMrFWD9suF1chpJVMHQxhvQIuGKJMVXF8gIGM1v9YlZqhiZOEeJGHoX/UKLXEloF0zmk2sCyj7zZMW2n6FMfBgZA6bc6AVIkxkwxz9ivHDCU+RUcwJBFhKwk9OsM5Am2+6vM+NXW8goIUC+SELszR4XX52xUDYBo92QFK+ZplZMcA32AJt2B0CK6daA+SnIPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbHvU+F7/a1mhnMh6Fb3dI/mISL7FEfUAupKtLHnx74=;
 b=gT5K8yn2MiF1lDfIOJCE9XpRcS775KqTlkziVWUqCpnC2EuPxBUbyXh0gx2bR/g/w6KeQ272c/5pW6Ils+fsByQoU1lcGDmmZlBZFtORWL2fIafaI02ahhpT7Hdn5e9TYNTMm5sCENK8VxDsyUedkpaf+sU8MNxjHSeZ0WJ/PolioZMsnW3YfUdv9lPAePxB4RzJ8EDCZUYXFReNJHkJHj/qph1qjvWTsddAQ2V2jOdG1YgbpjKCJgvwUZIT/3oWMgT1aiihvOGS509Iia+sfhZC5azkuujPK+Kphaea1IHQHPiLA3mAhttkO6S/rlBvHcyj7/ST9CMNx+FZ9jRSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbHvU+F7/a1mhnMh6Fb3dI/mISL7FEfUAupKtLHnx74=;
 b=m4pAztqHcOKis8QnUcNaChGKraIyDUNYtcb7I9W1axc9j4u2JOntrR0TDdvAFyVAFxV65SSkCQKJFTpPQ7+EOid+c9MLnuKHbXzr+OMwE2qIhPkoRcAIl1cvo8b1m2sssuVqnB8qlWrnySJy/4jy89NXr/Eil2c7IK+TnMp4CvU=
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:58 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::43) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:56 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:55 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 25/47] hw/arm/xlnx-versal: add support for GICv2
Date: Wed, 20 Aug 2025 10:25:24 +0200
Message-ID: <20250820082549.69724-26-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a88177-0425-4947-e726-08dddfc35428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZJqjuIMyMGmdvjhTA6Z2+aOchinyds57JLLcQeWsCJez7ig5Ftdg/OXM9YYA?=
 =?us-ascii?Q?xiV5AbhELIuDgPu/O7erkc/ZrCUc/rNtLTTtjqc334VdLfAbzn8CqcxeDxGM?=
 =?us-ascii?Q?UnLokG6F5VkvNZkW2MC36ppPQiXZBhHvSOwYG1EedX9VQrjYMJa3qActglng?=
 =?us-ascii?Q?74dvf1JCVBxNhWO4ybdyRc2n31qtQzcoaUgUsT4SJE0XU/P5yv8BCtg8e0TV?=
 =?us-ascii?Q?E7Tx+RzPTALqUgLbMX+p0CZ5kVkGPsuPE/fmw46sDsyqVY9u/CdTbiBw0NL2?=
 =?us-ascii?Q?Qw74/0tejUpGREsg0pKEV/V2w+WpBnd4+k9TE8GmhCRfkLqBtKvSwP/wX9xw?=
 =?us-ascii?Q?d9KY2n8tA5+tevAqYS1HQwnKd19rhaq/pZCNLdNdnXkQUbXwsfpjKfrVMv7C?=
 =?us-ascii?Q?AcFeCWXuUg2kKMdX3VVoZArP0dZMtI6Ql5C3fq67Stw5VIfcY8HsoQcp7/Q/?=
 =?us-ascii?Q?ZErU3LStHB1tMrh9KdStOkGEavEwFD+6jUf8VXJCqq7bvjtXr3wqLFJNcFIx?=
 =?us-ascii?Q?lsNR5U2FnBF71TuctcxAWbHHzMds18jZBDKLerzx8JRU1FcdhBvKaTf4vHsX?=
 =?us-ascii?Q?prIZWHV3+OXkYsIapl3KKDkRYl/WfqlHs84rqscRltR2thR0JPoDrbPj1x0I?=
 =?us-ascii?Q?ztrtMjOxQGHQH9ElSHpaUp81zrlhFB8dJXgmPSzU9H+v9uxr2Gnv7bmLxH9B?=
 =?us-ascii?Q?zSR12+w8fGJ9Gp2pWdBSjjMF9f61tcgFtIofvqsp07WXrqpJRZ3gNEJeg2Hs?=
 =?us-ascii?Q?4SB4xOnhqombG1xb1Z0F/pJwjOqcy9n1hpjdesFICs/+O9kEE4v9vVTKKtux?=
 =?us-ascii?Q?c9pwSeiNsQswjlOfIgZl3vML0OD4mqapUj+p+OP3lMwEjb65z7Y7cDCekg27?=
 =?us-ascii?Q?Gq6xaIfqY1RsN/D21NN3uba6EwGcyFsr91p+Bj3fqmvLFX6a0JnwiiBRYUxl?=
 =?us-ascii?Q?VoBv4W4aU91mZhUCxcEqV0tGs4q1r4zheRLATFoPWvhH1z6Qg6wReXS/mwnx?=
 =?us-ascii?Q?lcerHJnRaJpKKB4wLqYsY/5wlmaLT7Nwq2mrTOfJn6fQs6sDMMxEpiPYQAEq?=
 =?us-ascii?Q?xgNF4RprFeA4UqJdK2hkVWL2RVA0Wz0WMTzCIGXWIUHEbv9vglssiqXTUXHR?=
 =?us-ascii?Q?iMTYUhBh0jV0djpsDKvGjnwJXkVH4ScbhnhgS9K5uQP+S4tLFKTmtYZd72Ww?=
 =?us-ascii?Q?W8jZV93dzR2LECiGHb2xchBEAVCCpZG+YI0NvgMBGSvU4WVCf3e/PzfHkQTg?=
 =?us-ascii?Q?X89KVoxbiEnxBAGL3ytVcup6S8100Ed3YmD3zkQSvjMwyaFkTPewESQDoTjd?=
 =?us-ascii?Q?8chuZxnvwl2XW2vWTlqgmds1SRv/J1W4N1mPcdSHf5UGuDUdh09faM0aC3Gx?=
 =?us-ascii?Q?FK8zg4Q0ZWZdZU8My7DDQrJfx8sVQmFzFLH0TkoR9bvhzviUf/cpD6SKaQj8?=
 =?us-ascii?Q?QW4ow8AzGU7UwTyVArrGDVlvLvReeLqLOXgYtr2C55uJBJT8jV384ChGY+gy?=
 =?us-ascii?Q?Cym4Asw+r17vMKeUMUdd8ZvTBIhAQpnkuSDA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:57.8706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a88177-0425-4947-e726-08dddfc35428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
Received-SPF: permerror client-ip=2a01:111:f403:2408::616;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Add support for GICv2 instantiation in the Versal SoC. This is in
preparation for the RPU refactoring.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 82 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 58cd874f81f..771f6108558 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -43,10 +43,11 @@
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
@@ -72,10 +73,11 @@ typedef struct VersalSimplePeriphMap {
 
 typedef struct VersalGicMap {
     int version;
     uint64_t dist;
     uint64_t redist;
+    uint64_t cpu_iface;
     uint64_t its;
     size_t num_irq;
     bool has_its;
 } VersalGicMap;
 
@@ -504,10 +506,14 @@ static void versal_create_gic_its(Versal *s,
     DeviceState *dev;
     SysBusDevice *sbd;
     g_autofree char *node_pat = NULL, *node = NULL;
     const char compatible[] = "arm,gic-v3-its";
 
+    if (map->gic.version != 3) {
+        return;
+    }
+
     if (!map->gic.has_its) {
         return;
     }
 
     dev = qdev_new(TYPE_ARM_GICV3_ITS);
@@ -543,49 +549,85 @@ static DeviceState *versal_create_gic(Versal *s,
                                       int first_cpu_idx,
                                       size_t num_cpu)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
-    QList *redist_region_count;
     g_autofree char *node = NULL;
     g_autofree char *name = NULL;
-    const char compatible[] = "arm,gic-v3";
+    const char gicv3_compat[] = "arm,gic-v3";
+    const char gicv2_compat[] = "arm,cortex-a15-gic";
+
+    switch (map->gic.version) {
+    case 2:
+        dev = qdev_new(gic_class_name());
+        break;
+
+    case 3:
+        dev = qdev_new(gicv3_class_name());
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
-    dev = qdev_new(gicv3_class_name());
     name = g_strdup_printf("%s-gic[*]", map->name);
     object_property_add_child(OBJECT(s), name, OBJECT(dev));
     sbd = SYS_BUS_DEVICE(dev);
-    qdev_prop_set_uint32(dev, "revision", 3);
+    qdev_prop_set_uint32(dev, "revision", map->gic.version);
     qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
     qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
-
-    redist_region_count = qlist_new();
-    qlist_append_int(redist_region_count, num_cpu);
-    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
-
     qdev_prop_set_bit(dev, "has-security-extensions", true);
-    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
-    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
     qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
 
+    if (map->gic.version == 3) {
+        QList *redist_region_count;
+
+        redist_region_count = qlist_new();
+        qlist_append_int(redist_region_count, num_cpu);
+        qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
+        qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
+        object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr),
+                                 &error_abort);
+
+    }
+
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
                                 sysbus_mmio_get_region(sbd, 0));
-    memory_region_add_subregion(mr, map->gic.redist,
-                                sysbus_mmio_get_region(sbd, 1));
+
+    if (map->gic.version == 3) {
+        memory_region_add_subregion(mr, map->gic.redist,
+                                    sysbus_mmio_get_region(sbd, 1));
+    } else {
+        memory_region_add_subregion(mr, map->gic.cpu_iface,
+                                    sysbus_mmio_get_region(sbd, 1));
+    }
 
     if (map->dtb_expose) {
-        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
-                                      sizeof(compatible));
+        if (map->gic.version == 3) {
+            node = versal_fdt_add_subnode(s, "/gic", map->gic.dist,
+                                          gicv3_compat,
+                                          sizeof(gicv3_compat));
+            qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                         2, map->gic.dist,
+                                         2, 0x10000,
+                                         2, map->gic.redist,
+                                         2, GICV3_REDIST_SIZE * num_cpu);
+        } else {
+            node = versal_fdt_add_subnode(s, "/gic", map->gic.dist,
+                                          gicv2_compat,
+                                          sizeof(gicv2_compat));
+            qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                         2, map->gic.dist,
+                                         2, 0x1000,
+                                         2, map->gic.cpu_iface,
+                                         2, 0x1000);
+        }
+
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
-        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
-                                     2, map->gic.dist,
-                                     2, 0x10000,
-                                     2, map->gic.redist,
-                                     2, GICV3_REDIST_SIZE * num_cpu);
         qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
-- 
2.50.1


