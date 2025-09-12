Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A157ACAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cR-0005x3-Q5; Fri, 12 Sep 2025 06:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cP-0005po-LT; Fri, 12 Sep 2025 06:03:01 -0400
Received: from mail-sn1nam02on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2406::62d]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cG-0001EE-Ep; Fri, 12 Sep 2025 06:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/25YUyxozyQbcwIQHB7tsdOKxYKrrmw3BpGWXiZyl3rQq94A376H5FgQQVkiic4F1VHL/ywgMuFH/SfFmZZQCOMtQizONbwReNmInqvvjyMmlviQDOdcd95FpZVDON75LqCgB+J25DoJ0F8yd9CcGlgSSWylphTXJWeVRIivSDayoIQlD3OMNj0daS1lCjfZh97zVybPYdcTwTxsTlWrDBunZubBzDPwdAA8jIeX9vXr/xt2UH2HogDtA8kUdobHW5ObdvISsd7eOWB/9lCr7OsW9Va4en8RmuDKEXnTmVLfALZTG9zAPDWPhcPxJr6X5zrgVwMhdwMkS9IlYZ61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RzthV+oyR0WDvdvzw7IcAJoSUVnb2LxRn303QHDILA=;
 b=mCtg3hkl7ob7SEmMtTqWY7VyUVk0RYazToPUqYT8OzWSVAJMSxioDEVvxdHFohxwRGcJl1UlpETI+BSs+q+edeDDjdS+VBKc/+xagxMiYtPiEIwBIrq/BvuZz+qMXdiCXuQkBwIY/W4JJ/tlGEtkZOGbgJvWqWfLBSIpEHqeI3Y6dut5FwO4YYAEoYghW1kTey3hNJKn37yLaMFzXJw1AcCxi2BFvf/k9yx2qytfaI8okJJlmY9wwIHOFSRGjwiUEERD5DJsn52XNC6cEZ8iuYGeMHuNtHR4i+3nk3C2FdfvrqTjyt7y8J64BTdfmVmNvZEQA+OzE0DpGlbWUW3Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RzthV+oyR0WDvdvzw7IcAJoSUVnb2LxRn303QHDILA=;
 b=S7FM/ynFSMJLBNYHTCONcevpr9y/aPYXGIRCWswO9BsS6FqGnogpSzW9SyRonW/55qIqm0CK6ESsyEgqk248YIYh+0uCGGnXkecPO2f3QNUKek+urEVXN2sgGoKbBfImx1YiEuYlYB18oN2uV1rZDwvglrzxkoAZop8By0syFE0=
Received: from DS7PR03CA0279.namprd03.prod.outlook.com (2603:10b6:5:3ad::14)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:44 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::c8) by DS7PR03CA0279.outlook.office365.com
 (2603:10b6:5:3ad::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 10:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:32 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:31 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 06/47] hw/arm/xlnx-versal: gem: refactor creation
Date: Fri, 12 Sep 2025 12:00:15 +0200
Message-ID: <20250912100059.103997-7-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d3b833-7266-4e99-05cb-08ddf1e38500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7nOQaDxJ7wYDHrYv3CTIShbD1H0EphqedDN3HeUPAtJUFB3Lds+HikI4DOq6?=
 =?us-ascii?Q?CyUNww2p9oozNkJIH+YQwWG+YTc/2j79pLB7ZO44rHJ4cdAGwfG522mKDlTn?=
 =?us-ascii?Q?WfJ94YVCI+hdvcemEAGUwPo1surGlVOgZlyHHSMpZRitYttZHKDv3sRtYtge?=
 =?us-ascii?Q?tJTNQVXBXohq9+9iHnK1ZCgATv7k6rTFRnphEKTpORnKixr2DcFXBdaPwgbD?=
 =?us-ascii?Q?kYatNtkFR6ccHhCnfKZAjs47XAR+5A6gfaWmBxtB5So87D9HCwgbrig2LsmG?=
 =?us-ascii?Q?wUwzxEkI7/tn4dADcBlXTs0FgnvgLdU3gWMiy5lvlRSZ2Py63BxmANQY5KOC?=
 =?us-ascii?Q?65PUKe5I7O17AeU7NdsTNUxE+3CyUufvEbM5/wyZ2cV+vHYnH0CqeUEjGNEo?=
 =?us-ascii?Q?AKrDbO9oOp876hl01kHkarVINvLHFk0/t3FYY74CPWFlBNK4Z9RmyjpUomdg?=
 =?us-ascii?Q?wGEQ3Ov1WX8ZjXTtj1S5G17zgzTVSW0pe7IPZGEqwQCMeE3+CwtVb6ddBf8e?=
 =?us-ascii?Q?xdTqc7QR7/recg0b3yDbcQgVPRbI65RZBkU82+vJQb8Lz7DtykpX1pYgx4va?=
 =?us-ascii?Q?7mWz/E+z6Eb3x3/6bu1BxYuetRo9ObtlWTo3sAB0WStEtvJDVA2VE/QOY44C?=
 =?us-ascii?Q?2Z+ukTVnGIoxjg+J8J9JbRKLITFynk1uvRZ6Ir7cZ1X72P1O26oVvpRZyHYk?=
 =?us-ascii?Q?vBi6+08KJEJ980KylrbdLluALs9BCmnnzede/CY90Mil6pn1BqUJRRB1XAzI?=
 =?us-ascii?Q?64ksq7Q4lwQq5xPjcTBtN9vFZ4x6beyMEHHUQXYOv5vBA5utkQ3sM7CSjkHp?=
 =?us-ascii?Q?10nfzKe3npMOK9aatQVaZVCEy7vI+xdW37u3xU68hnyAHCQ4/lt0wqnkBl3p?=
 =?us-ascii?Q?moh7Qy1lGIzktRXXRylUfnxNVGn+MjJq5Ns/hbRiikqYB2uTVWETmHlSAfvo?=
 =?us-ascii?Q?ukkeAPvx9x5bqh9BaWu1Rrf5Ly6mXJdM00mB/0tcn4M8gLpIRiHAdk+b8vQL?=
 =?us-ascii?Q?DTHaX6BSIuMFTRyf3RLcfD2EcxPPXXKwZF0q6FG1ANyfABlALoBO3n4wHRI3?=
 =?us-ascii?Q?jaeMFZutW+ddtEqhVcOacgWxWr+E22AXueIy3GTmauYYTk+kOYrYpZGgZM7G?=
 =?us-ascii?Q?hEB1A5TOXsLPLXA/37kaA9vvb5Bdgo/jl4TZVaeuI4Tcgy17OWShvFWyYxrC?=
 =?us-ascii?Q?PgVTNcdwS0fbHt1meubB++u84PAks7RillNCmSB0tPGqRdRtvCYkoXORilj4?=
 =?us-ascii?Q?SUWDigdkrQmg4AKWKxybEF4qunDVeOcgn3cfPXA0cYfb0cZ4FVaUDvqonFwp?=
 =?us-ascii?Q?KGkYUl3VxM8NcMfCIbU1MD812rky4jYzOxP2ytqEApcyA7eLOqDUeF53OaAn?=
 =?us-ascii?Q?kMs2p6seCZrtVbCaliBxI271EL4vHHT252t+PbcPnsnihsh+OqdtkpIQo0Dj?=
 =?us-ascii?Q?qt2+n73HObRFVNpNER73FmjTIofzkSQPBarb2Vut4utvI1DIZF1G8Ec1ISvL?=
 =?us-ascii?Q?QvAkjhMfKYq6/YVe/EKy2evxpxs/YQNWapOz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:44.6913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d3b833-7266-4e99-05cb-08ddf1e38500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
Received-SPF: permerror client-ip=2a01:111:f403:2406::62d;
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

Refactor the GEM ethernet controllers creation using the VersalMap
structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

The FDT nodes are created in reverse order compared to the devices
creation to keep backward compatibility with the previous generated
FDTs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |   3 -
 hw/arm/xlnx-versal-virt.c    |  54 ------------
 hw/arm/xlnx-versal.c         | 163 ++++++++++++++++++++++++++---------
 3 files changed, 120 insertions(+), 100 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 4a7a2d85aac..1fcc2b623da 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -16,11 +16,10 @@
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/dma/xlnx-zdma.h"
-#include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/nvram/xlnx-bbram.h"
@@ -76,12 +75,10 @@ struct Versal {
 
     struct {
         MemoryRegion mr_ocm;
 
         struct {
-            CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
-            OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
         } iou;
 
         /* Real-time Processing Unit.  */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 52852082d4b..0634cc90eac 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -36,11 +36,10 @@ struct VersalVirt {
 
     void *fdt;
     int fdt_size;
     struct {
         uint32_t gic;
-        uint32_t ethernet_phy[2];
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
         uint32_t usb;
         uint32_t dwc;
     } phandle;
@@ -55,23 +54,19 @@ struct VersalVirt {
 };
 
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
-    int i;
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
         error_report("create_device_tree() failed");
         exit(1);
     }
 
     /* Allocate all phandles.  */
     s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
-    for (i = 0; i < ARRAY_SIZE(s->phandle.ethernet_phy); i++) {
-        s->phandle.ethernet_phy[i] = qemu_fdt_alloc_phandle(s->fdt);
-    }
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
     s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
@@ -207,58 +202,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
     qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
     g_free(name);
 }
 
-static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
-                                     uint32_t phandle)
-{
-    char *name = g_strdup_printf("%s/fixed-link", gemname);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
-    qemu_fdt_setprop(s->fdt, name, "full-duplex", NULL, 0);
-    qemu_fdt_setprop_cell(s->fdt, name, "speed", 1000);
-    g_free(name);
-}
-
-static void fdt_add_gem_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_GEM1, MM_GEM0 };
-    unsigned int irqs[] = { VERSAL_GEM1_IRQ_0, VERSAL_GEM0_IRQ_0 };
-    const char clocknames[] = "pclk\0hclk\0tx_clk\0rx_clk";
-    const char compat_gem[] = "cdns,zynqmp-gem\0cdns,gem";
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/ethernet@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        fdt_add_fixed_link_nodes(s, name, s->phandle.ethernet_phy[i]);
-        qemu_fdt_setprop_string(s->fdt, name, "phy-mode", "rgmii-id");
-        qemu_fdt_setprop_cell(s->fdt, name, "phy-handle",
-                              s->phandle.ethernet_phy[i]);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz,
-                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible",
-                         compat_gem, sizeof(compat_gem));
-        qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 1);
-        qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 0);
-        g_free(name);
-    }
-}
-
 static void fdt_add_zdma_nodes(VersalVirt *s)
 {
     const char clocknames[] = "clk_main\0clk_apb";
     const char compat[] = "xlnx,zynqmp-dma-1.0";
     int i;
@@ -610,11 +557,10 @@ static void versal_virt_init(MachineState *machine)
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_gem_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4b4cca0487d..8ad67a110d7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -27,10 +27,11 @@
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
+#include "hw/net/cadence_gem.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -49,10 +50,18 @@ typedef struct VersalMap {
     VersalSimplePeriphMap canfd[4];
     size_t num_canfd;
 
     VersalSimplePeriphMap sdhci[2];
     size_t num_sdhci;
+
+    struct VersalGemMap {
+        VersalSimplePeriphMap map;
+        size_t num_prio_queue;
+        const char *phy_mode;
+        const uint32_t speed;
+    } gem[3];
+    size_t num_gem;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -63,10 +72,14 @@ static const VersalMap VERSAL_MAP = {
     .num_canfd = 2,
 
     .sdhci[0] = { 0xf1040000, 126 },
     .sdhci[1] = { 0xf1050000, 128 },
     .num_sdhci = 2,
+
+    .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
+    .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
+    .num_gem = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -109,10 +122,22 @@ static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
     }
 
     sysbus_connect_irq(sbd, sbd_idx, irq);
 }
 
+static void versal_qdev_connect_gpio_out(Versal *s, DeviceState *dev,
+                                         int dev_idx, int irq_idx)
+{
+    qemu_irq irq = versal_get_irq(s, irq_idx);
+
+    if (irq == NULL) {
+        return;
+    }
+
+    qdev_connect_gpio_out(dev, dev_idx, irq);
+}
+
 static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
                                            uint64_t at, const char *compat,
                                            size_t compat_sz)
 {
     char *p;
@@ -138,10 +163,25 @@ static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
 
     qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
     return p;
 }
 
+static inline DeviceState *create_or_gate(Versal *s, Object *parent,
+                                          const char *name, uint16_t num_lines,
+                                          int irq_idx)
+{
+    DeviceState *or;
+
+    or = qdev_new(TYPE_OR_IRQ);
+    qdev_prop_set_uint16(or, "num-lines", num_lines);
+    object_property_add_child(parent, name, OBJECT(or));
+    qdev_realize_and_unref(or, NULL, &error_abort);
+    versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
+
+    return or;
+}
+
 static void versal_create_apu_cpus(Versal *s)
 {
     int i;
 
     object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
@@ -375,50 +415,86 @@ static void versal_create_usbs(Versal *s, qemu_irq *pic)
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
     memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
 }
 
-static void versal_create_gems(Versal *s, qemu_irq *pic)
+static void versal_create_gem(Versal *s,
+                              const struct VersalGemMap *map)
 {
+    DeviceState *dev;
+    MemoryRegion *mr;
+    DeviceState *or;
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
-        static const int irqs[] = { VERSAL_GEM0_IRQ_0, VERSAL_GEM1_IRQ_0};
-        static const uint64_t addrs[] = { MM_GEM0, MM_GEM1 };
-        char *name = g_strdup_printf("gem%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
-        OrIRQState *or_irq;
-
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
-                                TYPE_CADENCE_GEM);
-        or_irq = &s->lpd.iou.gem_irq_orgate[i];
-        object_initialize_child(OBJECT(s), "gem-irq-orgate[*]",
-                                or_irq, TYPE_OR_IRQ);
-        dev = DEVICE(&s->lpd.iou.gem[i]);
-        qemu_configure_nic_device(dev, true, NULL);
-        object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
-        object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
-                                &error_abort);
-        object_property_set_int(OBJECT(or_irq),
-                                "num-lines", 2, &error_fatal);
-        qdev_realize(DEVICE(or_irq), NULL, &error_fatal);
-        qdev_connect_gpio_out(DEVICE(or_irq), 0, pic[irqs[i]]);
-
-        object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
-                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
-
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(or_irq), 0));
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(or_irq), 1));
-        g_free(name);
+    dev = qdev_new(TYPE_CADENCE_GEM);
+    object_property_add_child(OBJECT(s), "gem[*]", OBJECT(dev));
+
+    qemu_configure_nic_device(dev, true, NULL);
+    object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
+    object_property_set_int(OBJECT(dev), "num-priority-queues",
+                            map->num_prio_queue, &error_abort);
+
+    object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
+
+    /*
+     * The GEM controller exposes one IRQ line per priority queue. In Versal
+     * family devices, those are OR'ed together.
+     */
+    or = create_or_gate(s, OBJECT(dev), "irq-orgate",
+                        map->num_prio_queue, map->map.irq);
+
+    for (i = 0; i < map->num_prio_queue; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, qdev_get_gpio_in(or, i));
     }
 }
 
+static void versal_create_gem_fdt(Versal *s,
+                                  const struct VersalGemMap *map)
+{
+    int i;
+    g_autofree char *node;
+    g_autofree char *phy_node;
+    int phy_phandle;
+    const char compatible[] = "cdns,zynqmp-gem\0cdns,gem";
+    const char clocknames[] = "pclk\0hclk\0tx_clk\0rx_clk";
+    g_autofree uint32_t *irq_prop;
+
+    node = versal_fdt_add_simple_subnode(s, "/ethernet", map->map.addr, 0x1000,
+                                         compatible, sizeof(compatible));
+    phy_node = g_strdup_printf("%s/fixed-link", node);
+    phy_phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
+
+    /* Fixed link PHY node */
+    qemu_fdt_add_subnode(s->cfg.fdt, phy_node);
+    qemu_fdt_setprop_cell(s->cfg.fdt, phy_node, "phandle", phy_phandle);
+    qemu_fdt_setprop(s->cfg.fdt, phy_node, "full-duplex", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, phy_node, "speed", map->speed);
+
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "phy-mode", map->phy_mode);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "phy-handle", phy_phandle);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz,
+                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+
+    irq_prop = g_new(uint32_t, map->num_prio_queue * 3);
+    for (i = 0; i < map->num_prio_queue; i++) {
+        irq_prop[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
+        irq_prop[3 * i + 1] = cpu_to_be32(map->map.irq);
+        irq_prop[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    }
+    qemu_fdt_setprop(s->cfg.fdt, node, "interrupts", irq_prop,
+                     sizeof(uint32_t) * map->num_prio_queue * 3);
+}
+
+
 static void versal_create_admas(Versal *s, qemu_irq *pic)
 {
     int i;
 
     for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
@@ -900,18 +976,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
         object_property_set_link(OBJECT(&s->lpd.crl),
                                  name, OBJECT(&s->lpd.rpu.cpu[i]),
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
-        g_autofree gchar *name = g_strdup_printf("gem[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.gem[i]),
-                                 &error_abort);
-    }
-
     for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
         g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
 
         object_property_set_link(OBJECT(&s->lpd.crl),
                                  name, OBJECT(&s->lpd.iou.adma[i]),
@@ -1095,12 +1163,21 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_sdhci; i++) {
         versal_create_sdhci(s, &map->sdhci[i]);
     }
 
+    for (i = 0; i < map->num_gem; i++) {
+        versal_create_gem(s, &map->gem[i]);
+        /*
+         * Create fdt node in reverse order to keep backward compatibility with
+         * previous versions of the generated FDT. This affects Linux kernel
+         * interface naming order when persistent naming scheme is not in use.
+         */
+        versal_create_gem_fdt(s, &map->gem[map->num_gem - 1 - i]);
+    }
+
     versal_create_usbs(s, pic);
-    versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
-- 
2.50.1


