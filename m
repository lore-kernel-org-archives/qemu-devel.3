Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC1CC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytP-0007F6-0U; Wed, 16 Jul 2025 05:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys1-0001u5-B0; Wed, 16 Jul 2025 05:56:15 -0400
Received: from mail-mw2nam04on20625.outbound.protection.outlook.com
 ([2a01:111:f403:240a::625]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyru-0006hW-Hz; Wed, 16 Jul 2025 05:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVhUYKW6eddQuu4MePpip4BqC57XdQKbqzmNkKjX2oEx0X0u6q1PEss1LF5VrhozUy6LhQcnYQL+m5Kfcwb05Fe8sVusbp1ieBMrXgKaZc7hgm18F+uEKhEz0QhyM+gqo5kUoIidrYq2vzTStk10U/ylKqdnEBOvKDBCkbUajO2rUEk9zaO4nXcK1RoDAo4mJq+dHLCGwANAXR+go80E+ctSt+RNQqcNqa4Vb3q06AoW8phmQgILqHbk4w/jqvNJQiymVCyuL6Z5jafVBF8A5zY8buiQ7VZ6FQcCHDoxDFKGTjG549rwsWgJXCpQAQziMtRyJPLlDh9D5xNLJ035eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxtJnHTQJ+6K6qTs7uDl9Wnt4WTUsntPBO+3VEVQjtk=;
 b=aJ5k4l4sAEkZbV7qwkh6bMnPP5qpis+JFsorSilJ7pMndnXN5BtGYI8F+fYvhKnjZY4YS7IYxI66JP7TUsdPqJGgmPN0BTpo75XAQTB45x1Idvlzlkuvzvn6RBV7prI8lR/i5bH4dVc0ApdZBsS866ml0l32h3i/PUPtTF3G93m2X/imTA3+e4poYM//U9Jv3/HpdV4M57ZZDjNLGMbGJy4GqZU5mP7mGPxCRjFFXl6sXoai6aZOrrLjaGN7zx7A4lIqGHmvpUQz5Yu3rNmE9XwzxCNBA5Swb/NsbwYz8KmIQa+YtPQt8fT6OAeWvycawFJvSkJcQnPBeY+mJywT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxtJnHTQJ+6K6qTs7uDl9Wnt4WTUsntPBO+3VEVQjtk=;
 b=ZolBr1FGny47bhH/ElWOqzbzDgZsysNx2NrMQ2uwnEvjAuD6B8btjC21tdzG7k00y+TdCcj4mZAjUh+wO1nZh/5wFn+u3vl2Mpspfpe+0gK9YYsNpr7eDgB4KIwvOyx5WiZNCgacTe8KdSwZSLcaijIvhZGJcd7n/9wPZyjXUm8=
Received: from DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 09:56:01 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::98) by DM6PR14CA0064.outlook.office365.com
 (2603:10b6:5:18f::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:01 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:59 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 31/48] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Wed, 16 Jul 2025 11:54:13 +0200
Message-ID: <20250716095432.81923-32-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: afe633eb-48d9-4973-835c-08ddc44ef8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yej7Yxeecj/TTRlJ0AtLj7aEftsBxhz0wOp2ywVmMSCB3zR7E4LgV9HzYT5c?=
 =?us-ascii?Q?5OJ5o7xdNWlxb1HeABYvVbPEO60FIZDsTSgsRcVE6lxfBm7u9KwFg5/ygaf8?=
 =?us-ascii?Q?3jeFWghDJYBN4iCDwVul5XdkduL6qgi7CDH1M7BjvSOzKwg8ZZt1XiDJZSBO?=
 =?us-ascii?Q?P1tAy4HlfRxRw6Ik+vmngmVq79IxiMoE37mEnmmbdU2ZQ3PIapU8SLr7LBf6?=
 =?us-ascii?Q?7KUWe2ABx3Xx9UTj0tP7eDZ9/ENNi92d7mFBU7SPH1CxaqnJmBuHvD1k+Mgw?=
 =?us-ascii?Q?tQDk2blonf8MpdItCw1z9t26KrQ4S7DiWqA9nDe4sgcyFamZsh3m674xQWr7?=
 =?us-ascii?Q?xn4ORCFNhg08fQU+bo8dS5xUJHBs/+Gdz3Hkuql0mADhTpg0KxE2dMfeOXGN?=
 =?us-ascii?Q?S+m2pTu6ztDXCuqSwWYPASV9bD93vWky0yHxa+um9P4c0LEkd+j1mdDlF9T/?=
 =?us-ascii?Q?9OFMF2d1r16l2DgbYPH+ZvExdBuPMJpBbsUkQCU3HWdakZCZRD8R7ym+H87l?=
 =?us-ascii?Q?29V6rec+dDw6M2ooEp79JITggEkGDG/LQS87yqOBe6H+0D1+o7Urk4Xe5dOw?=
 =?us-ascii?Q?8d5NyTEuP2obNpR4IKTRcc5W3NfdChQ3UvFrq1z8Ak20tBjp3G71E+VL+dUb?=
 =?us-ascii?Q?0/jIcW6hCIsZBBIylapV3AM6OcHZyvScedPm0IoRGg10YvM8cFhKy/mb0UaU?=
 =?us-ascii?Q?IcChEElCDrwKZf5PuKvf7+QFGVWRVqlTCj7lOHkidZI2wR0QCSePzZnjVY9t?=
 =?us-ascii?Q?hRgxz6xPhxcdjWrWx80Fgiu4EoVxYfMEl6EO+XM44tXD52NI1QdQbRBKd42Z?=
 =?us-ascii?Q?gEnGTW2CXkKoGfjWhanrReWkiE867ElkL3zOCcFUKSX3X0S24X+VoiWwSovw?=
 =?us-ascii?Q?GaDfdBBi+LecpzAxDH8MlsZfFznEvlYBXHaoJf3BRvDr7VjhHgtJ7bRXtw08?=
 =?us-ascii?Q?bgbURG+n9STFSyAdwoO0JI700tpAsNPiBagjIkY9JjrcJ5uvReEqDb7njyDl?=
 =?us-ascii?Q?lH/6SlCRAFsjnhcDAnv55qgGXc+y04/L0M9INL4eSI2SLdUD2oTEsHceUwcm?=
 =?us-ascii?Q?BYviWhrL0rPvZiBvDJWY1AdNcU+KhYMGSP1VgqDFkbWX4uEwSrVZ5EFP3V9W?=
 =?us-ascii?Q?x4LxzJcKLp/0dVFpSTnIxb4rrHffcDAvSPy9Njc8E8y2inAd7/cg+ieAzrxT?=
 =?us-ascii?Q?qkKr5fvwxLhmOp+mQ2jzIIkg3apc9BuU+Fr99T6CAOccUK+I1zf4RtLXkHtY?=
 =?us-ascii?Q?AIKAF+d+tRujUYuBNhWBaEMF/ZrzqAaalJJ7e8/2EVNqoxB9voNiqTU3fEc2?=
 =?us-ascii?Q?IqPij3rK4myjHckuCMAKYCxpCG0yuyRuKGefBMFv9SkPPpAGdzye+B2/mtmU?=
 =?us-ascii?Q?1B3CspIKg+CVObeHDTCdFE/a0w5yn01OTn0E9AjfLeT0cQGYxmoJKvWBadzC?=
 =?us-ascii?Q?C0DFtlEpbgBi3YioUDW7QPWKbqIiNAwWDDEsICnPICdCPhflKtsWrAGtWL/p?=
 =?us-ascii?Q?cJM1Di5x4waZNZkTnpKQXn9LUOdag7G/Az9o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:01.8805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe633eb-48d9-4973-835c-08ddc44ef8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820
Received-SPF: permerror client-ip=2a01:111:f403:240a::625;
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

Drop unused include directives from xlnx-versal-crl.c

Signed-off-by: Luc Michel <luc.michel@amd.com>
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
2.50.0


