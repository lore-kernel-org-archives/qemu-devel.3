Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED78C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysu-0004iJ-Dr; Wed, 16 Jul 2025 05:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrh-0001ZA-8S; Wed, 16 Jul 2025 05:55:59 -0400
Received: from mail-bn8nam04on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2408::626]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrb-0006bg-38; Wed, 16 Jul 2025 05:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7JLN4E4CPDQVIauXUhPAOni89mwXkiYjL5ozMfSm8m5SmDg343/q8UQvOOhh/+aeNFSVlMlMF1PRQS0KHe44IC55Rnz7vT4F23QDRQt5UcmCuyMQpb/ecdQhhAxa+tqqcvERd7zNFn0vDgELBwrCnQPhl2DLLPOLVw8nsZrrkndNTYl9zj8LuSirU+bw+H/C+8fsYOONHnsxodctOiliiXghhCIOoZZRzMdLPrZpVi8mE0+/GrAcJhdzM3GN1/zIr3Uf4KVeS+QLFY/ttiJ97E95ifFaXXLOOvf5HO0JbpMH31Z2FJgNY4aJj/QQP2ih9B4H07bJGWIeIafQ1zL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ze+y5vcAta7FtAHxZwvqiz8QmUe5Dg35HI3+B2YmK8=;
 b=bbKOC+uWBI5CQ0g3UotKGq4IzDnRj3C4an3xc2RoJ7lbROhm2GZe30AEJjeJxXt+po+KRDCl7expY6Ge1/nqqT31WHYwc7Rpm5As2zyQ1BC+k/O7WywZtn+XnE3OfT0rFcT9qQYqUevkijAH7W7UXa0iC/Ck999Pqayz4AVM3tovNxAUSsMgUqzNCLYUUiySk4yE3wELvg9SAxOW59HPLyY/ErA2U9njbesICdfnRkmaEHhSb90ovde1IHMriGAEbyVBKMVyusrukKlXAm9Alq8nvd61qiRCyNwI9y51OiGG2ISfc8NaymQysSKiT4u0FMiNT9atKK9l84h+YRhrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ze+y5vcAta7FtAHxZwvqiz8QmUe5Dg35HI3+B2YmK8=;
 b=vn33ShhKGgtOSvBPdW3EyBGqjgppTSUrjri4SJgpp0OqhHB4TuLrpkNFgo4ZExyBhyV77jJHQ+4tQjMOzkZXuJiewzO6Rn6KwHnhNZ9Wxo7Z12VU8B9EyFTFsCw0YKOf0aIRzs6HNN9vHP0k0sKJpF+F6NViC5/9+V1DZOAECKE=
Received: from CH3P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::15)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 09:55:38 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::6a) by CH3P220CA0022.outlook.office365.com
 (2603:10b6:610:1e8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:32 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:30 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 17/48] hw/arm/xlnx-versal: rtc: refactor creation
Date: Wed, 16 Jul 2025 11:53:59 +0200
Message-ID: <20250716095432.81923-18-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: adb1b1e6-f00b-4de5-dc5e-08ddc44eeab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kDmELyHFil6MmQyTf4uRj0LyJF7C7GKTcSaFjUP4SVJ5y2Uew5m/E0R6HFec?=
 =?us-ascii?Q?RwjrkqS8NlLU5GXwI50ICbEmdDzqDjATSDMi4syyTgln33s/rSooh5C+K46e?=
 =?us-ascii?Q?Sd23YwwbNKbwiUVKCxwUjyk3g69+fszBFAsUeaYZdm2Eg5XYcxNPbN0JdHgS?=
 =?us-ascii?Q?9vjryldXwG9habKVVlYkCtnWG8+vtmXI8JqrJpQM12iEcIS3N5QWTXv3Y/3v?=
 =?us-ascii?Q?dZYYvEeH+0BxFwtb+oLSfojxHfUMeBuZytFgbRF2eSvudRlgHTQ7zhi1KxRi?=
 =?us-ascii?Q?7+9kRERy+XYQxQ7RWG4YrTjUfZicE8ENGfap1LAbgTY/F4+87wcuNtLfSt1L?=
 =?us-ascii?Q?IXWO8Y3sll636QaimlIIJ6+2RqtuJgVBLDFzhiflOauUMa3wtTdGvgjok4wM?=
 =?us-ascii?Q?cZLE0hrmCHfJD+OVCInSfxbcuDkl6ECm7jb7gRIaFtQvTnvyQBLjKyRW6Sdv?=
 =?us-ascii?Q?LuA1oqAU3ZmV4iKRMyWZDvDrTiD+uJbL5xZy3RftaO5f9UNr7Gj3XKTCD1F7?=
 =?us-ascii?Q?cGAOO53s7hheUj05NStYwZUWX1s5EX+XjBV2llOcxA+Q1ZeOTVogfFaDOPx0?=
 =?us-ascii?Q?cOCRV/Jxq3GtBIwY/AH93L1MHBgJb1DL63EYpBqgpiB5Ah/Wbrk7zSQHPwhV?=
 =?us-ascii?Q?ddWTjVXwGfQperrYzYoJv9ReXxoFqgOh8zpW33Yf46SQa+a3cuQXZVL52IlN?=
 =?us-ascii?Q?DSGs3UDviXius5x3FpEHnC28Y0hWefH4cWxS41Nsa5J3CGU+2DW+WUSrcQk4?=
 =?us-ascii?Q?k0o5QbA7kvoC2UgWsgNUULqgKNrvRGc+QgU8UG62LKBDXsWCiGMCDrBj0FJy?=
 =?us-ascii?Q?iYtGi7bJ9tfpwxL8fn+dX5UUo9OP6+Mx/hOz6kH5wZVyNWDER6BtF1tuz9zD?=
 =?us-ascii?Q?1ZnHW/BkRyhvT6Xz922yEzMjVZVnrJyWuARCluSbAaJmFNgq8c7g/88F/sEn?=
 =?us-ascii?Q?XHLnj2sEtbBoNlTd3v3qHklH7dNI7qDhDdvoj0dGx+O+KGPvvgfMwXZ4gkmR?=
 =?us-ascii?Q?m1vQHXxe0vhWkCdeW3qvGmsuMU8jup40xh/JDZe6ti8F2z40MXp2SMHNlRug?=
 =?us-ascii?Q?FIPzNyclY/n93lNugEibBB2RoqQdZJ1jbihzy7IaeozCLeb4atuYeJCED2X3?=
 =?us-ascii?Q?kKxwACBXvcOAKcoZvtDjJjQSHVrz9u0fvq9mecKpAzfXXv4cs8YO2A1OByoU?=
 =?us-ascii?Q?ooEEZpZG5F49Yazui8cLmHler4kMjFNh57ivbeYJybbyHyvnBV7FCrRfCPx6?=
 =?us-ascii?Q?7+3v4Bz5KogC2G0ThxWpebA9de2XZA8E1Zm0JyZ/LEGmOF0lwjySWGUSZJNR?=
 =?us-ascii?Q?9SHrS++pevRjg+IuzE+1cvwASOKucF3H7g811+7vGZo65YLDnnTKbNVwhqio?=
 =?us-ascii?Q?c/S5QxtH69y/v/o3FWaL0NbLvGexek9Ro+p1McyRefPilq+bNE7oRYrDaJHF?=
 =?us-ascii?Q?tPrFcztDiTqXoEEjH+d4zPeRN4WNqMJyN2zMW01oVDnffLom7CL7aq58KP9Y?=
 =?us-ascii?Q?0ESF7ZTtRUULNi+t80C83vPgalFmdoXuL2TB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:37.9886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb1b1e6-f00b-4de5-dc5e-08ddc44eeab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
Received-SPF: permerror client-ip=2a01:111:f403:2408::626;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Refactor the RTC device creation using the VersalMap structure.

The sysbus IRQ output 0 (APB IRQ) is connected instead of the output 1
(addr error IRQ). This does not change the current behaviour since the
RTC model does not implement those IRQs anyway.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h |  2 --
 hw/arm/xlnx-versal-virt.c    | 22 --------------------
 hw/arm/xlnx-versal.c         | 40 ++++++++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index bba96201d37..abdbed15689 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,11 +15,10 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
-#include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
@@ -79,11 +78,10 @@ struct Versal {
         XlnxVersalCRL crl;
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
-        XlnxZynqMPRTC rtc;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
         XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
         XlnxVersalCFrameBcastReg cframe_bcast;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2d7e8a5955a..01c230491df 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -149,31 +149,10 @@ static void fdt_add_timer_nodes(VersalVirt *s)
             GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
     qemu_fdt_setprop(s->fdt, "/timer", "compatible",
                      compat, sizeof(compat));
 }
 
-static void fdt_add_rtc_node(VersalVirt *s)
-{
-    const char compat[] = "xlnx,zynqmp-rtc";
-    const char interrupt_names[] = "alarm\0sec";
-    char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-
-    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_ALARM_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_SECONDS_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
-                     interrupt_names, sizeof(interrupt_names));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_PMC_RTC, 2, MM_PMC_RTC_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-    g_free(name);
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
     char **node_path;
     int n = 0;
@@ -421,11 +400,10 @@ static void versal_virt_init(MachineState *machine)
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_rtc_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 45d9fc1e282..41965531f8d 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -36,10 +36,11 @@
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-trng.h"
+#include "hw/rtc/xlnx-zynqmp-rtc.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -121,10 +122,16 @@ typedef struct VersalMap {
     } ospi;
 
     VersalSimplePeriphMap pmc_iou_slcr;
     VersalSimplePeriphMap bbram;
     VersalSimplePeriphMap trng;
+
+    struct VersalRtcMap {
+        VersalSimplePeriphMap map;
+        int alarm_irq;
+        int second_irq;
+    } rtc;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -165,10 +172,14 @@ static const VersalMap VERSAL_MAP = {
     },
 
     .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
     .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
     .trng = { 0xf1230000, 141 },
+    .rtc = {
+        { 0xf12a0000, OR_IRQ(121, 2) },
+        .alarm_irq = 142, .second_irq = 143
+    },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -753,29 +764,40 @@ static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
                             "num-lines", VERSAL_NUM_PMC_APB_IRQS, &error_fatal);
     qdev_realize(orgate, NULL, &error_fatal);
     qdev_connect_gpio_out(orgate, 0, pic[VERSAL_PMC_APB_IRQ]);
 }
 
-static void versal_create_rtc(Versal *s, qemu_irq *pic)
+static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "xlnx,zynqmp-rtc";
+    const char interrupt_names[] = "alarm\0sec";
 
-    object_initialize_child(OBJECT(s), "rtc", &s->pmc.rtc,
-                            TYPE_XLNX_ZYNQMP_RTC);
-    sbd = SYS_BUS_DEVICE(&s->pmc.rtc);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_ZYNQMP_RTC));
+    object_property_add_child(OBJECT(s), "rtc", OBJECT(sbd));
+    sysbus_realize_and_unref(sbd, &error_abort);
 
     mr = sysbus_mmio_get_region(sbd, 0);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_RTC, mr);
+    memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
 
     /*
      * TODO: Connect the ALARM and SECONDS interrupts once our RTC model
      * supports them.
      */
-    sysbus_connect_irq(sbd, 1,
-                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
+    versal_sysbus_connect_irq(s, sbd, 0, map->map.irq);
+
+    node = versal_fdt_add_simple_subnode(s, "/rtc", map->map.addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->alarm_irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                           GIC_FDT_IRQ_TYPE_SPI, map->second_irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-names",
+                     interrupt_names, sizeof(interrupt_names));
 }
 
 static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
 {
     SysBusDevice *sbd;
@@ -1330,13 +1352,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                 qdev_get_gpio_in_named(ospi,
                                                        "ospi-mux-sel", 0));
 
     versal_create_bbram(s, &map->bbram);
     versal_create_trng(s, &map->trng);
+    versal_create_rtc(s, &map->rtc);
 
     versal_create_pmc_apb_irq_orgate(s, pic);
-    versal_create_rtc(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.50.0


