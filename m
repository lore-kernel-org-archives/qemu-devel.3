Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210D9C3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 15:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGftL-0000ZU-Iz; Sun, 18 May 2025 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uGftK-0000ZB-4D; Sun, 18 May 2025 11:25:30 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uGftH-0006vi-Vv; Sun, 18 May 2025 11:25:29 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b061a06f127so2409712a12.2; 
 Sun, 18 May 2025 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747581925; x=1748186725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+v3lSlrUUJUhPW0dZ2WG3aeSWrZAxmHxdbnfc3PX/Tw=;
 b=AavAONb0xHvf9LMx3dtmNL6d5coQXZ1HdmSUZxjJofbja1J8aHezYfaCQvBWPHm2cc
 hFGGiodkK1PvNV5TeKmgLJ5EdNGHrs2E7E4WPW/RyKOrmBCBDYxuEe874YtY/1gKtKCA
 cm6Q0RTzAolDtogLGubNgRE3c32OwM7oCIrqRXHcbbzz4FK+qgtJ6TMnwyGOlqlwjG/A
 WxaFunBeXqV5HYIyCif53zyOUPyeH3Pm6RJ3spedSHuo4yIP1n0zhHCT4c5DxQ02Jh/8
 ZCV5Z2q5IacPiFTvtGXDr4hvWvXVT8CfUsIB9YmNncrnFw0pwGfoHZGdtARWOBC1f4A0
 FfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747581925; x=1748186725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+v3lSlrUUJUhPW0dZ2WG3aeSWrZAxmHxdbnfc3PX/Tw=;
 b=gtTdnJ6pGt6+yoKZ0q2Z5ybLaJEu2KQnm7Or45ukdY73YfX2TQRS2EHnh2DxDMRFvO
 MKNWf7wt62dzAfbeh2VKfpMbkg8j/j8+LhKyTNCEB6XtblADaVmlfmDKB3HKLts2+Fdp
 RHMp4mL7cH7A6mRF1eoh8Efo5VB7j5LTe/LJe1UvRwESXUfnzY8Qlb/Cmq1/u3K9OcOO
 yOdV73iT7hWTZJ+1mZP0Pi9Lthn8JgYjFXsuNuqFYN1+Q7uZUa0eP3G9LrCfPRUbdaO/
 DL76KVADQDa8xjPq/d/IQFwE2+AhMDc6sU9AmjDzESyHi4E6FpCQENeWqH/oK3rXEJQ7
 RPZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh/J+gvwj/Ed6IyeHrS4CIfuAd1NNRZbTgWAY1kuXoUw/r3ZJmYorZ0h8GUorji0PbkTwfnuPnxnF2BA==@nongnu.org
X-Gm-Message-State: AOJu0YxJkeFUv+kF6aPt4rs1weWQD076i/cVR5NXwTSTzxbL27HcEM1A
 exmF8plojTSmRvkgp1yNrd0s9zDTe8n8kABAmOFWyu6WV0huzVnM8RW3aFgw5bV2
X-Gm-Gg: ASbGncvwrdQ++1MWJjcdMbsBWaiBJ6zJ9uf3N3wyu9RFt4NLW+rHB9LGdiicwKjtJ2y
 VE4Iz7gYd6N/I+D7chvhtT4o2Yi7swCPorLyz4WclkkwyfJVTuAmidzKoSDaUSyw1wEtzYbiRSm
 h75SSHRtmcjNQa3SWMMYQkI1wkqw2+TJJnSIEtwy4/iJOPbzdIVzgmIbiV5NBIXoLZWjiCmQjHZ
 K1myWAJxhr6sLsQwDDpaTN+R5XUOhwbu5fP7aplmzrq4jr2T7lhD6APhlNflq/3vPp8W7pn7Dn/
 u7uyjefg+hEDui7n9fJmkGC7f25GacDN09Ez55r8AhQ2D8OyROvHCVMfRko=
X-Google-Smtp-Source: AGHT+IG6AOF/OTHfhQLCGvzuY1U52LhLKo2ZBdozv/pcdmMURhqZLVm0ayXloHWHlz2fHrWlJrFBwQ==
X-Received: by 2002:a17:902:ea05:b0:22e:4a2e:8ae7 with SMTP id
 d9443c01a7336-231d451db06mr161933875ad.22.1747581924590; 
 Sun, 18 May 2025 08:25:24 -0700 (PDT)
Received: from debian.lan ([2601:647:4401:73bb:8eb1:534e:5ce:313f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4af1525sm44585765ad.84.2025.05.18.08.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 08:25:24 -0700 (PDT)
From: Yiwei Zhang <zzyiwei@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.osipenko@collabora.com, balaton@eik.bme.hu,
 Yiwei Zhang <zzyiwei@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] virtio-gpu: support context init multiple timeline
Date: Sun, 18 May 2025 08:26:51 -0700
Message-Id: <20250518152651.334115-1-zzyiwei@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=zzyiwei@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Changes since v1:
- Minor commit msg updates based on feedbacks from BALATON

Cc: qemu-stable@nongnu.org
Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
---
 hw/display/virtio-gpu-virgl.c | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

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
2.39.5


