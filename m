Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD524CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1G-00044c-Qh; Wed, 24 Jun 2026 07:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM12-0003ev-V8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM11-00089J-Gw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roJwGwDY/CRrFTsw73QBHjSB5e7RvHRSUPpyQcbaCuM=;
 b=Vv1L+BvO2a5/BLPrDFRquoL5hcFbz8UhgrfhieBKgmz3C5veRVyT8rnbiIqLB8NejfMWdL
 dSa26xkh7yBwtxbEY0Gk6OlJB4ucMDXELsKTlWKeLONl3zhvd/2ixh6zI3N61zSyTFbOY3
 2wTcd4jOBB2ygEAVKTN5SXtTSa/XB5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-SbPxveT4M5ijWyNw9zV3YQ-1; Wed,
 24 Jun 2026 07:43:33 -0400
X-MC-Unique: SbPxveT4M5ijWyNw9zV3YQ-1
X-Mimecast-MFC-AGG-ID: SbPxveT4M5ijWyNw9zV3YQ_1782301412
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 479D219540CB
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B61F3691F; Wed, 24 Jun 2026 11:43:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:44 +0400
Subject: [GIT PULL 22/35] ui/gtk: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-22-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3883;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yr5QT2PgTg6KEFWqJKmuI7PbsjQsUObANcfQ1+RHV1E=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGo7wmigVy43q62rcR+VBpInThEveZLuv3yrTug+uRedPufE9
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqO8JoAAoJENro4Ql1lpzl4hUP/iQ2
 0qUMQKej4Qvf447H15qyBUUO4h2u2VvYGPkTv8Z+ODlICvhfcSKg+lsaAJffH8qH12uvpZ1zqTH
 NUFmNcO6aSNGl5iEWqjyVFnNHVZJfvwJ5VYklsajJWvznv6RdezqFOmE4kwFE4o0/28QJuK459B
 RzEct99LtTOF0XiMeVnkuO1FKZflLSeoPZOAzX5SA8rnTDrGsW3C1sp3YGT871j5szld7dhkEWK
 CRTcGnE6PnDuKyZ6RtumS3C3x4VAHW7HPqu5ZDtiGIMN12cdP0pdQyegItwFzCcj/Jqi9eELaRP
 K81+aNzkwnwewmrAxfIFcSTzlt+pzxS5RT+2M9L/PDiklq7WkNFV3o0VUbiB2+Q8PJ4DkGJIukb
 UIgbcWlpfx3hS/uBNcAD0tWA83QRvV3DbxOqj+NHwt2AS2xYmYCkFegPaMJxuTJnzKfcmRJQYo5
 IKOj/a012EdNj46WoiKsZXpw/hfZlBMtUllHTAyK31SNffKo8KdhMoSWjpwOGY8y7sdX4AoiPTu
 McDdbkfz80wvFLsT2k4ethoBfLN8hujflSfHQtLHSOptAXAvDiSk2Q0YMT14blfX/4W/sfuMTZf
 1k79ADoOqb3qMYl6roPO/YU7zVJEWBa5BaeYhTam+GgZoR2+5tGZ26NdmbWaXj+C4ciDjEa9iuX
 ye/Hq
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add gtk_display_cleanup() to properly tear down GTK display state:
remove console and mouse notifiers, unregister clipboard peer,
destroy the main window and virtual consoles.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-22-4656aec3398d@redhat.com>
---
 include/ui/gtk.h   |  2 ++
 ui/gtk-clipboard.c | 15 +++++++++++++++
 ui/gtk.c           | 20 +++++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 3e6ce3cb48c..f4c8e6a9f00 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -140,6 +140,7 @@ struct GtkDisplayState {
 
     GdkCursor *null_cursor;
     Notifier mouse_mode_notifier;
+    VMChangeStateEntry *vmse;
     gboolean free_scale;
     gboolean keep_aspect_ratio;
 
@@ -225,6 +226,7 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
 
 /* gtk-clipboard.c */
 void gd_clipboard_init(GtkDisplayState *gd);
+void gd_clipboard_cleanup(GtkDisplayState *gd);
 
 void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh);
 
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index ea9444be70f..476e6b8303c 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -235,3 +235,18 @@ void gd_clipboard_init(GtkDisplayState *gd)
     g_signal_connect(gd->gtkcb[QEMU_CLIPBOARD_SELECTION_SECONDARY],
                      "owner-change", G_CALLBACK(gd_owner_change), gd);
 }
+
+void gd_clipboard_cleanup(GtkDisplayState *gd)
+{
+    if (!gd->cbpeer.name) {
+        return;
+    }
+    qemu_clipboard_peer_unregister(&gd->cbpeer);
+    g_signal_handlers_disconnect_by_data(
+        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_CLIPBOARD], gd);
+    g_signal_handlers_disconnect_by_data(
+        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_PRIMARY], gd);
+    g_signal_handlers_disconnect_by_data(
+        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_SECONDARY], gd);
+    gd->cbpeer.name = NULL;
+}
diff --git a/ui/gtk.c b/ui/gtk.c
index 2ee826b56fb..dfef1b10fe3 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2505,6 +2505,7 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
 }
 
 
+static GtkDisplayState *gtk_display_state;
 static gboolean gtkinit;
 
 static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
@@ -2523,6 +2524,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     }
     assert(opts->type == DISPLAY_TYPE_GTK);
     s = g_malloc0(sizeof(*s));
+    gtk_display_state = s;
     s->opts = opts;
 
     theme = gtk_icon_theme_get_default();
@@ -2560,7 +2562,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
     s->mouse_mode_notifier.notify = gd_mouse_mode_change;
     qemu_add_mouse_mode_change_notifier(&s->mouse_mode_notifier);
-    qemu_add_vm_change_state_handler(gd_change_runstate, s);
+    s->vmse = qemu_add_vm_change_state_handler(gd_change_runstate, s);
 
     gtk_window_set_icon_name(GTK_WINDOW(s->window), "qemu");
 
@@ -2681,10 +2683,26 @@ static void early_gtk_display_init(DisplayOptions *opts)
 #endif
 }
 
+static void gtk_display_cleanup(void)
+{
+    GtkDisplayState *s = gtk_display_state;
+
+    if (!s) {
+        return;
+    }
+    qemu_del_vm_change_state_handler(s->vmse);
+    qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
+    gd_clipboard_cleanup(s);
+    g_clear_pointer(&s->window, gtk_widget_destroy);
+    g_clear_object(&s->null_cursor);
+    g_clear_pointer(&gtk_display_state, g_free);
+}
+
 static QemuDisplay qemu_display_gtk = {
     .type       = DISPLAY_TYPE_GTK,
     .early_init = early_gtk_display_init,
     .init       = gtk_display_init,
+    .cleanup    = gtk_display_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0


