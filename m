Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967B2CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnix-0005RL-CX; Tue, 13 Oct 2026 21:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGniv-0005R6-Ef; Tue, 13 Oct 2026 21:24:05 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnis-0006ql-UM; Tue, 13 Oct 2026 21:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOQJJ9jZL8Y2AjPWZuluHgd6HJ9mn9gDCORaTOqhGuZImVojrN687qRZpFB+L8HiO/Hots4+8N3rFncfVzEGIkW1fmxn38qd2ylaBhbMUmv8yObzT5fxMQVUg5+Qtsubl+X3NzxUwpKsPoSH82RWpo/oicrOCmvLvUzT1TleJDZH9ilHxXf4EYmdynw3zVnV8IO9bjHjABRliaRLI4kXt12ZvSQLZyLT/6yurvEB2Zj3OmqJ+XW5n9QSMFacJ/gl7yCu9w2+8htaKjAKulQpKfKtzl+ru4sC3F2gB59H4oZicF6s6TPP1vLrVArkcM5bQ48Up7mTORcC/asbSBPNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZcf0Vx30rYLIbNhznbrNOSJq8qXI8aJpgHs2i5GndU=;
 b=E1YhFI3QVk8ziRtAajd3X6zhAwZHNBEH/Guc0IHo8DnhbmdB2B7lt0eAbJa99mQe5KlZ/qdaj0ICo7OofZ17nZmGwnqCpN54BYe84rfDr190Wtvk3W8ccJrhDGF4mCwKIBuAp9qZ7cGUBEVUpZAKzY1qNIfKPZUkMJw3e6zjDSLBe0eBAJHtpw7ymlOPNxp6AVHwsyvJYsOZ20y1QkRLNvY2CbvenMDLSnW129AfZk26lnZX4I5psQHAXziCXjvUy7hjE39oJA8jrgkzmrjAZPO/FyDORHvpDJwUnO6Q8/MT85rzzhvERI144ZepFwH/zLL5Ih6MUCYFxZ47ecriHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZcf0Vx30rYLIbNhznbrNOSJq8qXI8aJpgHs2i5GndU=;
 b=IzflXX8J5pSI1P2ssOz3OUo7LC+b2bI6j+ZJnCGwz/FWs8i5Indkwmm0TeItBP5FXotKx/NiADf3EHYya7anzYiXXCHRhiZtJ5RX+Yr9WJmnV+EZPDIrIM5sRZsjItK6yzmmWY6XrLqlHqSox11BiYvhO2dadL1i+8+AMzqLJ4Ohu26oBWZ8zO7Z0ewGqTAyXuRL5/ljdTw8Q2p4Y+JoyWihe7O5S4OjcgUIracXYDR0RY+zED609jg9KaUqe/dV0y0A1zCLKZJaS/u62x+kv3yVgTjBLYcy77FwAsBrjlkR5wK42yxANp9Kuurxkp9gOAMfYZaYPmyHhtKHxfGEBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:23:53 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:23:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v4 03/27] hw/misc: pfsoc: Support DDR training with newer HSS
Date: Wed, 14 Oct 2026 09:22:43 +0800
Message-ID: <20261014012323.322790-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b632356-bf59-4e70-1c8d-08df2991cf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: r84pV/aJx3QF/6QYXWx34KYfHm/TB6PC/D36eWEikw2wuwSFadNrX8Qie598+LtzoRQeAJGNphUDldA2fnI4RwmlGAbO0HQPBD+lELAUinwVzwFzxXGTceyI3HF2YmDGVW/pob0G9ACnWbpIHZfyjSMQbvgZg5349Kg8gnDtWS4K3cs3S5C6vUU49MkX/CL8gWe/2DLvOvvz/S9DS1OpOzwzQ2pKAdVQyLi8MA14BriXpLVhjRRj4zZY12b+sQS6+SFecU+TIcIEEKwdUiOPgv92SjQj0V4rNCWmIcmN7qsHFwJrx+QB5zFdetikwK4V1jfnIgr8PWgt9Wl6szveVK7ZY37KlRcAdLVOmLaB2oAHowBOLG6czq9TGQEbOw7McHpcNuB7e2fgkuFX8KXOcYwPBT8oNPNi8tQsGRdskSpmEzcR652lt2pESx/A6HS1sEfKV+mfcUaawvB0X1n6ir+EpCxuC8ubdhRnN8rQWdeLzURaarxu8HHaaEhf/kh8iZmwLH+oj4DsSVdXPz2Ro3mgN3cb3XyjJDAk5fMVNeoHYQ8fW4iApVO3teDfcTRapgzONGvSsYExd83QSqYLIM7fovJHvw0x9lpCmTHE80y1nUk/o/jxVEwI+C0PitW0TT/ofUT4wg5z8UYJU1fKg1yODnZDeDIUPEckKKJNLOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MBZ4LGD6QoAMtcHbHmJM4bzPU+C6kvmQgygd0uYLmmuxbyUj9altqP6aCl5?=
 =?us-ascii?Q?4Xl4YbXypU46s09/kdlqqEI35Pt5OLvAzll8n8l7MF+SZmRoI5wIEZk5v+lw?=
 =?us-ascii?Q?zg/7kJRDwLiLWYZ/OO+7aaR4tR2WNDFCEOUAMigW99PJVg2S/5vvRE+bx7dn?=
 =?us-ascii?Q?vCPwrazIheuOspdUQ+2XPQWC4EqXqU7uw3TVOtWOspsvMT6gXn/rPrZ9O4fR?=
 =?us-ascii?Q?+2/cOuxEFXaLJ+voirIFDOmDUA7z7CXCxQtDs5SMImFuItsHJON1Sy8JyAeu?=
 =?us-ascii?Q?E9iKgb/3RFpDSPX7GcQ26X9WLpmruEcfsWo5KSI7qn4T1GASjCEMaCWbIlAn?=
 =?us-ascii?Q?70619N8vutqgosc6dp3DFzvWZo0OK16bN5zq4bPTvDMS1TvjS+fSnYeaGNoG?=
 =?us-ascii?Q?eac2UXU0pO4xvgfhh8wCgsriKdYVYbuhNYoH0448lenLDVdbO1N6dnPqIJ3w?=
 =?us-ascii?Q?DipXLdMhDgK17iPSAAO/n1ce4sO1RmlMWkgkKQxh8MOrsFxWbapaLYaPmD8N?=
 =?us-ascii?Q?WAMP3BnTU9WHH7IYgztLX6tgJ35i/H+rmA3BLkeGWoeOpC22UomWt1NqRB28?=
 =?us-ascii?Q?23thqGSpH+dK1yUu4bQ7/7oYKtoWSXIDLHB1LLFUPwAC/Bv2vlMy6iTe8adb?=
 =?us-ascii?Q?5Y2o4jpfgoSll5d8uuY1Pa0dssIO/tIk1WX7g3nnqA9U6iyuXdTXQiSbF9+W?=
 =?us-ascii?Q?utK1iqNJsuTcbccdxbNrgYysBZUT+TUShlioi7WpgSQdaoBs+le9Ear6dM+Y?=
 =?us-ascii?Q?/Dy7E8hrm/It5aAsPoC8PVvhqpoS8o0R1Sa0sDfX8TJcZ+FC4VaHNA+jrSNu?=
 =?us-ascii?Q?qGaTw6IFjHlSFZst5eDcHMf9pNzxvTGBFwGewZXepWfl3vE+IzpoO2F+9kpE?=
 =?us-ascii?Q?Vic0tfKmOHtkn2vr7RLXF3KZ80Su5M0pbOnuPKjpzS+WlYF8OohanJBx+VHF?=
 =?us-ascii?Q?rjcrzHB0IejHbS4CO/oRo3qNtNk+I8rHj7qk7CGr4JcASp0mmiUOkD2k+wwL?=
 =?us-ascii?Q?vVYbun+eSnVsfYPL1p+zWvgrFsv4xGmihgayZVYY/7Xfu8QdmlOk8P8M8lzL?=
 =?us-ascii?Q?OolD1Zcbgv3OQsIy6f2ACA0RLi8fhVtW/jcJTVuh5O+rpG9nVtGwfZS3Rcmx?=
 =?us-ascii?Q?Zic2ydKsXb/wjvPTjtVqzol9MV1k5I6zdjx996Uj3dms6WXJhnHMFurnzUT3?=
 =?us-ascii?Q?EM3K2RCDiX7MzQdbcEcR2hLDrnLOQnoInSeIZtE2w/I+c2fZWJEi3IMA/ETh?=
 =?us-ascii?Q?kgSPvcdvsSOPIO8XGAkEeHOeQM2U2+5XN/SJNdqIC0pWAus1bAyX7jOJCNxM?=
 =?us-ascii?Q?R2eUrqhqNmDVUAvzb4cP+yB9XEV+l2VNz3yqGwSZDxIKzwG4KngqsJTKYf/9?=
 =?us-ascii?Q?f9sY91Xe1AJC9BVKBEXtPPJABlneq6+4TFBk96W8PYtQVY2IUP0CA2e0r9e+?=
 =?us-ascii?Q?p0CtDfYQmOvMBXLAe80RIIM0UNeKX6HXA+WBGYnJYScBZcQlDI/c5t7o+Nos?=
 =?us-ascii?Q?SGJEbGxmF5g3vP54AAZtceT3EZUIcDn+q0FRBGKn67rimUlpm1y4NYpQffDJ?=
 =?us-ascii?Q?OP7CcA1J/+EgCw/cIiN+k9FvIzL5Gy9bhIh/xQUg26RkBEewo3yMwVkzHQnH?=
 =?us-ascii?Q?AZoelfSWThEMyAFZpAcnSFGaeZ/1sNMZv3V9sj0Zu2gHEAGLhs7+9khMobd+?=
 =?us-ascii?Q?PHjrOvESHT/Cw8SGJ9qsXz4qDnpttMTIKzp/Xo49mhWshu6nQkBj5Orij37w?=
 =?us-ascii?Q?X7qYSrs9C3gW/0qiFE+2RWQ+n9dypaU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b632356-bf59-4e70-1c8d-08df2991cf40
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:23:53.6396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylCMJOAl7FAnKLB3SDSBU0EckAQnG58gNUvmls41JVKAInZPTQwA82VIpdjB4YK1jqZebf1gj6APtCP+Rz9Vc5aBT1uybJa8db5ePxB3Wiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

HSS v2024.06 performs DDR and SGMII initialization through the DMC
register window before it can complete platform startup. The existing
model, which was validated against older version HSS in the early days,
exposes only a few fixed training results, so newer version HSS stalls
while waiting for PVT, PLL, DLL, ADDCMD, and verification status.

Update the DMC model by adding the minimum state and status behavior
needed by that firmware flow. Model the SGMII control registers,
main DDR PLL lock, deterministic ADDCMD transitions, and successful
gate and DQ/DQS verification. Keep training progress and writable
controls per device and clear them on reset.

These values are compatibility responses for HSS v2024.06 rather than
a cycle-accurate description of the DDR PHY. Document that limitation
in the source.

While we are here, update the license text to use the SPDX format.

Note at the time being there is an HSS bug [1] that consistenly blocks
the DDR traning from succeed when using an HSS image built from certain
version compiler like GCC 8.3.0. A patch [2] was proposed and verified
against HSS v2024.06.

[1] https://github.com/polarfire-soc/platform/issues/36
[2] https://github.com/processmission/qemu-machine-images/blob/main/
    machine/riscv64/microchip-icicle-kit/
    0001-mpfs_hal-preserve-DDR-pattern-test-parameters.patch

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

Changes in v2:
- Use the Resettable API instead of a legacy reset handler

 include/hw/misc/mchp_pfsoc_dmc.h |   6 +
 hw/misc/mchp_pfsoc_dmc.c         | 273 ++++++++++++++++++++++++++++---
 2 files changed, 255 insertions(+), 24 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_dmc.h b/include/hw/misc/mchp_pfsoc_dmc.h
index 2ed582fb8c..6a1986c2c2 100644
--- a/include/hw/misc/mchp_pfsoc_dmc.h
+++ b/include/hw/misc/mchp_pfsoc_dmc.h
@@ -28,10 +28,16 @@
 /* DDR SGMII PHY module */
 
 #define MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE   0x1000
+#define MCHP_PFSOC_DDR_SGMII_PHY_REG_NUM \
+    (MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE / sizeof(uint32_t))
 
 typedef struct MchpPfSoCDdrSgmiiPhyState {
     SysBusDevice parent;
     MemoryRegion sgmii_phy;
+    uint32_t regs[MCHP_PFSOC_DDR_SGMII_PHY_REG_NUM];
+    uint8_t training_status_bit;
+    uint8_t addcmd_tap;
+    bool addcmd_move_active;
 } MchpPfSoCDdrSgmiiPhyState;
 
 #define TYPE_MCHP_PFSOC_DDR_SGMII_PHY "mchp.pfsoc.ddr_sgmii_phy"
diff --git a/hw/misc/mchp_pfsoc_dmc.c b/hw/misc/mchp_pfsoc_dmc.c
index 1fe4535464..96440dac62 100644
--- a/hw/misc/mchp_pfsoc_dmc.c
+++ b/hw/misc/mchp_pfsoc_dmc.c
@@ -2,22 +2,20 @@
  * Microchip PolarFire SoC DDR Memory Controller module emulation
  *
  * Copyright (c) 2020 Wind River Systems, Inc.
+ * Copyright (c) 2026 Process Mission
  *
  * Author:
  *   Bin Meng <bin.meng@windriver.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
+ * Updated by Bin Meng <bin.meng@processmission.com> to support DDR
+ * training emulation for with newer version Hart Software Services,
+ * aka HSS.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * The DMC register model is based on HSS v2024.06. Its read/write
+ * behavior is the minimum needed for DDR training to complete and
+ * may not reflect actual hardware register behavior.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -29,17 +27,56 @@
 
 /* DDR SGMII PHY module */
 
-#define SGMII_PHY_IOC_REG1              0x208
-#define SGMII_PHY_TRAINING_STATUS       0x814
-#define SGMII_PHY_DQ_DQS_ERR_DONE       0x834
-#define SGMII_PHY_DQDQS_STATUS1         0x84c
-#define SGMII_PHY_PVT_STAT              0xc20
+#define PHY_ADDCMD_CK_TRANSITION_TAP              12
+#define PHY_ADDCMD_A5_TRANSITION_TAP              20
+#define PHY_ADDCMD_CK_READBACK                    5
+#define PHY_ADDCMD_A5_READBACK                    (3 << 8)
+#define PHY_GT_TXDLY_VALUE                        0x01010101
+#define PHY_DQDQS_STATUS2_VALUE                   5
+
+#define SGMII_PHY_PLL_CTRL_MAIN                   0x084
+#define SGMII_PHY_PLL_CTRL_MAIN_CONTROL_LO_MASK   0x0000007f
+#define SGMII_PHY_PLL_CTRL_MAIN_LP_REQUIRES_LOCK  BIT(24)
+#define SGMII_PHY_PLL_CTRL_MAIN_LOCK              BIT(25)
+#define SGMII_PHY_IOC_REG1                        0x208
+#define SGMII_PHY_TRAINING_STATUS                 0x814
+#define SGMII_PHY_GT_ERR_COMB                     0x81c
+#define SGMII_PHY_GT_CLK_SEL                      0x820
+#define SGMII_PHY_GT_TXDLY                        0x824
+#define SGMII_PHY_DQ_DQS_ERR_DONE                 0x834
+#define SGMII_PHY_DQDQS_STATUS1                   0x84c
+#define SGMII_PHY_DQDQS_STATUS2                   0x850
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1         0x880
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_CONTROL_MASK 0x001fffff
+#define SGMII_PHY_EXPERT_DLYCNT_MOVE_ADDCMD_MASK  0x00180000
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1         0x890
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_CONTROL_MASK 0x001fffff
+#define SGMII_PHY_EXPERT_DLYCNT_LOAD_ADDCMD_MASK  0x00180000
+#define SGMII_PHY_EXPERT_ADDCMD_LN_READBACK       0x8ac
+#define SGMII_PHY_SOFT_RESET_SGMII                0xc00
+#define SGMII_PHY_SGMII_MODE                      0xc04
+#define SGMII_PHY_PLL_CNTL                        0xc08
+#define SGMII_PHY_PLL_CNTL_LOCK                   BIT(7)
+#define SGMII_PHY_CH0_CNTL                        0xc0c
+#define SGMII_PHY_CH1_CNTL                        0xc10
+#define SGMII_PHY_RECAL_CNTL                      0xc14
+#define SGMII_PHY_RECAL_CNTL_STATUS_MASK          0xffff0000
+#define SGMII_PHY_RECAL_CNTL_LOCK                 BIT(23)
+#define SGMII_PHY_CLK_CNTL                        0xc18
+#define SGMII_PHY_DYN_CNTL                        0xc1c
+#define SGMII_PHY_PVT_STAT                        0xc20
+#define SGMII_PHY_PVT_STAT_IO_ENABLE              BIT(6)
+#define SGMII_PHY_PVT_STAT_CALIBRATED             BIT(14)
+#define SGMII_PHY_PVT_STAT_GUEST_CTRL_MASK        0xc0000000
+#define SGMII_PHY_SPARE_CNTL                      0xc24
+#define SGMII_PHY_SPARE_STAT                      0xc28
 
 static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     uint32_t val = 0;
-    static int training_status_bit;
+    MchpPfSoCDdrSgmiiPhyState *s = opaque;
+    uint32_t index = offset / sizeof(uint32_t);
 
     switch (offset) {
     case SGMII_PHY_IOC_REG1:
@@ -53,8 +90,8 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
          *
          * See ddr_setup() in mss_ddr.c in the HSS source codes.
          */
-        val = 1 << training_status_bit;
-        training_status_bit = (training_status_bit + 1) % 5;
+        val = BIT(s->training_status_bit);
+        s->training_status_bit = (s->training_status_bit + 1) % 5;
         break;
     case SGMII_PHY_DQ_DQS_ERR_DONE:
         /*
@@ -71,8 +108,106 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
         val = 0xff;
         break;
     case SGMII_PHY_PVT_STAT:
-        /* See sgmii_channel_setup() in HSS */
-        val = BIT(14) | BIT(6);
+        /*
+         * HSS polls IO enable and calibration status, then writes the
+         * calibration lock. The HSS register definitions mark bits 31:30
+         * as writable controls.
+         *
+         * See sgmii_channel_setup() in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PVT_STAT_IO_ENABLE |
+              SGMII_PHY_PVT_STAT_CALIBRATED;
+        break;
+    case SGMII_PHY_PLL_CTRL_MAIN:
+        /*
+         * HSS programs the main DDR PLL controls and polls LOCK after
+         * changing the PLL dividers during LPDDR4 manual training. The
+         * HSS register definitions mark bits 6:0 and 24 as writable.
+         *
+         * See ddr_pll_config() in mss_pll.c and
+         * lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PLL_CTRL_MAIN_LOCK;
+        break;
+    case SGMII_PHY_PLL_CNTL:
+        /*
+         * HSS programs the SGMII PLL controls and polls aro_pll0_lock.
+         *
+         * See setup_sgmii_rpc_per_config() and sgmii_channel_setup()
+         * in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_PLL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_RECAL_CNTL:
+        /*
+         * HSS programs the low control half, polls sro_dll_lock, and
+         * reads sro_dll_90_code from the read-only status half.
+         *
+         * See setup_sgmii_rpc_per_config() and sgmii_channel_setup()
+         * in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index] | SGMII_PHY_RECAL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_EXPERT_ADDCMD_LN_READBACK:
+        /*
+         * HSS pulses the ADDCMD move controls while sampling CK from
+         * bits 3:0 and A5 from bits 9:8. The transition tap positions
+         * below are deterministic QEMU model choices.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        if (s->addcmd_tap >= PHY_ADDCMD_CK_TRANSITION_TAP) {
+            val |= PHY_ADDCMD_CK_READBACK;
+        }
+        if (s->addcmd_tap >= PHY_ADDCMD_A5_TRANSITION_TAP) {
+            val |= PHY_ADDCMD_A5_READBACK;
+        }
+        break;
+    case SGMII_PHY_GT_ERR_COMB:
+    case SGMII_PHY_GT_CLK_SEL:
+        /*
+         * HSS fails DDR verification on any gate error, a zero delay
+         * selected by gt_clk_sel, or more than one zero delay byte.
+         * Model no gate errors; the all-nonzero delay below makes the
+         * deterministic clock selection immaterial.
+         *
+         * See DDR_TRAINING_IP_SM_VERIFY in ddr_setup() in mss_ddr.c
+         * in HSS.
+         */
+        val = 0;
+        break;
+    case SGMII_PHY_GT_TXDLY:
+        val = PHY_GT_TXDLY_VALUE;
+        break;
+    case SGMII_PHY_DQDQS_STATUS2:
+        /*
+         * HSS requires the calculated DQ/DQS window to be at least
+         * DQ_DQS_NUM_TAPS, which is 5. Return the minimum pass value.
+         *
+         * See DDR_TRAINING_IP_SM_VERIFY in ddr_setup() and the
+         * DQ_DQS_NUM_TAPS definition in mss_ddr.h in HSS.
+         */
+        val = PHY_DQDQS_STATUS2_VALUE;
+        break;
+    case SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1:
+    case SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1:
+    case SGMII_PHY_SOFT_RESET_SGMII:
+    case SGMII_PHY_SGMII_MODE:
+    case SGMII_PHY_CH0_CNTL:
+    case SGMII_PHY_CH1_CNTL:
+    case SGMII_PHY_CLK_CNTL:
+    case SGMII_PHY_DYN_CNTL:
+    case SGMII_PHY_SPARE_CNTL:
+    case SGMII_PHY_SPARE_STAT:
+        /*
+         * HSS programs the ADDCMD and SGMII controls and reads
+         * SPARE_STAT to classify the silicon and select eye-width
+         * thresholds.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c and the SGMII setup
+         * functions in mss_sgmii.c in HSS.
+         */
+        val = s->regs[index];
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
@@ -87,10 +222,88 @@ static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
 static void mchp_pfsoc_ddr_sgmii_phy_write(void *opaque, hwaddr offset,
                                            uint64_t value, unsigned size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, value 0x%" PRIx64
-                  ", offset 0x%" HWADDR_PRIx ")\n",
-                  __func__, size, value, offset);
+    MchpPfSoCDdrSgmiiPhyState *s = opaque;
+    uint32_t index = offset / sizeof(uint32_t);
+
+    switch (offset) {
+    case SGMII_PHY_IOC_REG1:
+    case SGMII_PHY_TRAINING_STATUS:
+    case SGMII_PHY_GT_ERR_COMB:
+    case SGMII_PHY_GT_CLK_SEL:
+    case SGMII_PHY_GT_TXDLY:
+    case SGMII_PHY_DQ_DQS_ERR_DONE:
+    case SGMII_PHY_DQDQS_STATUS1:
+    case SGMII_PHY_DQDQS_STATUS2:
+    case SGMII_PHY_EXPERT_ADDCMD_LN_READBACK:
+    case SGMII_PHY_SPARE_STAT:
+        /*
+         * The HSS register definitions declare these status and
+         * readback registers read-only.
+         *
+         * See mss_ddr_sgmii_phy_defs.h in HSS.
+         */
+        return;
+    case SGMII_PHY_PLL_CTRL_MAIN:
+        value &= SGMII_PHY_PLL_CTRL_MAIN_CONTROL_LO_MASK |
+                 SGMII_PHY_PLL_CTRL_MAIN_LP_REQUIRES_LOCK;
+        break;
+    case SGMII_PHY_PLL_CNTL:
+        value &= ~SGMII_PHY_PLL_CNTL_LOCK;
+        break;
+    case SGMII_PHY_RECAL_CNTL:
+        value &= ~SGMII_PHY_RECAL_CNTL_STATUS_MASK;
+        break;
+    case SGMII_PHY_PVT_STAT:
+        value &= SGMII_PHY_PVT_STAT_GUEST_CTRL_MASK;
+        break;
+    case SGMII_PHY_EXPERT_DLYCNT_MOVE_REG1: {
+        bool active;
+
+        /*
+         * HSS pulses 0 -> 0x180000 -> 0 while scanning the ADDCMD eye.
+         * Count each rising pulse as one abstract delay tap.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        value &= SGMII_PHY_EXPERT_DLYCNT_MOVE_CONTROL_MASK;
+        active = value & SGMII_PHY_EXPERT_DLYCNT_MOVE_ADDCMD_MASK;
+        if (active && !s->addcmd_move_active &&
+            s->addcmd_tap != UINT8_MAX) {
+            s->addcmd_tap++;
+        }
+        s->addcmd_move_active = active;
+        break;
+    }
+    case SGMII_PHY_EXPERT_DLYCNT_LOAD_REG1:
+        /*
+         * HSS pulses 0x180000 before each ADDCMD scan. Restart the
+         * abstract QEMU tap position when that load pulse is asserted.
+         *
+         * See lpddr4_manual_training() in mss_ddr.c in HSS.
+         */
+        value &= SGMII_PHY_EXPERT_DLYCNT_LOAD_CONTROL_MASK;
+        if (value & SGMII_PHY_EXPERT_DLYCNT_LOAD_ADDCMD_MASK) {
+            s->addcmd_tap = 0;
+            s->addcmd_move_active = false;
+        }
+        break;
+    case SGMII_PHY_SOFT_RESET_SGMII:
+    case SGMII_PHY_SGMII_MODE:
+    case SGMII_PHY_CH0_CNTL:
+    case SGMII_PHY_CH1_CNTL:
+    case SGMII_PHY_CLK_CNTL:
+    case SGMII_PHY_DYN_CNTL:
+    case SGMII_PHY_SPARE_CNTL:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                      "(size %d, value 0x%" PRIx64
+                      ", offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, value, offset);
+        return;
+    }
+
+    s->regs[index] = value;
 }
 
 static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
@@ -99,6 +312,16 @@ static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void mchp_pfsoc_ddr_sgmii_phy_reset_hold(Object *obj, ResetType type)
+{
+    MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->training_status_bit = 0;
+    s->addcmd_tap = 0;
+    s->addcmd_move_active = false;
+}
+
 static void mchp_pfsoc_ddr_sgmii_phy_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(dev);
@@ -114,9 +337,11 @@ static void mchp_pfsoc_ddr_sgmii_phy_class_init(ObjectClass *klass,
                                                 const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "Microchip PolarFire SoC DDR SGMII PHY module";
     dc->realize = mchp_pfsoc_ddr_sgmii_phy_realize;
+    rc->phases.hold = mchp_pfsoc_ddr_sgmii_phy_reset_hold;
 }
 
 static const TypeInfo mchp_pfsoc_ddr_sgmii_phy_info = {
-- 
2.53.0


