Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C2C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsn3-0000O1-Gn; Sat, 24 May 2025 13:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsn0-0000Ga-FM
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmy-0000kp-W9
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JC2wYKSCVTSC9hRt1qKP/ALSipYOkMme8Y7eicj3lBU=;
 b=Mjje9fKD3gnD67iCYiL0X+CCXwGy88SvAz1g+wdbAf/SXubIiy+ugCb2wz9YjFHyvdJUMV
 XKld6cpuqc8NTURXLCa4btl54tQqnkKduly+ZKD26fPo0t24t1syOe9N5exWz5OANsCs8U
 oMTpJrsYVGB90rxprU0MjZyuTTUsSvw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-GTVondoIPzyRrNp75XieBg-1; Sat,
 24 May 2025 13:36:02 -0400
X-MC-Unique: GTVondoIPzyRrNp75XieBg-1
X-Mimecast-MFC-AGG-ID: GTVondoIPzyRrNp75XieBg_1748108161
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1B418001CC; Sat, 24 May 2025 17:36:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7629719560AB; Sat, 24 May 2025 17:36:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 13/19] gtk/ui: Introduce helper gd_update_scale
Date: Sat, 24 May 2025 19:35:06 +0200
Message-ID: <20250524173514.317886-14-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
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

The code snippet updating scale_x/scale_y is general and will be used in
next patch. Make it a function.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-4-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 30 +++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index aa3d637029..d3944046db 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
 /* gtk-clipboard.c */
 void gd_clipboard_init(GtkDisplayState *gd);
 
+void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh);
+
 #endif /* UI_GTK_H */
diff --git a/ui/gtk.c b/ui/gtk.c
index 8f5bb4b62e..47af49e387 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -801,6 +801,24 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
 #endif
 }
 
+void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh)
+{
+    if (!vc) {
+        return;
+    }
+
+    if (vc->s->full_screen) {
+        vc->gfx.scale_x = (double)ww / fbw;
+        vc->gfx.scale_y = (double)wh / fbh;
+    } else if (vc->s->free_scale) {
+        double sx, sy;
+
+        sx = (double)ww / fbw;
+        sy = (double)wh / fbh;
+
+        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+    }
+}
 /**
  * DOC: Coordinate handling.
  *
@@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     ww_widget = gdk_window_get_width(gtk_widget_get_window(widget));
     wh_widget = gdk_window_get_height(gtk_widget_get_window(widget));
 
-    if (s->full_screen) {
-        vc->gfx.scale_x = (double)ww_widget / fbw;
-        vc->gfx.scale_y = (double)wh_widget / fbh;
-    } else if (s->free_scale) {
-        double sx, sy;
-
-        sx = (double)ww_widget / fbw;
-        sy = (double)wh_widget / fbh;
-
-        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
-    }
+    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
 
     ww_surface = fbw * vc->gfx.scale_x;
     wh_surface = fbh * vc->gfx.scale_y;
-- 
2.49.0


