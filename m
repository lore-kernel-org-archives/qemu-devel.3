Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E15CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVu-0007jp-Nl; Fri, 22 Aug 2025 11:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVp-0007eg-1o; Fri, 22 Aug 2025 11:17:05 -0400
Received: from mail-dm6nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2413::624]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVl-00079j-5R; Fri, 22 Aug 2025 11:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sle87uWooY7riUpRB53ro+R6XVbeGg/slxkDWYDWKef9Ha6IAUEjBIWWVAeVeed3nFctLsLNUst2rf7Gp/NB0J88CNqrD4jUSCspmyF2VJ9pbK97vp85mXs9h84krOXnjWWMLHwf8pRxr98or3+5MdP2Cy07gDBOD2ALUF9zStGD3zpOXoRsG8TsVzf822dpaxjYA6I3+q9LVgDPAmTa2uuit9PeLP01HrD4y2woNlzsD8Yt59CyjLewLFuwnqcbI0Ojvsj7X9NNdc4mrUxToUKKiUmKsFe+bXT2BikJKxSbgQkj/g7eCCLg/KHhIpwIpR2TC8Ehaori2Jm7QFl6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDEuCkFislwF+i5Xl9/d1dob+XSx5NxLeUqs3AtUFy0=;
 b=DHQSVmnaMrHB4CpNZv3koaoqgo/CctN3iKsC1rlptYUZBwkc+jFfIbNFNHvrIaNJLxh3t5WybPG5ja6y+WD1ky24SUyiHjM1v0XhNlbMCUI2RMbWLMrqIjXYxAQbSu9ikZ2uhv+MsAF9Sq8f7MboNn4XtA15C50pvD8ZCo9I//qkTJEdCll006IHcllHp8Ueru5JbQZRmjuunCrIyrBE8bf5w54uOrwgP0H07DA9BqK2I8h2SSx3Wol3jxsDJiEZCXYBqS6fFnV6YPvpyFYUMo7zOrVxr1DPySw112u7GVV1NcpMJzqfHXi1BUbM/sb+pZMeqUgb2RujRFrpf4pMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDEuCkFislwF+i5Xl9/d1dob+XSx5NxLeUqs3AtUFy0=;
 b=TgqYl3LdLhIiFxeSW0AsHHwdfiEh3qPvrmCWdwLVxBwko4jMt3YNgGBjQFhD/adxKJ+T5Wh+5v9MiMj8ljLz+ey21fmeaZ/0ZDqBZEBN4fq6DM4nlWqLZusY3VpOOf5ZhLpjXjZQTts5+Y7KiaYveqLYp/2h9526q6M/FqfCX7s=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:16:54 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::47) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Fri,
 22 Aug 2025 15:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:52 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:50 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 14/47] hw/arm/xlnx-versal: bbram: refactor creation
Date: Fri, 22 Aug 2025 17:15:39 +0200
Message-ID: <20250822151614.187856-15-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b342805-708f-4b68-132b-08dde18eecf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vR82k3o3nN0gl2tksCIlPVaHPurXmsPoOBmfcVtgrgTrH+PhQnwTgvF6vFzg?=
 =?us-ascii?Q?p7T9Xy1y0SE+EtWattqZw9m4MJD7A1Zjv5HXBDR7d6jAPNp2YEF5MBflVGHu?=
 =?us-ascii?Q?ug5sChDFdBX/oloo2DnvIXxCqwtI0sEoVz2MJNNgtZeq3i3BWIvEjpNCZILM?=
 =?us-ascii?Q?3YxdNvC1JsJ/Xe6P2GXbKEyP+n2vTjcN8Mf813WaFv4rq+f0sctfNPsm9Izx?=
 =?us-ascii?Q?mDtdgU3mVmfdRBC0TY6eEkUZXh2moVZnfphP0Bs6iVNouUvo7cv/nFIUAXkO?=
 =?us-ascii?Q?DGgMqji4AZC8ob065kqI58lSU3yM62bO5XvHwm5OoP0NxDmtA15/+YJmPpUX?=
 =?us-ascii?Q?3eNWTWxcF8gyNU3d3GbNhr8a8ZWZFx7CRDYZ5vO/qGoGA2TeY3wCjuRndYxb?=
 =?us-ascii?Q?AzEzR2Mh+rq/QkN+Tzk5TSs63oWi5aCl+ZzOIQ4lXfVmdLBC3yTpDmrNjO49?=
 =?us-ascii?Q?ZpmFZApKoZwbgPpEDEfdF6CV7L2FkWwm+mzDJSgtVisSzZA5rvzlF1mWhJA+?=
 =?us-ascii?Q?Qdv9D28VjaSu9g9sIV02WFA6XYbEFAlaGGLkNjApwj7dCiS2XnwRHyxhHVZm?=
 =?us-ascii?Q?ju7jtKdyxAJUzht9zlRRQbcl0usMhcRCtDeA1ocNu/6PmCbJ4a6A91OT6Fd9?=
 =?us-ascii?Q?5t4SuCvI9Kh4E/j/NdpxsPaVsnm97cVe9xAgsmbDGbv3drRpLzXQCK3Six4t?=
 =?us-ascii?Q?tSY50t48c1mRqXU+UfDPJNPR5/0Fa0vfi5MV73u9i/PTrkiDprL2zCTsjU/e?=
 =?us-ascii?Q?qbfRT3lhvfZUDzJEfirhU3IdE7yOG3pJttYItT852c0fAp82kkTSFDhWsOSQ?=
 =?us-ascii?Q?hl3xYOy/2gPUZRD9Fibp2Jth37O1vmfGWbdxBUopDtTEXv/3cEYe0LUcFNkg?=
 =?us-ascii?Q?gm8hBnBYDbDZYACC6xLLX91O+L3ymdwj2/UZLpGAq3lhi+ZEB46Liaw2cPk4?=
 =?us-ascii?Q?QHSREkeJEqHPTd6YwqPlSIjcwsdC9gJOHhSqC+yIxN0Ef/qELQKWYG7g21Ha?=
 =?us-ascii?Q?I/t2ozIBTRDzMi7mds6W2Jadmh7XgyPfHRGsxmWIkDyj5s+KodpYu7s7yJVb?=
 =?us-ascii?Q?slo5iHE2TxDZZH3TKeNr5DlssBEHKcZiP2lkIJyKCbMYnSn/Cr1W3DKh2Yet?=
 =?us-ascii?Q?qX2n8nwQFzHcO7cj+zbdTy6x5BDMMyE+6ll+szdFGhY5IcKIY8ORdP0Vadcq?=
 =?us-ascii?Q?5re3YTM4UeG2wb/IR6GzXNs+P5xq0u+khXFZDkV0qE5OAwW2nwqSsxH8kojw?=
 =?us-ascii?Q?gGUAKH1uFn9IWZwDmLWhPNaX1tU8+Is0Yq8k8jqnllRefSw9aAkoJ9INkUX4?=
 =?us-ascii?Q?QgNJKY0o3ugYznNBL8eOONiGMAK3HPwFccmrUC+WPGucvm0RJACMjkoCQGca?=
 =?us-ascii?Q?k4uiBp11u+mIwEwYNYoQJZB+EI2+x0akk4YH/hotVD+Q5AO09WAvAU5LjeOE?=
 =?us-ascii?Q?c9eYRvGsdqR0qkYpseMKUe8n6W7vQAeGy0YNe3Y5u4hlbfLvCzdT4Mg0c3C2?=
 =?us-ascii?Q?c1N6ePXUAUhnKbOmtyH4WCaGjybf/ZIlVkCy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:53.2748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b342805-708f-4b68-132b-08dde18eecf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
Received-SPF: permerror client-ip=2a01:111:f403:2413::624;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
index a948e24aea0..f766a3e1027 100644
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
@@ -445,22 +425,21 @@ static void versal_virt_init(MachineState *machine)
     create_virtio_regions(s);
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_rtc_node(s);
-    fdt_add_bbram_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     /* Make the APU cpu address space visible to virtio and other
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
index 5750a112637..9a9c21f782a 100644
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
@@ -818,26 +821,25 @@ static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
 
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
@@ -1336,14 +1338,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
 
@@ -1385,10 +1389,23 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
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


