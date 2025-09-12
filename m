Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7F2CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cd-0006c5-3P; Fri, 12 Sep 2025 06:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cY-0006KY-BU; Fri, 12 Sep 2025 06:03:10 -0400
Received: from mail-mw2nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cR-0001JY-0R; Fri, 12 Sep 2025 06:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvlbgw5ib79MhkcgnF1+OL2wg1MbpAq7T9TNn8dv/nr5vrwVR2r4eUJftJbraubMdIooLAT7SwDalMSMmy2Ua3Ns67/3fP6nlEs21s5ExS/B2Bh5mdhvb6A7JyMuxQ1wua9o1kQjfGMm6d2+D1t4/snQbnsdNM3Bn+br62h/XqK+FJjWP9vnDRrD+edEjueRkp7NgBXGlDCxvIIaEgNZbDFZdNiUjJUi78acxVpIfJiyjH3gnIZBKgYnMljH3AIU8qFA5Cf31kYqKq3GgdzkLJ5BNYeniNdOsSP6B/RGZFbDR7FyMHVqe7wJoVuNc/0lLE4JBWDIwaFa26bB113foA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdK4djylWJtOyWU9sVPMd58hL6JoBk2qhvRM8X24ZYA=;
 b=uS84mpQ+WlH91bVf9oihHQVrRbPfdDZroQ3fkI+/qcwkFYJGpFUqpyN9h7jS5c+HWGLSYnizedkwpopnoTWEYRUlVFNeoZ9ECAr9BRN51WjFpOztdBIn5I36pGpwi1HGI5xJMQ6arBgCEHLAbmJp2cy0rSE2Y2LmyCo8cTQS/2KwyqZYm8zhRjav6/y0X9DusNPOVzSbsIIGqrWyGDLc9cXc+UGaDpGWH+VRCTw8niJN48IEqypJHydiidkz3Pm5gxE0ay3Mdus+819vF77gK3nGtxPzWT+xnDueIfCNraWEiCG8XqknBmSu9wAXw0ko+05loTnxbvA27ti93MvhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdK4djylWJtOyWU9sVPMd58hL6JoBk2qhvRM8X24ZYA=;
 b=V9/3LWwwY3wzYpiUSTB6L6dscBOHmTJkMXLtUWB8CaSFbmB64G18xRpFvHIfFah73AQMfCxReVsbI5kdFFsYQzPga0UyP7crllqEGUYiuAGosGZge9d+Oapji2daZI8UJbmBT8yFFuC3ieO7s7S8KEzwjNupMW9t6s+BpPpGEqU=
Received: from DS7PR03CA0123.namprd03.prod.outlook.com (2603:10b6:5:3b4::8) by
 BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:54 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::f5) by DS7PR03CA0123.outlook.office365.com
 (2603:10b6:5:3b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 10:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:50 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:50 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:48 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 16/47] hw/arm/xlnx-versal: rtc: refactor creation
Date: Fri, 12 Sep 2025 12:00:25 +0200
Message-ID: <20250912100059.103997-17-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: c55534f5-d445-4f84-5b4c-08ddf1e38a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pVBKyM9V75GuHf8QAWjBLZ6RRFKWuX1ZY/vwfP4i5i1bzUE1gj0HGo8qqpoU?=
 =?us-ascii?Q?cL4ib37YV2zsGd9Xmz1J74lIcC5Mz0S68pCW0ReWja8bqm30KcuSdEHqM4qV?=
 =?us-ascii?Q?5ZiGtY714o7k1XagkrthFojLxOHTE6Qclbtd/0L0U5o7uPE7O//778OG/lsN?=
 =?us-ascii?Q?2AdhyfvXic5TyxFd8SlgiRpTnvO/vXA//n7s3jPwfk2WF6yR68/WSZFaKaDw?=
 =?us-ascii?Q?txY0RxZxd3cc7XGnuNK5flFYkloUO2v7Lv3d67g/ymy37roaqYcuNHYkPYSG?=
 =?us-ascii?Q?7PVQBUFkV+MJDTU7470kpSxMjtITCKSh5n+HGn+I2Z2Ib4xuj1rhurTA5bsC?=
 =?us-ascii?Q?XVQYEbBSZ5p7jwp/Jem9UrPCwnAfBJ6VunNHlaB9dI3gFS4NosGACpwr1lIz?=
 =?us-ascii?Q?qy2+3LQgxZGgOPOohZXLr3XoIjRnluOMpO79tWEreLJI4BDyb1MWa0SMJTdH?=
 =?us-ascii?Q?Kquu025TsTNuWTy9oiLwjts3irdg+QGnXJsrZMlymzMj9o7FHYslHHYaw1NE?=
 =?us-ascii?Q?aIH6mRfCWeQEU9ofGnQi208W3OZ/9rrapVlW4WUzVABQY0zcgso6fI03xVak?=
 =?us-ascii?Q?c6l0MV7A/yOEVeNWe6vDhEvFhwCdx3Aofa71wj/vOF5n0M/nO6nxylxPkO9k?=
 =?us-ascii?Q?gHhfsKrCKie6ExTERGH0AbMLFyl34aEPd8NmNwgwTE6SvvUwPMn5JxXe4jQY?=
 =?us-ascii?Q?QHlUAECmlU9F64dx9YBcuVGnVPsiYEy6iL9YtzPU0SiYEW6ntXStUsB7VdFI?=
 =?us-ascii?Q?ahC9T0oszYGWgH9hT6rKRS+kNGOHq408TnH+1zMHyMV/i2OCNSbrjF8Zx64f?=
 =?us-ascii?Q?Efd4kBumesbwf8fq2K0t34oR/GxDrJowwuxZW1RcDiBfPH7keAa/ZWH8IjWS?=
 =?us-ascii?Q?5jfZidpBpxaVMh8a4ahMyybRU9rxUsvGpJ+/kTcjW0dhVMUZKfmfEUQHqld3?=
 =?us-ascii?Q?E3RzZZbeNjPaxPqY43BelVIxvKH8AFx1fAAQ1d1ulYzF1oG06rUHjrzhPaJM?=
 =?us-ascii?Q?zVsSn1zwY8CEwB79nd943EzAWblQ86bG3klBaSPD/x/R04VYkOTG3JkbnJnX?=
 =?us-ascii?Q?v02tOgBrPRY52iPREDfeA0hd7LEI6yMwQv/Mx9ZWgsyhRRAbn8rn5q3tstYG?=
 =?us-ascii?Q?/RBKuaIeRo83H6cq0dj0oNUyk9gLP0bqAd482+tyKnOvV17Qi9GaoTuXGFKB?=
 =?us-ascii?Q?oapOlEsdVVqtcRISuFMbsn7ZfYWdZNsDmGaayOcUkUsZXsmCnzoDCsgoYQnc?=
 =?us-ascii?Q?XwQqPBZp8yerZRFZbWYKDWUzXoRNB6P+Q2EawdtFOxg7MExY6yU82IJI+w1k?=
 =?us-ascii?Q?Iz3oylEk94tUmZqvcRos8hSurfxp3ra/XOohiKU1PPiMvdUFl8gS2FjhAfDo?=
 =?us-ascii?Q?LZpfb1GyUuQy087MPF97GCbl9xdj6FRUdlnfZ6orQU68qnwJw40vJPEEHB65?=
 =?us-ascii?Q?vEIgF1Qjb8Moxm5avTFPW/M3dhdBDW3JuaH5ggR/fBpFnOXrg1FsNdJqjNLs?=
 =?us-ascii?Q?jxkrtTxXnll6weS1Rqfr04BhLqbgcM8EBHW5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:53.8159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55534f5-d445-4f84-5b4c-08ddf1e38a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
Received-SPF: permerror client-ip=2a01:111:f403:2412::62a;
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
index f766a3e1027..d96f3433929 100644
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
@@ -424,11 +403,10 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_rtc_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     /* Make the APU cpu address space visible to virtio and other
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 5054f4146f1..2f1507a1bf3 100644
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
@@ -760,29 +771,40 @@ static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
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
@@ -1343,13 +1365,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
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


