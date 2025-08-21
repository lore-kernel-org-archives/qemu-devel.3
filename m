Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25A1CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yf-0001jH-3E; Thu, 21 Aug 2025 09:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yJ-0001SN-RC; Thu, 21 Aug 2025 09:04:51 -0400
Received: from mail-dm6nam12on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2417::606]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yB-0002v6-Fk; Thu, 21 Aug 2025 09:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgGMZbburXuoUIhhY82EdSvZWDgaIevbEoazNcugMWyn5EhG56N4eZ865i8l/zp1Djr1aAHDkCQ1E1M1tJfGbYo/z1t65+su5IMWdF2h4q3jNYm4ExAhUYn+mNlz0DB4N9rcuUZoa0l5WXAEQ8fhge2kqrrkUWwLzM5jfA4hwfEFZe2Sj4gggsafAQ0+tNnUTY4dnWmHLXWeuyvLKkBT4vlz3CvqBVlLHozrJ83ayRHx1kLje3b4pf3dASY1L8dgmhZeJ90OExzgd61/qy6Vyx5hZHYxkWFe9XedsZWxqm0/4CIqnQkf58hRwxSFzh+EkntSPgpA0arigq0nQrdIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/h7o6blKIuemyfoqPbSLP1bGiAch/qigjVEz8Rk5/U=;
 b=pY44K8eNfm/yJiuyzmWRXQIsQ57wytqkBM3JxR68Dwg9q4EX6a328C1cjnaClQZVlXcYeaPHWwzbme/fahSBRGcxr8mcpBaKXkmyEJGmu807LTR5MkuAJ4mOzvIikvU7toHxDyWB2Xi4ZkWp5R/BKU9AFJHH35kxjrcTWzHu66e/58sxCOzyGMZoE5BQdcnDlqQOYZQoIQKt0l3rQ+WOVYs3zJ6Yg/I3fgJxN/Wdd8ne5uI2edmUrQQ+ChRR0VOHEKFLVrFFwXHPkft1Mco9LjRqO9klXQ/zFgpwdS5lmFOvv6SgQs8j6ZeZS5tezDA5kyBu87gAdJdULm4FRv+4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/h7o6blKIuemyfoqPbSLP1bGiAch/qigjVEz8Rk5/U=;
 b=oGnKmVg4NKFk5BhIP2EsjCsBkMiIv5pMvauR8B6iiyl6pBXuWton4B/hj15usiWQoXchsjIoglcG74FwoRm4aHXv/F/IZUGcAuLqEKFW+N0YpyeumvxqqUKTZgt6zmT9W9Mp4V7Q5qJ08FBBrb101TeLIw9nBT/Om+z7SlOlOkY=
Received: from SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 13:04:33 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::d9) by SA0PR11CA0206.outlook.office365.com
 (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:32 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:30 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 16/47] hw/arm/xlnx-versal: rtc: refactor creation
Date: Thu, 21 Aug 2025 15:03:15 +0200
Message-ID: <20250821130354.125971-17-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e11f33d-16bc-4137-4b3e-08dde0b345d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fdoWfm+KLvdRlyFu0K8EW2TJQ6hayhT65oZm8hFBB7YRtU3LlSgd44vNQSRV?=
 =?us-ascii?Q?CSbdUnVliGv6ifF2qpDK9/k3kQwGMrPKCPyCw3e8apdyYhCr+IrVhSr8WGSK?=
 =?us-ascii?Q?bThby6rYpmN8++K87Q8ErGEPuersBb9dirF8nGayjQC3PXgDGzqZxREr8Nox?=
 =?us-ascii?Q?Rb9KAc8STgsD/QrSqpuRlHzNcq9UDb8vHvav7Bffp2vIAwsJFvESKhMQBIvq?=
 =?us-ascii?Q?A32Qwr43qmfBKZCCtb1qqpqIt8eD8VkqiRqXsiEKXl75HTVA5OJjFgPZbpeJ?=
 =?us-ascii?Q?rO2q6cXCcTZi2aFzvukf7jrYm1CDLJbcbqQelHIKUfkswr/M1TRRJWK7sG6X?=
 =?us-ascii?Q?VJeb+uhcB/d2tTjGssTox6GwxdntcB0XS4VKGi63zAN5/0RqdX09s/ZMY8SH?=
 =?us-ascii?Q?/7DkOOOoUtdEk6oI2AdVE1yIu43/8uoV+FCMUzFcy8jb55BiLk8v5A2YBTAC?=
 =?us-ascii?Q?cxjOjuADKy9eMDE5XQnvF1jSXKB8KmB7DxsNSKSYOMjuCUUYFyIGj4OwlWGe?=
 =?us-ascii?Q?sZyKsLCIDCG193di0X9PU2yR+QnhzqVmiOOsRvzkzrTFjMvDW0YPPAklJWGv?=
 =?us-ascii?Q?BJNi82xxL1w20XfJVl4JYGVS1XjMMH1rDZXy9AIImqaoxdF28Sb6I2GAB/A1?=
 =?us-ascii?Q?qabPfbVM1j+Sd3dyMy4+cqepVZrTEBJocvTqosT5PforFY6+U/24bcqDtzxN?=
 =?us-ascii?Q?NJEBqAycunwA8tRT/dGB4TKaCF3HPUZIRGmrCIdn/IPjWiNCUA/Vpq7gxPio?=
 =?us-ascii?Q?o5NIpJKNns0N7aGOyYwFu4C2lgW+XnQ9188ifz6TqMoKCLGhF05om5JuIT0u?=
 =?us-ascii?Q?5fhLQ8Rg4kOnuDiJG4n7V3ej99H1CUCzElJOnk8qlqZ6veZgMxHhs/pHz8fR?=
 =?us-ascii?Q?UQayCBpKUU/PuDGo1Fe4HhkcauwHacSHLv/fXmUnCdDtfDnbRsA7D49Pmn1+?=
 =?us-ascii?Q?VVH/Q3GA3uLu93PDA0kLRsJ7wcDPlvAmzsdn2erTS9wk9dTiKy4Scshbmh3W?=
 =?us-ascii?Q?edEjESn65yNX3m0tB4kgCvASKdirpI4AT3gPVSgOT9gIFfcF+F8sfJid1qt3?=
 =?us-ascii?Q?nWYYjliRbm9WiA0+omTZEjbnUTK6gK7UBbl28Dog47BVpxWxGK0ucONb1XgD?=
 =?us-ascii?Q?eoicQm+iYzkNPQpaAJHblFQODMxKgBdumGRfQ2yFUFKJP5A8zZdr4iHsqNTh?=
 =?us-ascii?Q?NtlBAQls0xVvzuCWImgmSxDaRMYdWM9OtokELMtTnMMa5abldJuW3ki+V7FZ?=
 =?us-ascii?Q?2gl/SHX3kujZOD5dK41rdR93uwFuRKHDnNMlrfeGKNOJx3ICpEzvTuUgRAEA?=
 =?us-ascii?Q?TFsVSNt5vDRoM/Xd2tYeXEUJrwPrtDRrcViqbteea3Smf6XzXB3Ob7WIdEP4?=
 =?us-ascii?Q?mv+o9xVQSmVln388RG75/NW0q9eNYysdn9mOAuSREDADvZJZ6ZDvI/7YPUdD?=
 =?us-ascii?Q?yATEILU8XHhh4i5jYT2dsC0Vzb8v1E5kOvucLeVRNcISSHTfeXvPHGr4ATKU?=
 =?us-ascii?Q?EAPyZ5dpHnRUukg7YVG22uFwvN+fHZcXO7fX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:33.1163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e11f33d-16bc-4137-4b3e-08dde0b345d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Received-SPF: permerror client-ip=2a01:111:f403:2417::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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
index 3b44d9c5c56..467efb92936 100644
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
2.50.1


