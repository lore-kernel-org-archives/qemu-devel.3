Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11DDFF8850
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 07:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGuII-0000cz-KO; Sun, 26 Apr 2026 03:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGuIC-0000bk-T9
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 03:52:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGuIA-0006N9-PP
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 03:52:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so114657015e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189957; x=1777794757; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tMkUi0r7yzmpH9iWXuskk1HxFeNLDP8o5ANaBDDxtg0=;
 b=qhSWPHoaT3HFtCjuALP1zI/fsMKkAI0rK/V14QTYaYqEhOgz09sbrvhE+WzAKLE6he
 2jTi17Cg+z8stzINwTDj3sOAAp6b/TyTla+pxWtFzeBshpMVh6XFubjEpMq1IVZqAekD
 ptdCQpYXUtvta1ytfPCGDfvv9SUxhDRNCskyeE+v450Jwo9OuPoDzgqdph317mgjcoZw
 1mRlKVwSkdfGjsxFx/yCk65HxN0i8BQQ+9LERhwjT17P5PElHi+OY8ujh3aLkknK+7aP
 mit/xDz8gpUNz4KEq5AE1DOLREPDNqANVq/2Hdt9+6b9SC+sE4N764wJZM3mUAo7TyZC
 X3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189957; x=1777794757;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tMkUi0r7yzmpH9iWXuskk1HxFeNLDP8o5ANaBDDxtg0=;
 b=qHZjUKgJFuLw1PX95D3bUzcVbwKLpDAsq3dTa00LA9gcUu3BislNujiW5isjCzlLH6
 aDPG9HujJICZxJIi7wVreo2X+XRL2u4FVvq8mfZ12Nu6LRPSff0GVL/y7ni80OT4Dpja
 nbPSFy2yMCKCb6uVYxLDRXd/Okru5jNxCaiBkb4iTOCaH5za3bwBQW2msqrh6gjt5QWZ
 Qw7PLHNccJrFifiBl/sbTaQ4En4h4yfApHh39NZ5kRJK/0/UuL7LqezHGvpjyzPRiwXj
 J7DOLG+X3thXoMCs3Jxic8EmFKLLiFPD6J9IUK3UHI7U4wToaoMAzPh96bPRsnVEhCSE
 umvQ==
X-Gm-Message-State: AOJu0YwpeVtmX4n83LyBAD89VG2kqQn1S7w63Yqtfntsh+SJKntYOnWc
 jTF81sNyPXLs+kY0LfWhVZwiCG1VLdUp/4YKBCa/Z1OMxNp6F2ESTtSNLwhDfNY1
X-Gm-Gg: AeBDiev1U9km5wwVQKYlpOKiCR41DXJ6mPHH/JaLYCGPw018i3OZVCwptQnXJIgz7RS
 isfUSYnYDhpFVfehpsUSBwryuXmloVu8Ak5GncUWrGQgAYf+y9WiCtI95xmklDiCn/M+ufSE/8W
 T5v64/kPBEgd4HpGXviwrmFmFOOyMWpSqJpvXL89yvGnoUthZelbO1C5KfzgQ/s1gbR5XLaKHNt
 xmCCVVBzZehZHXkDxDBRy78gtxLKOkWWdmoWhe5hFugnKqsDwgOiC3PAPgx4H++F0g5C08cyXmQ
 S/eZySt+hvVU3GRegl3ClKGLHHC6XcT1fEjW/OxILC3lyHX7TNQWluRqmOsmCqiXBEcTEH93UIM
 aw1vCB/Hw0JX+gCQHQ0ADOZnEPIOIEzph9/OEDoDuTiQuOZ00x9BmQAWoNEXLxthVlfM921Ao9t
 9H52RXez7JKOyqphDi00M4RcajNAVy6QcWmaaBB8EEmquwrpso6Q==
X-Received: by 2002:a05:600c:c10a:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-488fb771613mr417462105e9.18.1777189956679; 
 Sun, 26 Apr 2026 00:52:36 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c68asm224080045e9.3.2026.04.26.00.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:52:35 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Sun, 26 Apr 2026 09:52:33 +0200
Subject: [PATCH v3 1/2] ui/gtk: Use non-blocking clipboard retrieval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
In-Reply-To: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x333.google.com
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
 ui/gtk-clipboard.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 65d89ec601..691784697d 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -136,26 +136,54 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
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
 
+static void gd_clipboard_owner_change_contents_received_callback(
+    GtkClipboard *clipboard,
+    GtkSelectionData *selection_data,
+    gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
+
+    if (selection_data) {
+        if (gtk_selection_data_targets_include_text(selection_data)) {
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
@@ -173,12 +201,10 @@ static void gd_owner_change(GtkClipboard *clipboard,
     switch (event->owner_change.reason) {
     case GDK_OWNER_CHANGE_NEW_OWNER:
         info = qemu_clipboard_info_new(&gd->cbpeer, s);
-        if (gtk_clipboard_wait_is_text_available(clipboard)) {
-            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
-        }
-
-        qemu_clipboard_update(info);
-        qemu_clipboard_info_unref(info);
+        gtk_clipboard_request_contents(
+            clipboard, gdk_atom_intern_static_string("TARGETS"),
+            gd_clipboard_owner_change_contents_received_callback,
+            info);
         break;
     default:
         qemu_clipboard_peer_release(&gd->cbpeer, s);

-- 
2.53.0


