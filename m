Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D0C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwec-0005YD-DL; Wed, 16 Jul 2025 03:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwe1-0005Gw-Rq
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:33:39 -0400
Received: from mail-dm6nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2413::623]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwdu-0000fv-Oa
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:33:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj8+0HjOEIeuzOkm/N+QOlvqsdAKFZAEv4tmFv7ExOgy50TmuxcYjOYRUbxZwwxFE6XdGBnv13h3oh2/1WULnsKi3vmTEfbhzzhwanFfJTGg3iBX4bgeMON9VvBpm8XVfTZcY4HnijpJP/UT1iuDfUKMb0mKXxOzvMAVncbxDW0H5/uubIoZFzoI84UxIbhORieqTXGsYBFb5I+Ytn08sQq3r1DMr6wXErwV29C3v62nzg/YR328YK3+xLKYETQPiNggubDLOVhfDuP9vR2Zr19crMdZ9ZP0TaD0hKlxJBJlDaOu7Kh1dFILySVa3TCAtRt7PwS6s1S9LtlssyKNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xYQ8G7cjsZXspJIt2Dx5ZYtk7ThFa0j+X2MRfhjEaQ=;
 b=uswrSnLO6PVk1y5sHx2Xzr+pWBVt9H61tIR1gwbWB0Qkbp3Qk0+ljOog0w7qquLPeS1lmgxr8GGNGpSOxsw73e3R7izcba3IXwydw+AUEqO3OCs4Fn0wa4Fa/51OujKZCjmn79eo8IIDCJEzTkSM8m691F3rxUMnsEaWb0uidinBcd+RxJX9jbUnqG25yzKKzeO4x0aoqPoLLT6tNLDXZhiGuSjgt5Umw9MR3zkSTaNP2G9Ir0+bbLO/EjJnLi8UDZFsK2YWrr8Ck+L/r1yVG9q3k1KTnGCcWsRvaCZfenFdcwCF2mcsOA2Phud5At7iUFD09RHr4+M/8YTI4vF3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xYQ8G7cjsZXspJIt2Dx5ZYtk7ThFa0j+X2MRfhjEaQ=;
 b=t03+oHYagSl7HXhRDwCzAxECOPOkoMFSO49i7j9dVu7uVZD/om5lok0G/vGjUrtniyMZiW/2sNdE6uLx1iF3ugMet30xi0ClXUhoc/nK8GL6GhSHo2SA1vrEPCj6ISck78+UYdZi2LfKXX/1pOGmyhYLHfNf5s9G29T3Vnga4Xs=
Received: from BLAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:36e::20)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 07:33:24 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::75) by BLAPR05CA0024.outlook.office365.com
 (2603:10b6:208:36e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.14 via Frontend Transport; Wed,
 16 Jul 2025 07:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:33:24 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:33:20 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH 4/7] hw/i386/amd_iommu: Support MMIO writes to the status
 register
Date: Wed, 16 Jul 2025 13:01:42 +0530
Message-ID: <20250716073145.915-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073145.915-1-sarunkod@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 9256ec93-db61-415b-2e56-08ddc43b0c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?56oeC98A4kPEIdzjuf7rOBLJ3r0iedsJAzzRwr1jaMIneFy4Wso+B0bVPda4?=
 =?us-ascii?Q?h2LTfDXeUy3EKH14dU4+kKKxd5FK+pyRBnE+nBY218kPpCJJVSce1gOTaRUt?=
 =?us-ascii?Q?cDNmdl3WEU9DiKVsr76gmxwbfO+9g968lKPxg+eeXGOrE172y7FQoRO9+JFO?=
 =?us-ascii?Q?ITXG6mahkR2BuKiGGu1x4t8VMuCalKOxgzpTrq+XsdZauGWf+XTqHl55A8Cq?=
 =?us-ascii?Q?HaM45m0Yahb75S3v0WBUo4cvZO9MqQDwlBc1mFlX3IQqFTWdvm+fH6bve4ld?=
 =?us-ascii?Q?wAc/nHfoarR0LJY9iBtM9wqr3mm5LNcMaAG32DS4cCvqmI9c/p5dT793QInS?=
 =?us-ascii?Q?RDmc6BpAw1BXdED7J2HiecaaBQGFxUsJ8T0KDWovpcrrA7/5hujVlf8tTQa5?=
 =?us-ascii?Q?0NZLorWaDRE7KevgCBRnGxzs0c/ePbvENzX1lAfw+DVQIlHexk8JDKxgaQRv?=
 =?us-ascii?Q?r0BxwsUGcH7wRBb4Y7V0AfAwBC+PN7122/oZuZQ4Q/5hEAxmfh1LfP08jDfh?=
 =?us-ascii?Q?Yuq+XV3AV8B1UZ4oHwS76jagBJ1RCrxpdMHfgO8tX0GPkUdE3c87MAonwMYK?=
 =?us-ascii?Q?ayfEHjcQDWHCnKjdccbXw4z7M63lYfwK80ZxAJ02LE96vLAw5/qfYNO1k/ts?=
 =?us-ascii?Q?w4fbbfPr6VuZtywVODW8Ze2TTRRkEWAFkcuCoTusimGo5OH4tfFl7eS8cB9U?=
 =?us-ascii?Q?sPeu0Wwm77bJ9SbpFKveIGtiRZwx5jNPhF/PNzQo0S+aMkoTFTMO8Z+gfkX5?=
 =?us-ascii?Q?Uei4rfAGzjhxVq9nQT4/2MJhKQVOpWaKJ1bKKl6c4z6ueffyEDO6hERmKmha?=
 =?us-ascii?Q?VQjeSdBePJYUldy2ZVwMXEZI4W4e/3mew4RnSvL1ICsgTJCgH7hKqPhuTBy4?=
 =?us-ascii?Q?Fx6qEWGxWfeAof0kDvN0PlHv0Q0L5cZIji/7hICKP6xS5Us/26RNegoM2l0V?=
 =?us-ascii?Q?UZ+8fm8lEf3trOSQIbgjIkkRO28ydRHc1WHsK6Y/GUZcathwD1Ba9oFujaNo?=
 =?us-ascii?Q?QkG9zkQfjifzDGFw+AplcTHer9JlAW0/hxg49jcuQXBn/XfQG5N0ndxzyNDe?=
 =?us-ascii?Q?Yj4zF1koAi5r1AVa/qQh/xkxFpgpoJrq95cTV8R8jmpOgzX1ubuykGIVJVKo?=
 =?us-ascii?Q?t343gYUJjkj52eMGRsKJDnZ7NxasbgqU6oKOsyID8iMf4eZl8lujQvnonbNr?=
 =?us-ascii?Q?aqwgIUX09BnpG95JJHFE5MICQcZRe+wJOhc+hDXG2c4a0cGS/dDx0kzUMw0E?=
 =?us-ascii?Q?Jh/nVNHv7al+HKHMJ/ePnwAvJmLDd5KyXL7HSztx2u4ioqL181hWQcelJejo?=
 =?us-ascii?Q?Kn9+166Vu3ciHJpSULuIsFAiOkjoqn2ZQStjocDp7d0MrXO4V24+qspHWLbN?=
 =?us-ascii?Q?/vZ64jhxHR2Bdb5RQBmWP/xhuLZrG2ZSx1AMroOeetEfZbxfzLCt82y6Ce4I?=
 =?us-ascii?Q?tBkVxYVXnlgwdXYp6AUwNMSMCN/I39jJpzPk9tNMnHEip/4VPqXsRXcGoBfQ?=
 =?us-ascii?Q?xlPTI8VwFmnAAecwCqgPUN6GrGdWq95Pjicz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:33:24.1143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9256ec93-db61-415b-2e56-08ddc43b0c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
Received-SPF: permerror client-ip=2a01:111:f403:2413::623;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Support the writes to the status register so that guest can reset the
EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
respective interrupt.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 784be78f402d..e0f4220b8f25 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1613,6 +1613,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         amdvi_mmio_reg_write(s, size, val, addr);
         amdvi_handle_pprtail_write(s);
         break;
+    case AMDVI_MMIO_STATUS:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
-- 
2.34.1


