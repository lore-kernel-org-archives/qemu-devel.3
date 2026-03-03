Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B5EDA687
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRVC-0005TI-Gy; Tue, 03 Mar 2026 10:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRUO-0004yi-Hx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:16:55 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRUM-00057U-V2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:16:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772550988; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IvL7c7hytdepdOdx2JApjbzGjRdRu0v93SrjiA98ED0RPVwlRgpbIMDtQEKgEd9WL1DXwF9PczPNAL1Bd/E3lP3yHv88Dz7rNNmuxUh0M2KGjsyA8oBKtez2zEIwU6k0gWBQQwtm2LVL/ka9JicXhPmtaUPuiQAaXZyfcLpqBD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772550988;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bMwxJstP0hMCHYqXn9DB2chRRtPs9Bd/G3zSjWfkIw0=; 
 b=HWdwHmgU6x3dM1y4pyU2FUVOKIeaUfjm+dcmWR+I+BPTRwra3lKvOxuhZA1fkE8x7ozy3qNnPYhhB6p/HmhRtpKCBLtaELmA7IpgtfnqmQFQI1Ppiqc7ly9yeVlPGbT9oWexgnzbtTOpPmE/3IeJmtnpQNcosJYYMJqFg36icYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772550988; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=bMwxJstP0hMCHYqXn9DB2chRRtPs9Bd/G3zSjWfkIw0=;
 b=Camjsnb5jwWnCs42OCYq2rFfPH0f+XO1z7fwfpaBkZKBCdcAtyAFVmVwQ4/56Ldy
 QDBPX1Eb/bb3FsFJYtI8ifz7c3n/Zs45MsOnuzuILJbL16SeItDx9u3nlzllsCja5gS
 mrkBTjdTd3yOwY/fdyvtzGL211G+W9Y7e7j8rnBE=
Received: by mx.zohomail.com with SMTPS id 1772550985627999.8921776254057;
 Tue, 3 Mar 2026 07:16:25 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v22 07/18] virtio-gpu: Ensure BHs are invoked only from
 main-loop thread
Date: Tue,  3 Mar 2026 18:14:10 +0300
Message-ID: <20260303151422.977399-8-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/display/virtio-gpu-virgl.c |  6 +++---
 hw/display/virtio-gpu.c       |  6 +++---
 hw/virtio/virtio.c            | 10 ++++++++++
 include/hw/virtio/virtio.h    | 10 ++++++++++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0f754829fb71..10c4b5160f40 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1203,9 +1203,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
index 643e91ca2a7a..38c922e4eba3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1526,9 +1526,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
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
index e9d553295257..7c4868330752 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4497,3 +4497,13 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
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
index 9dd93cf965ae..6fb823f241fd 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -547,4 +547,14 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
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
2.52.0


