Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E303C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQdc-0005Aw-Mu; Sun, 26 May 2024 23:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdb-0005Aa-EA
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:03 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdZ-0002GY-PY
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716778980;
 bh=4YQPDegC/uo6rCutQTFXZ9/NrBsVExasOCkbb0VwV7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JUCMmdxixa7hGjouGDQLs8rqwHpOeCY0m4+CsBMiMBmMdkpWL4J2zbESUwnb5oOnN
 IimuL9O8Df+Qp7FLubT9byOBme+H3hIcL+8suK0N+Yppd50kpcADFOmvtdG4yk0shR
 X5Ka4mb4x3LVxx9Wa8vD+8cm60yPEGa7RG/4VZ0SOp+65vH45yKUdDDLN0ExVEmTWV
 AJ0hhsjuMq6P/zrhQ4r2PFB1OGNm2alH5JBaBukApXdkEGQ4e8D7dl5hkeHseEm+gc
 UgSDhTa49Nk1JsNxZ/yO1hz2WJ+AYdUEy7imN95Er5K5QEGhhsUcRkQYk1nEj0eezG
 vUYmGwG7tlIVA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id B2E08378206B;
 Mon, 27 May 2024 03:02:58 +0000 (UTC)
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
Subject: [PATCH v13 01/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
Date: Mon, 27 May 2024 06:02:21 +0300
Message-ID: <20240527030233.3775514-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/display/virtio-gpu-virgl.c  | 8 +++++---
 include/hw/virtio/virtio-gpu.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9f34d0e6619c..7239a9f8e066 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -594,11 +594,12 @@ static void virtio_gpu_print_stats(void *opaque)
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
 
@@ -626,6 +627,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
     uint32_t flags = 0;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
@@ -645,8 +647,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         return ret;
     }
 
-    g->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                 virtio_gpu_fence_poll, g);
+    gl->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                  virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a7a..bc69fd78a440 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -196,7 +196,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
 
     uint32_t inflight;
@@ -231,6 +230,8 @@ struct VirtIOGPUGL {
 
     bool renderer_inited;
     bool renderer_reset;
+
+    QEMUTimer *fence_poll;
 };
 
 struct VhostUserGPU {
-- 
2.44.0


