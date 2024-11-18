Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A55D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD19u-00032R-8T; Mon, 18 Nov 2024 07:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19s-0002zI-4k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:12 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19q-0005ON-64
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so34169055e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934028; x=1732538828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/HCHXMnEBiDeYb/y8ziPz9hA5jzwBngAlzN9BmJ4hI=;
 b=YDp9DHPQjmtN/ZX9YNAZFkirT5453yo880ERxT3jBZnrWYxSD9QbfP2LbPT7+tIHS+
 gCIUIWjSGBkU7bYZsOPR09eqTWZdedk4qmC2HtH0raCt83jvTKlb3D/hLQIk7VxinOZl
 JMtipFN/Uz6dvWbSqqMxj5wWVoE0jlDModUJiVbitUllGxNuDcJX0aCIsZtED3ukVcdB
 mpyQtG/dAqI/6iKzxUB+eXEYlrmOFHFTwm0HOW93XiW2wZ6U8KMiXNx/A2HpRhFwCkPk
 Q0lQuBmI1rrcqIuADSjwyaj73gctt+sJvAEt4pNR3xGZ+pDcDWlKTzYHicxTzDqKr+UO
 OCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934028; x=1732538828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/HCHXMnEBiDeYb/y8ziPz9hA5jzwBngAlzN9BmJ4hI=;
 b=lnbl1t/vwb6FdB6NEad8eoPzwFuPMGZh1ElUhmxqaHY1xw4o1envdUf0+urOqHPqYN
 cJV05IuEiHVycXBeUqChKrCSr4yvlyPwKhUCP8lXpGET9Dkv9yRpPJ6fzmGQAn+K7obw
 gHgTuhGE8QYecUPuFARjQRgaBtW4MWDdS9Vug4l6b70GWRKVixj66WQARewd7eL3KYWn
 CqkhdtHEuHIy7RWnBtcBFnE/TbvayF69uLC2F4CZ4kOmh9RcqbpSYcVqOaQUrdaiU6sp
 Zqz6RgpXjCoczLMUH4nA/HptzDw3CPN5cnCrOUDstXB9GG34OxBOFWVA9uWxMeZPkZGe
 RPxg==
X-Gm-Message-State: AOJu0Yz+AHiMMMmMCkQ6FKYF+Fl42eDAz3DS2oKs5en3v6SA4z0oCSVr
 DuDQgsLys7KoncAKBjjLRFyv7oTCbKf+gNmUj3rVBlZdRbEN9RpbSOjUt+BIRi/awadr8SyAJyA
 g
X-Google-Smtp-Source: AGHT+IEw/yUPTzIK0SlphR6COFUgkFUAA41s2ghqCIsxKNjb3jNgCEcH3UlWoGfGolM1zSI1tlobjA==
X-Received: by 2002:a05:600c:3b20:b0:431:5a93:4e3c with SMTP id
 5b1f17b1804b1-432df74cdb3mr117437165e9.16.1731934028473; 
 Mon, 18 Nov 2024 04:47:08 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbe7dfsm12533069f8f.56.2024.11.18.04.47.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/15] hw/display: factor out the scanout blob to fb conversion
Date: Mon, 18 Nov 2024 13:46:31 +0100
Message-ID: <20241118124643.6958-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

There are two identical sequences of a code doing the same thing that
raise warnings with Coverity. Before fixing those issues lets factor
out the common code into a helper function we can share.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20241111230040.68470-2-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-gpu.h | 15 +++++++++
 hw/display/virtio-gpu-virgl.c  | 22 +------------
 hw/display/virtio-gpu.c        | 60 +++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 44 deletions(-)

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
2.45.2


