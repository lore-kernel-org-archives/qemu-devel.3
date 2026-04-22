Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1264F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4K-0000ru-7S; Wed, 22 Apr 2026 06:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3B-00081N-1c
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV39-00035j-9x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yfcfhd9vBJRpdnHJt0lOwLAbPp8isOxs25CejdjvNhE=;
 b=YHjZM0KUk4XaRkRC2WIP/3K3kDS699jD6NBp4YiSqc7/JCO93o2FEYMlVm4mlCv1kNhypA
 j7kZ/lw2D5PRDLL1JkVolqcW70iyjGDRyIK0Cv5NmUkT81NDsKsSMrmLxBP+fSqNyslANH
 3CvyBNzfd7hhZraq2FU8KpANwyAaeJU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-ALPDiIQuOdyitkoH9tzt5Q-1; Wed,
 22 Apr 2026 06:43:17 -0400
X-MC-Unique: ALPDiIQuOdyitkoH9tzt5Q-1
X-Mimecast-MFC-AGG-ID: ALPDiIQuOdyitkoH9tzt5Q_1776854596
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83D661955E79; Wed, 22 Apr 2026 10:43:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA0E7180047F; Wed, 22 Apr 2026 10:43:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 24/40] ui/console-vc: console_scroll() -> vt100_scroll()
Date: Wed, 22 Apr 2026 14:40:25 +0400
Message-ID: <20260422104042.3936506-25-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 931693a7b0c..d3e891dab92 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -266,9 +266,8 @@ static void vt100_refresh(QemuVT100 *vt)
     vt100_image_update(vt, 0, 0, w, h);
 }
 
-static void console_scroll(QemuTextConsole *s, int ydelta)
+static void vt100_scroll(QemuVT100 *vt, int ydelta)
 {
-    QemuVT100 *vt = &s->vt;
     int i, y1;
 
     if (ydelta > 0) {
@@ -293,7 +292,7 @@ static void console_scroll(QemuTextConsole *s, int ydelta)
                 vt->y_displayed = vt->total_height - 1;
         }
     }
-    vt100_refresh(&s->vt);
+    vt100_refresh(vt);
 }
 
 static void kbd_send_chars(QemuTextConsole *s)
@@ -323,16 +322,16 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
-        console_scroll(s, -1);
+        vt100_scroll(&s->vt, -1);
         break;
     case QEMU_KEY_CTRL_DOWN:
-        console_scroll(s, 1);
+        vt100_scroll(&s->vt, 1);
         break;
     case QEMU_KEY_CTRL_PAGEUP:
-        console_scroll(s, -10);
+        vt100_scroll(&s->vt, -10);
         break;
     case QEMU_KEY_CTRL_PAGEDOWN:
-        console_scroll(s, 10);
+        vt100_scroll(&s->vt, 10);
         break;
     default:
         /* convert the QEMU keysym to VT100 key string */
-- 
2.53.0


