Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514FC5DF60
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMx-0003Ek-50; Wed, 12 Aug 2026 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKM-0006jP-7f; Wed, 12 Aug 2026 10:53:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKK-00079g-M0; Wed, 12 Aug 2026 10:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=tSDYynFEgVkI3gwbDjfUb5SZ4xnvO60qT2dGDIJepAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rcLsnp9OBIHF3fIkxJRLsMJHnF2HU28QLHTFUBjadg8Ee1O60h0RcKNWsx8x4fQX8
 qiRLkyywXxpxfHp+NT0U3hfTmfRv6ORmtqpigvp47Ldr+kYSS1e7pjZ2UZa6BXTVEh
 m6moBAW8B5d9hfYZtvs0DtrLdSyGWTDcrKtOORiahxVZy+DOFvfULYGliwhjFCFUXY
 SFIPtz8ktQBoMWDQLfp/O7v3QYultmZt4I/zVSbtvgDU5VAt93CA4sheXLWGqVX1OT
 Vn6uGVbWGvN8CqlQ/J0+00HcPqO9gMdAZPorVSoE7TrSf+MYGd2y0q9Tr6CBQHHkwD
 oT3P0wMC9h3Ag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 932111CA624;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EDDC2409D63;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 57F122F9A3; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 032/120] hw/display/virtio-gpu: reject strides
 exceeding INT_MAX
Date: Wed, 12 Aug 2026 17:48:15 +0300
Message-ID: <20260812144955.649205-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

VIRTIO_GPU_CMD_SET_SCANOUT_BLOB supplies a guest-controlled uint32_t
stride, but some downstream consumers take it as int. They may interpret
a value greater than INT_MAX as negative and cause issues:

- pixman_image_create_bits() takes the stride as int, and Pixman may
  later access memory before the blob buffer.

- eglCreateImageKHR() also takes the stride as EGLint when importing the
  DMA-BUF, and Mesa rejects it.

Reject such strides before scanout.

The check in virtio_gpu_scanout_blob_to_fb() rejects unsupported blob
configurations early. The check added in virtio_gpu_do_set_scanout()
covers migration post_load.

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260717-int-v1-1-8aa05e1791a0@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 9c724426f5192845b5975dc48165de06a3da50b2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 10f55bd2ae8..9a1b0a51ed2 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -654,6 +654,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
+    if (fb->stride > INT_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
+                      ", larger than the supported maximum (%d)\n",
+                      __func__, fb->stride, INT_MAX);
+        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return false;
+    }
+
     g->parent_obj.enable = 1;
 
     if (res->blob) {
@@ -773,6 +781,13 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
+    if (fb->stride > INT_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
+                      ", larger than the supported maximum (%d)\n",
+                      __func__, fb->stride, INT_MAX);
+        return false;
+    }
+
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;
-- 
2.47.3


