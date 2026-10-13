Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C24CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcU2-0001LE-FN; Tue, 13 Oct 2026 09:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTx-0001It-QV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTw-0004ft-4Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5zuTHs6baNn4pyUyGIitIf6dGLBEwDZSUc+JOew418=;
 b=TEzVgaR511GF78K45yZGBCCD8RPx8AWBdfmrzM63gt6vbsvb61gAbnwT96pXVZRDT9qvUg
 3l6e0QpKqjvVK2rYnBqFMVN8NVe21QTK+WRDD5gyxqQsxjdzH36JJSzDrHGeu463VV9wAz
 Fmp1Zn0vLTNvC4bpGQNxh7CdsK4YsVo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-o_dRkpbPOR6xJmpCAkREmA-1; Tue,
 13 Oct 2026 13:23:44 +0000
X-MC-Unique: o_dRkpbPOR6xJmpCAkREmA-1
X-Mimecast-MFC-AGG-ID: o_dRkpbPOR6xJmpCAkREmA_1791897823
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B7CF185BE97; Tue, 13 Oct 2026 13:23:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3268D18002B7; Tue, 13 Oct 2026 13:23:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:03 +0400
Subject: [GIT PULL 06/40] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-6-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IzdTT8k3evv3IwVBDgOwepdgCM3rG+BRfLxQmUojjsU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDChZgLO7WQWF9HYwOXDqt5Fz1ok7BAbpj2J
 uJtg9Nde7WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5V5BD/9gdW/a54Canf06YP9piD6wQvU3SaUByPWRrV2acKrDruKZCLqdRQ1GkUo6QX8fC/Aq9hW
 tHTWnkpEfgCC879KhlRvtrGE12En+8C4RA4UDmNBVyCvnNK708UKrRbVRBXv1Vpk9mO/DjYhe/Q
 GQIldhCfwi5MOVuQUSIJYr2JaI0l2+irt2bvTzT2/pKIpkSV/oA5z5B4sH9+GNzvvnTaCcxCTIG
 IdLHRNeuAsasYkEiCS/bU1TJVtcxqgtCXsideuWhOcHJyT36TicyYwjM6J1SKojzQ0M/ozVPKGM
 dH4SOr+W/RcUAoOgLV1sedZlCH2KiRpFJ9+T4JzGosTZIZAgsbyeQGYhVrww4jDGUxYxl1tooQN
 45DXaWJ7/jk0WWHNMC2Y6pCb0YPdNeCVK3y2tdlvyOx86ymJoTNUWTg3/pgM+L08rmspu4iZVzl
 gpbSPZUiHjQ71c31b3yhfD7f9yDzYR1xBExGuUHtL/1nmeWwilJFLQPg3esh4gIddn+0/r7Dxg3
 2FzBf4TnEOaeRAfum7IkjCNdP71Qvq2WsdHPrMSJokVsllqS66kCKsOt2jUqpZH5ZrFtr6VAUxm
 1DVu6LjBndTDeKyep7+5ivmArQ3PyC2wYv+RPdNbXuIkzkDqRbZPUYvJaCCc1WQnfzkV0yQNFi2
 UB4yUuxLABCDltA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

Block SIGWINCH, so it is delivered only via signalfd.
Install a handler that uses NotifierList to tell
interested parties about SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: add sigwinch_remove_notifier, call it in curses_cleanup]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-5-2c3b10d829b3@gmail.com>
---
 include/qemu/main-loop.h |  5 +++++
 ui/curses.c              | 21 +++++++++++++++------
 util/main-loop.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 8c1241a2c11c..533d4c2be413 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -449,4 +449,9 @@ typedef struct MainLoopPoll {
 void main_loop_poll_add_notifier(Notifier *notify);
 void main_loop_poll_remove_notifier(Notifier *notify);
 
+#ifndef _WIN32
+void sigwinch_add_notifier(Notifier *n);
+void sigwinch_remove_notifier(Notifier *n);
+#endif
+
 #endif
diff --git a/ui/curses.c b/ui/curses.c
index 4db32b6168d6..9079bfbee469 100644
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
@@ -172,21 +173,28 @@ static void curses_winch_check(void)
     invalidate = 1;
 }
 
-static void curses_winch_handler(int signum)
+static void curses_winch_handler(Notifier *n, void *data)
 {
     got_sigwinch = true;
 }
 
+static Notifier winch_notifier = {
+    .notify = curses_winch_handler
+};
+
 static void curses_winch_init(void)
 {
-    struct sigaction old, winch = {
-        .sa_handler  = curses_winch_handler,
-    };
-    sigaction(SIGWINCH, &winch, &old);
+    sigwinch_add_notifier(&winch_notifier);
+}
+
+static void curses_winch_cleanup(void)
+{
+    sigwinch_remove_notifier(&winch_notifier);
 }
 #else
 static void curses_winch_check(void) {}
 static void curses_winch_init(void) {}
+static void curses_winch_cleanup(void) {}
 #endif
 
 static void curses_cursor_position(DisplayChangeListener *dcl,
@@ -417,6 +425,7 @@ static void curses_cleanup(void)
         return;
     }
 
+    curses_winch_cleanup();
     endwin();
     qemu_console_unregister_listener(dcl);
     g_clear_pointer(&dcl, g_free);
diff --git a/util/main-loop.c b/util/main-loop.c
index 65e5dbcc941b..e59af0e270e4 100644
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
@@ -124,6 +125,38 @@ static int qemu_signal_init(Error **errp)
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
+void sigwinch_remove_notifier(Notifier *n)
+{
+    notifier_remove(n);
+
+    if (notifier_list_empty(&sigwinch_notifiers)) {
+        struct sigaction action = {
+            .sa_handler = SIG_DFL,
+        };
+        sigaction(SIGWINCH, &action, NULL);
+    }
+}
+
 #else /* _WIN32 */
 
 static int qemu_signal_init(Error **errp)

-- 
2.56.0.116.g6de20f6092dc


