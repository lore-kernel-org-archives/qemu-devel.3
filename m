Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789ABC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tj2-0001hC-9k; Fri, 04 Sep 2026 09:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tj0-0001gL-AW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tiy-0005bH-QZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ogN5Q72a9eOOhrFxC1dZ74jR7oqZv4dsYzPV0Ax+hg=;
 b=IrGcFgV7xXapFiQEPaQ7Qhvm+lzKNeGQoz/G+2zpXV+Sbelj+6QtUPlSQ7WKFqlSMMJCTm
 bjoPUEnkTkqWpgsP0nkHZqphwU072k5OvpiNywjCd+Sw49vpnD1JTn4EnEqyC9AFFflKao
 ivL1+fzc5hnpYah6VLNv4498PxKXfWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-EbiRTzPSPzOzGJJ9W9JE6w-1; Fri,
 04 Sep 2026 09:12:07 -0400
X-MC-Unique: EbiRTzPSPzOzGJJ9W9JE6w-1
X-Mimecast-MFC-AGG-ID: EbiRTzPSPzOzGJJ9W9JE6w_1788527476
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A34E195FDD6; Fri,  4 Sep 2026 13:11:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71AA51800765; Fri,  4 Sep 2026 13:11:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:19 +0400
Subject: [PATCH v2 15/25] contrib/vhost-user-gpu: drop scanout_bitmask
 bookkeeping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-15-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=A37YX35GVOBJzZqDYHROObSH9zDX7yUaTjA+BdwdCtA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMw3rwQyqGzGEdWC3EnA3uCvTrD/oGcvAH8M
 R+zGhm/S6+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5ZbTD/9FS0blJynzNZka7tkWfR/TFiGHingTv0MQrqLyDjBtmS4XiU4s7HVBvsMNrn6GBlOhXuk
 4ln8ZSsHpQ+V2778pJekKPFy7eNPeutlx2LFR7eeO7EkiRW2DjItV/3KQ2Nj+jxg21dqHZAmDxL
 x9lOCj+ZirFqDVOUUY/DboUEuYydZNUc8dfhIOXtBLT+5qMXwwkwscRbr9zgStzXpQpyZnSYLzE
 9rJiqsLxNFnM4AQvmTowNXZf1fwzoZnwFdrEAEOJypyXLKuJ3ShGt4CFcuZyi9IGz/mxtg7ZG6D
 shKd77KFDY0khDpA3xgGafKKR3XTgoR+Nj5YCH9hDAB3wjV4+ckTYdSnEwwF94f7QPUD/vmVeno
 0dKSN8oJvN8Aw9oiiFAlf2G86hy2bhbiB6HlevgxIfuJIgxFkoIBR4Z8TyOZ4ckx0pTSD/tc+qF
 G8OHQJMVLxlVOo6sRs17R/HcyJjqGFtBJN6yLWcZDpHotposmM9lZ9NDfBNtb+l9IqAG22OkMNk
 /7Du/bfqi17PAhl+/V1MNWGt1xrvi5vdJXkcmHE4pOVR8SwAUsvgWjD0hCbZcLp/hJZJ1mExGXt
 fwoYmYYtj/54VajiZSTbhtFxHzqnrcsdHrDt1kj54i2rX+johiVgiAVDZvdWD6PPDgLFKH/+AhR
 B2JgdWcotamK+8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


