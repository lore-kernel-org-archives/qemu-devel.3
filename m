Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E2CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeC7-0001dD-Nw; Wed, 20 Aug 2025 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAY-0007Ai-BA; Wed, 20 Aug 2025 04:27:42 -0400
Received: from mail-dm6nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAP-00016m-4m; Wed, 20 Aug 2025 04:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnEUQQnq5guC269GKTHFnWTlegTMTNM6ZBntV9d3u9PYfU+XqcDztQQ6kOmaXZ0GJf2AcerHQOUt+aSsRe9wSm3u7AfV1ie03dk39PY5J/lvtYh36lCkmLB56T2UecLNYUBXxx6QOdorvOr3mY0tTsFedN/T7RqvmUdOyYVnSLdsveyNUDhVrCC44Aaox78GcnIzKCbg8ap0Q/3wtk1uCYPKO2/ox07Iah9W/rGjvkgIPK+BgudT1X+50tSvZdRKvkc7+mAtQUQdtGYO7+tTRR9Rw8nScYjju34qRZER6B2+IKLmbGHaaJoBh5BPrdrUHqsVWR5d3B9mhaWGzTZhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE7keH3aTlnMPdQyiY/8M9MYRXDnIIyLKZTizAU/y4I=;
 b=V6bQ+zAY84dX0mjMC2WkomcFk8csxjaat381WSFaHo2I19jf2g/IepXw84yvBZElVAywu6bxOnMGxYU8qQCrgB7/6e2ukwpSnq6tbdC4M7+H2G1GVIKAVOkUDO4bCvlFKvK4SWVrUhcw6z7uWGxyCH/XavaEpGMsJ37wC3Xjysm924UX6dc6cHtTg4W5KZE9ra1+qFu7aPuL3+gvSLA0HzbMpndnQ/DwFQ9bjV4YvrErxwV7lxwJ8D0B+9en/ve9m86p8fkKCUlAHwO0qOvu7r6Zm+pPuDbWqi77FfUpfzLhvHAmCr46SBpx4K5G2AWHJH9VPLrV+bq7r7egpA4vIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE7keH3aTlnMPdQyiY/8M9MYRXDnIIyLKZTizAU/y4I=;
 b=dHcBYCW3UxR5bZwqkBr3xxBSSH+Zl5GPLHKvXC48mFhLyr6RjrHlc+ySn8fQdrgr/C7dUtED1S2GSAGjQuhyvcEOVlZO2E4EF64UZAkIZwz5+QMVlNtTOjerIWfNxQLedn+qhTI23SvKBIaFBYDgNPN+cH91liHTDAvhk9FRW24=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:27:26 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::73) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Wed,
 20 Aug 2025 08:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:25 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:23 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Wed, 20 Aug 2025 10:25:38 +0200
Message-ID: <20250820082549.69724-40-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: f51d0115-70d4-451a-f7e5-08dddfc364fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0Oi0taO+12lYL4CFocPVjpHbMDYZv3Xs1rVGPrw977dTDv/A1GKJOWg+6MS?=
 =?us-ascii?Q?fORPV7RXXSLLAory+y2cSPWFsMfl5wteyKg/eUl7U6PMtQPZzpziIIzU1/nw?=
 =?us-ascii?Q?Dr4oRLh+bOG4Y1hax8/SWBsLdUXDMPYcmI01YJPOQL7oi16Ugpwy2cA1LCqY?=
 =?us-ascii?Q?++wrT+OjIYU/dANy5zMqI3wKLbEqXZIzvUPi94aTNuUgH9iRgWKWehs7Vxa2?=
 =?us-ascii?Q?xjEgPkENZU8MTHW7tCRu0EpayZtNHm1IBjvXMO8Cul8k8IRSVN7SWeUHiHSl?=
 =?us-ascii?Q?7EHr74ebJYkZ2XxfysRyguLrbZu/85E2Zx6EfBMjfuCNSaQkhcF9Ap+tl7/c?=
 =?us-ascii?Q?PhdQgedXIWAKLhmaT7AJMQIwGEDAbh62X7nX0dwAyFQcYyf9F8LuvFUfQAT6?=
 =?us-ascii?Q?0Sdn1rNDhdTbImrq6R5pnoefLRc70xCRcuM+LoGcKEc+rXVgpF5dMcOPgvdV?=
 =?us-ascii?Q?s3e0ux7QRg33CbF+nr694NYcC/HUg/LBqmM0HBU8EwVcxxqwX5DjrV46N1EW?=
 =?us-ascii?Q?XBi1CjgIBWt5g41vmo/fwQN/HRaH39kX/Dr/9ucdZgUvC2T7EGPE+TPnFdas?=
 =?us-ascii?Q?uFfLNcO4zISmpfCrlHvu+NWsTMs5lYRozmGlUS0aotX8tbZ5SJVJCo7EG/Si?=
 =?us-ascii?Q?3KB98Tx6ZYCNmIAh02T+4WRey1mesFZg3SmDuZv/TW/CVtDHEnQ9Wb2oiqoo?=
 =?us-ascii?Q?3gH8qPdxzdrBoIPk+cd2ZHIYzGUJkJc1mfaL45LLoUoiZa15cBX6AMTpHMgm?=
 =?us-ascii?Q?E9h8+i7BuCErjRqfpWRW7lOeDIOQMQNpXK0rEu0FqHIM+G/WoMUiNonsudOV?=
 =?us-ascii?Q?J6+6c24tn9g99DclsGfkNG4n6xAgLdYPN84+qtW6upjuOovfO8VICkV64vXI?=
 =?us-ascii?Q?o8nZ9ZnlkN2vmfpguNjif0uNzv1dsmGAK14bSOfvc/cd7z2RJBJTDrJkLIlO?=
 =?us-ascii?Q?zWPs22SOAJkDjk1a1wxgfk9KtOK2AHqrMxgN1Qfzz8OHhm9cunrFFzkS7d7K?=
 =?us-ascii?Q?RS4K0PUkroFHURSZc7oOOWDy1oqGu/bokMFRsRpU21BWPgwCh0+2bDLqdVRq?=
 =?us-ascii?Q?CENI/Za2n4OO0jBrAAmQnt0hHCe6Txwy1+eqLFHCulTprT78ai9q3B+Qa72T?=
 =?us-ascii?Q?YH/488XHjQ/VhVjek83G8OOAG4uRItk7kp6BFrB+bjNGconDfqpdJWD1718w?=
 =?us-ascii?Q?Z1Ce/Hn5i65rfGICkI0y105deF4c3TBqxmK8tbEJDhBvRAX0PCdUebxJvyqz?=
 =?us-ascii?Q?CpepZQC4unuT4e0pxZxCpQVSE42Mu8izGn5v0dhoEOgGfW0WYWdMoeQrPRXp?=
 =?us-ascii?Q?TMIwPsfdK1j4Wk+Ty6sllQZD3aCNe0IWB3hUCfacak0Kle2tiTNmoEFCzP9b?=
 =?us-ascii?Q?c+B471uRSCgg4sPJ+PhwRYkahtvccTH3ACNbOUAhFFsm9nAccl32f0mTroK/?=
 =?us-ascii?Q?jKxkPXI03yZEcGM/IjjQmVb2PpCp+UEiES56y0LxiNKgwKf41PRSTxMxCJ/i?=
 =?us-ascii?Q?j07x8JPS8uiF9+BhTv1kOj8IsRiVFLxyXnYr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:26.0988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d0115-70d4-451a-f7e5-08dddfc364fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
Received-SPF: permerror client-ip=2a01:111:f403:2417::62d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Add support for the ARM Cortex-A78AE CPU.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/arm/tcg/cpu64.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 35cddbafa4c..b56677c1a5d 100644
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
 
@@ -1313,10 +1387,15 @@ void aarch64_max_tcg_initfn(Object *obj)
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a35",         .initfn = aarch64_a35_initfn },
     { .name = "cortex-a55",         .initfn = aarch64_a55_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
+    /*
+     * The Cortex-A78AE differs slightly from the plain Cortex-A78. We don't
+     * currently model the latter.
+     */
+    { .name = "cortex-a78ae",       .initfn = aarch64_a78ae_initfn },
     { .name = "cortex-a710",        .initfn = aarch64_a710_initfn },
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
-- 
2.50.1


