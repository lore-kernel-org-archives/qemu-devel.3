Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A31CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUG1-0001ld-1Q; Mon, 08 Jun 2026 03:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFq-0001Ne-GA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFo-0000Sb-T0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAaTuhm37B4BnOohrXjrSbA59RhGqmcivU4t+29HN3M=;
 b=Xa4ZhAKO5ncwsC3L+c0cPlbJIh0o5uEMLnqLBl8ccdkUgoKIpYmqPVSCKj/FV2IGwNZXz4
 c4OWqRbxD98UMBIOlkHnr5ZHUbdT8cU66HMVLITh/rHh0hJvyWoAi5q8XbHVhaeafIqoV7
 uZ+E4+xp3aS86c1/oDwNFZ1lJfuP/pE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-5i7GcBG7OHST01ZL6_GRsw-1; Mon,
 08 Jun 2026 03:18:33 -0400
X-MC-Unique: 5i7GcBG7OHST01ZL6_GRsw-1
X-Mimecast-MFC-AGG-ID: 5i7GcBG7OHST01ZL6_GRsw_1780903111
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4011195609D; Mon,  8 Jun 2026 07:18:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85F961800480; Mon,  8 Jun 2026 07:18:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:39 +0400
Subject: [PATCH v2 21/33] ui/gtk: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-21-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3061;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UaBH1LhnScei1s2prqbY4sVvuMKVbUZp++lzw6vePA8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxLZPmnMmKjzrk3zrEjga6pD+ywhmdp0ww1j
 DAG4gVi1XmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSwAKCRDa6OEJdZac
 5XusD/9V3xLV5kIG7zao6qyi5c3r6/VG6CKGi5uqdFPRlF/KWlXMCDuhm/m8pOKhsdSIu94OdHN
 JkqE3g0Lljm2BaQ4NhAeT8cvtcn/P0MzJC8SMbnh3xA+7oMwmPWsisIZHWZeeu/yCGqu/uzzotZ
 fCEQkaTFQZHFQMFqwI44Jy0k3Pic0KDOWnTqkw4lPk2y7NrGHml5NYIYgM5AfaIodbMH7NIeE8j
 uWNDGat5p41gtiL+9hq3ndWQ7kqEMnGRGzvLztnSib5V95So/FyffNLdKQSDvLOMb4WSgtlsXZW
 1L7K6VgFPwJxuz9G7wH9s55qEplR9Uan4z6O+uT28r1eu6r76TrYPoLhI7aPJjk4kDrvRq7m1n8
 h+GhB+nDq9gJP+dHfVJ93ZL8NvaRZxhSHtSz5Jn36GFuprBn76HtyJ9gVXH8DC2Vb35evYJb5ZA
 eio5/N2LIVGCZ9YCZk0prBJC6qydGE0nOs4VnncztUPgos4NWZT2kuC6GBTijauySyqufAbxuJr
 0QE0XEAiuuvxjbJvgYkQsrjrKN7Y+R5G9GAshWN21Z90j1ZFHx9gIqXVJUaWdAWgFyh0EzV0o36
 K2M0Xe8k1Ewd83ZMK2aVaetKi2UcDzGreWSowPLzvw1jeTtrgPZbWVDtttMJJi4TxOHNTa/wmCc
 f/wZ4f0sc6abD9A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
 include/ui/gtk.h   |  1 +
 ui/gtk-clipboard.c | 15 +++++++++++++++
 ui/gtk.c           | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 3e6ce3cb48c..5156a049509 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -225,6 +225,7 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
 
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
index 2ee826b56fb..c26dc83ac3e 100644
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
+
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


