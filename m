Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1835FCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cy-0007Ok-Pr; Fri, 12 Sep 2025 06:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cf-0006kg-Q7; Fri, 12 Sep 2025 06:03:17 -0400
Received: from mail-dm6nam11on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2415::619]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cT-0001Jz-Sl; Fri, 12 Sep 2025 06:03:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPrJ2geZuysKonXhriPcov807eAFVoL4uFI9Ln/jmkB9a0HBRhPETw96wkz9UwIpZ9l3Zr8Sa+0q3QsWS3y1YQPW5+WHk13s6cJwYvISQ/2FcF/ynCN56NlUJgSI/rkYeuvLFtdwUMQZ8PmfDIhudlfA90NhaGT/LBIMpGO1yqraZS6vuZuGpbsNcnSDfCEXjVNLbIu+jXBQaXasB8UQ+VI6AxVRNxf09qwGjJRMEzy8oKbRmxgx2bk0bFooyUljktNA1403IGry83gVHOb2NqUyIsjYrAkNfI9+HN2Q4KVE+BRpL3c30vQmHJSxHKwVLLst7XQK3OoAVysZqYjJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ4E9nGbV07zWGO/tHjGPUGTntu9m6Z6SLdhvFXbIb8=;
 b=NuYJeflVsuuTiDonoiQ8nItd6q3anAQUSiYPwWIkTOKLRRhAy9Kv6JTazYYXtFzUCn6kA8972WFE3Ss2KbaXPN1A+pXIQH0XGnWAQejuewYOcYvRjPBFLlle6+F1rXQk0sD7OQ+k5ecKUkL6z9QVSTXreggwbDd8kK3Hr4x96leejtGprnLwXYOqqrvepHDsU084zbPJfwqWU2x4LNXFmMTmTNeNaoVCEw9pMJZBDTEvKhppp/tbXLT6XdgPOBg3tUjTQnDI/rbXthJTgGtUcCyB4hYUWC44sRpGeKKKeNVPMpkB1w0C2HIjxYSCzgt8+HWuUho0Z8NfWrHXjcO3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ4E9nGbV07zWGO/tHjGPUGTntu9m6Z6SLdhvFXbIb8=;
 b=MtKG02oEibyiHF1KIr4Pu0vOYCT5ZxV5ixeoF+/py6lMulPgPcJW6ge/2JVj5ZerT+R3Qs17IDb5Y9egFCHK1uA/DY9vJOrjjV1OtLvrKEc8D+2AM586PgWj0j33X+2ypEZXh0YN40YvUVdYYbOamCll/feaPNOMuGHwYks85mA=
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:55 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::cb) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:57 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:57 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:55 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 20/47] hw/arm/xlnx-versal: refactor CPU cluster creation
Date: Fri, 12 Sep 2025 12:00:29 +0200
Message-ID: <20250912100059.103997-21-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: 617b01ce-5cb0-45f2-52b2-08ddf1e38b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejVCelJoeHlVZld1V3dEVllQQ09xNDZXQXBZakhLalVKWnhlUHFLbXJ4OU1r?=
 =?utf-8?B?Z3Y4UHVXWm90alN4UWlXODJWVm4xMTNnekJhVmRYVzdPYzZvUmZUZ0UvcU9i?=
 =?utf-8?B?SmM4MWRyZEMza0UxSVJRcFp4RmtXbmEvNmZkRDUzV2s4TFZsUjhuYU9aWlJw?=
 =?utf-8?B?NStoRVNmakl2QkxZREdGdHN0b0FzcU9ETzJVdUNIZ2hRK2YyZjBEalQ1R25C?=
 =?utf-8?B?MkhnSjRXRkdwakpwdDVrVnJLQ3VhU0Z3ZG5pb1J4MDU1ZlZ6VjJNY1N3M0Fk?=
 =?utf-8?B?SS94ZWI3MTRMQjhjQ24rWEZjUjdxdEUySWZYcVRnWURtbzR3dlRoeGhJM3My?=
 =?utf-8?B?UytYRmNLZ3ZNNWR5SnJLOXg1NCtlS1l0MTU2N0pYL2Y4VVZDMUhzYnRlOXdQ?=
 =?utf-8?B?NTI5NTF1MUhSeUtVZ0VsQ1V4dHgwb2dnOFp0ZnhSV0trek5vYVhjZU4wb25F?=
 =?utf-8?B?ODR5NUh4UERJQWYxS3NLYUdCMk9xQ0dLZjJRY1h2cWVDZ0lTVlZ6SXpOWUla?=
 =?utf-8?B?V2FENnhTbU40NkwzRjU2bWJuN0JwdHhvcDhCRmVlcm9DRjdEVGdwSmIzQlVp?=
 =?utf-8?B?eis3Y2xjRUUrWkRiWVFveVIwRWc4TFRLRjRCVUVCQVJDd2JmdjhPNHBuM0k5?=
 =?utf-8?B?bHNTZVdvRHNFODVjL0hFYTQ0dFdoeFVFMjdUcDdBdE5XTGQ4NTJNQnZEN2RT?=
 =?utf-8?B?bDhqODhmSGNwaUxmcWJjWGtVTGtrMWdDdTIyMXFEanRyd1BETExvN0h0azhC?=
 =?utf-8?B?Myt3d2FOZHk2UDhlNDRBakxRbVZscE9kUENPSVdBTjV2dDF0VXR2OHpzd2NK?=
 =?utf-8?B?T1JIQ05ocklDeUFYWFA4ay96bjdkc2lmdXNWVGdjbjhIdW9qUnJWQWFtbFhm?=
 =?utf-8?B?Nm5YTHNlTXNlRDdJUVVLbXFQc1BuVnQvYXFMcVJiRFN4ejBUNCsrMW5jdDFo?=
 =?utf-8?B?emdJbzNzZy8xOHRKT0FmenMxQWxMckJzMG9aWGIzM2cxMnpEcFR2VDRISXF6?=
 =?utf-8?B?S01pM0NqdE1qRnFNdHQyZU9lNFNIeldNSHB0a1Joc3hEeXlTbkVaTFMwd3da?=
 =?utf-8?B?bWZZcGJlQkt4eUxUb2RiZ0xUV1FRY2Rpd3JVUTFUd1lKeTI3Wlp1b1hiYldi?=
 =?utf-8?B?d3o5VS9LNlc3Q0dLR0szWHJ4eHZFdlRZbzk2Q1BMclFYMG1OdWJCSGJsL2VZ?=
 =?utf-8?B?clRRbnU4QlIveTdnMDhJRW5FbEZkWEs1VENPbzVjQkV3MTI3TEtoNDBrYnJW?=
 =?utf-8?B?eUZLQ2xSN3hzWUZhTmxETUYyejhWUGRPZnlUWXdkWGdybEthWkw2V2NRbVd4?=
 =?utf-8?B?Wmx0L0UybEFVYVVDYTlNeUo0TmgwRExXYWVMYUpCWnZHWHNoQ2lTYzhtb3NJ?=
 =?utf-8?B?b0w2dG84UUlTaDdYU2ZoajFiRys4NjZMTDRtMUFIdXVveDdyeHNvbWZJeTM3?=
 =?utf-8?B?Q0k0a1FKTkY3RnRIb21JY0VtcVFnQXhWbVY5TXh5a3NuMWx5eXF1cC9DekpC?=
 =?utf-8?B?WXQ1bThveWFRS2xiZ2lMMUZQckdLTlcwejd0Uy90aEdHbGdHU29zSGFaaSsw?=
 =?utf-8?B?bVh5bkJyRGVaUWU5M0tlQVhrZlhhUFhka0FkY3BHNFk3b1EzS200VHcrUEJo?=
 =?utf-8?B?dDRjVjhHUVh3NU5nVUlRdEJMTmhrMDcrdGNXc25VWGZCYmRiZHRVNXJOVnho?=
 =?utf-8?B?dFp4ZmJkQjh2Ulc0SVo1WEJTeUh2ZkNyR3VmaDBvZ1J1MVQ2ZFZ1S0Q3VTds?=
 =?utf-8?B?WHh2RldHb3ZwRnZiaENZRysvSXlKN29UeGxYL1BGZnRBWGtlUjBnaWh3L1Vl?=
 =?utf-8?B?YndNTnRoS1ZnRTlaUCt5Y3ZTUEE1a1ZEaSs4Vi96dEkrQjVLc09YSVlOWEhJ?=
 =?utf-8?B?YS9IZ1FkVzdJTWYvRVRwaStMQ0U1MGovK1d6R2ljRTl2OGZBS0dyNDI1UlQ0?=
 =?utf-8?B?OE9TY1QxRU8yMTF3ZEsvbGN5eWFpdU1UU282TVFvMk1hVUNLUktqa1RNa1lp?=
 =?utf-8?B?ckdEN0F1RkNHUWxUd3RENllqTTNFY3hQT2sxZHo0N0hyMnV2dk1heVduVytR?=
 =?utf-8?Q?mrxFB4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:55.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b01ce-5cb0-45f2-52b2-08ddf1e38b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547
Received-SPF: permerror client-ip=2a01:111:f403:2415::619;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Refactor the CPU cluster creation using the VersalMap structure. There
is no functional change. The clusters properties are now described in
the VersalMap structure. For now only the APU is converted. The RPU will
be taken care of by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  12 +-
 hw/arm/xlnx-versal-virt.c    |  80 +-------
 hw/arm/xlnx-versal.c         | 352 ++++++++++++++++++++++++++---------
 3 files changed, 275 insertions(+), 169 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index af47acb288f..9d9ccfb0014 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,11 +13,10 @@
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
-#include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
@@ -41,19 +40,10 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
-    struct {
-        struct {
-            MemoryRegion mr;
-            CPUClusterState cluster;
-            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
-            GICv3State gic;
-        } apu;
-    } fpd;
-
     MemoryRegion mr_ps;
 
     struct {
         /* 4 ranges to access DDR.  */
         MemoryRegion mr_ddr_ranges[4];
@@ -73,10 +63,11 @@ struct Versal {
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
+        uint32_t gic;
     } phandle;
 
     struct {
         MemoryRegion *mr_ddr;
         CanBusState **canbus;
@@ -94,10 +85,11 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+DeviceState *versal_get_boot_cpu(Versal *s);
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b981d012558..27594f78c8f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -36,11 +36,10 @@ struct VersalVirt {
     Versal soc;
 
     void *fdt;
     int fdt_size;
     struct {
-        uint32_t gic;
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
     } phandle;
     struct arm_boot_info binfo;
 
@@ -61,22 +60,18 @@ static void fdt_create(VersalVirt *s)
         error_report("create_device_tree() failed");
         exit(1);
     }
 
     /* Allocate all phandles.  */
-    s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
-    qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
-    qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
     qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
 }
 
 static void fdt_add_clk_node(VersalVirt *s, const char *name,
@@ -88,71 +83,10 @@ static void fdt_add_clk_node(VersalVirt *s, const char *name,
     qemu_fdt_setprop_cell(s->fdt, name, "#clock-cells", 0x0);
     qemu_fdt_setprop_string(s->fdt, name, "compatible", "fixed-clock");
     qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
 }
 
-static void fdt_add_cpu_nodes(VersalVirt *s, uint32_t psci_conduit)
-{
-    int i;
-
-    qemu_fdt_add_subnode(s->fdt, "/cpus");
-    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#size-cells", 0x0);
-    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#address-cells", 1);
-
-    for (i = XLNX_VERSAL_NR_ACPUS - 1; i >= 0; i--) {
-        char *name = g_strdup_printf("/cpus/cpu@%d", i);
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
-
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop_cell(s->fdt, name, "reg",
-                              arm_cpu_mp_affinity(armcpu));
-        if (psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
-            qemu_fdt_setprop_string(s->fdt, name, "enable-method", "psci");
-        }
-        qemu_fdt_setprop_string(s->fdt, name, "device_type", "cpu");
-        qemu_fdt_setprop_string(s->fdt, name, "compatible",
-                                armcpu->dtb_compatible);
-        g_free(name);
-    }
-}
-
-static void fdt_add_gic_nodes(VersalVirt *s)
-{
-    char *nodename;
-
-    nodename = g_strdup_printf("/gic@%x", MM_GIC_APU_DIST_MAIN);
-    qemu_fdt_add_subnode(s->fdt, nodename);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "phandle", s->phandle.gic);
-    qemu_fdt_setprop_cells(s->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
-                                 2, MM_GIC_APU_DIST_MAIN,
-                                 2, MM_GIC_APU_DIST_MAIN_SIZE,
-                                 2, MM_GIC_APU_REDIST_0,
-                                 2, MM_GIC_APU_REDIST_0_SIZE);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
-    g_free(nodename);
-}
-
-static void fdt_add_timer_nodes(VersalVirt *s)
-{
-    const char compat[] = "arm,armv8-timer";
-    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
-
-    qemu_fdt_add_subnode(s->fdt, "/timer");
-    qemu_fdt_setprop_cells(s->fdt, "/timer", "interrupts",
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
-    qemu_fdt_setprop(s->fdt, "/timer", "compatible",
-                     compat, sizeof(compat));
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
     char **node_path;
     int n = 0;
@@ -394,20 +328,18 @@ static void versal_virt_init(MachineState *machine)
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_gic_nodes(s);
-    fdt_add_timer_nodes(s);
-    fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
-    /* Make the APU cpu address space visible to virtio and other
-     * modules unaware of multiple address-spaces.  */
-    memory_region_add_subregion_overlap(get_system_memory(),
-                                        0, &s->soc.fpd.apu.mr, 0);
+    /*
+     * Map the SoC address space onto system memory. This will allow virtio and
+     * other modules unaware of multiple address-spaces to work.
+     */
+    memory_region_add_subregion(get_system_memory(), 0, &s->soc.mr_ps);
 
     /* Attach bbram backend, if given */
     bbram_attach_drive(s);
 
     /* Attach efuse backend, if given */
@@ -427,11 +359,11 @@ static void versal_virt_init(MachineState *machine)
         /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
          * Offset things by 4K.  */
         s->binfo.loader_start = 0x1000;
         s->binfo.dtb_limit = 0x1000000;
     }
-    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
+    arm_load_kernel(ARM_CPU(versal_get_boot_cpu(&s->soc)), machine, &s->binfo);
 
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
         ObjectClass *flash_klass;
         DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
         BlockBackend *blk;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 1e4229c7670..56ec03a8b9a 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -41,10 +41,11 @@
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
+#include "hw/intc/arm_gicv3_common.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -65,11 +66,38 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
 
+typedef struct VersalGicMap {
+    int version;
+    uint64_t dist;
+    uint64_t redist;
+    size_t num_irq;
+} VersalGicMap;
+
+enum StartPoweredOffMode {
+    SPO_SECONDARIES,
+    SPO_ALL,
+};
+
+typedef struct VersalCpuClusterMap {
+    VersalGicMap gic;
+
+    const char *name;
+    const char *cpu_model;
+    size_t num_core;
+    size_t num_cluster;
+    uint32_t qemu_cluster_id;
+    bool dtb_expose;
+
+    enum StartPoweredOffMode start_powered_off;
+} VersalCpuClusterMap;
+
 typedef struct VersalMap {
+    VersalCpuClusterMap apu;
+
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
     size_t num_canfd;
@@ -162,10 +190,26 @@ typedef struct VersalMap {
         int irq_num;
     } reserved;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
+    .apu = {
+        .name = "apu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
+        .num_cluster = 1,
+        .num_core = 2,
+        .qemu_cluster_id = 0,
+        .start_powered_off = SPO_SECONDARIES,
+        .dtb_expose = true,
+        .gic = {
+            .version = 3,
+            .dist = 0xf9000000,
+            .redist = 0xf9080000,
+            .num_irq = 192,
+        },
+    },
+
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
 
     .canfd[0] = { 0xff060000, 20 },
@@ -292,15 +336,16 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
+    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic),
-                           FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
+    irq = qdev_get_gpio_in(gic, FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
@@ -373,111 +418,243 @@ static inline DeviceState *create_or_gate(Versal *s, Object *parent,
     versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
 
     return or;
 }
 
-static void versal_create_apu_cpus(Versal *s)
+static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
+                                   const VersalCpuClusterMap *map)
 {
-    int i;
+    MemoryRegion *mr, *root_alias;
+    char *name;
 
-    object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
-                            TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->fpd.apu.cluster), "cluster-id", 0);
+    mr = g_new(MemoryRegion, 1);
+    name = g_strdup_printf("%s-mr", map->name);
+    memory_region_init(mr, OBJECT(cluster), name, UINT64_MAX);
+    g_free(name);
 
-    for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
-        Object *obj;
+    root_alias = g_new(MemoryRegion, 1);
+    name = g_strdup_printf("ps-alias-for-%s", map->name);
+    memory_region_init_alias(root_alias, OBJECT(cluster), name,
+                             &s->mr_ps, 0, UINT64_MAX);
+    g_free(name);
+    memory_region_add_subregion(mr, 0, root_alias);
 
-        object_initialize_child(OBJECT(&s->fpd.apu.cluster),
-                                "apu-cpu[*]", &s->fpd.apu.cpu[i],
-                                XLNX_VERSAL_ACPU_TYPE);
-        obj = OBJECT(&s->fpd.apu.cpu[i]);
-        if (i) {
-            /* Secondary CPUs start in powered-down state */
-            object_property_set_bool(obj, "start-powered-off", true,
-                                     &error_abort);
-        }
-
-        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->fpd.apu.cpu),
-                                &error_abort);
-        object_property_set_link(obj, "memory", OBJECT(&s->fpd.apu.mr),
-                                 &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    }
-
-    qdev_realize(DEVICE(&s->fpd.apu.cluster), NULL, &error_fatal);
+    return mr;
 }
 
-static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_gic(Versal *s,
+                                      const VersalCpuClusterMap *map,
+                                      MemoryRegion *mr,
+                                      size_t num_cpu)
 {
-    static const uint64_t addrs[] = {
-        MM_GIC_APU_DIST_MAIN,
-        MM_GIC_APU_REDIST_0
-    };
-    SysBusDevice *gicbusdev;
-    DeviceState *gicdev;
+    DeviceState *dev;
+    SysBusDevice *sbd;
     QList *redist_region_count;
-    int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
-    int i;
+    g_autofree char *node = NULL;
+    g_autofree char *name = NULL;
+    const char compatible[] = "arm,gic-v3";
 
-    object_initialize_child(OBJECT(s), "apu-gic", &s->fpd.apu.gic,
-                            gicv3_class_name());
-    gicbusdev = SYS_BUS_DEVICE(&s->fpd.apu.gic);
-    gicdev = DEVICE(&s->fpd.apu.gic);
-    qdev_prop_set_uint32(gicdev, "revision", 3);
-    qdev_prop_set_uint32(gicdev, "num-cpu", nr_apu_cpus);
-    qdev_prop_set_uint32(gicdev, "num-irq", XLNX_VERSAL_NR_IRQS + 32);
+    dev = qdev_new(gicv3_class_name());
+    name = g_strdup_printf("%s-gic[*]", map->name);
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    sbd = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_uint32(dev, "revision", 3);
+    qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
+    qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
 
     redist_region_count = qlist_new();
-    qlist_append_int(redist_region_count, nr_apu_cpus);
-    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+    qlist_append_int(redist_region_count, num_cpu);
+    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
-    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-security-extensions", true);
+    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fpd.apu.gic), &error_fatal);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        MemoryRegion *mr;
+    memory_region_add_subregion(mr, map->gic.dist,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(mr, map->gic.redist,
+                                sysbus_mmio_get_region(sbd, 1));
 
-        mr = sysbus_mmio_get_region(gicbusdev, i);
-        memory_region_add_subregion(&s->fpd.apu.mr, addrs[i], mr);
+    if (map->dtb_expose) {
+        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
+                                      sizeof(compatible));
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
+        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                     2, map->gic.dist,
+                                     2, 0x10000,
+                                     2, map->gic.redist,
+                                     2, GICV3_REDIST_SIZE * num_cpu);
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
-    for (i = 0; i < nr_apu_cpus; i++) {
-        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
-        int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
-        qemu_irq maint_irq;
-        int ti;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
-        };
+    return dev;
+}
 
+static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
+                               DeviceState *gic, DeviceState *cpu, size_t idx,
+                               size_t num_cpu)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(gic);
+    int ppibase = map->gic.num_irq + idx * GIC_INTERNAL + GIC_NR_SGIS;
+    int ti;
+    bool has_gtimer;
+    /*
+     * Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs.
+     */
+    const int timer_irq[] = {
+        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+    };
+
+    has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
+
+    if (has_gtimer) {
         for (ti = 0; ti < ARRAY_SIZE(timer_irq); ti++) {
-            qdev_connect_gpio_out(cpudev, ti,
-                                  qdev_get_gpio_in(gicdev,
+            qdev_connect_gpio_out(cpu, ti,
+                                  qdev_get_gpio_in(gic,
                                                    ppibase + timer_irq[ti]));
         }
-        maint_irq = qdev_get_gpio_in(gicdev,
-                                        ppibase + VERSAL_GIC_MAINT_IRQ);
-        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+    }
+
+    if (map->gic.version == 3) {
+        qemu_irq maint_irq;
+
+        maint_irq = qdev_get_gpio_in(gic,
+                                     ppibase + VERSAL_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
                                     0, maint_irq);
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
-    for (i = 0; i < XLNX_VERSAL_NR_IRQS; i++) {
-        pic[i] = qdev_get_gpio_in(gicdev, i);
+    sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
+    sysbus_connect_irq(sbd, idx + num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_FIQ));
+    sysbus_connect_irq(sbd, idx + 2 * num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_VIRQ));
+    sysbus_connect_irq(sbd, idx + 3 * num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_VFIQ));
+}
+
+static inline void versal_create_and_connect_gic(Versal *s,
+                                                 const VersalCpuClusterMap *map,
+                                                 MemoryRegion *mr,
+                                                 DeviceState **cpus,
+                                                 size_t num_cpu)
+{
+    DeviceState *gic;
+    size_t i;
+
+    gic = versal_create_gic(s, map, mr, num_cpu);
+
+    for (i = 0; i < num_cpu; i++) {
+        connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
+    }
+}
+
+static DeviceState *versal_create_cpu(Versal *s,
+                                      const VersalCpuClusterMap *map,
+                                      DeviceState *qemu_cluster,
+                                      MemoryRegion *cpu_mr,
+                                      size_t cluster_idx,
+                                      size_t core_idx)
+{
+    DeviceState *cpu = qdev_new(map->cpu_model);
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    Object *obj = OBJECT(cpu);
+    bool start_off;
+    size_t idx = cluster_idx * map->num_core + core_idx;
+    g_autofree char *name;
+    g_autofree char *node = NULL;
+
+    start_off = map->start_powered_off == SPO_ALL
+        || ((map->start_powered_off == SPO_SECONDARIES)
+            && (cluster_idx || core_idx));
+
+    name = g_strdup_printf("%s[*]", map->name);
+    object_property_add_child(OBJECT(qemu_cluster), name, obj);
+    object_property_set_bool(obj, "start-powered-off", start_off,
+                             &error_abort);
+    qdev_prop_set_int32(cpu, "core-count",  map->num_core);
+    object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
+    qdev_realize_and_unref(cpu, NULL, &error_fatal);
+
+    if (!map->dtb_expose) {
+        return cpu;
+    }
+
+    node = versal_fdt_add_subnode(s, "/cpus/cpu", idx,
+                                  arm_cpu->dtb_compatible,
+                                  strlen(arm_cpu->dtb_compatible) + 1);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "reg",
+                          arm_cpu_mp_affinity(arm_cpu) & ARM64_AFFINITY_MASK);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "device_type", "cpu");
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "enable-method", "psci");
+
+    return cpu;
+}
+
+static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
+{
+    size_t i, j;
+    DeviceState *cluster;
+    MemoryRegion *mr;
+    char *name;
+    g_autofree DeviceState **cpus;
+    const char compatible[] = "arm,armv8-timer";
+    bool has_gtimer;
+
+    cluster = qdev_new(TYPE_CPU_CLUSTER);
+    name = g_strdup_printf("%s-cluster", map->name);
+    object_property_add_child(OBJECT(s), name, OBJECT(cluster));
+    g_free(name);
+    qdev_prop_set_uint32(cluster, "cluster-id", map->qemu_cluster_id);
+
+    mr = create_cpu_mr(s, cluster, map);
+
+    cpus = g_new(DeviceState *, map->num_cluster * map->num_core);
+
+    if (map->dtb_expose) {
+        qemu_fdt_add_subnode(s->cfg.fdt, "/cpus");
+        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#size-cells", 0);
+        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#address-cells", 1);
+    }
+
+    for (i = 0; i < map->num_cluster; i++) {
+        for (j = 0; j < map->num_core; j++) {
+            DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
+
+            cpus[i * map->num_core + j] = cpu;
+        }
+
+    }
+
+    qdev_realize_and_unref(cluster, NULL, &error_fatal);
+
+    versal_create_and_connect_gic(s, map, mr, cpus,
+                                  map->num_cluster * map->num_core);
+
+    has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
+    if (map->dtb_expose && has_gtimer) {
+        qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
+        qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
+                         compatible, sizeof(compatible));
     }
 }
 
 static void versal_create_rpu_cpus(Versal *s)
 {
@@ -1284,11 +1461,10 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
-    qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
@@ -1297,18 +1473,21 @@ static void versal_realize(DeviceState *dev, Error **errp)
         s->cfg.fdt = create_device_tree(&fdt_size);
     }
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
-
-    versal_create_apu_cpus(s);
-    versal_create_apu_gic(s, pic);
+    s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
 
     container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(s), "irq-or-gates", container);
     object_unref(container);
 
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
+
+    versal_create_cpu_cluster(s, &map->apu);
     versal_create_rpu_cpus(s);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
@@ -1361,15 +1540,19 @@ static void versal_realize(DeviceState *dev, Error **errp)
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+DeviceState *versal_get_boot_cpu(Versal *s)
+{
+    return DEVICE(versal_get_child_idx(s, "apu-cluster/apu", 0));
+}
+
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
 
     sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
@@ -1469,11 +1652,10 @@ int versal_get_num_sdhci(VersalVersion version)
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-    memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
 
-- 
2.50.1


