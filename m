Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F3DCF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOKY-0005V3-PC; Wed, 07 Jan 2026 02:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJs-0004zw-2S
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:51:06 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJo-0003H0-RM
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOSwBRjjEdphjLvVQ0/L6NBUFUjLdT7AYw48eTnu22h613a/L894DbF/xw+jRhk9GjgEqZMrRrjLlTisdD1o7kxJUO+bKvmi1J9ARi63CyfHd7BCIc/ucXu1znJ/+J/23x+Uw8Z94XNCawyy22dBp1mpyqJZhkuKaJojETvPwxEu3/gJ7POSRzqxFVKU319oZB0ATJQSkkaMV5d8phB1XcFDfruEOkOOaNs7qjU+f8nc2sKmrlmI/u3bCictPzIUPnn7v27EgTDI9Zi1OWZDuRIBJLF5yfE5LMttv9X+/3Ge5j3tJvVbXw5MJUgGuRddTlbXU7vOcTsOW5KqqhPT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL+9hQ1YtLCnwqLxdY1uD5hH3KiM21IlCuL6THFcnHk=;
 b=ywK/lZ74fbAXs2ZJqKDw0Caj3/EHaEch866ixbHvWzcudq/YbheRNVwNY07DjiFJYbmYYaHbiwSBfxKhMZBXWnT1DqLFZrpuil8FcHyPwukfgm6c5ddj8LWYbAUTY2/FlplbcM6wpL2RqIsqBmXEU0wUw18/vhrHpmrrlPXraonOIZAxBtu6pNtuAHKNiOdPHyfuufiMCU/IlfWqp1qf26hyNC/v06UvMF51GsYMTmqclBQkdT69rorzSdF4anIM508FRr3s8fF2SyLtF+3HgCLDBYef57zl08g9136EcT+ZTnTEOIFkZdpHJwZn2Phf73MnWeBQRW1T6nqHRfDbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL+9hQ1YtLCnwqLxdY1uD5hH3KiM21IlCuL6THFcnHk=;
 b=4xafGP/8WQ5sDJSkDqkuQ8NB8aJVc0UarlfShuS9HjbEYIlFmwfB5DnUS8FQ/QQf60THUnDtxkZiVH3E7xA62SKTEvjqNnAGCmgSSBRV284Gkbjlq87mkuWygbIbxO08z7sH/JYu4ZkIDKEv1dCuSgQGRKFd01Rr2NgW/DtLEnY=
Received: from BY3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:254::30)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 07:50:53 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::1c) by BY3PR05CA0025.outlook.office365.com
 (2603:10b6:a03:254::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 07:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 07:50:53 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:50:48 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH RFC v4 2/3] virtio-gpu: Add VIRTIO_GPU_F_RESOURCE_USERPTR
 feature support
Date: Wed, 7 Jan 2026 15:50:29 +0800
Message-ID: <20260107075030.3453924-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107075030.3453924-1-honghuan@amd.com>
References: <20260107075030.3453924-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: c324b8a7-b9c4-4d87-4b44-08de4dc17bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kgfdzB5Z9Th+gnmRmuK1VUWwn7NipCM6uRtkjbS+hywg7Z0oK/cNTj69ip2N?=
 =?us-ascii?Q?HQ5HrHpL7mF6ACI91i/48HXAgj1aNZwPuGT+EIWWEU8qlWV0H5zG9VTsGVHY?=
 =?us-ascii?Q?vohDghYKMCMWPkWAAF1XapRdhnncPkP69+ZybgI32dCqxGPcfNwbJSYHzCqd?=
 =?us-ascii?Q?+loQK4MDBeESU8c7XTMYZwnNZ+Z8a1x3wCBz9laz63zZFE7lMy+YUjBmmFOr?=
 =?us-ascii?Q?QXk1FqqPg3+47kR9b3IeLD2yK81XvPe39pkEINROq7dwCeuQCeJxy+m6tJFg?=
 =?us-ascii?Q?MLPHy863s7K9tOSgGRjBvfOqh+L/pmXngTsavtoVVljSYnUznoRU23nQrm2O?=
 =?us-ascii?Q?8WysvByE6cUXjsUqagO9/elPm09uhe6ffOm0p/il+eX0okgfWzQ1330Pd0Fd?=
 =?us-ascii?Q?z7xAafv+kftejBX7U1ZuZL9NpxTm2RyJA5UzG5On5GGbC4IsL3fhPcxAIMpC?=
 =?us-ascii?Q?BHUTXsqYP+sXgb9N/NSkAecYXLqqr0d5qyKjevwtF9n7Aqjx8L4i+73wioyV?=
 =?us-ascii?Q?C/9r3qaspDSbQSDaDoW0hHD1oPKr/MjwPXUBCEm3835pJsAj36NJwbIfHs4l?=
 =?us-ascii?Q?v/HVWrc7IEAJ+CfENZsQIApZCpI7S8WnS2CuJ2+d0GdWVC680BYCzSP6sMND?=
 =?us-ascii?Q?W+XEU//ytoSYFKfLzWWKAepT41BCRrbaGdPiP6gjprhLnxLivNoiAMwfxY/g?=
 =?us-ascii?Q?1CZHHZvwUetcQBnj+jgJTFF0rlocfdcNRIsg9eGR1NVyNaixQ/1/E9n0T+j5?=
 =?us-ascii?Q?yED/pcKLmIEVWQ4g2aVToe6rYob9xONQTxSRdCUK1JwZJJI35nGahk5DErEG?=
 =?us-ascii?Q?6WxDaoFkCfL0i4lRPTokYr/pnWMRNum7eGmOqf7Bg8zywb6+FtKDZcEeX6GE?=
 =?us-ascii?Q?PXP+pyNLy3RuF/B0rTgfyiQbodvYvg2bDPw6RLyesYC+xnirsEz9ix6s68ML?=
 =?us-ascii?Q?5yyBk1/ccdLLG0o+N4n2KlPkcAdvBl95kh2i/xfE2VzSs79988pmKla2gHaX?=
 =?us-ascii?Q?yKAoztIgvEJSc+hfGx1IeahMYASodt0LhD2rJ63eT3vZkDz/S2QcFfipKbbY?=
 =?us-ascii?Q?m61KcfnVl4dECiYIK7ZynBI+jVw3ZHKcgPVH9aO7He5+i7kTF5MtUmS3jUXU?=
 =?us-ascii?Q?Vd1+oyaZk2B8XN0+f9ykElaFw6OkQSda+UjG4hi92tp1Gpkg8IRxRgLd1XoF?=
 =?us-ascii?Q?LTjH9e2ArDu8UCfD+qh9R++WTnsCqyDPsWWYkiC1xwjl7d+CmvartsdDAfC5?=
 =?us-ascii?Q?D1+dwSwaSGQCjpmU6OzMkMFRN/FTccsKQkx8Z+BSVS7BW23lh/7d5YsIGnFg?=
 =?us-ascii?Q?AwRtlwWjx39WhrOaxr1+z/NFx0vLExSZ91GLNowuyxlZ00eresrHW5FSZuup?=
 =?us-ascii?Q?RKX1ym9KIcv6z9heClw2NDBAiTiokO2WO1YCPWfZPc5OL8wGf7B67FL7w1ND?=
 =?us-ascii?Q?NyfdFmw7EdX+rcGG3S47tOsRWqCQj4PiycgDnaID4UTEWgU7JWdkmqKuUHed?=
 =?us-ascii?Q?67TLH3OyzlIq+1r/nN2PcPeixoPjim40ZL+fBjXyfogfzzK/xJXTcuSkopU2?=
 =?us-ascii?Q?L9AFZorKA04gh7160wo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:50:53.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c324b8a7-b9c4-4d87-4b44-08de4dc17bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This patch introduces support for the VIRTIO_GPU_F_RESOURCE_USERPTR feature
in virtio-gpu implementation:

- Add VIRTIO_GPU_F_RESOURCE_USERPTR feature flag definition
- Implement resource_userptr property as a configurable option
- Add VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED configuration flag
- Enable feature negotiation when resource_userptr is enabled

Usage:
  -device virtio-gpu-gl,userptr=on

This feature allows virtio-gpu to support user pointer resources,
enhancing memory management capabilities for GPU virtualization
scenarios.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-base.c                | 3 +++
 hw/display/virtio-gpu.c                     | 2 ++
 include/hw/virtio/virtio-gpu.h              | 3 +++
 include/standard-headers/linux/virtio_gpu.h | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..f013a4ece6 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -264,6 +264,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_resource_uuid_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
     }
+    if (virtio_gpu_resource_userptr_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_RESOURCE_USERPTR);
+    }
 
     return features;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 17df148920..0241b44cc8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1685,6 +1685,8 @@ static const Property virtio_gpu_properties[] = {
                      256 * MiB),
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
+    DEFINE_PROP_BIT("userptr", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
     DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
 };
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda..fe98ea0019 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
+    VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -122,6 +123,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_resource_userptr_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index b85e781a2d..fe36288fe5 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -65,6 +65,8 @@
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
 
+#define VIRTIO_GPU_F_RESOURCE_USERPTR    5
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
-- 
2.34.1


