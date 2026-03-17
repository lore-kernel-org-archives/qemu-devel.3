Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CF7F3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QB8-0007w1-2v; Tue, 17 Mar 2026 04:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QA5-0006XY-Cw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QA2-00037S-3t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JunWrlOjUaBqWEYWaxVNRGfLgE6IGyNbEZUn9hvzWBE=;
 b=HPCoJUBDqMW3S06sb6hqzZdW/u6xSucZ8l/QwVSPd+hK+d9BoNjIUSEmqW/73ucJJ+wEpc
 FXvWHYOxetnmJyDTdP5rUy+uhrKhZuXs482WYgVhBY7fhgQ/pUelGohh3q7sNejiIb1Fug
 3pwuDOW3p/lQMlDQX9zmMla6PQ8eB8c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-MB51PgVvPMyeJtSZ9E28QQ-1; Tue,
 17 Mar 2026 04:52:19 -0400
X-MC-Unique: MB51PgVvPMyeJtSZ9E28QQ-1
X-Mimecast-MFC-AGG-ID: MB51PgVvPMyeJtSZ9E28QQ_1773737539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28ABE19560BA
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 115D918002A6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:31 +0400
Subject: [PATCH 17/60] ui/console-vc: vga_putcharxy()->vt100_putcharxy()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-17-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Q7H7Ck2laPDFYqsQ0lbaAjfNMqA0Xc1//VoNWqqey40=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXahKLWF1Bk4yqKMUkw4vrztcmdigtgahq3a
 ZZTQhHhq5qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5X1WEACOQfjBmgbLGEh6GbI1Yddv8ow/dlLTygkqVh3lPV1tfs5Z75+aEZQMPkWtnFEDUG7aCL/
 sKKoOTp6bGHSB00BOMZWFBnwyXG+bqNBUAjcev4+yjpdVyTsrJEdoH+Ui6Th9eGF+6oC6/79y7+
 nPVZVy9agqDoiS3M//KrO1Z7beZxg4VyrSKo1SsjiHewO4CTv+hi1bMJekrcFCnnE0mG11xL936
 W2lzMe51rxmp6McHOcdI0OkJHBVmsmi2IXF/favZ4IPvBQBDxZNWQ5bgyltfJLwpn1VUtOIVHtR
 7ULdVbZwWvCJwaRz3dc0QQ3g6LI/1gHNA4xbGwCS2RlbF8ecBzj3JLqiRACa/v/Qv+DNUO/+0/V
 hX+fcVW7r/TGRZpJsdQ1CRcimzHULz3vIMO2eASS2QianRf9GUYIxJkzMfU1LHAW0pXBKqhDnk7
 aplxIiwL/Cy/cRfj7Y8TO2kYh05DoXXeXkWnBK32rHWtm2FzIZRP/Aj1iZgcTlN8KTe8RH1jkJ4
 HBo3l1Jn0zOGGOlRX8bRWR/2yWA6blLwwaOR7F1V6tLs8f9s8cUto87HG1PMNSrY/oLxT2iIEov
 07yfb8IwdmlXza/c17rLPEyhuUoprGboBHrTokIFARHilxlEqM+v/RAEte6kFCWOvOZgpxoia3C
 ch7b4OCP0BH0eGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Have the character rendering function operate on QemuVT100 directly
instead of taking a QemuConsole and extracting the VT100 state
internally. This decouples glyph rendering from the console object,
continuing the QemuVT100 abstraction introduced in the previous commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 0e0a9ad245d..c730a8a52b8 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -157,14 +157,13 @@ static void image_bitblt(pixman_image_t *image,
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
@@ -176,7 +175,7 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
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
@@ -243,7 +242,7 @@ static void console_refresh(QemuTextConsole *s)
     for (y = 0; y < s->vt.height; y++) {
         c = s->vt.cells + y1 * s->vt.width;
         for (x = 0; x < s->vt.width; x++) {
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
+            vt100_putcharxy(&s->vt, x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
@@ -584,7 +583,7 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
             x = s->vt.width - 1;
         }
         c = &s->vt.cells[y1 * s->vt.width + x];
-        vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
+        vt100_putcharxy(&s->vt, x, y2, c->ch,
                       &(c->t_attrib));
         invalidate_xy(s, x, y2);
     }

-- 
2.53.0


