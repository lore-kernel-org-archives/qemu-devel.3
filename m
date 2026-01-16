Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66C0D4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfRr-0003Aa-WB; Fri, 16 Jan 2026 03:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfRq-00039i-34
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:44:50 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfRn-00060a-TW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:44:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhYwl4XGm9WZqS08r1/bChcjyv9fuOwKbIhPW614Bgw/rVjmy+06cdhMZa/gWe4v0Eh+/+dFP7pZs6vTg68MXB9rQppx2P+37iHWymTCXBxHvHj+2qbgP1T96Exh6gDZbZ5Sd9IsCsGJWRNADFE8dnVPfh5fJF+tVoh849Nq5I3XOdAew/HYFbzgRYS781k83Ue3S8aHXswtfgIQsctBQytRV/b2IlzcnYBBDR8zBEsPPrA1VS23MjBYwB2V/dVGQb9I69acRyr8wfkRC+5/ODSpC2U5W2nLesneEK44/ni09Ro4b/sQK26zuAozxjyZT9ctGZbZ4El2vwYn24xa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNOgWtPx2bJ7OlOPzP/bnM6XqKyAdKXeNppIo33ygx0=;
 b=aXaCivC3Z8uDFgarwqhOHnZzePxURGx0IQGbQ0QBonbLnzLbu11B7upGYuUb5YgoZ0LQ5I6rv8nvs31cbwfFAMoy2aUnQ89IrOReTkCn/0mbXaLdcEcKlxNQn1aZOjAlACXvwZJpT55CKj/mMni21h2wYGs0IcQlGA6yktqzP1ryrhZpTxSU4FPx0vtl004h5q7PBXn1XyGSKt4Pr0wOpjWBgaHEtQOj2JNUKPhX2VfpAvqC3iacH3meF68tB3uqo6ZRUP+kqsiN6LTQiYuHf1JMAXx6K96nVG0a+9B9yxKCPECJJRWF6+ptybsqpb3S5/cnwC1PhXUNAGXdpre0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNOgWtPx2bJ7OlOPzP/bnM6XqKyAdKXeNppIo33ygx0=;
 b=r6uZlE77HnwbJkZ4cvUjp4+NzU5T6IcNZJ7Ddy888t7V/4Mpj67E79gUxYGszBJ2SV6l27a8rogWq1frprjQ4t5HengEtWWWqXneLANZvNC23f4w/Sz857HhXJrlrn755lVjNWTcsuG6lwaksueZsXjAjV1QXyyJjeuRE7HAVQA=
Received: from BN9PR03CA0507.namprd03.prod.outlook.com (2603:10b6:408:130::32)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 08:44:43 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::3a) by BN9PR03CA0507.outlook.office365.com
 (2603:10b6:408:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 08:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 08:44:43 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 02:44:34 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC v6 4/4] virtio-gpu: Add ROCm capability support
Date: Fri, 16 Jan 2026 16:44:09 +0800
Message-ID: <20260116084409.326062-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116084409.326062-1-honghuan@amd.com>
References: <20260116084409.326062-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de424fd-89a9-4d74-163e-08de54db7e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RXGs9l+0ZwIdxCEQtWYxR4CKt3XaFGzef21eDyWKxuHxusuat0xVUXKGBwVZ?=
 =?us-ascii?Q?isKh4n9Vk/wb2HhhLJMChxnL3itHF9vAO7YPmLOLDtrND7PIy7HrbEWfpZl4?=
 =?us-ascii?Q?rN+t9opDP0tYtGkdCkg46DJd73EtnZhlUZO6E4MqCEp/M75166zycOS87IvR?=
 =?us-ascii?Q?tBOzuT3sO48yO1gSAmJJhAoc/yYpMAo1tyBVEWR3dO4+xFhycg3wS8jbhFuH?=
 =?us-ascii?Q?qQ9I9tMGL7kNnf/FQOSd0jZVPE13A0YEWRV9fo+fMl3Mnd5rWfvnHlWxDdHf?=
 =?us-ascii?Q?h5TKZbWeJwcS103zbDlNPSMC548KUkO/gnUFcpEzoS2pncDLJpXU/7rbbonR?=
 =?us-ascii?Q?ijyH1KVnFe6QTbgJdYcqZ5j7CkJzrkNPZi9w2ZdhhlFBuPo6dcSiqdmc/FMe?=
 =?us-ascii?Q?8hd3B4T6/bAH0PYl3BqQw0QSnrKGdrTMEpyt2PbWfv5jFCbqwam5pAJhiXgs?=
 =?us-ascii?Q?+EMhnMS2uWgL6Vl3VAYmmJf2rEmTcW9RC9yXYfWWwFsPHau6aABsrXzVmX3H?=
 =?us-ascii?Q?EpJklg8tBRNZqjQr7ZMzlZqHfu/Wviq0xaAUPjceuD9h239n9cQydRtWHHZL?=
 =?us-ascii?Q?HZ9TSeioF+UUuevIx7feEfrJhpXj7wF2wjtBHa4wu5ZERpdAbHaKjThB/rO0?=
 =?us-ascii?Q?ejZ2+xjupvA+gDntqHlqxUnVsh+TgqXiQGQwgbr/29p0jb4aGmF8KvDWWa2m?=
 =?us-ascii?Q?w389YFkmpDJrIoWDwgajio2Bupar9FEdYK3DJzNRJlaRwXlsP/vclwEFRpMf?=
 =?us-ascii?Q?dBAzFWew0GiObv8ZLOuW6w+p3xU52W87e7VQrs+K9PXDwPDbxlQam+8pia3z?=
 =?us-ascii?Q?dUKpOPUnFQ4dea7Rr9Xj2xR54gQ/cG5Kd9/mmUMneJbhJhfuiChyXOOa4Yd/?=
 =?us-ascii?Q?ZYzu4M/wFXHo4K6db3bvQGsZDGq/m9h1TV1kSbfaGheFuufbDc7kxbLT+SjS?=
 =?us-ascii?Q?tuwjDMVIwND6TLM3HD4nWtUUHjCC2P8TgHdwxPZ1+JOWNK97oA9TJ8MFSDcu?=
 =?us-ascii?Q?jf1uU6Wmqg//BBxcQwfc9HHRWhfjJOlDbj6mmc2lxHh5JN9A7I47GezyRdru?=
 =?us-ascii?Q?ZMDEnTRYbm8YFl/z9ust4GAmXDdkvniAgeR3wmcB6oU54mpf+p3fk1KeV6Nq?=
 =?us-ascii?Q?MqXUt7WTGsZG7Nd71ramWVM+HldBP4Aq693yDeCWLIK2acbpRZslddbxiPfx?=
 =?us-ascii?Q?QvbgSE4qF2rixnjb9QqHENARuBuIfJ6hmhin7AfmxSJyRE96rKBCCVfQ/7RU?=
 =?us-ascii?Q?eWN/M46BjdBl/SYV2Hqw0WS7hhEbyOW0GUZ2KNh0IXJGw3owJxV/hQkSBudw?=
 =?us-ascii?Q?k0ZqtMmJRyLPmV3gXdYRx8ufhFOraWD45O/ntTDuVXivJrNXfZV2wrqtJNQr?=
 =?us-ascii?Q?Q9PwMk9oELL8uOaK0b6qZCjFopMEIFIkki2eE5NJAGrr+cFfoekHL3YtL8t8?=
 =?us-ascii?Q?wSXQUmE+Ao0Kyb1LlYwZKx3AcQdVKStBDxFZVkSWRdEp/yU+Yght1HMlkuGg?=
 =?us-ascii?Q?4R2bMvG3IKZuqk4PjTnIrnrSu38hZWD6SqmDYmrFZIl1ZNTjnLjcWUge3HS6?=
 =?us-ascii?Q?6cC6hfnYNKBPcxGRXPMz41TE1onqwFMkwmIJ2CBnEWrUHMetlcTUJKzrC4bR?=
 =?us-ascii?Q?T0KnAsRVIXTk3yLrlCZvFfWGeMZMVSEVxRz2trzkWbUDiDYfGdmK6jZJuLv4?=
 =?us-ascii?Q?9F/qlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:44:43.1219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de424fd-89a9-4d74-163e-08de54db7e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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


