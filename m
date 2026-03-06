Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B32EFCC067
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDH-0005Js-CP; Fri, 06 Mar 2026 14:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCQ-0004Cm-M9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:03 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCN-0000RN-Ts
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48371119eacso114188165e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826658; x=1773431458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRS02MZ6aEMRyeENzvEVRS+yAlrpGP763UJyGyRbzXc=;
 b=oJx4mc1nXrJNLYxKPzxCpRyxkha4kdp6Xhey9n1IV9kqMLgociMFkTGVfJQdgWKJdP
 +3WiopOt4J6GJTdIfAqhCEdahEXHujILI62MbG8DJkoQFmmrurxhFn9xgHfqJh6OBSF0
 kPWzYG/LgM53otGodpaEVhzuA8pjZ2NQMkNAnnsyoh4hBlDP9LxxbuDE6Ko3n/nMiR/H
 MUaeps+L4R4VGhNB7VxDVfzcSj7lIyl8Ui4FrxC3qnIHk0q79QfqAk4uzZ9jE6IIqYqe
 wUFQ641OnFmpv9c5WmxSPSaf5GUAOKeR9EfJqWNoIWZAoMluwOfEBknkM917F7atVWxB
 D/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826658; x=1773431458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TRS02MZ6aEMRyeENzvEVRS+yAlrpGP763UJyGyRbzXc=;
 b=Qzdm5hc9LNGO0/jxuk3WMagTlL5Kys4ENbQw3uJIbJQpff0zo0HIKyYJbTzp3ecEmC
 QoV83YwuKgojC9HbBps3/f+zv8uSDO1ay70txOeekEP58dJ2mT06427D0CpQJzahcl3n
 oaVE7Bn7e8LQzL1JX+EWUsFPvmxHnrHyItL0pw2BeKXrQXAx7BUaOfqFhAawAhJdJ8UE
 TKR7U/K0Rkl5Lb1+qi5fXOFO/FWreaQDvyWAWloogSXjSHEAK6VjTYeOsgnCIno+pKkx
 NtwqCgcGEWflzwVcGwVR5LVmE3a4IvKoWwH9bK3pUdnJiI5l9ZFlnMFy7sVJTBwsCtGf
 w4gA==
X-Gm-Message-State: AOJu0Yxlt5JrnBOgcxoe0ppJZzWmfQg7QVkF/QvKqfgNV5lH20t5f2Cv
 FyRYhDcAQc9BsOFSjc94nHmErMoDOsXXEN++q/H9VlX5+LTq3ie+sFyTjZhHEZ+yN4w=
X-Gm-Gg: ATEYQzxSYssu99b9M5Aa9T9lIdoc0iBq3fvfJlQp930toQ1wE4A1Kglt4bKPs29rjYG
 UKKG4tXUqpd4JSvsgpTT09jIJjUoU+Jw5Xmv/1BQyLOaRW5GtG68ZlUCXbFX09VqKXmuAvVdCsO
 x/VRjLxEu3hL3lUFgVhkQWfrvJDYyysnuduTpAZRB1qQOuzSdenxFxKOQyaz1uiaNlJ+++TF6/Z
 4vFv+Uko3xYVn3Le5v6pwe5TCSnMnN5nrvq3tkIanTImW1XFCypaTz2SAVdcBYcQ21CIh1fS/4I
 DRTQfpA1b4pPmIiquhL74qIdiZXio4f3fvl38FI1k0Gr/tJUDgdhHAjKt/E/3BuUcMINiDaMApN
 q5h6FxCNusAjPthuSNCEpqb72sNo5El9N1XZ4bZJ++oKd31aesLtXz9dj4uQKDDq9RQ+JKzNEkZ
 cttkWRxSRUa6eCwnCBaMSIYnqz4gIsim9Ojg==
X-Received: by 2002:a05:600c:8714:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-48526957d50mr50072905e9.22.1772826658421; 
 Fri, 06 Mar 2026 11:50:58 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852470b412sm50445705e9.8.2026.03.06.11.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C692689DB;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 12/20] virtio-gpu: Support DRM native context
Date: Fri,  6 Mar 2026 19:50:39 +0000
Message-ID: <20260306195048.2869788-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
using a new virtio-gpu-gl device option "drm_native_context=on".

Unlike Virgl and Venus contexts that operate on application API level,
DRM native contexts work on a kernel UAPI level. This lower level results
in a lightweight context implementations that yield better performance.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-11-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 0f4bb304a9b..086e2fcf27b 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -84,6 +84,17 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
 
+DRM native context is supported since release of `virglrenderer`_ v1.0.0
+using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
+host blob support (``hostmem`` and ``blob`` fields) and should be enabled
+using ``drm_native_context`` field.  The ``hostmem`` field specifies the size
+of virtio-gpu host memory window. This is typically between 256M and 8G.
+
+.. parsed-literal::
+    -device virtio-gpu-gl,hostmem=8G,blob=on,drm_native_context=on
+
+.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
+
 virtio-gpu rutabaga
 -------------------
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2610a32e408..1a999887481 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
+    VIRTIO_GPU_FLAG_DRM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -122,6 +123,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_drm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 3e0680880e1..b941e9a4b78 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index ae1880c358b..f5fe1bf4e73 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1323,6 +1323,25 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
     }
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDERER_DRM;
+
+        if (!(flags & VIRGL_RENDERER_ASYNC_FENCE_CB)) {
+            /*
+             * Virglrenderer skips enabling DRM context support without
+             * enabled async-fence feature. VirtIO-GPU will initialize
+             * successfully, but DRM context won't be available in guest.
+             *
+             * For vrend async-fencing can be enabled only if EGL display
+             * is used. Vrend can't be disabled in QEMU, hence DRM implicitly
+             * requires EGL too.
+             *
+             * Async-fence was bugged in virglrenderer versions <= 1.1.1.
+             */
+            error_report("drm requires egl display and virglrenderer >= 1.2.0");
+            return -EINVAL;
+        }
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1386,5 +1405,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
         }
     }
 
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DRM);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a89d49aa8cc..de7a86a73d2 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1517,6 +1517,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+#ifdef VIRGL_VERSION_MAJOR
+    #if VIRGL_VERSION_MAJOR >= 1
+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "drm requires enabled blob and hostmem options");
+            return;
+        }
+    #else
+        error_setg(errp, "old virglrenderer, drm unsupported");
+        return;
+    #endif
+#endif
+    }
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
-- 
2.47.3


