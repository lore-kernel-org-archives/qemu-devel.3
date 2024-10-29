Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED550D2AB30
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3V-0004Z0-39; Tue, 29 Oct 2024 08:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3T-0004Yn-Q8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3S-0007Rt-59
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so3453531f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203832; x=1730808632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hV9bRORlikllwDGAZFR9/+PU9WimawpPGHP7OfCvCPA=;
 b=ElYp8KhdKz3DWg+8lsZsvpMmGg8Mdhdjym8tLBHzzl2//u6ef+HloMumst3EqHRPaS
 ZoMAzxDfjhy5PQ8B4jjYQCiwcT3BqSs+gp4F/3smLpI8XPtM0g6W3KReQyGaqIIB2el3
 5tJYNLICcDLzYKvWWg+nHmSm/yY7hqUxxkcbdImeripI5GAK4JKm1zrKQtxfgXCYP55P
 OOIQDt5EhRPrk/ILBePqnnN0Eu/BuMzofbfhoV0pLf0ecn7ZOA/X8ndwGZ+r0U4TBzEe
 mZNVLj0hGnPHPPBw/bqP07vihDv9ot/gq8VI0fUzL+NE6KRnvG97h6U82XrAS9WNl94T
 KElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203832; x=1730808632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hV9bRORlikllwDGAZFR9/+PU9WimawpPGHP7OfCvCPA=;
 b=XfyE9LNWpoOA9FROts5lrVO9JMyo8UDNCulvzQ5K8NoZ8n4CEbPnAqddpe8DgWmDF0
 AQxoqvM8PgUeToPnmA+JkCrJn5/jZ/UrAu352eSS0vbdtSroTeS1L4XhXWZc3G1WuW59
 6yI7OjV+dMq/DhL9ELJYZO7KLrJ3bg2/MuGEVQo6IEsJ8uYRjPSVDpf5nSgxKWwpVGfA
 kzUw7JdnFn+WVErthtLh4MBLFqe8fJWAQtFS1PJl5S7HZScMn4tqdjXNV5cbqKmx5eAE
 l7uPzGJMYeoNkxc07I2suDyen+Z95gdnL3gTmqG7W/fXV+UajlsJoNL9vhmEfccRGQ0T
 D7tw==
X-Gm-Message-State: AOJu0YzwafIIxMq5YJWg6Gbqpf0AjsGc1Y74gvNTQacMAG9ZmJS8w2Sr
 nH4nA+eItgnYc6AlHb1Q/nodm+W7tLyUl9LNMymk+VkR9+78LNCD/FosrUQnlkA=
X-Google-Smtp-Source: AGHT+IHQLA7fIJiqVOeqriyBOSdR9N5/LutdhMIjBZCRakAEoM38pKvwKwokVuNf5Muk/cencb41tA==
X-Received: by 2002:adf:e543:0:b0:37d:54d0:1f20 with SMTP id
 ffacd0b85a97d-38061158e30mr8505650f8f.24.1730203832597; 
 Tue, 29 Oct 2024 05:10:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b712bfsm12319579f8f.79.2024.10.29.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2D8B5FAA9;
 Tue, 29 Oct 2024 12:10:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 04/13] virtio-gpu: Handle virtio_gpu_virgl_init() failure
Date: Tue, 29 Oct 2024 12:10:21 +0000
Message-Id: <20241029121030.4007014-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

virtio_gpu_virgl_init() may fail, leading to a further Qemu crash
because Qemu assumes it never fails. Check virtio_gpu_virgl_init()
return code and don't execute virtio commands on error. Failed
virtio_gpu_virgl_init() will result in a timed out virtio commands
for a guest OS.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-5-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 18b6c3b3a2..71775243e9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -222,11 +222,18 @@ struct VirtIOGPUClass {
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
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 29d20b0132..ea3413aa56 100644
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
 
-- 
2.39.5


