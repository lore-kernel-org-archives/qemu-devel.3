Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4822BC531F3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 00:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtEGc-0005pE-O7; Thu, 19 Feb 2026 19:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEGa-0005mM-Sw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:21:08 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEGZ-0004qb-BD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:21:08 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771546853; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DWuwafLxDGuToFaKfrxJAom5m7nB41DvtdfA6sC1XYJb5u001k2oh6MjN9ag/HSDN81I9dIlJ4aegpDFPgwR0HYY1+FcTh3W9Z7TRUAlGAyyk54zHqJMRYU5PJV0CjTmAPkD3Q13PUdI01WtuM+20Yj8IdVAtfGO98iB+dyFxA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771546853;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CspB7o3E5B439g+HkHN/aNXcXe/JfBdX2Q3Io9UegqA=; 
 b=PSsCnMWRs3mFKZO6oocJQxamTdGlUcKLYVNtMFQ9FZUER68nNdTNSACgYoZZDXHBBpnbAT6D7tapnQpSw+kGzi5G5j/Cy8q17bzs3U9oyAC2Ny18kfLw2LoRU/041HNd2fiwCI8nBXba805YhJmZjrhAv1UW3tF0Fil7IhulZks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771546853; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=CspB7o3E5B439g+HkHN/aNXcXe/JfBdX2Q3Io9UegqA=;
 b=KL5sJfm7jE61zSUuvSRPt7cQL+bzjxlGls56xFioEpRpfCf4nSjfjqnlpQPIcJLq
 EaFKZPAtaaSk6EEgyhNaLxq1W64Ns0mqW4IPcSDbB7ePPQg36FUCU9S93XhsBkEP+d6
 JkB4uznw/QxqOTHCAGEiCPJ0YD35qlFPeUaYkOBU=
Received: by mx.zohomail.com with SMTPS id 1771546851724470.0839316553098;
 Thu, 19 Feb 2026 16:20:51 -0800 (PST)
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
Subject: [PATCH v19 08/20] virtio-gpu: Unbind context after GL operations
Date: Fri, 20 Feb 2026 03:16:22 +0300
Message-ID: <20260220001634.3579257-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
References: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

thread. This results in GL context switch failure because context is held
by main-loop thread when GL is invoked from CPU thread. Always unbind GL
context after performing GL operations such that other threads could take
over the context.

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

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0f754829fb71..b78870986d39 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -896,14 +896,20 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
 }
 #endif
 
-void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
+static void virtio_gpu_virgl_unbind_ctx(VirtIOGPU *g)
+{
+    /* Virglrender always uses first scanout for GL. */
+    dpy_gl_ctx_make_current(g->parent_obj.scanout[0].con, NULL);
+}
+
+static void
+virtio_gpu_virgl_process_cmd_with_ctx(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
-    virgl_renderer_force_ctx_0();
     switch (cmd->cmd_hdr.type) {
     case VIRTIO_GPU_CMD_CTX_CREATE:
         virgl_cmd_context_create(g, cmd);
@@ -1010,6 +1016,14 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 }
 
+void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
+                                  struct virtio_gpu_ctrl_command *cmd)
+{
+    virgl_renderer_force_ctx_0();
+    virtio_gpu_virgl_process_cmd_with_ctx(g, cmd);
+    virtio_gpu_virgl_unbind_ctx(g);
+}
+
 static void virgl_write_fence(void *opaque, uint32_t fence)
 {
     VirtIOGPU *g = opaque;
@@ -1136,8 +1150,10 @@ static void virtio_gpu_fence_poll(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+    virgl_renderer_force_ctx_0();
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
+    virtio_gpu_virgl_unbind_ctx(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
         timer_mod(gl->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
     }
-- 
2.52.0


