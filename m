Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBA1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22ee-0004pn-3p; Fri, 26 Sep 2025 03:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ec-0004o1-9n; Fri, 26 Sep 2025 03:14:06 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22eW-0007an-UA; Fri, 26 Sep 2025 03:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlxZ+18FDLCi162rXWUcu7sloGg//6KymjNU78d9V6A5VriG5k+0gW2FYgkSOMifc7nEVsf40JBtYd8F1JuseewCuU8VaB5jVVImsbEY3qWVU2RFSHUJqJM2S5T11dcG85NYmsyLEpasoV1s51wN/5ojPBpTvQ0QEHeJyoo+mg1bWqBRzBjZH9YKR1KIprLh1SrcIzP//Tev9EQtwyRI3igDuFmc3CdB6n+iiBMnIEml5QZvJ4ffZIHeXRpqnWXoXctpWSZlbWEWgRtFLExv8wWJDvbNRKzGWPtHyOJSTsUJpEmY5lYrrYoVY/NpuQjMkLvxbct4oF2ZRtO4WbZEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epZi+C5Jf9stdDVxEebeLRs22/iM3jRmrcQ7KrDbC5E=;
 b=uqUfIrXsRFRj0q/WCU/jJXHfUn36bGiPIzkfrh80VarhdwgiRm+qmq0pJJXfUxh+Ttfqtp+AKEeuBV1uz5VeIOSCzS2RvR0cmTfm3uFx1Z5Uu9TNCTMqdcKgxQEsB63YdD9oP3kHNF1+wj9KmU20JHBirgP6Qqg7wtOARol6smFayWMPDicpK/Jm+zITesKY7SPRlUkL3VkXtuB4g9eDz5hlrnnj0O06Qc+bmeiwmXzqTlF9fgRULxOO4GXFq4PZPVMp0uxXyko8js18/GfzdSmUIZu3U8NcxDeuPng4TYYmy9pitvcgWdL4oxko+yPPX5Hmt3I2fL1jXJN/Od6eJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epZi+C5Jf9stdDVxEebeLRs22/iM3jRmrcQ7KrDbC5E=;
 b=gU3iRxkM5XkYM8fadLx0Se23Zc7BmlnyyD+lG94Bdxn+nKdw414sw2B47z9ltKz6jWo+17ZJvotIHOWOUpAiQDPr62WabUThSuKdaSMXGm/vrQCTtoGB8zlqKE/2cUig6XboXxHLTv0uMgXb5CcvU7HjNBVkqQGRgAjFRY5e0qo=
Received: from PH8PR21CA0024.namprd21.prod.outlook.com (2603:10b6:510:2ce::23)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:08:39 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::b7) by PH8PR21CA0024.outlook.office365.com
 (2603:10b6:510:2ce::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Fri,
 26 Sep 2025 07:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:29 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:29 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:28 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 09/47] hw/arm/xlnx-versal: usb: refactor creation
Date: Fri, 26 Sep 2025 09:07:27 +0200
Message-ID: <20250926070806.292065-10-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e8354b-8f3b-48e1-72d0-08ddfccb84a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T3JQhsKYIapZF8G7/JyeGXwhdDVVb38dkjdOwmUSuPysujutulf+YEs5I91K?=
 =?us-ascii?Q?aUncEA28K/ZAVkAn4meNZfTl5h4lYVtxmEwg5EKUXhYTY+9WK9CaCPeGAAQd?=
 =?us-ascii?Q?oOzr5S1vjzQyXCRp0Ls7rxd/5/NT+7xLohNAsp/HO2ZLldmGHH+/YHcIjXof?=
 =?us-ascii?Q?ImcsT6hU+/B8O1ZAWoAKB1lCzYt0fzO3E6RecUV0IBZG8sRCtBV7EuetjsIl?=
 =?us-ascii?Q?exHtpPqKJgdzLSBzojsaYbNnmYj5aubzFe7rXlgLhOGs51/IUt8x/eyF5QQj?=
 =?us-ascii?Q?wLBpXrFBm6pUfRgBnv2ohg54VfEwku4otfOGKtMEssDSx8o961FHnrikgRau?=
 =?us-ascii?Q?zAbZfBqnLkAFxKLZbo7CanGxZY1D8bJXLXH0dS/riIgMkdr/gxbJ85NmyW81?=
 =?us-ascii?Q?7Bq4QfI54ZiAXB892uewO3g/T0Gjg5clC2Q6Wv80ImtvXNdY8M3s5/IliGmk?=
 =?us-ascii?Q?OTzHmJFMbqLS1WEaLLCtT64QfmrHcbGRkVBgm858Wifw4tHtBN3ezhP8FwXK?=
 =?us-ascii?Q?vjL5TuJGYJhW9HbuYOKpJXIFP9enRa/zeh4IHzLqAda01nX/KuvUJhAHM8vh?=
 =?us-ascii?Q?uhx3CLADMcKNmY7hsuEkrZfH6YH82dE/bQVNVGdb2NjQHlMCGjrUngB9Ex/0?=
 =?us-ascii?Q?/oD1ZV1UCHSXfjAgZoVwAGPjkp+bdzvmhqBI96p/zcAp2dXeumjhZKs+1DZA?=
 =?us-ascii?Q?4Sfzl4gTx5PRqx/qyb35n2A+ONS1kPtLUgsP/3Jrbf7lJvcvPD7ev1lJ9Tie?=
 =?us-ascii?Q?nUIFL7PckkMQdXJd6drwm/Daepo8jQKKsrcPvaffGpaIeYh7tHXlX6M8F1Q2?=
 =?us-ascii?Q?7QMWITtuITckrGvQYlR5tGm5OdzJY9dst9VDbOZyw419dmJCOIIkyrQ0/xRY?=
 =?us-ascii?Q?RUS+8YtwfzzGpj3AtMJw4p7uYJJ+uWQtCwL1L0D6fTscUGvYQqjcwVS0O+u2?=
 =?us-ascii?Q?UorKnpl/Yk/4JcKmV8bImR3jNv55yonecD1gfjkX11GreqzIwLUL6I4l9NLK?=
 =?us-ascii?Q?FRso46LUhFfQygmHCsRGC0dXnwpnKF1zv6QlpN/2gJX7K4gNLwq/dR4RcKzE?=
 =?us-ascii?Q?lTQu45SKJ+qilFqf3JqXdfl5vFcA/SYk8g8RgXMzOK6K+a6+T+AiBOOCvKXA?=
 =?us-ascii?Q?VTLXmYp7an/k2LEyjnJTgF024E8gaXCZYCtHHiiCsDypkdPZS+SqeP1cljAt?=
 =?us-ascii?Q?ZKAozKw7BKnB5RxLxIRrVIebHmd30HmMG0wE2iAk7+ljmnpShD99dKd7VeEx?=
 =?us-ascii?Q?fMLxweHkrw1ANRSPWsIgA3DmSnc4eQHd9iHhyGrR+CRUjgnebjvx2/KxRzAO?=
 =?us-ascii?Q?7MRxOhQs1p0MLuOXqdgZpi3aKhcAI36saojpcLeC7Wba00BibwiUBwJiEBFU?=
 =?us-ascii?Q?XCPozJWfxjun+NgIWhSPX3mYFIoHN1poyEEf5XvscbzZgsOcQP8XCoMUZoFI?=
 =?us-ascii?Q?pTmh2PqEEy7/foYCQ7W6dt+it9klmdvNZU3EmzoHx59ZfFV5z3Fj7tykmv5a?=
 =?us-ascii?Q?dmmzYk0AG+XN2oORZ3zxkZONxzaoRJO/nU2w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:38.9723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e8354b-8f3b-48e1-72d0-08ddfccb84a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Refactor the USB controller creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 418e4c6e983..5801598da7c 100644
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
@@ -532,11 +479,10 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 295fca3d60d..946c0170674 100644
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
@@ -1015,14 +1064,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
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
@@ -1206,11 +1251,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.51.0


