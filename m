Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465D8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zC-0002Wj-Rf; Thu, 21 Aug 2025 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yo-0001rb-JR; Thu, 21 Aug 2025 09:05:25 -0400
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4ya-00030e-My; Thu, 21 Aug 2025 09:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF/yM6TP2V5rwBuKV25aJT8TmO1+JHRZTNWBBggEHIAi3T4uIPdPNcrJLRohlZFIiii90iqnb6IBspt7X1EqiTKSmtWqGAteAZqjDv5b1h2uHXZWcYvS6Ag4Hvs4bnfxMr3RvjqG6zX9Pw3UMruE3oLyjFCw3zAtd62I0g8kkETO0uTf65Jcq57aR3e7nTePrjxhZs7+kYmBVsolPTFJ3lIIKrrIs+5bzVh/sdGD5QeGovGdjbc6VZRoT7Dis3AVYdWQRXpmB4rl0/xODhga1zzrs0ElJFqQuOkVD/mFV2l3Me+O3DQ3gZoaE+lftgNfP4rCmIbkM13nkHkOaakeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To1RStDgxOTfHlvZuouz8X/BKp881ijaoYamHzLnFr0=;
 b=inDEDHSdc/yLqllofVD+9O2YgW3cm9aUaQWa47TlrEKKd1aCMHkmKCPM1eaA0JFoOZjnOO6rQ1FH50jrwaUAfWZAza/j1EjhFFdDh5KDyPW1Zk6seiliWfsXj6n71q7MOTOlyFlqJWBlmmB/VUTX+2wcwNlps+o+vGkMbIfJPB3Z/3KSHJ/nxzP+V0Mvz85jjVQJcMprmnZIm0wEOcLdRDAX2vIbiKuRXqI5MqkvDLvaZ6424Q3VD69NKlGudu78GoCZvhItCCnlQyM6iO+d8vQgGhOkbbYS4XyuC4eIBESqULThUIr8DJwagpNF3y8StK6AgLRCTi+CWo7qcvslWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To1RStDgxOTfHlvZuouz8X/BKp881ijaoYamHzLnFr0=;
 b=UTObzYS2PsbEyMXxspHtHu92/AFL7MTqhpM9JGnj0H60Clhh+Lt23PfiDawqFpQcivKC1yzA0dp0kgr2JKPBpFiDxNIslmDTZyNAakPeX1GEyLTxOwwS/dd547wi1ub/sJZh8eJ2gQcR0CqLk+sbXW4XLRDKv6TiX3dtc7fhoM0=
Received: from PH7P220CA0116.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::19)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 13:04:58 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::d2) by PH7P220CA0116.outlook.office365.com
 (2603:10b6:510:32d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:49 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:47 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 25/47] hw/arm/xlnx-versal: add support for GICv2
Date: Thu, 21 Aug 2025 15:03:24 +0200
Message-ID: <20250821130354.125971-26-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 85678cca-d02f-46c6-bf6b-08dde0b354ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xQTstm42IBUEykLuihklSwXVZPxIWs45FQ5o0eCr7UraGqAYGV1BGoAmEwko?=
 =?us-ascii?Q?FIAgRXvFVpHlzrrzlb6MtNbn8uGT9cmlPkVwdduhZKcucfjQ/K30N/P7BWkR?=
 =?us-ascii?Q?9tahgYqZfTCLvjGBjG4jc0lNYaXMt/jUYhK04hfvVg868Wm0vo0bQ/AZW6OX?=
 =?us-ascii?Q?5oxCm4qKVaIt787izTxPruUstUTbKbge/IHCyNxPoLVD6GABIHKwZCj6G5p1?=
 =?us-ascii?Q?tiI7fCv6mYAnMsA4FbZ7bs7O+ay++c5jJtX1ZHMklejk/E7XKP+6FXm1yqrC?=
 =?us-ascii?Q?35rWrelDn8HWSFSwCylk9HmIYiUy81Z90Awvzvp56pv7Uj+TQMhAQtLmHQcB?=
 =?us-ascii?Q?j3t2bEH274MfCkawuEzXLB67rbRBbcFjAG8AR04PZbJ7vrHDVo4U0rZvhN4c?=
 =?us-ascii?Q?PAK4RA6Kq8k2/FKoPMAynUTpsvnsKGoiLZe/+KoCOwoje7Tk5avZGfQNssy7?=
 =?us-ascii?Q?srdOfP7hMQCK4nybTZFU4m654rUSu2KRt1CWrJqt05J2TBotGgvnnDpIdXUw?=
 =?us-ascii?Q?PfRB1jblqxYfQXB5aiLimkP2jxq4iheSWMuZUlQG7yGrZRkvTux49d0VwzXR?=
 =?us-ascii?Q?r+IAGqw0WI8VxcrsdGWgGIm1Qvn9Pe82QXxUsUM1gH8/zHQV9qz8xmjTbtVR?=
 =?us-ascii?Q?WXzUpcflUsAM49V3ytRWQn7n9BE8QMCp5eLiCvh0D9CGjVFNm7gd6rcTAq53?=
 =?us-ascii?Q?KLAT25tmx5svp871eGeC75kQktnYaYgnOqIHQa4xqhh+tXZvvFbUzgGit42Z?=
 =?us-ascii?Q?8NpSTFmiUsxK6f9c+gIPp7pqPyajkXwmnRuGbpqD29BY0sNVuIdTaC2SRPCI?=
 =?us-ascii?Q?ZRZVYmEO/4BGsaaZB2/Yc74Fb63AZKcWtckK2bIui07C/l3uHGboU+FB/rlV?=
 =?us-ascii?Q?ZuXQnhGMI0vTXgCbY3uTlUOR4GWt29psNCizccDu6wdtIT3zZuaYIaW1KPoG?=
 =?us-ascii?Q?jzAk1KYr+DExZeglj8gHLAPfd2g6vLhgj+i68bmyJMCGM/WNX8E5vZQ0lPtk?=
 =?us-ascii?Q?sOYYlrUjLdAmM0E181cG0Q16CF0r5Sa7hdiWF0NDYaCD9TmWemjrLTMlUqe1?=
 =?us-ascii?Q?YodmQ01aDBr7dw7/24thKGoxllhK6oOHsmau4gr3xgTCpxYy5Ht+Fwc5Wn4s?=
 =?us-ascii?Q?71fC7aRIStQUaeRS7+X+AOQBXxO1f5zsenOx57NGcr2+r0OaGBbL65BRjs04?=
 =?us-ascii?Q?1GO2oZoVWFB2avKkIblMUkEX+A50ImNWFrVXfdfz8MNxAMYMz3XwaNIkxyvO?=
 =?us-ascii?Q?qAlbZQvbiFodheMzuEPmmwiA96XENqS8ku6jt1wT75KBUtH5mS+x8BGTTzV4?=
 =?us-ascii?Q?DZfbBRQz9h9CV3qnB7kZqJCN2hbLuAKfrOMdGxflgYTCVSI1kHCN5GKXQs8J?=
 =?us-ascii?Q?DKQCKngMNJZv0IocdX9Td+tAh8ETgrjAfNQdXEJ8tDsJ297ewrIyqUUNFTBe?=
 =?us-ascii?Q?6e6T/yheTrgaAVdEvs6OJS9/0ceYYk3gREpgUW7JFwwVst0XCxQXzGfaWbFo?=
 =?us-ascii?Q?y0rLeQd8ux52peA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:57.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85678cca-d02f-46c6-bf6b-08dde0b354ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
Received-SPF: permerror client-ip=2a01:111:f403:2418::62c;
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
index 60e90356b57..0137c81c57d 100644
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


