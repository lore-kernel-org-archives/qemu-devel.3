Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAFACAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqeQ-0006gy-T9; Wed, 17 Sep 2025 07:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbQ-0002me-KN; Wed, 17 Sep 2025 07:45:38 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbN-0001rX-06; Wed, 17 Sep 2025 07:45:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLEc/nDCOfraNeQEvW4qOmP+IwjlixF6cFYdNwEDJMHday0vg+sgRPx9eofWRQKdMzUMy3Z9ar5P2nEWw+e6/868sQGICd1Hz/116Ma7G9Ne6NQdVRaPhxR9dT1EWTOoNWW5bO1NAYrJPFEoQwr0VqoG/YJMj7AXBW8JSv2SNlP8ks0iABNGtH9FIubbi8rQjEVsLwBKnlHU2dCYiVy+eWZvjrfzn0C69BKpR43wgRVrB6obU0h6MF05yOMhW6KDz4KZCpyL4JXLElkrM1r4DF/cWS5FKzFGBrqfr+taILtDguJPvNupXY+jWz60wqCMy4fL5tROdXgAXa33RkeXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/rcxq6dXn3caikwL7HNdBBmWKjn1cVcanwIg8h3RMg=;
 b=nDVXjRwtJjdzOoZEzcNsx6ySqnalimF8uMN+TvVV8dhIie9GDmpPDjHQly+2YDzmTejkcqYZFcEQroEjgsMhUL31YWQxP5kbLzKDIv+ySM3XFiXtWX/j3UhJBttaDq65rQ0MebJjh4PVESPTN12Lr55b5lmgcTLku7eOT07R6kDeDWfq0Vdb+ZG0GGYh7GEu6JTZmy0hDTY2PBbBAdIF4EqqnVDZ1P1nX5JGF0KvQf24GsBk4JJyI+607rElq21YPLOS/0rlzdRtT2uzyRscWvWy1fRAC7zcNGxiKAeD+k23+nRsCfRvm9ALIUigHcbGGCggAYRacq303RE0wORw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/rcxq6dXn3caikwL7HNdBBmWKjn1cVcanwIg8h3RMg=;
 b=02ELhJ4Yno6vcjNfJeByqNlJBon00vHEpK0v7+5OQB0BelM2pEQR6gAjq9OBoGkTrL+SdSlbAg+0G8yx/0GesjLx+UGvqwk7ASzukNTof5Lb6d8vp81kOKjOg3Pm3GOUCSGPLJQSr55ceB3XPAqI/pcgjgwmi1eAl4eo7sFhSN4=
Received: from SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::17)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 11:45:24 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::4a) by SA1P222CA0122.outlook.office365.com
 (2603:10b6:806:3c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 11:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:08 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:07 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 5/7] hw/net/can/xlnx-versal-canfd: remove unused include
 directives
Date: Wed, 17 Sep 2025 13:44:46 +0200
Message-ID: <20250917114450.175892-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af91353-ef2b-4780-21f5-08ddf5dfb06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uhH3MoJiEjfRUCeimP5ce+JIdy6qYAUzTC8LDiKerkdQTMM329ur8//bnjMT?=
 =?us-ascii?Q?IAplC2gAcS6fJky7T+OuTBafcIYsdLX2i+LTvtDnqwHUS8MMSNf5tFg6rmJC?=
 =?us-ascii?Q?DMSxVGPAG8RPkBT50pmO/9uf5VRLB5/EsW5WAR40uoVj4OEdkGxU/BScKNlr?=
 =?us-ascii?Q?Vs2F8SyOxzukBQZRHIlCtCQxjUlsc8nSs1wYgPEI6Xacf4WsoNiKi+DSKpz6?=
 =?us-ascii?Q?idMt3hbvJISWkCEJy08U8kLiytC+hl0OLs3SXdnvpERHUS2PJs/06HB5BTlY?=
 =?us-ascii?Q?vLc1JZ8XYYIuFoijpZyvIJhXz+Hkjs7NfCIChITgNzLaNUxHFuXwomsqxVUM?=
 =?us-ascii?Q?MUGvCJWqoyrza9ENBfTK3iZdEcpuTUZUlp3TzCPoENXNvuYN2x9cm5CHmsth?=
 =?us-ascii?Q?AweJNeL5bLmenUJBsMFniKcibCS+WUs9MoQ3I0eCQqc6Sz91u2whkGhQzLlH?=
 =?us-ascii?Q?4q3Wr4Eo61NAEX8/h+1+dLPpfRKEiixvmGAnpP1zxS1v2vE9IFn9aMGvE417?=
 =?us-ascii?Q?kDP/57j3BaqdmN2FofeSBe/NsQxcPmRMAnNPobqpDJD9xN2lNknT1fqH4Xxg?=
 =?us-ascii?Q?6ndCGxKZTxilejtkn6xzAUkZF6yYsCwypLxCOI3VnBXG/iDRSFcwoOdbKM7b?=
 =?us-ascii?Q?B69dBsuE1KA6zYk3GBhFxh3rRWCzsg8ISiQa0KP6ofRK2gCizP4K+l3x5hNt?=
 =?us-ascii?Q?KrhqnC8Ht5GxO+SWX0wJ8phYg0oIff7XBGsOaDHxE7equRK310FCRMUEOQw8?=
 =?us-ascii?Q?wrgwwwYE3wyEohDqpUcgNDVEn3UkW/JhXO8RBmFC8zzOTt5rmTYGpDyILpoR?=
 =?us-ascii?Q?xcoXuYTTcaHlY/i66bRL3Mp9/KRH/wTmOSbkN0ntELJQYVcRi2guR8PRhIWU?=
 =?us-ascii?Q?Xcuep/JZq1cqBE00qqmUaq0lo3z/M5la+sICyHYzKaEpo1hl4mZSOAs2yj0L?=
 =?us-ascii?Q?zVpKSxNI5YDoB3gP02S6kDSc2a3o2VVtYrbuhkIYI5fySbu5B2jjhVhf2oYD?=
 =?us-ascii?Q?QjI8lOzM9Ire4kcPygDvrSxhdjapTzPr5xY3m/GbOfgaacOaye71McUOjFHB?=
 =?us-ascii?Q?iUNvyLdEm9db4JwRpVbBIVq89lx7vmHiwXKRx8nP5h8m3rLfpQFwztqCgq5T?=
 =?us-ascii?Q?1tDQ3qDKlj1gvMD7eZH/PoLA1BpP+dsZhZAicGwMMTSAEbqGrLk/icLK9JR2?=
 =?us-ascii?Q?X+zsmhzAMFAe0NSIoDvM/GWIfNRf/QXnhnmbwaE2AiZ+FkUUns/x+5yImBoC?=
 =?us-ascii?Q?YOPqSa0cpgRu6xcg7PX27hVmEBGtrPVnifoDzclVYyNbMnDNbh67YbmLqq0s?=
 =?us-ascii?Q?Q/4RmWP2tDrkI19OE/dM6JG/S8LgxI1awGNXHdJAR10pRaBFl829868/835s?=
 =?us-ascii?Q?mw5bOV1pWhcvDKbfujp5eCas4CHKb1pNvdB9F8MbAmZIwJUKjYO0gzEYibht?=
 =?us-ascii?Q?wi0NqGMfEJNcpjaX2Gs+yXW+MU7uxtJrI2t7mrMkHAPc/EUm241FY6tT1/IH?=
 =?us-ascii?Q?H+H/304OYfstRcqqSQ5POkYlCeTxBWkJaMZ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:24.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af91353-ef2b-4780-21f5-08ddf5dfb06b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Luc.Michel@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Drop unecessary include directives in xlnx-versal-canfd.c.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 3eb111949f8..343348660b5 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -33,16 +33,12 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/register.h"
 #include "qapi/error.h"
-#include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "qemu/cutils.h"
-#include "qemu/event_notifier.h"
 #include "hw/qdev-properties.h"
-#include "qom/object_interfaces.h"
 #include "migration/vmstate.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "trace.h"
 
 REG32(SOFTWARE_RESET_REGISTER, 0x0)
-- 
2.50.1


