Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144C9D3ABCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 23:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAdP0-0000uM-QV; Mon, 11 Nov 2024 18:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAdOp-0000tL-KE
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 18:00:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAdOn-0001ir-Hx
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 18:00:47 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so3538711f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731366043; x=1731970843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxzzjInQDdcHJ2SqBgIRmm2wxmj26K0aTYuxqLWAoGk=;
 b=VvR6Q/PbWb6xMt0sc+RqgLQ7zVnUkDyDq3iP4c64M+ULmeBMJ9PnC920rKc9v3ciAD
 cF0z2LFJTEDMvp7z6T2n76MrQNpkkHy4ywMAeUpnPqkcY1GwgilJgUoJQyEuY8EBmAoR
 0yJP4R3pvyXMJAEpClSp6E6726zQLghiEi6QBuriQ/63uXxBpqC6czicDc8n5kNcl+dT
 +x4q7gsDa6TOUCsCcK2owcdRke4ex1qeaduC1CJqcYeyEVhM28lImwHf2pG6doLbbv20
 1BpM8oz1vHRNS5NQg6/95YGYKVDkntCJ1mKAhVjKxyw6n9b4ZpzTHTvCbcUSmAnmgcl3
 J/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731366043; x=1731970843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxzzjInQDdcHJ2SqBgIRmm2wxmj26K0aTYuxqLWAoGk=;
 b=l1rVHIDO20Dr6S5kHpm/7/+o6QP9uAJYxBoPPDpnKEfpUcwRaKJqgMerZdtOFvQx87
 1lfvlpnfyD9oQ6zM16PZJn/WgiYRvWEmmpSgAi2dUk/q6p0GNxFJDJupc3456DHmJHJf
 qSLfrSFMV2Zh9vtCYy1qgi619osGwn/EwWJuX22IxOencrbYKlPmWifKYbSepP34hXwi
 vfwRoLouikqE3fhy1ItJfzjYXdhf86MZJqjoC9NRmxtlKE4uSAepvHLaUnwUhCgz3SP+
 U/zNOTlK5w2B+vlWJBu7vc2ttorHYNlqjQv8YPTx2MN+04RTEXrbSsrEOixmuXJeoPy3
 vjYw==
X-Gm-Message-State: AOJu0YzDZXlG186hI/4/Ye2IElvW7sPz8Q+GJLDZBCgYCy9yo3+EDJVz
 tq8gCegO6NQD6aev8eqnfK+iR83iVyYztLiH6iOKg1PFwdZZrLUKlL4G2ONqdw0=
X-Google-Smtp-Source: AGHT+IHp5h+WRGtjWuYcc/d+nXS89FS9FmDlB+rCFEzK+g7TwDy596Ml/CeEfDpXFQElINm6TA28/A==
X-Received: by 2002:a5d:64e3:0:b0:37d:4ebe:163e with SMTP id
 ffacd0b85a97d-381f188c956mr11150775f8f.53.1731366043104; 
 Mon, 11 Nov 2024 15:00:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa709ec7sm230433125e9.35.2024.11.11.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 15:00:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFB745FA3C;
 Mon, 11 Nov 2024 23:00:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2 1/2] hw/display: factor out the scanout blob to fb
 conversion
Date: Mon, 11 Nov 2024 23:00:39 +0000
Message-Id: <20241111230040.68470-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241111230040.68470-1-alex.bennee@linaro.org>
References: <20241111230040.68470-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
v2
  - fix compile of virtio-gpu-virgl
  - tweak comment for blob_size
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
2.39.5


