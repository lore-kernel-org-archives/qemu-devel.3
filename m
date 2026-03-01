Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164ADFD0075
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 20:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwnkt-0003Bj-Mw; Sun, 01 Mar 2026 15:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnkN-0002qc-RV
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:50:45 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnkI-0002Ex-5X
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:50:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772398202; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RX6zKStjgRSh2s9z9EVn/Sy4odcD79+Ym42aU0BpRjZrHFqwzSZb13lmuSGI66SXSPlBsYM+OYSNMYJPr3fO6t5VNCGUin8n+BeTqbyd5kGXRMQkrVm3/zzbO1cfmNbTKT8UP/sq4TJtUOK1otLPCI3p42krNGa7UfTSjjNiAiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772398202;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=j8DPUxwCNH3p3vQdvPZVH2WkbBB65dwd9HOII4I6ibI=; 
 b=dmPJ1zRDY4Uh9+rPtH/0tbiqkZu+SCbreU5gciuAvZkRi/D8L0xs0SqL32oJ/xmVHE/TyjfG7GhZNXRi081dCHbDxde8MJBa91XSJ0DqPTziuMSA9Wy1w5gwSgNZIfGyCP9CxZruY9bSA1+FnDMGzYH3iunQjGKel0bAftB/ND0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772398202; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=j8DPUxwCNH3p3vQdvPZVH2WkbBB65dwd9HOII4I6ibI=;
 b=TvYd/ynOCI9CZ4VGvB38QegOB7ScMkRhajLUv+6OLFxtiZvmtvBxYYTdFHxXISl+
 LCMhjOKaT0BXws8uZsPNkD6jyAob4y91mn39sYAf6VCds8fipsh2zeE2xA/zPjzATEM
 31ICiaHhqQILXYb9jsedJ7PP0TE8AQTq8P4YiPjA=
Received: by mx.zohomail.com with SMTPS id 1772398200233167.35102191004364;
 Sun, 1 Mar 2026 12:50:00 -0800 (PST)
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
Subject: [PATCH v20 10/21] virtio-gpu: Bounce virtio_gpu_ctrl_bh() to
 main-loop thread
Date: Sun,  1 Mar 2026 23:48:27 +0300
Message-ID: <20260301204838.596994-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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
interacts with display while processing GPU commands. virtio_gpu_ctrl_bh()
works in generic AIO context that can be processed from vCPU thread, while
GL and UI toolkits are bound to the main-loop thread. Bounce the ctrl-bh
execution if running from a thread other than main to fix the problem.

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
 hw/display/virtio-gpu.c        | 12 +++++++++++-
 include/hw/virtio/virtio-gpu.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a7a..d0737cbba8a2 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1126,7 +1126,16 @@ static void virtio_gpu_ctrl_bh(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
 
-    vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
+    /*
+     * Bounce handling to main-loop thread as display UI toolkit
+     * and GL context are bounded there.
+     */
+    if (qemu_get_thread_id() == g->thread_id) {
+        vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
+    } else {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                virtio_gpu_ctrl_bh, g);
+    }
 }
 
 static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
@@ -1533,6 +1542,7 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
+    g->thread_id = qemu_get_thread_id();
 }
 
 static void virtio_gpu_device_unrealize(DeviceState *qdev)
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda65..d3bd8ed0d28a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -218,6 +218,8 @@ struct VirtIOGPU {
     } dmabuf;
 
     GArray *capset_ids;
+
+    int thread_id;
 };
 
 struct VirtIOGPUClass {
-- 
2.52.0


