Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF5BC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsnW-0001hD-Kg; Sat, 24 May 2025 13:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnK-0001Ui-6L
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnI-0000ly-AP
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgRH6/eFm+pH+gB1fXJHRpL3xXRtg898YAqKXTAuvZI=;
 b=BEKhVHYhGsPPjrQQoDwWtodCvKJsIm5L/hmnM/wZoOUxN5CHZy6fpupbQYrQoDmmoNG5DW
 MrBj9zbYJ03QBtOYdhTbJrUEYgn4/0bdcJXV2z6UJ0/LimXVGp3j1Qt5s6arZG6JBBUJEH
 kzn2Y7jDBXCJd+t+lzqSQDsDT9K1uFg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-oVBRJ8vpN9Cj9EJbA8O7Ow-1; Sat,
 24 May 2025 13:36:20 -0400
X-MC-Unique: oVBRJ8vpN9Cj9EJbA8O7Ow-1
X-Mimecast-MFC-AGG-ID: oVBRJ8vpN9Cj9EJbA8O7Ow_1748108179
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 338471800873; Sat, 24 May 2025 17:36:19 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C09A419560B7; Sat, 24 May 2025 17:36:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 18/19] ui/gtk-gl-area: Render guest content with padding in
 fixed-scale mode
Date: Sat, 24 May 2025 19:35:11 +0200
Message-ID: <20250524173514.317886-19-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Weifeng Liu <weifeng.liu.z@gmail.com>

In fixed-scale mode (zoom-to-fit=false), we expect that scale should not
change, meaning that if window size is larger than guest surface,
padding is supposed to be added to preserve the scale. However, in
OpenGL mode (gl=on), guest surface is always painted to the whole canvas
without any padding. This change tries to fix this bug by adding
appropriate padding when drawing surfaces.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-9-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk-gl-area.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index db93cd6204..8151cc413c 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -44,7 +44,9 @@ void gd_gl_area_draw(VirtualConsole *vc)
 #endif
     int pw, ph, gs, y1, y2;
     int ww, wh;
+    int ww_surface, wh_surface;
     int fbw, fbh;
+    int wx_offset, wy_offset;
 
     if (!vc->gfx.gls) {
         return;
@@ -61,6 +63,17 @@ void gd_gl_area_draw(VirtualConsole *vc)
 
     gd_update_scale(vc, ww, wh, fbw, fbh);
 
+    ww_surface = fbw * vc->gfx.scale_x;
+    wh_surface = fbh * vc->gfx.scale_y;
+
+    wx_offset = wy_offset = 0;
+    if (ww > ww_surface) {
+        wx_offset = (ww - ww_surface) / 2;
+    }
+    if (wh > wh_surface) {
+        wy_offset = (wh - wh_surface) / 2;
+    }
+
     if (vc->gfx.scanout_mode) {
         if (!vc->gfx.guest_fb.framebuffer) {
             return;
@@ -79,11 +92,29 @@ void gd_gl_area_draw(VirtualConsole *vc)
         glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
         /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
 
+        if (wx_offset > 0) {
+            glEnable(GL_SCISSOR_TEST);
+            glScissor(0, 0, wx_offset * gs, wh * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glScissor((ww - wx_offset) * gs, 0, wx_offset * gs, wh * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glDisable(GL_SCISSOR_TEST);
+        }
+        if (wy_offset > 0) {
+            glEnable(GL_SCISSOR_TEST);
+            glScissor(0, 0, ww * gs, wy_offset * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glScissor(0, (wh - wy_offset) * gs, ww * gs, wy_offset * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glDisable(GL_SCISSOR_TEST);
+        }
+
         glViewport(0, 0, pw, ph);
         y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
         y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
         glBlitFramebuffer(0, y1, vc->gfx.w, y2,
-                          0, 0, pw, ph,
+                          wx_offset * gs, wy_offset * gs,
+                          (ww - wx_offset) * gs, (wh - wy_offset) * gs,
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
 #ifdef CONFIG_GBM
         if (dmabuf) {
-- 
2.49.0


