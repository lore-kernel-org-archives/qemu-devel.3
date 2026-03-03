Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65845EB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEDC-0007ZJ-P1; Mon, 02 Mar 2026 20:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxED9-0007Yz-RR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:06:07 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxED5-0006j5-VF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772499965; x=1804035965;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=isjgbJHyYDI8XCeds+5f1BABimzOuV1Ieca2QinJjkM=;
 b=dB3igh4fVWf0CyqOXqT2YomI77sAVUL2Uj7hWv2TiRH84bw3n4P53GCG
 al5ca3OPwOl7CuuT4JR3xryYOuAtwdb9OAvrqgr6R2oDspemuXK6cFRFa
 TTGYP7MUEkHSLnbSMqs7lJ/0c7ISSiAXxKM81JpYbH7P2aWZAp16MCWi7
 tteNwOn2+MlDw24GE77Bqjr1CMYu/fDHDXpD1emFQfpKHWWMDfJVOdDM4
 DQBN8xrlyhrQWQku+uzEKAQXMso+CAywjFLtzj+L9Za5b1H+lbT6YlAST
 Q9uXChiQgK3BMLzTaa0B+kWmVOkFfZQ2EUmanWWiNK8EjZWib+5i8btwJ g==;
X-CSE-ConnectionGUID: HMX6qpmWTFiFYsIW75ul7Q==
X-CSE-MsgGUID: OThQG8DARRGXDRysvGw3nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77135441"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="77135441"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 17:05:51 -0800
X-CSE-ConnectionGUID: HKpOzK6QQXqnLKdTGf+gTw==
X-CSE-MsgGUID: T4Y8MfxGQ9SRUMYODtEYSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="215402042"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.205.222])
 by fmviesa010.fm.intel.com with ESMTP; 02 Mar 2026 17:05:50 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
Date: Mon,  2 Mar 2026 17:00:47 -0800
Message-Id: <20260303010047.1925589-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

When a virtio-gpu resource is destroyed, any associated udmabuf must be
properly torn down. Currently, the code may leave dangling references
to dmabuf file descriptors in the scanout primary buffers.

This patch updates virtio_gpu_fini_udmabuf to:
1. Iterate through all active scanouts.
2. Identify dmabufs that match the resource's file descriptor.
3. Close the dmabuf and invalidate the resource's FD reference to
   prevent use-after-free or double-close scenarios.
4. Finally, trigger the underlying udmabuf destruction.

This ensures that the display backend does not attempt to access
memory or FDs that have been released by the guest or the host.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/hw/virtio/virtio-gpu.h  |  3 ++-
 hw/display/virtio-gpu-udmabuf.c | 25 ++++++++++++++++++-------
 hw/display/virtio-gpu.c         |  2 +-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda..65312f869d 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -357,7 +357,8 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
 /* virtio-gpu-udmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
+                             struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              uint32_t scanout_id,
                              struct virtio_gpu_simple_resource *res,
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d804f321aa..bd5b44f5fb 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -151,13 +151,6 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     res->blob = pdata;
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
-{
-    if (res->remapped) {
-        virtio_gpu_destroy_udmabuf(res);
-    }
-}
-
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
 {
     struct virtio_gpu_scanout *scanout;
@@ -169,6 +162,24 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     g_free(dmabuf);
 }
 
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
+{
+    int max_outputs = g->parent_obj.conf.max_outputs;
+    int i;
+
+    for (i = 0; i < max_outputs; i++) {
+        VGPUDMABuf *dmabuf = g->dmabuf.primary[i];
+
+        if (dmabuf && (res->dmabuf_fd != -1) &&
+            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] == res->dmabuf_fd) {
+            qemu_dmabuf_close(dmabuf->buf);
+            res->dmabuf_fd = -1;
+        }
+    }
+
+    virtio_gpu_destroy_udmabuf(res);
+}
+
 static VGPUDMABuf
 *virtio_gpu_create_dmabuf(VirtIOGPU *g,
                           uint32_t scanout_id,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a..b2af861f0d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -902,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     res->addrs = NULL;
 
     if (res->blob) {
-        virtio_gpu_fini_udmabuf(res);
+        virtio_gpu_fini_udmabuf(g, res);
     }
 }
 
-- 
2.43.0


