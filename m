Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE48CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cd-0006Yb-LY; Fri, 12 Sep 2025 06:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cY-0006KX-BA; Fri, 12 Sep 2025 06:03:10 -0400
Received: from mail-dm6nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2415::602]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cQ-0001JL-3l; Fri, 12 Sep 2025 06:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz2P6xgQb4UZySer4VlZI3NHDu+srEDu+Vy+anbP9BfevnH25Ppg5atP3oq1+zJzu3ihwSKOcz4Vpo1oRb7ZHD6bmccseLHO58H0WiexLYlhMJFrEVb73Ets131QJeFPz1/pfIbWrSTxtyaq7JaQFOkPBr0vigSFrzJXOmuS4+0n4Qz+V/GYvki04Z3hBUHIAnVkI0lr3jBgnD5pc/SM2dlPRTZPdBnE1U/K10yxE2LMEDcOuiBspnyZgODGYAdFhUwL8UbcCAFr/uSvQrMJtW5Kqj+J9UMwSQfXAHPnNwzfCt2Sss84+clWw0nfSl3NWAajuAsEUlm+K1jQZjsFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZbrJOCJ5wDIm3I1jIoN2m3n20KrRWwUkRr8SfR4hS4=;
 b=pubt/K9nz8NQe5jiT+VeDmB+XjoCRW9Z9usHbkUXgLF6FtGa1z8Vb0lPXtM1DvF/cRq1B9FmlWkR+lNcTrdQPtF/DevzSDlPz65S0HjSH3ZA3upTGTUe6tJMiDgB4PvO2F+iTZWkY6mOyA5aO0B6nui//JczAVZzs5CnGcMl2MNtnWSd25L3Jp6Pr5jrWMpbjWbSSN/Ehj+lcz5cjoO6YgHN8QYub+pplrd+sAg9rIYGVOSqxisNv59l2GS4hTv6rKTLi4hYmNgi2TtEbcYcm2X8Kd77UGPI+rPu5jLxMoIDnTe2ChOnKhLxgENnvsoSsX81fYzRxha/aXj7dkFw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZbrJOCJ5wDIm3I1jIoN2m3n20KrRWwUkRr8SfR4hS4=;
 b=z5tr4kuTqfzx90D2nRiXDFfgkMQd6XVACeuovFRktxIXUi39ddKNHpFJ7M1OVFyPMRFhSd3hxw/fXmzmdfZlSwN8tlhLxSaOe/IRu7oe/vAMS70Kt90vtBgo/oeOwEsvP7XfBFdcbfIKK09vN4jtn4khQ8sKvWKMOnMjvuBA7ns=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:53 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::3e) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:46 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:46 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:45 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 14/47] hw/arm/xlnx-versal: bbram: refactor creation
Date: Fri, 12 Sep 2025 12:00:23 +0200
Message-ID: <20250912100059.103997-15-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b89bb81-ec11-4264-4dc8-08ddf1e38a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lqDlix2jgi7QFYOv6gQKUZvK07F5XamefiO4OsJyoedS1nOXstCRhYi6KkyR?=
 =?us-ascii?Q?Zj4HWUzy9x39IuWpTfaE0mkRn+sTooQnllCVt7etygS5zVit7hqluwBUyVe9?=
 =?us-ascii?Q?BYWnhVBBsRLuZmWXx/V6XFCuCMqYD0JpQM5gzLs/1fem2S7ZqUZ3Vf4LXInH?=
 =?us-ascii?Q?sbE618lreFlBRdxFI16fAu83uhci+1ObEthdcjGRKBKHid00tWXMywr87lQW?=
 =?us-ascii?Q?3RCGESaCb8L6ORm5YveLFx6pCBgxpjRQOjUg7qi9p01lWlXUMxQN7W/GszOR?=
 =?us-ascii?Q?GyboXVbosmSb5HijO3hQargludu+vKAhcMW9kqBp8FNyA4mGp5Cs2dVpPjSE?=
 =?us-ascii?Q?roAM1VSN20C48jAeqndTX8iokGnoTrhzqhMDmg3xIJWDGrc1UILbcYIVWu0v?=
 =?us-ascii?Q?9yroq25VipaEIKxZjeaIIra32e4+OrKFhl5nFeKNd4cCj+EXvtcLYcCGd0L7?=
 =?us-ascii?Q?k1HF2Va4WwZLpUKH1auqqB/xpYGAPL1wGOGs8YbseraUJOIw9V+1n8ZRAqXC?=
 =?us-ascii?Q?ocRXFvvsklaUSQj0LCZKqNS5lUsFYQ5GyLUI4dUEkxVHiPoOQOqcJfqOAxqL?=
 =?us-ascii?Q?lANB5d7IhPysOax0wmOABjic8k7/c805zbJ9G6sUmd5s/iAA8P8XseXX+0JJ?=
 =?us-ascii?Q?9fH/HYJpsgJVhfiFf+DB1y4yZxBicnjQYKByEpu+QAck2P3tHUt941TcRFqa?=
 =?us-ascii?Q?x7Wv0NG0bKTzeoguhSw6oN9ps47SY4OOP62rT1Vk3WUMjt2Ywuo2Ju4XElfA?=
 =?us-ascii?Q?S2kjna3Fcks48xL7UTpzVJFeEVJlbZuPvLESo73EUk2Y5CUrh5LC+Oh8SOTz?=
 =?us-ascii?Q?ygCd5RQRYv16UG/or+Jme/yJ7h8VRNZLWfemld/VTCidoE19AdmDiwxbM1fa?=
 =?us-ascii?Q?Qsl8zQgu50w7R6Y9Te1JrcRAfy62EVRqFC0/OgE59IKz5ErscRTpbc0eDCD3?=
 =?us-ascii?Q?9VF+Q/c6u0K2uVd5zJ5BJkmxfrdUvaMb9C30XrrRfF4TORMVO8CW6pZ/9ag4?=
 =?us-ascii?Q?6+SIxsGIbUyU9TSZYickjDu9FYedxG/HHB/BQ4AFFlzDIir3UHscPxr3W0h0?=
 =?us-ascii?Q?lzhs2KDmua3amCBGw5qqXS6vS+RMUtvEjuyiLm27B0MENXF+nX8b5/8Yrl1N?=
 =?us-ascii?Q?Dpjyzx3VQ4O/rqjOTR2qyXsBMZSi2tmO7yZIxbMAO6mfxyLnPcBCV3s/CFDK?=
 =?us-ascii?Q?jSYxEKimk3YdmlRuoB5YWaQtDe8sqoGIlUxvyKYfch7bSsJi1p6lX7C7Jl09?=
 =?us-ascii?Q?Z1MFSEBTsgZs9FCDbP8YsxUOdpCLUkvX10yikle62l4/u37ykWd44i6Y40sR?=
 =?us-ascii?Q?UmaM7+dHqQPb6BDgMRJldVg32SRvClI3rlc6UkVQguMc98sgSJu2hWDbFo+G?=
 =?us-ascii?Q?wPsvvJfizx3yIawZ79jhi8tKYzh0Z3+EzeklPX+LYkZLcTXKWfqEXO84ti3n?=
 =?us-ascii?Q?HJISZD77rrUmuWKPgzNJTKsL9KJKm/50Bgcxev6jajenuqq+y7KsGXTbRNKh?=
 =?us-ascii?Q?gpecK1YXpRtz7nCmpa+iJFbuyivs2IZhXMqs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:53.1204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b89bb81-ec11-4264-4dc8-08ddf1e38a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
Received-SPF: permerror client-ip=2a01:111:f403:2415::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index ed242857efd..dcf84f722f4 100644
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


