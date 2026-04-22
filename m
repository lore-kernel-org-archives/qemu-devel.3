Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F579F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV3T-0008Nn-Ap; Wed, 22 Apr 2026 06:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2n-0007hs-UO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2l-0002r6-CT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhPhytE3lWDcWixEkyVZWAGAeNYkIorN1jvF2AFhexw=;
 b=KFo/Kq/vfp2G9YlIlyFbq0dtLDF051Zn7Toh1rKWgwN4OyY/+Xj+npXGZRGtlI4mSJsNw0
 9nmHCPIZez7V5cdMiF8l81JN56EpJ1YYh+1HJed5w4cQXKPCoxSCEXiZrDwCqt6ZWVbd3P
 01Gf4YuxbiqSQPgbKD/ZJCH9bx4q0Rw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-AnyA1LDYNrWLQbOB9LPmCw-1; Wed,
 22 Apr 2026 06:42:53 -0400
X-MC-Unique: AnyA1LDYNrWLQbOB9LPmCw-1
X-Mimecast-MFC-AGG-ID: AnyA1LDYNrWLQbOB9LPmCw_1776854572
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C2641800473; Wed, 22 Apr 2026 10:42:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B9261956095; Wed, 22 Apr 2026 10:42:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 20/40] ui/console-vc: make show_cursor() take vt100
Date: Wed, 22 Apr 2026 14:40:21 +0400
Message-ID: <20260422104042.3936506-21-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Decouples glyph rendering from the console object,
continuing the QemuVT100 abstraction introduced in the previous commits.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 34d9101679a..fb1c8866a03 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -192,9 +192,8 @@ static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
     }
 }
 
-static void console_show_cursor(QemuTextConsole *s, int show)
+static void vt100_show_cursor(QemuVT100 *vt, int show)
 {
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y, y1;
     int x = vt->x;
@@ -214,11 +213,11 @@ static void console_show_cursor(QemuTextConsole *s, int show)
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
 
@@ -250,7 +249,7 @@ static void console_refresh(QemuTextConsole *s)
             y1 = 0;
         }
     }
-    console_show_cursor(s, 1);
+    vt100_show_cursor(&s->vt, 1);
     dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
 }
 
@@ -1023,11 +1022,11 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     vt->update_y0 = vt->height * FONT_HEIGHT;
     vt->update_x1 = 0;
     vt->update_y1 = 0;
-    console_show_cursor(s, 0);
+    vt100_show_cursor(vt, 0);
     for(i = 0; i < len; i++) {
         vc_putchar(drv, buf[i]);
     }
-    console_show_cursor(s, 1);
+    vt100_show_cursor(vt, 1);
     if (vt->update_x0 < vt->update_x1) {
         dpy_gfx_update(QEMU_CONSOLE(s), vt->update_x0, vt->update_y0,
                        vt->update_x1 - vt->update_x0,
-- 
2.53.0


