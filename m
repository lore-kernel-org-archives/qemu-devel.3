Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C917CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVV-0007Wo-FU; Fri, 22 Aug 2025 11:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVT-0007WP-DJ; Fri, 22 Aug 2025 11:16:44 -0400
Received: from mail-mw2nam04on20612.outbound.protection.outlook.com
 ([2a01:111:f403:240a::612]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVL-00076U-TA; Fri, 22 Aug 2025 11:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqR646Shz4t1QF0PkmNz8jtKdj/S46VwrcUepmLqRFaaawgcow6XkRJDDywZx4pMnTjIJAJZ5ts3J2IyWUS59PIL+QvBanKiuJyXchMKMi5JB2o31d1z8vQCkILx3rzwneKDfVDLkfTH4ZvDDu9CAZi7xnJplaLPdWWeBLqfxtK0nqMYRlZxjt3T6ZK0/bSPPRLJ/ofRNNolFo/WGz4L7PSm45PAyjbtE2cKRiTOWCFF6LnE8NmZLEbWJn1O8L+sbEhGR/xh0wolwWj9xBtYe+f0Qwcx+Ru6N6mZHJBG/UfgnXeBHNcXTAQj/anMTiqfybyYwnAEqz9xS3jsqFYejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5alzMGbdiJ0wS00o6vrtpYmHXR6CyrF9CRkz5egjgM=;
 b=GtvrQAzfKXDWRlW9zs6wLttZJsvkegax8ulTYJ9OSttZ0zqBFNp0+DgfUjJA9Nawr1mQAN3cA0bacOUDyRLtfrqK0dkAR7EG3LyX9c6qhKnA2ARx9TNFLlggWgE/xjuhOVLtkQa0iM7Emy8xQ+VaGZONkUYoA6oJjw6zKYec5qSPiOmY+Pr76lZk0c9tiosLhNJ485CilnoH83yu4FX77948/qBljR74AxqbxS2G4su5J8/rvZLvzlsD30LA0kRiS6D/xuIY8nCXjo3D1vYYnhDrVrlbRjXZx0n/jE7VpsBRTIq8J3jLEDYvhmHtzNSxlgmn2//lV/iXPOeQD60u6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5alzMGbdiJ0wS00o6vrtpYmHXR6CyrF9CRkz5egjgM=;
 b=rOXZNAFKtXDD3Q0yd307hACh6D3LtgQx7VzSK4FMCU+4J0XueEO92baRb6QTjaJzdFShZDH2HIIICju0jnD40qyoT+AfbJ08IW0QU+my7BNT9ZgcDqOY2WXVIqYuFMtSnR+iHOP92Z+Hm+dCCoT2OX34NJ4QF/0PJaCh8qNPy54=
Received: from BYAPR02CA0048.namprd02.prod.outlook.com (2603:10b6:a03:54::25)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:16:27 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::42) by BYAPR02CA0048.outlook.office365.com
 (2603:10b6:a03:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 15:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:26 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:24 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Fri, 22 Aug 2025 17:15:26 +0200
Message-ID: <20250822151614.187856-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: dda2a675-084c-41e1-eea4-08dde18edd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/LtRNvNvFK+sXggh0K4TqxQazc5Y6NawzBgzaA3pkRaHuf6B9/o8QM4wwMY?=
 =?us-ascii?Q?/oVEZueC+8o1yF32ezDrWB68gQOVwMPE9TtptapHNiQnBQn3UVVxe6JBQrB2?=
 =?us-ascii?Q?lZYSWopsRHX89TQ6JKzcKaw0HIcfsAcT2P9a0ju+T1nqUIIAOt1/u++9hAI0?=
 =?us-ascii?Q?p1sW9I1TLf+nfGreYFMTQxHQtj4vs/1BtXLezBCwYUfITSI9SkmZ6k5Fa9vj?=
 =?us-ascii?Q?GMbhs5njVOLWSlERMWzOpJuurczjbS8jMv3059c3C55Z4CmyIUVRVNtQM6Fg?=
 =?us-ascii?Q?R42tmlJpKSv6iRQMgDo0IluJm2ElmTjWZ8c9ODshBcZmSxAbCZIdiHQBhtVA?=
 =?us-ascii?Q?+Wpd9IeKGCtPSOthXaJydwM1MZUJxLbnSTp/pPWunjBOgKEsMf2K8d3u6oDF?=
 =?us-ascii?Q?j1tEjR6T/G/zp2I8wMr8T7zkIdMNJNbUsdzUfKHBVuSYLATKEjragyx+vL8H?=
 =?us-ascii?Q?gZWX/DjeIBcfCSBn/m0rpVYhhSl3BButF61eJ3kUvSOtSyyhklPqdF1tGpsG?=
 =?us-ascii?Q?mqdd/d2KuZvKmvMn4SSNST1a29Y5Cu+rkUNPvNsXmJbuFPegJz7/7uUajSnf?=
 =?us-ascii?Q?DLH2wSt6zdJR9Y4yKUhdqXAaTXMFFREAMOZGynjV2682EmS/8JG23ly0bSCC?=
 =?us-ascii?Q?lnsUWbpnlRExbvkCd6OrNkWHmpt9SW28WY/r5kFxwkxRaBBHv2ZDFs3KQ7lw?=
 =?us-ascii?Q?EDKgum10xysc6h2kjdYI6TqkiNFrfZkPbmyWkvjojHLQHykHAd3D/D62Vc73?=
 =?us-ascii?Q?vUYcLQwrH38ULCQRNFtlgxyflDEKCq6bDuVJX+lBAkQE1kLlbeSb1KWt7LO4?=
 =?us-ascii?Q?SLHHWPjLMOVYdPcqfsqQZF86OLgNdZOAO6CJgs+Z0MvpeswT+0unfpK4oz2L?=
 =?us-ascii?Q?gNa1JWLevezzYFOjm0oJK7haXfXpBmQ4JqfHnVHmEDfDjPz7NxsTjAnG4DFI?=
 =?us-ascii?Q?SEUirJuHdBdo31klaK2Tk0bBxL++bRV63pIz23oPa0XqAohw2v8fRE926mdb?=
 =?us-ascii?Q?2hJOSVNwhnRQMyey31AAgQkwC3Y4ajlAmrJmZBH+ovRhrZYJ71xbf/IUOJId?=
 =?us-ascii?Q?VPOhvB19i567B4tS1/kRUCmPzN43pNBDklEeVCLXArx+BVbo4aRqe2sh+WKm?=
 =?us-ascii?Q?k5TbEDxWB4X1ikkyK/ncj06j1eBdAGtAsh2Ik8oc4PMYALUoANKyT2iFVdXp?=
 =?us-ascii?Q?ZHA92DMKNlyzq05d6A/xbS0jd5x1nntjDpq0xkztPlorPsz6hcja7IbhMga+?=
 =?us-ascii?Q?qtCT3tZba6qws/zmo8Y7uQ+Spl5kxWd0xzyxhAH/P4q/QEFNJ0eY9FD+Uv70?=
 =?us-ascii?Q?HfBdpHdHL7QnbTUsqstSLysBb4fSLYKZtTMukfm62ij1gu0pJJ5yxtNFsIww?=
 =?us-ascii?Q?95gGP5umvTbVks7v/xHHuKK0yPik+OyPqK08iMBXv7qaTNOsmrL10LxhJXLu?=
 =?us-ascii?Q?/0r0YiHDrI61uTClJfcBdXiCABtLDXSdheOI8NymrZrExg3FF091FpB80WNE?=
 =?us-ascii?Q?q+pBa7Ai3hMuHLxxQ7rKBEdfp5lkxfe+208M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:27.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2a675-084c-41e1-eea4-08dde18edd9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
Received-SPF: permerror client-ip=2a01:111:f403:240a::612;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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


