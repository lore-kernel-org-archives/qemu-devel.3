Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F02BC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 21:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8o50-0005G9-C7; Sun, 19 May 2024 17:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s8o4y-0005Fq-Gf
 for qemu-devel@nongnu.org; Sun, 19 May 2024 17:28:28 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s8o4j-0003Ng-3p
 for qemu-devel@nongnu.org; Sun, 19 May 2024 17:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716154092;
 bh=b9a/oqAdN6/3rkkIGPFydYeOna5iI9UlN+lbfrG8JQo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V3J/O56OfR2T0O8j7mwZ4Ltl6Q4N+v8ZrYMpZ38bWkeducwTyEaaMEOpg5sX9T0Ho
 /N+9/AYFYEIEUHZjg+Q/68/6F+DBGxSJhd+XHfYqhuJbRZzRPCO73kSO0kukMt51HZ
 2umdXzJKBkpptbg3OG/2iZC+xPMcdGIpVvrzGQoaQpOFVqqAzows7dHbJojipEDNkJ
 V1pL2nhf9lYZ866ulPVPYFr9SeICdSbIwAELt1CwieJ983KxNWud0DqQ5sqBquf/Uz
 NATDPYq5krOb4+hR0LLIMklWdd+arYMnCVflvhmXLvBJrXNAa8YIatXRv2aSQrQXD0
 gcn244qEhTW1g==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1ABF237820AB;
 Sun, 19 May 2024 21:28:10 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v12 10/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
Date: Mon, 20 May 2024 00:27:09 +0300
Message-ID: <20240519212712.2605419-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move fence_poll timer to VirtIOGPUGL for consistency with cmdq_resume_bh
that are used only by GL device.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 9 +++++----
 include/hw/virtio/virtio-gpu.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 63a5a983aad6..c8b25a0f5d7c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1089,11 +1089,12 @@ static void virtio_gpu_print_stats(void *opaque)
 static void virtio_gpu_fence_poll(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
-        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
+        timer_mod(gl->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
     }
 }
 
@@ -1141,8 +1142,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         return ret;
     }
 
-    g->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                 virtio_gpu_fence_poll, g);
+    gl->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                  virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
@@ -1176,6 +1177,6 @@ void virtio_gpu_virgl_deinit(VirtIOGPU *g)
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         timer_free(g->print_stats);
     }
-    timer_free(g->fence_poll);
+    timer_free(gl->fence_poll);
     virgl_renderer_cleanup(NULL);
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f3c8014acc80..529c34481158 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -195,7 +195,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
 
     uint32_t inflight;
@@ -233,6 +232,7 @@ struct VirtIOGPUGL {
     bool renderer_init_failed;
 
     QEMUBH *cmdq_resume_bh;
+    QEMUTimer *fence_poll;
 };
 
 struct VhostUserGPU {
-- 
2.44.0


