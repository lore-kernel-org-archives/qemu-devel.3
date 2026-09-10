Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F13C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4esS-0004xo-SL; Thu, 10 Sep 2026 09:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esQ-0004sU-O8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esP-0003kK-8n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CEkb1pbqvdSjaTl5T02aLz3SneBoJfy3quphqY3VaY=;
 b=JQSJRt9gFogNq9c3WzhlpAF1frCEYvDbS0yfC972K60+6FS6FzfIx5iukgKujiwunYDMyS
 9bEsV9lHRehQMBfcW4KoS4YGoB6yZ6HwuG0zbDU6f/R0+5zAEjGueIigeb5RrzzjQa9jM3
 /UZe3rQIBXttB6igHf1kFe1tkzVGLUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-9EgUvoMwNiW4KeMH5CNgDQ-1; Thu,
 10 Sep 2026 09:31:38 -0400
X-MC-Unique: 9EgUvoMwNiW4KeMH5CNgDQ-1
X-Mimecast-MFC-AGG-ID: 9EgUvoMwNiW4KeMH5CNgDQ_1789047096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BB461954B0B; Thu, 10 Sep 2026 13:31:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF3E91800473; Thu, 10 Sep 2026 13:31:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:11 +0400
Subject: [GIT PULL 16/24] virtio-gpu-rutabaga: fix scanout handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-16-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3051;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Y+x8YicNAXC2XmwidfmyoGEqbosScCND9O6ybcjTOno=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdfFL36d0uY06d3ZyfQjTfTR2X0WEYE6YXi
 EW5a/3NvTSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5U2/D/9foSEvUMvIBRJBvl0hBXiFJ2JFpW6C6+dymDeGPNxbjpOF4LEzT4ro6f7J4MfPXtb2Jl+
 SSex5BTU29NI7mpA5GxNfH2kVchAdSP58OnZZ9NUY/dbJDjONV38OwArNnvzHw0Q5OchK2+73Pt
 T10e4IFIAUFQTi1JZzloZAkTYrgZukC9gySrIg+rJbmYwVcSdbTX2Jm/7P0L6zdNIjByRfEXqk8
 FUiwtPe2xHKtWfFAchzU8X5OIFqu5EmpLuDLfJy99JVXV8AAaX/vIyRyoImrpIhitGTKyyVTXin
 in37RukrIsP/Kp9IkuIN+2C/O2+wgBagjzW4CeD1O7pXP+M8IDiyx9jQjtgyvffJ6SCS7Dusiwp
 0wlKpazKVTKbwND07tn5FM9tGKUd9uRSE9mubPdwhuDIJdMv9GCuH8XeaUO/Mc6TK+AcA5md2c+
 zjWjOxNHboN6ZRwoNTvt4zmSVetpxvfsc3wPv00DwK4xNKddIhs/KyUVnIZKdyZl0b97U0w9+T+
 HtyHggwaKJQwLT2rZPXx879+kKxxAvD/Mms0V3I9mpl3ALzVXME3xKbHZT8yPcm0XhRYcAGQ5WS
 lJITioVsOC6tjlY5pF767t808fnGlULPnLT3DjEM3XLgS1Ww9fMJ8eoO4FeeS5pQ5HntNISCy26
 w2Vx4Ycjj2vpHwA==
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


