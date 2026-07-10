Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEEDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBZk-00071E-Tx; Fri, 10 Jul 2026 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBZj-00070o-12
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBZg-0000aE-5t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783691247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sPCjzkQx76y26XppBnl21h0+OtBZR7bVuI9xBWFtyF4=;
 b=S62eFdLkf7G5TOdedaRuvt5KAAkYoT/G/wEf95qtyM6HqTANJnZ+94O7r7HAogzkjJG8uD
 dtyBiTlV15su38mFbVSwpy6sPYNfwNGJizArRD/bth+L3Ocy0w3UEDmtzXZB+YCtnGhxX1
 o0wXhRZgO0iu4IZWT8ZE60FGYa3XLzc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-ciQMM4KvN2O2EAI4GqAAMQ-1; Fri,
 10 Jul 2026 09:47:25 -0400
X-MC-Unique: ciQMM4KvN2O2EAI4GqAAMQ-1
X-Mimecast-MFC-AGG-ID: ciQMM4KvN2O2EAI4GqAAMQ_1783691244
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D05C41955F15
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:47:24 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CE133000232; Fri, 10 Jul 2026 13:47:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user-gpu: fix integer overflow in buffer allocation
Date: Fri, 10 Jul 2026 17:47:19 +0400
Message-ID: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 contrib/vhost-user-gpu/vhost-user-gpu.c |  8 +++++++-
 contrib/vhost-user-gpu/vugbm.c          | 11 +++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

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
2.55.0


