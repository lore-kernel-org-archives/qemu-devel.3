Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B37DC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G6a-00064K-Un; Wed, 09 Sep 2026 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6Y-0005pn-Kh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6W-0005K7-Ln
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYeXAmDf1Odc7i8PeL79UpH2Py/hNhTm0ExEtDUltCQ=;
 b=TrEAuyhzymgqsxpNgM00JGX7PTcyaXYd+zjrINSwP3IRhhPpZOneY2b/rpVZaJ9IYLYF9u
 6GnIka5EZRhowm3RWHHLhTpPF9GZZJ37icRw/NXgev2BZXW52sE1tvh+byXmtb2UIDZrjR
 PlRWndC7d3ssqbSPK11VRxZxyb3wGC0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-Zrm0SNr3Oc2vL34k9CzQAA-1; Wed,
 09 Sep 2026 07:04:32 -0400
X-MC-Unique: Zrm0SNr3Oc2vL34k9CzQAA-1
X-Mimecast-MFC-AGG-ID: Zrm0SNr3Oc2vL34k9CzQAA_1788951871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BEC818007ED; Wed,  9 Sep 2026 11:04:31 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 019B01800446; Wed,  9 Sep 2026 11:04:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:22 +0400
Subject: [PATCH v3 17/24] virtio-gpu: drop scanout_bitmask bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-17-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3592;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7Xe5PKyYiFdYI1lfnr9DrXWRq+TC3ng9j+1LCsQI3Lo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzz+KQcETOUEsYnG9QeQ83M9jU2pzEIvEkXm
 65gfqojlG2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5dMDD/96aqtM5cHSMAAhPZqhl5atikqFlouGTkrbU/Vfr7GgjbPca0rC+Rw60R9t28rrLG2WV/D
 V/Ix627mHTfDlUvEZlPrb0YpJcXgZsyx+jNjSJW8sw+O6jGYOHuNq7yxDrMvrOwPebbLdhy79yc
 lyuuotpVKAktk5d4wz2BXYRkVsQDwFex6pbhL5Cnes+Wb0PwwuS4etN7rBVUqKj5fPytyLr3XVz
 9htMucBiaQYIVN2QzfPLguN13BTIcm5MmPPQxQLZIs+O/p1LVnkha+GiZ7D81LkNml714gJOWpv
 VOwHVkMUzsoV1K24B6xrdYYH9yCTlNkZ5rtFc+FKYPQoIHzFff15G2+ZdrsUpvl4fnNYs/TOiba
 zaqJX6IFiTF19FY8mwhGUATv9AWdOz2iEa9piAGsJZS+Gs8qnl5gvDEp4NgwnJiwQOqEVuvPgk1
 ZklZfWvoz3iFjY/8FvHEyKXNQNJg7xGJxwS8AdkZfMK5DBwWHKcW9Lb7qjKFjbZaf27fL9pqwRS
 5IqfKSsL3iicxsMkz/z8peZ7I+CANkazs+PONxl5UVzfWho7TqghlL0WObZNMno3OanNO5yMvl8
 3tpGI9oCf+9+aMaS/vSQdcwElmBsAY6i6qP96M0SaTdnDunFT3Vi+d+y6o23mrrTwtRb9hFjPVl
 tCURm0UHaZ91kBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The per-resource scanout_bitmask is a reverse index of which
scanouts reference a given resource. The information is already
available from scanout->resource_id. Performance impact should be
negligible.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c        | 26 +++++---------------------
 include/hw/virtio/virtio-gpu.h |  1 -
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bcde65b50349..6e021b78b890 100644
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


