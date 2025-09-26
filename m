Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A666DCAC5BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22Zc-000695-Rq; Fri, 26 Sep 2025 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZX-00065M-Sp; Fri, 26 Sep 2025 03:08:52 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZJ-0006X8-PL; Fri, 26 Sep 2025 03:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRrDZamEyMYk4ZpOj6XPAr5hG/ZGkRC+Z6a+LhrImtk3qKtS+z+oZVYFOjAeEnlfAZm8oKz1zsTcNNlpwBPJmi4BrVoW029xX4lUnPtjD3GH0ESgNyMXIK432GSopCrmQMH4fliD8hmKLRVOm4sS7UwlLlgP1EvyNGrzYyp2l1MKhW91hClv5u+USLp3uADIooOS2cVt9zP7A71ml0EBY/KF1HjqcrWXuYwmzBjDPaQPqO6iVs2253X8Q7RMTmxcf5SW6zHsSEemf0Ub5F3Srx/1+kcTWDhJWWft3LRqVnQ6ucT+J0MAcyw+M+TL4MeIgeGi/YCZG76EiL7izyx3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbPGiuqT9+ZviK0KQHJSO52ZgtdTHi0SpB5NYOVPraI=;
 b=hpQnUrV/FQmVYH7D+KuDK4fwjZstgYGVhFT189FgEGV14SOkhcgTbX+FG04AP8AQCOwpEVZ8ijB+Z2Dxk34wb/sVVu8MJTC05neot73Q3Lo/dJGGjSlFUw/u0t9CRJF5dPqaykb1N9qk1F0+yAQa26KK1CRcg4PRsUv99c1sNmgpp9E+C2oCVdRpPUn89qGWukJ+z3kQYIz0Md+qmUzr/xe9c6Oa5rk2efuN63X+74CaBthIKdW5D7SNylau1NLqVNlZq0AU7iiF8sQg3pRFJOHEb4s0gbbEvSW80SFUaeXQBlIs56HQv3udCblqf39OA54/2cqO/lSgGjd2W92Njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbPGiuqT9+ZviK0KQHJSO52ZgtdTHi0SpB5NYOVPraI=;
 b=mdl4lzkCbImwh1l1aLavrQ492DrOAfcK0ttnxDH7wGNb5XUo0cA12lLiI0tftIayep28JfUQgWHCG9bheqf24TNKWVVnTUHaBSt4ONHOG64m/mGpliYJvpovQOp5F80AtIoVuneElnFA5vWt16HrdrxvgpFXiT5oTDz+IyIah80=
Received: from PH1PEPF000132EF.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::37)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:08:23 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH1PEPF000132EF.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Fri,
 26 Sep 2025 07:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:22 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:20 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 05/47] hw/arm/xlnx-versal: sdhci: refactor creation
Date: Fri, 26 Sep 2025 09:07:23 +0200
Message-ID: <20250926070806.292065-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cce5048-df9e-4540-dca6-08ddfccb7b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Luky0Tlpy2kht1p5f4D1oUtnGGHnA/eO1m8TfuNtt8KjcqzCYggt/l2XiMF6?=
 =?us-ascii?Q?FHrqyoczduXyFMiMflxhVrPho4+7uh1H3t/dvtYHdAl5n621JM+fe45sss5Y?=
 =?us-ascii?Q?LIJK+3Ngivi9nNyeH3Kb1TBRMAOBZO29R/ipruutbxqzKNebjujHtPMuDEDz?=
 =?us-ascii?Q?rl35UgvERQ/5uTUmYUKvHj+HVXaonL57dj70vzpOdlUlFluaaR9dc310rOnW?=
 =?us-ascii?Q?5uphPdyXqfzhzmF8qeBv55hInAeEKEOpYHPPJeWaXTVdwcKBasyr4hWxg1L8?=
 =?us-ascii?Q?xooFJ3V3TOV4ZqqspjrB6cG0/1zD2RUfwitDVlqh3yXSfacOlFqEJ/IuLSxD?=
 =?us-ascii?Q?RwSOFysa4mNFjFJFebk2S/7yoQfzo3QqjREg/qcDVA4eLt4NuxPVFeuNYThy?=
 =?us-ascii?Q?IHh2S7yi7N7RuXFbZM+eJt3/WwgiUlU5Jkbxzp4PJjNIcphRWYqCfLFN3TQZ?=
 =?us-ascii?Q?srLXsWv3LqUF/8sLehObZGNI9Hn52fY0rtJq2WfcjAQji9yjGaY8hOn2Z5o4?=
 =?us-ascii?Q?SG5ZEojVmNNSe8Q4eO7wCsIvD+NaijIF8wJVfYeqaG99ik4cM4hdUDvGCcyM?=
 =?us-ascii?Q?+n38KzrKrHiy/Mhk/GTt0dzz+dSuHV/9ETJ5GZFRtGu/IvIbWmoOyyTRBcuD?=
 =?us-ascii?Q?ICtnHMvWcVLjghgOBmeMmfwvRpw2Q8H75Yl8A/8tXkqJVMPSJPOD5zlpXRUX?=
 =?us-ascii?Q?MbsbwAu6DZC6fGTZjUJL1haRAaTIa/ZkbAeXyFrxwSxaabY0hEfD5jTBWFdJ?=
 =?us-ascii?Q?vF9myzPA448lb18UpQj+CB9KAIm1JKegjUo/Y1bumPryXtyuhPJVzc0VR6Kh?=
 =?us-ascii?Q?N+YjGWlODA0shDuKKLDgIDCwY80Xa3pBKRpNt1W0qvQTXZ2llH3pyZKTtWs0?=
 =?us-ascii?Q?5letL0/kxPQGdHavHDiUw40ME8UKRd0txjDwKfZd4PDqc+J85iz8ir0CJmwM?=
 =?us-ascii?Q?11VMycgsjmzAjiQVWQoqJaF5oY+rmHuGiiefafgFPBVzY7I8+siiHvq4DXXw?=
 =?us-ascii?Q?nKc5WvoOA9L69BvpW32X6K2bNAY/FFzxcpl6q1vCJY8CcwgPBTDegpRwKcp7?=
 =?us-ascii?Q?F7ENGicTkQ+EV9M2GfoT1KGcT0A56mFJ4+KtpPxXbg07QDymBQNa8Tff6Xmu?=
 =?us-ascii?Q?6vXOuR4Tcaw0M9x9uECNbFueEyzqKQC2f/Sn4ow8ydQWcrVSvwTToLGY2wGM?=
 =?us-ascii?Q?j+gykXjkmPTrn2TRcagWil5j6Bt8l0Gtn/FKXH8rnLjqpflqmYlCod5Zgnrx?=
 =?us-ascii?Q?vTC200Is/+1HGj7FGYAQIUlQMYsGvAsUM27S7/rK+fC30KhoYw0FIUtamK3p?=
 =?us-ascii?Q?nx/gIQ9Zcb5ZaXtm3GL4/5ihRlZ9sEgrkHBIu5dBSNnWtF3HsCags30Rm+1T?=
 =?us-ascii?Q?KU/A5XvAzdh3b10lTXt2H0U0IVyGs4ntXemt5QWiu9kWGnRTPVHFwxg7iMzK?=
 =?us-ascii?Q?XLAmexM/p1k83phpkQXpZE2ZNnaeeMG17UIp7SlNCjxZCNZq5MRZt8MqDUAH?=
 =?us-ascii?Q?gPpk1ngBG2YKErDpYYTZE7YJd+3LS/12k666vS96O1a0PBsyHJGeQjyeQ4P+?=
 =?us-ascii?Q?kCBR2+5MjhIjFF1hOEQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:23.0427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cce5048-df9e-4540-dca6-08ddfccb7b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Luc.Michel@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 3d2e33d3dac..ff2f47daad9 100644
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
@@ -1060,14 +1087,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
@@ -1087,17 +1117,41 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.51.0


