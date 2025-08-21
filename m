Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE935CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yM-0001UV-N6; Thu, 21 Aug 2025 09:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yE-0001Pv-6y; Thu, 21 Aug 2025 09:04:46 -0400
Received: from mail-bn8nam11on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60d]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y7-0002uX-57; Thu, 21 Aug 2025 09:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aumk1XgBU3Lkhv0L7bUV/QcYHu1LhyJ6qfCmieOsVIZ8Rc5uXbxaBHnhgQjl3RvLRSaY0u02gGyfmOz107P1jZHZU9k2+GbpDmzm+PCFaZr/Y/L8IwiWT+032T34J1WmNpdKP+SvCxkuMNgWawjAQItXOl9wFPpLZa2BgTwtO3uX/WUccqRf84mrrttWGy9fT0sEecaBLhdl6qAOAOKcCtzD+YQwMpKJauTTE69phiKBrFI4uMJwu+zaz6RKOrDnNbRM7s+/bXkKIr6CZVVhtB1ycSabDaoGmHLanNBun0veZjYiQo5v7ZCeLJOs0ay1WNwfD6peS8gab8RgL+2LtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii0lFFstxR/hNlA8TkTYdN2ac7jrF9A03hG+wGd9zMY=;
 b=UpoowS9KE4ZC29DczI9v0RDf0yvrWQQWq9+LDeF+eZ6f+GH6QXw5c7d+xLEVcItpOKSLePeGNpg8OXNbMrTLTcEj2UXuDv1qUShO+JM4I09RHp5U5EC2K1hzaxBh2T0mHSgcdcCC9qxTf7HxizWT6YIfP4byK52PmixyvgrnEIBCdXPOABkKfZ/SLzTuphvY+W8gG9tC5pnI/STp3gYL32Nrq4B64PE/0cCf++Nt5j19xnQOw0Jf3/EZ52EC2Laa2WrPz6J7uYHVcXVqYhrchcrjZCraaVT2GaFVkrvQ9ZMbgoQeh16NOFRk67xT704oV7DhW7MCuQXiiw6WUWCnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii0lFFstxR/hNlA8TkTYdN2ac7jrF9A03hG+wGd9zMY=;
 b=4IvSBnC0Gfa5aXc815/87krZExqCM840Yj+ApMbw8oPXGpmmAGHYtw4mUUCTzu+LMPHHVduZ+/Hj4wG6aBhCeB41OJQ5+m3YZ/1sl/4TxkXiUEWrZXOxwtXg6roiqZj18/Tri84kZbO1plq8eeI6hDQ5QVZ29PaHq+xskYH5620=
Received: from PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::21)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:31 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::d2) by PH7P221CA0026.outlook.office365.com
 (2603:10b6:510:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:19 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:18 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 09/47] hw/arm/xlnx-versal: usb: refactor creation
Date: Thu, 21 Aug 2025 15:03:08 +0200
Message-ID: <20250821130354.125971-10-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a63191-915d-438e-9f17-08dde0b3442f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fzc+jVNcDNDm464O/O4Li8OT2DXkl9tBsMpeAk0q8+QTkEEIziwBGwfS4TOi?=
 =?us-ascii?Q?i7wD9gD8FwZCMeiFWuqjDCi9YhPHr78jwgPw7agPqWgL5BJKlwdCn/40nPTI?=
 =?us-ascii?Q?KStNb7rGhtN3X/Wurmx9eAfsrS2bZHS8DwdhtzlCybiyV3weEENFK8ck23GL?=
 =?us-ascii?Q?nJnaNJ03qOMhkvRwbvNOnT0uEoni57ety8H0t3MdlO6hH2XvF+GPCDnAzJ47?=
 =?us-ascii?Q?3AkYgs5M73jVsSZStv7kiTCeM58a6CVOsIkdOV6ewUhidwSnWFAxCPsvL7nU?=
 =?us-ascii?Q?NL6ng+9WERWrH27/V6RBtMBGK/5crXEHKt8Fp5sBDqsMsHgEC5JJ0EM4elkH?=
 =?us-ascii?Q?CAuUcG+iOKsQ/joeG6kdOSrBtehzKXKZHrZz5rQhpcmXn64a9Wg6X673ljzH?=
 =?us-ascii?Q?0TwvlMf9CMPtlR4F0Xa4FUcJDvnI6XNxL1s3BnOkuXdkL4bRwn9CvxJkE2TY?=
 =?us-ascii?Q?IRh+l/tc7zhPcE/PeE5qJ+ueUZWzB4UGIE7y/PHzG/aJ/WgEd6sDcVRSxLts?=
 =?us-ascii?Q?dwu+dYerSqR0h9eOpdsezXdk8DKJa+tczqoIr2/zYneHrshtRTvXAZQpVJXQ?=
 =?us-ascii?Q?eUzUpinBlppDN2BRADsxL/U65ozTDidM9FtI832y9z35gXH7mMfPls2WmhGD?=
 =?us-ascii?Q?/NTqn8h4gVBlrXms4ZlY8UIPbhLOMSbRiA0d3hj8VLz+ma0DcqarrRCgLi7M?=
 =?us-ascii?Q?dbPqxbkVCzMUfoyZdQrUrnaRsymC+OZhZkLD6viyByISxfOsCKv2CICMHJ1N?=
 =?us-ascii?Q?Z70+A5KigFFkqydj21RmdfAvznrVEGT8Hs3M3RkObdSbicCIQICIxdve4je7?=
 =?us-ascii?Q?rCDsTwLoUFhw8mlpSPAhmA7v0lqET89WuBqZibUeOqJw6sAWTPDPkq4krSAY?=
 =?us-ascii?Q?rZ+A5vtX8SIvqQ8vjfF+2tGnMeo561RgLueT7wMMHnkbE7qJWgcE9KsKFqv6?=
 =?us-ascii?Q?K5PZx7+34bD9FhooApZpBWqrOQLo0j2Z04avi6TGsm62kFJs3lvkBwkCP0/I?=
 =?us-ascii?Q?kLSBrfaHVkpKJ0T+Lfev0/OExo+tlTy23EcoQtNDKi6Dd43Yo9u7kFhTQ0A5?=
 =?us-ascii?Q?7lipIpiZKxieKqionUJrM4BlXEGQBnLcmuXFWwN9w1vap6fq3x/Sg/bnyZB9?=
 =?us-ascii?Q?T54ILxB8A/paR+/KKbm0aKCWq5/j9mGM3BqF7MS/OC4UwItNKc7AYEnEsrsS?=
 =?us-ascii?Q?UdOroSHZDresyOzssOiQ0V6B79y4Ep07b0JG23ME0Pi1+KHeugAeWDpWbp7Y?=
 =?us-ascii?Q?5cLInh+SgbriL2kq67Z9TXvu2i0lVYsqHj7/+/TQunEh5boaskkQCll23WJ6?=
 =?us-ascii?Q?VTFnyOTAohzxi00/dgV7uyK36S4zztWnF3pvA7mUP6jxyrupg+K42DUr6Zdm?=
 =?us-ascii?Q?LIh9pYkEZlI8S0nuLh7A9dXy6Cqri/uCPCSVhOT4ISlT15w3ehv3gqWBcqfj?=
 =?us-ascii?Q?1pbeXHHe+H2KxpW4dHxZUs3evWeVbFUbTXW7cbpHVxscQe3KbL9WPyiL7F7V?=
 =?us-ascii?Q?wej9Qg4XzPDBVMGwY3c9EdUg259IKD+0K4bl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:30.2879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a63191-915d-438e-9f17-08dde0b3442f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
Received-SPF: permerror client-ip=2a01:111:f403:2414::60d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Refactor the USB controller creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  5 ---
 hw/arm/xlnx-versal-virt.c    | 56 +--------------------------
 hw/arm/xlnx-versal.c         | 74 +++++++++++++++++++++++++++++-------
 3 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 71c3314b8b4..5d4b30f0ff9 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -17,11 +17,10 @@
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
-#include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
@@ -72,14 +71,10 @@ struct Versal {
     } noc;
 
     struct {
         MemoryRegion mr_ocm;
 
-        struct {
-            VersalUsb2 usb;
-        } iou;
-
         /* Real-time Processing Unit.  */
         struct {
             MemoryRegion mr;
             MemoryRegion mr_ps_alias;
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index f0fb5694b94..cf5e297fef7 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -12,10 +12,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/device_tree.h"
+#include "system/address-spaces.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
 #include "hw/qdev-properties.h"
@@ -38,12 +39,10 @@ struct VersalVirt {
     int fdt_size;
     struct {
         uint32_t gic;
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
-        uint32_t usb;
-        uint32_t dwc;
     } phandle;
     struct arm_boot_info binfo;
 
     CanBusState **canbus;
 
@@ -66,12 +65,10 @@ static void fdt_create(VersalVirt *s)
     /* Allocate all phandles.  */
     s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
-    s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
-    s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
@@ -152,60 +149,10 @@ static void fdt_add_timer_nodes(VersalVirt *s)
             GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
     qemu_fdt_setprop(s->fdt, "/timer", "compatible",
                      compat, sizeof(compat));
 }
 
-static void fdt_add_usb_xhci_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "bus_clk\0ref_clk";
-    const char irq_name[] = "dwc_usb3";
-    const char compatVersalDWC3[] = "xlnx,versal-dwc3";
-    const char compatDWC3[] = "snps,dwc3";
-    char *name = g_strdup_printf("/usb@%" PRIx32, MM_USB2_CTRL_REGS);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop(s->fdt, name, "compatible",
-                         compatVersalDWC3, sizeof(compatVersalDWC3));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_USB2_CTRL_REGS,
-                                 2, MM_USB2_CTRL_REGS_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-    qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
-    qemu_fdt_setprop(s->fdt, name, "ranges", NULL, 0);
-    qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 2);
-    qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 2);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.usb);
-    g_free(name);
-
-    name = g_strdup_printf("/usb@%" PRIx32 "/dwc3@%" PRIx32,
-                           MM_USB2_CTRL_REGS, MM_USB_0);
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop(s->fdt, name, "compatible",
-                     compatDWC3, sizeof(compatDWC3));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_USB_0, 2, MM_USB_0_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
-                     irq_name, sizeof(irq_name));
-    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_USB0_IRQ_0,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(s->fdt, name,
-                          "snps,quirk-frame-length-adjustment", 0x20);
-    qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
-    qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
-    qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
-    qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
-    qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
-    qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
-    qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
-    qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
-    g_free(name);
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
     const char interrupt_names[] = "alarm\0sec";
     char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
@@ -529,11 +476,10 @@ static void versal_virt_init(MachineState *machine)
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 6c5eb6d3fd5..4e4df0851e8 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -30,10 +30,11 @@
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/misc/xlnx-versal-xramc.h"
+#include "hw/usb/xlnx-usb-subsystem.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -78,10 +79,17 @@ typedef struct VersalMap {
         uint64_t ctrl;
         uint64_t ctrl_stride;
         int irq;
         size_t num;
     } xram;
+
+    struct VersalUsbMap {
+        uint64_t xhci;
+        uint64_t ctrl;
+        int irq;
+    } usb[2];
+    size_t num_usb;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -106,10 +114,13 @@ static const VersalMap VERSAL_MAP = {
         .num = 4,
         .mem = 0xfe800000, .mem_stride = 1 * MiB,
         .ctrl = 0xff8e0000, .ctrl_stride = 0x10000,
         .irq = 79,
     },
+
+    .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
+    .num_usb = 1,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -420,33 +431,71 @@ static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
     qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, map->irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
-static void versal_create_usbs(Versal *s, qemu_irq *pic)
+static void versal_create_usb(Versal *s,
+                              const struct VersalUsbMap *map)
 {
     DeviceState *dev;
     MemoryRegion *mr;
+    g_autofree char *node, *subnode;
+    const char clocknames[] = "bus_clk\0ref_clk";
+    const char irq_name[] = "dwc_usb3";
+    const char compat_versal_dwc3[] = "xlnx,versal-dwc3";
+    const char compat_dwc3[] = "snps,dwc3";
 
-    object_initialize_child(OBJECT(s), "usb2", &s->lpd.iou.usb,
-                            TYPE_XILINX_VERSAL_USB2);
-    dev = DEVICE(&s->lpd.iou.usb);
+    dev = qdev_new(TYPE_XILINX_VERSAL_USB2);
+    object_property_add_child(OBJECT(s), "usb[*]", OBJECT(dev));
 
     object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                              &error_abort);
     qdev_prop_set_uint32(dev, "intrs", 1);
     qdev_prop_set_uint32(dev, "slots", 2);
 
-    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-    memory_region_add_subregion(&s->mr_ps, MM_USB_0, mr);
+    memory_region_add_subregion(&s->mr_ps, map->xhci, mr);
 
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_USB0_IRQ_0]);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
-    memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
+    memory_region_add_subregion(&s->mr_ps, map->ctrl, mr);
+
+    node = versal_fdt_add_simple_subnode(s, "/usb", map->ctrl, 0x10000,
+                                         compat_versal_dwc3,
+                                         sizeof(compat_versal_dwc3));
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                         clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                               s->phandle.clk_25mhz, s->phandle.clk_125mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#size-cells", 2);
+
+    subnode = g_strdup_printf("/%s/dwc3", node);
+    g_free(node);
+
+    node = versal_fdt_add_simple_subnode(s, subnode, map->xhci, 0x10000,
+                                         compat_dwc3,
+                                         sizeof(compat_dwc3));
+    qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-names",
+                     irq_name, sizeof(irq_name));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node,
+                          "snps,quirk-frame-length-adjustment", 0x20);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "#stream-id-cells", 1);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "dr_mode", "host");
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "phy-names", "usb3-phy");
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,dis_u2_susphy_quirk", NULL, 0);
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,dis_u3_susphy_quirk", NULL, 0);
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,refclk_fladj", NULL, 0);
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,mask_phy_reset", NULL, 0);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "maximum-speed", "high-speed");
 }
 
 static void versal_create_gem(Versal *s,
                               const struct VersalGemMap *map)
 {
@@ -1009,14 +1058,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
         object_property_set_link(OBJECT(&s->lpd.crl),
                                  name, OBJECT(&s->lpd.rpu.cpu[i]),
                                  &error_abort);
     }
 
-    object_property_set_link(OBJECT(&s->lpd.crl),
-                             "usb", OBJECT(&s->lpd.iou.usb),
-                             &error_abort);
-
     sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, MM_CRL,
                                 sysbus_mmio_get_region(sbd, 0));
     sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
 }
@@ -1198,11 +1243,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
         versal_create_zdma(s, &map->zdma[i]);
     }
 
     versal_create_xrams(s, &map->xram);
 
-    versal_create_usbs(s, pic);
+    for (i = 0; i < map->num_usb; i++) {
+        versal_create_usb(s, &map->usb[i]);
+    }
+
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
     versal_create_efuse(s, pic);
-- 
2.50.1


