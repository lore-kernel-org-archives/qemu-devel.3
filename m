Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220E2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 11:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGcdL-0002uA-S2; Sun, 18 May 2025 07:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uGXlM-0003Y9-An; Sun, 18 May 2025 02:44:44 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uGXlK-0003j3-16; Sun, 18 May 2025 02:44:44 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b26f67f10ddso1190781a12.3; 
 Sat, 17 May 2025 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747550677; x=1748155477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nHQq4ZN/6aHy0KqZR7eah9cgeaKBnttgZrJ3A3C+xAg=;
 b=ToRqXaRvOqiGBf/Cxzf5mv/lEqUdDJSphyJrR1D/5m5G6dU5rXpkRR+GJqflO96Kb4
 dJaXSEeftq01QpUhplXwOd8Qhh0yWqOy1XikEqBBa62bzhoXNJBbjw6UHpg2bYUvCeH0
 g8q5ovETFHCT9+dP8PTLwJDHJ6bn+Rgo+ZZ4tVbLiuG3LXHl1jv+UWMKJ2fkZRp90Xpg
 vJw0K0ctRa+gMHpGVjqjb6uGrP/Xnn0x9x/+8PVylLKESbRFvcExC6SRvc4PA2S0Gg/t
 EwNetDGxu57lm1FBV6hFTxddxn8V/cvr1iNyjntDpcf/efsIOonj+vBN8HIUtIlC8JOt
 DuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747550677; x=1748155477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHQq4ZN/6aHy0KqZR7eah9cgeaKBnttgZrJ3A3C+xAg=;
 b=m9klhHBLgZA8Jft6444q0Fp16ihFLRQ+72cXA0ebNmP1m9Xk2OFqnnDJH+4T57XX1s
 cPLXJ0t+PXumKyclRfPr0XnGB1QSfGoT98IwbJD/keP2Sauef/L63ds6ConPSg2YjsUj
 eQmtzTL9eexSK4w561CxCaAFUs0cdaySeRFMwWAgOZZ5Wzqj1ue02UPyPKabVlg/gwY0
 E/E+2lHsxayDMlJPNvbuQY+roeqPbd98NYp8/hrNVuBGAlDSQz192IeyItZZXtTbH4wT
 UtwPvl5Y2FbT1nrAnDdrjKYYpMAxDnaa/L0FBi0Bz0ziuxVOyKevy5HJ2vo4bF9v3XCb
 NRtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlaRYxFTvZH1TpE+tEerDVDxBmDxoqYBnLcKpteHDXQlNz6VtE22dDlmimqJuIa2HiOgVxJS3FYWekIA==@nongnu.org
X-Gm-Message-State: AOJu0YxIyPTRCBT28XhxD0H1sr2HKI6eTc1Qslo+Wech52LfvqnqGZg0
 /vNKQ0zoR59zpCGacB2oFeb4kl06wBOK2Fq0eB9bp6bE1jv9DIABOfmvvZgLuA==
X-Gm-Gg: ASbGncucgCvwhwBRwKYdTF/4Z9G4NF/xOW45PLo2FQtqLbGhV8bkMQUrgpIGA2iI3a1
 p+j2KaEWzCR5F5JxxHHjy6SE/z9pUDftqvRuOWzAsRZy3AvD6NG+FZKJYk17oRk+ek8zsMLBJXg
 vxHggh53v4w+HyeRrqi4gTLxcm8P68MwbuE+0dQpUppjWVBaMuEOVJiU+EfvdyPf4LSFw12aCI5
 1iREkkoP5RD3BXEW0PgcgUyrijDMzbx5wD90VLTylpzr7o6yc4Ju5nK2JxO6rk0yn5ErX9+es3M
 xgeze+b/vrFuLrg11edw/D1ocSKkSuhisBhkHKuNydIS0KzO
X-Google-Smtp-Source: AGHT+IFqQkc7g2oLGxGurm+ETB9EhQS4iFUQ2Nf4gVeYkONKAf2RinwdDc6clHPbgGxw/eEez6ON9A==
X-Received: by 2002:a17:902:c949:b0:22e:9f5:6f17 with SMTP id
 d9443c01a7336-231de35f05cmr97521675ad.13.1747550677098; 
 Sat, 17 May 2025 23:44:37 -0700 (PDT)
Received: from debian.lan ([2601:647:4401:73bb:8eb1:534e:5ce:313f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebbab6sm39472355ad.205.2025.05.17.23.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 May 2025 23:44:36 -0700 (PDT)
From: Yiwei Zhang <zzyiwei@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.osipenko@collabora.com, Yiwei Zhang <zzyiwei@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] virtio-gpu: support context init multiple timeline
Date: Sat, 17 May 2025 23:45:53 -0700
Message-Id: <20250518064553.317209-1-zzyiwei@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=zzyiwei@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 18 May 2025 07:56:46 -0400
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
sympton could be hidden by certain guest wsi backend that waits on a
venus native VkFence object for the actual payload, but that luckiness
only applies to limited present modes as well.

After this change, everything related to venus fencing starts making
sense. Confirmed this via guest and host side perfetto tracing.

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


