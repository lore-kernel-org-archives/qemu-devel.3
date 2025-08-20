Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7704CA0EFD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeA3-0004yw-BS; Wed, 20 Aug 2025 04:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeA0-0004pX-Ee; Wed, 20 Aug 2025 04:27:08 -0400
Received: from mail-co1nam11on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2416::608]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9x-00014Z-VR; Wed, 20 Aug 2025 04:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk8Bo+PRcSbhfb9UaHzBR6kL0Rk5kvHl7RqN8/m/0lbxcF/A8GemcOiA0KzHRR07zkCt4Mo1HyysF7wSzgw8rQIJceGgtotdeuGAaLK0VkgrR/smfUKqc7InRf5Do9LfnkUv6y3Rpj9Bd+bRXgkat529gYsvpmt5mYbsBYy5d82yxVVE6Xd32lusWaR3ACp9sLFNPC+U7sfxEBx0fYS/BUTCLL7grGbG/+AfW5X+ct9zb/t9lS7PF5lswILTkbc115N1yt7SBH3FNEOTzUBkfW6Uud4jWw1lM9zJFqpVbTPOiaKnK7+TrR11C4BeT03t2YxQWiTRkZ73RPf96EkXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAaitnsx/BXGi+WJZVn2Q+BNaYP4D9L6yxzVo8JLpuQ=;
 b=WiGpNybMhtnxOIsK98aciKppbI54raUS8CV7T/8+GS2Rwt9njldnLeR12m5d8Qo+7YWxxYEEmt2OOqGE3zQNKcKJnxGWQY224UHufZEth2HyLQlqRBLEZzIQfNM3PRySS0uaEg2bCu5YftbCrzxizdhBCuyUAEU7XF6nXVfy3cK5PzuwkIX7fm+QM5H2yd4NCnuuMxUArJOGp5d7fQqMNISxQz5F4vJvWbawWysSQkI8K6bkJLnMt+Ti2DoV5g5/DT9qZqfPuK8YZxVhZOm9OzoicEmBuj/kmmfEV6jmKkQm6+X7YjunplO6HkdMVcsprdyAzYYqKGFaPsdLKXJPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAaitnsx/BXGi+WJZVn2Q+BNaYP4D9L6yxzVo8JLpuQ=;
 b=p42p3iE9S5/ysgRNc/AZM6Mnk5G4wVG6fj5o1diteftmrhtE8kolYMMj55ZaE4l1SvQmmdFYeYAyrR4FUQ4Xbwc4BeXElkVf2+3kiy76nyv1PWHeXrQI922SWn/xAtRgoVtvbIk3mlndKnSB3EewSJESQf/0v05hjz3iA7kNqTI=
Received: from MW4PR03CA0342.namprd03.prod.outlook.com (2603:10b6:303:dc::17)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:59 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::df) by MW4PR03CA0342.outlook.office365.com
 (2603:10b6:303:dc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:58 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:57 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 26/47] hw/arm/xlnx-versal: rpu: refactor creation
Date: Wed, 20 Aug 2025 10:25:25 +0200
Message-ID: <20250820082549.69724-27-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8292091b-e816-4b39-c5fe-08dddfc35511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?utfqj/ZQOG3FhuP4X3L2O0gcDVGBYXVSMjrNEbw5cwMgx4m7LVcHBQ6zfEL4?=
 =?us-ascii?Q?fofH6sy9viYEdtcVq4q6pzcOPJj79LXHwEmEW2XILAmBD+JY9NxVGhARY5mR?=
 =?us-ascii?Q?xVIEen+90DRgyS6fUCQLwwtRjkGHux+O57F/W0NbZ9DhoMkq9diUos0kdrvC?=
 =?us-ascii?Q?bR9FYyhistZVTu93NvLJn6qgfCOE3pV5XykPXQdJ0Pfv1j+kjMRmbYg9u5zb?=
 =?us-ascii?Q?IYi7hAzxZwm4KvOWPJLtmtmYAezX3fd1Mcx0c5T/amfxfuCNxySWxZBbtYZt?=
 =?us-ascii?Q?yudiQexDs0Ug4Ua7bW9bZz6kIOKijc+1ps4IKGyIauvcbnT2vVL/BYH4/QBJ?=
 =?us-ascii?Q?4f2Z2yCi7z3Wre/26ugyDXc9xweZXBH+/ekCBtmV54OWbs4OjJEAkttcmFsj?=
 =?us-ascii?Q?sRGMdfZn8LZvp2dXARsrIdq/V8r5ss08n3PdxeLXzyMvHzqpvtG36VSsvNkp?=
 =?us-ascii?Q?unY3c6Zx3MJMk7+uHc7levVXYVLHKyhLtDQeYyd9bL05zzxFS51TB1Y23qnT?=
 =?us-ascii?Q?odsqTpQvqFD35CeJL2pDVsdS5izRR9w/Zjocxxfe2mb5zmxj0S2Jg4zXy7n6?=
 =?us-ascii?Q?mrdSyDfNap1gb82bN0MK5VNIuwRucSy6FxwSNTEVeGDmpkWBKXU1PuJSbPyV?=
 =?us-ascii?Q?75qOCZBGVm3bbH6pllalDGQL9RGLyj3zohMX18x9o/eQhDRyul5uxXGfLpe2?=
 =?us-ascii?Q?t1FRcUMIxBLb5Ia/kUEHYSBpGNqKPqrobve+y2NV2x4hLnudxbMUoR2HO7Xr?=
 =?us-ascii?Q?aHCEbDyjU5q0L8NDpJHn6xcvDEp9Xf3xeBomUFVSKlelW8/qA+rxS1y/aMa5?=
 =?us-ascii?Q?HwGsK8oSLiAAQeHi7KHxOFfbkUOeE1yL1QYHQqsfzo8es4kDDFAfWmHz94qn?=
 =?us-ascii?Q?jbkqkCPlLt6z0FPKVfPnB+B4nHZ+CiXN5i7pYPbd8XBU9RjPJbtj9cZ8+GZ1?=
 =?us-ascii?Q?GjU68dD1ndgLIImOEZ6J68nMpmupqbjYsPQyjj8SVB+zLv2MiHHbS5cUMyh4?=
 =?us-ascii?Q?t0QQ3BZVY0BdZDyi4JE/qx0JzOZxhO0eGX9rI9mVGeOBxqRU49lqtntTi02N?=
 =?us-ascii?Q?X1IqmB+hEgEkke5n6iSWUooUCoHfyCgNBWl4fd1wOghReYvSW22HNjbvMiVC?=
 =?us-ascii?Q?FMaHpG+C2VHj+aOUh2p9sMv1JdRRBuwplmczD/bryJLh0sPcCx/xp5ZwRB3q?=
 =?us-ascii?Q?xAm77FAlKlxQBBCAk4Tp8MOGpTxezyKhVbgaUQYJwmUKHTO24Pe8tqv234T3?=
 =?us-ascii?Q?xfqKCjKvqmcGum2sFOb8AwlwNoTrYnHjBZ/ShUf6ybgu+BmuDn9prFAcLm+7?=
 =?us-ascii?Q?V237Mg6tkOAjGa6ymQTNyvPN++8GE7uJO2ubyrAYMGuENteBIDgexrHinVtt?=
 =?us-ascii?Q?n+t7S6O7HfQykiBoFqiBpgmYzjWWbGsQ7anm8Rmfu+LWKmYF15X/Kan0SCGH?=
 =?us-ascii?Q?ghXSsWvsRAr2RirSVd+QO2Tfxcual22v7LTombBcHwC+WYLH+ox1qObMuRfV?=
 =?us-ascii?Q?37YToy+jPERc63De4LKb7P05teVD9Wh4Fd4Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:59.3980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8292091b-e816-4b39-c5fe-08dddfc35511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
Received-SPF: permerror client-ip=2a01:111:f403:2416::608;
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

Refactor the RPU cluster creation using the VersalMap structure. This
effectively instantiate the RPU GICv2 which was not instantiated before.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 11 -------
 hw/arm/xlnx-versal-virt.c    |  1 +
 hw/arm/xlnx-versal.c         | 60 +++++++++++++++---------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9b11ffb845d..62b8d234ecb 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -12,14 +12,12 @@
 
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
-#include "hw/cpu/cluster.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
-#include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
@@ -50,19 +48,10 @@ struct Versal {
         MemoryRegion mr_ddr_ranges[4];
     } noc;
 
     struct {
         MemoryRegion mr_ocm;
-
-        /* Real-time Processing Unit.  */
-        struct {
-            MemoryRegion mr;
-            MemoryRegion mr_ps_alias;
-
-            CPUClusterState cluster;
-            ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
-        } rpu;
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b6420f0f107..3003b0816be 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -22,10 +22,11 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
 #include "target/arm/multiprocessing.h"
 #include "qom/object.h"
+#include "target/arm/cpu.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 771f6108558..3905549b32e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -45,10 +45,12 @@
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
+#include "target/arm/cpu.h"
+#include "hw/cpu/cluster.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -107,10 +109,11 @@ typedef struct VersalCpuClusterMap {
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalCpuClusterMap apu;
+    VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
@@ -227,10 +230,31 @@ static const VersalMap VERSAL_MAP = {
             .has_its = true,
             .its = 0xf9020000,
         },
     },
 
+    .rpu = {
+        .name = "rpu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r5f"),
+        .num_cluster = 1,
+        .num_core = 2,
+        .qemu_cluster_id = 1,
+        .mp_affinity = {
+            .base = 0x100,
+            .core_mask = 0xff,
+            .core_shift = 0,
+        },
+        .start_powered_off = SPO_ALL,
+        .dtb_expose = false,
+        .gic = {
+            .version = 2,
+            .dist = 0xf9000000,
+            .cpu_iface = 0xf9001000,
+            .num_irq = 192,
+        },
+    },
+
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
 
     .canfd[0] = { 0xff060000, 20 },
@@ -809,39 +833,10 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
         qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
                          compatible, sizeof(compatible));
     }
 }
 
-static void versal_create_rpu_cpus(Versal *s)
-{
-    int i;
-
-    object_initialize_child(OBJECT(s), "rpu-cluster", &s->lpd.rpu.cluster,
-                            TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->lpd.rpu.cluster), "cluster-id", 1);
-
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        Object *obj;
-
-        object_initialize_child(OBJECT(&s->lpd.rpu.cluster),
-                                "rpu-cpu[*]", &s->lpd.rpu.cpu[i],
-                                XLNX_VERSAL_RCPU_TYPE);
-        obj = OBJECT(&s->lpd.rpu.cpu[i]);
-        object_property_set_bool(obj, "start-powered-off", true,
-                                 &error_abort);
-
-        object_property_set_int(obj, "mp-affinity", 0x100 | i, &error_abort);
-        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->lpd.rpu.cpu),
-                                &error_abort);
-        object_property_set_link(obj, "memory", OBJECT(&s->lpd.rpu.mr),
-                                 &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    }
-
-    qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
-}
-
 static void versal_create_uart(Versal *s,
                                const VersalSimplePeriphMap *map,
                                int chardev_idx)
 {
     DeviceState *dev;
@@ -1637,11 +1632,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
 
     versal_create_cpu_cluster(s, &map->apu);
-    versal_create_rpu_cpus(s);
+    versal_create_cpu_cluster(s, &map->rpu);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
@@ -1687,12 +1682,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
-                                        &s->lpd.rpu.mr_ps_alias, 0);
 }
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
@@ -1794,14 +1787,11 @@ int versal_get_num_sdhci(VersalVersion version)
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-    memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
-    memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
-                             "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
     s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
     s->cfg.canbus = g_new0(CanBusState *, num_can);
 
-- 
2.50.1


