Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D6BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8eY-0000FA-4I; Wed, 12 Aug 2026 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dj-0007kC-Vr; Wed, 12 Aug 2026 09:05:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dh-0004dI-Ap; Wed, 12 Aug 2026 09:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=wmXyhvHRF5Wt6v0WtFTJ3z7SKION7tEAHlvUZMg3r+w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ghqDoAWYnGwNZYym5ZNqkXK3zmn3N3h3DwmjtrFSGMIeHArcQfI6YizZMCH/Ruya4
 ugUtbhwdUtq3RFPw3KZxyBnNiIb25Bc9YD/jqgc0WBkKjA0oElUmZ73bM7HKkir57T
 nMbTgp7KNmKJJ06K/0vutNqDHTQGACrzVVXi3w/pnJQ6Pyl4gHsnETfgmnK8PUBSQi
 WfAXAS8dRYj/COk/9AsKF0z2U/1XXKPMHtCu5TLBZwIAtTRhp7Zntza+xNgsuOd1Qz
 Z+Zmd0LCz/Lk0pJF7zRo7JKUEPvRg7mk3VzNN4/WjMK5E/l4GkOrAr3Ln+FAutXiUG
 sTkcYk+QAGRCg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B3E91CA497;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B07D0409B7A;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0AD802F8C4; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 024/102] hw/display/virtio-gpu: reject strides
 exceeding INT_MAX
Date: Wed, 12 Aug 2026 16:00:59 +0300
Message-ID: <20260812130233.621965-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
index 0121aac8051..071abab24ff 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -650,6 +650,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
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
@@ -769,6 +777,13 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
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


