Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5D0C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8Q-0003yi-Fa; Fri, 17 Jul 2026 07:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8O-0003vd-Bx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8M-0003QF-LA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1v2IJbKM5Oxjscr41lNHLZsQaoQQrBM5vp/Iq03XJl4=;
 b=OwIe1bhCz9Im6TUNoGLT9ZglQgOqLeAWM8ZkRWSbZD4M71iUCmQF167VcwasTx3SgtK+mH
 aIrPi34AezWWt1e828VyZ7reTtMCzzhrFZ8b4OwpJ/wOjQp5DO8TT0BKeukHIB6EXtSczS
 UaiTJ/dUaFmD3Uy+3ZmjH1+BRA54qDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-18RIIaBxOrWPftmUs2gw6g-1; Fri,
 17 Jul 2026 07:53:36 -0400
X-MC-Unique: 18RIIaBxOrWPftmUs2gw6g-1
X-Mimecast-MFC-AGG-ID: 18RIIaBxOrWPftmUs2gw6g_1784289216
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B91CB180074B
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FB2C180029A
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:45 +0400
Subject: [GIT PULL 06/15] ui/gtk: Narrow DMA-BUF critical section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-6-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5257;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LqqMGY4JhJinImmIdRRHI4ZI7NgPKJAiKOMMBNgkfvQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWhea/nzAgbuT+z9Y0DZjeaLBr0yo5ldybCYPJ
 YxJLfGb1lKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5TiUD/wLXVubCtcWE0LWygmg9SgUnuiVvTe3VmsymVTB8PcZVB5CjxPST4m+RZNW8Mv58IGNDlL
 IyfMZr17nIUznjbvV+UGcw2zRPPAk9DkXY7DoAjIdjwzMCJaiColaeIg5NsWKXFlwzAUm1w9jcS
 iyZlnloI5pYA0WchcdWL403kqcGrGK8C83UPQlZ2Si/Q4cY8qyYXuCiMipo2EcjqgMLDTW9AThY
 aWppE2WerqKwIr0wVqG6Md94gkvGYGPOQiHLdhNNiZeS2qutTyZqF8+JC3/nRqGWX3lW9PQmz/+
 HoJQR37VgbsPhNBKMAnPxNw6GNW3ER7h05HCyY4qjrhmMscskvnjIvJm5QYfpNIV06R1ehyoTFN
 EqzLdx6W5gihfeAyT0w6oQhiFXfGwepsNyRi4Zgx60QjpdltqGsXFuteuUitWekP9eDjDBRLLoK
 3tLYisU9eRgjtJODOMR8/gilDw4LwzmtB2dyURNSk7UfUX/tO8OZfK28puhfyQdVr26RO+24sxQ
 afC480X8eU47gwpRNlntHU0oJccDGTAIPvmO+jE2JNj2Ah/hRlLPuctEZO2ouPy+TLmh/mdFmfX
 bvhBeuBLhTON8Xtm+nUEyn9YVy3cE3hPc/wtINz1RupjV+EE2kSfpcMoNtcvLWrFU/BnUsZE2fk
 g04DEj3hWKpIsjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
---
 ui/gtk-egl.c     |  6 ++----
 ui/gtk-gl-area.c | 23 +----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 7c5c9b2428c..adc81f34b1c 100644
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
index 23806b9d01b..29497019ee4 100644
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

-- 
2.55.0


