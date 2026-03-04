Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22DBEFCE44
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 20:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsyU-0004h0-Rr; Wed, 04 Mar 2026 15:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxsyS-0004gB-E6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:37:40 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxsyQ-0002Bb-Fg
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772656658; x=1804192658;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iU9HrAlxyVmFdRmTMc/tpTDGjqXl8/2Yo7G/tAJ23y8=;
 b=nLS+6TO3t2SJ9HJYQoQpCntuC45dtQmqLCqbuvHcvzIP3AUBsrpMf5kC
 MI14tBIpY+elECWhJBFr8SqsYM8Zm9uFFyrzwmadZuiNxiIc83LHRcKHw
 YnmfjTuvKNIHzUXvAbVOVqoR0TAO/pG2celQbeOhVrAA3LvDcOvRZBy4P
 jEs43L5s/LgC62QTsXp4nYUja9MsyG1UM8D0YgNCZxWVM3EO805pPwoE0
 7U7vwbrGIKAD95r2hUvx3FOgglFLap5j1eS2SHyiZkv63InwHthc9ek0Y
 yhVtZ+91HhgElqGY20RS93xgnu69wj3QbMtida0ta9XITvNriqYh6IVDn A==;
X-CSE-ConnectionGUID: 4p2dIDtSSIi7MKAaHHa/Bg==
X-CSE-MsgGUID: nftT4AfaSkqfwp/aetOoYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72930046"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="72930046"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 12:37:33 -0800
X-CSE-ConnectionGUID: 5xKMNQj/RXqIxfi+JHzOiw==
X-CSE-MsgGUID: CDT+lbhSRJWURzq/rqXVIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="221380470"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.205.222])
 by fmviesa004.fm.intel.com with ESMTP; 04 Mar 2026 12:37:33 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
Date: Wed,  4 Mar 2026 12:32:30 -0800
Message-Id: <20260304203230.1955266-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303010047.1925589-1-dongwon.kim@intel.com>
References: <20260303010047.1925589-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

v2: - Corrected virtio_gpu_fini_udmabuf in stub
      (Alex Bennée)

    - Make sure that qemu dmabuf has at least one plane before
      Comparing fds
      (Marc-André Lureau)

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/hw/virtio/virtio-gpu.h        |  3 ++-
 hw/display/virtio-gpu-udmabuf-stubs.c |  2 +-
 hw/display/virtio-gpu-udmabuf.c       | 27 ++++++++++++++++++++-------
 hw/display/virtio-gpu.c               |  2 +-
 4 files changed, 24 insertions(+), 10 deletions(-)

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
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-udmabuf-stubs.c
index f692e13510..85d03935a3 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-udmabuf-stubs.c
@@ -12,7 +12,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     /* nothing (stub) */
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
 }
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d804f321aa..74b6a7766a 100644
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
@@ -169,6 +162,26 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
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
+        if (dmabuf &&
+            qemu_dmabuf_get_num_planes(dmabuf->buf) > 0 &&
+            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] == res->dmabuf_fd &&
+            res->dmabuf_fd != -1) {
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


