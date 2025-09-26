Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAB9CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22Zf-0006BK-Ht; Fri, 26 Sep 2025 03:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZY-00066H-Va; Fri, 26 Sep 2025 03:08:53 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZP-0006Xc-91; Fri, 26 Sep 2025 03:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceOi9twIyqzWZJ/L9cniqOe1B6YAlMQf6r3mPSWFADy7MQ0Yrwvhto0BREqq0QDZcm1WXaHIFKZuCd2Sa8LZuTsWhBmseze4Ax+aQ0NoW/jDDAGFh9CiFjz2XvG1U6nCpoiXJT2m/jwRE3aKChgsslBHUxLcmJoW3WCw49rGMpstGmxF1+IQf5r8wRT3nQ+Vtm8KtPFMrGYJ1sjvZyYm218cJV9X2IRWOzl0H2f2p1aD1aUJjgl7vq/CvB3t19fYUVsuAg/BHZ0UwKNAFi8IUpfmFkzerwOtxHSvsgv2qWCgBY+Ebyz1gLzCklyw9EEElrw7N7INd7T5Xme4hyiG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uj5fEza2iBjoethR6YXgi/fpl6ZmLWon2S9p209SG8=;
 b=bgJ+m3kTzM9G2kJRCBUi2foWjEmWrHZ6LsoiV8AvmrTWykKXQ4jLd1YIDwhWHHQWnVed6Wl0uo5CEWVcI+NpRECXC8unJUSRTBE9xrmpP9ZpZoOxruTSbVeFKQLe5Ydh6nwj1yvSMUb3X8FvatdXtmae27vjlIEwldfghwkQlGV5oR11yjGwAA0dvGeKxc5Hj6Pc4WzEAVSj/50LexYLfUUzuOAgShdTH6u9OmLfokjfVSvUP8UuSac3k72JEsO0rpU1W2FnRxZiyqVrwT5mcBeGnzeSf4MDIaLNi05nIcOnKIWYob6dtvbpq+JOBVgcbd5WrQfEBm84nUxSFYQtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uj5fEza2iBjoethR6YXgi/fpl6ZmLWon2S9p209SG8=;
 b=jzP1y35fl0PBFSRC0o5PGMU8fGObMog1xVGvWexeJPT6R+S4Ch0ZvFWwGdz46hIVI4wv6JWL8fX9VCilmR0pMRC7JD54AkBBJqXQbhYmTOquR/Rol+g9k1I5tCWekRn7JCJURzJzYxu4NyAd9gcRCQXjy3UnyzZ4MKrgpE6+ETU=
Received: from SA0PR11CA0161.namprd11.prod.outlook.com (2603:10b6:806:1bb::16)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:08:29 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::8f) by SA0PR11CA0161.outlook.office365.com
 (2603:10b6:806:1bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Fri,
 26 Sep 2025 07:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:19 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:18 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:17 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 03/47] hw/arm/xlnx-versal: uart: refactor creation
Date: Fri, 26 Sep 2025 09:07:21 +0200
Message-ID: <20250926070806.292065-4-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: de96ab37-e8c4-4733-ce0b-08ddfccb7e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5wPZJn+aFjWLxScpx4V99VrseU2Ch1fkIUD7JTlYZ0+wvJ+8TKSxp0zqsfOV?=
 =?us-ascii?Q?87xJvVkNxMvbcR41PIbaJxVMOsZmKyrVjGY/cbizCvjqYGFEqnlJH7C5QqEk?=
 =?us-ascii?Q?Bsu/M2N5Wf4aRM8u7Rm0pdisLBE9gmO05MGglQI4NViD+Z51CyFrG4bn+Jcz?=
 =?us-ascii?Q?CWvRopBTgjlnBVeBx/ChjfQGLtWHANS2IdkCpZsXtK8r5AYuH2tC1wLxcB8N?=
 =?us-ascii?Q?/MBkDyfwvrDy431yZ9Jgd1psGQgzekdZwQ1n7K2XEvWyGMynCgZkY0nYu8Nn?=
 =?us-ascii?Q?lkJy1l5svM0M+lsVGRdaYs4uDhxtVzLbsyGHxhuwVNWSYyg/LSUVRoEi9BA9?=
 =?us-ascii?Q?OtTJodjar91RTWQD0oSkrrUiaX0RPCHZR9sCih25zOziFVb9aYQbcX9kNvR/?=
 =?us-ascii?Q?wZSHdAJ1lR9bm0ZPUpnhKCqJNWXSahB3r5MZpJ5KkREs+GnSwWkiD/I9UC1g?=
 =?us-ascii?Q?wYq4Pvz0fY9FbpZpcRKBe9fPxzrsIqykT/lLwWdR2HZRysULxH1ljNxQ/Y4Q?=
 =?us-ascii?Q?MLO7iZcEZ3Tw1gue02xlteu1kW1txyR7JUgw+n9avY68D7ypxx765Ad5p4KH?=
 =?us-ascii?Q?OmZ2zeyiIN2WQDdCrKokGfZNIT8o3zfX3Fl2s2LFkIzrTw81IJOlSzNYtrUf?=
 =?us-ascii?Q?czlC31GsX9wbaIeGdf3SQsg55YX6dJoRWpglts/z7ROMlsxpb+ULwB3LsV2V?=
 =?us-ascii?Q?UZY0rVro9LKy4TS2Lzwwje6RMk8l2s+/iOhr+F00jz5+IEBknbv3uYepW5T+?=
 =?us-ascii?Q?fapufnu2PStQID8bsnvpmZZOXoXB+nE7J1rsH/drXzcoJl87V8jcKIDHbOgS?=
 =?us-ascii?Q?JXNUnAXJoW2Zzf3KAaKnp7HzEjg2g7i5JCbmiVQBhUI3hOzcn7u9dHMXyxhV?=
 =?us-ascii?Q?VsDqKp2IiDYCAqKMc0RoArK/SvFX7ppuCOQ6xe6HSPbThIdPBA8CCWiu2TmV?=
 =?us-ascii?Q?OkUZM3vFD2dJQSkXbLFkKRPfkdZ/71V/PBk1QijQt+RWCzkJSqtRaO4hIQ7K?=
 =?us-ascii?Q?H8FNXttlX/xVTznpXuvj9fJo1DxcyAsMSMuBQ3rqjrcHglQNAwl3xfMK7pQC?=
 =?us-ascii?Q?AU0nTOl9gBmenTp574YqOpjE6HvSMsaDQ3VbgWPpB6d+vfG749C/sFJOEs/l?=
 =?us-ascii?Q?XURiaJ62P3Hje5SzspBpC/42zFZSi5ZFYIuNMSTlF4fvWSMFLZI/OrxMAMAZ?=
 =?us-ascii?Q?bWz8ZlrXutgOEB7i//UfOa18QmZL+hcUbpLnsWxF2xckHODWnYGrZPaMD/56?=
 =?us-ascii?Q?ZfDG4F8xXRh4SB61sgH3Ufdci/I0wsevtbRcERsRpU4GjsHH3B5zdL/ZY4Va?=
 =?us-ascii?Q?Itmzb4wL3iF3uHh0P3qbNKt34q8dnFhpVU4gZVdjQwEt+OeRcPuzif77qw7U?=
 =?us-ascii?Q?hxKuagXNhMszubmJ88+3mfVfFfKeCspSHvt68MEtyfKj4hIUbQ0CuEy/JvHA?=
 =?us-ascii?Q?ryQ3F21EaRiCrupdKI0zEeXN1g5RxNXYcK28DDnSW8w/KwCDsr42VQe+l8lV?=
 =?us-ascii?Q?l/ZKgaAVjoKIMdQEdgKufFvv3XaXQ++LkeDaNxrY8k8UIe4h7mDqt1MghvZf?=
 =?us-ascii?Q?SbZVZ4ZHZRABUK0GxQk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:28.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de96ab37-e8c4-4733-ce0b-08ddfccb7e9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 3b596219561..b16af79e8a9 100644
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
@@ -940,20 +1026,26 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    const VersalMap *map = versal_get_map(s);
+    size_t i;
 
     g_assert(s->cfg.fdt != NULL);
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
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
2.51.0


