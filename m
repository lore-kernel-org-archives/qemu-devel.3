Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D4BF9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV2f-0007V2-F1; Wed, 22 Apr 2026 06:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2a-0007D5-2g
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2Y-0002ko-Bo
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1duRi/KO8QDaQUrsoWP79lqJXRWmTNZKahK23903zWo=;
 b=F4tsUaR1u+MeSl7HKuOZqmu/enQNrbOX+wJWWDipdbjtzGpB+3wo6yDrd7KFEvRCYznunt
 xSPBHepIZuur4rM94+E+VzQfDTLUHV2rxSNu3mHuQqTCgv0fJFWsUMRGTChke5vBOl44Y1
 2T5JLNHf+1tq6k/OByrG3n1KP9tvtvg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-9HgSc1RrOnC5YwcmeqVBiQ-1; Wed,
 22 Apr 2026 06:42:40 -0400
X-MC-Unique: 9HgSc1RrOnC5YwcmeqVBiQ-1
X-Mimecast-MFC-AGG-ID: 9HgSc1RrOnC5YwcmeqVBiQ_1776854559
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2F4119560B2; Wed, 22 Apr 2026 10:42:39 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58B3E19560AB; Wed, 22 Apr 2026 10:42:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 18/40] ui/console-vc: vga_putcharxy()->vt100_putcharxy()
Date: Wed, 22 Apr 2026 14:40:19 +0400
Message-ID: <20260422104042.3936506-19-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Have the character rendering function operate on QemuVT100 directly
instead of taking a QemuConsole and extracting the VT100 state
internally. This decouples glyph rendering from the console object,
continuing the QemuVT100 abstraction introduced in the previous commits.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 272240712ad..3d73bdf2982 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -154,14 +154,13 @@ static void image_bitblt(pixman_image_t *image,
                            xs, ys, 0, 0, xd, yd, w, h);
 }
 
-static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
-                          TextAttributes *t_attrib)
+static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
+                            TextAttributes *t_attrib)
 {
     static pixman_image_t *glyphs[256];
-    pixman_image_t *image = QEMU_TEXT_CONSOLE(s)->vt.image;
     pixman_color_t fgcol, bgcol;
 
-    assert(image);
+    assert(vt->image);
     if (t_attrib->invers) {
         bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
         fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
@@ -173,7 +172,7 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
     if (!glyphs[ch]) {
         glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
     }
-    qemu_pixman_glyph_render(glyphs[ch], image,
+    qemu_pixman_glyph_render(glyphs[ch], vt->image,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
@@ -216,9 +215,9 @@ static void console_show_cursor(QemuTextConsole *s, int show)
         if (show && cursor_visible_phase) {
             TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &t_attrib);
+            vt100_putcharxy(&s->vt, x, y, c->ch, &t_attrib);
         } else {
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &(c->t_attrib));
+            vt100_putcharxy(&s->vt, x, y, c->ch, &(c->t_attrib));
         }
         invalidate_xy(s, x, y);
     }
@@ -244,7 +243,7 @@ static void console_refresh(QemuTextConsole *s)
     for (y = 0; y < vt->height; y++) {
         c = vt->cells + y1 * vt->width;
         for (x = 0; x < vt->width; x++) {
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
+            vt100_putcharxy(vt, x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
@@ -590,7 +589,7 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
             x = vt->width - 1;
         }
         c = &vt->cells[y1 * vt->width + x];
-        vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
+        vt100_putcharxy(vt, x, y2, c->ch,
                       &(c->t_attrib));
         invalidate_xy(s, x, y2);
     }
-- 
2.53.0


