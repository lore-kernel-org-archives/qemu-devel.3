Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16DFCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqL-0006fS-NB; Tue, 23 Jun 2026 03:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqF-0006IM-0R
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqD-0008Hm-Ag
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKlxCGNKs0kk4ALX1vXp/DYEb4dpEwlOWrBgQleDG7c=;
 b=GhJg/jFR7KMarvQex8yvwfZOnGR70zuTLL8h0nwlyW+1eNuMkpGZ/uQneyuFLx2f+f/tmy
 UR/HPWrDypRrO8wVoM3KWOf73q1Os9G+QMS+9sKYXbvlATncBrXJF4Q5lD5XPndPT8uDBw
 oQuEAk8Ik+lIim5Y68IujZdj+2gubsg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-iqZAkvdpOqK54doRrfLz5g-1; Tue,
 23 Jun 2026 03:46:39 -0400
X-MC-Unique: iqZAkvdpOqK54doRrfLz5g-1
X-Mimecast-MFC-AGG-ID: iqZAkvdpOqK54doRrfLz5g_1782200798
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A7111955F45; Tue, 23 Jun 2026 07:46:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A754518005B3; Tue, 23 Jun 2026 07:46:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:37 +0400
Subject: [PATCH v4 22/34] ui/gtk: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-22-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+DG8xB4KJmLQS3EpZUbBQpkZhWCN+8ypFWbdujyuWPI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjlecuR7X2WqRJ8iwPyrQbt1nMxTVH+zYN7o1
 QgnNmS25QyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5d/uD/98p5dabwIpQ/3+eb+6pexgkonAqVHrnXURe78dXVnlwHmNzospipWbOT73piPPS5yTHjU
 QuA8PL59ADvAFeGw268FJMPCAVTu5ke04eTSu/Ai4LQ3CohR54YDRc/ruABo8a8o2TxxiwUWgbZ
 EcYCRF5eoDilhNlQkDbSgM68kPPiXdwjx+h+HE0f2mpIoHKbShwPtMzurP4aYrUpeEXQGhrseze
 fD/SHnln4E1OPs5yIDXsoouhl8un80Pag9xqI4qg0f+nc35nNMtYkykFRYt+C0GtrMCMf6ATuKR
 9PvXmzXveBLHquHDWDDKwH248vhK6S65jW7kPVX2lA/HzeyG/GhflNntdxDsOvhH5+lZIz2mnMH
 W+Xb+Qxj3/K/6fyqiUX2uEeATpXhvmEQhjqRj5+d0MxsIvuoTQjLGP9lWZJEugymZ//q3IjNnZB
 mR0KVCWYqN8xe9zrd2LYplzuhkG4bZhBniV8zNNB9UMij3r5XxJOJbyYLToIy7XSzKwVuVeEmLZ
 eOzbvmycctEEBNuQ4sUqHW49Y3hlUJg1V1t3dn4ATDI3GzsjPAjlonzr6A8cZdwBBD32HnhiUaQ
 qDFbsdAOuQNVu+t4/9iShdRDwf3qLOrS7nTUKyYI0qucE9NaVSig4wqi6jZh93aAoqln2DFNjMu
 acu7dNV9i/60Dmw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add gtk_display_cleanup() to properly tear down GTK display state:
remove console and mouse notifiers, unregister clipboard peer,
destroy the main window and virtual consoles.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


