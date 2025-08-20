Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26B6CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9W-0004Dc-Sp; Wed, 20 Aug 2025 04:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9V-0004CK-0w; Wed, 20 Aug 2025 04:26:37 -0400
Received: from mail-mw2nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2412::623]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9S-0000sM-9T; Wed, 20 Aug 2025 04:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkpceEPRslqZ0294cdacO+/WSS4/Mh1YVfYk3JmbJBebltH7W2+tbBSL81cgUBTc3bdRV2E8fHGcMv/jSl1Y18JwhKUiRNI0wyfczcNHx4Gm2PS1lZ1kXo77pdpWbSY0qDtzyEv9vbjbQe4uNLuWkirsBQv2KFTVpD2908TfCy1VXTJA6C2Mu0h662eM3Vq5q4Jh2k9Z1OI4rnHtWJtuQR6wjUX5S6gQyfy6iMxniLDGMa+ssSpbyNPnqzwTx0ZLAWI20v7dQL4L+gpPAsziOqcI1K6H3hWq+MRMvs/IgVm3vwNDtKBd1jSgPRAnPB8vpbgVwyB2NAyCQIFjkSfD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b84o+FxFKc3eZ1DBozz6zdi4WxRi81/bJ2TORzKivA=;
 b=CC/Ml4j4eDmHkPT3v8y/GBupJcnJVAMjLsY6vpJDPDgCTU+ztQeoX4ZAYowXWp5SrOESN8EpTlX7BBQuMedKq6ZNEfV7M9UPoDssLHfywoF+KyajGL4b2nn9B/gfR7ATamkW4JjE3lii8SdKnXYMbbO8tp8zsh9Q8sL1QIviFgudb5kGIi2iV9Tx8mdQZ0GSV1+atv/bhW/oK0K14vSr3yynx1Rj1wFK8v4IhMXnM8o6y1bNA3VvF1nL3wqn5mjRvLG8hOGn8bvtXF4rugrR9JTbgY3y45CgrWvdGfrrSwsLQngnYCsfAzlyzHDXl/7EZUQNShxX1gp5dv6M2ll1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b84o+FxFKc3eZ1DBozz6zdi4WxRi81/bJ2TORzKivA=;
 b=X+0rdfzkUnUpVbkz9DmrN30jMp1RZ90gKJtewvJ95UOpujtBoRkxvnU5eRENomNrRaPlq6pi0EfTAwmQNto6ZdHyu1b6hK6wG5WFVXSAfzuZyH/jgY6B/x2viK9uZmYnUaVPElQMZoIUlhj6FRKBWZPhBkTYpAwLI/lpE4rEypg=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:26 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::60) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:24 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:22 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 08/47] hw/arm/xlnx-versal: xram: refactor creation
Date: Wed, 20 Aug 2025 10:25:07 +0200
Message-ID: <20250820082549.69724-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef7fc33-ddf1-4d8f-46e3-08dddfc34164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zcZSLkzWmdqGsoMx9B7Xv3ONhF3pM3eH3iLDmf30PqhJ7djXJBqH9khCbTz0?=
 =?us-ascii?Q?GgWSFOkLDw3syfNNun2LuBmkMAW7A3ikDhada4srWnCA5BVVUcMiOeKcvaTO?=
 =?us-ascii?Q?MKOGNcDQ9G11jj2oiJKtsHr4oLs/qFGf3z1ruveXYA4LUeSOu7JkXV58X6O1?=
 =?us-ascii?Q?Yo1ygeChRZV44OPEYZF5d1bEp5OCYzRPoEiV5yVVlM2ZDAkGDz2Oavw7Jm3h?=
 =?us-ascii?Q?vTyDAEM7WovwgEt+bDD+TSZ3CDPoYbiptQpXulUuVWQnZf/PAR7TErLqAqnw?=
 =?us-ascii?Q?Jy7eRcjAkfl70U9aud6egvC4CoGy+KOvKYl6/721Pq5pnZOTxKHGUyGd993f?=
 =?us-ascii?Q?KKDvMgu+dgUI2y7KIjameDLBvoN4nCeG/I8gJ6mhgNW+0H8B63lh6gTsn8V8?=
 =?us-ascii?Q?vF6nxav+RXVBPnIqRhIKAabfwFGgYOrnCWepZI7ABcnj9xAsIsyVEUne6YeE?=
 =?us-ascii?Q?l0ZCNk7lPR8imAXjgkWkSxuj7EGBxwYcs6F6bChVn7x2Nm/qk5Yw+jFb4wBt?=
 =?us-ascii?Q?vQ2RMDOsHLUtFQOkE0uTgpzTQFhyfNOclr1cQ1L8ieM6liGaP+fom/rwdo6c?=
 =?us-ascii?Q?fAl9P7hSIoiy3mDCQTjEhmXXEa/ncp0LPlm2fmid02Orf20j5I2BtID63knU?=
 =?us-ascii?Q?DL791PUk4KgaDr6eXkAD5M5lgnz2ngNC/Q2LTQpV6fQEV1ooNvQ28iBZv0Ht?=
 =?us-ascii?Q?46ipYNi8trBsyZ1/20Rrhb7EO7Paz6pvkGqRp+94MGg9HkPGZW1hBl01XIVv?=
 =?us-ascii?Q?kKfTJ75sq7uXF6Id6bgx4e6LA5oPuMAT9uLyPWCu7vc210JEUfatWRh6MFWA?=
 =?us-ascii?Q?oD2soXmr0XqLMzcBSCwWCcZXIw0x1ByhqvcL6SV47QOMsjPBiKWYkSNiESj/?=
 =?us-ascii?Q?YcjL4jR3Dc2ATiTFOZsuTOBZvTTcHBIeFQJ2eQF+SZngPzVi1okEqQX5QoKt?=
 =?us-ascii?Q?3J1FCycxhG4tFGh1l41lUZInrcGxOSi5Oa6XeZQkbPC8vSOPqfrohKtNegVF?=
 =?us-ascii?Q?syIKNDNsCzhu3A+Ekhtl7iIS7Zthtt5xNfE+bNuL5YrF6Q9Y0x8S1H+nVrfT?=
 =?us-ascii?Q?fJZ2G/Ae40OPS8QHKs0PW0rgPaJdqQS2oPSZoHpH/9K9sKu3XRixGg66VGXj?=
 =?us-ascii?Q?ztB8lbUA8B+7H4qwcikbAPbFGs3zjoiLcl/vorJQQtvTQRoi7yMTXizo64WI?=
 =?us-ascii?Q?T00Y2D66P0k40fgbZj3l/igJzMxZ/aYR1SJczP8QlXMuwuytEm+5+eUiESDl?=
 =?us-ascii?Q?2jEZMi2KIoCDpF99KCP6kzkEEozBmP0yUPbJOCXMibFeDJjYWtpV8uk67kP0?=
 =?us-ascii?Q?JQj5mFy6FHUBjmR0sAxU1BYOrNevGCJuE1zhp/C2DuUelTYP1B1xgrFwKfh1?=
 =?us-ascii?Q?m60nKx+tIcl5GhD5TUTVuwuIfehSsd/jhD/NvlHwYY2kvsn293dP15bttUFA?=
 =?us-ascii?Q?Be8C9c5bL3ZBL+N9wv0+xfkfL0Z5V/4Ug35v84dIvYM/0jnEXYGTkBkGFJZJ?=
 =?us-ascii?Q?wfXtUwwIMIrlDPp7+q9pESQU7+e4CBjcYWxa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:26.3846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef7fc33-ddf1-4d8f-46e3-08dddfc34164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
Received-SPF: permerror client-ip=2a01:111:f403:2412::623;
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


