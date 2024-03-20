Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E35BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2uq-0006qE-KV; Wed, 20 Mar 2024 16:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2un-0006pA-KQ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:52:01 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2ul-0004VV-Tj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710967920; x=1742503920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CVxup2GfKsbv1zvZ7npDH2anHuHqKqtF8wfEpZWZZaQ=;
 b=lT7H6MizOhUo4CkE2IewhVg+F/jniW05oanEGtZyZ2DDrV3Y8C9fEmQH
 Zks74gW/+ASgvjVKZwHZ8w3IPTFIST/3XT9ZDQk2BEuiuygMQPpsmNxBg
 4/+wM2s9gLGr6s21BimOt5HLruYXLMAhGeeuBLM9LcfEVGgaRXTOoueor
 aaKA52N6vpnm2r4Uq0ChdXMmmzT+9BSl1OSrywb1LIhsF6lsBpXd6eHUw
 ioqesQw6VZrFHVuFSLp/2fyCXpLEXyjOnDyWK4CfIGaDBPA1d1VvHKAHK
 WAhOCAYGzO5g45kkyacbanplZFQmfmfvazZ5T1Soe58AOQoNo747ORznZ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16463564"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="16463564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 13:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="14679715"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2024 13:51:54 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 1/3] hw/virtio: initialize QemuDmaBuf using the function from
 ui/console
Date: Wed, 20 Mar 2024 13:50:16 -0700
Message-Id: <20240320205018.3351984-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320205018.3351984-1-dongwon.kim@intel.com>
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

QemuDmaBuf is an abstraction of dmabuf specifically for ui/console usage.
To enhance safety and maintainability, it is needed to centralizes its
creation and initialization within ui/console using newly introduced methods.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu-udmabuf.c | 27 +++++++++++----------------
 include/hw/virtio/virtio-gpu.h  |  2 +-
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d51184d658..dde6c8e9d9 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -162,7 +162,7 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     struct virtio_gpu_scanout *scanout;
 
     scanout = &g->parent_obj.scanout[dmabuf->scanout_id];
-    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
+    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
     QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
     g_free(dmabuf);
 }
@@ -181,17 +181,10 @@ static VGPUDMABuf
     }
 
     dmabuf = g_new0(VGPUDMABuf, 1);
-    dmabuf->buf.width = r->width;
-    dmabuf->buf.height = r->height;
-    dmabuf->buf.stride = fb->stride;
-    dmabuf->buf.x = r->x;
-    dmabuf->buf.y = r->y;
-    dmabuf->buf.backing_width = fb->width;
-    dmabuf->buf.backing_height = fb->height;
-    dmabuf->buf.fourcc = qemu_pixman_to_drm_format(fb->format);
-    dmabuf->buf.fd = res->dmabuf_fd;
-    dmabuf->buf.allow_fences = true;
-    dmabuf->buf.draw_submitted = false;
+    dmabuf->buf = dpy_gl_create_dmabuf(r->width, r->height, fb->stride,
+                                       r->x, r->y, fb->width, fb->height,
+                                       qemu_pixman_to_drm_format(fb->format),
+                                       0, res->dmabuf_fd, false);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
@@ -206,21 +199,23 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     VGPUDMABuf *new_primary, *old_primary = NULL;
+    uint32_t width, height;
 
     new_primary = virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
     if (!new_primary) {
         return -EINVAL;
     }
 
+    width = dpy_gl_dmabuf_get_width(new_primary->buf);
+    height = dpy_gl_dmabuf_get_height(new_primary->buf);
+
     if (g->dmabuf.primary[scanout_id]) {
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
     g->dmabuf.primary[scanout_id] = new_primary;
-    qemu_console_resize(scanout->con,
-                        new_primary->buf.width,
-                        new_primary->buf.height);
-    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
+    qemu_console_resize(scanout->con, width, height);
+    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
 
     if (old_primary) {
         virtio_gpu_free_dmabuf(g, old_primary);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b..010083e8e3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,7 +169,7 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
 
 typedef struct VGPUDMABuf {
-    QemuDmaBuf buf;
+    QemuDmaBuf *buf;
     uint32_t scanout_id;
     QTAILQ_ENTRY(VGPUDMABuf) next;
 } VGPUDMABuf;
-- 
2.34.1


