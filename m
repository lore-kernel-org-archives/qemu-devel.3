Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E27ACA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cg-0006l1-HA; Fri, 12 Sep 2025 06:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cU-00062H-6O; Fri, 12 Sep 2025 06:03:06 -0400
Received: from mail-mw2nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2412::617]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cN-0001IW-T8; Fri, 12 Sep 2025 06:03:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMtDe7eLcKvE0O7iUIojJ05XfW83mnptOx5PYRG+taBAcT6Uo5tuXJrPuTXu7xrtec81k1SxZsWmIKsxtcj8ddMLZCyPvI2nYhn3PbOF5bWrhT0vZk8Bya9J6aSrkvlZ5ZmrVgKBL4TAE1MLkgQBpU5joJPBHhZ6Y3ZO98HFvIDPNsPes/+Kuop25PFQO7Aaqg0+u92nz8kNSHXYRiY/DS6krPqf2YHE8RiAv2961LVXXdDJQbDSFjhcMdpziJpaKrmW/3QuBGsm0SLJdH5aYMbAl5v+iQdg/IaJI1Y9gTDY/x5SGuRKvByhlBOy7w87gOFObGOVwS9cZB+UmUBJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKGT9RU/umwOU2DhGKD0vY48nQyWPMO7c5Ds6Oou8jQ=;
 b=UmLZmFoqytPb92AwvF4EIeHzFIjGxx0wc6vTwFihyms6ivS+TCaDjj/22FFhVuxKFVlK355tkpolgGSFoAz9lFhZam8byiwOfXLvnVL1Qk8bd6BIWulibtuYs7hDoY1Kf1khHxaj0WEiN0ovu5AmsVGHi//gV4YaI/9yiB3/S5vA7pPqdq3RlTVkzb49N+F5MVLn0J5TrWQOHdMfHaxmxuQ/5y7rh3eNmtKBtkkuPIKvDmKKSsU00+OxXeqNsSG5TS9rPKdTN/Z2BB5K0ucvyJqSYnicGtLqSSuBIL5UQudVvw7zxShzprbggQFHLa8sUsMQQ7l+hqdbhzXvDqe5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKGT9RU/umwOU2DhGKD0vY48nQyWPMO7c5Ds6Oou8jQ=;
 b=fOq3dPhulmMe+7zATNXWxMxiLGa9RsG1R8bjD3jlFT0YGjSOKPveUv1pVRSsHB5I89vvM3grkMD9anu4fVtVqLDBhVhs1qf+TSvvmclgrk8v089N2SEijsnZDmkltjBLp921nkPvtTvVQVC2pQsAxlGwMQIMUeVFeUpanuSxbr0=
Received: from DM6PR14CA0051.namprd14.prod.outlook.com (2603:10b6:5:18f::28)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:53 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::4d) by DM6PR14CA0051.outlook.office365.com
 (2603:10b6:5:18f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:48 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:48 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:46 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 15/47] hw/arm/xlnx-versal: trng: refactor creation
Date: Fri, 12 Sep 2025 12:00:24 +0200
Message-ID: <20250912100059.103997-16-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a3828f-e542-420c-73fb-08ddf1e38a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ilCKrgcHP+IG7HCYHUGdqN+tQ2emKF7uyPnqIh/uxN3XbkslgH1j5o7niab?=
 =?us-ascii?Q?FNPl/rStjJbeni8DirIEkqIpvBiSkpEJDt3P2krunYdHUKZsAzR0waoAFRpV?=
 =?us-ascii?Q?iHHs+/k9yuo2T8WuZisKtw8+Y8mFAChx4fC9EU4b0wIl9sjj920xko5Xi4d2?=
 =?us-ascii?Q?zjfPJCcSj1p0cZI19RBcARt2dxWPbBY+CDAisANqo5ycaMSSGJXEHU7hePko?=
 =?us-ascii?Q?1AUKFSThYcL7AMdsPYeNrq9W2FkVMOTQOho00sg1iIM3elEJ3r/bRH7BpNnm?=
 =?us-ascii?Q?MWFZJeP10fNaxV7TwgW6XEe2rfyc070YzUeGhNve6Vxq+bBg67rFYLW6UYex?=
 =?us-ascii?Q?b3w/EUTuO0qyNswlnqt1XoEjeSm70DkhXOKKpdU0nlUC0Pu+surLL0mbXZBp?=
 =?us-ascii?Q?adXcxp10ZpwZgMpJeCVDiSUQIb/lL/c2IEPcmqrF0BOxoGGSZDMEntd//rDY?=
 =?us-ascii?Q?SMM1ZTO5vDQxvl8L5YspKXiKHQfp8i94NCyO0P561WUuIANlIu9q2Bb2Igsm?=
 =?us-ascii?Q?Z1W4wgrh3O6fn+HcxfZooVltTedfWkf1QTccIltCCeYpXHab7JJpLCpLtBS0?=
 =?us-ascii?Q?TFBFwrddVkAxXwy/NB891UctST4q14cX1+IsLf5joU/FpGwhL8OWzWjjgKlE?=
 =?us-ascii?Q?hs/1bPxFckQW5N3IqlF3qcZuls6+su74TCsfZuKGeZuPRhHlN+jNJVG0COey?=
 =?us-ascii?Q?ZsTvibv1EAHkjHgswcVls75xovdwSmmoV7WWPmR+EzuOzpG0ACsXVjdmC0uO?=
 =?us-ascii?Q?FthnICAzW8etZShz3ovlcpdzlnizndBq05OdjqN+yFTu0FioX6aU0XcBaNP2?=
 =?us-ascii?Q?8Y0Xt0sH6m7OC77X/iSK6sUcV1ckbxCqmgtJ/CVLC/wsj6DmPVaQ2GuWEcDX?=
 =?us-ascii?Q?uHTZpYSdVw/mkh0T61W1RtiWWQ8E8W21R1m0wvQEbdcch7sLnwSqTrvrAncj?=
 =?us-ascii?Q?nAnywYy3VIzj8rlcA9UVErpX6eXjDY3V1bw3vb37nvfMP2hy3auw6K4W94ao?=
 =?us-ascii?Q?PX5uDO1IkgsaeZFP0ChgEmVAjfKjcVjDXmgOD7xOSXIsK1n36QO/VCulCPep?=
 =?us-ascii?Q?evlkfQT7+X9FwUFL1KpXx2lzZx058lzd6QhK/KPTqXX3xHKtHQnaOVyw5ThF?=
 =?us-ascii?Q?qDYgYEJoLKPexiZetek2IL9fTOlNUeN2pdNsIEYk9LkgOTl7pyYMRI0eEaXe?=
 =?us-ascii?Q?kcAmegre5VTJz2rE3cQ0Jat5Yn/l4vMZbGyJNyJejWPULvbrw5k2cLMq5bxE?=
 =?us-ascii?Q?ujo1LwMtRkMi3WwtZALYJr9ubWTlzv9SPFguZYEKSfBgi3Dzgibi+08tQOnG?=
 =?us-ascii?Q?0aGIHzNb915a0BPSYxfDiFM50/88jr8Oe8xTl0AGAZRW5ZMqVMuSuJeHfGlr?=
 =?us-ascii?Q?jvP5Hj1UGYIfo4JvHEwqs2nUJnMtMvvTAEEdPUZOn/I/fcAW56qSi5I+xYGh?=
 =?us-ascii?Q?j8KhoMLf1qzISGKotIbYPtaHg5l4qNFNwr5rpM7ugqz0vPZFDGtIYxd8pTUL?=
 =?us-ascii?Q?SMrHuSMMHNOIPwmFwtidzZKTodlCUn9TwtSz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:53.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a3828f-e542-420c-73fb-08ddf1e38a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050
Received-SPF: permerror client-ip=2a01:111:f403:2412::617;
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
index dcf84f722f4..5054f4146f1 100644
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


