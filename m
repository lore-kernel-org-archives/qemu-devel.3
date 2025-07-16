Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BBBC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyud-0002M0-1w; Wed, 16 Jul 2025 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysG-0002C1-Id; Wed, 16 Jul 2025 05:56:34 -0400
Received: from mail-dm6nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2415::630]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysD-0006ll-Nl; Wed, 16 Jul 2025 05:56:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH6QCma3Kkww7lBxWbf3cwV5ILgJLvsP1uPELIEvi+Y2LwBT9hSUbwX7QA/FQgPfqfRljoYzmioLcMGrievOFWqWRpNMmYAT4LxKnzMao1xt65M1IiOgrbvS081SoRWrVcwJ5yghWYnZiU8Y8yPqy4DsInIVgmK0fOwqTvk8poR+6C83GONePtO4aTf/yB3V7os9LkxxgrNAVt8ZjRnDxHxAZDSo0oSmlTAzz5KXQ8JlZakj880QxlyiQPUrvKX8p46/WNNwTqO5T2XqbTJ4a36pBlrsTAEPU0HPplROALJSioS0csHxZVYGN4/eztPDzSrYOuspywXsJVGXcUivSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTo2Hd08Ch5u0f/PtQFzW+eX6kFB/JWuYO3kuS9CWbU=;
 b=xgBRy/eVlE+kPu2uGqls1GZq2xXm9+HBHXl1V/kQkk6vF74U50WHgoUgtH2I4x6+Njpe1k3i29EOxCAG3ojPHPD7M7PFlCKqai64R8nYzgBHFrWRzRtsBLf8vi7BL+vOdn3yPjumljclbyE8uJcXtUK9vt5BnnIwflWz5DsyxlmlKYulANHkVDNBJc+EHkaC5yEMX0aMxj5TND+xd1tw868N2epv4mNzjFj9lDsMcYrmrNM+XsbF2Gv6t+tXf3ehZhaO3UQco3rgsU0wheTac8oTdWE0eitQ9PEdlok6Ag0uzPujMsJc4by4VcrEYFrhJi4C0RDKlsbRM2RDsIAtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTo2Hd08Ch5u0f/PtQFzW+eX6kFB/JWuYO3kuS9CWbU=;
 b=QI4YerAo1AafKwU9h12WdHg20V+od12bz+e46AiWGlftAgUh6pkPqQ2gjSArz7hqmvyzxQJ5cMrA/nrF0f2nleK5qBiHWkMU2Hm3rJdnhFJo3/9Ip1ZvVrlBLMSF4ZmQgOU+PfPw2EbU/sJBGywJIaz7me9tG8T5R405AFVz3YQ=
Received: from DM6PR14CA0068.namprd14.prod.outlook.com (2603:10b6:5:18f::45)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:56:20 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::a9) by DM6PR14CA0068.outlook.office365.com
 (2603:10b6:5:18f::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:19 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:17 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 40/48] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Wed, 16 Jul 2025 11:54:22 +0200
Message-ID: <20250716095432.81923-41-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 285b0028-abe4-4b0f-d0a3-08ddc44f03e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfJJora37mIOeMOH/+Jcb7MYOwBz9kTsLtOFMO952hJR1i9uWHU53TLSQC/G?=
 =?us-ascii?Q?4L+BJwUuxe/CHUbRftV9HGhh7P+1HsJtSmC6yOWLeTT8iL2V5cMHZ83ll4eL?=
 =?us-ascii?Q?26+gUttJXY+ZodOa1T2ajnLBciQSLLlhCXLIdqXjJrac8wYJvj6F6F8qJIMO?=
 =?us-ascii?Q?lud6jxdEJry/xDK89lEE+BIZvhllJRRrr1YHVIdBEm6+4XclQiGOl9eQMI0r?=
 =?us-ascii?Q?dviW6S8kHK/t6n340YcMk2KvZHlP/AnBHgC3Mny57JeQjdn55aX5kL5x9/Mp?=
 =?us-ascii?Q?dpFUttxnGu+LsiceAX9rojrGWHktT5AMw/j4sh8x3/nyIH+h3Se5xI8vF/Vn?=
 =?us-ascii?Q?xQ2F3Z5uRqTU+7Hk5nTC+Zub++mpWvxHwiLgXri/XfagSNdHO4h3V9DhUlgk?=
 =?us-ascii?Q?mtZH/1KffZcEYR8IuFZmW9a1Ais/cGSgvVNTwlDaxZkokioRCbhTCc1/uF79?=
 =?us-ascii?Q?nRku3ehMoxcc0a8bXDndymKC3xPVME6r+BIdleuWQRS1jC3yviOHCOnRJLwX?=
 =?us-ascii?Q?lo4hTUAUIqys1gDyrcvFoqnMl63gZnRYBQrvWoiWcyvD6Mx7IQbK+PYNYLff?=
 =?us-ascii?Q?C2yHMQCgSa+jW3iGNrr48qCfEC+S9JEc7RTMtRZdCoTUtL3hvaDUCohb+0TM?=
 =?us-ascii?Q?FXD7qSnxAq5Ol1TnAcx1jBBsCHkubUG8+cmMkk1SabXfOlL0pAl2RkfQFq17?=
 =?us-ascii?Q?eYkWb/zOA4eU4jMgJ6BQa1GO2VM9Nsgno576SGNVErPw22R1ld5NduWexVD6?=
 =?us-ascii?Q?LZUebqzJHmgzvTmp7lIs4hBByr9c3nGkLKPc0GTaaSZ8ZgA6ULT7UEzoC7us?=
 =?us-ascii?Q?4BvioL/MqP+6Z+/8VdF15XZC7WTocszVw1A+YO8GKPWtmhhfxMlF1dZhyi29?=
 =?us-ascii?Q?PMwqTgJollnsOV30a3cOnBCEMeRrcMFklR00Ld8JC1UvdmxrEe/RPD7Fmgyz?=
 =?us-ascii?Q?1EK91EdxHw/OIblcMLv0vvOAZUtS19wWUYGxDUy9Hh/7p1COb0YaU/PKBPOd?=
 =?us-ascii?Q?ytGRbOUqXehWE49cDeSzif8LjZ99AXg+7rpmfNXMF1yeeNE3cfFKQZdTLCEG?=
 =?us-ascii?Q?KoHG4j4TRTvcclb5H5j3ompjegNZTFdtwp6EnK96NWSSGUIixxzzSSsMrc9h?=
 =?us-ascii?Q?OhlJzFIbQ2lBfNuCwNaI/K7yM/RlElfiRI+AF6HRzDCvlSt+xDXaDlYEAIBL?=
 =?us-ascii?Q?Hy9hrXlHZYyCbKDkOFwZaxDBTXkYaWaA24T6W5P5lhEW3zneMzawW/8v98OS?=
 =?us-ascii?Q?fZtAMQX/SxXFrOu3GmEgIBGJri6jzjXdiUvrWxZApIo92F9RIY89bfDQoRrt?=
 =?us-ascii?Q?S/doYHKpT3AYfNDpfPp+rcXqe504CNz4uFgsA44l3Xryh9zX4LMc7Qofezme?=
 =?us-ascii?Q?ipJav5+GuqDOiaU1dC60JBwQN9yB9gWlo5NquZrsjyim4148hyWv63dg9bzZ?=
 =?us-ascii?Q?rostyTOyeEanY/NElZP5nStPaEuuuDGYoH4ssP4zmGMAeI0nhfOsC459R8N+?=
 =?us-ascii?Q?AiR4leG0Vi2cJ50N9dpwMKQV/QKcWzY1naco?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:20.2483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 285b0028-abe4-4b0f-d0a3-08ddc44f03e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
Received-SPF: permerror client-ip=2a01:111:f403:2415::630;
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

Add support for the ARM Cortex-A78AE CPU.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/arm/tcg/cpu64.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 35cddbafa4c..337f8cf0c8d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -404,10 +404,84 @@ static void aarch64_a76_initfn(Object *obj)
 
     /* From D5.1 AArch64 PMU register summary */
     cpu->isar.reset_pmcr_el0 = 0x410b3000;
 }
 
+static void aarch64_a78ae_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    cpu->dtb_compatible = "arm,cortex-a78ae";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by B2.4 AArch64 registers by functional group */
+    SET_IDREG(isar, CLIDR, 0x82000023);
+    cpu->ctr = 0x9444c004;
+    cpu->dcz_blocksize = 4;
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000100001011ull);
+    SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x01011121);
+    SET_IDREG(isar, ID_ISAR6, 0x00000010);
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
+    SET_IDREG(isar, ID_MMFR4, 0x00021110);
+    SET_IDREG(isar, ID_PFR0, 0x10010131);
+    SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
+    SET_IDREG(isar, ID_PFR2, 0x00000011);
+    cpu->midr = 0x410fd421;          /* r0p1 */
+    cpu->revidr = 0;
+
+    /* From B2.18 CCSIDR_EL1 */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+
+    /* From B2.93 SCTLR_EL3 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    /* From B4.23 ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    cpu->gic_pribits = 5;
+
+    /* From B5.1 AdvSIMD AArch64 register summary */
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x13211111;
+    cpu->isar.mvfr2 = 0x00000043;
+
+    /* From D5.1 AArch64 PMU register summary */
+    cpu->isar.reset_pmcr_el0 = 0x41223000;
+}
+
 static void aarch64_a64fx_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
 
@@ -1313,10 +1387,11 @@ void aarch64_max_tcg_initfn(Object *obj)
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a35",         .initfn = aarch64_a35_initfn },
     { .name = "cortex-a55",         .initfn = aarch64_a55_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
+    { .name = "cortex-a78ae",       .initfn = aarch64_a78ae_initfn },
     { .name = "cortex-a710",        .initfn = aarch64_a710_initfn },
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
-- 
2.50.0


