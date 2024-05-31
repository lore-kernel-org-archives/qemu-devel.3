Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFCCC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 18:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD7So-0004KR-SV; Fri, 31 May 2024 14:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sD7Sm-0004Jq-IR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:58:52 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sD7Sk-0002bf-Rl
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717181930; x=1748717930;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FDn3+0B7b0pamU9Rghkcupt9bYANsdYgHr+E/tTlBWk=;
 b=g4/SnCjUIqf7yH2QNyL9FmGHC2SfqMVV5eS/0PPOGNEIRwyrqURI8SW3
 Hma0huPoRj2r06EJGWpZuJ1rxOE+VYgncGvT4Dc0TgEqn2B6F4Bvuwm8w
 gZloVbEVPsP7JuAroZsfDIZ7W9xWE2fA7NDdETi35DcaxPzsnOTAD0eO0
 zUK+G/oCuzlvWw+r90BpdkPcptsfZIeBMf8tO8HQBWSwpvZhHORMqXL/k
 Eiptucw4LsBST3OiSYNJWzR4qFxR8YQIhFHzhTexQKaMjEAlCzWRUq7pB
 HfYTP3ttDeoD2llRa706OezdrHX0qRuCKf7+cwuB1n8jMvqCcqLjkhB// A==;
X-CSE-ConnectionGUID: mPiHZB+VQteIiOxyeKP5GA==
X-CSE-MsgGUID: r3r0tL5xTWS9PLEb76Twzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13965362"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="13965362"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 11:58:44 -0700
X-CSE-ConnectionGUID: pKEFlgl7SxSzlbiPLpsq9A==
X-CSE-MsgGUID: Jf5OF532Q4KSIrWtHHa9RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="67442164"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 11:58:44 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/2] ui/gtk: Factor out tab window creation into a
 separate
Date: Fri, 31 May 2024 11:58:03 -0700
Message-Id: <20240531185804.119557-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531185804.119557-1-dongwon.kim@intel.com>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

Pull the code that creates a new window associated with a notebook
tab into a separate function. This new function can be useful not
just when user wants to detach a tab but also in the future when
a new window creation is needed in other scenarios.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 65 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 93b13b7a30..3bc84090c8 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1396,6 +1396,41 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static void gd_tab_window_create(VirtualConsole *vc)
+{
+    GtkDisplayState *s = vc->s;
+
+    gtk_widget_set_sensitive(vc->menu_item, false);
+    vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+#if defined(CONFIG_OPENGL)
+    if (vc->gfx.esurface) {
+        eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
+        vc->gfx.esurface = NULL;
+    }
+    if (vc->gfx.ectx) {
+        eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
+        vc->gfx.ectx = NULL;
+    }
+#endif
+    gd_widget_reparent(s->notebook, vc->window, vc->tab_item);
+
+    g_signal_connect(vc->window, "delete-event",
+                     G_CALLBACK(gd_tab_window_close), vc);
+    gtk_widget_show_all(vc->window);
+
+    if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
+        GtkAccelGroup *ag = gtk_accel_group_new();
+        gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
+
+        GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
+                                           vc, NULL);
+        gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
+    }
+
+    gd_update_geometry_hints(vc);
+    gd_update_caption(s);
+}
+
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1407,35 +1442,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
                                        FALSE);
     }
     if (!vc->window) {
-        gtk_widget_set_sensitive(vc->menu_item, false);
-        vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
-#if defined(CONFIG_OPENGL)
-        if (vc->gfx.esurface) {
-            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
-            vc->gfx.esurface = NULL;
-        }
-        if (vc->gfx.ectx) {
-            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
-            vc->gfx.ectx = NULL;
-        }
-#endif
-        gd_widget_reparent(s->notebook, vc->window, vc->tab_item);
-
-        g_signal_connect(vc->window, "delete-event",
-                         G_CALLBACK(gd_tab_window_close), vc);
-        gtk_widget_show_all(vc->window);
-
-        if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
-            GtkAccelGroup *ag = gtk_accel_group_new();
-            gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
-
-            GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
-                                               vc, NULL);
-            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
-        }
-
-        gd_update_geometry_hints(vc);
-        gd_update_caption(s);
+        gd_tab_window_create(vc);
     }
 }
 
-- 
2.34.1


