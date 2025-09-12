Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6502CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuh8-00072Y-Ni; Thu, 11 Sep 2025 23:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh1-00070T-QA
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugo-0007vj-Kr
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45dfb8e986aso14958925e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648586; x=1758253386; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BMp08n4abJTiAjD0sjEHPnkehDOAKZyGVLvyGKxNOZc=;
 b=G4iQuM3gXeGe0cOTWkUvxBWzJcYG0EEDJgRWptEGVsn66gIFmKxTBnYMVlvPbkG0re
 6dWPMYue3E8TUNQ1xgAwMDyg3N7eY57Nv7kfvlAo8duAcZBP5p1jAM5xFom9RXqfynKP
 vFD9cHv39D9RFPmrv2BAzZkeI6dZ9CaYPVLn+lBY0YMMrHjeVLhSCB8Yjg1srDHsmW73
 WEg++w33/bIx2d1f+zFTOqAYk0iyhMFv223Q5kUDrTxEfrQkkPZhH6JyZe/V0yYYNZav
 8lLUnH1cKWdWA/Qd1jTExiBGohAN66Y/+c8Q0AuFLvQ0AKZ3FNge7fC4WgVaAOqQa8l9
 4Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648586; x=1758253386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMp08n4abJTiAjD0sjEHPnkehDOAKZyGVLvyGKxNOZc=;
 b=beLxGUa6dKzGp5W/N0YT1+etVM4Psg4hkuNUa6zyuG3OpdMEJyiYMMDoYyV4GVhS4H
 tbEgIQptPEkV8z3424DDH8FoFkGMmO7b8f2AkdbtYiNIuv06h9ErwitgmczreT857mR3
 KURlXG8tFbYQefKMvTRkWi2uDcFkIizI5B53D/nDoEmINHYycKn6T8W4yLz+x+F8ys6Y
 S48mqRduGtxRB82Ez/AMU65RZrRMUr4X0MdhjzWH9K813Z941qydAk21m5MBs2QudbAo
 D1D2UrG2ya45cWeNceJYQv/iKRP3x6ttKImPaBtkmpzTZbviakdgU60X5QAmkpLVqwhQ
 JQCw==
X-Gm-Message-State: AOJu0Ywqve0fmaPn1v5EPtN+L5OkJkZ9ZxD4ZNYyyNeK+aqLEqQaQhfp
 ZeJSORoGL8xOVseAj7vlhCOlWiH/1/TkuC+XYHH/4TBTv/ACTBU2GoUF
X-Gm-Gg: ASbGncsOI3fMCcRd9vUSl5GuJV/iu4pJ+Nc83PQeDOSIFSHK/0CM0zTWCBu9z8uT3BU
 TVEpfMh4b+hukgQ2LgKEdHG7ePbM+VgBHWaMow8sIfyaf/pVV1GnjVoKehHS+lUYZDUZ+wknTbJ
 PXfikJP8Rekh9OCSa2v5Q/9hs1rS9Z3OPFyr8mUTUkyATgtoPPnS93mdeoAkUIftL0FCRDPkhxr
 4FS5ShA0NDM3ZrsFO9jYH74PCgI5wEjtvE3UbpGrTFg4nIQxNIbGMxM2VDoAtmsQeP9GmGaxJLa
 /lPmZ9hiNCkxKtQVlLHao3PZRFAOM5o0cCQiWmutmE0yVglnKkn1SYKzC9ItglDiAy+Z1elrHKA
 2YaAoxIEpGl0eX6wbEyV+18bWlS3kG191PxtinuW0buAJLMqiBGjmBu5c+ABtcCg=
X-Google-Smtp-Source: AGHT+IEp/0M8SiiD7QfqsDNFl5TjJGZlN9sw6L8PaaY1cYNH+uAjbc3ujdRvI5CaVRmm8iRtAnKp0w==
X-Received: by 2002:a05:6000:1a86:b0:3e7:46f1:dfcb with SMTP id
 ffacd0b85a97d-3e7657929a5mr1453061f8f.26.1757648586049; 
 Thu, 11 Sep 2025 20:43:06 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45e03729c76sm46199205e9.6.2025.09.11.20.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:05 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:50 +0200
Subject: [PATCH v4 05/10] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-5-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648577; l=3415;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=x7H0XeeMERCwGAq1s4DtG6vInlpV+u3ZG4ViaEkuoc8=;
 b=C5ow/Nv/1ml2Ys0+8l4uqOWX7RhXx9T6oezmSRiuSuLt4pubVNTswWhR4XSjVoFJNLItw9gPq
 zoezWn1ODqDBerO3G57ywsQqaJStztivNd4ylzhd98iyjtDBjVAlRGy
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Szymon Lukasz <noh4hss@gmail.com>

Block SIGWINCH, so it is delivered only via signalfd.
Install a handler that uses NotifierList to tell
interested parties about SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 include/qemu/main-loop.h |  4 ++++
 ui/curses.c              | 11 ++++++-----
 util/main-loop.c         | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 4e2436b1968b5c513f7d4e84e010b0d4fb31a1b1..7cc45c3a274434020fe33b1ca0a4d839de994e97 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -431,4 +431,8 @@ typedef struct MainLoopPoll {
 void main_loop_poll_add_notifier(Notifier *notify);
 void main_loop_poll_remove_notifier(Notifier *notify);
 
+#ifndef _WIN32
+void sigwinch_add_notifier(Notifier *n);
+#endif
+
 #endif
diff --git a/ui/curses.c b/ui/curses.c
index 161f78c35c32fc03ad576d2bd8e91bdfe09b265d..d1b308d5f8051e99f12f4d32435a04e294060a10 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -33,6 +33,7 @@
 #include <iconv.h>
 
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -149,7 +150,7 @@ static void curses_resize(DisplayChangeListener *dcl,
 }
 
 #if !defined(_WIN32) && defined(SIGWINCH) && defined(KEY_RESIZE)
-static volatile sig_atomic_t got_sigwinch;
+static bool got_sigwinch;
 static void curses_winch_check(void)
 {
     struct winsize {
@@ -172,17 +173,17 @@ static void curses_winch_check(void)
     invalidate = 1;
 }
 
-static void curses_winch_handler(int signum)
+static void curses_winch_handler(Notifier *n, void *data)
 {
     got_sigwinch = true;
 }
 
 static void curses_winch_init(void)
 {
-    struct sigaction old, winch = {
-        .sa_handler  = curses_winch_handler,
+    static Notifier n = {
+        .notify = curses_winch_handler
     };
-    sigaction(SIGWINCH, &winch, &old);
+    sigwinch_add_notifier(&n);
 }
 #else
 static void curses_winch_check(void) {}
diff --git a/util/main-loop.c b/util/main-loop.c
index 51aeb2432e77eae7081c6945e21812acc71b5f37..db4bb9c88dade805bc98322c1a053c65e9e97f7e 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -100,6 +100,7 @@ static int qemu_signal_init(Error **errp)
     sigaddset(&set, SIGIO);
     sigaddset(&set, SIGALRM);
     sigaddset(&set, SIGBUS);
+    sigaddset(&set, SIGWINCH);
     /* SIGINT cannot be handled via signalfd, so that ^C can be used
      * to interrupt QEMU when it is being run under gdb.  SIGHUP and
      * SIGTERM are also handled asynchronously, even though it is not
@@ -121,6 +122,26 @@ static int qemu_signal_init(Error **errp)
     return 0;
 }
 
+static NotifierList sigwinch_notifiers =
+    NOTIFIER_LIST_INITIALIZER(sigwinch_notifiers);
+
+static void sigwinch_handler(int signum)
+{
+    notifier_list_notify(&sigwinch_notifiers, NULL);
+}
+
+void sigwinch_add_notifier(Notifier *n)
+{
+    if (notifier_list_empty(&sigwinch_notifiers)) {
+        struct sigaction action = {
+            .sa_handler = sigwinch_handler,
+        };
+        sigaction(SIGWINCH, &action, NULL);
+    }
+
+    notifier_list_add(&sigwinch_notifiers, n);
+}
+
 #else /* _WIN32 */
 
 static int qemu_signal_init(Error **errp)

-- 
2.51.0


