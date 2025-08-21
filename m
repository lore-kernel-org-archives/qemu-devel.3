Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09639CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yK-0001S2-9w; Thu, 21 Aug 2025 09:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y7-0001NE-Ay; Thu, 21 Aug 2025 09:04:40 -0400
Received: from mail-sn1nam02on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2406::606]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y4-0002uT-CV; Thu, 21 Aug 2025 09:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOhRoCSOAXmcOTNE7J+Buf2fog+mDVWJyUawNtALS5Rn2nIBEmfju1p+6jawaa/RpxmdR0PZnaeShNii0cEruem0MVJ27EEBtj+tEOyMgR82F+dRBAUnUF3KIqE0z2DSR2tweTgy7wRvQjrbhEgvUV/F+EvPRFgN/H8a/QyccJ3G1ZAGJURNUREkk5uITfK7bViVImqIHbT3UT8av17sJPYyNDpCTq1UvTOSlElKuZ5zeFc/SDTgKQzsxh1O5ly6pYAFFYS3MmNSU+hpv4G4QZ2CmCQYX2sORZAfbYzaS2FfshXj/v/FUfO/kGFKjgxIGEq027qfGakuTAm3d8r08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b84o+FxFKc3eZ1DBozz6zdi4WxRi81/bJ2TORzKivA=;
 b=icBeg7C6s3NQ1oBK6nxwypEPvExjSsj5Jvc5cwuWvq2u0SMIrWtKXo+CtdPdYq/gJjNPQBSNkJnjpkmqnSefOje4cy6M5iBdisoJDKiIxoPrhyErsNPBVlPc+zeJL4EC236DXWdY70DIzcxtPd3NgfcYGYcWZ4hr2sYkX5KnkaVo+r1vjEWK8M6SSM9GAdvCVwz9FCfW7snKcedPgJrpqezNKzUQX1fsYS/zQKebSqc1/I1FW7OsNggS0cwYBrcLP1BE3Yiok/tjE/Vaq/UsIiEn+7i2g7WfEjO6qlQSMZv229pdTWAzsfRzxQm7wE0JLkjam8EbQE500TthsXZCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b84o+FxFKc3eZ1DBozz6zdi4WxRi81/bJ2TORzKivA=;
 b=K7BHnnpSvUswIu06EE2QNW3qy/II8Yug4pF83IA7z5CQ4B7I5it7VqnMumusHzm4LoXQUjSL/8gCQRLUkIJaZPhjGLY4WBWpzeOPtYs1GrQw6/euqA+x0Ewj/3pKIeg7QJfVdcLr+aU9oghRPTrfMwQ/SKaGjZAMsJ+rn9CSJvg=
Received: from PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::11)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:30 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::a0) by PH8P221CA0056.outlook.office365.com
 (2603:10b6:510:349::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:17 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:16 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 08/47] hw/arm/xlnx-versal: xram: refactor creation
Date: Thu, 21 Aug 2025 15:03:07 +0200
Message-ID: <20250821130354.125971-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: a9dd441d-8376-4bba-0d4e-08dde0b343ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZP9NnxtXMLnQjvufUVX5dItXsZnBkKKFa+uCGpycNKzrkWk/Aw6MTU02ZKD?=
 =?us-ascii?Q?5P4efHoI2EeYZ1aSxWWoNCYVv7F6c/Rp6+toRL+bM+2jBE18nUf+3xuAJMYM?=
 =?us-ascii?Q?mq+pateBYLYlVQv4ttJt8hnCHXL27Z4LWpeVwktAQzka7pr7u0CcUNhbJ8P/?=
 =?us-ascii?Q?oAFAexJqSdhepDEeIbZf7TllwAI+PM5KyFA/obwRueKTN7Dv//90PPBHnaPE?=
 =?us-ascii?Q?Hpnx3sA+Jt8z9YQdkllE/CqU6tRnwd9PzAyFpxuUggqmY+l8OejlFi7PrZyt?=
 =?us-ascii?Q?SQyHPmYtSWuZFHrfYHWudAvICE+0sREhMMXQnAxwAIjyuZe6XzXilFI3+6GW?=
 =?us-ascii?Q?AqfCzit5odgLp9UXEiedYPH4L757jscEVg0jFhmPfgcTjzMfaubym+8GxkXg?=
 =?us-ascii?Q?wy8eze4ByJC9tSE1BSY93P95/QTBIVMxkbkmDDT3HtW9XE9POQQ5vhpbVd7Z?=
 =?us-ascii?Q?ET89mxmy0UxgAMdPMmNL7vIg5d+Zk5jHdk1zOLoaoavZl5engN8x1qHB19k+?=
 =?us-ascii?Q?esxh4aN2FSnquX7B3bLw1pCHYmRgEfzHOlaULtHbfKf968s9wkIfsP8f3Aaa?=
 =?us-ascii?Q?IhewCptue/ErIHbCRP4+K2s9VeIiAHtlHaPZR36i5AjZ7+q4dxgmxoq/rlQu?=
 =?us-ascii?Q?OClvA6OCt+3SE1tbGyqVsw3Wr+OuZnouKOqOnZNwD+de5FixqlIy5XEI9u/G?=
 =?us-ascii?Q?eu3r8dU4gmnDPDLrTRrTD2Z4T+QPRkcXvRduZOO6CQQedUIvqwE7VqoT0CNS?=
 =?us-ascii?Q?lrqhM+BcsfA7F/rGBXo14zpDfYxV//pe/dhVOZb7IqphiXTDuP0h/KTTYPF9?=
 =?us-ascii?Q?hNLtTFeRpn/O/RP2SGIMzqLkms8PX1PDdJu5TaJDx8a7Fn+Jx+Y4KE6O35pR?=
 =?us-ascii?Q?980cyb9HOiPv66uozbEwnWkXa1OyCbchestyCd/QtecWGf9r5PEBWxdFY23o?=
 =?us-ascii?Q?1cVGN8qHS4dVohFd2z6uFexCBM6rXG+OXmNZRzfKg9nYdVBx+jEi/ceBj9Od?=
 =?us-ascii?Q?1oudTdKZ1SQSfQ7E43N2I/9kGICuHOsJB8dNVQk7p2UL9qaN/WhYNEzmW0+R?=
 =?us-ascii?Q?mUJ+nAef+9kVrMydPibmF0cAFD/P7hTwUhSlVI/+o2MSMpi4ujWtiXGSaq3Y?=
 =?us-ascii?Q?Or6Aft++ZX7PWL8WtkVqBRv1JSmh3adsa0oYW/aHJ6K84h8irwZnOXs3cvGf?=
 =?us-ascii?Q?wdvRzeggSb/9iPvIJUKhjZcw0DfS9Rr0CYd/BO5Sa1jEU6WPRtybc6Dvezeg?=
 =?us-ascii?Q?rFtn+Ir4PhnMfyPgcDUoCA7JwRU5TcJ8vQ5HPU6RSDPkBBtwS7C6qgWsz6Ob?=
 =?us-ascii?Q?rA9/U3ZGZZ1rYvPnOU4ulqVsBguTHgv9shxJFPMluejm+nifBgW734o/LzG5?=
 =?us-ascii?Q?exJbXWguipAyfjLhsYg5u1uJDpMaUunIfwaVogbghlKoSRYqLi66kcai7ETY?=
 =?us-ascii?Q?JzdHk+SPYm7vZg515z96b5yTGhhgqlTkX6YimJ4cYf37KsnHxUppww=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:29.8453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dd441d-8376-4bba-0d4e-08dde0b343ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
Received-SPF: permerror client-ip=2a01:111:f403:2406::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
index 97cd991be10..6c5eb6d3fd5 100644
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
@@ -633,41 +649,35 @@ static void versal_create_trng(Versal *s, qemu_irq *pic)
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
@@ -1186,15 +1196,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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


