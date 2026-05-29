Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE79CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvFD-0005bh-FC; Fri, 29 May 2026 07:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEw-0005Jy-Tk
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEm-00004v-8S
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAaTuhm37B4BnOohrXjrSbA59RhGqmcivU4t+29HN3M=;
 b=T62PlfZ1pPw3k8vVty2M5XjJV3WmcOEjAP1PirKlwCHLKJe79Pogxo7wbfp0snFpLZqg0Y
 gKx2PKn5PdcwUeTdRbS4qKvGKYWa8H6ZEmhbaObsNmh6GWEJXjUXYkR6va6VL+WEOt2mL7
 CUo3KpqLK5hIIeAA1R/cb5nflxvkNBE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-o8PBJGTENaiHgLAF637tVg-1; Fri,
 29 May 2026 07:18:44 -0400
X-MC-Unique: o8PBJGTENaiHgLAF637tVg-1
X-Mimecast-MFC-AGG-ID: o8PBJGTENaiHgLAF637tVg_1780053522
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C99FD180034C; Fri, 29 May 2026 11:18:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B903F1800465; Fri, 29 May 2026 11:18:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:41 +0400
Subject: [PATCH 20/32] ui/gtk: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-20-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPqk0VzjoqrEkm78M1bimp6BOO8wY4k3qdx
 EBKL0g4aI2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5Y4kD/9/UfSIw0E3itS6/uUeGvZFy1vXJWWDseUIvMis618AFmNMwEpE+WREglrBdL9/ql7ZlHE
 SYMULBzlg0XZOrAlrLQwSwlVph/fkKZ8qg7SeZLVOj4OJhI4LfG2cCp80Dld4xVAllWF4bRbGfv
 60n8YKiU3TIeN7ohbKb49LNKl0D1pNOGx3VSyXg9W1w4JMsTCyJe7Utzu5LidZG+BLSotJjBDpx
 MC2MQg83Lbx3Wsd0pvJKofJ9NE2JDFTX+p+UdqIiVFawXZwsvF4akPsaz7WfFzmRvaAdQNN2rfz
 TRJmdkrDjXbzcoD+5nRvt3It9j8jAmkevvxj+jh5TiurGDeb3glMRArTSYeC+4S5Pd2f7Xua98n
 NVJaqXso8NyEV2uG88p3SzCexONMahI3zXQh6hahvxwH8tkilNHhwav6byvU+wDKYtD20dVXyB5
 6zdj+2f19Eg5zdT1LJnWa1rUPNn7lYIxNbxwczbz48WYcYtCn9plNZMHpHqZgRGICEfw3ywnG2A
 V4fpU4prY3JcSfN/3E/SHmJcoLqCVD8Ygwz7ReeEA/9m6L1pzTPcbWbc0ftmV0MrUi0RdqgWGIp
 sPYJd8WABGvyHwCMv3JJKr7Ibn5fTiLpOd0XfwqLJEb0cDqiwIJ6JaROUU03jg+volzKx0qN76h
 P8YcAzZoruBppuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


