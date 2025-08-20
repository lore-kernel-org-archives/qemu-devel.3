Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A28CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAR-0006po-Js; Wed, 20 Aug 2025 04:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAP-0006i2-3X; Wed, 20 Aug 2025 04:27:33 -0400
Received: from mail-dm6nam12on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60c]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAK-00015i-Sn; Wed, 20 Aug 2025 04:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQJShI2gM+y5UzsVb48NqBIY9sDDq0NILTsArsnjYqj7o2NS7bVgw/7UpSlURY0grj1sjhPAe55s4Nfyz+ededjuegMpIsoIbSFf0LmLj3HPjDDaOLU5IHyXuogDUcovDZWeFzF8vxJN2B8bY8pdewnMCBwSVuvfXCsjewyA/4OtwqsX8H0OJUxcwvWjRx6DWtJBTmVtkq3/ZUN/9b9fOsfpQq3nhppCjiudpXVggYt+hzH2gMaWjch+Xv9/XA8m+5DkcsFoJYZmJ+re1FPCVFvYp08Gk8sHMKo9axaRzoWr+Sjh1k6XGF/oeG+9MNTpMLso/bnFX1wQjDlKvdXbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuEWt5tRfdvobkIBEH+tbNbEHt20XA7kfPQxwriPY8M=;
 b=T5vRYASYTdIm+rZNE3Qw0tAScDhVny7FoRJlcBb8wTPJBr/L8zfqClwsptdXztx980FcfTLiZDApADi2sCURkTKh0+rjjwyFGKLdaVd8CAyZJY+nwN1tNJ0+Z7r4IZKTMD2fpT0duNM1hw9bu8SLxsu0Li/BEx4ijyCajT+iCjWKDe3YH79/zb4Qfyh88IbB2N0JOJRYPH3FhmQcxIzOcvQtrG5lwSqEtsr5c1JvjLmIVcijAPyPYtj8D/El+6IgNr/T58vEYhTVSdhE+gs0tKNVPr3eLCyd+1F+dUC0VZS/CoxbmNATn0Vg36ZDKgJA7QBlFnNsc5mv+ZRbCiq4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuEWt5tRfdvobkIBEH+tbNbEHt20XA7kfPQxwriPY8M=;
 b=5ODjHQn4mWly2n5nnBkRkB/SGuQdB+sa3E2RNICi9w7EsAaGBe6XaeGoPogXQpcIROvUf57cvY1YrxaCslDP6JeR8b3+P1abU2RKq/O/hsx4er8TZ1X9k84ujshANsjKe9wTLoFQ4Isl8miK3XCaQyCpuHwFPUuI0QYgm5yKBVI=
Received: from BYAPR08CA0066.namprd08.prod.outlook.com (2603:10b6:a03:117::43)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 08:27:15 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::17) by BYAPR08CA0066.outlook.office365.com
 (2603:10b6:a03:117::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:02 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:01 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 28/47] hw/arm/xlnx-versal: ddr: refactor creation
Date: Wed, 20 Aug 2025 10:25:27 +0200
Message-ID: <20250820082549.69724-29-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: df53c9c0-e0ed-4996-c8ca-08dddfc35e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a29Y3zbabrhgmFLwkCJzuXL8c1vteH1ECKsAKRq8n7MnrscvMkB5kjiaG2sv?=
 =?us-ascii?Q?5USaSYMs6xnJio6G3HHULvAX8L4rCe2Z0ftbFGuyp77h7huP7ALNJ+l7Wola?=
 =?us-ascii?Q?c8qsWyPcv5Q8GziFSu/Gjn6Gc99KRN7qoDwRLjXY7o6ZXKWnI2ddzCAr/7Sl?=
 =?us-ascii?Q?yJkqlY1qWMZh8M1tlb/5db6nBpAr2/AgRmiuQnr6mvM2PZp7NYI/yiUCA2C4?=
 =?us-ascii?Q?QaAwlghPCjhwT8Za6h7Pu7X0xEkgTbynJsGibPGzkxZD5H4N4hYlORZfWxlg?=
 =?us-ascii?Q?XjL9iXUCkpusboPBxQv7R26+StUEAbLn6EFHc70ddLEr9NOAUzY3fYpVRlNC?=
 =?us-ascii?Q?ZF9csJkmwKPY9IyWEUBy0evFeAl2m9NKKt7pZmQb3tdfDNKF0VCivpA42QjB?=
 =?us-ascii?Q?vS4qVYEbc7bH1QnRU8cIJlWR6Xm7CeAfgCncnSiMiM2QWQnR+uN+CGwlRvsm?=
 =?us-ascii?Q?x2nq4MpX449Ttk6W87RsUcPMyEAxcjBWzIVmhrVg0t5CN3B6DGvfdfwCMyXr?=
 =?us-ascii?Q?Qy1d0UTctHW7EPc+BiKyJFVr1czCPCO7CK/BDjISIc//RfOjmNUXZFxjzcp2?=
 =?us-ascii?Q?VVO5D7B+Szl6Z5zLqSPnZLxVimlhYo9qn/4DJ2Puklk4XiuFmi6khEQJcxtb?=
 =?us-ascii?Q?55V3uOWRbX0CB8Uh9RHC4VuB8tWxx8SEth/CPoviyDf9g6Bna4FYi/UNIOM/?=
 =?us-ascii?Q?Okl7EWG1Lxb1fzgkmC/bpWvqXeNWvGds9m1dUDNPMugU5VtOtvlIRBWhZdUm?=
 =?us-ascii?Q?hM1ZRnk87jx6cgWBoQP+flR0DVVIWjDoZqWx72BFxBFfpXUz5bsJULhEPJoc?=
 =?us-ascii?Q?dNtgXjscvIlTGIZtN1EjLoNpGZJUj0EjFcBPkXM6pJ8V9F/JhnRskq9jNCCQ?=
 =?us-ascii?Q?06gcSG0jZeMlpVH6GMfT8FgMi2Y9ksSQggxt5n7mI3vRI+bbXvdoVYAai7rD?=
 =?us-ascii?Q?7A0crUbC5EkuXQUs5S72PZVnR9ZmNNxJ46miMzTdcVWnJkF1tYGLOUx3xi7M?=
 =?us-ascii?Q?B/nQGlMCY5BORKCFeyh0YTXorLgbFMen8t/Qw2vOuBKr8A0OWrx55Buu9DbG?=
 =?us-ascii?Q?GKdLDL2B+l/GGGKRjlN12pVtMfF6jddXr+2pUTxxjqnYhtT/iIHWCZQCXy0x?=
 =?us-ascii?Q?d4RJuwnG8pbwPiJxnL8B80eX+eJZivJ/O+tlHZlcqBOQt6h3ztnv+UzQMx1e?=
 =?us-ascii?Q?7kbGBYJy9Rfp0o+Sb6fOiNeIm+k0AdfLd3fsDSRyA3VDY831H9cTvh1oQULe?=
 =?us-ascii?Q?AhBGrgTeMY8Zn8BdlR20VSU43WxwN+ODH5TOSFVFl5vxBlPhQjMp71Vriv+D?=
 =?us-ascii?Q?DV06+DR5DUwAhaRV2r2vcb65Ym/JxFzVsixUW8u/hC/R/BvaAhUh891yKN9b?=
 =?us-ascii?Q?1OrHm6PIjdL1ApHwb7X4gEFKOL+eOk9lLC7wSIIw7gBj3zoRqNb9o+rYwHkV?=
 =?us-ascii?Q?YUsg1jQHcygRtffOx51Gl0BiwdL9T8XbUQBSO+ByUoiaMKAlEiqghq9sRJJ/?=
 =?us-ascii?Q?9mzeSL/rRc4ko3Pj2/vQrgN1o3Ct9/Za1jvb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:14.7600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df53c9c0-e0ed-4996-c8ca-08dddfc35e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
Received-SPF: permerror client-ip=2a01:111:f403:2417::60c;
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

Refactor the DDR aperture regions creation using the VersalMap
structure. Device creation and FDT node creation are split into two
functions because the later must happen during ARM virtual bootloader
modify_dtb callback.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  7 +---
 hw/arm/xlnx-versal-virt.c    | 79 +-----------------------------------
 hw/arm/xlnx-versal.c         | 73 ++++++++++++++++++++++-----------
 3 files changed, 53 insertions(+), 106 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 7be5a6ccf4d..a3bc967c352 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -41,15 +41,10 @@ struct Versal {
 
     /*< public >*/
     GArray *intc;
     MemoryRegion mr_ps;
 
-    struct {
-        /* 4 ranges to access DDR.  */
-        MemoryRegion mr_ddr_ranges[4];
-    } noc;
-
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
         uint32_t gic;
     } phandle;
@@ -71,10 +66,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+void versal_fdt_add_memory_nodes(Versal *s, uint64_t ram_size);
+
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 3003b0816be..2ca4a80dd00 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -104,92 +104,17 @@ static void fdt_nop_memory_nodes(void *fdt, Error **errp)
         n++;
     }
     g_strfreev(node_path);
 }
 
-static void fdt_add_memory_nodes(VersalVirt *s, void *fdt, uint64_t ram_size)
-{
-    /* Describes the various split DDR access regions.  */
-    static const struct {
-        uint64_t base;
-        uint64_t size;
-    } addr_ranges[] = {
-        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
-        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
-        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
-        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
-    };
-    uint64_t mem_reg_prop[8] = {0};
-    uint64_t size = ram_size;
-    Error *err = NULL;
-    char *name;
-    int i;
-
-    fdt_nop_memory_nodes(fdt, &err);
-    if (err) {
-        error_report_err(err);
-        return;
-    }
-
-    name = g_strdup_printf("/memory@%x", MM_TOP_DDR);
-    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
-        uint64_t mapsize;
-
-        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
-
-        mem_reg_prop[i * 2] = addr_ranges[i].base;
-        mem_reg_prop[i * 2 + 1] = mapsize;
-        size -= mapsize;
-    }
-    qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
-
-    switch (i) {
-    case 1:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1]);
-        break;
-    case 2:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1],
-                                     2, mem_reg_prop[2],
-                                     2, mem_reg_prop[3]);
-        break;
-    case 3:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1],
-                                     2, mem_reg_prop[2],
-                                     2, mem_reg_prop[3],
-                                     2, mem_reg_prop[4],
-                                     2, mem_reg_prop[5]);
-        break;
-    case 4:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1],
-                                     2, mem_reg_prop[2],
-                                     2, mem_reg_prop[3],
-                                     2, mem_reg_prop[4],
-                                     2, mem_reg_prop[5],
-                                     2, mem_reg_prop[6],
-                                     2, mem_reg_prop[7]);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    g_free(name);
-}
-
 static void versal_virt_modify_dtb(const struct arm_boot_info *binfo,
                                     void *fdt)
 {
     VersalVirt *s = container_of(binfo, VersalVirt, binfo);
 
-    fdt_add_memory_nodes(s, fdt, binfo->ram_size);
+    fdt_nop_memory_nodes(s->fdt, &error_abort);
+    versal_fdt_add_memory_nodes(&s->soc, binfo->ram_size);
 }
 
 static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
                                   int *fdt_size)
 {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f46c73ac8e7..bf680077e48 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -115,10 +115,15 @@ typedef struct VersalCpuClusterMap {
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalMemMap ocm;
 
+    struct VersalDDRMap {
+        VersalMemMap chan[4];
+        size_t num_chan;
+    } ddr;
+
     VersalCpuClusterMap apu;
     VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
@@ -219,10 +224,18 @@ static const VersalMap VERSAL_MAP = {
     .ocm = {
         .addr = 0xfffc0000,
         .size = 0x40000,
     },
 
+    .ddr = {
+        .chan[0] = { .addr = 0x0, .size = 2 * GiB },
+        .chan[1] = { .addr = 0x800000000ull, .size = 32 * GiB },
+        .chan[2] = { .addr = 0xc00000000ull, .size = 256 * GiB },
+        .chan[3] = { .addr = 0x10000000000ull, .size = 734 * GiB },
+        .num_chan = 4,
+    },
+
     .apu = {
         .name = "apu",
         .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
         .num_cluster = 1,
         .num_core = 2,
@@ -1480,50 +1493,62 @@ static inline void versal_create_crl(Versal *s)
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
 }
 
-/* This takes the board allocated linear DDR memory and creates aliases
+/*
+ * This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
-static void versal_map_ddr(Versal *s)
+static void versal_map_ddr(Versal *s, const struct VersalDDRMap *map)
 {
     uint64_t size = memory_region_size(s->cfg.mr_ddr);
-    /* Describes the various split DDR access regions.  */
-    static const struct {
-        uint64_t base;
-        uint64_t size;
-    } addr_ranges[] = {
-        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
-        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
-        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
-        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
-    };
     uint64_t offset = 0;
     int i;
 
-    assert(ARRAY_SIZE(addr_ranges) == ARRAY_SIZE(s->noc.mr_ddr_ranges));
-    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
-        char *name;
+    for (i = 0; i < map->num_chan && size; i++) {
         uint64_t mapsize;
+        MemoryRegion *alias;
+
+        mapsize = MIN(size, map->chan[i].size);
 
-        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
-        name = g_strdup_printf("noc-ddr-range%d", i);
         /* Create the MR alias.  */
-        memory_region_init_alias(&s->noc.mr_ddr_ranges[i], OBJECT(s),
-                                 name, s->cfg.mr_ddr,
-                                 offset, mapsize);
+        alias = g_new(MemoryRegion, 1);
+        memory_region_init_alias(alias, OBJECT(s), "noc-ddr-range",
+                                 s->cfg.mr_ddr, offset, mapsize);
 
         /* Map it onto the NoC MR.  */
-        memory_region_add_subregion(&s->mr_ps, addr_ranges[i].base,
-                                    &s->noc.mr_ddr_ranges[i]);
+        memory_region_add_subregion(&s->mr_ps, map->chan[i].addr, alias);
         offset += mapsize;
         size -= mapsize;
-        g_free(name);
     }
 }
 
+void versal_fdt_add_memory_nodes(Versal *s, uint64_t size)
+{
+    const struct VersalDDRMap *map = &versal_get_map(s)->ddr;
+    g_autofree char *node;
+    g_autofree uint64_t *reg;
+    int i;
+
+    reg = g_new(uint64_t, map->num_chan * 2);
+
+    for (i = 0; i < map->num_chan && size; i++) {
+        uint64_t mapsize;
+
+        mapsize = MIN(size, map->chan[i].size);
+
+        reg[i * 2] = cpu_to_be64(map->chan[i].addr);
+        reg[i * 2 + 1] = cpu_to_be64(mapsize);
+
+        size -= mapsize;
+    }
+
+    node = versal_fdt_add_subnode(s, "/memory", 0, "memory", sizeof("memory"));
+    qemu_fdt_setprop(s->cfg.fdt, node, "reg", reg, sizeof(uint64_t) * i * 2);
+}
+
 static void versal_unimp_area(Versal *s, const char *name,
                                 MemoryRegion *mr,
                                 hwaddr base, hwaddr size)
 {
     DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
@@ -1687,11 +1712,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
     versal_create_crl(s);
 
-    versal_map_ddr(s);
+    versal_map_ddr(s, &map->ddr);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     ocm = g_new(MemoryRegion, 1);
     memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
-- 
2.50.1


