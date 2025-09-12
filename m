Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2411CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0df-0008Q6-37; Fri, 12 Sep 2025 06:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007QN-IS; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-co1nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2416::628]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ce-0001Mb-Ox; Fri, 12 Sep 2025 06:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1VTBMkDMA5O8MhvehyXitpixwxiM9PI3Q0rXIGa5HBuG9+K47+8ZWpEqNfp1x039HNED5NmkLKtWNDas/fpHT47b47B4pOoS/RP8gi3ZMHHvAU9qyEgyxEVi7rbUrpXiY9wQW6hIgOi6QaaZTbczTHLDTJvKHkx+b4xwjA0RfM99YX6q134odgdKinwyDlTfez6ZtD5k29H5Lr7Ih9Hn6dsj34V5AGpTQ0yN/HvYbuy/3Y7pp4Nu+EvSPGs1V5bOCzG+Ui+uxq5JSZ/Lp/fwVllU1lPMVAxzkqjc7qEs42gmSKVb+hA7XHef7zXkxOdxWYj4HLr6f0LUJExoGHx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUokdPI+Nu5pddVZi7wMvKWlqmEOmDDER/Si15Y8W0o=;
 b=Q68OWeGBQlH80lFmMpHpo3Gz1KWGn0Ul/K8+Gj9jrd6Lepte+JR7DjUI0549mzUH0+BJGC5ji/vNhwkGydl/hTstkC0XBO5D0EO/SU9QpUmgFq9PZMNgLf9oKFrVxY4Q1H/sb8OzbOxC7O9EVQt24FKs6t6E4h+kd+7GoUaumehsQl9sSFigAfWljXdYUX4PHbwgr2ai9Op6+Fdo32e1GS0GEWvWji8B2s0xtgjpQjrleygFmcabOk14ziOpKj9ACrVGjlt8cf1C3mwrIuJ9EyhzlUjd8vxT7NtengoBfdm7UyPWQsn3ex/N8DQwxEqONdS20lhF3z3NJpIboWqOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUokdPI+Nu5pddVZi7wMvKWlqmEOmDDER/Si15Y8W0o=;
 b=z4zswzmVq7CwAEsq4SkHJwmlV62Px9OH0S2+InpcAXMerB5JwtCYuVi8AKu+OA19T2nJjZ9OtqC03OKdgyK5UkRF1B2Yk6YAEUTYsSE5IelRoUTgYgOaaNzcNhwO9iSlQszgFQ9SQBNNSXeB54KwiMWYOovoNrwVGpDtqogVeFs=
Received: from DM6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:5:177::18)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:05 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::4) by DM6PR02CA0041.outlook.office365.com
 (2603:10b6:5:177::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:06 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:06 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:04 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 25/47] hw/arm/xlnx-versal: add support for GICv2
Date: Fri, 12 Sep 2025 12:00:34 +0200
Message-ID: <20250912100059.103997-26-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4ef4d7-8573-48b9-efd2-08ddf1e39138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ail3KYb0hXsWWA4iTYuFVukAGlG+mzIwF7XLCO/mvy43sy60h9cAQKzBltMU?=
 =?us-ascii?Q?g7cT7EPZs7B4RIlerrFbC+bx+dHt+JUOqneykM+RxKLmdM9360yu491jfSRf?=
 =?us-ascii?Q?gcUEOQcN+X2tIP+46kBm/maKfK5HrXKTkJ8yqnQukwOb5p2dfhOJb1OPN0Wq?=
 =?us-ascii?Q?4wI14oIkJIl0tlEPF/1c5rS99xgHf3vDdUQ1QhBMYCsFoNkbLfekMTj51yUO?=
 =?us-ascii?Q?vQaOoXHA5bMmpazybwLwAL2kB925dVPHTr6qcCsGpPL25D1A/YcHabM/enpz?=
 =?us-ascii?Q?pqfutCa7/tM3b1t0hHDgn2eCVj6nH+eQF1ZBZh3UVg3G2Mn9CBYmUoGhbU6J?=
 =?us-ascii?Q?xywm3Q9FdonGkLp8w893lkz892AcrxLQyttipvZaA5LlbV+UOWcIO2ah0afL?=
 =?us-ascii?Q?PEh4SXeXQcFTiN5zOq8r5r8H7fuUcbryWUBfdrtMVv0TVuNclcAOkNAQARZz?=
 =?us-ascii?Q?ocM9Jk7H+ogjO7p4tH+5nggNqxsT2xDPw4HbsQsQwDZpsXT8/vYGv1p1tFUs?=
 =?us-ascii?Q?J+sjWAXKha4qSoD5BsM3vU1Dgfq9+qudf6sRxCXAKKnPpavwglgWP9WkiRuG?=
 =?us-ascii?Q?sxyuAOYOabG4RrouXopFzLfPWiK+t4YEcJHyx8QfwUZZ9sTG/rrcIkcPh5x9?=
 =?us-ascii?Q?P8KDaQlf/8f/5MUMx8CozX/B2NMulVp5HVoqDNKCsJUhcmuMRukJNoL9u3Wi?=
 =?us-ascii?Q?bMq4YqgEb3mv55k3NpGrrqBJE4pqB+anE5g8wriOqpyKQz7rdY1Yk5GR46wv?=
 =?us-ascii?Q?46h7htNgaWmPM54Rhr1V2PfghuBSUN8B5ARmOLEvrvleFvqz/YIy4ksHXStU?=
 =?us-ascii?Q?N+dnrZxoo42Mvk0RXzOvHWg5wYOj+/PdrEMNNlmtWNmE6CZA/xHvUNxJjSHz?=
 =?us-ascii?Q?4EuiqAW3m0Qm8QK68bcd6Hsz/9vac//yhmPELlWzLmahHlOCQi6MIUOr194a?=
 =?us-ascii?Q?KH8T287lMiNh6YUMmBcoEBxnOMMQ4qS0/7sobikKWfl27oHOP4WZ4g741SHv?=
 =?us-ascii?Q?SbJdjCAU+3vfYHB0BkL4jhut7GIdevANyfMAn1lN6BbvAmff9H6PduJgA65q?=
 =?us-ascii?Q?dch7S1znoO2KIccy8xX47PGiiesQmU/TvsEM45LlQANvlJxvRBjP9y2r4Zus?=
 =?us-ascii?Q?YAdBefU73apjQhOIAxaGPP4fC1H5lzdJAKmWERo/xpnS13tqDaJTIH765yfs?=
 =?us-ascii?Q?wV2gThbewhOZmn9VsUgWoQtb7Z9qqCpBh4qV8qyUVzTRDfHpPQiZHZFf7d1r?=
 =?us-ascii?Q?jG44k5ycKNLUW5xKYBNLnjFGW70jRIj2gzWwYthu+ldQfPPf5ipo2KvqEOW9?=
 =?us-ascii?Q?Xg1dsR2knU+CHhhN2J5ug/GK1Ibs+s0pomanD4A7jsvRh00VEBDvFIw7uOO3?=
 =?us-ascii?Q?dxJC8XecgsClTuk4+PqgwiKuigQrMO/uIerYjU3i6Q+srkwM3nJDnRBpEsoD?=
 =?us-ascii?Q?SQB62fGlA2Nr/T+IXne99UFXSPUByMpO7STzVMbzn6HvuTdl0kWjsP+fh/iT?=
 =?us-ascii?Q?YqM4puTA1nHVsm/api8iW88z8Jk7ft1oXmB4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:05.1974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4ef4d7-8573-48b9-efd2-08ddf1e39138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
Received-SPF: permerror client-ip=2a01:111:f403:2416::628;
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

Add support for GICv2 instantiation in the Versal SoC. This is in
preparation for the RPU refactoring.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 82 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 1c79a3aa047..d5dbbe10a6d 100644
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
 
@@ -501,10 +503,14 @@ static void versal_create_gic_its(Versal *s,
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
@@ -540,49 +546,85 @@ static DeviceState *versal_create_gic(Versal *s,
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


