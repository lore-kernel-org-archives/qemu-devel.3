Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0479FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50U-0004Mh-CX; Thu, 21 Aug 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zA-0002Qy-2O; Thu, 21 Aug 2025 09:05:44 -0400
Received: from mail-dm6nam04on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2409::61d]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z1-0003FV-DL; Thu, 21 Aug 2025 09:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PChoocn7UdgpgbZySif4ZP88SkrJQ5Oz0jWGHWxJRELqrwWIrkMVISkfiCNbjFceQQVBp9E4RbOl8dY9bxEscJxUUKt26oq9J0RrjcLLwCr6w36V+Xi9yGn6emS8UOnaJfxQccJDykAKmvJRV51vRyiqBazk8ovTx2UZ9WKxqI1nYOzSEv4QGtEThBQAfeRk6ZC+TJrBznUPitd6f5z7E8FBmloQzxyfoqiTA+S+XG0ZXt+p7WB2se8bMlcsQ4X/bs1aY5vpBnkG9Z6K2eikhMwJAiL2GzwPzYgVPwu6mpConA0gQVVhddSBfy0Ta86m22kcCTjoSH+w78n2s/Aa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzFgSTCoNh0l0IM1RnmeA0r04UCWE7FWK3wxSYFAFYA=;
 b=gvl9HpIbUzerXc8I6Qa3uB1bwpfbph74ebJu+Qz1kIuTU/9cOjIWA6mVyTFhtJFB2SMaJxOv59Obg0I1lVeS1zTKUGg54lzE71mIaHYkxrxKyOler8WsqFb9W94NC9RLbTGVYsWFg7l9qJiRqNr1LDj25ozR2u49Tq3EVhGBVqcgUInqo4YYI65gRz6DgvsLDduA+23wszbs5qko1ZsDh7OeW8qVDxQS5oHBcsKAVUhmt4DPEciuZx+0odft2P8gFPcBAF/OKJ68GX2LlUU9Ws+m365wYGPmWhjw4ReiPyKRaNK5KfnpUlLZdst+fcceRhU5cKvj9wbDGL0bNdbr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzFgSTCoNh0l0IM1RnmeA0r04UCWE7FWK3wxSYFAFYA=;
 b=o3EZSot9/HN9VohAzQ5Ejh6q4XFrIS/H8ZzxUjzH1Mjb7Y5tCy2GNt8hBWvRCQvdaJZ7xre9kFAEitIc6jlW5XF7ieysY+HBj/eAL+GEYcFkNBWRMXixoZ2wu0TETcbRscQDWYOYXzcyrR3TofR/8oloLkOFTeoVWBUl4/PNOv4=
Received: from SN7PR04CA0062.namprd04.prod.outlook.com (2603:10b6:806:121::7)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:28 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::51) by SN7PR04CA0062.outlook.office365.com
 (2603:10b6:806:121::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:24 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:23 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 43/47] hw/arm/xlnx-versal-virt: tidy up
Date: Thu, 21 Aug 2025 15:03:42 +0200
Message-ID: <20250821130354.125971-44-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4f0106-19bc-4f09-263e-08dde0b36684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2zwmnT4OPew0M2fCm32G9LR4kxani6c6VeqOY1bwNfqalcmGtHRGuySV0vM0?=
 =?us-ascii?Q?lF7QGN1MaFfnU60wF/Py9mZ+ofSzjGrfBCSoTHIUBnytoYpd4MPbPwKuAbAn?=
 =?us-ascii?Q?JiK6oyC+yfE9VJF69P0EGk6M64zt5o4j741ySlkYPeTrey0gK+md+COJ7f66?=
 =?us-ascii?Q?+/qJ9A62VqQvzcVbrR331WSz96qmd/4x5nC/F/36rNFIw5m1UjmSYcY2Z2LU?=
 =?us-ascii?Q?weIy5wYCZJxNq0kiTT+PMVpk9VQ3vItX+A5d66aQoyqOv17xIV1geLur5h7l?=
 =?us-ascii?Q?d1cNG0pm6u+dYO0d+3SckGW2AZ0YnKU4Ksoec2b3OXDQBDOK6iZ0F6Kf5xuc?=
 =?us-ascii?Q?Hce0Lv0r/4pUOW+3AkaCvmMIkOpk2g98oRwMlImXXmCGT9GqfPU4Q2bQVO2f?=
 =?us-ascii?Q?PjObp0QQSSFq3SEZHUbs8+ZUMakFsWmfoy0AKrrmXNAHJs+Y9EMhdW+W0MuI?=
 =?us-ascii?Q?VPLu3uK+TLCpRao2WDVOY8EAGn9YzsIo2mm8dN0/w2FzE+bCmYMDafdBdHyT?=
 =?us-ascii?Q?Avz8iTixiAb+dyHnlyQyzTNIuhFY4ML+VLq2oARWqsEhhK/pZPVaQrg5F6iK?=
 =?us-ascii?Q?eSmhXOVCdHRjpGNxamlInz7l4ouLnpKUAX0+PN84mj75VegEsrSeJXvu3SmO?=
 =?us-ascii?Q?79xRPgu3wBKNTH/Dkwomo1wLLdY1v40b2T88W8SNZf1srnRftsahRt4hv8F8?=
 =?us-ascii?Q?XfckNKuAcF2zQb/D55zG0G+2w1FDJX78EINHWdvdvTv62PTku0EELl/T6viU?=
 =?us-ascii?Q?KHoqPC2J+ZgtxK3ondbDbF+yeqEduHjxIhENIUkSDEpy4eYtqIOisdGzccal?=
 =?us-ascii?Q?WgpavQlmCucCI2BbuXankz/jJblm5yOKBO2B8rt86/BH0ZrKCwATqjju66Jf?=
 =?us-ascii?Q?fNDdUOyJNU5AnkV1/zY4kG4QxER4sRZbVh7N9yY/m3XfFTMhhxqzP2E7diJK?=
 =?us-ascii?Q?3o8UAi+iicldeXr8Xbix/jOAcnI/8fwxMMA/vdd0gwjFD/2Z01D6PoTOq496?=
 =?us-ascii?Q?SowHARG6CTpTCR0MBcWqJHqu08VqpGLWDtviD+0eKQ+8LvDQW1enuVRPTgp7?=
 =?us-ascii?Q?36JSgP2Igu4b30UVd1AqCGHjPSPTkPmzymOijqyLBDBijOk2QPAEUVtPwCzq?=
 =?us-ascii?Q?xybxR9r7rFIuediiXDxrY78DUCN4hHSJJ+wH31rahVqY6Lp2ypInrIG0c1vR?=
 =?us-ascii?Q?uUipWyKTRhuhsLc5Ky+ok71HgWAVICrv+wV/w/LLhMkaXICyiy7/owfn+uLZ?=
 =?us-ascii?Q?Ww/y1XxT4/N3KRxwxwykmhAKG0GNCxuej/QCJhTPwPnOFDg99T0Q9tuUt54g?=
 =?us-ascii?Q?uOSlb+b8pGFC81l0y+tcPceLnKAJ1DZg6g4mr7gWQoPxjpPnwHH581w85OB9?=
 =?us-ascii?Q?kPvE4PiSOU6lGrYjsyQ3dF4ucNyHCyWRfQH+45rWZTXgfm6hbgpRM0n2lgy5?=
 =?us-ascii?Q?8e2zxutJASbrrj7/ewUXFyYk0YjI1AMiiHLafTao48J6FJ/02NslnCEFXk/R?=
 =?us-ascii?Q?qT/V9ag2+qGupAbQBwN9KN9FkvgpjA5X2eue?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:27.9517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4f0106-19bc-4f09-263e-08dde0b36684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
Received-SPF: permerror client-ip=2a01:111:f403:2409::61d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

Remove now unused clock nodes. They have been replaced by the ones
created in the SoC. Remove the unused cfg.secure VersalVirt field.
Remove unecessary include directives.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 40ba053bd08..de475e89412 100644
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
@@ -263,12 +241,10 @@ static void versal_virt_init(MachineState *machine)
                                  &error_abort);
     }
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
-    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     /*
-- 
2.50.1


