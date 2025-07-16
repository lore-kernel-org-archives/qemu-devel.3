Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CB8C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysa-0002ul-6G; Wed, 16 Jul 2025 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrR-0001J5-IG; Wed, 16 Jul 2025 05:55:39 -0400
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2009::622]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrO-0006aB-3D; Wed, 16 Jul 2025 05:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO5waGlz+3Df0smkcTDw0oGp9gElXkf/qleof+25gsx0OHx/RoL4zZjJjgQVrr8rLYoIHZ3iV5HcPlTvzEzUGQkahycBuUrMF3YhkkFBtdwYKPmiMRKjQerlbvb7re2OsW5sAH0d1K37jDB77HOb7l3Y8pLvawdWe9lhjytwnhun1fcJffyJaSKN1FoeQl9CIA/gspTUxsoS7+LSVNg7GBa+Y7Wsz8ebzqWiGhRpjoBWl6pWT04e6mn2J3NXZu3HIYCoYPuREnVFj2Wku7dv9OEHoCh3eEby+TWzKyRwHYLsda2KfV50utwzObFPXAj8l+yiciujXh//OgmvcrP8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMA1ZHJ6jhucjmGMAx4O9kMA3VL/yiPyYVfUAlzMUtE=;
 b=vFvAsRY6EmHtjfsUevQoAAxCq8DDiPk/Pio4uLvjM7KM82mNrKw8ffPwxRPoe/geyrSk/UeqWiO5/fQ9SobYjSraIJmBTl/NL107Qj+LDgxH+JuV517Ek+rNGOpyxqShJdp/7GD2kbSgAztBWiEJwQb3CxiyXrMJ1ZkB1gBqvqqh7zJKwJNq+l68fNEsvqUf4plZBUWjNSoZBd67Wc8Ey/tP3jyS/Pp2TGMShMyGe1LkYBwhDd8kI+XqFKQ3vArFH+WztRR9Mp5+iVKgpYVXXutkEWAJ8A6z961WQhNYauHAgoqvF+5uHtUktIwyzW7HGSrEfRb5+upLgClLeMH6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMA1ZHJ6jhucjmGMAx4O9kMA3VL/yiPyYVfUAlzMUtE=;
 b=vCKhdArCWYCPlRHKjOknjWF+LvNi/2Xd2Rt9oK1Q/7CWhsfg3RjH/c4vAziqY9SqTIAQo6VnIWQJNsiBPO3eOEQiUgUn0FM65m0GEdB0777WG+SIH00j68lY9n/iYhfg802jNdck100lEanPaBcVyH1fGXZ7ZeYMaafJB+0s8dg=
Received: from SJ0PR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:332::8)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 09:55:29 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a1) by SJ0PR05CA0063.outlook.office365.com
 (2603:10b6:a03:332::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Wed,
 16 Jul 2025 09:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:15 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:14 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 09/48] hw/arm/xlnx-versal: xram: refactor creation
Date: Wed, 16 Jul 2025 11:53:51 +0200
Message-ID: <20250716095432.81923-10-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 383389b0-d536-4727-de97-08ddc44ee4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B3hhNJDhSJ2hNe7Ykn8Ewktp+KJpbIVOkykEt3PRHob64bw0m9IHDK4kP/CF?=
 =?us-ascii?Q?wSOrnOGAHnqAZjLsvpC1l2Av9O2eh6lm4uYxC4l5VUAMzrQwjPdfNGZGKiZ8?=
 =?us-ascii?Q?cuFq9usLxtosRw8MohGhU4cbMIl0jWIcB6HLp32eweVxZryuWPtDldDWDEdR?=
 =?us-ascii?Q?PcbzlsrD4s2PwihBMjo6WWm/rhFtZIoN2bDplUbedTEiSjB1Da23jWNGZjvk?=
 =?us-ascii?Q?hQyP+/YbxLBvNaqmZFku3NECTleTh8jwYzZT00pnwN3oFzHE8ZucieeeixDI?=
 =?us-ascii?Q?LM/RO1fhYpEZzJWxpyjSwg5INKmua3ph1AlaxPOzlF4Ak1+Z5cYdFa3qdcUF?=
 =?us-ascii?Q?Xx6RX80tSpQnAAeJ1cYXkjGSYsDqbJsl/IY42gIDI9EjRjvk2HcA4kXikNoo?=
 =?us-ascii?Q?DLEBADKiVKR6T60LdySIsniJsaW6u2ZC4UdYsA1LMYlKF+uJ+kgu19Bk/ey8?=
 =?us-ascii?Q?CONDj2XCTBSPdPKkNy+ZoGj7IgwjB0TnafeIcx+5oRr8lUx8sAOAAFHpsCas?=
 =?us-ascii?Q?4tovThk2pnanWVhRcyqFXVWllpkanoeazizeDjLvjIvNkCjmwoKgYLQKP0S1?=
 =?us-ascii?Q?Ni+Zx9bdZve03smJF74PZqJZ8YE5luWpaxhXWU7l0XEiKJo66Ci2aVEzDEQ2?=
 =?us-ascii?Q?ExIZyU1Li7LJbjibrsY4RdARR1v4D9rTbcxMpSp6lsFk7lashaGv0LV7OkoU?=
 =?us-ascii?Q?sSdfuOKEkF1BZF8xCV1Ax03925gMswB+/ldV7kPcQaqTK4jq6W5iiaIk1iIn?=
 =?us-ascii?Q?psSykE1wvNnYHcSkziZRKejVIR5V0nboAqQ96czRKhFz1SDix+HtGdK2k26B?=
 =?us-ascii?Q?f/O2T2TgAyin3URWK3JPzlnA60mSkkwm1EgW/9fW6WR+NGAfQLNeOsSQP8Bv?=
 =?us-ascii?Q?1xqwxpxOGuFL08Om4d+fZeHf1DU/22xxVJX+5PnO2CGSHdHY8kCBZSmxCLAh?=
 =?us-ascii?Q?y6h9azV1wz6TJLXu3IPvJqahoBKEgzHoHXae21GaBTU8mys9WefhoxvtrKE6?=
 =?us-ascii?Q?/LpW8pOdI+jWmQSIKbXtzEYuP4W9yNaJQLjM7gZXnBkmDBVR73KZXNCNCwPJ?=
 =?us-ascii?Q?VDUexCso6z+qsSiAKwvogQ9NmW9LxrfG4+TQTGL/xQAvbbL6S4QlvYHG6BCP?=
 =?us-ascii?Q?00AYlkuHua9l5HJfK6MN8T0/TbWBefhiMBgfz3wGPbV/8qS1uiFv61LjibGW?=
 =?us-ascii?Q?p1cn+2mCrjKp+lkL57FFH/11Cobbr5LJr7bZ8tCy18nFtsjlkLc2JogsHgjk?=
 =?us-ascii?Q?KlAS0iPo0w0DK1DUHiHvQCii+3cyzeHA9EybF/9DzVSGnC0l32PnKSJfeFMD?=
 =?us-ascii?Q?fjkpXvwNYqECXj45ujRXP5cW0pmSDbXT8H+CrH3fdAZEDkvRX7R8Dt7kdlvh?=
 =?us-ascii?Q?Cx8eSnVbvs8/1ndaayhV2AfkgpLOeNqbWq4hmk6sf2F6v+CE8cX8XZskepS+?=
 =?us-ascii?Q?zl2t6BQlDNpt0Mvq6BeZMbuu7oUt+xQagXMB+da3foUGo1/81QY28BAzFd4w?=
 =?us-ascii?Q?4HtP8oxqbtSVHjO2B+T5XS2PZL2ZU9ocaF6T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:27.9544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383389b0-d536-4727-de97-08ddc44ee4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
Received-SPF: permerror client-ip=2a01:111:f403:2009::622;
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
2.50.0


