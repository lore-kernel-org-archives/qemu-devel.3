Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F858606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jxfJrBYs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJydx-0005Ov-DI; Thu, 22 Oct 2026 15:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJyda-0005ER-Vm
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:45 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydX-0002bw-RJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792697980; x=1824233980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6ozjDoKM2TkI3/QhrSZp0dTUxzM2BodZ2aG3BUGrc+I=;
 b=jxfJrBYsHu2+OL9xI9w60OFiOiLK6hXcw0Tz18IY6SsJSJS3XniNi9nn
 EkZ9NpWI4dmupk4nMa+PEzIUbr6lGGfirkzCLL0KZTSyohVsqrfZkV9f8
 MtXqb38CbXDtyPDlxrEkHjOJGau7M+wX7iUrOdy8qifvJgkDCx2b81+Jf
 yI56+JP2NzwjMJkB+cFRewjgLvhmuistbrGXEWZrb5OHNIiWukxnrNjTf
 PmAAC8u7vo4RcLho3w5fyh78SnLKXt7cX/kAMf4SoVpoA0eOGOiddQnH6
 pJyXtT62Wz7G7B1cqcUbVj8ZzyEUQa35oUbFT7TvLjaEw+z1yUKwKZ2wl Q==;
X-CSE-ConnectionGUID: i1Hpq2HEQ+WkQupOzLAUjA==
X-CSE-MsgGUID: 10ljPvNwQFmw2CgJgeSZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1563786"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1563786"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 12:39:28 -0700
X-CSE-ConnectionGUID: Y6t2PiYeRQ6YsQVOV1JXTg==
X-CSE-MsgGUID: 2WxkIL38TPSgZRwQc2whxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3530580"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by orviesa006.jf.intel.com with ESMTP; 22 Oct 2026 12:39:27 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v2 3/3] ui/gtk: Defer initial fullscreen activation until
 window is mapped
Date: Thu, 22 Oct 2026 12:39:44 -0700
Message-Id: <20261022193944.19266-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022193944.19266-1-dongwon.kim@intel.com>
References: <20261022193944.19266-1-dongwon.kim@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.43.0


