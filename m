Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE8CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cU-0005zw-5Q; Fri, 12 Sep 2025 06:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cP-0005pq-MH; Fri, 12 Sep 2025 06:03:01 -0400
Received: from mail-bn8nam12on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cJ-0001GU-Nh; Fri, 12 Sep 2025 06:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJDua7ITxhGD2FAuCrEv5WtOBWWce//q0WVLv9z0HyegGRjC5S9Z0z2uZepKN7XbBx47FxOOFO5ZzyIQwrRVECGkbOIKSPOZvp/UTLCYXbKdYvTk4kzsixKz6ZetoNdP3E2kwsnQ9WCD13OIPMRVn/G42hHlpcK8pQLyGobSdPoOquPJAI+uWLd/UHJFb1ltBUc6I0aPIQDSQn634UVyP9/3VeWDSO582OIVRE+TsRLi5KXPtgasi+1/ZM3yStjpbB2VVMq8Tt8pHnK6gGCxYXnfAnPK5Y8x+VxluzjMBkzg6qWtK+MGx1qBC/gXeDTr8np/HYoCRD+y/nUHUvnsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPKO2fFZ18WTIPxqxLrHMiTGkcsboveMs6SeUeEeZnw=;
 b=ooPgm3Js9iuE6RVy161zv6A2pohBUPY+Kxs21Sa27g2XAMPwfssEV7fiDC1j7EdpTUdx+p6O5w/cHDDcxzHUKRK3V7OAqPvxHhqXXyWxdGp4OH3IIAKdWFFOTeX0zjI9wcbEpInpJI3z7x8FqGultzEMsgQYLUfCTid53APJEJGyay0vqpQi7Z8SmhZgNOv2xIR6Nld1DFc7RrtThlYzqEO4dlOvKqGGIiTg4OwBsIWkmD4uni1ACn+JsK0LIQWU1V5rJlb+TQ+dyTsr/Hs3lUI5QwEfgg14hE3NE+KewXHrwyzAHbUWPiwSqOcQlCT84qHkQqPblSuLMfVxbEqLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPKO2fFZ18WTIPxqxLrHMiTGkcsboveMs6SeUeEeZnw=;
 b=yEP4+p3Zt7AhbWhRGbXmhSGoGz4VxMneuYMcXmW9uaYYxTFYMslaj6ThiVWQAHn+ByMWrYyDiCZJuawNSy1JEnys7quYF89Fi0ETDybaB83Z/WK7c+nYUEWD5jLkuIIDdMqGG/RF85CSJIovvQUDEnqEcBoNiTZ7+wZx0/47KZQ=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 10:02:48 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::b7) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Fri,
 12 Sep 2025 10:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:34 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:32 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 07/47] hw/arm/xlnx-versal: adma: refactor creation
Date: Fri, 12 Sep 2025 12:00:16 +0200
Message-ID: <20250912100059.103997-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b633ce1-121e-46b4-efe2-08ddf1e38658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RYVZBDSNfCo+OhiahLFK7df0Ov9hLADKw8uqZ8kM8cYP7wKo/iKKHBWKHKNT?=
 =?us-ascii?Q?LRArvHg/xIMNYQNHRI2oLqgwUu0g/fLcRtPGUvhlFXaZq9ZP3TiWHDathJPi?=
 =?us-ascii?Q?nSILnOZdexvKKpT3SkHVIrd9Vr2cRQGa3ahjKdxow4UlVt7T+HfkhIXi1yCY?=
 =?us-ascii?Q?tyOJZbqvW+MVMfn4MSuV9pVl+1WvOvRPXf/kwRm3+A23d1nZFhcFIVYqP2rC?=
 =?us-ascii?Q?mRpFiNHqdRkR6OlFvUWM6yCLoZPtLQpY31bMVFYdt9cVAwf5YMXM2ccqohZ4?=
 =?us-ascii?Q?SfU5cYWb/4UEt5HxmidbkmMS5BY/ro7/XaCc1STNb61/0n+Qkvnv0S/STUm2?=
 =?us-ascii?Q?JKt7nMBl0RIZb/3FZNzmxPRVwvc64pVApM+6vgSF++wsdoiwU5bQz/awilOi?=
 =?us-ascii?Q?oYZ5xdQbVQA2boSemPIwejQ9GcMGHv28604FW0ksoi/ljmrvByOBkFWDhM8W?=
 =?us-ascii?Q?WtbCaSsqoX9s5MuiBP9+W3cG3ZmOw6IC1xxyXT56I/9ItPhlE+NcBXFhlkC1?=
 =?us-ascii?Q?mAWj0MbPQyyB34/kifbX850S8v5ck+V5D4qzl23ocmLIkcjXFpOYGOxxDOS+?=
 =?us-ascii?Q?lk8thEH7fPqBOaQnc+/0Q8sK1f6uvW2atXTpdFw8TQjfRjTWBAHDg/lJ9tT2?=
 =?us-ascii?Q?NaNca/5tPC/RoJ9+e7gpAYV4D+mDnsvvzpsRpydlOgqEuXEna3sriEznVWaT?=
 =?us-ascii?Q?Qmt1ftUgAIf0HFVxSMVUs0Ved8EZkRuEovmlZTL3dgu+RvzW+z4koY85GX2I?=
 =?us-ascii?Q?Ro8QYL78R6aNFxE8Ji+5W2GGSBHmmGkVBi6C7GPpO6a010DyHQEcrPwO1qoP?=
 =?us-ascii?Q?QJec5DV6Ft0LqRCe7FCgKVx8jgYnpGK37ICpJLy23ZeUxjx4PluNdwaTFVrD?=
 =?us-ascii?Q?qyhFKea8n8Ct9KjmG+K1jaovmyNb6WQuiKga5XMfiqucU/cCaLn0gYLJBt+L?=
 =?us-ascii?Q?R4nqle2WQfja8oVKftATq8HDfwnTbeOmutry5vXGsdkcs1qU2NyZjIoCW/nf?=
 =?us-ascii?Q?vQG5O34pfB0KbzcF7WfQMq6nY5wUpGjk3mN+fitl+0ea9Lysf5/THG3iQ9vD?=
 =?us-ascii?Q?t5X5oy2NSfJUA/P86L8hx4czvTfHmKH6j0o8aGfbzRm2AqKJA+X3z5uzBJyH?=
 =?us-ascii?Q?f+PhCVXv46dWaEZME6FZQ88GH0Y26R7nHgXavh7kvgq0bGWVpy71lTx6Bvap?=
 =?us-ascii?Q?L26TKGa9ygQwg8ugNnti41NEhyfgD21EL+lflCjXBvfUr3km5LPRQmZ2YxQs?=
 =?us-ascii?Q?riaJDAbOeaupWWL2Irvd5QEboqcs7wo5/gH95FxbWJxM7o8XBIizZSnfkpR4?=
 =?us-ascii?Q?IcqWiT+yUnXSuZ0RWPGfrUknew2gLdXgFRRIxHW1mQAMCg4EjPrjv+WDb+d/?=
 =?us-ascii?Q?IWYeRne8hpDEwLS6nBRoveRNTvP0aKW4DC7hgr45uoNfhZhsuGrna0pCeVEz?=
 =?us-ascii?Q?3CIiBNsVvpe7lObr+W9pUnjmTOLEHKRL0WDWdKJPPHR3bwpqKMziBabi//sP?=
 =?us-ascii?Q?NDd4Mq8khFMZDG9s5BjtsQ+8JQvxCq24FQue?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:46.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b633ce1-121e-46b4-efe2-08ddf1e38658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
Received-SPF: permerror client-ip=2a01:111:f403:2418::61f;
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

Refactor the ADMA creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  2 -
 hw/arm/xlnx-versal-virt.c    | 28 --------------
 hw/arm/xlnx-versal.c         | 72 ++++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1fcc2b623da..4eeea98ff34 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,11 +15,10 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
-#include "hw/dma/xlnx-zdma.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/nvram/xlnx-bbram.h"
@@ -75,11 +74,10 @@ struct Versal {
 
     struct {
         MemoryRegion mr_ocm;
 
         struct {
-            XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
         } iou;
 
         /* Real-time Processing Unit.  */
         struct {
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0634cc90eac..418e4c6e983 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -202,37 +202,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
     qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
     g_free(name);
 }
 
-static void fdt_add_zdma_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "clk_main\0clk_apb";
-    const char compat[] = "xlnx,zynqmp-dma-1.0";
-    int i;
-
-    for (i = XLNX_VERSAL_NR_ADMAS - 1; i >= 0; i--) {
-        uint64_t addr = MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
-        char *name = g_strdup_printf("/dma@%" PRIx64, addr);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0 + i,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addr, 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-        g_free(name);
-    }
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
     const char interrupt_names[] = "alarm\0sec";
     char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
@@ -559,11 +532,10 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 8ad67a110d7..3ffaa6fc56b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -28,10 +28,11 @@
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/dma/xlnx-zdma.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -58,10 +59,20 @@ typedef struct VersalMap {
         size_t num_prio_queue;
         const char *phy_mode;
         const uint32_t speed;
     } gem[3];
     size_t num_gem;
+
+    struct VersalZDMAMap {
+        const char *name;
+        VersalSimplePeriphMap map;
+        size_t num_chan;
+        uint64_t chan_stride;
+        int irq_stride;
+    } zdma[2];
+    size_t num_zdma;
+
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -76,10 +87,13 @@ static const VersalMap VERSAL_MAP = {
     .num_sdhci = 2,
 
     .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
     .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
     .num_gem = 2,
+
+    .zdma[0] = { "adma", { 0xffa80000, 60 }, 8, 0x10000, 1 },
+    .num_zdma = 1,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -490,34 +504,49 @@ static void versal_create_gem_fdt(Versal *s,
     }
     qemu_fdt_setprop(s->cfg.fdt, node, "interrupts", irq_prop,
                      sizeof(uint32_t) * map->num_prio_queue * 3);
 }
 
-
-static void versal_create_admas(Versal *s, qemu_irq *pic)
+static void versal_create_zdma(Versal *s,
+                               const struct VersalZDMAMap *map)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *name;
+    const char compatible[] = "xlnx,zynqmp-dma-1.0";
+    const char clocknames[] = "clk_main\0clk_apb";
+    size_t i;
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
-        char *name = g_strdup_printf("adma%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
+    name = g_strdup_printf("%s[*]", map->name);
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.adma[i],
-                                TYPE_XLNX_ZDMA);
-        dev = DEVICE(&s->lpd.iou.adma[i]);
+    for (i = 0; i < map->num_chan; i++) {
+        uint64_t addr = map->map.addr + map->chan_stride * i;
+        int irq = map->map.irq + map->irq_stride * i;
+        g_autofree char *node;
+
+        dev = qdev_new(TYPE_XLNX_ZDMA);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev));
         object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
         object_property_set_link(OBJECT(dev), "dma",
                                  OBJECT(get_system_memory()), &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
+        memory_region_add_subregion(&s->mr_ps, addr, mr);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_ADMA_IRQ_0 + i]);
-        g_free(name);
+        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, irq);
+
+        node = versal_fdt_add_simple_subnode(s, "/dma", addr, 0x1000,
+                                             compatible, sizeof(compatible));
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "xlnx,bus-width", 64);
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                               s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+        qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     }
 }
 
 #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
 static void versal_create_sdhci(Versal *s,
@@ -976,18 +1005,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
         object_property_set_link(OBJECT(&s->lpd.crl),
                                  name, OBJECT(&s->lpd.rpu.cpu[i]),
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
-        g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.adma[i]),
-                                 &error_abort);
-    }
-
     object_property_set_link(OBJECT(&s->lpd.crl),
                              "usb", OBJECT(&s->lpd.iou.usb),
                              &error_abort);
 
     sysbus_realize(sbd, &error_fatal);
@@ -1173,12 +1194,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
          * interface naming order when persistent naming scheme is not in use.
          */
         versal_create_gem_fdt(s, &map->gem[map->num_gem - 1 - i]);
     }
 
+    for (i = 0; i < map->num_zdma; i++) {
+        versal_create_zdma(s, &map->zdma[i]);
+    }
+
     versal_create_usbs(s, pic);
-    versal_create_admas(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
-- 
2.50.1


