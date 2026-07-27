Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3C5C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJs7-0005MI-0n; Mon, 27 Jul 2026 07:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJs5-0005H8-CZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJs3-0003ee-IH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qehTNLc2Jh6L2YaZibtPwTJ9+4FXPg2W3cevn1UdqpU=;
 b=h4e9A1XbWkHNNkXqJ37tEG/vBQtjHRAmZDNvv2GxrynwDQXhgQEjOdozpJxsIJvvAhr1Vb
 72Q/fbdl0hMdwewArLhK9mWtuxFS4p1sXhNobJrWQgSV4xKnudGGbvlng8WnCIrma8+FpE
 qXDGYP6aLLzjE86XujJT0C8xJClogrQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-KONfBw0qOuSlOsNVgZQeRQ-1; Mon,
 27 Jul 2026 07:51:45 -0400
X-MC-Unique: KONfBw0qOuSlOsNVgZQeRQ-1
X-Mimecast-MFC-AGG-ID: KONfBw0qOuSlOsNVgZQeRQ_1785153104
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29CD61954B28
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:51:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9F221955F74; Mon, 27 Jul 2026 11:51:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:11 +0400
Subject: [GIT PULL 02/23] hw/display/vhost-user-gpu: validate message
 payload sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-2-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WeuQ+Ag+ovL1UQ7DOEoC3DSLDD6wamv5Uo4NoeqyEBE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+ke2vrcz2BFO4gVThW6znI8hk+CZzaEH9Z
 yr03tm6GLKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5acxEACabWuuymaXaJAldku+yJzRdXuZnF/5iZy2l0sOZK4yRqiOp6ODrMaEf9X0ge2dWxN6Iy9
 ARWn+LzAqzkCnyIGPwmrYoqGFVmTHZTw+7Ac/aOc3o108M+Oidro4pxZOGFkJVBs7OhKjczaXd4
 j6tyXXHpsH0SZe1TmxaoKXPP1XbFpE7iKFHKs/FFpQMVggAnJ8+b1wIHfa6chtC7y27j9bihXyc
 HneNjHXkHyXTfG7Td53Twfx0c/d6BEXPTMX4KhIuJn1UUqrSYIFNvKNRiBmlKSKfmvuGX1spGw3
 PjJFJgvCNnOnZ1r6niYp8g+fEhmZXe4A8z19MY4y0W3vXhhIt8PGTOWpZ+u6xY2YW9szQClcN7c
 uZhFEYNDCBmYauM/EZ1qsI9MRr9co/df+OVEET9RWJV5kAbRSDmY7T2s1FDW5u4129GJ3m1xEgn
 syLlC2RAkIT0zH3gW71XMaDgvROc6zkhshHK3zbz0L0MpEQEYrmro+mT5EG/cV+6JuAmKBu7tsf
 Wk4O9uUwOsvn5vnHHqv21H/AqOMtlPbYdPcps5eByBPOcq02zHwkRY5NZxNyMPGRZ3PBcSThW2v
 E/L0qeIF+pOmxya276hvadmRSZMrx09HgkWPBdOP4n5CY8b7Gds6TfOq7gw7VqYBGVaSg01x8ta
 U0TEzv1vjkBvy6g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A malicious or buggy vhost-user-gpu backend can send messages with
undersized payloads, leading to out-of-bounds reads when the handler
accesses struct fields beyond the allocated buffer. However,
vhost-user-gpu is considered trusted by QEMU by design (it has access to
shared memory etc).

Add a centralized minimum payload size check in vhost_user_gpu_chr_read()
that rejects messages before dispatch, and a per-pixel bounds check in
the VHOST_USER_GPU_UPDATE handler to ensure the variable-length data
covers the declared width x height.

Fixes: 267f66465 ("hw/display: add vhost-user-vga & gpu-pci")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3866
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 57360898ca0d..cd684d63639e 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -119,6 +119,31 @@ static VhostUserGpuMsg m __attribute__ ((unused));
 
 static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked);
 
+static size_t
+vhost_user_gpu_min_payload_size(VhostUserGpuRequest request)
+{
+    switch (request) {
+    case VHOST_USER_GPU_CURSOR_POS:
+    case VHOST_USER_GPU_CURSOR_POS_HIDE:
+        return sizeof(VhostUserGpuCursorPos);
+    case VHOST_USER_GPU_CURSOR_UPDATE:
+        return sizeof(VhostUserGpuCursorUpdate);
+    case VHOST_USER_GPU_GET_EDID:
+        return sizeof(VhostUserGpuEdidRequest);
+    case VHOST_USER_GPU_SCANOUT:
+        return sizeof(VhostUserGpuScanout);
+    case VHOST_USER_GPU_DMABUF_SCANOUT:
+        return sizeof(VhostUserGpuDMABUFScanout);
+    case VHOST_USER_GPU_DMABUF_SCANOUT2:
+        return sizeof(VhostUserGpuDMABUFScanout2);
+    case VHOST_USER_GPU_DMABUF_UPDATE:
+    case VHOST_USER_GPU_UPDATE:
+        return sizeof(VhostUserGpuUpdate);
+    default:
+        return 0;
+    }
+}
+
 static void
 vhost_user_gpu_handle_cursor(VhostUserGPU *g, VhostUserGpuMsg *msg)
 {
@@ -322,6 +347,14 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
             break;
         }
+
+        if ((uint64_t)m->width * m->height >
+            (msg->size - sizeof(VhostUserGpuUpdate)) / sizeof(uint32_t)) {
+            error_report("vhost-user-gpu: update payload too small"
+                         " for %ux%u", m->width, m->height);
+            break;
+        }
+
         s = &g->parent_obj.scanout[m->scanout_id];
         con = s->con;
         pixman_image_t *image =
@@ -396,6 +429,11 @@ vhost_user_gpu_chr_read(void *opaque)
     msg->flags = flags;
     msg->size = size;
 
+    if (size < vhost_user_gpu_min_payload_size(request)) {
+        error_report("vhost-user-gpu: message %d payload too small", request);
+        goto end;
+    }
+
     if (request == VHOST_USER_GPU_CURSOR_UPDATE ||
         request == VHOST_USER_GPU_CURSOR_POS ||
         request == VHOST_USER_GPU_CURSOR_POS_HIDE) {

-- 
2.55.0


