Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44575C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubys4-0001uw-Lk; Wed, 16 Jul 2025 05:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrS-0001JB-Ka; Wed, 16 Jul 2025 05:55:39 -0400
Received: from mail-mw2nam04on20624.outbound.protection.outlook.com
 ([2a01:111:f403:240a::624]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrO-0006a1-63; Wed, 16 Jul 2025 05:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGnevTh4xPbzz4rUEdiR2xZQV0rbWREOFY1QsBv9LXN0R5IzhhFUqboX8KtyP4ZZzWIA+p9MiAxaaq9V6NZOgqzH7n3XMeh6nLkU/39ww93bKYVV121trRHyHa8U9lYSJSAsitnQrYy2GVZiuQwjVuJ2z+6YlK8xmrmnrUrIl3mxBk/ZOcQNq7YkR14RBXpRkMhSPdP5i0mI0E+PK6LAUYQ5S09pa30agVL4jz/92AY0C7eprLQuA14P9D0NYwCCg5vLLp9iAFGwk+OKj7A+7oc9IX1Dd4QSjxvo8gJXnG65p7CV40+ZzVvHCcdgEJ+ekesoHIyNLKATcFEODnvjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilH/IkcAbjOunFpoYFFKUXIsOBSzcPJZMR7UYblBOOU=;
 b=HBo/SuBHWC+q/cMJ9FRD8EC+r1HIhOHDaINuKsoeZvPkpLvzXWgC6ic6rH7OmFargmgggPk4fxsvac90lglkbmBEaXBYJt+vcIfT8A02myoipquYwYIO7USqubfoqcM0NOpkHBUyO8YVxy4KNk+oZfl1Arlvs5ksRWeCb230j0thJXTuB+sfAJOfP+asNMwsSkmEd2LvbKVatQdOXFMZnFGGng94CiUMD/DG/eP6ZhzXct1CHp4bIOU+wLIyVcky6XyNlDZc9/5LoGtFAiy9ewwt137vl73plrSKCxlQS40k9zhH0lK3eoiSJ4I4qifihKfZYeX16hRd7hTs1wNRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilH/IkcAbjOunFpoYFFKUXIsOBSzcPJZMR7UYblBOOU=;
 b=P+5J7R4FVEZi+7vPBJ1U40JBdtu+xvfXUobc5eJ16vsxllVD7jTH8NB8kd8XPMR8iEN2sKJYUs4K2oW3jtyGd9dP91pa7MPNUYgxceYQy+kevTQLFUglvqQOt0k635aQCcfMxepsGM81b4Y4P6/eWI38QsLLItqZL8ZWOewWQ2M=
Received: from CH3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::27)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 16 Jul
 2025 09:55:27 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::82) by CH3P220CA0009.outlook.office365.com
 (2603:10b6:610:1e8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:25 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:24 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 14/48] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Date: Wed, 16 Jul 2025 11:53:56 +0200
Message-ID: <20250716095432.81923-15-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 59836d21-82fe-41c7-5108-08ddc44ee415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?by5+j/LBOoTaH5zjF82Fax4GgBMy+XQHGSLe8Xh/b9hBZjGOAto8sG/hNLSJ?=
 =?us-ascii?Q?OmJAwnH8wG5B9nDrf2o6PaNJcEnTLEf7eAFFvtB9egYe47JtrmilEuru6G64?=
 =?us-ascii?Q?f/aUFXwdWVTpMqQZLIMgBKQzxOFzb960uXJs1k9BuCNoiP/SN/2OCxKPFmqL?=
 =?us-ascii?Q?Qfe+dNvvLMScJTwRNmGubUsSbCkNY0kuruhVguU7w9pCWYFFjd+kJhnsoB34?=
 =?us-ascii?Q?JR3snA0EzTITfJqTW5X/9iy6FY8DVhfJqUgrhJR4LZP8dYhAPv7G91rSKqON?=
 =?us-ascii?Q?sy1Myjt58uNGQ0TbbojgndZYBT+UafPEl8MGtMBPj7kn+pqRSfQrZGyCOdu5?=
 =?us-ascii?Q?2z9KIJnLvHiVi5YweV1QxLl0mecsik/ThykCMsLFp1Kzj0Stu78985LBNIEs?=
 =?us-ascii?Q?zx5j++HUTz+g+rlVqmiHHMpDohvS7Kv8QGkaK6FIIvPYj4Tk6zixNOOLaxXC?=
 =?us-ascii?Q?/wGnSX7TLWPD60NCuWU1JZrUOrslhUpDbvOEOrBnVQJzRLoi24pE7R3VV9/d?=
 =?us-ascii?Q?JDSU3LLRmF1wIUbTV8jW09ADnuJxvbVpwj3FxxmnVerI4wBQhRXKzH94oDst?=
 =?us-ascii?Q?L+quDr6L5ay78ZCA3OsybqK9h7R76a/OQrAVTI7/PbhYwA3v6ByAQT6nj8BW?=
 =?us-ascii?Q?m9nueqPHypOOxhgInvE+fLCWhiQch6Hd7XqM22dAn6p6i6n+9J7jCqVLcYkE?=
 =?us-ascii?Q?bOwutEE21RL4UFfQ/CUoAPTvB7jFu4jFVfzJqmkfZuGsgBkMbWv0vPIsiYRb?=
 =?us-ascii?Q?b+czDw49m1foq24Fn+61svNGI8PLIqBgYGuT/0HbFujxvsbfIeZHV0WgSbJh?=
 =?us-ascii?Q?0u7GvB4A2+f3CJ8CfRFBCHAadt4iw/4b4AkSRsq8GbvdDeuUTzSedbsGUdua?=
 =?us-ascii?Q?oJxJ2CwZmoC7T3LPpvmhQjptigbutFv1S4BQuBTDbcq9fKHarPUlG3fNDuUm?=
 =?us-ascii?Q?rhkWtiLiwwyBrDYdkSWSU5u2RSERLSmLoeCmkKDiZJ8ypFezAFI7dP9z8Uos?=
 =?us-ascii?Q?BSuYxIG9KPrujx4ehUvA6Si32yNG5y/sq9RO8b+QiqwVnyAGLpKkAA99f1zU?=
 =?us-ascii?Q?wy8/8j5h5C0EOMtAUscDrN9atxW6E7K1e0xRiAFBX2HKd/sKPDDiYioo7dN3?=
 =?us-ascii?Q?eRDOd/C3gtLaVGwxDMbicJONgbcYmLavTHe5kxyVWBWl0JcemGCi70iu3xAL?=
 =?us-ascii?Q?JY3MA8bqbafXCubNy5uNduPjf4is2pifVVfY7md0hIkZRkvtRyTynQVeARsk?=
 =?us-ascii?Q?jlXwOrnZFiYb59E3A03+gfThhusHNXR0XeCgWfpNrCv2hAfVIxG1zxIUMsoE?=
 =?us-ascii?Q?/lcGtw/gO90pjGagaEXK3U5FM0vra1f8KwqN0m6pbl/PmXwgTLawHDsiYUco?=
 =?us-ascii?Q?Nu54bSMZGAztLGilXRCM31ebUmNig7PSmahuPu5HzpI4tBaT0vjS6mBp+LPu?=
 =?us-ascii?Q?2Y+5q4cGRgrO1TQFi8/Lm5FxVDaO6G943J4nNhrwjpO0zdPfZIlxe4UXPFPU?=
 =?us-ascii?Q?W5I2o0hxLfdURmQWqFhSopMxqoPrL0nLbjHs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:26.8765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59836d21-82fe-41c7-5108-08ddc44ee415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
Received-SPF: permerror client-ip=2a01:111:f403:240a::624;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Refactor the PMC IOU SLCR device creation using the VersalMap structure.
This is the first user of a shared IRQ using an OR gate. The OSPI
controller is reconnected to the SLCR.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h |  5 ----
 hw/arm/xlnx-versal.c         | 48 +++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b7ef255d6fd..78442e6c2c5 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -19,11 +19,10 @@
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-crl.h"
-#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
@@ -82,14 +81,10 @@ struct Versal {
         XlnxVersalCRL crl;
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
-        struct {
-            XlnxVersalPmcIouSlcr slcr;
-        } iou;
-
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
         XlnxBBRam bbram;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 89c93278336..d34a36e18aa 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -33,10 +33,11 @@
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
+#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -114,10 +115,12 @@ typedef struct VersalMap {
         uint64_t dac_sz;
         uint64_t dma_src;
         uint64_t dma_dst;
         int irq;
     } ospi;
+
+    VersalSimplePeriphMap pmc_iou_slcr;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -154,10 +157,12 @@ static const VersalMap VERSAL_MAP = {
         .ctrl = 0xf1010000,
         .dac = 0xc0000000, .dac_sz = 0x20000000,
         .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
         .irq = 124,
     },
+
+    .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -861,25 +866,28 @@ static void versal_create_efuse(Versal *s,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(cache),
                                                        0));
     versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(ctrl), 0, map->irq);
 }
 
-static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_pmc_iou_slcr(Versal *s,
+                                               const VersalSimplePeriphMap *map)
 {
     SysBusDevice *sbd;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "versal-pmc-iou-slcr", &s->pmc.iou.slcr,
-                            TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    dev = qdev_new(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    object_property_add_child(OBJECT(s), "pmc-iou-slcr", OBJECT(dev));
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.slcr);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_PMC_IOU_SLCR,
+    memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
+
+    return dev;
 }
 
 static DeviceState *versal_create_ospi(Versal *s,
                                        const struct VersalOspiMap *map)
 {
@@ -1201,10 +1209,11 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
                   "is not yet implemented\n");
 }
 
 static void versal_unimp(Versal *s)
 {
+    DeviceState *slcr;
     qemu_irq gpio_in;
 
     versal_unimp_area(s, "psm", &s->mr_ps,
                         MM_PSM_START, MM_PSM_END - MM_PSM_START);
     versal_unimp_area(s, "crf", &s->mr_ps,
@@ -1223,27 +1232,22 @@ static void versal_unimp(Versal *s)
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
                             "qspi-ospi-mux-sel-dummy", 1);
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_irq_parity_imr,
                             "irq-parity-imr-dummy", 1);
 
+    slcr = DEVICE(versal_get_child(s, "pmc-iou-slcr"));
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 0, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 1);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 1,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 1, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "qspi-ospi-mux-sel-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                "qspi-ospi-mux-sel", 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "qspi-ospi-mux-sel", 0, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                SYSBUS_DEVICE_GPIO_IRQ, 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
 }
 
 static uint32_t fdt_add_clk_node(Versal *s, const char *name,
                                  unsigned int freq_hz)
 {
@@ -1262,10 +1266,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 }
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
+    DeviceState *slcr, *ospi;
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
@@ -1312,17 +1317,20 @@ static void versal_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < map->num_usb; i++) {
         versal_create_usb(s, &map->usb[i]);
     }
 
     versal_create_efuse(s, &map->efuse);
-    versal_create_ospi(s, &map->ospi);
+    ospi = versal_create_ospi(s, &map->ospi);
+    slcr = versal_create_pmc_iou_slcr(s, &map->pmc_iou_slcr);
 
+    qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
+                                qdev_get_gpio_in_named(ospi,
+                                                       "ospi-mux-sel", 0));
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
-    versal_create_pmc_iou_slcr(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.50.0


