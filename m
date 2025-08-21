Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8D8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50b-00053O-5C; Thu, 21 Aug 2025 09:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zI-0002fY-7r; Thu, 21 Aug 2025 09:05:54 -0400
Received: from mail-dm6nam04on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2409::617]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z6-0003Fw-Jp; Thu, 21 Aug 2025 09:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJgSqc0FJGc7RVinhIWhQr9wp0ASBTox0yEteM8LYXyYHo2TwHXGfYAtgXzmOM99+1fQmSOz0BMRSdvVM1W34HVqjLhbEDLPddW/A4H47RTRCbirDAIirPmq/IKGcHRIablpzz3a0hB/zdC4eCToYLs+8Tcmk6xrl+HSLzImnJLw+tD7vGck4OSOrj6e5xJ6N60JFcEoS86Jc40gUY3vjs8GMhUxNecHR0US1Kmjn6O33FoGZU9NBqJqbtY2Jeu6AVhB6XRgSU1zZZdy8JCE7dvkJ87GR0hrQYkJ3RVSJXV/an4DcqbLG/h7G1gQk31PHIcPGmmt2VnoMv6OyzkY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE7keH3aTlnMPdQyiY/8M9MYRXDnIIyLKZTizAU/y4I=;
 b=Ko/Ruw78jkGTHqvvBIZpAf87KTRD2CGro7EIwxYZGTOkTQS0BQT3rqTypd9kFwoODzCKVQdtsREnOyKVKB/WSTUUuNKl3x/mSkyPE5b1LeERbq9kfUsfhnmJFlHuWJW4RsGfoVnAx7fibjPvnrDYB6Hn1eaV1+DWLHvQyaiKku6SnYwaffLyZe9uFpg2SUymXdGndpbpgzh4MgCB5yZ12ymsPPsaiD6fap+FB+m+5l8a2FPCXHhTDKDBo5u/PTRlNRtnFiMCrlXONE0nsWijUPnMccE/H/RSGRTN2WAlDhIeprg2d+vPKcbxZLTj8Os0RsNm6Ln2SfkKr7mR9o9hQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE7keH3aTlnMPdQyiY/8M9MYRXDnIIyLKZTizAU/y4I=;
 b=hm0iYcVl87pbrQxoV0Eu1lOqvXG7E+3hR4pRTg+pD+siLOLjYzqQN21+gj+8zTgdM93UB1j4KBdSY4N6xmGBsp+sG9N1eXXpSHIfhWZLmaCioSNf+b1TRge+bQMgNsc1RM53sOACGPuzK2a45wEAuy3g4VVc6BZqL5JFNNnwPXs=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 13:05:27 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::fd) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:16 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:15 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Thu, 21 Aug 2025 15:03:38 +0200
Message-ID: <20250821130354.125971-40-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 66adfbda-e6f6-43f0-afb8-08dde0b36603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BMwsjK/2rRLhMzg/AwiCyhy0UwLKgsAFG16TW42/PsouAi7Iidswyyhu7FDG?=
 =?us-ascii?Q?klGyywXCUtvxoB3094G+iyM4LnhkUfNR3VDfe5dkEGKG+bc0jmphPb9gQ4Kv?=
 =?us-ascii?Q?kCeSwSNl8ld/NwakwdKnFqxbBQXmsNICZJGfeeEBm/g9tAh/r8OLsenV+Ugo?=
 =?us-ascii?Q?zURnbSk9rSbzQX2gyg3zC/YfnnA0UE1omlyotd89K5j/05aIxUXUbkfSlzxi?=
 =?us-ascii?Q?yIeE7fAchgwDTcBLZejiGt7UQ88PIbz/6EuHOYaADYIJ/IlmHNDIe0vwpeB/?=
 =?us-ascii?Q?vB2X+OOLGPbFThBuFwPOcLXm4pyVN0n39syBn4k6zeLN5z1d469Tjyge6mU/?=
 =?us-ascii?Q?za66SIoGX8cBnfI8Z6jzVZpcI/cdbPaRluMomP+Pz+hTSUGwAarmZmueXmJV?=
 =?us-ascii?Q?/HzKtD4dgLpNBmKlmalEYWf5PvMRhRdp1kYb4tB3+XkEAmHk/CQstCFWVF4t?=
 =?us-ascii?Q?KmmXxrBgBXO/cGka8pKb87esf20MSurfQwCz6A+JSQJmDRTwKq7BJj9JYc5U?=
 =?us-ascii?Q?Mrl1m97mbR2Ia3jL/vq7g6MBXjDVrL+111Ow73yXM8r4CfXeMyi7IzEZ3gXE?=
 =?us-ascii?Q?Q0q1NLTrqKStl7GoysV5LJsWeJnJ4bfEupZPLKWWcdL8vAB7o7SF5V+bCrZC?=
 =?us-ascii?Q?N+mvZQgnhIAChApOtVscNUnT2OKuIEJWpcBnSkl1nUh4YhBsahm70O4yyLpi?=
 =?us-ascii?Q?SZQKpJYXk1+R8BeqCJQEP97uYmbYhoFzjUQAyPZpGiginD/6EKd4jJ5ScNiG?=
 =?us-ascii?Q?IZuxqYBe/gS8Sygr3YiZ4kP/8SyDSt6dZ/UTp3Daw2nYFbd56QRM2QQtlHiJ?=
 =?us-ascii?Q?4eJiwmEIYwpcSxsKO8DiNoNv3r8rA8n/f8RNC88iPKl2Ko1FbYLEaoioWXlQ?=
 =?us-ascii?Q?DLz/PeGT+WU//DO6iEkX+cbzj3JJG22U+vDZwoJft5W5sYaffACPUzecq6Z+?=
 =?us-ascii?Q?0YnigVLJJrCdnBjTnMfVh2HgScWMzjqZz9qQVeWw5JEBfu9IzdS919azMkPj?=
 =?us-ascii?Q?W/nWAZxQmTJQZFjDBQa3wgQBllj4urNqv7uS8Aig7O8/GUIWNvoSISewEnOx?=
 =?us-ascii?Q?jwBJr540BwhnGoLclZrl5XpMatvt7OHZWzN4s9ERclCTpRMAp6tI1COd7ccU?=
 =?us-ascii?Q?tYFtSPkAhM8+w0LqArj2MecU147GDqs2bBwPNEIJkw+ts5b/jp2vhTo6TcI4?=
 =?us-ascii?Q?aXvKnlFuQv+CJ6b8qNt9ZQLmURa/ySsRsUObfbxFVZKFbN8C4CK14nGFyDWn?=
 =?us-ascii?Q?JdtjCTbhGBw1Fr43xxhD7f49PwHaOWHFSqwOKx9/qfTjGLT8hpVCZrp9u5Dj?=
 =?us-ascii?Q?klNBHjXda6rUDJ4HF4xuIZKRZmEGH7nZQ/204gIFqoJr4sdnlRRyalOT7GwL?=
 =?us-ascii?Q?rThzUQ60KGiIS4cBgA34wDPbiXrKsAR8YDoa65hx+3l6fDfXC1npsxkFvXvO?=
 =?us-ascii?Q?jTuC3/5mDT73/QUMOkajZ2tYm3yBYAOEotPHuwURoK6fLzIXlq7gpNBiu8j+?=
 =?us-ascii?Q?bI5G1ItrhiNrvzS6fLWyEHDKb/YVfJvO9qEZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:27.0959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66adfbda-e6f6-43f0-afb8-08dde0b36603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
Received-SPF: permerror client-ip=2a01:111:f403:2409::617;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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


