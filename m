Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87121CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aO-0006X9-Ux; Fri, 26 Sep 2025 03:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a9-0006QM-Dk; Fri, 26 Sep 2025 03:09:29 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zw-0006cb-4Y; Fri, 26 Sep 2025 03:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvl/qLh8ATWztdkKQFnd3MtzJjKpWesHgx1z/I/07N3qKM4xOCJGOn3rySX5OrT2sMAKCb0xmv9ayAqwtrbUNJcDYgudGpov0GQ/83xJBo7+LaY9XIY8vfKWXRusvUpC+sLWaIpdtA4BIdTUQqN1ZNbGcfxd28Qe6WjFh/XzF6QSDpgje406yWHwmrjOwwBcu52DI8NC9bgXF8I28hT8a8xjm4VvPspz5yFmwCVmKm/exIEFnuVvIkW39E8MC+an9dqEQxVxnUoR+RWo5HB1OxIudSX2PbNq9M3DrfUvUlKZObN72RDaeAjJIljsQZr6p7FhOuoosE4jRzXuQq3O3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlTAmkKqA5TD5PwrjTbs7NSjsdUQHpoxITuTPVXDjPQ=;
 b=PzmnSiKME/92k0VsMuDQ14HE8ImQ14p2KO1Tl8TgI6qyhhDsR1Dcz4hlHoOAwrD0jMYt4fRUUXLYXCHiUl+pCs2YcRzdL4kxdr61obuX2itR5ELmgrJXtvYMt7H9Jpu1/AMds0KCe7FCYsh8hWcjOG8fj5SQPbl0ZGwlbBRJkaKetCKUSjaKG9VUZAJ7CKW5kAwaX2ld5Nxx3p9AAbTthNRFCTO0ap03MHnGs4+xdxOpRdeImW5nVpST2Zx055iG1FBdHFsR+h0X1aDAFOJlJ5UK6GJmJGFxlgWFPS6RRqkav+2Do7YKg31kanxuiUXClO8GL9dn1WiHpMpdxWp/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlTAmkKqA5TD5PwrjTbs7NSjsdUQHpoxITuTPVXDjPQ=;
 b=AdrOpwbZbj7L4uVhrt5uKM+HjnctU9GXuJDixREPCTW+uWISL2NcCGw8/W3hUXmef3X6EyJ33L7O2bN4sEHAwnVROL85sXWLfWIqLIXNVKk2IEznr0YQ8EWbrgNvGKtAdTJ85nAuisuOnky7FOaK+PBct//MHg1Dfv+oKmSCZ+k=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 07:09:05 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::75) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Fri,
 26 Sep 2025 07:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:52 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:52 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:50 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 22/47] hw/arm/xlnx-versal: instantiate the GIC ITS in the
 APU
Date: Fri, 26 Sep 2025 09:07:40 +0200
Message-ID: <20250926070806.292065-23-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5b2a54-6c93-413c-e6c1-08ddfccb941b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rtyeEs9XX8rXbnlsFszSmlLQcCBXI5AHPDJ/VXmGx8TFc4Xr3Clt7t2t1MQF?=
 =?us-ascii?Q?o3ZnVIg1ytn1d9YCBkYaU+am251aFzjpw7H7UOJWjk4w0P6XrHC8as+2EdiN?=
 =?us-ascii?Q?tzyz4EFJQ0GfwwPUHFiW4BsWP5HyseJkhm3ngNgzPCYdTuhilS/e/l+Kl9fN?=
 =?us-ascii?Q?UhOMAmmnHsYhTg1GvxG4kvkvIVo0TZxVM0I5xiYcTLrrfyfmp1/AtvDMWy37?=
 =?us-ascii?Q?brLFcQOop2euASpZ6NAOTc7dsbQ4aFCMFgVJ/lR2CGHKlsWWMBSs2RlUC21u?=
 =?us-ascii?Q?UEGWPUMuEyPoCmJpSFGoGKaW3QVmDdrIiBt6878kU+wzP4NaIp/rgnkBR0Ox?=
 =?us-ascii?Q?V4jppFohY583xlslxYtlZw6wxKQULzJHx9S9aq43KJt+PKUqGGNjOpp/7WoN?=
 =?us-ascii?Q?lLpMV150JH/bEDwSjIU9cDsK2F3sGichWTa4EAnfDdvONFW17a14hDzm95oW?=
 =?us-ascii?Q?w5iezM07QVBv8am9IevOTwwiFm3FdzsTFU9i0C86hw0e5JLLnrkH5p7QmUD8?=
 =?us-ascii?Q?+MYwl3QY23kJX/Wank6BY1M7+4JekYlh4UY+yCXQKj2vt7TGiJ2UWaLKlekd?=
 =?us-ascii?Q?x6CHsdPSTvuyNNL0CjpZf0nLH8WZ0O89baWUdLM/U+n90aEF25gvGLAT+R76?=
 =?us-ascii?Q?aBUhWnDpyptKCTJaRmAmMVt6yTF5jKgw7/2QCCVI+bYTDuBhdw2HDJZJHSNv?=
 =?us-ascii?Q?3QkaqURezCOUYH6gyRYGnEXGCb+ibcYJqn/BMGVhvV2Hgvi30pyRQXQ8e1g2?=
 =?us-ascii?Q?tYLcbKGS+5y0mxzLQW00zPNigt8JYSL9JgP1CYM01Ltol7GcBDkg1+u+2CCC?=
 =?us-ascii?Q?NfIE1OxeeT/UfLIzLX4f1s50+YMmxrWFHaYrvX5hdwtofBveqOHV8b9rDLgb?=
 =?us-ascii?Q?D0Rkg/hF61AcuQgE6sbmG6UoKbV1vJHBkZjyz9uDflI4DaEqDuzBiaI4GKZ7?=
 =?us-ascii?Q?Krr771jCAkUN9sh50HmQ7Px+RCv/Q5KtObOr2YzBCr8lGj7gubWz7tl2q6Bq?=
 =?us-ascii?Q?qAd9hOtW2SR0pFFbS/UTGNN+4rjHdBvtcLNpI4pT6+CzjqIEFlEbfUOasUd9?=
 =?us-ascii?Q?FjZUWGmPdYTvL2VdNsxeNvoxQSKZFbE1AEBvnO3cfPaCGu+Bc71NNXqyLWdz?=
 =?us-ascii?Q?lPDbIumwgtdhItIbnPD8QW+N9VaTSRlLUNyvCe2y7EFazTNo9R0ac2SaeHuQ?=
 =?us-ascii?Q?JcyF0s2PIqETtrKautWrJe3iGOchUvqKsj1FSJQL+OxD5Wy7UxpbUcmN51/Z?=
 =?us-ascii?Q?1qAfItZmqnR5+Y/ieRY6S1Tq74BxGf8TjZu3wgWDDcE6Sg4HXNgb6shrlteX?=
 =?us-ascii?Q?ZLFKT03Mu0cQNHvaq7JkcfuNxap5MVNJOu7tJy6w2kBVrlhPKTtYlYFEW1at?=
 =?us-ascii?Q?jLZdqwJfmswfswk5IUqedMnl2AvFuTzk00yU7Ebk6kJXtrqrfQ2Lpn4dlm7W?=
 =?us-ascii?Q?NPmJNyMcU+vfWCjpCCFwjN8t1JDKJivOd8tOyn1M9erQazrH3CT7XQY4CWHB?=
 =?us-ascii?Q?IKhSxfVZC11crOdJddFCYLPxbsmaIcyFW4w9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:04.9153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5b2a54-6c93-413c-e6c1-08ddfccb941b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index ccb78fadd7f..e03411bc212 100644
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
2.51.0


