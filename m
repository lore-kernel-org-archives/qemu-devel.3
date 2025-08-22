Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20746CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXV-0001Dl-P5; Fri, 22 Aug 2025 11:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWY-00089k-Cp; Fri, 22 Aug 2025 11:18:03 -0400
Received: from mail-mw2nam10on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWI-0007DY-37; Fri, 22 Aug 2025 11:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+ObZgoZJzCsoRW4mUSAnWsNYohEzYwHyJ9i8HaeOWbSgmkFYjr25+X+qKW7jqoUTgZlvoptAWkefxKXtda/M6EyukyloupwtdMEcdz5Rt5j9T7fRYFFZEG9caztRA1EqpeSEwVlj8ylyeg0M7YXmqQc0l2xkw69bmhCqhkK+5PkkF017CCymVLGqKrKIuA3M5mI8o03GJz+UXEgHBvtWRq5CaNxmgzy6e/SYy44KUzo5mXHZBjsDFfc4rVIOXKZryrI2ZCgV5+Wabr++T4EIUGhoG0htM8qhXv4Vxs6UXPgof1tJuDJxg5vtfsbxj9kEqpYYgcErp95ldRXn6GXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=PM25/gn9gxfWac99+xDed6z62xj2zweTCUAF9QTJo+u5tT38DKBbULzkHNfj8GBqH4msr2jKmz2V2Lh51RuRmlLelqa3vGAMrgQhLkiIS7T2+yOQanBnDXfC9E0vMQxwwcSqKRAo1QHUjN/j4krmoT1JMh7QIToxzIwzOel+XN9dVosfSCnL6svpC+fLWnUI2V1WVnDt7AA+xlCj+4yp7IE74cjbOkEN3AFZxvrESJ0UV62fpRupPCV3KojGkqEB9jV1iJo5k2efiWpdK58WQQnkWXToa2dqhjDj4tq7O2UC5HPO5TSx5WWzWJvCP7ME9rpBGSAlxedfoFJ3gs2gSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=3T5BbcaQwauaiasd0SE7tTpwXoTnjB/3W+h/W/1/YzeaNim7Rm3jHTB/ssyd2hjMC1METPVUrvQygyagJ17r6yN7wbwHHnLw8Ct9XuhKxPhIp6Hjm1ileLdwqSNbr3NyTJvkbkseRpznZI4wxHmf7jV3DgHBrVABQBxEEejizWQ=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 15:17:26 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::dd) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 15:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:24 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:22 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 30/47] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Fri, 22 Aug 2025 17:15:55 +0200
Message-ID: <20250822151614.187856-31-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 6229f857-5ff7-4de8-08f7-08dde18f0051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?avhTXu16pmRxU3kF1vGxlwC21u8K99ShN7SkGZLOyEQxuWBHmfWwDdwN55YP?=
 =?us-ascii?Q?dFqbO1OkfqvU2fdNumKCazNS9mt/U91cgQ7as8gMDpZ5Oskax0E0V0Ncq7FH?=
 =?us-ascii?Q?wiMISHHe5b5qfklITv7Df1LFWMtrC0aLBMVrLnGE5apy8Gvz4k3UmekRINyc?=
 =?us-ascii?Q?fhxK6NFQbOqgMTESBuMarb7DI0PFzAlozJnXtcRbcaBLKHqziSU7+bEPJ58j?=
 =?us-ascii?Q?oX7wlF//+jlcBV0YbXm85TdJJRAJ3NxlrmNyTWDQ9dUJSPAWTshauyC0tt5w?=
 =?us-ascii?Q?Iy8K8VkuSByPI3Qd4VPBbSJoC1hjZk1GLZMW0OBaGyHxInio9g5mCqptQhBc?=
 =?us-ascii?Q?HGIW5fbm6QUxjbVCCdPbvc8Y33d2fM+j4Y9ygb3rTDNw/7uDYoBdxWs3hxUI?=
 =?us-ascii?Q?BgwEcjzENTacDT1C903h5He9iQ7KdvWPR9pgp+GE3nKsIU7/FVojKAAT3fBR?=
 =?us-ascii?Q?8BEV3XSHS0OPZynuQqgRM4uZyy5zvj3wPovSWOFoffk/uutpB/6KOsZ6t7dk?=
 =?us-ascii?Q?rpP+KVB5V4U1mH4zNCYtyh0selGouyT6T6uS25A7I9h+0rlC0ui+hf/RBFkc?=
 =?us-ascii?Q?kFIu0w4P5M5tct4kYtFroM5RhPl/QZwUFi1vf57//sl215hA+wnkbLxUdq8G?=
 =?us-ascii?Q?dbihLiV4k9Jfeqe1ztqM3AF6BoS60z8MTmWO5vZtv9f4A6hNtYNiCbLD8V7X?=
 =?us-ascii?Q?UmRgP2e+QfcSenlL27S+sLeLL7tAixGhcN3Z/PyOJumun5gKhvljwaYHPn5S?=
 =?us-ascii?Q?AEASbqSRKPwled945qf1OIhu4umwR8w9skKOYV9bU3v/Vv1PZq7mE2tth1ve?=
 =?us-ascii?Q?A4gtpenu64cUJXwxQV0/A3mrAnz1Lw3uobyWdxMZH9YUXgESfu8Hz27xSSYB?=
 =?us-ascii?Q?7+cSpRynDkAxjWrmMTq8DYW60Dez+JtvTckEKl8FC+5Wt8bCwns2KE6jSH3E?=
 =?us-ascii?Q?h7d7vRbI5JcfYvWngaRa1hOjZ6xV+N6CdnM2P5jPGU30wmulw2yZuw7wFae6?=
 =?us-ascii?Q?YGiEBCZCMhiNZJQUkbFOyofLsSYCRSnghRn9CqwLxK3yNHeZSYYKjYNhWFW2?=
 =?us-ascii?Q?r74rUkio7oCNzq+sHrpiFfC25usV1PcgnXiorGtfAaWdASCsLkWhS1F0pksd?=
 =?us-ascii?Q?Rdk0P/Qpl8gjhAtk4SwvECwQbzQS/a3nmfTKhh7VjBjifW/HqexlP++S37C2?=
 =?us-ascii?Q?WjheIAdvb+77bf/k639I9tod+2VNdNfyeYkXhS2O0V4fyyrjE0KitBqBO19S?=
 =?us-ascii?Q?+ajsu/u+d95WqDW0Kiirz/HXJtYZwnUgaA7nz8BlIwIY+Nhte6ujPVyZVF1x?=
 =?us-ascii?Q?oj/woEPtp12oUeAnGE6Jthu3IIBZn+ihnW9EtEg+/mg30s/V1pThC5mVvzXG?=
 =?us-ascii?Q?yRU1L5jrK55F5lqAmrLHpW9cVzuRDHWyzUznMkwXcY2rTXcIuuNRBvib8vFc?=
 =?us-ascii?Q?KjWToKAtyKpZ3y61Pub/lS8cNr1louTfOoF+yDhO5kFChVrLbneEBRokMB57?=
 =?us-ascii?Q?1N9aZlV9vhdujlfC5zIrUt9yXGE3Alqpz8gO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:25.7009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6229f857-5ff7-4de8-08f7-08dde18f0051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
Received-SPF: permerror client-ip=2a01:111:f403:2412::62d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


