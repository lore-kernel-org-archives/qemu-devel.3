Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E54CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUGr-00035h-Mp; Mon, 08 Jun 2026 03:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGV-0002eJ-1C
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGT-0000qr-Dn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+H65yUMS8QFZ0xHQwMaM4OHCR//vhW9gwvM6NoXdvEg=;
 b=ef/WV/BHz+nuMmXUrbd3oqVe2k0TtpAT99/E656pRf+5SQ6yYNMmWWvT06tjIrBiUCzBji
 EyqCM+dXeYfO9cL5BFTKSHF5usu+1wvHgYgXveHSg/nGN5568MWpKmuuxYg0kilhMbhZ6T
 Rxi+yfmwSM6g0GsfJsCsGWMrn2YNg9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-8eS3cnGiOi2_rEUPb7YuzA-1; Mon,
 08 Jun 2026 03:19:00 -0400
X-MC-Unique: 8eS3cnGiOi2_rEUPb7YuzA-1
X-Mimecast-MFC-AGG-ID: 8eS3cnGiOi2_rEUPb7YuzA_1780903138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01EA19560A3; Mon,  8 Jun 2026 07:18:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C02593008B34; Mon,  8 Jun 2026 07:18:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:44 +0400
Subject: [PATCH v2 26/33] ui/gtk: move global display settings out of
 per-console init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-26-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=T3Lt4cLR7Bg9GWH2jYmqVlSV1/LktAb6F8RB4zswtXA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxMll2gy036aC14VVKW29DciojsX8UtOM05Q
 IgjlDUM0DiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTAAKCRDa6OEJdZac
 5Xe6D/wOlzc4AskBiy2Bm+/yc0foFA0kpcJNppbM7qQL//jnz/JYSTX8JETnAKwdh6znH7SsRT5
 yweTn/IM9lxWtHMbM/qlc9hxHd/oa+s2wZ4NWpJab4zf0gidUiLwfrKt75PM9hRB6V5LZimyCU+
 KZwcPkpY+Iirphuger/DvHx7IeN7X2ZrCB2hMLBb873KYeTX5k0373qNiL37xl/7613RLY0AXKB
 KmkqjS5oBJhWh3KVSbsoQT7KxPuSBCNtTLdAeWHvkntq+nK+w/1f3AUsu5hMiwYSFqFwmsOVcx0
 L7YAhZaJIfKffn3H23Kkk5g1TlAKSbNcI3Mzho2GWwUzYHQtuiIXEe258bj089lUmiqP8swAQgB
 6h/1IjP6zq98RjFSunJob7A7h5N44jdlkevSRyoxU/lg9qRhFGqokCdiMxQFAvquY3osHvOzwEc
 vy8TtLXmXARt+2u5Bk9rc+tyHL3KpG5643gNl43XHv/Rn/0GhhPv/X5fNLq+OYJRD+afHHb370A
 LVtqVCub1lONSrWx34ZfR11oT+jGfH0a/p7WqIjOG00iNrlBJHkJbzOf1q6do3GIJez3OVzZJCB
 TzRaCUpoSrTdM3TebfoWLlmL8VvxYyMQIj/Z3TtL8t+yuqbbr3Tu6YK4SIoIzzKtReyJBNvcknD
 HbHQKW7+SUHGd2g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Move zoom_to_fit, keep_aspect_ratio and touch_slots initialisation
from gd_vc_gfx_init() to gd_create_menu_view(). These are global
display settings that should be set once after all consoles are
created, not repeated on every per-console init (where the last
iteration's values silently win).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5bc2a04b43f..e86b618f770 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2269,8 +2269,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               GSList *group, GtkWidget *view_menu)
 {
     const DisplayChangeListenerOps *ops = &dcl_ops;
-    bool zoom_to_fit = false;
-    int i;
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
@@ -2350,26 +2348,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     gd_connect_vc_gfx_signals(vc);
     group = gd_vc_menu_init(s, vc, idx, group, view_menu);
 
-    if (qemu_console_ui_info_supported(vc->gfx.dcl.con)) {
-        zoom_to_fit = true;
-    }
-    if (s->opts->u.gtk.has_zoom_to_fit) {
-        zoom_to_fit = s->opts->u.gtk.zoom_to_fit;
-    }
-    if (zoom_to_fit) {
-        gtk_menu_item_activate(GTK_MENU_ITEM(s->zoom_fit_item));
-        s->free_scale = true;
-    }
-
-    s->keep_aspect_ratio = true;
-    if (s->opts->u.gtk.has_keep_aspect_ratio)
-        s->keep_aspect_ratio = s->opts->u.gtk.keep_aspect_ratio;
-
-    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
-        struct touch_slot *slot = &touch_slots[i];
-        slot->tracking_id = -1;
-    }
-
     return group;
 }
 
@@ -2379,7 +2357,8 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
     GtkWidget *view_menu;
     GtkWidget *separator;
     QemuConsole *con;
-    int vc;
+    bool zoom_to_fit = false;
+    int vc, i;
 
     view_menu = gtk_menu_new();
     gtk_menu_set_accel_group(GTK_MENU(view_menu), s->accel_group);
@@ -2453,6 +2432,27 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
         v = g_new0(VirtualConsole, 1);
         g_ptr_array_add(s->vcs, v);
         group = gd_vc_gfx_init(s, v, con, vc, group, view_menu);
+        if (qemu_console_ui_info_supported(con)) {
+            zoom_to_fit = true;
+        }
+    }
+
+    if (s->opts->u.gtk.has_zoom_to_fit) {
+        zoom_to_fit = s->opts->u.gtk.zoom_to_fit;
+    }
+    if (zoom_to_fit) {
+        gtk_menu_item_activate(GTK_MENU_ITEM(s->zoom_fit_item));
+        s->free_scale = true;
+    }
+
+    s->keep_aspect_ratio = true;
+    if (s->opts->u.gtk.has_keep_aspect_ratio) {
+        s->keep_aspect_ratio = s->opts->u.gtk.keep_aspect_ratio;
+    }
+
+    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
+        struct touch_slot *slot = &touch_slots[i];
+        slot->tracking_id = -1;
     }
 
 #if defined(CONFIG_VTE)

-- 
2.54.0


