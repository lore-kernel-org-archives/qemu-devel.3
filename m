Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAA2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXY-0001G8-E6; Fri, 22 Aug 2025 11:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTX8-0000AJ-7s; Fri, 22 Aug 2025 11:18:26 -0400
Received: from mail-bn8nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2414::604]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWq-0007GG-V4; Fri, 22 Aug 2025 11:18:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpQVwzddFj6jQaRZHKewDjm021pj9YgkY9y+DDEoqmFDtt1oSSkiRhpmHoQ5rDu+fYhnh2C+q//wjqtDMDt6hJtHfhR1Ma9ShCmmvPXTXDacH9JDjOvJjlvwDGLhCE9RTj0U5J0pJ20T1gA4E0raRLOZ7njNMrnYha/fseUTwhgK9FitGqijr5ey4cmQE2KNAE7oZyI0qox1WSkRnguKjB77Wl5sbVFHf0OyHXcZ2cPox0oeZwmk2yYEqKYKZs3a/tuVo4YCZuMpK6neDsODjE6vkJKyIrSqmx47JBeNlDJgwS4qXfUsG20isUKiUEHGF6o4x3xCPIha4qLG3j4mhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE7keH3aTlnMPdQyiY/8M9MYRXDnIIyLKZTizAU/y4I=;
 b=CAGfMkO9b/8BSB9z5exb7nKlmcjFw/tXn6/y84ibFPSPrdH6zNEEcZ3T/ERjhGO1WB+ZgNErYm15d5Rut1fj8kZVtC5DWr25lxZ10MlUa57AV6+ytQfZFTR6e5XwpqdMWa75RirDgGT7gepsaJch7eFWfKpMD6tnyZMvbZFbRcVQnmosRBemKIq8OCkPALCX6L4AjohuUKHqyf9TxfTQdQcNW7vn5jQ8gChFaD3FT7xcp895AMYivMviWyEkANS5Fm8jvr1EnbQSN1fKKfq7n1dSDA72pXHI8Cyiq/Az0Kz/S/TtynxTuAPvYB5UM9UoEPwDJKM+1r7ArK4Wwuza2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE7keH3aTlnMPdQyiY/8M9MYRXDnIIyLKZTizAU/y4I=;
 b=nCSI+QxSiPOkN1sLgSopHiHjmgPhngnaYF0OPXH/sFcEB8ShlPAEkSIayJRdxMiLgn165OR3aFdjT5VKYHNC+jRnA+92JCdGGWFdrUObRF1ZW0IgHhA6Uezs2wvx9KqEzML19HMTSYRvXRp1C+cfKUuc7OAWrc692doCoCTi6jU=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 15:17:45 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::d2) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:43 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:41 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Fri, 22 Aug 2025 17:16:04 +0200
Message-ID: <20250822151614.187856-40-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 433564f7-418d-4e5b-745a-08dde18f0ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DjOt4fhh+dhuW8WhQefT/7Fy1S8Ac+DfPk/8pYuA3gjNNAPyjPK+qujgrZ4a?=
 =?us-ascii?Q?AFPZLHuQSFz/mMRfGBZu4UZj+NhghAUvP5x2S5iD/jFSdVBSGsEVkExk/2VC?=
 =?us-ascii?Q?wewPFkxHHq95Y2RVPzBGKv0/utBccUPkQsOi/6p7XfGbmNIdxRBwXxfn43We?=
 =?us-ascii?Q?z7dQCMUSjLdxnEdIXryKyYnzwx+7KnbkvxYRjhWDG0kkOYjcbYNFkNWgxxnx?=
 =?us-ascii?Q?+2lE/a8a2aBxgaNlUCtKw3Fc4hmrY1+nN/k81sZdxyREEwLqK4kHqNras2wc?=
 =?us-ascii?Q?69+P6h5cK0XDf9bpXfVKTWpgbV1y/uZq778jwgs8J0go/2W0f3vT3FJCwuYy?=
 =?us-ascii?Q?e1JXw/c4LJSzTh0W+EOQfd0aUJ6mBpPyws7PH19no+G/+YZT3fNG7VGgyjux?=
 =?us-ascii?Q?BsE0RXbBaa6Apagqu2tuGoG1Eq0Cq1OZiLzVOq36+Fh50+vuK8epYkJfzjin?=
 =?us-ascii?Q?w41wnZkxhrJOXiRCGeEO+McXDu6BDWix4MXnq9mqm5US4c2qmPgfkiY3xDeL?=
 =?us-ascii?Q?5tWs5Wl/PQ3Ao7WImNsJv1JNQ9sZ59NnqsQc/PmFs0OJXBb1VGLs4t3WdwTo?=
 =?us-ascii?Q?rdJeOcTjshAC/CVZPsiT2dUjzXZSrqAP/TEFWLXGDkY4fJfoKMRyjpV9jPhn?=
 =?us-ascii?Q?PBIkwljV8DxdkGGZTwYeJFMT0UsW8KBxJe7wRpJ38Mvgnwdv/klPUSRebA2F?=
 =?us-ascii?Q?UVmyjPcKFQEOxyXQodGOxnnoycmx7X0rkg5NT3LjtqwOobmPRl3dRRhOR5XW?=
 =?us-ascii?Q?h7n+4MrmG+fdFeM7tFKj+G9iUBMeP0uEeqO+IEpj8CLD256Vcz5/FCIUN+S3?=
 =?us-ascii?Q?WB3/w6mk3xsSmmlj81EZZ7TkIXj8LSLoQDtq26JkN2Zzw3o7XN5Eqtr1zV0M?=
 =?us-ascii?Q?mHF3sp1rAAK4PZzCrdLAN7xIWUtN9QmJbwkRGLk4pFpCXGo+iaOQ3Fy4RyXy?=
 =?us-ascii?Q?4s5wAJ6alU3d81tmPrwhDwWKvXfkpz+a8txwTo2llaMgjIp9KS4NSnOc/e/o?=
 =?us-ascii?Q?boQ0crJUJlpAZvsAop1stwU0MsN/gnkGclCrULRRp3BCFx6K6AFC+6VFgUD5?=
 =?us-ascii?Q?nKxmPV2MTRT2W9LGBlGS6LTSBwFSxa6QcdksxBLrplmwFMWubECfeHO7XNzP?=
 =?us-ascii?Q?I4OS3bN6/HDeP67ANBsSGSYSPTtX0qwMUSOXAeSXWfJiyy/6uPgu6PXGkm5m?=
 =?us-ascii?Q?TPFoEalIkfGyVGElPHm+NXSCBXsxyM7YRuF/rsKVqXPcK/utNBK5QDswO/o/?=
 =?us-ascii?Q?eZoiRKc/gAsG8Wn/kUKu4ZLxy5U7PYvTLgkvmEZzlBy5WA7SofRmIMfD2lzW?=
 =?us-ascii?Q?kiJP/g96mfLaigw/99YHxLRCqvLqv5XfaKds8hqLLyxahHON+m0nL4CBsBaY?=
 =?us-ascii?Q?2NphplE2SvE4aKWAzvGS3Xypo4lM3A/q/XNUZexUueVOSmPpy6vH6xE1+Mmj?=
 =?us-ascii?Q?hUUo1WDP+giDDWq/hgmnXRAZAz8spnAZaFqIJmr35u5m7tEksUjbVGCnj0p8?=
 =?us-ascii?Q?sXQKL8a5G2y1r2ydQoNDjytX9vhimJjL01kp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:44.7016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433564f7-418d-4e5b-745a-08dde18f0ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
Received-SPF: permerror client-ip=2a01:111:f403:2414::604;
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


