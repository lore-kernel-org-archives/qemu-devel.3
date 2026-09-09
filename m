Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F75C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G6T-0005LA-Py; Wed, 09 Sep 2026 07:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6S-0005F7-TN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6R-0005If-1g
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTpKPp9bmfG57LODxp6RB5dmZ5vLEDP1G4fJc7F1tIc=;
 b=QSi11ebJgM0CxzpExmq8MtxdeQHSrpeZnKWidWKbWGGUkoaLQK3hnan63AAtF1yDaziqdc
 fJz9Usj4lnTjF/j9qSPxoBG/xeYqO7ImkbFW4ux3WR0ZR2y435TMngI5htNLysfb2qe3Z5
 MgW7TkaiPTl6uEPUPiHJpNTHlNEKqjY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-gO2-2FzXOmCFLH7mv3sVGg-1; Wed,
 09 Sep 2026 07:04:25 -0400
X-MC-Unique: gO2-2FzXOmCFLH7mv3sVGg-1
X-Mimecast-MFC-AGG-ID: gO2-2FzXOmCFLH7mv3sVGg_1788951863
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4DA31800752; Wed,  9 Sep 2026 11:04:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE4191800473; Wed,  9 Sep 2026 11:04:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:20 +0400
Subject: [PATCH v3 15/24] contrib/vhost-user-gpu: drop scanout_bitmask
 bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-15-99266590e79d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6B5EZCR/TOMDpLrG+wIPlLqHW5uL7luP1S9QLKLFUPM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzzZhSp933dA+hl+r6VOt/z/987iU12/KkD1
 Xd3JBIK0AKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5eIlD/4/YS079KBlhHF6bw7bKiOEKs48XI6Msv1J52E/iEoXNea/fldfai+hsv4cO2VdVvNReob
 8WCTq1R6+J9jBDXA+aQFIrIVIb9YmXdVOoZi2+EOcM34CTgz/54O4AHDAKf7Yu4F/aL7Uhnmyvh
 FfLFSeQ9d/pi3lYbdlRaz+M+thb173QfTLTIXoWbciEC5yGkRVDNNMt9JPdNMK3g4AjZ6pLQF5/
 m6t3ltb1npg/LU4/2PbVj7ijOOZr4u7vqRfWYEwQd1FD4x0l/cX/qqIwD27XW/V2BVZI3qdqD4Q
 hDYJjf8mi/KKIjGqgz4+MdVdU+nRwGD0JdgAO1tshpSHJ4OQaJyeJZKOWuZVoIGj5sBG4nlKP9/
 8KuWrzkUMiDCNtwJf7USzaFem9JmCFacQdPnesjnxowmbaO8Bg69w26qykjFdf9Jqe2HshzDVWV
 2ZvwPxfq3yyCARmB8Msgu1A6HAeX+oLBkZmi+yq7Y1UkskR/upqpd+EYno4tGCNYf7cTV4CANtQ
 Nl0Irq/2PAH41BDNAINdYZG9jNteypURijKeeOsCvWAvjfc3psTmlBtaFMnC4EFvksy8FA9hANA
 57Vhfx5S6ulqbx9USlGcCYxZOYEUN66x9+0oKxplVXMob8MlGx6kzp8YmdvZUZLS2wunk6I7WpM
 89f//cw9areCBlg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


