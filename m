Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF030CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKtpv-0001SH-HI; Mon, 17 Nov 2025 02:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKtp8-0001Op-7Q
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:39:03 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKtp4-0005aw-Or
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoV74JIrfIRALHskrzD9sJinHcYcYb9S8COo1LNWpTLVR+UJfJMJ1MgiUSMxxI4ifqJH7K71xVZmmMnpuSZ5U7Y6DEKDmkDjyRJMd25fB3G9HmucbMfH5+bcYCJn40k+v1KMK84iYitYm5n1houbTNq0554Xo9ci8RZOFPhdOrX9EgKVpTXxPivt9+qWiqgwmpkRPNMdmE5Z+fNlNBgNEaYvddYiO3mT8KJxQW7ebQXiXEAUOqbGCiCqrFjpvtPZE2jCTSumFx30daRVaxSA9Hu3vUC5BodcQc96Zq+BK0M9nTtR4tNEqfbO9R7qBgNmLpLOi0zbdmkoZFtpC2GRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vurPIQEBgUEpzH5sWQR6vn4OFToANJqHOyBe3u4IwzM=;
 b=aRJzpIoXYpMpe9zLZ+GB+3gZLhLFMhnY7n3U1weUGyS8Bkehd7O8Bog71bc06Y3VphiK9umKjpZJqRqXpLvuO/KVAm6KbVd9R5ogKUGOWrbVwOyt2lutG+lNqsL+RYR3e34Z5POv1Xcnwd0VYvmVJH8sK4euatNQmBOZMob2aNwsXXjvy+juyoLuaIAlzx9kIqObfMO1I/fLzpgCEevfhgVIOao73slUFgiFD48XVYzViRCLkKJ8p9zOR6iMYSKW0BrBYw/Keq+JBlQlPnezCiW1rWgWyvgV4n7c9Kn8lf4LnFM1RfuM1YJliWMWf63OSYAiJa16KlKIA+BeG3O9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vurPIQEBgUEpzH5sWQR6vn4OFToANJqHOyBe3u4IwzM=;
 b=sSgCYF/BR71oQVXWcn0Fv20LZqzEIfY5NVW/6fnpEvG9Hs4lVMpRBVCgK+Vaq9KnAA6YPeWnd/hfKD5bCg51KvI/7FlGw/JLF1rEdxfokNJlUnu6NaTFRelaBQ/18Nb6l6p/yctr/W9t40aORMT1tckTYf++PFsEyA6h0OHas0g=
Received: from BYAPR02CA0061.namprd02.prod.outlook.com (2603:10b6:a03:54::38)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Mon, 17 Nov
 2025 07:38:43 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::38) by BYAPR02CA0061.outlook.office365.com
 (2603:10b6:a03:54::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Mon, 17 Nov 2025 07:38:42 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 23:38:39 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v2] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
Date: Mon, 17 Nov 2025 15:38:27 +0800
Message-ID: <20251117073827.114891-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe08a24-80d5-46b8-9724-08de25ac5548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?93B9Ajh4Dj9G/A2+VC3M6b+8dXZfKXGw3XbCiCw2CQ0Gz9mhQ2Ht/yj7WObT?=
 =?us-ascii?Q?kzL7yisYzIflD+nGpIEwNCf/rkpMowQ5roR+hjtMbY/ikt+WXWAYs9HyQDQR?=
 =?us-ascii?Q?e+jVK4nMLNXImaZAHt3B/gRAtNn6ggY9LSdB+5aYa+dJDNPF2fF/j8QtL7DH?=
 =?us-ascii?Q?a1VDgClw8qwip+8qmeOIG1T3/HOwAgq3TQaIoHQvhiwKXp/3t/xZisDAkq9j?=
 =?us-ascii?Q?5Sr93dh0uPDlcCxpZf5VRZToEUmo7gF9Vl/LyUyFNSMYf3sOYyhTAtli/RBg?=
 =?us-ascii?Q?4ImsTjOJphf2ZIa+DkkfX/MUTWeynViH0apzJpOielLl4Q+IS6pVC1OAdQ80?=
 =?us-ascii?Q?YQHvwFK0iir+0A4nWAUU5F1Kx8mFWdO8ets0OLdFTGwAJhdb479LSgPu7XXq?=
 =?us-ascii?Q?eM5rAEh0EQFEYWt7lGnRUr6fOoAu85B6uPJxfdQhUyKsghWAQjW0mPkOY1b3?=
 =?us-ascii?Q?S9IwAINOIMvJSiZKK/88CW8AoUmPSMqbVyhJNpztlzsyehFQD+s8PBdkNDGe?=
 =?us-ascii?Q?UY6bJP1yg/wmPpXP4fJlr5tqWici02MUA/N+OS/WuR5bpeyWF3e1xb522x0/?=
 =?us-ascii?Q?fy6DxsDPDn09A9RdiGgnOOJvTF8kNzHYRmy402yQr+w+lPTaUsqVpMNjc2T2?=
 =?us-ascii?Q?RjPCPNDQt210Mty8kGqSfaMY74E6BkmFPsq/Tq+rwXSWoqGmTSR5HpxdpFfZ?=
 =?us-ascii?Q?fLJkx4JN9M4EEJvGvk3dCLbMSn6QKr7qfExjpYuJQUV60qb5bo9vKQuKRjGo?=
 =?us-ascii?Q?woSILnJrVNMExJEP1sYNTPwWho7diO/XDjNO56aheCAXgCEHMVU4BpyaNIfF?=
 =?us-ascii?Q?+U3SanrJah3ML44KivMq5yP4mMi263rhQUPdYtBsmrv2Cw8StTaDEw1rWyKy?=
 =?us-ascii?Q?Of3ipDTdz1SRng+Es16AykM6RH75OGBZmGe5V2RPQt9kECl9fEEfJVv3zz7H?=
 =?us-ascii?Q?1BuKUtF5/VpI7+bxOAT6X6MIUM/IFri38IUn6t9846ghlryj5P7JpZXj1qug?=
 =?us-ascii?Q?VE4gY0EQc3jcge0pdpQApONPmGYh+4NL/AMegwksYhhRPCmoz5rB5qVnydt9?=
 =?us-ascii?Q?7U1BNwJ2WiRUT+JNQG/A4sEp+pXxPM7ys34sWHJ31E+Pa8WSPEOsFISBbmSC?=
 =?us-ascii?Q?U4bDBGmRZ0+uEfu1JnNZHt1iqaeUe/vjM6k+2WKOqNyz/nET8iDryWKTYjNh?=
 =?us-ascii?Q?+wqVZyPdptqJuD2LqGHtU9kpTT5RRKk1wY9cF46b0odjfp7Yw71NNGzdyK+E?=
 =?us-ascii?Q?SIv8t70MXHPjFokHCd5eCMsX6HvVF9pMQANBus24yqca819YVA9I2HrXqRbh?=
 =?us-ascii?Q?LpsQjUgwFth+FaBMLG1riqnCzJxzHyLHr4aEE2V2PZs5tNmiKFd4s+EsZ4VQ?=
 =?us-ascii?Q?Rzk7KeFyfBIGEW7ZlIL+N9yKAKbNAdNJE16jyvyAWmCUzbSWrDgKBqiutXLz?=
 =?us-ascii?Q?bDdCOYKMGT992q9E221Y3MscklDBrUMJVyMTuib9OGD3EY0ltj7PPCY6ID5J?=
 =?us-ascii?Q?tWvG47V+ph2lq6YmLqu8hVMG1InFenn1jdACVucp/j+CqDiBI1RF+jqeCtwu?=
 =?us-ascii?Q?RXlxiyhwmDw1Nc8vy+g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:38:42.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe08a24-80d5-46b8-9724-08de25ac5548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Honglei1.Huang@amd.com;
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

The error handling logic was incorrect. virtio_gpu_create_mapping_iov()
returns 0 on success and non-zero on failure, but the code was checking
whether to set the error response.

The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
properly handle the return value, consistent with other usage patterns
in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).

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


