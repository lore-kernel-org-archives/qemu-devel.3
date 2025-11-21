Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CC0CFA47B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMM2S-0001SL-8Z; Fri, 21 Nov 2025 02:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMM2Q-0001S6-KE
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:58:38 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMM2O-0000Fe-2r
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:58:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gunHEb8mFa4sXbuXf4+YfjTTXIGX0hH/EJmfbHOovcHtiKuflkVo3npOapWbakk0Pxye5TLmR9yePE1Zovr1q47xn+iNZFM+VowAVoUlauKq4m4HiKeM4pQ1g32o2/sx/LWKPii1Kgp8lfaT5EaQs+C5C3sqtpduSjfnUu5nRBx1M4nHdhHhE9oYPBXO5cJnuLVD8a8XOB0LBLQS9B2S9yBOs5/wqD4uoma2i+AN/mremy/IjQqR26XWxoKE2uKhhIzuGJWPMRWOO8YRFGp4UYwZ29tlzvrdwnPUzcuQefeMgoeEJfUrjCi45tW3sqOVJBJtryEK3Fun+t/NomOJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INh5Fnc8e7lU2ULliVl5JS8utZa/zsfiC7gWfWK0D28=;
 b=QEReRzJaIPKn92ZTH5EZfRlcNUq0rvz2lHcOSFUCERi2WjcDrXQMN9L+GxJbfphtflkwTyOZl4c/lQ3/RcmNSjtJ1+pCepn2PV+0Pngro1+ngQ+yXrNHWtG9jDEiCMrMDoSsNek/ljRA0SKJF9q6mLYhLTRS6DS0sr2BCDJM07cryuQJ2Pqd1z2k7giur5/fTje/ECWCO8Z8yhc4duY4o3Y+TMtkwPhsKJ7fe3dQSuLPdn0rJLph31DvLFavGW+OVf2QK7p9UaCdtDx7Msoonc5+eUyvHd04up3YGUNA0S3VihE4BJ185nnh0Dvz/J6YhBpi8HUAeGQFEKnZsT4ctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INh5Fnc8e7lU2ULliVl5JS8utZa/zsfiC7gWfWK0D28=;
 b=4IA9UTWdgsngQkFYbBwThN2qXTcJXUCK0lUpSHliSdQ0dLoYEA/MAAmGB6Lpyp9HcVYoJQe4ahp/j6Vbpezc0AeVZNZ7MnF02hm65fn/molHqxhus3OzvyCQIFQvmy6vFe4p1pSAwipFjWMDLS/+YBr19Ss3gOoaTvr+T7RF7ok=
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 07:58:25 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::33) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 07:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 07:58:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 23:58:20 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
Date: Fri, 21 Nov 2025 15:58:02 +0800
Message-ID: <20251121075802.1637598-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fb2fd3-71b5-48e2-f8b7-08de28d3bf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HcX6FWW7reaQVFSklBx+PYkbmYG3FWg5jEiWgjXtExtzOuC9mtBBFUKiFp/a?=
 =?us-ascii?Q?fS8NeKsevvNs/zXbaCYKJ7Xc4IlOuiLTrJd2osCL5Df6Gfi+u1cBT/K3TuqQ?=
 =?us-ascii?Q?sr4HpQkGY9VMZOMFmpME7vlMj2Eulffu4TeG4+rcCSDNWBjWZoML5TPQDSo1?=
 =?us-ascii?Q?2cCFb/EmGD5nbv0thiGYyY6Dc7/aHdaNVKoUVv8Eqq/dwCEGdZq5cZPoG1kn?=
 =?us-ascii?Q?w/Yv9cizQ/TGDXgpfbl/aX9y0dZbkooGiVFXqwh02FCqleMOyFkPJpUJdFaR?=
 =?us-ascii?Q?hjN6SSqvVy74tN2KWsT9T3rf4rtec5iqiNwTCX7h4MQislDg9CLHcUYC2PJf?=
 =?us-ascii?Q?0mEmCZfYoYQaSqIKcCHFbbeu/jaoabGOJmatUqVpxo+kPvxhb3iXxrkbZH7m?=
 =?us-ascii?Q?pzpWP/ahNVka9ye24/FvAl5xVUANIj59NBKSGF/FeAb7/LRixBdSkmM8KEy8?=
 =?us-ascii?Q?bfsIy+UVQGxzx2bQ1dmMfFCJSiL+pRBW+SSZaBVwmhUINpjVQQ3aCxqse/+d?=
 =?us-ascii?Q?dFileiwUPXTToBtf7UGvH+/xYdJuzFCmU98bKQAp7X0ohcn2eC4OCDoQnFAK?=
 =?us-ascii?Q?/e23BC+gzwlvl6Q3lOCIo3aPXEzer0YjMj51hiWldqjolIXa66ORMS+OeLvk?=
 =?us-ascii?Q?NTpJss8Skonw1Zq0rKw4LojyRVBbIQjY4R2so+mBYGkdJErf+wX+w0q2h9Pg?=
 =?us-ascii?Q?20Y2KxxED5jt9S+e72cYPObHKaZTq4Fpg6qzYhF4+6oyIsBg1XMEqNMqZ1uL?=
 =?us-ascii?Q?zdQREYthFIgLpn6hrGNHzq4POhcY3s2oYLrLeiGbYJYJTdwTJqkipTCxr3M/?=
 =?us-ascii?Q?7CdAMQnJBCS7DzInwcrb58WQbHBDQppOP4MVxFuL69QQ7lCOFSzEjFoTGj5P?=
 =?us-ascii?Q?Qhg518wTw08jE7NwFs3ZFAGBudkAa9ch2wwqrNMuJZvJUzBCM6I11sbMYfZ/?=
 =?us-ascii?Q?aV9e8tiJWgCPB+HKlBgKE5rIXqEoKBTLGL3hLz7GJ2vO/651f2FnyqJNumGw?=
 =?us-ascii?Q?+CXXosyOBYAfFkXPreuf05CDYlKHK/7T+mMcBAuarmwnXIPe+DY8wOnoITJh?=
 =?us-ascii?Q?YaeUNn67agNEgovCABNJ1in8YsR5auSuMX33EzL4rECE2Y10XiI7mKS1ZLTF?=
 =?us-ascii?Q?bcu6+38R3WtqF3RimPdnM73HfNIgftkjFcNjD9L+dYhpuH0GdNMtrBj3IZAK?=
 =?us-ascii?Q?3BQPjwReMifGUtEskKrzEKa9xDmQK5DtXz/WAZpKwbCJUt3Xi0367QUOHDhO?=
 =?us-ascii?Q?k9qPeMJt1YveffemnVomYa0dNVn2k+aVOWN1b3IbNCHGysR2tMcBKQOoqvEq?=
 =?us-ascii?Q?DX7rx8FG9UlruEdjUIlQlMpB07l+Pg7QwhfWe42CwonkECGSh9SRfPnyjjEJ?=
 =?us-ascii?Q?f3kXziT31XuL2FgsXAV/qgoO3hqXtaG/TiSL5hw7MxR9ixa/c8t8K87zDtm3?=
 =?us-ascii?Q?KCLfhH7O2N3svmRGN6XEgcjp1j1dOFLVSSdI4VnYBo2fa3LOvx+kyukRMBR6?=
 =?us-ascii?Q?Jss5Z5q1WypMcj0TBvY3suhR775oLDmSNBqR/PTMMK+CU7jfg4QyunjvL+aD?=
 =?us-ascii?Q?c9MenEC3CA4u6Cshh1Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 07:58:25.0578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fb2fd3-71b5-48e2-f8b7-08de28d3bf9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Honglei1.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

Fix error handling logic in virgl_cmd_resource_create_blob and improve
consistency across the codebase.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error, but the original code was inconsistently checking for error
conditions using different patterns.

Change all virtio_gpu_create_mapping_iov() error checks to use consistent
'ret < 0' or 'ret >= 0' patterns, following the preferred QEMU coding
convention for functions that return 0 on success and negative on error.
This makes the return value convention immediately clear to code readers
without needing to look up the function definition.

Updated locations:
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
- hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
- hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_attach_backing()
- hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_resource_create_blob()

Changes since v3:
- Extended consistency improvements to virtio-gpu-rutabaga.c
- Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
  CHECK(result >= 0) in rutabaga functions for consistency
- Now covers all virtio-gpu files that use virtio_gpu_create_mapping_iov()

Changes since v2:
- Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
  feedback on preferred QEMU coding style for error checking functions
  that return 0 on success and negative on error
- Updated all similar usages across virtio-gpu files for consistency
- Expanded scope from single function fix to codebase-wide style consistency

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 ++--
 hw/display/virtio-gpu-virgl.c    | 4 ++--
 hw/display/virtio-gpu.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index ed5ae52acb..ea2928b706 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
 
     ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                         cmd, NULL, &res->iov, &res->iov_cnt);
-    CHECK(!ret, cmd);
+    CHECK(ret >= 0, cmd);
 
     vecs.iovecs = res->iov;
     vecs.num_iovecs = res->iov_cnt;
@@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
         result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
                                                sizeof(cblob), cmd, &res->addrs,
                                                &res->iov, &res->iov_cnt);
-        CHECK(!result, cmd);
+        CHECK(result >= 0, cmd);
     }
 
     rc_blob.blob_id = cblob.blob_id;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91..6ebd9293e5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                         cmd, NULL, &res_iovs, &res_niov);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
@@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
+        if (ret < 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0e..1038c6a49f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                         cmd, &res->addrs, &res->iov,
                                         &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         g_free(res);
         return;
@@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
                                         &res->addrs, &res->iov, &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
-- 
2.34.1


