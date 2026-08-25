Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8FBC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMY-0005e8-MV; Tue, 25 Aug 2026 07:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLs-00051A-8t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLq-00067O-6U
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wekiPFg1YpB8XRBQpidETX8GSUelcvkelnskzvbxTPQ=;
 b=RqhRLbL7q2chsBtqPLrFeX8RJrbzDJRnDt17BDW+DkTmf+IM83c2vC9T3lbNZFLwXs31au
 T00MGqr9ZmseYf8Z5uN3Y8WqZp5XW3hY3ouKH6hHHJvLomFcv3QdkRV0DGpmgeLRlJm3oy
 Hwxuyo/C8/RRqDo/ji+kuii2pQP2Sb8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-2EzJ_QZSMQi1x1t7yj1cLQ-1; Tue,
 25 Aug 2026 07:29:55 -0400
X-MC-Unique: 2EzJ_QZSMQi1x1t7yj1cLQ-1
X-Mimecast-MFC-AGG-ID: 2EzJ_QZSMQi1x1t7yj1cLQ_1787657395
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9FB8191FCD7; Tue, 25 Aug 2026 11:29:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D332830002EF; Tue, 25 Aug 2026 11:29:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:02 +0400
Subject: [GIT PULL 12/19] hw/display/vga: fix text-mode OOB write after a
 graphics surface switch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-fixes-v1-12-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6592;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=epeGVteNEbyd1wpjoz/1IoF0sVT1BmKTo/Iiu+dso9I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrU9x5ToGWzF2dH/PEJkuTeCeQHo1UOZkyHl
 JNsue2z07mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5c4XD/9UqJo5h+k1H2mQFCYlKG7xMh3mutmHMlmivx8qUx+3Wx2L3mqt9ZbP0lT4x/ScOkdq7Pe
 cYSGLFtYHIdQtZHpRzpZ1oOyl5zuPxpe+YlwOYFDhVT1sC/bWqdYJxf8wfD2/T6uWoxXH3cj3xe
 NFvS0Omo8UhK1OcxE58nD9Av/n9H06sUjD2fZKXzNv2PjO7Jg7yRH0UdsJ4485/IEmV8UQv/uN3
 S3YBTc5yIzfv2ky7PJJ1TfYBWe84Ep+NbdEv3XTj1nSfwMIKIX7Y+MXLxvNG9J9nk77Qx/YpAVI
 qjUsnseinLNSHJtz81G+xoD1hcVO7BLcAAQp66GQ+OAkl8VrkzB6R0uZNbG3TQLaf5MDZZo3gmh
 SIVNRW+L3mi6kBuc9aBQ4wO8mGqGLZmtfEFuudZ/BYzhpdjKOb3iloCeurFbiqsB6iFqcSCaz7u
 s3vsJBg37Eq1SP+hcPsK+3gF7hq/El/xFqKLcxWPjFLrLUV/PbgTeYrp7cok5KjV2v6jqLkc25w
 NBVAgokOdJ2IemugMla09o1PTYwkFa65Npg50SPDDAAM9yH6yaYLyYtYskR3zk4z6t+U/5PCj/X
 rfmAhfFOXPb3tiF3fypTy8nMfklKObANZ2gvDP1psWfZlGtUizjOAcZeM2KxdffNFUoGF5VGt1j
 mND8toMAgl2ocMQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Warisjeet Singh <sinxx198@gmail.com>

vga_draw_text() decides whether the console surface needs a resize from
its geometry cache, but none of the cache terms observe the graphics
renderer having replaced the console surface in between:

- last_width/last_height are shared with vga_draw_graphic(), which
  stores them in pixels while the text path stores characters;
- last_depth stays 0 for legacy (non-VBE) graphics modes, because
  vga_get_bpp() only reports a depth when VBE is enabled, so the
  "s->last_depth" term that normally forces a resize after a graphics
  frame does not fire.

So a graphics frame that shrinks the console surface (e.g. 80x25
pixels) followed by a text frame with matching character geometry
(80x25 chars) skips the resize, and the glyph loop then paints
width*cw x height*cheight pixels into the smaller surface, out of
bounds, with guest-controlled (DAC palette) values, on every display
refresh.

Separate the geometry cache per renderer: text paths (vga_draw_text,
vga_update_text, and the text handling in vga_invalidate_display /
vga_common_reset) now only manipulate last_text_{width,height}, in
characters; last_{width,height} become graphics-only, in pixels.
Additionally, make the text path compare the pixel size it is about
to paint against the console surface's actual dimensions.  The
surface check is the load-bearing term: caches in either unit cannot
see the other renderer swapping the surface, the surface can.

Fixes: CVE-2026-77913
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215
Cc: qemu-stable@nongnu.org
Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
Message-ID: <vga-v3-20260824.sinxx198@gmail.com>
---
 hw/display/vga.c     | 37 ++++++++++++++++++++++---------------
 hw/display/vga_int.h |  3 ++-
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index da0c331486eb..cb0e28b79b6a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1241,7 +1241,10 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         return;
     }
 
-    if (width != s->last_width || height != s->last_height ||
+    if (surface == NULL ||
+        surface_width(surface) != width * cw ||
+        surface_height(surface) != height * cheight ||
+        width != s->last_text_width || height != s->last_text_height ||
         cw != s->last_cw || cheight != s->last_ch || s->last_depth) {
         s->last_scr_width = width * cw;
         s->last_scr_height = height * cheight;
@@ -1249,8 +1252,8 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         surface = qemu_console_surface(s->con);
         qemu_console_text_resize(s->con, width, height);
         s->last_depth = 0;
-        s->last_width = width;
-        s->last_height = height;
+        s->last_text_width = width;
+        s->last_text_height = height;
         s->last_ch = cheight;
         s->last_cw = cw;
         full_update = 1;
@@ -1845,6 +1848,8 @@ static void vga_invalidate_display(void *opaque)
 
     s->last_width = -1;
     s->last_height = -1;
+    s->last_text_width = -1;
+    s->last_text_height = -1;
 }
 
 void vga_common_reset(VGACommonState *s)
@@ -1887,6 +1892,8 @@ void vga_common_reset(VGACommonState *s)
     s->last_ch = 0;
     s->last_width = 0;
     s->last_height = 0;
+    s->last_text_width = 0;
+    s->last_text_height = 0;
     s->last_scr_width = 0;
     s->last_scr_height = 0;
     s->cursor_start = 0;
@@ -1938,8 +1945,8 @@ static void vga_update_text(void *opaque, uint32_t *chardata)
         s->graphic_mode = graphic_mode;
         full_update = 1;
     }
-    if (s->last_width == -1) {
-        s->last_width = 0;
+    if (s->last_text_width == -1) {
+        s->last_text_width = 0;
         full_update = 1;
     }
 
@@ -1978,15 +1985,15 @@ static void vga_update_text(void *opaque, uint32_t *chardata)
             break;
         }
 
-        if (width != s->last_width || height != s->last_height ||
+        if (width != s->last_text_width || height != s->last_text_height ||
             cw != s->last_cw || cheight != s->last_ch) {
             s->last_scr_width = width * cw;
             s->last_scr_height = height * cheight;
             qemu_console_resize(s->con, s->last_scr_width, s->last_scr_height);
             qemu_console_text_resize(s->con, width, height);
             s->last_depth = 0;
-            s->last_width = width;
-            s->last_height = height;
+            s->last_text_width = width;
+            s->last_text_height = height;
             s->last_ch = cheight;
             s->last_cw = cw;
             full_update = 1;
@@ -2071,22 +2078,22 @@ static void vga_update_text(void *opaque, uint32_t *chardata)
     }
 
     /* Display a message */
-    s->last_width = 60;
-    s->last_height = height = 3;
+    s->last_text_width = 60;
+    s->last_text_height = height = 3;
     qemu_console_text_set_cursor(s->con, -1, -1);
-    qemu_console_text_resize(s->con, s->last_width, height);
+    qemu_console_text_resize(s->con, s->last_text_width, height);
 
-    for (dst = chardata, i = 0; i < s->last_width * height; i ++)
+    for (dst = chardata, i = 0; i < s->last_text_width * height; i ++)
         *dst++ = ' ';
 
     size = strlen(msg_buffer);
-    width = (s->last_width - size) / 2;
-    dst = chardata + s->last_width + width;
+    width = (s->last_text_width - size) / 2;
+    dst = chardata + s->last_text_width + width;
     for (i = 0; i < size; i ++)
         *dst++ = ATTR2CHTYPE(msg_buffer[i], QEMU_COLOR_BLUE,
                              QEMU_COLOR_BLACK, 1);
 
-    qemu_console_text_update(s->con, 0, 0, s->last_width, height);
+    qemu_console_text_update(s->con, 0, 0, s->last_text_width, height);
 }
 
 static uint64_t vga_mem_read(void *opaque, hwaddr addr,
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 5664317ecd6d..ca69ae981521 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -122,7 +122,8 @@ typedef struct VGACommonState {
     uint32_t plane_updated;
     uint32_t last_line_offset;
     uint8_t last_cw, last_ch;
-    uint32_t last_width, last_height; /* in chars or pixels */
+    uint32_t last_width, last_height; /* in pixels (graphics renderer) */
+    uint32_t last_text_width, last_text_height; /* in chars (text renderer) */
     uint32_t last_scr_width, last_scr_height; /* in pixels */
     uint32_t last_depth; /* in bits */
     bool last_byteswap;

-- 
2.55.0.543.g5ebe2ebe4ea8


