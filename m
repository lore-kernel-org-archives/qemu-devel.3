Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F84C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wplQK-0003gO-SB; Fri, 31 Jul 2026 07:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wplQJ-0003g5-4o
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:29:07 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wplQG-0004As-L6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsQ7gtOLKVFrYhd4dXZlOM896I+SaiV9j/aDhlxjOQiDO8LGiHeCczH1ekZs013bf6EKGzdGvTakjCgYRExyIp5EoxTpOBk9KpRfUGJ3b9bGLsXmnE2xX2H7NHpgjpGOhAJmOxH0ZMUFZW3u58pUKL6Hx8eKHLgrUgioSuvWT+/kzKtDvMs55ijro0qFNvxytkRjAfeXFtUG7ordFdktSYHZqdHwO/gSqD2rdF0TsW63pXvwubDKZwS2CPCN36+JZlooR0+Iy8okQ7zEooXLIi3MutahzxOq9mNeddU2f2tzjxY5JUH+k0m644pH0rgjRHKkd4DlgJeIYJn9teacqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJesk0wz5r44mUTtRCfdxlGi4XVWuG56ju0CcSVMGcU=;
 b=SdCKBYuzSn6I6VTcqhP4fJqWJNIQQhGzhkWfSTAIcRtYToGZbXJs4Sgr6t/3PGtLdPMR5HnsKxP7PC6+k70QGRpVsGktzap/p54VTI0s+gWuu2irZ1eh9hbgtoJnOtxl6G6PZyo7j/GB7nOaNoU6IqHgMzvyPS37xHLJy/rxK1mHAk4BvAmbbAF9aj1o9Y2e0ujeIYU4Y3CtrgUOhYO1o/fbZVYQc1AERo1hXwx2gowZlhDYYsTBYOTEw/7nChCctezCjN9dRb/r/x3HIvYZhqKl9r+EcBOpeA9aQAWoJMfBr4UB5pXjqr3onrj0LByQL+LZXgwtKJJ41DvTN0QwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJesk0wz5r44mUTtRCfdxlGi4XVWuG56ju0CcSVMGcU=;
 b=OsnKOqgcxYGv41Fbj4Of4LZoQ8Iz09iRvTFECLHYX8TM+DvmsYwc2yJpbK3kM52g98fG7tD5B6ZbgjCg9SsVThyl+/fdv2xXWSV/ZEjTGCpjTwce9MQ7agP7cJygMo8EV9lqA8RMtA98UZNsGmd0dLogeBg9TIQE7LiOcLG2Ue4=
Received: from BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::13)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 11:28:56 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::7) by BL1P222CA0008.outlook.office365.com
 (2603:10b6:208:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 11:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 11:28:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 06:28:56 -0500
Received: from [10.67.184.128] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 06:28:53 -0500
Message-ID: <b81d2346-10d7-4503-9831-a9248a70b0b6@amd.com>
Date: Fri, 31 Jul 2026 19:28:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] migration/rdma: add x-rdma-chunk-size parameter
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
To: Peter Xu <peterx@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <farosas@suse.de>, <eblake@redhat.com>,
 <armbru@redhat.com>, <Emily.Deng@amd.com>, <Victor.Zhao@amd.com>,
 <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>
References: <20260330064758.2816891-1-guoqing.zhang@amd.com>
 <ampSFcrRagKtf5y_@x1.local> <b454973f-275f-4f75-8367-8b6230d42bbf@amd.com>
Content-Language: en-US
In-Reply-To: <b454973f-275f-4f75-8367-8b6230d42bbf@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d142e65-9088-43e1-d435-08deeef6e8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|13003099007|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 40uG7mlXSwDnXPqrPxS0KNMqGp5QUqvJjvT+cb+k3htuunT3bDhPpqlAXIhoxZWFnK06AxyTMJHBb9CfcAtf/Ne0EQtUav97/6TnnHsvKGbnyS8JXVXH9sv9Y8FcCr5TJ4FuVWRkepAVaeDWKuM6IrT3cXIKR4Xh3LIq5W8wJgC/5w/a77eBV2hJoqkNpEGQy+4SHwUb6QROLDmd49oVc7CwBMJoBKs47kkhnsOjtu5Y+LN/Q15ZPbc5WpdN8IRBsqwBaU0gzTSEmi1/9rdrt8Vc1A1E2g+J6MOARVeCuhx29t1FOQFnsIWiU9JXvc4f89qTQOW/5B2N4SN80teoRWLhQHZfgQAwCtJGvorcauZ56Y4wXpXYJLpODMdYW/jp4VkGsvoG8fPbQqX7KvAnpqtRmtOW6PftH7/uwL5X/IficmxZmNUtp5mrrE+X7t7fDEqp/SczXdcs7mWdTCiMFhtUFm9KOj04yGO43mDCwHQPGV3yCJfGdymPgsKUbrjs7XJtfAOa6xF3uy8QXOxq/HlzH+6sa1JqXtR70efeh9lmil3sm5PIWe6KUPjpQdUBB6m6q9OZDBrlxN4A9cS0JFpaAl5+1fVXifyBRrNhnA1jLBtHEyQvD5+7T5Dc03y3TTpe9NlBkvLia8CGSlAYvAzlr8tha1sBvY49975OeJ/y3J/75dzh5dXBGNozUgKs8AO3G4EqdMXEMHoHw8yExg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3c0NQCYtGAfySbeiCtP2YlZWp4zwNgAhPEh8BTmeRrOUm8BW3AqfwmVCwQgqRjHXAlPlZ3uqneXs2H7C8PCbpCpD1kriuhHeai1CjiCNnZpFpFw9dCQWVzmmYG1xUx/+TpMraQn8AQg+8bSF6MpZ6Tk5wym7xg+fkUhPtI1/86O9hG9d9V/8Sl5OfNGCfZqgZ76fFIEluOZQz/XhMaH5FHIPbt4z2cL90on35Zx0jRV01cxXkgtUxCYkk9Ichr7KuLbddlF0kkHvpvWq5tmWjrYFj+05ATMouV/B6v/+nfWRXZqtPMVBVTE8N6kJggVhO6q1vfXY3iNgdx7E1bWAvHRmnpup6dT5Qbx3/MLaMTsWE70PrD/R3QM7S1QIDMHk/OlCv9CPA7hEh4jSTjnOQRcSH5jImmjagXUvohG/j5llwA0ezSLjLmVuschrPA0k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 11:28:56.5817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d142e65-9088-43e1-d435-08deeef6e8ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2026/7/30 03:18, Peter Xu wrote:
> What is this rdma_merge_max()?  Why it's twice the chunk size, and 
> even if
> I believe when reaching here the current_length should have been 
> throttled
> by chunk size too?


I don't know Why it's twice the chunk size. It's from earlier 
implementation. commit id 2da776db48.

https://gitlab.com/qemu-project/qemu/-/commit/2da776db4846eadcb808598a5d3484d149773c05?file_path=migration-rdma.c#line_36f493df3_A72


Thanks
Samuel


