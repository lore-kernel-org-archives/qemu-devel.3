Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD95AFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRnp-0007Uq-VZ; Mon, 27 Apr 2026 15:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRna-0007T8-0R
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:39:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRnY-0006s8-Dl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:39:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso113154385e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777318754; x=1777923554; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1m5TZjfPpKFGxNcdvdtQL+COsgMLl98v9ZR1ImYqYM=;
 b=JsZKJVTslNlRLf5GumJ8nz0Ym7TzKFXcfz/jKn24Y4yvR/FH4pnTsvWMcf5zzCiwPe
 EpGy5IicWWOFzjiDma8OBLgkYHvTn58S/k1lqXJ08Nic74Lm4ktWokANA4IQKniUGwyc
 eToIb+IESv8nBQGQFmBrGdzel+HDMsXG/fE3yIRWFoAu14ovmYpGkrRXOuwP8zqRnBFZ
 7ECRrbDKlZn6bRSmdHLYqAE4uuEIs/MOf5uC5wUhzmweP1riDxEbjD/YNmdW0zXsWop/
 ZnZhfmXmOP7t6oRc9UBg7dLhXgDlKaH392lnSqpne312d5/2TSOJF15MKFpD2M3PBxJs
 ds+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318754; x=1777923554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o1m5TZjfPpKFGxNcdvdtQL+COsgMLl98v9ZR1ImYqYM=;
 b=OhVwdA/cvSCte+VHdZYiAKPPd1b9pru1NhqxoR4wNVGwcH5/1oaLBuGUj2M1owDILv
 HSJd9qqhx8OkJw9mMPW98Q1lr3NtK2UMWCe8uqfpm/K20mbq40T0BCJ88t7z1IOs2pop
 i3Fm4Odu1Y+z9ho9unB43noI2O5Otou0frrdkp6wOfUm3cdB23Paa/2cUugmjFis8Hhn
 CHY2LZ/7n4tCvtGuky204HYIVcDfoTj92j84ZPiUEFuNN9IvipvnGldWTtIt9SJRNV0m
 k0Q/B908UraKzTuMpGUJmUX9qr9bsyKEVEi2qdasbLar0XKxlDQrg/g5p6/8OfU7zFiv
 QnsQ==
X-Gm-Message-State: AOJu0YxyAKm3NnSH/0+aQ+tA608fS/6Kml1drV6Oqpk8x2HyI/5Yu278
 q4fPfdRDFRHsMvfVnxJeMU+8Gp9YJG6Q4pVgGV9aX84jt9yv/VVoPOIA
X-Gm-Gg: AeBDies9tmd/r8OWLq+ySlt9mXsJiJ2cX3rgjBr6gb71HFU5nUowMj+IshIsRMdeqK8
 hY38/2jNGSE7WneF8NWBW8dc6Sz3Nq0Xhg8Y1m/7MrHHK6+ybUzlsxLBnlflYlnUa08nenuf+2+
 qcwA1xWQtaByoaGbXiqT4dFRRJ6ReImMhwdFSnVDoC4sqrDp948o2zvWvaKQtlQHpUX/GD5+4OY
 WRHUfH9WTuzN2kjG6w0HIctzQL2uW7XhveVfzLOxNJVfRuo5n9UbOOoCdk2Rb0q9isdpvc17ag7
 OHnb7aX1a3gwWb6f5Abtj4t0536F8VRNzEM1iKkpR3iHjOEI5b5+NcnWYcFb7WgjI699az92z7L
 A/fSwOgfdrKCmEc9JfUoonhv1lFuGAnT2rO4vjp/0b5gGV4tW+ewOZd2TUy7+nYe61SLzk8Us94
 kCimemhFyA86YPpujJGGL68lVdsSR1Og9Fxr0fA4M=
X-Received: by 2002:a05:600c:3386:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48a77e64f29mr142535e9.16.1777318754450; 
 Mon, 27 Apr 2026 12:39:14 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773e70c2sm8281035e9.10.2026.04.27.12.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:39:14 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Mon, 27 Apr 2026 21:39:10 +0200
Subject: [PATCH v4 1/2] ui/gtk: Use non-blocking clipboard retrieval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gtk-clipboard-v4-1-176ad9919931@gmail.com>
References: <20260427-gtk-clipboard-v4-0-176ad9919931@gmail.com>
In-Reply-To: <20260427-gtk-clipboard-v4-0-176ad9919931@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x32d.google.com
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


