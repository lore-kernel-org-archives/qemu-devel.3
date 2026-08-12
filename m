Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD30C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMH-0001f1-0t; Wed, 12 Aug 2026 10:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKj-0006ti-Ft; Wed, 12 Aug 2026 10:53:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKh-0007Ah-PC; Wed, 12 Aug 2026 10:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=wQSppIRnVOtI/EJeAnabdmFvHwBZRi6B4PHGE+18fkc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tZq5bCvlDjm5SMEqrHpV7kH2lcQQpZ0ofTbTI14xOvIwJqNCD+d6saJJEXriS/Hca
 mV/MX6XoldXkN2VkmNphCBHRUq0VLQx14s10Pnh2ySnlZAGpEM/m7nBq9lvIn07M/+
 36X0+jN/CBTTCXqt3GCr6+RGw+kcNzJVE+uMVjz0BzTG6yOsq0GEwfqBvh9Hj3rbE9
 /qaeIis8S3Hb1tjHN5BeqrNQTGSQ6k1CKGDPI6jMo0lsF41iezZbSfchzPi0NBtM1I
 PzEVdKf0RgfdsXHxuHrNyZ9exfkIwbhTgunPRQgCaGIzBD6DXGs3OQKcQbf8vFczax
 Dlo/C1ZaVILmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F4231CA626;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 05A8F409D65;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 652AC2F9A7; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 034/120] hw/display/vhost-user-gpu: validate message
 payload sizes
Date: Wed, 12 Aug 2026 17:48:17 +0300
Message-ID: <20260812144955.649205-34-mjt@tls.msk.ru>
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
(cherry picked from commit 1c1232c2ee0798e5f8446200005f045a153a5648)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 3f6fb7a8033..25abdf86363 100644
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
2.47.3


