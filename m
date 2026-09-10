Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE74C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4esM-0004gC-R9; Thu, 10 Sep 2026 09:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esK-0004W1-Vx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esJ-0003jN-Fb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTpKPp9bmfG57LODxp6RB5dmZ5vLEDP1G4fJc7F1tIc=;
 b=M3dvtdLsmrYACo+JMSjSem4NrsgsFrfv1z0L0YWJa9iZ1Yu+3GorSztwILHOA4LzsBMkol
 x/Yalm1yTvF4X7cykqsdBe3uMc8chPatn6zisb5GGYumjBDuUsCg4cdnep7Mt2C0P9tWPM
 7nTaaNXPpr6LiIdUGFfMQZvE6iFS/X4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-MO0PGOZJMdS8vRSs5Y4ENw-1; Thu,
 10 Sep 2026 09:31:32 -0400
X-MC-Unique: MO0PGOZJMdS8vRSs5Y4ENw-1
X-Mimecast-MFC-AGG-ID: MO0PGOZJMdS8vRSs5Y4ENw_1789047091
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37A341955E79; Thu, 10 Sep 2026 13:31:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61C7846E; Thu, 10 Sep 2026 13:31:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:10 +0400
Subject: [GIT PULL 15/24] contrib/vhost-user-gpu: drop scanout_bitmask
 bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-15-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6B5EZCR/TOMDpLrG+wIPlLqHW5uL7luP1S9QLKLFUPM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDcxL8qF8e9Ko0TqTkI+b6iOSH1OLz6IjyaA
 /tDZc5VZHGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3AAKCRDa6OEJdZac
 5X67EACyybLiSOWMUrA0SBYKs4SFD9I92nz3wL7lynqPhvoddWqcOwrA8UpUP/XJx2voM177tzy
 MavaMcHpyra2KioTXdZodr6ruK6zLs19l0iHwZtYd1t2Hmd8ZdGkJl7aBCW92EBSJ8rzedKUgHA
 1i04RV0gx0xDhwTzbqgQntUp5WotVHGLoy/0BMNY+ILF4ABQmVwV0PCEpeeNRZBGOhwyhh1fpCf
 7L+9xY5qA/YBc5t/rYwD82eyRa5214SV5xmDz0Flstg8fEZKD3zMC2e2I8yGxI1nbTkQkWhoJ6U
 RvG2twFRnauVloRY+3CDoQiALniHhj+1mr3jJ6CfekaT23th4E8uacueSwVmojLMTaTpevo4HW1
 mOm7Qwv3jpvsc1SYnc44KMmPC7A3nREzhVUaeZXsOezR/zjJ9XWLc1QkfggGadjTRtbwkgIJyYt
 1vBdGlrsdWuYOSNHtK7e6YDPyI+EAomQHE7kCfVFvEbkOCu4Zdmr9jRItHWvKKnD2b4vzEaH64i
 MfT9ZolZFBBV7lGKX48pWYawOIawKBkkKROcuHHUzvgL1jDfOSfJBx33aJHR1y1K599lzOcXqHB
 NgIMhgxuFJUAXdZxk9q0iZr9L6keycNn5IocOfYCsIrdDJ6P727V6/MPNa7no/Ku6ib5L62sF6O
 201cCzkg1EK2MFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The per-resource scanout_bitmask is a reverse index of which
scanouts reference a given resource. The information is already
available from scanout->resource_id. Performance impact should be
negligible.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index 933bdbb671c0..f70b34c179f3 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -36,7 +36,6 @@ struct virtio_gpu_simple_resource {
     uint32_t format;
     struct iovec *iov;
     unsigned int iov_cnt;
-    uint32_t scanout_bitmask;
     pixman_image_t *image;
     struct vugbm_buffer buffer;
     QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
@@ -416,17 +415,12 @@ static void
 vg_disable_scanout(VuGpu *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->scanout[scanout_id];
-    struct virtio_gpu_simple_resource *res;
 
     if (scanout->resource_id == 0) {
         return;
     }
 
-    res = virtio_gpu_find_resource(g, scanout->resource_id);
-    if (res) {
-        res->scanout_bitmask &= ~(1 << scanout_id);
-    }
-
+    scanout->resource_id = 0;
     scanout->width = 0;
     scanout->height = 0;
 
@@ -446,11 +440,9 @@ vg_resource_destroy(VuGpu *g,
 {
     int i;
 
-    if (res->scanout_bitmask) {
-        for (i = 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
-            if (res->scanout_bitmask & (1 << i)) {
-                vg_disable_scanout(g, i);
-            }
+    for (i = 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
+        if (g->scanout[i].resource_id == res->resource_id) {
+            vg_disable_scanout(g, i);
         }
     }
 
@@ -662,7 +654,7 @@ static void
 vg_set_scanout(VuGpu *g,
                struct virtio_gpu_ctrl_command *cmd)
 {
-    struct virtio_gpu_simple_resource *res, *ores;
+    struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_scanout *scanout;
     struct virtio_gpu_set_scanout ss;
     int fd;
@@ -707,12 +699,6 @@ vg_set_scanout(VuGpu *g,
 
     scanout = &g->scanout[ss.scanout_id];
 
-    ores = virtio_gpu_find_resource(g, scanout->resource_id);
-    if (ores) {
-        ores->scanout_bitmask &= ~(1 << ss.scanout_id);
-    }
-
-    res->scanout_bitmask |= (1 << ss.scanout_id);
     scanout->resource_id = ss.resource_id;
     scanout->x = ss.r.x;
     scanout->y = ss.r.y;
@@ -797,10 +783,10 @@ vg_resource_flush(VuGpu *g,
         pixman_region16_t region, finalregion;
         pixman_box16_t *extents;
 
-        if (!(res->scanout_bitmask & (1 << i))) {
+        scanout = &g->scanout[i];
+        if (scanout->resource_id != res->resource_id) {
             continue;
         }
-        scanout = &g->scanout[i];
 
         pixman_region_init(&finalregion);
         pixman_region_init_rect(&region, scanout->x, scanout->y,

-- 
2.55.0.543.g5ebe2ebe4ea8


