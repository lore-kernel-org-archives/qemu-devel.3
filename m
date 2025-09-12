Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E65CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cc-0006UZ-3i; Fri, 12 Sep 2025 06:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cW-0006EB-PM; Fri, 12 Sep 2025 06:03:08 -0400
Received: from mail-bn8nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2408::614]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cQ-0001JX-A5; Fri, 12 Sep 2025 06:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPNcSeQp9sImkJ80Q5OzmsbOOAb5wTg+m/DZEvTHEzuTXUQ6EA++OWFu0F9J0vSsJ8oUwztWsT32iRnEvsgpmSTcHijrHpvmwEIF8yZsUVEcP2ywcViDjJ2e3QC2v01UcuzcxK68aF2LKd3M0ZRi6YgunGR9V8Jp84UvAwmFpRrVxQJCR73a1ek0FYTjmVJ1PvydKiHy8YVmPwwVZ1aoXAh8o/ll+aSA9FB2QOjdGQv4vbYUaJgK9tmCvD8cY9w60rKFilsElUA/J+vxG59weCwHCbHOqj8ccjtRtkxf7JaAazRa06Rgr2KusFo2s40hYzqsOfWKKXFOTYJQV3Ft9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjIu0vE3Wcf6QlDdxHGByC93Du0elAvHoKX7gHVczlI=;
 b=hXTKYguzvfyMgq3xtIZPs/UbFWwwuU47IgRQv4BbBVJjXlC4u4+tLXMFiSA0sGIAvRt233m9ooQW3qKQxCHjqKgkIrlSdRmAmF4dW25DEJAbh8jm0MSp9QscddDOVtrI397zM//MnV3XHy7ONMY4196xL9wvjuyhDTUDr2uLJLYkCaQB5vnxk2jPWBf+ynobHXGnKeOUSOKv/rDoiiJhrTYs2F+bYX73He/CDHFDZZpxPSe1k05kier0olzY10WsD3sKrrR6NomuratKFDKCvCtwy+Ea4NiiSaxj9bRHreHRN6vOhtncTB3wHpnQE6m80XPRgXSsjEcLpXm4onJ3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjIu0vE3Wcf6QlDdxHGByC93Du0elAvHoKX7gHVczlI=;
 b=PiJhm+JResaiC0aXf2y6q8UJku4gzUM5UfFyIWl92s5KunmbrVEaaTQiKkvtwmOU5ZqEV+qHxP3ycdcxTd2aCYGAwb+RISH7yt57zC/x3WmYQqmH+vIaW1EI/WCu71JsFtZdjB9oVaJ/sTgcFwnlzJhRR65vIbHrTTpRY11bor4=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:51 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::89) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Fri,
 12 Sep 2025 10:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:40 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:39 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:38 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 10/47] hw/arm/xlnx-versal: efuse: refactor creation
Date: Fri, 12 Sep 2025 12:00:19 +0200
Message-ID: <20250912100059.103997-11-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c6572f-ed62-4d77-139b-08ddf1e388de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xb+svQdG1fwDGV+2cfECnIOX8xxzLG0AvYd5e0UBbuXaEST69ZapIObh8ZTq?=
 =?us-ascii?Q?3Mv2SaBfdbKqm9U+QJWRWBuz5Y7UdslJnJds/sV5fb93qlVA0uPKGXBP+ega?=
 =?us-ascii?Q?Ixcgceqz3xgzA3ceP0kZTFlaCE5OERXobyWGWwlZwZAyvvi4VizXwuqAx04e?=
 =?us-ascii?Q?QO3Bq0sbh2n1/2cbaYkBIUvmVCh8bykYP4CmQgDVxypOstkNfb2W9awOh71r?=
 =?us-ascii?Q?W/xZr2wPa285vrwWNo3tINecvZTpDx/o5nFw/rDPEz7NPY2/P9tH+8TYPn8J?=
 =?us-ascii?Q?kutIz6q5ANDfbubarD4eT3lzvVekPFh4IgC0lG5I0RX/Va9ihDtdq76X4jRJ?=
 =?us-ascii?Q?QEB1mOEtKu+4laWvNLmBz69vYTNw/c60kzGxAUGE+RjL1qqW9LR6+QKJ7tmi?=
 =?us-ascii?Q?SsXI1bZFhS5/IBSLK6rDgcH2K93Vt5JRBMVWfoACqsfIjuUIiCRvmmWiDVVA?=
 =?us-ascii?Q?ax8vh8TYajbr6T76wZo2jzw9sVuLfKQ+kUCUcfDkEQgiBRgx7WLAnJtaH6xN?=
 =?us-ascii?Q?L/PAlmvDZ41OYfV0V5MBIQH5A5MzME56egTnw0SiYc0ZMnLMlNtlUvXllfpR?=
 =?us-ascii?Q?kY5yG+UvmbEIUOfrSD+pXT1WevKhl6O+NuyK1e19QrqIrCLatpypBG9Ttk3p?=
 =?us-ascii?Q?wukQX2bW9jPei8//KgUkH0/eujf3SFf1ai3m+eqq2WiaNnwIZ9SGqT2uvHjf?=
 =?us-ascii?Q?E/tBaGTkJtwIkiefat5Nr8XGrZs1aOjaoX4on3fJ2hNDMyJqFHFj8BtsoyCU?=
 =?us-ascii?Q?1cCuuGu11fLHfiYunVZXqNL2VaLS6oL2dG1M0yqij+QpPeRAUwHIDRft7y1F?=
 =?us-ascii?Q?2N2r3Y5En0zacQv7OY8I9UTbWYrfEdnliU+FcSBcbKwF2ikuhV0U/JC3Hvnb?=
 =?us-ascii?Q?NJ2G17ARBIJJZmIk1JfdbcP6bOddd4v/qfhjQvPHMORc1049mgkrpoDn5tUI?=
 =?us-ascii?Q?sVhhFzsrRnbTgaFJTBWPZxhuSDTNFLTZGEl69aPfLX83pGBzPzouHPn6MCJ6?=
 =?us-ascii?Q?IBMALLdXuujO2iDWUIlxctWOZcoD0Do1MViAWDQ1r8I1maS64qt18Z5czHjr?=
 =?us-ascii?Q?rloJxHDge2MWN+0jnw6TQn9RQH3SEj9pScVSnTm6cw7WGIS3hGOtrsJdo3ae?=
 =?us-ascii?Q?0DnrDjtsXdxooIIjr0++Az/rh2BuFYMHqNkgAKyCwgpbCxVpeII1Tipt8D1B?=
 =?us-ascii?Q?DTijcBuFgxI+qg4SKB5LXI5FhHvsbp7ND6Q0mhDx8YBPlhxdXBh2raO2r7mQ?=
 =?us-ascii?Q?blKejOfzP1ohjRw2utRZcC5dYvLMQq+kPvetImETeVsbBbumCFYKt9Aqh0ZP?=
 =?us-ascii?Q?lDNPD0hOk1o61e4i+sjDrIWpwVaCA6NVqsE0TcdmwLHqOr5det4jhvz5hEu3?=
 =?us-ascii?Q?ZVpMdllhbsEM7rsoMAnZqIYNJseSJCmctNzWYKnWZ+RfOH3y9jSu5oq5CBJH?=
 =?us-ascii?Q?NmVfXRKi+Dq+vi1cIFh6tyl6E7Tqy72TIQTjStcSRNQFWm3JSBagU0yC2IKZ?=
 =?us-ascii?Q?1wWGUxxd4m/ELesdQpDkK0TNkXtPoG7Smfhu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:51.1802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c6572f-ed62-4d77-139b-08ddf1e388de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
Received-SPF: permerror client-ip=2a01:111:f403:2408::614;
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

Refactore the eFuse devices creation using the VersalMap structure.

Note that the corresponding FDT nodes are removed. They do not
correspond to any real node in standard Versal DTBs. No matching drivers
exist for them.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  5 +--
 hw/arm/xlnx-versal-virt.c    | 43 ++------------------
 hw/arm/xlnx-versal.c         | 78 +++++++++++++++++++++++-------------
 3 files changed, 54 insertions(+), 72 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 5d4b30f0ff9..79ca9b13321 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -18,11 +18,10 @@
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/nvram/xlnx-bbram.h"
-#include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
@@ -100,13 +99,10 @@ struct Versal {
         } iou;
 
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
         XlnxBBRam bbram;
-        XlnxEFuse efuse;
-        XlnxVersalEFuseCtrl efuse_ctrl;
-        XlnxVersalEFuseCache efuse_cache;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
         XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
         XlnxVersalCFrameBcastReg cframe_bcast;
@@ -137,10 +133,11 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
+void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 5801598da7c..b6c49dafe09 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -190,45 +190,10 @@ static void fdt_add_bbram_node(VersalVirt *s)
                                  2, MM_PMC_BBRAM_CTRL_SIZE);
     qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
     g_free(name);
 }
 
-static void fdt_add_efuse_ctrl_node(VersalVirt *s)
-{
-    const char compat[] = TYPE_XLNX_VERSAL_EFUSE_CTRL;
-    const char interrupt_names[] = "pmc_efuse";
-    char *name = g_strdup_printf("/pmc_efuse@%x", MM_PMC_EFUSE_CTRL);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-
-    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_EFUSE_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
-                     interrupt_names, sizeof(interrupt_names));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_PMC_EFUSE_CTRL,
-                                 2, MM_PMC_EFUSE_CTRL_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-    g_free(name);
-}
-
-static void fdt_add_efuse_cache_node(VersalVirt *s)
-{
-    const char compat[] = TYPE_XLNX_VERSAL_EFUSE_CACHE;
-    char *name = g_strdup_printf("/xlnx_pmc_efuse_cache@%x",
-                                 MM_PMC_EFUSE_CACHE);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_PMC_EFUSE_CACHE,
-                                 2, MM_PMC_EFUSE_CACHE_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-    g_free(name);
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
     char **node_path;
     int n = 0;
@@ -391,19 +356,19 @@ static void bbram_attach_drive(XlnxBBRam *dev)
     if (blk) {
         qdev_prop_set_drive(DEVICE(dev), "drive", blk);
     }
 }
 
-static void efuse_attach_drive(XlnxEFuse *dev)
+static void efuse_attach_drive(VersalVirt *s)
 {
     DriveInfo *dinfo;
     BlockBackend *blk;
 
     dinfo = drive_get_by_index(IF_PFLASH, 1);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     if (blk) {
-        qdev_prop_set_drive(DEVICE(dev), "drive", blk);
+        versal_efuse_attach_drive(&s->soc, blk);
     }
 }
 
 static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
 {
@@ -481,12 +446,10 @@ static void versal_virt_init(MachineState *machine)
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
-    fdt_add_efuse_ctrl_node(s);
-    fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     /* Make the APU cpu address space visible to virtio and other
@@ -496,11 +459,11 @@ static void versal_virt_init(MachineState *machine)
 
     /* Attach bbram backend, if given */
     bbram_attach_drive(&s->soc.pmc.bbram);
 
     /* Attach efuse backend, if given */
-    efuse_attach_drive(&s->soc.pmc.efuse);
+    efuse_attach_drive(s);
 
     /* Plug SD cards */
     for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
         sd_plug_card(s, i, drive_get(IF_SD, 0, i));
     }
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 87b3b2c65e1..7aaa8dda077 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -31,10 +31,11 @@
 #include "hw/sd/sdhci.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
+#include "hw/nvram/xlnx-versal-efuse.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -86,10 +87,16 @@ typedef struct VersalMap {
         uint64_t xhci;
         uint64_t ctrl;
         int irq;
     } usb[2];
     size_t num_usb;
+
+    struct VersalEfuseMap {
+        uint64_t ctrl;
+        uint64_t cache;
+        int irq;
+    } efuse;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -117,10 +124,12 @@ static const VersalMap VERSAL_MAP = {
         .irq = 79,
     },
 
     .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
     .num_usb = 1,
+
+    .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 139 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -750,46 +759,45 @@ static void versal_create_bbram(Versal *s, qemu_irq *pic)
                                 sysbus_mmio_get_region(sbd, 0));
     sysbus_connect_irq(sbd, 0,
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 1));
 }
 
-static void versal_realize_efuse_part(Versal *s, Object *dev, hwaddr base)
+static void versal_create_efuse(Versal *s,
+                                const struct VersalEfuseMap *map)
 {
-    SysBusDevice *part = SYS_BUS_DEVICE(dev);
+    DeviceState *bits;
+    DeviceState *ctrl;
+    DeviceState *cache;
 
-    object_property_set_link(OBJECT(part), "efuse",
-                             OBJECT(&s->pmc.efuse), &error_abort);
+    ctrl = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CTRL);
+    cache = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CACHE);
+    bits = qdev_new(TYPE_XLNX_EFUSE);
 
-    sysbus_realize(part, &error_abort);
-    memory_region_add_subregion(&s->mr_ps, base,
-                                sysbus_mmio_get_region(part, 0));
-}
+    qdev_prop_set_uint32(bits, "efuse-nr", 3);
+    qdev_prop_set_uint32(bits, "efuse-size", 8192);
 
-static void versal_create_efuse(Versal *s, qemu_irq *pic)
-{
-    Object *bits = OBJECT(&s->pmc.efuse);
-    Object *ctrl = OBJECT(&s->pmc.efuse_ctrl);
-    Object *cache = OBJECT(&s->pmc.efuse_cache);
+    object_property_add_child(OBJECT(s), "efuse", OBJECT(bits));
+    qdev_realize_and_unref(bits, NULL, &error_abort);
 
-    object_initialize_child(OBJECT(s), "efuse-ctrl", &s->pmc.efuse_ctrl,
-                            TYPE_XLNX_VERSAL_EFUSE_CTRL);
+    object_property_set_link(OBJECT(ctrl), "efuse", OBJECT(bits), &error_abort);
 
-    object_initialize_child(OBJECT(s), "efuse-cache", &s->pmc.efuse_cache,
-                            TYPE_XLNX_VERSAL_EFUSE_CACHE);
+    object_property_set_link(OBJECT(cache), "efuse", OBJECT(bits),
+                             &error_abort);
 
-    object_initialize_child_with_props(ctrl, "xlnx-efuse@0", bits,
-                                       sizeof(s->pmc.efuse),
-                                       TYPE_XLNX_EFUSE, &error_abort,
-                                       "efuse-nr", "3",
-                                       "efuse-size", "8192",
-                                       NULL);
+    object_property_add_child(OBJECT(s), "efuse-cache", OBJECT(cache));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(cache), &error_abort);
 
-    qdev_realize(DEVICE(bits), NULL, &error_abort);
-    versal_realize_efuse_part(s, ctrl, MM_PMC_EFUSE_CTRL);
-    versal_realize_efuse_part(s, cache, MM_PMC_EFUSE_CACHE);
+    object_property_add_child(OBJECT(s), "efuse-ctrl", OBJECT(ctrl));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ctrl), &error_abort);
 
-    sysbus_connect_irq(SYS_BUS_DEVICE(ctrl), 0, pic[VERSAL_EFUSE_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->ctrl,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ctrl),
+                                                       0));
+    memory_region_add_subregion(&s->mr_ps, map->cache,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(cache),
+                                                       0));
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(ctrl), 0, map->irq);
 }
 
 static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
 {
     SysBusDevice *sbd;
@@ -1259,15 +1267,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_usb; i++) {
         versal_create_usb(s, &map->usb[i]);
     }
 
+    versal_create_efuse(s, &map->efuse);
+
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
-    versal_create_efuse(s, pic);
     versal_create_pmc_iou_slcr(s, pic);
     versal_create_ospi(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
@@ -1298,10 +1307,23 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
     qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
     qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
                            &error_fatal);
 }
 
+void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
+{
+    DeviceState *efuse;
+
+    efuse = DEVICE(versal_get_child(s, "efuse"));
+
+    if (efuse == NULL) {
+        return;
+    }
+
+    qdev_prop_set_drive(efuse, "drive", blk);
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
-- 
2.50.1


