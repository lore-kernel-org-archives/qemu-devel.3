Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72827CA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9H-00044F-1l; Wed, 20 Aug 2025 04:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9F-00043i-C7; Wed, 20 Aug 2025 04:26:21 -0400
Received: from mail-sn1nam02on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2406::630]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9D-0000qo-8N; Wed, 20 Aug 2025 04:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5hFkm00GyXnnoqDDs7vZAwpT+eSSdJYawNvG87lRf6tspJeclzmf6Gf7hfLiMQtrUlQChPItEHGuoP4JWvy+61DlF+5TYmGd+i8viZlSVHfoxAfYJtLp4S9xsbWlP/KrpToekEZ60KfFF2GlVyG1dtWmGJPeXIlw2JTWlvVlCEhSCQtYl2uSRzmryViXMcjBbjFoPLP2gcUmQqJRrRav0/ZdFpQXUZABRkyeEzlJH41nyxy+9IWkQP1uUAUpWX5FIyzharRVXPi2wjisZKWbTMCYp+z9k+TXknLkJOeIDv37Lu0TMpctASUuzt1zbLdE/dl74qT6/B0gHscBsjGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5alzMGbdiJ0wS00o6vrtpYmHXR6CyrF9CRkz5egjgM=;
 b=aNXZikkWYXKeS09fMoP/JJWRlOU+jOqYTUwPnIb3/Y5VL1y/cd/nr/JoXKQEE5WT83mapdCLvFZ/kcDaWyZF/6JdyhFhfTG7TfXXJ9s8g2+CwG+17VyA62He+Prviu2EURX25o9ikVJYgjrJhhiJ3Go84noHtlkdXfTPp0rf6ytuM/qx7RKQNjZOkv31JI/Ak03Afmz6GeQP66Ncejgv+g76NSumuK4WVRuM3hA1riNnTJl/Dyg6rJg2YeYoHvItLJUs7VNBojMoOyti1e8/8oVXjYkrv0f5AtLKG6DYpWrPzzesH1mPFPdP988OHYyx+wkn6lT5zpXMagGucIM8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5alzMGbdiJ0wS00o6vrtpYmHXR6CyrF9CRkz5egjgM=;
 b=fNKgwjZ8jpu1ZFD1hGt3+Lydv33tlnZ8h+/w9UF1Ty1TJOW8yhdmZluHeCV8HgMRCizr3jCMEPvTZMG9QA3LG2QAnyUqdZRin7AVKfm27a2YvjITBFwdFXGGtm4VLsw+vvY7WDEZEJtIIx9mHsnbhd/9P1KrsqmpLulRrq3VCcE=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:12 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::74) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:11 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:09 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Wed, 20 Aug 2025 10:25:00 +0200
Message-ID: <20250820082549.69724-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: f9960579-fe60-48fe-c876-08dddfc33904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pnqcXeqsReBLLvGWTfU/Zt+Yng9BgzRETMZCVRKUorYI/5ByjWu+O3D2znTs?=
 =?us-ascii?Q?E7cGBOAfO/Gw9K5NAGwYC+TegThwDPuS1mxiEXieDSO/DfNknqd9KMqqqx5O?=
 =?us-ascii?Q?YFdMa8cw/JJ2cxA+Akhjne8o9Q+M5LQVWVX0SR9DSGiavvK4TsOo8/JtqPah?=
 =?us-ascii?Q?snIbwlt7XML1PzAeSn1BuntCxV2FPwciYZPBJ4znX3+/niFEbKtwcHi9MqU0?=
 =?us-ascii?Q?1l3dyrDvJKD1p+S4nkXh6iiwVOE9DS5xawmbc6uEaWf/KGsSdpJkl1s3om39?=
 =?us-ascii?Q?1rKd3QIq12aYntW0EOXr59p6ArTVkUaTbLyuMcKHxL0YHmU5dVt1MI/aNmCy?=
 =?us-ascii?Q?plCwaZYX//7rGldOvcVNUAqY5hP2f2EJ9yI7TPlbpD7p4qacmaAV4RndVbuJ?=
 =?us-ascii?Q?XmxUqQ5kZowoHq3nixBRWdopbf9a4hxF/wrimCYLNYxMPbPp4xm284LTxZdH?=
 =?us-ascii?Q?wWL6Ddi81bCQf7jTht7mKKWor4i6LVdRGLEB5IrdVfEsOMMgfl63u0n1dYci?=
 =?us-ascii?Q?A0fHGFXTrKD+oenGJhFPamuYpg3peP4UYmfh9t2GrekDc9GKm9YoRzUI/GYZ?=
 =?us-ascii?Q?FPcxHxeareW6gXuxZYxda1Gyr8ULf6zFn5CxFq0/vq3NtP93TMe2P3sdoezh?=
 =?us-ascii?Q?gm9DVvZAK1orvUTj5hpfAajlNjDfJ+q9CGcR7zKewVsKqofyPHQFAO43MQTa?=
 =?us-ascii?Q?wQwrqKvXgyn4Q92Q2hrwRGZsrFcjQ+MRnnkx03FMpgOiIpg3K0KP0wmbv+GT?=
 =?us-ascii?Q?eVqpRsU2cN3j+jz0i8Be6CdwRqQMXNPDdIFaosr0CL7bPCx1zuJq/CvcDTs5?=
 =?us-ascii?Q?tiCbfURJkthVMs9M2XBsONqiN0qBNAbqCBIbi8A46zQ3euq/5iUJ32SX2ICj?=
 =?us-ascii?Q?KCWynye5mVqgg564fVNao2x3WyO74FB+GQ8XrWgKz1PXNIXHhXK0J2ym2gEp?=
 =?us-ascii?Q?Cfe4BPC1qfgtgt1TEt/jNSyrIJoiNlRInSUtHeGV5tjZ+QgPmPjZ3xXQaYxp?=
 =?us-ascii?Q?pYqvAsaYNTMabQ302sLVT7hfQ3AwgUARZ7gU7KzyBdScvLkwz3Qr0KcTJjOx?=
 =?us-ascii?Q?+9VH50Z9qMCVEjkfOMBAXvYA4kOuRhpU58FYE+yHeYHauvdSEm1nD33W9kFR?=
 =?us-ascii?Q?Z1yRBhDxgonAVbVUHDjKuTi0TgF2t9ufrQqYEdqDmzUol5ZyfSKeYSkB0SGD?=
 =?us-ascii?Q?AkhdV81/1T52V+BUvKujdfsWe1Mr6JyePGSY42KY33iNbkawzo4dYMbyyQR5?=
 =?us-ascii?Q?Grci2naCoIFhlKNYbFvdWKkPQnBXnlRlqPo5rEOuWmcbIFtS8oO6XpadjEbU?=
 =?us-ascii?Q?in7ypafC+LV+O2nFYzQbRkk09C7HxaPVCtdKHLyxUjtJNe8zW28fpL2Fjbr3?=
 =?us-ascii?Q?2JR2nJkfSIkWbXc4XTNDLk20s5kXGLO8RMG0lrcEG2jIh/+IT58x4JyW/FGg?=
 =?us-ascii?Q?dNka0a53Zye52npnDLbwkxTx9wUKI3dygs6odAnkq/vHkOTE4uuvs1RY06V2?=
 =?us-ascii?Q?mWx0aQvTOxWpNU2rAJPDcwLPuDpNkq6HZF4H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:12.3365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9960579-fe60-48fe-c876-08dddfc33904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
Received-SPF: permerror client-ip=2a01:111:f403:2406::630;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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


