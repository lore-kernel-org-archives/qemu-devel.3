Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4D2C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbU2-0005tO-OX; Sat, 25 Jul 2026 08:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnbTn-0005ry-Hl
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnbTl-0000sl-JQ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784982465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rUKGsPUYN8ToWm3Jg3qskGLXiIOajZadzxp0CpAvn5g=;
 b=Z5n1RfNP2ECD/2BL1nj53tpEX1lGfvwgXcEvoQVeK7HBeVsA1fDMOkmq5evEr2R280dnxv
 9NDwCV7Ls2RQcpidNveNazuqOKeUhc9Mn4oCYoPqZCormyePVrobbclz8IfVC09uh7YTB6
 NqN7zaWSkRnqUWf2VR8h+/rGhJVszqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-PGCkJMH9PiSlyk6X2esrmQ-1; Sat,
 25 Jul 2026 08:27:41 -0400
X-MC-Unique: PGCkJMH9PiSlyk6X2esrmQ-1
X-Mimecast-MFC-AGG-ID: PGCkJMH9PiSlyk6X2esrmQ_1784982460
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39A85180029F; Sat, 25 Jul 2026 12:27:40 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FFF2195608A; Sat, 25 Jul 2026 12:27:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2] hw/display/virtio-gpu: fix offset wraparound in
 scanout_blob_to_fb
Date: Sat, 25 Jul 2026 16:27:34 +0400
Message-ID: <20260725122734.1775774-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
arithmetic. When the sum exceeds UINT32_MAX, silent wraparound lets
the guest steer the scanout to an arbitrary in-bounds region of the
blob instead of the intended rectangle.

Compute the offset in uint64_t, reject values exceeding UINT32_MAX
(the width of fb->offset), and only store into fb->offset once both
range checks pass.

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")
Reported-by: Cyber_black <Cyberblackk@proton.me>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v2:
 - no OOB, dropping CVE, make commit message adjustments
---
 hw/display/virtio-gpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b21ac8dace08..bc45cfb194f0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -785,7 +785,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    struct virtio_gpu_set_scanout_blob *ss,
                                    uint64_t blob_size)
 {
-    uint64_t fbend;
+    uint64_t fbend, offset;
     uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
@@ -815,18 +815,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
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


