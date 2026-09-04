Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D51C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2The-0005bv-No; Fri, 04 Sep 2026 09:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thd-0005Yl-CV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thb-0005Ac-M6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAaK0yhjS0Ztp5ky/+LpGTZUDzifpD2VL1IIx2cZVaI=;
 b=HRutBHTO8QO74TRk2PSnRkdUe1EqpWuHVKvwtLaSKAzqNj8ooY3GTPZKzexuqOzkZVeaXW
 2a7zSh9PeCqHmR5p2J1RYA43IAcJkU2mguIEp811BBpVLqZbST3xn2ROgIDbQgkzxkqjFy
 FxaqVhMXMdEpnzwTqbI0OL8PkcoCQmE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-cv97j8h-Mm-F9bfC19pXCQ-1; Fri,
 04 Sep 2026 09:11:25 -0400
X-MC-Unique: cv97j8h-Mm-F9bfC19pXCQ-1
X-Mimecast-MFC-AGG-ID: cv97j8h-Mm-F9bfC19pXCQ_1788527483
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBE8B1925776; Fri,  4 Sep 2026 13:11:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 740CF3000223; Fri,  4 Sep 2026 13:11:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:21 +0400
Subject: [PATCH v2 17/25] virtio-gpu: drop scanout_bitmask bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-17-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
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
 bh=jQVxNMscLnmbP4WigWrn6p+D1DEvXhd1N0hmCD3n39Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwZQRgaiUJDuJ9lp556ITBI0zt9mImsouBZ
 UGa7XeCuwiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5WAiEACLFX67Aid+xTxLoBe4C1tl/mGUtomfc3WRKZa6F/gkESkf8NC7nvQmlUSzyAWWyzND7GT
 52wjIq3J3GFaD1XP31hpgxXGePY6kPQJO98IVREKxyOnOTFErlQS9LFOJ21hnqPmNs2/AIpQUQE
 y2PtpsNLMzJxA6gKxn6xvr26d27pTazVEhxYuBqUg2wpE1cF1N4s8yox3bi3FkTsphAdg4xxA9P
 mTueEhm0Cq6gapEWOQq0GTh3ST/CEzu+RQ/690l9lys7lZ3sxPkOAEBQwCx/oOoJtg4+AybFIrh
 ABhmlkdQsLZmslxlaAK0WPkyNhhsjRluD0Swy2Gw0qj00Tueef9k0tPsl05yKtVkYQzEj19/1OT
 Dz0vObrBGYGhoPFrsWFzxMr2dhdw+IrrmrIIr8zeGTlSWFvmzWZglBaBKP4glg68ncJyvru5anE
 0U/SUY6WrL+oy51BZRMzU1F7dguE40955y64r1ysFqIpIyFghHc2GwKU/47pXJw5gTWIc/pOxRB
 FmvNKJu+3D3XHyfY3Ei7I4QWsC3U2Hn9Z/lK4/Z9Bih/buvpEdOAuChtpNnlvu5/8YxitBJGJD5
 qz39YBeyqbNdYVJz+OjWLKeqb3IVKamSl4wekphM+dmLJV8oGzhI3lglM8L27LWlCN/Wh6Ki3O7
 AQTD5LgIJN0/kfA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 95c905b4fec5..b244afb69e4e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -434,12 +434,6 @@ static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
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
 
@@ -456,11 +450,9 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
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
 
@@ -639,10 +631,10 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
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
@@ -667,16 +659,9 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
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
@@ -1707,7 +1692,6 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
-        res->scanout_bitmask |= (1 << i);
     }
 
     return 0;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index c2018b41056f..071cbbb6113e 100644
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


