Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79E7CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22Zt-0006Gj-HB; Fri, 26 Sep 2025 03:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zm-0006Eo-6j; Fri, 26 Sep 2025 03:09:07 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZW-0006YX-SZ; Fri, 26 Sep 2025 03:09:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUUED2nla6tD5aYn0VXexEPIKGI9VYnkb9sP6MEussxlzWRiH7vpLky8ZBDvBMFKncsIE5uZ32OZcv47uO7EsD+oYTHQigB2TPTJzkoVkVJokYkqjjEUMUecTCcHAaBiZkOWYX/NsZ1K1QTCItGaA8lPSTk7Q6SyJT9gtOT9ovQH4ZKaOqQwnRYt2QYRIdDLyhy6EiFulcpec70iRgMTtf6zaBTSjr+tQeKAJo8vqTEIfFJpD04xTO1bOvKjiKhPZ71JsjeZnT9RHdJHUpvoeJIhqZkE2c9/F7QgWklc4bWQPJgTVrcPhLFbHxTKvgbxR8JPY8CaMKC/oCBlZU606g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1No14uufmwwp5G9V0a8LeBj83CWRkmx5IinZPAqDAU4=;
 b=eEIOGxF261k4KL377YtoBfzlh8KwF5RYViX+42pbfhUA+omfjQentCMtsHNu0okksuR4n6ivn4IosgQulHM7iipVfJH3bab8UuCgpPdTN0+ss2f0ho3+X9D6gSAEfJPQVESf4veBqST0DCxYCtG0n587+64Ev8xmAESRBTwdgtNZAyp38jzmUFtHcZYhb4QMH61BFOP9hp1bCw8FTtodOr//vYsk9UEGXJlEVX1PExNLEnFx4NJXvz/Zj8ks48HFy19iZVAR6xCaxVcw5GUj8PUuErQp39qJTUWPZ2fm75ZboP292rxay0BC6nPYLEanAcJ9rryPtoZZATkObMpaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1No14uufmwwp5G9V0a8LeBj83CWRkmx5IinZPAqDAU4=;
 b=qoyhDA3DQcEpByx05Oa1jBrmC/AC9Ftq+3jLKs1RvB8547HvQypED9qpE8Kxvo8cFg3ch3WbbWDL8hY6MSrSdfT+2hRuug+4FWfW0v8iWn2tjK885VevqLVKB8Xnxq12XAnFzwBLoAAb+r9cwSgXZGr0CBwrQPVguKhG46NokeU=
Received: from DS7PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:2a::27) by
 DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 07:08:39 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::57) by DS7PR06CA0003.outlook.office365.com
 (2603:10b6:8:2a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:27 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:27 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:26 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 08/47] hw/arm/xlnx-versal: xram: refactor creation
Date: Fri, 26 Sep 2025 09:07:26 +0200
Message-ID: <20250926070806.292065-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f87592d-f4c1-410b-463b-08ddfccb849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y/979NTQTvAOgdC61RddVGXwHIBNVEgD6cPixMf05issIaUgUmOWtTeVyF/4?=
 =?us-ascii?Q?JyyaZ2PCREwPBh3qCs4zi/bwmptWAfchKX2C1W5NsNjxI82fNtwYZ6X1Xku2?=
 =?us-ascii?Q?fY4AurHljfNyiNClcJO9S5hpKxrAtGucZY0sMDhIWGvLJSSTpSlVBcCrWrKN?=
 =?us-ascii?Q?HSokdxw5Mdrfy5xrSwIq5XKI8LbPZkX63TR4yUBv+zgMTDthasc27oIA3qI0?=
 =?us-ascii?Q?HZH+BpWoFFlrUblJhT9LeyeCkuazL4S1vK1eXBqFu1GabEUV6erYQQryvVPs?=
 =?us-ascii?Q?nOd3EeaMSHngt900jINizElHXoLvdK+CVO3AyWyW+bjN84ierQoUgdajUdNo?=
 =?us-ascii?Q?NG0ZcQ8tmah8B+lQY2dQovkrH1JnfSDpRvfjCOWks7XtepvW+/ufPpQcp7Cp?=
 =?us-ascii?Q?UuEu5eluUCTRhWaEw7DvZ08S9E+0u4CRtVdl2yxgAuLEOhuwZv0sk17WOotu?=
 =?us-ascii?Q?lSaAtJwpZRvu2Oew4UwFB/c1uoWGVXUVMAlrGLjm4rS5HeWt4US4Y2iJ1iGi?=
 =?us-ascii?Q?1SeFKaXk3ZO/q5gAiDzsjejHEObLoyZerRCBTzkuEMTERlv9qgAQD1wWHht9?=
 =?us-ascii?Q?dXzFuAYq5C1qfjmOHUbFPH6EHjL7i03G8QBBepKL/IpMuajz7Aw+wayBoC/8?=
 =?us-ascii?Q?1PD+9Fa1bxku7/aYIDj4LbpnQCLWKGcxPmlwByGgM6487KBIEiDhkKJ0msaJ?=
 =?us-ascii?Q?WYvIRwMZ0vuT3KyP9Epw9JH6nZ23jSf6VMzAz3T6eWMLQPLePuD/VTHoB/vD?=
 =?us-ascii?Q?mrQi5WHJk1PSZfgU2nZjuJzSr9X/Y1sfYNFM6PcVUTxUfUifT006KZw2kVwz?=
 =?us-ascii?Q?zbwycp4J4fZ+YevqaDCzVLbF4rhls04lLuz6etKWnbrf2SBTq/wYTR8Kix47?=
 =?us-ascii?Q?AnJCM33RU3NNDx8uDrwxEISx3cVMkCosIusdGuqALqadszN//wRjNIcXT8Io?=
 =?us-ascii?Q?3WaYvppsk1CEi9GmD3lrniduqN0jN4t4LKa6KAdaOBKIIx/HCVCYxxBb6OCw?=
 =?us-ascii?Q?Q80UhIkVCihWXdmddwdByG6Bcp/YllnDN7njTuMmp6GNG4CUcrVnGaXs40lc?=
 =?us-ascii?Q?27pwmbic6nldDPnJ3PA6vjAzJlIMNclX5Eayy+hw5hfHXKZ0h87RRYfKj07f?=
 =?us-ascii?Q?PpgX40StfOEIpglNwry2Oy3N/nM//4HOLstcTJbhswIjD6yAJO/LOy8nwm5M?=
 =?us-ascii?Q?IZWUYHa3SMtuPZVOHd3NbQ65IlIFADFWKpCk/qOVWeKjUuas5Y0WRbfQ0yE1?=
 =?us-ascii?Q?GtHXoeLxVd+PP7s7enOrOx41ttkab1RpXnUBMQgBFqPFYItTTSGuYP0WIDcW?=
 =?us-ascii?Q?6uWXuUGR/gNlSylKzYRjGxGpi9hAB0cc37p73raPTbB1KMbM0MfzDsYQwEv5?=
 =?us-ascii?Q?h6VJb95/+QqPPsW7RoJm48un+pCkdcYcbbpiwHMZgG80lcFOZldLd/KwZTvZ?=
 =?us-ascii?Q?BcNsJZ1LimTqZIY1DfJW1EXN4FBO1uSfEfUwlHNO3tDMsln7A2Xa1pUQLP55?=
 =?us-ascii?Q?8tbCdsJuzuWyXU6cIBl9Az9CxFw6DRN1ouWz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:38.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f87592d-f4c1-410b-463b-08ddfccb849c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 5c2bd4be1f7..295fca3d60d 100644
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
@@ -1194,15 +1204,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
2.51.0


