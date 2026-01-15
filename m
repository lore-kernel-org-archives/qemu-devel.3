Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67489D33A00
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIiF-0006C5-Mv; Thu, 15 Jan 2026 03:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgIiD-0006Ba-3H
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:28:13 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgIiB-0001Yp-8X
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:28:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUn5A4AE1Kcu5gvX26h2B5iEDpdurpMNIPZcvmHfvge+XbU5CA6KnY2iDapIZY9S545g8IxDW/L8MhNpNGldLyI+x/yx3rNPqCtcrHVDjtSAWovi62CF4uqfiR41sTmrMc9YHIn6tjpqnKyGe0C28KYWfzYHPVnAhDLO+QhVz7twvoqfzvvIQFdMRMmXfZdldD4o1WleEEKxn4jAMZ1Xevl/mJlF/jZoe3lbBYhx1tuqdql22I6LkwRdX4JNnm0MfvcxMevwYawIzT3MoZmrac6pjjphc9W4ZgyfNrCw/6UX4O6Bkvpc1mabXP5b9/BYJMOJc3zwWro4//hYp5sLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNOgWtPx2bJ7OlOPzP/bnM6XqKyAdKXeNppIo33ygx0=;
 b=Z3jjBRdRaXWzubJbZIMN7QADW/hQQJRzoIEyJoXpMGzjyA3E9JikhPeYsuh78hY/6HfmvR5e7KCz+RyTGafT2Npk/SHWZXdxroJTgeFZqb4F0ekQTqFB20aIUAJqJfo08FPSx/JgL2v08dUvkcmXR1Mj36Hb63HmcyB8EUx0xrHRJUMpga16gi8aU/Bjgaa7IiWCmz72B5apjGB6CewY9XQI3egOmKftc+RMXI8z6Y0opy8YziWMpyznzWKW1U6FI1TopLos0c5mA2QXjKfahPxbb9f5DDsU3WnjTrLsfcg39dovs0Gx3Xj3p5K2bzPKDeO9+2GJ/R3uIdnjoVTbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNOgWtPx2bJ7OlOPzP/bnM6XqKyAdKXeNppIo33ygx0=;
 b=cXmQ1FhbRcpb3cL2N/UDrTiG8ARUmowj1r94FDU/6wYrkrBbw6srHOV4orAmfBfC2D5/cjN+TIN0qEfkiJCLWSWqnCF9PNvQhoF0XTqVVTmvMG9ItnePxTO0kBTVzBZ/pH4bm8qT1ufLbQp2jG0nMtAbzN65lLOuCJq2UBduH2E=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:28:05 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::7d) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Thu,
 15 Jan 2026 08:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 08:28:05 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 02:28:02 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v5 4/4] virtio-gpu: Add ROCm capability support
Date: Thu, 15 Jan 2026 16:27:39 +0800
Message-ID: <20260115082739.174224-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115082739.174224-1-honghuan@amd.com>
References: <20260115082739.174224-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 76082bfc-521c-4831-80a1-08de54100189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LH3Zx20rhwg0sUnFQltKp0HqCREKQM8ttROQAqR0svInT5EPlloX9vcsJuH6?=
 =?us-ascii?Q?H+73iC4M7wxoSVe0XywfdItpqnx5kAEfTSjbvb92wwldmk/Dn35aqiGimO4J?=
 =?us-ascii?Q?GaWkeiQiNXP2RmG68z4N6ee0HBRPuQ+oSNDhgWQSVfTpKtK4Z3XQeW+kDuMX?=
 =?us-ascii?Q?f1B+78SH4152uoAgQ7YOLEnUCftB80oB8AmY4HqNEVKkosUMhGD/OPu4yjck?=
 =?us-ascii?Q?I536qbkTBN6B6gZI2edNhVd5NOSXQy62CNr+wsdcdVzz/C2QaGPo5uDUzDzn?=
 =?us-ascii?Q?P6jY9g6iWHt7ED2iOCeQw3eLyp3zT94CPDMtGSF0RhQYxXaBljW5sMvAKS2I?=
 =?us-ascii?Q?IIhsNdzsBQ/XMWGHp5ob+7fuk6PUwzVtH2Gbwhtg+zCHy4jD4730koDlslrA?=
 =?us-ascii?Q?CnV47J19W3cBEJDo99+CLsRZgWFGt8GQOBbJjVKIw2P9W2f8sofV8jZDrzNc?=
 =?us-ascii?Q?G6ElxPI/SmmFozgunsJ1VVqSlkIqcm+NNqzG7ahpMjHdaaGRQmJaftvbXx5U?=
 =?us-ascii?Q?crLsYPlN3jIgrRUF559qGpiNpbUnOFKonvhLvkzkbjsbffh6C9UY8iFQ7Hpa?=
 =?us-ascii?Q?Dqxr10WW/ZmYMZqoA0WLOwUUSVXj3H3551IeF4dGV8ypp+sXYKbAak9ba0vk?=
 =?us-ascii?Q?CWbGXUZki2agt1aFXUL8qybrRz2325rgyvboYIBWgSZgjeM4Wb9QfkeorcxC?=
 =?us-ascii?Q?z7HrqyGHSCwO/h+37koEeHV/8x6k6jBA47l6hEbEp7WmBFkUQy8AJMPUBFQ8?=
 =?us-ascii?Q?rBFswpdnPMd1F2OsiY8Q3w2K6NpAitqwP8FGW5zkfS370eYc6agThExGyz/2?=
 =?us-ascii?Q?tiMxHDPD2E315XyZUo2mRAs7qKbojPSZNmkNc4gnk+gOhMqyU9S+tjh31Ji0?=
 =?us-ascii?Q?qLV3t2dr47qwVS1kQTY1PMDdWV61GcgXspOtOaUawO1KS5/7weoThZqSjxv4?=
 =?us-ascii?Q?D7M/MeqW8bgGql8CTTOyfdgVRMrWjwQ183mckPCgHz+6GiFTOGTeGdhR+UJU?=
 =?us-ascii?Q?wsTMVlckGfuGa5y5HNLVKMd5h7x7pHQO8rASuV8WAN0QX2tqtL37necheINd?=
 =?us-ascii?Q?yoNJlrfN11/IwFKGaf89N3hE9tpA5aidKeLV/aP0v5vnErjUePQsHc2OYYKd?=
 =?us-ascii?Q?A+SrHa19ppp6JSdGV8OcBtnpJVwXJkQ/74+UHt6sIaYkBZk7XtsLkUXfamo8?=
 =?us-ascii?Q?+lnXP5/qGJk9gPJk/G0+lO1L085mzun2UwdsV5mjpktwmVoJDknCUogT0MgM?=
 =?us-ascii?Q?8asvy6L9f2vp4lpCcAAnqdyx3ZNKmRmVfoEFF1k51LMYgkwXDkMU61C72SvM?=
 =?us-ascii?Q?nwZi7R3gwqmGWP4+7WySJ3AY5JMKmBybjvPxA20L/70obY8M9IVYKv8qzjMM?=
 =?us-ascii?Q?kjq4RXq8xeNLtTr8vbgEjWy5tJcqIz8Hqh3L3vEntIXOa/HJKphAg6Csqt9H?=
 =?us-ascii?Q?5aUc5ffjPtyHjcWDfDItEhFoD5NgMzBm6bdNPehh0N3BFXtdgrYwlPTjbLNQ?=
 =?us-ascii?Q?m2YNurxU1jFvX9cQ6P8/s9KwbSCCZTV0iAsWADI5ie9RY7a4auxchn4RR4hj?=
 =?us-ascii?Q?oc7T69/gZjOSC9uncYgR+UMbv3WSpptX+DavltxxKBt/8cFGGFUNhzzs6+O8?=
 =?us-ascii?Q?v+awr6CFcR/sxBpPolR2J7J2VNJZDi9oUR/nXb0OVjwVEAZIoJ7Dvsuz5j6r?=
 =?us-ascii?Q?Rdv2fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:28:05.4755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76082bfc-521c-4831-80a1-08de54100189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

Add support for ROCm (Radeon Open Compute) capability in virtio-gpu.
This enables GPU compute workloads using AMD's ROCm platform through
the virtio-gpu interface.

Changes include:
- Add "rocm" property to virtio-gpu-gl device
- Define VIRTIO_GPU_FLAG_ROCM_ENABLED flag
- Enable VIRGL_RENDERER_USE_ROCM flag when ROCm is enabled
- Add virtio_gpu_rocm_enabled() helper macro

This allows guests to detect and utilize ROCm capabilities through
the virtio-gpu device when the feature is enabled.

Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-gl.c     |  2 ++
 hw/display/virtio-gpu-virgl.c  | 12 ++++++++++++
 include/hw/virtio/virtio-gpu.h |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b98ef2ef98..f059bcb177 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("rocm", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_ROCM_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index cbfb8aca3f..5e0f465c37 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1160,6 +1160,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
     }
+    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
+        flags |= (VIRGL_RENDERER_USE_ROCM);
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1218,5 +1221,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
         }
     }
 
+    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_ROCM,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_ROCM);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda..9923970ece 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
+    VIRTIO_GPU_FLAG_ROCM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -122,6 +123,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_rocm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_ROCM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.34.1


