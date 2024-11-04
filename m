Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD3D1BDC5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80Kz-00055g-5p; Mon, 04 Nov 2024 11:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t80Kw-00053L-Uu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:55 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t80Kv-0004gu-0P
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:54 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9e71401844so407986166b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730739231; x=1731344031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/So9pG2LMx/q/DZBv0lbwhuc0H7Ruhh4U8wSoq6I6Q=;
 b=JGD77aLxiTATihHVqtwjUAFX1DJsuLKfnQyG+JUFqFU8j4Z4LyAyclngTG9oBhZRTN
 pPbPJIe7yshSMl6WlIl2qi4jZOOdhIHSy5Vy0WkQUtnUgcDaDYqHVlXq9eSzV1QSzzYG
 YstVnVirH1RM4bs0fTuiOPiqxcw+RQG6I96blXsLSJ43bzUCwD3Lwk2J4TTWV1kY4LqE
 uZ6C7O++9xnDHr3DRP/6WtjqgPw3yDRXrT9DsgkQRjIOM43GVH9+MGlmKEfHILWDl2c/
 NMxBs3Wv3I6ZZeUprpAezONKaO4xxnU4lHuBSFKh4wt2W0yXm4T0SwLigsRMp1SHa1FX
 vYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739231; x=1731344031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/So9pG2LMx/q/DZBv0lbwhuc0H7Ruhh4U8wSoq6I6Q=;
 b=XjGUR/5QZ2tV2yrYUx5bFt2SlSMJqtnnyCcZJvvC8mv/JKXI2iySgnlGCVE5CRYOD7
 meZ5orD1jT4elsH0ozztwuM1RT1zLLhCbDiY8OQxjtwZZBeTtd3u1VlaXI9/pzNRg7gE
 oyC7r4oBX3TLlqq2l81m50zZbgwcIW3g4RJOQCWshwhZtsNmAyFReCQNM083Rnu+XgFC
 Nds/Zwk9Na+XN6kyNdFCxEXl2kGaBWaNpQMW7byTeOX+0luP5mo644hCS714N6byq4Fp
 N5dGLVuEn8Wn3KirvBg7akQxAeZeOUieCnbEdVd5Zzf+5n1yguJUJIZ7BBIJ1HdQjQxW
 AokA==
X-Gm-Message-State: AOJu0YyTL+YEZlFKHnFnGZGIzcQE2+Zi7vmyuds+JHfTLbvIR/UxzVf5
 TwUTvq5FtxhiUAnt5qSN1CJIOh+lmd8CTIcEFLd35aqkhYQ/e5AwpWjK3f4JFKI=
X-Google-Smtp-Source: AGHT+IGCIaxv2lVKYUjomKt0+f3XwzvK81uFVdX0WMZFohPZIOSkftMgQ4lP42i9BlYHP5ayj8vDfQ==
X-Received: by 2002:a17:906:dc95:b0:a99:f77f:b489 with SMTP id
 a640c23a62f3a-a9e50b9430cmr1474837866b.43.1730739231320; 
 Mon, 04 Nov 2024 08:53:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17f93f9sm4047066b.163.2024.11.04.08.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:53:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 621F85F89E;
 Mon,  4 Nov 2024 16:53:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 1/2] hw/display: factor out the scanout blob to fb conversion
Date: Mon,  4 Nov 2024 16:53:47 +0000
Message-Id: <20241104165348.2361299-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241104165348.2361299-1-alex.bennee@linaro.org>
References: <20241104165348.2361299-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

There are two identical sequences of a code doing the same thing that
raise warnings with Coverity. Before fixing those issues lets factor
out the common code into a helper function we can share.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/hw/virtio/virtio-gpu.h | 15 +++++++++
 hw/display/virtio-gpu-virgl.c  | 21 +-----------
 hw/display/virtio-gpu.c        | 60 +++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 553799b8cc..90e4abe788 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -333,6 +333,21 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id);
 
+/**
+ * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
+ * fb: the frame-buffer descriptor to fill out
+ * ss: the scanout blob data
+ * blob_size: the maximum size the blob can accommodate
+ *
+ * This will check we have enough space for the frame taking into
+ * account that stride for all but the last line.
+ *
+ * Returns true on success, otherwise logs guest error and returns false
+ */
+bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
+                                   struct virtio_gpu_set_scanout_blob *ss,
+                                   uint64_t blob_size);
+
 /* virtio-gpu-udmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index eedae7357f..35599cddab 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -852,26 +852,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
         return;
     }
 
-    fb.format = virtio_gpu_get_pixman_format(ss.format);
-    if (!fb.format) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: pixel format not supported %d\n",
-                      __func__, ss.format);
-        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
-        return;
-    }
-
-    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
-    fb.width = ss.width;
-    fb.height = ss.height;
-    fb.stride = ss.strides[0];
-    fb.offset = ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
-
-    fbend = fb.offset;
-    fbend += fb.stride * (ss.r.height - 1);
-    fbend += fb.bytes_pp * ss.r.width;
-    if (fbend > res->base.blob_size) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
-                      __func__);
+    if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size)) {
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c0570ef856..e7ca8fd1cf 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -721,13 +721,48 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
                               &fb, res, &ss.r, &cmd->error);
 }
 
+bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
+                                   struct virtio_gpu_set_scanout_blob *ss,
+                                   uint64_t blob_size)
+{
+    uint64_t fbend;
+
+    fb->format = virtio_gpu_get_pixman_format(ss->format);
+    if (!fb->format) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: host couldn't handle guest format %d\n",
+                      __func__, ss->format);
+        return false;
+    }
+
+    fb->bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
+    fb->width = ss->width;
+    fb->height = ss->height;
+    fb->stride = ss->strides[0];
+    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
+
+    fbend = fb->offset;
+    fbend += fb->stride * (ss->r.height - 1);
+    fbend += fb->bytes_pp * ss->r.width;
+
+    if (fbend > blob_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: fb end out of range\n",
+                      __func__);
+        return false;
+    }
+
+    return true;
+}
+
+
+
 static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
                                         struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_framebuffer fb = { 0 };
     struct virtio_gpu_set_scanout_blob ss;
-    uint64_t fbend;
 
     VIRTIO_GPU_FILL_CMD(ss);
     virtio_gpu_scanout_blob_bswap(&ss);
@@ -753,28 +788,7 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
         return;
     }
 
-    fb.format = virtio_gpu_get_pixman_format(ss.format);
-    if (!fb.format) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: host couldn't handle guest format %d\n",
-                      __func__, ss.format);
-        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
-        return;
-    }
-
-    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
-    fb.width = ss.width;
-    fb.height = ss.height;
-    fb.stride = ss.strides[0];
-    fb.offset = ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
-
-    fbend = fb.offset;
-    fbend += fb.stride * (ss.r.height - 1);
-    fbend += fb.bytes_pp * ss.r.width;
-    if (fbend > res->blob_size) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: fb end out of range\n",
-                      __func__);
+    if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size)) {
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
-- 
2.39.5


