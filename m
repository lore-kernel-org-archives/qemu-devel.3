Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34644CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22cO-0000r4-Th; Fri, 26 Sep 2025 03:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ai-00076f-IX; Fri, 26 Sep 2025 03:10:06 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aO-0006iT-Rp; Fri, 26 Sep 2025 03:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHqpBjSucI4IG1xykae2eyIuKHWGwrYn+2cY17NxnIaxhnRF61o33OJuDvc4V0eJ68Aq6qg86rlhc3Qb/CIVJ7bGLQdyM8UGLcvJCKOSa45Uzyyp9daWMO4p6ZL+psAP/2L7M/vF2c2aPnVs1v6eO2RXs1Czi3JsqXYwSpp5i3VVr6MMCg1IbD/jUnRR+UrimwMam7XuQf+X6LMPVgSA+RtrZ8Svf7FC8s10bxJ1aQ4bGyVsXlWNT95EGsAiCRJTU5YyjyqaOn5lTolJwEnFPML0gtQ/+PIsanubW2ldKwttRUkrduV30ZV9IqGr8p2a/mSAcJRPz3RhYy/P4m/xMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqIno8Nta1ZpIHie+UAtJavxTOT7VQnnT9QzDc0z97U=;
 b=xvMw9+9gTb6PSboiLS7pvRJKkM6FSvcbblUKf1UrMA0YeLt5cLrD26973N0aHyPyFBzRg49bUG9XKZEquI73GbWn9Z8OgNIHAMdcsMDmZv1n/7tFvnTLh4vPH5QDPj2VcG+/etP7/ruYaw38D7WA/U80m1TxbBNW9SGhEbCTwfCSZbjJzj9qpEU6lMr1RY/GcZAg2KFkLjH4LUDhlYlDhql/315mKif8EEdwBU4dtb9uRD+gB0mpvVj179teZj1rCsC+nhV4FFWI9vhC56bXWlFpektXlN8HaJFgZYW1dQJ77f2VKv/dU1tM1zn1syYdOExQWhVsc6qqwsG1bJfmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqIno8Nta1ZpIHie+UAtJavxTOT7VQnnT9QzDc0z97U=;
 b=w3kl+9TthISw0ZV1w1+8dt0sMERVLlJmG5y2eXuuLIIQ1aZXI7MB/1cSacrxzoL3dedfTUdDXanOwyXrqVu43XlmYMSwRd4eFmUUbCi8gRR/z+yKq6qOtGy2pYtjMfPXKv57UaUz9FF4djvG3Vm/lOV6zWgtK0foN2vv2sbRN/0=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:09:32 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::14) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Fri,
 26 Sep 2025 07:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:22 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:20 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Fri, 26 Sep 2025 09:07:57 +0200
Message-ID: <20250926070806.292065-40-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4b9b92-44a1-4eb8-009b-08ddfccba444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J2XgKLjx9upVrf9QGs0xHSNa0RWQDOkLV8vTPg4g+ZbK1kw5cl941hsp+mux?=
 =?us-ascii?Q?FdCXP0Y6YgcRP7qvagxnra7Jw7PEtRdjv4LneaUAOqNjhACReECB5NfUs7+E?=
 =?us-ascii?Q?fllNGHZ/BnE7LYtZCFbnrBHZbelhJPjqSWLV5OkGcku2Y7rJfzB2pLgrUGbv?=
 =?us-ascii?Q?vaHk1jTjy+slhHFDo/hB2qJEwfZhzDjxC6amJfbFSBMx7hovGFnSugeY4IRe?=
 =?us-ascii?Q?dwPA4oeDurFrXelPhL/0xvj1pZtU0nHR0W6zgwacpi1t+WutkPAbAJuU/O9e?=
 =?us-ascii?Q?TQwpJkoK1nq0N4695WmYDXcELYgJBTzDKryc4lGvlJVvn5n0jvolWH+XSyF7?=
 =?us-ascii?Q?ZFrUPyoz4dD1Tn/XC4Vm1Pj28VLljzLJN5ZCVJUMJVVXhPnFKJS0q8IRt1om?=
 =?us-ascii?Q?5JBc870Z70aQfOTapoobk3V7hdhBVEzJaEcdGx8eEz4pmVkL6rz1CO9SWzXN?=
 =?us-ascii?Q?4RVBjWODvNCM7g0mDMKgio0OOswA79dr8gZ83H+YHGa4ViA4eb3pMckUmRdb?=
 =?us-ascii?Q?1S8CEqlqFuT9L+KBT6O+ll/eX+0+BCuLyqwCgpQfXxtGa7CHOYSQ+C4bVOU7?=
 =?us-ascii?Q?S/a6eZAUjC3y62wkCZMPt4y1kKvvrsYJln5UPsPdPh0qeW+uI1L71k6B6kwZ?=
 =?us-ascii?Q?VwPpYzLYakrRRQy8c71rBwm0NkQLUNgw5WfzhEEB0ygdPoio8kKlfICDG9Sf?=
 =?us-ascii?Q?y9/ne58tjY1E59h48NQRXdx4XMzz2tXm0u7tr9BJkW2z+kQJIHF+HMjWHFrn?=
 =?us-ascii?Q?W70jXmjrLOGGLvB3K9wfwPMFT9ZfTnea47nHvMBtRL919DKUbxrSb/UABGyO?=
 =?us-ascii?Q?ElGLRQ5RT+Ip6Kb0fr+A3lRI2c5rj+WIhsEIURpATlYeOVUux+oAtrcXR+6R?=
 =?us-ascii?Q?FUKOnk2UtcBgW27UBSSjXjEF7an6qJS7L2IswUY6ZXO/cECzmuMBqQQri1fa?=
 =?us-ascii?Q?G7KTG4hajuE1JlFeb1TjfM+Y3JGpD+mGxwhtLUsw8++Qdkl3Y/aiiNeuIeO7?=
 =?us-ascii?Q?Yj4nWkNzY2MnVZo+BwSQ8nXi9b4HCoWjp+cCpcyb5UmYp8lqTm1tXazegwrL?=
 =?us-ascii?Q?PNifdE/Q/vA+ZsMbb+jofLaK5cAy0WwFOThh4Wzpfl/a0lYKajGOkjEs4chH?=
 =?us-ascii?Q?JEVFbhvjyj1U4LvMaxViaNa7IFT2YLKqOC6ATTTnZZVLr2Lx5YRupI5Urrcu?=
 =?us-ascii?Q?6WVnJKxeaE3uly9E5yhv+EIjYAz6ctbHX4QfpANtJK4tFWFKol+usy/6yvn4?=
 =?us-ascii?Q?zPyC0DEprSAjPOHSE+Y31SM8Or6MYOTIDd+86OL+peR23O63DoGJOWt4WWQi?=
 =?us-ascii?Q?vU1BLwqSoeLcYHut7OSf/Txk5ug/th4lsWR4C7+XED+Sg1gTV/GbzjZjZaiJ?=
 =?us-ascii?Q?eY2yKzSRlqCWfNkc22Db4RBBHDRjs27vYPqHhjJ61Uw3f4Ef4fob52WoTtSt?=
 =?us-ascii?Q?iBIZ5Stj2LPfq8Tk31xearINhXiQtbdRKChpozwd2rJgGDlwaHm4XNOjYx5r?=
 =?us-ascii?Q?y7kbtIVqyunmiY9L4pY4sxgQHVT+cOxOH9pvHIPc4ajSXLtJPKIkn0WgFR6D?=
 =?us-ascii?Q?eJ9yeP16TNBvXiygVds=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:32.0154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4b9b92-44a1-4eb8-009b-08ddfccba444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index abef6a246e8..90b6c0ebb0e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -404,10 +404,83 @@ static void aarch64_a76_initfn(Object *obj)
 
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
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by 3.2.4 AArch64 registers by functional group */
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
+    cpu->midr = 0x410fd423;          /* r0p3 */
+    cpu->revidr = 0;
+
+    /* From 3.2.33 CCSIDR_EL1 */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+
+    /* From 3.2.118 SCTLR_EL3 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    /* From 3.4.23 ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    /* From 3.4.8 ICC_CTLR_EL3 */
+    cpu->gic_pribits = 5;
+
+    /* From 3.5.1 AdvSIMD AArch64 register summary */
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x13211111;
+    cpu->isar.mvfr2 = 0x00000043;
+
+    /* From 5.5.1 AArch64 PMU register summary */
+    cpu->isar.reset_pmcr_el0 = 0x41223000;
+}
+
 static void aarch64_a64fx_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
 
@@ -1319,10 +1392,15 @@ void aarch64_max_tcg_initfn(Object *obj)
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
2.51.0


