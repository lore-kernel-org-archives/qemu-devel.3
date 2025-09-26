Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F11CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22a1-0006L1-5g; Fri, 26 Sep 2025 03:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zw-0006J7-Co; Fri, 26 Sep 2025 03:09:17 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zh-0006ac-91; Fri, 26 Sep 2025 03:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs3MK0cQnvtCTNBjAMfO6OVvp3o+rQlSyNrmYNXLkEXHISHqcIaK+DUP1osI/DDuHk9SlCd4W/phA1pKudgOaJy40KXXqOGTtiIyApLBuDvBJ9P+vhrq1bbtZSN+NpkYmlMoHoGhxi02NvojF0gbVBu+YCaRkDToF8ca+lnZQQVAqX2aXPfe4cr+iQaoFM6+lPwSNduBEvE3CQpT4A9pXFUrrXqOLRKWMKCemPbhnRAGBMadRmXbX5Gr+XLFLJC66NgEThY6ECY+vOj/94Yj1A6GOsRicpXNi9N3iydVcU2VhbuVE80TSQZu5vS/Bu3ehaRZqiF8jSH8aREoQkYtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AogIG5xxuDsrR76ut2pbHIc1LQbNTHLBLv4I5HXFJ4=;
 b=KD6DRD9H+8bDMl0LjZ5ZQ3KILyDAYkbVZ8usbw0PKl6LOx5oHZ42LL1to23f57n3s9dPf62jRmiRWMaHceTmLA0lE86pMY8DOSWk4IN86WJhWUCr6ov5iz4S71gRNVSSZjgN+6N62FI2E9W2qGJX/SrPHEnesQfVf9p/uKX0hK/JUYynPWiNA2qnbhcRAeABxeEWaquWv0w7BLPbPW7BulJcPzfEJV7g/zTFh2NIiuysQrZkd1z0T1Zg1EwlC4T7VDarhcXbbXk2hLh7b6J9fZPFsP9SGLxqhIsQ1k1cg/tfdSh0f0Vek43slD1rFqD2iSfeCuxjK/6TW0UHnMHI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AogIG5xxuDsrR76ut2pbHIc1LQbNTHLBLv4I5HXFJ4=;
 b=XTBMXaPnvzqhWhxWrdf20NLhc6+WJmfoWBVLZwmXceKWFLc0GxPRy2lCBPZpDbLRx15977y2v9Ej5SSAizY7Wogo8T7j99p2GmT2ooMXjcxEGlZcOKmKXDSj3wE0TA3n+ezfAiiELp5v+qawWYnVeZ+6mj4SjdSu5ifUjR3OlzU=
Received: from SA9PR13CA0102.namprd13.prod.outlook.com (2603:10b6:806:24::17)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:08:52 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::5) by SA9PR13CA0102.outlook.office365.com
 (2603:10b6:806:24::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.5 via Frontend Transport; Fri,
 26 Sep 2025 07:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:42 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:41 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:40 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 16/47] hw/arm/xlnx-versal: rtc: refactor creation
Date: Fri, 26 Sep 2025 09:07:34 +0200
Message-ID: <20250926070806.292065-17-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: d106250b-317c-4429-5379-08ddfccb8c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMAjdhJ1Y8jZt9GogtmTAZvfsTBso7P7x6vKyZWNtsX5+8XHQAsK5aHMtMh6?=
 =?us-ascii?Q?ZYgEWVKtVfK/nQeB7fs7AmbT+o1wr33gBnO+DSqbS/GhrNHkdBGqEiZs0hbk?=
 =?us-ascii?Q?S0OQv1E3TwOJJdbYwzUrMkOOQUlm0qB4ncDr35mXTf0gUJdV51kUTFTZ3qxm?=
 =?us-ascii?Q?M1F67QAFXFYexJ1B050ShIhf7uXyTmhHnZNb2CDuOXDm1NEk/cQWQfjcFyZU?=
 =?us-ascii?Q?w6BivlX0nuqYuTN/U7/HHYCgmllkYVXjCPWE9ltRr4lL2SXCkMgP/iilEh29?=
 =?us-ascii?Q?rzQRi8BOBX9/BoWjd/Vpwrb7l5nXJByKZx1tfL0RyEWHAltS3SKLuB6JxIrZ?=
 =?us-ascii?Q?RMatt68a/uaRekWv4lwXEMX1dI6XjgzsM0WlgUhECxJ2NllvyYNo4vw/PG1u?=
 =?us-ascii?Q?ux7gsRjUPq4+D0EaU490HqkylaV/+8efRb1hWnU0iPEbHD5MQum71pyMULdZ?=
 =?us-ascii?Q?Gh8Q50i0Kzlmp1MJtMsYvgQRaGJ2UqTyfUAb3WcbvLEJZaCWnfLf1Oq+ptp2?=
 =?us-ascii?Q?DIlAP3W4CcSQkrwXg4///Cbmp1RZW+NV6wgCWcqFPCjuKAoCOXIjfPaxeSmG?=
 =?us-ascii?Q?bWDc1Bg7bWHE5gMOIJDWV0U5WXlmS/0pnXajb0Wmi4nyTxPImVeozfJh3Jwc?=
 =?us-ascii?Q?FTu25Cz+OaFflDzhSTOm9P14cs/d44dT168iLhnYNvs1uhX2CkZiwAZxK5dH?=
 =?us-ascii?Q?FhmiV3dp0TVpi4isvist0QwL3vku13vIPO5ZONp32pqTVyfmUI4hZ+cFPwZl?=
 =?us-ascii?Q?n1FVUw0hQ4E7lnq9Hg/y3JNGQef0ANoq8lXMP7TrxBSojEsftkngCl/ROmUH?=
 =?us-ascii?Q?MYZZtNLpi3UcEbJ5Q4r6IhJ9WOR8ZaDDUtkSYmgE8YKMeBvm9DrUwAXvYWuG?=
 =?us-ascii?Q?1k1vKukoHlN5kJt2Cnj99V8jebzTAM1u2npAXeNGnMJZDztii1MsEXdKW1cE?=
 =?us-ascii?Q?TBXIDn/iaC2wyg9iZZ+N6ceQY68n+hwsAorObs2fMXXy4nyW/Fn9c7bNRT0M?=
 =?us-ascii?Q?B38B0j5OkPGc9Ze3TJtdWDhcNmVo6FKrhJqmNV7D8mt3roHM2aZR8pLAbyAX?=
 =?us-ascii?Q?t74sgKbDgQjYIHpZRYREhBcIKYXNSHn3IP9UIfjO888MlUHp82YhueqqxqHh?=
 =?us-ascii?Q?tGJdCGcPPGBuFRR9JSgclsnAmrUJMh0yNcqazp+yTgX7vg5OTIh3nCQ7Itx5?=
 =?us-ascii?Q?2BnSrDaNjaGMqpJ5ifkgIAT0tNVEcRf81T6ygdrCbQF/p/6E1lUZ4wuGjQ8D?=
 =?us-ascii?Q?QxwF274hYNHfphgtebU7VkzLphcBluUJgGSi8Nh1wGwzoKJ6KKq4F8XxLoeu?=
 =?us-ascii?Q?WJfvb7kckByraabk65TOEcc8ipHZ1uf5QWzfVKBxSaF2HM8G/2d1U7LIoeOr?=
 =?us-ascii?Q?WWxZ7xr9DxnamMafboSFkRSKeV1j6qPQYVXR19tB1fJ7zuBT7vTcrxMw/nx+?=
 =?us-ascii?Q?SE5nFQC2OKqz5YVfKOXhWv4Te5FJVp179VXCLvenDoZ5BDMhCuEiMVnXdZJr?=
 =?us-ascii?Q?PeNTSViMCWIUrrEIZ117ym3qN47FhSkmw7oa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:51.7100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d106250b-317c-4429-5379-08ddfccb8c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Luc.Michel@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 7a97d5df6b8..9b1e0d46f1b 100644
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
@@ -1339,13 +1361,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.51.0


