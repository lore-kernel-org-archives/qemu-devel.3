Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B27CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0ey-00037R-Sl; Fri, 12 Sep 2025 06:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0dD-0007jT-Mc; Fri, 12 Sep 2025 06:04:00 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d0-0001Pf-HX; Fri, 12 Sep 2025 06:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9ZxaiRcpR4Cxp6x74+86JXmUbd/9COznbORIPBoanAnj71hwPy366iA26C572Mb46UJYCTg0tsUtQpFf0bizFofLlmEigc2Lg0Df2cQ4wapfPz0W2cJwaRed2QUbCXWrYA04PiGojSfa4RlbtaGXunCsVzhRhIKx9ICXTdxIVxGsZ340m3sWLSsAlL3hHsWY56ZhcYQW+0J8gfQ6hRVFbhvyVAnQa7/OWLdTa6Ts0PRGzrZdtdvRLI9/rS8KTcJ0oh4S3A0CcwNszHI0HqRfIBzAPMpGbohKfc+dxMzWQC5HhK48OdDIZ99U2ohrEJ0iJ9qkFfreCFNTSG/Z/UOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jcHHicCMl1JatyQANWUU8sdxf7EO3amzt7yuyzdCmU=;
 b=GW4DGrz+wOg/pwDqm/NZBMB8Rcim9mj9gLGlMNyznav5AmEo3oXU9tqszg6baxukoitv91FWOWqYWXQfqFKdv9C5n+/rQFoxaZN2ATOPT30J//RWu1ke3IvAM4QDk6EN53DpyK1bcuvP6C5sgKCvirE/kag7+bcfJUeYFmoHlzmfJpZOEZiq5pW/hYB7dfKtfCNlxbG/yUeCGB+yH1juweiSziv/udFZ/iOslxAqpkduNR0/zKN7dYhLSzAE4leB75yiq3AY5/viGmrBK1aJwN1moCqscoL0SJeHXmzEAWcLrWbwLAdjSIYEamMcMwfkccQVV8UdMUmplOMRTZeWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jcHHicCMl1JatyQANWUU8sdxf7EO3amzt7yuyzdCmU=;
 b=1nzo1cP9po/lRkAsP+yWfnxWDg6oogl5Eg5NqnManRZ97rMNZM3beLVX1P9QndcqFUGNDmnfAPf0TspUdVYLty1xGQ2JFwV7XaWXGqfjRt8tjYkMGLO69MDmSgKsMONd6DIG4G9fWsdAP7qeicl4KJe7ArBA98z+1oEdANoUqwc=
Received: from CH5PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:1ed::15)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:17 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a1) by CH5PR02CA0008.outlook.office365.com
 (2603:10b6:610:1ed::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:38 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:37 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:36 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 43/47] hw/arm/xlnx-versal-virt: tidy up
Date: Fri, 12 Sep 2025 12:00:52 +0200
Message-ID: <20250912100059.103997-44-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf9a19b-d4c5-4eee-6bfb-08ddf1e3988d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DoQcr/FmSrN0X1mnefzr2ijpf2FkkR7rWezq+tzDz4xuZeEhN3YvT/1Q/yXs?=
 =?us-ascii?Q?F0PjzQWZqzxf4fyC8QRn+NJNpahxi/3ZSFL5N2XZWR+ku009AQV+diTeKV72?=
 =?us-ascii?Q?mE7vSgfdVDmbmEAyyYdVZywj/tI6j9cNH/28laB/m5eycPR59d2j+qVtFwCT?=
 =?us-ascii?Q?EV1KWCiVaks6VtNLlwnvaYuuuDc12C7Y80T21VWBmacr4/GJLbUGVg2y19H5?=
 =?us-ascii?Q?NBBI1xZbbTgWqiO7G6zsbXQgfD8pyQTxb+I2yR7lNVMKY8JMcI9ceP9XgoEO?=
 =?us-ascii?Q?DK5HPc0Shgu+1ikyT2Ru1LTnqznARD3PvFffIEqr7j98M8pQcN6a7HfmEdDD?=
 =?us-ascii?Q?FcWbHcFirdpxoIAlBnI3suQWpbr8rCzoQSs1PVxJIbp9Yxks+QDDArl5+J3J?=
 =?us-ascii?Q?xF7kINDmHyuzVEjLXYo731kLC9Ome7GpejkBxpjibJdx5HzE/RryM7pF5Ra+?=
 =?us-ascii?Q?4/e0lIoYVbhJxfGeWSJRM50lR+nS+m/RBDaGnAY5XYnA3pdoIVuS2moKtoVL?=
 =?us-ascii?Q?FtNQxVuxeQpLC2SEZ1vfdc44wTVvJtRrDL669TFwEuTbAqsQUfQsYYV3cZhr?=
 =?us-ascii?Q?MQGqwmzeeTvXMVJxOCwBo5DulZgovCMx5i75GCN/6QpEJbYaL6yRPDDJTNv/?=
 =?us-ascii?Q?E8dL4lzDkZs2pj/zBBwEbyaIAzOW94tJ0CGjRD0FxlVidxQT/7elr2+eg5dN?=
 =?us-ascii?Q?K0b204BO0Mmvtua2qo6FQ77Du5fbyfLkJs/SwbSHHFnegUk+EEdE2rqC781G?=
 =?us-ascii?Q?Q4bxid0s/3uDuYHwFhnE7ejSTyhK/fiTgjj7VF3/qTxv+wjp6sdX+tFDazVy?=
 =?us-ascii?Q?yUpEYQu0kOeJRxh6t9z1dUskA/ik95rC3Y2PTexgjTdYyU/aWZdv1L8jQeCw?=
 =?us-ascii?Q?fiu2icR3WxkTgIJvbM/knbmGm7H84vtPvu3K0ATwE8Rj90Wl7j8ihLVmkCg9?=
 =?us-ascii?Q?cn8NjjgvaIuYd8r1mw0QtMLXQCgCPm+kXc0klXHKtMt8/JK1Hfmh9n7GgG/K?=
 =?us-ascii?Q?dI02XsK3N5JLHQb91Ox9j5k2iUOythXxARu98Ls0el+UbetEMLJ8cOlrREWk?=
 =?us-ascii?Q?eOWujYx1Lx0KevyoAA/xXL7P66jKHCDKry0u0MEij5h0shbnDEL3R0V3K4Uv?=
 =?us-ascii?Q?ajUOoNs5gbMczqld/UzO+9xVcjQ6044JjzZOcr0gXN5p9uE1HUwtAhdTqeh2?=
 =?us-ascii?Q?eR1CuuUTs4Mb3xJMMlmjZmvV7Lpnp3C7DShkD0BTMXtlPpe7gBIVzH7nuj3M?=
 =?us-ascii?Q?8iqmae4yvOe0baMYcgBCmkXiY+sYcBcIt6RVGU1FJtmCYn8mFtZmS85cw9iN?=
 =?us-ascii?Q?4as6I4sYcE2vbGwrpQyXe71Mf0bTjkUMkRLgdhR4/TZD3w3R7sKBBJBqNE/H?=
 =?us-ascii?Q?P91cwN24NSMW9XGRhYDvlkwmHTezl2wip7Srl/4S31cckw3FkA/+3ivuulzv?=
 =?us-ascii?Q?0Nnwx8I0BWBtZDBv8RcTzPJKVTHe8w7rZJPPczRIN1mNN+8VqAcHirKr3T58?=
 =?us-ascii?Q?ulAK7J0b8UtfVT/2PfblxgJ3x/DwT7hQsK6K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:17.4933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf9a19b-d4c5-4eee-6bfb-08ddf1e3988d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
Received-SPF: permerror client-ip=2a01:111:f403:240a::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
2.50.1


