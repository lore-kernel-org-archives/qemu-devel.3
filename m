Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83212D2AB30
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3n-0004f7-9T; Tue, 29 Oct 2024 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3a-0004be-UT
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3Y-0007TO-Uc
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so3459342f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203839; x=1730808639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7P2y8ojbRByNUhojZLYVixQKQid+9QX54I0osIQ9P8=;
 b=P60p0tBZiRC4R8Kv+3bkW9dAYzeFSVsPgUO+bPoSpNNRvg3ghEc4jevTQTdqMb5eYN
 UvcvH0x5+Rixf7W6X+Vo8mhXaqgJUYwDinYpHsXhF6nTr9heC/7Nx+el95BJQawnWf5D
 Kov8jUGifMkN9lN+XCaCYu+Ez3m6y4f8qR1xEkYskxsg/wCkJ2ZS6fSDmVKKCftf3UZU
 XSzlhf6KaZ9q5eBUqN/9w7ubneL7uvFWiNWeTAWOuVtA+lBVOOXZ6uiwrCE7oBll7tBJ
 RHqXxtahJUcI1r1h7v3rbkFzKLb3aDKCoEquFw3pXsXSker/7dSXAA3qDrpqnghiTH54
 4VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203839; x=1730808639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7P2y8ojbRByNUhojZLYVixQKQid+9QX54I0osIQ9P8=;
 b=VcbnUdiKyYf3Vw0FyaT/I8kcdDybPn/AuJgxw7T+tNzNgj3itIyz8BWwz3SQNIe+Gh
 hOy3YClF+g5fOvlDIAveZgAptgCIN77CtrRM7sswU5aOixjZLBUccj58ohbG96ain47v
 x4dazQ896ofC7QS7igB5J8xBYRyuzU2/1IZE8y6NmIy5vhQTlqzQBrZRh3BgK4+/TwwU
 w9U9onfiGk9B3Fi10W9GFgWL5DQKB0t6hKCi+c1fpSkDAsiDo0ohCJdkl7NhR8235xww
 huLctLUOr9gda2pcipWCvNcDMQTkUy4jN7gBXTfJ0ztfPkCbV3FmdTgnSL5eRJ/b10Ua
 /KEg==
X-Gm-Message-State: AOJu0YwmZzEsW4G2l3qizETTv+4HX5PNfLpuPKq1Q2x2Bs7cgGvDWA9F
 /VyQmwQ4OcoMJbW1NEd+twa4BQEZOt2bMafGh9aPDgPQ5eARlSVMA3UVgHRgf9w=
X-Google-Smtp-Source: AGHT+IGHvIUeBsC3EL2hJG4gXYprxAxc3bDOkUy9UIWMYoKYZPfYe70qiqiwdbqx/jkxWh6IIALysg==
X-Received: by 2002:a5d:45c5:0:b0:374:bf6b:1021 with SMTP id
 ffacd0b85a97d-38162916869mr1701207f8f.27.1730203839263; 
 Tue, 29 Oct 2024 05:10:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3bec2sm12310048f8f.39.2024.10.29.05.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0E595FB73;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 12/13] virtio-gpu: Register capsets dynamically
Date: Tue, 29 Oct 2024 12:10:29 +0000
Message-Id: <20241029121030.4007014-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
like Venus and DRM capsets. Register capsets dynamically to avoid that problem.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-13-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f9ed81071f..07131d8eb9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -207,6 +207,8 @@ struct VirtIOGPU {
         QTAILQ_HEAD(, VGPUDMABuf) bufs;
         VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
     } dmabuf;
+
+    GArray *capset_ids;
 };
 
 struct VirtIOGPUClass {
@@ -352,6 +354,6 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
 
 #endif
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index f2555673a1..e859c0dff0 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -144,8 +144,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
-    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
-        virtio_gpu_virgl_get_num_capsets(g);
+    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
 
 #if VIRGL_VERSION_MAJOR >= 1
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
@@ -177,6 +177,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     }
 
     gl->renderer_state = RS_START;
+
+    g_array_unref(g->capset_ids);
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b2f4e215a7..5a881c58a1 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -622,19 +622,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(info);
 
     memset(&resp, 0, sizeof(resp));
-    if (info.capset_index == 0) {
-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL;
-        virgl_renderer_get_cap_set(resp.capset_id,
-                                   &resp.capset_max_version,
-                                   &resp.capset_max_size);
-    } else if (info.capset_index == 1) {
-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
+
+    if (info.capset_index < g->capset_ids->len) {
+        resp.capset_id = g_array_index(g->capset_ids, uint32_t,
+                                       info.capset_index);
         virgl_renderer_get_cap_set(resp.capset_id,
                                    &resp.capset_max_version,
                                    &resp.capset_max_size);
-    } else {
-        resp.capset_max_version = 0;
-        resp.capset_max_size = 0;
     }
     resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
     virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
@@ -1160,12 +1154,27 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     return 0;
 }
 
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
+static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
+{
+    g_array_append_val(capset_ids, capset_id);
+}
+
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 {
     uint32_t capset2_max_ver, capset2_max_size;
+    GArray *capset_ids;
+
+    capset_ids = g_array_new(false, false, sizeof(uint32_t));
+
+    /* VIRGL is always supported. */
+    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
+
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
                               &capset2_max_ver,
                               &capset2_max_size);
+    if (capset2_max_ver) {
+        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
+    }
 
-    return capset2_max_ver ? 2 : 1;
+    return capset_ids;
 }
-- 
2.39.5


