Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1395EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjG8P-00046d-JW; Mon, 13 Jul 2026 08:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjG8M-00046P-3W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjG8K-0005mR-89
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xBCRhKksK85VC4gIzUEZycAGMGy0x9PL2hAUdX3iQeM=;
 b=Df7G0gSv5pbjYlOY8FJEvYX2TIhwNaKJa1SRLVh7CyNmElU9Kt58jOZaEBUtW4Yj5xwQul
 IyZgpsaSNdJq+Vk+lJrbBAJKUjb/lrCOfBiL1Gz76uxl7Te16p/P0xP5wWsEWbZVZbwme+
 v8gyygIKttalehX83WT9krWcesRktKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-YFtPgcdUMSy1AtU948EdFQ-1; Mon,
 13 Jul 2026 08:51:36 -0400
X-MC-Unique: YFtPgcdUMSy1AtU948EdFQ-1
X-Mimecast-MFC-AGG-ID: YFtPgcdUMSy1AtU948EdFQ_1783947096
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E44D51955D5E
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:51:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5735936F29; Mon, 13 Jul 2026 12:51:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] hw/display/vhost-user-gpu: validate message payload sizes
Date: Mon, 13 Jul 2026 16:51:30 +0400
Message-ID: <20260713125130.101787-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 57360898ca0..cd684d63639 100644
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


