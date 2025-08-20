Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BA5CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9v-0004k6-HI; Wed, 20 Aug 2025 04:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9s-0004i0-Vz; Wed, 20 Aug 2025 04:27:01 -0400
Received: from mail-bn7nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2009::626]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9q-0000zN-T8; Wed, 20 Aug 2025 04:27:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adp4lMVweRW/l3+wmhKLDTcpt/kTQtPud33olNjcOL2QWIUeHeX24//fDj0LWLH5kmHiL08063uoGiT/NGRqz0acfAIp1Z4/MBKGjffblF/ZkDpY8dq3JIV2zjqQ94Bxzz5+/4PYIdOVfN9zd+wlc+n0IcjTDeyQIDbyK6c6uGXy8ubMTcJoYgPKmSDYWyI5di+Zig2dT73+RrZCsdF6DN5fIHkFGt9aq+BCthKxpwG4OBMU+8wGteWF2fcwTGo9nA5DHI6j0mhqqJg3VZwD2V0Hn3SJ70TIE0e5EAlo8u7/9t8tARzLQQ9el5cv5Ansou5cnrMFmmP/Ap6VZLRkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK51ugESFmviVnU8u08MvTxrlgIVhZ9KL/pnVrGONDM=;
 b=IMPQZ3Uyhcer+twvR2vuoTkPlGbLm9iDI0CshvRbf16WNEB2ZXuZREfAMliBOu1byAgZuYGlux7394yqvU5cTjIuul/I92mfxTfsA8Xfo/+IWyKYk8Xja351K0PYCyxBxwhfrD/KoTX6hn3GAAXFQLVnxP2jgDeUv0dAKsVqC7LkP/ffFEXk8PbA0j+eXq6myyuI5sN6aIpG/twedVKQTtcrb9/D5o4IWN9Li9jOnKCJtTRhb04onjYkJ70DHKVOgkM/mmOy9kE4ykkNk6EVp3phXdma1VdI/dmFuYuUid1Rvm8Rk00NIUbHEz+QeAA2p1SOVSJXnuaj8Eby92Q2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK51ugESFmviVnU8u08MvTxrlgIVhZ9KL/pnVrGONDM=;
 b=RZmX0OVqleWcnrwjhyaN85cGty6eNa8dwuP1P30KlHyrAiEScD3JrZXY9BPVsTk7iB6HV6Gg6E+e0N/fUXc9el6+TUuHg4FGW6gn+jPHGqSQ3ZkUokJpp5flFbU9mfuj/mw9MCQFtrMnKhRzSum+O8609xDBffChoddJXMX6mXk=
Received: from BYAPR08CA0047.namprd08.prod.outlook.com (2603:10b6:a03:117::24)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Wed, 20 Aug
 2025 08:26:53 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::fa) by BYAPR08CA0047.outlook.office365.com
 (2603:10b6:a03:117::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:50 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:49 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 22/47] hw/arm/xlnx-versal: instantiate the GIC ITS in the
 APU
Date: Wed, 20 Aug 2025 10:25:21 +0200
Message-ID: <20250820082549.69724-23-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d8112f-784a-4769-bd48-08dddfc35198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qI9Jk+SLIk3tz4vT+o//SPh6wAIDgsFzm4wDSafexmf4tkxsaHkZqz19Vakf?=
 =?us-ascii?Q?Stz9dmD6CRVx89d/sxn9D/5OxfbmbljEHNxtdl6c59H1wfTJmxS32DQogD6E?=
 =?us-ascii?Q?oZw+4Kf58hXp6D9LqM+pNoLV8CqzN+BRN9Zdaz9hSmdVmVrdZbeXA78mPnW7?=
 =?us-ascii?Q?SC30vnH89kV0ya6mKXDtXPVttz4z6mWlIy8DgAxw2Sbm87AKs+wfjSZTCXo3?=
 =?us-ascii?Q?JrStZN1D24Tf+G3hUweFra6/vQoAnkhPoH4BAJAdIaKrY0yBYxL/kQN9Bdlk?=
 =?us-ascii?Q?Fkcre5a9JbN7Q2A4t1dY8YFX0li7bUkYkOk5bTVB8OpFgqdeeVgEL/7kdrkn?=
 =?us-ascii?Q?YwRmV9SBoCogDm3723KUXXMUnRyXxhqNwb/p/aB0GqybZAkhwgUASuEHMF3H?=
 =?us-ascii?Q?vIiq54hG+IcZTdKNJRNRTN+jjgEr9CUJ6FUazMbpQR76ZXOP4HLtAlIftXKe?=
 =?us-ascii?Q?TaeMCTzWWcd3QWhGkLOC8u8Bb5tVZ4wUFzfMrtzhHdSuLV93+yexahreEnWw?=
 =?us-ascii?Q?TEzqjk6wGCq96PLbw2sH6hh9G9TeW32c6SrTvvRHfftXaV9VIiZ5VupoJZQp?=
 =?us-ascii?Q?SG4ZWRwBRoziOO9ImPVkSfBuEmcuJe+7llYZCi4M5eqKaZh/M5ikCI4l73mb?=
 =?us-ascii?Q?f1PhxPgygQ/JxkaoK6cTpY8oKr80q/c+uzkcZD6iBinUv5csM3LbjS9Hj9r/?=
 =?us-ascii?Q?J36p5BJcLOlhcYcrzLz7G4zFqDthLUBgU+Gqt2059AvAW+8xKPAeKzwUrh5M?=
 =?us-ascii?Q?7hHAepnhFT9JHKq1Lh08dbvcbsoxeZwjAz7kHzTu5MsqU36j8tVW4PARD/2+?=
 =?us-ascii?Q?BxhOp9+luv8FTHd8gB2igAlILhx+4R5YgGx47lrJhqcaSwmhMh3MFdWgXVtb?=
 =?us-ascii?Q?aea69rPc8ux8lNZu5F2A20wIZQiLaKXaFs4514fp4/mZ0w0+G3eKUzfwvXbz?=
 =?us-ascii?Q?JavJgVxvKDV+peG2L1UAaHt+kpdetGkNb++3NqoAgn5RCqPdw1SKcgPdlCQi?=
 =?us-ascii?Q?/j/DIZY0VkBpG9QR7Owh80JWi6JBxiGw+Qis94ci0I9aE3Ga5vDoGW1b92nL?=
 =?us-ascii?Q?P2g1yjMCJi30QBreqA+g8O08zUjBHNADZWacDzqzOc38qGPH/O08ZYHFPxcV?=
 =?us-ascii?Q?icFw5eyvyg31+DvJysWHReRH8IeqsME0KuO1SGxvKWy1tCMVHU7nR0HEKd4J?=
 =?us-ascii?Q?7XYnr6wSUh6j4Ocp544RtlzKGyrVRu3D2YBJN9H6d22EkBXJiwubOluBzD36?=
 =?us-ascii?Q?ylobsKPxZWQWyhGi2e9YU4NY3tSAjf03dnWtxn6/WtavPVZlfLTuo7Ipn0ap?=
 =?us-ascii?Q?VCHEj3vrNiBIA7Zzeapx2a/0D0SVNQKIkjWDhY0VusfAIlbdllvZmnf3bRTm?=
 =?us-ascii?Q?C2PUxhiakycRdJcT1a/bOnVaA5Q2wohmjL3zYemkY4tyBQckGTbFz7E7A8ku?=
 =?us-ascii?Q?ZA7LVnQfvZbstr0jqcW9hOdbUitv/HTfC0+54bCZDpSWsWDqf6zXpLKQPLo2?=
 =?us-ascii?Q?7A6XxBARi7BjPjuBGQsh0BCJ0CCf2SeV2SJd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:53.5708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d8112f-784a-4769-bd48-08dddfc35198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
Received-SPF: permerror client-ip=2a01:111:f403:2009::626;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
2.50.1


