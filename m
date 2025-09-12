Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A094ACA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0b6-0004vW-Cb; Fri, 12 Sep 2025 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ax-0004ug-AS; Fri, 12 Sep 2025 06:01:33 -0400
Received: from mail-bn8nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2414::627]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ar-000100-8H; Fri, 12 Sep 2025 06:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5Dk/F5KjsQxGVCXr7JZJRALr+hjWChB5v5xEnfyl1emEHZbo8yQQXJYIb6iRpsSX+MvMPxgdtK+BTfrcs38F7MpaLZDyJFiQfVwFeYc+V7h9RjG1BYfUhS0+g0xS1Z+0MsO6NCSoyKraGI3JbdX1CSkyIuN7uXab0gm5IfiH/ueCtckimwx/2YQZytjLeBNFXCSLUbuACMt8NDCfDMFxjXhw5mMtzZqhxMxcSVV6UqwU32ST/07ksjH5NcJJoPIZzIT8xMgblq8GypJcS9myvGYJYIhA8Ztm3nptyvf2xpuvKSZgVAyOdFF8Cnf8RaDyLElmwg7nvrwgaPakeoxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efn7Wd4/4cD8VpnlV5844GVHoLIv9tcZ8b9zDqArtYo=;
 b=QJuJCyHhUldw+RgB42nlg+3sDEUxZ1lfxMTBCOOJancuDDMHjDgmcwo0oImLASHsv+wueKOmJUDLzekV1M35FbeeKouZrAZ9Frmv22IZTHCCaGoxE/pEaK+F9MfUEbNBUb2hf6VOIfomS/KpP/R5tx4ntOEHaYSJ+N139oDZGaJAKS81AaUBS19A5sEjWt9nGV8REtV9pPenPEIQFpWE6nYjtly7sjDpEvL8T3zp8jMG+HWliXyMMBXYBkcPjEUlRPmpk1n9X0zLHPwalW5HniAkfrVSS0nk3pEQ9u3KX5rsWYcXu1OF3euLI6mTOLHB2z2X51kCjc3k/3kLAiF/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efn7Wd4/4cD8VpnlV5844GVHoLIv9tcZ8b9zDqArtYo=;
 b=OpcVUxbZAWCukwJPs6zz34Im1hrsgIHpyYMVkb1sbbyChH+88ZrjR/Bn2ki9+w1m8zx5uR/B+Q2UUh8CjSieB3SzGFL1A7LScCi4LN4WmNEtIPk6rSm4mELu/UZgkc4CL0iKcBV+njgI7sDkr60jz+RRAUg5k9wL4ALPz5dw/q4=
Received: from DS7PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:3b5::31)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:01:16 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::1d) by DS7PR03CA0056.outlook.office365.com
 (2603:10b6:5:3b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:01:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:16 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:16 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:14 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Fri, 12 Sep 2025 12:00:10 +0200
Message-ID: <20250912100059.103997-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f863cdd-e285-4e00-aa1b-08ddf1e35080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZW1rNFRDbFRVeWM0WWRHZnJPTkRoeGIwVUJvVzR5c2hrMlMvbk5sNEYrcnNt?=
 =?utf-8?B?ekF0T0JpZGIybFg2T2J6THZLaGJDZzlXbXhzby8zUHpSTytYWHB2UmV0L0w3?=
 =?utf-8?B?Z1JlcS9XcDV3MzVja1krb0twT05ZK3AvNjgvYW0zWTlLa1FGM3BUTVpBdGxI?=
 =?utf-8?B?Qy9hZkxsYWdyaHM4NWl4bVNPajY1enV4WWxmdFVNbUMvREdGcDVaajdSUHU4?=
 =?utf-8?B?cktXcTc0RHRHRXk4NTlVQ2ozTHRWM20zWUR3ZXdJTDhTSTJpSG0xVHNjMVdy?=
 =?utf-8?B?dXlDTjBRZFhmbHBTOWtmdkU3MkxLU21hMmJwSzVYSmVCbkhOVWxobUFOS1pS?=
 =?utf-8?B?RW1GOXJxV3NpNVlleElFcTRwUlZ0dmdSakxIT0h3WE54dTdCSHNmSER1Mm1M?=
 =?utf-8?B?akROVmpIOGtQYVdQUnZDWGJJTG54RStxZTNYdyt0WFlEZ3dUZzRXNVFWU2F0?=
 =?utf-8?B?YTcrQW1rZDQ5K0lQckMySWhSQVd4Qm1FTUE0SnhyYmpNUE5Fd3pTUFRNRkgx?=
 =?utf-8?B?RGY1QjBudTZTVzEreExsZWs1aDNKdDNzVUFDVkY1WSt4S0RTV3ZLZUs4VEVj?=
 =?utf-8?B?NTlkNTg1aVdoQWpFUFhCeWM4aXZaZTBScEN6NDQycloxQy90NXBGYnJaa2gx?=
 =?utf-8?B?bm1OZVdCbzg5ekFqYm9pdDNZODAvL3RFSHJGejhmdTBKYllDaGNhbXZ5dk8x?=
 =?utf-8?B?K281cENHUzdlYVpFaFR6alJqRjFsdzZ5TEVzUVRsZGhrVHMvNC9YK21acEs0?=
 =?utf-8?B?STR3dlZYSkx0eDMxSzVrQUZxQjh1Sll2NjdYSzRCMjRsdlZqU0pCb1NsMEVN?=
 =?utf-8?B?WktHdzVyNzZtVm04SERBVzh1OUp3d25vL1pXeFpueFBhRnp3TnBHVWlFSTJJ?=
 =?utf-8?B?VFBpVFpHVU1SeFNvNnIyZys4MUF4QjNiZTkxT1Z4LzhOOGVMTFZlVTNra09H?=
 =?utf-8?B?STIrdC8xK3REUEt3NmdwU0Zvai9RMmhackJ2bDQyZGYvZldVT0s1ZFNEd1JQ?=
 =?utf-8?B?aTEzNk1pdU0yMmdhMDlIQnUwZjRtSko4dUE3ZHdFTlR2ZEpBKzQ1b3kyb0lh?=
 =?utf-8?B?eFNLOS9RR2llNUxNVWdHTUEybm5PM3dWMXZJT1B1QXhjUytCMVh5NDE0QnZu?=
 =?utf-8?B?QVhaNTlVUHZ0cVRBOHFNbStGSXlQbHF3QlA0NTc2alNCWFhYRzlyU0Y2VDJQ?=
 =?utf-8?B?MHFZMmNYUTRpaDRra2tuVnRySUozbDhrb0lhRDdjRmVnYUc2MFpCcGZpdm1L?=
 =?utf-8?B?OEFVU2hpcU1DRjZhbXFrUEp4TS9qdWhRR1grZmlCMU5pQUFWbEhkaitxTHJw?=
 =?utf-8?B?c0NMbDg4Um1oK1dZQ0VORmhrby9xTCt0U21nYkkzbG5UNERmNmFpWlpzZ2tu?=
 =?utf-8?B?QnhtbVhzZjBURWsxbUU5R0NlUGRMazRIZExHSDQvd0RUYmtmRE9POFRyVG1I?=
 =?utf-8?B?OWpIbEhlY2xwSG5GY0ZKcEtUdkJudjNtaGRXRHVsLzU5cFc1RjIxQ242T2F6?=
 =?utf-8?B?RGRibnRpeEwvYWVHbGxrTjNEeXVnMWVHN0p5V21wV29qVHc4MjRVdkxNdytw?=
 =?utf-8?B?TE5MVXZqQ04raXI2ZkxuaTVEbU1CRnh5VmQ5NzRKa2hoaVdVYzBMOElReFQy?=
 =?utf-8?B?MlpHN2duNVBZSzV0K0VOZmJoRHFMeWh6UmsrazR2MjdQaER6MzBGOEplVVEy?=
 =?utf-8?B?V0U1b05zc25MSTlTeWwwRTR5aGJIYXoxN0xFK3NyR2JyM2ZicGZmSHl0ZW5o?=
 =?utf-8?B?Wk5vdUVLSGZ1N0lnWmV6V1hrWG1pQUs0VkZWY0JUQjBHdUZIMnRMT3pxRHpt?=
 =?utf-8?B?Q3dIa2ppc2lsMW85Y3U1V1VRV015dnVoNFYrdW1aT3BNVzgySU1FVnU4M3N2?=
 =?utf-8?B?SjFhdG9aRytsZk9ObnhnS0RJNENibWIwM0lPS3Z6eS92VGI0MC8xMWo4Z21R?=
 =?utf-8?B?bzhJYlVsOThnbnNJY1pPNGlUb2t2SExYdnVCWHZMQzA1OXo0Sngyc0JoUEI4?=
 =?utf-8?B?cnBzMk1HT2RtVGM4cHhDY0F2aVJicDEyZDNDVXdSYWdDdUFCbHRwVW5DRmNL?=
 =?utf-8?Q?zt8Z+4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:01:16.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f863cdd-e285-4e00-aa1b-08ddf1e35080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
Received-SPF: permerror client-ip=2a01:111:f403:2414::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Split the xlnx-versal device into two classes, a base, abstract class
and the existing concrete one. Introduce a VersalVersion type that will
be used across several device models when versal2 implementation is
added.

This is in preparation for versal2 implementation.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


