Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB14CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXH-0000dU-8d; Fri, 22 Aug 2025 11:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWQ-00082H-3c; Fri, 22 Aug 2025 11:17:47 -0400
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2418::609]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW6-0007CF-L7; Fri, 22 Aug 2025 11:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+BTrVhYKhlD8tfOxVjgxpKFPmzrW3lklx72p2gsj6z7dLC5vie48DWXYY3G92IMJ8mECOehUl2CwM95QFhk32uihqSQqQwAbVCKnvbq37ZnEc+qP3ROG651+8XL7r98o6u+TzglQIt7C3zl/qKWTByxnFym0qctvwEHYwa5BKPNDRL/GQYAFqxdEjH/YOzAtb+XTb3GBFV5xV5iOofowql3cx0PORJqmIzkgCkwzSmSTfYH7U7jWvwblkl+ZrQAhOa02kzETrRJVQVP0rAy+otM8F2I7LtXku5zuX+FEGYK68C3Rw+CwzNLW6xw2k3ycM2O2dsqdIZfs+gDcGrY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuB/HBAsyfSY2ltlomCr8VRpC+pJ2jTVp3U26LTpVd4=;
 b=FuxN3GKZQ6EMVPNrWoYMzuSuFz+SgmKwTyRcg0HxTTRfbOGjfVQm38O57YaAS65fWpewAtsUD16O6H7yrouH9D5LxfOaDazOSqVLSkCf0K89EWTA2skYL1zNh7ri24JsFKTYMzxoPmN+nfddk/e9LuIDIXC/ANzdmx/sN0nXfLzw+yWAtsUsmTDAKBGCpMYLtQnv81BaY0HUaFxrcSyqCXnXFrWnCp9U3TQ8iyeE5H8+OphDkJw9k00IoXDGZ8kCPho3s2q6m+/wxhr6jHQGtKN7FN46yBXvIjyKU1WQ55lHu8f3YqVrRsFaf/6Rfk7LTqFqU1JDiLQVeYr9jlfmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuB/HBAsyfSY2ltlomCr8VRpC+pJ2jTVp3U26LTpVd4=;
 b=DFYgiAzw8kqfWtwX0aO9TaHQpwTSBtxHlRr6wC8atKrl7cMLXdfzpYvxz8yhHRL5tUZmHHRLmsPFxCIlvNU60SIAmrU6QqSBQ4Q37BnSc+AXj7irn4m/Vq2Vk/8JNJpvOEA0E1xpOuX5kCdstwnPiANsLkrD0WpxvFlMIgPkYH0=
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:17:13 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::8c) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 15:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:08 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:06 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 22/47] hw/arm/xlnx-versal: instantiate the GIC ITS in the
 APU
Date: Fri, 22 Aug 2025 17:15:47 +0200
Message-ID: <20250822151614.187856-23-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a50c29d-bfdc-4bcf-65f8-08dde18ef90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WfRxayFi4ms4PdV7PfNukaquUyWZURX9hqrwnQ0Mu7cI4L5M/13eL/8u+Hq+?=
 =?us-ascii?Q?16mPRnsk+XEmC7OegR12VhpJy8WyUxa3zHRKiCoMT7WDzsa7ZlONbBRa8jqY?=
 =?us-ascii?Q?1jp7Mw3GPOVQzNog/d32iekBoAySngMhj5wKkymNYNZg/K6qBIJNr2r3TWWU?=
 =?us-ascii?Q?lvJkDGgobCWLDYWw9KBBhC6IvJbx653hjW/2tGTVnJUwYgvvaiq6maUcB5ko?=
 =?us-ascii?Q?fAld1wBAvR6r+0nMISETEAQANHvDs5Wv7yq0e4Fgv3BL1w7wvy0lZ6SWDULU?=
 =?us-ascii?Q?ATvR8/WpBcFoAf2lQZ1JEaPvVJDWBTY3IYb+i2KOy4eRCSNp4CxwaiMPYNNt?=
 =?us-ascii?Q?UeMdxuEsatdi73+YxTLqLge3ecCcHnTh5cdabmeyDQM56reiOeXJRWJ+DeDC?=
 =?us-ascii?Q?kMXv56gdUxiC2jGnTT3za9sU5TQs2gZM2xFA2n2eSUgjrWg31RZwvW75ajxT?=
 =?us-ascii?Q?yp7jIskYTnZkHvNgP7IbMWKUne8ccEjRzlX5/hfg9fQPrSNo34t7C1eToOVw?=
 =?us-ascii?Q?C8qdUZHNXl3WFrCcyCEk6zwXQdIVH+21l6RT8/NgU+ZhumUS6XtDhB6ZhquK?=
 =?us-ascii?Q?H1ohzFd+pgyv8KKiFMgtiGHp2NUQ6x2xqZiU5EXDNHLMlQTs6w96it6KvDWd?=
 =?us-ascii?Q?lwIkn8pdrYu4b5FjQk/VCFu2C939eAiCoHVIQB++Eu2ezpvwx4YayErB1Bo+?=
 =?us-ascii?Q?/T2I6YRup8QNFiPjhePX5jpNRcF+xru9gFvmti/GO37TpY/U2xxhZ4IdKhYq?=
 =?us-ascii?Q?Ecu22J3yvM3RJr4zSBHtHrkc/jJ3gqND2S1XIJoiH41Y49GRVVWWOGSTNiqh?=
 =?us-ascii?Q?5bk19UZ8Ug/b9DmxdJX5kL62itmI+XyQ+tOrYfGnnaB0ZbdTTJjfCPizNtf9?=
 =?us-ascii?Q?nVA7qtYhF3oeyZ3nUkIvBF4p60+dtJo2bdShPMNCDegEVQQcRssLdz9II14X?=
 =?us-ascii?Q?W4Ai6X8lonF+Feiy6jYolri7hAWK8OKdE5aagG30PJAQsJCm8vGbS1vXirae?=
 =?us-ascii?Q?PA//J2isDbiMoQgYBQtrM8M3rxXQk34blN9vVYmmoQGAMzr1lDky9Ago8NCX?=
 =?us-ascii?Q?Oz9fmqW0vVqXKGKINLb09p4Ld0y3xztWQGu8eCMceHaCA1F07HnLrROV6wrH?=
 =?us-ascii?Q?eBiF/Qv6aHWMyqWb/NUHZXUSVmw3Qi65pKpHDLI4XUw8wijXPYKj9ezxXWgd?=
 =?us-ascii?Q?oK4n9Wi42p+FicYRHug1nLIjQ3xWxm4nOwzRlmXF8qcHyh9yHPPyjomQzcJn?=
 =?us-ascii?Q?RQn1DrwnCQlZ99/VoU+JV3QfBtujAXG01A2cmjWs686yL+JvTNmb7UZwT577?=
 =?us-ascii?Q?q3HhNixiNhi2tCtxcWTpsrmv32RRhwFW6mhwZkHz2XWedYotnJnhqKybqI+N?=
 =?us-ascii?Q?h5UoDrCXA/Mrl+qMpJcXndTUT0BsqBIeE7YvynQMGz0/I0FmOGwjisxYeQxd?=
 =?us-ascii?Q?grjsc6wDE43hY4wpPsgcw7BfX0SXzH929fWGS5fNn0LY8ORJv+py8YTeaijX?=
 =?us-ascii?Q?4GgMVDn7O9DVV9JRoEmMH/TpWhYprpcKMUuk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:13.5488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a50c29d-bfdc-4bcf-65f8-08dde18ef90a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
Received-SPF: permerror client-ip=2a01:111:f403:2418::609;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index b87ffa56313..79dbafe3a7c 100644
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
@@ -213,10 +216,12 @@ static const VersalMap VERSAL_MAP = {
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
@@ -449,10 +454,52 @@ static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
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
@@ -474,10 +521,11 @@ static DeviceState *versal_create_gic(Versal *s,
     redist_region_count = qlist_new();
     qlist_append_int(redist_region_count, num_cpu);
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
@@ -499,10 +547,12 @@ static DeviceState *versal_create_gic(Versal *s,
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
2.50.1


