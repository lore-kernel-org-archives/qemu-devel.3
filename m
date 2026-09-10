Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE1DC88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4erh-0002Wt-L6; Thu, 10 Sep 2026 09:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erg-0002NU-23
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ere-0003e7-9G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O82sAP5Hj+bGeZK3beOKC9TNFaKpvhY6RCKuJLTbO1I=;
 b=DfzxiQgsqYW4gKrzEylNJfcUkRWqE4Q+1qmRuXIO62br3DLeKC+NGyJmUsqID8NaQJFVBI
 kDBwXSdgJjqdAxA9bd5AOEFKqJzNorjTigmqbS+mzPEhSTbdNPRh10V9a04bi2mIMuxBtm
 KDB8EyZiY9wjyRSRnIeXJ4wokHoKBaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-IGcTVQc7McGly9wsvkziLQ-1; Thu,
 10 Sep 2026 09:30:49 -0400
X-MC-Unique: IGcTVQc7McGly9wsvkziLQ-1
X-Mimecast-MFC-AGG-ID: IGcTVQc7McGly9wsvkziLQ_1789047049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E394C195419B; Thu, 10 Sep 2026 13:30:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E00DF1956095; Thu, 10 Sep 2026 13:30:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:02 +0400
Subject: [GIT PULL 07/24] ui/gtk: move draw_submitted from QemuDmaBuf to
 VirtualGfxConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-7-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6254;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gBqWaKJgA4/yz9sjt8xtm7yhbFIUll6dO32lThJ4IRw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDcESJBmGuNqOKrVWeLn/G+T98Ma18gNuBZ7
 Bcqo7f8gryJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3AAKCRDa6OEJdZac
 5U1oD/45xB/b0KjpffrY1sUyIqdS+E96TAQeAzZEkhaGj/jrR9v9S9RDwDMVVEQz0OPbAigQrse
 qlIc0ya28UY9Xtg9MVdf/zFzEquvwnBIOJ1Us6HAm48XrlUz01DaSe01KSg6IrdhaSH1GUQWYgB
 th15mC9REZWlVkDF2aD7fgLqLd+W17cmFhGy4hZdX/VIW8dZDfI+IZUYk+dlT+jN6fO1C2Vq3BT
 VaQm1cZCnwUmPA/PIQZyxnjzb0hhK6GIb8v/6JXSAF1L6buBDXLYL3bX3Q4XsfkBAPKjFZJxXWg
 NU99dP4Xs5bJhm+l8y1L53/ix1pbQHKgaSDP7WnCwAm7BJzOY6DcvRkSO5JKxlzD55Bq3jZkfZ/
 0Y7plyuK76fLfAcc9eJ+quoTFYzGE2plJUaXt2T5unYoaEoZV1z3q6FBa4ICvqix2cjt+390BAi
 s1BmM/MDPXbIrRG8BbDbEvyzG+VTBthYNQa4vBIg5qvShBDdtUIHZNEivuQ9BMm/uTYv/FDGucL
 Z2+/y4yQ5ldrbPHf8JXnMuk2Us7duZ9t+l513NDeK1Y2Frmg3SfTRG5BJKY8n0uWWHLI5IpDWOA
 xUWC2/6aQLeF5TyJ0ti1tqVxgDJtwsK4OyjLfjK9kddYKUjpAuXPInMoel3gZY7/cU5hmHd14b0
 UotBI4/zX+v3DDg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The draw_submitted flag on QemuDmaBuf is only used by the GTK display
backend to gate the draw pipeline and prevent gl_block refcount
imbalance when the guest submits frames faster than GTK draws them. It
is not an intrinsic property of the DMA-BUF but transient display
listener state.

Move it to VirtualGfxConsole, replacing the getter/setter calls with
direct struct member access. Reset the flag when the active dmabuf is
released in gd_gl_release_dmabuf().

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/dmabuf.h |  2 --
 include/ui/gtk.h    |  1 +
 ui/dmabuf.c         | 14 --------------
 ui/gtk-egl.c        | 13 ++++++-------
 ui/gtk-gl-area.c    | 10 +++++-----
 ui/gtk.c            |  1 +
 6 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index 381583bd536c..b972099859f2 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -42,8 +42,6 @@ uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
-bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
-void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
 
 #endif
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 4b4ef50e3701..b66b9ca5c519 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -59,6 +59,7 @@ typedef struct VirtualGfxConsole {
     bool scanout_mode;
     bool has_dmabuf;
     int gl_fence_fd;
+    bool draw_submitted;
 #endif
 } VirtualGfxConsole;
 
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index b61dc7ad2783..495270f29bd6 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -26,7 +26,6 @@ struct QemuDmaBuf {
     uint32_t  backing_height;
     bool      y0_top;
     bool      allow_fences;
-    bool      draw_submitted;
 };
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
@@ -212,21 +211,8 @@ bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
     return dmabuf->allow_fences;
 }
 
-bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->draw_submitted;
-}
-
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
 {
     assert(dmabuf != NULL);
     dmabuf->texture = texture;
 }
-
-void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
-{
-    assert(dmabuf != NULL);
-    dmabuf->draw_submitted = draw_submitted;
-}
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index c671aabd11b3..8623181336e9 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -86,10 +86,10 @@ void gd_egl_draw(VirtualConsole *vc)
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
+            if (!vc->gfx.draw_submitted) {
                 return;
             } else {
-                qemu_dmabuf_set_draw_submitted(dmabuf, false);
+                vc->gfx.draw_submitted = false;
             }
             qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         }
@@ -169,8 +169,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 #endif
     }
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.draw_submitted) {
         gd_egl_draw(vc);
         return;
     }
@@ -290,6 +289,7 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
+        vc->gfx.draw_submitted = false;
     }
 #endif
 }
@@ -406,9 +406,8 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GtkWidget *area = vc->gfx.drawing_area;
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
+    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.draw_submitted) {
+        vc->gfx.draw_submitted = true;
         gtk_egl_set_scanout_mode(vc, true);
     }
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 29d1b1e4116f..45c0c8c81a11 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -82,10 +82,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
 
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
+            if (!vc->gfx.draw_submitted) {
                 return;
             } else {
-                qemu_dmabuf_set_draw_submitted(dmabuf, false);
+                vc->gfx.draw_submitted = false;
             }
             qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         }
@@ -319,9 +319,8 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
+    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.draw_submitted) {
+        vc->gfx.draw_submitted = true;
         gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
@@ -356,6 +355,7 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
+        vc->gfx.draw_submitted = false;
     }
 #endif
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 1c75b9ea3c4d..55e45e8445bc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -593,6 +593,7 @@ static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_release_texture(dmabuf);
     if (vc->gfx.guest_fb.dmabuf == dmabuf) {
         vc->gfx.guest_fb.dmabuf = NULL;
+        vc->gfx.draw_submitted = false;
     }
 #endif
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


