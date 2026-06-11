Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA400CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbMd-0006Br-Aa; Thu, 11 Jun 2026 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbMb-0006BY-Nw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbMa-0005FY-5I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg7KsGskAxUGYQuCz+J5GZpDMT7LUWwYGX21cOcPlLI=;
 b=cQS/cYnPGNAE4C8CxJY4GJBUzB9E1VyD8cTkVWbww3tlp29xTledW/da6t3riBs+sju+4Q
 gjiigG2U0gTuTo0Q9OR3oiuqTigC0PGdYlfDu4vEmhxnmfWVuN3mhF38cZbVFX6XR1XbUN
 /9s2d/vHrSwvNq6f0IjPeg6L1hn1hPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-M5idEvZ4OMyGSIvSC8Z7bw-1; Thu,
 11 Jun 2026 05:06:10 -0400
X-MC-Unique: M5idEvZ4OMyGSIvSC8Z7bw-1
X-Mimecast-MFC-AGG-ID: M5idEvZ4OMyGSIvSC8Z7bw_1781168769
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 140921955DCA; Thu, 11 Jun 2026 09:06:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D611736917; Thu, 11 Jun 2026 09:06:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:43 +0400
Subject: [PATCH v3 28/35] ui/gtk: move global display settings out of
 per-console init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-28-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
 bh=qAumGrHZBnM0t7kIhTqS+Wj/lvxsIp0KF4uHpXKaqGU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnhTyWXQINAwbT02RNtuXTGCPgeAFf+faeL9
 oWD+jtFSBmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54QAKCRDa6OEJdZac
 5YukD/90qVdIZwlVa+kDOjvvTWEHF6ouSLD5z7e0Pwas78hvLrD4GoYa4RsI0cIM7S6SWyXWoXV
 BYNTIRAs3WG7T+CRc/gVVhkfVCS0+hD4t717U3JuYQdF/vnG+TeVzHvcfrs3RcNCDcE15AK4TRK
 gveqQcfIUpKwmFxShD8u9/WLQYrG3E+Vn4CnkFHEq9PsjIlJ4G5HKb3FszxT791fjr2iaNYaXWB
 GVPIUHF0U4uZYtNRyrro8DXMrhlFDrTOYcE9in5BkXI1I2ZgPw0rBMoq63qA2tCr0+MWuom2ugg
 KQ16EsJB8uYNcLjJgnWcqOZTWaTh6f0nwTs9jivD3igaDLGbyn7Bx3XxehJlDxFa3kPsm7vjZaU
 7uySBOYGLBHHEhQK7M4EHTPiVistW7hmiXtVivedBwGMGI2EJrFJ7rQ381PD3ji4yfq0O6TUhWM
 wE5I0k4e44ETEjjzSr1pcrLDOXqtNsDV9lSu5NMfmIqalkWMhSBMk6Ws2EoUxEfu0ubh/vYXoiv
 O6wtWsvkmZ98fB3BnOpzf09DczRAxaqdHkzs9AipSV0VtVkxkgQKll3xcJJCRfVWLT64NoytfoR
 pLcQ8+1R3UWq/ZpNWHKLkug243UIZPKcwJVnyGmnMjy5v/usNBiR7D4svj5MVt3scn1cwsspUne
 GjAKPDV3roOHZbw==
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


