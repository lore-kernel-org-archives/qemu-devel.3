Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5BE9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSzF-0008CS-Ig; Tue, 17 Feb 2026 16:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsSz9-0008B9-7x
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:51:59 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsSz7-0001Nr-Iv
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:51:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771365102; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eO8Z8AdRan8hhZBslZiw7qiauM38VqkAdaAW+NpnlO0MgPqriNFhU9nJgG/KfBbWf5h80Wxt9/1k0n/GAoYikwKRe+P6KnB6QLD+f8tXvXzYb7eJ7OnEME2abCJLKI+GmSQkj3gLqHx6dBlo6GLVqdy9npFvxlj4rpoPUsdUjeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771365102;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aQaG6nS4+RzGmjU/24LUpRpZp6FwJ6sMEExKWN7vBb0=; 
 b=N5zXHeDMMkZihv5MvXaINcMqGOX0q1Z4gnELwYJuACVxr8kFmQUg0TDqVmhZUa/BdCUIiZA+ieDuDiD45JvDit0gW+5SXDWHFX+PzbLGWUf5U/9/qNvPPSWWXqfysLeOmOAnIBOAvFD46hMNll04LPsntGoiWPRFhV41rT5SdPQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771365102; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=aQaG6nS4+RzGmjU/24LUpRpZp6FwJ6sMEExKWN7vBb0=;
 b=BcWq5pMJzJEUgRRwQ2R8JVVbArzQGoKQzvmmKhyeyruIbu2wubfDpbojfN/ZcRDr
 RrMhEKvPDYQMR0VggCqCfFImNG9aH3aSuvG9ni8zYo/DokvwznTSNn30mroeRWsb7I5
 jyMaM2zVAj9uguF9DYTgI9Ak37VCYJqiRW9mR9co=
Received: by mx.zohomail.com with SMTPS id 1771365099824327.5905637389625;
 Tue, 17 Feb 2026 13:51:39 -0800 (PST)
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
Subject: [PATCH v18 04/19] ui/sdl2: Unset context after GL operations
Date: Wed, 18 Feb 2026 00:49:13 +0300
Message-ID: <20260217214928.2970885-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
References: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

VirtIO-GPU commands may be processed outside of main-loop, from a CPU
thread. This results in GL context switch failure because context is held
by main-loop thread when GL is invoked from CPU thread. Always release GL
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
 ui/sdl2-gl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 55e22a7a3d59..936b15f737d8 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -57,6 +57,8 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
 
     surface_gl_render_texture(scon->gls, scon->surface);
     SDL_GL_SwapWindow(scon->real_window);
+
+    SDL_GL_MakeCurrent(scon->real_window, NULL);
 }
 
 void sdl2_gl_update(DisplayChangeListener *dcl,
@@ -73,6 +75,8 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
     scon->updates++;
+
+    SDL_GL_MakeCurrent(scon->real_window, NULL);
 }
 
 void sdl2_gl_switch(DisplayChangeListener *dcl,
@@ -91,6 +95,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
     if (surface_is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
         qemu_gl_fini_shader(scon->gls);
         scon->gls = NULL;
+        SDL_GL_MakeCurrent(scon->real_window, NULL);
         sdl2_window_destroy(scon);
         return;
     }
@@ -105,6 +110,8 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
     }
 
     surface_gl_create_texture(scon->gls, scon->surface);
+
+    SDL_GL_MakeCurrent(scon->real_window, NULL);
 }
 
 void sdl2_gl_refresh(DisplayChangeListener *dcl)
-- 
2.52.0


