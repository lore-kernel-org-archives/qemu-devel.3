Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243D9CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVp-0007eh-9A; Fri, 22 Aug 2025 11:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVh-0007bj-0z; Fri, 22 Aug 2025 11:16:57 -0400
Received: from mail-dm6nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2415::60b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVY-00076w-VJ; Fri, 22 Aug 2025 11:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTeIDnnPxvn3rrX1MXoJbLgW87bMrQxgoaG0IKk3o1LinjWtweayB+T09LZfUboMZCOZd3E1CG6rn8LQJ527URDUFIH9StC6BtDvus0rlgt3gkxr3XkoSiZuFPuTVoVMtJYSOohUTMox5R977Unq+4pCfWBGP9WKi8SVbS9Yim3b02PwthznM0PBgYP/DMxiGHXydXKIZ53snp0n5UTQPyO4aAx4NISG+uM+wjVHXoHoiYEQ90cWJqBBCbcv0xjPPqkNIm1MHac1i0gEJh6JSyPz86zox7FE0+AlASZzaKdZCjhJOXpMH1/uvNql8tFSUYW8/waoK3HqsmYogUmzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmLNvrlsjyguHllgqlP1O50HbxCU0UgGaGZoEFp74So=;
 b=mN2qCl+/gXy7YHCV5+lCh47LE4ZyRpL20gKHNCKEN4fDiTpVhAaiWChdxAo5/owYsfNMJyK84X5CUpDZCwCji+vLXcY7xHFr1m/t0GZ6rqZAUL+ApfQa+mgqbsgydXGJ/MRSME/p11l5hFu0c89ZlMxZ0H4UWgL3tH5OZvCk97oi5gmrKa4P+JmjFeelHIzf0ADQ/DM+y13dJcIRSsf6Bbi8joWPKjcRLcCPp6w30jqGBg30hg4TJwBYqhZYOTRYyz6GRgvXr2MYcfdMlxtkzUGhxJW20tz1TIpCnnSW9nPZ9WG0PY/pI1ITlWf/C+nFnGnZKc+yZ7gA/msRgnxLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmLNvrlsjyguHllgqlP1O50HbxCU0UgGaGZoEFp74So=;
 b=3Wlscj2rU5D9z4wx+dYtdut60cID6GXVZaIoC4EkfMUJQ0Isduie+NzqsOemKilcQ8yvD4MIPISDkCFW6IL7XRBwHxZT3LhdYzkdpunVKxyRci6M5Lp0kJeYm7uHRlwT7TSPGYBEx/9++pYuQuEZ45Q7UduGImZbDKFLfwOCCLg=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 15:16:36 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::b1) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:16:34 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:32 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 05/47] hw/arm/xlnx-versal: sdhci: refactor creation
Date: Fri, 22 Aug 2025 17:15:30 +0200
Message-ID: <20250822151614.187856-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aff65e3-f07f-4331-47e3-08dde18ee273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tBuzdO2n8Eq3xUpKKcLYzajPGZE5T6Tv+WbeQhGEAe2fi+kJBuCtKHbAKT05?=
 =?us-ascii?Q?t0ud7oQYLYHOaZr5Vs4E/uB2lsuGCRlTxZAkmc61HjXfA31enCSVZBX4gqnl?=
 =?us-ascii?Q?GVgsounLf9sEirW48+tAwi7uDi2MxCh28iqWq4+QlcyIJP3VMKUke/WDvY8K?=
 =?us-ascii?Q?ap0bqn0Q6vF9avLK65Pw1cuL5YxbihwI2fE5A11yFQuWPcbK6C3zHXLGcefR?=
 =?us-ascii?Q?EK3ID8Vgev+WIdtwJms3oDmjMSdB5l1Eb6osq0i5taoq/f8mlgOXme+BO+R7?=
 =?us-ascii?Q?Wf6W9K81A6dBQ+YSTkRITS35fIbt7Y02o/rnXnBcxUj/TAs49KwcUeThyf/B?=
 =?us-ascii?Q?O3Vfe8ZBlIIPgOxNnWCcRMtYXfm1z1XMt9Sdp9BDu0Dpe+4Z6d17lGvFlQBo?=
 =?us-ascii?Q?266Pw6Z46thOYZLilvb9e1KrX1xDuvjK1mrD3Te2xrLJF99UNSvhT2Eo1nW2?=
 =?us-ascii?Q?9aSNeoMfHSAux3gxaRUzqA6dFv4HFN2hs1RDfF2J8XHRIDgsz+koTHCzMonh?=
 =?us-ascii?Q?XxxIq6j7q2xXAIXSssp0aM539D+tpHc7OILmJ128cTsCoPoxNjgzL8JaeQn1?=
 =?us-ascii?Q?0WI9AX9mUujjwyaASKc30gYzz0kOJhZ4ewUephzbrdbLjw67Bxb20+I3204Z?=
 =?us-ascii?Q?FMwAz6Az4lWfJ8dmthG1Ivg7DdMO6H55nzJf9HoojUKJfEnKUl1V1hCXGpc4?=
 =?us-ascii?Q?Y9E6r3oihDcpTenhr5SpVpvpmyCwCHtpknffH/DhEDpxmCa22S8GtlmUiw6y?=
 =?us-ascii?Q?PPGjo0YR58wVBiIirFKhmqLJ9CMIvzD1EBRHUCSiHPN+f/99nzsPFFeHi4qb?=
 =?us-ascii?Q?eDbUB5O+ZPBEexvhHJuei5z2KoumS/yycFCD+wv9aYNGegJDcFXYM5Z0B5XL?=
 =?us-ascii?Q?F6dX/jM453tJHHq+EuqXCAbk+6ND9xMJD2jiN/sgYwHkA2+a8sILVJjFIUd1?=
 =?us-ascii?Q?ie2Xcs+H/Nn0uAOcAYqhaSYGYpkavjpEBddJlBDo03sDjhKHsXHtEzXJZbw4?=
 =?us-ascii?Q?dKwS3DQkysjY+n3hLG0JulUC+JgtUSoS762ar30a/Zi/gqHGv6yr5RSkS66M?=
 =?us-ascii?Q?H0U8fr/nuGo+e3anRBt321VdFODDrZMscRquMrLf1IYmoENhN50cPzNZABnn?=
 =?us-ascii?Q?cOTqmC+FiBi9nR+/7WE4TnDT9+CwaQeYpSEt3t1D2tKQbh6VTp+aLwH51Q8U?=
 =?us-ascii?Q?bLR1OlTPqUTzFDS77t2C32+b6d9INFEqloK3zQDBZE4E1UklAELMzuiDMXVB?=
 =?us-ascii?Q?LDo/GizG7Tt4NSSS7ssVDBcXByxLbowVdBZjkLjy0DtYY1rUehk5LMGVSoRd?=
 =?us-ascii?Q?GSNW56Pk1DXnfG84LiC+T0+opQ09yVNhfsdvdb4eseUP4tV67uz4AdxMCtA0?=
 =?us-ascii?Q?PWsPGUiqw2M9GwiwntQlqXpozz3h+SXjcIeV7g7pLuitAvbeT3Bt1ks3bAto?=
 =?us-ascii?Q?tsX2JSyu7tbQ3C8Tq7ZjbqaSXMg6VuOVe3swlSSzFiyAQuffQ9/7z34WJwDo?=
 =?us-ascii?Q?alJbJD/YKsMNEd9hetd51om9aGSAMrVKbvGr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:35.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aff65e3-f07f-4331-47e3-08dde18ee273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
Received-SPF: permerror client-ip=2a01:111:f403:2415::60b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor the SDHCI controllers creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  5 +-
 hw/arm/xlnx-versal-virt.c    | 43 ++--------------
 hw/arm/xlnx-versal.c         | 96 ++++++++++++++++++++++++++++--------
 3 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 007c91b596e..4a7a2d85aac 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -14,11 +14,10 @@
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
-#include "hw/sd/sdhci.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
@@ -103,11 +102,10 @@ struct Versal {
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
         struct {
-            SDHCIState sd[XLNX_VERSAL_NR_SDS];
             XlnxVersalPmcIouSlcr slcr;
 
             struct {
                 XlnxVersalOspi ospi;
                 XlnxCSUDMA dma_src;
@@ -154,11 +152,14 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
+
 int versal_get_num_can(VersalVersion version);
+int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 334252564be..52852082d4b 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -282,36 +282,10 @@ static void fdt_add_zdma_nodes(VersalVirt *s)
         qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
         g_free(name);
     }
 }
 
-static void fdt_add_sd_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "clk_xin\0clk_ahb";
-    const char compat[] = "arasan,sdhci-8.9a";
-    int i;
-
-    for (i = ARRAY_SIZE(s->soc.pmc.iou.sd) - 1; i >= 0; i--) {
-        uint64_t addr = MM_PMC_SD0 + MM_PMC_SD0_SIZE * i;
-        char *name = g_strdup_printf("/sdhci@%" PRIx64, addr);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_SD0_IRQ_0 + i * 2,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addr, 2, MM_PMC_SD0_SIZE);
-        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-        g_free(name);
-    }
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
     const char interrupt_names[] = "alarm\0sec";
     char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
@@ -562,20 +536,15 @@ static void efuse_attach_drive(XlnxEFuse *dev)
     if (blk) {
         qdev_prop_set_drive(DEVICE(dev), "drive", blk);
     }
 }
 
-static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
+static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
 {
     BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    DeviceState *card;
 
-    card = qdev_new(TYPE_SD_CARD);
-    object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card));
-    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sd), "sd-bus"),
-                           &error_fatal);
+    versal_sdhci_plug_card(&s->soc, idx, blk);
 }
 
 static char *versal_get_ospi_model(Object *obj, Error **errp)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
@@ -646,11 +615,10 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_gem_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
-    fdt_add_sd_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
@@ -666,14 +634,13 @@ static void versal_virt_init(MachineState *machine)
     bbram_attach_drive(&s->soc.pmc.bbram);
 
     /* Attach efuse backend, if given */
     efuse_attach_drive(&s->soc.pmc.efuse);
 
-    /* Plugin SD cards.  */
-    for (i = 0; i < ARRAY_SIZE(s->soc.pmc.iou.sd); i++) {
-        sd_plugin_card(&s->soc.pmc.iou.sd[i],
-                       drive_get(IF_SD, 0, i));
+    /* Plug SD cards */
+    for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
+        sd_plug_card(s, i, drive_get(IF_SD, 0, i));
     }
 
     s->binfo.ram_size = machine->ram_size;
     s->binfo.loader_start = 0x0;
     s->binfo.get_dtb = versal_virt_get_dtb;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 5dccf231942..b963a05935b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -26,10 +26,11 @@
 #include "target/arm/gtimer.h"
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
+#include "hw/sd/sdhci.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -45,20 +46,27 @@ typedef struct VersalMap {
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
     size_t num_canfd;
+
+    VersalSimplePeriphMap sdhci[2];
+    size_t num_sdhci;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
 
     .canfd[0] = { 0xff060000, 20 },
     .canfd[1] = { 0xff070000, 21 },
     .num_canfd = 2,
+
+    .sdhci[0] = { 0xf1040000, 126 },
+    .sdhci[1] = { 0xf1050000, 128 },
+    .num_sdhci = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -71,10 +79,22 @@ static inline VersalVersion versal_get_version(Versal *s)
 static inline const VersalMap *versal_get_map(Versal *s)
 {
     return VERSION_TO_MAP[versal_get_version(s)];
 }
 
+static inline Object *versal_get_child(Versal *s, const char *child)
+{
+    return object_resolve_path_at(OBJECT(s), child);
+}
+
+static inline Object *versal_get_child_idx(Versal *s, const char *child,
+                                           size_t idx)
+{
+    g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
+
+    return versal_get_child(s, n);
+}
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
 }
@@ -422,36 +442,43 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
         g_free(name);
     }
 }
 
 #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
-static void versal_create_sds(Versal *s, qemu_irq *pic)
+static void versal_create_sdhci(Versal *s,
+                                const VersalSimplePeriphMap *map)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "arasan,sdhci-8.9a";
+    const char clocknames[] = "clk_xin\0clk_ahb";
 
-    for (i = 0; i < ARRAY_SIZE(s->pmc.iou.sd); i++) {
-        DeviceState *dev;
-        MemoryRegion *mr;
+    dev = qdev_new(TYPE_SYSBUS_SDHCI);
+    object_property_add_child(OBJECT(s), "sdhci[*]", OBJECT(dev));
 
-        object_initialize_child(OBJECT(s), "sd[*]", &s->pmc.iou.sd[i],
-                                TYPE_SYSBUS_SDHCI);
-        dev = DEVICE(&s->pmc.iou.sd[i]);
+    object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-        object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_PMC_SD0 + i * MM_PMC_SD0_SIZE, mr);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
-                           pic[VERSAL_SD0_IRQ_0 + i * 2]);
-    }
+    node = versal_fdt_add_simple_subnode(s, "/sdhci", map->addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
 static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
 {
     DeviceState *orgate;
@@ -1064,14 +1091,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_canfd; i++) {
         versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
     }
 
+    for (i = 0; i < map->num_sdhci; i++) {
+        versal_create_sdhci(s, &map->sdhci[i]);
+    }
+
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
-    versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
@@ -1091,17 +1121,41 @@ static void versal_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
+{
+    DeviceState *sdhci, *card;
+
+    sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
+
+    if (sdhci == NULL) {
+        return;
+    }
+
+    card = qdev_new(TYPE_SD_CARD);
+    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                           &error_fatal);
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
 }
 
+int versal_get_num_sdhci(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->num_sdhci;
+}
+
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-- 
2.50.1


