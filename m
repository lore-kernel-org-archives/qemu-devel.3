Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D149FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSEV-0005VH-0L; Mon, 27 Apr 2026 16:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSEK-0005U4-Rb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:06:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSEI-00058J-5b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:06:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so131936665e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777320413; x=1777925213; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1m5TZjfPpKFGxNcdvdtQL+COsgMLl98v9ZR1ImYqYM=;
 b=s/9jfZyU3Cev6LSaN7/dNpFtyTlbnLVPjWZMUr2NUCtSYZDRBgjv1/wpR6LXjvfVBX
 Osxb4YfUcR0428zNh2HQnJI0rKIQXitW3R15NvWHT/302MkIvdm+g5aTBYqcAldXPSvf
 xTvOeD9N3aPbrmsKCff39mb9pzxI2/Et2RNdjYiIwXTbGzCB35OqeyJP84wqER8qZSt1
 ewqG1fZok1epMb0V6EAxHqp/50AaczS7VhTuB/cDqBlB+8tN18OKJocRysNFb/JH/jJ6
 oxHxiYrwZWWiLneglbPjExtaLmpJJ58pNZEq69BcWpy0VeetlO+cAinPWJOFxQOGwglM
 /e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320413; x=1777925213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o1m5TZjfPpKFGxNcdvdtQL+COsgMLl98v9ZR1ImYqYM=;
 b=OJGuUnrS3B53TxtBTlIAovv1MV157KauwBBqY1dF7mVt7F1KL4SPBzXIpUyteC3089
 CJu2plfIRrSdP5tisygdMDbhlRN3OVmeSyhdvDMVfWgrFQwRkaLZqHe+bglk4KByp20D
 vg3uHfxzo48QlldRQwOpnJUl62ar9MXbDXZskdMOHM9N75cx2g4GWw//tsEQXBAkotB4
 rQxDNPIDyS971T+xyB6aXSdiniYEonm44E9SNp+MLKCJDCVSA/T/yZ27EN39683gv+ln
 A4tNuaOnjA3F6Hwk3U34PMbHfz1WsO8INXbdctPDCqrYHoSeaZuKN5XbLZOSXT6HTs8y
 IG3g==
X-Gm-Message-State: AOJu0YwyIYPSJqck0I9BO/t5nlrym83PDhSndtHbujs0xEDHfZ9EIEiW
 IyK9IMLb19w6OhMJEsqKtZSwJqunUZZOXEGKtBK4kBl9eNl95CNmBCCI
X-Gm-Gg: AeBDieuRZlLEOdp2NGuxxW4pAPwqkvCaPOKzb4i0EH4vlUuNqnl2ZZoxi6vwprdNm4y
 ckAmtZbJ2WvrLZZD/fGR24ouI7Rj857VIVkJOCFCrb2/gCWGKurrSYbZzvV4OTokE0gAwzwgxLv
 hEWFAJreETKOouPLSq2RxIHA3v4c0jb+exw08nUMkyG0TMncXWjx5PPz4q41gyotOW0QQW8zydM
 kY4Uco+aYKWGgJGT4sDXKdl7WtxcHAInYD2gDmE7ZqeCPESn0GpOpEYfL+P3Lnd/3fQhLCeAINI
 hDqCcRDBcVafd1xBHmh5Xu0kr3p2usKkCvb7x4Pwi47QzG7kPWW9YI9auFyPV1Er2zbNjy0grAB
 OjUNUTBb2GluRN/GMoacKSInJnZx2fanUiB/PLYMAl19Db+YE9JJMclYgzBqVhQanloBxbzu53q
 Q0BXBRw4WbUOlSF3DISyTTQeUu9nJiqO1/ZaFU3+g=
X-Received: by 2002:a05:600c:a11:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-48a77b1b405mr1781355e9.26.1777320412330; 
 Mon, 27 Apr 2026 13:06:52 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773efe38sm12767755e9.13.2026.04.27.13.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:06:51 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Mon, 27 Apr 2026 22:06:43 +0200
Subject: [PATCH v5 1/2] ui/gtk: Use non-blocking clipboard retrieval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gtk-clipboard-v5-1-6968feb31a5d@gmail.com>
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
In-Reply-To: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
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
 ui/gtk-clipboard.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 65d89ec601..463ed4e905 100644
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


