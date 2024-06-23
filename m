Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3220AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLP4g-0001yU-Qo; Sun, 23 Jun 2024 11:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sLP4e-0001y0-NT
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:24:12 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sLP4d-0003LU-54
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1719156250;
 bh=cnq4VVHrQIHCGXxk7mzyFjoWKnxeNwe2M3HWDizeihE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nGiL5PI/rJx0Iq8Xdt2rObQ0vYneiBaJg9+Xkk4Tr+djoj0H1kCAFnzUh4liUJSJI
 A51Hc4p7ef1X0CcBNtEd066lKuX6OfURUOEDghEQRdPtq0uL0/svPhijZlWfMSY0/4
 AE4NmUpjC3b2Qe96q343haSJa9nE1ORJbjxaaxHPZeBJ76OUOn4gw9LdqDWIz7xXUL
 dO/KFOaFg3+2l934VHZ6iAHdcDkAiRAdlKbba6f9WgzJs3ZSFZE+jMXJM2QvAnUybx
 dkQ11n1/RExkG/ESYmEmsf5k5+0lLAVBWuVt9wvX2MakH8sbOq+SH6RBqheNU2/KJH
 /Bz3kRTgM941w==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD35737804C8;
 Sun, 23 Jun 2024 15:24:07 +0000 (UTC)
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
Subject: [PATCH v16 05/13] virtio-gpu: Unrealize GL device
Date: Sun, 23 Jun 2024 18:23:35 +0300
Message-ID: <20240623152343.328436-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
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
 hw/display/virtio-gpu-gl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 21a1e9a05c5d..0109244276fc 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -150,6 +150,22 @@ static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
+
+    if (gl->renderer_state >= RS_INITED) {
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+            timer_free(gl->print_stats);
+        }
+        timer_free(gl->fence_poll);
+        virgl_renderer_cleanup(NULL);
+    }
+
+    gl->renderer_state = RS_START;
+}
+
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -163,6 +179,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
     vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
 
     vdc->realize = virtio_gpu_gl_device_realize;
+    vdc->unrealize = virtio_gpu_gl_device_unrealize;
     vdc->reset = virtio_gpu_gl_reset;
     device_class_set_props(dc, virtio_gpu_gl_properties);
 }
-- 
2.45.2


