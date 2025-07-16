Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58D8C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysv-0004qk-OV; Wed, 16 Jul 2025 05:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrp-0001aX-Hb; Wed, 16 Jul 2025 05:56:03 -0400
Received: from mail-sn1nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2406::62e]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrh-0006by-EO; Wed, 16 Jul 2025 05:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Able05SvU2fP4YbNkej3L11NLHbI9fW84q60QdQdIQXR/cFHWOXwuCO8XmMMzO+YW5fAw9jGbmzRFMUOf9qwgcXiVMeVYBcOg1HXEkwapkwOb18Tx9DS5jddiswI2ad7KcKPQELQdGTXDS611m0PAO/JzXrY3RQpex6bYJ/Vbso892CQuv4Is8FHVyHjYTEOTp11yHXaihf3WVQTn3CCKcVNGL6y0XGVj0LB85XM1qMKSfioKo6UhduEd4et3ZamB/7iyzluX+5knXFrR2/vfoOChCQSxEV4lI9f6LPEP+Eu3ji7994zhgeUAiFAu1bL+zGhN2fc9loINyHICXC60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJILH1j+32DUYA7ArE+alKSndJq5lrSNm12RZRY1HPo=;
 b=HW4uaMsj+lTgSPQiFy0XcLrnlUzR8+f7I7MBWhBiY0Tq3jqsCqzT9wxMm1g6uzpP/XuIpzfa+K78gUkXV2btefwUGQjtjCQDaiagpv4ecYcDDkWUycEwvCZv22YE3u/OYwCJCZeULh91inL/J77T5UAJh6AhCyH8YJ6BEcd8a+WSzXHX23/hfTnfWYq7A285PoykxJMAmi05PPJRAN6o4yZtIk2uzGCLnnsdXxVh4IaJFOXglXI0+i0Tzo6S/g3jOE+081U5TR4gvlQAdMfApME1rXxSh25zDFwp4J4O9W954pad2xg/654o4BQ8QDJrcUCE8g32GxxUr0WAV1OHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJILH1j+32DUYA7ArE+alKSndJq5lrSNm12RZRY1HPo=;
 b=lH94ZGLzP7wfC4SwB2lzHrL8CF+ItCQ6Yq6wJY9NgDAc43poVlQmKdR5mg9AHtYz0JWPR5LMvNzoY14wH5GCdSTACk7EuDXs/BFFslZQiZwjzk4zcACU+3r0njmzzmgxvw5zWPcmt2PkUw//G/voZP4jKWFOngaRcz3jVCbB0LY=
Received: from SJ0PR03CA0123.namprd03.prod.outlook.com (2603:10b6:a03:33c::8)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:55:38 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::41) by SJ0PR03CA0123.outlook.office365.com
 (2603:10b6:a03:33c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 09:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:36 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:34 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 19/48] hw/arm/xlnx-versal: crl: refactor creation
Date: Wed, 16 Jul 2025 11:54:01 +0200
Message-ID: <20250716095432.81923-20-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f00b979-5b11-4885-c1b3-08ddc44eeaf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8jnUcfZzXu7NMsg6QvwCrCTOZiC0Q5rccV4j4qjBmDsBPLvUCYy6haf30cH0?=
 =?us-ascii?Q?KCZoVfja/dsJPCcqGwk3O67QThRc6wP1Zfg4iMqcyVd1FdUOy2zgpZp7EwEu?=
 =?us-ascii?Q?3e5V99mPOCgIZytghWKpfA8P1lC1UzMDUajaXXYW6doqnSmMHZy716YbHcM1?=
 =?us-ascii?Q?h3XM72MeMgeBVv4XXL4uh9Z+/QaI8bsWTtNFw164cRBVqcI6iaRx6XDaT0le?=
 =?us-ascii?Q?4cy8TfpF3hlDjfJBWPNjc3c0qDoB9yWT2AL/dFS4sYYP+QNvO6c7bSbRnmvE?=
 =?us-ascii?Q?ZMb3gixzclxL8eoHIxyRcP8k8urAspy6DxJ5im1Dk53tKDe8NevSIX0hObS2?=
 =?us-ascii?Q?0950IRe526FZ68SqjBTNcymIEAm+bsgxqIYYe6H+GxFxporXLomJzaOOGq9O?=
 =?us-ascii?Q?Pt8Da8Mue+D0jghAom74yLKUFZFgsvV6gcBGrPoHdHw4TUYbAffnUrwLq4IR?=
 =?us-ascii?Q?YJgwU6xL07lgsIG7NPUlzoeNpUS+MW32HOgnY1VjBMclB37v2grTvHl9DX60?=
 =?us-ascii?Q?3XnmTIEUGsXV9TIQZ8jP4KFBr661tYh5PeT+rkKSx3FBn7ePZo2riEmGy0q8?=
 =?us-ascii?Q?KUSpiff00W7PErE1ez7Aizlsi5m2OQ2mZm0MPY0qWmGs8lw25HlhsqIWXyep?=
 =?us-ascii?Q?eXPstZG9+dyeYYKTnSEILSsCwqpOkHhPc6PKyUH+wr2iEksw2M2PVm2axNha?=
 =?us-ascii?Q?7X7jHNeGx8lcc3OIBu91S/klwZVaazSZX6WPAcos4c2aXw9hEEqU9WCXJGML?=
 =?us-ascii?Q?tYXn3/G2Hhvc6wwSrNMo8kIlWtHnTgHs9Ur7xfBtjrPkfhHXQg3ZKtFU3rrS?=
 =?us-ascii?Q?8IKcxs1oxOaf6rNp14fL5OcHsfxOQsk80vtQZin9Bo6sj09wrhl6wMBBfUxI?=
 =?us-ascii?Q?H/n3DMv+MQihLzzCBoULNVx5F7YyDDam1wUWidflkZ7jXlqWu2b+CjeCT2Ph?=
 =?us-ascii?Q?1CJPdtSF1qa7GWfJwocNI7qYqG8YDMDK3CFA/PX3UysPZhjf5jzJ+Emp0hyC?=
 =?us-ascii?Q?QsRb5B61/6aBrt13u4nNjwgdu1FCuK+quAmVKuznvC+vZmNCS2AFi5vZItyH?=
 =?us-ascii?Q?b+Jn6wJz3D2hLXxDb7Bb/2DnGUx01/J7N1OM+kSMoC2+ZMo0pd8xJAlKW29J?=
 =?us-ascii?Q?giMOaUhY8cnckO/efSar/36wAKQzHgP6h5Clmgx93S17cj0f6mz+3cKJ8KUy?=
 =?us-ascii?Q?BNKQQS8bcUK50mC4UiaTbJAB/zpvVBNBlBUKTv/PLSHzv9SQO6hz5JCUu1Ig?=
 =?us-ascii?Q?tPWSlLDPTwMUUcvdyUzusu1qMya9P07UFsv/dwv5Hcyw76M30cVBgJTeoSSo?=
 =?us-ascii?Q?qvr2/kxyTfh/Y4nhxARA1DxXZqDgdf2T+Y/m5AYf9gWlt0ifkPJBCex1bhsb?=
 =?us-ascii?Q?9Emdaew+vx/Ih2KfQ6A90I+B3/bODF90Q9cuJtJza1na2nGyv4G8CLuzXQk8?=
 =?us-ascii?Q?nm52D9AcimTseqVsNcRdSF5MbJb/CS4tBfG0a5DmWhIJeWbaiRhaPBpcOvaN?=
 =?us-ascii?Q?RkY0/O76wSz1jqF63R/DrPIYKpdlK/5vCoHy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:38.3848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00b979-5b11-4885-c1b3-08ddc44eeaf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
Received-SPF: permerror client-ip=2a01:111:f403:2406::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

Refactor the CRL device creation using the VersalMap structure. The
connections to the RPU CPUs are temporarily removed and will be
reintroduced with next refactoring commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h |  3 ---
 hw/arm/xlnx-versal.c         | 36 +++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 5a685aea6d4..d3ce13e69de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,11 +15,10 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
-#include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
@@ -69,12 +68,10 @@ struct Versal {
             MemoryRegion mr_ps_alias;
 
             CPUClusterState cluster;
             ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
         } rpu;
-
-        XlnxVersalCRL crl;
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2128dbbad92..ff55ec62301 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -40,10 +40,11 @@
 #include "hw/misc/xlnx-versal-trng.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
+#include "hw/misc/xlnx-versal-crl.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -149,10 +150,12 @@ typedef struct VersalMap {
         size_t num_cframe;
         struct VersalCfuCframeCfg {
             uint32_t blktype_frames[7];
         } cframe_cfg[15];
     } cfu;
+
+    VersalSimplePeriphMap crl;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -213,10 +216,12 @@ static const VersalMap VERSAL_MAP = {
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
         },
     },
+
+    .crl = { 0xff5e0000, 10 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -1106,31 +1111,28 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     sysbus_realize_and_unref(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
-static void versal_create_crl(Versal *s, qemu_irq *pic)
+static inline void versal_create_crl(Versal *s)
 {
-    SysBusDevice *sbd;
-    int i;
+    const VersalMap *map;
+    const char *crl_class;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "crl", &s->lpd.crl,
-                            TYPE_XLNX_VERSAL_CRL);
-    sbd = SYS_BUS_DEVICE(&s->lpd.crl);
+    map = versal_get_map(s);
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        g_autofree gchar *name = g_strdup_printf("cpu_r5[%d]", i);
+    crl_class = TYPE_XLNX_VERSAL_CRL;
+    dev = qdev_new(crl_class);
+    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
 
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.rpu.cpu[i]),
-                                 &error_abort);
-    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_CRL,
-                                sysbus_mmio_get_region(sbd, 0));
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->crl.addr,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
 }
 
 /* This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
@@ -1327,12 +1329,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     versal_create_bbram(s, &map->bbram);
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
+    versal_create_crl(s);
 
-    versal_create_crl(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-- 
2.50.0


