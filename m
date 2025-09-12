Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88517CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cf-0006iR-91; Fri, 12 Sep 2025 06:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cT-0005zy-AT; Fri, 12 Sep 2025 06:03:05 -0400
Received: from mail-dm6nam10on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2413::612]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cN-0001IR-0f; Fri, 12 Sep 2025 06:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbq5A4ju/EzLbDWhaUmJqz6/n3Ka+cx0uSbvTEgv1psk17MGy972yiUjK24Su9ReVitv6VxUmMBfKe9MXMRzXEt6YP7PA1RUAzqOQCbNmD027evm124rCK9kPxvlYkhQWO0/6i1vJvwiu92WNeOWNEr8jnoNM7kcYTXdukiadzlVWmoIRY+4WAX9RcooKZCOfMckgen1Q9f0Ndo694LECTMJBbb399VFe387AmAhe74QLQyU+yFHm3mgpIjeQdPGdI11Lxn6BCB6JtUBRdlGrek1PUPOZNYvlWj6fG9BQKJvVoY26mtdpwqVP8PlV76peeXCO4tTRoZZz592oFUnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhJhJyukg6KiugcAfVREZrJO9aBMKQ9oXhatpPcXTi4=;
 b=WlzlGrTyYEw5QRxcLCUcZ/KQa+GCFJLSUYnL4HYxfmRM1321BcE/QKa5MiG6ZfNU4DBmdxg48oNqCd71gu/0zw/e8VcQESYfLpFEqwT+BKno+PcZ1EYbDoYCVPlUrLsLd6HEVpjllJeL4YQveOUHwynX1huuhw8+aommnUOEqH6iePLFxg0q+Y7KUL4h0PnS8OnP0L+7+ku/w7F9ZgSZrBSL4Y6kkckHixMeOBI45onauj/Z9yS9jak0BPoUOcMpFnRnaumRzz5wFNiOE8yEzb5anIcWep4fHnV5R6Mlk5jzcFRtcQyVogjiL0wOfUnhdCzBJoRgxhj0vtwHX7yCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhJhJyukg6KiugcAfVREZrJO9aBMKQ9oXhatpPcXTi4=;
 b=D0toL4bl4KkI5JiV9fj6tzvbhEBN3VdlF8JKb0t6YNvh5AY6fmd+pBvyFrTTbSfwZrTTnHDcX0r0UgSGQLlDK88cKMIvyI6TJncOx9naHrI/2ZV/XOlCjL/nSYeZU4cno2LqsZWn7jkgAuuxxAy2I5UdMhHdttF3R6DrAHh7nLU=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:52 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::70) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:45 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:44 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:43 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 13/47] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Date: Fri, 12 Sep 2025 12:00:22 +0200
Message-ID: <20250912100059.103997-14-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: a55ecd11-cf24-4512-f868-08ddf1e389cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UODGpRvnreGrTgcqilB5ZzgR1u6fUvJGFK/J/7fZmodiVqCQObYxTL9cn7kj?=
 =?us-ascii?Q?/jUNZo4MEhPsB3edikPBtLDQsvk57GNHKrXK5Vv01AUAVHaYNTiIGzzA/b3H?=
 =?us-ascii?Q?rem2yetk2zAU0wxZ9QN/AWRjhLQoBnPsofpjoZJH+kQoabbn3Nv7Z+ctfS7e?=
 =?us-ascii?Q?5B8/CJ0jIULYOzDO8vBQ7RK6KSZrSruKLqt5xyOKsTqjJFTPD9LMLQmOHrUU?=
 =?us-ascii?Q?wiH2Q00xqKI0Dz4OsXbccsVI4zmLFUkGdVslZiOdbKzHDsdIPKBNrrckR7mO?=
 =?us-ascii?Q?3Lt9Szl8j6EWyNNu8T7effTbaWGJuxL5Oqvlu2F2ukYzMN2IN0F02Qty1/+c?=
 =?us-ascii?Q?7r1F51mnxZ5bMJ4eD16dpSxdXvtil7M8+6iIU5tSkYh4FR4bAf7hUUEP6bjp?=
 =?us-ascii?Q?K/7smRFllEYcQjEK5xX92W3Wy5H2IuOfSKQmbzvRgZVjHqp6ny3OfoVasRxq?=
 =?us-ascii?Q?pRZAP0rWDcM1lWMNyDDqrYCM82a7/crMgcr2TEQh8pRZJGyNg1yd9d9/8NVX?=
 =?us-ascii?Q?nBFBFgm/DYARmf191V1n48ereshVnXs4h4ndppNiajSv9kQRqysGafBMpdcG?=
 =?us-ascii?Q?P35vQi73RTf8WjH72kr2SkytdCtmq2/8/kOc4J2a5+fKSzjrYDEU8pM8rbO3?=
 =?us-ascii?Q?CoXSgCHMrkwPVjnHkIpeaeOsen5p3LMQv0g38NPAILc7XGJfFdPDIVwQ3DYI?=
 =?us-ascii?Q?7ONWfDWKgOEOnZh4hh2eAYswsvA/gLz9RUGhxoPb6MeLqxkRt4lt/SSulEyq?=
 =?us-ascii?Q?TCMHJjwlHUX0HaHa5PaoV6IeVtG2skPTNZDDTygu24kvuWrUYVE92Gau7dUT?=
 =?us-ascii?Q?VmvV1mygze+5kXph8K62wDWT85uHOexCqmGOX2NuMV17i0s/6NI192N5J34U?=
 =?us-ascii?Q?fyOsOus73J6+lTSictd8cgAp7p+PVy+NRmDCj3eaOLnldTLnvOvWqbix/9b0?=
 =?us-ascii?Q?wlktg99OAHatCsaEn5n2u9jeGNE6UgPAo2JXeF5lPbyIAzmnY+Vz+dBlYws2?=
 =?us-ascii?Q?w/OQ56vZA7ZciL/7fbyV8Eh9A7B3V2F+mGVXEhS0mO1KeWyiEQRL95t6YrEP?=
 =?us-ascii?Q?RxDDISFrgJfoXMNvao0neUM6d05TcflldEXUCvkUns6VOXLSrMxU5mgsB5Ns?=
 =?us-ascii?Q?LVoZxpBzr854wJg3aJmON2gs2VylCmmSiId32KXOgLI5hedkEFdbPivD0gqc?=
 =?us-ascii?Q?7ePULF7Ao45xVR9Nm+imtgvh4FgeoQMIyzIvbCA3c8fVRVHXSoFPhLsQIqsN?=
 =?us-ascii?Q?gEkCZz2qRkeB4U0qfm8qzIK9F8wVb5+teQIklGS7/BljCsFwYkoP4Rw5bny3?=
 =?us-ascii?Q?/aUbr6HBWTAjebYiXtPayAL8xinGl92VUMgV9zXerQuO8x5R8VXUX5HrvC+g?=
 =?us-ascii?Q?AKJlXo7x/vtxsWnrDV/JAZBxOyMEN2t5qMLr1ypk9lhpjIvTftqqmpaBUGgO?=
 =?us-ascii?Q?roRFfeXR9qh3YF/gK1tZbd9Qe0bcysPYZq9Ry+tXlTrIyv5YQl1BHgKv810M?=
 =?us-ascii?Q?L6WnopOz/lAtJ2NZ8Y9MtzabHGdLpIjznvXV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:52.7662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ecd11-cf24-4512-f868-08ddf1e389cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
Received-SPF: permerror client-ip=2a01:111:f403:2413::612;
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
index ab769f66a72..ed242857efd 100644
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
@@ -868,25 +873,28 @@ static void versal_create_efuse(Versal *s,
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
@@ -1208,10 +1216,11 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
                   "is not yet implemented\n");
 }
 
 static void versal_unimp(Versal *s)
 {
+    DeviceState *slcr;
     qemu_irq gpio_in;
 
     versal_unimp_area(s, "psm", &s->mr_ps,
                         MM_PSM_START, MM_PSM_END - MM_PSM_START);
     versal_unimp_area(s, "crf", &s->mr_ps,
@@ -1230,27 +1239,22 @@ static void versal_unimp(Versal *s)
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
@@ -1269,10 +1273,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 }
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
+    DeviceState *slcr, *ospi;
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
@@ -1325,17 +1330,20 @@ static void versal_realize(DeviceState *dev, Error **errp)
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


