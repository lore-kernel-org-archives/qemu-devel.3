Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC4CCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0da-0008E5-By; Fri, 12 Sep 2025 06:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cd-0006do-R3; Fri, 12 Sep 2025 06:03:15 -0400
Received: from mail-dm6nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2413::606]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cU-0001K5-Iu; Fri, 12 Sep 2025 06:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUHGur6vIORykdZYhg7XjNpo/f9AIHULkdQ9IL0DW1f0A18r2qIcF5O+7+Ncxxehwx094aLC+/L05vKTZ1K5cgs7IXf5w26g8CaOOrVQqevrsKGwZir3loka7Hf17BqwojMlswhmhrCukRKq+8UgNJtRT8K6cGFetPknXIcjZEJfVvAo0opdYF36IQoSPTP2H6gc2m95JydrjTuzWpMPBNDnwld/bO0/a4z36q4cjmxkHQ50miV61wgXqhVIDMkv8gUbJ/YEurmw9TYXvK6eBneO25uFvO1Kfcphh6OaPmK5psAS/OpLx6SOMn6aXH5gOQbopDvYwpy5YSKrMxmxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCaC1NyJ8OtdfxLQmh5A3qWRwVBllGPm0oIyLSO0p6Y=;
 b=lGrrD6BzcHeBSQP3sjXZsDJ2H6idrR46po6kxx9QmogArDAwuf9jferCVEOY+JJOoKrhR72ztvCNaOruJYL3EQR/G6yWHyR6R8zTu3vUsT0KxxpWC8pHvSefR0lrn7PeiQ4KSETzQylnMOxCGEoZ8G4n1wquOvF3spcwNnCvflXGP9lUi+PGAWxGnspRKOjx/kxjQv503qoy8XimDk5PcZKifMd78Y6Xa1YdBLeQjz51xUwZppT4XyfHzidjqwi2AlwxzbQ6X7xf7W+gj+DXmASPpZY6lMsVWlvbRM/Yis1cYpHTYcamgYwNGGHx86P9DuH3RJQbyd8txIrJ/4LzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCaC1NyJ8OtdfxLQmh5A3qWRwVBllGPm0oIyLSO0p6Y=;
 b=y4WL+yvOeGLJcPMJbF86IROrFI2OmkziGao7uIkRBQfoFX9Xew5y04uyZ8wUKJVrsWp72ZxuymqCijlyMK7o41LXk4FYk51Y24JklWvVjpEjE7rYCPpZcWFW6ZTWk004/YDryNgv/pDQBeyqhbX1k+GhCuXMNBTFRQtmwXZC44Q=
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:56 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::e9) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 10:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:01 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:00 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:59 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 22/47] hw/arm/xlnx-versal: instantiate the GIC ITS in the
 APU
Date: Fri, 12 Sep 2025 12:00:31 +0200
Message-ID: <20250912100059.103997-23-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c73192-d556-472f-c71a-08ddf1e38b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yt9W32iRUgdYrUm9JNpKzoHx+jZZmHIHC1VsBWea6wx93yTLRnXCJcmnNwBw?=
 =?us-ascii?Q?50ZcJjivzGNUsxJyrYmOIYkjATeGub7kM24715TQUQBG5gj9GrqP3U0H/37T?=
 =?us-ascii?Q?ejj8gVgriQqX/dhhV0GQrKfE7TZ7SYCQDSF33KpkF7ChswzPH7kSHc4uoUec?=
 =?us-ascii?Q?YbQjDNHwW2ZDrG69Im6klMJp7ZqJ8gUZs9UjPMDL8jCqbj3kEcdfnOHu941S?=
 =?us-ascii?Q?GRoJ5M4JHlHGtFiEmWE+hXeDrUBsCB8X9mERKhLrECq0zC4JykDbd6skG656?=
 =?us-ascii?Q?9+4yJIJDCGSnA0RgpRA3gDVsUui0uz8i0AnTcjLdbRVicBdUJYjEcTbStf4K?=
 =?us-ascii?Q?CcZZUcZ29zRsEtunGHikZcVZoseJzwQ0/oihp62aA+orlsEFg1NLLTdevnu3?=
 =?us-ascii?Q?Y7OPZPQeC47YOBNQvkb9//7oEMzHIgGw6wLsWf5i2MDxjEGQz79/3gJo3qFX?=
 =?us-ascii?Q?GfvyguHpW1D4fDmxpg6n3i6x2/ZABkHyEhJBQOxiSV0g49fthVshBro8R9Fy?=
 =?us-ascii?Q?3oP3tgY/9gu6c2kd0T9ACOvpCNceQNLP2LM3WRGD24GS+1ip6SEuUEHqseKG?=
 =?us-ascii?Q?IKF6W6d298anYDA8BpLYyWN+7nmmFmVYUOFGp0Xn9Zu5Lv5lfxnnJThd5NL5?=
 =?us-ascii?Q?+ZMcqWICgNdJVIuOeCGpLPJBzCXEOeb/ynypxIPFXsz63OKTIDjJXaB669Sm?=
 =?us-ascii?Q?fRaZnFpUz02vkdVCJsqC608RNh8+nskjD0noS1MaaCyiSj82p3FI57ziKJnO?=
 =?us-ascii?Q?dGU+yYm//csPGUl9z8/fykPKjFPKFY3B5u7tTREiMMA9fuDnBYX7aFdoYEY8?=
 =?us-ascii?Q?Kb4MDW5A/xBEEFrhCRSsIsb4xBwLuxXQu/WmRuCRQXC2EE9yeIyLV21TJ3z6?=
 =?us-ascii?Q?xds3gP4VcqWhOYz+d8huBwGS1RN3pbvsX3os2iHurqghRVmGbC/vSRvCcTi7?=
 =?us-ascii?Q?4bcykNGpQGLsUUx4bcVyoqF7kbX09d34Zg+LF0YMxxSrJblI9um7+EdD/EqV?=
 =?us-ascii?Q?Q3b8SKSWsKF/L22vCVAPF3F5+GX0On30ZHG/h4YyLdu4tQEVytkeyVTT/g60?=
 =?us-ascii?Q?6Db/oFy1xkbOsO77UBZH/m1RSwc2lb9QhxoZep2Pm8Ns3+ugwQgDOf4H/zaL?=
 =?us-ascii?Q?KAUykSPWW2rbx/d0HrRheCfiLKRSwN7QZX+HxDJlKA6FZrzFzqDBRZJoQls5?=
 =?us-ascii?Q?orEZZVnINkwopMT6v3m7wbaYLQGY+HhZyz6BW/lsEdSnkbjxVvU+E8UPDUOk?=
 =?us-ascii?Q?fjsvR0r9dSafagjjwzhxc9gkoqZV7Tc44oX4yT8F+5MYYxM8Dire9DSKeEbT?=
 =?us-ascii?Q?bVsAN6+bD6pHJnOcJrZjDqw/CLN9lyurmZCZ98Rn/5w1jflcny29/dD+GHZD?=
 =?us-ascii?Q?E3DanGbdKBwvmFiZg518pCwDPomC4UHA8/yH4WydcAEOAWlY++Rmo8TUPYod?=
 =?us-ascii?Q?K+/3W5YrNoNhyDrYiKUuKa4QX81s8z4uVxSLByitX98HY3o9BucQYHMG0N8l?=
 =?us-ascii?Q?BGPd2XfYo4XXbbvbv5nCWu8FkCN5LMcf2cyS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:55.5431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c73192-d556-472f-c71a-08ddf1e38b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
Received-SPF: permerror client-ip=2a01:111:f403:2413::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f4b9f419728..6252e0742c4 100644
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


