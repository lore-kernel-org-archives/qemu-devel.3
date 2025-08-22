Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49112CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVt-0007it-QW; Fri, 22 Aug 2025 11:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVh-0007bi-VI; Fri, 22 Aug 2025 11:17:01 -0400
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2412::604]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVZ-00077h-BH; Fri, 22 Aug 2025 11:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCVZkPj5ow79U+GdgcL/EOqXh+O+JaupRWgRONSBrLSWFZ3qoHdOQ1eAfkf4jMviD8956sY6oj0+4VDZGJHoOf1fIRtLXkbmKY/bOyyEP4VKXt472bC5uTqHh6z/OBJuZwAL7YPZk0iofrwnsDdL1WZrapx2d3jLYdZIk2rXErHilhfZwCguMei9GWaymUCNEC4fChcWuXQI7/w3L5wUJWZX3VFmQLzDX8cGGRoaFGkGnceqA/sYbIMsnWM4+jQCIflW93z/XtFKhzT5tPi7c3bOxQHgz/QWNiBDywHs1ssZjRaBdt2YOCHY0K8WjSaoYAb1A25BFrcER7wEMlNxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMNsOtMg313bEot7T27LebvCm+C5occ0TNpTo2mblyg=;
 b=puAtF8YJtG6Zg3vtDqin7dBDAP/w5kPBlYgK/BnRUxBPOKbwxQV0KGd6W0M8NMykNny/QgqCTr271WZwaSmEInHnE03xRhrU/fxgSwn8X5c7kEt6Ga9T+BlW8QtF0uIF3BZPpO/uFLe0KGivY3T4pGFL1MtBwuXVyLDABIE9/QzLoa6abNujdte9jbo25X+RTiPXrn3u5nD6RCTu3A1o5IjeoDHlU9ek7KFhG6KeyUeqL3jw5JmHVaRZakw1QSx7LJ1EU6CQkQB0+nE2OYC+r15dZwFtQN8Y2rellLnJ5OgqTYL5QBb2eoQxvKD0Ammtj+BrF8U5d9gLFW2VOdMCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMNsOtMg313bEot7T27LebvCm+C5occ0TNpTo2mblyg=;
 b=C+gs9zlx8zKa5aPdRxHwucGE6U0moa2Ez2dXaOaG22KpeS0wfO0B+o7nakmFlDNmyKh9CW6Mc40YepypZXXRobiH/nqr7yR3v+ymY8LlpiKrGE8eXvi3QLu/J/CMr9O//TYUM2wiEXQWBKDSIiSJEaWY03Gn+eKpbVFARATWdkc=
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:16:41 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::6a) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:16:40 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:38 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 08/47] hw/arm/xlnx-versal: xram: refactor creation
Date: Fri, 22 Aug 2025 17:15:33 +0200
Message-ID: <20250822151614.187856-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ceb0e75-a5c8-4888-409d-08dde18ee5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LhsQ40sCgD54Lzad7vkYZRiHRbLWbJTzsgHtP+gd4cldChb1tfkssRSNhnm8?=
 =?us-ascii?Q?Hh4h6OyftWkewbxKwNQpD+ZkSlDK7P1Ti+1EDEt9B2dyQibwZFnh22nDrRep?=
 =?us-ascii?Q?W5TpKIf29xJOXOgRRIPL6i2xcsugiK/fS5Ms7FG0iPpckL/AefFrVYa+K/am?=
 =?us-ascii?Q?roXjQ1WTo4hWdoy5YCn5poDdwkZvuZ1xIXupcl6Pb8E0tfOiVckM1lxWJU0N?=
 =?us-ascii?Q?jlFm/5qiGgXmAKYFChyC3AmBBxbi/40VL+7miKaq5MQbFX8Wu2GRnbhcgYl0?=
 =?us-ascii?Q?A5nPRTuvbMl555yq5QUEu3hGMdWqEFa4haV/Exe5aBDbBPhLGkAI4CqdzCKd?=
 =?us-ascii?Q?GDtIaFHUz930ivnIhXuTQuOTgLXfGFKjNl7PwLk/E1ugXVcd5cjr597Kam31?=
 =?us-ascii?Q?+U9pFUsUUmt/KKxMLKBaAJYU38l2CaWJ4HL4G9m97jJkG6Z1f2IQwTPglCip?=
 =?us-ascii?Q?qGnzqtDLhhQr0G/iXM9Qnal67t8KRdIoNzvrisfDJc+oJ2o/57bigPNkFvV1?=
 =?us-ascii?Q?EauiW0n9D0U+FfslEsUDzpBE8VyVi14Mt2gm/SPbN/c//RiUfvrHoNtKHRRo?=
 =?us-ascii?Q?3IkgYABZF/Msrvd+cSEj91JvGCQ9hyDowkj8Ny3c400DiJ+kIx6X9wZxt7qQ?=
 =?us-ascii?Q?SBV2vMtVw1Kbto+9xnlmZmskQQuqzbNvUb7149l8CBgR/TGjV2T/NUJ0Xged?=
 =?us-ascii?Q?53Fn7CwzWr3GldUQwDTg0VtAXdt/LZXMMeiTDTK8Dk1/huS5kmt2DNUDbJTW?=
 =?us-ascii?Q?rxDu4i5ybCzg/ZkRrduHQz4X5FrunzhYDiRA+BdXmKzZ4VN4XfV4GCy2rCR4?=
 =?us-ascii?Q?P52WzHLxmhlmWMlhH9i1hGiAbuTnRqbP54iMXbfQ3aydp0yHi2bu5kkvwLoK?=
 =?us-ascii?Q?FR50E8GiSs03a1Z2NQmP5Z+fStjK3Mi9StBKhO45pQXKVppbfRdS16Rlkijl?=
 =?us-ascii?Q?AoYxPXeGhqgCbSLH2BsMvi92J0bHMT2+YQaPs7HuBAufPrZisMK1ZV0gV5En?=
 =?us-ascii?Q?KUBx7Sy5pqRARG3JcOJ4v4j1bX94z+0vW0epb1VSoPo49JE1Fe0qxOs4zmQ1?=
 =?us-ascii?Q?FVty5zKTwgNcnALxYLkZ6JVzeM283OxkDH/vOQygrvEqTW2ouAlC/hOanIoo?=
 =?us-ascii?Q?xvcJBxGd+h9H4kePhuMDD/RgT6bdbYs6DSDFk8zLbucsTB6/zqhBy2xMs/Pg?=
 =?us-ascii?Q?yELR6zsC/fiOHZQ592qTKLxNd1k12bnhyP20P4enVrbOTODNoesXvadubJ33?=
 =?us-ascii?Q?Nb03w/uBgCN+q20huan526KnhWlHdS57BdZyDPerGY7+Bjza5c8lj8zH9R6r?=
 =?us-ascii?Q?sAmIytDr56GyD1f7gR2iB1JodhRttS/pkNP+A/gB1ehtfTajCq2Bu2gSwjWM?=
 =?us-ascii?Q?bxZy5565ukboqVfBapLQf9QD4WsT/kNvioWKPBA+0UQK+embrdVixiHihfU0?=
 =?us-ascii?Q?waQD5zl3tdEUM7ra0J7V9xUaItMJ1FYdbGlaPN+mQrpgcgH+VajEGD1lU31u?=
 =?us-ascii?Q?g/x5RoD0hOjdD9yWOTsOIT8o9DQeE/qxEKxL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:41.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceb0e75-a5c8-4888-409d-08dde18ee5cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
Received-SPF: permerror client-ip=2a01:111:f403:2412::604;
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
index 0ce9703cbaa..2c2aa0fa2d6 100644
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


