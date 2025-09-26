Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA203CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aZ-0006tx-Fo; Fri, 26 Sep 2025 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aO-0006fL-SR; Fri, 26 Sep 2025 03:09:45 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aA-0006gE-0U; Fri, 26 Sep 2025 03:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKmnUEIfyN2LaWFYboPgH1ZYL+FCqAjjdZNhFa86Vq9klhE4hbTFUxDhdPa8iuKDPG9bVOZZ3UPqdP4Oim9Du4TeZOonOJBzwd5miICG7Uf+DySf7ZNxqldAgpQwcL6GMANYEQotRQELBv4BKIQ57utRIml0hPZTEtDaaznr6fFHV5XspkWc2oJ0WW9B1aMy7MFq8g1OQGBb7MUyXAr7vEI+obZF2UIgE70FSwL2OZKgkReX+m0IJ6YndYABvYgAIOUt42NoYd7z08H5FDNk1HjAogpmKu9HBfE03TX5I2AJQUCVlcLDNgNEetlAuUMiUeg7JA7kqV7y1XCaic9Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLLRtN58qTiLwsp7J9WiYxWFlXRVGO32R/CO48HKaJQ=;
 b=s7321wLM+qxA8R5kX2kqw7XdfMwVFZja0nnxhemMiQ29cxyoFlLsjq0v6dTKLcNYl26fREqB4996SbgwLBrnMMie7+8IQxjci4D+GMxDGmd+cSoDE+qSwCIJXFNpB3kDpcC/YoXsT86LqNYqOMQejoFjPZSWiIvRSz6kXVDL5aayqttzvML7Sd65dLR0vlqD1q4HsOH+Izm4ezwzLZxdyl2FrRN7YYQfcSdezIm/hLtiO2VtHwrTtLey+0bCqgw0r36PlPpBdkD+r5S2fMT4hyIVlpLf8QTcX6C++Q3qcPtSorLTGfMOt0hBO0y7+oV/UGQ9BNCUhEn56e6O+D3YtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLLRtN58qTiLwsp7J9WiYxWFlXRVGO32R/CO48HKaJQ=;
 b=lPPLRfW5/O8QT3yVqQmlBE2S8xh5DxNk4At5gL2bFk2oSoDEGbyKyq6pNhRa29LoBS1tyMfY06dNOCxJ6HyIIPi8VJlwjlNRQqPXC4FbtVfX3euZ5dEygaotd9+W2aGqyDC/iUiTufZ6vDCTScsruxY8QukNk4gxs93uI2AKwzY=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:09:20 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::ff) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:08 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:07 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:06 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 31/47] hw/misc/xlnx-versal-crl: split into base/concrete
 classes
Date: Fri, 26 Sep 2025 09:07:49 +0200
Message-ID: <20250926070806.292065-32-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf41d2-7723-4c11-df88-08ddfccb9d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRFW9Zb3rZkGEVnOoPenW2Wc2iSAlFn/9vqzyfY68ixjtXMZmdrPpzkmTcvW?=
 =?us-ascii?Q?hd8EPiuAtb0Ol13k2Opg7qALl4Sw4R2XazYWj33QA7k58JTyTVhj3W2t25lk?=
 =?us-ascii?Q?W4IG2fAwU7hT0Q5ZQMa49xX5gJJ1JNBVBICf2oJrRr2D9vhGnO2BLzRb1uDL?=
 =?us-ascii?Q?kF9/4ibSRpYB3vGVWglJb3aNnp/cvUSiPaGW+6ksa41W+Q+NKaNKozIMQIqK?=
 =?us-ascii?Q?n6dbZZQ8CBbdf15xrPZzhirm7pvwOmylWZLFNSrTh0EeJ2BVeZ4nh4k9+I+C?=
 =?us-ascii?Q?tqdOxDJB1tHDtdu5QDDd9/LVt8EarXcI1Lm0cmfgx/GNBCQfHoZRciCDDOh0?=
 =?us-ascii?Q?cuJ043V2bkOYvE8gs6VO6CoOz1yNzEAmoSjuwO9ZMKrq6A3XBNB+kIqYqXEg?=
 =?us-ascii?Q?wIy4621SMSO9fsfw8lvTlGYK2MDrxRC2qWKCzb2SoS6yMClroz15OqwUWLuo?=
 =?us-ascii?Q?+HVcz1KO2XsAJCFrp6YT/TrVrmlBC1zIED5uz9pE72AOe4Uva7rwJc1SB8UW?=
 =?us-ascii?Q?1XiNr8Bgs3a10tQ2eD02RB4sko2QTMHDTtbwWxUw5It5t2smse9w5nDRbdX0?=
 =?us-ascii?Q?SoPe3d8EMjxPxhLAXAtDMiAZu65po+UISE5PZW5B3fwy865cvq4nXhsoXoU/?=
 =?us-ascii?Q?kPBoYKe+oqB6FhExLF1bcbc/XB4Ldi1EN2xtLwMhIqlGNR94fuXFh7E4wiNF?=
 =?us-ascii?Q?r6s3HbRrY0dq0Q0jtgQA4ZouhFP0rFMi8Wslnm5R2jKHR4i9AqWnI568cZMk?=
 =?us-ascii?Q?IH+EjByt10EggPEROuIYCc4aP5mjoVGCJ4CIL78pvqisEuBJG7PxYBJ+IDSr?=
 =?us-ascii?Q?jHlhCe1dN888Hy+MdxV2ApOh8p5yZVhfMaJf8ar+XzKFLH2r5mkihr9zJtXS?=
 =?us-ascii?Q?RiIUmwhDpA/k6zvk9fKwNKbBJbjyr+goxAe3DjhhlNpRVcBsk8gvWVGvzvGw?=
 =?us-ascii?Q?Dv6BmBSk64u/tqmY3Jr+cgnLdYvkSys4olMiyrSGg9m4GvgoEUNDTFbpufUs?=
 =?us-ascii?Q?c/uNbw6wmnGFI+2eMFWsZCqMnXDgqCzFmoeFhWb8JL276wXi6kmWNSLUv5f1?=
 =?us-ascii?Q?9aVbDXnwPKqLF/DFcej9PMEy8eipUtJqzXR6mNnuhtQENfKEAupO540fMLSo?=
 =?us-ascii?Q?fB9TnrXNvQ/QoS63PWP6p/26rggDp1Mm/JSpWwU4qvgyTjMNhDEcSMTv9+rB?=
 =?us-ascii?Q?yy8UES/s60nyq/F9K6WawypR7aEUXADLtHWwA378OckJLuUrqtseFnPxvy6l?=
 =?us-ascii?Q?pmVuyOo0CQ6s/8c6DO9t6konoelpgm6sonjkwhA5IBGPQp2aBVGKMqmMGXor?=
 =?us-ascii?Q?f9xtQpDBzBvfqkftSJkRZmDufzOjkydEpRwYNMKy/SrYkUlsTD8n4DmUGdE8?=
 =?us-ascii?Q?MBTsu6oJ6zcbV3IPAEeHXkthEUhwxkTECtoRNz5Oyb5OfjN2YWZMAzTh9Ax1?=
 =?us-ascii?Q?Gxr95bIzgPgeUCxSqmtdJVcFEZUYA6FpU826PI6XBJayg82fkBRWukmhjg73?=
 =?us-ascii?Q?RbuluhJxNbC4zXr1lQ3JnE4aKI/4JUm4gxxlrur4G3ljukGbjxOw8eqx9S5p?=
 =?us-ascii?Q?DBTse39akLIYkgo2roI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:20.5992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf41d2-7723-4c11-df88-08ddfccb9d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


