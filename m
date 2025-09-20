Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7676CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07He-0004z3-9U; Sat, 20 Sep 2025 19:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HW-0004e7-VP
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HS-0006fY-DW
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so3863665e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411972; x=1759016772; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BMp08n4abJTiAjD0sjEHPnkehDOAKZyGVLvyGKxNOZc=;
 b=Vuo9R5WdbJbZDQaP8oajMnUufAi86F1bHX2wh/VxhZQWWTdHnRP5eMv8SeFc3s8VsD
 mc9JnFmW/isofgtYoQbWo5vR9HXdxNEi3AbYrBA6JaiFNyNDoVs0G9baojGqAayfodCv
 Ne19l1go2GDdIsiN+I8NspryNJZ4p0LUI5T0+3Er5S0yzFhptus1JJhECOoRWg7XXIIx
 Vh7SmluSnJSmmPXdcMKghHGVoy8mEUX0M/LjwJS3e7Bh3kVcgKEAjcq1hfljS/qag/gb
 hlrjItPOVD7fB4JzMW/52NNOTJdkkHlG8l/HebZqqwSqe3fWDOFPgr5622mQ+RxhzlF1
 RgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411972; x=1759016772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMp08n4abJTiAjD0sjEHPnkehDOAKZyGVLvyGKxNOZc=;
 b=iGeKuk4BrkNqjyPcmCJtDVMLThv+SRKlDykMks3y9IJ25he++6/dGHFtxq1divsNH3
 RMkwnHIlgzpYyNRw+Kj4ZU3uObMxYYnAzqUyJoeyJjx6qPTiozqIvWtId/xEHHxnHS1I
 qddRg3iaFCwnP0R/Qv2+ZLlZllzHYLIMqMhOFnsuPITFVeguosOru4x7iQe9itpRqL02
 j0NDMeYhTGsZWqyxVr/imNMna3VuxnfVGL9Kq0+UiWOEhrtRRubhnuoIc2E5aBnbcUv0
 fjXtBlEps9VwiwDuXMiKQqGe9fBisdFOzjqFNDRtkST2pXttoRy+2O6o9D/gNJo9uGdl
 EMDQ==
X-Gm-Message-State: AOJu0YxtUHZc96RgUHn12aWzlJ2V0Vdb63LyoiemfQu8XohT0PqVtID4
 9Q4piAo7vvM+0fKdlfkxX7OVympI2PwGHLkGkqjgpp8jGn6v6bFGOVJb
X-Gm-Gg: ASbGnctAz81Jh//7hwIgXQCD9XRarIt7p0RG4Vf6uUfv4AEsDsjCfkmilyTdE4hzt1Y
 eYQAU9VWW2wIy5Ljo9sgAojvhuOighYvY9wcXNwIouhb7e78aGZbH0feXpXmvwIyMSqsAgllraR
 Owx7eoPxmQZoJRxR6V+ABIRripvOCNyYIG2/seNdSp4HpPMzn9TJjCTeqofSKVCXDgsKI8+qtKX
 JeOc+GC/oeFMZN2XafPJaL9ZSSvh7b8ZHTeuej++2XmRDfjfoqgWzx5Yig3XN4d/ZfhyiQKga9C
 iaf2GIdliAw+IaFpK7m2/NCc+jtlrU2qNEaBZCpSKnJltcnxRVwrgd2SYZU6/2TW676Gh44TYA1
 sKrth+JFMNLngylmgzfeoDOylEeSlEHN1QVZhPJnIHujyayLcIR74
X-Google-Smtp-Source: AGHT+IH0zRGTf7Y2yLFq8KXzRxFRBLq4OIbAAJKAo0EESDe7a/kjYf/jOBYV21HDsewjo8FxWQmdTA==
X-Received: by 2002:a05:600c:3114:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-467ead6871cmr63453685e9.18.1758411972532; 
 Sat, 20 Sep 2025 16:46:12 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3ee106fd0edsm13179826f8f.53.2025.09.20.16.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:11 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:35 +0200
Subject: [PATCH RFC v5 05/12] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-5-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=3415;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=x7H0XeeMERCwGAq1s4DtG6vInlpV+u3ZG4ViaEkuoc8=;
 b=S3znN99YbliXaObW5hKA8sH6Fgow5U9eWJSmH1m9Cp+aPdkgo4PiEhOLMZj3s6WBG1RbqFBni
 x9v20Ipfl2AA7s3rQtPT9cxMA2WD668nFF69fcmzQqcRuq7vOgMM1Uu
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
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


