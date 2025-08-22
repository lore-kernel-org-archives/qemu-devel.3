Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE70CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXU-0001CP-4I; Fri, 22 Aug 2025 11:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWm-0008ID-On; Fri, 22 Aug 2025 11:18:05 -0400
Received: from mail-mw2nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60f]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWR-0007EY-Vg; Fri, 22 Aug 2025 11:17:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNIJuU6rGmV/OhJWCUm6KPlMDgIGVa8hEGVHE0T5oVEtIstWTWESLSynmEe71GFA+teKPbkL+8VGbuU5NEqQBb+JDcJtinLQc5psqP1i2U2k72DL48pntMV1F+JSYcuy/bMyOFKiY9GNvVOiqSQ7gVefaUyu+Qw7UeVsVIPg065LLcAZEMO5ljuWOkvN4hNXHe0sns7ASvzKn3k2eTr62Ye/TZFShVBGCuMwYGxRMTAZmMzC68zBBz5cujSRYU5cuRUnAjcWODOuyHP8A4ruTChCwEzLOCDU4K6m0tY7XuI6A7izgNFlyx5dBY8LT7zMCWNwTE0tJ02Y7k3/qmx4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FMqOPBoo82tQMV8EShowbWIztb8FCt7ITZgBSspjf4=;
 b=LNfkL3uiGnP+v6KOHR8xHt1xpvCzw3UIy8nbNV8RWjzaTarXd9iGWAv9mD2RgvPY/N5Fn4XFkQNWF0fhC3L3o9B7r8lQIrcKNouZTG5LjYsoshc2ak9r3gLHZBrDXd0GZfrX6PoToSC6SyaggYwgtqaZ6MSQcZy9uzUKGxRY0hpjkvY+TUaIYxMXH8CphYn2BRGLJjWM5QL/1F0macgE4XBpWiMTvujJvrPSbe0Fm2RMmyJqXNSNmu6+eL6LYmny8BAtovgDg8LtwNR50UbQ5TuywYxC4mgSwmE8O8f7Rdoz6kTjoor15ATP3A1w5/6j/5Zf76tgN0lEbglHc3R1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FMqOPBoo82tQMV8EShowbWIztb8FCt7ITZgBSspjf4=;
 b=q5umB78Uy9uzEBcQxCba/6e9OjGsiePxkBGtGkyFNHDC8W5F0E336p64t07KV1W7Wlwe28d2ycVJ6xbnRdXe3DtkVrO0IW9PdJrKXaB4INHlon29LC3RM1lUpeeFzKRkILLw8eyNsDzDyEezMHf2vqDTzPDQ9wGssvEW+QDl/s0=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 15:17:34 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::20) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:32 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:31 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 34/47] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Fri, 22 Aug 2025 17:15:59 +0200
Message-ID: <20250822151614.187856-35-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 624100fa-65da-4dee-aa2c-08dde18f0532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2EySnJvMEg4SDZMSmdudVVYc0hmUkcxbkpSZmtvcXhvcW9BV3dPQVhtbTJp?=
 =?utf-8?B?L3lhNzlVRk1TaEc5OEVsMG0vMjAxTWtqZUtFeWpJUi9KTDNYS09TSGlZTjRr?=
 =?utf-8?B?Nm5VU0VMdU1DcU9ETXNBY1M1VGVtSEQ4cjhDV1BhMzRncGM2NnF3bUtxaENw?=
 =?utf-8?B?ZVFPb3o1Tk1tdjB6R1lTOVRtNEJkZW9QQkI1Q3RweFBsWEZTbVU4aGI0d0hW?=
 =?utf-8?B?TTBmZGlZK0tBak1lVFM3TWxBWUZSMFFsS05KNjNwMWJHVlcxMHZKZTNaSG9j?=
 =?utf-8?B?RzJuWUk1ejJ0Tkw1bFUyeTFLMStveEZLVWZrOHpXaVdMT0JDMVZ6aDVKZ2Nx?=
 =?utf-8?B?cVVZTGd6dllNUFJIY3JmTzQycWhycnBmblQzUHNxTW5kckhPOHZjYnhXSjgy?=
 =?utf-8?B?YitRODlJODRvMlF0VEIrTnNBQ0R0S2U5SWZpOFJOYUhUVmdEY3owVWlWOWU4?=
 =?utf-8?B?enRBUU44WHBDM1BmSTJhRloyY2FhV2drTGg2Vi8rYnFWNlcwYUNJRmVJZzZ5?=
 =?utf-8?B?c3IvaDBXZnA0Y0pKNjhRYklDK2puSVdwMjdtMEhQQldjMzJLYURmVHBESy9w?=
 =?utf-8?B?V3RBTTkyQS8yRXZWZW9rY0s1SllUNnhMdDlEVzQySFF5VVZ3SVJndjFxM1pC?=
 =?utf-8?B?Y09XbGEvb3BrcW5OeXdkY2ljdTgyZGtkd0ZqTTFXTFdmVUtINTJMRW9TUEFk?=
 =?utf-8?B?T0lDbW0rSExjUFh1dFlWYVJiTjNLUjhKK21yTDl0SWU4T2E3OTQ3QnltcUdh?=
 =?utf-8?B?ZjF6Q0tNTkEyM1RHZmtyY09ZN21obW5wU0VseDBSLzhKQ1hZS2I4c2JXYWgr?=
 =?utf-8?B?c0pJZ2EyaEplbkZQNzZMdHRGZ1ZDdHVheTJDSXBFUi9ZaXFpOHZ2Z2d1OFBq?=
 =?utf-8?B?dkxoK3ZybzY2eHh3RzhDVGJsVGlZamtIY0dKRzlZWlZtbmxLcFM1c0JmSThs?=
 =?utf-8?B?YVlpa0x5c3Y5TFFJNUVlRC9teVdPYytNVzY0TlhlUlhFYVJYZCs4bFlQMGN3?=
 =?utf-8?B?MjVIWWRiaXA5SWJhS3F0R08zdExPeUlFaSt4Q2JXbEE3cXNCd0NkaWVSb1RH?=
 =?utf-8?B?VTNKbUVuUGdybGdGQ3YxWkRLb3VYSTNnYkk0cW1pMjFGaFVUU2lRRkFUOEZ5?=
 =?utf-8?B?SXV5VHJRMytyK1Y3VjhtTFRZUytXeEx0dU9sYk9KaGlNZ2I4MnZucjdGbmhq?=
 =?utf-8?B?Z2ZJMUZrM3JiZ21nODVoQ0UvbGFsSVFleFBNR3BwNkJRWGxmQndzbUY0VDFP?=
 =?utf-8?B?RmFJa285YkVURmNjdi9NdXVWbWVnZlIyR1lXaGNpRFhrbkIzYjJWTW1xMVI4?=
 =?utf-8?B?Z1hubTVHMWtaazRWWGNYY04zMHRRY2w0ZWtzN1A0QzRMZnRoczZkenR1QWVm?=
 =?utf-8?B?WHFzaVlGZ09YV3dsMzN1OUxsWVRNU1lXL3A3Z2o5amhuT2Jtc1JkbXFkamhV?=
 =?utf-8?B?V0hwdExhbUpXc2sxbG9VYWRWUXJoU1NGVkZWSUVtMXhyaDJnZklZU05DNWpX?=
 =?utf-8?B?dHk1bm1hdkx4N051THRzcVhFejlkOVFBUkNhVHc0My8wVHhEbk9zTHNMV0Fj?=
 =?utf-8?B?SHN1TEhhY1ljUjg1ZE8xSDU3L0VFR1pCOHI0V0dGamRRS2duQ1dhdHE0TE03?=
 =?utf-8?B?ODVyMnhST0libEJmbnRpWVNDc0ZTcnpCRUNiYlBYQUNhYlZjdmZwdnBrV0JD?=
 =?utf-8?B?Mit6eE9Ra20xRklwL3hiMHcrd2NQSnJmTGV0MWNUZXBuN0RYRVY0M0I4QVV1?=
 =?utf-8?B?N1hVeFZZUCtsQ0kxTEJsWmEzT2VIbUhweGsyaVhrN2QwcjBkd2xBdndPVDR4?=
 =?utf-8?B?czhITXN3dXhnNTZ1akZmZnA2Ymd2dU1renVTSXY4NHFRbEVvV1p1cHZaSmgy?=
 =?utf-8?B?ZGdpSWdER3pVQXRKWGVYYVNPQTYrMkpReGpaRE5yRDBhL3JGazk2YXlXbEt4?=
 =?utf-8?B?dkI2eEsyNUQ2RGVNbU56SDEzbzRkS0I4cDFOTnNWL2dZY3UvMERQck5tVDRW?=
 =?utf-8?B?cTVnV0JYSVdDQTFibmFhQTJZNjFPNHRSRk15RDh3OU56YUpCTmwvM2RDOXBO?=
 =?utf-8?Q?AJZQHn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:33.8888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624100fa-65da-4dee-aa2c-08dde18f0532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
Received-SPF: permerror client-ip=2a01:111:f403:200a::60f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
index 1462c2ffc84..3b6413262f0 100644
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


