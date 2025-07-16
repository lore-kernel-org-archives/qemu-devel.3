Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD54C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytc-0008Dk-8i; Wed, 16 Jul 2025 05:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys8-00028B-Vv; Wed, 16 Jul 2025 05:56:22 -0400
Received: from mail-dm6nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2417::631]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys3-0006jJ-Vi; Wed, 16 Jul 2025 05:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5YlYqgWZScFeEi1YICkGvnromQVu+AIXUWl2vYhshGhGdc6A03aPeLPpclQX1x6mDzTnhPEDRisSd7sTQp9vhmGdRVFKZvFs65pitD2yL72ubch9XNYg1ddnmalgkIWPoOY5VtT9cCPfSiJJFo80FiRZPRyjUuKF7Subpolx+NZlFzAqpB4bGYcI9ukeLF3yu8l4FEzE21/Rc5Q9rR4IpzydTUTqE4JO7BqiBmm4pvMW+36P3ia2q28ZpJQK+JxlpVSxClKYggVH5CwVAgFYV+8aQNKQM19x42bK4aUtOaPM263AChTmgdOnhBWH8WxR5QbuCqk6qBOn0SaDWAXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PLpT8tydypI39aM6RITNapK8wJthh0dN9651w3AqX8=;
 b=dMyQTl5cw111QFWHA0uk5zmULN9v2MnHlEDG5XuncioHrVrcFE6njJMZO9PCdvSquSXSUX3Djvz8LC1aWLkT2kohh4L5qQdloaz/2zuFGMQj1FNnGOaCZ+5TOZR8B53b2STxJFI93dfKWqNQL3Fa3ZLTrRF9jUM8oyN3Rlj0lNFOoXqBUvBhKvFiAGVeKWQ/vRk7XS/h6KPG78s4fdMvmfSXCZJfXco2x2SX1pagwTvve6j+vVsbWC3HHRkbn3OriYVj3Htp41ajTEYFsuTXcD6C8oytEmA4FpHUMGX5oivS6XDdGSTQ9+B1GOMi/79JsSOFos4EzhHCgQPkNrwcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PLpT8tydypI39aM6RITNapK8wJthh0dN9651w3AqX8=;
 b=rzuk0YmvFUoiOw/ngB+q4PmyicutD2yK862b0dkMRo1L1PNadazfplG65gJicEjSLBzl1TNv/99pScRwghP+r13u+pp6QkXFpVNHoIdgq6ZcBwh+uKI4NNjm2djdKUugWrP+tvQAzsmQHNuQu8DRSKRHmpHD636l3jnFh6TWxaA=
Received: from CH3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::7)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:56:09 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::9b) by CH3P220CA0005.outlook.office365.com
 (2603:10b6:610:1e8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
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
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:03 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:01 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 32/48] hw/misc/xlnx-versal-crl: split into base/concrete
 classes
Date: Wed, 16 Jul 2025 11:54:14 +0200
Message-ID: <20250716095432.81923-33-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9555bf88-a1de-464f-1898-08ddc44efd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u1ovBLsGAW9gTH8yOSCOVGpOu0yvLka8oZU2oJOGRmHyQJC9UR/mBTP5tBt3?=
 =?us-ascii?Q?p7lc6u0wSMGXM3hp+gNPg9VzVhzmcHPbB6uK7btA+BYpL6+hM3CCQYb3wuBB?=
 =?us-ascii?Q?A646nRSROwHu6LCH7zY8LMhH7t5KwsuLXMm0Omx8IKkVmQNes+z6IoRgHEMq?=
 =?us-ascii?Q?cEnPQahWY8g2HyhY/nFuUYZq/taSyNAZJ/Xv7FlANrYFzBCqX/9lbI7RI/kf?=
 =?us-ascii?Q?G3LMrw0Se0H2APn2MDqvt0+Rd6bnaGiaCg0MOsXNWyzRlzzCTVl95ZeDz0Bg?=
 =?us-ascii?Q?RhcIOrJRB4Fk0b2XG5YgD5o49X7Flju4o5H7KnnDttgauFtOARmUXvkV6yKN?=
 =?us-ascii?Q?SErds7UM3uWjI/rCZa3i9945COUbqIYbUD/z55fBtLmFUw9N3OyTxs92t4+x?=
 =?us-ascii?Q?OWCGkEWG0BDHf3DluAB7OgBUaOxmQPtvy5RgmM5KSnmwX0EjemiF4su19TKo?=
 =?us-ascii?Q?FyD2VWC9jf6ZuS6/qCoIKM1+LCEwnkEkiQmjQvRzeolRX4xodgYdGeKzm+Q7?=
 =?us-ascii?Q?7LqBdoT2YWdWgDTK6VbmsvRjKZ4B+ydv1clBPqkH/fbEKYAWt2S77hfWIemB?=
 =?us-ascii?Q?Z2vtqXrAOPr5e2NT5Xtr8IwqVGWFuGJy4BiMm1Hmwx9+wa6lrIHF+4DLuVHV?=
 =?us-ascii?Q?OFsqH9XSzJ+Z5XCHx1u6Tibe2RvFYVOqM4FV3GnK6b+5Kgi5jAanfmAzh26p?=
 =?us-ascii?Q?bmxmetRve+owLzozrUSzcqYNTWFQRUh/i3LnuGwV9WHdbuND00ievFUh4RMd?=
 =?us-ascii?Q?/Xo/ueUGmYpSmsK0wP22b0u4urgxD/LWU5kIA/l9twxsL4I68tn0SGfTsOH+?=
 =?us-ascii?Q?sxCnsmLHwx0LjNs2b4eU/aq4is0/GQhooIc7enLSvUUUQvSU5y5KLCph5e+O?=
 =?us-ascii?Q?rm4lBGKtyKxhP81pZJNhPGYvpHuTIYQBA5d0j1PRI+gH+l7ji+HKUpIeJcRg?=
 =?us-ascii?Q?LsdvZRVP/QCmyGf7spL8PQ7325AQZOLJxn//pk0rNS3F/V13QQs0V2ENB9/Q?=
 =?us-ascii?Q?c4GhJbgFLtXc4DDCjS6eh/6Hzz28imz+hGYOAA7oHe3dGgIgoIYEXZLMD33O?=
 =?us-ascii?Q?XI3/Q2qDQlxOI3fEOs8yvkM7oUzFxFlk4Bv4jqxCSmgnlqR+bUE9yDkusygn?=
 =?us-ascii?Q?bvXxGnf3mxTi9Kpv02PogmE+SdlSUWtQ2E2+si1CdrvqYtdsKieUR/ZOwHQH?=
 =?us-ascii?Q?n7pR3Q3E0U9T3igTuOYC5mSQCYsbqf9Zy/FGcUVZQXQ1+u9hQ0P+N9Te4eFm?=
 =?us-ascii?Q?A9GFI0sFBXS3hFPMmB5fC7xREBafwgyhxgG5JWcjvu0Hg28Sx0aFghV97ILY?=
 =?us-ascii?Q?9SYILly3uFlWH0Ysy/Z/7ZcOLeNBWPhqjeXSVJzzdgRC6sbr1zk3Q5lWtXRy?=
 =?us-ascii?Q?d7tcmlSeFHayWLwdteRDjENHMMGBXwwh1t6gZfXaGgsXdsSKWG33DQJybhnG?=
 =?us-ascii?Q?lpNp66uoehDp9HFkVgm45nDicjOTMreAkHb/atgrpIE6T8/eGLoXvfEwNGz8?=
 =?us-ascii?Q?7BrNGo0RBmhhYOWraGt05IbsrZpniibyhKJO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:09.0860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9555bf88-a1de-464f-1898-08ddc44efd3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
Received-SPF: permerror client-ip=2a01:111:f403:2417::631;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
2.50.0


