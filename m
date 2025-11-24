Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96561CFD316
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNCL-0005QA-Gx; Sun, 23 Nov 2025 22:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNNCC-0005Mj-Sb
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:24:59 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNNCA-0004eG-TB
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:24:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvFOQfSJU9Gzq4jM7RFlMV54CQElb9z4e/YeSJwLfls5Lp1yPH46Zd5u48DdLJLeV/SefKqh71c0NSftykOGdXl7VndvBOOd1N8UwbweALjPGXanxi3jzlXWAw2cQ+xp5Jq2Rf10RwZ560nfmtYrBoBLpm8z140TkWIc70RhfMqgWPYTCjIKBZzq/k7pwnZePv2Bclxp8Mp0ZsRNh/wpcAQtFikxyzAqmL5MJIj6MObPmYm5pCx778FnRch8oZYUCzvYgji47rlDewsWheT4aF2LO9TRDvUBhvmTTd4gUsmJse+P6dUZKLfxQ0BkVw5pQrgob7OYRwYHZK7MzRWayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiK7se19Qd0xoHx2vgEJs3TpWaV+5tL3C22/R0isA9M=;
 b=JWl1+WPqCL6zSlqLLPmRdAqdReX9FRDMZM8+yflcJEUyqsECoRcDvDjPJIwfV6xUGasW2G6XttHDyiuhfZR/hMwW652PZ7hHP4TOgQIsSbp3StvM59CgfjlyerACcGHyqrTMzyM37mtH+Zbiuk+hBAS/O1FAdh/1+tYoVvPo/iD0/t3xIrkYNzMcnG1nGkoDBfgiUGSHhm9ZV+2YOFXQIFRgIgTqXPr+ZTe82wD1GSRm+o2bIKo4MdxiKb0jaL0g7p7EQjtr0JnTxsWf7fViuKSN4pf6wOkJgi/5gyHmN5eoSrC2608nejHsMwXjsC6wLc0DEmgwqROFTMSMTjG5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiK7se19Qd0xoHx2vgEJs3TpWaV+5tL3C22/R0isA9M=;
 b=GM3q0v+6qUTOUHAZZlEj/IxV1dXppPAtt8lqyqaavYvM5jDK8V9HkliW/aCTZTlLeY6BcxspJ2/2Zfr2TqbfReN04CahLhAx6LD4OSkyff6VsqRpN2SXQWLSNBrv3AYs+YJuPItJGKfaRtg5Bv3mj9Gpif1zMew+0cQ70CFFqnM=
Received: from BYAPR06CA0013.namprd06.prod.outlook.com (2603:10b6:a03:d4::26)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Mon, 24 Nov
 2025 03:24:47 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::6a) by BYAPR06CA0013.outlook.office365.com
 (2603:10b6:a03:d4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 03:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Mon, 24 Nov 2025 03:24:47 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 23 Nov
 2025 21:24:44 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v5 1/2] virtio-gpu: fix error handling in
 virgl_cmd_resource_create_blob
Date: Mon, 24 Nov 2025 11:24:22 +0800
Message-ID: <20251124032423.227712-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124032423.227712-1-honghuan@amd.com>
References: <20251124032423.227712-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 19be19ec-fe6e-48c8-a4b6-08de2b090533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DR2NFwVspLbUDz5Q2iz7aeFE1HZn8uwdZkEQ2SCGkIG7+SwQCtkSakbiHrwy?=
 =?us-ascii?Q?CPYEndfFtMYLmQQR/rhs5oqDeBd4hyTc3G37KoT4/gwyeknNgFiVkcZt09xN?=
 =?us-ascii?Q?5JaZnVMQsswcF6TJgb9cZ59WyhH6GY3pDKgVqFqOEiXIC5pcJ7KWuUDv6+KD?=
 =?us-ascii?Q?rSaIfKF94Y4PACNPqDgQ1SAo4KUi9eXh3xcQFknVewa5mscAcKPJ8Yg1B2o5?=
 =?us-ascii?Q?2QqEXwTePjlfTFHwz1/oUTDrJ46SuMEpwoEMIYqZuN2MQJ+yZEdv/Yz/H30T?=
 =?us-ascii?Q?9vLAd5ctcCAvUxBkRNUxRTjqRChSFF+s++cIK8iJrrMZ1E/sBFG+QwcQoE0s?=
 =?us-ascii?Q?rcu6QFcz/s0IHENFtria2+v41OD3NGsU2GL9YhC9HIs77EXYyYpu3WUr4WEi?=
 =?us-ascii?Q?4qonySZzRmdRoMZ9aXhKNrz5bna11p33k/p8FEwU77Wt26x1hYBx2qKBmJxP?=
 =?us-ascii?Q?Y4JGxcFhePnrzON52goznLWpTkZqGZ32W8T8qoWguX6GROyaDTggD2Nd8ImA?=
 =?us-ascii?Q?GASWOSHUmjPiTwQEpinLxHbDbRrXG3jN6guXXl1VdyBan9UFp9TCdaLzf5S8?=
 =?us-ascii?Q?2OOMAAGs2cbYzt+auyEgbRqnauZiY0uOFANip/Ki9fWD224BzUQzaPvicKN4?=
 =?us-ascii?Q?QkgQTRqExJP1+RMcMhU9FZI+4kKjBUpbYSPEt6xICjhxn2qalV0fKeHyP6WE?=
 =?us-ascii?Q?PJKG9KIZYhQpYZuJ5q0aJaH+NMiX7gfphoNHcnI+7x+EwqscwJ3uvm2sN8o3?=
 =?us-ascii?Q?udkrwo82611o5Ngg7nYPMmuMwiNNQOdbtZMO4b3loOTeBDv7Oyo5JXMeEFpu?=
 =?us-ascii?Q?Exs9wCagVS1Kh5LL/a7LS/x+9bhrrtAf2P68uhMrRWCmh+eYm7HeHL/xS1UB?=
 =?us-ascii?Q?tqOeJBLtbPmqcwpof8txRX6nC6ixyh+wR7AEODGGsNU0wfk8ex2NQu1sm6/j?=
 =?us-ascii?Q?tiaTfmVD+2K0Tw97ls54dyNp3nzDV9WO6+WeYQREa7NyvKrVNuS3NkOE26Wh?=
 =?us-ascii?Q?uC1oWg073cxaaIq7eI+5R56senVwTVSqhdFyGXkOqdqJ3M9N7kr48/W4+1a2?=
 =?us-ascii?Q?BaZ6+JA3R2ZHHDWtIfeCzen8wNaTM0Crciz75NwKdFz9Rn658GoAO5nHInjO?=
 =?us-ascii?Q?93m6vP7H5iJiszcdsuYSTCYojBTWviH0pdD0NxvuOIjIUxCnZ0Fcm4NqROur?=
 =?us-ascii?Q?/j+GifhZf+dgHmF4x0pxGkXq5Q6GSvARv8o481sPuYxA7bRgNlsCTvxI5L8d?=
 =?us-ascii?Q?y3ho2XEbx492N5QbyMA00LU8bs6jtqfIIybXXmtI0lL5EQRyOjdJfihe9I1F?=
 =?us-ascii?Q?L3HpZjIGl/3Rno7xm64YMPjBKRFjILkF3dj1n25HANGEe2tJQ063gVJEFPZZ?=
 =?us-ascii?Q?Lh3sH7LfzCvgxlHpadH70ULACcMwPm7JvTV7MkQkqNJ0bsFHUE7uwWuKZh5l?=
 =?us-ascii?Q?iZw3MRc1Ua5Y1UaTX7xw9vYKF6jK75mKGZTh6ZnBRjgsvx4gPZ3V66WvxDKX?=
 =?us-ascii?Q?Zzy3wMQhTUhoG1HJyqsugpBx74pGHPmV0g9VUQNnI3rSRSLqmPNrQwF+/lKz?=
 =?us-ascii?Q?jO3IOcOzPjoRoDuVTOM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 03:24:47.3816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19be19ec-fe6e-48c8-a4b6-08de2b090533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix inverted error check in virgl_cmd_resource_create_blob() that causes
the function to return error when virtio_gpu_create_mapping_iov() succeeds.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The check 'if (!ret)' incorrectly treats success (ret=0) as an
error condition, causing the function to fail when it should succeed.

Change the condition to 'if (ret != 0)' to properly detect errors.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91..e60e1059df 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
+        if (ret != 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
-- 
2.34.1


