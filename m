Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jVG4Za+9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLBzu-0002II-Cu; Mon, 26 Oct 2026 00:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xLByE-0002Db-A9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 00:06:02 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xLByC-000329-K9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 00:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792987561; x=1824523561;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=/LiZVN97BQwTm7lMfTGjfxFIBWMgJOMutxV0WxIqJ5Q=;
 b=jVG4Za+99JykjUKFU8zz01M9pDWRbufs9XmTNz/7jfMMQZ3b5uY/WqLC
 hiCQs6tP/Yjn7PRMiIFFYxtJ2g4+49YBA4TJMjsonR/dm6IUaQYuRZhXd
 7OYq7e8Bk5VoxTLosZDqC54St4F/xd3j7w3oAqzpx20vEZsv+2DJI2UQL
 4LnWoiuyntdkgehgcGRfez4k0tPPHlOPh1eFnxqJrwLkQAxGSlxHHY4E2
 BsMiV5/JC7JicwhD8ekNujsT4gixYaxoEpxlZmrdgCUAJvvZSzXNQcmcv
 5bJ1yl9RWzqJFhmsfZ+RpvN4HZCi3yw1P2i1DztS7ipMMJbsX5iUIkR6U w==;
X-CSE-ConnectionGUID: irmRt+4/RPy4j+C7OfwPTg==
X-CSE-MsgGUID: UWhqt80ATtOUgjuUvY85Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1524788"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1524788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 21:05:12 -0700
X-CSE-ConnectionGUID: jL6kB8t3SqWQQb9+3YHN4w==
X-CSE-MsgGUID: swEdsx0vQ1+L0vQLGEVLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4213620"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com (HELO [127.0.1.1])
 ([10.80.113.172])
 by orviesa009.jf.intel.com with ESMTP; 25 Oct 2026 21:05:13 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
Date: Sun, 25 Oct 2026 21:05:20 -0700
Subject: [PATCH v4 3/3] ui/gtk: Defer initial fullscreen activation until
 window is mapped
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261025-gtk-ui-v4-v4-3-6cf2b6ffeb55@intel.com>
References: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
In-Reply-To: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=198.175.65.9; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v2: Use gd_is_full_screen for full_screen check in gd_window_map_event

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 10db77414a..ff9d17015c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2902,6 +2902,22 @@ static void gd_vc_free(void *p)
 static GtkDisplayState *gtk_display_state;
 static gboolean gtkinit;
 
+static gboolean gd_window_map_event(GtkWidget *widget, GdkEvent *event, gpointer opaque)
+{
+    GtkDisplayState *s = opaque;
+
+    if (s->opts->has_full_screen &&
+        s->opts->full_screen) {
+        if (!gd_is_full_screen(widget)) {
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
@@ -3001,7 +3017,8 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->has_full_screen &&
         opts->full_screen) {
-        gtk_menu_item_activate(GTK_MENU_ITEM(s->full_screen_item));
+        g_signal_connect(s->window, "map-event",
+                         G_CALLBACK(gd_window_map_event), s);
     }
     if (opts->u.gtk.has_grab_on_hover &&
         opts->u.gtk.grab_on_hover) {

-- 
2.34.1


