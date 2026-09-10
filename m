Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16836C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4esY-0005AT-7G; Thu, 10 Sep 2026 09:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esW-00056H-Ha
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esU-0003l0-Od
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYeXAmDf1Odc7i8PeL79UpH2Py/hNhTm0ExEtDUltCQ=;
 b=RUT7ITTu1955QsSBnjcZDRrgeRDya9gIuqV1CZ2Meh+USABRc1fp4WiDTLU/nqh7L8TQ28
 9vKZLrYDfoFg0P8owiUGZAOlN2XKrmvxSSlznWpyCazwZYweTw2ZZUE3f1upa2AaRm5Try
 yV0iNZorKEhwxWXa7HfFVUXpNQOmB9w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-uu_2x35qM66Hbnl7WTPUyQ-1; Thu,
 10 Sep 2026 09:31:43 -0400
X-MC-Unique: uu_2x35qM66Hbnl7WTPUyQ-1
X-Mimecast-MFC-AGG-ID: uu_2x35qM66Hbnl7WTPUyQ_1789047102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EB3B1954123; Thu, 10 Sep 2026 13:31:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1C271800473; Thu, 10 Sep 2026 13:31:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:12 +0400
Subject: [GIT PULL 17/24] virtio-gpu: drop scanout_bitmask bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-17-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3592;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7Xe5PKyYiFdYI1lfnr9DrXWRq+TC3ng9j+1LCsQI3Lo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdLs88Uu7oiOykgI8Lzx3PkWVccMyRWW6vF
 /Iux+bvJUyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5RXHD/9n0UIxTe+hhQt+L8oFAPw8+eGytT3uT+Ql9PO36QtYKZuBJkTXbnEDBYR5RSITwkHfYOu
 8PpWKd7sIAooUmv4PahBw9z/EbKhSojP/BahM/uQZrMuIEB/MYaJWwPIVK+MAywgIdpqmehvS86
 8ACtJWwILg4Jd5sk0KdW6oTheE7Z9kdxBfaZEuP2UIg3//jZ3S68rDXwmyY+CkniCM0zRseXGYC
 Knfkn4ANzCK7PHEPFnE/EgRqG12l9WxKobS275WEg9P9Iso2xGXP7ta2QphFVykF+xYmJq2xgZn
 3oq/CnpR3Ns7VJCBTeYCmbthA/cSj/pmJE9WxZ9nkk/L3T7NR81L1/A/RiWweQ7MPSm4eszak+X
 Wx3s/Ac29GnhLyYNSvPES5DokucbqF4yXEKPBzIbDojjPQF8FaKEXLamXMpAvNeyh2RckHBP/SG
 ii+brXhSvFQI6TS9ifKbEKU5nG8yeHgusWRkWUVUvgjDjiRk6MTsXq7TQF2RSNjg2Sneev/uDQe
 fnTNkVpyq63b5Eh3Ko0fAFDcQMt0TyC3iiZgE3CduM5ISylo4xkaAvmqbmwLMXSc3ctMspjvYyQ
 a52cZ8EE5pULXy65bPd+Xuk0bYTlshK5O9oaS2gHqSk2SYGM2MsGTzXGNZvxx+nXhWe9CMwdyhh
 HLL6lQTKZQErl+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


