Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47587CFA466
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 02:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMHBd-0003P2-L5; Thu, 20 Nov 2025 21:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHBY-0003O1-1T
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:47:44 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHBW-0006Io-7h
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:47:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBKMBpDRYjSD+g6ZExwJoR/l6Q8BPDCAnNB8NzNIeTz8eUf3yhKQj3n3i8gesjlgJvAqtPuc9T72zmWTdPH4oPFjMiX+Bo7AURR6DHVHOLGxrGp8WxXJYKAOBXVtLrWbcK0blpQufUpsE5yDeZH62zm+P3sZbP7baonkMngr9tdbMxPy5g23C04ISu3LmLUkZLk85KOnW9V9CnSaeY/4FZKTvOsdjICAMAkksKT1S/Q/MAKOV50JaC5K6Hw1/1Wi+qVg0Ihv54pyKHXzNHAXsKi8RtnJye0tafdLapR4FVtNoEMbVeLA2Fi1u2hHF69yz39hUjUJyPyU+y3NuZUdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFu4503ISJFeKGv67QIVk9I8pXGL+xv1E4okLu5nYIY=;
 b=Blqg45/Hi7slBlJFVV2AJS8EPSHxF60klN8m8j0QpaZSL8FNFQG29uhFoBKOPnuTOEL81f+AcULbTcGHByGKU7cgNpKACc9YTYV6xNGULOnLSKVbJDMzGEtR2Xou4XjMsmVhsxDOjDqJvjJ1xgHTMM4sOrbejkgXbUuqaiNbyc8bfulxV/zVnwKMzH8/vjXesH35PmjUsxHjR5Hip8p02NFD67m3efLs95/UG0bnCMn1fJgN5Bj/G7Uy25A4eZApB+1uKGKvaAmYcBvcemw3qRBxFuF+espckgyM81abFlOE9xzoXaJKBigmnN3u96laHwhmjdVasG5FMvGqnfWAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFu4503ISJFeKGv67QIVk9I8pXGL+xv1E4okLu5nYIY=;
 b=NGE1bhwppjpUkkmPuu/vt/pfqeJGy65cRtd+Gv1TjgBeK/ZPu6Tz62ZqOSEa7PrJv+VurFLolX51vSFAFyKrdfr94IM//get4GqEUkN01VKYW0L8cTqoXUEtyaTA+rNXgb+q75SA3OD+Tnw5OZFoQV4q8d0OdppBab2L5Ina+ME=
Received: from BL1PR13CA0394.namprd13.prod.outlook.com (2603:10b6:208:2c2::9)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:47:37 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::82) by BL1PR13CA0394.outlook.office365.com
 (2603:10b6:208:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 02:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 02:47:36 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 18:47:34 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v2 3/3] virtio-gpu: Add VIRTIO_GPU_F_RESOURCE_USERPTR feature support
Date: Fri, 21 Nov 2025 10:47:05 +0800
Message-ID: <20251121024705.1403042-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121024705.1403042-1-honghuan@amd.com>
References: <20251121024705.1403042-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe950dd-46d5-4bf7-5240-08de28a85475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWHCfng6jwckwWjUpr9dwvM4ktQ5m0TmldziXZEl/WFRjP9boKAmT7co4tvL?=
 =?us-ascii?Q?YsGg8AgqTCmbgywnaSs+QycucbfGS/HpHnubUQkBtkv+JakfZksxjrz0yyzZ?=
 =?us-ascii?Q?1rj/5mrJ+MJUlD9ctiB4OetC1TyAULlUIx4KIZ5FvPEfWn/kKcPrruzShvc1?=
 =?us-ascii?Q?/J+fUwaC9Yx5y4LkKK0KiMAMvKyHMx6m847TEUoSwGsxsEoZkdtixpfUDmrd?=
 =?us-ascii?Q?CfFLm3HnSxFXOZoPcK5PLlQUTsgxsOWjsIPB5dfa06UwByYbcvAv+BgswR8i?=
 =?us-ascii?Q?+KrIcBx0lkxJayLMTbcYtrZ8CyJhKw/FjAPVodS0rpev+MWrRdnqXdKOCQMh?=
 =?us-ascii?Q?BUhGiu6IdbjUlICEwfuJLuy2YVn9wnDRA/V6G6JAtU+t6RL0bp2nULZKQBnl?=
 =?us-ascii?Q?uakH6MLFlyA1UUIPViL+A1IgxI9v19Se73xNvOfzOe+IvBncEy9weIwFbIp+?=
 =?us-ascii?Q?gSNXHV+T4thncdBaHEH1NQQdydx2b1NisTBezLXrFV3kKZFfbrmcKaAc4TTd?=
 =?us-ascii?Q?Z1LeSkKIxXIuffTBOTLhs+Yk0CRhKHyB1STpgMOVPbxireVSvDEkJCOJ7/Ag?=
 =?us-ascii?Q?A3J+pqHYLklegwj/YUMXm3/swZELBg9LtOxwUyUcFyCblnhiJ+Qg+4A9hBN+?=
 =?us-ascii?Q?g9KljgUYq3kFu6uqu4YGlpM7BLZdptmNkk45eUMvRnUp8iedbCLSSjvV26C1?=
 =?us-ascii?Q?IWIDmDb3wOtACYQtUP/VsJYRAX1mY+4cEOyPhRew8smAtghMoCpG6OtphIWH?=
 =?us-ascii?Q?RAWZ08gEIaAGDetC5yGkdG1xsvOT06e38ehw7jml33JZ+vz4HK8jQ+Q3gz+p?=
 =?us-ascii?Q?06W/qwhUvaC+7BegNRV/VRqVBvgsOhWGkMRDCOXTNyeFBhX/iJqX2wcmqp4X?=
 =?us-ascii?Q?cMoPkmLkiKAYavFma3zGAJ649toEsBWp1xGTp5FBDNdA1Ui41ekZ4a+oCSWF?=
 =?us-ascii?Q?OxWnJSEvN1rHnqJZSelZwBDOeiKFKwdPh7kd949E5CKLypVbeYdvIiQNoMJj?=
 =?us-ascii?Q?pm+GWsxMs9/6ex7EzGgk7cfpYz3GyI/uZy/OV4ZQzUxmKOkZjHTZwxliu1tC?=
 =?us-ascii?Q?Xl0H9IcALQw1rLFlc83fLEaQ84jhaYmIbH8a4yaoz7XihgVRKUAYTl7c6gfj?=
 =?us-ascii?Q?AKvmNNKCl/0a9c9Y8uiuwbB6G3SRpIuF0QtiEwQKtnhWWrj52MqS488iSRkq?=
 =?us-ascii?Q?uj5u6i17xOgENQHOWTqWBp3zaZFmuHD9RImKCEY6HuYF2u2Gp5sbj+87/2Nu?=
 =?us-ascii?Q?1/ya9vnRetFgORyDA60y5pkhAX+F/XvpAivmza+4MjI6xsdSwM77XTagNMp2?=
 =?us-ascii?Q?uKBP5gTli5TKfMALTTQPLObTmOjsnSjcxSxfduTMBPqiTRNGebSA31nhVo/E?=
 =?us-ascii?Q?OAtO+V5exg4jtI/QnKmCyzvCFURYsf/gMGNS6XyWW2fP/gat0LyZ7RdqRdZO?=
 =?us-ascii?Q?5ifZ8rr/JTUf73AiViHY4OohKf+ajfEKx1O9msFdkhJmWeNB3+G06phSOE3b?=
 =?us-ascii?Q?aXV8iJXCPW4K3ulpj9O05q1y9pVXnv3eKcgoTVqEzrxgATby3GU+aSu1e0vs?=
 =?us-ascii?Q?dqhtLgX1tcai/ijW5Rc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:47:36.9361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe950dd-46d5-4bf7-5240-08de28a85475
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 956dc811fa..5f1dc80060 100644
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
index c820247db8..ff68f3c451 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -101,6 +101,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
     VIRTIO_GPU_FLAG_HSAKMT_ENABLED,
+    VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -125,6 +126,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 #define virtio_gpu_hsakmt_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_HSAKMT_ENABLED))
+#define virtio_gpu_resource_userptr_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RESOURCE_USERPTR_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 6c54cb745f..321477598e 100644
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


