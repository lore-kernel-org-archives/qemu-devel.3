Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2FDCFA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 02:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMHBj-0003Qc-7X; Thu, 20 Nov 2025 21:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHBb-0003Ot-5g
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:47:47 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHBX-0006Il-Bz
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:47:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhFqQBvf1tLSMn6t1tH4US0vx5jHgJklnIedOThbLH7cXvmyWESSCVQV5Ia8RqhCQGoCrsSEK8ZQ1YiE7ZfX6ndLajRepDzP80v/jqWKp99P16aSbpfBxh35CTlRnERonLCvn05i/u5XAD9G9TGv8PrlbVLaiVFFfSJjbTZv7MJyNw0DxIEQO80OcAQ9bTsOs8t0losFIXvT3/raYjnG4HnEXetWciWWi1xaZ37cETqIffkyLOnkV6qVs6prIhPNffrQAkFFiaTUhjpR5S2L1BS/WmOv/C/ZCN7um7ZYbpX6hVUt1Zckxn+Z3ZZ3LAH+4DgPVkY9aHRHY3DugmWBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6eNI828ogGk5DgEt/LD1ODPehtpxXO9IG+PQCUJrNo=;
 b=qjyvpGDO7mCJ5iUiOCGsIvjG0cO01xptwMmFKPKPAnf8llTIm5xdU+CGvUFFbsbwLojX7BRt/KMrsZ/TI2X3pKHiMJTnL6K5QWCAnmEd4ZA/p4etTPiC0kBH6QSCkP1kVoYBPAtidUlGPAqpopEqsKWGNZtl/m/CO49KPabhXUi7c9WZSwX9q5evlBT+tAFspqDY4IEc+XFUvdKyEAwj6+YXKz4qYReX+V0e/teK4T43Lzkjr2H7UqyCHrbhLwTSkE6SRM5RatJQVJvayPf+myjEhIFn2UdorLUCkDwgwRk9MRB/cAg0z+ABiizrYXGj8QRHpBjuxsxIitxX1+ZIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6eNI828ogGk5DgEt/LD1ODPehtpxXO9IG+PQCUJrNo=;
 b=hL/AMpj/xVjOnNDn0TbJUJlON0PeVCSG87X7DS5rRGJ/qI5EtUGpPuxi1ai9qOmM/zR8xeZ0AgguehfKiRjxHnnnb+w2paUzqOMw+HrrprvKmTVWNyFgt2n8w34+ML4Z4H9s3wuXpMt0CtcOBit/LWCMgwaqzQWmypFkHzusvXQ=
Received: from BL1PR13CA0300.namprd13.prod.outlook.com (2603:10b6:208:2bc::35)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 02:47:34 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1c) by BL1PR13CA0300.outlook.office365.com
 (2603:10b6:208:2bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 02:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 02:47:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 18:47:31 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v2 2/3] virtio-gpu: add configurable HSAKMT capset support
Date: Fri, 21 Nov 2025 10:47:04 +0800
Message-ID: <20251121024705.1403042-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a5f83d-a172-4e24-775f-08de28a852ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XE/oZl/imyjst63Qsy++RnC5cBCrnmgfzSVj/iKupj6Qlvg+A0ZTuY6dqBeg?=
 =?us-ascii?Q?BAO3nc9Fr08dc0gALaRbZbCkdjnGuLZV+avIq4+/1YsIzRkCCGiFg58MbiNB?=
 =?us-ascii?Q?n7m4zS7LL4ieu/H6bel4uQ+YaBA7yNF8bLJN+4xiT4xhsUGoM46DrNK/2lag?=
 =?us-ascii?Q?mK3pWxwEYvGagwxrEoLR5XUfV9VBOkyVQyU6dabtMGIC4jqaO5Qi3ngrpqi4?=
 =?us-ascii?Q?maTKn4xDHnB0fMByRYna3HZvlD/IxdO2kxqvvPjt5D43jhqfBiCoxXzjRnhZ?=
 =?us-ascii?Q?fWdzTe/ZkzuOsUwExfOns4pJujdvNhDvGgnWoqaqtur5+bfVIl1AS10H4zEA?=
 =?us-ascii?Q?LAlaND2iPSxljPok+ZizQKTOORgCS8sRhk1828mZPI+UyfKepN67GGfbUaa8?=
 =?us-ascii?Q?xjKwajFAYQFKaVWQAEliamWF9HyIA0guGI4PseHIEEtvDmRxVMU2fzMFU2VX?=
 =?us-ascii?Q?8+vg0yVXyGx/jeFR5I0Bvd3a0HEF5cWQ/G5e5O0brLJ5Etil7asN3HCzmcwM?=
 =?us-ascii?Q?6dhOn4yE6cXKHnZJpjy3/4LgXIrX4RVUeyrqrAJJcTsMVXAND7V3qiE9ZhHO?=
 =?us-ascii?Q?Ht4BhVfOIoLenainPMLcntWc0l0dVEv4cUNW6g7uqSVfOs03V38BjNlVWMtl?=
 =?us-ascii?Q?LrR/jQ+jOd+JrJHalX12yh+b4G2mdidv9oAy+JehDCGWaBdX6lhV//SMpB9C?=
 =?us-ascii?Q?VddoSdf04aweBG72fVpI9WN3roucLh8sjvEcCCSfwlq/B2NKjF8vHmBRls2U?=
 =?us-ascii?Q?2RlxIdqMlgGiLKcRRDNl4uRE68txJnXUjmnMevSgdCo0cuOEGsI3v0WkYLhx?=
 =?us-ascii?Q?MZ8YnfGiodoKWMNAxUIF3S8rsmKsTmjbaE9iAdpw2j3jiQQQTcDKcu1v65r5?=
 =?us-ascii?Q?3h4d2SYwsCobMSOTszGl2Sh5imH5TGqo97z1uNgtJnD1Tb2MPb2kTAWDeq/z?=
 =?us-ascii?Q?TwB/Oeljj8rai1KmJhHtXQMOQzwxpxl8y70fhWHcHctTwpIpJ0xcephdBCPo?=
 =?us-ascii?Q?nIqZWRfPZawkolNo+Es7i2fNuYHoVpo5OdMvUYTM7dnj76gkINNpBNz+9bPZ?=
 =?us-ascii?Q?KT5cRSo46ALyEU0kMaKsuSlJJiJE/YlM4q/v4cxdMegei4NXasVQaNrFXY9A?=
 =?us-ascii?Q?d7FUng4Rq7TLA+w+LFRgR7zL+lqgBzgHcFHyvuBQeZOy71TwAQLRZTX4CoA/?=
 =?us-ascii?Q?GR0JHmEkC51TAv4HmBddR9KzIYI/3LZSHJa9Le5m0NVQuhHfyOJaMa0cQh+T?=
 =?us-ascii?Q?TyLegVxtuUxNKgC0MxI4C3NNsyo8PczrIhCJvOabeVsn8kyzBSbi6yYTNHyv?=
 =?us-ascii?Q?tWEpRPXO+DKhhmAGJrSUjhXCIRdR60aWUnesbX9mmmFevfpDSyyv1lxSIY6v?=
 =?us-ascii?Q?erFgrgNu80Atvde34YWQ+CHu61TQQlpdGpAwd87eNIr2hIny6rqyMtCtcG/p?=
 =?us-ascii?Q?LCmBq8KSBHJM4wJjKDvJN9OqfX0A5ltlYbj56V4gc/YK8Z14IlEgmFEh8CI+?=
 =?us-ascii?Q?mL5ZBUF3wSOj0bIkYYDthug/mK8ekZqWjr53bylxAM2RrmOvE5MhMdK6r2Vw?=
 =?us-ascii?Q?Rj2UntikJgDNrhSftTY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:47:34.3733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a5f83d-a172-4e24-775f-08de28a852ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Changes include:
- Add VIRTIO_GPU_FLAG_HSAKMT_ENABLED flag to virtio_gpu_base_conf_flags
- Add virtio_gpu_hsakmt_enabled() macro for configuration checking
- Add "hsakmt" device property to virtio-gpu-gl device
- Modify virtio_gpu_virgl_get_capsets() to conditionally enable HSAKMT
  capset based on configuration flag and runtime capability check

The HSAKMT capset is now only enabled when:
1. The "hsakmt=on" device property is set (defaults to false)
2. virgl_renderer_get_cap_set() reports capset_max_size > 0

Usage:
  -device virtio-gpu-gl,hsakmt=on

This provides better control over HSAKMT functionality and avoids
exposing unsupported capabilities to guests.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
 include/hw/virtio/virtio-gpu.h              |  3 +++
 include/standard-headers/linux/virtio_gpu.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index c06a078fb3..4ed2f53e4e 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("hsakmt", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_HSAKMT_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index c927275c79..d907cc75e2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1160,6 +1160,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
     }
+    if (virtio_gpu_hsakmt_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDER_USE_HSAKMT;
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1218,5 +1221,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
         }
     }
 
+    if (virtio_gpu_hsakmt_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_HSAKMT,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_HSAKMT);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda..c820247db8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
+    VIRTIO_GPU_FLAG_HSAKMT_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -122,6 +123,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_hsakmt_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_HSAKMT_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index b85e781a2d..6c54cb745f 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -313,6 +313,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_HSAKMT 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1


