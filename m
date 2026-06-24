Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC3FCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1Y-0005GS-AF; Wed, 24 Jun 2026 07:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1T-0004xr-N7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1S-0008F3-3h
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE0rbc1W8WQri077mYJc24bwE+yLX9BU7lf3LJ2qwBw=;
 b=SsDKNbpSr2TQPccgF5yhlZS9W0c6kulZdq75x0jlY00X7Q0QyDRRD/1+e30+ThMkoqIGeB
 J8bPAZvb4ItSpK7sd2/Mze5SBoAoQ1K+pcN1TbOkadaFuGQHv3xF14Z0vPA6H5hjwRZ0Bo
 0AJPfO8Ib3OkRjvjQNxzJhL82GPosGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-3prqVybdMvCHyfv-LDsfRA-1; Wed,
 24 Jun 2026 07:44:00 -0400
X-MC-Unique: 3prqVybdMvCHyfv-LDsfRA-1
X-Mimecast-MFC-AGG-ID: 3prqVybdMvCHyfv-LDsfRA_1782301439
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E9B1955D9C
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05B743691F; Wed, 24 Jun 2026 11:43:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:49 +0400
Subject: [GIT PULL 27/35] ui/gtk: move global display settings out of
 per-console init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-27-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZUBXtPJlX2OWT/sTPMuuEumHPHaM//93HxlNryQXaXc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jo0WC1H/Z/vvRGLcW+JX0iPRosPS5cyDkQ4
 aG/Ot9vsqOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5ULHD/0V0Ll1o2kLD/QeAbxm3QxmukVw+uKkgOnaskRbvc5WBj04gxZXn0q/jXDzWVryxj3/gGO
 E8vgSD3CXJKVr2efRImaZ7BPJcqk7+VJu8/6jfVhaeE/bNEOrTbmC9/kT5kf6dF7HkaQN7tAa28
 iEnDfmTTEdvobkpkno/Abd7H4af3GRp3bcV6P8xj8UBi0LWYBxSXzT0vkPXTxRZcve9h1Y0hriU
 SdaN/UIgdPMDqNmrDHnItohKvtctLVw4DzEjGng72TY/m/RLS8DYRJpxXSy8iowdYbndfTOOfyL
 YMKVcY7uEIkBGFdWba/IzVSFzb1Fkp4JX+4yR9Y46uu9vgCNuxZZuJxU2YjH5G3GF2WhwxDENkq
 X/G/eOIpPsaUbIOmrK2sdnWabcNqT1HnzGiUAae6WGOUKd8q9ss3CuYDmTL3WTtbbr5SSTJshWs
 6HlIZeaz8Jqz7m25JOY0Q6SwiVSgg+JCi/nVInEZOABIjfwUeAg03GoaQWECDnD9xU2tVaf/Ogi
 b8Xksmz3o3MYV7jyESZvDBpMsT6EmR2lmjxVnbiztldq5OQg9YlM1S7tAakknolVZqdsxJZOhKB
 vgrxo/c9CHYk2eFJNxEC/VPImgGII/sAYYbIarkTHwOnreBajvgxkAQLP4dbywI+eTbok7y5T2f
 NhwWXrf1m79z9xA==
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

Move zoom_to_fit, keep_aspect_ratio and touch_slots initialisation
from gd_vc_gfx_init() to gd_create_menu_view(). These are global
display settings that should be set once after all consoles are
created, not repeated on every per-console init (where the last
iteration's values silently win).

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-27-4656aec3398d@redhat.com>
---
 ui/gtk.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index b4dcdcd9a44..929e4cf43f7 100644
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


