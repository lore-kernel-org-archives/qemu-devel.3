Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05BCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwpc-0005bz-1c; Mon, 17 Nov 2025 05:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKwpW-0005aH-Om
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:51:31 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKwpR-0000Ck-Qm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:51:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP6XM+N/zPu9LdCnz08le6OwlkH4QTMcoFFb1P+FifE2Ke9B8Rv2spleLp+dIha4FaGoGZA+u7VS4OsUXZWPYG9prJizK5RmLUmc4EaEbbVTCN8J2Z6mOy9MK1sZrMOJCJA02uk0IJPFCzwK5xmK63fe/UTpAgJlkrTVQCpgvYdZgP9P6cw3aJZKLpLny8v0Ycw8BBu73h8Q6zN9iHpUWldUOaP+vp3XtEV/Gjxd2cLaTYzYacpSOHStfV77c+45QDFidTwOoCzTRkPPplva1w/gKL4cdXIutANXpZJljKenUJOOPsVXny7/5WdoqzBBbC69xzEWbHks2GjPn5SRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+VFIRbitYCM7R2oNIlE+f4qAWS4JvdNKAwVbFcQjsY=;
 b=KAVfJucZXCkyVwpjKep43Rbpp9YwFV/5cwQAs7p/qanCQkkWDUgLqlGMGhm5kgpXH+cEc+6wwYhDuziX+fHBEWjLUdlqLeNttWLiug/A+GSsbsrTcWcYl9xcM33/ePMOVxl7YAjVPX/V7wtbLMW7KW0sEf5iPCdYcR+s/hMSAVaLpx6ywZYApTsJMEzNZ5sODlvXrvxe0O+P4jExinVNGNvftzIuZLfAVBy26m432R7ggz2KA6vhYEUHhuYryCkYuzt0O4HzxOxIsZRLs4Et57sudfi0XvoByorXWnCH9nawku8Bs1Tjs39cA5WB6aHQ6sixZ1dNcITemS/vftpgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+VFIRbitYCM7R2oNIlE+f4qAWS4JvdNKAwVbFcQjsY=;
 b=j3LwT887N82L+5jlL9QhAb6VWl1aly2Y3YZWS/LJil0qW0HVKU48rpruXMATQSZWlcirVe6bmOSwlqfY2IwgxYEFz/oJnA9p+DLq62ozVrFpQGXLIlAU7MueoOuDfaKAl+5kjCENYse2Sb0udYs6MLbyTyJqhoo+SyWobswla3A=
Received: from DS2PEPF0000455E.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50b) by DS0PR12MB6533.namprd12.prod.outlook.com
 (2603:10b6:8:c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 10:51:19 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:2c:400:0:1002:0:a) by DS2PEPF0000455E.outlook.office365.com
 (2603:10b6:f:fc00::50b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.2 via Frontend Transport; Mon,
 17 Nov 2025 10:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 10:51:19 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 02:51:16 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
Date: Mon, 17 Nov 2025 18:51:04 +0800
Message-ID: <20251117105104.258513-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3306bc7c-a379-4871-5624-08de25c73db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDhrHQU/GcDt6xBd0AAdTL4VI7kQlpH5jHpQ/6S9iEBx1JMR74E2aAdTuApA?=
 =?us-ascii?Q?qmHPYtFjSIk/w1PsF8gX/jJ4LPboaWTlboEfcrvhOhlgnjQWNvn5wa8/Kl0u?=
 =?us-ascii?Q?fVpR8wMHnxKtGYd4PhMIzICpNQD5t7GhZJb/qKotGGzxCaVh2remQCaKuxU3?=
 =?us-ascii?Q?ZvEPuDe7wBDod3guigDZPAidQ9o0n4BjA5MCPAlaDOuDe1aIBpxRFxHyhtA6?=
 =?us-ascii?Q?jR6OoDAldkXBasKgo7DmzU6Z+wBCwi5BCTEVZbNXbvNnMLFQtJU8qrN0Er1G?=
 =?us-ascii?Q?4SzM5lF8Wkn4UaZurlOMXPzCMSUuhuJVdKrV/+S4dKjFeZF/2NSb/AuiIFeP?=
 =?us-ascii?Q?jiI74ArAi0GbpvABhcvnFlRxd2F2uHDziZXJ2Lw6jFYOXuXs3/t5in9oABji?=
 =?us-ascii?Q?YM5B87FEO+er0wT9ViKPm4x9KLrgPoSmIFsv3l6rok0rZG+Qysx5gPR1tJtg?=
 =?us-ascii?Q?5rm7lqn2gAzeXOPTQP+GMJqnR8gDqZbUfVo5QMQ+WmE60lZUI6y8jYnuKu8s?=
 =?us-ascii?Q?qraTCueEmGimEADsgBEPWATbor8nnUfcnwqCD2b37vdQ+GpKqFsxxvch/Kep?=
 =?us-ascii?Q?Yi995gJ/SUw97zziCSUO/zC6BufWOkyyBTNYAUdqd7LeZdQu642NgcxCco2o?=
 =?us-ascii?Q?TZwgejGdlNvqwrH96iMEAEHHSyXJ7MmyvE50uNyybiIW5LVS+KySCtOXKety?=
 =?us-ascii?Q?qjJog4aTHtUFzuDZdO5pJLikNUcFcEdEoA4L/fLLlBzqFTQ3Xqy9ZUgfe4AO?=
 =?us-ascii?Q?5DjYfVCfAxeIvJM6SybOQV75jb4nJRMm6HdI5ln2Dpflet34eEMB+4IEyRCc?=
 =?us-ascii?Q?7n4c872eMK9OCBeSZoMOcA1xnKnhAO+4BWba58BA4uSqJ+Rrqdojyg3KIXdS?=
 =?us-ascii?Q?yADYplUUzgqP4/ZL+URR9gPOQ7EvPGSFQW5Ft3Mfc9ehfQrahdxfX6Dbm1jr?=
 =?us-ascii?Q?9CxrSVrDUFB+P9W831A3tbyyKuDCxf3O0eWLeCn5gElXSjR8fNF7rSEfikPx?=
 =?us-ascii?Q?z0vLGxLDKlpTJcGay0/cI10YcbmJiiJ3gRDVqozgOeT8h/pqZWpqIp74MDPB?=
 =?us-ascii?Q?Rvhfh6uzn+2wNiwk8YtKF+wFvoCFgz99XJvKh5dU09i6A4NHTnHTVZYVPLfH?=
 =?us-ascii?Q?8I34m/63U/E8CVMi23yAHZ0D6oyH9S1Jx+bhqn7DAMEmil4GRIhXHCjbHQoT?=
 =?us-ascii?Q?6hF8d+RntBSqusg7xB0cc+PWlIrVRa/FdNi99C8qy6uxsGOznROLzi81lhcQ?=
 =?us-ascii?Q?vANigMWdvD66TmNx09fBKIt99evdlLB3iapjJtZeli2hYjHZyLY/hLchQiWG?=
 =?us-ascii?Q?25+XjI36j4cNRji1phEYSx8BEeKcMtLjflUU+dfyRiRBPnjrbCVf+yPiNPZc?=
 =?us-ascii?Q?GEQPhtWYQ7iOHUr7tvaTUMp5DmEwI4+lguf9p5zYYIixeYYOLGeg1y2VYunq?=
 =?us-ascii?Q?chkFLSxfcAEvdnNFqPGWfq9sdrxic6tT8ges3betgfxweVYypVCn1dlVbuJj?=
 =?us-ascii?Q?ISwGp8JRWDNNpre03l1lUd9x1ztUTnsR/bjM1lciOaeHT79PxyhztD6PPFkY?=
 =?us-ascii?Q?Y3H9VziKYjqA2CC5IAs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:51:19.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3306bc7c-a379-4871-5624-08de25c73db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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


