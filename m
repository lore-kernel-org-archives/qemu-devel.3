Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA8ACA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVt-0007i2-78; Fri, 22 Aug 2025 11:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVk-0007cV-UF; Fri, 22 Aug 2025 11:17:01 -0400
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVh-00079A-Qr; Fri, 22 Aug 2025 11:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hsplz9PjVzZNPSNEoJpC8gJDq8C3G8UWBt+sglBCXuz1IaF5fbYeI9z07SdKyawX2Cw75Jlq1pUYyQtBeuqqdpwjt30Yg6gkCj9HX2w/BFsOq63+0nnj2dcGpEfKDiT453pt95m/sKEsS0lBDJ2dSbMd96uc0JJM2SLuDuUyeGjZauXaMxVdVI9IP0mC8apFgKqyAa2Hu8Nf2hHEJ1+MOSrMNwm5pMFLd5vRTWLBQn9FwRvVryWkx3H8B1N+2JGu6RM60FmqGY4YuHPxk6+uV3AD8gDB9+Vx3Y7IJvz9B3WgajKqCB02FqS8ftFFybysiW+kym4JUAslY8VLROLwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb7QjWs3ma30/B+Q7Hy6AFWBcX5GJcahMqDDNxN93vI=;
 b=uhDKOjMlq/dhi8AT3chOLZg0mot1n0ng21pdfidAaGJekGxxXsiv5iJgErI+l2n6NhxSrZND0e2WI+if3eZIoCeip1of2ljrPGi4jTERnNMKeCQO8TUifFZWfjf8mpzQ4Sj4oyombtJ+U8h//bTl/tPzxM0ODULzNBpNdX9+X8UCfS60iG/dpLwSJBEn3tVH+FuL9xm1NYr7EXgTW0eCS3aKincGJlT4i8OcF7qtfehzzKFwyh/xitRas5/TYkL95sbjhYwrIVVTGkCG86x2aCYnz0KGA9F92oKDntmllkFEP73eghex4gvhBbgL+lwjfKT7CYV7STj5REPlTWRQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb7QjWs3ma30/B+Q7Hy6AFWBcX5GJcahMqDDNxN93vI=;
 b=oPnRerwRSot+PvEi/iYtseH2ewRtwqlShRDnXJrT3TT0M/ttbtHec+hVcENeefP2FbUI+AQoHb00mzzt0iY9bqsVuvoImRzWgx4tWM/I3PsHkIVfxt/wH7G7r/NOpia8VuX9pEturU/SeRSd4oQL86iPF6sfKw9+sCpDfXyIPv0=
Received: from SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::7)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:16:52 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::2d) by SJ0P220CA0001.outlook.office365.com
 (2603:10b6:a03:41b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:50 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:48 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 13/47] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Date: Fri, 22 Aug 2025 17:15:38 +0200
Message-ID: <20250822151614.187856-14-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd90084-f9fd-4931-2ee6-08dde18eebf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YPDzJIF9WRvJw8Og6+EA0tZNfnvOoLWRozMONrvW3SQ1PLHMZN7XFK94mDxy?=
 =?us-ascii?Q?9yRuP5Ybbr6Ce3Y4wpuRElEcn6kWOyvTjVRNzTSIA8uXswBcJOu9YZfK6vQZ?=
 =?us-ascii?Q?x00e62/2Z0yCY0hujOPfTnzaI1odNu4hRFK7c1X4akhn1Cs6Rf5SqH46k1pf?=
 =?us-ascii?Q?pV/nph2L47o7gDWzVAqxOh535smTMVLE4G0oyfzITHJ/meVmS/KoVb6wp6nF?=
 =?us-ascii?Q?2BKJPOoWndBYOOgwfQTga9wbVUYogrk5fgXAMjKv+zhPoi2sE1QKQOf0xHwU?=
 =?us-ascii?Q?BXNPkwilN6hL0FgCIUOCVJfBIfbKLEYH4CHOqhqiaVyGgceloMkzQd2zzZ41?=
 =?us-ascii?Q?tD2Qz28XfexXW+q8+zpgzPnsZoHSc4GDwzVJ32zRkZ7yKCnzsDDREXVyKH15?=
 =?us-ascii?Q?vAjfhThKOMJS+yyI8zRvkSpHnWaKz5/NMzzWvlzIierLkntDIRzdBYvRkhCq?=
 =?us-ascii?Q?pI5V2DAZRKhqwkPlB0FZBplKuNqnHh30Clyoo1trHvwCCFQBWHuxiL/2MdWR?=
 =?us-ascii?Q?uulvO+jIUhqy8CdnC0kRmqDNPsT6b4JJ3a/ppRDusso6DKR3x3CDnTj3/l9w?=
 =?us-ascii?Q?eWaIRJ2YyOz9v0+iwcMELJ57SBRS830pLR5QExrLlDVauKww5KCEwKshv1Yr?=
 =?us-ascii?Q?5oSoSieqrhX36AQtrVIQMuyJPXAADR7FxqFVpwbeqZTG+821wy+0XqHhfCna?=
 =?us-ascii?Q?s4mGVJH5WAytqxwTiHhzlslJ48fxl8v+qffzUJRUr6KUoVjKSOL74a1XFIqF?=
 =?us-ascii?Q?9OkvhrsXNOfCJKpsb+UAR+2K2BsxlVthqjPrcoMEvmHbBWuPd0OwY6X+Thex?=
 =?us-ascii?Q?z+TpYwsOdoagshOWwPAE6QbRw/W1FJwepgYNF6J3JmtvxChqTHsrEmw6R6ZO?=
 =?us-ascii?Q?gka25p2JpwQVRcPtjEX7S6WUWCvoQg3jlHUDyVByhBUa2eF3Er9TPZIVBriH?=
 =?us-ascii?Q?sjQBjZOP4EYhj1et+RfNp28z1Dq3dYuwRIcfhldw00rmAWwH25e+09eLHZzo?=
 =?us-ascii?Q?W+K/Wu51lEqOyaAaMogaNptGZONn0UekP1AWollR6Ov03xWMY8BN7uBqEUEU?=
 =?us-ascii?Q?zcm9JQ3FiT6nIh4LKFm+VavUSreax8B8c+KwaMbQkolhj2X1dZAQyOTOJrFH?=
 =?us-ascii?Q?erjeFt/yvblTDE77mJQ/PLGZ2+SJB1xUWmzikiMacv4pVVNfGJFQAHahugov?=
 =?us-ascii?Q?ploen3ZmA3bi5uSJgCWGBCozCIs+8UHT+xUiAHdXP17G6Qdou5KxQVLj5vwI?=
 =?us-ascii?Q?UgoMCTltreUF+sPH/3LNKojaXbd5Tv1UwT7q4FjKecb72DcqeNX5vZIPV4Br?=
 =?us-ascii?Q?B5pugtILJwC8ZYlxD+AEySaAcDIRZ7bJ/FGfXXpMlMw5xz1ut842m03eO4RB?=
 =?us-ascii?Q?LEAGx0OPD/+n/2Sg6vX8aMLkODegJhzMX/r59YkaG6YXCKuYKkeDek36QHY2?=
 =?us-ascii?Q?yNyjNj8H0ww9W13yMlfzN0kP3cxzfDj0NNfrfPbIHTk40MxWe7f237c4gYTH?=
 =?us-ascii?Q?rutRhBVAuvLRm1boUftp6SRUhGOeTDJMHHAw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:51.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd90084-f9fd-4931-2ee6-08dde18eebf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
Received-SPF: permerror client-ip=2a01:111:f403:2418::61b;
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
index 2474f8f25db..5750a112637 100644
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


