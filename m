Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE374C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoKe-0001fV-P1; Tue, 25 Aug 2026 06:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKc-0001Wp-Jv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKa-00063H-Vz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KbaR4QkgMrsVs3OGLnUUQ0qiQDBQJLZcAZ2qUTgcZ04=;
 b=iZmx1PPt4FA4YtuH6JdyqtVnKVBa/c80uLMLKExa+orJWpNNvcGv8/TaDRIuDxHYg5J+Sn
 FZ7Bp8pB2tguBcsTsjTa2ZQW4VgyaW76ZK+DIl/Ha6zO8EGTXeHExequvTLEqqhFZboW3O
 j3sblZmZPCko9DjuUPv6aoqkZIVgLG8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-vHybqtKwMSaEwJp-egGw_A-1; Tue,
 25 Aug 2026 06:24:33 -0400
X-MC-Unique: vHybqtKwMSaEwJp-egGw_A-1
X-Mimecast-MFC-AGG-ID: vHybqtKwMSaEwJp-egGw_A_1787653470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B82AF1955F13; Tue, 25 Aug 2026 10:24:30 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B38E18005B6; Tue, 25 Aug 2026 10:24:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:49 +0400
Subject: [PATCH 12/18] virtio-gpu: release dmabuf when switching to a surface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-12-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2476;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=W53mgQKDGqy47NLllukf15/S0W1UBuWpMAiQFTp1I90=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYN33CIQ+ydzX6ITmlkVGe683PDOUl/ga4v
 A6g0BjjjpSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5Xu/D/4363qj79O63y2zooQrh2bf4Stna8w96yLUS8NwV3stxItwzmLmGOXWq4Tyxh98Kv+qKYL
 IE7pPWWtVCfoAj4pdqT8iq2MOY1AP1Ehx7yrf+nI9COQjwysNGRmRV9ZdKy4eOPW+FfubG78NSt
 Y2YTb/LqOv4rLdygLbIcs1g+VXoQZuUtgQ/QOY9FvTRrDuBuNJDTRqqheS3VDdyySZdq2/zCVDZ
 rDj7E0qr8/MHprsUQtnr2y3lLKLooSgW5S29WzRVTPx+LFMW8df0bHcY5GfZ6VttrZx9y4xsSNT
 M4kox8ExqVuytAY4B5F4VgpSRvYVcl5CYMpJV2i7wew/FQIgugwfV+FwAc9rmTsOY9utQ0d/+Ne
 EZZHOGkLw0I4xVG+kl66V8cKLWzl6is6KohqXH/4QUMrjyICfJk+MgZjxFlebeqpPyUjofZhJsO
 oASR8+ip97YLRe+JO0mllzxLBFdt4aHKIGpfu41BN7kJIBCzmsVdpcl8HoII6ZDvsxzek0MGJoT
 Ue/z3rNzn22RhE0W4B/XCF/c/VssF8dzXXnM6gsGG678aYvyWJMCXmqHQEMcnVyd99/OfTFxbex
 Jizd0Y3xw4NpAuUYoUE61YEirImiJfO//y5wQ6OxUNm+sM9n71hFMC2RSI0c4NAVIFPWrRTEEAE
 Gh6Q5UcwRPZ0wAg==
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

A scanout may hold an active QemuDmaBuf when a SET_SCANOUT switches to
CPU-backed display data. Force surface recreation and release the old
buffer in this case.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5362f7a4c269..a74475dc6741 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -658,9 +658,11 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout;
     uint32_t bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
+    bool was_dmabuf;
     uint8_t *data;
 
     scanout = &g->parent_obj.scanout[scanout_id];
+    was_dmabuf = scanout->dmabuf != NULL;
 
     if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
                                          fb->width, fb->height, r, error)) {
@@ -687,12 +689,11 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
     if (res->blob) {
         if (qemu_console_has_gl(scanout->con)) {
-            if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
-                virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
-            } else {
+            if (virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
                 *error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
                 return false;
             }
+            virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
             return true;
         }
 
@@ -702,7 +703,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
     }
 
     /* create a surface for this scanout */
-    if ((res->blob && !qemu_console_has_gl(scanout->con)) ||
+    if (was_dmabuf ||
+        (res->blob && !qemu_console_has_gl(scanout->con)) ||
         !scanout->ds ||
         surface_data(scanout->ds) != data + fb->offset ||
         scanout->width != r->width ||
@@ -727,6 +729,9 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         qemu_displaysurface_set_share_handle(scanout->ds, res->share_handle, fb->offset);
 
         pixman_image_unref(rect);
+        if (was_dmabuf) {
+            virtio_gpu_release_scanout_dmabuf(g, scanout_id);
+        }
         qemu_console_set_surface(g->parent_obj.scanout[scanout_id].con,
                                 scanout->ds);
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


