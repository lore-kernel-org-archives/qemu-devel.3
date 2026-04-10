Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3070F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPp-0006ki-1y; Fri, 10 Apr 2026 15:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPe-0005aS-Db
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPc-0001Zw-VH
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KcrzGeBjehjOUW8zw82kPtw6ySxe1QAmRnxkGVr+yI=;
 b=dpirO8gDl++L9WoGtJyw4ium7gqJZVlmSdTgw3ZH+ymll97oniczPv4UdrbRMouoxmJ/4m
 owVo1hMWYoZz3KiC/MPAIuicFwcAIvN7QPQVNsxm1Y+Qn+mIsX3K5XB2KwTjO3q8bLvlez
 g2YPRHCQAYLQHxJzJ5GibQ5Dgdd/jNM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-pPngN734NZGKOTPsw7JioA-1; Fri,
 10 Apr 2026 15:21:01 -0400
X-MC-Unique: pPngN734NZGKOTPsw7JioA-1
X-Mimecast-MFC-AGG-ID: pPngN734NZGKOTPsw7JioA_1775848860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5E6618002C0; Fri, 10 Apr 2026 19:21:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 924D11800357; Fri, 10 Apr 2026 19:20:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:43 +0400
Subject: [PATCH v2 21/67] ui/console-vc: console_scroll() -> vt100_scroll()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-21-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LCbaWntss3vOkniSRUREb63eiybBKODUV21uJvRfJvM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UqE90+OW3E/kOsn9Tat8TJWQhMG+K+TgT+
 2WbXHrIqzSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5TuID/4yGZ5k1R7kVJMsB6f6chvSgx1G8noAmeDsHby7zlW+rEDw+8QFsol9ksvFVsbr+XdR/qA
 dAZuUWAwPZhPD39adrW5cvi0OO5HM5GNu42RwFVTrPfHeWWzzpl2or5Z86Z90BqHc2p1W0FYffx
 HElULhp6cNhdSB0bQypnUaxWckXxey4ZdyjsMZUPnQ3inOURnl0dCdiob2lOl57obfxKCroqaTV
 X2q64EiPZ/mgTdVEi4U+s1sOiauF7rTDodpmvHjK48gnZc8S6rMwiY3gtZNv1fr0Uiy/cstgD+H
 aSv2HoG0ZLd1jJNuBiYs7WklKns6iqlY5/7gQBKQVQvHphH+iRr4roxCXAMG6381Gwo4tWGAzFR
 KaUlFWcmyfByoGMAbI4P+wGaIJRG3c7Cd3/D3AuuRuXYPbho11t9RmB3JEXGznK1OWXC2sUH/yx
 FG8YiPH29KhHRzvJ/zs1ir1W82UVXIgJ6CDbbwH2owsDCSMtec/OH5UxYZCQAuN+jZzweZhP4pj
 96ZH4Thi217wy1fLU5zRhy3WQbcPWqu/nrct1a/EwFzenPNbrqZPMmOrWXwki65bHZ/tSw7iW7A
 i55T+6at7F1BVOER+aCQRj7XZ4UTcYdZgNBJK3OEXWmQO7J0eOcQV6dpy+V4BaqvieH+SBa3bNo
 uxw8x8nZrs58yaQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 6694c5082f8..c6846af3697 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -269,9 +269,8 @@ static void vt100_refresh(QemuVT100 *vt)
     vt100_image_update(vt, 0, 0, w, h);
 }
 
-static void console_scroll(QemuTextConsole *s, int ydelta)
+static void vt100_scroll(QemuVT100 *vt, int ydelta)
 {
-    QemuVT100 *vt = &s->vt;
     int i, y1;
 
     if (ydelta > 0) {
@@ -296,7 +295,7 @@ static void console_scroll(QemuTextConsole *s, int ydelta)
                 vt->y_displayed = vt->total_height - 1;
         }
     }
-    vt100_refresh(&s->vt);
+    vt100_refresh(vt);
 }
 
 static void kbd_send_chars(QemuTextConsole *s)
@@ -326,16 +325,16 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 
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


