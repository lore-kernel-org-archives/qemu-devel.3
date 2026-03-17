Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE3F3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBF-0008ND-ST; Tue, 17 Mar 2026 04:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAF-0006hG-SL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAD-000384-7F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPgZoVBC3b4nDaEUUg80+XlVnCSXlIOSgM1V9iyuX24=;
 b=G+kfqdboKmsV9mWTA20hDceety8IpdvROUX7watf+pZxGQw1BU+ERoA389skc281uUlai5
 eEIbAd/GA8GJYDpqi6WZiHx8bjutj2VsxArYbqbnG6N5CNazXgcMZsFyadHPucPrK2K33+
 GxdSe8X74VOfBOJ6jx4EgZ9xHsa671U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-oI_BlhmWMSu-lNKtlZMikg-1; Tue,
 17 Mar 2026 04:52:31 -0400
X-MC-Unique: oI_BlhmWMSu-lNKtlZMikg-1
X-Mimecast-MFC-AGG-ID: oI_BlhmWMSu-lNKtlZMikg_1773737550
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6946F19560A6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5135D19560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:33 +0400
Subject: [PATCH 19/60] ui/console-vc: make show_cursor() take vt100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-19-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NyYSvih93rJd1CyzwrhBo41dWBooijMHyzc0vvlvhBE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXa9/4+mZMUFwBNqLlVzWSmXQSJR51b1lVMA
 n9B0VnZvH2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5XnKEAC03bgMrLW8YzW0GcFMPHiXUIYb+aDc4kfBdEa8moHwoAwHF/00maC2bmEZeZRfPfbl1VI
 ZD5eAiQiQ2sQFucXwX8Mt4KfndeWslz3iGm8zSespwPNs828gI0EuLuIfsEccBjO/RGBNFHHfyX
 prVsF7MI7xvZfYQ1DILZLVgl3lnuRAvn2FFGZ9Nrx/gVw0kicla+lZLJDXEA4yY5bJggJrqk2rI
 4bbt9fanno0jSQD8BOGlD/v5g8XpCdwWUF5A6KPs1G8Hqn6c6DikDrnMl6n21yFc0h7I+Hdd7mh
 hLAgcJwEKRmVT7V/h57QP461DW2gKcL3QAk3woaYVYaDI+3Rugc42hrGzXYn1OmF4NFvcw4bCfj
 iCsh5H8aLKkKk7QcmnljpLmTPZN71ZIqv/GFrMxnXR0DtJeSp1gsvw8b0/c5kFltJ1o1JyGwyQk
 ga0dtepvzLFRyo3g2J7SYDt44WgCqWO2oniAekL1/jX6UQwOu/iGbW9xlFENQqYlYX+99Z7Ypuk
 Yn5WnSZCy4E8dhc9gnnN14xWE0yzkmU5ZCTV3PBnoYC0gQVBfNDmYCdFM9xy9DPs6VYbWn6XeXm
 IUXgBtBSXZ3l6O2XVdgh2WsQKrRfoVDtH6wPECxIeUhOpsf3RgvnVK4j1goEWCxJZunB3A7BjcO
 Xfjw0Orf2+xTYMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Decouples glyph rendering from the console object,
continuing the QemuVT100 abstraction introduced in the previous commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 4117429a508..56e2527c7a2 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -195,32 +195,32 @@ static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
     }
 }
 
-static void console_show_cursor(QemuTextConsole *s, int show)
+static void vt100_show_cursor(QemuVT100 *vt, int show)
 {
     TextCell *c;
     int y, y1;
-    int x = s->vt.x;
+    int x = vt->x;
 
-    s->vt.cursor_invalidate = 1;
+    vt->cursor_invalidate = 1;
 
-    if (x >= s->vt.width) {
-        x = s->vt.width - 1;
+    if (x >= vt->width) {
+        x = vt->width - 1;
     }
-    y1 = (s->vt.y_base + s->vt.y) % s->vt.total_height;
-    y = y1 - s->vt.y_displayed;
+    y1 = (vt->y_base + vt->y) % vt->total_height;
+    y = y1 - vt->y_displayed;
     if (y < 0) {
-        y += s->vt.total_height;
+        y += vt->total_height;
     }
-    if (y < s->vt.height) {
-        c = &s->vt.cells[y1 * s->vt.width + x];
+    if (y < vt->height) {
+        c = &vt->cells[y1 * vt->width + x];
         if (show && cursor_visible_phase) {
             TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
-            vt100_putcharxy(&s->vt, x, y, c->ch, &t_attrib);
+            vt100_putcharxy(vt, x, y, c->ch, &t_attrib);
         } else {
-            vt100_putcharxy(&s->vt, x, y, c->ch, &(c->t_attrib));
+            vt100_putcharxy(vt, x, y, c->ch, &(c->t_attrib));
         }
-        vt100_invalidate_xy(&s->vt, x, y);
+        vt100_invalidate_xy(vt, x, y);
     }
 }
 
@@ -251,7 +251,7 @@ static void console_refresh(QemuTextConsole *s)
             y1 = 0;
         }
     }
-    console_show_cursor(s, 1);
+    vt100_show_cursor(&s->vt, 1);
     dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
 }
 
@@ -1069,11 +1069,11 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     s->vt.update_y0 = s->vt.height * FONT_HEIGHT;
     s->vt.update_x1 = 0;
     s->vt.update_y1 = 0;
-    console_show_cursor(s, 0);
+    vt100_show_cursor(&s->vt, 0);
     for(i = 0; i < len; i++) {
         vc_putchar(drv, buf[i]);
     }
-    console_show_cursor(s, 1);
+    vt100_show_cursor(&s->vt, 1);
     if (s->vt.update_x0 < s->vt.update_x1) {
         dpy_gfx_update(QEMU_CONSOLE(s), s->vt.update_x0, s->vt.update_y0,
                        s->vt.update_x1 - s->vt.update_x0,

-- 
2.53.0


