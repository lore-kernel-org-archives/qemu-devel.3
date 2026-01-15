Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1778BD3CCB1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgG8i-0001Xk-7I; Thu, 15 Jan 2026 00:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG8g-0001Vm-Ds
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:43:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG8e-0005Az-11
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:43:22 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F5hDoN063109
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 14:43:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=i+BwiseMQj0mQxHK2/k1VFKYppgZNnaCntKyrEeA21Q=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1768455797; v=1;
 b=PHg4bOlPncwbSk090tdPNg4rQX8Wye+/Q3Yl3kMQqet8QtsK9dj0r9aPl0wLapDB
 ugG9Qp4oRyBU3ogsHyEI8pz1Km5/v9+4i9Y8mXaOfGypTwozJwTWzMw/qqlcEJ9N
 NGswrYe5PV8vG6iNoWqdWAl6V4YIboZUDrqqRfVQDwOqm/PEYxI9wq9iK4nUupP0
 YDbPZGvxFVuq67Xg14qAsUulooARIR3Bw2XlohCRkxvet63zUG2HDk+n2MXoVRPY
 eg41EGeW0fBstGcIWql9O/GsyCbfvY7tOpy5wHUZ6tGZLyRYM5BZBqB4lfYQAE4O
 FIhHFP3I4Olv7aQfXOlvcA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Jan 2026 14:42:56 +0900
Subject: [PATCH] ui/gtk: Narrow DMA-BUF critical section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-gtk-v1-1-57f49e856408@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAF9+aGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NT3fSSbF0TI5NkoyRLQ4NUM1MloMqCotS0zAqwKdGxtbUA5vrOZVU
 AAAA=
X-Change-ID: 20260115-gtk-424c2b910e65
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ui/gtk performs the following procedure to flush a scanout:
1) Queue a draw event.
2) The draw event gets triggered.
3) Blit the scanout to the framebuffer.

When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
possible and unblocks it after 3).

Blocking the device before 2) has two problems.

First, it can leave the device blocked indefinitely because GTK
sometimes decides to cancel 2) when the window is not visible for
example. ui/gtk regularly repeats 1) as a workaround, but it is not
applicable to GtkGLArea because it causes display corruption.

Second, the behavior is inconsistent with the other types of scanout
that leaves the device unblocked between 1) and 2).

To fix these problems, let ui/gtk block the device after 2) instead.
Note that the device is still blocked during 3) for DMA-BUF; this is
because, unlike the other scanout types, 3) can happen asynchronously
with the device for a DMA-BUF, and the device may simulatenously
overwrite it, resulting in tearing, if it is left unblocked.

With the problems fixed, the workaround to repeat 1) is no longer
necessary and removed.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/gtk-egl.c     |  8 +-------
 ui/gtk-gl-area.c | 23 +----------------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999cdb..61bb8d731ac5 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
+            graphic_hw_gl_block(vc->gfx.dcl.con, true);
         }
 #endif
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
@@ -152,12 +153,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_egl_draw(vc);
-        return;
-    }
-
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
         if (!vc->gfx.esurface) {
@@ -408,7 +403,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
 
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        graphic_hw_gl_block(vc->gfx.dcl.con, true);
         qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_egl_set_scanout_mode(vc, true);
         gtk_widget_queue_draw_area(area, x, y, w, h);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d264a..9e7ec7043037 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
+            graphic_hw_gl_block(vc->gfx.dcl.con, true);
         }
 #endif
 
@@ -163,27 +164,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        /*
-         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has already
-         * been submitted, but this function does not call gd_gl_area_draw() in
-         * such a case due to display corruption.
-         *
-         * Calling gd_gl_area_draw() is necessary to prevent a situation where
-         * there is a scheduled draw event but it won't happen bacause the window
-         * is currently in inactive state (minimized or tabified). If draw is not
-         * done for a long time, gl_block timeout and/or fence timeout (on the
-         * guest) will happen eventually.
-         *
-         * However, it is found that calling gd_gl_area_draw() here causes guest
-         * display corruption on a Wayland Compositor. The display corruption is
-         * more serious than the possible fence timeout so gd_gl_area_draw() is
-         * omitted for now.
-         */
-        return;
-    }
-
     if (!vc->gfx.gls) {
         if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
             return;
@@ -342,7 +322,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        graphic_hw_gl_block(vc->gfx.dcl.con, true);
         qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
     }

---
base-commit: 667e1fff878326c35c7f5146072e60a63a9a41c8
change-id: 20260115-gtk-424c2b910e65

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


