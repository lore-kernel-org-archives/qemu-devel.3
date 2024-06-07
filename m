Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5268C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:09:20 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFeRv-0000uH-FK; Fri, 07 Jun 2024 14:36:27 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeRt-0000u4-PQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:36:25 -0400
Received: from mail-bn8nam11on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2414::626]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeRr-0003rl-5t
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTaEiSkTCpyI8a7qJL8Kc9xC63Cw+L4nuJ4holWZ3TWoVqj6IJdfptNd6zuyirVo2dn8feZjtSQxXTMYcT4HoLTbzOfM948YG+ZD3OqzJE5fsybyQchcyZ462sdqKqd4WG7yB+BzCFbaMYuHZj/kwqWyXQcDvxcl6UAm++HtxPuca4kzY6VrhODdlAqhyL22M1ME4YdhymTYTstc+wawlYVySplVu4wsYa9M921+cWzbeWnjFMEopMTlW7897fRGx7MTcIkNTWBcNUpZmqhS5mx4BNuDke2nQWJVstTE1cSeYScdp5fpiRiEeDp4G1mM8l0XbY7gZ20hxcZkjupJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDsdZeowbmmZGJ+3oiV9FAHm4JaiKldSCBUVp8zibR8=;
 b=TvVrnv8jCNBfgIGyxYzMLWjNEQxQyeTFBGNvd5N5bTw76sDMs3fhYWL/PmYvgauSNBhCWKugz7+wU3A8xTuu4P6MfAR/YQojM9kqqCO8qkQuT+jPjqqII2dJdKca87lavX3batwgyIJYbln7wNoTWBOylEmnXZRGWbgPwMmfbXddSu9D4T56pm9dvyQF18+CHf83+H5TZcIKYEE1gTJM+kfGD2hITr1BTN1eQMQQrILeeFvZIn1H3M4L4cCT2TUbnkQkznQJgCCzMKWPSGFcUVqlnbclZO2Yu0kuCGLzfqZ0q//RND5Ua3oj1DZ8VkxP+Z0tIsWTE7Gf6SR/6fAfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDsdZeowbmmZGJ+3oiV9FAHm4JaiKldSCBUVp8zibR8=;
 b=5km+XCj8StmMT2AD90IeQ6EmZ1UpUPnPvdCrvoWMnra/O/QHP3TWTMdUlzrfIS/LHEoJ8YZQpBYa24vgMSlYFKiGu4I2c47FL2ESuSPpWlkvPDSaAtDK4j2QylMlPBEcu1vJoOX695ZbfjwrfnWiPt20BrePlV0pFyejozlP8XA=
Received: from MW2PR2101CA0036.namprd21.prod.outlook.com (2603:10b6:302:1::49)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 18:36:16 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::a) by MW2PR2101CA0036.outlook.office365.com
 (2603:10b6:302:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.9 via Frontend
 Transport; Fri, 7 Jun 2024 18:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Fri, 7 Jun 2024 18:36:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 13:36:12 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Jun 2024 13:36:12 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
 <peter.maydell@linaro.org>, <pankaj.gupta@amd.com>
Subject: [PATCH 2/3] i386/sev: Move SEV_COMMON null check before dereferencing
Date: Fri, 7 Jun 2024 13:36:10 -0500
Message-ID: <20240607183611.1111100-3-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607183611.1111100-1-pankaj.gupta@amd.com>
References: <20240607183611.1111100-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 103586f7-77fe-40a2-004c-08dc8720b743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w8gAQwL0cz5HbBeE49LRKx2uzgcsQ8ne4J6giBoLdek16/f1ny5XoyF0kZNA?=
 =?us-ascii?Q?dNr40wvi/WWidUnq8EXVOITXk5PW94iGnha3Kkc0RSeAB35ESJ7OO2CLIoND?=
 =?us-ascii?Q?wtGQA8QA02Jbd1yK0z74eHXQ5OVDgi/5mEB95sK+jUzmgjZs3dczIplK/aKe?=
 =?us-ascii?Q?LKUyu4WdkzTJZXR6lyLsBn3HRd4dLW55J/pCuxA0oYZzL8kMLqYmks5vQ4fS?=
 =?us-ascii?Q?VDHG/CDPK5B72AB6SE+q769y+4nc82FaT8Ohq7/xbtZo9T6SNzMncMeeOwHH?=
 =?us-ascii?Q?OxPIEZuWQYp1sb2SAZ/siEN6qiDzYR8XlZFWURF6axW0J7FBS/WSw03aBMeX?=
 =?us-ascii?Q?LVARTE6haldGtQwuJ887TmBL39h/yZtfHP2gBpQcEK1bTCJX4fIhjn2kJXzd?=
 =?us-ascii?Q?uZef0MMHcQsFYM+q7jXM1lvwSAtVfDQiSSItK1hwhkctpnqp01GHIuBufXzq?=
 =?us-ascii?Q?UtWo3sGQdJmiiIePg4cQJP30e183/M3BRIHKfayQBBbARIlDGB7PDrq4CpH+?=
 =?us-ascii?Q?DdRB1uj4qZj+LLGt1w/YmR5HsMvsZ4sLuaiRHnFCLpXIw+bWWx+yjZ9d78cP?=
 =?us-ascii?Q?L6n9Zd9F/aQqnAKOhp9MwUhcn2cpUiOck3IHnhYZnTIgHkpqt3T/CJ421mNX?=
 =?us-ascii?Q?Wv93mSWn6DiTFv5WFgI0ApQjEDhcQP025pST4TnlWy73qrqNxQJA93WrrCRS?=
 =?us-ascii?Q?/8FBSVYDcjnLvh3R7CDt8jV6FaW5Gu8VA9YPyzYgJrHejQ/bpXuCHZm17LR9?=
 =?us-ascii?Q?m3Ls3Tly1sGK+1sYvSB/JdpvyuHtJBcj9E8A86EyK+UkCEc9z71Hwwg5La17?=
 =?us-ascii?Q?Gwd42jjk3B6Vx5SlNCEFCTkK3kDcUQYvOrWVL/ci6cq7uaGEPq6bGDAub3K1?=
 =?us-ascii?Q?ZA+2hJLQU2tvnTx+edhVC6gaK8A+RghcTgifU0lAlGUsVMx6qwd46NiJrbu0?=
 =?us-ascii?Q?xnHJE4UHP1uYmZ1AVi6x3jdcAG5f+SEwg2ECBppnIs0cS2fWQie11VKWSn66?=
 =?us-ascii?Q?FojxVQUkb14yuv8DBKw1YwlidQih/AXJVrNFCmcAeuktjddcDcAjOaQwe+SD?=
 =?us-ascii?Q?ISFkvc9hRFt+06bL5cSuQzR6S9Wqtt2e26lf9G2jfEGsb2j0JvJuzbkZKwyy?=
 =?us-ascii?Q?f0peSu8PZwwMpr3E5yUz70koecMU/4JhT4t1dhnXXwq2EICtLB7rSCvXLzKz?=
 =?us-ascii?Q?DCtMTg7f9ueF3J0pre8kCYZgVMN7fo0kAZKFKDccCAdgz3KPzcX2SFjc18XR?=
 =?us-ascii?Q?y5vKX/tu4Ko9/zS0cJyK8E9DiRngYLbPlDgz2oUzOBWtc4JdZXVm9iuBoTNb?=
 =?us-ascii?Q?rdb76SzoqoS/FG7YYBaKS2ZjhHrBzr+UTK7zHtTVu2Qru++poyMDBE9jm0Jt?=
 =?us-ascii?Q?EF3d5zPI17sCv7+fliRc70EFN5L8jN0Bfo3l2okiysuDGF/R5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:36:16.1530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103586f7-77fe-40a2-004c-08dc8720b743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
Received-SPF: permerror client-ip=2a01:111:f403:2414::626;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

coverity #1546886

fixes: 9861405a8f ("i386/sev: Invoke launch_updata_data() for SEV class")
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7c9df621de..f18432f58e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1529,11 +1529,12 @@ int
 sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+    SevCommonStateClass *klass;
 
     if (!sev_common) {
         return 0;
     }
+    klass = SEV_COMMON_GET_CLASS(sev_common);
 
     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
-- 
2.34.1


