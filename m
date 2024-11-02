Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB57E677E0
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 04:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t75NX-0006dh-Dl; Sat, 02 Nov 2024 00:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1t75NT-0006dK-Nd
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 00:04:44 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1t75NP-00029Z-He
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 00:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=y6ck5i42cffhvphu6dxjdetwli.protonmail; t=1730520266; x=1730779466;
 bh=H6opuookDxUI0mwjF3PWotdN0kb6cIai48YZoVVmwqA=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=bU4Epr5krfnY3dfyx4JgFzNyNtgRYIDOSDbdEr6bWTFLKiFQLunpLzFCX3HiCdWi+
 usfHjoSlhxkFXr5Y1zZaGINT/V/3Ikp6VcaXKBJaSDfDNkPQkuvpqas3WOL8PuZD62
 Ac9EOurQOPi/8xrSoo5B4gXtI8unEJjc0iSLnKKC6jfXBqzl3wZUFhuM0atuKy7OGs
 SjBi1MGylRqSCF0NMx/1IuvhQWrPY8i7jcDZDdX4vXxZBVy71CbwsrQh8OmjEXf03c
 cGeLFLbcbjjkDRoHSE1S2dc52tnHlWtvw07UkRRWMDUZbHVLX1gcthkid9EuBufX/w
 sJXOhKTErtQFA==
Date: Sat, 02 Nov 2024 04:04:24 +0000
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org
Cc: dongwon.kim@intel.com, hikalium@hikalium.com, thuth@redhat.com
Subject: [PATCH] UI/GTK: full-screen after wait for hiding of tabs and menu_bar
Message-ID: <a3f5c533b761756e90e80cc616e2e9dff3aefa4a.camel@proton.me>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 212866017b3b6ba4e7a4ca75902ee16548a8f6cf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139;
 envelope-from=edmund.raile@proton.me; helo=mail-0301.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Edmund Raile <edmund.raile@proton.me>
From:  Edmund Raile via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wait for hiding of GTK notebook tabs and GTK menu_bar before entering
full-screen due to asynchronous nature of GTK.

prevent:
 * full-screen window overlap onto monitor below
 * black bar on top of full-screen guest display
 * misallignment of host-drawn guest cursor and invisible guest cursor

Signed-off-by: Edmund Raile <edmund.raile@proton.me>
---
I'd like to report an issue with GTK UI and suggest a solution for it.
When entering full-screen, the tabs and menu_bar need to be hidden.

Currently, gd_menu_full_screen() does all of this in-line but since
GTK operates asynchronously, this results in:
 * a full-screen window that overlaps onto the monitor below
 * a full-screen guest display that has a black bar above it
 * a guest cursor that is misalligned to the
   host cursor the GTK UI draws in-style of the guest cursor (QXL vga)

My solution is to wait for GTK to hide tabs and menu_bar,
and only then enter full screen.
I've implemented this with a callback on a simple 10ms timer.

It has been tested to work reliably under heavy CPU load, when
GTK may take longer to respond to requests.

Since gtk.c currently has no maintainer, I am uncertain who to submit
this patch to.

Kind regards,
Edmund Raile.
 ui/gtk.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index bf9d3dd679..2f6aac6386 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1463,6 +1463,32 @@ static void gd_accel_show_menubar(void *opaque)
     gtk_menu_item_activate(GTK_MENU_ITEM(s->show_menubar_item));
 }
=20
+static gboolean full_screen_enter_callback(gpointer user_data)
+{
+    GtkDisplayState *s =3D user_data;
+    VirtualConsole *vc =3D gd_vc_find_current(s);
+
+    gboolean tabs_visible =3D gtk_notebook_get_show_tabs(
+                                GTK_NOTEBOOK(s->notebook));
+    gboolean menu_bar_visible =3D gtk_widget_get_visible(s->menu_bar);
+
+    if (!tabs_visible && !menu_bar_visible) {
+        gtk_window_fullscreen(GTK_WINDOW(s->window));
+        s->full_screen =3D TRUE;
+
+        gd_update_windowsize(vc);
+
+        /** deactivate callback **/
+        return FALSE;
+    } else {
+        /*
+         * re-schedule callback if GTK _still_
+         * did not manage to hide tabs and menu_bar
+         */
+        return TRUE;
+    }
+}
+
 static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s =3D opaque;
@@ -1474,8 +1500,11 @@ static void gd_menu_full_screen(GtkMenuItem
*item, void *opaque)
         if (vc->type =3D=3D GD_VC_GFX) {
             gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
         }
-        gtk_window_fullscreen(GTK_WINDOW(s->window));
-        s->full_screen =3D TRUE;
+
+        gd_update_windowsize(vc);
+
+        /** give GTK 10ms to perform the resize **/
+        g_timeout_add(10, full_screen_enter_callback, s);
     } else {
         gtk_window_unfullscreen(GTK_WINDOW(s->window));
         gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
--=20
2.47.0




