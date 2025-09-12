Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C0DCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cW-00069j-A1; Fri, 12 Sep 2025 06:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cP-0005pp-Lf; Fri, 12 Sep 2025 06:03:01 -0400
Received: from mail-bn7nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cJ-0001GY-Tu; Fri, 12 Sep 2025 06:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8W+8U7iw8+qQ2TU5kF1ivhatK2iUUpIuWtLYX8fJmjdKew4ae63Ndifher59VpMhfrR+KCRz8zj5vEzaBkvC1GsvMkPny9ChJxg6tKStbPYefXFRaUc3eqpf5DQeLMxRXIaRREH0DfX3cqieWxgYY9SLnrlf+0vdfT1B4iHCAT5XFvXM4x/gNwgDWV/bDIm6vF9HU5g1ndpbTHqBnBXC01Us8Fw8Eiwc6+19ZqSvb82lWTCNwKf/nkv5g1JWsLg/8v0SX388rG3odNLKHqzit/9fPjt2N+G7eFTTxs9uKmBo0dFw0jtWuhJN/pEPGl0dYntKpb1+T6wM5EsrhmO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW84d2vSmUk7g7MPt5YZtjb2cj+9z3imf0lDaIKVHxM=;
 b=xjLKPzTfjO7IF6ZEM7p06LmvujxniitI70aE6XS0BO0nLCasaz83UbzaIGS1Ra5nMFxFG1LM4aUEi6lGSgsx3GnuMRO8SDZXnSg021xPkSHxX9bN6Nuk8jgAz66M8gEDDQbKQ1H//d7wTlVCN1Xn5nHpuC8kqRo5gw4IbX3NvVnZoASEB73UB1F6I4c9fJIyacFzwQ5iAN2mIUhia3chGksxcaojh/8jzYpmB2RikiDncxz5vEiRFH0jr/aJ+NeFhNoHUrmlIJSohBnwcLnnm/ATr3+3KhXJ/KDK8Gm2LG8b2/W6EoXq20k/FeDEeHPzF5c52I8K5ZoDGGItyurvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW84d2vSmUk7g7MPt5YZtjb2cj+9z3imf0lDaIKVHxM=;
 b=xizgyCIcGcArnX8DybHaqDWFgC7WTFGhci045xVt6Irh08757elMTavmzL5zhERep/9PQxQj9t6JaBKhO6vb8HuDMuqtnMvss6hBH/LFy6EZLmHbnXmBG93VRlBbgYz3W7psE/Fht+hM/Gqj96aDsmKht/NdF1C13ULRQqatL84=
Received: from DM6PR14CA0063.namprd14.prod.outlook.com (2603:10b6:5:18f::40)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:50 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::4c) by DM6PR14CA0063.outlook.office365.com
 (2603:10b6:5:18f::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:37 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:36 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:34 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 08/47] hw/arm/xlnx-versal: xram: refactor creation
Date: Fri, 12 Sep 2025 12:00:17 +0200
Message-ID: <20250912100059.103997-9-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5156a3-d786-4a46-3650-08ddf1e38822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oxPRZgthY94H3dG2i5c7Jv8Mh5LudLnb+7OZ3v7XN/Skdad/FtYGmMim+puf?=
 =?us-ascii?Q?UdcZB+vNSakxXEH1zUQorgpg/bU1yEJg0sh9dh+0pW4WqHrBQD/R1yuS05uS?=
 =?us-ascii?Q?v8/uFBxZNUawCdAuPymuTCsJResGKd7xDv/6LeHfxbwd8lgJS1SR8s2EOmXq?=
 =?us-ascii?Q?iGsroGI5dpXyeTgUmOJTjPIbAyDhHc+qMiR5pNOE39ud0y7DsMEnSeuKxa9z?=
 =?us-ascii?Q?+5diEsADbdHE90JvLZfQDG4M5TVm3AQJB4+tE/s9gUHEPG4PTysQVoF0iFuy?=
 =?us-ascii?Q?gX8YBkM1yhcH4CSSJoydkbpqG/YX7eNgQ+mS2iP+JqdyJzjtcVPf7NjnrhoU?=
 =?us-ascii?Q?de2csKiUHWkLs1c5CIEjsxDdRgCiGFL1pX6IbJDUTrngXRKXsu1xCX32FCtM?=
 =?us-ascii?Q?wjjfvxRKmL4/lu7EP83XuWuHe91W7kRCsdG6v4VoPNxLooHgCcG/GJYnThvb?=
 =?us-ascii?Q?y+pWOgiKWEZwAYIYdsRcQfL52GZxplj/QSaogeSIgk7WMlOGPgM2DTk5kRwC?=
 =?us-ascii?Q?sghWYz5C75z5q8fdfVgSWOlt8GkDqxCcOnTKoqNUyL2OQss1SpOZoYKun6Xx?=
 =?us-ascii?Q?Ukx4bMg0kOcVfR40y5pkPu+hOTBtHTjWkmiD2TARxriKJ1E0uuOc/Gn1CO22?=
 =?us-ascii?Q?oOFcLy8dVhfHrweUNqx6fCZolH2E92AuQ+qBNObABxo4WiierHKFbM+/a3y3?=
 =?us-ascii?Q?TL6azrapAaKy0NbCFVEtMsKm1memQEyzv6yVr54aVvNlzQeeT5etTkRPi+Rj?=
 =?us-ascii?Q?NZ6bnO4mZmBh9d7fpQHLFAGL3N3bGI7YZIku46yX8vQNc3tWKW91taJYf+Md?=
 =?us-ascii?Q?GIqIp6y3LbWmaAEc0wqGMNq+IcqXo4bwVDBQDQTMDkOlNfLUdUSDim/KFby9?=
 =?us-ascii?Q?zIy5M+AexwEXh8gUqmdcb4+YQm2TW4MDduimeQuGW96YkOSa171t0G+UUTzj?=
 =?us-ascii?Q?qtnGxQh5NIGp0Hb/acawR0vRvEP3aoDtb6nspAA2Ul6y1LPYJ/v/LryUMAv2?=
 =?us-ascii?Q?FbpNM5ojOnEQW34ZLN0376UwQY63gvGEfClhgiLTkMdwQi8I08qlvPtONwnp?=
 =?us-ascii?Q?NXbUC6+dSdSt6G3a/K7FmGyv/9idS0bvn5Qgfj+p82p6CsQdOGzc6SkF3Oqt?=
 =?us-ascii?Q?Qr3CxiHGHCAxeOLS/NUsC7vvYPFlTcbzUrfs/x/VNOOT2Oe2pb3zgLh6mIyz?=
 =?us-ascii?Q?3doKqcxuasvjmF9+fhkPP0wm07hnuMNdYmz4N4Yn/wt+sG0k1dIgSx3n95EW?=
 =?us-ascii?Q?pVTEMBDxsx7Bb+l32Ee/ohYnVxaTUt5/5G/0tn8vwl6qXAsUSytouAtYb6/I?=
 =?us-ascii?Q?V2P1HQrPZw72NmOr9syWWM/6foqFh6CLpemy1n5m7pXv/DdmNiP5VbV70BCE?=
 =?us-ascii?Q?jPNCWziP4nJ0/yWE0KvUN36Jh3timudgv/Obxxfkqr3JTNwjVKAAMpPoP6Am?=
 =?us-ascii?Q?FqvM/TsrJ7s3AhHKAv5ab8e2YYpT1t19Ymm1/PC38AQj4J+B8ikkMXwgz6Eg?=
 =?us-ascii?Q?byBtgut9BNuKEo72eiEnQQ1PViKXRVxetWaK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:49.9495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5156a3-d786-4a46-3650-08ddf1e38822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
Received-SPF: permerror client-ip=2a01:111:f403:2009::61a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Refactor the XRAM devices creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  6 ----
 hw/arm/xlnx-versal.c         | 59 +++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 4eeea98ff34..71c3314b8b4 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -18,11 +18,10 @@
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
-#include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
@@ -86,15 +85,10 @@ struct Versal {
 
             CPUClusterState cluster;
             ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
         } rpu;
 
-        struct {
-            OrIRQState irq_orgate;
-            XlnxXramCtrl ctrl[XLNX_VERSAL_NR_XRAM];
-        } xram;
-
         XlnxVersalCRL crl;
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3ffaa6fc56b..5d647a3ac0b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -29,10 +29,11 @@
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/dma/xlnx-zdma.h"
+#include "hw/misc/xlnx-versal-xramc.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -69,10 +70,18 @@ typedef struct VersalMap {
         uint64_t chan_stride;
         int irq_stride;
     } zdma[2];
     size_t num_zdma;
 
+    struct VersalXramMap {
+        uint64_t mem;
+        uint64_t mem_stride;
+        uint64_t ctrl;
+        uint64_t ctrl_stride;
+        int irq;
+        size_t num;
+    } xram;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -90,10 +99,17 @@ static const VersalMap VERSAL_MAP = {
     .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
     .num_gem = 2,
 
     .zdma[0] = { "adma", { 0xffa80000, 60 }, 8, 0x10000, 1 },
     .num_zdma = 1,
+
+    .xram = {
+        .num = 4,
+        .mem = 0xfe800000, .mem_stride = 1 * MiB,
+        .ctrl = 0xff8e0000, .ctrl_stride = 0x10000,
+        .irq = 79,
+    },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -639,41 +655,35 @@ static void versal_create_trng(Versal *s, qemu_irq *pic)
     mr = sysbus_mmio_get_region(sbd, 0);
     memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
     sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
 }
 
-static void versal_create_xrams(Versal *s, qemu_irq *pic)
+static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
 {
-    int nr_xrams = ARRAY_SIZE(s->lpd.xram.ctrl);
-    DeviceState *orgate;
-    int i;
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+    DeviceState *or;
+    size_t i;
 
-    /* XRAM IRQs get ORed into a single line.  */
-    object_initialize_child(OBJECT(s), "xram-irq-orgate",
-                            &s->lpd.xram.irq_orgate, TYPE_OR_IRQ);
-    orgate = DEVICE(&s->lpd.xram.irq_orgate);
-    object_property_set_int(OBJECT(orgate),
-                            "num-lines", nr_xrams, &error_fatal);
-    qdev_realize(orgate, NULL, &error_fatal);
-    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_XRAM_IRQ_0]);
+    or = create_or_gate(s, OBJECT(s), "xram-orgate", map->num, map->irq);
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.xram.ctrl); i++) {
-        SysBusDevice *sbd;
-        MemoryRegion *mr;
+    for (i = 0; i < map->num; i++) {
+        hwaddr ctrl, mem;
 
-        object_initialize_child(OBJECT(s), "xram[*]", &s->lpd.xram.ctrl[i],
-                                TYPE_XLNX_XRAM_CTRL);
-        sbd = SYS_BUS_DEVICE(&s->lpd.xram.ctrl[i]);
-        sysbus_realize(sbd, &error_fatal);
+        sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_XRAM_CTRL));
+        object_property_add_child(OBJECT(s), "xram[*]", OBJECT(sbd));
+        sysbus_realize_and_unref(sbd, &error_fatal);
+
+        ctrl = map->ctrl + map->ctrl_stride * i;
+        mem = map->mem + map->mem_stride * i;
 
         mr = sysbus_mmio_get_region(sbd, 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_XRAMC + i * MM_XRAMC_SIZE, mr);
+        memory_region_add_subregion(&s->mr_ps, ctrl, mr);
         mr = sysbus_mmio_get_region(sbd, 1);
-        memory_region_add_subregion(&s->mr_ps, MM_XRAM + i * MiB, mr);
+        memory_region_add_subregion(&s->mr_ps, mem, mr);
 
-        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(orgate, i));
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(or, i));
     }
 }
 
 static void versal_create_bbram(Versal *s, qemu_irq *pic)
 {
@@ -1198,15 +1208,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_zdma; i++) {
         versal_create_zdma(s, &map->zdma[i]);
     }
 
+    versal_create_xrams(s, &map->xram);
+
     versal_create_usbs(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
-    versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
     versal_create_efuse(s, pic);
     versal_create_pmc_iou_slcr(s, pic);
     versal_create_ospi(s, pic);
     versal_create_crl(s, pic);
-- 
2.50.1


