Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F2FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBgl-0003rB-PW; Wed, 12 Nov 2025 09:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5gk-0000VM-AL
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:54:46 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5gh-00036x-RD
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:54:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjSnriKggDsrvWj6s7mw8pDnwCQ5pPtwHwegHL35OTdaT71x/YRnJomSw+/rd9NxkhKbJsUnJs+JVaZbAKQE9wvXsjCY2zw1xlEExk/eoq5v/CiWyZ2+dwWRwqoFLeQsZVg56BsJ/ENpg2gjxb++DqeH0od7k4/H+2CNaiEW4BvjA+Zjz/ynlnBHf6m8leEYStVK+DdW5a0jI6Ux8CugWqxRnsHZR0K0srCZDr39bwDR4kmnP/+gv2jSyXhpABY6rhkHKBMuWDCYOPy7MgCagoJR3GWmPfpKgaqeNGWbi6qFrQCDVBvW4C1clPn6w8mBgR6xu9YF/TrD3D5yweqZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZfkjAqHwQvF5b4CyD4zYNAlJRRnoe2uIYAfUTn62gc=;
 b=WK4Z7uQkubVTmeHjEp/ETZneYGia6qXn8ou4e6pVxMJZr0gt7FgDU6z3VnqT8TR0jfJWh6e0H091rU0ywEEc6+ZpWbcGgjTyzRVvuPeDsy3K4/GlGsvbqddRLmqbl8h1qtXsHEfdKL+Y2g1wravi+s6/cZ3bStQcBg59cDnjwfS34QndWDzASAwuOtEWRiiK0Fo2ga6Hg0OLejJFLQry0rfIevBpzPmgAcSg8px205mG0hNhd214fwmqysQd5mX2Uy6K3iZOBLJ4ieiwdZrXYuyKLRAWvsLeDd+Eg51PFgggpkReR/Te1ApF5VyIB3rs0TM9jzdU1bSCHx21OQzNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZfkjAqHwQvF5b4CyD4zYNAlJRRnoe2uIYAfUTn62gc=;
 b=nKJL5q/s13xE9KOAWT/XDlqZjpmpnzjQXCDmBP1WEZc3X/Tfm46Jm04nQdEk38qSIvTx6hgvS6mJukAxgvsfvIYYkt6L03S/x8AM/4RZE0kXwt/dYEjwB5UrgONe86QE7dxWTWA5NRhh/7ToQsHQsp7fSvX2Up3GUNt8nGnnMZ0=
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by SA5PPFC3F406448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 07:54:38 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::6) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 07:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:54:37 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 23:54:35 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <Ray.Huang@amd.com>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <mst@redhat.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH 2/3] virtio-gpu: add configurable HSAKMT capset support
Date: Wed, 12 Nov 2025 15:54:13 +0800
Message-ID: <20251112075414.3719917-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112075414.3719917-1-honghuan@amd.com>
References: <20251112075414.3719917-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3beda2-7721-407d-bed9-08de21c0ba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GzpUMKcbkDAOqAuhXY3yDIx90+/v3CfmQejL0BpN8TfftywvN/daPTGdthDt?=
 =?us-ascii?Q?l0vFDBv3mRHghiQKnVE+aTGxX8eZPYmNgVpJP5DzzNntE3HyIsHPf5OE2FHC?=
 =?us-ascii?Q?PTJrc3FT3b3eov983CSdWBkHQvkQDh7au0sTghUtkwz3lqknDHJeGGkbLqDW?=
 =?us-ascii?Q?GkHcjpWmA0NRynH8QFWt1Ml6IS2mw9OC9qhyvhqJcpi6RaXdDM928KXt+ouQ?=
 =?us-ascii?Q?VhCtSLeU2geQDT7JaWnKJtXcs5wgm19sIVD4s+xI8txKUxVMiyeWchxcSgI4?=
 =?us-ascii?Q?v9aTmcLGyMX3LApCwJHNaYa4L4OJmUScMH0PWYaIQpOOXQD5NKsxQluXnGsV?=
 =?us-ascii?Q?rQyvdy73x4LrjSIdsojB4/I3xoGK8RHTPk9XwojmZxRlpUFKSO3HjdK7LgRg?=
 =?us-ascii?Q?KfSxssWby4WPNqdrnCSu/s9b6Ecyv2Nxbg6jy+ogm/+I3KUxHcwXqHUD5L4K?=
 =?us-ascii?Q?3BJMWuXIKA4cUtPoBu77QspStty9nU20Uxyf/ssVNTGlVdy6bcT4e+CDEyXg?=
 =?us-ascii?Q?/kA8EEQMXxKzDx7RA7aAq2CM27pLaH2U26sQh8EZEe04Vqp/B8a5Pz77JLrG?=
 =?us-ascii?Q?89JbyutPAgqlbkwm1Q2eu1Nah37BBBs4+xfBKscsVpkPnvVya1XqESEaKX5a?=
 =?us-ascii?Q?U3fwBPqujP9CJj3w+w7UxdHQIiuRoGyD7cTyaFl3/821Ck0luU0EhxEl+V9t?=
 =?us-ascii?Q?+E0w7/Hj1dDdWSbZDYo/PrHtdAFxFEQbVAaXfHIBzQBpetQCH81j3ffDmulQ?=
 =?us-ascii?Q?wzfqJP5TmBGUEZjyThN6NI9NHLVUlnbjzNhZSADHWN6iaMQgQn8r3jd1ASlH?=
 =?us-ascii?Q?5zev5e8yhkcjcqXmmrmLVCiiBvPrVi6km3nJJ6lj6IKrBIfmsJwLbW9vWGhe?=
 =?us-ascii?Q?deiVCSy5l91X5HDDTe3pFOacFGG1TsbjA5xZnGP4cX/NQERpZ2o26cUWyEAG?=
 =?us-ascii?Q?vd8A/nryi519WwFLAlPY9B8UuH4BUblmiwEA9mgOvtcNEjhPkCgMWiDrqvSP?=
 =?us-ascii?Q?rpYlUwN7bh4W3BzptyuOU/VxyrP5mNXRUaHWnUJGqUb4z5NDf9VtPGRESZaz?=
 =?us-ascii?Q?n+DkIqVDJrIqnYrgdI+i2DhwlWRORyPl04FldMtsA4zeY9uFW1rZMqJ0mB63?=
 =?us-ascii?Q?8d9n0mV8meqDoNlbpQehmoemG+4LMZNtDDwzvD++Ln3JhWczJmIkXKKdvOBe?=
 =?us-ascii?Q?kZdM31Z9GDv+y0uShwES9xk0sQVXvOvWMkjj3OwRqWhsKUlpUusRC+Z36cZr?=
 =?us-ascii?Q?kco3Ilww+ADt0RpIipMBsd0rW8agNDmHIQhR3s6gJO0QOmMcsqfkUKR0FMml?=
 =?us-ascii?Q?51z3ZIQowRwSievjLfCbDwGnnRyjJIe4KwNY9r11sbVS/AOYd0SfyVjUeac1?=
 =?us-ascii?Q?SQtPeWHs/yAVYl933zertLfTaQYvHu+f39FoM6eT2P3p8lnwxLbnRHIQ16ZZ?=
 =?us-ascii?Q?aC8qGkUwNiYBZhdvWVHbcIRBIjqw9nb5zj9xWBXHAGQ+PZsQiml6wHq+LiXI?=
 =?us-ascii?Q?E6WtcA+L3G4uGacDwPN2/cG/igdlOlZ+rMsCCe5ddf0In7NWPvTxEDAUC6QU?=
 =?us-ascii?Q?E3lYDEtQi240cckb3ME=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:54:37.8675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3beda2-7721-407d-bed9-08de21c0ba86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
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
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:19:00 -0500
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
 hw/display/virtio-gpu-gl.c                  | 2 ++
 hw/display/virtio-gpu-virgl.c               | 9 +++++++++
 include/hw/virtio/virtio-gpu.h              | 3 +++
 include/standard-headers/linux/virtio_gpu.h | 1 +
 4 files changed, 15 insertions(+)

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
index 9da64bf16f..7162c4bfee 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1227,5 +1227,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
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


