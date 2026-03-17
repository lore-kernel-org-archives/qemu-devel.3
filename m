Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55E4F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBj-0000jo-DJ; Tue, 17 Mar 2026 04:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAW-00071t-Hb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAT-0003A1-M4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9nyli9BY8wD/CTz9U2BMlE1zq/HDRv1YjQhX67MylI=;
 b=W1Ns1qT+vtAFgraSa6Tn1IueLX867yMwHpYqNB4fvDkkDW9+MjW6gYhLJDuegYuI66v1yl
 /v5emlEWfTtGm75nEVNxkyqYt1IJJ2cODLF+qM0Ag/35DnGXYRnEFTSf7rvIiwFBGsZ8ru
 xTMWewWyorTGFrkSoUaU88Uk2sj6bzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-Bz95D4D-OqWdfGThVsEeYw-1; Tue,
 17 Mar 2026 04:52:47 -0400
X-MC-Unique: Bz95D4D-OqWdfGThVsEeYw-1
X-Mimecast-MFC-AGG-ID: Bz95D4D-OqWdfGThVsEeYw_1773737566
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BE7019560B4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7122F3000223
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:36 +0400
Subject: [PATCH 22/60] ui/console-vc: move cursor blinking logic into VT100
 layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-22-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5150;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=19Yda8rU5AGiPLr05ZJlrDxs/rzExrhqBPxO9Konvw8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbhrLMoyrH1oD2YCJyxEkxxQXGeCoP6rVuF
 zoBY5bcVeOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5cavD/9DJA3gxl/S4u23ZVPRMpoJKN+oSbPmE51FozNGIwosbmjXwp1jWz9H0WrNH83jZk1yo90
 8R6Lh3Fpy5lqR9dxsa9QuxiIsp06fq9dvsOXu32YIz1N3kDhuZb+p/vNMC3jWwCjKD/c8dswM7k
 pwZYPQBoGduQqZkqkq9fUzQgCxs2MjGdxH10OdfCiDPVxfLa3ZNxGz1nl5gegzNAu/01dQV14EU
 jrpy1EYwRYYEaUMdnEB3cnC4umleKOxopT9rxoMgQZgYH1cu4PbTb64WZtEoe5L+zcntH60wNK9
 FvR3ZvV+DBLoOc21rchJd8nYJ626x0Wgafy88X4lbcPfcF6Vpa1/oDHHrxO0CoBST6Imhqn0JaJ
 IvMYIsgDWySCsDcUexRoO5wXejpQcbltM5bL/BMdx2sWoXWEmcdPxPtyaSGxaHohTRDsOWTSWPC
 PieJvxVPximR4BI9nUERaLQcaoBgJCJIiFCnO6+GZaJlx82CIo88YrGX2Cn7dvCRNLi7E1R4lDs
 3pfWXT9ZYZKwgRqVBII65GKUykAsFlS/AkUb5i2ws9oRkuZCvvpI54VwWqmR66iZCvCRGA1D6aK
 Ol2/elZWFgVMn0kyeoiU1bbjUp67K58WDmwVJfRU7lr6/1rZK/d5Wotq0gfWhucdc5Nk7x6z6fd
 by5km5sGj01hFmQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Maintain a list of QemuVT100 instances so the cursor timer can directly
iterate over them and call vt100_refresh(), instead of going through
qemu_invalidate_text_consoles() which iterated over all consoles
(including graphic ones) and called back into the generic display layer.

This removes the qemu_invalidate_text_consoles() function from
console.c, further decoupling VT100 text rendering from the console
core.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h  |  1 -
 ui/console-priv.h     |  2 +-
 ui/console-vc-stubs.c |  2 +-
 ui/console-vc.c       | 28 +++++++++++++++++++++++-----
 ui/console.c          | 19 +------------------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 4896e9e0e04..401e5a010fd 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -416,7 +416,6 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id);
 void qemu_console_resize(QemuConsole *con, int width, int height);
 DisplaySurface *qemu_console_surface(QemuConsole *con);
 void coroutine_fn qemu_console_co_wait_update(QemuConsole *con);
-int qemu_invalidate_text_consoles(void);
 
 /* console-gl.c */
 #ifdef CONFIG_OPENGL
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 2c2cfd99570..8bcdb79d914 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -36,7 +36,7 @@ struct QemuConsole {
 };
 
 void qemu_text_console_update_size(QemuTextConsole *c);
-void qemu_text_console_update_cursor(void);
+void vt100_update_cursor(void);
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
 
 #endif
diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
index 8a7f19c1f44..d911a82f263 100644
--- a/ui/console-vc-stubs.c
+++ b/ui/console-vc-stubs.c
@@ -14,7 +14,7 @@ void qemu_text_console_update_size(QemuTextConsole *c)
 {
 }
 
-void qemu_text_console_update_cursor(void)
+void vt100_update_cursor(void)
 {
 }
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index d2a7d527586..22d1128ee6b 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -8,6 +8,7 @@
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
 #include "qemu/option.h"
+#include "qemu/queue.h"
 #include "ui/console.h"
 #include "ui/cp437.h"
 
@@ -69,8 +70,13 @@ struct QemuVT100 {
     int update_y0;
     int update_x1;
     int update_y1;
+
+    QTAILQ_ENTRY(QemuVT100) list;
 };
 
+static QTAILQ_HEAD(QemuVT100Head, QemuVT100) vt100s =
+    QTAILQ_HEAD_INITIALIZER(vt100s);
+
 typedef struct QemuTextConsole {
     QemuConsole parent;
 
@@ -1090,20 +1096,28 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-void qemu_text_console_update_cursor(void)
+void vt100_update_cursor(void)
 {
+    QemuVT100 *vt;
+
     cursor_visible_phase = !cursor_visible_phase;
 
-    if (qemu_invalidate_text_consoles()) {
-        timer_mod(cursor_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
+    if (QTAILQ_EMPTY(&vt100s)) {
+        return;
+    }
+
+    QTAILQ_FOREACH(vt, &vt100s, list) {
+        vt100_refresh(vt);
     }
+
+    timer_mod(cursor_timer,
+        qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
 }
 
 static void
 cursor_timer_cb(void *opaque)
 {
-    qemu_text_console_update_cursor();
+    vt100_update_cursor();
 }
 
 static void text_console_invalidate(void *opaque)
@@ -1119,6 +1133,9 @@ static void text_console_invalidate(void *opaque)
 static void
 qemu_text_console_finalize(Object *obj)
 {
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(obj);
+
+    QTAILQ_REMOVE(&vt100s, &s->vt, list);
 }
 
 static void
@@ -1143,6 +1160,7 @@ qemu_text_console_init(Object *obj)
 {
     QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
 
+    QTAILQ_INSERT_HEAD(&vt100s, &c->vt, list);
     fifo8_create(&c->out_fifo, 16);
     c->vt.total_height = DEFAULT_BACKSCROLL;
     QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
diff --git a/ui/console.c b/ui/console.c
index 24e4761e1f9..8af1dee0e22 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -752,7 +752,7 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     } else if (QEMU_IS_TEXT_CONSOLE(dcl->con)) {
         qemu_text_console_update_size(QEMU_TEXT_CONSOLE(dcl->con));
     }
-    qemu_text_console_update_cursor();
+    vt100_update_cursor();
 }
 
 void update_displaychangelistener(DisplayChangeListener *dcl,
@@ -1457,23 +1457,6 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
 }
 
-int qemu_invalidate_text_consoles(void)
-{
-    QemuConsole *s;
-    int count = 0;
-
-    QTAILQ_FOREACH(s, &consoles, next) {
-        if (qemu_console_is_graphic(s) ||
-            !qemu_console_is_visible(s)) {
-            continue;
-        }
-        count++;
-        graphic_hw_invalidate(s);
-    }
-
-    return count;
-}
-
 void qemu_console_resize(QemuConsole *s, int width, int height)
 {
     DisplaySurface *surface = qemu_console_surface(s);

-- 
2.53.0


