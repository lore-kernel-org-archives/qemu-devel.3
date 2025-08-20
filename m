Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABBACA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9j-0004P2-Cg; Wed, 20 Aug 2025 04:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9h-0004Nr-MB; Wed, 20 Aug 2025 04:26:49 -0400
Received: from mail-bn8nam12on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9f-0000wx-GG; Wed, 20 Aug 2025 04:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMVO2ZgNRzJL6eIlaDZBJBLT299SluScL6LWmvMmiuJbkd2kHV4aeFZ/Hk4sKXszEktO+4YkMOJUmwYoGfzRep3rVF4KMoW4DWQjaiW++dwpzqpTANfnhlM2czBegLNlwwgsihOr7MlyCC5sLdmpeIROPiNZWZ/b2Pq/6Rxj0qMNmJvYTaVl/Ba3x10icxUfdcwll8uWB2JzogDwWoFVXkGkW13yyQs3iW/y17oEujSFZzjz5gKwtvd/dmvOqJTGJzt2LxFpDGFE9EcKTxr+LKItA86Ly/hLSi7t/zxgkMWihtzXyWdOrJUoaVWlfRb8N41I9z5cc/1BhqIcxUFvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Opy+iE3DFMz3s4Zy4hQcch3vh1mO0LEdE11LBDjAMo=;
 b=ROv6bwaOdNod5IRSWYBXuH5eLAgM24EwEcDdyeabUwdas47DESf7z79sKNQJaW38qyD0LNu0d1M6/SIeOOOqRoQzIJ8J5YUpmGArnU6tI/bw1pxc898qtR12uRoRjf0vsie+qIDSWOKGDB2AM0+LV9PZTg7QMJqSO6o8k7QGswz+ODw/z4YiiH8Ee5LYYxNIVtSGACKZd4odEMDB1qXB6rPtuDoDQEnMPaXs2YAUM3vnvvgjZakBos/ZRpRJLX5rZJKiLyVn/+AxVwqqKciDe1zt6GjRrMl0QJtGQjYC8XSkiNih252ha836x7tkvExB7130h/9cbTbdD+42mnBurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Opy+iE3DFMz3s4Zy4hQcch3vh1mO0LEdE11LBDjAMo=;
 b=XC3XKNKXuSh4eXi10BgHsXlZMWGd882dEMRjawkPmR5AI/GgJAC7cdQBnat+mWa4JUZjJ7TLw1RDwLjzEvmlcNzPVPNibqaVuRQ4x71KO3KmI/lvB3UeeaXE/RZbD+XCGi/sGQTuDWMg2HmCU1KGR7kZC0usQfIHI/75SSztcbk=
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 08:26:40 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::58) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:37 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:36 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 15/47] hw/arm/xlnx-versal: trng: refactor creation
Date: Wed, 20 Aug 2025 10:25:14 +0200
Message-ID: <20250820082549.69724-16-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: a79c35ab-c739-4f49-9d59-08dddfc34937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ymwUOoWQWc1Z1mED3zsK7NuWVjs8UKDkjl+gfkcnP8/NHLeN0KwnZ7MUdsmx?=
 =?us-ascii?Q?YePy8wjT2R5t5z3bq+erGXSL2ePa/usvPt++e82HQdC7LZkJdeZ5YJ/zgEP+?=
 =?us-ascii?Q?phV0r9dE9+Hw+V1BlGXHDvLnktMZkFVTqxBhANNbT1vYq14C1UGJM7TuspuM?=
 =?us-ascii?Q?yNvb99FfNOwpCv+IANipiPZoJMajlkLMDttcJ9UjxK/Q1VmqRNvk3jYJVEtF?=
 =?us-ascii?Q?Bk1ROoJLfuyRd+Ji1N8dyr9EckXKNRYTO6G8q5M+bc/8YJVTmeu/t/mXV7w9?=
 =?us-ascii?Q?Dreszi97YcZ3kvwAkNSo4km16Lw+rYRjCLOnhQ0poFCQErr6WG/3XoPewQdJ?=
 =?us-ascii?Q?+/VANbXfSmyObURiM9DLh9qWeYZK4cc8BaVGcFoNF9zZX5KhWnRFfhBFgv+s?=
 =?us-ascii?Q?k5h+u3kBqi58yecq2eHL3197lu2ej17vKCsnhqWir2mvFbiLouOJIv7/EIe3?=
 =?us-ascii?Q?x3qkX1IYAramhoId5J44bowB8Q8vg4GSpMLsCRTEfXPP65PQ3Xu7xeV7foSs?=
 =?us-ascii?Q?25tWw7SH5zcyDXjD2RTxuBGrm4OZURBzdCbfQnT38Kgdzq3beczf7CR6k5/5?=
 =?us-ascii?Q?sKRtHSplPxRTSWbSzIxVpt4bQCWoKg4X4X5WzyTzx5XNWrkSdLLr3/P+kfn8?=
 =?us-ascii?Q?nZ7IGn/mgI6CfoEnOCkDTvgQmBe9gZdOPVPjdomR/YlIclKrg55Wy8ytY2zL?=
 =?us-ascii?Q?ieVlsOsbW69occ+Q5/eYecvJKYM4fvXgrhguxj1VFyvFgvkxNXGyj3Myq7QQ?=
 =?us-ascii?Q?hTgbcDAhn/2zF0dOQPi9PQWl+GXT14JqFSQffpYmEQjHH3K3e3GEiCKqdot0?=
 =?us-ascii?Q?MNs9ncEujAnbhSSi1/BhF6ARtUgfbypdmudso/sMlhdNcytBxLj214pgOnE5?=
 =?us-ascii?Q?lZHpAIy0IwGtAPSebALYXT84Vk2BtCBQ2EyNlDPtFebdy5QXoea9YwOWx/8b?=
 =?us-ascii?Q?1Zdsajl693MRFK9OHp6T9BclCkzu/Tlx4kJWXfgqC23AzGFvaNzPdvqv4yFk?=
 =?us-ascii?Q?e/OXS/RbzteeMDzGqy6Ie7RmG/CsZZj7AkJVRGETGB8tEfBw7OPBRHBTpIks?=
 =?us-ascii?Q?4EN3XpOwWrG7aiBXD6tZ7UbecJIX8bX/tehNmtmvirfjcTPy+x/bZ3thZ9L4?=
 =?us-ascii?Q?PdxGfIsbZO2AlJUYBqA4NJN6daU2/whBRj+e8k7q81M3XxeAPZByEeIuM9n5?=
 =?us-ascii?Q?krTqoZTygczTq+Oo7Il2ZZ0dXOswa+sF5/QqNNTByTi1tveyyhhIpKEu3lRa?=
 =?us-ascii?Q?gaJDXzY2H1hKpu7Bz+N0d1nX4Z837VcV3WJYK07g3aWlsPD3Ot+dU64OjtdC?=
 =?us-ascii?Q?0yS+7mQjxMexGTy2g4SbG3+Jqcd01A4f8Oi//00zkZDG4sPpDS9CdDfeUK6f?=
 =?us-ascii?Q?js7C8Up/nwHUOXQ8lAtbZLcgPIit2qbKMqurolOlnh2d4R6eGpRpBA3MIyLv?=
 =?us-ascii?Q?nrEZISnyYlVhU1THdZ0hvv25+I3mUY8sbG+qo9DnybC04AlJvvERq1QtGnY9?=
 =?us-ascii?Q?IGDM+8+kzIMID/khpPBgddQ8+iRfV38JVLSo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:39.5149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79c35ab-c739-4f49-9d59-08dddfc34937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
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


