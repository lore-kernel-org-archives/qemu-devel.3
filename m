Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E791AD2AB33
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3o-0004fW-T2; Tue, 29 Oct 2024 08:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3d-0004cX-Gv
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3b-0007U8-Il
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4319399a411so40512415e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203841; x=1730808641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmizK428eYdY2C9hOKe1a6rQdlv5YX/NKe3TrD6Y5Mk=;
 b=BiZQP1Itc/1R08uxpsY6g0hbNCwcJTPY7ju2KQJesTbTRD11V8320zC2vKUEWH//DI
 kjdCY1l1t+LF29m43M8f++/F0kQn3/DqZ7BThI9p3v5rBkN9Ln74ozFrlqP4zdVVtdB/
 TyXlGvJKscn1uvfKnkCyL/NZ1Zo9guyJpQMqnyXYdHTfSq8/20dv/oGkr9Vg01R2A8Go
 KGJ90EnZC1nSawLr6prZtuAzwt49F5ER89JngbPXqUKZhDP0I+ykLVEFZtZVYgwXwZFa
 Rx38KJHBjddzh+VaecXrWvGFMi8o9sbo53PsAhrIodbB5n8OVIQ4mEo4vaYz/RVdNwCW
 NX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203841; x=1730808641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmizK428eYdY2C9hOKe1a6rQdlv5YX/NKe3TrD6Y5Mk=;
 b=YlfrxkP5nWCNwN4Norl2RUXPFeMf3Jzz5M8H7ZSW2XPQyD+Lf+uyqyM7P8VQ2MfQRw
 y9oCoZTsRRIjcbZMIrEkYvuw97UjgnB0V+KfQlTzIaANEMNeTdb5NiA9XoufRMIofKRK
 1uc9kjKNu4stCD1DHEQajdc9bcFm1TSR4/7tKZOsmEzoJgfs1D/DUl7/uDB7bk6yIpVB
 ByB+9camPAxcSWpfNPwH/yKAES7H5oMr2YD+DFHZkiiTZ50Gc+tnfIIeKVlBhBLpJpyM
 yu6/bZEBW+l8y/V+cePSMKnI7N6c5NKD3CXt/p5jOMsEfI9uzzVC1k9fqtriJlv3JvSX
 VFOQ==
X-Gm-Message-State: AOJu0Yy1jXyrRob1YYv+Bmd2ULMhEOepWET3IhxAjX5/4d960tIl00ud
 MVohQZ8i4J5URnA2eWvO5CZOL5oSX0ZjADaTkqp4nKN8YnMRiQtPh5exotJsn3I=
X-Google-Smtp-Source: AGHT+IHD+YzrxILHVlRcEddQSCNrHAWR+dUM7S5KtPEKmHxjFBOAj0QHO3N+c+39T7ZKwQXKQjpK2A==
X-Received: by 2002:a05:600c:138d:b0:431:5f1c:8362 with SMTP id
 5b1f17b1804b1-4319ad4176cmr83909785e9.35.1730203841432; 
 Tue, 29 Oct 2024 05:10:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f719sm170948565e9.15.2024.10.29.05.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BDDFC5FBAC;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 13/13] virtio-gpu: Support Venus context
Date: Tue, 29 Oct 2024 12:10:30 +0000
Message-Id: <20241029121030.4007014-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

Request Venus when initializing VirGL and if venus=true flag is set for
virtio-gpu-gl device.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-14-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index cb73dd7998..b7eb0fc0e7 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -71,6 +71,17 @@ representation back to OpenGL API calls.
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
 .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
 
+Translation of Vulkan API calls is supported since release of `virglrenderer`_
+v1.0.0 using `venus`_ protocol. ``Venus`` virtio-gpu capability set ("capset")
+requires host blob support (``hostmem`` and ``blob`` fields) and should
+be enabled using ``venus`` field. The ``hostmem`` field specifies the size
+of virtio-gpu host memory window. This is typically between 256M and 8G.
+
+.. parsed-literal::
+    -device virtio-gpu-gl,hostmem=8G,blob=true,venus=true
+
+.. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
+
 virtio-gpu rutabaga
 -------------------
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 07131d8eb9..553799b8cc 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -97,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
+    VIRTIO_GPU_FLAG_VENUS_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
+#define virtio_gpu_venus_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index e859c0dff0..7c0e448b46 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -157,6 +157,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_BIT("stats", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
+    DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 5a881c58a1..eedae7357f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1128,6 +1128,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
     }
 #endif
+#if VIRGL_VERSION_MAJOR >= 1
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+    }
+#endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
@@ -1161,7 +1166,7 @@ static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
 
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 {
-    uint32_t capset2_max_ver, capset2_max_size;
+    uint32_t capset_max_ver, capset_max_size;
     GArray *capset_ids;
 
     capset_ids = g_array_new(false, false, sizeof(uint32_t));
@@ -1170,11 +1175,20 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
     virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
 
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                              &capset2_max_ver,
-                              &capset2_max_size);
-    if (capset2_max_ver) {
+                               &capset_max_ver,
+                               &capset_max_size);
+    if (capset_max_ver) {
         virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
     }
 
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VENUS);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b6cd9fe567..c0570ef856 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1477,6 +1477,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+#ifdef VIRGL_VERSION_MAJOR
+    #if VIRGL_VERSION_MAJOR >= 1
+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "venus requires enabled blob and hostmem options");
+            return;
+        }
+    #else
+        error_setg(errp, "old virglrenderer, venus unsupported");
+        return;
+    #endif
+#endif
+    }
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
-- 
2.39.5


