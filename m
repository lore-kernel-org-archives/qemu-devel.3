Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E28F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV3H-0008A6-41; Wed, 22 Apr 2026 06:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2i-0007hO-SA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2g-0002pK-Pi
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8c5Lj/GZu5gO8bWLEIHb18NdCCWVUVhn6fkUu0qHuE=;
 b=ToZet2N2yqFZlEXM4fohIosQ4KXMM2G0H3FUJIBXMvoieEBE266J78b5DDUQq3qBOH9A0H
 N1uSQ80/QZRPh60N0RqMmJs2jkIz5+uR8qpJoqVf4A6bQNVHYcN3T61ltah3p7cH5ef+zb
 r9eqV/Les0ZttBSHF0Lka1ztOex3sKA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-2w8yhG7fPN6N3XJAHyAqNA-1; Wed,
 22 Apr 2026 06:42:46 -0400
X-MC-Unique: 2w8yhG7fPN6N3XJAHyAqNA-1
X-Mimecast-MFC-AGG-ID: 2w8yhG7fPN6N3XJAHyAqNA_1776854566
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5FC31956054; Wed, 22 Apr 2026 10:42:45 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A1443000C15; Wed, 22 Apr 2026 10:42:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 19/40] ui/console-vc: make invalidate_xy() take vt100
Date: Wed, 22 Apr 2026 14:40:20 +0400
Message-ID: <20260422104042.3936506-20-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Style fixes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 3d73bdf2982..34d9101679a 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -176,21 +176,20 @@ static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
-static void invalidate_xy(QemuTextConsole *s, int x, int y)
+static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
 {
-    QemuVT100 *vt = &s->vt;
-
-    if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
-        return;
-    }
-    if (vt->update_x0 > x * FONT_WIDTH)
+    if (vt->update_x0 > x * FONT_WIDTH) {
         vt->update_x0 = x * FONT_WIDTH;
-    if (vt->update_y0 > y * FONT_HEIGHT)
+    }
+    if (vt->update_y0 > y * FONT_HEIGHT) {
         vt->update_y0 = y * FONT_HEIGHT;
-    if (vt->update_x1 < (x + 1) * FONT_WIDTH)
+    }
+    if (vt->update_x1 < (x + 1) * FONT_WIDTH) {
         vt->update_x1 = (x + 1) * FONT_WIDTH;
-    if (vt->update_y1 < (y + 1) * FONT_HEIGHT)
+    }
+    if (vt->update_y1 < (y + 1) * FONT_HEIGHT) {
         vt->update_y1 = (y + 1) * FONT_HEIGHT;
+    }
 }
 
 static void console_show_cursor(QemuTextConsole *s, int show)
@@ -219,7 +218,7 @@ static void console_show_cursor(QemuTextConsole *s, int show)
         } else {
             vt100_putcharxy(&s->vt, x, y, c->ch, &(c->t_attrib));
         }
-        invalidate_xy(s, x, y);
+        vt100_invalidate_xy(&s->vt, x, y);
     }
 }
 
@@ -591,7 +590,7 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
         c = &vt->cells[y1 * vt->width + x];
         vt100_putcharxy(vt, x, y2, c->ch,
                       &(c->t_attrib));
-        invalidate_xy(s, x, y2);
+        vt100_invalidate_xy(&s->vt, x, y2);
     }
 }
 
-- 
2.53.0


