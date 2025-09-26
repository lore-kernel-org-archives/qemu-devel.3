Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B61CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22d3-0001oe-8X; Fri, 26 Sep 2025 03:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22an-0007DI-Td; Fri, 26 Sep 2025 03:10:11 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aW-0006lv-Dw; Fri, 26 Sep 2025 03:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxxzC3KTO4WoFvf+7NTCk1YAH2MYRhGoxOoLYE1X3AyrkdYIjPqnMkjG/YPL4RtaNCJDVxWj9TT/crHoGXIeudNSt/KFLRiZmFQww/jsSzD2M79Y2nLKYC54WydQHsNNkmg8B10h+Mw9ELQ3u2ixZkT/vb9PJ6d82Gq4K3yVHp5QzwL4PSYI/fLNqxRsxY9IVQAczW2ZqBKNHVqbaR12Oo0FSfF8FJEB6+uAVbr8X9EvOXAJw4ZLim8yMkNRrkDbIJLNrcvXIcuwzv6gUAbQ3FYlmgpfgO1wk8H7DDtTlCsCt+b0IIyc7ddZf7uWVPF04PiecmsmiAwsv0scq9sJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkWu4MKuYOY9FO2YHXzv5KO84p+V21XEtoo51H9QKfU=;
 b=EK4KuBYyuLnoCuPeBe5PYQFhmiz9e8X6IvJorDbuqip+MEI753iUObEICaUu6qw10i+z8ylDW3owvmLzzARlVi7X9VYNq80AhBJeFlKl+Cn7Gysiz8q55sQv0KqCyLkVE7DM+T8PFKVePvafyRz1saWdMdi+eSPuxx19QcRbf1zOWz3sd0hGrc/q0eMef8mqT5g3PndAa0kTT2clHtx//AlRqitySHWVeAnT1nG+l28QBz4U2i7WDReccQn299lN4A9bOA3oEBIcQQQ4Yfcn3jzd3UX/4vC/0iXeSuCgQsybFex4TJ5XV+aNjEKzNCI9Us+OcwNf6UtHz40y6hseTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkWu4MKuYOY9FO2YHXzv5KO84p+V21XEtoo51H9QKfU=;
 b=qmkXGokWCvYoK3BHVfC6/HwX2SkDFcapDVT6dTK+dVQZupUdklsTG+B7Onp/6S1FeJeLNCiWKe8EGn0YWItC9W4lUeU8QwzsUf+zcree79IEKWJXkUsJcek/13/v0xn+xjDkHZP8XD1y1kCxl16VBLQ9fQD1Ar22hdtfqPrlA3o=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:43 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::a2) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:29 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:29 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:27 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 43/47] hw/arm/xlnx-versal-virt: tidy up
Date: Fri, 26 Sep 2025 09:08:01 +0200
Message-ID: <20250926070806.292065-44-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: d96c934c-d89f-430b-40f7-08ddfccbaab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kSmvGCg2k+q86w4+WVlvN2c953+LNDIFrqYSaWWLikAyk9AFdHKlkVvAZI8V?=
 =?us-ascii?Q?KfURo0Qu7UW+kcTSOaczQZPnK5Di/q2xTjYklN2Z0CO5S4YCkqkLhvbVGJc4?=
 =?us-ascii?Q?QHMGW9N7UAxJmL2bBom2GgOSarSoe4xxXKnMBo7uAMK82TiO2FvnDdJ19Pyi?=
 =?us-ascii?Q?r+bZr9YV6pvHEz2fV2liTVgdCDt7mLbV1VyF1ipUfef6w9ByurANY5EgDr1P?=
 =?us-ascii?Q?Jgf1jBs0PJH5nCJ2mkPK09119ABKp3jKfheEMUTy87QZU5zBAOLSYqEoyqhk?=
 =?us-ascii?Q?RscNRqYXBKU54QhpHze+Nx18BJDXka9nLUG3D7baSMkPcTNmaD+NAh2mdJL0?=
 =?us-ascii?Q?qzHbD1AmJ1j/lGIIRfqvFDOtu7ewU4Z0u9JOXiQGsbiCIiAYl5MuaHq5xTXu?=
 =?us-ascii?Q?aN6CRVMTtHYirlC2mh5jcEetLtZeYTVC761DP4TFH70kmyM3W5z1RwTbDLHr?=
 =?us-ascii?Q?TWLbyxy3LXUWE+pA4xeOEzxqN75bylxrszQi43eKa/bAeOB24b8isc0Nhy3u?=
 =?us-ascii?Q?0OOkOEACz+IH+rpTYKXirCuJVGttjUXYtKuq9BGRw299Kql0Nu4CM/C68hp3?=
 =?us-ascii?Q?1t8SgT4oMQtyvQNMprC1I1dHgX16m6JEmzufHaMx7xh3DT2uzr/NcAisCBzi?=
 =?us-ascii?Q?idoYPSn/NIMHXkzblvA8V7pQCEmL8ckzJ2VRmWUfjLwqlougSykc3dvnRod2?=
 =?us-ascii?Q?sPtHdgepRcxA2JFFswFIhzwVkn81FzFsfsGRFnupE+1PXaMs4swSYGoNmdW+?=
 =?us-ascii?Q?fPeU+nyyNhmfQExzeFlOsoGtke4gkEXV8wiUsrr16OuPxyPnVDJNlZ+zV2Nf?=
 =?us-ascii?Q?AceccnuEGFxX8A0JlHiXWbyIGa6RaXlNNnsbtoHLksMZSZYQqceWzY9TOND6?=
 =?us-ascii?Q?DJplJxaWwkOh0pPFQXPugzgFsGUjU8w3bAqfa7Uuyj2FyjXFEpe6rPjKCosE?=
 =?us-ascii?Q?jdl8WZYGR9Mw6SFBNm9Cgr3QFz+n6kLA84WE5ur4hPm6kIsxLvJtjKV0uiTX?=
 =?us-ascii?Q?3Hdp3N86aJdmuIBeYqDsTgiAE842fHNvg3Jq9D4SBM9ric7Eby6YRS6PtgKD?=
 =?us-ascii?Q?Pjjlw63DdSBtk+7Ki5cc3mC6266nlkU0MX7zNmy0nMuASIByvgsuwPZURsYZ?=
 =?us-ascii?Q?lcUUpfhQk+coeJeZ9Sr9WrrkFd/ZnqvEZS76PF5UwVHOlmCTY3X0RP6d0QmD?=
 =?us-ascii?Q?896y6fG8ZXw7/sQgSDU4QzXfZj0IB5DhP4dcb8Sw4LOmk0wXyDCoiJfEPeZs?=
 =?us-ascii?Q?XfCt5CImClqNroAHm/ElmtohYlKV/24G4TpgdjNT1B3UbQwWVyXwC4aENw6D?=
 =?us-ascii?Q?codNR71GVZnVga7uFx7iYyLh9ks0jmTIRpcxW1M91r6Y+nI9/F4NJgCCjs2E?=
 =?us-ascii?Q?oFDw0Im0vUguhXD9N2GGvRP73nMm9jGS6x8cj9QBCJKsun9delFf2Xihp6lt?=
 =?us-ascii?Q?63Kp6Z8Z+4faNHkFApDjCCUMfRnAqPO22PRDQ2LlN86Eh2OXMNyFhJVIMZKJ?=
 =?us-ascii?Q?mfRXJWphoe94hR4hxbtJjpMVQQ/X7vbyqFmb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:42.8375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96c934c-d89f-430b-40f7-08ddfccbaab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Luc.Michel@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Remove now unused clock nodes. They have been replaced by the ones
created in the SoC. Remove the unused cfg.secure VersalVirt field.
Remove unecessary include directives.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index f9abb9ed639..14c2d5cc924 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -17,14 +17,12 @@
 #include "system/address-spaces.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
-#include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
-#include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
     MACHINE_TYPE_NAME("amd-versal-virt-base")
@@ -39,20 +37,15 @@ struct VersalVirt {
 
     Versal soc;
 
     void *fdt;
     int fdt_size;
-    struct {
-        uint32_t clk_125Mhz;
-        uint32_t clk_25Mhz;
-    } phandle;
     struct arm_boot_info binfo;
 
     CanBusState **canbus;
 
     struct {
-        bool secure;
         char *ospi_model;
     } cfg;
 };
 
 struct VersalVirtClass {
@@ -70,35 +63,20 @@ static void fdt_create(VersalVirt *s)
     if (!s->fdt) {
         error_report("create_device_tree() failed");
         exit(1);
     }
 
-    /* Allocate all phandles.  */
-    s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
-    s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
-
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
     qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
                      sizeof(versal_compat));
 }
 
-static void fdt_add_clk_node(VersalVirt *s, const char *name,
-                             unsigned int freq_hz, uint32_t phandle)
-{
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
-    qemu_fdt_setprop_cell(s->fdt, name, "clock-frequency", freq_hz);
-    qemu_fdt_setprop_cell(s->fdt, name, "#clock-cells", 0x0);
-    qemu_fdt_setprop_string(s->fdt, name, "compatible", "fixed-clock");
-    qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
     char **node_path;
     int n = 0;
@@ -266,13 +244,10 @@ static void versal_virt_init(MachineState *machine)
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
-
     /*
      * Map the SoC address space onto system memory. This will allow virtio and
      * other modules unaware of multiple address-spaces to work.
      */
     memory_region_add_subregion(get_system_memory(), 0, &s->soc.mr_ps);
-- 
2.51.0


