Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B569CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yP-0001ZS-Un; Thu, 21 Aug 2025 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yH-0001QC-Jd; Thu, 21 Aug 2025 09:04:49 -0400
Received: from mail-bn7nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60d]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yC-0002wd-LK; Thu, 21 Aug 2025 09:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx8sAfxWLq5mgfbQtzP+WpXndjBohE7UO+XqKhi4eb+F5yPQRquv5AKKMoyMP4Yz0hk0TFusCjiIrBAG+4OZcgQD+9T4KQi8xqdQGwXSujVx7br2iX7vcKHObHcTZIniklXORmopvrKV0FLhAiIDp9iSlupT27x/kUczC8LqpDrhZTWuaabCqRvN3OkxTOTEJr0Wk4Juljq8OLfOHvw0tlkhb2ZvEVBwqWl7FIUgJy+FaXBfAEwjtVU0DCApy7SP+Cv1sUZSYC9q61P2TD5K7Pn7EDcsUkKDOVGx7qE7jALBC3UKv7wVXDPh/VQHmQlNINZrw5IaQtIy5UcY8FyFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvBhc1xcchn6NlVjkVJ1U0/AKo5axIcwbDMShqbYs5w=;
 b=UIYHG1Z3fhuD5ETjf+NNWD+Fxoska0Lzcv8dzjyRXXBi0Tmrgb5bbUlZcU9ULVcyc6uT6Ma2KkVjL6zUE7F8HNdhgN7a0leBp8R0UMJUzE1c9q7FBjqVoDcRRax71JUoQohbnV53AWq1RBgctcxzIW99JCaxH0JBo88S6geFtyWDKX9zpQXhoDBa8dGy0FghckGXfj9tcXWCniC8Qg65mU4CGAV0k/WnfOU+UiuBvi+9Onm4ZLMb5E4rU7TbJwKRsPSEEsHntJKytn3F2n0Bvsfx8TGCaM62cQ+bwsrvoZ9G8o9kZO1s9dvAqA3iPgsd3FCsH7qmu7Tx8beYQHElOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvBhc1xcchn6NlVjkVJ1U0/AKo5axIcwbDMShqbYs5w=;
 b=cbV9VDYEHgv8AZduyvLu68iPROxpbrGLpsQqvOzgXo7Jsh2yBt7o72OkY6C9SGwHJ+POvgZO0r/FM1NTxW4MsY3sRpJbxlbJ59iOFqi2SaRakw0zBep+03Ic7ASRFn4V4/Enhr7XzWZz1Q0rZMKgPwXy8GQqHXBjM2WaxCF8zzU=
Received: from PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::15)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:37 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::29) by PH8P221CA0063.outlook.office365.com
 (2603:10b6:510:349::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:36 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:34 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 18/47] hw/arm/xlnx-versal: crl: refactor creation
Date: Thu, 21 Aug 2025 15:03:17 +0200
Message-ID: <20250821130354.125971-19-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 7246212d-767d-42d3-d0ee-08dde0b34866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YDYbpbmPZp9IrdvWB828Oyq8iRqjKoeQoj6HnDFQZ9KR5x6smXi7uE8uH3Bj?=
 =?us-ascii?Q?vnxK53VYjK7PzA32XNDrqi7+hE6oY53Uxsdd6QZPI/6z5VfbA+ZRUTsYfIdr?=
 =?us-ascii?Q?qCkkpWRtato5/ekA8RgrzV0v/L8XxsI/r96C33XaQ4JZhu/fn/y5KHQFpFay?=
 =?us-ascii?Q?/CEQmnUao82T9MfHE0s8K8lgyHOYUVSD98g/A9vycKqtOrOJjoNCrWSiKEoh?=
 =?us-ascii?Q?j3TDiL1aXAtEe3XwykR796Zv3rLYLh15QmVHOUSspmdLehg0YU1BG8IrzBhh?=
 =?us-ascii?Q?Ap1tkRG5TGow4HthQWJOlviz7ji94ZDRpqEfqcWeX04/jJw2mdj7SSQlwit+?=
 =?us-ascii?Q?a6WVD48ru4GT+LHsTBBqYK9UbORXwPEu91ClYdXd3+r+FTZVXadOt/Y2507T?=
 =?us-ascii?Q?RZyjiua1YBldr43YFFhHFAAlytgKjIEx31oMEuHCuTyrt/PG1emXtvwylz65?=
 =?us-ascii?Q?hloG/b7qAKD98hZRHwvoIpOXGChuSSS9mx4lres2Hg9QkuwshPoUIRDlIOEk?=
 =?us-ascii?Q?PtAGWupMMg3xalfjqIrm2uZJfCzYkZRx9p7lA2q19NeY9OYvvUkBZFcXXOxi?=
 =?us-ascii?Q?2d/lcwFNVyunW9DmkYB9H9eodQ6XZp102CZEJlNPaJBPQJl5px+85G06A9uF?=
 =?us-ascii?Q?5fa9LdE8DLkxxamqd1qBUGR69deb814XjDQI1pzPiteycTnsmYERF4oSckbb?=
 =?us-ascii?Q?FqSDs1qf9A2p/lw5UQXUMfqa9Ryvq5AIPY69INglSpWwNzYyjlaaWHDD6Ta5?=
 =?us-ascii?Q?DWWx+WE1niYBFjA1GkFLUOhpee97Bbr5fvAv28YEOkgRnK7OxI2ADIeU6NUX?=
 =?us-ascii?Q?KpZjoMDfSwDiRp63UVbHf4j181Ox7DUlThGsex0YLlTpRcmbt13cQqsi0Sst?=
 =?us-ascii?Q?OhGaOxTeI7a2R/gl6276LVjECJ3A1SwU2vVhH35d4gyyOJ6JTCWDFXuD0rlL?=
 =?us-ascii?Q?2q2+flIUFuvbtqHA8vlqfdZCP423dCla7iHlpqTPvLYPxvNz63tO4FxGHJvF?=
 =?us-ascii?Q?hoB7aWgNByov8wCNjywafuveKrjsSVoWRq7iLyVxpoYnuBq4dj3wZA7ek5ZK?=
 =?us-ascii?Q?W7hhnlFiO+nbXOe8ecKOhc2um6GL2vUpatvdccPWqxwlrfncUNRKKsz50XCh?=
 =?us-ascii?Q?Xitje1jgwa1ItIv/Rjl2A/JScMiPHsjnZPtYSQeJ7SKmHMLJ+OIZwFCtqj+S?=
 =?us-ascii?Q?2uNRvso6ULly6EUDM1qaAZGO4PCZ8ZUQj4s6u4fPZghzFQx7ouc6XWKwCpHM?=
 =?us-ascii?Q?fWmsWXuf0TW6s8l2/3KemYf6M2L2r6J7i3PAHX0w3JPT0zCPaTPI9+fAQJBf?=
 =?us-ascii?Q?e0RsDBwUFLMUrOQwSfcxQu9PGD6+cD45AEDkWKWoaCTLBS2AdWcBnU6v1aG/?=
 =?us-ascii?Q?0E3R/yoozQlbqUzz/6i4swZeFWqeh3cdWlHmefyFUje0/ctM96WkK8FZIIAy?=
 =?us-ascii?Q?2kLEKJV/0FsdYfCuMxhg8rNEI6lTbyw0QiGltIX4fnrnO+mV32++sAs/vljY?=
 =?us-ascii?Q?wXTiU6R/RpnolY8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:37.3600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7246212d-767d-42d3-d0ee-08dde0b34866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
Received-SPF: permerror client-ip=2a01:111:f403:2009::60d;
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

Refactor the CRL device creation using the VersalMap structure. The
connections to the RPU CPUs are temporarily removed and will be
reintroduced with next refactoring commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  3 ---
 hw/arm/xlnx-versal.c         | 36 +++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 5a685aea6d4..d3ce13e69de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,11 +15,10 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
-#include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
@@ -69,12 +68,10 @@ struct Versal {
             MemoryRegion mr_ps_alias;
 
             CPUClusterState cluster;
             ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
         } rpu;
-
-        XlnxVersalCRL crl;
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2128dbbad92..ff55ec62301 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -40,10 +40,11 @@
 #include "hw/misc/xlnx-versal-trng.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
+#include "hw/misc/xlnx-versal-crl.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -149,10 +150,12 @@ typedef struct VersalMap {
         size_t num_cframe;
         struct VersalCfuCframeCfg {
             uint32_t blktype_frames[7];
         } cframe_cfg[15];
     } cfu;
+
+    VersalSimplePeriphMap crl;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -213,10 +216,12 @@ static const VersalMap VERSAL_MAP = {
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
         },
     },
+
+    .crl = { 0xff5e0000, 10 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -1106,31 +1111,28 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     sysbus_realize_and_unref(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
-static void versal_create_crl(Versal *s, qemu_irq *pic)
+static inline void versal_create_crl(Versal *s)
 {
-    SysBusDevice *sbd;
-    int i;
+    const VersalMap *map;
+    const char *crl_class;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "crl", &s->lpd.crl,
-                            TYPE_XLNX_VERSAL_CRL);
-    sbd = SYS_BUS_DEVICE(&s->lpd.crl);
+    map = versal_get_map(s);
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        g_autofree gchar *name = g_strdup_printf("cpu_r5[%d]", i);
+    crl_class = TYPE_XLNX_VERSAL_CRL;
+    dev = qdev_new(crl_class);
+    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
 
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.rpu.cpu[i]),
-                                 &error_abort);
-    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_CRL,
-                                sysbus_mmio_get_region(sbd, 0));
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->crl.addr,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
 }
 
 /* This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
@@ -1327,12 +1329,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     versal_create_bbram(s, &map->bbram);
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
+    versal_create_crl(s);
 
-    versal_create_crl(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-- 
2.50.1


