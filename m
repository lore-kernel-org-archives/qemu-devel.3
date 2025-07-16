Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF7C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyrv-0001aj-Ih; Wed, 16 Jul 2025 05:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyr8-0000sz-63; Wed, 16 Jul 2025 05:55:19 -0400
Received: from mail-mw2nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyr3-0006Vf-Is; Wed, 16 Jul 2025 05:55:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDhlz5B/LWiAvIF6rSQmjlMmW8HJKNgBvDBB3Jy9BHDi3VlF6FHu5Tu6E0KBVbsorbVQ/w08K3zomkzkX7n5/A07U3OMp+VFpywJB5yH6CFAqRhNqLR+2KpzOtt2d5Xf6tYHE/Irc6Awq5R1HOQWVxbdZ1kr6PZbmlZhZO0CbAUQilTtu2jhM79SCdCJKRimYw8jhtjivP6JfX4fiutzWDyR1ED+/YYMjcM8lSlUEvXe0/RT/P5MCcn6LofAunnuXgXY246dmH7/acqxBGOjM4YRSbdty4s1RkjMBbQliJi3wNTqGYNdUxohqOgFUsOUqKY5lXOdnGDS8I2okqCaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ekuBMEDXXL1VkMfVlVSx2ubVMGZ2xl1BPx3Pn/PFTQ=;
 b=oTGIfx+Af4owdNLBFS6N5ivNsdIf8bNi9V/N7ROSpKkSez95WN9lKJzHO3w3wvllJXAPt9Lor6+JhrtIOgfBAqQT1rY/OMGzgMRSWTwphLbY3WuE84+yLm/nRBmRs/MQc1JlrOYZI/PN96EJZL5ToYNSSySzVfzmOZUjmA0mSP3St8nO0SBw8+Lu7iP88nRA2jfsKgRCghlPVsnFo9zyL3Zqwj9xKmR5ZSEOZ4ZRL4M9IZ77rjg2w3Bo9luxHAvMltd9bbLeC+4dCpGIqtmlqcTZtu/uoQf4ZvGwEVFglK3SajBE7x3IiHpVLNz5LVdZh3xhbSnjuxsacbnsMcHUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ekuBMEDXXL1VkMfVlVSx2ubVMGZ2xl1BPx3Pn/PFTQ=;
 b=dhyAxnp8nDN/dzO0DFwJ0Y6uWmqjKAE47tIzwNRBuOtiwtuzeQJdRWx9rf1mVzixG1Gm1tt4+zjRzB9J/iwstE30i2r3lZBaS4BzQx35KzM1l2m1dBqk8hmU3THAO3HKc1c6pG0DtoDbujy1++irYAmyHcBCNhKemRBQfXBQtcc=
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 09:55:06 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::5) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:01 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:54:59 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 02/48] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Wed, 16 Jul 2025 11:53:44 +0200
Message-ID: <20250716095432.81923-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 447da0d9-badc-4627-fddf-08ddc44ed770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lcdf1twGKs62Xafw1XwETCA1ZbcZ7lJgKKGhuWpPBYo5W/yYvhkks/2XYDRx?=
 =?us-ascii?Q?pbX2kS89YUElTaFCkvjzSIxwVOykrYKh/4jgLAzS+1qxpSJnbQMQURDLNt0v?=
 =?us-ascii?Q?H4U6zuhoujhg/i0yJgVNwKpmYvGQ2pMyvtQ0Gw95wyRWqMxUU8qAyyGg6tZn?=
 =?us-ascii?Q?tuI6wbWvhyA3YvzPOS+kUggVPNBR1GRCfTWeVilR+SWmffZf6qzwyD3rRjYY?=
 =?us-ascii?Q?IDEcCZPkPe+RFw84y00rmeAmsHqp7EJmGd3j9ue9orhqiwXickoi1ZKsLoyk?=
 =?us-ascii?Q?1vcArtNmMJ2946PKGK6hNHXTsIx1n/odfVlAFCymHDFcS5tp9foYHcaJU4LD?=
 =?us-ascii?Q?N4R6OWP7ItyvfG/qvSgWB5kx0t8NSEDclatVjZzw6taz9mZVLTRhFUTmUkyA?=
 =?us-ascii?Q?YT14YuJt5ioZUSpSlCiJNIRcuxhWaMkJVjgGcVKTOb/PzEDEOgBZ8meaJlDH?=
 =?us-ascii?Q?+BpXep7Wt/HxoE9fiGAqSfwqv8IfVxzVoREI4puhDshItXV5eG0b2bQZLdKr?=
 =?us-ascii?Q?1aPlW/SPtmPoxNTDG+pL2xwELfXy6o0v39uMrcQNwAqhI9mPR8hvTZ7RXNIX?=
 =?us-ascii?Q?hNZGcL8ExDjCTNcRSzW+y/4JpthN7W8ONfxoHcblgH7O48RDCgmMgZQQjfWr?=
 =?us-ascii?Q?bRroIOfhncLp5QFDfpCEWsnXiYEnMjgdhFeRq8PNYumRH93igIm3+yCG4Ww9?=
 =?us-ascii?Q?uCizTnOUYjznNMenSjY88kkM901PmFjNHMVymjyz0t8Q1bvyLQpW7AWuZ+7q?=
 =?us-ascii?Q?NTpRg5mDFLFEi9cvIN6CyiVt0e9Ck7FsEsC49wHN4GHKaVbYWZMZIEaJPT68?=
 =?us-ascii?Q?PE8NK4/mz4om45a99sCeBe4i/pD5vX/IOHF8WEVL97DhObEzERAt/DHdownx?=
 =?us-ascii?Q?VAzpcaV5/KRAPksL2BxMF9Ea3PP+IcHjN26y0NW7ia6bd7VnJOi/bADqOh+v?=
 =?us-ascii?Q?kG/pPwj9CDiBiqaQsVDtF3EknI7Fq/0MZRAl/MJNu4NHwvruaxIsD8O69Sb3?=
 =?us-ascii?Q?0IurJ8hPAysV/F61ZOkdIJwFeCRnvTuR9H915KlZmlJa8nvhkOphbKekhCYY?=
 =?us-ascii?Q?OYLSD01s9gMTWg4xOMskGtINEzNoAWfR3HmJWupCdL1vyzLGHS0+R23dvkHB?=
 =?us-ascii?Q?mkdN8EM1UWCyuHeS5irqhNfHq3A/+ZqYCBBpOHWzCaDzLRfcKEf14gTcA/Dd?=
 =?us-ascii?Q?AsDhwv8f+k4tJi52rYd/OyAhf1rw2pbPkaOuplxYxXijT0Xek/icnH50HXuF?=
 =?us-ascii?Q?Mjva2oxinMBI1NN8jsChT6fVFRTJJh6V3laLMN0ACsmZlnLjq9YZjr6UFKoG?=
 =?us-ascii?Q?M8ltajQM5/tPZMrJtqiJ6V2B7OP1alIifkfBEKlQutMOlPxlBEpqa6Yu/2vZ?=
 =?us-ascii?Q?rSTHaCbGCKSATjKDRXBHFBN36ZNbvzEOv2xy18NzWG9mP6lMngfkadfCTGV8?=
 =?us-ascii?Q?eeXZ8UgBx/LZ/bTs/HzIdlkUVrJJlr9JrP9O2Xy3VIAeJTX1kIFOW1LUv2no?=
 =?us-ascii?Q?hbp0bFTx3KiCb49gei7lzuYnJd9F7HHrtiZB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:05.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447da0d9-badc-4627-fddf-08ddc44ed770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
Received-SPF: permerror client-ip=2a01:111:f403:2412::61a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
---
 include/hw/arm/xlnx-versal-version.h | 15 ++++++++++++++
 include/hw/arm/xlnx-versal.h         | 12 ++++++++++-
 hw/arm/xlnx-versal.c                 | 31 +++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
new file mode 100644
index 00000000000..46eb165a2bd
--- /dev/null
+++ b/include/hw/arm/xlnx-versal-version.h
@@ -0,0 +1,15 @@
+/*
+ * AMD Versal versions
+ *
+ * Copyright (c) 2025, Advanced Micro Devices, Inc.
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
2.50.0


