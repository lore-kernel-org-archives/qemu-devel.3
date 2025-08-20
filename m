Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52873CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeBj-0000OP-30; Wed, 20 Aug 2025 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAZ-0007Eu-1o; Wed, 20 Aug 2025 04:27:44 -0400
Received: from mail-dm6nam11on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2415::620]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAW-00019T-MU; Wed, 20 Aug 2025 04:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2qmMUFtiYk2sm0+6Ex6iTwBxxgQHQGi3txVyebNqJ5QRpm7YGjoT/yVV3yhI6UM82t/miRjehP8rkdwlJkl3GxvRLyXe430hAARCwNeaVUSxi1XaQYplGD9U5AS54F02cBX37VuajcqnAMbO51Cx6tZo6JYhIYjQ5IcykUKO0tj/SU049D7jRS4E71gf2oJWIpjcSGtBLFe6ey0rKq/mgOod15f0yHqSK6gyZXikcAxu6zEmXASbBz59Eq+8xHzfyHXfnh75qw8xQsLcoA2ZhZiPQXgRQheEWXx1S/b9FLvDmm1oS0c9fW/JQ5eTy0TMCReMtQO3lngHxOuS45Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k90q27RfSh1FLCPZ5j+SY3O27QK700HzzRDTyRicN1I=;
 b=Xj57+fGpTpOZS9TKOPic3K2QHaC9vRiBeeVqfls/x/ZbwZQ05Bwo+LZ8eaz7MnVb49BVAR65HSGXfqglxBj68R8+s/8kPme2SdFH0quLF4YPHzDajp8cTsITQaBqnqLTpOi8LnoRYib0Zkk1Vk+ppSE26n5IVmkXb3dS0BAlAMSJbd2rFpi+bGyZFlEKf3SDdon046g5b3LkQRhxviGvaaHpvwy74n1Kl4qBTNMs8NcEyCmtTLnaSf+yoOa/z9AklXR/S8fDrfGowWmJDGiRCYyrTdUV5IjxvZHxT16H1vGdVQSdtUSbDoQqmSs7Urbxky9WsJUblAOEAMqlBlm+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k90q27RfSh1FLCPZ5j+SY3O27QK700HzzRDTyRicN1I=;
 b=cgMm3+eNRyD+6gXpLNADN4Hs3IoeBcEy4WvsQ4L251ekrDn8UuPFwzkjt2pYSBX+7OYA68AgJR39mLAUrf0fMbzY2k+Nvtd3cC+RGIyAQitkmcS0C++mpRqrYpghsytn7fPcUmnaXKVMMdhmC2J4CreKG/Kmws35kC2XV37Ym/Q=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:27:35 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::1e) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:32 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:31 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 43/47] hw/arm/xlnx-versal-virt: tidy up
Date: Wed, 20 Aug 2025 10:25:42 +0200
Message-ID: <20250820082549.69724-44-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de87f6a-5c98-4eca-61cc-08dddfc36a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t7l/8qeJPgwLdsq5b18Z8FBCJuBdUQutHPe6lGsb6ykasohkDUHLA9zaApjC?=
 =?us-ascii?Q?yYhU0xAQznUF3xPSq9vBhkiw66+nNQ/LmumrMSLQ2bAFnZTf6qeFSGzDbSjo?=
 =?us-ascii?Q?gaNCFz8g1UIu4qux1WbmeQ0cPO0HwV7tM/1EcXIv6XC79bMUAmFdEZ2leu3m?=
 =?us-ascii?Q?a0/7PW1Deomu3DVZa+71EXGrA/5govSbkaklQdwaQbGk6csrjQESJvzM1b/2?=
 =?us-ascii?Q?7OKITblXa0CLVcDkHSUhPSbHzExzi0d+mGzHMiK6KtozvBbeR21YJrJrUKCb?=
 =?us-ascii?Q?sQAMKJcATOgaTlG00M6PAX5ucDVmsiPJLaqxrxtDGs8Uedg2XQyiRtS8GN3R?=
 =?us-ascii?Q?DyQaY1+/aCzJgYc/3Xj0JCxZdxciYNBDFt1Ib/c1NPSjxZQ2zsb1iS2ucCdV?=
 =?us-ascii?Q?Fbw2ClK3lNoqpirER/YzLUhKWLtZ4irCecesSVcXaiwR7hzcNXBeCQIdPiel?=
 =?us-ascii?Q?H9kGXzSt8ueoKDb7rvne2naGBNaeumwRNUobh4l6p/44eFMO+vxy+1Hjbeqv?=
 =?us-ascii?Q?tJVlQT56TFicY2So9ZH9zrJ+xKY/z7l80rYk8kZDgnW+vqs//dxMkvd2N+wO?=
 =?us-ascii?Q?zxjzQQI92kfoLepWir5No91OhALXKTDY9/4YT5qO2tV+m1D5qOpLddKNlrcE?=
 =?us-ascii?Q?HNwH+s092rjQGehfSqloroDBUZaZ32DMTu3aR2FI+hrT5+/Ud/4i5hk9pkIL?=
 =?us-ascii?Q?XkHMguv6R5wOwlpWOtcq+I+h6OI+cw4WHQ4shocDjz8j84NGCp1s1jvnFtcF?=
 =?us-ascii?Q?FjLSTpExYF8/0TPQPXIqdy0eHPMOxXUFDsyh5f39E5gY0DotJfKp9kwiquyv?=
 =?us-ascii?Q?KEnKlh1Po3t809nR28D7FUntCpmWirtpzMaM9X1gHMIN/3XJLm0d7vTjxp3K?=
 =?us-ascii?Q?Loa2YjDeGfwSspRbGQ1mYzRwQPlWtzdWE80iK0e9f4wYN2dX1rC+AlKjYz9O?=
 =?us-ascii?Q?4BLw3U2sHGHoJG88Ljzr1yMhxobT5ocAKM7XtLwpPE1BfaQUNepilpiO/RJz?=
 =?us-ascii?Q?QHFsfneauwCh3cQNg8I7RoHWHx7GVika84xCAySpuN4j5mmlfIvLZw7VrbpC?=
 =?us-ascii?Q?qKSqqXAFP/1oeYHk1RyIyvCxO69uGaemgRK6LcP321vzInexlMXqjX8qyMND?=
 =?us-ascii?Q?Q8mTQ7+SBheGjgYCkA8rTa0rxrSW1fYUWEzNT86K+QfUp16uJgThFN6rJt0K?=
 =?us-ascii?Q?5CmpovuQhVBTNyYlONrXpH2iVWVtMIfo4ywEuInbHYBSYxJDIOQ7R1BZo6F4?=
 =?us-ascii?Q?8+XYRD1aOdGjOG7Immhn8tkA+OnNEd8xotFkNn/m9nJWcEbuGvX94ac63K80?=
 =?us-ascii?Q?mS+9+Hs1Dg3yUwVb2PQVK/QFGb6iZCgNKC9eEU5efL7VQJhuIGfn+ZVULWpj?=
 =?us-ascii?Q?96zyZVKCUuBxuugNuRXcGSqtQATcbYspo9w/CgMsJIBf6E4wzUVubrD/XF+c?=
 =?us-ascii?Q?dYJLKYUNrw5qoOcUqdQDRPxy6vsGUD1gD4P/bpnd61KVJCw0nGwg1TC3fBD+?=
 =?us-ascii?Q?Dzr7OGhwkFbVfzPQLOh5v0Zixr2y7axacVox?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:35.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de87f6a-5c98-4eca-61cc-08dddfc36a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
Received-SPF: permerror client-ip=2a01:111:f403:2415::620;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
index 9eaa08300ae..b6fddc3920f 100644
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


