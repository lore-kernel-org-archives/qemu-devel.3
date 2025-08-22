Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D6ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTX8-00008q-J2; Fri, 22 Aug 2025 11:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWV-00084U-Pr; Fri, 22 Aug 2025 11:17:57 -0400
Received: from mail-mw2nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2412::609]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWH-0007DS-73; Fri, 22 Aug 2025 11:17:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnPHKP7YTqtWZg1NNwAtUlUeNJhI8znz8B7xPQZgEvWTekzBseAhn5TiRzMwrr//4Zrp54o/Hz0K+FNTYqbeYn9N7Os32aC2NeteRY5nJ41t6IHZpmroBeYbfOD6Z1a/Q6llqh34qj02eHBwmqxtJdx4QjFf2yuSj2FmRbUszVbx+hs5aAFk/KuP9wAXL1dWm4R9LpJQbjW9zzqVpkBKvAdtX1Lfh9KGL1skIWD3xwj4IWCKng9B0NZLcKX8rVQln3vYgUoGQyI1FNuBR9fjUt96VYoaiSLRG71eux2RFj7gc6adDjbv8KZIyoPf8kuK94T3HY7cGrTBwoo7Cu84iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sS+TYgSXttPi4fjh4DuRaTXTJZT5HNwqdwvbgSsawU=;
 b=em4BSbEZU6EbTlKQt6+Xidf3Bg4ARp+FpIPTBFwNyEWE8CekWffy1gqNAJ/a2dt9cbJnUbxRRiF+mdpyDwOSVUQQY+6lr3ZzVcMMtPsO1aJVhejOJQ448lEKzC/U+QvTxCG7QhEPhAsBpmg5KuCXqySfQTIpKci5ikOB82JRWOiGD8ppKeKSczAxCb8jnYWx+kLvRY9+XViTiw90PIEECs2Qr8eRapi2kjU+kRZbw2M/JOzsZWyc0Tk0DTipFzySf+MsN7nDqdsjd4wNB5rDn2FpXFFpwW0eFFUJijJs3rBYCjz1NHc8x8Oo8m+BFnjZPV5OJ6kaebpcWqjQp4MkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sS+TYgSXttPi4fjh4DuRaTXTJZT5HNwqdwvbgSsawU=;
 b=UE4kqCOkK3fh9As5Qi1ulK4efoo/96+S3SHMW/YDbRRmp8E4qozZfFBku/802QPtS/DPcm7tNA+d/CLDvc2idys8lASrcA70vo5Jd/UIb7KKDJqcZIVVKyF22WDNdsK8J2G7x7tfJh6tgyO1xEc2PUVy/prUKJegSEdmC6iOfvw=
Received: from DSZP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::11) by
 SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:17:21 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::33) by DSZP220CA0010.outlook.office365.com
 (2603:10b6:5:280::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:20 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:19 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 28/47] hw/arm/xlnx-versal: ddr: refactor creation
Date: Fri, 22 Aug 2025 17:15:53 +0200
Message-ID: <20250822151614.187856-29-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 466d895a-6c19-4a15-65f1-08dde18efdd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZSFkQi9iU/l+EFeG94e/8kt/aZpHWzhJSonX4EXbNCY0YZgGRXrtIXYLmf1B?=
 =?us-ascii?Q?/tPzluCM2+jgKp/6ltzWqKfQCNr90MN/w5HQ8+nEa2BHeI6hz/4Tlkb8HQ2r?=
 =?us-ascii?Q?DOwO2g5TlnZ2MPSNDSr5RS8yd0xnwt+iMpx9lBC0LtyzcZTZonwUmjTy5FjF?=
 =?us-ascii?Q?ohYXlPksNVmWPYRVmmCLss7KQeT2ykrf97YDvBsIkuWwOd5X98f2L579bF40?=
 =?us-ascii?Q?1d8KCmZg3JCBnc1iBDd40obrznJZNzKyZE6ywRTj6Xyv4epmcXkSP+zRIWfS?=
 =?us-ascii?Q?xjDAYGBBfFtrLqGae6h9ijUmodO4l2nQwz8IyrlNuhHW+YxLbZPvitzaHMMP?=
 =?us-ascii?Q?mGPuGKUOcbV5pXIDumtdyo7ZQkZrqeibiii+MEteOv4l1zXerDzCuxrmSA6Q?=
 =?us-ascii?Q?xYVRtBOXTJreoYxQN2htdpvldGcKSlltm4bGqKJ/VGayiKdfRZ7FGVWEM3yg?=
 =?us-ascii?Q?czy5+cmoI0Zugffe40x5kD132nUDwbjECTcOa/Whl/iAEeZ7MPbr80Jcy6tG?=
 =?us-ascii?Q?Emob8HrUYuv/iSWcU2JKmgWsHetHU+BFKbghIQaBko0pavhrEQlUn1Az+uJK?=
 =?us-ascii?Q?VIr2UC4cocYmpnWvDzodPl2+2Y9J9X0Q3zxBQkI3aj668qbEYwf8wsgIomDG?=
 =?us-ascii?Q?f1U0l/k5yqqLctQWW/va4vSK0SnEqz5wnj69onkhNhDrhOVRqiQ8oXd2iBAt?=
 =?us-ascii?Q?RRB1CUiMiRH9tjdm4yeV5t9kFdA3cidntDUJZujPuaQlFr6Y+HlSuLRZYAOL?=
 =?us-ascii?Q?V/2xmxy2JMD/52FzQYmMPlw8KI2pKjsvq5bQx67IkKMxZ8MdBB/t/HOGNZfp?=
 =?us-ascii?Q?6VSr40L9rBhHsnEj6hG+qEn49sNj+RactC6z/yVC01UFfVgQZVtxFpOOAnDj?=
 =?us-ascii?Q?fdzp651PFJxwuErooPO4l+8fD02OE6KB7pKN/tImJ27AZy7ZRSOd/S+IyfYU?=
 =?us-ascii?Q?1PE4fRv5kAXr6BqB15bc8OxwAIYWjse3TWKVWy2LZOFiHBbdS2NH+fR4NVXZ?=
 =?us-ascii?Q?kCtocEQyR8kmbanI6EZheLrI5OlnAPO1TovC+Rq/ji8bCDGJgdpTB7vhpXF9?=
 =?us-ascii?Q?SeynJ670AJ7h0tWV0jMfv4uYvnYykxF2016a0NpL4AWDxE/Qob8u74e7iM43?=
 =?us-ascii?Q?pBAkuEwtQGAnVAXEJD+Li6swRxiO1uMsHsGwXF9LgbrtATe8prIuC/r9+dG4?=
 =?us-ascii?Q?ZZbBfnaiRmUCLKpx0tburukVoTeUEKzHxaGtb6gUklqP7qIiGEI4YLc+s4we?=
 =?us-ascii?Q?aXgQITpi7/hTLAt8HpTFLeorgTRwfajUXAiVcSmsx/72NpiVUr9urKoFy1hJ?=
 =?us-ascii?Q?al3O2WZ730Y4k6DBs8HV1ZXfvl3wg35xLtLx1sYZncOmBuwaPE4q1Ru1tTjh?=
 =?us-ascii?Q?vy+Z3DKYqkSaiq0O+98oWeHMimlmHeAxq4Hr23DebhrmN1suJCYmZm69GA3X?=
 =?us-ascii?Q?GzlUtdMIvOSVGGcF9ylyOq8jdAyg3EiOJ1DiRGJ83/E9ZNkYMCz5Oct9LVtG?=
 =?us-ascii?Q?OWrmSggpR8UEWxuvE/bgQSRvdB/D0B0OcmXt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:21.5826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466d895a-6c19-4a15-65f1-08dde18efdd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1
Received-SPF: permerror client-ip=2a01:111:f403:2412::609;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 72b40d7b920..2a0aca74708 100644
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


