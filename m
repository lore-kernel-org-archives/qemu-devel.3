Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849F7C10F1A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 20:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3M0t-0007MN-1P; Sat, 04 May 2024 16:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0l-0007LA-OC
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:35 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0k-0005U0-7h
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714854571;
 bh=3bQCBHzTAYsqEJFg3UkbvZGLZxQ6fvJwm6Hfq6oVsPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YOEFLtxTSRgfMzCC1AoxBt+t/JuvW5e0RBBdqBLHhmkpFu7YnqFvyUUFe1JL1kn5T
 Dca6oz83+q38XmwXX14UIA5fA50xDl8PdYEF0V+7L3Y5ztyY258bD9lSnTzVqbdXpB
 nDNk2+hATKx4BIZb2WisxsjpjVTI1z1Q7yZM/sL0/DY4N8DrxPFrVtvl0Bt3ahK5jA
 ZbnZFLeJ/ge3h3iKiiJ5TFviTmgK1K3b4KXaDAEBapQH30yP9flSVu1iS8FMJTfzDU
 XsZYxEev/HdN7QCkbfeZNhQQ2sBnsdyjxT1/c9BqL27/BsQzYisgwsVkmvOytVrXTY
 hnE7KrQU2oy4Q==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9335B378205D;
 Sat,  4 May 2024 20:29:29 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
Subject: [PATCH v10 01/10] virtio-gpu: Unrealize GL device
Date: Sat,  4 May 2024 23:28:25 +0300
Message-ID: <20240504202834.399780-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Even though GL GPU doesn't support hotplugging today, free virgl
resources when GL device is unrealized. For consistency.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     | 11 +++++++++++
 hw/display/virtio-gpu-virgl.c  |  9 +++++++++
 include/hw/virtio/virtio-gpu.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index e06be60dfbfc..0c0a8d136954 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -136,6 +136,16 @@ static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
+
+    if (gl->renderer_inited) {
+        virtio_gpu_virgl_deinit(g);
+    }
+}
+
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -149,6 +159,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
     vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
 
     vdc->realize = virtio_gpu_gl_device_realize;
+    vdc->unrealize = virtio_gpu_gl_device_unrealize;
     vdc->reset = virtio_gpu_gl_reset;
     device_class_set_props(dc, virtio_gpu_gl_properties);
 }
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9f34d0e6619c..b0500eccf8e0 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -665,3 +665,12 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
 
     return capset2_max_ver ? 2 : 1;
 }
+
+void virtio_gpu_virgl_deinit(VirtIOGPU *g)
+{
+    if (g->fence_poll) {
+        timer_free(g->fence_poll);
+    }
+
+    virgl_renderer_cleanup(NULL);
+}
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b34..b657187159d9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -336,6 +336,7 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
+void virtio_gpu_virgl_deinit(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
 
 #endif
-- 
2.44.0


