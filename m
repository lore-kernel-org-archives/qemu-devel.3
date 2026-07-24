Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6681C4453D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn76S-0000jM-89; Fri, 24 Jul 2026 00:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wn76P-0000j5-O2
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 00:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wn76O-0007fp-3B
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 00:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784865695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x7cEeIFpReF3E/VfocOlGLakTV5amuOYL1ByNNNnHqY=;
 b=Io3pgGoPjK/5D8zqyevzDW3i6A0/VbqrOe2rEXjNknfn7c0PKskvsBtAjekQRnQA7N0Yfy
 pmZZZDZokExWw7HIn79iDJjsjcHSxQIBK7+0ehR6AAk/zSlTpzrdhrC/VlEiyarogr/yCp
 gSkq51QEQJLkKgRcqS1a3dyZQf4DE6M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-BZs_WI-pM4W0Y1wGs4L3MQ-1; Fri,
 24 Jul 2026 00:01:32 -0400
X-MC-Unique: BZs_WI-pM4W0Y1wGs4L3MQ-1
X-Mimecast-MFC-AGG-ID: BZs_WI-pM4W0Y1wGs4L3MQ_1784865691
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7141944E40; Fri, 24 Jul 2026 04:01:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04177158A; Fri, 24 Jul 2026 04:01:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/display/virtio-gpu: fix offset truncation in
 scanout_blob_to_fb
Date: Fri, 24 Jul 2026 08:01:26 +0400
Message-ID: <20260724040126.867935-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
guest-controlled offsets[0], r.x, r.y and stride using uint32_t
arithmetic. The sum can wrap around, so a small fb->offset passes the
fbend > blob_size check even though the real offset lies outside the
blob. The wrapped value is later used as data + fb->offset in
virtio_gpu_do_set_scanout(), letting the guest point the scanout at
host memory beyond the blob.

Compute the offset in uint64_t, reject values wider than UINT32_MAX
(the width of fb->offset), and only store into fb->offset once both
range checks pass.

Fixes: CVE-2026-66019
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
Reported-by: Cyber_black <Cyberblackk@proton.me>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 36d2bd9edee6..d1e32840e223 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -784,7 +784,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    struct virtio_gpu_set_scanout_blob *ss,
                                    uint64_t blob_size)
 {
-    uint64_t fbend;
+    uint64_t fbend, offset;
     uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
@@ -814,18 +814,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
+    offset = (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp +
+             (uint64_t)ss->r.y * fb->stride;
 
-    fbend = fb->offset;
-    fbend += (uint64_t) fb->stride * ss->r.height;
+    fbend = offset + (uint64_t)fb->stride * ss->r.height;
 
-    if (fbend > blob_size) {
+    if (offset > UINT32_MAX || fbend > blob_size) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: fb end out of range\n",
+                      "%s: invalid fb bounds\n",
                       __func__);
         return false;
     }
 
+    fb->offset = offset;
+
     return true;
 }
 
-- 
2.55.0


