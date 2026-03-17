Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5891F3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBC-0008DW-V8; Tue, 17 Mar 2026 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAR-0006v7-Hs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAO-00039K-HN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV43fbeXkmMagiHlbdfR05piBLoT3juwzXVH0wLZtt8=;
 b=G9W+Nh+Ni4DVPtj/4KsBBA/KIlSZ5fRIsD4p3FbV2wUba9tlf9QnE351/wnXJ3WI2BThnc
 GipzoNDmxRZYT+ICdPKbRCHnlYbKxbefLxfGx7BVIxMz6ZxRF87s12YCIoyYzCfK/8Qg+v
 qj09T3WbFdVor1yUESevfJATOh2BGGE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-p7xKiseiM0uCAffAdyM05g-1; Tue,
 17 Mar 2026 04:52:42 -0400
X-MC-Unique: p7xKiseiM0uCAffAdyM05g-1
X-Mimecast-MFC-AGG-ID: p7xKiseiM0uCAffAdyM05g_1773737561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063951956056
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D70D51955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:35 +0400
Subject: [PATCH 21/60] ui/console-vc: console_refresh() -> vt100_refresh()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-21-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wh7049aWb42j3hAztzpyZ9eVmnSmItAg5RiicXmbt9M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXaXdpRqo7VQfFXTMudhy9quB64ePiHdeLIX
 VyTvj+yTfmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5fxAD/9xMaiVOj+K5iQ+/4UiIKPwscg+UbQpWZlZM1fLHmY+SE8YO2aVJBRKSmdz5l+LZh75Nvu
 wCL4/zfC/ht8sWEpB82dzURZjVWerftRsMELX+17s2uft3fnd6nPu0ct8hS+j6AeFHwGQSksgpb
 +Jk0k10zrDs41T43vaLrfQJJjqoED1lsP09FLsruwpjUuJtKjUPPGJvP0qU4hQNXh/WwwV4PzgT
 Z39BMfTowTFYhHXSrxEgkHZ2MAjMUUr/P8nVMBwoHWcaEf7cJiAo35HKqIyPYeV13cE8FmDfHJm
 Dk+1b601b+HZDlDylaT9WC/WPlIB1kI6f3gSgAuTrFCBjCoZY7ETgbegHy2ckasK4trb7QQV+GH
 NVeYZs8XjbLcXjs4Mwen/mKClekHxKrcYc9xYWqpVtU3Ca4UvdnWwIne+MjzF1MfnSXKi6RtPkJ
 lAw0Rbw/kBHBvDX6sUv/C9AHA64gFgz6YLpf1IeQRv4CSQ8QbEyAg3kzHTfTQ9ziwAkr9a/dXFD
 H1pFwqF/z3s49ad7x81uvSxSnqQwpTsTbixodkqzYMsueC85qHol1kuVXk3oZcx66F2BS0jqBR1
 4FyV152MlwAx4wj8BY4Rio/XIVYqaLqmrYbBY1egVlCOs+LJWUkPpD6GdHnhzjaEsjc2+HMpU53
 ePkF6ENx8oii+pA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 8a18659036f..d2a7d527586 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -232,35 +232,35 @@ static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int heigh
     vt->image_update(vt, x, y, width, height);
 }
 
-static void console_refresh(QemuTextConsole *s)
+static void vt100_refresh(QemuVT100 *vt)
 {
     TextCell *c;
     int x, y, y1;
-    int w = pixman_image_get_width(s->vt.image);
-    int h = pixman_image_get_height(s->vt.image);
+    int w = pixman_image_get_width(vt->image);
+    int h = pixman_image_get_height(vt->image);
 
-    s->vt.text_x[0] = 0;
-    s->vt.text_y[0] = 0;
-    s->vt.text_x[1] = s->vt.width - 1;
-    s->vt.text_y[1] = s->vt.height - 1;
-    s->vt.cursor_invalidate = 1;
+    vt->text_x[0] = 0;
+    vt->text_y[0] = 0;
+    vt->text_x[1] = vt->width - 1;
+    vt->text_y[1] = vt->height - 1;
+    vt->cursor_invalidate = 1;
 
-    image_fill_rect(s->vt.image, 0, 0, w, h,
+    image_fill_rect(vt->image, 0, 0, w, h,
                     color_table_rgb[0][QEMU_COLOR_BLACK]);
-    y1 = s->vt.y_displayed;
-    for (y = 0; y < s->vt.height; y++) {
-        c = s->vt.cells + y1 * s->vt.width;
-        for (x = 0; x < s->vt.width; x++) {
-            vt100_putcharxy(&s->vt, x, y, c->ch,
+    y1 = vt->y_displayed;
+    for (y = 0; y < vt->height; y++) {
+        c = vt->cells + y1 * vt->width;
+        for (x = 0; x < vt->width; x++) {
+            vt100_putcharxy(vt, x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
-        if (++y1 == s->vt.total_height) {
+        if (++y1 == vt->total_height) {
             y1 = 0;
         }
     }
-    vt100_show_cursor(&s->vt, 1);
-    vt100_image_update(&s->vt, 0, 0, w, h);
+    vt100_show_cursor(vt, 1);
+    vt100_image_update(vt, 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -289,7 +289,7 @@ static void console_scroll(QemuTextConsole *s, int ydelta)
                 s->vt.y_displayed = s->vt.total_height - 1;
         }
     }
-    console_refresh(s);
+    vt100_refresh(&s->vt);
 }
 
 static void kbd_send_chars(QemuTextConsole *s)
@@ -1113,7 +1113,7 @@ static void text_console_invalidate(void *opaque)
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         text_console_resize(QEMU_TEXT_CONSOLE(s));
     }
-    console_refresh(s);
+    vt100_refresh(&s->vt);
 }
 
 static void

-- 
2.53.0


