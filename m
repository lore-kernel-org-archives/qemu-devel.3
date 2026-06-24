Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7293DCDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1m-0006QP-9o; Wed, 24 Jun 2026 07:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1k-00065p-9b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1i-0008Hq-4R
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMJGqPCB7/Q2ImivU61P/WtWAZlTP9zza2YC/cPPjIg=;
 b=TS/h2b0E+maFWDj/jEbVchd1kxLHeuNzngckShNCO4mcJSxh2NAUtusH6/HdZn0+9uBH4R
 NZnvpJ4llsSrt4b9TrymLAjud2Yb2rgbKP+f6JB/IxBT/QB47cUXmR+6g2PYkO1kmycMFf
 A7o0QQ3RvNxRnuu8oMzAdZGbSw372Gw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-z10TLBsrPwiOD2fra6sYNg-1; Wed,
 24 Jun 2026 07:44:16 -0400
X-MC-Unique: z10TLBsrPwiOD2fra6sYNg-1
X-Mimecast-MFC-AGG-ID: z10TLBsrPwiOD2fra6sYNg_1782301455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70AC71955F11
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3253D195609F; Wed, 24 Jun 2026 11:44:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:52 +0400
Subject: [GIT PULL 30/35] ui/gtk: handle console hotplug/unplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-30-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4177;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EHnnlH/qv29Cu9NeDZAM54dpMmMb6B5GcdzhzH2LPr0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JpuoTXJwjl4C5c+oerk0Nt4SrVaOSNLOLRY
 dlm8amzyHyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaQAKCRDa6OEJdZac
 5be3D/9DuTr0/mgyfZC+B7tM1y0TFA1exlGnFMwZncL+IQfukOLO6iA7L1q1wqRePyBKh5YFa+n
 YSuaeEgW/Uo/dULbIS+QNHEYeIiIS9nsidHRWNweXvolsSvAm5gxkXkITecss2h8TXvuZ6f/6as
 k20/5uMeNJ1XQxKvni12jyuLncBgAOukYSh8X+ALMWjjiQZsLLGzfNUydXJ5dUdABq4WLxxwktJ
 OoZyhm4fTDevBA7rbwBqfGdtBiDEzVlw022/Az3PGvQg4KjPaO/0Ea+aEor+ridsvYKqxFol1Qt
 BUGQ9MBfCQgZGi/aep/FL1Bco88OpK8bX4WnOucx5Kv3eqAJHFTiBinma8EsdBk1JqEG/Lfu1b1
 TUvL63JqC9LfdJ1LyasIMa8Xs/SFYPRSZsIWXdHS4V/qQyIvkNGguO3yGQfRqFoANY401PLKgej
 Cud3zNNnHhgd3stVFLUSZSJV/NisxGQP61mESDr7CXBC2asjFUdb/NDXPFiWLSziqaMnt+JwxZh
 jVMit32SUSlSoJQ4mkimn4HuLNkMXaJzpD1xt7U4KvQZzZJvZ3IHh4yu9lOf+WblPnPKyuWw27h
 1KEfPNi5PeriBKgNihmpsnb3lbpcyVg3cXQYYjs0ZF07KcyPSjazIU3fUx8qCQKQzfeEwlgRs6p
 JP/LtS5OUbXZ70Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Register a console notifier so the GTK display dynamically creates and
destroys VirtualConsole tabs when graphic consoles are added or removed
at runtime (e.g. vfio-pci with display=on hotplug).

Add skips consoles that already have a VC binding, remove skips unknown
consoles.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-30-4656aec3398d@redhat.com>
---
 include/ui/gtk.h |  1 +
 ui/gtk.c         | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 53d0e447a23..5c9c34a069e 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -141,6 +141,7 @@ struct GtkDisplayState {
     GdkCursor *null_cursor;
     Notifier mouse_mode_notifier;
     VMChangeStateEntry *vmse;
+    Notifier console_notifier;
     gboolean free_scale;
     gboolean keep_aspect_ratio;
 
diff --git a/ui/gtk.c b/ui/gtk.c
index e7a9156f206..7078d89d679 100644
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
@@ -2414,6 +2415,74 @@ static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
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
@@ -2694,6 +2763,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
     gd_create_menus(s, opts);
 
+    s->console_notifier.notify = gd_console_notify;
+    qemu_console_add_notifier(&s->console_notifier);
+
     gd_connect_signals(s);
 
     gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
@@ -2814,6 +2886,7 @@ static void gtk_display_cleanup(void)
         return;
     }
     qemu_del_vm_change_state_handler(s->vmse);
+    qemu_console_remove_notifier(&s->console_notifier);
     qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
     gd_clipboard_cleanup(s);
     g_signal_handlers_disconnect_by_func(s->notebook,

-- 
2.54.0


