Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 13:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzxSs-0003ci-3N; Sat, 20 Sep 2025 09:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1uzwI2-000584-AJ
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 08:02:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1uzwI0-0003Zu-Hb
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 08:02:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45cb5e5e71eso18591725e9.2
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758369722; x=1758974522; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N/Aat/GU86e1dBKeFErhP7PDzyMUGhadT//BKBsQPT8=;
 b=UhEPOkWRxehBdQjE4WInheV12MRbVSwwcxbyvxd2DZs64X6A5jDCfwPAneqjwuXE2n
 52UdAlgQ02eh+Mj1OIC86HIeGdNZBvitoDqwf8VsHu4QMRt5d943MoLH2aeqgNwzh4Z1
 7B0HtXX9ogtAjTRo+pdPptPvoIU+pKDLmnDdyF99pVp5odAeD+CVKOIUN0YpS4raRmyT
 IntSgYtm5Dd6di7MDKRSRJr6uRV3G2iy2AV9WXQg9QB43XDMnBRQmqO9lf//d4+rUc4m
 HFr9jvgbZGaPlEGxwZAHPwlwnv7iYWMrqRaKQGij+KrdR1NVgoB8Oi11iouQ4Oq8xif6
 A3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758369722; x=1758974522;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N/Aat/GU86e1dBKeFErhP7PDzyMUGhadT//BKBsQPT8=;
 b=VFqOj7TCi8mmEkjZ3HhncZV7t9rFHyp37yu3fsHtBliqvNzahVvyQKiuYv4QyVgP9Q
 LgsMfbNLqUU4ZtoZJFh8w21UUOUMKYdCrMXL69TfKXURWMS/3iIVzzTFhaxklpnwZ8Cy
 tuGDkxrqkuuZMEKhnSEaUXggAZfilfOpWpiQLrFqaJLvTU3khL76iTlEzDaerUF2DpSh
 DvDxIbpe8CBT6pBe2eCygVQYb1O0/dzepAzdEC5cwEYPgoMeBB/vgEjooBcWJvwoMhlH
 ZubY7DVSjF9RC3U4VAj2q7kmuNqJd40Z2TuvC5At6dHRq5yyEZZdPlhKeu/pYGfrRnO7
 UgTw==
X-Gm-Message-State: AOJu0Ywcoh3rSDN97uxUY+5ZhI744H/zoVyW/kAYj+xCh14gkgcTjaSZ
 JaRKRP9H6Q/nlIQiwG2GxYnH6Wv0jaHfqXTVIu0Uez4Iu3ytn/SwJq6P
X-Gm-Gg: ASbGncvrEctCyDhJ4Omto1oktVVl3JUI1eAxa1Arz2wt9DgxPNRf4rVngYEZ0RFc00N
 Soh7kY/U12KyviLiIDhSk1fU44H40yJYl7PW1QihHxrarzHzQkfbXZGuEikFQGHHM8hczvxl4to
 JvlTQe7YA2W5VTFpvgQ8vyL7TxJxXsdPmWVQxiAFo0wIjJNCtyR8gxQjmATwGM6pkrAKY1/X/7h
 V60gPdUd+PE8VaG01gSkq8Su/1Tw+BfpQmZ5xKMj/sRLH0Ob2oOkN+nkM4Fe3tFWPyIVl0RS2Sx
 8bm8OxYM7VRowCRZG0VksT6XOd1tShXsfAu033tGK2OImTT9d7bpyhbB3Rx85oeCaI8VAGtjnaD
 hPq9odeVtJUvayFgEgxk5VVQkX48Btv55AoTO3CxT6Q2HlzjvcxViNdQbcec63qUc7fJLlqy6SS
 Duyw==
X-Google-Smtp-Source: AGHT+IFl7DQ8Rm+KsgGCcTo/AXxdwoQuB3f38doLAr6D5omhAi0vr7uTqOOdgKkZgaNRaxkY+nmTog==
X-Received: by 2002:a05:600c:4fc5:b0:45b:88d6:8db5 with SMTP id
 5b1f17b1804b1-467eceea772mr59026465e9.12.1758369722048; 
 Sat, 20 Sep 2025 05:02:02 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f0d8a2bfsm126950085e9.2.2025.09.20.05.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 05:02:01 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Sat, 20 Sep 2025 15:01:39 +0300
Subject: [PATCH] tap-win32: fix multiple tap support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKOXzmgC/x2MWwqAIBAArxL73YIaFXWV6KN0q4UyUXtAdPekz
 4GZeSCQZwrQZg94OjnwbhPIPAO9DHYmZJMYlFClaJTAiW+82BYKt2ON7FbCOLiAZGSlNU2jkTW
 k2nlK6n/u+vf9AB3eastpAAAA
X-Change-ID: 20250920-fix-win32-multiple-taps-ed16ccefbd17
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 20 Sep 2025 09:17:15 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently when more than one tap is created on Windows, QEMU immediately
crashes with a null-deref since the code incorrectly uses a static global
for the tap state.

Instead, this patch allocates a structure for each tap at startup.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
 net/tap-win32.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b3f121f74eb32f1bff779c84ce03114..217a43cc2f5effdd92e1bf49466fe8d2cd0490e6 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {
     tun_buffer_t* output_queue_back;
 } tap_win32_overlapped_t;
 
-static tap_win32_overlapped_t tap_overlapped;
-
 static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
 {
     tun_buffer_t* buffer = NULL;
@@ -605,6 +603,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
     } version;
     DWORD version_len;
     DWORD idThread;
+    tap_win32_overlapped_t *tap_overlapped = NULL;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -645,12 +644,14 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         return -1;
     }
 
-    tap_win32_overlapped_init(&tap_overlapped, handle);
+    tap_overlapped = g_new0(tap_win32_overlapped_t, 1);
+
+    tap_win32_overlapped_init(tap_overlapped, handle);
 
-    *phandle = &tap_overlapped;
+    *phandle = tap_overlapped;
 
     CreateThread(NULL, 0, tap_win32_thread_entry,
-                 (LPVOID)&tap_overlapped, 0, &idThread);
+                 (LPVOID)tap_overlapped, 0, &idThread);
     return 0;
 }
 
@@ -670,6 +671,9 @@ static void tap_cleanup(NetClientState *nc)
     /* FIXME: need to kill thread and close file handle:
        tap_win32_close(s);
     */
+
+   g_free(s->handle);
+   s->handle = NULL;
 }
 
 static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)

---
base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
change-id: 20250920-fix-win32-multiple-taps-ed16ccefbd17

Best regards,
-- 
Gal Horowitz <galush.horowitz@gmail.com>


