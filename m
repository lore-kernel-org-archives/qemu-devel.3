Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF40DCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUHJ-0003aH-I2; Mon, 08 Jun 2026 03:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGe-00032i-69
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGZ-0000xU-Sd
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSo12UqAozNyKPNf2wzj6CS1smHf5IC3QLcPig7r7q0=;
 b=dpONcwV4MpGPxsqktx3oou70/PuBq5ZfuoFsu+l3+aZiegL2w3zIt8T9bsNhHIcoj0shBc
 ClhSq8bwclHAmJZS89TUmvbEmMfHL2HmL2aS3l+9XAYOqJ6ltvkrO8o7P45nhs7BpKqPx3
 rHfYezM80RXZsqdVQHx2euTmVcNMv68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-t78_EQ_ZOHGC5uljl6PE2Q-1; Mon,
 08 Jun 2026 03:19:16 -0400
X-MC-Unique: t78_EQ_ZOHGC5uljl6PE2Q-1
X-Mimecast-MFC-AGG-ID: t78_EQ_ZOHGC5uljl6PE2Q_1780903155
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063681956094; Mon,  8 Jun 2026 07:19:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87E151956053; Mon,  8 Jun 2026 07:19:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:47 +0400
Subject: [PATCH v2 29/33] ui/gtk: handle console hotplug/unplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-29-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oS1XDhLVUJSxwsHHpY/8zKXncSL2PFHxGoOAAs9N4C0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxN1O8HE9QddYSfgDzMrGoVOY33tUiIcfIGn
 fVLNzeX0iuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTQAKCRDa6OEJdZac
 5XCkD/4oKdHhDz9H/f5ygcsfV5BO+1C/o4tZ5Yd+Mp3pVPqjMYhyRzwLEbeGiCDeWaDE/fAwirf
 gDzrkXnzO9fPgBRrcg76IQ7EIlWGXcW/cJ5O6zXncMSAd/nQoQq40ygQRf08iDvwRVNuZfwJs5j
 o6iYL2Ns5HfB9FcRh+EAVcefawYyumEoWRsRcmt7v3QDimHgFaKmS2b08+z1jx5KmQz2RLkNP6j
 Yf1422mKwxL66Ujxb8CN4TUnk4xtmXcJM/7hr449+PDWPjEBKxrtL3zxJkL7i++3ssDAek25cUN
 ku9AjrUkI8FB8GdAUae1Zly2cIgmm7jb6wq+ZMb4OiNMb3M34AIsLCoLJAI2X5czNStz1ijFylN
 X0ONLcxRqvRz7kaQWLFLSQZgicvzNPGFqE/cxYNCoA5Rc4+YRoouQaCshKXcD9WP6iiM2oZhRMA
 KSgf53m46WQ2lNRTAYmSJKTzthgIJLuDg+cwlrHHIQdoYQ9BccV+oZtFHa3//QLOY2+tL3W9rz2
 YxseUtnsUVgQ4hRSrF1xXx4FB7/uLBbWOR7CSAbJMAC3o20b6fKp3JL6+p3yeJmANPQ2Nz7JfW3
 rXjl/q0p0J5g5j8xhBCRNXQcDBbDPJZv/4pNY1qAae/3DogqHFJcpd8NagZTabMHLIEdUs2WWee
 uS9+qp/pvWyfmcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Register a console notifier so the GTK display dynamically creates and
destroys VirtualConsole tabs when graphic consoles are added or removed
at runtime (e.g. vfio-pci with display=on hotplug).

Add skips consoles that already have a VC binding, remove skips unknown
consoles.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/gtk.h |  1 +
 ui/gtk.c         | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index b0be5070795..6cb611ce474 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -140,6 +140,7 @@ struct GtkDisplayState {
 
     GdkCursor *null_cursor;
     Notifier mouse_mode_notifier;
+    Notifier console_notifier;
     gboolean free_scale;
     gboolean keep_aspect_ratio;
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 6325704c397..6ef58d1367c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2332,7 +2332,8 @@ static bool gd_scale_valid(double scale)
     return scale >= VC_SCALE_MIN && scale <= VC_SCALE_MAX;
 }
 
-static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
+static VirtualConsole *
+add_gfx_console(GtkDisplayState *s, QemuConsole *con)
 {
     VirtualConsole *vc = g_new0(VirtualConsole, 1);
     const DisplayChangeListenerOps *ops = &dcl_ops;
@@ -2414,6 +2415,76 @@ static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
     qemu_console_register_listener(con, &vc->gfx.dcl, ops);
 
     gd_connect_vc_gfx_signals(vc);
+    return vc;
+}
+
+static void gd_vc_add_gfx(GtkDisplayState *s, QemuConsole *con)
+{
+    VirtualConsole *vc;
+    int i;
+
+    for (i = 0; i < (int)s->vcs->len; i++) {
+        VirtualConsole *v = g_ptr_array_index(s->vcs, i);
+        if (v->type == GD_VC_GFX && v->gfx.dcl.con == con) {
+            return;
+        }
+    }
+
+    vc = add_gfx_console(s, con);
+    gtk_widget_show_all(vc->tab_item);
+    gtk_widget_realize(vc->gfx.drawing_area);
+
+    if (s->free_scale) {
+        gd_update_windowsize(vc);
+    }
+
+    gd_update_caption(s);
+    gd_rebuild_vc_menu(s);
+
+    gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), true);
+}
+
+static void gd_vc_remove_gfx(GtkDisplayState *s, QemuConsole *con)
+{
+    VirtualConsole *vc = NULL;
+    guint idx;
+
+    for (idx = 0; idx < s->vcs->len; idx++) {
+        VirtualConsole *v = g_ptr_array_index(s->vcs, idx);
+        if (v->type == GD_VC_GFX && v->gfx.dcl.con == con) {
+            vc = v;
+            break;
+        }
+    }
+    if (!vc) {
+        return;
+    }
+
+    if (s->kbd_owner == vc) {
+        gd_ungrab_keyboard(s);
+    }
+    if (s->ptr_owner == vc) {
+        gd_ungrab_pointer(s);
+    }
+
+    g_ptr_array_remove_index(s->vcs, idx);
+    gd_rebuild_vc_menu(s);
+    gd_update_caption(s);
+}
+
+static void gd_console_notify(Notifier *n, void *data)
+{
+    GtkDisplayState *s = container_of(n, GtkDisplayState, console_notifier);
+    QemuConsoleEvent *event = data;
+
+    switch (event->type) {
+    case QEMU_CONSOLE_ADDED:
+        gd_vc_add_gfx(s, event->con);
+        break;
+    case QEMU_CONSOLE_REMOVED:
+        gd_vc_remove_gfx(s, event->con);
+        break;
+    }
 }
 
 static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
@@ -2688,6 +2759,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
     gd_create_menus(s, opts);
 
+    s->console_notifier.notify = gd_console_notify;
+    qemu_console_add_notifier(&s->console_notifier);
+
     gd_connect_signals(s);
 
     gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
@@ -2808,6 +2882,7 @@ static void gtk_display_cleanup(void)
         return;
     }
 
+    qemu_console_remove_notifier(&s->console_notifier);
     qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
     gd_clipboard_cleanup(s);
     g_signal_handlers_disconnect_by_func(s->notebook,

-- 
2.54.0


