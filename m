Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67435C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 22:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sboxJ-0002ZK-2f; Wed, 07 Aug 2024 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sboxD-0002Yk-8P
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:16:23 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sboxA-0004ZW-7M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:16:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVA61muqgpcRlR9gWT5VFOQSBG1XTvVBsJYUCoxYXMicoDsYey9LaGu5Q/lx6YHb6bw9vMU/zfJb5Rof4Bg84KJ1iZZ27dXYwujCFPdtUQzpNzUn2n6EAHE/l3WjHO+r6lQxSgGpzexq2XdP6j89VmSPgZRiuxUYzX3Kl46s5nfl96N+A4fZJjk7ROkHcC5YlWaLVa54arYKzJPyG8RQS3pf6ngpDZNgjdSjERMm37jlBXP8vb988e07n8JCRd6myEisv1/yUh/bUd84VCctUCC6ENvmiIqt2Y18l+5iKUtt8J+dxeWrmvO059ZnuG21XRPNexkt7dWxMLZ8iGT+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLTiqC5Bq9HZGR14SYU5la/g17V+9G1cI/VpQaJ0uV0=;
 b=qD0A7SsXer9AarjvvF5xHvBiaqHh3qx7eqclaI5YFosVyOgXQ001QVYHHg3z0sjOq/AXyTgoE//BzsB3HY2IUYQyAQd8kKHi2LfUNmo2Qotr+f+1W+eY97Y36xCH9yrsro9j1Ocb3pvJPuz2lMyR53OSHW9a8xRVhRHGocO0a5DIV6Uy49or0UNcStE0Mlk1saVGwWZO4xkDuAir1k/QT/ukrQeFAychdh5fXwHNa/UB1w9n+B24aS+MqEoum13AXCkDif4TWIjHz9dVt4zKKmfY2+pJ5wohrgdVrMs1QiTchtiXfUtfUk/3fc3GlOuU5yRy09oChl0EWJADl7EHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLTiqC5Bq9HZGR14SYU5la/g17V+9G1cI/VpQaJ0uV0=;
 b=14NBM+a674EoMYZOF8WlonBpA0j+P/YwYcfiaXeG9V6KJ+50w4dxGVAzpxAYms+kueRNEQq6+fJEwl6NQqGn2YVrWbq+fE4n3xC17I2pVNsvShCiXSeQUiOm0we4EaTI0TJimVc4e2a0atTLYjWE9H42NqulvflimbNtfKXXWks=
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 22:16:13 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::65) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 22:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 22:16:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 17:16:12 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <babu.moger@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 3/4] i386/cpu: Enable perfmon-v2 and RAS feature bits on
 EPYC-Genoa
Date: Wed, 7 Aug 2024 17:15:45 -0500
Message-ID: <07c14906a65db5ef0d0c89846b0cd36f3b9ede54.1723068946.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723068946.git.babu.moger@amd.com>
References: <cover.1723068946.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4e7092-a49a-43df-cbe6-08dcb72e8c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1dGsx4vIx2Rb3mkG1F2hMWZigM7xj20iv0zc0YoKK1hJa09dKsNCbMowwRjZ?=
 =?us-ascii?Q?rxeBXllyIf78Xa76KQpOO4B3Ey0RkwQbsMjyOX+1x1N8axa2SCbcjC/vPnLp?=
 =?us-ascii?Q?Cr3NRA7pxK26qjwysJ0Wc8lN/2rKXRJVO/5Pu+psRECMWgomIPLaVS9cWgmB?=
 =?us-ascii?Q?pEyV+GclBQUMGOlfoAjnSrcvN+FprpNI9WKtXwYgD/hPiF5O7peJ/xYrSfRE?=
 =?us-ascii?Q?6BUsh4PtPnv3ZiI+lCQfn+AsHcqmTvtT/mFCsyvsou7C/kj8Qu9fL+i2ou9g?=
 =?us-ascii?Q?Vp1Nr0BWhYWLOLbAWRH7satIRRPfnpjQuYEVeGpSk1LazHJYvS0FjpRtRsL3?=
 =?us-ascii?Q?bQC6fnA31SBPyRpxKM+v1s6a7/uWJfPoVgG7mkl+QQpj0HLGK3idIAt4M9xH?=
 =?us-ascii?Q?RO35qZf9snH61m5eVkBkGJBS3cuWwUoUfjc9+94PAqp7JX68sxXrrCg24Jb0?=
 =?us-ascii?Q?SztgNdJ6Bl6UdlzbhhkIXQuTonPep4iicbUARh8Es0gric2gE6ZTtctLjwvB?=
 =?us-ascii?Q?3o5bWNV6TjOBZIc8LqHCswjaZEjkm17tRkeOfKvDyM1XfByTeC/kWE9W6sCO?=
 =?us-ascii?Q?JCBNyQAApQucIihWzfSnIkVo5y8wvm2A6j0OkO3nEiYAqJ/OLFRuQNYPisqe?=
 =?us-ascii?Q?c9y8ph+/GA//BVvm7XtD4NRDpQBNKqUfBA1UV7Aoq23SZsoqkNbTTmp9fFQJ?=
 =?us-ascii?Q?KAJb7hfFFzY4QstiV3foASxIZEooJvAqWw0xXqMtC5AB35hh3upi+Dw0s6M0?=
 =?us-ascii?Q?hh8d+kZr6OZrH+kEoDoM7wggsTsUhscZSxzB9eiYve4kyTk6/kaUdusHAxLx?=
 =?us-ascii?Q?fM7GOzR1tfAJol04FLhRi6qEF+LS88hMbpRZI9GLjmV6XA7nqGumH7fErQi/?=
 =?us-ascii?Q?nyTWPz7Paj2ZrF4dS3+rQinP4Bsrzug8dxA4+YDOhxXK2DaSx6Ak7UGOVQe0?=
 =?us-ascii?Q?19o9U/eFgjXr/ZDQlKw0ldCJ83+pWA994uErsh1BarGoUwbtnptU1KHl6goU?=
 =?us-ascii?Q?E9UIBm9gNkoyz2tvPr3VuWxviAiRQZhdlapXwlCkUZ3zvdZwDbmKSB8O60Ih?=
 =?us-ascii?Q?j6XK+tOlw95Gwzj6q8DOOMRu4qk8q5KVeEg8mPeSspy1KPiTbVyv5fRaaTOp?=
 =?us-ascii?Q?vL7R6SwRMIdJKFEstnrIzGDn3flUd2+suo+eNxwmesOyGi8wtqNMJ2bSNW1Y?=
 =?us-ascii?Q?9qw+NVt4lfri7tmEPlNLn74fVj8Pywj71PqRYKMcYcgYQFj5cYDrEAGtzpw8?=
 =?us-ascii?Q?bVDD2SM2Gf+fHgK92hF92T6s9yLcTs6ehmKuEPL1k5eiv8Bbrx+InkrLaSfb?=
 =?us-ascii?Q?D1mM8vU6uEQBf/ASCefRYbfX9ysVaWKHsp9DDjeuNgrY+1tA0Wj9JPlDvvUp?=
 =?us-ascii?Q?Xr8PexfhkgtRxYC/VnsKs/m5x0Wj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 22:16:13.2550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4e7092-a49a-43df-cbe6-08dcb72e8c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
Received-SPF: permerror client-ip=2a01:111:f403:2415::600;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Following feature bits are added on EPYC-Genoa-v2 model.

perfmon-v2: Allow guests to make use of the PerfMonV2 features.

SUCCOR: Software uncorrectable error containment and recovery capability.
            The processor supports software containment of uncorrectable errors
            through context synchronizing data poisoning and deferred error
            interrupts.

McaOverflowRecov: MCA overflow recovery support.

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
v2: Minor typo.
    Added Reviewed-by from Zhao.
---
 target/i386/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 44cac5fdc9..d88a2e0e4c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5301,6 +5301,21 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Genoa Processor",
         .cache_info = &epyc_genoa_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "perfmon-v2", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v2 Processor" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },
 };
 
-- 
2.34.1


