Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDAFCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXS-0001C6-VA; Fri, 22 Aug 2025 11:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWq-0008Kf-Ir; Fri, 22 Aug 2025 11:18:09 -0400
Received: from mail-co1nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWN-0007E0-Iu; Fri, 22 Aug 2025 11:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVAjIqOlNRUjnP2TSSm5d9VlBcyZuZzl7UX5EI7m63PDYSKua+csRXUp++NP9rciJTrBJlzWagdBWXj2I3OGg2dY/vK7qLA+zQXkQH9y/dT3g1OlZ/weKZ696KCasbdSKandUp9KILuL815/R9Tz1z8Eysq0os4PF5ZbPWj+Ve58P8EE0ZC5/ifwpu/+Ue7setItiNNzppewcvk8rNBIBgEtphIBYUBbKg7jDmvO4wraEzZUW/MDlGrYJIblCvOYD6GM/BvHMwp63A8wwdjMsc52V08e52V+xUar2tW39PawEFHIyIF1hRiQsSRPHOoxXTINc+huASKSp7KwKtYWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhURXWJrmzS4o6rjkeYbUxI08a1CVOmSBNr7j+KMV2U=;
 b=DtQT1Cgymq26VtgV/iOTZF4UNFYC/HWLVXUpP9HLuMz5ofy51RYA0wf12Kt7XmrRDeNsCwzaiH3YttZWsXAWEmtcKvdNrr3AI1Rz7mwBP3tKOHDbfdlvbSwFJvw44MNLwrRhBgCNi4NcYy6/Pi3JGZ2IYtakAGopSS+LaRZ2hBZJATGtOzXkLXEv9ueYlklKKHUl9jEOkKbU5KVgsou8AFJLyXS3Si2rBe6ZeQutGo4xffuuCnhdDGWsgJFPe+S4Eu7w2xZ/zfaHU26awowSpU3wgqFxnQKsa1FFA2gxHQTUyhRXe+SxY8N4aS2nUnX3lTFHtOn0iqu27sqHrRhitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhURXWJrmzS4o6rjkeYbUxI08a1CVOmSBNr7j+KMV2U=;
 b=D88aX6KPUE/pTpQMI2VhYT0evg2hNkAqKTptOF2BMiUfqPf/kV6kp5Xvp69+4/4v7MO1n9o1+Fq/TLxACRs0tSPL/J1zYt/cIeBAvHjB50lsXsF+jhSVGr+aHis5ZD1CWvIYznP8nopHuUz/XAPaOhtAlqpeoc8CdnjWXrP6MXQ=
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 15:17:27 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::3a) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:26 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:24 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 31/47] hw/misc/xlnx-versal-crl: split into base/concrete
 classes
Date: Fri, 22 Aug 2025 17:15:56 +0200
Message-ID: <20250822151614.187856-32-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e30710-56aa-4416-e27b-08dde18f0141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ave+hagd7CmbncxumSjV6wzT1wbE3tGXDp0IAyzTXgh3YrG3BXn1keJ6b7JK?=
 =?us-ascii?Q?pIHs2luQmTmqQKrca/cXKrUxeyyW+LoEzWqATePBFVfWNG06OhGZ/r1VPmSH?=
 =?us-ascii?Q?0YrKvd5GdUCVbK+y7O3fp4JCWQtIJ7OrMvHnd9ni8kVkGRS5LNrsL0InduDB?=
 =?us-ascii?Q?mZle0E+tEyvC/rXaQF5Uwffjr8y94YdrK34L9beDqTMcG1YsodXT/SUSPHXe?=
 =?us-ascii?Q?1NLxpxVesNa25ipZAjPCIKd73fHawfmVEJteKUf08UAW1lQsCzCI37uk1dbl?=
 =?us-ascii?Q?CT0EnivPECDBqorG3PNtr5EzXSD++XOqji78l32KdlAxO4DbczxOLKoEr+Nu?=
 =?us-ascii?Q?qjL/LZEo0HPCf2TBz36cDSUp0WWaQNfVuontaW0xVclj3MGnTlBJqf4tshCn?=
 =?us-ascii?Q?aqWpze49to943vT1hwlRnIDgkGZ6mgJ2bE0JlwycQEvSPwqDPgMTcd8k8dDB?=
 =?us-ascii?Q?94fBUwPEUTZpL9LTp/sDGgiPn+EXqLoG/iSJVP+9VMwIwuIL82W8lFL+GnCf?=
 =?us-ascii?Q?bOaA33W/52Lu3lrTj4MJU/PPk72sTwBCBe4SaVCn0NIWTsUP/b7urmvNcj+z?=
 =?us-ascii?Q?MKdqxEKTPsVmX0AoDdMMypYPLF0sYpx/i9pBEkzFEXYJPSPSkDDLPOue6XTj?=
 =?us-ascii?Q?BALlUw1d0OYPclSUS0XBhvxGzJzZAiKrEGbMbW4i5WSBMgEAJztu1I2u5ufP?=
 =?us-ascii?Q?b6hIyRK8iVRZLkhkl+p+HwA3GHAOm9Xnz5jq03ndJOyERsHS+khJahshs4Ee?=
 =?us-ascii?Q?3CqC0iJwQrbQ3mX4GDxHdOJQVPONrBUxydQHEfOFNg93Xz5CClhB8RDQB2oA?=
 =?us-ascii?Q?WJfCAQHWDJpQrh8Z0tEnbuGCHBidmgoULNHK0mTp1adzWvrH/OU4uyUdP1fE?=
 =?us-ascii?Q?TO3O+9lxkdsJyB8FAUxjZzia9hQtZyNqxNa5fR+UaCpYpA/k9tytnBcDwPlL?=
 =?us-ascii?Q?tC2v0u1iQyMFh60buRPeU8sRiy69rl4r0LbcvfJY9pd3ODfvQGlSqFFd2/ma?=
 =?us-ascii?Q?Yvca9FekyXg4xkSpL0E6+ELctI9WHrz+Ne3E5A+7IcSZzm0dxN1LfUpjdMyf?=
 =?us-ascii?Q?9wIHal7cOW5bKbAN6KQ0VWNDRM+bEgzEBuUxSjGEzrxE0pOh5Q6GahPv45oF?=
 =?us-ascii?Q?+31Uh676gpIxuVLF7jouhH5bidipSLyXA9j+LO5IlB/EKSniyOVG3cUIlbWU?=
 =?us-ascii?Q?v6EUaJggIbdyyUt0og/GnpJIyhYLySe9mYPfDCTv4LaQXHoZejrXaBkhwaug?=
 =?us-ascii?Q?Rucy9sAGSvxmJsdTww7K0Efa3dS4y7VS5d9k0y7PzUAycKYuXEaJBcu5Tg2M?=
 =?us-ascii?Q?So0oW4EoBsoNCGtbwUA947Cili5/PkyFUFwRXF478+J7qJ+2mICMRpzSVox3?=
 =?us-ascii?Q?tRYyijPfmLmV3yK+QT1w3Ad5qDReyS94IBu+cHMAvisRvpcUHSZrOAP2LJmV?=
 =?us-ascii?Q?nFZ7CdAVS8feXXZjPgV5cyHFdt3kxzFrPkhI5fHp5XuuzNq5Mx/+1nzI0cgv?=
 =?us-ascii?Q?EcmMF0dakNC1rZjKjx9wC8EPF3+wSmQf9GBz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:27.3349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e30710-56aa-4416-e27b-08dde18f0141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
Received-SPF: permerror client-ip=2a01:111:f403:2416::61e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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


