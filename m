Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A21C61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoKU-0001S6-7l; Tue, 25 Aug 2026 06:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKS-0001Ra-EB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKQ-00061o-VJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSmR9dNgcxhkW1f0xItF+J03z6SZAA/S+RHpdsCIeP8=;
 b=WrsgNj2yBMNu2QqkNxVnpXL50o0s30WkQLt+ZuFW3KqIpb9ou1K8+Sre9LcGzGUi3CkoAA
 5Rb5QQNTo0wgEkPNwLF45ffkIt01GzFEGyFM8ETKADXijPQJzS9HEgtOlKjiRmIBGRLHXQ
 1surOLo+16NfJiasG7GgkvCQh3O2clE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-87Bv7DvKPN-i4kfN-BZhGA-1; Tue,
 25 Aug 2026 06:24:21 -0400
X-MC-Unique: 87Bv7DvKPN-i4kfN-BZhGA-1
X-Mimecast-MFC-AGG-ID: 87Bv7DvKPN-i4kfN-BZhGA_1787653460
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCC11180883E; Tue, 25 Aug 2026 10:24:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F642195604A; Tue, 25 Aug 2026 10:24:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:48 +0400
Subject: [PATCH 11/18] virtio-gpu: drop scanout_bitmask bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-11-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RUnzO1ES/piqV0h109hympaotXHFUXO2eIbxaiKafMM=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqNbJihLPzBUjZih1gCJqpGNTCq/BfrQGkYSYV2+8Y0Hc5S4
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqjWyYAAoJENro4Ql1lpzl1lcQAIU2
 z2kJXjajLXcWhocgfq5lw7nsDsIQSG1W4brDwMt/WUJQwjDE2fP7l+uUU1nVVWdIbyXH/POCC4f
 vlG/xq/xA08w2X6RXmYxdCyy510Wy2l6dBzGjV4o1aCH9iRoJPSx8z0SeoqvJ4Qll80rCVS4pj7
 FVib3kUc0gdbJ0aBlASPmOJKEMoZG7Ma8IxPJTseMYil6rOvKvl6nVAhra2K+tm7mjnROqHwZax
 pMZPRccFlkYusug635mQIkAb9F0DhFu6BVUQ0/wPgnxVEdmHG6tLsky1agEqd8RXDFTzleuwLPT
 OYwr99mWJabSvYG0UdVanLHpPkVi0CEDgMXaao8znM4JU0WWxXz2Nja3nfiz1DhTtqdm0Pko62q
 7d7tW0EKziTEsBay47c0L9gY4Erj6fZvLMwHlTDsLcafyTAtsExRW2h+Sqw+DCDUNSvC7A5NFpD
 394/oQPDMPYxP9eyE+GeBllGAEav0iOiPV3Fntv9J+5MNrQY99OTxvTJcqlWLHAqeJpzVu+eEVL
 /nGuDaZT6X9UaAif9O7oPGYBFtu+ut+yDMvfh5vNGnM0DPgDYZi6o3vHAofFYs7F8u29nkM/l3G
 xCLuS2NPR86Nl/plui9qhSuQmMbV23oCjkyeIMWhBP2v6TXAJ5p0VyCD0ZpBB42MSYgd17uXiuM
 i1v37
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The per-resource scanout_bitmask is a reverse index of which
scanouts reference a given resource. The information is already
available from scanout->resource_id. Performance impact should be
negligible.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c        | 26 +++++---------------------
 include/hw/virtio/virtio-gpu.h |  1 -
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e547cac60398..5362f7a4c269 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -403,12 +403,6 @@ static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
 void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
-    struct virtio_gpu_simple_resource *res;
-
-    res = virtio_gpu_find_resource(g, scanout->resource_id);
-    if (res) {
-        res->scanout_bitmask &= ~(1 << scanout_id);
-    }
 
     virtio_gpu_release_scanout_dmabuf(g, scanout_id);
 
@@ -425,11 +419,9 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
 {
     int i;
 
-    if (res->scanout_bitmask) {
-        for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-            if (res->scanout_bitmask & (1 << i)) {
-                virtio_gpu_disable_scanout(g, i);
-            }
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
+            virtio_gpu_disable_scanout(g, i);
         }
     }
 
@@ -593,10 +585,10 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
         QemuRect rect;
 
-        if (!(res->scanout_bitmask & (1 << i))) {
+        scanout = &g->parent_obj.scanout[i];
+        if (scanout->resource_id != res->resource_id) {
             continue;
         }
-        scanout = &g->parent_obj.scanout[i];
 
         qemu_rect_init(&rect, scanout->x, scanout->y,
                        scanout->width, scanout->height);
@@ -621,16 +613,9 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
                                struct virtio_gpu_framebuffer *fb,
                                struct virtio_gpu_rect *r)
 {
-    struct virtio_gpu_simple_resource *ores;
     struct virtio_gpu_scanout *scanout;
 
     scanout = &g->parent_obj.scanout[scanout_id];
-    ores = virtio_gpu_find_resource(g, scanout->resource_id);
-    if (ores) {
-        ores->scanout_bitmask &= ~(1 << scanout_id);
-    }
-
-    res->scanout_bitmask |= (1 << scanout_id);
     scanout->resource_id = res->resource_id;
     scanout->x = r->x;
     scanout->y = r->y;
@@ -1609,7 +1594,6 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
-        res->scanout_bitmask |= (1 << i);
     }
 
     return 0;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index d3ca8d82586b..1816cb21de76 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -51,7 +51,6 @@ struct virtio_gpu_simple_resource {
     uint64_t *addrs;
     struct iovec *iov;
     unsigned int iov_cnt;
-    uint32_t scanout_bitmask;
     pixman_image_t *image;
     qemu_pixman_shareable share_handle;
     uint64_t hostmem;

-- 
2.55.0.543.g5ebe2ebe4ea8


