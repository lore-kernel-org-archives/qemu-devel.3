Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A439EC3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXE5W-0008Vj-Og; Fri, 26 Jul 2024 02:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sXDr8-0004AN-VW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:51:08 -0400
Received: from mail-bn8nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62a]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sXDr4-000512-2c
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEGXJjS0xUmqkwJxvjKptAXKVRmQdG9dwhRM3Xj7gvP/WwhuF/uoJrnGKKEc9U8FCYU9rCuEeAqxqGbv7kYoIxv+YoOd1KIHQ+ISGM0HfB+G6Mzwr3SGHpeLuWaMpopP94x5UIS2b+9Ugmll5AqPwCwEmN3lYgd/6O6Wmyri+LU76VUg7bu3TY/qo6FzPDJmav2OmUak1gmzi8KaZXVezvwXEZCRdzltasKL6EGU8pFimH83rviunuDfzH2cOeso3bPunIzeyteN9jU7U20zZzDZsRTTa421zdH95Rgi3E38r2ubd2aopGZd/IxgZRyaD1xAcpSUYbC4sBv2pqYMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHgwfUPVro9NoMU8kggmkeynkpffBvsl1Qxu1jAKX2I=;
 b=XdxLKidftSnIwVrQfS8P3T6I4wZ51HedQAtRUJkyc5292MalZvRRSlSSvpmvvdfoH8DvDFUW3EzF9ZX7FihgPwiQ7s0VZT35dEG2Gq64xW8wGK9nfbiM3Bfyxzwvm25Pacqz4M6SGYoecR354eo5s2fuoVmKrhB8mM8u0LSnEyjOBZcWC82gJE1TTcYzBZsWyevCRdZvwEZlNQSiL7kLIXrRO5cID5HKJX6pJWxQ556MDh7g34s89MnVVWQ8m9hREqiEBPFFEyNum29QKnD9mbeGZWKlXVpA+8Qvaa9SM5wV0nVOACK4lfbT87k9MWF989Q5RaprmC5Ff+2glT3low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHgwfUPVro9NoMU8kggmkeynkpffBvsl1Qxu1jAKX2I=;
 b=ZQel0/zrQrIN66XlzMNsFUrpLvabJ2CgQrHjC0pVKdvxREQzqWoT4CJ/h+aCzyHzHs8SFEXyxqTpgG+Py3DqR3kyd7ExZr5PxEJgBB1B6xTujNTBSA/dRstCqbkklmDseDgNzTl9imdR1CR5dJ21dpXyEPPL/lrhO8pfq2D4qcY=
Received: from CH0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:610:75::23)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 05:50:55 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::a1) by CH0PR04CA0108.outlook.office365.com
 (2603:10b6:610:75::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Fri, 26 Jul 2024 05:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 05:50:53 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 00:50:50 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <mst@redhat.com>
CC: <ken.xue@amd.com>, <lei.huang@amd.com>, <qemu-devel@nongnu.org>, Lei Huang
 <Lei.Huang@amd.com>
Subject: [PATCH 1/1] virtio-gpu: customize EDID for vms
Date: Fri, 26 Jul 2024 13:50:29 +0800
Message-ID: <20240726055029.946-2-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20240726055029.946-1-Lei.Huang@amd.com>
References: <20240726055029.946-1-Lei.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c9d471-2b9a-4541-78f1-08dcad36e9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fNZPHtPAEyl/OOnB/GL8mLiuhWq3yis+FkYyZPF5eIVmXLWq4WTn7xsSLWYk?=
 =?us-ascii?Q?bkj6+5oYi9cve5rJDXk8gZiG3jROYmWkmpU93pXc62Gruw8f3V9p403Jw5g/?=
 =?us-ascii?Q?tohm0IpIODGHMafX/8WCRNOt4JG5B4syfU/9ZshTOkqUfdR3FH06+jZLr6qe?=
 =?us-ascii?Q?NfiL+giMQFhmmmYiFNyHNVXfsIqjjCkiA5XFlakxoQgOojgcA1+/BQKnQPfK?=
 =?us-ascii?Q?766Vagec5qYfsDpq8AI8yzX2qbOfxLi4pTvn8+V2Cxc+8IMEl3BN4M7eHyuq?=
 =?us-ascii?Q?c3KFb+FTdymAzjazsOL2uiKLsaKCR/pFYEvDgC9fy5IPi0NioLRVBJIRvstx?=
 =?us-ascii?Q?bPI1ygarykGYyQkElUcPCHljjUbssO9PJ3ScGFJ2rHVVNQVYyI3rB0J/GnoV?=
 =?us-ascii?Q?yxr+kUf4qoHWXXWrg8+b5LaEOPm0ZZx2CWKm+NmI/YiYqeSgvv++Yk/XoPYs?=
 =?us-ascii?Q?rqm88P5fAtp4kXWxtfoWu+sfPqs1loxGNN2TyfSYlpDbMo9rzJyHxlycrXro?=
 =?us-ascii?Q?mIYyBANulFov1b7WEgyn3DZnZT4RabIWqbhNq+Gz8rk9Ob4KAlBDH/aC1Xlx?=
 =?us-ascii?Q?qWnlKyKSkeCoidATwZ2f25V0yE+HAh438u75oDwBYTKrt8QJpjWf1B6AxaRo?=
 =?us-ascii?Q?jpLI00/4Dwtjdc+9DEzA1L9H1xvmpqcbjPFMK+UA34pUw+3RFVXSJ4H/Q2xV?=
 =?us-ascii?Q?oTq8BaHgpn90aEmXrNWuH3pbJ+OCJVt/MCE9eGIQR+satTpO6YkZ7KTpNg4f?=
 =?us-ascii?Q?1Yh8AchdjZU2OoBH1rq6buNRrRUArkCW0K4J3Ab7NwFYTt0WYsZ7o5MzvzL7?=
 =?us-ascii?Q?hpIXh66BtjsnhWpplhru7VY+LaH75OwJXFGxgYfDXmHx3jWGrFfvQZ/oJ86V?=
 =?us-ascii?Q?mlcVLaMRrTGsvmcSK03ih5BFPvfHz+7lZkCje2XOfj42z08ZbsGMhoovY+G4?=
 =?us-ascii?Q?05KWWL38NZZb3WPXFR21OtjYtcQOszR1bgCCstyr2p3RMr5SJV10MH03bgDM?=
 =?us-ascii?Q?22FCq6XwSYf33rJeXgG4SJYIxN8AExKxzbbm3FD5KzbhIFBl4xDzBes1YZj0?=
 =?us-ascii?Q?P/B9KZXuOc90h3SzR7SB7QsJh0Ay+k0lVh5HJtKE9eHrhLLBY0YZK1EMP7qH?=
 =?us-ascii?Q?qMD7KmXULjsAYlU5celUxuRPLQtBe180VbBt60yv6kguAZh4YWDsRjrA/Eff?=
 =?us-ascii?Q?CK4ooMLe0TtlIvLZgXx51zXWrdHZUeD0gUbWdZxGFH6lBdh7t+K2/bGuNYJV?=
 =?us-ascii?Q?ac1/uRZAzbJZciTzSFXmGnDusfVSkEg2PoOjBSa94Vo/tqnlILuPwmB3xTVn?=
 =?us-ascii?Q?5zMqob/bi2waTEjDcPz44OcJ7Pr5DhMEW1BaSqwXMKo8OgOLNd/L/bnDmrx4?=
 =?us-ascii?Q?b6fMLntGA2+HOdGaD4Qtm90Vk31CO6fxICrUPS0rMcwDNM4ZUdYxuNnU0o4k?=
 =?us-ascii?Q?eYBjyHwKqrGYYaiTncCT9UKUYpPIGyhy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 05:50:53.7017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c9d471-2b9a-4541-78f1-08dcad36e9a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
Received-SPF: permerror client-ip=2a01:111:f403:2414::62a;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Jul 2024 02:05:53 -0400
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
index 7a59379f5a7..094f2f65f71 100644
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
+    (VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 0),                \
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
+    VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, 15))                \
+
+#define VIRTIO_GPU_EDID_PROPERTIES(_state, _edid_info, id)             \
+    (DEFINE_PROP_UINT32("maxx" #id, _state, _edid_info[id].maxx, 0),   \
+    DEFINE_PROP_UINT32("maxy" #id, _state, _edid_info[id].maxy, 0),    \
+    DEFINE_PROP_UINT32("refresh_rate" #id, _state,                     \
+            _edid_info[id].refresh_rate, 0))
+
 typedef struct VGPUDMABuf {
     QemuDmaBuf *buf;
     uint32_t scanout_id;
-- 
2.45.2


