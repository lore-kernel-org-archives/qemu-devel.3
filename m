Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B8BC61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoK0-0000ak-RZ; Tue, 25 Aug 2026 06:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJw-0000PJ-9M
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJu-0005vj-Jn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGC3ZtTD0o/8b0IH0Neq58h30rThv29Te40Za8zKIHA=;
 b=NVYh9eHwx2yPpf2UCKdy0tbHRw2yj/0IEXyqDiukQk/eOopsw/EKDdrR4Kqp8v02PRzOaC
 pypiGKRzsBexvcK6oDFzRPoyFr5tZYNGhuqbRR18FGDA6SepTaNLAnyd3CAnsCmdkShP+5
 aGKoLGajeGPKYxy/QigzRJQc6JWPV3A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-7RDxwXxcMA6-Y48T5Ij6uQ-1; Tue,
 25 Aug 2026 06:23:49 -0400
X-MC-Unique: 7RDxwXxcMA6-Y48T5Ij6uQ-1
X-Mimecast-MFC-AGG-ID: 7RDxwXxcMA6-Y48T5Ij6uQ_1787653427
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6D5A195607B; Tue, 25 Aug 2026 10:23:47 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D8CD30002EE; Tue, 25 Aug 2026 10:23:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:46 +0400
Subject: [PATCH 09/18] virtio-gpu-rutabaga: fix scanout handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-9-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2911;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gi3nzR563umttu9ZHW8uYx324CNeZof5aiVhz7+8Tyc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYNUBKeDrbaWP8yEQSKMpUQndMIX3Zyt9Uj
 g2ZNz8CdUmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5TxZD/0fZzrbIr21zOXPxkkVs+9hHkwAZ7uFtcZ5Wnoefa7BJSCecKoYidG8HwxUkHQqBV68zhh
 7sOBspakhzw6hhwD92F4GPyPkku4b1/T4HY/bhVpBQ1ncftKGoQ2YLZ9fH0I7XB4wFXWLxTkyFx
 PgUnaM84x1jeEke5CEPJdR/itzHhJPfi7UJHYFxqDQ3ISwfCCA7ZpvJW81nX8NUczgYVKlA8mys
 xsFtDEajKx1f6h5BahrFtaDSJx70k6H/G4pvG0oYMxHGD/YMz9+y9HZ3pMV2nS/W+dQncTPWVcz
 5pliwSzrQ2M8Hftntkxc2yVDL3XN8UyU+dr0y+LrZcCXkXg8FZe53vsbHoi2UZ2BMfc6n9tb8Ro
 mSAoYG5oYcfvBdYOp9+FVcBJzkomDmMQqRF4bZbH3vwlK8DMSDE0UoTYtDmG1MxVCNKtKzU8CHL
 wzGURmgMWxd5hlz4+KahzUQwdgXf42JUlZX+r/T+rJsTRcesgmViFYR8YdA1LHaUvW5FzfINOkw
 2o4EhUWHhxXATySNBTmJbGKzjBK9TH6Atp443T2TG0CD52a99Ax9pkcr/hHpQmLvQESHoVPc0VT
 nNSV0/biXoB4mwHpRbV8epFKZCf1aSxGvUggOPH6z1AdCL2t66SL8uXeF0RBVgCRu4ezoc5I5IE
 lP4b8l60TqHw/nQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The rutabaga backend was misusing the scanout_bitmask field as a
plain scanout ID instead of a bitmask.

Fix the scanout lookup to use scanout->resource_id directly. Also
fix the missing resource_id clear when disabling a scanout, and
flush all matching scanouts instead of just the first one.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index a054f8117f14..fcd9c94d580c 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -154,8 +154,15 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
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
@@ -259,7 +266,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
 
     for (i = 0; i < vb->conf.max_outputs; i++) {
         scanout = &vb->scanout[i];
-        if (i == res->scanout_bitmask) {
+        if (scanout->resource_id == res->resource_id) {
             found = true;
             break;
         }
@@ -283,7 +290,13 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
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
@@ -307,6 +320,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
+        scanout->resource_id = 0;
         qemu_console_set_surface(scanout->con, NULL);
         qemu_console_gl_scanout_disable(scanout->con);
         return;
@@ -340,7 +354,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout->ds = qemu_create_displaysurface_pixman(res->image);
     qemu_console_set_surface(scanout->con, NULL);
     qemu_console_set_surface(scanout->con, scanout->ds);
-    res->scanout_bitmask = ss.scanout_id;
+    scanout->resource_id = ss.resource_id;
 }
 
 static void

-- 
2.55.0.543.g5ebe2ebe4ea8


