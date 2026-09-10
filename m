Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96678C88E45
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZzG-0003JQ-1k; Thu, 10 Sep 2026 04:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzE-0003JI-8G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzC-0004tk-H8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O82sAP5Hj+bGeZK3beOKC9TNFaKpvhY6RCKuJLTbO1I=;
 b=X2D882xhVSK4z9FDtKtXCLEk3ONx7tdRt6mqT2JwtNxOpcLukcrvM4QCE+RsI1XRMnTDRi
 Fr1A6JvDRGm4P/5I2E8xEzA6SupFwnBtX7vchOnkzqegSHBODQkzGUR3abbuj6leUlbahO
 0ELeCpancAVzE5QRP2+chamWFIYqutY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685--w3hUNbRPeuSbCfEqyYiRA-1; Thu,
 10 Sep 2026 04:18:18 -0400
X-MC-Unique: -w3hUNbRPeuSbCfEqyYiRA-1
X-Mimecast-MFC-AGG-ID: -w3hUNbRPeuSbCfEqyYiRA_1789028297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70D63180057B; Thu, 10 Sep 2026 08:18:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2DEB1956040; Thu, 10 Sep 2026 08:18:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:35 +0400
Subject: [PATCH v4 07/24] ui/gtk: move draw_submitted from QemuDmaBuf to
 VirtualGfxConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-7-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6254;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gBqWaKJgA4/yz9sjt8xtm7yhbFIUll6dO32lThJ4IRw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeo0Gc9A7bOAENTfi+pyGef81NnNLj4yRSWl
 53v0IaT3o6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5QrjD/920Yr8LWHki9rCr0CvxH71hY7qPCCOB6XXuj0R/RtgzkU3PzoDnuEkNKr9lMyJ3on3dG/
 Y2nuf8cKjvBEoE505mZxtD8gi7QHJo/dwgnTfYD9HUV/FS1NAeVu58kAty4XBhjZ7MXlya94Rmv
 UT2vsguIi4MNAFTQ8pOagn8D1xWaaW1ImFRWDb5iVHgw6fmQVDwlUiN8CcfWYiHLOu1OCXE/fki
 HK2nlmhDJniczsoTkoHGmV3Hd/Nm3ja45R908fpvTIcoAZooarG1jbBWgNWsJ16q/augmu3CQ+s
 ECTr7V5OZnN7Tg18QpxtmXasCEqQrZxfONpClkB48Ii4aj+sfdbOpIHL9/6dylKUDwaeUm+t0Pc
 dxOdoqW9waJz2kW9zA58ISOaIb6A9ub0u4T2Y2296hQb59E0uLd8zy5H95+h+fDQv9xDbat9OYt
 OwDAmZMXGslf841F+IrDBVeWYa1EQW5NkXzYyYXJZnV0ntUa2LEDhOObQs80zdkYUYDHZ6Hk1CQ
 yO+C0+HzwqOvlI6XL0GzBMsRMsa5cCsgDNaqdtvW2z6ih/dGOM5frE/dRT9qmGzyTpbdq14C4/W
 0R2ZAjDwDq8PLnqauuFKnqRNnnVuks0RpZZXqIbJDdfhkZL2oBnaBa3S3HimPxe4YNecfj72tYw
 pdcW+jQ+Bv8Lmow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


