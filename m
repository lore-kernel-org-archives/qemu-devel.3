Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E30CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0en-0002Xz-68; Fri, 12 Sep 2025 06:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007R5-TX; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cf-0001NW-Ro; Fri, 12 Sep 2025 06:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQk0VS6gbAuUZRxGqa/Gda1XWLLah1OHatgmnxsPKnLlGCrJvZIl5HEIIA1QVD60ZMKGQ1PkRE8oNRxh/gR3WVSIRGathkuPN8qfuu8xj1NAtoMatg4HtRrMj5DLSRHQz0FqewK5/u9wStgXI4CXYtEl3iNEzuy1TzgKN/3P8Fz/gBJTvFlY7+PPFoipof5hE7mCu3pzEZCethLLKVdGj4lxxecIXOzX+hVRMqBGvHsmVTS4KaqDJw0LnlL3YGq7NJoM0tJwwynNXvEHvG1oBnG5wricetFXSBXSf49FwAq+Wv0g5z8oN007Wz951ODMSm6vEWdLvVCltbTdC9YyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO0EplAPYeJKgny8GNcZa61N3Z7o1rRfoBDwlY/lBWk=;
 b=D4AKXNRngxF+IZc9HNI/+0iyd2Gki+D3dDlyzDqygwc1vRMdVRsv/jiCsWsfubwLAdGbxpqkCWimYdjWmekMHC8sWFektq25RN2d3c6oXZHuXUzgQUq8Qmz9MlCsALZUDlilOo5cOq8EnmqehD1Qa7Q+i0qEpH59KFKkKI9qupS65aqVLA1juddh0QfH9svIwoitu+vKldyBPcaZPYrMu47mqEsl04NEJoaHNuOAiW2KTa2lSasQmtb8Vt9U1ORSu3ouDKt0v7L1lHm2+irzivJ9+epvGv9B3oloriNvB8uqZbHHuF1xUV6R7xO5wCmp+tYwIwnL26MQYClpIZdc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO0EplAPYeJKgny8GNcZa61N3Z7o1rRfoBDwlY/lBWk=;
 b=sYJglkpsVv7+7cgj5cdz0KsgSQqlbzgir6YUoCeyLn05ntVXY7fY9Pg9VhCzdMtjXFIEraiutWkDbRf40sTVjTOLbtc8oQYxGPThV6t86bBuTCN0NNiQNUpiDqo/TB98A8N6WCudo/r55ZjKqgzpYqyjVKb7E7o6i0ru2/fBBh8=
Received: from DM6PR02CA0044.namprd02.prod.outlook.com (2603:10b6:5:177::21)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 10:03:10 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::f5) by DM6PR02CA0044.outlook.office365.com
 (2603:10b6:5:177::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:22 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:20 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 34/47] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Fri, 12 Sep 2025 12:00:43 +0200
Message-ID: <20250912100059.103997-35-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e670b5-01bb-4cbd-9226-08ddf1e39481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWQ1LzFIRG11RXFUdkgvN0JvdGhBbTBsVVMySWxHRmpMSHdmTVpMVTJxdVJF?=
 =?utf-8?B?Z090YUczbmUwOVRQOXU0Mm5NVkRwTmw0WGxweWFxclFqbm5MK2w5K2JIRXhl?=
 =?utf-8?B?aWt5ZzVPVXNnN2F5S2pkTHZ1ZjhaUWFkMUI0YjJNdXFXb2NVSTFsT1c3T3NM?=
 =?utf-8?B?SmJNOW5mZGV2RlNUTVZJdG1DNlFXMTZ5UHRwTEZqQjdvUFRVSUFjaHZ6Tk9E?=
 =?utf-8?B?YkltWUp0N0owV1ZqaFA2cUlMSCtUbzZSelh2Z0VXVVg1dWZxUEwrSEJibjQy?=
 =?utf-8?B?RlZWMkprYTk1dHBPS0VqbGVBMGhUMkk3cDlDQnFaTTRBd0xUNjVRTk9QUmE5?=
 =?utf-8?B?V0orREt0Y3pNR2VDaHFNaHZuN3NUMmU0c0xxd1pxYVF3NEhPVS9XMXZ6Nkc5?=
 =?utf-8?B?aUpNZ3hjeDFDWldXcEN0RDdkMlFiSlk2djhqZms5K1UvaTNUM2hlajYwY3Zy?=
 =?utf-8?B?OG4vZVdkclByVkhnUzNadW5UckdHSU9lZVpnakwwWHRTdlArdHRDK0tuK1h2?=
 =?utf-8?B?cFpQMXBkM2dZeWs4M25ISk5PVVFMYXVEb201aElNNmgzTHp4a2hMUXA4YUtC?=
 =?utf-8?B?V3AwME0vbDlTd2xiVStPYXloSmovUUZiYkxEaTJDekZVMHc1WEQ5LzY2UTJH?=
 =?utf-8?B?eHRlMXIxL2hlUWY5NitBWm1xMncvUzV5M2lMVklLNEppZkNiNmRRdGFrSi9J?=
 =?utf-8?B?N09YdmlReDQzb1kzdDNEYWZJb2JCVXAvNUVld00wK0VQM29FSnZiMWwwd3Jm?=
 =?utf-8?B?VmZBUlhQK0pWb0c0VUVsZHh4T2JtV1MwWWRGWnVrL0NDNkV2UUhJWUlWeFhn?=
 =?utf-8?B?WGxLdVoyZkhqSC9QaFNrQTI3NEFxeGRROHBqS0ZDZFFkN3NFYXlOaE1JOTFv?=
 =?utf-8?B?ZHlCblhKNHZLMlJqWHlRbUdmRUplYW5ORzl4T0NnTklnOTlBVlF4NlZnQTJs?=
 =?utf-8?B?Q2FPeFhNcllURnhaeDNCaE5oR1pEYjRocWxpU3ZJWFc3bFZHY0YyYUcxRHNF?=
 =?utf-8?B?disyUlVOMEdsRWY3VzZVdHdvU2Z1dVZja3QrQ1pGOG14L0dnMUtTVGE2NExj?=
 =?utf-8?B?U2xQb1QyaytFdGlrNlYrc21jbDYrdnlwdHlGQklNeVRqbEExN2hPdFMySStz?=
 =?utf-8?B?UVFYMmhCejlwUGFyY3JpZ2pCeFBkTERGeTN5c1A3RmsrQXBYZlFtbmZMYk1J?=
 =?utf-8?B?RGZBZ3d2MDh1TDBFeStPT0F6czRDdHBTc29XKzFadWtPNllFaW54ZlFuc2oz?=
 =?utf-8?B?LzR2c3EzTTkrT3dNSGQ3U0RkdTY4RmUzYWtDSkx5T2lsc0lwdEVxMFJDQUMx?=
 =?utf-8?B?YmF0dFB1UllwWlQ4NGtnOS92NGs3b0E5UlN1eVpleXVneXRzcFNuYWFqeFVu?=
 =?utf-8?B?ZkNQbFlRRXlWNFg3K0g0ZGZqdjk2eUJrT3U2djhNYXhQYjFuNnN0M2YycTQr?=
 =?utf-8?B?T2huWk1MdVVianNHd2N6MWFZZTQ5UHVQa1E2M2pZdGZRUWNVRjRPTVh6d3lI?=
 =?utf-8?B?SUVGdzVYek0rM2NWd08wNXJPeDl5L3dMK0Z0R0ZZK25mYVdGdG0xRnFzY2lW?=
 =?utf-8?B?VXczZ1YxMXQwQi9DbWI3Z2dZMStNbVRoT1pNbUhzemtaVjYzdDlnSU93YnRj?=
 =?utf-8?B?NHBJa0Z5TTJxbG1FOUI0MFFnR0hNazB3SWFZdGprRWNlcVZQMjV6Y3dtNTho?=
 =?utf-8?B?YThkbjd6c0QwdmhJcitrWEZZU3cwckpWUndMWGVMTkhuZzVhRE9kT2lGbGdJ?=
 =?utf-8?B?aGRHMDJJTXdkMFFXMWljaW04K1JKU2V2N21kZytBWlZ0U3NGeUM1N1N6RnRV?=
 =?utf-8?B?ODhYM2xJWkFIYldHZGpJdm9JWURyMzR3NVVGMUNWWDh1d2orNkJIbnZMOVli?=
 =?utf-8?B?OThFaTZEOWx6bGptTUJvQmRSaVZJeG1uSE5yVXd1dE1pUUtpcXBEcnFkMU1p?=
 =?utf-8?B?dVR4d2xpa2N4dm8ySEI2RmhQZlY3eFhNS24veklRMW85UmpuS0ZpcXk1U3FY?=
 =?utf-8?B?am9nbld3TC8wRFhmcmRqTEtKUVVJT2FxU2gveWVwSDhQaTUrZ0xjeW5POXJH?=
 =?utf-8?Q?c8aKXJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:10.7053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e670b5-01bb-4cbd-9226-08ddf1e39481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
Received-SPF: permerror client-ip=2a01:111:f403:200a::61a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use the bsa.h header for ARM timer and maintainance IRQ indices instead
of redefining our owns.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  6 ------
 hw/arm/xlnx-versal.c         | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 7bdf6dab629..da0260b83de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -85,16 +85,10 @@ int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
-#define VERSAL_GIC_MAINT_IRQ        9
-#define VERSAL_TIMER_VIRT_IRQ       11
-#define VERSAL_TIMER_S_EL1_IRQ      13
-#define VERSAL_TIMER_NS_EL1_IRQ     14
-#define VERSAL_TIMER_NS_EL2_IRQ     10
-
 #define VERSAL_CRL_IRQ             10
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
 #define VERSAL_CANFD0_IRQ_0        20
 #define VERSAL_CANFD1_IRQ_0        21
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 02119d13533..3ccd8a88205 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -47,10 +47,11 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
 #include "target/arm/cpu.h"
 #include "hw/cpu/cluster.h"
+#include "hw/arm/bsa.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -671,11 +672,12 @@ static DeviceState *versal_create_gic(Versal *s,
         }
 
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
         qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
     versal_create_gic_its(s, map, dev, mr, node);
@@ -696,14 +698,14 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
     /*
      * Mapping from the output timer irq lines from the CPU to the
      * GIC PPI inputs.
      */
     const int timer_irq[] = {
-        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
-        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
-        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
-        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+        [GTIMER_PHYS] = INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
+        [GTIMER_VIRT] = INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
+        [GTIMER_HYP]  = INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
+        [GTIMER_SEC]  = INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
     };
 
     has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
 
     if (has_gtimer) {
@@ -714,13 +716,13 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
         }
     }
 
     if (map->gic.version == 3) {
         qemu_irq maint_irq;
+        int maint_idx = ppibase + INTID_TO_PPI(ARCH_GIC_MAINT_IRQ);
 
-        maint_irq = qdev_get_gpio_in(gic,
-                                     ppibase + VERSAL_GIC_MAINT_IRQ);
+        maint_irq = qdev_get_gpio_in(gic, maint_idx);
         qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
                                     0, maint_irq);
     }
 
     sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
@@ -840,17 +842,21 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
 
     has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
     if (map->dtb_expose && has_gtimer) {
         qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
         qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
                          compatible, sizeof(compatible));
     }
 }
-- 
2.50.1


