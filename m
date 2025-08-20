Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569CFCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAV-0006yw-HR; Wed, 20 Aug 2025 04:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAR-0006pq-Hj; Wed, 20 Aug 2025 04:27:35 -0400
Received: from mail-bn8nam11on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2414::626]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAK-00015h-W4; Wed, 20 Aug 2025 04:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpboGf8I7CfSbaaUnT36UVwejYCSP43FcDBQ9cnltPI4Eg1pLbttzoOuJKACakjAkKciKcjET3smbtVDK+ijY9ohBi/FDft5AQKoDBQwuedrWqdeEhJYvJqnOUZhrwKQmRYPLqzofap6qoLra9S7BVTVV4+mk9qa6nMuP8FB3MuQ9TmzaEbVbzckXG1DvZT8e60iFqsnx0XnAD50RK5ZCzadwPbXHOx2jWy2ryYXGRde95MXHF8PIMqHZOB5lL8JNsICP4A8h0I+Z224IQMFQUPpefEvzoQjSfLggYaTBewySG9TLBFL7Ep5B2yS80rjSc7ocj9DiidRM5N8Vl/UBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=FOUDDQ+1utHIMmPHaTFERhD7Jq4PRFgEF6oXB6L82eEYggrwaPSrJwf0eO3kN2oKhpnpgzAQh9sxK1JfOIDo1BwiQCTp+svO3yUAL+XDRYuVx7rF4AuD5eyZRdH8Q0Z4apZH/A/cmnvIDIySqKghA42OjpABXNl5lT2Vn4t5N8uUeBCEsKZGdCE/96pma09NxoPPozn+wjKyJObdS5NRgC+ngP5QBNUD95AEjEZUQm71tvhCRWLnhcN7TQlFj/+BLRqWrQjpo5jUcpltgkM5DRKser16BUtAVeBbTIJB6pb2Z3Y3r7t4hl2x2lFHanpolNFqDBHZKDUkQiq3ZULmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=bakB37GIGlS0HSbU1F/c5FuOorxMeQgNctnC0ocVbwSN9Jywc+F7ITRz0OdG9a3dVnQNHHZS3s9CTeyC5/wyBH+oVVQrU20fuOOG0RdLZl5JHHQWH8KW/okuvnqlRu9hLzQdhKpQwKSPFESKDamhI+v8cnUZeuLS9Mnu5Ay7UIs=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:27:15 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::30) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:06 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:05 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 30/47] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Wed, 20 Aug 2025 10:25:29 +0200
Message-ID: <20250820082549.69724-31-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e07b5d-99fe-45bd-e24b-08dddfc35e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pUQ09UlW93/dsWW0uP4dokbfg3chV2o4jCvn8pXDlqQ/sh7BKE5cUszIWB10?=
 =?us-ascii?Q?YRH25F6gMeP3vQQCky6cb0vDS1vqelljUFW1BEDfeM4RO4ZTEk7VDHQVEcAq?=
 =?us-ascii?Q?L7HMo/eD2epcj0Zm9PvbzNLnq/kxJOu3IILWYA/4o75fPpQSs0X7vM8vEex4?=
 =?us-ascii?Q?Ff+cnvH75BmxoivY97a6p+r4Dgmte80mF9Gnf7Oq8NNqV/9mFWsnV42XB7EQ?=
 =?us-ascii?Q?kr3Qm1OKXEtPNdQJQOdDwzAWhDc9AililKWNdWNTCRMtxWgH9cOVkOHbaYvG?=
 =?us-ascii?Q?jWMln9z9P4ONbdbyXQd/qL1DgfK3eb6e/RJm8UJuonLtANBz068oRpn8HBLh?=
 =?us-ascii?Q?Gf+w02RkijRaBZmugf5WUs80iZRv5QNp4nYZs/dNgcRoqJmnfhrKjWP6aoTj?=
 =?us-ascii?Q?SyP/sS+dSmM4OfGDQoFx3iOXhFH+SuMoNtOk6db3cBEhVHsvku2RhTNcxwiv?=
 =?us-ascii?Q?+24JuSlD88rXD+3bf/t6M/S7tJrCTot52R/4/eOq03w3vFzYyLRAFVX/h3U5?=
 =?us-ascii?Q?gTdduR29SPMytdBrcDOClYb1LGZHhwB6zTzAn+yGV6Xz6J2ueCUC+/jq+gag?=
 =?us-ascii?Q?8S5TAZ3yJbpzexb+NtSYvHKClE/jviTIWDbsPsb5jySv0z+w8ebGvJb51Z7O?=
 =?us-ascii?Q?esSRUoGNRNbPuy4I2Rvm9XcErDoVaaT3aJ/V3kXV/q+uSjJOtwpAQVtJk602?=
 =?us-ascii?Q?qmu+MKjsZqEoL5ORt7CuMIm9wt3MBhWoMbg/cM2B/TklqeM6Np3MgE3POA4y?=
 =?us-ascii?Q?el004Xg8Zu90Efu/wD8c4c9dOrQzzYQ5JNwzsKtp1EnEjMcj+qcT3EFBZmdV?=
 =?us-ascii?Q?adpG3ijGRojVxWbbMwj86DXAvsq+6S2tULjuGNjKZBrldm6GZLIDDf4uEvGH?=
 =?us-ascii?Q?dVyqjdi889y6JDBy48W/2XbZv3O49AlMBraYKJHLK0G2nmC3/hMxkn01+Fzd?=
 =?us-ascii?Q?Vt2Zg1dhIoe14ajHY14UWC3FxVfoTvTwLoN1E0Ju7C+Kr97bQuU5eV5bxGA8?=
 =?us-ascii?Q?vJs0LjF7FlDWXpRaPe/v15gFr4Sp4ULWWuinGbH3j2m0UGv/WCEPoGPq0F+n?=
 =?us-ascii?Q?fFb3xs3WNPaC0F0nARCzQfVjyFfy2bfTXoMNnFncjXivbIjCqXvc9CB3saJm?=
 =?us-ascii?Q?XpjKkZWn7cADhDLyoxRWXfSkwwu3e+TvK3kPx3oUGdONv5vTz+Sf/sS+oUFo?=
 =?us-ascii?Q?/m5YEFJ2GzWjN7Jyt9UmwzRAXIYI0hgHWXiSaE3k67ZdacPRcOQZC+wXIYTw?=
 =?us-ascii?Q?WsQyosG2dmEZ0p6Od53Km0B2usWsX1uH5p7BQ/eo5JAHCoiu82CGhTrF2026?=
 =?us-ascii?Q?fMV2+ms1f0FPmrKFONQXJ9DfWY9s7TuEGgUeF0yIhElIPRQznf9CNRn0W/q6?=
 =?us-ascii?Q?b8o34wGMo3SFtk7FessS96T82c5QHDKu3TpNknaeBKi6sghWXwhwdNjY2j/v?=
 =?us-ascii?Q?3N7QHJ8wUhQnmqSBJu6xsOfbRL3bg5JdyQDfIy79D790LV3kMLuScpumHGns?=
 =?us-ascii?Q?Hnsk6G4GaO1u+K9h7efFFvZpampuADgmilVD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:15.1387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e07b5d-99fe-45bd-e24b-08dddfc35e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
Received-SPF: permerror client-ip=2a01:111:f403:2414::626;
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


