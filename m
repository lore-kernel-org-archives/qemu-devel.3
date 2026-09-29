Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C04CA5FB1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasl-00058W-4e; Tue, 29 Sep 2026 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBash-00057N-78
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:40 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasf-0006MT-At
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:38 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so35924165e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700036; x=1791304836; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dBwnFanueDtb+QItNjZPWm5x6yrITqXYwMZ8MKnQNfo=;
 b=hXl7Dg/q06HR3J241vqRVYTVVdOUTYs15Em0huW7GZ2FwIo+cNQnCf5ZJMLRsbNFo1
 B8ezgiYh/6VEMGQMtCd2XefRHUIzHD9GPWEGfqVCSKvUjH6Bj8lbaXnduK0XcaYPl3MT
 wWIgB1h2sotBRulHC+skwd+Hug8ymBcQNCE0Hvkuo+lAhut2DJVHXmt0RRG4sYLR5BTf
 gO1S1mjCr70wVTXQWwo1H23+wXSFaDVq9DL0hxL28twZeP6pBfoOc6p727XGAVYBrcfZ
 XUvTgrX2/cVlqAFQLgdxrHDJNpwT7QauLFB3GH38cu/sQ0O5s+I33WxSoIXvLROBrc2U
 X+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700036; x=1791304836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dBwnFanueDtb+QItNjZPWm5x6yrITqXYwMZ8MKnQNfo=;
 b=J8vcdsTOrSNXOQppSebVwwOm6Gtjcdt7nBdS6Lvm9m5rQxw2k9re4A0GkROKMwxC11
 H/qES4RgryoGukrTFtJ9l3ktrpJvLqbNBpY2pq33/8Om7vLkTj4OpEbSR0GgjW+g8ly5
 WCvwYoKVhVYd+g4XKt0THm3MNWfystOfVkyYunWyQe3lgpyOkg/fr5a2JRA8NVDWa3tr
 xwjJV6MKeGb2PiNWEm9x6N7ALbdKl9CLGSKcfLU4yZcaiV5Ie6yTHP5kVWJ06e0jPbza
 lAaNiDl7crIQZulqebSeJx0A++hMX+GB7u2ryzUCzyce12/+Te1eUhEfxAOwyGUeTsoA
 mvAQ==
X-Gm-Message-State: AFuF++lPNOnYG/loPdNUysCLnbkC0c+4A7B5r9M54MHddOJU/p0V8Q49
 zuLRAMG1UTLBZputYXq6FS9Vt02pzgrbMeKq+jC6Qn/yF1OVRaAz7Ob+
X-Gm-Gg: AYBFou1sucagGgp+c9+qb973C+Uyzg3qNUx/26uKHBlMEl2k99ynIdJ8EFNclw9Lkd6
 XJVFlB7edXyidFo2vuBN6uxaoGTeMAA2SVaJd8if0HtazXX19vOIQzaLA5MQfLWM6bfM7X5iEaz
 FSJSpidK5mOBQsELTdfdw5pXwCbK304MoXAn09NHWNrbttADAYQ1rqtAJ1nkzBCXskrFt4e6niJ
 hpg0g8cK6RkwBWYqsyOpD7WwaWop+uGEIkAOr6TWW0Ei5vqyw6SF+lAl9fgBHFNokJBzF3BHTZs
 NmoOHoiiUng4cHkweiZ+7GVPSaBOjOBYTCCDMtyaXb3opbQsY8smcdqwVdiggGEIJ4cYqeJQ1C0
 4cPL29EphT4iLVBYbi8pDFpziRRV7oilhBUiiJVkoqEZNEuois9bL8yp1cnc3IDNFHLhw/w9TAO
 Q//DO3epA6DsOfIeYhqWtnfvjWY2+NHX6S7UuI7E2wpHe7bSbND+XVEsDUhSyBOVq2CQkfQywzl
 fffL63QCKdeQcgXJnpJhhMRiabS
X-Received: by 2002:a05:600c:8a0c:10b0:4a0:62d:4424 with SMTP id
 5b1f17b1804b1-4a0062d4712mr75257965e9.8.1790700035788; 
 Tue, 29 Sep 2026 09:40:35 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013d3c85fsm6578805e9.4.2026.09.29.09.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:35 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:33 +0200
Subject: [PATCH v8 05/12] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-5-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
In-Reply-To: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=3291;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=8/mXswQFwyFusVK5OVQJSrjJSZwOL/1OBUtr2Ho2tlw=;
 b=IZWfKdgBzvj5qj3jf3uRcpkKoc5LAT7DQHJSBqjDjBhTtC/5UfxwHfnZZgBJtCiTlxsW5e//5
 +uMxCGHn7ltA+V/wKguUzuYdxAFzE8UBMv9d+n/FjL5qHYTJH815iHH
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x10.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

Block SIGWINCH, so it is delivered only via signalfd.
Install a handler that uses NotifierList to tell
interested parties about SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 include/qemu/main-loop.h |  4 ++++
 ui/curses.c              | 11 ++++++-----
 util/main-loop.c         | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 8c1241a2c1..ff41346b0b 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -449,4 +449,8 @@ typedef struct MainLoopPoll {
 void main_loop_poll_add_notifier(Notifier *notify);
 void main_loop_poll_remove_notifier(Notifier *notify);
 
+#ifndef _WIN32
+void sigwinch_add_notifier(Notifier *n);
+#endif
+
 #endif
diff --git a/ui/curses.c b/ui/curses.c
index 4db32b6168..ced5fd1216 100644
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
index 65e5dbcc94..d867b30389 100644
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
@@ -124,6 +125,26 @@ static int qemu_signal_init(Error **errp)
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
2.55.0


