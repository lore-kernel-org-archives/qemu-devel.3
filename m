Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFF9C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 13:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdq2R-00058n-0d; Sun, 28 Jun 2026 09:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wdq2N-00057x-07
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 09:59:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wdq2K-0001RW-0a
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 09:59:06 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65SDwjCe009933
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 28 Jun 2026 22:58:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Wfn+1QqEGyb4UTQOAKfa1rLk9JAIIu71oqP1oD3W5yc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1782655136; v=1;
 b=Xs0h4LTUiD796CkfW97l965Ep/ZGtzLsgJ4wL9HQohWbwuDes1IMpt9O41QUhpYl
 yJhPMZZWWAgQdDzf9ShvYrnmdEvk7J2B2fOIMr50SMqH92qNT+M2VUJD3jD1Cx8I
 Jc1amIxUvzv4mNctx0/6NdkkaFG2inKfDWPAR0qMaUjdH4dYCgJRrUJYuBIrbQRd
 qKSJVRdEa8MNTOCP+vfHFnT7K2numf53ebbtoc/2UbGtNBY4bdDW1nfmeCGNcW/A
 OyXkyUiTJLSjcWuqx/6KAVxEeVRDgRaFCvW/xFtPPDYQGpYMVox7jyi0htDU5t7x
 EQ8PMthsBw16HiBqjRJ/hw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 28 Jun 2026 22:58:28 +0900
Subject: [PATCH v2] ui/gtk: Narrow DMA-BUF critical section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMwQ6DIBAFf8XsuRAgQLUn/6PxYOmKWxMxQE2N8
 d9LvfU4L29mh4SRMMGt2iHiSonCXEBdKnBjP3tk9CwMSigrpDTM54lppZ16NFKgNVCeS8SBPmf
 l3hUeKeUQtzO6yt/676+SSWaug26wNlaLuo3Jc0ec+JvlMG2B946/FuiO4/gC+mfhKKMAAAA=
X-Change-ID: 20260115-gtk-424c2b910e65
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=5660;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=u9PNnrGuU9cST5YQYAuYVgWgWK9ItE3ISy/dmOCa4a0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ajxvw1wX93fFdav0Tjnukv/zmMSyNslvdzs+woFtDOi
 ruVLFXeUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJEuT4Z/2jf+d2s1X2fe4tVr
 s/nf57tflVb+mVYSoOuh3FjJ/liilOGfjVTYXyGRCYpeirsus56/N9GafcPBPU/TlNJ1G52NF0a
 zAwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
---
Changes in v2:
- Clarified that guests can use pageflip to avoid tearing while ui/gtk
  only needs to keep the DMA-BUF stable during the blit.
- Avoided the unprotected gd_egl_scanout_flush() fallback by queuing
  redraws through gtk_widget_queue_draw_area().
- Link to v1: https://lore.kernel.org/qemu-devel/20260115-gtk-v1-1-57f49e856408@rsg.ci.i.u-tokyo.ac.jp
---
 ui/gtk-egl.c     |  6 ++----
 ui/gtk-gl-area.c | 23 +----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 7c5c9b2428c2..adc81f34b1c8 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
+            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         }
 #endif
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
@@ -405,14 +406,11 @@ void gd_egl_flush(DisplayChangeListener *dcl,
 
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
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
index 23806b9d01bb..29497019ee46 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
+            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
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
@@ -347,7 +327,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
     }

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260115-gtk-424c2b910e65

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


