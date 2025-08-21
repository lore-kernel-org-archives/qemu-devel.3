Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0023ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yT-0001bL-VZ; Thu, 21 Aug 2025 09:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yI-0001RO-AL; Thu, 21 Aug 2025 09:04:50 -0400
Received: from mail-bn1nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2407::62e]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y9-0002vh-Jh; Thu, 21 Aug 2025 09:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbnZtD62igWaCIxq2Ins7JuEDNTjG0GcZPoffG/JNoCEiaVyZwaqRegPQ5ai2vmOCqEz8X3OaNS6qAZJy7LKDJ4LpImbRC/PuJ7VcVuJprudtFHjexlLrLnO49m2rsftpTsAxBivAkhvenOqa4vQmxnwvtEhc6H4Zv3rASinF0MS1/3O+qCRRE7NuLfygE9TYES2DFJhSOErhgNXx84KRDx8o0ft4FoR8iRyDzcUbl90JVk/IZe2QWdQoX0v+hq6QtFDVB4BeHUqKyf5GtV24wMxHKlutpu50ZaFKBXOd0Gq/SApgzBoEGbZvZSiFlXHkGteYDh/k/89n4DTQaH3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NARjDdovf0Jj/KsWIMIL6ePx1JKBIgQ4PBA+V5kjzZk=;
 b=CpjtQtel9P1IqLQNgcwsXh+VzcDZtLexvWegrhVDzYQlMUh26pW0ojFZ/FhW0Kezl165kRMpKjFAjqy2rldxAxjP02pkuNoVoeQcjTUo6NoQPvHCkAN17HWBqv+gFngS+u8DOTdmLpT7FaSKShvQi8b5nXXkpPZhQfwPRWm234LrGHesVubEt8GZi4toGAXqGplaKP5DxuFtRmS6qXgGttmtDDv9BgrNjCni5a6J+gDQJGY4ryNvW1DPaRE/ir3ycfonL9DNQb86edoeDn2pb9kek6oRau2irjzzXG9KCWKel4uR2BylFm9g2WrUkuKE3ZjBeInJISg9c+1xEwULog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NARjDdovf0Jj/KsWIMIL6ePx1JKBIgQ4PBA+V5kjzZk=;
 b=ncRCGWVFc3AY8rHcZNibZ9xZqoVpP6eXGylasThGUSuOaYUZd+KitEZZccPXO9N1uwWfP8cb9RiAJNOBDMnS40y1RSkgp3e+oqgmk6W4PtwkLqoPXjCC5hjzDlenOSQhEdsfhdXFJTlDQQ51KIUx+2QmSuL/x5BS8MUifWZfY+w=
Received: from PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::9)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 21 Aug
 2025 13:04:35 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::d3) by PH8P221CA0060.outlook.office365.com
 (2603:10b6:510:349::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:28 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:27 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 14/47] hw/arm/xlnx-versal: bbram: refactor creation
Date: Thu, 21 Aug 2025 15:03:13 +0200
Message-ID: <20250821130354.125971-15-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 027ea1aa-9000-4194-a403-08dde0b34636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aAk2JB0Zw1NUvY2PlXQ2G5B/BO4iJkjzcq7Z2d8Iqgm1L6MHvHikQiyrTmot?=
 =?us-ascii?Q?PaVOgh/LvhQJRtVTqsrWFDV6obrybAnEal1GSlEowW71plXXQFIhS0Ki6tK1?=
 =?us-ascii?Q?DJo8GuNdaetoeYQvjCDjpe7xmoeF16TtUWBc6Eq57ITvIFP+Ikdh+Nn99Oq+?=
 =?us-ascii?Q?59+c8fGGxQFKyjm5FoGW25ZSSWcgBXkg0NNvDoD+vcOnKkJCTGunfy65amfc?=
 =?us-ascii?Q?3Z+BbZ7aAdHkJAFivZoptautaNV/rqxGcKwYz0E1IIgbxoBHlcsqt4L2cOim?=
 =?us-ascii?Q?C/GjEyaBICzVgZjVR86E5w6i4k0Qz7R2ap0zpiXo26ivrYsqBq4mlqIM3s9f?=
 =?us-ascii?Q?6hXt7Vb9/McKI/oNCXVOqFgKhjwsXkPFJRk6k4+aMiQMbS5599UBnQ3r724h?=
 =?us-ascii?Q?inTUt+d1UnNdwhAlJ0x8e/jESnI9Lu2oLX9E/4eLjxVHQ7aLysNUMU310eQd?=
 =?us-ascii?Q?bnHjjvq4JzvfjmbHJl0und+/gy/Pv9EZ7YMRV0EwDLPsFC0c9ha8Wmro0m4y?=
 =?us-ascii?Q?iUsbEiO4L+LOAqCmTAbMAj2YhAlJSUSBN0yJ+hwXNeJsSyX6R1n+YvGns3gg?=
 =?us-ascii?Q?w+9OkLsBG/0uj+ZHLoPS26KkYAt/EmWs8+LJ650XMkVjbML+r7iKk272CGqW?=
 =?us-ascii?Q?fXFDzRlk7ZpelnjHY3D5uX2qjsZlEl0MCCpoFyt0oi1yVVSvVixaNDds3Dq1?=
 =?us-ascii?Q?RqKxPsDLWeuMNnvS/GZT1LQSQhmtR5x++7gJvhnptUEPWb48LyGOThZnCdy4?=
 =?us-ascii?Q?VgxrKQ9C3KvVJTQLcuqrkdQu99sGwkQrHHmSp2q4e2HA41nULOSFaUHPfuEz?=
 =?us-ascii?Q?9C7z/WAQBbp+0fF91737oRgmkupI/XnQeJJGkdMgsr/qqcc5QKjydFkW6KBI?=
 =?us-ascii?Q?yPnujgrZb8ckX69jvvgtJPZ24i2VtLqiTf4unblbEtqe6uuCQ/JTffLMh4Zs?=
 =?us-ascii?Q?llCXA+IfJQOC+1VKLmZZFzPjBunItOj2Oz+UVcZF+J+U9z8Asxeo12nw3TfP?=
 =?us-ascii?Q?2yb+31BdJl6+BYA4FlxzsSl8yne2pE9VHqaNXMmR6TaaUPyFwHHv+ImDDvRN?=
 =?us-ascii?Q?Iz68M4tQJ3TBXFSljMDiaZQILvbgZaOJxgacaQIKb2TLMMyIdc5DdLHS5fGQ?=
 =?us-ascii?Q?uRPORff5NcV+JY7fXFuo70Qqa2s6nCNHCDYLpH62pHAwcW1FLpHZ+13NSvH/?=
 =?us-ascii?Q?WJ3tNNUNDTdbdbGSLcYr4mT4Hr+UGuVTR0Wo6MumQrp57WxAqgbSGuQWD3U7?=
 =?us-ascii?Q?7Dxn9gRoP1eMFvVYLAdlxA/pv11uKLrnjIsMXDXMB0M62THUDBYRWp4AjojM?=
 =?us-ascii?Q?Gh3ugV8JHV8s6oBvWvnU3dVmIwr1z4qRkJAKn6FtBGtQLu5/k7NrNgiZ8jz/?=
 =?us-ascii?Q?qva3gMhLoLHJL3h4kaw/WGUkHV2ID55Ne5WRRQqKxn/ncMogBtbOX1Birx4I?=
 =?us-ascii?Q?LlRE9Vu42YJEegltUvXr+cpFWlkOqrp+3k48zuFvf+09/y3PzUyUyXH1PRCE?=
 =?us-ascii?Q?1BPh9EYLUXOjzaI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:33.6886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027ea1aa-9000-4194-a403-08dde0b34636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
Received-SPF: permerror client-ip=2a01:111:f403:2407::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

Refactor the BBRAM device creation using the VersalMap structure.

Note that the corresponding FDT node is removed. It does not correspond
to any real node in standard Versal DTBs. No matching drivers exist for
it.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  3 +--
 hw/arm/xlnx-versal-virt.c    | 27 +++---------------------
 hw/arm/xlnx-versal.c         | 41 +++++++++++++++++++++++++-----------
 3 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 78442e6c2c5..9adce02f8a9 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -17,11 +17,10 @@
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
-#include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
@@ -83,11 +82,10 @@ struct Versal {
 
     /* The Platform Management Controller subsystem.  */
     struct {
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
-        XlnxBBRam bbram;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
         XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
         XlnxVersalCFrameBcastReg cframe_bcast;
@@ -119,10 +117,11 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
     s->cfg.fdt = fdt;
 }
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
+void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index c5dcd57d1dd..3b44d9c5c56 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -170,30 +170,10 @@ static void fdt_add_rtc_node(VersalVirt *s)
                                  2, MM_PMC_RTC, 2, MM_PMC_RTC_SIZE);
     qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
     g_free(name);
 }
 
-static void fdt_add_bbram_node(VersalVirt *s)
-{
-    const char compat[] = TYPE_XLNX_BBRAM;
-    const char interrupt_names[] = "bbram-error";
-    char *name = g_strdup_printf("/bbram@%x", MM_PMC_BBRAM_CTRL);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-
-    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_PMC_APB_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
-                     interrupt_names, sizeof(interrupt_names));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_PMC_BBRAM_CTRL,
-                                 2, MM_PMC_BBRAM_CTRL_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-    g_free(name);
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
     char **node_path;
     int n = 0;
@@ -344,19 +324,19 @@ static void create_virtio_regions(VersalVirt *s)
         qemu_fdt_setprop_string(s->fdt, name, "compatible", "virtio,mmio");
         g_free(name);
     }
 }
 
-static void bbram_attach_drive(XlnxBBRam *dev)
+static void bbram_attach_drive(VersalVirt *s)
 {
     DriveInfo *dinfo;
     BlockBackend *blk;
 
     dinfo = drive_get_by_index(IF_PFLASH, 0);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     if (blk) {
-        qdev_prop_set_drive(DEVICE(dev), "drive", blk);
+        versal_bbram_attach_drive(&s->soc, blk);
     }
 }
 
 static void efuse_attach_drive(VersalVirt *s)
 {
@@ -442,11 +422,10 @@ static void versal_virt_init(MachineState *machine)
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_rtc_node(s);
-    fdt_add_bbram_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
@@ -456,11 +435,11 @@ static void versal_virt_init(MachineState *machine)
      * modules unaware of multiple address-spaces.  */
     memory_region_add_subregion_overlap(get_system_memory(),
                                         0, &s->soc.fpd.apu.mr, 0);
 
     /* Attach bbram backend, if given */
-    bbram_attach_drive(&s->soc.pmc.bbram);
+    bbram_attach_drive(s);
 
     /* Attach efuse backend, if given */
     efuse_attach_drive(s);
 
     /* Plug SD cards */
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index d34a36e18aa..615eea54372 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -34,10 +34,11 @@
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/nvram/xlnx-bbram.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -117,10 +118,11 @@ typedef struct VersalMap {
         uint64_t dma_dst;
         int irq;
     } ospi;
 
     VersalSimplePeriphMap pmc_iou_slcr;
+    VersalSimplePeriphMap bbram;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -159,10 +161,11 @@ static const VersalMap VERSAL_MAP = {
         .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
         .irq = 124,
     },
 
     .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
+    .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -811,26 +814,25 @@ static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
 
         sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(or, i));
     }
 }
 
-static void versal_create_bbram(Versal *s, qemu_irq *pic)
+static void versal_create_bbram(Versal *s,
+                                const VersalSimplePeriphMap *map)
 {
+    DeviceState *dev;
     SysBusDevice *sbd;
 
-    object_initialize_child_with_props(OBJECT(s), "bbram", &s->pmc.bbram,
-                                       sizeof(s->pmc.bbram), TYPE_XLNX_BBRAM,
-                                       &error_fatal,
-                                       "crc-zpads", "0",
-                                       NULL);
-    sbd = SYS_BUS_DEVICE(&s->pmc.bbram);
+    dev = qdev_new(TYPE_XLNX_BBRAM);
+    sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_BBRAM_CTRL,
+    object_property_add_child(OBJECT(s), "bbram", OBJECT(dev));
+    qdev_prop_set_uint32(dev, "crc-zpads", 0);
+    sysbus_realize_and_unref(sbd, &error_abort);
+    memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 1));
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 }
 
 static void versal_create_efuse(Versal *s,
                                 const struct VersalEfuseMap *map)
 {
@@ -1323,14 +1325,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
     slcr = versal_create_pmc_iou_slcr(s, &map->pmc_iou_slcr);
 
     qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
                                 qdev_get_gpio_in_named(ospi,
                                                        "ospi-mux-sel", 0));
+
+    versal_create_bbram(s, &map->bbram);
+
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
-    versal_create_bbram(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
@@ -1372,10 +1376,23 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
     }
 
     qdev_prop_set_drive(efuse, "drive", blk);
 }
 
+void versal_bbram_attach_drive(Versal *s, BlockBackend *blk)
+{
+    DeviceState *bbram;
+
+    bbram = DEVICE(versal_get_child(s, "bbram"));
+
+    if (bbram == NULL) {
+        return;
+    }
+
+    qdev_prop_set_drive(bbram, "drive", blk);
+}
+
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk)
 {
     BusState *spi_bus;
     DeviceState *flash, *ospi;
-- 
2.50.1


