Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3CDC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQL7-0002P9-EJ; Thu, 01 Aug 2024 03:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sZM2W-0007J0-U3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 22:59:40 -0400
Received: from mail-dm3nam02on2062.outbound.protection.outlook.com
 ([40.107.95.62] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sZM2U-00005k-G9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 22:59:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI0e93nnWvp2J4iQiRERSRUGSiPWTVHlkjJNQi6uC5DDYhwCkBhy9fIn7ggNBsqBP6RRpaXSayzx3hPAV8onoLMooW7qXrWyV2nq4YMIwo9aQpe9fr1XmluUYYv5av59E8jHRU8pjr/lYcq5WUvQFGEfGFvgXXq4Bq83GnedMcUT/VPYG575DfScTCgZvlf45W/y5DeVYYCUWB+9b/s2Phf7rQtQd2r3NKRxq1VvlL+ZsoIH4MdWRY/A4clW8r7GfJODGktttI4STxfe44cxd01k/m2YdQ7jAItWu3O9YLg6karIcnC4bZ5w4itbt6yOYAPh3IX2ltWvfnI64fogow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOk+sfBuzPbh1hBtpWO1MlgWMq5JYQ6omqLePzSEjSY=;
 b=qJYCFRa70ZAwhsrTNe5MfvrAmHHbTFpS1h9MfrC/WORpUu4LcwoSm+hrUrNaWDvB/3DlCpedj8htvpvGLG8BmfXd0EG7WsavZEkLs6JcI1tm7bezx332ozWTY3++syEztDRWh0Yhrljv3Zirjw8RCneyecfrVomk3hfb2hPYgyF0SK0qSuVq0sHOy5y3mjfe//tMkHkbl7nxy0cTdaZ9xEx7WWvmPEnI7fNQzblCKkIyWS01CJ8AE69sG5Gi89LFUnvqtHr7lLuDXMWU5oiOS4A5nVkyL1vSAlPoxgkzESPfXzEcmh7dL+Y2r0wNgF+bI+BHeMMjD9FMzaB5u+s8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOk+sfBuzPbh1hBtpWO1MlgWMq5JYQ6omqLePzSEjSY=;
 b=rrmnMDAJXvS6wf6RDiuA3+buxFx7yPBusGzX23iXNALlKfpXLcFzWCtP/2sb8YU5hrPABsn2Otqulbes+8sTIx7Oa6MJ8K2C2KKa/sFGEfdKJHLTVf7HeEM8XCWQBJ5LA6TrliLXz9UzcAx6PqR6ux1ddxxLUWF2HJke5B9MkXQ=
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 02:54:32 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::c1) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 02:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 02:54:32 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 21:54:30 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <mst@redhat.com>
CC: <leihuang@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <ken.xue@amd.com>, <qemu-devel@nongnu.org>, Lei Huang <Lei.Huang@amd.com>
Subject: [PATCH v2 1/1] virtio-gpu: customize EDID for vms
Date: Thu, 1 Aug 2024 10:53:33 +0800
Message-ID: <20240801025334.1610-2-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20240801025334.1610-1-Lei.Huang@amd.com>
References: <20240801025334.1610-1-Lei.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: ee956338-c59a-4904-739e-08dcb1d54542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mKlrgf1+7fKjcvCgIkHgwY6AOpknzs1+nCou4xgJJv2MBqZlO7DJ4GR11cTW?=
 =?us-ascii?Q?5AxmZymp8S3/gjNPPb5B4AKXbQOUEf7w/luvClVJX8bSxz03KMhMcVPcAMtj?=
 =?us-ascii?Q?QMrQ6hgfrgeDZy1sOD4/5HdHrZ/pPAFiP6tT4BT733ogEbzst3S1oZwjkeQg?=
 =?us-ascii?Q?mYCkP+z0I8tnTewFL0vUUPJRwa8IEWWCkCfcF57zcgJQMwa8wU7izyU4rnjN?=
 =?us-ascii?Q?BumdE8B7wHdavrT/kSP0s212zdq+BlKOY9p87/EBWCaFs/DgqkgKAdQLhVO5?=
 =?us-ascii?Q?aHwj/6BTcZS1+wVv3ZtxZOr8h69eLrLAiSYAGwDwbE9u7IQ/VX05JWLnP0wq?=
 =?us-ascii?Q?YbzCCePQK68fUkRfdAjjbs87EOojuvOCfn0nDoh1n5e3GKLpk4UP2NELC/fW?=
 =?us-ascii?Q?conaoYTCgNEagpRWkAM8QvC063xjjK0EUVa8uWw5/atervHd5m8EE1S80yoV?=
 =?us-ascii?Q?m6ucWgzwwmK57FObzCe0/lhe1Tveyfh5PCabhYv8t3yxAV4FM6okhFSvxy4O?=
 =?us-ascii?Q?+AXEz2Kw1k/SDR6YMjMNBUqloef6zEX8jmQNZWSduEV+VQcG5lOCYh7G6hr/?=
 =?us-ascii?Q?VW6B06j8Djbk2y+XyOAnZDt5wo68sKDDgfGHKNox4DHPdsI12SYKa6NQFcxe?=
 =?us-ascii?Q?1zi0PxVWn8jRfyoKORxqcLQNzuaJp84fXvYLwIx6Zz1L6l2lL8U3w2tIl8LH?=
 =?us-ascii?Q?xpTXb659tKopyPkKj12eohZMr3Ua3nY2SOWEE6HZvxO3xgXW76J6KNjsc4o/?=
 =?us-ascii?Q?pun8vshquCgdZd3IfurybeznVrrvAjVgCV6wDZnXD0n4E9mmUCdmEUBaAhQy?=
 =?us-ascii?Q?vwMQiHRbZBj6XHdi/dTADGukIxJWbblvg1zXfG1QfQNKIQo2cYiR3o82N+zK?=
 =?us-ascii?Q?5q7/BBRf1LJ7Cm5JzC4eYwcNWBtIar37tSJ0fH9BymI1+Hnoscv9BgV7Kb/k?=
 =?us-ascii?Q?K3nl0lo32Wk5YA5sfvr2LS6tLoxpOZQBF90gKzNcwCmb9VXczRqylWZ0dfIy?=
 =?us-ascii?Q?0zS/c3bcSznTwXW+2511Ypd++iJmxQsaB2ponOmd7ot0TKe6T0UXPAlKi0ek?=
 =?us-ascii?Q?ptjFIUsjlECHHm/kUDQ/oAB9soB1lUcV4aWKw+vfW+KbE47NPp/6SfxFuH+Z?=
 =?us-ascii?Q?x2HSMEVhwYZHel8lAC9xO53vwujiz9PELcKiG98q+oxQxn19leaO3YNa7M7s?=
 =?us-ascii?Q?Mollo0hMVWXwX89VHvvmME1ycv4/44RLKPE2R7tlTN1Kq2iRHNURA+lFCVWO?=
 =?us-ascii?Q?w+fwZhy7aFBPSCT+PsTZsYETfk6HwAayxgPU+8e+6sCn64/RmR23Q36Gxf9D?=
 =?us-ascii?Q?w5np80+g5FUf92V3GpY9wEyCwMQniu7zl6Je4qVXEa6v8IUgHshEbv5ZAmsg?=
 =?us-ascii?Q?oPnBh8M0NVZMR4kdmWa6mH15s/4pJRoA0x6mNi+uQ2W/zZ/IwZuYSwW/6xFn?=
 =?us-ascii?Q?FSd0FnjW4aP5pFNyjFfZh6o6/F88G+0T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 02:54:32.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee956338-c59a-4904-739e-08dcb1d54542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
Received-SPF: permerror client-ip=40.107.95.62; envelope-from=Lei.Huang@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Aug 2024 03:35:07 -0400
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

customize refresh rate and resolution for the guest VM
instead of being limited by the actual resolution of the host.

add edid info and modify conf like:
"-device", "virtio-vga-gl,edid=on,max_outputs=2,
refresh_rate0=120000,maxx0=7680,maxy0=1080,refresh_rate1=75000,
maxx1=3840,maxy1=960"

Change-Id: I5d5742d280186ffd5dee9eba7697f06a2b09b123
Signed-off-by: Lei Huang <Lei.Huang@amd.com>
---
 hw/display/virtio-gpu-base.c   | 41 ++++++++++++++++++++++++++++------
 hw/display/virtio-gpu.c        |  1 +
 include/hw/virtio/virtio-gpu.h | 26 +++++++++++++++++++++
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 4fc7ef8896c..80d22005447 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -46,8 +46,18 @@ virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
     for (i = 0; i < g->conf.max_outputs; i++) {
         if (g->enabled_output_bitmask & (1 << i)) {
             dpy_info->pmodes[i].enabled = 1;
-            dpy_info->pmodes[i].r.width = cpu_to_le32(g->req_state[i].width);
-            dpy_info->pmodes[i].r.height = cpu_to_le32(g->req_state[i].height);
+            if (g->edid_info[i].maxx && g->edid_info[i].maxy &&
+                virtio_gpu_edid_enabled(g->conf)) {
+                dpy_info->pmodes[i].r.width =
+                    cpu_to_le32(g->edid_info[i].maxx);
+                dpy_info->pmodes[i].r.height =
+                    cpu_to_le32(g->edid_info[i].maxy);
+            } else {
+                dpy_info->pmodes[i].r.width =
+                    cpu_to_le32(g->req_state[i].width);
+                dpy_info->pmodes[i].r.height =
+                    cpu_to_le32(g->req_state[i].height);
+            }
         }
     }
 }
@@ -62,6 +72,8 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
         .prefx = g->req_state[scanout].width,
         .prefy = g->req_state[scanout].height,
         .refresh_rate = g->req_state[scanout].refresh_rate,
+        .maxx = g->req_state[scanout].width,
+        .maxy = g->req_state[scanout].height,
     };
 
     edid->size = cpu_to_le32(sizeof(edid->edid));
@@ -96,9 +108,16 @@ static void virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
 
     g->req_state[idx].x = info->xoff;
     g->req_state[idx].y = info->yoff;
-    g->req_state[idx].refresh_rate = info->refresh_rate;
-    g->req_state[idx].width = info->width;
-    g->req_state[idx].height = info->height;
+    if (!g->edid_info[idx].refresh_rate) {
+        g->req_state[idx].refresh_rate = info->refresh_rate;
+    }
+    if (!g->edid_info[idx].maxx) {
+        g->req_state[idx].width = info->width;
+    }
+    if (!g->edid_info[idx].maxy) {
+        g->req_state[idx].height = info->height;
+    }
+
     g->req_state[idx].width_mm = info->width_mm;
     g->req_state[idx].height_mm = info->height_mm;
 
@@ -204,11 +223,19 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
 
     g->enabled_output_bitmask = 1;
 
-    g->req_state[0].width = g->conf.xres;
-    g->req_state[0].height = g->conf.yres;
 
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
+        if (g->edid_info[i].maxx && g->edid_info[i].maxy &&
+            virtio_gpu_edid_enabled(g->conf) &&
+            g->edid_info[i].refresh_rate) {
+            g->req_state[i].refresh_rate = g->edid_info[i].refresh_rate;
+            g->req_state[i].width = g->edid_info[i].maxx;
+            g->req_state[i].height = g->edid_info[i].maxy;
+        } else {
+            g->req_state[i].width = g->conf.xres;
+            g->req_state[i].height = g->conf.yres;
+        }
         g->scanout[i].con =
             graphic_console_init(DEVICE(g), i, &virtio_gpu_ops, g);
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3281842bfe1..dd759a80522 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1666,6 +1666,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
 
 static Property virtio_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VirtIOGPU, parent_obj.conf),
+    VIRTIO_GPU_EDID_PROPERTIES_MULTI_DISPLAY(VirtIOGPU, parent_obj.edid_info),
     DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf_max_hostmem,
                      256 * MiB),
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a7..61c69735dba 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -18,6 +18,7 @@
 #include "ui/qemu-pixman.h"
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
+#include "hw/display/edid.h"
 #include "qemu/log.h"
 #include "sysemu/vhost-user-backend.h"
 
@@ -150,6 +151,7 @@ struct VirtIOGPUBase {
     MemoryRegion hostmem;
 
     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
+    struct qemu_edid_info   edid_info[VIRTIO_GPU_MAX_SCANOUTS];
 
     int enabled_output_bitmask;
     struct virtio_gpu_requested_state req_state[VIRTIO_GPU_MAX_SCANOUTS];
@@ -168,6 +170,30 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
 
+#define VIRTIO_GPU_EDID_PROPERTIES_MULTI_DISPLAY(_state, _edid_info)   \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 0),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 1),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 2),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 3),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 4),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 5),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 6),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 7),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 8),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 9),                 \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 10),                \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 11),                \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 12),                \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 13),                \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 14),                \
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 15)                 \
+
+#define VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, id)             \
+    DEFINE_PROP_UINT32("maxx" #id, _state, _edid_info[id].maxx, 0),    \
+    DEFINE_PROP_UINT32("maxy" #id, _state, _edid_info[id].maxy, 0),    \
+    DEFINE_PROP_UINT32("refresh_rate" #id, _state,                     \
+            _edid_info[id].refresh_rate, 0)
+
 typedef struct VGPUDMABuf {
     QemuDmaBuf *buf;
     uint32_t scanout_id;
-- 
2.45.2


