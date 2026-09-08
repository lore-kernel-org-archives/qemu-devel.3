Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BC0C79FAE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI5-00005v-Rt; Tue, 08 Sep 2026 06:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI4-0008T9-50; Tue, 08 Sep 2026 06:43:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI2-0006ZW-Fg; Tue, 08 Sep 2026 06:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOHhOgmoZIwBfRLD0FieWWDZFMG6kG72e20F/sdB/WQudBLyU6GX8EmEvrImPrXF+NNgbeFYWxzqlruEYJVQy+AMRAvldZC87GgkhehAm8Ly0Sl4XQL3Tm09+YLB8hA5ci7arAp+HQTWFK8Th182xS9xhzmgHnUQO2LKv+OaQ4lx+Khuo7fdb6R/nnQNG5++MQjFejmG2PBm/WsHMmd94r8wdv1CFAysRECN59o6FycfNtvrx9pStL8KnhPRs8xJfHTuG7VJCHUos/9qjhtaypG4OC8XH/VuIu1HEXoecs32IKjQUhQ0Kwn+8N0Ysq7adhISeYDoqgD14IJc7Vgy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcRT8jlxpHruIAEdWFyuSB1sLbOWvhRP72H84w8BSas=;
 b=RYCkvlK49PRhb5PQ3xCrPiWxtIbz4sAcDxKoR3PG3+IN83alJwvg4zs/njKptzwCtCIpWgUcpYTZiQeuRB7S1stDtR1ovpg3clqiI9PPqkAKDBz80FiKy/RY0m0H3dPh7I3AGwNzWyke0eDI8C5dx9o9HRsOM+icV+geht0WUPEsEsmmoZPdybw/Bd9cCONckrbGEay1vHZXErLi223KUug8U3uI32pnWA5ddS4NwtyuC1FXqo4eRFqRCnCmNudIZ0FnYIsSxcllbYg1QFEQeVEgzW3G+PuQj1MkQ2PnSQesxbaEwL64YqDiF/V2vSKACmszAHpkGO0iORcQPVaLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcRT8jlxpHruIAEdWFyuSB1sLbOWvhRP72H84w8BSas=;
 b=h/Ba75yKCLMkAYJoXoBfdxLlUa8pi4KjAqAWlJvbQqGhm4pWw4G0Aflo5GP8BYALrY1D3s1LSda69ppomqTiLXpolO6JE1YJvFTRHTdRUWA78MTbEruroJHaIcIPR2nE+tUmV87Bngg184EQU8z32LOck5a+SQsbhM0Wk2xBgz348tcbMxtog+nhteyA3Cwwg3jy6O6mC0znAsk10ZClME06xkvj3N6RyLE42zLrrKlfO0RLWFGoLSIcsTno1AG9mV4GhhRFnPCF+KiLHDudmJJeIWHOLuvoigpi3IZbHkHLmNGWLY2Lygd9q3ooDKv7ZcSGdjJ17j1QAcVBYp2wTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:43 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 16/32] hw/arm: phytium: Add Phytium E2000 control region
 placeholders
Date: Tue,  8 Sep 2026 18:41:25 +0800
Message-ID: <20260908104159.1621764-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2360127b-a010-4d95-1409-08df0d95e9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: eFSuTru4P0BflcFygotv8kr4hX/pxgBX8OuaeV5SGKyoHSXqtwqaUdlTKxP50o2zzNpBFX5dKR1Hx6cJYp+IhN3nnh+Frc8IKY51LL92EsgM6/5gq4/7qQi5qzhzDVO4zsCKhEkvNUFt+Gfhvwa9M7AIkRTLe4x8feJOCH2GEywiwlYXbvENF3mIVCYhzEkyo19PuKtywAuvWHZtHk+skSTqk7GteJ1b9r/3mpP3ULlvLcL+Xynj6RU4ueKxtDQp81wqCyOqx7mNTpgRXEA0arPIrKjH7hVUuO3Jdoo01yCxM135Tm6BcOTwR+eUAhlo+TuuVnz97xdv9kLmgiuDeQl+7Ek/3dA1o4qlaJvLu1jCqf0qUvbq8JA/Z5jcmwRAZTnE6suWE+b714TulfcrX+A4C1AXstSGbI3vzIp21Yn22raRDi1j8etclGVBrlyWwX2Tfbx7VTlZYFl2zTNhTZgjJW0zf4w9B4jX3svrZu31oFZr9ykSJvertpHU67WmnUgZxdVHT20yfMl84nd0j+hlxbGj6sXcNH8YpL4/7HWS0rYbkfhhIPxEgIhW3ZXopQIO0PZkOMVeJTrDogNdobmdSLgiFSlHsTtYUwzf/Rdl8Ew5REnMOZxBTFM/+DG3MtIzrez5TqaBgMyZ7U3E6X/wA8TdfwWAlg16kvvTEN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMmP0wqL102klIbNMaIDVCQLcp7bcLX0URjy1VQ8sliM4LKO8mP+PZ56eA0l?=
 =?us-ascii?Q?hlfLdfw+QFThJ/72j2Y20S8lWeEYjyxms5u+79Oe7zHu0560LSMfxdxqEjgZ?=
 =?us-ascii?Q?oCgoTMTBuaVcHG10+8Zx8lmKyuYmknwEZgqhcY6DP+Xxec2PzzPPJcJqDC/r?=
 =?us-ascii?Q?skU+IHUukaWXjoUv7U5mwYnqzTdAEtIJQ5VsqAchcbmS5m3x7z7I2wkEQFD7?=
 =?us-ascii?Q?Fv4GoXwBmRxDl4VSXShSdVN7D/+5W4iW197GcSYVqnWl80Jnyj5U/e3s25Ye?=
 =?us-ascii?Q?pP8A8TbrN0PjQwHf4cKXPet1uFPE/8xrquNAZ5j9F8FfkaAnz7xRaIL2d5p5?=
 =?us-ascii?Q?tVwQfaktJT2MxHha6MztXOh0+37RdVHKmrCBpd/VBNswEt+mSce7lVSEQtmS?=
 =?us-ascii?Q?12AGY7FJt9mJCuzsSQSAXd3ygmKOsYJlTjZy+a5ciI231XDWuY2dYdylD1eW?=
 =?us-ascii?Q?4h2YCBw7fNlfhFZ4xbWtIaVM37/lprkJc9+L1HBsxudR8PbLRpbbLPsBbfXZ?=
 =?us-ascii?Q?BRjPljFUIXn/o2r5tna6lVUOP1MsHWoUz00DQpriQK52zRPb6fw0S4IeHX81?=
 =?us-ascii?Q?zmOl4WEP74AeIxH6jj0wLjk9+ZkvNe7e26QZI0iK8Fe5Oe85/DmAsgZTkEMq?=
 =?us-ascii?Q?5G6sMXKJQ+XGs8bGRVvWr7yG6Tb+/9nt6HH07dOs05hNM/A5Yl/40VAPZ6wp?=
 =?us-ascii?Q?qrfHH21GrvFHtd9ARkvLSS6PL22hnmWCL59QuMT2/5UGxNwMVkIEDdFexfOn?=
 =?us-ascii?Q?taZZq5O+m/cReJVcPjBqVjyazQVLBG20fkEopf81WXS1Mnvgjbu7XCIVHIML?=
 =?us-ascii?Q?lRXSU3uQXSGZXlZg1G7LiM3hzw12+hbYkpIaAXR4o0VcQ4m2DJ9hcHzXjLwL?=
 =?us-ascii?Q?Y1h/NP+B+EmPz0h5tJB1TNYxUf5vdP3/vOxp3Uom/J2CAeiiWHUHBZ+Ra2b9?=
 =?us-ascii?Q?l31Brrq103HEuWH/lvGMCi08vywNiMyGq2y21kgeDNCx0chYTybWpmbYmHZs?=
 =?us-ascii?Q?j5XcOrwzqKDyhkMoV4UBBvTNBj3IEW2tfimirXarffIBpNAf2a8JnxMfdqA8?=
 =?us-ascii?Q?VGqni0kWXRPcagG5S412Ed4pQpbW3ix3nZlH3amB1DoHT5UcoO34bbgYKIIT?=
 =?us-ascii?Q?nX25QvUaTAQsrYBcl7i4rCPlwWvJybH4w9Dtxr2r4VrdvrHDxEfS0jQc+Uo7?=
 =?us-ascii?Q?VIQ618QbtH2qv1a6qn3bo+ynk1IafBaKooXAP15N3h5YTc+DEey+Ppjh93bf?=
 =?us-ascii?Q?SVYLbcQLch+3H8aXYbmdoFWoYoX9fK8BUn+N3hoIUSEv6lQRE9exgdg49ikX?=
 =?us-ascii?Q?S6VfBapb98s5B3qCLdsLUFFZmh8R47oKH8lu2IYL7goGAcQfCY8HrLZsG7Zi?=
 =?us-ascii?Q?fPuqi4+//E7fdCdRYSwWHOm+l93f6axOLxHXFXRIHPDJX8pNg8o+OmRxXl/6?=
 =?us-ascii?Q?8L0LTkViPLZRoZTBpPJNGx3bVF+us8dJ50DdcSyHwPreOvj/zB7Z1AA6fZLc?=
 =?us-ascii?Q?EwjHnQa6fUP37yu2juil9oaPq5l4rW0teb1xsz5nRpxuwld5GgDCvgyAXcWl?=
 =?us-ascii?Q?ydNmUwz9ugIxiCo76BJa+cWSCKSfXq4n9Nj7qGUMQsvm5naWUy//awePw/Em?=
 =?us-ascii?Q?tSNHAkQub0DQSvOYnB+bh8TWzwK2M94pETSRijJijhysRV6Ip9+L+bHuTm9h?=
 =?us-ascii?Q?eP2lRZaDLl4oNwEW27wYYZp0pjzIw5Gk7z5ddAlwE5/VhUaOangvrLNVCbWx?=
 =?us-ascii?Q?iKAugFmpzW2q4V282XmENaN890E1JIs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2360127b-a010-4d95-1409-08df0d95e9b4
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:43.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4EWiHv+YfeRsO0ng7dH8Wkf+OHDPLblrulHQzQskjgIqG+DfGp+jzc/WSjLVTOmlhIWdXwhU3UWsoWPABJBG8nH1KU1hfnsxG/HwMeGPvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The vendor PBF accesses clock, reset, platform, security, and chip
control windows while bringing up the SoC.

Expose these windows as low-priority unimplemented regions. This
keeps the firmware-visible address map observable and allows later
device models to overlap individual windows without inventing
register semantics.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Make the E2000 SoC own its placeholder regions

 include/hw/arm/phytium_e2000.h |  5 +++++
 hw/arm/phytium_e2000.c         | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 6199bb7b5c..15aa1cddd1 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -41,6 +41,8 @@ enum {
     PHYTIUM_E2000_UART4,
     PHYTIUM_E2000_UART5,
     PHYTIUM_E2000_UART6,
+    PHYTIUM_E2000_CLK_CTRL,
+    PHYTIUM_E2000_SYSTEM_CTRL,
     PHYTIUM_E2000_GIC_DIST,
     PHYTIUM_E2000_GIC_ITS,
     PHYTIUM_E2000_GIC_REDIST,
@@ -52,6 +54,9 @@ enum {
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
     PHYTIUM_E2000_GEM3,
+    PHYTIUM_E2000_PLATFORM_CTRL,
+    PHYTIUM_E2000_SECURITY_CTRL,
+    PHYTIUM_E2000_CHIP_CTRL,
     PHYTIUM_E2000_BOOT_IACC,
     PHYTIUM_E2000_PCIE_ECAM,
     PHYTIUM_E2000_PCIE_PIO,
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 6818d081b3..18d64aca69 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -68,6 +68,8 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_UART4] =          { 0x28014000, 0x00001000 },
     [PHYTIUM_E2000_UART5] =          { 0x2802a000, 0x00001000 },
     [PHYTIUM_E2000_UART6] =          { 0x28032000, 0x00001000 },
+    [PHYTIUM_E2000_CLK_CTRL] =       { 0x28100000, 0x00001000 },
+    [PHYTIUM_E2000_SYSTEM_CTRL] =    { 0x30000000, 0x00001000 },
     [PHYTIUM_E2000_GIC_DIST] =       { 0x30800000, 0x00020000 },
     [PHYTIUM_E2000_GIC_ITS] =        { 0x30820000, 0x00020000 },
     [PHYTIUM_E2000_GIC_REDIST] =     { 0x30880000, 0x00080000 },
@@ -79,6 +81,9 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
     [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
+    [PHYTIUM_E2000_PLATFORM_CTRL] =  { 0x32e40000, 0x00010000 },
+    [PHYTIUM_E2000_SECURITY_CTRL] =  { 0x32f00000, 0x00001000 },
+    [PHYTIUM_E2000_CHIP_CTRL] =      { 0x33000000, 0x00010000 },
     [PHYTIUM_E2000_BOOT_IACC] =      { 0x38000000, 0x08000000 },
     [PHYTIUM_E2000_PCIE_ECAM] =      { 0x40000000, 0x10000000 },
     [PHYTIUM_E2000_PCIE_PIO] =       { 0x50000000, 0x00f00000 },
@@ -581,6 +586,17 @@ static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
     phytium_e2000_create_unimplemented_region(
         s, "low-peripheral", "phytium-e2000.low-peripheral",
         PHYTIUM_E2000_LOW_PERIPH);
+    /*
+     * PBF writes clock and reset controls as part of physical SoC bring-up.
+     * QEMU derives virtual clocks and reset state elsewhere, so retaining
+     * placeholder visibility is sufficient for these write-only setup paths.
+     */
+    phytium_e2000_create_unimplemented_region(
+        s, "clock-control", "phytium-e2000.clock-control",
+        PHYTIUM_E2000_CLK_CTRL);
+    phytium_e2000_create_unimplemented_region(
+        s, "system-control", "phytium-e2000.system-control",
+        PHYTIUM_E2000_SYSTEM_CTRL);
     /*
      * PBF programs SoC-specific PCIe PHY and port controls before U-Boot
      * enumerates ECAM. Their values do not affect the generic host bridge, so
@@ -595,6 +611,15 @@ static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
     phytium_e2000_create_unimplemented_region(
         s, "board-control", "phytium-e2000.board-control",
         PHYTIUM_E2000_BOARD_CTRL);
+    phytium_e2000_create_unimplemented_region(
+        s, "platform-control", "phytium-e2000.platform-control",
+        PHYTIUM_E2000_PLATFORM_CTRL);
+    phytium_e2000_create_unimplemented_region(
+        s, "security-control", "phytium-e2000.security-control",
+        PHYTIUM_E2000_SECURITY_CTRL);
+    phytium_e2000_create_unimplemented_region(
+        s, "chip-control", "phytium-e2000.chip-control",
+        PHYTIUM_E2000_CHIP_CTRL);
 }
 
 static void phytium_e2000_create_cpus(PhytiumE2000SoCState *s)
-- 
2.53.0


