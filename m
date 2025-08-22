Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316E3CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTW6-0007tE-Qh; Fri, 22 Aug 2025 11:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVx-0007lW-3F; Fri, 22 Aug 2025 11:17:15 -0400
Received: from mail-mw2nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2412::611]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVq-0007A7-Jc; Fri, 22 Aug 2025 11:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2RQUFPUDraCoDDh7p2xNSaK+KxWaCjBibniShBIv+JpjSp/VrFtQjjFl2JKHopDm1C8oFH92E0zzC/tjl2BpXGKNRn6418u3YjxruA07pUeq8Rv5w/0kza7AieMvJynI0buc918foMFCotnYMg5o2xNQ0jzGVPyFbSQH3B5gWSQoFJ81NCR3sfdl5fgK3hZgVTsh/dKwkFSuiKC+axd3UcSTdaTjISFxKZNf3Yw1ZB5cRmJuBY8+qSaBGYHsKtU/FQQZBY/M/bVCbRjlqJBsJUEmHov3zqzwageeHGpcS0x49FICwmGbo+kAY2q9nhJuHvea7N66a1kTBDBRYdk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI94IQ8u5yeEDKzLYnaBVhG/Q+25wHXTK3edu+WIT1k=;
 b=fXTYtVRINClp4HQqpIvjFUIUCWfGYL+EtAwW18t/WQHOdNhB/s+kxl7/sS5uLl5hfzF0bku5XI0628zQMQ3piAcA6xheOv4Nve82H3wIPdiTGPRVPXq4qcM8M/woIrj1Vq5bK5LjnhxQcIGG2ZVCnhTThIgu3LFUqdIit+XTFq0ywzF2rbmypdD1roMyy6Kwu/CfsbwpNAZmA7HybIYJseoai88YDdzbWMsB7mziMbsOuAtp2gviw+1Qe5k4sX0IZsa0Po5p1sMPvmkBotGmZNRxO7kaTu2akuaaw6LBTkZ6KPziw2+yHI9I6mmyK/lPU6LmsZfxZiYXPt9iGmUmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI94IQ8u5yeEDKzLYnaBVhG/Q+25wHXTK3edu+WIT1k=;
 b=0g65M3QfTZHy9F3k1aNGn1TKXBVvaN69gKZ8ClPoXa5NXw1E4XBLTQht6pHx+wA1UXHZ16Br75DqN3JFHSCuzN6wX5bXyxkSwWJHE+NAkK1lQw85Bnj4RfR6Y5GeqKOesTFjGl0CkimQpKdRZ/ie7NsojsO4juU6HoRZmlvbnBE=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 15:16:55 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::90) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 22 Aug 2025 15:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:16:54 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:52 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 15/47] hw/arm/xlnx-versal: trng: refactor creation
Date: Fri, 22 Aug 2025 17:15:40 +0200
Message-ID: <20250822151614.187856-16-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 07200046-15a8-4586-82ef-08dde18eee16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CdsoD2R81GVZCjalBVI455hmqifpaY5MWH3unlB7gCUlz1uA4Qavb4dk5MJo?=
 =?us-ascii?Q?OvIu71AmKHduQT3xQvybQ/nImI812RLmuI/+8bcbB6THkcKWYjkkaKXaU96t?=
 =?us-ascii?Q?bnDK3StU3/NFJ82r1OHTjztFLfifmIFX5mJG7Q9snfMR8N2exgbVaya2jeEV?=
 =?us-ascii?Q?OTLZcXsSmT00xxhnaoaiG4poLdow64cZqA85ufNEApVpSjO44IZhC9nlZSHj?=
 =?us-ascii?Q?vPURRDI9Jav6yLnG8LDdR2OZPEjy53LVoTvlwvZh3LeTwkyFuqHlylgWewFn?=
 =?us-ascii?Q?by6ifi1I2AFY+g3KvCPVQTva9J62PcgYDkM+2BG4Z5UORMqJvWn5aDIdjqAZ?=
 =?us-ascii?Q?z1sg8meNkB6dAJAS/imI8tSSHjOSvoWxDN+eE6siglzHCxPJTF0Qo809FDya?=
 =?us-ascii?Q?K0Z/aoVjpDHUJnhPqIFmlcZXzBGtbTuQLLMam4YmYZPo2uV8zRVp3ficXR3F?=
 =?us-ascii?Q?3LwB2mlFHFhn4/qdUWt/iQMTEuDY+amjay3BPIkRmsV2B2++LpIDxJLtCr+E?=
 =?us-ascii?Q?P9VAMgkxDD2fJu30L6dZX/LwLWWbqzVpZOkapaMdnynW//o+j4LHK12l8vnv?=
 =?us-ascii?Q?cyeofqesOGHNRhC6Wid1Gn2T8C2iC1KlD5GTTVxB0EHnQ9J8m3BUDiEck4NI?=
 =?us-ascii?Q?adT25d9LM8YwT6yd1Oo0kpmkwOWcWZzGkqTq1lAUq0Hr3TYd73QApT2GOHlb?=
 =?us-ascii?Q?bh4GuUod6nILdQKL/VNERqdNeScgeUYofsiI1F6xQhtHVUMiOMj7X6/gajYj?=
 =?us-ascii?Q?dPoIhdo4MWFb9eOsF+6X8zjDAuqmzO5HxbLl/wqL9r7lyBXmoMtMhMokTOfG?=
 =?us-ascii?Q?RsZcUT3yKrgs2nNntFrraocYEQwC/DYD4uxVBsUScA/tZtxyT5C6ENyCumJI?=
 =?us-ascii?Q?0/COM1bZjvOyXFn1wg0SdkN1GNm6Hck65laX8Qa4BEcoBoCtuwTFhw8dHe/F?=
 =?us-ascii?Q?jSNsO1uc2ZvLoUj7X0VbaQQ9m4oqqQ5KpSKsfP3qNOUqFWfaLXU63ejv0F8t?=
 =?us-ascii?Q?IWF79XhYH2XYaG5qmi42Hx/+LQfxiilR9VrXVi9MokkOuDMiPv3EARdp7N0N?=
 =?us-ascii?Q?LwphmTjlpyRGHLLHalzZFi9TzRzDHcq2kOlnmiJJv3MNN3sO59ZJ8ZJ7x2uu?=
 =?us-ascii?Q?Yy1jhedG23KHb+2JSsyxGCNRh6WEBQLXOMjfN+6+AGiCk69UiAY9slTsKEBI?=
 =?us-ascii?Q?1vKJgbJOI5KDxj6/RCoA5Y2ugavjmn/Jf+U/E99YMufzIO78Cif381W7/ckv?=
 =?us-ascii?Q?cMKr8qTpFnlES0Ou3CPFO7dX/8/9krTOAEaZzUtB0I/6TBI3PgfCqzyCR/tQ?=
 =?us-ascii?Q?U5FUYXInAFYF9AR8rLa0kmKIdwFEhiBXpzOXeKTNfU2hRoNJDqvPMmHDoikq?=
 =?us-ascii?Q?EHbdfeLm5EqJNKbx1NNw5t30+yLf5zhuMFK6j5TqEMN4cVaZaJBvlMVUJRH4?=
 =?us-ascii?Q?mLPvN590yY6BCBj9dljWorRzyuo1QA/iXSt2KfO+WvkhX2BIljyWXswIcxYe?=
 =?us-ascii?Q?8XpSawphoP5ZE2TMITpPnD/v6u9wZdY9KBSS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:55.1741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07200046-15a8-4586-82ef-08dde18eee16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
Received-SPF: permerror client-ip=2a01:111:f403:2412::611;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Refactor the TRNG device creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  2 --
 hw/arm/xlnx-versal.c         | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9adce02f8a9..bba96201d37 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -18,11 +18,10 @@
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/misc/xlnx-versal-crl.h"
-#include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
@@ -81,11 +80,10 @@ struct Versal {
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
         XlnxZynqMPRTC rtc;
-        XlnxVersalTRng trng;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
         XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
         XlnxVersalCFrameBcastReg cframe_bcast;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9a9c21f782a..7b4dffc448e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -35,10 +35,11 @@
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/nvram/xlnx-bbram.h"
+#include "hw/misc/xlnx-versal-trng.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -119,10 +120,11 @@ typedef struct VersalMap {
         int irq;
     } ospi;
 
     VersalSimplePeriphMap pmc_iou_slcr;
     VersalSimplePeriphMap bbram;
+    VersalSimplePeriphMap trng;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -162,10 +164,11 @@ static const VersalMap VERSAL_MAP = {
         .irq = 124,
     },
 
     .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
     .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
+    .trng = { 0xf1230000, 141 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -778,23 +781,22 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
      */
     sysbus_connect_irq(sbd, 1,
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
 }
 
-static void versal_create_trng(Versal *s, qemu_irq *pic)
+static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr;
 
-    object_initialize_child(OBJECT(s), "trng", &s->pmc.trng,
-                            TYPE_XLNX_VERSAL_TRNG);
-    sbd = SYS_BUS_DEVICE(&s->pmc.trng);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_VERSAL_TRNG));
+    object_property_add_child(OBJECT(s), "trng", OBJECT(sbd));
+    sysbus_realize_and_unref(sbd, &error_abort);
 
     mr = sysbus_mmio_get_region(sbd, 0);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 }
 
 static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
 {
     SysBusDevice *sbd;
@@ -1340,14 +1342,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
                                 qdev_get_gpio_in_named(ospi,
                                                        "ospi-mux-sel", 0));
 
     versal_create_bbram(s, &map->bbram);
+    versal_create_trng(s, &map->trng);
 
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
-    versal_create_trng(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.50.1


