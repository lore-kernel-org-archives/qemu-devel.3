Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E201F9B60B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4F-0000f7-4z; Wed, 22 Apr 2026 06:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV31-0007tw-4M
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2z-0002zV-1W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gI2e/bCn4OAJSkV+RCkPD04tj8R9k4rZ/ohts0NCBeA=;
 b=SgqYsspufsuGJc7ptbFxIuPtRNyTqVd8HmX6rpayaCJuUzF7oG5BNt4E+6omBDG2uXgumU
 reekc5RFbNHOJg/OvP3LOBBg0q15EwS8xfpg5XqVGy8HjLEvsCBQQBAyWIyD/kjjRMiqsy
 fn4Po/N66WnexbnlADk9aj0WebhsIEc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-3cqdngGfO_memKbpovWa3g-1; Wed,
 22 Apr 2026 06:43:04 -0400
X-MC-Unique: 3cqdngGfO_memKbpovWa3g-1
X-Mimecast-MFC-AGG-ID: 3cqdngGfO_memKbpovWa3g_1776854584
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F2D1956088; Wed, 22 Apr 2026 10:43:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84F1B19560AB; Wed, 22 Apr 2026 10:43:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 22/40] ui/console-vc: console_refresh() -> vt100_refresh()
Date: Wed, 22 Apr 2026 14:40:23 +0400
Message-ID: <20260422104042.3936506-23-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index bc8462f979e..fca04fe57df 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -229,9 +229,8 @@ static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int heigh
     vt->image_update(vt, x, y, width, height);
 }
 
-static void console_refresh(QemuTextConsole *s)
+static void vt100_refresh(QemuVT100 *vt)
 {
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y, y1;
     int w = pixman_image_get_width(vt->image);
@@ -257,8 +256,8 @@ static void console_refresh(QemuTextConsole *s)
             y1 = 0;
         }
     }
-    vt100_show_cursor(&s->vt, 1);
-    vt100_image_update(&s->vt, 0, 0, w, h);
+    vt100_show_cursor(vt, 1);
+    vt100_image_update(vt, 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -288,7 +287,7 @@ static void console_scroll(QemuTextConsole *s, int ydelta)
                 vt->y_displayed = vt->total_height - 1;
         }
     }
-    console_refresh(s);
+    vt100_refresh(&s->vt);
 }
 
 static void kbd_send_chars(QemuTextConsole *s)
@@ -1066,7 +1065,7 @@ static void text_console_invalidate(void *opaque)
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         text_console_resize(QEMU_TEXT_CONSOLE(s));
     }
-    console_refresh(s);
+    vt100_refresh(&s->vt);
 }
 
 static void
-- 
2.53.0


