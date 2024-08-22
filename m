Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878E9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCwQ-0006R9-6N; Thu, 22 Aug 2024 14:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwO-0006Hd-Cn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:53:48 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwL-00047i-Ka
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352809; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ICZOjFB0obUN5NOKsIpRJa+QzepTw77AKnJ869ZWPXIjWIRrTyeeAGoD/v/cZWAJpV+I/dGEKU/uv39yZHAz6P4AaIAhMRo+DzyCod5by9LdQvzjLCze+UnMwKGBzSe5FAYX7jloZOQb/M+VUKuDEb0X+XYareQ3ZYcitj1m9SQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352809;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7xR9fSMJMKIYACVO3G4J6qfmpH4JFthFXE8ykwiHe3U=; 
 b=YHiPJskSySpH58lr1DqSBg4VubF9zfCl3UjhuDL/UQ21VFzDsJMf9NB0qcgwucaBoL/cODjwpXrgSRLl37IjKZQQaQ/7Q6o9dQwPf0+R7B6Rk30TjmjhJP5fXZmOOghxPZOom/nrOt3uqgYdpkirnluWxbfmaXHNdiQAt3dZ6k0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352809; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7xR9fSMJMKIYACVO3G4J6qfmpH4JFthFXE8ykwiHe3U=;
 b=OYAmzwnIyVmDvUyhiw9N0Cd3MExG66EtIGposQy/AadFyOcAnd8NX50Uygi4osgN
 fUySuxV3RN/DL1x+EmfaPOlkI3/VnqJqdAfixLIZCJRIDSnUPupm9FZ/ciAarUqRHOY
 xaf5ZQ9hiHtxCkTJWi8MOvyZOHjScM+DIB3jDoFU=
Received: by mx.zohomail.com with SMTPS id 1724352807902621.8137743079594;
 Thu, 22 Aug 2024 11:53:27 -0700 (PDT)
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
Subject: [PATCH v17 04/13] virtio-gpu: Handle virtio_gpu_virgl_init() failure
Date: Thu, 22 Aug 2024 21:51:00 +0300
Message-ID: <20240822185110.1757429-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

virtio_gpu_virgl_init() may fail, leading to a further Qemu crash
because Qemu assumes it never fails. Check virtio_gpu_virgl_init()
return code and don't execute virtio commands on error. Failed
virtio_gpu_virgl_init() will result in a timed out virtio commands
for a guest OS.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     | 30 ++++++++++++++++++++++--------
 include/hw/virtio/virtio-gpu.h | 11 +++++++++--
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 29d20b01321c..ea3413aa566f 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -29,9 +29,14 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
                                              struct virtio_gpu_scanout *s,
                                              uint32_t resource_id)
 {
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     uint32_t width, height;
     uint32_t pixels, *data;
 
+    if (gl->renderer_state != RS_INITED) {
+        return;
+    }
+
     data = virgl_renderer_get_cursor_data(resource_id, &width, &height);
     if (!data) {
         return;
@@ -65,13 +70,22 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
 
-    if (!gl->renderer_inited) {
-        virtio_gpu_virgl_init(g);
-        gl->renderer_inited = true;
-    }
-    if (gl->renderer_reset) {
-        gl->renderer_reset = false;
+    switch (gl->renderer_state) {
+    case RS_RESET:
         virtio_gpu_virgl_reset(g);
+        /* fallthrough */
+    case RS_START:
+        if (virtio_gpu_virgl_init(g)) {
+            gl->renderer_state = RS_INIT_FAILED;
+            return;
+        }
+
+        gl->renderer_state = RS_INITED;
+        break;
+    case RS_INIT_FAILED:
+        return;
+    case RS_INITED:
+        break;
     }
 
     cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
@@ -98,9 +112,9 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
      * GL functions must be called with the associated GL context in main
      * thread, and when the renderer is unblocked.
      */
-    if (gl->renderer_inited && !gl->renderer_reset) {
+    if (gl->renderer_state == RS_INITED) {
         virtio_gpu_virgl_reset_scanout(g);
-        gl->renderer_reset = true;
+        gl->renderer_state = RS_RESET;
     }
 }
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7ff989a45a5c..6e71d799e5da 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -224,11 +224,18 @@ struct VirtIOGPUClass {
                              Error **errp);
 };
 
+/* VirtIOGPUGL renderer states */
+typedef enum {
+    RS_START,       /* starting state */
+    RS_INIT_FAILED, /* failed initialisation */
+    RS_INITED,      /* initialised and working */
+    RS_RESET,       /* inited and reset pending, moves to start after reset */
+} RenderState;
+
 struct VirtIOGPUGL {
     struct VirtIOGPU parent_obj;
 
-    bool renderer_inited;
-    bool renderer_reset;
+    RenderState renderer_state;
 
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
-- 
2.45.2


