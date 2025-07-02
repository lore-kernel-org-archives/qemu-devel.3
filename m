Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E59C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwn-0006mY-Of; Wed, 02 Jul 2025 06:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwi-0006ie-NO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:08 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwX-0001M3-Bi
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:08 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so8555495a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453033; x=1752057833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzVknBoggUzvrFjLbxqW22UiKdqh6179CfLQfmp2lsQ=;
 b=AQ0fUOa90HhWouVTT5SbVW/B4EdlWmZDmQ3FrSSIF5Yaa2KOtewHWpFbyXkT9zLOXb
 Yt95UHac/JtDOfNJK1Y9foHD2g2+9Mk3ArVl9t3C0EYZnMtpk/mbNDu/ez4nTdDsPgCi
 HPXi1KzrJH+Nc1C7o2rgs202N64YNYzPLOSCm0GwD9bv/EWbWc2G63W4D4IVkM2GHvn2
 rGRAvbbste9p3IgMzQzIqQdXftTJdAClQdcDJ2g+zNVAbi1E5rE3qABpMeUjj6Wli8Gt
 ZEL4fA5gIx3TDjobAImEKvRZ8RJNRn8p34AhohVFuWnlU2SqUhAGW76H4KMVmqV17ZJ5
 /0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453033; x=1752057833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzVknBoggUzvrFjLbxqW22UiKdqh6179CfLQfmp2lsQ=;
 b=I+6J6yzwG8JeZPbuGuND4Qoc20ID7x4pXYKlSmkSq7DXW0krgpQU2cpJyxvwO/FrrD
 9GJ+Ee9OTYN/albSrT1/YN86jAZUDvyxvlIyxVJgISZnXACjOVJXJUYq4ezi+vuK5CR8
 qFcLhBNoA0OG3M+SIenRijDBD8Fmgkjlc9H8jKty1T+M/ktv3pXOMOOrgXwzfcNymtD9
 qcPw5EhUWka+rtKmW5i3sOfH/Dxtfzb4qVRd6K1ukMp5AfcYQYam2M6y19MhEZHWWE3E
 diGyb1tY5oGBz4llZG4iOIIHwBzCkYxsaZ9pfZNyEo1xOjiM8GwekhSKnJNd7okwtXoL
 srWQ==
X-Gm-Message-State: AOJu0YzPb2kqzrBZyGoQmtplvwPEJCqcpoGAHd2WdNZnKzH/ndqI8cNt
 jVQPEIhPxsfOVNfnkXJQFrdJ3Xu+/aIClPvMzw7SlpYY+rYjDKeytsLPItZBPg7lkmbIPatisZe
 hOhxOrkE=
X-Gm-Gg: ASbGncuhgiah4h7epugdcnRFG3t0ePBsUpBcjg8lWXiZYQm97Nz+eOfACMv2p3+hi40
 eOXojSXICiEjXSVn3m/uNZMawfHqIFKSGxyxYzd7GyHFwnmYGkHoi3fhdZNKrEiMLQKlFmI1vJJ
 iMplkv3jH7Ux9BTnKVVZwoLptwfv7OIwM1CgcdfRiLaSqdnbwMWlALVi4J7HrnbcvjhQcyuWBaw
 u0gDU0XUopm5WN4hwarmh075ZR05POPTi0IPBZT+2oISuZF8n0WcFCMK+R+2GVQPwD4l+kK+R7s
 cRTaSfrBiHQbf3rI3KkkChwjYd5854s89W+rVAFpD6vaA1FAqTNR5H7SO9Bo26s=
X-Google-Smtp-Source: AGHT+IH7ShiqmakM4qtyLDjPBru+iBrjthojtCAOWJ1jWBXYue8dsSt7+DLFB3hYWaVGqPIDz3aAew==
X-Received: by 2002:a17:907:7f26:b0:ae3:7218:27bd with SMTP id
 a640c23a62f3a-ae3c2a90895mr243664266b.7.1751453033339; 
 Wed, 02 Jul 2025 03:43:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35365a0a8sm1061834066b.71.2025.07.02.03.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52D215F936;
 Wed, 02 Jul 2025 11:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yiwei Zhang <zzyiwei@gmail.com>, qemu-stable@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 15/15] virtio-gpu: support context init multiple timeline
Date: Wed,  2 Jul 2025 11:43:36 +0100
Message-ID: <20250702104336.3775206-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Yiwei Zhang <zzyiwei@gmail.com>

Venus and later native contexts have their own fence context along with
multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
the flags must be dispatched to be created on the target context. Fence
signaling also has to be handled on the specific timeline within that
target context.

Before this change, venus fencing is completely broken if the host
driver doesn't support implicit fencing with external memory objects.
Frames can go backwards along with random artifacts on screen if the
host driver doesn't attach an implicit fence to the render target. The
symptom could be hidden by certain guest wsi backend that waits on a
venus native VkFence object for the actual payload with limited present
modes or under special configs. e.g. x11 mailbox or xwayland.

After this change, everything related to venus fencing starts making
sense. Confirmed this via guest and host side perfetto tracing.

Cc: qemu-stable@nongnu.org
Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20250518152651.334115-1-zzyiwei@gmail.com>
[AJB: remove version history from commit message]
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20250627112512.1880708-16-alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b3879..94ddc01f91 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -970,6 +970,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     }
 
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+#if VIRGL_VERSION_MAJOR >= 1
+    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
+        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
+                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
+                                            cmd->cmd_hdr.ring_idx,
+                                            cmd->cmd_hdr.fence_id);
+        return;
+    }
+#endif
     virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 }
 
@@ -983,6 +992,11 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
          * the guest can end up emitting fences out of order
          * so we should check all fenced cmds not just the first one.
          */
+#if VIRGL_VERSION_MAJOR >= 1
+        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
+            continue;
+        }
+#endif
         if (cmd->cmd_hdr.fence_id > fence) {
             continue;
         }
@@ -997,6 +1011,29 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
     }
 }
 
+#if VIRGL_VERSION_MAJOR >= 1
+static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
+                                      uint32_t ring_idx, uint64_t fence_id) {
+    VirtIOGPU *g = opaque;
+    struct virtio_gpu_ctrl_command *cmd, *tmp;
+
+    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
+        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
+            cmd->cmd_hdr.ctx_id == ctx_id && cmd->cmd_hdr.ring_idx == ring_idx &&
+            cmd->cmd_hdr.fence_id <= fence_id) {
+            trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
+            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
+            QTAILQ_REMOVE(&g->fenceq, cmd, next);
+            g_free(cmd);
+            g->inflight--;
+            if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+                trace_virtio_gpu_dec_inflight_fences(g->inflight);
+            }
+        }
+    }
+}
+#endif
+
 static virgl_renderer_gl_context
 virgl_create_context(void *opaque, int scanout_idx,
                      struct virgl_renderer_gl_ctx_param *params)
@@ -1031,11 +1068,18 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
 }
 
 static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
+#if VIRGL_VERSION_MAJOR >= 1
+    .version             = 3,
+#else
     .version             = 1,
+#endif
     .write_fence         = virgl_write_fence,
     .create_gl_context   = virgl_create_context,
     .destroy_gl_context  = virgl_destroy_context,
     .make_current        = virgl_make_context_current,
+#if VIRGL_VERSION_MAJOR >= 1
+    .write_context_fence = virgl_write_context_fence,
+#endif
 };
 
 static void virtio_gpu_print_stats(void *opaque)
-- 
2.47.2


