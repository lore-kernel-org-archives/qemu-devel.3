Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B343ED3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 10:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSYvk-0003qi-FE; Mon, 08 Dec 2025 05:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSYvS-0003pD-Rr
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:57:09 -0500
Received: from mail-westusazon11010046.outbound.protection.outlook.com
 ([52.101.85.46] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vSYvP-0004VG-7c
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:57:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l559WXziO7pDnR3r5iK/NfoHeNBFZm97DewmikVkLcbh7spHOSkQXvI1u0GjD1hkco/oNQl+yiOtSxsu1M7so3ogkmC+ELeUPlj2UmFikKxs637M9F8zjPirQOvEPf9wNDl4CnYgdlWHUQV8Dulw3Xo+KvQIC+zSvy/iG81WN/ROLBQLTumPm7iTC97+rPqFUF4mdeKzxPg5GSEqsT2dG2CXZGZsyU1k0dTj17YiFejN8yQju45eKOipClaPUHgduK8xvULuMvxt92cg7txFCXtLjroYg+5JMWIFitk6q0xvmnU5C2GMg07n5nEWcH3rM6nWFWasHRC0Ee6sbth0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTIEuAUpcQmxU6ZuWtV2jj3VGxK4bQq1jFDCWz93lGc=;
 b=sA9nmku7qOLpcl+aGVQnFd2eIVtHBmvMjG7QnViJ1Sxfv88NGPKC6hy/M8cV4H/ZS9HnLPAsBm7bYuOn6xWYATyI2YdCBJWUuJGwT6SYpRuOPrj47N+bfVqPiqMzOZmvmKMqpYmc7ZS0tZuwMwbsv4ZkmM12UP/ly0VgIDpLVP8abp1XFMxc+uv4rNSb/wq5rbo1+K9Je+YQGCLf5zCrFoMMQwYc2CvOXXN8P3/6/VMmr0ZZLaGJapXYCy6Co5bc2Sc3CLM6HrOzpbGf/LCY5Yu7mDj7NeyEh/ksyvOeNdDviM7jltGLaw2hhE0n1OodX4pzc2EsLC4in3zIjsoP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTIEuAUpcQmxU6ZuWtV2jj3VGxK4bQq1jFDCWz93lGc=;
 b=UA5Zm6LD11P+bzASmODeVwW/M29IPySM9piQwkQeEr8pFWsRlgnLx3CMONZ9wqXXOeOBDfWYMrVKqaHYyqIcAb9PuVUb5WfcyQ784bqOq68moDN8+cU8Tx1N42AS5vQyFIgieMV0UKAHdnMiMXQajuUrpBx53RMS+XV7I8Vngc8=
Received: from PH8PR05CA0023.namprd05.prod.outlook.com (2603:10b6:510:2cc::8)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:51:57 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::f3) by PH8PR05CA0023.outlook.office365.com
 (2603:10b6:510:2cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 10:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Mon, 8 Dec 2025 10:51:56 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 04:51:52 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>
CC: <jonathan.cameron@huawei.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v3 0/1] numa: add 'spm' option for Specific Purpose Memory
Date: Mon, 8 Dec 2025 18:51:36 +0800
Message-ID: <20251208105137.2058928-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <286f685c-0694-46d1-a8cb-13c77fc598a1@amd.com>
References: <286f685c-0694-46d1-a8cb-13c77fc598a1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: f84942b0-ccd4-4966-159d-08de3647ce3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aH+BRB2E8q10lMpz9P2ISs8Ij/yP7try059QHw3CCUhS/es4Eioj90oZyIym?=
 =?us-ascii?Q?vMrZEaVdQyDzT/TtN8B8kfVv43i5onkHXb89hFE9dgFH4Ltd5ied8TOMY4F+?=
 =?us-ascii?Q?pwVLqQDwndjXKW4DPM3QN+jxNwvZ2+f0LvpZNGq0UyE0lUpNiQiQs+9Ma4l0?=
 =?us-ascii?Q?LYRsrNGmeWwEJ+NxsElXCxiCD5BA1UhaczGra1h3xWNSZeHnM/HYQGPHUPLC?=
 =?us-ascii?Q?8UBEa0hYKu3p5ULgDu3UXmreQg865jkH2/bI3gymirr73ZLQOARYB4gvjqv1?=
 =?us-ascii?Q?9P5tBV8crHmUA96metYKs3kmqQ8JV/xpxPGiul7JGYy6+xU7wbCCOU0+kMH2?=
 =?us-ascii?Q?e7W2d96flNLQdLArI0fRtSSk9eny0ev8feeHlMfYRt3pee8ZQMftd49C1Yda?=
 =?us-ascii?Q?sBn9NebH7SuM0UyrQvTpuDqm8rpXI3Eto1Q3ZP/6PKQmQaCZ0D7wFZtOeVGf?=
 =?us-ascii?Q?o/j0pWf2uCRrhUBnfpW0a7BITWX1fVW4yq64DaFOdhD9622SKQYm6M+4l1xD?=
 =?us-ascii?Q?Uc0UUwU9gHywmfrER38Y+w5QrRlC4jtX+kH087LFml/WhLPu7PmFioK4aaCM?=
 =?us-ascii?Q?s/EU26x+pFq4KDnSrU4vSj07lJE81lRKzdTx6Gm5As2YNnTAY52VHVFyqyRD?=
 =?us-ascii?Q?pvOMfb0+18Hx4R6B7IC09JQp7QWi2Y9ujySkKnISa42kC64k1n2PHYcr8ODy?=
 =?us-ascii?Q?Urfzg6gu+2sS9kZieDlbjJubeQz7aNE3WGQvufTHzZ/1Wu8cZwwKYynQOsxO?=
 =?us-ascii?Q?IirbXd0FVNA7HAqFZ/JWAB1RqXfqE78VV49+7WekI9yo/DImGK3kkhw1k+kX?=
 =?us-ascii?Q?9z/f8bxXbgU209euDmwxASLYjLc2MRoQaGb2fHfiDMIPgkoc3vLU0hegm4j7?=
 =?us-ascii?Q?cWSRx0MHnKFHQkh5su7UveqG4SoT/gw1v/u4JRrlZm+UB3Wl/pTzu5eJpCHG?=
 =?us-ascii?Q?v1wjNpwz/lTkFjTUhva3BaAyfkV5eQRKv5KXhBVf4t3dViSygxPknfoRSHvh?=
 =?us-ascii?Q?PquPJBO2CvpeUhp+kOXfFaEiuv5ocnILF0/cg1USzr7IWSQ0oM08abnovv2H?=
 =?us-ascii?Q?nmENS4NUZ6IIy3alP8fWzeYlL70Km6bqZc4uam2TArhgKfhhSv3TpiZMG6Q8?=
 =?us-ascii?Q?rrmJjD8dCvGFs0QZWzMPICkXAFyZpbGpGfSQmeFx6jvvjZG63E/tfVz98p7q?=
 =?us-ascii?Q?d8w+4UFmUEJZ/jN9iMec6vVsKdkqW5W7RodwDMeMMTeHw3Er3F9Ovxkg4fW9?=
 =?us-ascii?Q?1QSeyA3aob2dFjsS/j0Nek0ArRmam+7yJVfXjNu/Iy2BtV1R5ghJS2dNCjCN?=
 =?us-ascii?Q?CpJ+IYxsw3BBhUtettNHBbaq9EUrwN2BrXvfRcR07ctpQ9AbZp10ZhNGpxwd?=
 =?us-ascii?Q?KzGgC/rR69ppR+ucJnb5z8U44Dr6mx8Q9dvdgo80c0IGL45PQVKOzSaWdThz?=
 =?us-ascii?Q?k6XAFoqFC3HPV6i2IX9NN9CLe7O4nD7ZdZAKm+gMMw6ePYI2Qgbl8N0SKK05?=
 =?us-ascii?Q?Ca7roFmPAlklnX9G55Qa2E+J19VlGzZbsIWcHY4CinzlXGDqzAJLgI20u9LM?=
 =?us-ascii?Q?SEGaC7uzZ9/T66UYmCwZLxRrAgz0j4bd+HT1gYfp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:51:56.2485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84942b0-ccd4-4966-159d-08de3647ce3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
Received-SPF: permerror client-ip=52.101.85.46;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi David and Igor,

Thank you for your patience. It's been about a month since our last
discussion, and I apologize for the delay.

This is v3 of the SPM (Specific Purpose Memory) patch. Following David's
suggestion from v2 review, I've simplified the implementation significantly.

Changes in v3:
- Removed unnecessary RAMBlock traversal and RAM_SPM flag
- Now directly iterates over NUMA nodes to update E820 entries
- Added documentation in qemu-options.hx

Use case reminder:
This feature allows passing EFI_MEMORY_SP (Specific Purpose Memory) from
host to guest VM, useful for memory reserved for specific PCI devices
(e.g., GPU memory via VFIO-PCI). The SPM memory appears as
E820_SOFT_RESERVED to the guest and is managed by device drivers rather
than the OS memory allocator.

Example usage:
  -object memory-backend-ram,size=8G,id=m0
  -object memory-backend-file,size=8G,id=m1,mem-path=/dev/dax0.0
  -numa node,nodeid=0,memdev=m0
  -numa node,nodeid=1,memdev=m1,spm=on

Please review. Thank you for your guidance on this implementation.

Best regards,
Jerry Huang


