Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF6F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPj-0005kd-42; Fri, 10 Apr 2026 15:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHP4-0004wW-Qg
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHP2-00019S-Ou
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcRo5CAEdOjBKNJZHbtN+cZpcnk/HQwcXTjPRUQ1/pE=;
 b=emplc0/zuznbgyJHuNRmOe/AhXJbT3wiO+fgZtliqOVBRVFlunnArLryPE4cqIb7MBc6pT
 NdmQ6QWWFjLLUMh+umh9Yk6YNDQTKN9SixVnJoCRyHWqjMo96n79Z8GZcA3C4/VPzv4N8K
 c7yJfr0LyFypEZJmt9d/UoZl9+dZywE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-Ircw8FBgMVyrEHqCKOJBww-1; Fri,
 10 Apr 2026 15:20:26 -0400
X-MC-Unique: Ircw8FBgMVyrEHqCKOJBww-1
X-Mimecast-MFC-AGG-ID: Ircw8FBgMVyrEHqCKOJBww_1775848826
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9458180034C; Fri, 10 Apr 2026 19:20:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B64BC3000C16; Fri, 10 Apr 2026 19:20:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:37 +0400
Subject: [PATCH v2 15/67] ui/console-vc: vga_putcharxy()->vt100_putcharxy()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-15-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3119;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dJnrgMgCNfQEna7bGX8u4UyoRqB7oR/YhWc7dLzoiB4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0U0QucN7JfDEej9Oa6Ra67Dz528AdEQkzoP
 6fwa/KloHaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5d+FD/wOXk0on7NYopkFwW/T1dRMhCfcIPrj+PQzJwe+Ar/FUfGPqagBjjPV8XoTUKybukUbOhY
 btgJo6jaa5ul+TAJTcCm4azYNEbO2M/ho8jyVslmNtst3275gaYT6ohhpaaNoHR3fQgdteIX6Ra
 gKBRtE7gHLqWLctuC7aOL7iuARmQLeOYBy59syc1oyH4IATTr3B4TrzHW2wEoPsvoD4OPQlKqyg
 5HwSRFvmH6AcsuGoiM8wzHF5Cbzpn7M7bZ5X4NF32gxvhvRAOLQfOC20JxvE3s4DwG2e2pCMQsW
 xMiCNJlUFxjkcLtsdpN2Q82QDbpoM1IerKISAdtZb2Ebf+yl62rP0UP7qD9vXLTTghYjPw+boOH
 i2IcywMTUEKUq4UYJ+8NgPoqsl43PqrOaab9Gx3qsLywa+qUDXx3+txhE5sbfwBk83liNb+9Thx
 HoJomGd/Vd2Q/PvMnyxJ1IImCD28O/cP7/24z5qXQltmUYaBM8furmxbQWNmWiwBw/flBHQKogd
 o42F2t6BUNxFYM0Koplzh870VvgRxRau7dsebvUWCcE5letdFmvTfN/JDNGbb7PVQCbSElL7hMZ
 3lHZdQPkGITAvj42TskUhBC5U/fJTLS7OcaNjbC81F3zI3J0mmFC3uRH8LgPO00NcLxyRMvVVJX
 yFZeIbNesPeog/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 267620689e4..cf087c64fb2 100644
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
 
@@ -219,9 +218,9 @@ static void console_show_cursor(QemuTextConsole *s, int show)
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
@@ -247,7 +246,7 @@ static void console_refresh(QemuTextConsole *s)
     for (y = 0; y < vt->height; y++) {
         c = vt->cells + y1 * vt->width;
         for (x = 0; x < vt->width; x++) {
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
+            vt100_putcharxy(vt, x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
@@ -593,7 +592,7 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
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


