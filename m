Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A584DC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zzm-0003kF-Fa; Thu, 10 Sep 2026 04:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzk-0003Zs-UT
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzj-0004w8-CI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CEkb1pbqvdSjaTl5T02aLz3SneBoJfy3quphqY3VaY=;
 b=V669OF+jAbfGH5aSlmaafGW9kHdsTL2K9jKwXyvPtnr4NSKXE6eo4IkPlkXP1TTXea7E9m
 QzS9k7fBvAd1kurv6INehY06IPvQ4ZXnxruFj2brNkj4a9APRSPW8xajPfQ8aIrN6loQ1q
 f866OziUQBQPpNN8DP/Lj6/3JwrhNhk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-BTjBcueUOcaw5ZEuU0ce8Q-1; Thu,
 10 Sep 2026 04:18:51 -0400
X-MC-Unique: BTjBcueUOcaw5ZEuU0ce8Q-1
X-Mimecast-MFC-AGG-ID: BTjBcueUOcaw5ZEuU0ce8Q_1789028330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7017D18005AA; Thu, 10 Sep 2026 08:18:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B7C51956040; Thu, 10 Sep 2026 08:18:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:44 +0400
Subject: [PATCH v4 16/24] virtio-gpu-rutabaga: fix scanout handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-16-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3051;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Y+x8YicNAXC2XmwidfmyoGEqbosScCND9O6ybcjTOno=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeolQqnRjUuAvA9/FgS/DbhRxjHZWi6OP2v0
 2sH3gHPVs2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5f46D/4u9Sf7FMdgnmHoQ4pzbDnsArDqy0w13Tr4Jad8hiV9ZXTV3r/J8BOMJafO6rpxbMaYL8P
 aFIoSf04mKjSFpK96I+qHbWqZiOcIikEjBOgXnrWkQC4VmkfsFyoq1iAB70Wv1U4db9OLKk0wXe
 ssZ4T1fWAPJ2o5HSqaaMqfw6AD4j0Bh7tLsgI21+ODO61O0pC7q8bvf/KzacEaEFsB63LCxIxtw
 EAWCcqaUR++9SQ/abUr8vuCwU9fz/vZfQY/ACLxuHrbPezoC4zfiNRiKoEBtgjqS7o0wQrvj+Zw
 9rSg95GIpV/UJdBCn7G4A008ugd4pWyQLM+M5pEzi76fHk4Un+eR/owOZ9JwcPKl6loBUCSA3Y/
 OgPe+vV441xN/jVM7ArYDc2HKAd4fDhw+pKBwDqbNoJ0DcZjO2Q19T/KE9ZvNrrZydSzRlIScXI
 7AZTK0EWbTDu23hwReT38Slo6w5zB4fXn+cn1MdG2GCqzbafkXSZYBbvBOkDt71VmaUz28IdlTQ
 twoYl+nBqWvYpeNBG1KmtswqIhTUjP8ofpQKtf+g+5KmzZt5J7zABZCzhIRkBIhz80D+gtdLOic
 111TO5ChO7fgs1aO9ccNjUWMl2TQtZ/cERwYkRnFmqW/iVr7pIG3BpS2kxn8Y+FGrl6Y24J3Lhy
 yTXfMTHdHGe95zw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

The rutabaga backend was misusing the scanout_bitmask field as a
plain scanout ID instead of a bitmask.

Fix the scanout lookup to use scanout->resource_id directly. Also
fix the missing resource_id clear when disabling a scanout, and
flush all matching scanouts instead of just the first one.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


