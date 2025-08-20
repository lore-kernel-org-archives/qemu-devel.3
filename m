Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB6ACA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAW-00075s-M3; Wed, 20 Aug 2025 04:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAR-0006r3-PV; Wed, 20 Aug 2025 04:27:36 -0400
Received: from mail-dm6nam12on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2417::611]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAK-00015e-2A; Wed, 20 Aug 2025 04:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp+R/7jN9uIMe+UB/lxNFR1Ib7U+r3t6Gab64two64F0PV4SKvUFrojHks5+nBdfNoFM4rQYuqdxiDHBst4QmmoqCyTHDn2lFTwu7WlyWrEE/thYZjySo5DiUWf5AtfkSw9VpAIzg0onVKpjOXQ1hmsPZcPgHpnAVAIpjImiBA061eHUuNDlMh/ECMOTF+O7mm6ZSoUPbi5v0ZFWXrPChkvKm+VCmumc8SkI4pgqNuizi5E7Ds9pN7TcaIra6THTW9c/bMPiSam3S1I0c421bMpU4AOG/wiz9Vq9TQ7oAtp5tfqGL1pCel2QSe6FV3Erl4jgt8H14v5JHHzlx8/aAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhURXWJrmzS4o6rjkeYbUxI08a1CVOmSBNr7j+KMV2U=;
 b=aMfHMzDUaX/2QdejJpNwA+gr9qmJvVW/i18NHvHFXUNkBfz7nunBSLsQLj5p1c7xV/72nAYbgWO7MatXBeHXa+7t1DN9lb/D0oMZoxQrfE0ZcfxNZisGN6t23rtHx4MW5rhbUVj/y9Z9RcR0t8kSOoba348OEnRfPuK+z0OjDcFojiNjsUF+gZig8hrMyr2Qn/yCYp4jiivlbuP9V9uAeX6rjzT6Y8UZH6K5NztvqQnnmd8rIDphne0OfHvnZZ6uetAIaGez0cO0MExBxNM7HSifSIedcHteQGXBfdncgWrJl2fAc6vy53tLgpvW7FeXqeHEW7fKEhgVSoanLwQZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhURXWJrmzS4o6rjkeYbUxI08a1CVOmSBNr7j+KMV2U=;
 b=bsT+ESuA9EaAbuFweNLqgCi0LyGqK1qvTP8EfRObOaQPUOFE12r4McPhESYk5JOGVp/r/OaNQWBrX8wWGu4fYc1p+sLCPWvPEUMUKwXU116DuYAPU1u23SaT2xX94hHbENtRTmhRaCADbQni9BYVk4KqYbmCSNuUbiZVTHym4WU=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:27:16 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::47) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:08 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:07 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 31/47] hw/misc/xlnx-versal-crl: split into base/concrete
 classes
Date: Wed, 20 Aug 2025 10:25:30 +0200
Message-ID: <20250820082549.69724-32-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1623c32f-681a-469d-aa1a-08dddfc35f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gy5k9PufTNTdp9QIlKpncfQW5WHxTsbYoUFxARBy9pl9WVx9QUa5FxtXvEBG?=
 =?us-ascii?Q?5fyqfI86oCpcSMKM8FP3/5CkBG8+ZPS08K7CC9IrBeoalPWFbwmY3YA/XvQa?=
 =?us-ascii?Q?ZnXjMd67avvv+wv4la/JHzgeDczHzvDSzVfZDjTJpZr/uNGqRItyGUQo2UYQ?=
 =?us-ascii?Q?3AXRzBCBN9/tKEWx2qJnXh3aq9NA4ywIW4FgzeZM8Hhwb/pIVMC5vRZnZX1d?=
 =?us-ascii?Q?+6dVQ5EUDYOV5zrQXIMO+/JJw66Mf0PIT8yELuhrlwSWP6bqxp1nT1uJ+e11?=
 =?us-ascii?Q?UmAI+GDr3qJn+UyWBluErK/9Zi0uWCmvuBnVv43IqRe7Ixk6XLBTi9kzzA2s?=
 =?us-ascii?Q?mrBVDYhH/m8ofmthi06TUhP1vKBFT5/DrEqDtdu17LZ2jDSnZ8izjovm1w+t?=
 =?us-ascii?Q?U1iie9APklUn5lGyaMgXVBsg9S+IDXPjVkLStc4DkpgUKZ3QgKrTBtCFO3W1?=
 =?us-ascii?Q?J/ES5Zp15TESs1fGIbOvpsWSKFsQ4Hj3NFr5SLBEGeWGGR6FDZHA8jeVVjHo?=
 =?us-ascii?Q?3o6WoLMD0EreezODNmU1Te69gxsNqaQnrJLveZmOJxKkvtUhhuhpOOxiuqpD?=
 =?us-ascii?Q?AYTT4C8Z6QXvP4UjSDGfrGkitGtyYHRF7tAV52GE4ce7qcBYuQg4jpcgRHCf?=
 =?us-ascii?Q?rIfIo6/aWvjb8qXsCAeZ72MSLdPjd4ipaVMgt0KBrcOc2DFuLEDm5y0HGhTE?=
 =?us-ascii?Q?7uvx2c+RCrdYHVc24Yrm8BcOrMNfIGAgxNGjO3oLBorUJuggxV8+mfVvK4Hz?=
 =?us-ascii?Q?MIyuK/Q5MkiN8FzWYDzIIeaV3id2cdb1EwZxsjyYTJBdOzIMwRZVFS03jI/z?=
 =?us-ascii?Q?zuQ5G55k747Iz1//GGmaItS07jZDJFYV0LaLxj10c8L3rMp49FeuKXfGNgr9?=
 =?us-ascii?Q?JsfHrih56gS5f6fHIypG++KZsQSow8HWVluKMh0eqMKqRR+bcp0FwleuSORN?=
 =?us-ascii?Q?PHqC3Ek5bGcBEkUCg9X+pfpAbAI9B1wEWnx57G6r46U+KOKGCbM6dfwGTG7N?=
 =?us-ascii?Q?/ZqwfPFT0HFphklZdMvJYWrt1bKrvvKy0+cbFpXbw1zpP3M+WtYnzBrGhVEy?=
 =?us-ascii?Q?0aZgK7UeNqAzzTVQih65AccKcV4EYUOo6mWTrVrqRRn2rqJ4OS5HARyylGBr?=
 =?us-ascii?Q?wDvWPJrKXD6On4gj1w4+54TFnfcpTo59hK1joLzlJf9Kr9wBqt9vNIDuICeG?=
 =?us-ascii?Q?nxL95ZOlicqy3Ep5Ysle2MOylhxM3Tu6Jrq3ggIunPAGl/Z0ZPCgJac/5eMj?=
 =?us-ascii?Q?7kPD5GRV4lknGOewJQ7ZvIrOpAW15w3EBmQxNE4stzcJJ9Ue1C1lHut1CSZC?=
 =?us-ascii?Q?WmI6xzeeJKgaYwji9z5h2yTpjGVrOb+YNUqjxNcx3I9QLjRx44jXXq/jtFJ4?=
 =?us-ascii?Q?WrTAsaw5+7hm4OQ0ikODDb5yOvU1/IiLyFIwNu2eV1DQfZxfF2+NRhSCULpi?=
 =?us-ascii?Q?Ju+a2cn2eAuR4BLBTFb34x+Qzd28jIAGPT4910LrQy4ZQ7yYzoCAC9yvg+7f?=
 =?us-ascii?Q?tbeZNAgVnKfeg7On2JTMurMsVH8uGncWfGPK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:16.2325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1623c32f-681a-469d-aa1a-08dddfc35f1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
Received-SPF: permerror client-ip=2a01:111:f403:2417::611;
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

Split the TYPE_XLNX_VERSAL_CRL type into base and concrete classes. This
is in preparation for the versal2 version of the CRL.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/misc/xlnx-versal-crl.h | 31 ++++++++++++++++++--
 hw/misc/xlnx-versal-crl.c         | 48 +++++++++++++++++++------------
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index dba6d3585d1..2b39d203a67 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -1,21 +1,27 @@
 /*
  * QEMU model of the Clock-Reset-LPD (CRL).
  *
  * Copyright (c) 2022 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
  */
 #ifndef HW_MISC_XLNX_VERSAL_CRL_H
 #define HW_MISC_XLNX_VERSAL_CRL_H
 
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "target/arm/cpu-qom.h"
+#include "hw/arm/xlnx-versal-version.h"
 
+#define TYPE_XLNX_VERSAL_CRL_BASE "xlnx-versal-crl-base"
 #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
+
+OBJECT_DECLARE_TYPE(XlnxVersalCRLBase, XlnxVersalCRLBaseClass,
+                    XLNX_VERSAL_CRL_BASE)
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
 
 REG32(ERR_CTRL, 0x0)
     FIELD(ERR_CTRL, SLVERR_ENABLE, 0, 1)
 REG32(IR_STATUS, 0x4)
@@ -214,22 +220,43 @@ REG32(PSM_RST_MODE, 0x370)
 
 #define CRL_R_MAX (R_PSM_RST_MODE + 1)
 
 #define RPU_MAX_CPU 2
 
-struct XlnxVersalCRL {
+struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
+
+    RegisterInfoArray *reg_array;
+    uint32_t *regs;
+};
+
+struct XlnxVersalCRLBaseClass {
+    SysBusDeviceClass parent_class;
+};
+
+struct XlnxVersalCRL {
+    XlnxVersalCRLBase parent_obj;
     qemu_irq irq;
 
     struct {
         ARMCPU *cpu_r5[RPU_MAX_CPU];
         DeviceState *adma[8];
         DeviceState *uart[2];
         DeviceState *gem[2];
         DeviceState *usb;
     } cfg;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[CRL_R_MAX];
     RegisterInfo regs_info[CRL_R_MAX];
 };
+
+static inline const char *xlnx_versal_crl_class_name(VersalVersion ver)
+{
+    switch (ver) {
+    case VERSAL_VER_VERSAL:
+        return TYPE_XLNX_VERSAL_CRL;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #endif
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index f288545967a..be89e0da40d 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -296,21 +296,21 @@ static const RegisterAccessInfo crl_regs_info[] = {
         .reset = 0x1,
         .rsvd = 0xf8,
     }
 };
 
-static void crl_reset_enter(Object *obj, ResetType type)
+static void versal_crl_reset_enter(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
         register_reset(&s->regs_info[i]);
     }
 }
 
-static void crl_reset_hold(Object *obj, ResetType type)
+static void versal_crl_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
 
     crl_update_irq(s);
 }
@@ -323,24 +323,26 @@ static const MemoryRegionOps crl_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
 };
 
-static void crl_init(Object *obj)
+static void versal_crl_init(Object *obj)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
+    XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     int i;
 
-    s->reg_array =
+    xvcb->reg_array =
         register_init_block32(DEVICE(obj), crl_regs_info,
                               ARRAY_SIZE(crl_regs_info),
                               s->regs_info, s->regs,
                               &crl_ops,
                               XLNX_VERSAL_CRL_ERR_DEBUG,
                               CRL_R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    xvcb->regs = s->regs;
+    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
         object_property_add_link(obj, "cpu_r5[*]", TYPE_ARM_CPU,
                                  (Object **)&s->cfg.cpu_r5[i],
@@ -375,45 +377,53 @@ static void crl_init(Object *obj)
                              OBJ_PROP_LINK_STRONG);
 }
 
 static void crl_finalize(Object *obj)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
     register_finalize_block(s->reg_array);
 }
 
-static const VMStateDescription vmstate_crl = {
+static const VMStateDescription vmstate_versal_crl = {
     .name = TYPE_XLNX_VERSAL_CRL,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalCRL, CRL_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
 };
 
-static void crl_class_init(ObjectClass *klass, const void *data)
+static void versal_crl_class_init(ObjectClass *klass, const void *data)
 {
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->vmsd = &vmstate_crl;
-
-    rc->phases.enter = crl_reset_enter;
-    rc->phases.hold = crl_reset_hold;
+    dc->vmsd = &vmstate_versal_crl;
+    rc->phases.enter = versal_crl_reset_enter;
+    rc->phases.hold = versal_crl_reset_hold;
 }
 
-static const TypeInfo crl_info = {
-    .name          = TYPE_XLNX_VERSAL_CRL,
+static const TypeInfo crl_base_info = {
+    .name          = TYPE_XLNX_VERSAL_CRL_BASE,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(XlnxVersalCRL),
-    .class_init    = crl_class_init,
-    .instance_init = crl_init,
+    .instance_size = sizeof(XlnxVersalCRLBase),
+    .class_size    = sizeof(XlnxVersalCRLBaseClass),
     .instance_finalize = crl_finalize,
+    .abstract      = true,
+};
+
+static const TypeInfo versal_crl_info = {
+    .name          = TYPE_XLNX_VERSAL_CRL,
+    .parent        = TYPE_XLNX_VERSAL_CRL_BASE,
+    .instance_size = sizeof(XlnxVersalCRL),
+    .instance_init = versal_crl_init,
+    .class_init    = versal_crl_class_init,
 };
 
 static void crl_register_types(void)
 {
-    type_register_static(&crl_info);
+    type_register_static(&crl_base_info);
+    type_register_static(&versal_crl_info);
 }
 
 type_init(crl_register_types)
-- 
2.50.1


