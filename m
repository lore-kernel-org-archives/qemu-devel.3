Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7300CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yI-0001RJ-Bb; Thu, 21 Aug 2025 09:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y7-0001N1-3K; Thu, 21 Aug 2025 09:04:40 -0400
Received: from mail-mw2nam04on20613.outbound.protection.outlook.com
 ([2a01:111:f403:240a::613]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y3-0002u5-Th; Thu, 21 Aug 2025 09:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfVEmKwK9DYSmPbi/3Zg21wkwHk3qboSq6NAXDtajoPMZTCh+f7Whw5wSYJ551yfiI1PbaP8eYb19BWwgUI6XJlrEOoN6A8dwhXvT4xpKdmKyL4MhcEp4Cv1ZMnfasWCsNtp3u08Pj4iY6AxyEiUvqkYolKwdANuozQ2Zj7ppWTVmYE+ipVU5xyLV+sqiu1hsmpRYuyUiAO2MVkKr5KRnxB/4/a6dGLuVgLy/FZTAxFG9is/UjVTnbwLUSFiLVg75s5tE+YiCErJVx86f1yG4/ApLYLj23cUWlFBfvtU3dytuKl8BJRGo6XWuU95e5B78xpF3yT7bEf1TMcMt383qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov1YVBEp04Va5An8ZHJNWYzqc4As5VAUcKIfEggj9+8=;
 b=ddDaml9Ej3cXSuYgqrBxh1ymMWAJ56OzQRei0vOFTbXaddocemIHAPiqsv0LANOxR9yccYE3+V9DhEpXu0WhFkA6ghMq0kMcj0ELKoM5gqoWF8pvz2J+7RYB1ReaWwQxr6UcPZ3uONvVKvCcnLVvOgju8A2phEXNvmqbAxb1NO/kTWh9R0zOMBFPnwMV1+Lteun5w5z9XU8PJ47XGtQh2XQFAHSCvJqHx4F/WwmyVxHvZsKHNaI04sLhiGAYttV6dAH4l3C9NaXRZ5xkj+fdLkguFUvaaFM3rK5F4NmVZH/zIiyZNI/kVyG4lSFv4AJeKT+6zgDiFKxvbZWf2geavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov1YVBEp04Va5An8ZHJNWYzqc4As5VAUcKIfEggj9+8=;
 b=cS+lOuuSXmB/kLOj639Uw7A62Zc5N2ER7m7Mnc65yjjcCgKVkTrWjID6ylSSda40su2hzdS8dFI14+iquVg37S0ncJB0fuNZ6J9CyYhiz6cfaSR2Fr4y9dpeE/eIMlDcToEE8wX7ddvM2NV0NqcslRQZpFoqh98AnNwmA9Ro1xA=
Received: from SA9PR13CA0083.namprd13.prod.outlook.com (2603:10b6:806:23::28)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 21 Aug
 2025 13:04:29 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::ce) by SA9PR13CA0083.outlook.office365.com
 (2603:10b6:806:23::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.5 via Frontend Transport; Thu,
 21 Aug 2025 13:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:26 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:25 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 13/47] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Date: Thu, 21 Aug 2025 15:03:12 +0200
Message-ID: <20250821130354.125971-14-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dd4d47-bc7c-45b2-63c2-08dde0b34374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBDBBgmSMENja83HyMoJcg+1FuhY/SlU+rDZp3BqSkrst0uNovpzCKzLvm/T?=
 =?us-ascii?Q?65XaUvC/3pbKw+DW/dkp0C4Dq2A3BeEIABPep7hOo0AlREN7S58ZJVEZxz2C?=
 =?us-ascii?Q?+eDT5JyHsHnyoNRiEcOC+sIc4ZTNcIq/1rEjKTURSkhYNfsJmY9i6anjS2+0?=
 =?us-ascii?Q?sbHjs5OCsRTcRXtiSBWjjqnQRfU3AxbE9IWHGciagvvIQonTo2mYBIQ1qebn?=
 =?us-ascii?Q?gRuETe81o/ZVz+v+f2P5Eym31UoIe8qSLtfyo/D9uhH7z+21ZYtHcB+qvi1f?=
 =?us-ascii?Q?+/ggEYbEMe0hwQ93/XMumyvz+7y24nFNn4N7kRkqJ2eh35iYR8fnkuqlAt2M?=
 =?us-ascii?Q?X8vogg8P48rUWR6V0TgL1Kc5pWecKmJgQWnMcDjawZyf6QhMJoIC1uS7lzYr?=
 =?us-ascii?Q?B/EqR3G98xe9LvD1g9h2tLc0/BcGAEWGbPRwWRU4mUiuCbbQLewksiAeqEM8?=
 =?us-ascii?Q?xcLzaTZB8TOIcu0jol5pgainWNmb36nS12uTnRITGXDnT4AytCiGOGedO53C?=
 =?us-ascii?Q?ms2ye6fhSpVYU2CBM10KiR511w+m6yXIIW8oLcl77oLRbpPzqygCM6AOIGlQ?=
 =?us-ascii?Q?xCQMgTrEynXY5mV/jlwkGEbo3pdtZADgK7y12QM7JfDNhAs3lp/e0U81kP9S?=
 =?us-ascii?Q?7m6+ZJ01vYu3UdAvm39NhQvaTBu6zIeTE3Hbmvr1imaItZmU43GGl1OgQsSx?=
 =?us-ascii?Q?wGXFm7sqfsJEM0I7pJIBqCntLTwBOkQtk1PPAwmarGrbEjIk5t2IGZtRCQIV?=
 =?us-ascii?Q?FjXI2OAmdYBiYFdWRixtVb8rIymEbf4DlAw0pb5d1iMrCNfQQDun4PANS2x/?=
 =?us-ascii?Q?iWqkQTqzERNSOY8JMKfaDFeBfk7iikvyeg97pGZBUP40uwbRpDgFynPseZqb?=
 =?us-ascii?Q?5YA0J+4mWz8y/i/U2vrEVaN/SzHoDow4JDyDMhm1Yqzl1GLcjjUZxI91eOsZ?=
 =?us-ascii?Q?iKoXtR67qCxt5TqOpAs+1DcZiVw0m2Qgy03oVM7vTDeIM+cTP6I+4QEZSkpG?=
 =?us-ascii?Q?b/7sGlN7JNicuRS4+GN9o8mcQ/DvpC/MZqWD4P/sS5pzR36fRaOS1DDBISFA?=
 =?us-ascii?Q?+VXvNVQVg4EGdyLEoYT3xhvlWlDYr62BAPM2F0QKQR86MvIdwrbeh5uP76SZ?=
 =?us-ascii?Q?QIaMWZJSGHb/JuhOvW8dKVEXRq/eabmgKAX76wr/xaCNUwa+0QOSIVhEQ0dK?=
 =?us-ascii?Q?vnVuQSh5zFQyAhln+2gUxFN4GYrVFlVL6W3/8N8dVyxzeoYrOFpHoKzl+t4n?=
 =?us-ascii?Q?1nCv1sS8xEbkxZXfcUr9mY7iTY3Y4a93arA0E8Sf+AQSRoyCFZTQ88LC9l1k?=
 =?us-ascii?Q?X5DclX+DPUUPKa9ikH9FsmBU+8jMa+bzrIhN4AM+r8iPf54/jKkDaE0ETm5S?=
 =?us-ascii?Q?naUVvvIXBP8+znhEErro/XNmDm4j0GfTQBMNp/XKpqi8yvNAS9caBbwdxdUl?=
 =?us-ascii?Q?lS7aypqNNMZ3pREdZaNGi1eQ1UK569RoNPr9pAhJpXbm19DDHM01pHInLXjf?=
 =?us-ascii?Q?lykNHeUQ3P3KUznwBkMsnk6fAcTXPlBjxY8a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:29.1301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd4d47-bc7c-45b2-63c2-08dde0b34374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
Received-SPF: permerror client-ip=2a01:111:f403:240a::613;
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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
2.50.1


