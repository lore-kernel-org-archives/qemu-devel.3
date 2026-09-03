Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B41EC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aI-0005Zp-P8; Thu, 03 Sep 2026 07:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aG-0005Yu-RC; Thu, 03 Sep 2026 07:26:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aF-0006gK-1b; Thu, 03 Sep 2026 07:26:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+RP5o0wVSTTef4hWy7kuCFWHILQP8hBPGSg6Rd3gYYvtP9iMv5s3Zz8R2aDZ0qRDT+BY675asgAcEU/ByNNsYKklBeCyjVFogOBU50k1iHY5Uq1mSdSf3w7tzpcPj0eGCr0vwMSVbHi9n3he9Ldv0rVpPhWJ/+QCGezpfZyFJnetUDwADUkbTxpKQoBTWFAfiIyy67mN0Wh6xONDhBEzcp3QxR/tkcvILrtBw5ysPGroxIltk22weyPvQV5BaH/3wbZ7LB3XJMovnbAf2RArWxOysdhPTVSlItKfH/ZczUtk1+8I3jxTy3eISvNVMJBfxkocN2av4NHjy3w2gT5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyE5diPs9tc+ibUZFSef20+fLdVx7hybKj/Pa7imnGc=;
 b=NukK5w1Wf6Vu+f75daUQ6HX44dIkPe+fSbGQDBP++n7RiNmrf7uwDA7wTc006ZMXVZ53cXliwKrZgTF8Qbv7GjLhzieafgIWqtYAH0R8N+tyidQti5ba6ZdKJXZ6N1fXQiwb8PqgksVo/NOO8Q+ednNiUz7qbbLZVygGfBfidu0G3yaBecpEDWJLi6Q3ZsvWSac42BkWDS3YVE8v285ErqPZ5WMVMKu32BtWTo1oocGxE42jWe+32RPA7PFfTMTgY1Wkh+pu7s+NgVs34XJmhCdDoRTC5QZqryRphbi7JQysr+r7sclfmN4KzgLZ1EhfqbBT6zZ9gTWF1s59JQs2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyE5diPs9tc+ibUZFSef20+fLdVx7hybKj/Pa7imnGc=;
 b=Ns1iALbPTVu/N2KfTteP6HBYxlOOhsyCnlczWboHeXFEN5VqKAgU+qw733EJEP9KCO44yyaP5dffYNOu9r5XXAtqauNJxtfsuSH5ceuCOp0VSxCn1qG+Rq3ZvjJXPtuubFO9Ru9m+Jwg/91zTSXWKSkaZCWC5JRrabUIFdo62Ga/SsbUwFquh4V7Li2fhNscBGW1fsGw8kVusXDRqs5jQ9+lr2hhasxs2BLOtxiuyU43mz7mOi6JCTh/bbmx12HDQExFGm6oDb4rZqxqw5OoYIdipscWwP5d/ce744H0aMjK3ZL0eAwzFfYlueRWHIKFwHCfg4IBogg5bHs8urnLeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:08 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:08 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 08/33] hw/arm: phytium: Connect Phytium E2000 GEM controllers
Date: Thu,  3 Sep 2026 19:24:48 +0800
Message-ID: <20260903112532.3276678-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec7b4494-e48b-4a1f-b09c-08df09ae2623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yQMG1qvnFWNJXBSaQsoX9bxVXdF0sPUQ61qbduFxBqFmnaY6P4edYocHwIWFZaFa47zOU5yD6GAyuuGSqxrFBe0MfytyKEhlyVR3sV4qkNEtQqTlcnu28D0ldOSKXVZMHU1+O2RsEGI+/JXI/U31q84Q7AQ8WExowo0Nxw7vVz/aD1CBhZnfnEgTbTtF562TiG/W9uqk+a9D5950g7HWyMcPvY9aRKqB3QrWINzhHD1H+qRBkMChXxrOYY+fTGLwWhbl5iod2HuMmAvW75/65vg27gkDEMIllQGw/DAa3+rGjovd9pDV5YCDyuYAeEBR39GC4iiG0zmYQlC4Sii77CVzbOczxxQluef2dfHV05O4sZGgut4ENAYf2sx3E5W0wozUPxv7BlOOTqP8ef3zpxHgdy3q3LHnjpJeE5qKa4glMBNzzS7v+i0YcxGhZQaZ8S+TACpILWwELYXg5KtQ/+yUJefwuZug/USC7F0v/3NbuW77sE/C7g05P552sxZIVrqNFNWyMJl8kHPkrb7mfGOZEFp4tNmYrzcj5uMLaGHJQNn/ipCLbCjSHxdy9cMDw5LrURVV7fwAFec1uqZEShfg6rXzupmwcw1pO2PW5YZM+CGep0UFEKxRNuHbtklh72j+rNYcDn1ScNIfDmwLlAAS4gCGwCaFko+8ptYV7wE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbzzB/m9W2jLPBQnNIDlQ0E0wFp7BdDSICIf4pN8uyNZ8XWKhv7YnvmVaBdO?=
 =?us-ascii?Q?lQWK80zCVK5LmwkMOwihArYdhIefehjDTfohT2v/0rWBsi1Jm4yYUJ5l8/jQ?=
 =?us-ascii?Q?u9kz/d+w+d7uHpNQlUGSsy6+DSXsTfusBWNY3YzWmGtJ1yQSMqtU2stADsWz?=
 =?us-ascii?Q?A3JYXBhgB6768zB3w4x7U+WqP9iPmc9DvKVkGii1/VIaC1d/3TvN+Tk3gvRr?=
 =?us-ascii?Q?SPwkZhptzYhhgFN5OnJjGqJigAPrzyT/jc5AStOBb5kSFJeO+j0OxpU3nI4U?=
 =?us-ascii?Q?ZieSCcw+NOcRRSc63ekQHVRnfYP+7kqDCr5qPnQr0aUr5OcnudRRfmL2JXZT?=
 =?us-ascii?Q?HILyCw4EgTDiW3ubfcd+Fe+9SOoFdaANN6oE2j+9KjE21IkUNRDFGB/rU7U3?=
 =?us-ascii?Q?xtSkvjqIsCxa0lHTaIc0yHH7ByeCaDFLdBHVpQVxiYI8evpoEHZVl4I6g0D/?=
 =?us-ascii?Q?FGz8Aq2XtN9J4du58PR6n8vdUMCIRQYL9Zn3Tppa1EBXszbR5oRYeFykcwrr?=
 =?us-ascii?Q?uMPD0KQlT9USTJ9eMmTTuldWjRsNk4JIC/FfkbZoHiapZUQ9qmF4Pf8cEUdu?=
 =?us-ascii?Q?BCNb26tCuQDDW/vH2uB9M/FBb3q4I9MySmiJIBYEmAqKQyuRgPuDW2SBECxR?=
 =?us-ascii?Q?Y4CfFZDe8Nt1DJDFM7FUWIepD0sJ0l6UbT+o3pe1Lbr5pDgnflTZP5raU+ES?=
 =?us-ascii?Q?GR04cFacDXbaCqHoNKEkhJYm6/a2JYH8MX2t0kIY56ohjHn1qvcesByih9Fs?=
 =?us-ascii?Q?Kd5lHrSMtf1A9C6/16JPfKEBJzBmeSlz9NjS9XFIFpPifhhYeU6yUrGMKkT3?=
 =?us-ascii?Q?lTxcWSMTqsizXk0SMNyDexod3pJip4V0HpuCuJMzcIlZTZo8TOI/r3ywoFQf?=
 =?us-ascii?Q?G/chgKgo8CeGsmsRbSZqXfclGEEz7ZTYOVki4sy0elqmXkUIy7iCDAljUmMB?=
 =?us-ascii?Q?aAeYTymcBANzg9ycHSEt+awztP2K/fc6jJjh3VQuREHGG6RIBBBY3wyhW2Yg?=
 =?us-ascii?Q?mx0lTe9LYBoFTVh6vvoIqGz9yJkeR53d6ZC6C9YwZfHzq62mTEsPIAdKU47c?=
 =?us-ascii?Q?OBZbgHsc+/KN4mH4mZVUvIWYNhTTi0QSI/yU5wuyvX601vRbFJvcailAnmYc?=
 =?us-ascii?Q?WUvwky0MKO4PvHoJRmOkNGBQI30/FHGX7yJaMRHQ/tFTYNfkLI9lhk6fD3Fn?=
 =?us-ascii?Q?5NFO1Jre0ZQd7TzjZ7lKr/Gou7a/uEk3HkXXCaoqq1IEvUoF1qBmOJlmIdcB?=
 =?us-ascii?Q?/XwRS0Flybl5FrCXM6APud1MMyfS4vRkZjhqHTunTmf8QRl+zzOkoOSHk08x?=
 =?us-ascii?Q?q7teWYFGRPCEkMIv/O/V3PsLtID15fwewtxRcq7x09f8Ge9Hz6Ulh7WViS1C?=
 =?us-ascii?Q?GkLFPxPHrsw2AxbUtstZ1XNpMVb2bsOON+sAHdtDaDMe7+bHmc09ATl9AmON?=
 =?us-ascii?Q?lplGFRaDkw5QnTw9/fpiDQckUxggpzVMvTWx1dSmBQEKTN8Qt+mLLJLAYD57?=
 =?us-ascii?Q?5PNiGLXAystMlZWc3dcJn2UK9OdqZpnKOs/fS8o2TJt2JYyVBUYJeCySdNAV?=
 =?us-ascii?Q?sACMNLTEcKesdXzNjO3Bg6G7hLxWUkeo2v4tlZWlrEJUgDllJ+hIaJotwq4J?=
 =?us-ascii?Q?ZMbtPZPuS47iik+UeqdDeThIg2g4rgSQQc4TzI545C9f1x7ZK2p0ocZPQZXb?=
 =?us-ascii?Q?xdJ1AmKDsqg7W0LvPQGiXh3zL6DKYLAhx0aPJ2xQObY7s33whzTgQRFCYhVp?=
 =?us-ascii?Q?7cnAjql2v6z6V1AxxbB8moZKKLqaTZw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b4494-e48b-4a1f-b09c-08df09ae2623
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:08.0068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA1J1aIrYO5uQ7ZuLsgqHz5TnewDLpbdl3MIUi2w61i8hEQzj98mEaD87ezy+LwiKmw42HvEfmpkPjw+Da5uG555ranPvQIA68/qpFK2D6U=
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

Instantiate all four standard Cadence GEM controllers described by the
E2000 SoC device tree. The generic model implements the first 0x800
bytes of each 0x2000-byte E2000 aperture, so cover the complete window
with a low-priority unimplemented region and map the Cadence registers
on top. This accepts accesses to the SoC-specific clock and SerDes
selectors without inventing their behavior.

Connect eight queue interrupts for GEM0 and four for GEM1 through GEM3,
and configure the PCS, MDIO PHY address and 16360-byte jumbo limit
expected by the SDK drivers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9358a47b8a..08128232ca 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -132,6 +132,7 @@ config PHYTIUM_E2000
     depends on TCG && AARCH64
     imply PCI_DEVICES
     select ARM_GIC
+    select CADENCE
     select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 88307184e9..c68a565330 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -26,10 +26,12 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/unimp.h"
+#include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/sd/phytium_e2000_mci.h"
 #include "hw/sd/sd.h"
+#include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
@@ -44,6 +46,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
 
 #define PHYTIUM_E2000_NUM_MCIS        2
 #define PHYTIUM_E2000_NUM_UARTS       7
+#define PHYTIUM_E2000_NUM_GEMS        4
 
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
 
@@ -65,6 +68,10 @@ enum {
     PHYTIUM_E2000_PCIE_CTRL,
     PHYTIUM_E2000_PCIE_PHY_CTRL,
     PHYTIUM_E2000_BOARD_CTRL,
+    PHYTIUM_E2000_GEM0,
+    PHYTIUM_E2000_GEM1,
+    PHYTIUM_E2000_GEM2,
+    PHYTIUM_E2000_GEM3,
     PHYTIUM_E2000_BOOT_IACC,
     PHYTIUM_E2000_PCIE_ECAM,
     PHYTIUM_E2000_PCIE_PIO,
@@ -79,6 +86,7 @@ struct PhytiumE2000State {
     struct arm_boot_info bootinfo;
     DeviceState *gic;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
+    CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
     MemoryRegion ram_low;
     MemoryRegion ram_high;
 };
@@ -106,6 +114,10 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_PCIE_CTRL] =      { 0x31000000, 0x00200000 },
     [PHYTIUM_E2000_PCIE_PHY_CTRL] =  { 0x31500000, 0x00001000 },
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
+    [PHYTIUM_E2000_GEM0] =           { 0x3200c000, 0x00002000 },
+    [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
+    [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
+    [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
     [PHYTIUM_E2000_BOOT_IACC] =      { 0x38000000, 0x08000000 },
     [PHYTIUM_E2000_PCIE_ECAM] =      { 0x40000000, 0x10000000 },
     [PHYTIUM_E2000_PCIE_PIO] =       { 0x50000000, 0x00f00000 },
@@ -130,6 +142,16 @@ static const int phytium_e2000_uart_irqmap[] = {
     [6] = 107,
 };
 
+static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
+
+static const int phytium_e2000_gem_irqmap[PHYTIUM_E2000_NUM_GEMS]
+                                               [MAX_PRIORITY_QUEUES] = {
+    [0] = { 55, 56, 57, 58, 28, 29, 30, 31 },
+    [1] = { 59, 60, 61, 62 },
+    [2] = { 64, 65, 66, 67 },
+    [3] = { 68, 69, 70, 71 },
+};
+
 static const int phytium_e2000_pcie_irqmap[PCI_NUM_PINS] = {
     [0] = 4,
     [1] = 5,
@@ -255,6 +277,43 @@ static void phytium_e2000_create_uart(PhytiumE2000State *s, int index)
         qdev_get_gpio_in(s->gic, phytium_e2000_uart_irqmap[index]));
 }
 
+static void phytium_e2000_create_gem(PhytiumE2000State *s, int index)
+{
+    DeviceState *dev = qdev_new(TYPE_CADENCE_GEM);
+    CadenceGEMState *gem = CADENCE_GEM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *name = g_strdup_printf("gem%d", index);
+    g_autofree char *unimp_name =
+        g_strdup_printf("phytium-e2000.gem%d-unimplemented", index);
+    int map_idx = PHYTIUM_E2000_GEM0 + index;
+    hwaddr base = phytium_e2000_memmap[map_idx].base;
+    int i;
+
+    s->gem[index] = gem;
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+
+    qemu_configure_nic_device(dev, true, name);
+    qdev_prop_set_uint8(dev, "phy-addr", 0);
+    qdev_prop_set_uint8(dev, "num-priority-queues",
+                        phytium_e2000_gem_num_queues[index]);
+    qdev_prop_set_uint16(dev, "jumbo-max-len", 16360);
+    qdev_prop_set_bit(dev, "pcs-enabled", true);
+
+    /*
+     * The E2000 exposes a 0x2000-byte aperture, while the generic Cadence
+     * model implements the first 0x800 bytes. Catch accesses to the remaining
+     * SoC-specific registers without inventing their clock and SerDes effects.
+     */
+    create_unimplemented_device(unimp_name, base,
+                                phytium_e2000_memmap[map_idx].size);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map(sbd, 0, base);
+    for (i = 0; i < phytium_e2000_gem_num_queues[index]; i++) {
+        sysbus_connect_irq(sbd, i,
+            qdev_get_gpio_in(s->gic, phytium_e2000_gem_irqmap[index][i]));
+    }
+}
+
 /* The vendor DT maps root-bus INTx solely by pin */
 static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
 {
@@ -511,6 +570,9 @@ static void phytium_pi_init(MachineState *ms)
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
+    for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
+        phytium_e2000_create_gem(s, i);
+    }
 
     phytium_e2000_create_pcie(s);
 
-- 
2.53.0


