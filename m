Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F72ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXe-0001YG-1l; Fri, 22 Aug 2025 11:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXA-0000Ed-E1; Fri, 22 Aug 2025 11:18:28 -0400
Received: from mail-bn8nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2414::606]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWp-0007IO-Dm; Fri, 22 Aug 2025 11:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuU4P1PHtBaT2mNiPJuPnCAX5ApSaaoQSZIYZNSr/v8Q1wCwZ5cRs0H3mttdecm3sGyJZ/SLqDCjfWGGx3bNNU3NfMu/gyhytApzN/1zTazAksJgfbAuhqAxC9rjBBMrJL8RrhK8qYAKZn2jIJzDc/UXLEfS9dAtLzscJOZlh+2AupbuXzQfEZz2S1RDT5AOcnAsfyKRjE0UR3wYrHK0RWSvxV4QQ6RE52P4Cc7GKcqEAKQprTKmE6TXxUYgZVK3wMv5/rIIuVtY1jgVaIGuuAxsVKJuvhnAZ6QERR/cS84eXDfoZUV8Ufz2Vmwlb/arewFpWCjBTiOgbTroj9FZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jcHHicCMl1JatyQANWUU8sdxf7EO3amzt7yuyzdCmU=;
 b=YxO+oHdOF4RXMhyTQDHENaczK28/QpyTF9Xv3nu22KGWzbVHkrTGTx13bO9h9tf/6nmFXfF6plKn7c2lPQLzvRgGO3ZM0h0pgkpVoZ/SwjmPgej3fuOfrYxMZ1jGzAA7oD+LWQsolm4JKBl31o2S3KLunUQXIK00QvKAd9W2hM/RrRxFogeSfW2Ck3AjAMskpE+iezjUBbCEpdOrvSva7ACZkdwGQ/U/inZnMVq+cBueEsbmNOHbCqcIByLsUDo1sEJYymG+pzh1fzVD5X9TcrETfo8EivsSs+yCDgS+EBHE0HPNRNSfc2pLoRjKuqtmMRUaIrbdsTfJCqf9bj4BGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jcHHicCMl1JatyQANWUU8sdxf7EO3amzt7yuyzdCmU=;
 b=Nb9LLJL9enlSw/+OXYzw3aTOGB0i72U+n7G6U6wQXGntO/zM2E6QH6odtx7b4l37sHmkmnrIf7TjZn8IJ+xyqOmUd5IZGVidxEg/2IVK0u3wTppp6HHymdB7MXBGgGGiQnhJAJ0VXqFhGn79CPbc/E2dBY6GD0BtfmJWx5GtrWg=
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:17:59 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::1a) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.8 via Frontend Transport; Fri,
 22 Aug 2025 15:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:51 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:50 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 43/47] hw/arm/xlnx-versal-virt: tidy up
Date: Fri, 22 Aug 2025 17:16:08 +0200
Message-ID: <20250822151614.187856-44-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 28125436-f38a-4d49-e849-08dde18f107c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8kXNu0IbpZROo0lRm7Jb201VZcBZPZFOQ7QcFiwtIrAq8YoI0q+VYS6yKtnP?=
 =?us-ascii?Q?nlT/HQzlPorpzUDIFAZ2OydYly/1HHTnClWTADy3DNkcNkGrnIuErSfFnHvo?=
 =?us-ascii?Q?Iy9jS3aAJ16mQcHYYhCSZdBsYoSAR1ktUbLOldu839c7/LRYQYJAW2JEQePw?=
 =?us-ascii?Q?EG4sMI3ukO85G1eGBSN0udrQ3b7hy8gDDTlSRvSsPMNWr+vK0TzedCOgFD+8?=
 =?us-ascii?Q?0+cWZxDIQCzoDk28+EvR7XpnoHqsv2e6H+NK+CaZsLOtHSdB4NNhkARjXLRH?=
 =?us-ascii?Q?WyiO0WYRnW0WFbeIu1p6mZ4d5MreerB53DoNm+8DEckfH0wzOokIoyAIWu0n?=
 =?us-ascii?Q?RBDrhw/Fqwptj2pG1gW85C0wOTN1Zh2YtRGS5f34Th4ZgE+TGbZkGvoE5HOI?=
 =?us-ascii?Q?whaY63nHnkR7f509NZ+RtbYfclcByGvGCzILDqbHC9o3CaoWs4ytZ9UTsJnr?=
 =?us-ascii?Q?J4TDx/w6l4C2hdREGGff8dV7IouyhiF52I9ea7WsFKczoB6Wk/MpYCxWJWTv?=
 =?us-ascii?Q?4TNm5Xw6GeUCbPnI0hAiv8a3EdIo34tIiHvyRxDjOc1mK2WXRjk0RHG7vSFQ?=
 =?us-ascii?Q?8i6dz7//gT0E43nLzA2Ec5o3+0ZhEH9GsofmVFlrqpY9NqX41gKYnPQGHIxo?=
 =?us-ascii?Q?MwINKF9ZilkaAwE5PwBfEVKCyVqHPfTY8KYzMKCi9Ao9grskmwOpQRZJPKAb?=
 =?us-ascii?Q?FKmDb7G+nsA/Fuh6Mq4wsBVi+OYtcNmVHVe+khEBzr9p/IYjipnuTlwVJbGj?=
 =?us-ascii?Q?tOPnZ+UU97JwLHTrGppkNgV9Mtgty7VLZD+Ccl49XtrkFItK2xSMz4oXNBJ0?=
 =?us-ascii?Q?9BokTEzOs0mRvLrldlFdSkDuXci7o6iYjFuAGWQSqegHtUsMhbuKeNo2d/9d?=
 =?us-ascii?Q?XgaSBgU88zXkLp+YWr7zblTx4NPdnK4fvFum0L5riPQoFbzIfcYogFZslB12?=
 =?us-ascii?Q?980rVkg0IRKYexhRcWrG0xx8Sq7qBIcZ4nboZV+jqvwTyz/vvuOEKNqOwkem?=
 =?us-ascii?Q?Ce5AMASdmQWdVCQd7hhBWklGj+2+8knnerIDv5BWy8gYMsCV0oHf6UbtDGB9?=
 =?us-ascii?Q?wog/xxoa6oPNXVMEsg26UHL6aepTWk5iXBe5090507sV8XN9rHvOZGYqgSc6?=
 =?us-ascii?Q?+i4XsVCoj6dWNLuLCO666be+XtCCyMXzagnZBXxQCg8r0YIQyr03D6hOD0HT?=
 =?us-ascii?Q?YTlilnsakjfA79e7DhBOCWWVS38PJyL7XNI7Db0Kv2J4++X3j5YjPb4IA6KW?=
 =?us-ascii?Q?qAGBIpEJGPnFrnptZXolZSwv+gpoVm5NyCjfw+eHZceVmDWXspV37AAm7X98?=
 =?us-ascii?Q?ZVdkSVlGUFNT3owcVqrizMeLKT7y0FMZkcfOpXXRbNBqEgR7/6FHRG2xMeEL?=
 =?us-ascii?Q?TLYQgnRO8vz5lpx/7DQ0e0/eDmGx0MQU8JxPXFqwhpfYd9BGuitbaeOCj+CA?=
 =?us-ascii?Q?R+i35piJZRDlSTti2/ZR46IfZfMGPl21rwsTLC9rBYsF9q6KFzU6Q5nAXvqT?=
 =?us-ascii?Q?d2dkZ+UMeWS6GLXvztiwWy9QYl4Ia6inJPeQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:52.8329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28125436-f38a-4d49-e849-08dde18f107c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
Received-SPF: permerror client-ip=2a01:111:f403:2414::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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


