Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB318CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cj-0006uz-De; Fri, 12 Sep 2025 06:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cV-00064Q-0l; Fri, 12 Sep 2025 06:03:07 -0400
Received: from mail-mw2nam04on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:240a::62e]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cM-0001IJ-17; Fri, 12 Sep 2025 06:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2/yCU6zceMMAcqkXnH25Q7D2dZ1w3qz1lNWgR0BG2dUkO3uvr665KLI7f/oF/ZpYjNhjxq8CY3KXSS2Vxyhoxwi9dqq8EpopY7FVEp1rPCIt16GcjDk3zn1GCu/80m61GZuSh67NcHPjmZoFFQKpQiGXJYIXpAtjMNe/A6IUb/8PS66bLDeYeK51lLeVOe3FTPZWLAs1pTK03Xxpl51IuGiqWrg2U/2hZlyRNp6vnUCOG9PtAPJcUqgajRey9etTruq3Jaij8W52vI12TVmpjtrMiIl0SHhFtkmztHbLqUYK5JbdH/dsDZAajC1ZwJZq9mOZI6ddRk1qFwXJhaMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GaVysA9Mf7BilsM1bywaQzevXzKOpOBpZYIYeMQb8M=;
 b=VCWOuj3d6P8gQQPQA5b2VHxB27tjCzon9Y17vPVoxAoQLSKjtcmN8BVdkAikAurVu4ly11C2YP9Vu8VXxAlIhEl4VWaNf11wjsZxH3OF4wxppO9AVZCsP48a75b+8VSLj40/qiDyieVIpBIzg9NDSBB4VU/Dl1WqIzhJMd0cJ6fV/x8OLg+DZVeFI7FrRNDoYryo0scivOrr9qNdwvqKQe9jUcp0wQXP4AcIzntzrWBuqjlLsg0GCRQBG3P4TzypZyqrlbOnl9lHMDXcNXgOL7MK0gpjFQd9y5X/nTfiQGGbpJd917eMvzs+wMo/CyyCJHbsgJEnro2ZTMuS/J1fgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GaVysA9Mf7BilsM1bywaQzevXzKOpOBpZYIYeMQb8M=;
 b=i+4w2UNxN+jXrinskLLi1zQzmZ1l+22OLs+eLnSjeNVOkNy1Gs0vafDw495tyFmZUg0qj3cYES7qvtVPtqTDL+CDqoCVhrpf2dVpUvmrpok0Y9VybPkWO3LIoHaXg69fPXlTrg85A+6xIyCe4lSDSuM76TgCH99LD2+Tc/7vK4k=
Received: from DM6PR02CA0066.namprd02.prod.outlook.com (2603:10b6:5:177::43)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:51 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::67) by DM6PR02CA0066.outlook.office365.com
 (2603:10b6:5:177::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:38 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:37 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:36 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 09/47] hw/arm/xlnx-versal: usb: refactor creation
Date: Fri, 12 Sep 2025 12:00:18 +0200
Message-ID: <20250912100059.103997-10-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 923781b4-43d0-4335-fb2c-08ddf1e38882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IgdJh0ZvfIBp8Fh/GjY9dwvEBKSDCy+hijs67CFuZmiU3fKJzQEKDwWToHhF?=
 =?us-ascii?Q?23ZEi0bF1+DzTF57A5xyzQUDZemwQ7D+V0L51dR8nMRxvcwLsBrrdPmbVof2?=
 =?us-ascii?Q?nqrlF7hWmzgffmuTd0yACYEX/KIHHfESJTeAnpPAejagMjfA93lnjecoWnn6?=
 =?us-ascii?Q?CAFsSvCjWFPCVbP4FoYcE9pKz9WHf4N3dww4UfyT9+isvLz4EiBui0OitjJk?=
 =?us-ascii?Q?8i+kiHtXSrfxeg/KWNibTzmm5WKlt4vwbd9xBtyogiSeuHFyhuffeox+KlMe?=
 =?us-ascii?Q?Ahob0h6ROgj/cpEFCIliT3rjg1XrZhsZFdpZJNcHQiLX/ZhH8N8ltLg6tMJF?=
 =?us-ascii?Q?tMCU6Qj7HayjbScCe4gujpkod6ZSJL9PemXE8Zz1alHa/yN3m/zjpy630uaA?=
 =?us-ascii?Q?Fhcqpn74pKlkwrc0dETiYLSmW0u92YimEdxxjZ+g/enWJea3J1vHcPzFX2Uq?=
 =?us-ascii?Q?Mt0pATZOPw01nV0IpHeeI+FDH5YPfGP2/YzJ/p3IJwzqWjRU00el+pOk5U4s?=
 =?us-ascii?Q?3TOSEYkrYtyEQqpvU/KD8If/OJc4nvR7Zsr0QGkh7lAlaGolJqPbf+e1QcsD?=
 =?us-ascii?Q?uAH3D546PFk77MXvSayAmbvp8PWaAPvJY5GaQk1GUKuyTJs3uM/5D3X9LWS5?=
 =?us-ascii?Q?vWI31nC+CAs4u+s+mxOGTCezLPH0eSj99j17A85ddX8OYdTXjQGTgsNiBZVj?=
 =?us-ascii?Q?6HuMB9ElCyThCPfmMfSOwRiBOmHaN+7aAWfVmkfZ/AGobjFTF1g3YJ6bby4w?=
 =?us-ascii?Q?r5p67oIbRov2CiAWQXYETVyzPLWWzQgHyF7PSTjEs05ZpHVS5A18JScU5+DA?=
 =?us-ascii?Q?p1NeF34jrk3XnYlMRZu31Hgi3NCseS0F2zT9fcgHo+peaYQvHDNCumIl9az9?=
 =?us-ascii?Q?uS3QDgY/4dVFMgN7AI8QF6v2UXHSMahXIOBeIahZeshpbvDTHchYR7TMBNBh?=
 =?us-ascii?Q?iUrysaWKvxW+vmJ6pg6gntZBpvk5cadKqx9RAarZk84+cPg9MccqU8aF4ehp?=
 =?us-ascii?Q?Hsua2mBO67QFYLHtGhZzDODbiDfqfOLsaO/vS5936K5AgosKN0mfL+kHS8gm?=
 =?us-ascii?Q?FIzHoc3Cc6ul3kfQsiDJ8vgu95DXjZiaq2Tngvm05PIrhDFMqdeSL40QicKB?=
 =?us-ascii?Q?vT4UONIwhBuY+RPIjegilEJiCy2C9XKOTBkOH7iXbxyCxvHvfTsctpgVnJ0w?=
 =?us-ascii?Q?wDgwKxv6YmIMkZ0G5JkGFswWlzjPFVxALwYIfSeSPhIz2xyLjnDY1EZ4lQWx?=
 =?us-ascii?Q?jtPOh3is6cxLlPNu73WVymzJ7+TW8xXcPrDpEYFHTFlidla/vudK7TUxL8Fm?=
 =?us-ascii?Q?58M1XXppR6wSgVhyrTlLXJjp6rh+TG7udVtmw8BYin1nQwh25cXatoj6n12Z?=
 =?us-ascii?Q?6OfrsCtZpFQyRvOAs8cgEzi15CHp7HZJeyvJIgOF8lP4NBMsCElYdtvnA2ic?=
 =?us-ascii?Q?sZHkbVZJnO6ExB2uJhH8ORr3WXs97TgfDNlKyvLThiZEwZj/gioTr0mOan7X?=
 =?us-ascii?Q?WBcPIAYIchIYqq7E8/QcbQK/e+e3lCkOL2mY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:50.5818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923781b4-43d0-4335-fb2c-08ddf1e38882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
Received-SPF: permerror client-ip=2a01:111:f403:240a::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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
index 5d647a3ac0b..87b3b2c65e1 100644
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
@@ -1210,11 +1255,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
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


