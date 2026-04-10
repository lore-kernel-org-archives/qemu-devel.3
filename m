Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5641BF45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPk-00062S-Qe; Fri, 10 Apr 2026 15:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPU-0005N9-Ss
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPQ-0001Q5-SB
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35NB0NPv2qOWBVLdjvh0a4RCEHDwikxV3x+wq6dGcfw=;
 b=NjWfm8TvlfVVLRDLeTO+ttXLaOixwvHJJmVP2XKFXF6MmcwICK1cvPjtxqNUdF2yn/7WNp
 u+5XuVKd6O9pfd2TPOOMLVT8oDs5Cp+hGlljzQbrAi120q3B+K0Ka66WUeHmH8Blg3kXvb
 vsDDr5xOc3usiC5uf+Oh5uiYylRLjNU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-nEzCD_YROImaoDvcWAUpFw-1; Fri,
 10 Apr 2026 15:20:50 -0400
X-MC-Unique: nEzCD_YROImaoDvcWAUpFw-1
X-Mimecast-MFC-AGG-ID: nEzCD_YROImaoDvcWAUpFw_1775848849
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79AB8180044D; Fri, 10 Apr 2026 19:20:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46748180057F; Fri, 10 Apr 2026 19:20:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:41 +0400
Subject: [PATCH v2 19/67] ui/console-vc: console_refresh() -> vt100_refresh()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-19-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Alv36LrSEk9pffbsC7R8BXcgJH+s8HLIVfm8/6cC23I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UTC5YnAx3mhJRtjWlIqasqVJDGZhAcwAaI
 +MFO5Xw9CCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5aFEEACLRFsKMZr8qCaCwzt+QoEcPge1PEDuVs9OqT+ZcBrOsXsJfHQ/69gbwYBF7aI2x3MkQLf
 s4PWaUpME6JhZuDP5SDGAe+5saE/E11UR0YTk3cwzi7Nl6orGiRwlMfnwPpJc7IRuCmpO6v5YHj
 z8YGHYoWFwbqY/DgW62pVwXfxOoPl8qn7LAjLal/v+r0ir81BKLDAaZKBJecY9A6bE4d5goSCZF
 5xmlXxXd6stNxu3xxpuGzf5dY+3lZQnIR3z87GFY7+aOMHKpoNRw3LyZ+jEXbv7WS1oZNsfGinC
 UZDFkLQbgOL/pQ7As7sSLM4SWFZZ9OeNzCuov74IwSrWvRcrtlU4a0x7eswfJf7J1eb5VryrE4/
 lFgFqmlpB1JGw+m4BjxwOkGXU3uLIn1RVRxHRwMT9KZ6IAqKuGYh0Qzw1VM11lv+JuOS+TyZRPY
 u+ctXTFpSygNVevk8rLw2MHKdy/Vcz7myDcViwRRPUM9zbCMxprmQt5B8QrZlHo+SB9nR3jRNTs
 OcYM3xwcII7O7LJJTXlkNHWqRGvYz2fIhB2zIblYK8ErVkULURIohF+dwm9nIvKa+52fX9rg70K
 20Bg9SsWRWMmuGf8b2j4JJvBNauw7ekAt/OUGrpv2U1oMQKT0Sh42AEgE7IaXz1F1ulsVq5LCx/
 0jyXfbQXrvaaouQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 ui/console-vc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index f8682d2d1dc..d46dcb6a678 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -232,9 +232,8 @@ static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int heigh
     vt->image_update(vt, x, y, width, height);
 }
 
-static void console_refresh(QemuTextConsole *s)
+static void vt100_refresh(QemuVT100 *vt)
 {
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y, y1;
     int w = pixman_image_get_width(vt->image);
@@ -260,8 +259,8 @@ static void console_refresh(QemuTextConsole *s)
             y1 = 0;
         }
     }
-    vt100_show_cursor(&s->vt, 1);
-    vt100_image_update(&s->vt, 0, 0, w, h);
+    vt100_show_cursor(vt, 1);
+    vt100_image_update(vt, 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -291,7 +290,7 @@ static void console_scroll(QemuTextConsole *s, int ydelta)
                 vt->y_displayed = vt->total_height - 1;
         }
     }
-    console_refresh(s);
+    vt100_refresh(&s->vt);
 }
 
 static void kbd_send_chars(QemuTextConsole *s)
@@ -1127,7 +1126,7 @@ static void text_console_invalidate(void *opaque)
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         text_console_resize(QEMU_TEXT_CONSOLE(s));
     }
-    console_refresh(s);
+    vt100_refresh(&s->vt);
 }
 
 static void

-- 
2.53.0


