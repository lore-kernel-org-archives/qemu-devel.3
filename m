Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C60FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdap-0007QC-KB; Tue, 28 Apr 2026 04:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdac-0006v0-J3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaY-0006BF-QK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJYvvcZRba3I1zKU++du8AS3XrBP5bifa0DkUwP4SUE=;
 b=FCOXdeBWqhjy/lcnxh/IqZjR7+oEhRuf1uQAKGm8NAGuvVVkxo+kEeXA40/Bkrt7AOg91l
 aMrdBA/4PRyo929t+MNFKEQ2j4KhiSffw8mG1N7Icu7XJWPs8R1aqXzgQB07Oht39UfuPN
 ppAs0NRZNQElf6OBU+j0jL03Mrbu4IA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-8tDN4GZOPSqnY09l8vfjXg-1; Tue,
 28 Apr 2026 04:14:33 -0400
X-MC-Unique: 8tDN4GZOPSqnY09l8vfjXg-1
X-Mimecast-MFC-AGG-ID: 8tDN4GZOPSqnY09l8vfjXg_1777364072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9E83195609E; Tue, 28 Apr 2026 08:14:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1467419560B1; Tue, 28 Apr 2026 08:14:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Jind=C5=99ich=20Makovi=C4=8Dka?= <makovick@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 14/15] ui/gtk: Use non-blocking clipboard retrieval
Date: Tue, 28 Apr 2026 12:13:01 +0400
Message-ID: <20260428081303.990973-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jindřich Makovička <makovick@gmail.com>

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260427-gtk-clipboard-v5-1-6968feb31a5d@gmail.com>
---
 ui/gtk-clipboard.c | 53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 65d89ec601d..463ed4e905b 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -136,26 +136,55 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     }
 }
 
+static void
+gd_clipboard_request_text_received_callback(GtkClipboard *clipboard,
+                                            const gchar *text,
+                                            gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
+
+    if (text) {
+        qemu_clipboard_set_data(info->owner, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                                strlen(text), text, true);
+    }
+    qemu_clipboard_info_unref(info);
+}
+
 static void gd_clipboard_request(QemuClipboardInfo *info,
                                  QemuClipboardType type)
 {
     GtkDisplayState *gd = container_of(info->owner, GtkDisplayState, cbpeer);
-    char *text;
 
     switch (type) {
     case QEMU_CLIPBOARD_TYPE_TEXT:
-        text = gtk_clipboard_wait_for_text(gd->gtkcb[info->selection]);
-        if (text) {
-            qemu_clipboard_set_data(&gd->cbpeer, info, type,
-                                    strlen(text), text, true);
-            g_free(text);
-        }
+        qemu_clipboard_info_ref(info);
+        gtk_clipboard_request_text(gd->gtkcb[info->selection],
+                                   gd_clipboard_request_text_received_callback,
+                                   info);
         break;
     default:
         break;
     }
 }
 
+static void gd_clipboard_owner_change_targets_received_callback(
+    GtkClipboard *clipboard,
+    GdkAtom *targets,
+    gint n_targets,
+    gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
+
+    if (n_targets) {
+        if (gtk_targets_include_text(targets, n_targets)) {
+            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
+        }
+    }
+
+    qemu_clipboard_update(info);
+    qemu_clipboard_info_unref(info);
+}
+
 static void gd_owner_change(GtkClipboard *clipboard,
                             GdkEvent *event,
                             gpointer data)
@@ -173,12 +202,10 @@ static void gd_owner_change(GtkClipboard *clipboard,
     switch (event->owner_change.reason) {
     case GDK_OWNER_CHANGE_NEW_OWNER:
         info = qemu_clipboard_info_new(&gd->cbpeer, s);
-        if (gtk_clipboard_wait_is_text_available(clipboard)) {
-            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
-        }
-
-        qemu_clipboard_update(info);
-        qemu_clipboard_info_unref(info);
+        gtk_clipboard_request_targets(
+            clipboard,
+            gd_clipboard_owner_change_targets_received_callback,
+            info);
         break;
     default:
         qemu_clipboard_peer_release(&gd->cbpeer, s);
-- 
2.53.0


