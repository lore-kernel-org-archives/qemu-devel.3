Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0A2C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysy-00053i-BE; Wed, 16 Jul 2025 05:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrh-0001Z8-8Z; Wed, 16 Jul 2025 05:55:59 -0400
Received: from mail-co1nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2416::628]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrb-0006bj-Ku; Wed, 16 Jul 2025 05:55:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHMfv9cuPQeILjap6thEgXFawJKdhicuJ6GbWGoyun4PjqWJ1p+q/tYuiVWbUB4rMqQwJqgDBNSjW9HHuhxNHEeu8keQY5F//5Mu/irqYpK/u5P4crwIPzXQZnxXmC32Z7PHfew2SS+9ZCW9Ee1gKj6aeqD+ZXsJPLf1ER6el3b6Bt48DM8LsTx9eY619WadBAvMEBrQqA8tkbXvMye4hzOyFuijKIIa+6Sk4+3E0ym9fvALmoyMbLTpM/eCFOJvQF9c+Ov65JSNzt7LwAryGq3p8AwR0OTUxLGaJLubtph6wIq/rDhwtvB5+qaRgXaWVRIQUaZ2kW2cYE0xr6biYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kM0i/YOq/Skh+SxmbP1CmrnH9QCzl/fHIgTf8oxJTs=;
 b=Xnvx1R/vBgPxPPvah9PkCNpH5BM0h8Oowb44czZzwMrndVWfbIeQUkOVQurBsvjrNBoF93yb0hUP1Q5BdxNnUcfjHEGceXKZDr9IOR1ISlg2y/XHR9lfBjey2dDGLu2SNEUehsOKt/7+Q/5mdSd6jtVoo9E9yKYi1f1WYnImEqawqLcriGRQxmoD50TUb5SiuB0hb73zpyDdt7SR/AsdPQslaXlM6iTEdCuVQusFDo/Q1TvkYSRnC1JXbhlb+FoxbPvrr1ggXQY2PWlOTA4LgjA2fdCAGdUtMU9vz6hKDbL+fO6UpASPmGWJlCqWXOPPmySepJnudYlv8IKTcWEpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kM0i/YOq/Skh+SxmbP1CmrnH9QCzl/fHIgTf8oxJTs=;
 b=oFUJDrUN23M+uxWMI1gNAfiuCD3KFAD8EzFYh7I1ZPbL6G1z0rglfDLpNeNuBwfmmwZBH8hFr3kC0cZ1BHstL8pPBu/Tk3LfNOxSUM+X9EePyC+8R3S6iBYPhGpytYaQw0JaZi/9YrISGJcpszrBFwVIcMcyA8/j5UcSiPxnJ1Q=
Received: from CH3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::32)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:55:36 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::42) by CH3P220CA0012.outlook.office365.com
 (2603:10b6:610:1e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:30 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:28 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 16/48] hw/arm/xlnx-versal: trng: refactor creation
Date: Wed, 16 Jul 2025 11:53:58 +0200
Message-ID: <20250716095432.81923-17-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbe2fb8-08e8-42f7-0d60-08ddc44ee9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LsYWYjMJ739ka9UhOVM22WIg0ggWpJs95dROelwQkvMmLz+hxTvtHpnsjoCy?=
 =?us-ascii?Q?Vb4Xb7e0q/vGrVG3va4c3CVQBBYcc4JLDgw0H4WGEVZdd0Sx8rLGA8anLo+V?=
 =?us-ascii?Q?d5qkjW+6tjl7CNy2BUKXH/sFFnbgkqf3kKfd0YOA3MmOHbsc6Kg7/ZWm3e2P?=
 =?us-ascii?Q?c7h7oh13uJD5utROfIg47g1HoSGBS4mmwf6aXTHZTLYerp9Y3PWEoSBLmYdW?=
 =?us-ascii?Q?q1jIafPulSmQ7xAice6oR+Km0y6MsSJazMpJiou7dlmODw/GbP5Pd6zAJz+6?=
 =?us-ascii?Q?pjEzURq9a5QDT42SZpievMJhXd2kopYCFAyau0rogsMLZiER+GqX6FmJO+CV?=
 =?us-ascii?Q?vb5+dd/XYH1oxADK74ys2VtEw+YuhCqDoowjmFLMYp8E0908fpcRvDUVbIoy?=
 =?us-ascii?Q?eodIGkr0qy+MTDZbcHSSafIGZoAymWozVWs9REA3lUpw239Ou/525B+YM/jJ?=
 =?us-ascii?Q?01uF17EG3Xlo46mPZScNSVuetQou8BsheZBgeZsp9RX2NbrDQ1oEBJ57NOMe?=
 =?us-ascii?Q?xuRTLEWQVAuqQiDaOL/tuhvGXPpWelSbctGx8FK42OpNApBqP0/I+7TBqGGo?=
 =?us-ascii?Q?IGjVfqxrWs6nI5H1fkaW/jUp2Cq57TsYwpDxm2m7T9bQqMJZ79P3bfAk2UeT?=
 =?us-ascii?Q?+iMvF/OcLG7HdxWMJPler3BQxFSmVQmjhhPsE0ZI+B3/lY6aWVCfFEWdJfzb?=
 =?us-ascii?Q?xbkSGKFdSX8AdyLfYcCMWIMd5WCOg2Nujty7uAjr3lUMdvo2wTvTdd0ISOHT?=
 =?us-ascii?Q?TcZyAUe+syKLu4ZGyyQqhApWgoQz/fx28rAajCqm7FHhK+3aSxalwHJbNSP+?=
 =?us-ascii?Q?aInAm/c0z/kkFTyQKD7qCgbtoE5IpPrLE0mjQ71VbvY+VpAX/9kfn5XscRno?=
 =?us-ascii?Q?ssA8pbxWhLHCT/KmWhogL1fnpC4MtdWJBdVfGi5QPxhrK04HijiLfOnlmwSa?=
 =?us-ascii?Q?PZFGifB1KQ8iGZO0+4QjGAc+/pK2+XVhRe2laGfITZ5iaCOx/0GvxrtiBtIJ?=
 =?us-ascii?Q?0wh7CykSPCHoxtYRh/O7a4uhc79UUVAOF4ysUeTOXvOLhGUr2ypqaUoosEVH?=
 =?us-ascii?Q?ILqKu67wXaNAOEERws/cmvHI0WuMhirqTgVthAx0t9T6DiMi50gX19ECFLkn?=
 =?us-ascii?Q?hXxg/+n08sYslHPdVRdm8p05oqjaHO5/eEUvym3JGFMogkBJS3K9cKqOSFvs?=
 =?us-ascii?Q?s5KK1i2uB3zUyKVzufbrnSO6V/aknk/JhUo8c90OiD55XEvAtkXQpfql/Jt9?=
 =?us-ascii?Q?3vbf3PVxWg8MUr2Hys2zhxJYn8GRdBTBpBUsTexvLoYDJCvWJfE08ghrMRcE?=
 =?us-ascii?Q?wTzxSsYOTF8bf8Lwg9ckosEj4CAkbBrlMyeWm9pxo0WwGOYCF8+k9loSGdz6?=
 =?us-ascii?Q?pM06CBiM6F9uCzDmerwM/6J4r8deY8cjptoWjRxYxNsjAkuNVab1Kg1PgrsH?=
 =?us-ascii?Q?h9BNIEfMrNWcXJqZGH30f0V0yKH3fokscW+dAqzjZjDMvLCZbc/lvboz2C85?=
 =?us-ascii?Q?+MYItSgL7tLIguZy7xlgUBJ8F5cvOEcQc+Zm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:36.2563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbe2fb8-08e8-42f7-0d60-08ddc44ee9ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
Received-SPF: permerror client-ip=2a01:111:f403:2416::628;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
index 615eea54372..45d9fc1e282 100644
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
@@ -771,23 +774,22 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
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
@@ -1327,14 +1329,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.50.0


