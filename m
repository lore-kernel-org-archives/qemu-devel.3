Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7CECA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yO-0001Ul-48; Thu, 21 Aug 2025 09:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yH-0001R2-Ln; Thu, 21 Aug 2025 09:04:49 -0400
Received: from mail-mw2nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2412::618]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y7-0002un-Sv; Thu, 21 Aug 2025 09:04:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNMmDWmAIvYMTmmTpBi27N26sXp6d79PQiTkgMOEDftOLIMAtZVHl+OB9d9tgj+0sXsea6TnmkEvSMjYWUEoAPzsQU874mwBxPYtaos2BEZdLkX25Z1ys+G0MSrGXU3/RN1QBzxJ4iGuXMvOJCtukIaig6aXUeijvgBA86YkkeuonLBP+iAgktTMMON985vQ/uhWLDsRmklfPhT0luWimbOHg84H3cwb1xZP+N+k6ObRB3bMI3kcPCioRCcif3tUDaAkvwrln3frCCkqPu13qr2uIoADZHJjwEu/o11AROWreU0Ut7VxtFdOpIODKCzCOCjQGWq8neYBtiZH7sS3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQUVuSMCimkWeSzSIIVhontBUqAnE4ykxxAfLrMegBM=;
 b=BgRxQ4RAhtnE4ghVsAecIYEPv/qNSMUS8ruE1NB0ATNMJG0mkgZM1Aum4h/jAYLtTGRaERb1L4J/rCVK0ei08wIp1CBUVq6X8ISsnOSRwyezqZqW7OOFRKzVJPX7H5JnvjaN/gd3CcicQE6XMxzMOxAH+NpojCrwFJY2HZtC+qoFmz0Hzvr/iVKGY47N9wLFFgQjff/gr9cwAFwmK0Q5naXP84C7nIuthlelAbVDRsSONYgrsCxRhHMsy+UiRgNQuEmeIE2ESQm+qAYkQgP04QxtZQUOKfRlKDQfGa0KYhoWyumrBeySBfsL8Mp1HgsyS2PRf1Kc2vT+Odlgwdxd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQUVuSMCimkWeSzSIIVhontBUqAnE4ykxxAfLrMegBM=;
 b=VTkBenCWJJxwI7bTWC0ItTHHmeDqfehzh44QFwvFiVVoL/uz8ZfBc3roudRXDpw34FB/EdXiDIRRPH/eY4HEbPG1ILppQb9pBLToPfuuLTKdYW0xO4Q+Xqfi9r7lt1RuXOQwD9DMLu4iZZ6VJK4yMwXOkF4ZVn+YN5hCk3aHTnY=
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 13:04:32 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::b7) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:21 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:19 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 10/47] hw/arm/xlnx-versal: efuse: refactor creation
Date: Thu, 21 Aug 2025 15:03:09 +0200
Message-ID: <20250821130354.125971-11-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: d56a911c-4458-4700-0255-08dde0b344a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Di6acq3NZL2Azqb3zauijmIh4yXihrxUxED7TZ0QX7NPVwq/bi+FYMp6nWv0?=
 =?us-ascii?Q?bELX3l7ZsRN5oAdsWLNljaZW55dkwr62RKfaG+aRH6iHTydqbfbZX4q+hM7P?=
 =?us-ascii?Q?AgwLCMSL/FsooiVec4QkBAYkUcvfbj556Gai1BOprG8w8rXVAI2lU5tSwoz+?=
 =?us-ascii?Q?BH/ANnaX8CbJmu46aunEqyVpprV60DO/r9p2DBUY1DRfd48tB6hJaFBgFMM8?=
 =?us-ascii?Q?bhctdQLL3h86Yh94ZoCfPJiPA62s8m4V7ZRzBJygTFLdgaErEolIJqXGDWh4?=
 =?us-ascii?Q?8KxcMBWJxITLY3+bLePmroSr3+nku9GLaMiMUDufg8hd9QD1PMV0AgvZckzV?=
 =?us-ascii?Q?iirl5meWYxqpcwiWIb1bCfBU4qq6dSHEhNtmMiG+q6B39GYcH9LP03G5mFNv?=
 =?us-ascii?Q?gDDmku0b38Nu7ygeAeoOL/oAsatEvl/vYZi9MYn1rY4vocwxtcxlnyhu+NJM?=
 =?us-ascii?Q?+5+wc1zUBzk1di/zcvy+QnuAyuUgrQ6TdFyZaECCGmyXX3ersubHPHaBNP87?=
 =?us-ascii?Q?Ht0y9E7tx9GDxXfNIeR1Fflj4KLY4JlATmx90bmye/6v5CFitEJXk8IWUPo2?=
 =?us-ascii?Q?Uab64MRjE9MnbWrfNpknSHyo/NvKVY4ym3U2z9xspd/yHDmtodGRMqUJa+X5?=
 =?us-ascii?Q?TUf3305zcuuhSNeVdE9IdoGaJ478x85kHhgazTI0ZNZBsc9s8CYpcD+041Jn?=
 =?us-ascii?Q?xzneM8t2k8t+Ts8bUZoe61s74zaOqisfeNZHk9mdymNmDuAJiiStGmFB/n1/?=
 =?us-ascii?Q?LHFSh+fmA2NDgkI0egy+hAFDHNM5T2S7eWn214SHtskKhblDjGkWh3U1LiIo?=
 =?us-ascii?Q?Wox1ySPnySi6v4c0uKyFneLxiW0LjdgNzzgYonvxgIwCK2xvOG0fXp1YkWml?=
 =?us-ascii?Q?tPe8hNfOcPH+v34mmGfZQd1krLDrzO/01hb0d9r9Cl5G7/UvtaPNtI+2WbY4?=
 =?us-ascii?Q?DZBdbI9gmhUSuoNU7gy7HbyB4QfKsAtfiALDTmBhjaFCuGrarM8aLdriWqqg?=
 =?us-ascii?Q?Kd2ALS1CKh6DUxFt1nCP730uu8hQmozAA7JL12tGBwBIeweTfczEweQP2h8I?=
 =?us-ascii?Q?cQIovIXSNms0Dj6iO9BffyTpqE7/4Dj+79AVhgy81aH1VDYe5wYBzd892iD8?=
 =?us-ascii?Q?DBxFk/sgX07eLIv2u6viUnKhDMM3EZ9RKnQYiYxdCqES68RK6sh6J9a40LFV?=
 =?us-ascii?Q?YoKwkEytAIzIr4Gzf30FrKcQD3I7XAfu3/tYJHoa9P1D7mfA/4OkTnCQOG2X?=
 =?us-ascii?Q?NLaJRNmP0L2WxlVK0eX1069JQAcvoRSFwhDhetRQhrlzu5I63Ftc7YhBwCG5?=
 =?us-ascii?Q?ewMvDN5LCsDUFWegxh8PrmZxYQNfzgd5kIb2NayLrD1o0LbBQfCP+Otle2vO?=
 =?us-ascii?Q?ZeEfb7BQ9Y+sz1q0gFL0PpFZjJv0ouv9/IIzl8TOzUgjy1AbcD+zigSn8Ku1?=
 =?us-ascii?Q?MgJPqaPyQjCeB6c4J11z0hAZnNoplGbnEoIZRcUZB7aDgp0YnQ6GXFQKnsme?=
 =?us-ascii?Q?2O7Nlb3xyCosrUQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:31.0311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a911c-4458-4700-0255-08dde0b344a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
Received-SPF: permerror client-ip=2a01:111:f403:2412::618;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
index cf5e297fef7..f8e9a269b50 100644
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
@@ -478,12 +443,10 @@ static void versal_virt_init(MachineState *machine)
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
-    fdt_add_efuse_ctrl_node(s);
-    fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
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
index 4e4df0851e8..ed202b0fcda 100644
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
@@ -744,46 +753,45 @@ static void versal_create_bbram(Versal *s, qemu_irq *pic)
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
@@ -1247,15 +1255,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
@@ -1286,10 +1295,23 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
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


