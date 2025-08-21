Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5739CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50g-0005HR-9q; Thu, 21 Aug 2025 09:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z5-0002Bv-9q; Thu, 21 Aug 2025 09:05:39 -0400
Received: from mail-mw2nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yu-0003DV-KL; Thu, 21 Aug 2025 09:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn2F5GU9oEKk1132HNcWO/OdpSi1xPkfTMlapGgk9KmnVjGc3Z8qajFCRIFYwkPvALHI3YG8aIoTZIuOATLCDs9sKLml/J/BAIDQZ57YRgfmfAnoWIn5mXgfUCABYfKtMEff/l62ApJkM/U+c7oKAoT0PhDyEwKMkRv2v+ITgi4Fctlr6thoaJlLcOOPfaUz5ZE+ohfB4aGiK8X4P3ckMa9A0RcyUtNZqVt8ZDzYcloywB9k/GEfak/JwtW1LLnyLxYX2hbzxokO1Dqb3+Hgovzt7Se9dKhKDMgClnJnjM4XuiuSDMR6uak+v+Q9Rp7wSsTjKvBV/Zx7LfHWjVVg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xlm+g2PSfea3UdRe2hxwBnlquxLBJAQaw1hr7qSBbBY=;
 b=dvpXk5QGJA+2ooTh0vAg+WTsdbSIGt7rKGjvPNqbOOAGrUrPtveqY5txCmjCS7wYTI7KCiB8/QBgRlxLR2/eulvQp/6mHo3YzNKUUUXri5u7wh3tSMMFTHg1ygawIuXUAD3kW5qx2ulS8vDJVIdJibX0ZqspMf2KVgkGgm9Decw9cHMb82hDWTF/4e5xkJcRoV5PNj7SgPfmB6LhTrETXny9vyZOYR5yEoZX4bm04Tpmwg75FyCXTXJXSZ4yVHVStq8i9VeYNjVui0ax5ifmzNtOhMU1jbFORRd8zMvi+ewSg15rj8VVyT772pnsfVQkM+MLUToA0CZp3fIxZjSdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xlm+g2PSfea3UdRe2hxwBnlquxLBJAQaw1hr7qSBbBY=;
 b=Q7gfG4dIx42lM2wZv7vI5fgwODMmZiYpILfnJSrOQgaJ9/uwA9ItNnnGYfEcW1OhoQNU6qUeG6/++A7AovsLvc0Xv9jTTxrWM16yAWJ55xd8Mn7Axkl1osOTc/GMQbvSndeJ9jdHmEjvzU2Po9Ukc3+iacPc9zmLHlmyDLJPPd8=
Received: from SN7PR04CA0073.namprd04.prod.outlook.com (2603:10b6:806:121::18)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Thu, 21 Aug 2025 13:05:18 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::6d) by SN7PR04CA0073.outlook.office365.com
 (2603:10b6:806:121::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:07 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:05 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 34/47] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Thu, 21 Aug 2025 15:03:33 +0200
Message-ID: <20250821130354.125971-35-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb4c92d-087a-4f86-f6a4-08dde0b36066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHR3Z3hGZkljb25rR29MV1NvS0ZNTmMvSGw4QWpoT1R5dWdSZTJXSmVqazNY?=
 =?utf-8?B?enQrQWUrVEFEaC8zRllZNFE1NzR2R1dmVzhodnZWcEFCbDdGeFB6VVE1V0xP?=
 =?utf-8?B?VHN2eGdUZFh5dmVyL0FQK0JlZVZxRGJTaGk3Zm9obDEwRTV3dG9pbFliU1Nu?=
 =?utf-8?B?K1hXTTFPbVZjMDRiT3RORWdBSTZKYm83RkVRUlBsVVlZblNlRzIrdEFPUktY?=
 =?utf-8?B?Z3RjRG5hbitIUVVvazh5ckJwTzZCTWFicWtQZC9hUUhYeEtsUXJyYnRqYVpM?=
 =?utf-8?B?M2FKOHBZUjFTNnBRWisrVSs1MW4wYk5lUkFsNmFsSUNTWnNZQS9raStESVB2?=
 =?utf-8?B?SnlFOE9YOERWbUJDS3Fub08wR2VMOXRKbXFFcTRLd3l2enZJYVRub3FWV0pr?=
 =?utf-8?B?UnE4RVNMQlF5aG1sZHhXUW1sZGRoVXZGRVFRN0NQZnczRFR2c1lTN1d6bWlv?=
 =?utf-8?B?RWxXWC9yV09UcVY2dUV2OUlBbzRrUmhVNnRoenBKOGRLRkpGYktWS2dhTmNY?=
 =?utf-8?B?K2h1SGE2eGNMaGpLdXkvUGt6M3JYWU1SQlduS0plZFMxVys4SWxZaXhienJG?=
 =?utf-8?B?T3FKRHpJRzIvWWUwVC9jcC92dytLWWJqd2c4b0l0OVFmRHE4YVpRZE01V21s?=
 =?utf-8?B?eHMxWmN3c3RoVHQ4WFRxNm9ZTGE0M2R2d1E3RG1FazgyRktiT2Y1RmVqNkRJ?=
 =?utf-8?B?QWdyd2pOTHlNeDNoRVhQMTZUZzZxcXJ0VkhNWDRycDBQanVrTTAvU1hOOXkw?=
 =?utf-8?B?Z21mbFRmaWFaODFHancrcVd1U0pueUhKTk8weWpCU3B5aUoxazQ5V2hqVkRx?=
 =?utf-8?B?K0kwaXg3TVdMYzNHYlF1dnZxL0k1T3AyNDk0dy9la3UzZmt5TndSZnB5eXBt?=
 =?utf-8?B?YmMzZkV4K01XVFcyL2dKYlUzVEdVeHdpcndEYnFORkRDTjk4cVNDYkpMSVN1?=
 =?utf-8?B?UDRDMUN4dHdQYlJiWjMyN3JOM0xUK2tzOVk1RHZrZ000b09ZLy9UbWR2WEs5?=
 =?utf-8?B?ZUYxVU9sc2hnbUFPd0tycFQ4WFFSYzd1Y3pLdnZIUHdxV1FDTkF3d29NY1dV?=
 =?utf-8?B?MmtGSE1VRzczZnVnaW9mamV5REU1K29nQXphcEM5ekcvcGZjT3gxVFc4NGx6?=
 =?utf-8?B?amM2ZmRYRTdZcWFXdkRrU0JNUWdFQjJtMU1ZMTV5L0xEd0JldEpzc3o1ZWJs?=
 =?utf-8?B?TXFodVNLNnIzMGl6c0sxcTNHV016OGRGM1ltVFNwajZ0RXpzM2xmRmsxL3B2?=
 =?utf-8?B?OVFoS3lzSzJ1K2xJakpsZUJyUWswSWptTVNUdXk3UkIzbWQyS1BqU0JPcVN2?=
 =?utf-8?B?bDE5UXFwMEhkM0tlL2t4OTVvdFpSU2kyVzk5WDJaMkJ4UytucEVHdEJPYjhj?=
 =?utf-8?B?V0NMZEVEdHdaUkVXNnAwOUdpUjgvSko0R2R1QkVSaDh3Tm1iU3E2YUJDbzFY?=
 =?utf-8?B?dEJZTllKUml4TUpvd2taV0ttRU5pY2lzUXFrYXdVbElxT1RDdi9HbldzOG1i?=
 =?utf-8?B?MFR0d3k4MVgvRFlqN29XY2xYTmdKMUZRWnBSNCs4K0Y5aUxIZ3dWT1BILzJC?=
 =?utf-8?B?TDhwbXNnNGxXTGZGM0V6MXFCRVFqZG94cUZVOURqSkNodXVDckllVllMcks5?=
 =?utf-8?B?OXJVN1ZCa05Pd2xYbFJTb2xjUmNCdkFSeGJGeEFaL0xYZHpyM1FBVFFSSHZB?=
 =?utf-8?B?YlprbzNxVU5WNml1QUdqRktEcUJ5SzVpQ21hT2s0Q1V1WTVQQThySytQOWdP?=
 =?utf-8?B?b0RZWU9WQTgwOGZPYkQwS1B0akhOZ2FZdGFWbTNJS0F0UHhpR3ZFamlKdkIx?=
 =?utf-8?B?aGFBNHRuTjVvRHpaZjk4S1U4djUyTVFaN1gzUENNUmU3QzloTFJoQmtleXk0?=
 =?utf-8?B?WkpLY0dMOFZQcEJYVk5iQ0hYWno4VjAvSHRVQm8vNnNsRmpqcmVYUG5vWWR2?=
 =?utf-8?B?NnNnblVFZjdjc1NlZnBOV1dzc0N2U1BXUlAvR0VncGpXOUdPNFVabFJaQlZZ?=
 =?utf-8?B?aDJ5VkNJRitQZE4rU2dSQ0xWekJweGl3SjY2MzRQVGZ6YUUvOHdBc2k5Y3BO?=
 =?utf-8?Q?O1e5kO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:17.6952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb4c92d-087a-4f86-f6a4-08dde0b36066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
Received-SPF: permerror client-ip=2a01:111:f403:200a::62a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
index 63c4e6eea6e..28db3f263c6 100644
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


