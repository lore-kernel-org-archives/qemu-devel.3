Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B5FCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0bC-0004wY-9r; Fri, 12 Sep 2025 06:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0b2-0004vE-C2; Fri, 12 Sep 2025 06:01:37 -0400
Received: from mail-dm6nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2409::614]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0az-00011z-FJ; Fri, 12 Sep 2025 06:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydJaweoe/+BEphOjCmRWU87HpzrVGYsONI6GQ4pEjnYToO1Jkpljv0vQkGOV/gmYrSlRXF1shGI8SsMxFI6jm8dY36DrEC0pqUH/B0zjhHBMkFRau6kpE2YKiyKWj6pxKgvWbgfWey/lHRWmaL6fw9fLuczQln06VchdhJrF98kouKltOH5UD7O+5tgCNiFWsC6CK8Ceoet+rMusyCpQ+61J6CSWSBnzcnHCfhiYJPptHzdWY2wEIIkRcxfhWNFB55TIigIPRvC569mwcTwPH+xKB2Oe9M3RfssCJ6Nich7L5fpVpNDXuZF3uSrE59yvoKjbwQhcbxBnVfaHYM6Wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZoIpJx5jRgwkLAv6q+27lEbCMjdhETtGBoZB+dYpDI=;
 b=I9CoLCQhgzF8cwK6KCPN3UN/PepZfRcINnKtAbtroGvxuFqrVHc8D4aAxqCZ2GZN2EYSR7sqlkbPqZ6aqcTqqotXXwVgDkM4hwAYXGDo5ZK+vT+mjgaB7gfnn5rH3Kz5dqrI4LDN7Dd2LS4jZggge+2TfPoQ4jMb9ZeCBdghfwMIgX7R3WRqhUlQ4Q7c2ZnAsQkBfXXkhqxj7t2Xm/qfsAslB9VLnetpf8Ww51eDUCQ6dZIpvlpZxmNpkZXhe9cmV8ADuhQX7BL9Ipxtaha5qPudRhTcJb7+tzH6mNHc4lxcozHScN203s+HQstG6xNKYpyZpuPGILL8uNiXzRfgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZoIpJx5jRgwkLAv6q+27lEbCMjdhETtGBoZB+dYpDI=;
 b=UrevOLCCY/qctZ21bDE4XJu+Cel0cHu6wzo466AZ/KTDnqGLmv6p6FYdBjiFCoAcG6B6rc8tWlNx75OQCR1N16ua9tRE042QMEljUA97UfPZbocWuyKz7DEbpUivdLq3Jerh/sGHPLFR6IeqTvgIklHDADcuhQOoII9KYAMS3+8=
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 10:01:21 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::f4) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 10:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:01:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:19 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:19 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:18 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 03/47] hw/arm/xlnx-versal: uart: refactor creation
Date: Fri, 12 Sep 2025 12:00:12 +0200
Message-ID: <20250912100059.103997-4-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abb59ca-4c0b-4969-490c-08ddf1e352df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?54pFtlyRCQZdPvQz8suEKpliknRIQgZ8uTs211R5Kg7SUFAq6DLVsMw1St/L?=
 =?us-ascii?Q?0/z29ZcIWctnAKUqyqRX+4pkMrzpl+uQxPY/lLB3qPGh7+8a9EgMA2mE3bYJ?=
 =?us-ascii?Q?yMFV5C9l9p/HkNlb5acbEDwyjiekpvyFnCgRvcfhJl45vwcfb8ImkRZkCeFk?=
 =?us-ascii?Q?ffIdsETuuGg4xUnVfhWw+ovRLBVdLhJ2vSEq6h7+51PSzpYtWAWApk/RJaWA?=
 =?us-ascii?Q?Ypy6mfhqFmr8imZ5UQp4DcODuU7qyZEOi/u1dKzFUErvQSb+6+FAWkguwYOb?=
 =?us-ascii?Q?2Z+faQCeevvSuDk0Aa9DfGkERQGdx3sXklPB8QbnXigccAjc0pMTIwD8vGW8?=
 =?us-ascii?Q?jUr7703LwvX5L9ROpNyphkRfyrGPekGBwfTTcHs7jrA3CkzBWXYVsTsOnjkz?=
 =?us-ascii?Q?h4Nt0d7liFLeYFM0adHTOKwXRtT2MUpOxG11z+XkKSk9SVEgf7Q/Q28kjgIf?=
 =?us-ascii?Q?l48hFHiMWlMGmBqCLnbBU5sS44e9Pz9NwmdupoF52dmjmjpl5BbZvIIe+o+Q?=
 =?us-ascii?Q?jIoGlz8aaoSNTP9gB0GED6SWicJwJ+sI4sVMLZBUPtf0Ei3qUyp6BFd/VK+w?=
 =?us-ascii?Q?09pAq2ffojW7dP4tEBTYHjHrr0nfOt9vqnwXKqB7E5ZfoxnPvDAlU7D74teQ?=
 =?us-ascii?Q?0Y7Yz0KTZm5ZFdsD6EfUaSBIgQ506hGiu9nFyvF+CuEUmGbcrWa5J+5zE8mL?=
 =?us-ascii?Q?uZhgRqhpteo6rh1kGtjPXwbhFqJTPKyxnK00ZG9BTbTB1e/F1vA9W/ezUCUq?=
 =?us-ascii?Q?eL/V/oUyqNaFtCdb9MvUXi2TR+p8gCLbAOSO5PQgYYQGshvEDCA4iEg4nCXI?=
 =?us-ascii?Q?T9Yw83mhVxRJf2qYqQ2tmo4NvyzrefwXSWmIrHizNYpnoaa/FUPEcs9foQno?=
 =?us-ascii?Q?0+AskN4CD87pK1DAYTvrXGFZ5ZJrO/zvGUw2iIKmWPg5RYK/VB99uvXI//WC?=
 =?us-ascii?Q?PXX0gM+Kg6ZI6KKs2vdkcz6N4A14n7G+MqnbpMHRVBhv/upMVHEmE9RpO75t?=
 =?us-ascii?Q?TdR8w+BE8W+aumlJHZrK9Pu1OysZvfSlu9w22G3S7zQKsl/N+DRimGH1NM6i?=
 =?us-ascii?Q?ZywqrWMLvUqR6ne8lnim5V3pK2kJr2T99gJhoC2Fxiv/KJpYs9TdukAMK1tv?=
 =?us-ascii?Q?Qb9Qqy5GrTi7OMf5bARXv8loxC9rnS5dmZ5MwL/IN5HZEu4yIKCDbOlBGy07?=
 =?us-ascii?Q?zL9XieqAkCpeJIdggjuRuLlMFKtqVPZArnTQT1cGyWZxSA68frT4JyyR3UsL?=
 =?us-ascii?Q?HKqWsaH0p+U2sf1Ro2rcYRO47RWxX4NjVNaZyUHm9Y+MGgikpyNrtCJGb/pD?=
 =?us-ascii?Q?Khb6tt4wJYKa6/NLxtPkzRuA7AkKcGG9HFgyutMe3xe+DYuGb22i7tujtFfH?=
 =?us-ascii?Q?WqL1Gl+s7ggCVSA00vhKT8y+DbzkN6/kJOhRSV8Ntfkt4ohqpskCummZ9Pr8?=
 =?us-ascii?Q?yAkrNTUSOqhhJzeU/xIjDlOwQotdeP6DWWlwLl23QJ7Kq289JFeb5jWsD1pI?=
 =?us-ascii?Q?XwWMFBxmaFBuXXoTYEdAZh+qKo1m8uGld5yi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:01:20.5903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abb59ca-4c0b-4969-490c-08ddf1e352df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
Received-SPF: permerror client-ip=2a01:111:f403:2409::614;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |   2 -
 hw/arm/xlnx-versal-virt.c    |  36 +--------
 hw/arm/xlnx-versal.c         | 144 ++++++++++++++++++++++++++++-------
 3 files changed, 119 insertions(+), 63 deletions(-)

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
index d1c65afa2ac..e1deae11317 100644
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
@@ -703,11 +670,10 @@ static void versal_virt_init(MachineState *machine)
     versal_set_fdt(&s->soc, s->fdt);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     fdt_add_gem_nodes(s);
-    fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index fda8fdf786a..87468cbc291 100644
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
@@ -940,10 +1026,12 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    const VersalMap *map = versal_get_map(s);
+    size_t i;
 
     if (s->cfg.fdt == NULL) {
         int fdt_size;
 
         s->cfg.fdt = create_device_tree(&fdt_size);
@@ -953,11 +1041,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.50.1


