Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F5CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aC-0006Rj-VD; Fri, 26 Sep 2025 03:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a4-0006ML-2r; Fri, 26 Sep 2025 03:09:24 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zk-0006b0-DQ; Fri, 26 Sep 2025 03:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwDisx1LYsNYQzttiII4ovi/iYRct9hUprjquP3BP4O/+dyLbP7Zu4XLPt1XMFjfdnwx7g+yh+06u5zX77cCj2Rkw4NC8GWPMgvZvR7tA3bG1g3E02Woh07U4R4aPQdVvb7OWhGDgWBvf/+XSirI8BJF8C2uAG8GoK4UvuHEaAhm6IZllBCRAge5gYy0fyAHweXFyeZszAtcHb1Cou/uoa/XijlQJrIvpWSZINEkvpp0SN0HnQRfaE9azFLH4kmo4zvG+aGIMXUv06L3+Y+yWhVtBqBY7fwPiu6jv0CquRH9GQmmo0tSjS5SR+ZPCa5HbYNbYyoenrqo2nBJ6NN/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un0Bel8YGFBjL2xn83TlJoMCi2ePmiU+A6mMin4HsMg=;
 b=IDc8Zg8+5CySE2+7vXxOBExmdp6Bw3rTSz1ONufpl2Si/2KZ0zESZfWEDUCtoLLUZgdrKYlXDZvEEovMc4Obqra6rs1+eGluSl3ldRsJTYgE/Q9HVMaPmRE1Ei1/gWQgYBChpTHSdCoxo7XaiYXfjjRqK3o4iJINDZ43Gp2DFGgnzvbe2yZAJl7w+Wxho5EDvhscnw0mbrCbOMSh4ajPKJ7+ms0NAXDlPLLugsao+ULj6Wg818o+GtX4otdvQkluyVhR/oDGPXBWXh4OgDd4U4frxp7jm/mBb198GOCyKTgOhQzIoBtC+7cOJDSvO1VS0sssmzDyJCV3apPpC8FPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un0Bel8YGFBjL2xn83TlJoMCi2ePmiU+A6mMin4HsMg=;
 b=wbMylUjtEuIvbkLjRnn5jmmUOsAbGYV3XhzEQ3Nlir0QCxB6KX8/VrgQkuDtjluFZUKZ/abDGmkmGeJOuRIG6VfQcsJxzyuOAWXxgCV01N7hjvbS+ZSsRr9uAGGY5vhrZaOwOrKXZiNWX6YTfFZyUx4GVs4b1lnNLyq6TljNym8=
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:08:57 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::46) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:40 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:39 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:38 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 15/47] hw/arm/xlnx-versal: trng: refactor creation
Date: Fri, 26 Sep 2025 09:07:33 +0200
Message-ID: <20250926070806.292065-16-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: da1fa0cf-ea42-4056-7e53-08ddfccb8f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJeJD9LPEQq7EkvsiiQcVnduvmd4PL1Kf2ImeF5mcLxe5QtKjmhX1u9HpRAM?=
 =?us-ascii?Q?l8hN3j7N1y8pFva0NtzfOwXrykRF8wgUjkDpvy3NzFJt3mlPorWMzyfdv6n6?=
 =?us-ascii?Q?kX1kcIOq3HZd+NROw5W3oEsnX9mFe1zBJR1mOCpjxW+s81H9ddugW0ld2lDK?=
 =?us-ascii?Q?0SQBSSHv5H6FYj6QrHUp3+rj9VldAUk3viSg+InKrRqgknJn8sx00W215kHX?=
 =?us-ascii?Q?ZX6A3aaZnQ+/oj8gz570ld1zln6/+ig2b/zR7AR+EiCk7+L45wrYZ3j+ckiZ?=
 =?us-ascii?Q?l6ZCMGPKt+dSJzv0o3JH4PnqwSg3hJ176wgJVTF1Do37gDEhiyX9ohYiQigl?=
 =?us-ascii?Q?/0r0wb89ycJPyssc9yMImkjzstqTsZ3DF9+FyCXKCfgv8z33Yy8kySp2kAy6?=
 =?us-ascii?Q?o6dkmxvto+pwjjkp7hLUi6RYpF2G4If79K1ywOWVZ1GbgE709Tp2te7xcqcz?=
 =?us-ascii?Q?Jb3cSSylxzZTRUdznInGvju+qm0PKFhwPI1WsG9n7vxFK8aTlvLLnaVzYeCe?=
 =?us-ascii?Q?8GvHIN5xRIuhAaQgZusIQI5k86dUHjzvZKc89CXfVIQMyJEmiIXelmSWdHSw?=
 =?us-ascii?Q?G1FDQLloXCVhM1kefXvlrK/94P5TSVY5DZ0bgdAnasv43w8psmvcfJhmYE1h?=
 =?us-ascii?Q?O+QVX7W+lvCIFrFNQsDM99HDSgPo0evWt1VPH/tCo0JYAfW1uYZWALcu2OIs?=
 =?us-ascii?Q?Z9kFt7NuFENaH5qA5r2eX0TiW8MpVyMneRwpS4mUhhGedDuKTG+xU4LcjJiO?=
 =?us-ascii?Q?gKoRTKweywCgW2Q9MyYFCxQ7dvrCCviG/4W0CtRm4PhH9QMgmHqH6Qq9BWXI?=
 =?us-ascii?Q?dBgnfZFn291lFXTosAoIWjfXObQUTzliJnJbZ3+cVwtqOW1nBuF1+u1BrTXG?=
 =?us-ascii?Q?rWosTIAuX8NI6etkCXWa1LeuSkPXEdTYB+LWm7pkwPnj6YjBv/v53KYVbyrz?=
 =?us-ascii?Q?STzHeiCeGXuimiopPyR4hYP0CqWXeVBqrB3PZYrPpggpKYVjhYAkXhKKLQxJ?=
 =?us-ascii?Q?3rvuVjKD7qXrRiZsBDOaJwUROnvGiyBaBgBQPmiwYH3Fzrx3VGZedJfAspdk?=
 =?us-ascii?Q?8SvfkyRIjRnni+gIeA0vKECyncL+WVqzLeqebRGUP6dThxDu+/d3Y4vgSmjE?=
 =?us-ascii?Q?B8gX13tLJ/zDcbmwHzsMW9qIdFAEJClBqj1wCGiCrEXj87uw0b52hLHU8/zx?=
 =?us-ascii?Q?gPXxZ+ndFYoxajLosvrAURNhzgMTogWVSA/AlLZUTMC1MDa4P/otUu9VFnwi?=
 =?us-ascii?Q?hKWAgKareLuJMVeA4IWF9aV9vgO6DWhxGdoOvgAk7l+WtAo89EA5Tu+OrCPq?=
 =?us-ascii?Q?uOYItorPEf72kESjUNpPZJlnBAzXhFZQAkTYweOzOauUdJ5E3W7X+p8TXnBC?=
 =?us-ascii?Q?VVEIR2yY/9Vbzt6jfkb3Uk1ur23kYaxeTRHWvkSYZMF7jqmzg6M65jTRw3Cc?=
 =?us-ascii?Q?+0Xl6pvlSlrxxSedLEYRQ0t0XEAdOjGWIFqn9ClQW5dZHKNyi6NyN5O+GnqZ?=
 =?us-ascii?Q?WbVv3VyNqi6sD8HWsPVN6Pf3T4ToxeO26Xx0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:56.9569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1fa0cf-ea42-4056-7e53-08ddfccb8f5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Refactor the TRNG device creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 31ceaf61bed..7a97d5df6b8 100644
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
@@ -1336,14 +1338,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.51.0


