Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBBED591B2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 20:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8Yt-0001V2-N1; Mon, 18 Nov 2024 15:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yq-0001Tr-Hj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:28 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yo-0002Ne-JM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:28 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9ec86a67feso39575566b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731962485; x=1732567285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kIdm3c5CRlQd1d9CckiYBUwnYKVwMrWkq3AMyJ9+Ic=;
 b=VYK7KJHxVqj2RxBJZdRstr7ivVeEMGE2/BRQr4e9rB+GMHZIUE9LIv0hLvzjUpUlXi
 RyVmoMFqQoOCEtqaZymqE4+HdUzOA8QhgfWvkmS06ExclfHdKchLG0bZEU4SfSbENTu4
 Scb+olnZDvCqdIeE6kPTxE8XUAYH+Chy4WFociX7VySkj0kFDo6eQRB/kny11gMY283N
 xIEMA3h/pAb1BIdEzxiTrC+LrcYE4WOMMaTBgbVt4owr11wqG7nNEsaELnbIjLcirAMC
 PhBoVrPmamB0fV1MQySYPPkBJr5U4L0ERROWD4HSSJLnd78yCsqx73jKZ+1P3jHZXk2z
 h+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731962485; x=1732567285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kIdm3c5CRlQd1d9CckiYBUwnYKVwMrWkq3AMyJ9+Ic=;
 b=wxbrlvMmhcQ+dwx8/hCPHiyFaryvccmsOXqkfAdsvHxOY7Yc44ndjoaDShV/YNCEcP
 5G3viVFdJT4xqVdv25zYog1r0EXpi/SzD5RFwoOVFkyLAMH8x1Cz17UC+gLTi9r44DHd
 U4HoNTOh0cBmbwFLyFGdBnN8kmxi/Ajb6xWgQomERaYMDRnfcZ2l7HljTzj1H1VJ10KC
 ci3/TelMw+sFr23w9ucZ2LtraXL+Whx3IFdiddPxMnG4PLfJERDLBRKJe7wX0mQ29j3T
 QQTYvMo2+Jhw+OQ4Fno7sKlyP8p5tDGI14Si1duo9m7C4kUKCt3O2U+Az5MefA2B1udn
 V7kA==
X-Gm-Message-State: AOJu0YyYioxjTlSvdC3AJN049WNhKFFQYWj17JhwqPLYyG3d/T76i99d
 4d6+W68q93H0XwngaYxr+Ld2gHvuEYVW2qz4MYXglSbj2UeOCe9oAZBRjMsVXai01CgyEvo4biQ
 4
X-Google-Smtp-Source: AGHT+IHpoF4FeRdYRUJ+9wLnZe/f4LOBxy+15QrlJ2fvAzQuCU9V8EnkkdoX/1tvnbe7cUhe2yjhXg==
X-Received: by 2002:a17:906:9c82:b0:a99:fc9a:5363 with SMTP id
 a640c23a62f3a-aa4833f7a46mr1208173566b.9.1731962484893; 
 Mon, 18 Nov 2024 12:41:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df56b1esm574306166b.71.2024.11.18.12.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 12:41:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 650425F95B;
 Mon, 18 Nov 2024 20:41:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 3/4] hw/display: factor out the scanout blob to fb conversion
Date: Mon, 18 Nov 2024 20:41:22 +0000
Message-Id: <20241118204123.3083310-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118204123.3083310-1-alex.bennee@linaro.org>
References: <20241118204123.3083310-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241111230040.68470-2-alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 553799b8cc..924eb8737e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -333,6 +333,21 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id);
 
+/**
+ * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
+ * fb: the frame-buffer descriptor to fill out
+ * ss: the scanout blob data
+ * blob_size: size of scanout blob data
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
index eedae7357f..145a0b3879 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -805,7 +805,6 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
     struct virtio_gpu_framebuffer fb = { 0 };
     struct virtio_gpu_virgl_resource *res;
     struct virtio_gpu_set_scanout_blob ss;
-    uint64_t fbend;
 
     VIRTIO_GPU_FILL_CMD(ss);
     virtio_gpu_scanout_blob_bswap(&ss);
@@ -852,26 +851,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
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
+    if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->base.blob_size)) {
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


