Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6214C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMr-0002lZ-Kl; Wed, 12 Aug 2026 10:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKM-0006jR-AI; Wed, 12 Aug 2026 10:53:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKK-00079f-Lk; Wed, 12 Aug 2026 10:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=9Iuwdnelw1WHAfxVLD86ANoX0VP05deWUNJmlAOSzcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V4J3QItnfyc/iT62Ug6xFrVNfuIaCz7jaXBMLHUXaURwuWG00pOluR01aCqAxqyB8
 4XlPZOaneM2sfQpZt6QeU0QJyGU1vRDhc0PhHzBhz0olsjsNd/Gci7ZFHg2snOJQvn
 +5ZJ5ZINCPKmu2a65fLRV4iJYFHZW0hYXu4l1zowQHclAtDgoz9Ibi55rWMIqhdCbf
 EMOaeribTN4hh3kjzY1Q4UGnzlihS3sbz/o6D+LSIb9Wg4+Hqj9spaD01fHG1Bxx+n
 NDpU4H/MjQLmIAa9EAcUt74iuQLTjr5kygRhrwVeD29uQ4FT2/3GL/DI9x2j9PZzaH
 nhqrcXjfyN0aA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 894B21CA623;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4555409D62;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 507202F9A1; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 031/120] hw/display/virtio-gpu: validate stride
 against width on scanout
Date: Wed, 12 Aug 2026 17:48:14 +0300
Message-ID: <20260812144955.649205-31-mjt@tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Validate that the framebuffer stride is at least width * bytes_per_pixel
in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout().

A guest can set a very small stride while using a large width. The total
size check (offset + stride * height <= blob_size) passes because
stride * height is small, but pixman reads width * bytes_per_pixel per
row, causing heap OOB reads. The leaked data is rendered to the host
display.

The check is added in virtio_gpu_do_set_scanout() to cover all paths:
blob scanout, non-blob scanout and migration post_load. The additional
early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
configurations early.

Fixes: CVE-2026-63109
Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3989
Reported-by: Tristan @TristanInSec
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 861372428b05f74a1cf9a8af22a863aa7b46c7ce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 81d65ec57ca..10f55bd2ae8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -646,6 +646,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
+    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: stride %u too small for width %u at %u bpp\n",
+                      __func__, fb->stride, fb->width, fb->bytes_pp);
+        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return false;
+    }
+
     g->parent_obj.enable = 1;
 
     if (res->blob) {
@@ -757,6 +765,14 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
     fb->width = ss->width;
     fb->height = ss->height;
     fb->stride = ss->strides[0];
+
+    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: stride %u too small for width %u at %u bpp\n",
+                      __func__, fb->stride, fb->width, fb->bytes_pp);
+        return false;
+    }
+
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;
-- 
2.47.3


