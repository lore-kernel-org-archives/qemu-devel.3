Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E20CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eG-00016a-AT; Fri, 12 Sep 2025 06:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007R6-Rr; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-bn8nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2414::625]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cf-0001N0-75; Fri, 12 Sep 2025 06:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfOZnT2ZRbvzEk91bz/+0H7awOrvUXnpSZFdPYamSetCosxxQSNTgD9NOnEKGJOabZGNzk9614VT8vp7pIY8LQtt+DrYDXeV3bGRP+eV4cYjlB5t+s4tW3OHq1VGZyREPzdWcIs2g0/a/3yhNap8XdhJoSXjuNyIDv3yUKdZ+/YKOxCIMTcbrqZtP9jIxbRonxbzmq1qkjQiIWTO7k2XVTiEd44E0Qs4ifF69cIegwO6mjCHya5l9QotIT3pcvkWckSx/mWdnfL3qXE/Se5MBVCWBJbhN/Yq6MftXWCBE2b7y0gQKyF0iFotD/VR86wSShoHgQZQsJMMSie2guEf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=IRZSZl6HkqY3QDw/LYF2GPpbnAdk0YAQd9Zc8uCqIn4uqkOz/JHGU9ftwi6fq9oecrhCSqmnv0osNy8jUcjSYWLPEVz5RLAHSxjsuqIEuJStka8vChgMWmjAoDHHNIRGEeKKUqClOVok9EEHOBXHYH+qtBLRRFDiOoaWkr+cuccu1Tonu+6LmTbkf2uEBXKGel/Mcm+t2Jgn+iWf+6/IEiQZ2OX9054ghCNz9hjQIYP/E6mo7cgU5iU3tdybkL7TVFhCQN0U1F1nBick2lfOOtQUAuDgDrzJgCoeICiM0xioBA55YWsozAiaI0WTrl4lagtPrKuR5ObkuOfG7xTgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=rZG+KIVt51Bb5HqdQbDv8h1B9KiLWXMQgBWQ0TzE75PRLgFjjlYd8E6CRAhSVHazzE42yr4d3T6+5I4+/sTBWVCKP6EITIbmN0nZ5oEkahfIV9OeDd2ZfF8yR3dngSREjjdTyvdMmeVonA33R0chrS097CF+4D7Uj0ck5mPnBBw=
Received: from DS2PEPF0000455C.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::514) by PH7PR12MB9103.namprd12.prod.outlook.com
 (2603:10b6:510:2f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:07 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:6) by DS2PEPF0000455C.outlook.office365.com
 (2603:10b6:f:fc00::514) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:14 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:13 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 30/47] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Fri, 12 Sep 2025 12:00:39 +0200
Message-ID: <20250912100059.103997-31-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: a48ef7d6-fb94-495d-51f2-08ddf1e3923f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8dfhtHaOIEPLMdU5/BDNXMPwSFF1d8ZYS5pr6gAz0jY25Y4VxfvNtY3pLPAy?=
 =?us-ascii?Q?8cM8O7YvKAmC6/tQ7VFC1wBp37wdCqtEcSkZ3bJHzFI/FF9Ohi9nUXlX2vgD?=
 =?us-ascii?Q?O5Q773d4hnfL2bxdrT3UmUqVYF5oPE7zOjD5Cvpfq1RuIdluuLMherOaWG+S?=
 =?us-ascii?Q?PwfrlUyLGeA/hqvkyOdZZ/OGLfCtArXxRedwVIhRXUf7INiur/OvGsrZQpAF?=
 =?us-ascii?Q?L6X5dUOX4PUUsianwxa9UqL6r7+CHGxD3yoiexqLohrFQTPUT1pGMNEPrN5I?=
 =?us-ascii?Q?Ulf7qBdnDWAyahxSItZHWDS2pac4GG6csWbHKcsq/cGx/ZSQFhS9w+Je09ev?=
 =?us-ascii?Q?h/LOUHLcpEevscbbTVNp1wHHHS1zCho5kq8yDGG/gjE4xry0yIiQKvHck2AS?=
 =?us-ascii?Q?uIpDfJgAHpefd2reJajEeaeGgsuNVug+bEMbo1IZau6B176Mz9Sr301eXV0j?=
 =?us-ascii?Q?gHWxhR7PneaX/S9CW9WQvCe2W0nNkOBFpHPQa92oAY0ubn9KAEqonNQRBJGX?=
 =?us-ascii?Q?CA+njKTIrGnKJBAgak+irsLk0vmlFMxsMfBa2l08zEFpAilPX3UkrIQhpxI0?=
 =?us-ascii?Q?RNwMpfRLgmsme+AfMHL3R4bEtictMIHEADnmjpOsy5gxOIIHAPrSHnW3RZT4?=
 =?us-ascii?Q?59291nl9oaC4RJUoL1NPeNd4dsNOt+7l0DGtjt0MsPq/idIkWgSUlKU8oGEQ?=
 =?us-ascii?Q?ER35DWExYqfO4HjfxKX0hMm2mjb3Cq+HgiVRp00KC0vSsfuoO5BeC5PApYw7?=
 =?us-ascii?Q?yWUsbD+biQmIG8QYQGPwtGC/2kHs1BCtQLNM/PeN4ap336iZqgUMmNUOYYjz?=
 =?us-ascii?Q?gKxxAxOegFgmHIGB02WlQPCLANCL1Ze8+vCqX4aJ9KZfuYo/M6ktDnItAABl?=
 =?us-ascii?Q?XNURNC5Yxw0vM+RmTd4EdWjTazesR9emBjd0IA25yCEmZCaz8Ralj3mzB9+w?=
 =?us-ascii?Q?VfB+9ROoQ8f5cawh0IZ4ghIpt8pVJu3EHJDenHMoev+o6OPZ78cGBbDluyef?=
 =?us-ascii?Q?Od4cQZrZ3MhEwowfZs97xwjfy05hXVYqfV69S7sPasptatGWfENL6Gli2nKJ?=
 =?us-ascii?Q?XALmuPjXSzDlbEHTbptsXO3icfWEPbJqVMg5pdemanWlWJPQb186km7/Uz2w?=
 =?us-ascii?Q?Xx5+vSoSLT5A/eSjVjmWb100mhKH22gXa3FcSYb43S7blemfZZ/Ski/odeCq?=
 =?us-ascii?Q?oL01WOh6h8iGylZLW5Q4ZNRqiJweFqOuCxNsaFKAupbG1wz/pNf4Uc+sJKOx?=
 =?us-ascii?Q?E6Hjvez6T4jIAo1DvfOhWpDx/ZXPMdyWGTf9tQJho79sK5Mf2R1aJQNYMoUS?=
 =?us-ascii?Q?nUcBmihw19GAMujgvNob3kJAoKKyY4RsDm49Wehvojsv6veRwSRHtai/xkE8?=
 =?us-ascii?Q?tbX/bvYSHVUOp/8iANd1Mnr6bHckjkCvcH1NKIuE2L4sKvQBnHsPdxhvJUCf?=
 =?us-ascii?Q?j0n7L6sLu0UObcJRTTOaAntpg6cKirQOUiUW0LDOv+Z+8uXv6glvZMpINsSg?=
 =?us-ascii?Q?VVuqJRR1wzs1A1Ro8iLFmqqjPXFEIdICkBIF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:06.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ef7d6-fb94-495d-51f2-08ddf1e3923f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
Received-SPF: permerror client-ip=2a01:111:f403:2414::625;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Drop unused include directives from xlnx-versal-crl.c

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-crl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 08ff2fcc24f..f288545967a 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -1,18 +1,15 @@
 /*
  * QEMU model of the Clock-Reset-LPD (CRL).
  *
- * Copyright (c) 2022 Advanced Micro Devices, Inc.
+ * Copyright (c) 2022-2025 Advanced Micro Devices, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/log.h"
-#include "qemu/bitops.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/register.h"
-- 
2.50.1


