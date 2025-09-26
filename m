Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DC5CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aA-0006RQ-6S; Fri, 26 Sep 2025 03:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zy-0006Jk-NJ; Fri, 26 Sep 2025 03:09:19 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zh-0006Zi-IN; Fri, 26 Sep 2025 03:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI57mi7rMC8EscT6MmQs9wZfcx0anFe0ppMT2Zx/L4vrCD6DQmTvk8IeIdJkmWhz3jAgXiP3hgs0D7xhWJjFyj8cmpA4Uw6NQw5biuG9hxJCBiclxHXP31j40zPGTvqI1oDaLWrKUW6p9S0ZUKzKF4aALgcHldXsMRSK3wdLWCLsRggYDQ6mxYR4D8jL1H4NPuHMffwlRXFNm/SR+jTpXe5gm+il0Bb1wA8BOuMj0H5gnMbLPpB0nqfDc4St4QxKXYHNzwkNXNYcljFShpyHpz6/LLOsBCzFWuBW95E8zZEJMVRx+fiQ+bptqG+/206mQ4p5eUnLiTxPN/yXNZZZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UaZrTkKf4i0QRPgM/iDR+dGwNAJZ8vmpcUZsi516Es=;
 b=K/DCRyYa/Q21jmGbDQL/ZC2Oe8uJ8gDNXbbNqTdIYxPO32HhvT1evU42wFIRSk4qzLlDUGNs837ey7ULAQxcoLcB1jvuaF9gnkVOqLxcDKWZvUEl+Y2fdfoDNygoGie8etqFtNbc896kTbPdqwEe6lca+fLwjJKOeuhXLbmWNzx6xFSjhw6pp2eOGU9FCMfSWxEGdmYDLsFAD4F5rT6clTNx8deON9BSAT/w3TCHWUxZ3wB+WakwHaV6Ok7F2Pn4xMXUOP94s8w36noCR/oGHVjKDfndNV8Kap4BTWF916Dqt3DjzT1/W3ntpIBK2gksjFGkrKmzhrp9Mo95c90W2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UaZrTkKf4i0QRPgM/iDR+dGwNAJZ8vmpcUZsi516Es=;
 b=PyQ41pQ9BTS3MoUlewoMKAv+DA/rgKwnqm5uUNeFUtwvO6inz44sGgtf4Jj65ZNiWW6OreoFIkKT5iG9IgPlUg/loE6P1uI1ddRedVf75AZFnMeAstPYsMbCoR8QsN+1fR44O7gr5rhL4i9pSzUYzXt9Sg9gU5Te0TxETwK2iXw=
Received: from SA9PR13CA0109.namprd13.prod.outlook.com (2603:10b6:806:24::24)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:08:47 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::cc) by SA9PR13CA0109.outlook.office365.com
 (2603:10b6:806:24::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Fri,
 26 Sep 2025 07:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:37 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:36 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 14/47] hw/arm/xlnx-versal: bbram: refactor creation
Date: Fri, 26 Sep 2025 09:07:32 +0200
Message-ID: <20250926070806.292065-15-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e6b173-4896-4d0f-5201-08ddfccb89c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+vNTUzCIqyuQd/wZ4xarZLy9d1AYmHdhbgls/7t0wREP8cPaX/sDGVEaximV?=
 =?us-ascii?Q?aSLm1+BCf22TqjEcvbscOZEcVZTbirlwct6rOjNEGJA/uwMnnuXeiVLTFlGY?=
 =?us-ascii?Q?5jJNsJDZGCt+l5ykjtvZULEbjA2mLlvyO+WVIOuIpVOBg/eJqcia6K5Hk403?=
 =?us-ascii?Q?Hir6/c+p5Sfueel3qb4EI/DXm5cKQ1DyHWDbWIda+OyCidbKr5E7ncfP65R6?=
 =?us-ascii?Q?4L57WS30ZT3unoQWjswKCcZbny1qmfKwk2qsPH+Fpo0A5a/y1dSZjrNQWcIM?=
 =?us-ascii?Q?hRwg7qZAj3nPfO/XmOKJAF10LpPTtTasA/l8zBLWb3ansLTAH5BPpyNdjKfD?=
 =?us-ascii?Q?LJZreQIF6dLdkQ5w7v69mHYB9aiakWMzWKTg1oxLY8UR9svz0i98hutDHQMt?=
 =?us-ascii?Q?r9wIhmpoN9TNd2ka+7tgwNiw599QQ5L10MUB5IHEZdqmClFJT7/XuOby4r0p?=
 =?us-ascii?Q?JyKypC4GaEVj3DCgpjLIOK/poK6ABEc5ddYMCuiaRCQOuDFSTH5F1N2TsQwO?=
 =?us-ascii?Q?s8KXMoF0xbTEiwak4HzjwUo6AgKk9tnMAh2KOAUSBLJQUCQEJFtar7r8Glq0?=
 =?us-ascii?Q?4YlDk/ZSjnMGuMm5aNGTnMemwSTNdg2r1Jy0kDdcF5rrIF9/SKHD4nvaC6k4?=
 =?us-ascii?Q?2cwORiwTgZTlpLmQ4MnesV8G1uV9uXdIRgKSQy5vGEnp/etqEOmIn3/gX9xR?=
 =?us-ascii?Q?AHp+YN5HVmM9WXxAGH6J5LS2wngYABIb3eRiyKAeL789AF7NdE+wNnWbdgsL?=
 =?us-ascii?Q?7zH1uMI7bNAckPdd2rbJ7mH+EE+Oq6S8ZAatNz/Ou9eMpQWmmzwxgb8e2VBr?=
 =?us-ascii?Q?boNeF2E9vlHQIOyKSYL7J0SaXzyc/k2s5Ra6KvgO3ULXugOrGAYV+Egp0MxR?=
 =?us-ascii?Q?v7LCBE1+zYLlC0VSVwh0OtjsJxTiwkmTFiIH1ZNrCB08ljUaYXen5qDN9QBJ?=
 =?us-ascii?Q?3SXJUtLdyUeZO6VkGT77uh9HZ+am9UB8u0EfszLLhRyN1+JxxaKC8ugff79D?=
 =?us-ascii?Q?8G/HtkEFWAFu6tGa6Fuvd5cEdBZeIQDuXcsAsi6bykOyCO98vTwakmjz1wUr?=
 =?us-ascii?Q?ZYH5Ep4CDOD5O1SfWAfMj3Jt3oKqtobosKFV5YoB++Zu29fL6O+zBmrM4GGq?=
 =?us-ascii?Q?MFYy/AAOlhy82WPOGYnnzYOn0A15HH7c62xEWcxiyrbcyd0puVK4INGwIuQA?=
 =?us-ascii?Q?zQndWFF5IX4Kd8mDx2BnCqwhQ8ifuYZU1Z9dby973JlRztOY05OVed765I+Z?=
 =?us-ascii?Q?y6GAUx6EKEVYWlzftwXpEfLjOoGSL9GtCfClFqBGVYLIF9KwUqT9p5J35OtZ?=
 =?us-ascii?Q?WmiM2jjWBoFo2ZMKlCpkeXp+/uMid12gtbNS4VLcmIt/zF2uOHeABzeAnA0A?=
 =?us-ascii?Q?ZhL+DruCB9RnkYdvO4fDC7M/zYufX4diy7PuPXzMXdMkU8fQWxuhGs9mDBZe?=
 =?us-ascii?Q?NqryJPb0QgKykLpDD8vAzGS1aVFvDII6RwXXk2sSoMfVrvF9Wzq2j3lCc7HZ?=
 =?us-ascii?Q?VzGYIVo5G/cHMpLwm/4IW3jQrwfHzliYh7k+Abj4FAzE0XEXtW2dphj4bbrb?=
 =?us-ascii?Q?+jTFOjz8A2nMkiOb52g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:47.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e6b173-4896-4d0f-5201-08ddfccb89c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index e71c774e72e..31ceaf61bed 100644
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
@@ -1332,14 +1334,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
 
@@ -1381,10 +1385,23 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
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
2.51.0


