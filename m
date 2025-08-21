Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DC5CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50i-0005Iv-Oh; Thu, 21 Aug 2025 09:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zI-0002fM-1m; Thu, 21 Aug 2025 09:05:54 -0400
Received: from mail-mw2nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:200a::612]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z9-0003GP-Mu; Thu, 21 Aug 2025 09:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOGjUKmQ7E6Q0bA6b0ZQfQRvacH1ppCZvc6AsSljnhlcoJIjz9kataB5QF0PI7RRppSLEQF5Ir60pijeZB2zDLTiL20XdB9mFME81YWbPJpSuF2c107aWnWkTbUAYSsloGkRil/DVSdbxO4unog8wUM/oUH5szFj7uxPMvMvDhWpV6QJvoZCD1bFopB6WcLl4ePFF9l3rkVAx4ztdbPAYuQRcr2+wEaoYtsGnfJ4llMwXuEY/Pc2IR32ouAXMm4InQKlIITstmmEwr03BpOYglmabuZimis3Me1GFpij37W2eftqpQwbvDXLPI4uVMCNFWjKjYpvlzwbrve8RO9IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHUeStJ/pZhP3PKoWuPr9Yw+jE/sHp71UfDmbN2EMfw=;
 b=aLhcAAoJcv1dmTqSaS7Llo/16cnzfcL3gvukBiwORC5aNJwyYkMsFxXkzDK87plGo0fyVMlpXeE0ecoGcD8wJKO0gVA4E6O81yBD3JGgtYxIIi6MgUoNwtCH+v2JOqEuf3QBxOE09rXjtNH3Rk99la0q5rNuGyhUNs1sa1fDNjXSHQ/iCXqNh50lKNZmyWE3F2EFoWhk4OxdxdaP0SLM2f016cRoaPbI34tbE2m6lkrraTZsPkZVKyfXhdudh1ov23MCANjxNUCttD/R6c+xpjMSd70FkNFb8JdCO3VyWwFheLTz+sNB4Knk2t+CTFgTmYse+Dwpf8LqRtgmIwLZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHUeStJ/pZhP3PKoWuPr9Yw+jE/sHp71UfDmbN2EMfw=;
 b=ecVfCp1+f0uAsLloaUzb41wrPQXXEMgq36iz3JaJuJ69G/iXTcn6LSeQzp7jDTqrORHpO3T+R5+B+uQ6YicKkAsDxv5S22kvACDhy2cRwW5o1IvE+qfqEC1uZdCjNyxtZTeAeEGHdmW/Ae2CKjTz3pczGCcxEKm82H6p09JETyU=
Received: from DM6PR07CA0094.namprd07.prod.outlook.com (2603:10b6:5:337::27)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 13:05:29 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::b7) by DM6PR07CA0094.outlook.office365.com
 (2603:10b6:5:337::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:18 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:17 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 40/47] hw/arm/xlnx-versal: add versal2 SoC
Date: Thu, 21 Aug 2025 15:03:39 +0200
Message-ID: <20250821130354.125971-41-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed32147-b805-4839-060f-08dde0b366b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hjGLOLtoclv2+zZ3eEr8E3WA0b4sgALOTJ3AsTnj42cvWM4YFXX2by4f/Hip?=
 =?us-ascii?Q?HGiFw1rixaaCJWxUnNnP80yDdAD1nUEbRdopsioKZzhg+E5glhBy7ktGAqwH?=
 =?us-ascii?Q?U5WWa8RW7BufRpK9nPvcGvs0/kVk3xQzvct5PM104993NVmly0v40ZMV2OQ8?=
 =?us-ascii?Q?BYqdHjq+9yTbMqmw7MVAiM75ESx7INArCScaFcR61I5zwVk6bfMagcKTx5jU?=
 =?us-ascii?Q?YSOiZWoSySzs4na6ugEdrLH/thR7UMIbofmrLTi5tGbtqrkXkLihvr4RjR/r?=
 =?us-ascii?Q?VJELjbLOF6aeuHQMvC9LiV63OABshr3agBXw8K76QLDTS2FbakMGNocUQ3EB?=
 =?us-ascii?Q?Spjpb9CkIlfgWKlBKL6UJeqPtMk0B9EXvxF/53nHxLpkp1zmLgyWytiKwcFB?=
 =?us-ascii?Q?rKlCzJ0UqRwZSak8sHeu9kXuTeXu2HJuyt03kF+9lL2RPhneKYaxqGip0W64?=
 =?us-ascii?Q?uXRdjfBQaZX/C79T0RJWYIUeICpVJCIU5NUkmuhuCyAPlyk4BfziNC4nXhfv?=
 =?us-ascii?Q?QjCxEvcp+5iFLwMLxtqysAZVZU3KdwrXFoQCnxDpxLbr4FI1pkFHoXR3E3nz?=
 =?us-ascii?Q?KX4mwPJFA0bLQJC7WlFNCLUTikQw9SIhJccw9QAB6oDR8Lc7cDLT6fqOXrmJ?=
 =?us-ascii?Q?eNbsLQ/SQcNDl3CYIvPar2m8ZroI5Q4wJBl850yNYPam5z/7dacfjCWDQL9m?=
 =?us-ascii?Q?m97TtrnBwWKMhIfthbiRB/xFRr8IqH+NvqtSexm6NEGNCk9VeMMlaqiNRQVr?=
 =?us-ascii?Q?M739R00BPVntEVa5K+Xw6RFAlSk8KB4rMAgBuE6AUO98w2CUn46+9iaFemKl?=
 =?us-ascii?Q?I9Y9c6d7bbAGYurXAYpT6UXlFAUSySNEXXAhxROOUmM29jiTeOeTnX8oj0gI?=
 =?us-ascii?Q?/ZQhLYKykZkMLTzy/QMMs46+8kUS7sqip2+yQaXFZF1KHR1QMoGUUueXqvFd?=
 =?us-ascii?Q?II0gblTjB3YmQxTIKXV/b/2/wAqpQFxCHWx/65pxVDkOuoK7FBs12T4nYUL3?=
 =?us-ascii?Q?8VMHSZM2xKKZVoQKABHCTxDYSBeiAi13TCUJQgZuO6gcupFHmwvBEpEojB6U?=
 =?us-ascii?Q?1eVpeGPGmnn7e/ugr4prbucna5grI2UnU9Yce5xJMSJbVfZ9uq2pUYZmtv3/?=
 =?us-ascii?Q?zPvH/4wR7EjcKbP/5bY5TmBBrYKFr8qhVnxe1IzOyOr7kV2L3nEqVA1Byxpl?=
 =?us-ascii?Q?ylfugtiGCWRSdYsHbVUTDHY41Lu8jbhQTHlDUJq6DilbdNA5wQl91Qdrd/jD?=
 =?us-ascii?Q?X33SoMHoKmihyZdrzuzXUbyspNMVUzDISUGI/Sq3Ie1xRLH0ULJv9dDz0cTy?=
 =?us-ascii?Q?BvtUjyCBdAPo8+ZyzVeXRLvhmrbcoBbFHEiyx2PNLif/1rZyyI3lLvDnMNSk?=
 =?us-ascii?Q?oRa6WtW16KJViRbOXvEkz3He1/difsN3tK+BPxiORLYU+El6GxqYAb2FW3ET?=
 =?us-ascii?Q?/QXfjGRb/2kbhZTDfD6y4DX8G+TkzlxjaikHRZMtanAKGDxwniqNsaDY8JS2?=
 =?us-ascii?Q?FuU4gDgWnbdbHBYVHFHEMkVpoRzfD8W/4gVO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:28.2566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed32147-b805-4839-060f-08dde0b366b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
Received-SPF: permerror client-ip=2a01:111:f403:200a::612;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Add the Versal Gen 2 (versal2) version of the Versal SoC family.
This version embeds up to 8 Cortex-A78AE cores (split into 4 clusters)
and 10 Cortex-R52 cores (split into 5 clusters). The similarities
between versal and versal2 in term of architecture allow to reuse the
VersalMap structure to almost fully describe the implemented parts of
versal2.

The versal2 eFuse device differs quite a lot from the versal one and is
left as future work.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  17 ++-
 hw/arm/xlnx-versal.c         | 207 ++++++++++++++++++++++++++++++++---
 2 files changed, 209 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b6cc71f7209..e1fb1f4cf5b 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -1,7 +1,7 @@
 /*
- * Model of the Xilinx Versal
+ * AMD/Xilinx Versal family SoC model.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -20,10 +20,11 @@
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
+#define TYPE_XLNX_VERSAL2 "xlnx-versal2"
 
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -70,6 +71,20 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
 int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
+static inline const char *versal_get_class(VersalVersion version)
+{
+    switch (version) {
+    case VERSAL_VER_VERSAL:
+        return TYPE_XLNX_VERSAL;
+
+    case VERSAL_VER_VERSAL2:
+        return TYPE_XLNX_VERSAL2;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index b6d99f5e103..4919061849c 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1,7 +1,7 @@
 /*
- * Xilinx Versal SoC model.
+ * AMD/Xilinx Versal family SoC model.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -350,12 +350,128 @@ static const VersalMap VERSAL_MAP = {
     .crl = { 0xff5e0000, 10 },
 
     .reserved = { 0xa0000000, 111, 8 },
 };
 
+static const VersalMap VERSAL2_MAP = {
+    .ocm = {
+        .addr = 0xbbe00000,
+        .size = 2 * MiB,
+    },
+
+    .ddr = {
+        .chan[0] = { .addr = 0x0, .size = 2046 * MiB },
+        .chan[1] = { .addr = 0x800000000ull, .size = 32 * GiB },
+        .chan[2] = { .addr = 0xc00000000ull, .size = 256 * GiB },
+        .chan[3] = { .addr = 0x10000000000ull, .size = 734 * GiB },
+        .num_chan = 4,
+    },
+
+    .apu = {
+        .name = "apu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a78ae"),
+        .num_cluster = 4,
+        .num_core = 2,
+        .qemu_cluster_id = 0,
+        .mp_affinity = {
+            .base = 0x0, /* TODO: the MT bit should be set */
+            .core_shift = ARM_AFF1_SHIFT,
+            .cluster_shift = ARM_AFF2_SHIFT,
+        },
+        .start_powered_off = SPO_SECONDARIES,
+        .dtb_expose = true,
+        .gic = {
+            .version = 3,
+            .dist = 0xe2000000,
+            .redist = 0xe2060000,
+            .num_irq = 544,
+            .has_its = true,
+            .its = 0xe2040000,
+        },
+    },
+
+    .rpu = {
+        .name = "rpu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r52"),
+        .num_cluster = 5,
+        .num_core = 2,
+        .qemu_cluster_id = 1,
+        .mp_affinity = {
+            .core_shift = ARM_AFF0_SHIFT,
+            .cluster_shift = ARM_AFF1_SHIFT,
+        },
+        .start_powered_off = SPO_ALL,
+        .dtb_expose = false,
+        .per_cluster_gic = true,
+        .gic = {
+            .version = 3,
+            .dist = 0x0,
+            .redist = 0x100000,
+            .num_irq = 288,
+        },
+    },
+
+    .uart[0] = { 0xf1920000, 25 },
+    .uart[1] = { 0xf1930000, 26 },
+    .num_uart = 2,
+
+    .canfd[0] = { 0xf19e0000, 27 },
+    .canfd[1] = { 0xf19f0000, 28 },
+    .canfd[2] = { 0xf1a00000, 95 },
+    .canfd[3] = { 0xf1a10000, 96 },
+    .num_canfd = 4,
+
+    .gem[0] = { { 0xf1a60000, 39 }, 2, "rgmii-id", 1000 },
+    .gem[1] = { { 0xf1a70000, 41 }, 2, "rgmii-id", 1000 },
+    .gem[2] = { { 0xed920000, 164 }, 4, "usxgmii", 10000 }, /* MMI 10Gb GEM */
+    .num_gem = 3,
+
+    .zdma[0] = { "adma", { 0xebd00000, 72 }, 8, 0x10000, 1 },
+    .zdma[1] = { "sdma", { 0xebd80000, 112 }, 8, 0x10000, 1 },
+    .num_zdma = 2,
+
+    .usb[0] = { .xhci = 0xf1b00000, .ctrl = 0xf1ee0000, .irq = 29 },
+    .usb[1] = { .xhci = 0xf1c00000, .ctrl = 0xf1ef0000, .irq = 34 },
+    .num_usb = 2,
+
+    .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 230 },
+
+    .ospi = {
+        .ctrl = 0xf1010000,
+        .dac = 0xc0000000, .dac_sz = 0x20000000,
+        .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
+        .irq = 216,
+    },
+
+    .sdhci[0] = { 0xf1040000, 218 },
+    .sdhci[1] = { 0xf1050000, 220 }, /* eMMC */
+    .num_sdhci = 2,
+
+    .pmc_iou_slcr = { 0xf1060000, 222 },
+    .bbram = { 0xf11f0000, PPU1_OR_IRQ(18, 0) },
+    .crl = { 0xeb5e0000 },
+    .trng = { 0xf1230000, 233 },
+    .rtc = {
+        { 0xf12a0000, PPU1_OR_IRQ(18, 1) },
+        .alarm_irq = 200, .second_irq = 201
+    },
+
+    .cfu = {
+        .cframe_base = 0xf12d0000, .cframe_stride = 0x1000,
+        .cframe_bcast_reg = 0xf12ee000, .cframe_bcast_fdri = 0xf12ef000,
+        .cfu_apb = 0xf12b0000, .cfu_sfr = 0xf12c1000,
+        .cfu_stream = 0xf12c0000, .cfu_stream_2 = 0xf1f80000,
+        .cfu_fdro = 0xf12c2000,
+        .cfu_apb_irq = 235, .cframe_irq = EAM_IRQ(7),
+    },
+
+    .reserved = { 0xf5e00000, 270, 8 },
+};
+
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
+    [VERSAL_VER_VERSAL2] = &VERSAL2_MAP,
 };
 
 static inline VersalVersion versal_get_version(Versal *s)
 {
     return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
@@ -1286,10 +1402,15 @@ static void versal_create_efuse(Versal *s,
 {
     DeviceState *bits;
     DeviceState *ctrl;
     DeviceState *cache;
 
+    if (versal_get_version(s) != VERSAL_VER_VERSAL) {
+        /* TODO for versal2 */
+        return;
+    }
+
     ctrl = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CTRL);
     cache = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CACHE);
     bits = qdev_new(TYPE_XLNX_EFUSE);
 
     qdev_prop_set_uint32(bits, "efuse-nr", 3);
@@ -1537,34 +1658,47 @@ static inline void crl_connect_dev_by_name(Versal *s, Object *crl,
 }
 
 static inline void versal_create_crl(Versal *s)
 {
     const VersalMap *map;
+    VersalVersion ver;
     const char *crl_class;
     DeviceState *dev;
+    size_t num_gem;
     Object *obj;
 
     map = versal_get_map(s);
+    ver = versal_get_version(s);
 
-    crl_class = TYPE_XLNX_VERSAL_CRL;
+    crl_class = xlnx_versal_crl_class_name(ver);
     dev = qdev_new(crl_class);
     obj = OBJECT(dev);
     object_property_add_child(OBJECT(s), "crl", obj);
 
+    /*
+     * The 3rd GEM controller on versal2 is in the MMI subsystem.
+     * Its reset line is not connected to the CRL. Consider only the first two
+     * ones.
+     */
+    num_gem = ver == VERSAL_VER_VERSAL2 ? 2 : map->num_gem;
+
     crl_connect_dev_by_name(s, obj, "rpu-cluster/rpu",
                             map->rpu.num_cluster * map->rpu.num_core);
     crl_connect_dev_by_name(s, obj, map->zdma[0].name, map->zdma[0].num_chan);
     crl_connect_dev_by_name(s, obj, "uart", map->num_uart);
-    crl_connect_dev_by_name(s, obj, "gem", map->num_gem);
+    crl_connect_dev_by_name(s, obj, "gem", num_gem);
     crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
     memory_region_add_subregion(&s->mr_ps, map->crl.addr,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
-    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
+    if (ver == VERSAL_VER_VERSAL) {
+        /* CRL IRQ line has been removed in versal2 */
+        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
+    }
 }
 
 /*
  * This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
@@ -1652,21 +1786,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
     qemu_log_mask(LOG_UNIMP,
                   "PMC SLCR parity interrupt behaviour "
                   "is not yet implemented\n");
 }
 
-static void versal_unimp(Versal *s)
+static void versal_unimp_common(Versal *s)
 {
     DeviceState *slcr;
     qemu_irq gpio_in;
 
-    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
-    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
-    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
     versal_unimp_area(s, "crp", &s->mr_ps, 0xf1260000, 0x10000);
-    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
-    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps, 0xff140000, 0x10000);
 
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_sd_emmc_sel,
                             "sd-emmc-sel-dummy", 2);
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
                             "qspi-ospi-mux-sel-dummy", 1);
@@ -1685,10 +1814,29 @@ static void versal_unimp(Versal *s)
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
     qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
 }
 
+static void versal_unimp(Versal *s)
+{
+    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
+    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
+    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
+    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
+    versal_unimp_area(s, "iou-scntr-secure", &s->mr_ps, 0xff140000, 0x10000);
+
+    versal_unimp_common(s);
+}
+
+static void versal2_unimp(Versal *s)
+{
+    versal_unimp_area(s, "fpd-systmr-ctrl", &s->mr_ps, 0xec920000, 0x1000);
+    versal_unimp_area(s, "crf", &s->mr_ps, 0xec200000, 0x100000);
+
+    versal_unimp_common(s);
+}
+
 static uint32_t fdt_add_clk_node(Versal *s, const char *name,
                                  unsigned int freq_hz)
 {
     uint32_t phandle;
 
@@ -1702,13 +1850,12 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
     qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
 
     return phandle;
 }
 
-static void versal_realize(DeviceState *dev, Error **errp)
+static void versal_realize_common(Versal *s)
 {
-    Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
     MemoryRegion *ocm;
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
@@ -1777,18 +1924,33 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
     versal_create_crl(s);
 
     versal_map_ddr(s, &map->ddr);
-    versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     ocm = g_new(MemoryRegion, 1);
     memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
     memory_region_add_subregion_overlap(&s->mr_ps, map->ocm.addr, ocm, 0);
 }
 
+static void versal_realize(DeviceState *dev, Error **errp)
+{
+    Versal *s = XLNX_VERSAL_BASE(dev);
+
+    versal_realize_common(s);
+    versal_unimp(s);
+}
+
+static void versal2_realize(DeviceState *dev, Error **errp)
+{
+    Versal *s = XLNX_VERSAL_BASE(dev);
+
+    versal_realize_common(s);
+    versal2_unimp(s);
+}
+
 DeviceState *versal_get_boot_cpu(Versal *s)
 {
     return DEVICE(versal_get_child_idx(s, "apu-cluster/apu", 0));
 }
 
@@ -1925,20 +2087,30 @@ static const Property versal_properties[] = {
 
 static void versal_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = versal_realize;
     device_class_set_props(dc, versal_properties);
     /* No VMSD since we haven't got any top-level SoC state to save.  */
 }
 
 static void versal_class_init(ObjectClass *klass, const void *data)
 {
     VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     vc->version = VERSAL_VER_VERSAL;
+    dc->realize = versal_realize;
+}
+
+static void versal2_class_init(ObjectClass *klass, const void *data)
+{
+    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    vc->version = VERSAL_VER_VERSAL2;
+    dc->realize = versal2_realize;
 }
 
 static const TypeInfo versal_base_info = {
     .name = TYPE_XLNX_VERSAL_BASE,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -1953,12 +2125,19 @@ static const TypeInfo versal_info = {
     .name = TYPE_XLNX_VERSAL,
     .parent = TYPE_XLNX_VERSAL_BASE,
     .class_init = versal_class_init,
 };
 
+static const TypeInfo versal2_info = {
+    .name = TYPE_XLNX_VERSAL2,
+    .parent = TYPE_XLNX_VERSAL_BASE,
+    .class_init = versal2_class_init,
+};
+
 static void versal_register_types(void)
 {
     type_register_static(&versal_base_info);
     type_register_static(&versal_info);
+    type_register_static(&versal2_info);
 }
 
 type_init(versal_register_types);
-- 
2.50.1


