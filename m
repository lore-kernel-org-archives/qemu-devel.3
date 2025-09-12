Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE5CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0ej-0002DH-5W; Fri, 12 Sep 2025 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007Qm-NG; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-mw2nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2412::624]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cj-0001O2-GM; Fri, 12 Sep 2025 06:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZngXcdoXMXbzf6+v96CaapKPRafizkc8N19CAAtVII2/JLo5z9GoP32X/ucPXXSRd4bx3DBu2liXXvaPJwt8D5Kd8bKeUjnD8Q4gMF/TpQoL6vgvEx5lYl3dCVMUcaWdK21WBpHYtNmI51r/mcggHfykn0gfoVxa36gK8HR8KFFE6TY88VS9Mk+vQ0sbOxgpIjkjtfeUDtJQyCgp3/4CYttjLdE+e0cmxijlpUPj+CTGc5madiREapQPdCClSiPG+TSVifX1Riw96mGxjR/LmVICMCgDcWE+SB+sBiwGws3xnksAYQzZPPe51B+RGk4gG4ZXtxwdKbz45NHg39JItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHkshJdCJjxqNbcRe5gxxtRRz2fbQXsiswImNqOPJCY=;
 b=fsAYrNh2vk7/FHg9g49MAit/RZhvhR/HNWyv4Ing3IjnJDhTuhADw2Lj7kTfCsS6mn4P3ZBall+qOVpH5dE5ZKs5qESaGJJLe0tUUxq6dIdl20ePGFzVwREt1FW6Y4qMj2ZKYq4kyz+sTTXILD1TcP71p89QWfMjosopV8YstvYDEXYXwiFTZLk8+RM9JEiEFQ1rF85gEhAYIBG3668IJisEfE8IbW1vvNb6F3l5RHNslKo0Q2kThSkU2IPIvv7s7g1g+a2kjVHimvK7ugb0mN7IOx2sDqxP6G/Zc6Q68NQ089kpI00r3irgUFBMfgpEFB4porrsjPTAq8f2tCMC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHkshJdCJjxqNbcRe5gxxtRRz2fbQXsiswImNqOPJCY=;
 b=kZWKvGnZRb7HOub+ms46CZnpd6/BS2buMGgEYSso9wnXELotH3JuINdcXMAiM30lZA+MLU7XKPkeHnwQuPhql+E3OTMkGDOkObnoHR6WNrqgq/uZ/aMsvXzYOKsbSrqZaaMSlsS51HjTK5FVZdBxE4vVCpEgiyveOiSMvLIdr4Y=
Received: from CH5PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:1ed::29)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:15 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::25) by CH5PR02CA0007.outlook.office365.com
 (2603:10b6:610:1ed::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:31 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:30 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:29 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Fri, 12 Sep 2025 12:00:48 +0200
Message-ID: <20250912100059.103997-40-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6a7b4c-54a4-4f57-8e3b-08ddf1e396ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y/yoYI/TVmyR02c42ZoiaAABLQF12ogB6uC75oE7/hK9ZbIbl2DkBld9xVPF?=
 =?us-ascii?Q?or/4Quy/qECKn0fg8s9ELsHC0p9wzPKqRws8Jly98/GGP5yJpFfk0thwgI+u?=
 =?us-ascii?Q?6RwCjRjmMryBn0JVoGQJrCV6iq2JagIdOHGNZmYNcyFDFRPU15JWf/sYZEoh?=
 =?us-ascii?Q?YAJXV9yImwWb+R8xeN4R8DsxbQwHOQeNPkqIXXZL9xtzOBkJ6md3FtlDd+Ks?=
 =?us-ascii?Q?LZIV17us1gfV1rzKZskJPC0kAfCmybHUvnGCSjrCWaK2jLIv2B/ztGJY/Lt1?=
 =?us-ascii?Q?RabLDA/XKDNOoWEyt4AZeWg5VAyhN4iSBvf248Fsg4KmgO65UJfkJ+aICfLP?=
 =?us-ascii?Q?Jh+5GQCnzvzxUyqwoAV6iOVKqPV3wh4V3acFmdUioMZKND5QmrJETfkeXhhg?=
 =?us-ascii?Q?6M4A4/4pdGEYyy2Y8umE4KULy1ruVl846MIG7bPa9yS73nPogls1O4zunq7N?=
 =?us-ascii?Q?QrjgeaHDXPRdluGaYw+/ByHGuf3xkhrpHg96E0WnMbosfHTPjrKVgkIPEshK?=
 =?us-ascii?Q?+I6HoQXEtgHrupVnwz6UnkcQMRZllmXd47f2HI3A/tsAFhovZ0PMkD7hQWDU?=
 =?us-ascii?Q?lovTyYkYGOFuAvVwDBbG0yB+/aEr9W2DLLR86QZC1zxhimb/juHsGwaFbPWI?=
 =?us-ascii?Q?RwrAZAiRx1CWv/mGBtPVhAP0a9VVXVjJVTccPtY3tj5SkJ3lSfw2KsUTb2Yg?=
 =?us-ascii?Q?cYtdryklpt1jRlDnUVZ0pBICUXqLM/YnnVczsO3iahscqhDO1sc46e/MiG91?=
 =?us-ascii?Q?gsaC3UHUCE/4cnH7iS4bvCjF4gqaRFDAr50csDZIm1e4Y/vh7shtHueNzP5q?=
 =?us-ascii?Q?/aAw5yXvlAvdsO28e5IL0qFRHWSDxfDpg0tdhlRreUkAJuM01ao6olQ1R7pt?=
 =?us-ascii?Q?UbzvbgZ6cRuBcfTFVsHk3qntsedodylxNIG5GIRzgoFaFm6LJmEvlOcLFvff?=
 =?us-ascii?Q?14Kf1s1cgTnJv/RKSf/IOstTbYnDMcXyX1TuWig7vuWVzjTjPlThCi12lTlb?=
 =?us-ascii?Q?1OnVUiFWCe5CsluV/qvNW+xz4HmNizW+MSVyBRD9hQOwrucsSoYj9MTgPW2x?=
 =?us-ascii?Q?04kiil2hBkqdXS4MDZbKi4/wTS0/aBl6HZy6JugmlfwiY6WN8u/xjLJ2pcnF?=
 =?us-ascii?Q?+Ma2NAZ7EH8CsZJYJzonpYczCUiO1YFLsmBZtIbbR8d+TYyQyJYlIAp3qhV2?=
 =?us-ascii?Q?RvMnO9rkhYQ5XF9Su5vjJZpjFpf7CT4xboMFlxCv/c1mSGMc1sD+IFm9+9Nh?=
 =?us-ascii?Q?iYBDmwpwnk+1wmb3P2FSJbUKYklkXELANBuBR/kmaoysKVFkCCRzrcSo+OVn?=
 =?us-ascii?Q?LvYT6I3S8KbPn0ccFGgv9wfWCG09Mzt/iq+6C8gnM2k+LsjjaF6VbQ0AVnhe?=
 =?us-ascii?Q?YK7p3GtVgSFNGlZQ5wyJHG45ka6Hc48B/bJWi73Zprh+fbykLZZqwtCZkUUk?=
 =?us-ascii?Q?hpmZ8gvr5XwJA/v7M7U9u5FpTvm2YCNFFVnObMYMeF8PZPCz1u52My+m7NtQ?=
 =?us-ascii?Q?lydjN//s3OWEOXHCBDZosFFHNrGZsS9pcyGp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:14.7691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6a7b4c-54a4-4f57-8e3b-08ddf1e396ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
Received-SPF: permerror client-ip=2a01:111:f403:2412::624;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
 target/arm/tcg/cpu64.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b8b1981e702..81b95923b4b 100644
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
 
@@ -1318,10 +1391,15 @@ void aarch64_max_tcg_initfn(Object *obj)
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


