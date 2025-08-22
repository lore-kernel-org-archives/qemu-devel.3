Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E315CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVs-0007hW-To; Fri, 22 Aug 2025 11:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVp-0007f3-Nj; Fri, 22 Aug 2025 11:17:05 -0400
Received: from mail-bn8nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2414::621]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVh-00078a-2h; Fri, 22 Aug 2025 11:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToOWjxD3PnjMbVMxg6qN6d9PBnXr/wP2BY5KoW2oQ/In4rLT/NeRsr0AFnhbydZc8jWePMznb6txU6of3j+QcsrGc/Lb2LwQ+cZ96FuwX7Mbn7rZp9xNvq9FrLNG5dWdD7+T0lcsYa+7BmRFy3qyk8WCLXe7G8PKiEKD1ppCp5CyastkQ75nL8YRE/Hc1NsgYFtYfFKuU/s4fpeXeS2l/+MRUp/ADa/R4BRJRmoMK0u+oAREVvBeMrntjBlrtsfArZV5aB2Fpzp66qJnvtX3SAjpcjcv9RvnegCOxyqXRody/a1mBGcgx5gQ8DidKWp/4XbrKvDVd9NMRx8CDfwzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA8SOYvU3KLHKjSKrHi3IHHUpS/Ek0+Owrp7Ent7FSI=;
 b=W0MElhZsx/gqyeVZ0D2Q1V74wusL+kZ4V4CV/RKE2n42mvFB4I/O7dTxLFvnfBMqbrqKj/VvpMliLIoc4nf6Ojsjk3bBpxeRTGtWCezDD8qbcoAKGAyXz0rQE5Q8YAvuYfL5dVDLIsZwf5lhlpgxIQdWBL947vFaPYdCG61Lrj5XHxxGQLFDhACLX93PTc3HwSYHSMKDpKF0fwujw1mJcM9fxJcOYS43eD0C5Cgz+8eBpZOdu6zsdoXFj4GgM2iTCGOvJQMu5yw69ZjNb66TElX90ZaApS75+ZoqP4ADsmsZ2ODCPAToFWL21rVxMZRkvo1i5HmCZJFfs0Tlqg0Bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA8SOYvU3KLHKjSKrHi3IHHUpS/Ek0+Owrp7Ent7FSI=;
 b=XIiVClwOzeXNWBlnelApufMlE8N6f42l1OrMY4A7HBr89kuYwRsi/xTNdVNH83LU+oIY/Y+Uvc3uhB4HymTsKQ35rjPfY/MIrfmQSNN2Rk44i2sIR+nNF8siGduyxUg+h8tdu6mPIi5qDtDj12DZiiT3MDo3ngHLlscTtcMtOKQ=
Received: from DM6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:5:1f4::33)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:16:46 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::a3) by DM6PR02CA0092.outlook.office365.com
 (2603:10b6:5:1f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 15:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:44 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:42 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 10/47] hw/arm/xlnx-versal: efuse: refactor creation
Date: Fri, 22 Aug 2025 17:15:35 +0200
Message-ID: <20250822151614.187856-11-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd2dba7-dc67-4f24-e50b-08dde18ee821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C4EiqOYRaJDfN5jVJuogyHRIODYFbnFno3lt7Eg1Cvht3kFbAvI2akOklcfT?=
 =?us-ascii?Q?f0ZR15jun8pzM77NC7uaO35LaletwskA0wTPtXhurIW53xn/MF0+1l+HNTzA?=
 =?us-ascii?Q?AOwaR18lGKygF2quNu62X/kvUgWij09MMdFgpe4HLpfwN2GiQkeAw2oNNtl0?=
 =?us-ascii?Q?G7o9Xo6SgSmhoGt0dj9aHwYLCuH4jyu2BNfbecPtAQXEeGyaLju5lDF4oFIp?=
 =?us-ascii?Q?5T1RgCSKBbx2eVOrHWGmu1FplIoi/j2wyMK4V7Voz0IMDmXeQhVokS976WuS?=
 =?us-ascii?Q?xeIUsCumPfOx9g7PvsbvqIVRyjc2e7dsdWEwLr+lY68c6u7FZ2qGWygYVYsU?=
 =?us-ascii?Q?7Jq6TMeJwF2HMPxYuZhNA7oeNcjw9Z9Pnee+HU3qUUYCCQBElOiFhGGrMMY8?=
 =?us-ascii?Q?FZgPBBPD8gcJqQELfWHT72SjN8yoyCkRy7LJnuZRbjBLRvQJ/jHgpKw9b+Zj?=
 =?us-ascii?Q?Y9Ls3FwS0rISkzX57oNXpiKuIF9xotI2vrrV5VCz52Eu+tIBkT01CCybymrJ?=
 =?us-ascii?Q?9lJr02J3wVgB0Dn4i+7ajp4Osy/4kxETv4ko7zxnI6kCSzA7lHszFPc2wL/F?=
 =?us-ascii?Q?5Kt2DHCV+Zapf5Q7hNLvFlA6SYuJcJEczofjSkxFRNzFYld61m3qWO1lFIM2?=
 =?us-ascii?Q?N8V4UpOrhggkzExG5nivSOLM4voNlDg+FCwPEHFtVXFXDdArjJTXuWNeNQpn?=
 =?us-ascii?Q?QEQmhS5wiXyZkTX9YTuuXgtdNweIp7TKZbEjRJgm3gm5XbCqB4tYKTi25ZQZ?=
 =?us-ascii?Q?6fa3z0jqZe8m1RsAsxs89Oyg+C+8At9rC2Gc+TKLPYILICPvczS8uE8hiwYW?=
 =?us-ascii?Q?bzmQkVYRvAh39cv5mrZiSt9zSZ5nSw6cZPocS5vsQGSiLfMmo911HsFDemTn?=
 =?us-ascii?Q?uKO/gOGc4bUCDr5OsRwye9OYpJjJSCrlVkuZe+8BhIy0Cp5uC2K1v4+xHQva?=
 =?us-ascii?Q?+2jbwNkLRhKxJCgzaziG1hu9q/h0slKlEOK8nXAXZDR2SY9JEMo3slfR8bms?=
 =?us-ascii?Q?tojdZckDtRfFkmCK953W5aTgSSmnNpvSMxKiX3kfmfNSF7OgF6iSTOiJYmGm?=
 =?us-ascii?Q?VihGD51DOlIUcF+sh3bGudhBB2/ycTuYM/BERzAZEXxGaSk3a9amSh/dgLSe?=
 =?us-ascii?Q?vwO/VRprbp1ldqQxjB6VGE/mDXTzNBi8EqsS9y/YAOKHFvSGylB3+3paVXS2?=
 =?us-ascii?Q?64tvYfe5sju2MqByqd0rz72yrOZXFpM2lgTf7u0Fq+2X964QrPnD9DFY+g57?=
 =?us-ascii?Q?PeH+UAUqREEuVx1pHPMZUCsdO9MYWpvYLX3u1kIxaO3djJKFPhBvibAL5cyY?=
 =?us-ascii?Q?5P0fT+ubT5QRbm0J+oOfeYkkY745wea9gO2GWwEkH/YHLhAozTN22S3mqZbU?=
 =?us-ascii?Q?7/nyi1rO3g1+qlg5VWRpSKiftfazvKevUOWrGFZox6gQN6UW0/3IKS1iCdQG?=
 =?us-ascii?Q?mqb6k65h+FwJHdS248/bj1p8OUhqA4fHu2/2wkiVSXlE1Ke8zFymX/zyguNi?=
 =?us-ascii?Q?xSPKgFWcGIjLY3eEqFqM6IXKyBd9jlp9CgPV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:45.1795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2dba7-dc67-4f24-e50b-08dde18ee821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
Received-SPF: permerror client-ip=2a01:111:f403:2414::621;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
index c7253d66f4a..1d3c08e1920 100644
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


