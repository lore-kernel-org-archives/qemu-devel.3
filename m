Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13B8CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXF-0000Ug-2F; Fri, 22 Aug 2025 11:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWM-0007yA-PE; Fri, 22 Aug 2025 11:17:39 -0400
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2418::609]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW7-0007CJ-Ro; Fri, 22 Aug 2025 11:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUgn/UJAeSQ5I5ZQBPD2SPWDWfvvfA1RUGZHLLTKDNWWfvLzILBCEarNhMS8UwFHOrN7VvX69RTlJqEwzncvACIwExyhNqRkGWO0H49oIVC30O7cWzOOhIghFY2Mgf4HUYaclaq9UY5JR1bE6Faj0w4q+9OhtTY4MXXvP1jr5aAJO+rzWNKaAALWjUkVOn4PC2vqV1TCeepw2P+oPEFf3X60RERlytAi8+wCychjaYnyW07YV+YfKPCk9bftZr5cIJrSBAJvjyGg8wIK4b+ZYUoMl2tgr0V5/ntCIUCEhX65InXUzFwjtJkHI6e818YL1gUQFdlhxaZI+6ZAO0TwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEgSQqTIDv6mh85zuyAn1u4tB6Jeflc84eAEwNCDZf4=;
 b=kAIWSJ657vNJ56QZSlHldhR5epc6+1p0mHnmxN6y1SGwkXynXO4lQRCsyaFodVywhFaMAa1YFeeZzWYOXCjp0WAOeiD0H9C5MzbISvR2LPP/NHc6ZDgGmZywWxkdmdxlf1342W2xdDUHqX6QFA1lHxO5l8xY+/dq1he8mIrEfr854YxdouF8nRP4N83x+njlpg4hYLbvptVIQWzIX+b6s/eyt0pEKbqqOHh6CKhuD4AX7jdYFk/F93r7p5wJmtm77BbIgrrDBx4N70NixTh0SVZ+O09asnNAUAxwZtdqeug3mIhpA/h0iIExDQtPUbLEAJsvbt1YqtQnax5GFMUm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEgSQqTIDv6mh85zuyAn1u4tB6Jeflc84eAEwNCDZf4=;
 b=1uvm5BFpgC1vRBni7a6s18oV6h7DErkpcb5Adb52OCjYYb8qVhI9ZotVCGnvS/5WGeFN9HQk8D8bv6MALCqI2XGW/mIe4YchUduen9T1zhHpEzBmJBtoTcLnrLjxAth1/cElz7ITd60N+7BDuuFumpRMZEFwqEMHOgX6V88qdOU=
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 22 Aug
 2025 15:17:16 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::64) by CH0PR07CA0028.outlook.office365.com
 (2603:10b6:610:32::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 15:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:14 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:13 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 25/47] hw/arm/xlnx-versal: add support for GICv2
Date: Fri, 22 Aug 2025 17:15:50 +0200
Message-ID: <20250822151614.187856-26-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 56101d1d-02dd-4350-bfe7-08dde18efa94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Yc0/1uV4VhjVLqIjLzhWM7bZMyc2pQPxbGLqIfP9BxjBio1Q3Zxi7xkv5ji?=
 =?us-ascii?Q?E+ImoeD6Jn3gSERD1zLj0FvMYNkozaXlqOkiHkniauq+wKI3Pj4d/2f5KgrN?=
 =?us-ascii?Q?t3KMKHjHVj9izzJhIsVYJEbyzpAJIwaKze/u8DDWisoSgCRQVmi7/+cNrnGQ?=
 =?us-ascii?Q?f8eVvvL4Fhv0fzETiNBAaoTW0q1tmCUFszOdAlxyYkv4bHV+6gSvJOxCIJuL?=
 =?us-ascii?Q?UFyHaMLv/VCHzDFRhUNUfD5oXHaulPV3RwoRgz9gqJBwZQ6tJVL75m4FZ+iS?=
 =?us-ascii?Q?d/K1E/D2mz9belPigiTTghr7hASc4pXG2ljppm/pM/93ZHnm8l5y4ICjqzA+?=
 =?us-ascii?Q?EIoPqPrg7x7wYzwirQINtZ68Up0v1MFrobafwIMblQPybhM3RtkXs9Tli805?=
 =?us-ascii?Q?IOxzxQfYr/bC9xEWoNQKC03ld/rel3f/LXHzo0yRygHkd7690NafAcLMKUMs?=
 =?us-ascii?Q?zmQBTp19AxlotmCfD8dka2PdQBHOZZvx/NaoQYL/Io5YH9TEw5l3frJd3uMR?=
 =?us-ascii?Q?Iotm7+bveBf9VyMldjtdEgC/6h4VkTrxqvrE80YfEB80eGhw/XWiRaa+fsyF?=
 =?us-ascii?Q?rd53H7xAkE8Xm3u4700fukvI1LsddJFHmGMafyuEZvyE+2p17mMjlo1T6KSn?=
 =?us-ascii?Q?e1IqApFwNfTy1yk3gY+VV7uNsxOj82LftqrgABPMkUdz9LylACGquRQTHy+t?=
 =?us-ascii?Q?nj5hGCzAe+FM6VjFCrayWemka5roZ/PAdoInoZdu3AIFeoT/+MFIOK757g6u?=
 =?us-ascii?Q?dAbXT5TSzS0B+UwrLmMa/zTkQJupeiYyPpYNWHNHVQR7JnxNg2FLonLgH6L9?=
 =?us-ascii?Q?Cn1tCSHznLJEnkz8xEWBsBz2ICKcGMTIvrODBEDuQzYi+kXeJgeXfx0UK382?=
 =?us-ascii?Q?1e+xXfna7Uz/gcYWE8cqmAXK+qOaTIsa7KMoeMRufrbLHYfq3uN0eJA0NG+l?=
 =?us-ascii?Q?V73V4C28fMCXtD/lzS3eLO0PQSLKISARmDRDIppjQaQxfD4f6KOQZNqaRnsS?=
 =?us-ascii?Q?OiB7YE3nfCYAjFGyfNyFaxoUn3dE2+nrlU53rv0vrxf1UMs4sQt7UPwCmEWj?=
 =?us-ascii?Q?4vXR8O6/+zJ7WQv9EV0ZfV4EfuxPH8s9IAFZy9B7coq8POwjB82cAGGNU53c?=
 =?us-ascii?Q?lNaKSC0QedtOYBOs/9dhHIaflOXtx8PwHvODVkhGrm2w5KhKSLfHfngWsUiJ?=
 =?us-ascii?Q?/xIOhSubB6I2ajDddc6ungmnLwICgG2cdV1VWqYqL0H6fYy+WjKTp8ptfRtV?=
 =?us-ascii?Q?5ttnUr3tYnXRhaYU74NaicI1DEcFk0UtgPO5I9WVva+sjrRatrdHOQfz0pfv?=
 =?us-ascii?Q?Lc19STx2yLRX0RBhGvK5GuaBDzTyp9xOSiSl8aB1Ayvx3mcqwz4eeeVg8pb9?=
 =?us-ascii?Q?PZS17mO9RvmijLgN08YCjh1YE1Pmqtngc//eLTTj35C9xrgBbkfMR6h3LJaS?=
 =?us-ascii?Q?5TFR8ywp+tXoHU5bkCA4gcEdcvOPBJYVd1+QshlWUwd0K0xRLQ58jzulLf8e?=
 =?us-ascii?Q?xHd+dHqYl3M3VH40+5AV/C/kud2SOAFMQ/d9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:16.1317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56101d1d-02dd-4350-bfe7-08dde18efa94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
Received-SPF: permerror client-ip=2a01:111:f403:2418::609;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
index 706d4eb733f..96e687abcf8 100644
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


