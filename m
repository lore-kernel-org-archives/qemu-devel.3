Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA419CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNCT-0005SJ-LT; Sun, 23 Nov 2025 22:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNNCD-0005Mw-Jf
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:24:59 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNNCB-0004eL-DN
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:24:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmdRRK9R8guobiVVn/HJr/oiqqdT+KAgaU/3EIAuxHdyjFeEl22THdbBt7pw+iYvT5Z/Iavb3wQ3/QSD9QL42LDstH6GlDqHngRTDMvqCIdciBSxdWz+9Tl4CILj3wcKCqky+16sfjaGPhNmU4n3Eny6lHI50JbXIjBadHd11xfY710RmUk4jBUTg/ukL/7tLThpbFDEf1oZrzsL0/6LR6Of8c0V5QSki4D4tyFOEX2uTDbYPUFkNlioTPSN4hanfgFMMz5i8RorIz2nmiunDgk85Dw6r6NBD3GQisWfCZ53JQ4ZEceCxDeHKy4LiZqXbpSNnD2hNFarP11IDR/7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTNBSi5cU6xrUe7PU03n1OXePNw5YWxYRXV7IJrYsKU=;
 b=QQ9My4b2W0dTRNgjcJydwD2pNO76+rg3xw3+ufve4PsxOWnGSYjMGNWiOtQ8aUVL5DDldQrDdfkFTFNtAEH16SrPtqYGixmnpUz3iby/WLe/qeHFuxPNkDRaooVgmdmiCHlQ1MR2vlrd9bdWZrLdITGkVRwDrWAyX0uwEnpz6ypczo+LP+2R0Krjnn75NN5guZN79ducJGNaVfP8q0G5dIWI5DeThNXqkT0fPvwLROKkVqQD/6utiH8cCb8O7/wiAldTj0ubgNv85dhngkas5ljX+i3z6Cs8qYR4AFxuGjoK53daP5+8OLHkeP/qoashu7VhmZkukIUECBKJogQrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTNBSi5cU6xrUe7PU03n1OXePNw5YWxYRXV7IJrYsKU=;
 b=Cpn3DsOvQPLM4V8IghDgRZRIKUTCDASNCJPiipm6dGPdTN7w6XHMNT+RWeRI9ukvYSb+0UHjP1aYBiUv/0CJIoGWvcvDzV6s8gO7pHwQCBOSQr+Fvaii6i3Mv2qUcRIMP1PKJA6f2Uq0FAHRHBwsGwaSeQ5GurUrDQsjXLMy0MM=
Received: from BYAPR06CA0016.namprd06.prod.outlook.com (2603:10b6:a03:d4::29)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 03:24:50 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d7) by BYAPR06CA0016.outlook.office365.com
 (2603:10b6:a03:d4::29) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9388.0 via Frontend Transport; Mon, 24 Nov 2025 03:24:50 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 23 Nov
 2025 21:24:46 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v5 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
Date: Mon, 24 Nov 2025 11:24:23 +0800
Message-ID: <20251124032423.227712-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d0dd1e-f665-4187-2408-08de2b0906d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vdji0XU2AuzDjFdr3QNX93SVTmXY1Vb70QZc4ZLIoSj2v+8L/PO21vf/xLrI?=
 =?us-ascii?Q?//fb+vjpiJO8EazdxigSo402JPGrfjWjNXm3Eo7H5jPfDHjpqFr4iIVNrqrS?=
 =?us-ascii?Q?GBMdyjs8nHnpzt6TCNdTJI21fdt2gFfeBwAalVjeM/ogfaAdMJwkOwXtewUT?=
 =?us-ascii?Q?CP57dXT9U6UzKJByQ6yqBS3QBVBR08TYDDglFwytwMrc7eZrzryXMIqkbIne?=
 =?us-ascii?Q?UQ77kerSZVzrcGpn6tiYuXRF9lESaaqduPDVgBIlj7yvsB9HnjnTLMH3sOpN?=
 =?us-ascii?Q?AYjQCFphsEwWlr1b4FB7O1jE656nLIKJVY5oLzx82DnxGCPVgUcXFDw9Echw?=
 =?us-ascii?Q?qssh0F4Idl0dDT8mcETwYJ7g5Kq+S0Urst8aso2JE9UBQib3/PMi1Ez1uhJX?=
 =?us-ascii?Q?Avi6o1VP/U7vC/mhhaB/MyZuXLQ6TDUutLIkZj5zZPlOEyIyIC5Sd3SAp8qp?=
 =?us-ascii?Q?UsmgYaL813uRcA5HzUn8j3iRtyIayqpeijjcsiQhIp4AHJ+LAQ51XWmKjERn?=
 =?us-ascii?Q?qBvo9XL54VlmRFHE+pPjurcwfj87j1sC9eJ9fL2I+lRlU71BYxiTNCtFpB6l?=
 =?us-ascii?Q?erBwOlybuTf80q+cfs4D0zkhxzR1/doObgOShB/woE5oLKdeD2z72sLGucW1?=
 =?us-ascii?Q?KggRFwkNxMfBnZPMTuTISfZ8qFJsAOtUp5m7RHCbUih0IcykO71OVChiP81J?=
 =?us-ascii?Q?3EvXRAJkbMo7zRLRw24eYJLTTA7p2XzRCEdHTWAoJn6CXpJAw1E8XvCxz7ER?=
 =?us-ascii?Q?OM3VJtqiN7H8J24/bYbNK1GeH+4hu6ME1oNa1lCaYZ6s+N5Ss6F/b9DVBERS?=
 =?us-ascii?Q?VArSppDNNBVzfSXPcMlOT+mq/AwfbF29aZePHJuRkmwPYmwoF4anR/QBYuC/?=
 =?us-ascii?Q?yHcXMpCo4S2six9RMWiVYf6PJrPH1QkRGGCMq4oJN1CgSE7dxV0HW4i6DP2e?=
 =?us-ascii?Q?OoI5wzMs+LZ3gIMCqsG0u4Jz9xYMFvlG2m4Xf+B78rV1fU8byDg4GLos9Jat?=
 =?us-ascii?Q?MqPXCKDBnlnTK4e95kZ4OryM6Bxttug2jfyaEUwstNlv8f6/eWrKWkT3Aj+x?=
 =?us-ascii?Q?SGzbfIYGw/ptC2O/oDh4YzTj1ziSsZsUU7/mRUKekiXwxXiJi4HqnFJ1Gsvp?=
 =?us-ascii?Q?2neH6IQNu9pPOazFlKawEKUxmd7L5pDPre0ZpsRu4Y+VRAP1/GYMcprdBRwC?=
 =?us-ascii?Q?lWGZEGIhYvZ1lO87bDK9mM+HV/hLEvlzK93Wa27JYOByPoVObSI8u8Udk0M0?=
 =?us-ascii?Q?xAaFBPTPWZQg9FHFe825976aizq0nk/hguZpw+WC7ojm0nU3rDpwGtAnZiHh?=
 =?us-ascii?Q?+HxIyaRC4pq+YSDs+oXlT4PA3MDvm42xzUVbRMF1Tb1hdQen1ZCdBmgkKmjV?=
 =?us-ascii?Q?vGwYHcWmC5pFSZiDJxlNXmVxyf/xHM7XP4wfbG9fdRq0W26JrKIr5TT+itCH?=
 =?us-ascii?Q?lO5AjzV+4P2Tt/K+H/Mr0KfVgPWyNRGJU1LBv3kO/4tkVPf5bJSdxSICwT/Q?=
 =?us-ascii?Q?xeEQ9Wz+r9JXrYKjEHhzHo2nlXwUib9eSHInSCwg9c4WLxBB/oxcJCkg8JXB?=
 =?us-ascii?Q?N/eVuO9N+bKFQJo2G4I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 03:24:50.1186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d0dd1e-f665-4187-2408-08de2b0906d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Unify error checking style for virtio_gpu_create_mapping_iov() across the
codebase to improve consistency and readability.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The original code used inconsistent patterns for checking errors:
- Some used 'if (ret != 0)'
- Some used 'CHECK(!ret, cmd)'
- Some used 'CHECK(!result, cmd)'

Change all checks to use the consistent 'if (ret < 0)' or 'CHECK(ret >= 0)'
patterns, following the preferred QEMU coding convention for functions that
return 0 on success and negative on error. This makes the return value
convention immediately clear to code readers without needing to look up
the function definition.

Updated locations:
- hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
- hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
- hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_attach_backing()
- hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_resource_create_blob()

Signed-off-by: Honglei Huang <honghuan@amd.com>
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
index e60e1059df..6ebd9293e5 100644
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
-        if (ret != 0) {
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


