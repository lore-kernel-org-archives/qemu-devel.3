Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0921CEBF92
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKtdN-0007Gu-Tc; Mon, 17 Nov 2025 02:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKtdC-0007Ge-QP
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:26:34 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKtdB-00041Y-5U
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:26:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veLpbEF8Rp2B+1Mp7reD1DNqf56sXJ+mAR8Sw8GisFy4/FLq7N4wP+olcqXOhr3ak1JrDtidylDPKD1el5EZM+iUBpJs4xtNwfuut28YzSNDTqMLtdds4HkjDq3pBFQjqOKEY8EYyPhF+bYKuTunq98kIo6jeR83mBfNqHgiBFagw+vv2FzJN46U/8qk3FGxCpj8JdpCt6zy4wseo4OObSHGtdFJwQecd5h+yTW3MDhQaoC3e2HHXrFtIFkI8hjGhzsygAdj/PXP7iaLIiynB3YufBry/Scu2Wk/wJc2KBMOdTcFT1ZbmoWrQ6bl0NUEMSK8BazJy7Z2qyD9icHJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4++MH2TbrNAoLll2np5gdCP5vBPrur4GtnDss9u0Ecc=;
 b=Rlg+RCCSK3UJL+iNfaYj0GO8lkkAO6erbkjYJ8CBl1te0PK8mdyYwIzAQzL8nb/mvRW7k2MPqZ9iKuHsHctFc4np8uEKirOzQse8QmxuPiIZr+c8Pqg8ZOUhpWvcT3Mb45bFBvNVyy0Wd5hgpfWNeV2aLaGn1UbX7xl9Co3ZFXsjtTjA3Zh++ApI7xmk81/B0ns1rrIAx8S5P5ayQhP7SnMqv8Hvz4SdtxDKHzE6QoyESn+FPTaoZFQgzo6G+a6UHXqs1zpc1uAKRRbECW7AACvkE7JZsm4gsfhrJV6Ak+cKf4PzTRIiMwvkFgXhvNM+xde8lLSsn2kI2cY5Jgkllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4++MH2TbrNAoLll2np5gdCP5vBPrur4GtnDss9u0Ecc=;
 b=onKfaxBf74LlVRzSROIlhZJGr50rlM08/L+z5Rc3U5qUlgfRx9kXQdWvTZcBMdW1Te+8FV1VHd9v0qhRgSYIYv8HHYbUUCaTSEQ3EQ4oo3iMngyLq1wxs1iAi/jRcgLKiRb2yK1YGk9dhcjaurMPKRpa55mk3xMV6gkjonVZz5Y=
Received: from BYAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:a02:a8::38)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 07:26:26 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::cb) by BYAPR03CA0025.outlook.office365.com
 (2603:10b6:a02:a8::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 07:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:26:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 23:26:22 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <mst@redhat.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, "Honglei
 Huang" <honghuan@amd.com>
Subject: [v2] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
Date: Mon, 17 Nov 2025 15:26:10 +0800
Message-ID: <20251117072611.107507-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2a58d8-9fff-4822-a9bd-08de25aa9e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OCO/bRbv/f5LQS4nK1C0z6GkOL3M6xdNusd+Hgv0C1iQgzBl4Wr7EyYV4GU1?=
 =?us-ascii?Q?AxdcJgr9YJp1jcpWOcQDSfP3bMQtIABOvuwMxv2t/QMx4RzWVnRpELz2UyLw?=
 =?us-ascii?Q?NB0we2F2tgmSEblW8w64RBPJBKWAkvbTzbDRZT92JJDDUMUvmwsFEDL20qZ6?=
 =?us-ascii?Q?UEpU3AL2aODmnNmcFadK0w/JWabDNX8b6/xu8QVZzTmIEicJQz2ZJVRr1mN0?=
 =?us-ascii?Q?Z3V1hNHSHhZ/gKMg2jJwYUbni47fiQxhwzHuXicrz2/9RIhxwWPC/RgqRuMH?=
 =?us-ascii?Q?ISX/8TRuF4fYB5FD2knJDXaOAeQ43P8IijiEZ5yR5A8kbvq7OQJROjzRkgee?=
 =?us-ascii?Q?ujTD4VJOlRebhFaPHqxg7fv+kMB+sHLlN75mH2tH+WK2XLQkoK8wYrFKOaOl?=
 =?us-ascii?Q?7YDRONxGOGPJ2Wn4hde8L4wFIuR3kKsfccFHnwxfUMR4Xe3lbRX70TeJgFbK?=
 =?us-ascii?Q?ioRByHSTufTMdHqbdbRCkK4Na/nkj01/1bo+55L3x6N7AaTv89DYq3aksMdR?=
 =?us-ascii?Q?rmI8Cj+tkjaq6oJTciKquVxm2vGdlp2TvGCMXgrdVTob9jnxAapdw/ZD3fxt?=
 =?us-ascii?Q?k48ivEewAg8odT0llRjx0Xc+JEa/3ISRuPbUMsfRGmIVXOPnvZTqlavZh+bA?=
 =?us-ascii?Q?t7z/v5r03i5JDEdGn0x38ady0jQRZJgKymQBCVP57rtUVw21fpLGLbLRQnz7?=
 =?us-ascii?Q?90RfjTltD0WqxC5/I7T3OQZYNpsRv/+eEegLVVeu9u5Pw1VrvycsAa4q6cYg?=
 =?us-ascii?Q?YCCR79o4t75cRynG9+iv3KnZZm2QHuoqspBaxrMJGMB3B18Wix+Mygx+84Wm?=
 =?us-ascii?Q?Sew9mBH0uxjUCeEl8cxKJS2xPSlJIXcTbDzE8l3xYZgufuHvbMOpII52PNwz?=
 =?us-ascii?Q?hjsn4QbQitJW4RlAzDokhdkdRVcsQq0VHexKRY7tADcM4DjcCSW2WeOz9/dm?=
 =?us-ascii?Q?FIxd6xK6xkgqoMhjaDi2Mm0CxWufa/fxwgi068JEr52vf+ypYG0nyp719a5Q?=
 =?us-ascii?Q?KS8h1hvthGqeQR/z3mR5zmOFftVqeN0x7UjPemk7TifglIEYOSAAcZLtDv+D?=
 =?us-ascii?Q?VadopfSA6elmZww8epL/bG0yzlHeF5/jSBXmktYTZ47KAbiCW7vlxjWaCMQo?=
 =?us-ascii?Q?qUzdHGoKikUYfeU8QqnQFtrT/jWKYpwz7dJMiD4C9XXisvCMCmQmQ+x5Xtk0?=
 =?us-ascii?Q?P1KSZhxJ7n/M0RojKoNcvUSvafx3+/JOns0TuX7nHmIQSRLDzv1mRcLh8S5w?=
 =?us-ascii?Q?+TuuVwCsEIg40k6ereoMgwUmUUFL0cbet2F/vvfNDrwD/1w44obhQ09s5RVi?=
 =?us-ascii?Q?2NiepG+shviJSiBTtF8IXD85NdgwuAM0j8v4jkn8UfGtHmX+kQjzukZigXww?=
 =?us-ascii?Q?trpbUkdjenN0BJ9ehflfmtvMhvYn7dzS8n/vwtheJEkrhuaU2LaWSxlWDBwS?=
 =?us-ascii?Q?1OydCzw/DzZVTZVV7xwSfKTL3hH9rTMTo5RyWdQUOrkTEOJKwb9jQgOKuGIV?=
 =?us-ascii?Q?PzyBWXgcVHJK+d6WBU7IXEuToVie0IKY/4hBqebD9LplbP0NolKPauMrgOoE?=
 =?us-ascii?Q?NkXGAzFJ3VCHfV7wBQA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:26:25.9786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2a58d8-9fff-4822-a9bd-08de25aa9e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The error handling logic was incorrect. virtio_gpu_create_mapping_iov()
returns 0 on success and non-zero on failure, but the code was checking
whether to set the error response.

The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
properly handle the return value, consistent with other usage patterns
in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
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


