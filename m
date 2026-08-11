Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C817C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kGt-0004CT-Be; Mon, 21 Sep 2026 16:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGj-0004Bd-Qh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:45 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGi-0004w8-9c
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790021140; x=1821557140;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YAH+inPY1fqAvyDyMLGqXX9CkA+KytM7+HVvUjUVZEQ=;
 b=fccpuKE7vbyk6OycUdL83Sa5dISpIZNkroICSh52b/73dgS4dTn4/X2y
 2kMR6r214c5XpKnsb50X9swyOw8jXVvxcU5OVHZotHnGYe5g0AeSh5IGk
 yQUll7pXrR/JuDugp7S3bWEcwBOI3KZwVI6sOGfiC5snh3uStHvibEI5j
 PNmmRqTLjirJG0c1azCG/sS5IDhR8jPF0qulcDbggWDB+5RZyKylXe3Z7
 y1Zi/Ltx7t7gIkE5BdgNotAmoeg8DCZWk5FMwi+OPyU3bnTyZyFJy2u8g
 j6rYCnoLdn5nxWJulH7SHYkBM1QKVNMFluMDfeeUtTAlfNyiUoLngomMj Q==;
X-CSE-ConnectionGUID: anw5x4toQMCmwHTFgChd4Q==
X-CSE-MsgGUID: p+cqTH6WTjOjGU+ddIl50g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94399580"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="94399580"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 13:05:30 -0700
X-CSE-ConnectionGUID: BLSrRgEuQkWiMK0dGDRYrA==
X-CSE-MsgGUID: 8vfOTQ6QTouD5KQ6sPVLPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="272001017"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 13:05:29 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] ui/gtk: Defer initial fullscreen activation until window
 is mapped
Date: Tue, 11 Aug 2026 03:24:26 -0700
Message-Id: <20260811102426.35538-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811102426.35538-1-dongwon.kim@intel.com>
References: <20260811102426.35538-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

When QEMU is started with '-display gtk,full-screen=on', the fullscreen
state is currently requested in gtk_display_init() before the window is
realized or mapped by the display server.

On certain compositors (such as GNOME/Mutter under Wayland or X11),
requesting fullscreen on an unmapped window can be overridden or dropped
when the window is subsequently mapped and assigned its initial windowed
geometry constraints.

Resolve this by deferring the initial fullscreen toggle until the
window's "map-event" signal fires. Once the native surface is fully mapped
and acknowledged by the compositor, activate the fullscreen action and
disconnect the one-shot handler.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index f20edc5c5b..cace30114e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2861,6 +2861,22 @@ static void gd_vc_free(void *p)
 static GtkDisplayState *gtk_display_state;
 static gboolean gtkinit;
 
+static gboolean gd_window_map_event(GtkWidget *widget, GdkEvent *event, gpointer opaque)
+{
+    GtkDisplayState *s = opaque;
+
+    if (s->opts->has_full_screen &&
+        s->opts->full_screen) {
+        if (!s->full_screen) {
+            gtk_menu_item_activate(GTK_MENU_ITEM(s->full_screen_item));
+        }
+    }
+
+    /* Disconnect or ensure it runs only once at launch */
+    g_signal_handlers_disconnect_by_func(widget, gd_window_map_event, s);
+    return FALSE;
+}
+
 static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     VirtualConsole *vc;
@@ -2960,7 +2976,8 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->has_full_screen &&
         opts->full_screen) {
-        gtk_menu_item_activate(GTK_MENU_ITEM(s->full_screen_item));
+        g_signal_connect(s->window, "map-event",
+                         G_CALLBACK(gd_window_map_event), s);
     }
     if (opts->u.gtk.has_grab_on_hover &&
         opts->u.gtk.grab_on_hover) {
-- 
2.43.0


