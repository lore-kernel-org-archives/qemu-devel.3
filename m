Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E095ECAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22b7-0007ZQ-T2; Fri, 26 Sep 2025 03:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aO-0006fE-Jq; Fri, 26 Sep 2025 03:09:45 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a4-0006ev-U2; Fri, 26 Sep 2025 03:09:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMwL3yhWiJByOQsSBPd6R9dtSYjrwO0BCjnFS5Rmfj+WMPWjS9bb3sYo3ZAEqt80nacsyiw3QgUL7xHfg+wudC/FQcDZbx57QIWJTS+uf2pvLJs/jM47yLdEFlx8Nla7dw36rFLmlq0byt2oIzgRpQmgn+KxfcSg9lUVfqAYFby6FrZlqeQ8lj/bYrLNNxRUBLeCn6B6G1OS9osae19o6WRSL+fcXNUqOHRCbPsTLLJ00lbzYuP08ayyegqda+8kSepZBYH73/3bPt6YNCccxbiilBgwbm7Tc3uIhE/BXqPUeDXd2Jo1udXIUoZn/izkmWMM8UJR/lDRG5fOi591Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6NrWzBTDmEMkYhKz7HxgZyNp5UNrOwDhlEJz7pIn4k=;
 b=MpyC0xceJSNcX4KQwMukgcFmMLVMHlhK0EwHPjlwjIxWGU1ROzKiNGU7kQj2AVxmHXLPpb2u42xaUr5p7+rzRVuvq9PX9JfvbEm0P9nsg82Qd5zueFokOWmxDRaZhF2TFgaS4sFrhiWj2sjmYBVYhtfHNrP1YrbgIaC9+acebOP4RkHF19du3G9+UMPm2OhzIpnNiUJNZKESsYtKatYlQMv0RuH+msCqUaOnfMCaYfkmwgIaAfGIFwWwUHNHhYehJwzyRexL9njxucg2l+4A3K8KqeWcbyGa7AclkmblU76BZ3KXQ0mI2BOsOsYBjwliMWRwMriRB4X9V7HkbBVvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6NrWzBTDmEMkYhKz7HxgZyNp5UNrOwDhlEJz7pIn4k=;
 b=lPmf4sTmfy1lyokbQxGXySVv5B14NnzCQOGgeQHEI+klvb4J1hAHaWP3iGR2XUprkZf7LnH2ONO+lwUwbvPDnRz1rl1QlYzjtrm9Rp5WPT9gT48+Cck/m/+Bu5T5ly5M4BhKpBUrb8Eiwny81X3SwdvBnhqR10ZfpQ4MhKiRjBI=
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Fri, 26 Sep 2025 07:09:15 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::9d) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:03 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:02 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:01 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 28/47] hw/arm/xlnx-versal: ddr: refactor creation
Date: Fri, 26 Sep 2025 09:07:46 +0200
Message-ID: <20250926070806.292065-29-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 190d7d93-80f6-4dac-faca-08ddfccb9a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iII9OiDeQFS8FBJUHMBcDgcv9w4Z+JvANGOCy5cXs6ZFp5oCHHSo3kiB4kop?=
 =?us-ascii?Q?qQy/CMvVucIBcXIk7YLRknrkJ+tw3/aVcW2xM+4Vv1NYU+BfIXXUbPjxzBaM?=
 =?us-ascii?Q?Ns03WV33Qvl9kSGbUFx9SIFWOZV0aWzcCBIr3etElQZZgGTNHvTZniksL9rh?=
 =?us-ascii?Q?vZxPJrhXZ1ln6TROxyIwix2unipggFkW0YbkRYLHRxpPVhBUlitxleWsi2vQ?=
 =?us-ascii?Q?Pz9ltCosxO55yH3dfwaTOrS3p78yxcSROLnyGATQXMgR1+CmfnNNnqs0n+nI?=
 =?us-ascii?Q?BpDF3TukrbovOFckkwEH+4x+BW2pSRVCc9a38tSQgCZrluQiOT+iWAg3FWzX?=
 =?us-ascii?Q?LKi3Fu2L3UCdgJjpQRB0FyaOXCEd04u00tQrj3ubeNFas+AWT6oXtcrlT3TD?=
 =?us-ascii?Q?gh6DtuXMaydSfA5utRa/BzM8ksWUyMcRwZLfPj0EPgf7F22IOzx0BqSlBoYV?=
 =?us-ascii?Q?avPV0ryAwC6cvTm4oGAo8vYWeYSnpaMKjR40qkUPl33NJLRhBSx3mSTTyE82?=
 =?us-ascii?Q?RrDPBobYgq0JOsmv1Lwllop7mTf2PCKq4k7K5E6MLyDr3WxGdAezWSQk1edT?=
 =?us-ascii?Q?uQlSK1B5oGc13+xCVKWSMiYGf9/WlJ60Bxcnjxxv2tpTHLu5Z87e+prSMkSf?=
 =?us-ascii?Q?Kab8BDhNN4SX0ogn3U07YuceCzI+GVz+tU2/9u3MYnOM7k4JiNRSOZdUeKWk?=
 =?us-ascii?Q?uhhusswLMZwf1JOpI4p4TZfeZZGKbKVYMT8xT0IU0kJGqLRi5WtS5TFakCmW?=
 =?us-ascii?Q?2bnp2vYvY9CkVegm4uJtRoqi4sQ2nhmHb6B+kxlc9wUUsZKIqkYT1kc6W9Sb?=
 =?us-ascii?Q?0duIH5PQsk5rlD5zDn0oemPwf12AhAEIQNmWQswvymNB3s7vK73FsL3dsv98?=
 =?us-ascii?Q?oa/dcJuX+oMdNaTObVsRlCRuw5m448XuSlBhyWNdT6VuhW+Hrf20Oqwa4mLR?=
 =?us-ascii?Q?5fsQsQ68mPaprOfCvgbQZc3OWAZtCq3twDCfEtWG6lkpguDboevYoy4KizeH?=
 =?us-ascii?Q?DFYRjkt9NQD8abnw0cimQS3n2N4TnJDiEAPc/hAtdGOmqhGepXgBMP6agfrl?=
 =?us-ascii?Q?VJEHis9y2cJnc6IaqbIyQhxy2lSyc+pcGSPrZrbYoZzANNQ7KlIdSG3eURyF?=
 =?us-ascii?Q?4eHMT4MEWTWUuk7GjZx7Q7hmWmgQ7AtRAQ6BdveNGEE0GiCJ1htPr4BIfuef?=
 =?us-ascii?Q?U2h1SmZS771EkysYl7kYmsHNDEBdr3b8U2aj6cSAVhh4ihD6eBI9COZzgLTZ?=
 =?us-ascii?Q?PCgISYpefK+IAhxV06c0DIjTvaNmqPBZKLqedV3GWJx/IKiutKq+GshHeLDJ?=
 =?us-ascii?Q?m4X2ZE1ZqqjzhpY5eDjxPry6kQ98/XnFKJpXSNRLvAeD3LI8ZxCsa8yTnRvT?=
 =?us-ascii?Q?S3kyUCYH5Ub3fhrvfoKZiz9uqvYW8CoNxtzc8/CnW2gZQZ/xmSGnYOSQ1c4P?=
 =?us-ascii?Q?O42OqIGMDWGIwjqNBvLzZTlrHyraCeHNGoifn2tK7KpnYn6udwgJBHbZvSkc?=
 =?us-ascii?Q?04A9CpqOMFnR7x81c854Zuw1FcPlaH0Fh8LGT4EwYJVwO7x/p4+G3O6kBICo?=
 =?us-ascii?Q?IlP9ytYe9E0wgAhN9nw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:15.3825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d7d93-80f6-4dac-faca-08ddfccb9a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 8aa82ceb839..f1b704175ff 100644
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
@@ -1690,11 +1715,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.51.0


