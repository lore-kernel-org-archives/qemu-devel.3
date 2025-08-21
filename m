Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE86CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zO-0002sG-A8; Thu, 21 Aug 2025 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z5-0002DA-GB; Thu, 21 Aug 2025 09:05:39 -0400
Received: from mail-co1nam11on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2416::626]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yw-0003EJ-3i; Thu, 21 Aug 2025 09:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OK+8Gmlv5mu8tTS4ghBRV5nZaZNwjbfirrJ89Emg/SbQtSthL3mTgKZ+WqZ68Grvn02OQGIF9N3JhlNIh7HwjDCdwU0vOkRdiJt6azSk1Er8ZsHWZ4BiKEAw93mPHzlsro7yAibyL/DJ3TvLxIrocg/AySHf06AJ2uCsVCR8AKaA4cgwminx5w19Dxxy1CzazgravHyw1JXfRDVJaDDXC2u2oV+8UgdlFAKH2oT8gqGaQcsUziGpm25iFIIoBcbNkDOgk4L93plaX1BCW+Q3+0QJuFD5YQBGlTOgQzteTYHAko8OmT+3pJOSIBYAxW9ulKXylhb/t8nGLM33mOX1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhURXWJrmzS4o6rjkeYbUxI08a1CVOmSBNr7j+KMV2U=;
 b=RSJSRZyPhZqtUBXtMRyZVxbOYW19QrkUR/BHGsBCpaguCiJPzTnpb0ergPXCwbZrciWk3jw0994dsIa8i2qcknH6znrvrt0ouPmJ4OxwWeZQHoWnnLFgAqAYP3Fu0mGv1JCCmXZJYplZ7/UZlny+GuI6PW5+hgYVZHHnTWH2XIJRUm1HAeCjN6wLaYXu2xcqQQhzq6vv5oZFjBj68exspJavMrPlmckPO8ftM7/yJbulVEplutXdDbgVzsj8Xs4eyKAEJCfB9F86m8sc81N3XgXlN9PIR2LKlqJyxKsnGc8bsEtukxM/R3aZE802BpkIHupMvOpHpU4VNDh3ownVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhURXWJrmzS4o6rjkeYbUxI08a1CVOmSBNr7j+KMV2U=;
 b=DV6b/Er23QuL9H5zb4Z6p+FUpowdxAB/H5+gqtsYKAwgLDvkmThwl4BibU5JopCb19NocxhZLZLGi20l++AlpbnyZ+ctv/BWJE6fZ1Wj+9mVW1imlUrn16yqDGS8y91UDr7LKkaN6dwTNV8mL+SJxGfnHFVryKyuQl0TY40ZbIs=
Received: from PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::9)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 13:05:18 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::c7) by PH8P221CA0060.outlook.office365.com
 (2603:10b6:510:349::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:05:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:01 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:59 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 31/47] hw/misc/xlnx-versal-crl: split into base/concrete
 classes
Date: Thu, 21 Aug 2025 15:03:30 +0200
Message-ID: <20250821130354.125971-32-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a5e987-6183-49da-07a6-08dde0b360a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tXy73tUCPAi3N8JvspRKsJwJ0kUrK9YKAVJmWjAw3UFq5dqlggpH9K8ofpJn?=
 =?us-ascii?Q?7PhMHvjOV8ubyvOBPU4mdJDuJMQqeb2f1FiUQPqSlKeZfVPY+Fq/7Dn+j8H3?=
 =?us-ascii?Q?AhKsocSNmQWlBR+J24p5OU8GFFOpbMpbkq2HejqA3tfF82+LGMdCMu50myBh?=
 =?us-ascii?Q?bLkPJiNURvDwMb6IBqAtGoGr6kF/fVQ6RTQDyHhP+GPsTJKeLU1H/FGPxx02?=
 =?us-ascii?Q?7bKKuSo1NuAEYGQZ7aJ1mOsk11woVFVhJ26X/tuSFY/kl7SALAKB9kCsRdWO?=
 =?us-ascii?Q?kvST5QI9KE7054EO84/QjOzHMxvoNR6ZvYQaWmalQxILlksGfQJ5HMKM1Eot?=
 =?us-ascii?Q?DmjrNNcjNHORshkG5T8enHWvxyh5dzZxMTuLuB4K7MIIbgYUCbIUuqYbbY7y?=
 =?us-ascii?Q?bC8zuNW9Fwb/GOE4nDP8b1qgIPKQJrEqqbhfRwTyK/TErdCqiMRtMZ2xnqsy?=
 =?us-ascii?Q?4QiEEXzwT+7X/IqoGey1zTZqnA98DKbJ7P721d3DZnIUQigRWkat2nC3bML/?=
 =?us-ascii?Q?+uKqBwhCm6LQhjf5R1+V0n+lVuAsULPrTEZbH2+eLcb7I7x6X9o1G8SV01sM?=
 =?us-ascii?Q?yBlPsGRgvxx/AIONpi7dsBFAEmM3V+VGS1T7+z6ZeU5oQK5FqzoKStXuuBHO?=
 =?us-ascii?Q?HBA1GiqnbHGa6DF1tdX9hYinvPvBUPXQxV3IVbOJ0TT5u2zaQKXalwkp7yln?=
 =?us-ascii?Q?KHdIbzMjkgO01XsVCGE1AbcZlvJBT7NB9HF501rb0stZ+Ce66noPg/wyCqFS?=
 =?us-ascii?Q?GAJOCivMx+el8pgb7pTUsbvNbH6nHpBb/J/8K+8KB/abIXAoLXDCcPteZP5O?=
 =?us-ascii?Q?URCjiggSyHi8QixupWhi8zOx/KJLBWjEOZyz02t/5jbsr6tSLeo+TuB8KDE0?=
 =?us-ascii?Q?w5eCfs+Thr7NtU32fMbJjiEAy04UlARlfc24sXpr9okiv6JxnT76hfHrTobL?=
 =?us-ascii?Q?Z/8ofKcvlJGlp8Spy3hM5vXHpqY7XVUNOFey/Hw7mjFdTksGOcMwGTPJPza+?=
 =?us-ascii?Q?A+wwI3ZYQdRM3fjdmriSC25xIqTiCDe5HuwrXM40wlA2y3vey9iTFrBCc5k2?=
 =?us-ascii?Q?C+s0vywRRpMN/DiK4BntGTW8dtN4oXezpN1jEk2McUho9F6hz8jgNJDKEJUq?=
 =?us-ascii?Q?/J72jRJM2Ial7csBOBPXSPHqhx8m2IRemgTXTs0MHBZBe+vwSuCyTGmAUi7X?=
 =?us-ascii?Q?owIMkK9sBBLUe4WWEfN8+L6oS1lPKdcDN41gAn5vrogR01BD0lV/ty4O56QA?=
 =?us-ascii?Q?0vTkAUYIVJtVgyy4YRKd/TFIQp5XyxU7GEXA8TdXl7YbypL9nvHd0KADjwUa?=
 =?us-ascii?Q?8GQnzANY909V0dHhywh1MKzcCnGoYIgFhbgmrQFw/8VBOVBJSJy1PC+HwuKW?=
 =?us-ascii?Q?l+DgnrfDU9g9Y+sBMlFSHhUgbfIkPu5hvus8ANmmCoU111aaxy79/9ahZR1h?=
 =?us-ascii?Q?j0E+MRpVY59hhATaIDVsGJVCHnhSWC4JSFL4JRWfR2CEeJmkFjYuiy1ueHQg?=
 =?us-ascii?Q?6l1IKN8aHURiJco=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:18.0538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a5e987-6183-49da-07a6-08dde0b360a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361
Received-SPF: permerror client-ip=2a01:111:f403:2416::626;
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


