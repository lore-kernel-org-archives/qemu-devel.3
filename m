Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403CDD4A613
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfWh-0005LQ-W5; Fri, 16 Jan 2026 03:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWf-0005KW-TD
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:49 -0500
Received: from mail-eastusazon11012012.outbound.protection.outlook.com
 ([52.101.53.12] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWd-0006l1-EP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISNreMpfonjcrAuRo7fVMKN7f8HpotdStwkdnrC+CYgZuGpogdVnPHRT8GifH4yJl3i5dDDumujvKlEz4Lk9GBk6N7O4fi3mSesA4FOX8MQLLAhBcgX4aBuhiIdKQ+EwJV0UG6bvsokRUTBArKy102v5ZqIRL13YzkFM9jI0cn//FU2T0P7DSojM2YE6uRmjlFRulfRPzqrXLN503H11aa9+gVkHTKSrl8tuoGjNTh3Z76GQfd6eWWQwwYKvp833XOvtK4sj8T63Kz+qahhrbxvxtBjxuCu9M8nP61lLwD1PG5cI/TxRkZPxnWEOP71ahNyWT/LOc9d40Vbz9+9LWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3zE1tjDTQC2vYWbHtliS+6MkzXyL9ELFKpb2LMIcCU=;
 b=OX12xJBrb8sxsFZzZTB2Z1VBUFYrrksGcukADl6zcFlbPOG+WBfXAk25DRu9kk8gXsms1HpU+3hRmBFAPQ4ebvKfjmNh8yljxXUYapuxTVUwpfkA9V5IM2z4+WwuLdbCr18nQHP7fJqr1sRkFyhc2RAbs3bOShJUrFw7DmxQ8mcgLZKDvFBVu4gmYjXw/s5WXfBRT3PHb8RhkltZ7bq5hWjzekZFCJBSUejVOBb2eipocJ2cx4frMLCTvlifAAsgrwnrLl+IytZr0RNdVyvS1LTfbNwtzWmB11YbOglzA53newoSJk1jfxN/0fKbTSZTvfZX00PINQ58H7TPEl5Qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3zE1tjDTQC2vYWbHtliS+6MkzXyL9ELFKpb2LMIcCU=;
 b=vHriO94sLsDmB4tAh8lmj/XFATMwhbHgQHs6yfoEEzAIClCQCuNRLhwijzw+CbHkG72krAHK/ZqPw5ZfdMqfWP1pYM0LgB4SunKFkP0kq3pT1mNwA9WWK6Mci90kBjoaX/Th2jlH35y2+RO9qe8JKUwEp9R7Ra3DdbUyZPV33bE=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Fri, 16 Jan
 2026 08:44:41 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::df) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 08:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 08:44:41 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 02:44:26 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC v6 1/4] virtio-gpu: Update Linux headers to add userptr blob
 flags
Date: Fri, 16 Jan 2026 16:44:06 +0800
Message-ID: <20260116084409.326062-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116084409.326062-1-honghuan@amd.com>
References: <20260116084409.326062-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c081a16-e007-4809-0ade-08de54db7d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2WGiLy84BDDbmfXERjoESlWUF/AT9TBk4oC9zWURCjZRLp8Dges7lKJ6v5Vv?=
 =?us-ascii?Q?+09C+NHlmu9clowjqE29Q6mWFL9g8cFPIk0G7Hg5Nha3h3Zt+BfawO2RMSIB?=
 =?us-ascii?Q?NFi5upC8WKZDiLaLmCkD0ODtcwt/HWj5ketfScKy8aV9vVpuHFTNwdtiCXTN?=
 =?us-ascii?Q?CMQ7GPh0LE0qVpV1+JGQpB8dEpAZpuomTLch92ITxCFDvdr1CzgCQYBSW/kc?=
 =?us-ascii?Q?AbOTo2WPlKFFELknP5DPmU+2uJbVSUzSdXS2I/QYqM2HFWVu61lOsAoWq3jp?=
 =?us-ascii?Q?tLNzy0ppG4ZhRzGmhX4RhWDyR7ffRgwhDkkUVn24zFyqBbk24DYKzNWpnatW?=
 =?us-ascii?Q?NOu+2whOwI/gSDfZJhGxM9L2YpVxhm5uzEahrxHevdhZcRI/sO8nd0MHpzDp?=
 =?us-ascii?Q?JrmTc4DiTkO8fpoxejx/vUHdpcbn6LYKMrz8xqcdJT//ubhtwRyZaB+0IbHy?=
 =?us-ascii?Q?XxrwAQSAcsZUEYM9p8ZwDyuzYoEBeyyZ1Qk7YlBhKZkJ/bwfmoUJNxus7EFm?=
 =?us-ascii?Q?HWfMsDobFBwNopDcsOPYAQ6j7nKxhcED6+ekr25kJFwKqQQMg/Tm91PFugWg?=
 =?us-ascii?Q?sHJi3P2bCcr60p42hsyoqxVwXwj3LnI24/DgsE9Xwg40UgoRqbgPSIPWAdZd?=
 =?us-ascii?Q?+6b/vzQ/1oQXWvKxwgzxWbmo1kV8DAaWROe2VVCmkp2K2B8RsYzZFptv8rQP?=
 =?us-ascii?Q?+idzGLXdvWYvUNNVHEPbI4T3oNQ5TllQMGo1p8CYSpfIdwtBDiJmB4CTkImg?=
 =?us-ascii?Q?1W9tHocHEPP33Xj0HEdOJPkvfO6JG6NPeFAn080GPkmoQV8Cai6tVQEvjGaI?=
 =?us-ascii?Q?KyoRodyDI1LeoM5BQsm8c5Vwwp4NFYpml2BGdy4hPBKNlR2jmccm1DEOVLtm?=
 =?us-ascii?Q?gvDqSs9iHkR0JZhjWkg1pAQWymHCXlfIz1GyK+Bza+olr+8Zq/i97/20X6pO?=
 =?us-ascii?Q?9ijhhhB5BOiPRzdd25f1ZUX5xalSF7mewwpi40C2ARBX8TANfmMLB2gtF0N0?=
 =?us-ascii?Q?qIsnMyLl67d1qsNBjhDSLHbkLjpEMaHEEWA+jbn1xAvVRHIiqVmDdZRnxdDX?=
 =?us-ascii?Q?Y0VhZLKhCmLgxZTdWv3VUtOo3HlFPhqTPGnBAijleZzsK6plEqstnopYfkhE?=
 =?us-ascii?Q?TFCUL+c8WG9et/GcQHa2yNnV5zhDuzkjc5HsRtE3eFdsvUk9g3aolH+dGq6u?=
 =?us-ascii?Q?fSPCguS3tYXCvUwIrhYbEi2F6K632oqcGLohibKIk+L+usRleJc33MrGIQOw?=
 =?us-ascii?Q?v9V9I48e+gnEaFQIAgNwuGVzdLAnbo0oVZ0sNW/4X82rPWg3ViFvLCqxJfq1?=
 =?us-ascii?Q?N2hXK36byRmiwhVKaY6AkgOoJQ6fng9sLcvL1YEK9i/a1AQKjI8FaAiEudFz?=
 =?us-ascii?Q?s2DDL23Iuaww6GdvtcUZKXRQ8QWquT89DUJheIjyFV/JXTEY8ZZyTokToNnF?=
 =?us-ascii?Q?q5RX2Yl9VYFY7tsQr8QJIGOYLunExKcwSDv5b6joROsCZ8eINWipXU2+TfuN?=
 =?us-ascii?Q?MHWQ4rwYPN4Rv38r2+uG6k6BnYJi0l9F/whPIgmXEPekzzg78+/epw8fQM8C?=
 =?us-ascii?Q?YXfZlzrUwUrJATI4pcEtMLD+UKAfDsSukNNkvUk2xiUM46MJrrirT8d2C0kT?=
 =?us-ascii?Q?i9EDIwlWZC0tAHip6bJaeBOTwFQsj0mpw9xlUOIjh0mCor2gY5xbjNEEKLVD?=
 =?us-ascii?Q?2RfSqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:44:41.1389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c081a16-e007-4809-0ade-08de54db7d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
Received-SPF: permerror client-ip=52.101.53.12;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the virtio_gpu.h header to sync with Linux kernel changes,
which introduces two new blob flags for userptr support:
- VIRTIO_GPU_BLOB_FLAG_USE_USERPTR (0x0008)
- VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY (0x0010)

These flags enable virtio-gpu to support user-provided memory
pointers for blob resources.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/standard-headers/linux/virtio_gpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af..c40961bee5 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -405,6 +405,8 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
+#define VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY   0x0010
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


