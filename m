Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754FBCA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgL9-0005V8-2F; Wed, 03 Sep 2025 01:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgL4-0005Sg-Gp
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:24 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgL2-000206-Qb
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756878441; x=1788414441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BU5RBu9Owyo/QkBmmzVDRxjd1vlxZzGymV4N3uTNCYw=;
 b=ixBcuQYMlAQvnkDAh5ePmwhBqiSCIihrAcCs5UyinsvEobbuQEhfbVnY
 2UHESoEPk+Rpp06wXGGNW9IJfso+dnZcg9Idg8EEG7O3kg5zikkuqDZEM
 wACDgEP9GWr0a2DMbExCsXqclI+mKLl1h6F/JG2Q+O15HNMIOcn3sv3Ro
 35Enuz88xS7Y8SuxQd0Vs/2dI4sMnhLsZRIf0HDqT1SgWrVpn5e36gA9w
 fqTMc8+1X7/5yUEsi1RS/S50uQ6Y8ZzSm9eb7O65X+qzsEZYQJr15ivHq
 2gwKVLwuOwd5AYEnwefro7riPeOfKs73D+KVSy/lzDGMzKsATU3tcCpWB g==;
X-CSE-ConnectionGUID: wFd46wkcQtyCybBAx3AJlQ==
X-CSE-MsgGUID: XrrfRx8/Q8ygHSSXRmlaqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58878210"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="58878210"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:10 -0700
X-CSE-ConnectionGUID: x09CrNPgQNey1k8mnzMB+A==
X-CSE-MsgGUID: zRdOdsBqTTKKOP44V0peaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="175634784"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:09 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [RFC 6/6] virtio-gpu: Find the host addr given gpa associated with a
 ram device
Date: Tue,  2 Sep 2025 22:42:19 -0700
Message-ID: <20250903054438.1179384-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

If the Guest provides a gpa (guest physical address) associated with
a PCI region, then we can obtain the hva (host virtual address) via
gpa2hva() API instead of dma_memory_map(). Note that we would still
call dma_memory_unmap() (to unref mr) regardless of how we obtained
the hva.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1654a417b8..4af8390bb5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -32,6 +32,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "monitor/monitor.h"
 
 #define VIRTIO_GPU_VM_VERSION 1
 
@@ -799,6 +800,36 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
                               &fb, res, &ss.r, &cmd->error);
 }
 
+static void *map_gpa2hva(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd,
+                         uint64_t gpa, hwaddr *len)
+{
+    MemoryRegion *mr = NULL;
+    Error *errp = NULL;
+    void *map;
+
+    if (cmd->cmd_hdr.type != VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB) {
+        return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, gpa, len,
+                              DMA_DIRECTION_TO_DEVICE,
+                              MEMTXATTRS_UNSPECIFIED);
+    }
+
+    map = gpa2hva(&mr, gpa, 1, &errp);
+    if (errp) {
+        error_report_err(errp);
+        return NULL;
+    }
+
+    if (!memory_region_is_ram_device(mr)) {
+        memory_region_unref(mr);
+        map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, gpa, len,
+                             DMA_DIRECTION_TO_DEVICE,
+                             MEMTXATTRS_UNSPECIFIED);
+    }
+
+    return map;
+}
+
 int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
                                   uint32_t nr_entries, uint32_t offset,
                                   struct virtio_gpu_ctrl_command *cmd,
@@ -840,9 +871,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
 
         do {
             len = l;
-            map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
-                                 DMA_DIRECTION_TO_DEVICE,
-                                 MEMTXATTRS_UNSPECIFIED);
+            map = map_gpa2hva(g, cmd, a, &len);
             if (!map) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                               " element %d\n", __func__, e);
-- 
2.50.1


