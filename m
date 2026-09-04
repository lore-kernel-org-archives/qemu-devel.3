Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39721C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tha-0005M9-8C; Fri, 04 Sep 2026 09:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThY-0005GD-O4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThV-00058w-CY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibqhERt06xtbZ3QiVCu/UfPVG5M/nC53uPXTo21sXrg=;
 b=GhZpf9Z/Oj6yzY6E0orRacz9wEqi95bzTAh/TB4EgSmJSWOg4UfEtvLVcQ2ByvADwx+mYa
 IRlkY9FIUZFIv5ofKl4L3hc7SU+2QJm+I8kqBY/bdddZ8MGiVYtsY9TPndzuzCOWIcZStt
 QLbOoBy3p/rrz/NnKqlplspJyZKlWMg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-yg1C7L8lOgyp7nTKK8KbuQ-1; Fri,
 04 Sep 2026 09:11:21 -0400
X-MC-Unique: yg1C7L8lOgyp7nTKK8KbuQ-1
X-Mimecast-MFC-AGG-ID: yg1C7L8lOgyp7nTKK8KbuQ_1788527480
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FAA518D7265; Fri,  4 Sep 2026 13:11:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F2771955E72; Fri,  4 Sep 2026 13:11:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:20 +0400
Subject: [PATCH v2 16/25] virtio-gpu-rutabaga: fix scanout handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-16-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3zs+1jG7cAuagGUnkATpCae6RXUVUGEBt/fm+AZmRak=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwElbKqp8cUBh5sEQaPEYKq8tiiLHOLbzBZ
 wZNnf+2oDiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5TWZD/9DjGUTtvrKaPmAGod7GF8papraFLOWwf8DHqdL7jvngNCrau9tjrpshuzzqqphbM4NJD9
 U9HcLOyusTaQOiLVxvYgsvzhZWQX0C7utCdnOYwyfzFHttz/GQ4M7xlDhLydDNih0sBBXn87RCl
 3SGh1Ex926azJRnyiOKUStXa4ATkD+cjVBqFOMZwBTz9r3E7NcjmVIatC5T38sHojuMxzpfP6ud
 NlEkPW745WOfPPygbQtClTlsyCYTZRUv9osBTGb0IIqScdZIsJ4fmgqir6YORxOqL9KczY6o3xH
 5OH6VSRC8brP0VhSU89xAcXhns2OJrwjf3/KxR2sgaDn9956mfOuo1Mzp4E4D4oMIrAfwGh3Ike
 lRXCMnmVEMb64BJWVOzFM7/lU4WG9Ulurc+raAA5CAHo+CCMtCg0xrwMm+3A7dDe6YS4/LY1na2
 OvtflSgHWaAnG0bWdT++XcAA/i9e50o7ybGUTmKQgOycUhGe/ao7s58LtobSCFZq9fPt6ZdRBwR
 aNDwOkED7m2Pygl2MJS8ecfgvyrlq0kOd7kEWuNemtyk+txHmlfrA4Qx/SzB2Eg/O3R3Teb5dvx
 TfpEqWFslP0YM/Ln5WxYc6jcq3kM+mjGs7p2DgO81xyO6Cx7cfdt2CFAaz1whrlpb5q4BnNVe9J
 7WkMKfqeUO02EGg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The rutabaga backend was misusing the scanout_bitmask field as a
plain scanout ID instead of a bitmask.

Fix the scanout lookup to use scanout->resource_id directly. Also
fix the missing resource_id clear when disabling a scanout, and
flush all matching scanouts instead of just the first one.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index b8f8a2068d0b..8a82e96b7461 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -146,8 +146,15 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
                                    Error **errp)
 {
     int32_t result;
+    int i;
     VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
+            virtio_gpu_disable_scanout(g, i);
+        }
+    }
+
     result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
     if (result) {
         error_setg_errno(errp,
@@ -251,7 +258,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
 
     for (i = 0; i < vb->conf.max_outputs; i++) {
         scanout = &vb->scanout[i];
-        if (i == res->scanout_bitmask) {
+        if (scanout->resource_id == res->resource_id) {
             found = true;
             break;
         }
@@ -275,7 +282,13 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
                                              rf.resource_id, &transfer,
                                              &transfer_iovec);
     CHECK(!result, cmd);
-    qemu_console_update_full(scanout->con);
+
+    for (i = 0; i < vb->conf.max_outputs; i++) {
+        scanout = &vb->scanout[i];
+        if (scanout->resource_id == res->resource_id) {
+            qemu_console_update_full(scanout->con);
+        }
+    }
 }
 
 static void
@@ -299,6 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
+        scanout->resource_id = 0;
         qemu_console_set_surface(scanout->con, NULL);
         qemu_console_gl_scanout_disable(scanout->con);
         return;
@@ -332,7 +346,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout->ds = qemu_create_displaysurface_pixman(res->image);
     qemu_console_set_surface(scanout->con, NULL);
     qemu_console_set_surface(scanout->con, scanout->ds);
-    res->scanout_bitmask = ss.scanout_id;
+    scanout->resource_id = ss.resource_id;
 }
 
 static void

-- 
2.55.0.543.g5ebe2ebe4ea8


