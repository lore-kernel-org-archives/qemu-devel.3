Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1395CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvFi-0007Wl-RW; Fri, 29 May 2026 07:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFE-0005kZ-0z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFC-00008e-EC
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P24QCtBOPZAeXQrOeIzkI8XwMxEGYxQbOqY5zX/qu3E=;
 b=R7S5OLSf942I92NpWkiew+PNQF3QsK1yRUOs1KXaJfUYfs74kAqz5ogyaFR+QGKCrwqmwk
 w+aVup1UGGhnGPYZj+ItvrSqPTt2poW89NPeIWDpFmsflrieO55QwHFoWxY5n9PUB81tMT
 SZP9WSJkm+2XSwhLgnTVZkvSHVfv+Ho=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-mCtGLnbXM3KIU718ehGerA-1; Fri,
 29 May 2026 07:19:12 -0400
X-MC-Unique: mCtGLnbXM3KIU718ehGerA-1
X-Mimecast-MFC-AGG-ID: mCtGLnbXM3KIU718ehGerA_1780053551
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 485AB195608F; Fri, 29 May 2026 11:19:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2E7430001BB; Fri, 29 May 2026 11:19:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:46 +0400
Subject: [PATCH 25/32] ui/gtk: move global display settings out of
 per-console init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-25-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oLtNKsYquzH+c0KmFeoUQjI9K4WgPxTZf34uK0eOhmk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWQ0PYqNtxwLiCeGTcdkRi5qBQqD5GvoSFdR
 X0MeWN6BRaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1kAAKCRDa6OEJdZac
 5Q1iD/99Pkc88COzYZxAegOJMhjkdur+MvXyScL1ZgBC3Jxeb3pH9jeN9O6NOlRuW63uGlYkwbe
 T7sXXAALv9wT1EOiPmUF/kEUM4Mf+iLCJnQST1ZtqCaA16UAaQugtFCSX3BjEnIzU+p2xUD6pXN
 QdpXRuSxuc6BF6nzDBum0sWpTObvaLIAat52IR4FHVg4U4vuC/2jF7TH316VH4drNLsKw1m0XkI
 010aJ1s3NTJud4J2doBUymMi+eXL1vcDmy6rd/lLssM/6UVLEN3hKMr2PXg4vMgImf+cDBUq9Uu
 qZU3Q5ZZNgN/bCN1Som+BOuxYuLhg6jzi9PF6T8s57U3l0358T7ZKk5S9lYJGS6U4KrVjqN+uOS
 fZqlm0GCYVw0BbBhmzZ80nV5UTYcVmPcxzIWrWZKLsh6FQMRy3FkQLhiEQOpz98RTfEvKqscrkN
 Dw8O5CBygNbFXlJYnTjcthbaC/9dVca1GvDZrQcDCn8hvx7W+SNgjbiGMwgPtIfO8iLvb2yBGM+
 TdXDYbkdkEb4VnT75tz4IqDlH7IvplrWqz36Y+y37ENevmrdnBtVfx7dYx79/7lF5yWBQ6Ut1MT
 qrUHPY44P3bx6Wii1o0IV2trfhpoYkgaEdicBMuwt1+6Y4L38FF7dNnpE3LJZ4jcOoUmZ1sJoDX
 Kbx5Hn5DgIf+KAA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 141cb69d494..1b9523739f6 100644
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


