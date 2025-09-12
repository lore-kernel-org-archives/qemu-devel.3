Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA31CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0df-0008QW-7i; Fri, 12 Sep 2025 06:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ck-0006wi-Eu; Fri, 12 Sep 2025 06:03:22 -0400
Received: from mail-bn8nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2418::630]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cZ-0001Lj-DQ; Fri, 12 Sep 2025 06:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at5lsFOoFLENBhLGN6Ws5c1UcCHWgU2TAJLK4RqgJKCFuRb1hxgFGL2BR1QBKUMpBNl25XeYQtFwrcpTr++qF646tty2XwBM/REgEfYLHvy3b5itI6Y+1UWL03OeL/UZWARBHt5RB8Vs4aXOuQN9mLFHKCSJvYVUhZG6exJ87lnXFMbfKKFEtG+oYTcvOtP70RMC60nTeTtVZWa+9JDcMTz3UiX4IT8CcFXJiYhF7VyBIwPV5xcCtK/hQqPfx5KgQ4AO7lODzlNyenG9uwxpQXDvmsM6DMaZwz/c27UbUIoetc+ULvxYrW/upTa/np0pZfl+MFTfMC+bly7Gf3UAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqW9JZhzEw5I9CQzO3LREAfcJX48F0Qsf7nC4SXM6RE=;
 b=AhVHlHdo66MmjysSgU9lq9OdYayIXrf8qclK/4McYixbJ8nwrCjtJyO3mtdJFZUDEJxDti8p07v+msbRF7jk7SHZtHKcGOgwJs07eHc3mPAlSJDVh/sSVC2aFiGG99S7ztM8SXqAOTKRFqws8IfFuN8UW62D1ShitTy4VUqiDbPmQFDlmlOjGN5/Zpa72eNsDtU1z+f38YTzWKeAq8O01sWtmWMLY++p8l3T26sJabBr4SGQtTfoZWKpB6hfkbzbJo3Hkvtr2GGmllBEWhMnCnDndYz2TM2PMmc6ViHuXOvJqJXrj652bDZAiNkwc/Cg5z6xXsgD9aPJC1vKi7N65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqW9JZhzEw5I9CQzO3LREAfcJX48F0Qsf7nC4SXM6RE=;
 b=x3L6GTfDTfP1rAgHXnIuuWJJ8nP33ghD8+dLloh+/uE2h1Wjq8q+xc230yOmRsKAqYp6Sg5z+8gyHSAOfVAqOcJw0jHKKmMrXijBtTt1oCNdA3O8qbvzqtbtEZJJFmcfa4ayE/LSULP7huxom/PDvyMQNlg9IE48CehidXYjaJM=
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 10:03:04 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::27) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:11 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:11 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:10 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 28/47] hw/arm/xlnx-versal: ddr: refactor creation
Date: Fri, 12 Sep 2025 12:00:37 +0200
Message-ID: <20250912100059.103997-29-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b7e545-12c9-4768-a71a-08ddf1e390dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uZIjKtWewDK7aZ41QwDUiKBBz9BUuUiIfs/oQwQU3qx7uCweE11+j4SxxHkZ?=
 =?us-ascii?Q?P8mgSEobRddGzpMOwnULM8jnh7YPvcQe3EN0oDEdRKns9CfJeFYuxbWaWefX?=
 =?us-ascii?Q?LE3EsKLv7xlTQP7bQlusaZmPm/rGyrbvROhHymUcEaV46je4LJvmBMsBDYyM?=
 =?us-ascii?Q?Ee+Ns4LMbO8GjqTYpiBgP9HkHLmejJWgPbJD+OszBSdx0tg6nh1hJ8+o5OqL?=
 =?us-ascii?Q?Y09fGJA7CdrX0bcL7M43xsTjeLAwcXzpJQpoaXrZSXFRk6z2KsXJ209YucJR?=
 =?us-ascii?Q?rCaX/A6o2YyrCNlEFFjRMkMM3NxGO09yHHom1BXwW9wG8YE3fySORXu2gZJp?=
 =?us-ascii?Q?iRofJhM3EPz8uAhF7TiA9NFeK2Bg5Pdlo7pkat2f7HIAQWYjqIsw1+hyr+K7?=
 =?us-ascii?Q?c/oZcMQxEQyTzj5ZztdaBo6idxbwiYYo5+bdVrTw6Nyd3z8cgXLKez0hPGuS?=
 =?us-ascii?Q?lJuVgn/1gRpPtroPLdqAE4MTmcxO/PfeR+cCRi43i9KdnP8thcKc9vtWJbVl?=
 =?us-ascii?Q?BIC59ijDzgu5Pxtz2PjfLzPrjNzkGU1PRXXyb/0xVjPimegv1+YffxxJXhwa?=
 =?us-ascii?Q?3PM39rzGckIIC5NFGDQvN1pIwJ9zK4ywvZYd31n4mVz7UUh+RVL5IstP4aJp?=
 =?us-ascii?Q?IxyyKkgwmkdEVDrE1aVN0wFw700IJ8SsB+rnAUDTPUg/Q7qWvUpj57MqeC5R?=
 =?us-ascii?Q?84CrnJKJ6vvhMQXvpWuCkzPT3Pe+Td3PgBZBDBwTYV2DORhaV4GGQ0cORegH?=
 =?us-ascii?Q?0hfaEBXIW3+E79krZKDzjUrup09zZ8v7EZSgpEnGu6NUSxSq5JPfLvA3sC37?=
 =?us-ascii?Q?iNoKTacUqHAVTmXAvXZLbe35QGE8tr8bJb5KGSx0UWihWQ0PPzAlGbWRfn1Q?=
 =?us-ascii?Q?N2iwygVOBgZjPo9uhTYJcQsFQClzcme/Aha7KPoGcKrRXy23FuECzb0gE5GN?=
 =?us-ascii?Q?dQ9PL5WcT6YhCuity2d8gb3jb6wxFYPrwrBV44a4w99RYGz+YOJmS6+hvdqH?=
 =?us-ascii?Q?XZUkgp2+YAm/i4RhRwn8o5vd81dXDCVBIM1KqM5enwlwVfKDE09D1B5OKY/N?=
 =?us-ascii?Q?JSSgKxkMKKb0OnWufJsi4WDIfnps/aB1e9v3KynoKe5KleBf0I4B/5m67HK2?=
 =?us-ascii?Q?4GpN/iBJXMf5rw87MBFe+Jwwnv++yj3WXJBAJbGR7hhDeiq1IIfLPhJNWG+W?=
 =?us-ascii?Q?5qKAaR5d4pvaIUJcHrdneVOFL1ceXuK//s4m4tAfgtoNZrXGAXUJtD+eszwl?=
 =?us-ascii?Q?F49Mbn/hb7iHTkyVmf/WKvFvSQ3tpSyTz3DNhF/fmGmKyYsYkSK/wX58JuH8?=
 =?us-ascii?Q?xWkAmbKfgBJJVnpltR5QAqpBzI2IOsE6TfmhCBjzZxrkLWYPCuPDL8lNVbVm?=
 =?us-ascii?Q?509g08EpR01HapK2gLtzh+Dbt6eTQU59w/5UYRReYlcOukZPWUXjjbfEU5/K?=
 =?us-ascii?Q?wLXtcGwBAw5/65WQlKkdpHCx3bKvNYzGWjWcEgzV2PY3+4d/UIZ0CcQlwnZu?=
 =?us-ascii?Q?b9o5kCwsPpA2FxKVvGwW8kM2Ng2eU2Kb5IcK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:04.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b7e545-12c9-4768-a71a-08ddf1e390dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
Received-SPF: permerror client-ip=2a01:111:f403:2418::630;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
index e1d6e545495..39bc414c85c 100644
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
 DeviceState *versal_get_boot_cpu(Versal *s);
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 5958e712519..ad7b3135a67 100644
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
index 207d55c062a..f7680cc1254 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -113,10 +113,15 @@ typedef struct VersalCpuClusterMap {
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
@@ -217,10 +222,18 @@ static const VersalMap VERSAL_MAP = {
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
@@ -1481,50 +1494,62 @@ static inline void versal_create_crl(Versal *s)
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
@@ -1694,11 +1719,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
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


