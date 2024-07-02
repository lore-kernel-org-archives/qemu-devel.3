Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A2AC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 00:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOR4a-00063Q-V1; Mon, 01 Jul 2024 20:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOR4Y-00060y-SO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 20:08:38 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOR4S-0005dn-FZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 20:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719878912; x=1751414912;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QB4s9oB0XRi7T1toWkR1VL72la3yjJEw5FUzDnuLRpc=;
 b=SN6RxHs5r6ye9yblJziI7ITcpy7XR01FUZXY+6T1ZsDeh0DuKbZhaaIe
 6eAeDEtAba8aCRMPR/wjoLovad+ghibG9dMJM6Wcivoqa2m1Y6AY1KuYZ
 CznrtVpPZfRjgZu3jIIjEBuaF+84encB38STnWe/ZljtHiONmlgEruzjy
 E4k5HQwjQ9TOM08Vx3t8wIafAXnwFS2VJDfcglkcsJUGYCG8bpRaTlOj7
 lz+ku88YxWCrkNtgZebJ0ElXbV6sdsE/hT7zBWpHLp1iCgKyj/dBag8/h
 ddC4X4xeSOpOmzAmjoyqj4yPFDws1huDk5PpSJCofVV6nGc30vsXUZfNm g==;
X-CSE-ConnectionGUID: SoII2g+HS3ixycgxwbSMMg==
X-CSE-MsgGUID: qhkbwwp+QkGWjqYMPFsAbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20790603"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; d="scan'208";a="20790603"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 17:08:28 -0700
X-CSE-ConnectionGUID: hxt0/hvYSZq7dYQ4eoWBWA==
X-CSE-MsgGUID: YoPWz1zYRl+CdLDGqHsjbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; d="scan'208";a="50561052"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa003.jf.intel.com with ESMTP; 01 Jul 2024 17:08:28 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Attach fullscreen toggling cb to all detached VCs
Date: Mon,  1 Jul 2024 17:07:15 -0700
Message-Id: <20240702000715.2624292-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

Enable hotkey for toggling window fullscreening for all individual
untabified VCs

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 93b13b7a30..768e66bec4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1396,6 +1396,34 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static void gd_vc_fullscreen_toggle(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GdkWindow *window;
+    GdkWindowState state;
+
+    if (!vc->window)
+        return;
+
+    window = gtk_widget_get_window(vc->window);
+    state = gdk_window_get_state(window);
+
+    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
+        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
+
+        if (vc->type == GD_VC_GFX) {
+            vc->gfx.scale_x = 1.0;
+            vc->gfx.scale_y = 1.0;
+            gd_update_windowsize(vc);
+        }
+    } else {
+        if (vc->type == GD_VC_GFX) {
+            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+        }
+        gtk_window_fullscreen(GTK_WINDOW(vc->window));
+    }
+}
+
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1428,10 +1456,13 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
         if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
             GtkAccelGroup *ag = gtk_accel_group_new();
             gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
-
-            GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
-                                               vc, NULL);
-            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
+            GClosure *cb_grab = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
+                                                    vc, NULL);
+            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb_grab);
+            GClosure *cb_fs = g_cclosure_new_swap(
+                                             G_CALLBACK(gd_vc_fullscreen_toggle),
+                                             vc, NULL);
+            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0, cb_fs);
         }
 
         gd_update_geometry_hints(vc);
-- 
2.34.1


