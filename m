Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190C2C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQo-00073W-54; Thu, 05 Jun 2025 12:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQl-00071g-GV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0007x3-QO
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad88105874aso189382866b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140819; x=1749745619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pi6A9pXASDCw44aREzrVY17X7X6kOk2Sy2xWECnN1gI=;
 b=h60IYiXOJceUNvJGYkNXJAl2X7LSc0z9qEZO9LV5DiA1d+9Lp2NMNG3P2xmJOhjjZf
 8ogKhF0HagDrfETbdygZeccpjhtdKK72eA80mIu5zRk2r8GlrSgNtyVGd7KR3b5OZcPC
 sgT+b/bSDiBsU3dbXl555MHTHN5VkcHLqvMCQbjrsDwn3AhnRWzARWnK/kJPYrCq55u+
 bo1cFUYuOXLRTzA7L5eudQk812FF26bFzXr8iNjHphlMLOM9KAYNUPMdbvAJ+FVNHf3e
 kt0aoaur+S8Eg2jgoPtSW/kJXQm6+y0G9n+OzntB4SfEtPlWO7uUHC9+gi3CcYVBGf+I
 jiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140819; x=1749745619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pi6A9pXASDCw44aREzrVY17X7X6kOk2Sy2xWECnN1gI=;
 b=obBobml1FSpltYfAgnNAlwwuw2VAWncyc7St7Q22NiKjntXoXi+TSkKIyIidRSqTka
 Zp/+YM0cvn+Gf7yHT4XpxTs4XWrYotK/VTaemqQVjzWZXGCL1UD44sUK0MNz1BqPzivc
 bqVj6wg9KpNIjdmxUka2EoD4eVZqTWpWaPEopPeeZaTbO5WpcbR7W/pB2gw5BH+LUwFy
 wm6SmYg8uCbZkuL7vgigvN6olnOG8Zdea3gwV96RfETatFtsRR/TFajKvGbrR7fqNEV5
 fcckSs7UFz8iDFBxiGTi1bMpf4A9dUoASCKXyrEad4VZD7XxU/yHwc2T8vGG3bn9nfJR
 d0Dg==
X-Gm-Message-State: AOJu0YwFIru6u1gVcGVlM3dNL9NL+sWaPSVXJkhQaK7295/CP2U0avtP
 NCxV9A1AvTc9djOSTNt0Rfa7fDT3TxJrvnCm3rYEG14qcKlUKLIjOq0rXtfMnGHjn1o=
X-Gm-Gg: ASbGncu4UT/32so+3Qs5UGHEGzZ22Z415AELqYATe0g2KXKGgMhWb0w5Qq0/6YD9Tof
 NiRtlR5U3g9v1qNCNpfEJ5L1zjpKEeWRyxzd41jwaFub5E0YR/u5t+cPMkEUCOIb6SlIStEvsti
 31nUw8GG6COh8Qj1kmmdfHwSC+xvZcalvYKRddiXxDB/R6wBuB9jm6inj/yNWprRNVZ77HdKXWb
 oR7tgZSwpPI5tsp80UC4+Nlr42re5nZHX2YqpiVZEvgx1tvkW4MED2VP/rZTxzUxNaDznlb7tN7
 irmCLZL2t14onhzcLd9kXoG/5s+SpSDKEeBjZRJK0zArnDDsv78E
X-Google-Smtp-Source: AGHT+IEBMilE/8oIFN8s4dI/vTPzEJ7DSZEtRq3btKkpLHozwbqKtt94AWtYqgiIuFa4ZzwXcZnfFw==
X-Received: by 2002:a17:907:94cd:b0:ad8:9c97:c2de with SMTP id
 a640c23a62f3a-addf8cec8a1mr719972266b.16.1749140818922; 
 Thu, 05 Jun 2025 09:26:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-added7edf9asm364342466b.152.2025.06.05.09.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8095E5F830;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yiwei Zhang <zzyiwei@gmail.com>, qemu-stable@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 12/17] virtio-gpu: support context init multiple timeline
Date: Thu,  5 Jun 2025 17:26:45 +0100
Message-ID: <20250605162651.2614401-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20250603110204.838117-13-alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b4aa8abb96..cea2e12eb9 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -978,6 +978,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
 
@@ -991,6 +1000,11 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
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
@@ -1005,6 +1019,29 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
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
@@ -1039,11 +1076,18 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
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


