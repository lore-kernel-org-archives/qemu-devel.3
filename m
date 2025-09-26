Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B00CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22e9-0003Vf-PV; Fri, 26 Sep 2025 03:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22cD-0000oX-Ei; Fri, 26 Sep 2025 03:11:39 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22bo-0007DP-Pl; Fri, 26 Sep 2025 03:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO4SxqzqnvnWHCdkTc3zOzXv1+eZegtaxCVnBM0jwhUVJiquYtEOpvTgSAwjaqbDTzpOjMR10TrEKeuPRE74/XEDpUjoorN1ZThKly7yHSzds2nR82iUDOlVjCPxgpFEKJGCMiupoJOMVtUbsoupk5w2SsGOTBPrxSeYHBtlKDpBVrM89Bl6EC+228lgg90cU7d+SB2+bM9BLY+xnPwIZHXgMiTKAzG6vA3OopONcZsRX0cHfzMV6g/hbM3xtuuR4Kv/cJcF1ueuP0b69hALutJrnvSspY3f2p7Anrw/4zHSCMCG2xF/wu78GMDLB0eFwBJoXllO8RwlEA/YMkifGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEieKK+HGru+BtGZoyCsQqTq3aOvwwWynxa6zrFFDOY=;
 b=uMNbgdKNRf/xz3OsjieLT2L+SjtBbBhBLHMCQFPiy16WW/VsqIsCI01ErcXUhC6en2c/1onV1NSoPwqmYGvW3PXV0FRjLywEfCFufoP5YpmKNfHG6baMwEqTxiA24C1yolGaHu4reIhzeUISp1llrRclwNRom1gaqjTl83F8yxCrKG+3jweLV0TqhjJK18AIpcUbEl5GAK9nAyP2+BVrTMyn+tQUZ3bqlmQFRcnT5xyEk5B9rtci0WSKn0K+VMWSv4aXEHFm0fq6WHbhdcoNojoodfV1Jd+Bnd2SeCl4K93FpvXsCNjm7qOsKXgrq66qx9aSvoFF6QjQiTkXCCf69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEieKK+HGru+BtGZoyCsQqTq3aOvwwWynxa6zrFFDOY=;
 b=NAbQ9i5WgcS/Ww6kqRAOrjnrPFH2bDPhR6hZFQS9HzyO8UvvwOZDTMMUibrJa4ryY3bch0jcBkgDQ84UA6pWXP0we5b5YmLOWE+kfvGZ7ntewnB1kQ49213WhmtnZM+qx2+GPxCchUVz04S4EHLGOmeWEEf7D7RPf/bZtYc7Vwg=
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 07:09:18 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::4f) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Fri,
 26 Sep 2025 07:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:06 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:06 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:05 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 30/47] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Fri, 26 Sep 2025 09:07:48 +0200
Message-ID: <20250926070806.292065-31-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 1999760c-e565-4d4b-28fb-08ddfccb9c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?32w9EZCfaqBmnqJAFF1K6YgmpM27T/xlGi74Od/nOpXS7vrKlRWa3yvg/5Q6?=
 =?us-ascii?Q?unSCFpk7YjkfvjPtA14gXXiZZritBInaMBUGEbOr9oUYKXCVFc46L0LpbcjL?=
 =?us-ascii?Q?jss08e7lDPFqKZ/HnqbS39qWHzDAnIbM8rLXLUJZlcBhL/s+nm1MjSYTv2g6?=
 =?us-ascii?Q?7GA6oELqfMeoudBaFAExgziwY/APJzLFlizPNi3bRB5R4FXIgvyjRsdYdF0+?=
 =?us-ascii?Q?RTmBI2dM9tZVGCLVftzogFOHFn42pWP3fkNkrTGRD4T835oOJWXWqHZuw3Hm?=
 =?us-ascii?Q?8ueTzKuF4+xCGd3cbADHnJi1ZJ3pn7g/hcBbOQea0AHuXTW223i3fvsoWEKY?=
 =?us-ascii?Q?Cqz+0koTb3Kr5VJqmNYnu8cLRu1jLcH6Uvh1nLG2BK2mKh3wCAj6FfbK7PzZ?=
 =?us-ascii?Q?1C3xcrvbHLPwPNEUYH3E6cd40j5Q+tuBe2UUczdeGVx2etZwPEfrXh99lw62?=
 =?us-ascii?Q?9+rV9vFlFrG505byLiAIWoCZuCzHELR7LOA9yHJDK4rmaimwvGb6BA5DOwRX?=
 =?us-ascii?Q?Rmav4S1k6at4WvLlI4Gl9VOA9Wg1BF0l9KuV0WU2zsivNxPQLCQNAgi05/zt?=
 =?us-ascii?Q?sFvbZM/u4nARXFvo1iPTxTMNZheKTSGlF/LyAXx8NW2L4pHmkW8XTOEFRAur?=
 =?us-ascii?Q?TR0BV3LucAnnkCIS25rLcWF4w1wt8WMVr68jDxuOWBQfxh4WiXtdwZetI+0s?=
 =?us-ascii?Q?Ali7s6WECamfNV9E5tmAeK+RIYAEUOee0k2azDkcXVfgmRw9GM/qAlHwZj3u?=
 =?us-ascii?Q?U2DoWe3VAgntdzr9V9Z34Mw+5aQC1Y63ihEvVUzWvTdqGwbK9AXJQavD1vUF?=
 =?us-ascii?Q?7Owue/rls9nx8sza+TwFM21/Mpd0g1X0YMGYJ/vLQAGIcS75qHat5w/o435T?=
 =?us-ascii?Q?T/eR7mfOTOgMfiIECxMXqXrj1EYo/1UAlTxAE1ujchDXz1q0dHzuZkgBdbZS?=
 =?us-ascii?Q?kJD8cKv410Dxg55VZtq2+87G+yQ8ZnoQ1q1STyCL+S1rnDOpMktZjjf3upzv?=
 =?us-ascii?Q?7Tzf2eJO/BN9leGiuS3CrixbzfiB+cVqmRGrS8WicXJpWZWTDGqDpXjwXkwV?=
 =?us-ascii?Q?lLANKUHH7VuKTsWvFQr2KpQqOkLp4mGofoprJ0yjOF4Q12xr8vgRWGub8OAL?=
 =?us-ascii?Q?h9XIhHBVWZpZHXLpU9xDl3mpioajwRkDWYr2r+Rz3TtQs7LmFtjqHmOCjNF+?=
 =?us-ascii?Q?ZkwX/t3I3/fZwPSZROK1cs8Z3Im+VqA5YtGPLyijCWHBh5UIuYvQ10FHxr4u?=
 =?us-ascii?Q?b2vYAsB42CojaI8YoeBfQdCKork6aaH2i3usjMC+r4CnsPGz1uLHp/4KE+KT?=
 =?us-ascii?Q?iI2/WqQ0VPwR5eEN7gFUBY2wYCmrygnVbo4kOjuDFBeSdY8TT6/Wg2Xg0hM3?=
 =?us-ascii?Q?OtMf7X/AxVV2HDYkphnXyVOXDNSoYm4maF0DTDBxslv+fAyjyXcKXhbh9ZpM?=
 =?us-ascii?Q?a9G0Q3Tul/HiddE5mO+dT4d1pE/b8iTjcnWIgLRtQv/GtRFbITtUB5a1ebeX?=
 =?us-ascii?Q?HaKwhF9LRAbT5n4kTNkpdvKiI5yWBbFIwl6c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:18.5155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1999760c-e565-4d4b-28fb-08ddfccb9c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Luc.Michel@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Drop unused include directives from xlnx-versal-crl.c

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


