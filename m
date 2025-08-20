Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A1ECA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9g-0004NZ-JP; Wed, 20 Aug 2025 04:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9e-0004Ia-5v; Wed, 20 Aug 2025 04:26:46 -0400
Received: from mail-dm6nam12on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2417::610]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9b-0000w3-V6; Wed, 20 Aug 2025 04:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRtGBMZ8fD4UdEsMilvATAL6/50EHqEHi1ERg1/yQmlEo2wIaiyT8PvN2/UAgVyacWwXUW3xbkhZSAtZkOiadsgBhPyste3lSxVuIlR33pe5kz+aXiuv7mXaZZ05dtXNP5DcdFA1CjaBqUbgF6Sv1geI9VJrH+iMNnoDwYY/l3I6anU6+bO2LjGoF6gEeAaY8fTfKepWyz6Mk4f8GuaEMYfUUZuV5SCEFIC+p4URiIhcybmkm5Mq6tjfJWP1DJVCTa9uMEXIcACQ6jxPadRyQVOCp0O5LFuWPDQKsPRdmIcCukt4y+i3JV01hGcVHpFmgN5Z1lopfphjct9plusulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NARjDdovf0Jj/KsWIMIL6ePx1JKBIgQ4PBA+V5kjzZk=;
 b=oVmsb54Lm5dQrWqVorr07r3Iy3PRJOpTTK8NNGnk+20b+VTLcSb3bwv9HUw1tfA9t1d72KG4OWmjbeMhVJYZLz7ErEFLTLQ5wwbXlH+1ACaYiiqlQyMoQ1O8mjGgs0yafiEwsOd1NkNY85T3Np61db7cM9nCkFoyDYgrdTPlY05ogPI958qfH+6lm2PGtosdymJyihLJ4cqk1w0v7aC3YIU71rEegSNPk9DBe5ZbJmQX4OT2rVXUATxG5jJsj7oTaVXQluSGmtHUmcc6N+sN3eTR4j6t5LYmtSEOcuJtWL8szhb0Uwf0qzfG8pP13B6FN9hOhGZ2r7nNUDgVI5V2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NARjDdovf0Jj/KsWIMIL6ePx1JKBIgQ4PBA+V5kjzZk=;
 b=iKEVFsmg1WqZyO6qsiPPyGxNHoOBMHZtY9jX8YhK/Es0F0wdBsX1vn8lq62wL1125Bv7GnUZ+s8qE5JD4dsVjXlrBJIHu6phJJ9HLdMNEfu2ry2atES1iyuWZZN555T8WUsQLP3Z/5P7oJKNCKz+ZiqUwDSnWwbCbrj+PkqirUE=
Received: from BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:37 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::51) by BYAPR08CA0049.outlook.office365.com
 (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:35 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:34 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 14/47] hw/arm/xlnx-versal: bbram: refactor creation
Date: Wed, 20 Aug 2025 10:25:13 +0200
Message-ID: <20250820082549.69724-15-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7483c41c-94e0-4117-171a-08dddfc34781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ul1ZkyLm04Zjic13455ZS3hM/QLQ+CTemSbPjpDIU0SObGZ7RS8JmqrDyv63?=
 =?us-ascii?Q?EwmDln8vUrfi5M/h9oj5AugqIRkEqEfHs8NdyTRyQDEM42ECCjf+TtguVcFf?=
 =?us-ascii?Q?frOLVG3DNvC2+kZefooG15prGuvuUJHJh+zc6r9m/Jp5jKSaFUvZmVdSyLpB?=
 =?us-ascii?Q?Jt7FuHEXFF1xT9wuL3m1A5cZ61Vv+d+OKjxfPYGV/5/6DTApi5rGGh+ViilC?=
 =?us-ascii?Q?K+lLk91q3luq9+cj3TZtriu5FKyIJGGMgKaTZ5iGKYYV9zSlQzExnppo+tpV?=
 =?us-ascii?Q?fe10WpkkOtiw2t2c+J+ay1197dtmFBnCzMnG5xe9LsgGqCAtKWMXX1uUr37A?=
 =?us-ascii?Q?irHC4o5vSYTACM46qfBqyeaeWGfyJSFpDEiIvIRsceInNPEW0VZlrJwc4HnH?=
 =?us-ascii?Q?OI+E7DA/4gB7oxZlJQ8O1w7QQmiKysPmDGLHo4avoHY3jsa9gQl7+niig9yx?=
 =?us-ascii?Q?SGFRgF0rE5Grrn73lkCt7LggIfRrVmYGX/7ZCaPHn4U10bhjQ9N1G7AjwfgS?=
 =?us-ascii?Q?Zyf1mlic886T0wwWUMlo6WNpML6UeJn0hmzagnSETCOG25w3EoXOPCjdAuZg?=
 =?us-ascii?Q?tN3/RuadmzXvNiVwvW9hL6knx/ufNdUy3gfGNGq3vtjHuSXnlG8DT/N/8f6Q?=
 =?us-ascii?Q?QmIZSyXw4b0mSqkRRsiwbvF21mtrdZplxGkJpktzMwLmApRAk4+0dmsP8CoK?=
 =?us-ascii?Q?GN7ZSppbMJGjAjtPKKt1GwUg1AUgebUOwtld9a6v0K3DI3x44qvMeusO/P6S?=
 =?us-ascii?Q?dehpZxv5FBpRcAAImlCFn4s701wb72qsan8KmkmipLDkeLbzouoXCNb3RDUY?=
 =?us-ascii?Q?ab8kAw9wy+YIgVCqgqn0TdnmtVqYJZi2zoydi6ZWGTONSCjMr7QhG6qK6QZR?=
 =?us-ascii?Q?fi5nam3dKvyFZcf84VWGIztPpi4NxDLJT0YlUBnzQHVsdovKHmAJmiuMMphv?=
 =?us-ascii?Q?9P1MlGdn24ug6yxGj7jPW6RuiCdmPiyS2L8wDnnWTFU3bDzFxFo3Ndq43tVD?=
 =?us-ascii?Q?v0BSsEWMnwBTkeSap38QFPez3VwnbDryT5qF4Cl3bJuevyq3RHVRzWw89NYv?=
 =?us-ascii?Q?3Kd5L0FO6QcYpWKLd/kuUnFtYSTTdk2hXFTBLCXrR4T8uSCHnPLi5t+R14vj?=
 =?us-ascii?Q?XS9FJChyRODm+NSW97tRmm+kpQOf3TwsbhANAAUGhCid5KGDFWJT2zz1lWJU?=
 =?us-ascii?Q?PuPBnZJSDCsHsbSSkbmVH9oY/DycJfTv9mTRJxgHfo76nYdDvWA4q1piwgR8?=
 =?us-ascii?Q?+VtmWgXUWVIHMoEshy1mTpla+GkR2N+qITj1YGpCi0n7g0hIxpFuVLi8rztJ?=
 =?us-ascii?Q?LZWPXdD36J833T7CQAdemu96LdTfWRpn/2DiQVhU/GoTK3qsGGlPlSBAm4Hk?=
 =?us-ascii?Q?FclUr1GjZeHx8DvOFLagFMhCGSku2f45Z6lxifPp9vxh8nY+Cso8hGiziGgZ?=
 =?us-ascii?Q?C96OSYD9JkDQJQnxv1LgCaOk3COGxRpZ7XKCg+Z+gzO1gdziCjHY4t+EnBAL?=
 =?us-ascii?Q?DwH1EjDcqEbvdrHfT/n5jhFGHwW++GXjjmfB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:36.6408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483c41c-94e0-4117-171a-08dddfc34781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
Received-SPF: permerror client-ip=2a01:111:f403:2417::610;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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


