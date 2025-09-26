Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2E7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22ZU-00062L-1z; Fri, 26 Sep 2025 03:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZQ-00061N-Fc; Fri, 26 Sep 2025 03:08:44 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZE-0006Wq-Ge; Fri, 26 Sep 2025 03:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA2wjbucjsqK2X+0xxR+z++1H6Lq5zHsXizdjy3InaqCqu7n5xZSU4XLL/S1kPiZoabyUcYBOdmUXesdXn3J59VmigpEWybdHZ/+bBVmZdGdOzJvjFa5XLKkwas8MFat+TUAaQ2SjRuelyyVGR1L+n2OtrCUo0EM3wYI/QiJ2uCV9jK9qhV5sMYPjtRo5fkipDP91vwOLTGz+Ctw6nD/tiUiDMEc3waGJQzY/6dqOUZ2zvVE5HcVrHh05lUCUzRpB4eYRs+cYjGGAa8QEbi+Vm38Xpp0nZH1SOCUfayThPtxLzHX3Y91mXthOL9RBgrfNpKPkur1AC9+CbFQ93uyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrMEU1EEBaUdUNQ3htGxJzUKiNgV5HGqcodzW67nrBM=;
 b=hh0FmvbkX72GFeX1lWWu1CLdJFIXmS0OdpMZwSBUISAVY7mVGm0pjgpzfX3XWCf0cEMYt7pHOAS2rY4xlOIoh/1Dt21mhfOKlDoAZe36z4+dCKibHCFa1DGB+OV3c2S8YpH80aiyKgpcVgroKvDmv3JMOGjvBXRR20eOAjjasJtMDruaq63i9QOxshiWTYTxP6NYzulxDP5C+mqlcvwabnzFtFoqQJ0GrXvBOrETC+e9dME3naoSE7Qfm3sKMTohHeF4YqaMiKwVWYn2jvDhcCJ6+QkrhfFLd64h9fh9CY3EpkuH1/cfF3hAz8jE/tnrQ0lyarHiLW4xQrz1Bh0V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrMEU1EEBaUdUNQ3htGxJzUKiNgV5HGqcodzW67nrBM=;
 b=KvfLviVl5nHa+omG8ApM/cAS1wDdTSdKUT1e5OYEqfD+A925CufanJIZea7CWTLn6e0SlgqlDrq6UMGTedldL+f23UxOCBEl7SmGprxw4SSwyvv++qJaGynIbeBXdNtSlsRWPTVAEbej8gFGN1a5FOoxBrEVIlHMwNvL/KJAw9U=
Received: from PH1PEPF000132F6.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3b)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:08:16 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2a01:111:f403:f90c::) by PH1PEPF000132F6.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Fri,
 26 Sep 2025 07:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:15 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:15 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:13 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Fri, 26 Sep 2025 09:07:19 +0200
Message-ID: <20250926070806.292065-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 378c6c8c-ca00-43b2-7dde-08ddfccb76f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ampGTWVMc0c5Ui9YVkRwV0hZc3dlOUdwYmpWRVZMZkVEeUZUcngwT2lnQ1dp?=
 =?utf-8?B?cm4veC85WEM4dWswZW5nS2tyR2VwMXVwTHJFcGxUbE1vRkNTTGptaHk5YjJ3?=
 =?utf-8?B?RUhNU1g2dlozNFRQckxLTm8vdDVhZVhLNVBKWEIzUnQ2OGFRS0xaRlZpTVVw?=
 =?utf-8?B?NWRXZldqelU3dllHWGZmQ2Q0L2pZc2xhQzlFRDJURVI4TDRGRkErR2R2amQv?=
 =?utf-8?B?TFVDaml2SVNzWTdOMjlUV2FDdStibmdkdUE4d3RuQVNwQ0daaDFxWWdFUmIx?=
 =?utf-8?B?N1pjZkZ5T2tuQ0hONWloVEh0YzhnalQ2MGo4aUpMYkhRd0ZMRW9zajljQXo2?=
 =?utf-8?B?VTF0TlFmTm83NjRzTGs0KzgyTXJGUGJid1Jyd3NoNXNIRmRDdkR2NENKaXZ0?=
 =?utf-8?B?RWJzbW10MFZXQWtVYmZSMWViODJPYWRkUDNkclErSThmNzJOSTFVaXU2aDEy?=
 =?utf-8?B?cU9BdXF0R2xzM1U5cTNnQ085QmZZUUJ5djZpU0Y0S1I0TVdRaCtCUzQ3Rklk?=
 =?utf-8?B?VUwxOFhMR05OVVU1dkxFeldGbzhnV0RSZnNNc1pEaWxWN3hMV1pQWGZmNXJs?=
 =?utf-8?B?M1FrZkk4RTdIWCtwdWVkL3pZRHVDRWFHdmlIWjZQVDkydEgzc1VhUG9Td1BJ?=
 =?utf-8?B?d0p4TzhIaU9mWFR0RDlBeWRxQXpjcksvSVRHUHdOSzNGSmtneHhBNlA1azJx?=
 =?utf-8?B?YXVCNzQxZHlJR0RRSFBJdko3anFxL3RwT2tnVktGSnFJZEdIODNjdjU5czNJ?=
 =?utf-8?B?ekpoZFFUS01ZRlZwdWwwMDdDSXErb1p1UDVka1Npa1VFWVdnaEFuMHNsZG5H?=
 =?utf-8?B?VkhmZFAvK2NUbU85VVdSem1hYThJSlpNdWMrRUJjQTAxckVhQjZWSXVoSngx?=
 =?utf-8?B?SkhHc3lRTXJZaXJ5aWJLNjZZQVdFVDRkc0dWMHhCWWFrQm5VL2hsWVBoM2la?=
 =?utf-8?B?ekFiazUzNWJSNlJvWGxzY1g4NjJtVlF4TTFROEdCRmwrUlBxSXhpQTZYWkJM?=
 =?utf-8?B?dXZIdGNuSjRvYjc4NStkYWhpazM2SmNSc1ljSVB4OWhCQnZJM1VVbVB6eUIw?=
 =?utf-8?B?RTdNelVxNXFQS1REaWhXVGovM2JGUlVKRE5BVVNqMEdDSWJ2Q1RqdHlVSVlH?=
 =?utf-8?B?WVVNcFV0SlduMkNxOVR3b3kyUVNkdUhOVnEwME5EQUczUGJOSFlFZm54QVN1?=
 =?utf-8?B?Rk1DMTNBVUdXbXR4NWNkSXRXMExlRDl3R2xOUFZTcjEranlBeGNQbWJKQS9v?=
 =?utf-8?B?RWQrMU5GbVNzdG5LZUdJQWR0UEozZHZsZXN3K2R4OENDSnlUdGpTVGFpazVO?=
 =?utf-8?B?T0lBNFlHNEdXOVZDcktWQXhtTUNKKzZySmFjL3pzTldjd3hzZyt2cmpkMlZj?=
 =?utf-8?B?ZGJrck1ROTdvTDhPaHJFWFZQNnVDdzJIWkJMc1A4ckZPWHROUDIrZWtuZDNp?=
 =?utf-8?B?cnZxVUFmWkxaMHBpSnc0RlBuNEtoSzdHWTh0NjFHQzg2akdRRHNmc0ZVeTVZ?=
 =?utf-8?B?WEZPTC9UVk5LZU5xM3pBMk8rVWxtS0hBcCtpNzg5ZEIwQXVYQ2QwNWZDT252?=
 =?utf-8?B?QjlobEVMS0tQTzJ3RGJ1bFB0a1NrUnFTM2pyVUp0U1QydWRMS2NLU3IzSDh3?=
 =?utf-8?B?TUlzKzFaSm5zd2ZyUHcyU1ByazhMVDUxblArWUdWQVJGTWxVVGpzUWl3OFAz?=
 =?utf-8?B?Y0hRc3lsSGNEd3RYTTFJVWNhVTVCRXRwQWc0MUZmeWIyc0k2S0krcWJrZUxi?=
 =?utf-8?B?RDdYRElsa0g5Uk5QZmxBLyt1WkJFWTMrN2ZWVzJqcjdXMmxRcDlsTGM3aXN1?=
 =?utf-8?B?WXRwNjlnYWpLMjhKUVpBUjB5TVdTb1hzUmtRVndJNkFaeUttVWV2S2hUa21h?=
 =?utf-8?B?elIxYVN3amFSeitEOFE2c0t6Mzg0djlHUk0wMEhSbVhOSkRMZWRBOSt1bFBt?=
 =?utf-8?B?cnVzak5SMmtFQ2gzTDZ3Tk0zeGhRZWFQQXc4eTRKK0FqQ29RZHA3WDJRS3pM?=
 =?utf-8?B?eW45aVdxRVZLcjVjaEp6VmRoVXczVmRVd2dhMW90bHRlMFVYV1ZlSWlIMWV5?=
 =?utf-8?B?YnBtZEVlejErMFZuMVEyRCt6Y0szT2pSRlkwY0VNdGtuem1GZnF4enFDekR5?=
 =?utf-8?Q?RWpI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:16.0475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378c6c8c-ca00-43b2-7dde-08ddfccb76f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Luc.Michel@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


