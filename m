Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A7EF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHOn-0004Gu-4F; Fri, 10 Apr 2026 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOl-0004Aa-9x
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOj-00015C-1m
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0I2+yZ98E836Z2P9dlsrUG3JAUWuXDSLpAuU+eC392E=;
 b=ACcwmoiRaAZPt7oMemWY7eEpEw/WFRr1zpo7XVDsRr5J548c2KSZxN7jUQp/Q8JMOldkj0
 RaLgxbH9oeJW/wMfwGo3Frok8UgQa572sqHe1dPRYRXZft1toKCw+Wqo0mjHd2CphZQdLO
 cBnU/7SVY6OcnVqf5+RdTUbPD2Hkr0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-Y0gyWIl_PmKPSk47N0Bkpw-1; Fri,
 10 Apr 2026 15:20:07 -0400
X-MC-Unique: Y0gyWIl_PmKPSk47N0Bkpw-1
X-Mimecast-MFC-AGG-ID: Y0gyWIl_PmKPSk47N0Bkpw_1775848806
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87265195605E
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:20:06 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E6BF3000C16; Fri, 10 Apr 2026 19:20:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:34 +0400
Subject: [PATCH v2 12/67] ui/console: dispatch get_label() through QOM
 virtual method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-12-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6932;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VZpzpANVaAkXTsjt5tv6uI07yEgnJRkVBs8sY4GwLtQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UCt4OpQ/403qw7n7WYHgEhNC/f6K6g/ErF
 LEGrqgB1NuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5ShKD/9rw3Bl3TP6Gk/yM+YumAzUovg5wDf4+x8X+9fwCbpMtti9dihwUC2XGk/dHm2jn+JOCAH
 RnwPmYSfgMQNFLCm+7SbSmw9NuX3r4MplJaVOsi2gUJs2Z8cvjMv3AxW3orFMHzkCs33cxzEkHS
 SZaqEje33lSSKDWTVDdFR95/TsKJ3ZK5TP79IjgG7kbo+laenNX0JmA4wcT29/cd3MmsO6E4Pu6
 9bWDR769IjG2RsmlUVzKy/96gQ1bInmu7KnsrWemW529GH5bujdzjOIw0ejPpcXeqklK7hfC4zB
 Kk68L0jQzZbjVk1/0MwD77t52q+r59ucyGkIaNokSJMu+JqIj+S6ELm1W2N7vBEnX9ShaOSXsxL
 3n+F5kdJ0FpUQuRZnRKw7junMuYcLz1bsfF3vzSAX0oEZp1Jk5duL0hYyGchlJ/0LI4reC/8ouJ
 NYgbQGzEHzyinCIs0WoB5AaSKZ5Dd38vIIvgqwss8S7KP1muuiCN6TQOTPPRkwfxTS/Bjp4Ur7J
 1CycWb7CCLn5ksmNmVGAIA6yU3h3wTGsL1gqmZOvtpHkO88HoXvyrN5KGGECL9NnTHPzR+gy2Ka
 /H54wZ6ofUZhF0Z8a9jwY9nXGKo6d/ntQH530vuyMEM6IouodAlwZYzG4vlgMMLfZi3Ajcvrlp8
 Tng7/mtdQf59vDQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Replace the type-checking chain in qemu_console_get_label() (using
QEMU_IS_GRAPHIC_CONSOLE/QEMU_IS_TEXT_CONSOLE) with a QemuConsoleClass
virtual method, allowing each console subclass to provide its own
get_label implementation.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h  |   2 +
 ui/console-priv.h     |   1 -
 ui/console-vc-stubs.c |   6 ---
 ui/console-vc.c       |  12 ++++--
 ui/console.c          | 101 +++++++++++++++++++++++++++-----------------------
 5 files changed, 65 insertions(+), 57 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 08082389f71..395a723e318 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -129,6 +129,8 @@ void console_handle_touch_event(QemuConsole *con,
 
 struct QemuConsoleClass {
     ObjectClass parent_class;
+
+    char * (*get_label)(QemuConsole *con);
 };
 
 typedef struct ScanoutTexture {
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 43ceb8122f1..2c2cfd99570 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -36,7 +36,6 @@ struct QemuConsole {
 };
 
 void qemu_text_console_update_size(QemuTextConsole *c);
-const char * qemu_text_console_get_label(QemuTextConsole *c);
 void qemu_text_console_update_cursor(void);
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
 
diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
index b63e2fb2345..8a7f19c1f44 100644
--- a/ui/console-vc-stubs.c
+++ b/ui/console-vc-stubs.c
@@ -14,12 +14,6 @@ void qemu_text_console_update_size(QemuTextConsole *c)
 {
 }
 
-const char *
-qemu_text_console_get_label(QemuTextConsole *c)
-{
-    return NULL;
-}
-
 void qemu_text_console_update_cursor(void)
 {
 }
diff --git a/ui/console-vc.c b/ui/console-vc.c
index bd816d45759..7b9acf1adb1 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -125,10 +125,12 @@ static const pixman_color_t color_table_rgb[2][8] = {
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
 
-const char *
-qemu_text_console_get_label(QemuTextConsole *c)
+static char *
+qemu_text_console_get_label(QemuConsole *c)
 {
-    return c->chr ? c->chr->label : NULL;
+    QemuTextConsole *tc = QEMU_TEXT_CONSOLE(c);
+
+    return tc->chr ? g_strdup(tc->chr->label) : NULL;
 }
 
 static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
@@ -1114,9 +1116,13 @@ qemu_text_console_finalize(Object *obj)
 static void
 qemu_text_console_class_init(ObjectClass *oc, const void *data)
 {
+    QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
+
     if (!cursor_timer) {
         cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
     }
+
+    cc->get_label = qemu_text_console_get_label;
 }
 
 static const GraphicHwOps text_console_ops = {
diff --git a/ui/console.c b/ui/console.c
index f445db11389..24e4761e1f9 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -436,9 +436,58 @@ qemu_graphic_console_prop_get_head(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &c->head, errp);
 }
 
+static bool
+qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
+{
+    QemuConsole *con;
+
+    QTAILQ_FOREACH(con, &consoles, next) {
+        QemuGraphicConsole *candidate;
+
+        if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
+            continue;
+        }
+
+        candidate = QEMU_GRAPHIC_CONSOLE(con);
+        if (candidate->device != c->device) {
+            continue;
+        }
+
+        if (candidate->head != c->head) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static char *
+qemu_graphic_console_get_label(QemuConsole *con)
+{
+    QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(con);
+
+    if (c->device) {
+        DeviceState *dev;
+        bool multihead;
+
+        dev = DEVICE(c->device);
+        multihead = qemu_graphic_console_is_multihead(c);
+        if (multihead) {
+            return g_strdup_printf("%s.%d", dev->id ?
+                                   dev->id :
+                                   object_get_typename(c->device),
+                                   c->head);
+        } else {
+            return g_strdup(dev->id ? : object_get_typename(c->device));
+        }
+    }
+    return g_strdup("VGA");
+}
+
 static void
 qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
 {
+    QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
+
     object_class_property_add_link(oc, "device", TYPE_DEVICE,
                                    offsetof(QemuGraphicConsole, device),
                                    object_property_allow_set_link,
@@ -446,6 +495,8 @@ qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
     object_class_property_add(oc, "head", "uint32",
                               qemu_graphic_console_prop_get_head,
                               NULL, NULL, NULL);
+
+    cc->get_label = qemu_graphic_console_get_label;
 }
 
 static void
@@ -1347,56 +1398,12 @@ bool qemu_console_is_gl_blocked(QemuConsole *con)
     return con->gl_block;
 }
 
-static bool qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
-{
-    QemuConsole *con;
-
-    QTAILQ_FOREACH(con, &consoles, next) {
-        QemuGraphicConsole *candidate;
-
-        if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
-            continue;
-        }
-
-        candidate = QEMU_GRAPHIC_CONSOLE(con);
-        if (candidate->device != c->device) {
-            continue;
-        }
-
-        if (candidate->head != c->head) {
-            return true;
-        }
-    }
-    return false;
-}
-
 char *qemu_console_get_label(QemuConsole *con)
 {
-    if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
-        QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(con);
-        if (c->device) {
-            DeviceState *dev;
-            bool multihead;
-
-            dev = DEVICE(c->device);
-            multihead = qemu_graphic_console_is_multihead(c);
-            if (multihead) {
-                return g_strdup_printf("%s.%d", dev->id ?
-                                       dev->id :
-                                       object_get_typename(c->device),
-                                       c->head);
-            } else {
-                return g_strdup(dev->id ? : object_get_typename(c->device));
-            }
-        }
-        return g_strdup("VGA");
-    } else if (QEMU_IS_TEXT_CONSOLE(con)) {
-        const char *label = qemu_text_console_get_label(QEMU_TEXT_CONSOLE(con));
-        if (label) {
-            return g_strdup(label);
-        }
+    char *label = QEMU_CONSOLE_GET_CLASS(con)->get_label(con);
+    if (label) {
+        return label;
     }
-
     return g_strdup_printf("vc%d", con->index);
 }
 

-- 
2.53.0


