Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCF3C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyrH-0001E1-JP; Wed, 16 Jul 2025 05:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrE-00017L-FH; Wed, 16 Jul 2025 05:55:24 -0400
Received: from mail-bn8nam04on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2408::61a]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrB-0006X2-LA; Wed, 16 Jul 2025 05:55:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRIl4ydFkXpwjLS5AZBdG6cdGEyVjII2KQTRuf75M7DxNcEeMqQGBz1TH5YVrWDfS7VDlIZCcCwGuR6c2aEqgops9rRe9rUIlx+/e0uRlXAvuT30SAHglgg0ZLIjROg1OyTk0kL2IOaXfLm/ozfLrL2YEria9UXK2vm5Pd18zp1ReqwIdL3Lz1s7XT032nBtN31rM1/zVbbdd6Gbi4XLCQejWr4RtfxKjlfe+d+/mU1B2Q4+VAeCPdSDnOEBtK5VaalOp/43mO3rYgcgqmhEu7R8qNzm5Y8FfHODXhE/frKRfjDYihpEy7BmViqiZPAaDPHBWWe2Lveifxjwc2PHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H97eKDoc/qlZXe6uH0kg8E4sFfksmWhqdaQ2Ff8d61c=;
 b=inKrg92fzbPuVEjnakv/hGjEBWpS5kZmBDJvo195ryNdWi0PVXjh8KxQ5Jyc6bHnzJa2W2rUgQIf796l1Epv9DgSKjulpqC/dLV4mdoGpxDodQMhudfk8BbXlmdhUPmZpuOC+2rYnxphgXAspGciLh7t0clnrEqCntPAzDUjeyfhBbrUNro3r4jZFKC+YOjlAViHIS+riUF1Of4ZozsKKHkGfhTL8rX1NyEuT2759uaN/NMnS8JLX58b4QfYtGt6iGb2Jrrf93AvyArmAdX/QwYVqIpR7o57pyOeggwpyJvHSaxq5UJQWnsVnO6bz9BFkGUU6VbpWK1HklbYsc2uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H97eKDoc/qlZXe6uH0kg8E4sFfksmWhqdaQ2Ff8d61c=;
 b=I41qlgnGaXe7c0TedEfmI0AMxibZlwLVECCPVhbu/Uy/Ikr3GiBPha3vcJ3JclLSGlb4jIjuPWf23MPoG0roCcEfzDVIDOBxHQmUyw2YsEarz0BU+7bjuW9q7+lxvPsL6nSbjpR7cBBwFKAZGDNeX84PcAUuvKHktCFc59L9InA=
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 09:55:14 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::9b) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:05 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:03 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 04/48] hw/arm/xlnx-versal: uart: refactor creation
Date: Wed, 16 Jul 2025 11:53:46 +0200
Message-ID: <20250716095432.81923-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b966e3-c4ec-427c-32bf-08ddc44edc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D6ahTvQERf8wQkTNjnATB6HDc1PbLi9PSmrPc6LAc0diFW/tKAnLU+ck0vay?=
 =?us-ascii?Q?vOL4UvYz8h3WPzQNo5jSptxfZM6tKWqABA7iPHtBinRiF+4T6KRiBBfXOoye?=
 =?us-ascii?Q?7hn9zglcI/YONULpJcoxT8HU70CSRJI/iWUKuhu0WABrRYmHVjRpwacey08F?=
 =?us-ascii?Q?al2CLW06pzYAgfdnt/vQgk8aaYWf/ruB3KiCCg0ozMNvTlWbQhNxpZybDlsS?=
 =?us-ascii?Q?Y60EiEP1vBx/J2gRC7Q6t1nZU+VSEodIAW8I4lVNi6RYzSJubnRKz5Nw30xO?=
 =?us-ascii?Q?7GZzOQ5N0QTvgFD6OHWnkuP5QJVgJuStsCnbs0NiuyYVdvAlhl5VBz+5We0S?=
 =?us-ascii?Q?JeS0vU6ymrh1GzVl9tGjraUhLfd8Kr5cczkSl5EobgYDDos4ywoaFUfIXE24?=
 =?us-ascii?Q?94kOaAMImm7b1XotqRftiwXqPpXHIcc70VfwEeL8+c9Q+gLBTFYH6dPR4QGf?=
 =?us-ascii?Q?LvIRZV7XFNjPPMW8/BSbLgwSMr0YPF2FF0Tpeimyua681E2FymjZurub2Yfl?=
 =?us-ascii?Q?i4auHIl80lnZXJZwJcp9+iL+Fa1M20obSqpGgh+pGxWrmRL4JPFqjVTCVpFz?=
 =?us-ascii?Q?uBjEwFYRku+3LD6+CuJ4kY46n3/CVtO+pwqZZd83COX9LU4fs+47a844dP53?=
 =?us-ascii?Q?nGhWhDK1qDD0P9J6NbjZKyWgocB1M3TxinqcZPGGaRPznh5clqteamtkkBiw?=
 =?us-ascii?Q?oYQPUCl7BiRyTLDGhw5hkEWWIw1GYpIckQG5BUNgQDqByMMoBJME7wbxsO70?=
 =?us-ascii?Q?Ue4gLV3zk0+NgbpXMalAi0euFjgKLsqh4RwVkomdfRYK/Ad77extYef8vtby?=
 =?us-ascii?Q?5IqsFH8VHoTN9PjGFlYSCcjpYZb+szG2MLoEE7t0x+9YgD35eQpryOnOn7Ix?=
 =?us-ascii?Q?aRg6jlucMMsqfniu6PZlRYsrxe/cuzARrGKrhHgJQh75qWgZox1RCUctikyv?=
 =?us-ascii?Q?icMIstvSe8Ncxkd3F4LNQ23JGanj5D7wAmXMz5qRTL9elNeJT1dEbAGA2wzI?=
 =?us-ascii?Q?wKPta6fu6bCbJ1Ld367DGTQUIE8jGmRcgWcUuKDbgivsEFNem5iBrBN8GWon?=
 =?us-ascii?Q?sgTmdFthgbrZPXhPRx37PxlRK14Mnnsj88o3LXZnWp/NcjV/mxw0aopKG7Wz?=
 =?us-ascii?Q?CKD8r4WABdXYXafoQJ0y21VbCqrpmEQ+mQwvH6UaCU2A4mSUni21t+GriepE?=
 =?us-ascii?Q?Zri7QvUhkmg06k7Hcp9eHuaGh9XPoh2sQjBDooQf+x2nU0oXYK7PQEyC2s+y?=
 =?us-ascii?Q?D0WT1gCCjMrOmvU831zdURrF3t0LKRSebce7ol88reH+JMYQQFovhHkcUL1Q?=
 =?us-ascii?Q?WBmrwS2PKKipnzv0akCMhWMDaZqrY1//kq4TjI4eRs+UsGAj2/7e9LoosS+6?=
 =?us-ascii?Q?gfrbU05tKsfDA7NEa4hEYCwz9So7R+bP5VxrABo4uovtdxNxMcRFt2IHjGJn?=
 =?us-ascii?Q?tcAfNsjMxy06IcAaswTJaJw09Cj7p39HJZXBB55mO3kdrb74D8ZJIi7CvEuF?=
 =?us-ascii?Q?hkWCFrTOUScTL8SXK2QnFaMB3MhFXeq7adkM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:14.2751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b966e3-c4ec-427c-32bf-08ddc44edc92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
Received-SPF: permerror client-ip=2a01:111:f403:2408::61a;
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

Refactor the UARTs creations. The VersalMap struct is now used to
describe the SoC and its peripherals. For now it contains the two UARTs
mapping information. The creation function now embeds the FDT creation
logic as well. The devices are now created dynamically using qdev_new
and (qdev|sysbus)_realize_and_unref.

This will allow to rely entirely on the VersalMap structure to create
the SoC and allow easy addition of new SoCs of the same family (like
versal2 coming with next commits).

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h |   2 -
 hw/arm/xlnx-versal-virt.c    |  36 +--------
 hw/arm/xlnx-versal.c         | 142 ++++++++++++++++++++++++++++-------
 3 files changed, 117 insertions(+), 63 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index f2a62b43552..b01ddeb1423 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -16,11 +16,10 @@
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/intc/arm_gicv3.h"
-#include "hw/char/pl011.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
@@ -78,11 +77,10 @@ struct Versal {
 
     struct {
         MemoryRegion mr_ocm;
 
         struct {
-            PL011State uart[XLNX_VERSAL_NR_UARTS];
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
             CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index c30dcca424c..7213ead466d 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -75,10 +75,11 @@ static void fdt_create(VersalVirt *s)
 
     s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
+    qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
     qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
     qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
@@ -206,44 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
     qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
     g_free(name);
 }
 
-static void fdt_add_uart_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_UART1, MM_UART0 };
-    unsigned int irqs[] = { VERSAL_UART1_IRQ_0, VERSAL_UART0_IRQ_0 };
-    const char compat[] = "arm,pl011\0arm,sbsa-uart";
-    const char clocknames[] = "uartclk\0apb_pclk";
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/uart@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop_cell(s->fdt, name, "current-speed", 115200);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible",
-                         compat, sizeof(compat));
-        qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
-
-        if (addrs[i] == MM_UART0) {
-            /* Select UART0.  */
-            qemu_fdt_setprop_string(s->fdt, "/chosen", "stdout-path", name);
-        }
-        g_free(name);
-    }
-}
-
 static void fdt_add_canfd_nodes(VersalVirt *s)
 {
     uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
     uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
     unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
@@ -700,11 +667,10 @@ static void versal_virt_init(MachineState *machine)
                              &error_abort);
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gem_nodes(s);
-    fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 7bb55751e5c..87468cbc291 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -24,18 +24,96 @@
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
+#include "hw/char/pl011.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
 #define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
+typedef struct VersalSimplePeriphMap {
+    uint64_t addr;
+    int irq;
+} VersalSimplePeriphMap;
+
+typedef struct VersalMap {
+    VersalSimplePeriphMap uart[2];
+    size_t num_uart;
+} VersalMap;
+
+static const VersalMap VERSAL_MAP = {
+    .uart[0] = { 0xff000000, 18 },
+    .uart[1] = { 0xff010000, 19 },
+    .num_uart = 2,
+};
+
+static const VersalMap *VERSION_TO_MAP[] = {
+    [VERSAL_VER_VERSAL] = &VERSAL_MAP,
+};
+
+static inline VersalVersion versal_get_version(Versal *s)
+{
+    return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
+}
+
+static inline const VersalMap *versal_get_map(Versal *s)
+{
+    return VERSION_TO_MAP[versal_get_version(s)];
+}
+
+
+static qemu_irq versal_get_irq(Versal *s, int irq_idx)
+{
+    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
+}
+
+static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
+                                      int sbd_idx, int irq_idx)
+{
+    qemu_irq irq = versal_get_irq(s, irq_idx);
+
+    if (irq == NULL) {
+        return;
+    }
+
+    sysbus_connect_irq(sbd, sbd_idx, irq);
+}
+
+static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
+                                           uint64_t at, const char *compat,
+                                           size_t compat_sz)
+{
+    char *p;
+
+    p = g_strdup_printf("%s@%" PRIx64, path, at);
+    qemu_fdt_add_subnode(s->cfg.fdt, p);
+
+    if (!strncmp(compat, "memory", compat_sz)) {
+        qemu_fdt_setprop(s->cfg.fdt, p, "device_type", compat, compat_sz);
+    } else {
+        qemu_fdt_setprop(s->cfg.fdt, p, "compatible", compat, compat_sz);
+    }
+
+    return p;
+}
+
+static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
+                                                  uint64_t addr, uint64_t len,
+                                                  const char *compat,
+                                                  size_t compat_sz)
+{
+    char *p = versal_fdt_add_subnode(s, path, addr, compat, compat_sz);
+
+    qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
+    return p;
+}
+
 static void versal_create_apu_cpus(Versal *s)
 {
     int i;
 
     object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
@@ -165,32 +243,48 @@ static void versal_create_rpu_cpus(Versal *s)
     }
 
     qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
 }
 
-static void versal_create_uarts(Versal *s, qemu_irq *pic)
+static void versal_create_uart(Versal *s,
+                               const VersalSimplePeriphMap *map,
+                               int chardev_idx)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    g_autofree char *alias;
+    const char compatible[] = "arm,pl011\0arm,sbsa-uart";
+    const char clocknames[] = "uartclk\0apb_pclk";
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
-        static const int irqs[] = { VERSAL_UART0_IRQ_0, VERSAL_UART1_IRQ_0};
-        static const uint64_t addrs[] = { MM_UART0, MM_UART1 };
-        char *name = g_strdup_printf("uart%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
+    dev = qdev_new(TYPE_PL011);
+    object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.uart[i],
-                                TYPE_PL011);
-        dev = DEVICE(&s->lpd.iou.uart[i]);
-        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
-        g_free(name);
+    node = versal_fdt_add_simple_subnode(s, "/uart", map->addr, 0x1000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "current-speed", 115200);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names", clocknames,
+                     sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop(s->cfg.fdt, node, "u-boot,dm-pre-reloc", NULL, 0);
+
+    alias = g_strdup_printf("serial%d", chardev_idx);
+    qemu_fdt_setprop_string(s->cfg.fdt, "/aliases", alias, node);
+
+    if (chardev_idx == 0) {
+        qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
     }
 }
 
 static void versal_create_canfds(Versal *s, qemu_irq *pic)
 {
@@ -781,18 +875,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
         object_property_set_link(OBJECT(&s->lpd.crl),
                                  name, OBJECT(&s->lpd.iou.adma[i]),
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
-        g_autofree gchar *name = g_strdup_printf("uart[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.uart[i]),
-                                 &error_abort);
-    }
-
     object_property_set_link(OBJECT(&s->lpd.crl),
                              "usb", OBJECT(&s->lpd.iou.usb),
                              &error_abort);
 
     sysbus_realize(sbd, &error_fatal);
@@ -955,11 +1041,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
-    versal_create_uarts(s, pic);
+
+    for (i = 0; i < map->num_uart; i++) {
+        versal_create_uart(s, &map->uart[i], i);
+    }
+
     versal_create_canfds(s, pic);
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_sds(s, pic);
-- 
2.50.0


