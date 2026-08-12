Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB3C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8m9-000465-ET; Wed, 12 Aug 2026 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kG-0003HB-AP; Wed, 12 Aug 2026 09:11:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kE-0006KJ-BY; Wed, 12 Aug 2026 09:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=HmMyDx8c9e97htP2vZBib5D2cm4Ket0MZOrjyDd7mQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sbP/eEs3vetxhNNPk4Ou3Ex+UrkngcOAUb8tRnYHfhwEEvngqtWX/NNIadztOS7/M
 1r8WjRkXWIkVExHcxuWJpgrxwk+rL9muWcCowIm2jZgjFQEGcQoHHaGxoc3F6RsPz/
 U8rJXSYPrtqgN0rAUDledUcPJrcYUNEVyO49IgbCI++nVpPFxfBCd2i6DGPadGEVrR
 XvCqkSr8Y1tLbZMkqMXVNDXHYYS2Ng5dQJIOZf7kyApCRysb6n0id3+p9ymuCgrk1Y
 5925ZcbeUvhf1ZWRh0YSnRlJ2HA0Dn7IorAMo6uyqGXtne4CBpYzqlS6rhU8NHX15i
 D55p5tvbQoaKw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACD531CA4D9;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E31BE409BBC;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BC1F92F948; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 090/102] vhost-user-gpu: fix integer overflow in
 buffer allocation
Date: Wed, 12 Aug 2026 16:02:05 +0300
Message-ID: <20260812130233.621965-90-mjt@tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A malicious guest can trigger a heap buffer overflow in the
vhost-user-gpu backend by sending a VIRTIO_GPU_CMD_RESOURCE_CREATE_2D
with large width and height values (e.g. 65537x65537). The allocation
size width * height * 4 silently wraps in uint32_t arithmetic,
resulting in a much smaller allocation than expected. Subsequent
VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D writes past the heap buffer.

The in-tree virtio-gpu device (hw/display/virtio-gpu.c) already handles
this via calc_image_hostmem() with uint64_t arithmetic and an overflow
check. Apply the same approach to the vhost-user-gpu contrib backend:

- Add an overflow check in vugbm_buffer_create() rejecting dimensions
  where width * height * 4 exceeds UINT32_MAX
- Promote the size arithmetic to uint64_t in mem_alloc_bo() and
  udmabuf_get_size()
- Check the return value of vugbm_buffer_create() in
  vg_resource_create_2d(), which was previously ignored

Fixes: CVE-2026-15264
Reported-by: "Vulnerability Report" <vr@darknavy.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3940
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
(cherry picked from commit a113e0c53fb50d78529fd5ea79e3b8313a7ddcaa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index bb41758e345..ee9858c397c 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -388,7 +388,13 @@ vg_resource_create_2d(VuGpu *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
-    vugbm_buffer_create(&res->buffer, &g->gdev, c2d.width, c2d.height);
+    if (!vugbm_buffer_create(&res->buffer, &g->gdev, c2d.width, c2d.height)) {
+        g_critical("%s: buffer creation failed %d %d %d",
+                   __func__, c2d.resource_id, c2d.width, c2d.height);
+        g_free(res);
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
     res->image = pixman_image_create_bits(pformat,
                                           c2d.width,
                                           c2d.height,
diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
index 503d0a4566f..710d5452977 100644
--- a/contrib/vhost-user-gpu/vugbm.c
+++ b/contrib/vhost-user-gpu/vugbm.c
@@ -13,7 +13,7 @@
 static bool
 mem_alloc_bo(struct vugbm_buffer *buf)
 {
-    buf->mmap = g_malloc(buf->width * buf->height * 4);
+    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
     buf->stride = buf->width * 4;
     return true;
 }
@@ -53,7 +53,8 @@ struct udmabuf_create {
 static size_t
 udmabuf_get_size(struct vugbm_buffer *buf)
 {
-    return ROUND_UP(buf->width * buf->height * 4, qemu_real_host_page_size());
+    return ROUND_UP((uint64_t)buf->width * buf->height * 4,
+                    qemu_real_host_page_size());
 }
 
 static bool
@@ -293,6 +294,12 @@ bool
 vugbm_buffer_create(struct vugbm_buffer *buffer, struct vugbm_device *dev,
                     uint32_t width, uint32_t height)
 {
+    uint64_t size = (uint64_t)width * height * 4;
+    if (size > UINT32_MAX) {
+        g_warning("buffer dimensions too large: %ux%u", width, height);
+        return false;
+    }
+
     buffer->dev = dev;
     buffer->width = width;
     buffer->height = height;
-- 
2.47.3


