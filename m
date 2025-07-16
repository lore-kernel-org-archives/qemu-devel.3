Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AF6C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyuu-0002wz-H7; Wed, 16 Jul 2025 05:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysQ-0002Kb-A3; Wed, 16 Jul 2025 05:56:39 -0400
Received: from mail-bn8nam12on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2418::60d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysN-0006oK-7a; Wed, 16 Jul 2025 05:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYXduuJwC3t2docYuqay4vL4rWCFQWlfutB3mVZbpH3KaSKfkcan1NQ3tXOvPAUYdCaJUCbecg6EhlMwWTZuGqfXHtYHnDHySw0+cLXcclTEFFW+dTs6gZJc583pz/yT56hU8wwan7m0IYaNlgcrzSJNZXgcyCZdVcEzHWmXgYDEUJpzR4r3zxCSl/eHzJkPrgtT4JAeFVEbpf7/E9FN36GcnYqPy9IBxCw0QGzdJGKUVYHjwaBdUEZrUlQWL+34hK+80mQFuaD46a65kh9zRRytL6TffawqzfuZh5nZXAFFVu1CUr3Mkn6LFZP5jsyLt5uIOp1dfYYpQky10wOIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2/DEdMkg0Bp0eHM1nmuuflPE5DzRMW1r5OrX8XgVLM=;
 b=HJW7LSLsgoQhVf+ziqbwD+eNYCGc1CvRijALsEmj86ckUtTE4Ro6PyuruFcBisnWPzgU72+oMiX1rlfPkKWmcl59GOfBz+dn9EPLYw94oYYyJPYIs9nNQ5x0c55e/U64XPURoW5eCA8NKQ+9yEYr/4KJ9C0128nmr5uf4T6DbpRtUDhiTL2wesZmYZGncT8YlbbaHBIGqfDz/GxF+9FU9WaAzi2poOjMxIev428zA/dLhEtNHlqWgPwTr8dekPVM2i9XdI06u9/MoFBYf+Fm1aLp9zb+iswfSaFV9GGvRGXXiuFcKlCCSsUaAdZcWsHnProsbgMCgJ8lqSaHIa7AtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2/DEdMkg0Bp0eHM1nmuuflPE5DzRMW1r5OrX8XgVLM=;
 b=fS7t/4Mq2Lj3pLv6V/95HO6iVy0nNEuiGy7CQt2oGLErUVFamTEge1zq1i7b+LBnFezQ7O/MwXR6pyqG2u9ndO8vaCLPdjnpTGsTaFvabxxOA8a5w2ywGfGUW29fkxY2kBnb3zMWnBoSNkzMMOFobLBUaw9Crw38ucjoD2pybMI=
Received: from BYAPR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:74::28)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:56:28 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::c3) by BYAPR05CA0051.outlook.office365.com
 (2603:10b6:a03:74::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Wed,
 16 Jul 2025 09:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 09:56:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:27 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:26 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 44/48] hw/arm/xlnx-versal-virt: tidy up
Date: Wed, 16 Jul 2025 11:54:26 +0200
Message-ID: <20250716095432.81923-45-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 04de2452-2140-4fdb-38fc-08ddc44f08e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KVXaXe3gIJTAC2GvuibgcNM81Fj5Izy1gP3lXqtzvxlJLVfLiaFfE/ZPOFiq?=
 =?us-ascii?Q?f0rkZHUhRaX+3zOsyH9SGdEWYO/VwXPc9OKfaIDAWMlnGsNYI0ic49SEBv5f?=
 =?us-ascii?Q?Y2PqTOSz1UGaQHQ4rlko5pKjxW3MDDRP90d20X9e0Tp0o73e3IyhwX4L3IQk?=
 =?us-ascii?Q?LUJxbfyXZ0zqZC2zw5NNIP1lpP4XTTrgJ7dzhAG9nwJ6Fne2eQbbtqooRhDM?=
 =?us-ascii?Q?fHqSRj9QPPGm4rkqGR0zLjQ2FP7ApdYuLDwtdIcTHJ+3e7wPgPYhKHgQvmi8?=
 =?us-ascii?Q?ZQ530nCg4EVOprq24bOSbaRaLlAKlFx++QpyxX/ERkfmJ5pylADfz0kFbf9Q?=
 =?us-ascii?Q?cnHdXw8VHqZSC05BNdcELHRHAaiIBbmKuPIboE51w7uI3iEKSN0ww0xS0WSg?=
 =?us-ascii?Q?uCg1fhQj7M6Wtmk8i0TXTuk8za7gzd/+dX/qb1ZqnDCeLeHsmQqb1V6uXyqc?=
 =?us-ascii?Q?gJUMAVqqSX8QmNGd4BjSwMUeY+wmywgxX+fPSgC4OY9zArqbTM+4lvCWqyID?=
 =?us-ascii?Q?EXQ4tElPQazkUPwWrvxrvRyjSeTaIG0/Uyj+CMO1Y+/0716/vSVri8mA04BA?=
 =?us-ascii?Q?xHWpkUakYYPJRLwlJC31hf+x/zqXE5cq8mv1BNYj0dx9/H45OkT+AuSgQkH7?=
 =?us-ascii?Q?oD751uwAstTmQXm3OZ/NvrRYjvHk1QxXLqbfjzAFGi3f4Kw4Cq3jHagJOq2q?=
 =?us-ascii?Q?DzN39kcmzFgwgKoCOGz3dw9ubmce5MHyB5xcEBTQCmJPU2KtCTFr6KlDIrGs?=
 =?us-ascii?Q?j8jOgC8iGXZUpCjfUAYGwYz03Ef200FQh6fYvXQOPPkJf3TjeeTtHcUrqIAM?=
 =?us-ascii?Q?noAoedSWHUht3vbpMCIKNRiQnWkaTuEEm0GCQP9sSLHvpIHcBTkJoTtOVpbV?=
 =?us-ascii?Q?KmZSyK9h9vD5BASwpgozfR3ueh1nCaVuj30YS3Si79UJS1ihTpV0WydZ8TE8?=
 =?us-ascii?Q?Xm/jidl2Xo3/hvnbbrIHzZrqnv7BHFJkXF/tafX1WZuG5KEFA4kkKF+ymSU7?=
 =?us-ascii?Q?DnId0y9Rns01eXncsyE7LnZ6ltZcB6OzHbaXp7QMYtFqoz7Tsg0NuWT5O3f6?=
 =?us-ascii?Q?AMTakFd5QgeTafojN+IQdmCaESE7W4ABZrbEWSb2WRMlsADuNjQ41gPuU1na?=
 =?us-ascii?Q?I3Qb4dYxzRYRjEJKMJIVnejxiTWHwr2OD0wEf4pK/rLeoANeKh6rxpze57TG?=
 =?us-ascii?Q?XR3JR2YBr+dK8GUSL2JcZBPwB+Te/FcfiMXwa+rUS2XwTNENYsNLZCh5tNCB?=
 =?us-ascii?Q?fWYMTYeQjtD+l1uzoFFx0igTECyA/2RgNWmAx/g84pU76hsFAUXR577hC5UD?=
 =?us-ascii?Q?pa4ZFQIu2g10i/rP0rbmvz1wa3X8eoAQVYoQF4WWtHdbATRmymSCESV6Ys+j?=
 =?us-ascii?Q?aYP6ntjUK0fxIHEf0EXccE2nlribazdV8P86tD+IVQu41ObM98HOiktwZOHm?=
 =?us-ascii?Q?YyJQzsO15EFs6PC4Y6qCOydLM4mqyHx54sYZZNDNHifTuUWYp++EQ3OoDprJ?=
 =?us-ascii?Q?m0fRRHSCc7poEOGZ+R1F+27hEOEu3EdZrxGo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:28.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04de2452-2140-4fdb-38fc-08ddc44f08e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
Received-SPF: permerror client-ip=2a01:111:f403:2418::60d;
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

Remove now unused clock nodes. They have been replaced by the ones
created in the SoC. Remove the unused cfg.secure VersalVirt field.
Remove unecessary include directives.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal-virt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 9b20aef8b07..154ed7332c3 100644
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
2.50.0


