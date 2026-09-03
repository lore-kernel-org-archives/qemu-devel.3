Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA40C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25a6-0005TW-C2; Thu, 03 Sep 2026 07:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a4-0005Sh-42; Thu, 03 Sep 2026 07:26:08 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a2-0006f9-8Q; Thu, 03 Sep 2026 07:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/lxyrzDfz83YbtXcHxh+QEfOet/9seugfU1JAsH4E3QH4MsYDW4pgwsJ3NlSPRVHetbjJkhR/dbmIh22c4IdagaAuEn6ScyN1aXGTKq7tem8k7GG5KjBQxAOMmB+DONVSZrrXWvNV3TvgMpsEs6BNxqv0xI8vSSCHEuDGNW7T5sOdUMKtxDiwwwrTe+qKQnSVHg6emu9IYfVb/e4zZiVQ/JAemwt9IxuxoGAOmUC1LMn92Y2CORXpCayWCDi+onja6D19B8AAbArTqscb+l+iJ3/ESZvi7/0DqHHHJK61rDUe13S3MLre8cMa29EIZqOaBl9fo1pwIeAPknJxlcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP5B7KduE+ohaZcnUPmMyrq/Gl9zLGQgxnH6KzabY/4=;
 b=HvpRd4eFXWfjKjfsCcMjN5uhcNE97pXIHM/JMqSM9bVOTjdHuhw9vxicSk96raoL1ao/apgwYqXB/KFAEThNyry8T0ZsBIKj/NmMDBc7INJA5gdgz555aVMt5jsRa7wfmy/2zTIytp6bBKUDtg39dnckCR9WK30xso0Foqeok+JFecaf6yjMxROG2wZ+WJIiYJU13chypxNOqiaVGYbEcJRjtiYAKIgWE63Ho9eim39Jni4Zy31mQSTwYw2u6/bEi5KchgQQyFbUiSqmwqbh0sqZqtA6PyyaIVAoRh9JBklK3+9LY7R7SmTnx19rfU2+8r65JGrp/ucKiv46YPZ7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP5B7KduE+ohaZcnUPmMyrq/Gl9zLGQgxnH6KzabY/4=;
 b=jg/WHaEaqAJUOoqDTrBwSPnfPNHEigLlcliQ36e5GZVpVPo31r78ojpbdCWzCSwOuv7fe9jvpPjmcQmtv04SbexbZYmKL+QnYPVDu2lM1VGSVjfXFx0OtxzTmVfXlkqGRs0YvuRgVv6hSBm/qQ9VktpEI+e7DEj2RpgiSlchRO7L/sNjmAlaxd1e0nFSS4pR889CqY55dVVoWD4td/02Mhf945cF5KuM4YMzxgF3NJYxJ3YNBiJMXyqEwm2NA5I6rHePYtwc8wWx0ba+zwjOfONekSfDgXR2f1QtUumn2YIjROZpdPkhMaIoWkA2R8KNyU92Ubt+tyzlgqSuUwRSkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:25:53 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:25:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 01/33] target/arm: Add Phytium FTC310 and FTC664 CPU models
Date: Thu,  3 Sep 2026 19:24:41 +0800
Message-ID: <20260903112532.3276678-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b465f0b-9ae4-4667-cb6a-08df09ae1d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Z042oRFFNGpU4XbhzYv1pct+nbgZUnuZMAr/ndjlHyahGLDhZIlMAtXQQYBYj7f2F5Gxk00ZJz7B57A0MmN/4a4En1y3o+P9dHFOGCHSFC7+4SYYDMLRy5nv0HKCOW58P4Ox0Bc6S9Fg3lPATXmdTe717jNhKy20bxVuE7Ob6yESa+wdmTw4nyqeC++F/uYKMYorI0Ns+5sa7UvSfUpNjWzUIiIEmGm64+PisprZY7SqVL5o/+HOsW70tH1FYnYk3pwKjRvMI1LoCDspZp24ltR/eY/aviqMi4K2Ac4r7oeK5y2ElE8FMzMOVo8Jt0Gg56B09ShAI+SrM8owbhx6T0if3OfPg+L4NiLoEdKhpdNXk7Oi+Z/Es3fTNbdRi3Y6ZpRhhEFFvxAWsUd6NsopPGrgU11jBS7fI0BoYJpEJYTLNq/NiNbmGZtm9GZraxHzIlX4XgeK+24JtwsgoDoJPSpdTtXc0UJG73L5Ndku2DsGbOHIF7EV1DFhyIMzeyskTPuFLyCk320i2B71Nb4YeroTBB5V2HSkAonn7ZC4zY0aPcQQbVjGl+AWqI6EbE/xJItLHI8fneF47gGaT/8q0f0CbRbB+0A58EromZm3DufANuqkrDdY7Jtpbh1+DqjFNRHrOWkGF0GbZ0qyJ8sQBL7L20Cc1tjcSrVzfjKrcrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pjy3a5tmn7braoSedUGXZL4q51gijHmUfw2toBzPGwL5NiXdd+VFdiYmznhq?=
 =?us-ascii?Q?dUWdLF3qmQ/a+Z/AKpTOtHBCGEmmlhw17fEh/gmFiy8Ug8+Dlf+s0/RGmO5H?=
 =?us-ascii?Q?H/4QpR4uoXrtZBSl6xwV/AR9ZRhT7l8e341p9RnZey3atuuHmGhS9t/SDTO6?=
 =?us-ascii?Q?MKGdIODXNZ/Y3b8rGq9BOMS1L33IOTdp/WXsTgVbGLdAzcy97TQQPycqyH1m?=
 =?us-ascii?Q?Fta2ZFsZxYrtLpt0WVShnJWrYoj5M1E2N5IYCDZ0c3V5HYSiQLvVFXbZ2TNP?=
 =?us-ascii?Q?6z69r0ae/f/0TwpMJ5Z2ZmnwqmCv2H1SN+/IRi4PPLeqtOsROtq7kSGXN2kp?=
 =?us-ascii?Q?ePwSiH1dC7EIlMWKFnWZtykdQB5+lDIObTAZ3s9dlhtfsL83C0zomQEFfnri?=
 =?us-ascii?Q?iRfbqzB+iEq5al50xASOYqLzEQr7hYHUhMrx/BJXGlyoubZoWLtlFag3oGq8?=
 =?us-ascii?Q?x9hZZPE8GFM4DHyKlc1myN6YQNB6apBb4eEiVF9bI00ShAfa2jFMbVbwuFrJ?=
 =?us-ascii?Q?eWcxFHJ1miJZJa9O2tXvJMABbX/OZWyw1Y9oK2NZzUM5cWQyI/yWqxPTFHQp?=
 =?us-ascii?Q?8R7cFecnJCsRL3pc5ZBt7GMIbq0sQb1FcH6xWwL6C9sSfS+LBw+bNAiMjuXC?=
 =?us-ascii?Q?KlCBsazm+ynkFz//SPnxU/LaYxvLISwDM4CXDggr51H41Yjmqax77tWNWJcQ?=
 =?us-ascii?Q?oG7Is+RkeWHzMIpo4dM+H/D6ef+TpzlHM/2ixNBZQAWOgg2AteO+PnG1dHh8?=
 =?us-ascii?Q?NrEY8yxjvj82U0KFaIfQ4S2RKxWvCerXvQQ/OPl0HQSgHH45G/1c0U31thAO?=
 =?us-ascii?Q?hJDt0hhWuBEVaEZeznkpn3SXAR7IebYKljTu98q/3n4nPlzKEW0bCMqpVeIF?=
 =?us-ascii?Q?sOKPjgeEVpTqz6yMJAq3K5gzE2JBD6ZuO/zC4P30Qa5GNHRMLaHiPC0phNr5?=
 =?us-ascii?Q?xZdlwkdlOvGi9aLfVpKOpIRMLJ6Sjb9935jNGZ4r4woZ9E5ZDiZkmoEffSml?=
 =?us-ascii?Q?pnPg0BfnGPf8RRSv4phfFYAFcu2hB7P3CnnKwWtEx57vP1MiRAfzjfDGsJL/?=
 =?us-ascii?Q?6rTU7mtJ43+NPQnQ8HEOQ3kmi3l71KnTKmGUd7qKVlqskN98MqT6w68yeFOj?=
 =?us-ascii?Q?0VJ+V9e8rd/G2WhKJ8gM+15wNaco7gZr7HLZ32u4oyO70BX2/ONTWIiZtZdp?=
 =?us-ascii?Q?eHSXCtyPpJ7/GKZud3P7yOEpjrNZZ50yLr0rVCvLaIvKgkHA6GUGhMZWit2j?=
 =?us-ascii?Q?e9YAYtQ0FQ21dwwKwSPaoH8W7KJSjFhPMbWNT5X/ORNdJIGu2PpJvzGvvSOb?=
 =?us-ascii?Q?DNygcZ+VrrNCnrbL78vykuFQDtpPD4lTWZLx2ZgehIXzN66MJCdw7gulXOUd?=
 =?us-ascii?Q?T3Nk98XTcTJ+10IRckFc2vwIzyz6w+sr/voV65asLIHvHiUF2jxF7ZhBVFrk?=
 =?us-ascii?Q?BHmaejAiYTmacPfSdoN3Ksh0eeWFuvrjx8sEUWDX1TwEze7lwelMYTUDrMd7?=
 =?us-ascii?Q?x2W9mP7dKQdNURZFFhakiCn+SHscyjZSE3R8FyXEO1maCmYs5sMhFByk+nXy?=
 =?us-ascii?Q?3Uj9PuNJzUOOY9MkXoitPg5mb4s/GmBY7plG/TGz6Zg18nJySE9c+fnisXAo?=
 =?us-ascii?Q?+YFQ/RCuOkH2eE2uo9R750vMHzbuo1mSZUi5dlJ7Le6D9Qj3iy3Y+mCdP2Yu?=
 =?us-ascii?Q?FmKHMNZR49myMnR/JnhhKpKfTzINpVt3A1yOqTpWfIwj7DIieqCtkq7meTLr?=
 =?us-ascii?Q?wzW1s45V2xMBDRe5rw1dCWb6GrbaMg8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b465f0b-9ae4-4667-cb6a-08df09ae1d6b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:25:53.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmOumWFf43uB0DbqESwP52qQ23OlDxsKhrmOVBsi/MRAVPKyK5j7fOpueHnJSC+uiLbPNdjc60rlE65vm5uGzVxhJ+I7LRkNgsZJnjSER8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Phytium E2000Q combines two FTC310 cores and two FTC664 cores.
Its EL3 firmware accesses implementation-defined system registers
while setting up the cores. Using generic Cortex-A72 CPUs leaves
these registers undefined and traps firmware before it can reach
U-Boot.

Add FTC310 and FTC664 CPU types using Cortex-A72 as their common
execution base. Provide conservative RAZ/WI and NOP stubs for the
firmware-visible E2000 controls that have no modeled behavior.

Set each CPU DT compatible string, MIDR, instruction feature fields,
AArch32 floating-point feature fields, and CTR_EL0.L1Ip field to
values observed on an E2000Q board. The FTC310 reports a VIPT
instruction cache, while the FTC664 reports a PIPT instruction cache.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/arm/tcg/cpu64.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index affd87a3ae..0fd2f79bbc 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -336,6 +336,85 @@ static void aarch64_a72_initfn(Object *obj)
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+static const ARMCPRegInfo phytium_e2000_cp_reginfo[] = {
+    /*
+     * The E2000 EL3 firmware touches implementation-defined CPU registers
+     * during the PBF/BL1 cache and core setup. QEMU does not model these
+     * controls, so expose conservative RAZ/WI stubs for the boot firmware.
+     *
+     * PBF reads these identification and cluster controls after writing
+     * them. Returning zero preserves the reset state without claiming that
+     * QEMU implements the associated cache or coherency controls.
+     */
+    { .name = "E2000_CPUID_CTL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 15, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+      .resetvalue = 0 },
+    { .name = "E2000_CLUSTER_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 11, .crm = 8, .opc2 = 6,
+      .access = PL1_RW, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+      .resetvalue = 0 },
+    /*
+     * The remaining controls are only programmed as part of firmware setup.
+     * Accept the writes without retaining state because no modeled CPU
+     * behavior depends on their values.
+     */
+    { .name = "E2000_EL1_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 2, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+    { .name = "E2000_EL2_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL2_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+    { .name = "E2000_EL2_CTL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 2, .opc2 = 4,
+      .access = PL2_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+    { .name = "E2000_EL3_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+};
+
+/*
+ * Use the Cortex-A72 execution model as the common E2000 TCG base, then
+ * replace the architected identity fields that differ between the two
+ * physical core types.
+ */
+static void aarch64_phytium_e2000_base_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    aarch64_a72_initfn(obj);
+    define_arm_cp_regs(cpu, phytium_e2000_cp_reginfo);
+}
+
+static void aarch64_phytium_ftc310_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    aarch64_phytium_e2000_base_initfn(obj);
+
+    /* FTC310 cores identify with the FTC303 part number */
+    cpu->dtb_compatible = "phytium,ftc310";
+    cpu->midr = 0x700f3034;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x00011100012120);
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->ctr = FIELD_DP64(cpu->ctr, CTR_EL0, L1IP, 2); /* VIPT */
+}
+
+static void aarch64_phytium_ftc664_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    aarch64_phytium_e2000_base_initfn(obj);
+
+    cpu->dtb_compatible = "phytium,ftc664";
+    cpu->midr = 0x701f6643;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x00000100012120);
+    cpu->isar.mvfr0 = 0x10111222;
+    cpu->ctr = FIELD_DP64(cpu->ctr, CTR_EL0, L1IP, 3); /* PIPT */
+}
+
 static void aarch64_a76_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1533,6 +1612,8 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a55",         .initfn = aarch64_a55_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
+    { .name = "phytium-ftc310",     .initfn = aarch64_phytium_ftc310_initfn },
+    { .name = "phytium-ftc664",     .initfn = aarch64_phytium_ftc664_initfn },
     /*
      * The Cortex-A78AE differs slightly from the plain Cortex-A78. We don't
      * currently model the latter.
-- 
2.53.0


