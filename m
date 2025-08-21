Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2D3CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yS-0001aX-0e; Thu, 21 Aug 2025 09:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yJ-0001S3-JS; Thu, 21 Aug 2025 09:04:51 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yD-0002wQ-9G; Thu, 21 Aug 2025 09:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgRw3MuE+duZg4KKTOMnd2dijw5FG/3eExFHfoSeWQ+03T/fQlwp3ctRgDCu3GYUE4zp9PYZQ8KzkNVQGuKO52ScfzxE0Yq4gz7Jhi2cUr2avvKa3qKAznzfTTwRiFJNmKuzhq8J7Y/8S1pNCuv5VDRphN5L1vkxg7wtFfjV9d8PuLIXaf4bqcRlvzHDOF0aBSUcp/pOiFEO11ob6RX1XpEwNdjt08N3N24U1QXw0JsMEctfkLgqu1EOzknyCR6cHQpEd0EY4+3s/XVqE7ZOCAvTRAeSgFISKsw3AVrAq7jI6dMJLsQbSppY3gYdZU0+Hgid185PP8l5H7P2ltAZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Opy+iE3DFMz3s4Zy4hQcch3vh1mO0LEdE11LBDjAMo=;
 b=H0epOO17VGlDkqNzZavG3pQ0YW5XWELCK7C/dKKe6zqrLPpi4WyjjDNi8eS0IlwsthEVfqkhyd/pYccz+SGkvJJJUrgni6tQKwBDS+fbxl+Lkkjc0+jfmV9JftpNNdgtIea+d5AGjSOp5D1m5FmjyoXNqv1pTpVt6cgDiPZJ6C4ybBrpIsvbPhn6ddfziGwurN0KGCNZNgvcbeLT2+IsGz11QelmrQI6iSXIe/D7PavdP2K37OIOfx0UnTj8wNBYiv3nOFpOLrvDgAVepBzwTlJUM2hoQtrm/1pyDC4I7L3uDMntUzCDhjQ0XoI3/TW/IyaxinwhJrELufCrL8yPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Opy+iE3DFMz3s4Zy4hQcch3vh1mO0LEdE11LBDjAMo=;
 b=PN3SsB+PUmIXY9uJEKlS7wXTnTKdZIr+M78/b1xdBvUX/fsGci3MEjIjeKBENUVckdKwYUbX6IilUpDxDDOnXyBHi8AFntn20A5/6kSM3DWspa68zAirwUnNI24yrzWIAwjfLqki4D+Kg5TXkSph+ybQmte4r88uW1kLbbL9sSU=
Received: from PH7P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::33)
 by CH1PPF989868826.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 13:04:34 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::88) by PH7P221CA0003.outlook.office365.com
 (2603:10b6:510:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:30 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:29 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 15/47] hw/arm/xlnx-versal: trng: refactor creation
Date: Thu, 21 Aug 2025 15:03:14 +0200
Message-ID: <20250821130354.125971-16-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bdc8ae-30b0-49a6-71a5-08dde0b34696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxcKTn4yrKDn2n0TbCdXB8Frp+pVfvdbNWrhMKTPNzJbkFJ27Ibr/CA/KWet?=
 =?us-ascii?Q?JVaVfBXUEXNEHsfG27f9bVAv7fanyheFCKycF9P/oii/+q9Vt0N/fVpAivNN?=
 =?us-ascii?Q?omuj+6+5WQoh3fdBhDf5RZPxYHN/vbAJrvF6qhWGiEa78G3lJgukGT2gLCPL?=
 =?us-ascii?Q?OyLMS5AZgtgm7c5fiKaAa8evsSiyYzpVdBfW0W7tmkwlpBRoH9MiNsQDlYu/?=
 =?us-ascii?Q?uDB6ZLVnzot0eAIUNm1v61DGumpseX+uS4nCX6eJf3Xub9Ro4lXVzaQHq43h?=
 =?us-ascii?Q?FZ8t00hPrJimhHZvlETlXd4CznbyVym6WXWdrv2hxP3GuN9vqeSYxdaQRlC1?=
 =?us-ascii?Q?CBIv3Hb3sDtkr3IyLQIx2j51SrWfjMa21ASjlTTsrqsA8N8r7nWn0T+xFTUX?=
 =?us-ascii?Q?1xgRUBZEcDLgusq3qPpcg+zLwzj+wDIuwkxRoUzACoQdfpO5KK2tDgJdDkdr?=
 =?us-ascii?Q?Sqk/2dLxUDFS6dN8J5aDn81+6mZhbvXHGIcn4yGUm+vV45lOidN70OnMgehJ?=
 =?us-ascii?Q?4fZeTQSnmsR7W3RKGlQDbWjW31B16pfgc9GEa0TS49Pu/K59Wdbw/vY9N4J4?=
 =?us-ascii?Q?kVlAThRV1gVyBGA4owjKTt2sW+KvTgj2sloUc8mwkLFd8VSDT4TTMw5TFU+7?=
 =?us-ascii?Q?bUtVlkbXPAjvQS9iXwjFywZeS81+e8GxQq+/wRM4axl8JxdMAbUGp3QaLUFK?=
 =?us-ascii?Q?wsnKU6ze1SieTIu/kYMF+x0Rx/UHhStkkKrXuwOIAkzNJs9dkDCZTv61iWZb?=
 =?us-ascii?Q?bjVglpFAQF1KdwyYhpCWnw21c2wFyv6HePwF0PXGJSSKOKt7Fbd9q9yulGrO?=
 =?us-ascii?Q?Can7+fRaVoRmDXBps/hbR/1ACg4TULIvrVxjIbyqUHP/TDYf+EpgiI/HXCMA?=
 =?us-ascii?Q?2Dk4R8pvw6TGsD05yZhri9xNcFYHOyImi6lc3ezJliJS2fjFisVRM3Y+rIXK?=
 =?us-ascii?Q?3h+Zwcx/2jPbPev8kbVB2b2RhQ0DsRVyYk5DT/JKUQZTzsnYLdzIPc8LfiGY?=
 =?us-ascii?Q?YRhrp6ltPnWrMSmX6rZU/QNX4J9++ww2Rc1iAJHM62oCI7Pf2ThcYawoC7YG?=
 =?us-ascii?Q?xzwfKoIos51eOPh6691I33WGUP5RL2NPguzDBMCKN8F1+eQpNEMOQFm1zZ/g?=
 =?us-ascii?Q?fIWiHCagaet9THrfoCw88YF30lLkCq4r0K+FlUIXxz/T9k/+gc5RylzX1TA5?=
 =?us-ascii?Q?2fR/cA2cbHE409uyU1zUy0zk0iSRgU7NdxSOrjhxqZfoTHKmbbTp7j2R1ow5?=
 =?us-ascii?Q?XHDmBk/Kec1IqNlklR3APvBsmFsq0Jf1dc3RzFXbR6BWNqSmV79jAKFRLkem?=
 =?us-ascii?Q?1166RElAutdg/DlJLhK1jURCJ5iZZkrB2T8DUIAO9DfON/ADVsrd8RDOlYm6?=
 =?us-ascii?Q?SB1U9w6secAiGByO6GpRuT25rlL8R1e0WsURiclyV88hO7G00nwVQBDXy+sS?=
 =?us-ascii?Q?o1aYiTSsrqBAWRsT1zuU+pYUNt7P2mwMMHhSdHHXEC4089Ds/yx+Ov02ANSw?=
 =?us-ascii?Q?+GzKfuQX7Wp0+9Gk6cfljgSd88etPCifUVzF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:34.3171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bdc8ae-30b0-49a6-71a5-08dde0b34696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
Received-SPF: permerror client-ip=2a01:111:f403:200a::60b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
2.50.1


