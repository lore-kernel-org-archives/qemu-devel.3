Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63686C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsna-0001zP-A4; Sat, 24 May 2025 13:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnI-0001Li-1Q
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnG-0000lt-Ii
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWYf2BeSTPqu7GlOBYoQqbkCpXlL24ybqO9vOsn3aSI=;
 b=biV0/RSU5kPih0xxv35HIYjuPZsDtlVMFlv2iiMciqXKQZeyJ97b0iN1qQYX8d9T+4ToUI
 7hLZ5Oe2H2MG2d9Kiccm7+co4UrtsvN7CA46yiadkBTF4aSxbGQuMpQlzNqw3bBEd/m4kO
 7IH4xtytPuUNInAkEcB81wlXQC51ql4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-AJGHsgMJNdijRZQkfuLecQ-1; Sat,
 24 May 2025 13:36:17 -0400
X-MC-Unique: AJGHsgMJNdijRZQkfuLecQ-1
X-Mimecast-MFC-AGG-ID: AJGHsgMJNdijRZQkfuLecQ_1748108175
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56B01180035C; Sat, 24 May 2025 17:36:15 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF0CF19560B7; Sat, 24 May 2025 17:36:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 17/19] ui/gtk: Consider scaling when propagating ui info
Date: Sat, 24 May 2025 19:35:10 +0200
Message-ID: <20250524173514.317886-18-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Weifeng Liu <weifeng.liu.z@gmail.com>

The ui width and height sent to guest is supposed to be in buffer
coordinate. Hence conversion is required.

If scaling (global window scale and zooming scale) is not respected in
non-free-scale mode, window size could keep changing because of the
existence of the iteration of the following steps:

1. In resize event or configure event, a size larger (or smaller) than
   the currently used one might be calculated due to not considering
   scaling.
2. On reception of the display size change event in guest, the guest
   might decide to do a mode setting and use the larger (or smaller)
   mode.
3. When the new guest scan-out command arrives, QEMU would request the
   window size to change to fit the new buffer size. This will trigger a
   resize event or a configure event, making us go back to step 1.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-8-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 47af49e387..8c4a94c8f6 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -772,8 +772,21 @@ static void gd_resize_event(GtkGLArea *area,
                             gint width, gint height, gpointer *opaque)
 {
     VirtualConsole *vc = (void *)opaque;
+    double pw = width, ph = height;
+    double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
+    GdkWindow *window = gtk_widget_get_window(GTK_WIDGET(area));
+    const int gs = gdk_window_get_scale_factor(window);
 
-    gd_set_ui_size(vc, width, height);
+    if (!vc->s->free_scale && !vc->s->full_screen) {
+        pw /= sx;
+        ph /= sy;
+    }
+
+    /**
+     * width and height here are in pixel coordinate, so we must divide it
+     * by global window scale (gs)
+     */
+    gd_set_ui_size(vc, pw / gs, ph / gs);
 }
 
 #endif
@@ -1836,8 +1849,16 @@ static gboolean gd_configure(GtkWidget *widget,
                              GdkEventConfigure *cfg, gpointer opaque)
 {
     VirtualConsole *vc = opaque;
+    const double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
+    double width = cfg->width, height = cfg->height;
+
+    if (!vc->s->free_scale && !vc->s->full_screen) {
+        width /= sx;
+        height /= sy;
+    }
+
+    gd_set_ui_size(vc, width, height);
 
-    gd_set_ui_size(vc, cfg->width, cfg->height);
     return FALSE;
 }
 
-- 
2.49.0


