Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B7C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPg-0000T1-Su; Wed, 22 Jul 2026 08:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNs-0003zW-JZ; Wed, 22 Jul 2026 08:49:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNn-0001tC-HQ; Wed, 22 Jul 2026 08:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=J9a48cWEgTgFtqpPf8tmVd3EWC7yUB/j19YWh3nygu0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PPZpdWYELfsn8wCskEUbyXgq+cbVbYLapkq0rdCcI6HnG/mocJjzzLBiiQxb6444S
 gEB86ap/UHkXLbJB657hYnYj+MS+8rfGOdRB4kyODPGBw0DR6wSzZOxkyzMvTrpP2O
 ie40cgdXY3RtvZso4EdrU2gojNHlag1qLbdII8d3Q0lsLFbqWe4VKQEmZL7of/qheT
 PRcosgmtagiE1pfznG2quARpJdm6fo72GdK1/0pghpRwqpcwRi8razsS8ri29Uc/kW
 ePXihx4hmMxUNOLsrDkQ4Q2iwowEUINA5yTDWY5y4nrEyT3GmJgfhEtURBZrHkoIEv
 5ecvhwmDxA8yw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDCEB1C3B0F;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 115B33F3769;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 760E217F07; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 102/122] ui/gtk: Narrow DMA-BUF critical section
Date: Wed, 22 Jul 2026 15:45:51 +0300
Message-ID: <20260722124622.31034-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Scanout operations need to be properly ordered to avoid tearing. The
virtio specification allows the guest to use pageflip. With pageflip,
the guest only modifies the invisible framebuffer while the host scans
out the visible framebuffer. The guest may choose not to use pageflip to
avoid its overhead, accepting the risk of tearing.

ui/gtk performs the following procedure to flush a scanout:
1) Queue a draw event.
2) The draw event gets triggered.
3) Blit the guest framebuffer to the host framebuffer.

When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
possible and unblocks it after 3) to enforce proper ordering. However,
blocking the device before 2) has two problems.

First, it can leave the device blocked indefinitely because GTK
sometimes decides to cancel 2) when the window is not visible for
example. ui/gtk regularly repeats 1) as a workaround, but it is not
applicable to GtkGLArea because it causes display corruption.

Second, the behavior is inconsistent with the other types of scanout
that leave the device unblocked between 1) and 2).

To fix these problems, let ui/gtk block the device only when the
queued draw event runs, immediately before 3). Blocking before that is
unnecessary since ui/gtk does not access the framebuffer yet. If the
guest does not use pageflip but instead updates the visible framebuffer
directly, ui/gtk should not add the overhead of a pre-draw block.

ui/gtk still blocks the device during 3) for DMA-BUF. Unlike the other
scanout types, 3) can happen asynchronously with the device for a
DMA-BUF, so ui/gtk needs to keep the visible guest framebuffer stable
for the blit.

With the problems fixed, the workaround to repeat 1) is no longer
necessary and is removed.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 53f0d87db7b4bc4b8c906eedcce6fec17d39824f)
(Mjt: back-port to before v11.0.0-787-g405a42e3655
 "ui/console: rename public API to use consistent qemu_console_ prefix" which
 renamed graphic_hw_gl_block() to qemu_console_hw_gl_block())
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 947c99334bd..fd72f02ff6f 100644
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
@@ -383,14 +384,11 @@ void gd_egl_flush(DisplayChangeListener *dcl,
 
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        graphic_hw_gl_block(vc->gfx.dcl.con, true);
         qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_egl_set_scanout_mode(vc, true);
-        gtk_widget_queue_draw_area(area, x, y, w, h);
-        return;
     }
 
-    gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
+    gtk_widget_queue_draw_area(area, x, y, w, h);
 }
 
 void gtk_egl_init(DisplayGLMode mode)
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index ddb51efd5f4..bfcf96e25d6 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -73,6 +73,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
+            graphic_hw_gl_block(vc->gfx.dcl.con, true);
         }
 #endif
 
@@ -135,27 +136,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
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
@@ -314,7 +294,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        graphic_hw_gl_block(vc->gfx.dcl.con, true);
         qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
     }
-- 
2.47.3


