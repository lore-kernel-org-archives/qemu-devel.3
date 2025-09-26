Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52BACAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22bz-0000VC-4t; Fri, 26 Sep 2025 03:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ac-0006za-IW; Fri, 26 Sep 2025 03:10:01 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aG-0006hl-NC; Fri, 26 Sep 2025 03:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9FkIqtu/Fsup4EtOwTL+QK2HPf1SBJH2i9iOEUqln25HNw0nwTkLlD0t+BUGn92JN5kVx4fOvBnyBtyZ4Lt1qrnt+fi4e8zDvdbt+GOyW6k9UbnxREpIZTvAHNzRFYXC+qkPncMMuolOOCjJZLxy4jq+gVlaSY7yRz3vCRjLLrWK/anaOS0pkzVWbE15H25xJPVNvV3ldqPfET0J+6U7D5E9KvfQfZksakdS50mB2QXkdMIEX9VrrHJWxZ83PUeE3J0dCGwGiqwk6/Y0VtmbyNtiyA7OpFUaBN+BQZaZk7xYwsMqwVQXdm9GQKWRQgtFg+fAls80xx++T0mP0pDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0iPKbLZG28cAMn5R5u5FHWr3I1UdY0InQ0KNL+b1Gk=;
 b=CVU6u5SBvR4jtdhcr/qerja25/93PvlcGnFpmb46lGGwj/J2saeJDSU5mlkeKuw4m9qe4Hdfh2bFdpg0X/EWhA/EPbWwGizY2lLP9sIXgYNMiha/R9IE4HOr2f8wmkvr95FpzJubfUeA+GWo7wF+z0HSBI+83dxQ7JBcvu8eISgSmD7sKY9VumM3sJf+7uJBBEIeIqaArANxAZKil8/xyxZf79nrrebPKwjufUXCztgjCvlAprGGHF9GYbk9vJaVhkW1K5GLYyIPwj3mVhhRYsulmnWr4GCalL2U7YFrVKInhhHYatNqJj5JYyiHKtmJyxJuxW7E6Lp3e9p6CjQ3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0iPKbLZG28cAMn5R5u5FHWr3I1UdY0InQ0KNL+b1Gk=;
 b=4Q/t9L9ZoIi8kgaJ9RXc51KbtqJJF8N/NMatufDtCNGvKEpmBi3mFkiziIDJDQrKU4S9Nau5taJ0SvClS+pznYZvpTijS6bKh/qiaENVeIv/TJsw75J8wgX7rUHscG+hGxTq1ktMo7+yR9GPeWJyHq511VohMsJAZiv9tkaG2r0=
Received: from PH8PR21CA0010.namprd21.prod.outlook.com (2603:10b6:510:2ce::10)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:26 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::4c) by PH8PR21CA0010.outlook.office365.com
 (2603:10b6:510:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Fri,
 26 Sep 2025 07:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:14 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:13 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:12 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 34/47] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Fri, 26 Sep 2025 09:07:52 +0200
Message-ID: <20250926070806.292065-35-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1982bcbc-eea8-4326-9200-08ddfccba109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWxFOUo5NWtDVUNoWm1qTHB1QUgyaGkzWnpHWGQ1UzY2UGU5ejQ4OTdJWXp3?=
 =?utf-8?B?c1lhc0JNTkI4c21tckUyU0tRQUNQaEVUT2RKNnRHRC9FRXg3a1pEQkRwQXFv?=
 =?utf-8?B?Z1ZmdWZDeUd4Y2cxQWp2S1QzWGx5MmRhdlBFUklSbU5mVWJtekJtQ1ptY2FW?=
 =?utf-8?B?V1plM2JNa3hYZGkybGNQdFNuTDNmL01lbVh0dXRRcDlvMmZkNVpyVXpxTldX?=
 =?utf-8?B?aEZuQUxUclgzclZISlczbkJCR2x4U1R5N1RWUzNKMW5VbDVsdXQzQnFJNEZV?=
 =?utf-8?B?ZzJWM3pJQ3N3Tm9Da0lKWVFES3F1Tld3NXhKNC9aNUw2SXNvTld0bnNNbjh2?=
 =?utf-8?B?dlFVRUFBaHl1WGdBbnAxU25XOHBhV3p3ZDIwdkxndGJrMDBiaWZzaDFBTmNh?=
 =?utf-8?B?K0VsY1A1TVBVdVQ0Wm9idE1Ba3RSZzBwQmNyZnVkc0NRL3JwbktRQkREN1NQ?=
 =?utf-8?B?VHJOWmRZSEI2RmZoYmt6MnFaZFBiejJXeGRKTS9iRGZCYmVpU2xmT3lJT0Jo?=
 =?utf-8?B?ZWtsZ3ZwT09nVjJyQjN1UFIrRUpsN3k1ODQ2YWh4WFFYTk9SYnpEL3RsS0Vy?=
 =?utf-8?B?K0xTb3Fja25HT3dHQk5HWjA5bW9VZ3R2NXRnanRsV3BoTldmZWlBd2l6VEhD?=
 =?utf-8?B?OUlFRnpPQXJpMWdSampKOWlsb041YklaM1YweVoxZ3EzWmRuN3JGeWNtMDNm?=
 =?utf-8?B?VEtuTVMzUjhSZG1zNHA5UllUUG0wMlJHckZjZnc2MlMxbkEydTZZSDgrQVJX?=
 =?utf-8?B?MmgwbWRzQXV0Q3dlQWFiaDN3Y0Q4Y3J5K2VJUWZlbEZzRHp0U3RZU1NYb2dq?=
 =?utf-8?B?OUwrQyt6Qm9aUGJSVXY3SDZqWEZOY1hUcStUTGo3TVRWOHJoRnZ4VVVuOFRZ?=
 =?utf-8?B?eWRqdTZUS0tKL1NJWUxlUW9qRmFuV0FOYVFqOXZRUlluMk84L1FTOWRpSmh4?=
 =?utf-8?B?OUw0c2NtenhwbGc0WjhZaU0zN3AxWU16Ui84cjFiUmZXeW1kWHA5QlF4Rkl4?=
 =?utf-8?B?cEttY1UySTg1M1F4UHpiWnF4NE0yWFhWbHozQ0daSGw0VWJUYjloMG95L1dM?=
 =?utf-8?B?d1Nyb2s3cG9OOHZnQVM0d1piMzJHWmFGTmZWTFovaU90VkpZMHlGSDJqVlBS?=
 =?utf-8?B?WFd1bU5YMDV2bGhmdWQ5KzRNZmFkZUhWdFN4SUJ3cmc4cVljMFIvYkVMSkNo?=
 =?utf-8?B?UDJoMVJRUVBjMnNDeXZHaXh0RU5GVFJ0UllGOEtDdTZjUWdxTTlXeUNyV3pT?=
 =?utf-8?B?R0pRZ0czWnlBRHIyTG10Rm9EWCtPaE9ua2liTGtwR0VubHhTYW8rTXVSUThW?=
 =?utf-8?B?QXJwMi9wRVZWUTNQZndiRVhZdnAySmV0MUVJdndDTmV3UEM3bzlkNXdtVlN6?=
 =?utf-8?B?b1plT21JQnFKOG5HOUNEMFk0ckxBbXI2NXBXRHpuN2NzSmNnSGR0blVWK09X?=
 =?utf-8?B?alRhK2Y0TnBIdld6ZVh0RnIzbkFzcmpGcHBHWlJFa1JlSGtBN2tCaHdoQmpV?=
 =?utf-8?B?Yjl4THdpV0dHSThxbVk1YkRnWE5NMlZMek5iTGY5VitxcytoMXVTR3lheU5k?=
 =?utf-8?B?bDkrZ0t3bEJ4RGIweG15QUFoUUw4OUtZM0NZOWQzRVIwYW1TN3Bxbm0vSUZY?=
 =?utf-8?B?RFVrMllWb3JzS0VqNS9nRXowY2t6WHB6dWx2STFYMERUT0RKSUJXeVJjUHhn?=
 =?utf-8?B?cE44TjZKTFJxVDhKWEhQREF5cHFVeHFObTUwdFMyWVc1WnQrdWxzRHJicnVV?=
 =?utf-8?B?MFJhSGd4QnU3K05OVUUwdm1KbHl3Z29VcVo2TThvYXB3eDViZXVFMllPRVpy?=
 =?utf-8?B?TGRKZzluaDZIbEFUdExRYW1UZmtvTnN5bThQdnZaSkpoTnhOSFQ1VmY2QW85?=
 =?utf-8?B?TmtUUXo4eFAyTmU4WENYMFlYV0c5c1kvQ1B1VFJjU3ExU3pzL0lNMGc1Zmtq?=
 =?utf-8?B?Si9nT1hWUUNrckhvRWtKMlJaZVBWK2k2NXEyMVNBOUlIQjhqZnlyWGlnbHE2?=
 =?utf-8?B?UlFwS2Q3Q0kwOHZwbG5IazJlNWNmK2ppWnhRTktNYUNQRVlYWHVTYTg5c2FJ?=
 =?utf-8?B?QTFPTVFhTzkxSU51Vm9rMmlnMmJGYzlHbm81Zi9tTERUVE9scEtrZE5XYnlL?=
 =?utf-8?Q?6/AM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:26.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1982bcbc-eea8-4326-9200-08ddfccba109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 6604e24a9cd..dc388300185 100644
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
2.51.0


