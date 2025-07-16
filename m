Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C3C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytQ-0007PB-Tm; Wed, 16 Jul 2025 05:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys8-000289-Vd; Wed, 16 Jul 2025 05:56:22 -0400
Received: from mail-dm6nam04on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2409::622]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys3-0006j8-Uv; Wed, 16 Jul 2025 05:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNNXrlOS65EU77rrP4iC8PhhaCe8pbzCZJptxq1flwkmTMaatlrnXFp34BASORIssQXFodo52vKX9I26rFtnTHGm61NKlSDlUKrQAPcO1kwFgy97b0fNftNqT29KhzN7P6mICEJS3Hu5H44PeUGnxcAH9P7l5aVb/mJgXKf8TdRlhkQmh6CFfm2olhLfKkds85zCusF8+uo0n2WzSEZaCfxxG88gPbQNnAK9fy+MAhNNuY3xkqrUgJjBRhjW5OAa+11QVwha+gR91Xxu19j1y/ugq76CVCqPQ8h3oNixvir4KryfT0aLRRR5zpRgssA+JxKimizZAWwfwkNe5dN0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvV4+QZ/Zcc721Opwmj0s1lyP4A/8xXlcEInA1DFBJc=;
 b=gowZy5+ysDQu8SXIUISnPYKqXRG2NsRUxp1zU6ARS5ZehJBjK3FTRAFPtxFKXF5y9tk7ICYdMPsBSHftoGO/qqar+mhYvFO0isJiW3kyrK0CRfp4Yyr/YpVTQcKKTfvpWMqAxNzDqK8nLa3zNeRxD4DQ0Ool3j6Wbes0m5U7kp2O/JkdFJnhF+bLMQJGULzK+LAUdjcP1Xzxi1BE5lTarKeJa2wdd1jFQBa8/2eFjux75S4wVgDAiylwgLqe7/ctthieWWeG+NkBIsud6qO4wqZ21XbsgtZMkKEGIhNYLbscdN0pxH5Xs2UONN69nbBO/QZt56Uq63x59sjl99leNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvV4+QZ/Zcc721Opwmj0s1lyP4A/8xXlcEInA1DFBJc=;
 b=aAG+xwmQVBxJ/kmd8/R4bAmni74Bth9SMnauKW39/rNcWXNkMRftMgDkOe7WcQ7FgBxsSJJ/JfdjdLPZbjbBhmDkonCDfj7uWJlE7fhKZpWDJVkcccf2R+54pw7bwf5cGuFI5hsHY4rvQ3chSnbnnMW628fkvwndT3la1Gz4+tU=
Received: from CH3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::17)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 09:56:09 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::f3) by CH3P220CA0003.outlook.office365.com
 (2603:10b6:610:1e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 09:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:05 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:03 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 33/48] hw/misc/xlnx-versal-crl: refactor device reset logic
Date: Wed, 16 Jul 2025 11:54:15 +0200
Message-ID: <20250716095432.81923-34-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: c6742da4-87dd-48a2-1992-08ddc44efd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sf4cERZhqU1/++JaAn/Cd+FQeAWIS0SVmyteIGyWKi/0QZxa8285vuuv16Vu?=
 =?us-ascii?Q?1FpyHln5XhU5e7Q154UR11bO0HDDHmQxVAzNpLIEe79ObR/F5oUfBMH69oka?=
 =?us-ascii?Q?IbZshPAVdjjklVhOFgS/M80pA/iWRRSM/A4qV2tTFqEvb0dJ300C34gmh+19?=
 =?us-ascii?Q?n+aqHjlcOXt5bfuODQ/DO0GuE54WrPYITK/Tf64CVPXjHgHxMt1p288/p2ry?=
 =?us-ascii?Q?pdUaegKISNv40UZ0WU4U6LEPVosqH7qCaKi0RQTa7TWThvDszYA0XEDmsIAw?=
 =?us-ascii?Q?QSB197hmvaLx0SwwwZ3hwmgh4qsV5SkjHyFzxfwvY5gYCUbFz5Z2bNajcnUZ?=
 =?us-ascii?Q?PJJwukldukmMxOw5FuBoYh+ULY9DzeOsgy4psWcumO1ZVJpuzOEAAgoJKGCz?=
 =?us-ascii?Q?6kkMlqknS63lD6tXDWA25iUu68FpzMyFw8yA8wOcghulJ61Z0pHKie9dHMM2?=
 =?us-ascii?Q?okhXR7UUWKh3m57iRA6kpoQNviblrzIj28XbGmhnr00TXUIfSYY2ZVWur0qh?=
 =?us-ascii?Q?0O8DedFP9i2d4zpobED9knPe0VONWU6dBeEatcEVkQI2Bg2ruZQEy3+UYzFA?=
 =?us-ascii?Q?KOFQQdEXIL6OtRbQVS6fMLlg/uASQpo001XXSPfJB69Om5X48IDqX7ffC0If?=
 =?us-ascii?Q?RtTUid0+Po0GXFOa7ctrX0imnYOvHHOFceExx/BRbODKDhM2TMBs4Iq9aevM?=
 =?us-ascii?Q?2sHDwtJtctIUyOPdvOwAFxEAWXuFrR5pLxsZL7g4/cqbevqk1MED5rsxoS+p?=
 =?us-ascii?Q?OOuw4NAo12KcJRRJYntV7IQ+SU1q4ChfoaLY7dvktLwpPp4qaTOEeWlYg0I+?=
 =?us-ascii?Q?8ZtjOCAdUWfiDtW3gkeMydL7b+HG6kWX1KT2zxbpzIZ+DIJ7tZrNWGGUyBSC?=
 =?us-ascii?Q?JzB/f27F1oj+8AwYINcA1TcMLrE44CO//e3E1uKqWq/obJaEVWjZkiyOcsEk?=
 =?us-ascii?Q?J6d6loQgMeNqadAPS5Y3eU+uT5nt/zgu7m4MsIQDQucRRX7oorvpDWlw8vMq?=
 =?us-ascii?Q?MwgoIPKOCL0zyFpOrXVApQthxyXt24pfoiOaCWz0FhBRVtduHaicdOtm4nmH?=
 =?us-ascii?Q?aNE9yPHTuQTHQJGKcxjQS57dUUMty+BrZkTeT+R1FGmX9cYEsw0XXQ8DVHY6?=
 =?us-ascii?Q?pr2Oaq9YLMErg3d59R9cbqnhMUl17cWibhdfCLjXFEWxIEgFN4Np7cO3Gu2B?=
 =?us-ascii?Q?ioSLKfKizzWA4HQXbdIaAwA0tYlTIBwZUnl32BhKtsdWgRJdGFUP1iBjBK3H?=
 =?us-ascii?Q?94RV6/9jkUxO3iRUuQ5D/Yv8Cb0BHL6UOoBloHnzW3zC7ndjzo1k7UV+zqo8?=
 =?us-ascii?Q?2JJ2zu9MI7shWSQ1yDHPMHiBYbNooFpg3RDC6lVDJXPaH8TG4ufnDfgDl6nr?=
 =?us-ascii?Q?Hqpd/wC6+PK1u5YuU/Gu/V3E13PTjvn35ikhE6t6l/i4z5vGClWFGL1cKate?=
 =?us-ascii?Q?qpbL9vGSJWE3LMvJRlvC8ZEmrajDmObJ7kmPwrV49POtSxM1youYziW3zSSC?=
 =?us-ascii?Q?73X8yptkv+yrpGFUEqpb5UZf/jyVyS9sEwju?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:09.5183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6742da4-87dd-48a2-1992-08ddc44efd7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
Received-SPF: permerror client-ip=2a01:111:f403:2409::622;
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

Refactor the device reset logic to have a common register write callback
for all the devices. This uses a decode function to map the register
address to the actual peripheral to reset. This refactoring changes the
CPU property name from cpu_r5[*] to rpu[*] to ease with the connections
in the Versal SoC. It also fixes a bug where the gem device pointer
was mapped to the usb link property.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/misc/xlnx-versal-crl.h |   8 +-
 hw/misc/xlnx-versal-crl.c         | 163 ++++++++++++++++--------------
 2 files changed, 92 insertions(+), 79 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index 2b39d203a67..7e50a95ad3c 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -218,33 +218,33 @@ REG32(PSM_RST_MODE, 0x370)
     FIELD(PSM_RST_MODE, WAKEUP, 2, 1)
     FIELD(PSM_RST_MODE, RST_MODE, 0, 2)
 
 #define CRL_R_MAX (R_PSM_RST_MODE + 1)
 
-#define RPU_MAX_CPU 2
-
 struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
 
     RegisterInfoArray *reg_array;
     uint32_t *regs;
 };
 
 struct XlnxVersalCRLBaseClass {
     SysBusDeviceClass parent_class;
+
+    DeviceState ** (*decode_periph_rst)(XlnxVersalCRLBase *s, hwaddr, size_t *);
 };
 
 struct XlnxVersalCRL {
     XlnxVersalCRLBase parent_obj;
     qemu_irq irq;
 
     struct {
-        ARMCPU *cpu_r5[RPU_MAX_CPU];
+        DeviceState *rpu[2];
         DeviceState *adma[8];
         DeviceState *uart[2];
         DeviceState *gem[2];
-        DeviceState *usb;
+        DeviceState *usb[1];
     } cfg;
 
     uint32_t regs[CRL_R_MAX];
     RegisterInfo regs_info[CRL_R_MAX];
 };
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index be89e0da40d..115327cfcf4 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -53,94 +53,103 @@ static uint64_t crl_disable_prew(RegisterInfo *reg, uint64_t val64)
     s->regs[R_IR_MASK] |= val;
     crl_update_irq(s);
     return 0;
 }
 
-static void crl_reset_dev(XlnxVersalCRL *s, DeviceState *dev,
-                          bool rst_old, bool rst_new)
+static DeviceState **versal_decode_periph_rst(XlnxVersalCRLBase *s,
+                                             hwaddr addr, size_t *count)
 {
-    device_cold_reset(dev);
-}
+    size_t idx;
+    XlnxVersalCRL *xvc = XLNX_VERSAL_CRL(s);
 
-static void crl_reset_cpu(XlnxVersalCRL *s, ARMCPU *armcpu,
-                          bool rst_old, bool rst_new)
-{
-    if (rst_new) {
-        arm_set_cpu_off(arm_cpu_mp_affinity(armcpu));
-    } else {
-        arm_set_cpu_on_and_reset(arm_cpu_mp_affinity(armcpu));
-    }
-}
+    *count = 1;
 
-#define REGFIELD_RESET(type, s, reg, f, new_val, dev) {     \
-    bool old_f = ARRAY_FIELD_EX32((s)->regs, reg, f);       \
-    bool new_f = FIELD_EX32(new_val, reg, f);               \
-                                                            \
-    /* Detect edges.  */                                    \
-    if (dev && old_f != new_f) {                            \
-        crl_reset_ ## type(s, dev, old_f, new_f);           \
-    }                                                       \
-}
+    switch (addr) {
+    case A_RST_CPU_R5:
+        return xvc->cfg.rpu;
 
-static uint64_t crl_rst_r5_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    case A_RST_ADMA:
+        /* A single register fans out to all DMA reset inputs */
+        *count = ARRAY_SIZE(xvc->cfg.adma);
+        return xvc->cfg.adma;
 
-    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU0, val64, s->cfg.cpu_r5[0]);
-    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU1, val64, s->cfg.cpu_r5[1]);
-    return val64;
-}
+    case A_RST_UART0 ... A_RST_UART1:
+        idx = (addr - A_RST_UART0) / sizeof(uint32_t);
+        return xvc->cfg.uart + idx;
 
-static uint64_t crl_rst_adma_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
-    int i;
+    case A_RST_GEM0 ... A_RST_GEM1:
+        idx = (addr - A_RST_GEM0) / sizeof(uint32_t);
+        return xvc->cfg.gem + idx;
+
+    case A_RST_USB0:
+        return xvc->cfg.usb;
 
-    /* A single register fans out to all ADMA reset inputs.  */
-    for (i = 0; i < ARRAY_SIZE(s->cfg.adma); i++) {
-        REGFIELD_RESET(dev, s, RST_ADMA, RESET, val64, s->cfg.adma[i]);
+    default:
+        /* invalid or unimplemented */
+        return NULL;
     }
-    return val64;
 }
 
-static uint64_t crl_rst_uart0_prew(RegisterInfo *reg, uint64_t val64)
+static uint64_t crl_rst_cpu_prew(RegisterInfo *reg, uint64_t val64)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
+    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
+    DeviceState **dev;
+    size_t i, count;
 
-    REGFIELD_RESET(dev, s, RST_UART0, RESET, val64, s->cfg.uart[0]);
-    return val64;
-}
+    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
 
-static uint64_t crl_rst_uart1_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    for (i = 0; i < 2; i++) {
+        bool prev, new;
+        uint64_t aff;
 
-    REGFIELD_RESET(dev, s, RST_UART1, RESET, val64, s->cfg.uart[1]);
-    return val64;
-}
+        prev = extract32(s->regs[reg->access->addr / 4], i, 1);
+        new = extract32(val64, i, 1);
 
-static uint64_t crl_rst_gem0_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+        if (prev == new) {
+            continue;
+        }
 
-    REGFIELD_RESET(dev, s, RST_GEM0, RESET, val64, s->cfg.gem[0]);
-    return val64;
-}
+        aff = arm_cpu_mp_affinity(ARM_CPU(dev[i]));
 
-static uint64_t crl_rst_gem1_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+        if (new) {
+            arm_set_cpu_off(aff);
+        } else {
+            arm_set_cpu_on_and_reset(aff);
+        }
+    }
 
-    REGFIELD_RESET(dev, s, RST_GEM1, RESET, val64, s->cfg.gem[1]);
     return val64;
 }
 
-static uint64_t crl_rst_usb_prew(RegisterInfo *reg, uint64_t val64)
+static uint64_t crl_rst_dev_prew(RegisterInfo *reg, uint64_t val64)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
+    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
+    DeviceState **dev;
+    bool prev, new;
+    size_t i, count;
+
+    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
+
+    if (dev == NULL) {
+        return val64;
+    }
+
+    prev = s->regs[reg->access->addr / 4] & 0x1;
+    new = val64 & 0x1;
+
+    if (prev == new) {
+        return val64;
+    }
+
+    for (i = 0; i < count; i++) {
+        if (dev[i]) {
+            device_cold_reset(dev[i]);
+        }
+    }
 
-    REGFIELD_RESET(dev, s, RST_USB0, RESET, val64, s->cfg.usb);
     return val64;
 }
 
 static const RegisterAccessInfo crl_regs_info[] = {
     {   .name = "ERR_CTRL",  .addr = A_ERR_CTRL,
@@ -242,31 +251,31 @@ static const RegisterAccessInfo crl_regs_info[] = {
         .reset = 0x3c00,
         .rsvd = 0xfdfc00f8,
     },{ .name = "RST_CPU_R5",  .addr = A_RST_CPU_R5,
         .reset = 0x17,
         .rsvd = 0x8,
-        .pre_write = crl_rst_r5_prew,
+        .pre_write = crl_rst_cpu_prew,
     },{ .name = "RST_ADMA",  .addr = A_RST_ADMA,
         .reset = 0x1,
-        .pre_write = crl_rst_adma_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_GEM0",  .addr = A_RST_GEM0,
         .reset = 0x1,
-        .pre_write = crl_rst_gem0_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_GEM1",  .addr = A_RST_GEM1,
         .reset = 0x1,
-        .pre_write = crl_rst_gem1_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_SPARE",  .addr = A_RST_SPARE,
         .reset = 0x1,
     },{ .name = "RST_USB0",  .addr = A_RST_USB0,
         .reset = 0x1,
-        .pre_write = crl_rst_usb_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_UART0",  .addr = A_RST_UART0,
         .reset = 0x1,
-        .pre_write = crl_rst_uart0_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_UART1",  .addr = A_RST_UART1,
         .reset = 0x1,
-        .pre_write = crl_rst_uart1_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_SPI0",  .addr = A_RST_SPI0,
         .reset = 0x1,
     },{ .name = "RST_SPI1",  .addr = A_RST_SPI1,
         .reset = 0x1,
     },{ .name = "RST_CAN0",  .addr = A_RST_CAN0,
@@ -341,13 +350,13 @@ static void versal_crl_init(Object *obj)
                               CRL_R_MAX * 4);
     xvcb->regs = s->regs;
     sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
-    for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
-        object_property_add_link(obj, "cpu_r5[*]", TYPE_ARM_CPU,
-                                 (Object **)&s->cfg.cpu_r5[i],
+    for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
+        object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
+                                 (Object **)&s->cfg.rpu[i],
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.adma); ++i) {
@@ -369,14 +378,16 @@ static void versal_crl_init(Object *obj)
                                  (Object **)&s->cfg.gem[i],
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
 
-    object_property_add_link(obj, "usb", TYPE_DEVICE,
-                             (Object **)&s->cfg.gem[i],
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
+    for (i = 0; i < ARRAY_SIZE(s->cfg.usb); ++i) {
+        object_property_add_link(obj, "usb[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.usb[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
 }
 
 static void crl_finalize(Object *obj)
 {
     XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
@@ -394,15 +405,17 @@ static const VMStateDescription vmstate_versal_crl = {
 };
 
 static void versal_crl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_versal_crl;
     rc->phases.enter = versal_crl_reset_enter;
     rc->phases.hold = versal_crl_reset_hold;
+    xvcc->decode_periph_rst = versal_decode_periph_rst;
 }
 
 static const TypeInfo crl_base_info = {
     .name          = TYPE_XLNX_VERSAL_CRL_BASE,
     .parent        = TYPE_SYS_BUS_DEVICE,
-- 
2.50.0


