Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202A7CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4y3-0001K3-Tf; Thu, 21 Aug 2025 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xt-0001H4-Ak; Thu, 21 Aug 2025 09:04:26 -0400
Received: from mail-bn8nam04on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2408::616]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xk-0002s9-Rf; Thu, 21 Aug 2025 09:04:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFOPARJVG02s6yN8z0k6UBJZotwWem4plrckLosIgcs3sNY28erItCMKWXShKPJ9ylF+HYqBFi+O5JXIqqx3gcYgjM59yxi5FwupJJZrDwDzeGlK8E8awFFj0nZmiDPodpzT3m45gYkJ7K8C4A5QooEEIyoOvWOdOSR5GAmTw5VLW1SpuYzPOBW2aQmIfnDkvKiB8RKPeN3QRh+zuXV4gz31mKfDtD38zT7exYkWfQbDDEn36dGSQ83DR7Y9DSHwbGOwUyy0SvvxgK7Pz6kEOOy1ZTD/C/x5kXLGmuYXH88PovBkCnFrBR5mcE8K6C2z2ji41XyavEL3fTHU4CToWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5alzMGbdiJ0wS00o6vrtpYmHXR6CyrF9CRkz5egjgM=;
 b=R/ZKXXTWrTrmHvpZlrjErDYQtPkccRzMqVDFHcKqs1wZE/UP94nbtCwYBGQtHXiuSy09IvGrUu/jxRC0TRc7EGiDq+wgOgC8PsvTk9DWdiGafmYrjObPI5qHasZk5tcFt7JUBBuMwLN5VRnvV2jiPnk6l4mY4hSKoiX2AhV8RkTlbRBuAUlZ8vcrOBHPfphdQq36cy6uwMUApYOhJ6mV4xac08Pq/pLHvlyHwSqPl+0HccZxf6Aq94vXAxeNLmoGDh4baM/W3OI2htB/9h0yq6IuNZ3JQzsU0lhcyxtB/ol2Aj7MAszW6faZn1cK9sCMjeTjK/WXjtQyr3czdnS6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5alzMGbdiJ0wS00o6vrtpYmHXR6CyrF9CRkz5egjgM=;
 b=T6unrFYYbciCQI0YzfHGVmPwWVGuibBeSNuy6z7PtEgsuC42bN4OS+trogMRLsGdNB0UBTp11uYlVakkSwdNPgWYeHnSZ39DSpKlWqGza6uFtJCa2BUGDhYu1izRII+sbtyWoSfBnHPHfHeE3Ww2B0ccxAVcC9tYGkMZ29AUA5A=
Received: from SA1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:2d3::28)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Thu, 21 Aug
 2025 13:04:08 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::71) by SA1PR03CA0023.outlook.office365.com
 (2603:10b6:806:2d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:04 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:03 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Thu, 21 Aug 2025 15:03:00 +0200
Message-ID: <20250821130354.125971-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 01559057-7c6c-44b8-690e-08dde0b33723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xtnlYr5Gqb6bwor9iUCt1+rWWulKhi7tsQZYvN8wgvcdKKjQk2nU4YY6WC7o?=
 =?us-ascii?Q?m0H4zwX8dLmp4gbpk8v2ndKUbsM6sk/IiqEfTVfSA5wg1IEhFf5cdumJ006u?=
 =?us-ascii?Q?GC149ux0jbGHSsTxeU65wYzn6xEqqezuNS+fa7kaeDvz70IZuyQKyEcNCTq2?=
 =?us-ascii?Q?YIW2YPPgHs8TIGkGgLPNyQPyYbcXCPv+pg/I4WKj8mYwytuhwK3FwBZz6rPZ?=
 =?us-ascii?Q?NfrOrEr/U45DI+m0SmPz6ufwzJ6UdKNKuaKcahMpMthJFSyqIR2doA0U0Yhw?=
 =?us-ascii?Q?uFbMqoNNZ+J2vgaqrrYawz0zThEfW3Mx0xL/SCKCQOZSlwnXU90n06rYvmTW?=
 =?us-ascii?Q?d4E3zT7ioXLllSoP/TDLEIJVGjLImwFmLXkcqBFmbfOgZ1csiFxnq/FSMC8S?=
 =?us-ascii?Q?RZayzBKkCDpVSSuIWnBKTUmdV8prZ7hMeNUE5lxeor7qqTpIgnmxr/Ss1Nbe?=
 =?us-ascii?Q?mjRcg0hz3c1wMxjCVY1hFfzlGh4OGOZRO9yYBrmzXd89jLVnPVL50bf4zd4l?=
 =?us-ascii?Q?S91/S+u6sPcc5cdcVYRjootiw4xWDb79xn4egwqpTZiQpgUb0mMv5DTnFIFd?=
 =?us-ascii?Q?MFrVPL94mqbXSNjrBpmFcsA/1PGYaRPRtlvRFZnGlR2wUaoR8hV3jSZV+hzA?=
 =?us-ascii?Q?9DbjRuDGlYjPXmrm8xXwj2Io2ygPMIH/LGrQ9gZxrSGQdUgDUHCbIbqObYhp?=
 =?us-ascii?Q?kIJ26bCEbIx0MuTLd0vF0S6mfRWwC9aOHgT/LFGRquaEjQK1edtrA5ZoV8kI?=
 =?us-ascii?Q?tProF4rFGhlHi787aFXndgf4RelWm3GUaUYAXGfWIDrF8SW5gbPcS7SMuOMI?=
 =?us-ascii?Q?kGqgmUyymaYyzfrPDdmFXH1qNbyeHOacADdo0U/x5vBRXHvcvYLvzA3rOCaj?=
 =?us-ascii?Q?cvTSwT7yvY5/ZjRahBH7HfkzM54ABQyFs1eQtpFXmIbYzTM+HSvj9ioU2apL?=
 =?us-ascii?Q?3flPFCrJ2l4uf91XSWNQ3QoWjNmNOujyfylT+qkWdjAo/yCSOvc+w0roPV8/?=
 =?us-ascii?Q?9+TU2CmFu9GY5Xg4uDuS/My/qtxwoHdo0W6IZ0WIr2EuixF892Jn+m25nAPv?=
 =?us-ascii?Q?ElGL5FduRdQbvzQ6nZgXDeaEe0DgHdZO4PCH+iK/aIaNqxIMx/9R2zFZ8d4x?=
 =?us-ascii?Q?G3K8dphyGcKhaF2tGotvwbI8wcGifOi4nE7qwSbw19qovUyAeM13uMbgrdF5?=
 =?us-ascii?Q?svs4D2YGnHxID+hbDX2EP4MtKL3mgoOxBLrb0/SNUWEWgIMGwJaqvD5Gq3hO?=
 =?us-ascii?Q?GkTzzr0oLm5yq+jgIdG8bN+jdICb/DS3rcNXwEuO9jMh06uWtk6q+ZwSb9ru?=
 =?us-ascii?Q?YZXlb4xj1XokKeAXj0idHh4soUoYzv0LE+RLQ48y7bptUffgq/6S47Sc0yFy?=
 =?us-ascii?Q?ek5WcxP8avDkY1wtds63jiqljrtkKpptILQrVmBufMKVatX0AO3oJ0E8Ql7l?=
 =?us-ascii?Q?kHRO8NhqCnSGAiXbQJZ94TQRSyxSZh3aXSc/1PiHbZbkbyHB6CvVGFQAvoLg?=
 =?us-ascii?Q?JyAyQSxPFQxnO/lVWJwBbLl/BSrifsAbn9wN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:08.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01559057-7c6c-44b8-690e-08dde0b33723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
Received-SPF: permerror client-ip=2a01:111:f403:2408::616;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Split the xlnx-versal device into two classes, a base, abstract class
and the existing concrete one. Introduce a VersalVersion type that will
be used across several device models when versal2 implementation is
added.

This is in preparation for versal2 implementation.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal-version.h | 15 ++++++++++++++
 include/hw/arm/xlnx-versal.h         | 12 ++++++++++-
 hw/arm/xlnx-versal.c                 | 31 +++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
new file mode 100644
index 00000000000..c4307d1304a
--- /dev/null
+++ b/include/hw/arm/xlnx-versal-version.h
@@ -0,0 +1,15 @@
+/*
+ * AMD Versal versions
+ *
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_XLNX_VERSAL_VERSION_H
+#define HW_ARM_XLNX_VERSAL_VERSION_H
+
+typedef enum VersalVersion {
+    VERSAL_VER_VERSAL,
+} VersalVersion;
+
+#endif
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 05ed641b6b6..1f92e314d6c 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -1,9 +1,10 @@
 /*
  * Model of the Xilinx Versal
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or
  * (at your option) any later version.
@@ -33,13 +34,16 @@
 #include "hw/misc/xlnx-versal-trng.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
+#include "hw/arm/xlnx-versal-version.h"
+
+#define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
+OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
-OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
 
 #define XLNX_VERSAL_NR_ACPUS   2
 #define XLNX_VERSAL_NR_RCPUS   2
 #define XLNX_VERSAL_NR_UARTS   2
 #define XLNX_VERSAL_NR_GEMS    2
@@ -135,10 +139,16 @@ struct Versal {
     struct {
         MemoryRegion *mr_ddr;
     } cfg;
 };
 
+struct VersalClass {
+    SysBusDeviceClass parent;
+
+    VersalVersion version;
+};
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
 #define VERSAL_TIMER_VIRT_IRQ       11
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index a42b9e7140b..4da656318f6 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1,9 +1,10 @@
 /*
  * Xilinx Versal SoC model.
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or
  * (at your option) any later version.
@@ -918,11 +919,11 @@ static void versal_unimp(Versal *s)
                                 gpio_in);
 }
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
-    Versal *s = XLNX_VERSAL(dev);
+    Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
@@ -953,13 +954,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
-static void versal_init(Object *obj)
+static void versal_base_init(Object *obj)
 {
-    Versal *s = XLNX_VERSAL(obj);
+    Versal *s = XLNX_VERSAL_BASE(obj);
 
     memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
@@ -973,28 +974,44 @@ static const Property versal_properties[] = {
                       TYPE_CAN_BUS, CanBusState *),
     DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
                       TYPE_CAN_BUS, CanBusState *),
 };
 
-static void versal_class_init(ObjectClass *klass, const void *data)
+static void versal_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = versal_realize;
     device_class_set_props(dc, versal_properties);
     /* No VMSD since we haven't got any top-level SoC state to save.  */
 }
 
-static const TypeInfo versal_info = {
-    .name = TYPE_XLNX_VERSAL,
+static void versal_class_init(ObjectClass *klass, const void *data)
+{
+    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
+
+    vc->version = VERSAL_VER_VERSAL;
+}
+
+static const TypeInfo versal_base_info = {
+    .name = TYPE_XLNX_VERSAL_BASE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Versal),
-    .instance_init = versal_init,
+    .instance_init = versal_base_init,
+    .class_init = versal_base_class_init,
+    .class_size = sizeof(VersalClass),
+    .abstract = true,
+};
+
+static const TypeInfo versal_info = {
+    .name = TYPE_XLNX_VERSAL,
+    .parent = TYPE_XLNX_VERSAL_BASE,
     .class_init = versal_class_init,
 };
 
 static void versal_register_types(void)
 {
+    type_register_static(&versal_base_info);
     type_register_static(&versal_info);
 }
 
 type_init(versal_register_types);
-- 
2.50.1


