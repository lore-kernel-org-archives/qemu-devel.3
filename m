Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B1FF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZhz-0002vz-Jt; Sat, 25 Apr 2026 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZhv-0002vE-BN
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:53:51 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZht-0002B1-Ur
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:53:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso5177108f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777110828; x=1777715628; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KS523ZuLQajlqaW9nRPPvwWPNkbM/GgW7sZV4UtjmFI=;
 b=HxrWQBxPWuldQ/O+RqaBf1qhakajFXhtkAPA6UdGmKDbD+7180WhJhLjJW0klFgqMG
 W4CQkS1EBdXpj7jsLJ1DJBFO0XF2jTmK2ymNpoJFYqahN6AFGR9fETnABGF2EQHCZVjC
 WniRmfGvePUDCYhUmga+IlAum+0X1g+sMb3KA8D/LrtzT0XP8GLaSJzqKbsc6trkHVEM
 HgGwYmwMR6KYZlucsf+bZ/oUrMweWeICLPkIe2kg0J9zRNvjP+bVuwcNsgF2JSn8VHsU
 83PHhe5Dy7bjjlbgJdhURT3isCXrFUHOBl7XFxswFzPxIBaL5xlWApi5GDrTtzZugcm1
 GQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777110828; x=1777715628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KS523ZuLQajlqaW9nRPPvwWPNkbM/GgW7sZV4UtjmFI=;
 b=So7bCQ8eCX5UW/TNu0oWiq1L7vfzn1Rxl5g8CUdCqO4YoPBPQYm4r/ETbT9mB2J5Gp
 EqXIU+Qib7zC3/N9evs2xONj2B3bmGwGgEnANS+b6VDpzr6QIw1Nu9jJRUkQLm3JsO1v
 Kurcs9TVkiXaveBDKVXa87dT0wRBq42S9qt4hF3FWCXivH61xcF/pg06q3w0oQR+rFKa
 jashThd6KA3HVLaUuV8kqZDA9CXmcuIXnSohBjlUqjYIE+wuHJgBWfhxxzpITKJGftkf
 bYgNWYsZwMNdn6FLxy9N6AMgJccmaV9pcsSkjMMpGc1PlasdPCIYCQHTYtuAAGVBREBC
 QNtw==
X-Gm-Message-State: AOJu0YwUvv33dqJnqpWaQyH7gBPchpK7yiX2MoaAhTAlAS8rED09631r
 Z+/m7IaPmxtrQwZ4yZHkJVU9gzX8Y2p7EkY0oa2qtnvYwbDkVRbw/6U8
X-Gm-Gg: AeBDievdrTXuXyBVIeP1FDLbCQbDoiI9+U3QlUDWz6vPlBOs7IURye7nAst0y9SanwY
 f2vbr2T90gub/hWdhfrVMtLz9XgUculuMZQor2f8cmf+Kr0QNKBclyjK+gpjRugojuc0PV4Xvps
 ZjR+k5bE3zzAJzE49IWGodrLuI6cT6ZLbMfEfByqbq130/k8GZz2mPowvPyduLxePbgqwmte+JF
 q37x/gXXWVc8lJM2H8puNgQqErlxwWVO4HLi0nEhl6TgElsaX8xaHF8p3Opz3EK+jjzRN7IgXB4
 pws0tpE6Nmhzp1LIIfO1UWAADtBXssykyVcaV9K0BlsuqLyJEAENjPOep/f2owYJdvDJU/PZPFA
 s6VaWpMoQmCPu3zZVUgc99FODkZaZcSbpHUWE9EcCERf5Ct/aa4896YhRVrC3Hd2GhXwqA5+0zy
 obkR+cxWHTMy+m4bCxZH/nYtY2zGseeEYF36r09qk=
X-Received: by 2002:a05:6000:184d:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-43fe3dd958amr55703038f8f.21.1777110828404; 
 Sat, 25 Apr 2026 02:53:48 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm67574574f8f.10.2026.04.25.02.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 02:53:47 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Sat, 25 Apr 2026 11:53:40 +0200
Subject: [PATCH v2 1/2] ui/gtk: Use non-blocking clipboard retrieval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-gtk-clipboard-v2-1-b098f3cf69cc@gmail.com>
References: <20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com>
In-Reply-To: <20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=makovick@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/gtk-clipboard.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 65d89ec601..23d32947cc 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -136,26 +136,50 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     }
 }
 
+static void
+gd_clipboard_request_text_received_callback(GtkClipboard *clipboard,
+                                            const gchar *text,
+                                            gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
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
 
+static void
+gd_clipboard_owner_change_text_received_callback(GtkClipboard *clipboard,
+                                                 const gchar *text,
+                                                 gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
+    if (text) {
+        info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
+    }
+
+    qemu_clipboard_update(info);
+    qemu_clipboard_info_unref(info);
+}
+
 static void gd_owner_change(GtkClipboard *clipboard,
                             GdkEvent *event,
                             gpointer data)
@@ -173,12 +197,9 @@ static void gd_owner_change(GtkClipboard *clipboard,
     switch (event->owner_change.reason) {
     case GDK_OWNER_CHANGE_NEW_OWNER:
         info = qemu_clipboard_info_new(&gd->cbpeer, s);
-        if (gtk_clipboard_wait_is_text_available(clipboard)) {
-            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
-        }
-
-        qemu_clipboard_update(info);
-        qemu_clipboard_info_unref(info);
+        gtk_clipboard_request_text(clipboard,
+                                   gd_clipboard_owner_change_text_received_callback,
+                                   info);
         break;
     default:
         qemu_clipboard_peer_release(&gd->cbpeer, s);

-- 
2.53.0


