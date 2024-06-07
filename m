Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1091DC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:52:00 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFeWj-0001JZ-Hn; Fri, 07 Jun 2024 14:41:25 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeWi-0001It-98
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:41:24 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com
 ([40.107.237.80] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeWg-0004zZ-Jq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCVnwW2Z91GLQSc0i5IXdgUigj4rUx1NCX+X/287F4MN0mJupRWFsF5x975+hlMA7jhtFBazu6pXovwG6UL19gpyCUgwZi8z+ORm53JXl06X/ZrGbZR3vUZCHutdUCGC98zWinPoWnCbkdXFQndSDChPn7fk3RjEeI5re0UojcKBruNrj3W2Aat9eEYntihhm3lXGddAQwvEDdGK5oYMPIxu3eHOCKtcnZOnnEZefFkIWrq0vNDfP1R55bBXIAX9kiHMq5BeEvnHF3M68p+e+T7X2mU83z/WmY8sXh2v2rs4VqB8sMUn8kHWyStqKXB12iXXAVy4OJFgq48ApHJgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8F0oGA8VEPZYg934kR/lZOH1mCEaW9Eu2/EEHu3xmE=;
 b=cZMgzNpJnDy7Tq7kQsmJcF1XjtlHAySjF7R6lEArE75Z4RX0OTTfNraOy+z/8w8sW5O8iwcNJYCjcX2kQBO6ZZeV68lCL6PkT/lfddFwx933nWU93AEWKP9XKQchzl6z7UqhQlb6E7PmSCbO3aNWv/FFjdApc8Cb8oVryQp4s93q5hdc+DmVRPl9dysBrBvaxnzdbcIC5Z3UYTRfisnJ93cF7dxNDUuKmvI8gMcmgPfSFfYQKBgyrh+6QrgFDaJx7q96xlihTthZpNL3tOp2+j+Y/hrdZY6tehT7lM3yO1l5N6E+m3w0LcdcAghDTn8H6GXWBk4uGRdtHtxa7d1rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8F0oGA8VEPZYg934kR/lZOH1mCEaW9Eu2/EEHu3xmE=;
 b=MQfprpVeuiGEDIjGwqPXS4nHPj25xvTyRcPsCTZs1chK0RV1RRvftsHDn9OOGuJ7jdBJDQEgpSDeH6lnd9+DMliTf+34wPTfUvC2YUUoODBzanWUPpMqMwow1+FWJHm8porkee5WpsAJ5DlwXoO1u4GyS1bpcThMPZQk9TZJ0pE=
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 18:36:17 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::8d) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Fri, 7 Jun 2024 18:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Fri, 7 Jun 2024 18:36:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 13:36:13 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Jun 2024 13:36:12 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
 <peter.maydell@linaro.org>, <pankaj.gupta@amd.com>
Subject: [PATCH 3/3] i386/sev: Return when sev_common is null
Date: Fri, 7 Jun 2024 13:36:11 -0500
Message-ID: <20240607183611.1111100-4-pankaj.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: fabf66d4-c2e6-4134-f99d-08dc8720b7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JYxGin/nz8BHfusDsL/mgmbK/ufRgqf2skRKoESXwqyC/EpXClp2QxPpFnmK?=
 =?us-ascii?Q?HrY1D/d6D0aChX90zLX1mf5H3QlAvF4/ijnCXpHVrh7ZCb8uMuXAmCg852LA?=
 =?us-ascii?Q?NLRO1dkuv0O66i4NUCe0pPFqKdP0lXM10diFWnBMbYADyWLG2/r3uqpd8+6/?=
 =?us-ascii?Q?Cu/Nb02lpxEa2YPOH0IeEC3XOi6FPJ98r6QP2lpb4ebnvsI7p5qYUaJHQ8Ic?=
 =?us-ascii?Q?Lg5EoTUjVgt9J/VQ4oQgHSvCfOS1CJNXgyX7GdcnivZk3pLnaYJd5D9x9EDX?=
 =?us-ascii?Q?59lz8R5LqnTubrAGnjM1UaUgP5eY2BomLd6SUobyYRDVrk7/x4MgBYS0VEbK?=
 =?us-ascii?Q?u2u5zsLyue1UUNYShIv7UyUTmb7WuPNQBzeQKobIQblteesJ7zO1KZutOA2A?=
 =?us-ascii?Q?URi3ZHXuq8nlxXC+3ZyhVnjlJSSUwzR3h++lfGooZvBK72peEwPTKCremiUG?=
 =?us-ascii?Q?f+lcHrb3xe983vc1oS6gRARHOFIQDzyaA+oq25s12yG/ghMXmy27b1H5zPpS?=
 =?us-ascii?Q?53Tk8t2Qhlu8OGxh6BKHp2S7DNoD4e8mNQgNViB4bWYfntmKOm/FOij8F6k9?=
 =?us-ascii?Q?xpkSCZh/n/tFoIuZ5jom9FMXSPs4U8QIaub+3lUw23nKUaW3aMYdhTv23QnW?=
 =?us-ascii?Q?J6oX48mXH2DsnfkPMzTJI0hb+9wafgYMSMbxnq9AiW3H3F7CYQrmgn4PyP41?=
 =?us-ascii?Q?6HMV86lbpGPaveEneMZObuO53qtuDEI5RkwrtT0MqaH6ZN/hOi4LdaBCbCdF?=
 =?us-ascii?Q?LB7Fq5Q65GvDt5gkgTgowjnh8S/DsQ4LdHB0McGkw4OhP3WDg4hTzfpKM27a?=
 =?us-ascii?Q?whrHkZ+pmGeGFl/tTuwNNYx2+sZL3WED2DpMwIC7gqZEgL5pZJTl4jE3n+ds?=
 =?us-ascii?Q?HQb/cVB2TmYluHX5qLF0fKM+Mnp+wWPEYtUGC8NclAOpxHFXXWcMGfX6WNSC?=
 =?us-ascii?Q?J+G5Fb546PJZZ3l1yFGD7HJ+da7FXsBRd+Zo8VR0hkKz5PAaC7HLOF1rI08b?=
 =?us-ascii?Q?msQ3FNc5AGNcALVWBQlfT1+6K0AS1vjVwj5RSPyuiu/613I2pnfIGRg1ZloA?=
 =?us-ascii?Q?CQBb8HeFBK5wET1bUb6fiI+nP5tV7kU59uZktJR9ZTdox8hRMk75WOi/8fJZ?=
 =?us-ascii?Q?YRqLM0V++FeSFAtYEiFNCmWubYWcW3bFRoQ/Yz6U8p9Uag8e6i3c+xaAJEPI?=
 =?us-ascii?Q?YdrdzbzErPrNYLU59/lAk5Pk4Nl9BpEJJ+E1j9Dxlooavw/SJcN3TVXVi4sw?=
 =?us-ascii?Q?b3zkuIxqvdVp9pk5GJlAAzAQIJq9wRd5c/GiXetMMW7H+R5gu167nRpCNw6b?=
 =?us-ascii?Q?GrAalM7Po6LKoBeBrzMdCuOgVK09D4PRBCxKdV3JZeUqUrjMWGoOQlvIhQfj?=
 =?us-ascii?Q?mmO5axVp+7UN+ovFU0OAe89uIyRj/AJj42CxQN+te9laG9iOdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:36:17.1686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fabf66d4-c2e6-4134-f99d-08dc8720b7dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131
Received-SPF: permerror client-ip=40.107.237.80;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

coverity #1546885

fixes: 16dcf200dc ("i386/sev: Introduce "sev-common" type to encapsulate common SEV state")
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index f18432f58e..c40562dce3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -587,6 +587,7 @@ static SevCapability *sev_get_capabilities(Error **errp)
     sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     if (!sev_common) {
         error_setg(errp, "SEV is not configured");
+        return NULL;
     }
 
     sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
-- 
2.34.1


