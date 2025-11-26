Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217BDD10373
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 02:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO4rn-0000za-Ja; Tue, 25 Nov 2025 21:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4rl-0000sm-4E
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:02:45 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4ri-0002ZX-Sj
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:02:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM/Gc6YRQzhLVPsc6cGZsQMje4UG1ovNwsszblJGt2E7SQsT7oc7IZEnnf5GHt9uSp2YFqku2GxxU4524jN0b6xDV8DnXeJjhHBJebYDTFfATfV42y9OqjiHi35Wq5JnUrAFm6PWcllxwal31/wdHn0N+PBhOIY0N7HhyG6gJ8nJp8NrehoqWo6zKWSCZH6nGXoKq9Ijpu9mshrJ9cL3mgxv9GTZfmnUurdYsK4PNAssAmlVcWi96PCksI6cEvlioR0N0oMBOfQRXkcHN54Z2YQNVAHdLirN8zCdOgc6ySLCHtrY/qYP3tgD214cpeTd8FePEL++I9Kjf6PEQV+clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1gkB3o1NEuWSGuVI24D6NEwy/kKHWK0wS6FvAkvqpY=;
 b=LhVB7arBUuT8X1V2Tss1mB6S9BPvCvN+B9mlsZ65mZMEnp0rl5CZd7xsE/qH6YABC42CaGzauW4tCMqNtASoX18YSD0NH0lOlZvaDcgodU4myc/sskZj8WqZ2BR5AWip652+kkyqN0+ZNQA0P0NL+aSOd+mKWKBATaYYMoVDD/oFsRe3dRWHw7NCVWVdhLT4fBKuCnervK2v67Sa86a0rAgmHxRqum/NBmyh+3AmRjci2j9OxhzxU7hcVX1cL4jJIx2CeTzbELrEjTd88GGvvQN3UW88ay+cXw0KYLcjA/H+Wo/LYqkySVSmz1G2NazgmAnRZRGTiI9Tp8wZk6x8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1gkB3o1NEuWSGuVI24D6NEwy/kKHWK0wS6FvAkvqpY=;
 b=EKlgOBAcsyG+37bV9jNtZVmpWwDacGC9MACXQSH/cqdmrf0n8PRP5Xsq9BZCt950lJ15rypD/cNjPqUzIXJ6+iRopnLa+MGuYyuvJ8yKx1xGlyd3q91sg1EauXzBNxP8T4mw57j0iALPl05vuX/vgr0jRUpdB4euARgU3w+rC+8=
Received: from CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::28)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 02:02:36 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::81) by CH5P221CA0010.outlook.office365.com
 (2603:10b6:610:1f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 02:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 02:02:36 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 20:02:33 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v6 1/2] virtio-gpu: fix error handling in
 virgl_cmd_resource_create_blob
Date: Wed, 26 Nov 2025 10:02:07 +0800
Message-ID: <20251126020208.2449414-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126020208.2449414-1-honghuan@amd.com>
References: <20251126020208.2449414-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f702b8-be00-43bd-ef77-08de2c8fdeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yK0vtlA641AheYHcEuOxgoM40k9X7a7I1n4Es9a+UUPqfbe6UGwYVtZNCtA8?=
 =?us-ascii?Q?u/g/hYhHMVCwEP1sAqMpvOQ16xG7qakgxoO8ykwprjQnXb5RQNJgEcpTLmXv?=
 =?us-ascii?Q?OlNmPTtGbOd+R0jHQzNmjUDMU2h+YTncceBkNxVyQU1Lnz581Jdaw2LPDVcA?=
 =?us-ascii?Q?q+kABl/9wuS+mQYvoZLgvOtFjjgWJ0s05g+o2bDKgnebiYKzxJjRCw9tUYBk?=
 =?us-ascii?Q?yQc8bK/ZlQKgRKf2L9W9O7lJtn0srpDU1E4KCLGkEft7GbcVwOMOUs5omrG4?=
 =?us-ascii?Q?9jm7MpTA7RgwPj3GNStRbK7xDUNAbV2B3mIEOH15WPxaBC6Ae8e43Oof7wFp?=
 =?us-ascii?Q?Je0MeuyVcfXxbHhVczF17HUVe46Rcm/AwKoK6SJf23AltEYFoa5Ia+OjZBgH?=
 =?us-ascii?Q?MzAZ3Oqf+4Lrixb7uSjYs8LsiDCPf1v1Yly2DR7SMKCs56XXpSO1IFi7CHUE?=
 =?us-ascii?Q?APBXoQq8B37lfv56vChhfGcnsua7ifdcUdKWaCG2sJvajyqCp6k+HyD0c+bZ?=
 =?us-ascii?Q?Wb+8VwgI7NkT3J4oHZ0zgqHORWLmUG96LKGryJJQxqv4ab47edaKb9NJUveM?=
 =?us-ascii?Q?VxUfYBkrl35y8zF5YInxZqdM3CZsT/ndBsip9oKTeqvD1km0j58ikv72bZDm?=
 =?us-ascii?Q?aPJsOSnz9EN8i79v9FQkg6H5bQvfuOMeObd0FIx96tHzWHIjZaEen2WCuo6k?=
 =?us-ascii?Q?sXoi3eSQXxvDePP3FqB0djpTD/4dnK3zED2GY/lGwfPZyAWTw+jxUYf2gbCJ?=
 =?us-ascii?Q?bVL64aTWx7qNn5uuQWQ4cXFd1WHAChpyoFpOVg0vX5x/Wym7DO3x2U+8bX59?=
 =?us-ascii?Q?zru/rJCu+LyBGvunoLBxF0p3M7V0Ix1WXzDp/bgPDLwGiOCQHgB50EUFuGOm?=
 =?us-ascii?Q?3+RoDqN9m8KcMyYM8ippxJqpseWPgBCd5sHl93E00suEAxXEnbE6R/gnGoWd?=
 =?us-ascii?Q?1Jp4fzLHl44lt95gtVP30S4hY+QdjhR6Wa/sdqBVdm8P7pAVP6QsThom7TWA?=
 =?us-ascii?Q?EDYH3tmmQ+jgfYufhyaEM52PwE5xQSl3XeFns1P9oC+zY1hGPO5yRG/X2VHk?=
 =?us-ascii?Q?TKOL20r4LlvWQxwgVzmzFsHLcdpT61ildBjsn5eiF3sup4TdWHo7unMwU/Ug?=
 =?us-ascii?Q?rTd3RflU7csah1OeaLaF4MdAjTOl3Rl+4BkI+Pzvonbp4yq3j98z+T8l9grE?=
 =?us-ascii?Q?qR5TamPMzHXwsMIKlPe7KFbTQZhMCx/zYbSeyOkQS9IZbkM8Blg8E1oET5K/?=
 =?us-ascii?Q?eBEV2m9xenT9nfeLbQ4z6NVM5v67TSN7hR7lRggJdcgkHS+qAPufUZuGUwPm?=
 =?us-ascii?Q?NMFmKlsw0KtFlsdPGqi4AnkK5smp65jeQBGtNevfK0LpkcvXAwsnHyRRWers?=
 =?us-ascii?Q?xvLnkwsGfT9T7kMYmejL+rjCbpiB12IIH1Z867lSz+EmsxPmRSbrG6x4CJEo?=
 =?us-ascii?Q?tX3sy7RxExFvJdzlwIesP+QMiQRJt1JPJUIe6hpCGrFTMGBzQYybOnwBXq44?=
 =?us-ascii?Q?H2fyt3aagFwWUlNDVJLvhuG7YGOSd48PzM7Gchc8Y8ynd7IXH3kwidQvkbMS?=
 =?us-ascii?Q?OH+gTtPpHk6Pmi1bCbw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:02:36.0794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f702b8-be00-43bd-ef77-08de2c8fdeb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

Fix inverted error check in virgl_cmd_resource_create_blob() that causes
the function to return error when virtio_gpu_create_mapping_iov() succeeds.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The check 'if (!ret)' incorrectly treats success (ret=0) as an
error condition, causing the function to fail when it should succeed.

Change the condition to 'if (ret != 0)' to properly detect errors.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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


