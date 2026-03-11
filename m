Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241B21125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LAx-0006rO-O4; Wed, 11 Mar 2026 11:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L7p-0000mB-9G; Wed, 11 Mar 2026 11:05:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L7n-0004cY-3K; Wed, 11 Mar 2026 11:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241305; bh=M9A7oOaWz0cwmh8/2A4pxaQ3GJewcei2wJIvO1Wo9ks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aJqeAfwJ+iVHUBf9hCj4NKgF196d00dnwR0oFEToqCPvIl6JPu3yKB3jaT/YYMmp0
 n4dG1lTX+D96TAdadhUTxanUvp6xk/IJQPUripCq/qhKrSxGPiKzoiEsQjdlXRVzK6
 RGe2/qsP7fYq1501WF91vUUSRRWtXIBxIBof99xTroAldf36newCXajrgliXYi/UXj
 OlW2ujGNN/PdFgVzthkHZ2nKvi2jE//rkc10lYAf2n1BX6UKVH5XzXRMnDN/D4UZQn
 +/pEI1GC8cPEWEdrwKgFMMK060v9bAR1Zt0tQkTVHwbUozvi+4lA5fSmls9mlYazTT
 avrUroVg6pS/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE119191E62;
 Wed, 11 Mar 2026 18:01:45 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DADF637C2B4;
 Wed, 11 Mar 2026 18:02:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 36/44] virtio-gpu: Ensure BHs are invoked only from
 main-loop thread
Date: Wed, 11 Mar 2026 18:02:08 +0300
Message-ID: <20260311150221.1084186-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

QEMU's display GL core is tied to main-loop thread and virtio-gpu
interacts with display while processing GPU commands. Virtio-gpu BHs
work in generic AIO context that can be invoked on vCPU thread, while
GL and UI toolkits are bound to the main-loop thread.

Make virtio-gpu BHs use iohandler AIO context that is handled in a
main-loop thread only.

 0  SDL_GL_MakeCurrent() (libSDL3)
 1  SDL_GL_MakeCurrent_REAL() (libSDL2)
 2  sdl2_gl_make_context_current() (ui/sdl2-gl.c:201)
 3  make_current() (virglrenderer.c:639)
 4  vrend_finish_context_switch() (vrend_renderer.c:11630)
 5  vrend_hw_switch_context() (vrend_renderer.c:11613)
 6  vrend_renderer_force_ctx_0() (vrend_renderer.c:12986)
 7  virgl_renderer_force_ctx_0() (virglrenderer.c:460)
 8  virtio_gpu_virgl_process_cmd() (virtio-gpu-virgl.c:1013)
 9  virtio_gpu_process_cmdq() (virtio-gpu.c:1050)
 10 virtio_gpu_gl_handle_ctrl() (virtio-gpu-gl.c:86)
 11 aio_bh_poll() (util/async.c)
 12 aio_poll() (util/aio-posix.c)
 13 blk_pwrite() (block/block-gen.c:1985)
 14 pflash_update() (pflash_cfi01.c:396)
 15 pflash_write() (pflash_cfi01.c:541)
 16 memory_region_dispatch_write() (system/memory.c:1554)
 17 flatview_write() (system/physmem.c:3333)
 18 address_space_write() (system/physmem.c:3453)
 19 kvm_cpu_exec() (accel/kvm/kall-all.c:3248)
 20 kvm_vcpu_thread_fn() (accel/kvm/kaccel-ops.c:53)

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-8-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 235f9b36383e4cc7a790bca51eddbe38edd5438c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 362828f54e..a65fca9c62 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1199,9 +1199,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 
 #if VIRGL_VERSION_MAJOR >= 1
-    gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
-                                    virtio_gpu_virgl_resume_cmdq_bh,
-                                    g);
+    gl->cmdq_resume_bh = virtio_bh_io_new_guarded(DEVICE(g),
+                                                  virtio_gpu_virgl_resume_cmdq_bh,
+                                                  g);
 #endif
 
     return 0;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 11a7a85750..7ab5221fbc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1514,9 +1514,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     g->ctrl_vq = virtio_get_queue(vdev, 0);
     g->cursor_vq = virtio_get_queue(vdev, 1);
-    g->ctrl_bh = virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
-    g->cursor_bh = virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g);
-    g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
+    g->ctrl_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
+    g->cursor_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_cursor_bh, g);
+    g->reset_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_reset_bh, g);
     qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b756f49867..34ef7b86d9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4403,3 +4403,13 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
     return qemu_bh_new_full(cb, opaque, name,
                             &transport->mem_reentrancy_guard);
 }
+
+QEMUBH *virtio_bh_io_new_guarded_full(DeviceState *dev,
+                                      QEMUBHFunc *cb, void *opaque,
+                                      const char *name)
+{
+    DeviceState *transport = qdev_get_parent_bus(dev)->parent;
+
+    return aio_bh_new_full(iohandler_get_aio_context(), cb, opaque, name,
+                           &transport->mem_reentrancy_guard);
+}
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 14c2afed33..d6c9fdf0e0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -543,4 +543,14 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
 #define virtio_bh_new_guarded(dev, cb, opaque) \
     virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
 
+/*
+ * The "_io" variant runs BH only on a main-loop thread, while generic BH
+ * may run on a vCPU thread.
+ */
+QEMUBH *virtio_bh_io_new_guarded_full(DeviceState *dev,
+                                      QEMUBHFunc *cb, void *opaque,
+                                      const char *name);
+#define virtio_bh_io_new_guarded(dev, cb, opaque) \
+    virtio_bh_io_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
+
 #endif
-- 
2.47.3


