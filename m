Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C222C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G5y-0002pg-5R; Wed, 09 Sep 2026 07:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5w-0002gk-0x
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5u-0005FY-7b
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mz4PTGP6qudujxpPZjanfIYAxxhnY7znlVXoIeYduh8=;
 b=cdXQUORGawDYr1VYUYiKRJf7aImaxOcoHVEViLqlZ21XMsbYm3CX+ZaPq9CliXnY6GyJ67
 lUVmnkzC/8d3xq9+kJHcGKqDowYOyoBBc7XMN8zivxCQQLEK7F8yunEmWcdLH2oSenNVs0
 yH8EUbMWCGmShG0x+iRAJqor9Hr6BkA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-UA60zhpNNeOwFrjKZ9wGgw-1; Wed,
 09 Sep 2026 07:03:54 -0400
X-MC-Unique: UA60zhpNNeOwFrjKZ9wGgw-1
X-Mimecast-MFC-AGG-ID: UA60zhpNNeOwFrjKZ9wGgw_1788951833
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D56BC180064D; Wed,  9 Sep 2026 11:03:52 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8AEC1800473; Wed,  9 Sep 2026 11:03:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:12 +0400
Subject: [PATCH v3 07/24] ui/gtk: move draw_submitted from QemuDmaBuf to
 VirtualGfxConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-7-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6253;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+V91CVLcUC+ZLIEMSp2uJ4sCzJ+RyEIZv2HE+0wNKsI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyIzswDeKfK0kfQJaU+ndO6UaA+241PwO4P
 yMMHtItHCCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5RSbD/0VCYE8izdr34DHjpUKB9xbPHXtp+wAGUVoZZQoUGkxdCi5twDiBArTwn1liBHr5nFoFpQ
 ZdzEttn4gIHzq+Xw7KwN58PrUaK7o0v/08vhxmFOJBmn8PwWupRRzIIzPFsGj5yT8Xj0bFJoYsN
 aTpaJ3O3TsR4d28cSTAv/+k4iavD8b5JndxunWd08yqCZ6vm3xPJ/J+hchDXM+D99+NNsdTH9E5
 d7xM17GpuaaDKF/cURoyOPJdAvPLeJhb0+ELOV22qT7bn3fXW2Gj0mz/8ufTo8uCVWvjUcB5eVw
 8uRbM7tM2lGi/AWyRq24jmDYDP6eahVFbuD7MHTc3isiNQO50KWqZaCfhXVEXWaknzv7YnLfhkn
 o25EfbDQwJsC8kepypNqapCU+n0016UFdniyhMRhryMkJ3mzzQ7u4Coam9hrmKt22+l26luhqEZ
 YysdPiLrKv1oay9+WNjvENWesHod02kxSXnaLtSZYI75CB9mTkIhrN8Hw8U9OjzEZVMVPKueTc1
 J5pu9NKNsKeaA+w9p1b1LPYgymjvYf3wrnnVRjT4FhV83YyTlUaNjbEI1u7IcJhaYDHzhjKhmdi
 rcngdl/kn523UCiNOFWHoR5mm7R5c65oMZWCtnij4u3hNNi219z9E/AI5VFwkic7C/YWwm8ra9D
 tTFr6GdLmEbwrCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 ui/dmabuf.c         | 13 -------------
 ui/gtk-egl.c        | 13 ++++++-------
 ui/gtk-gl-area.c    | 10 +++++-----
 ui/gtk.c            |  1 +
 6 files changed, 13 insertions(+), 27 deletions(-)

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
index b61dc7ad2783..16063dc62ae8 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -26,7 +26,6 @@ struct QemuDmaBuf {
     uint32_t  backing_height;
     bool      y0_top;
     bool      allow_fences;
-    bool      draw_submitted;
 };
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
@@ -212,21 +211,9 @@ bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
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


