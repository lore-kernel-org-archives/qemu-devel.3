Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C17D65C47
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 13:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVrRF-00047p-Ub; Wed, 17 Dec 2025 08:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vVrRC-00047b-4Q
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 08:19:32 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vVrR7-0000HN-Qp
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 08:19:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A16B5175C38
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 16:18:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2FEC9338234;
 Wed, 17 Dec 2025 16:19:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] implement systemd startup notification for qemu-system
Date: Wed, 17 Dec 2025 16:19:09 +0300
Message-ID: <20251217131909.3713900-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If $NOTIFY_SOCKET environment variable is present and its
value starts with / or @ and fits in struct sockaddr_unix,
use it to send READY=1 message to a session manager like
systemd.  This allows qemu to be used in a systemd Type=notify
service.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 os-posix.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/os-posix.c b/os-posix.c
index 52925c23d3..ab27252115 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -282,6 +282,41 @@ void os_setup_limits(void)
     }
 }
 
+static void sd_notify_ready(void)
+{
+#ifdef CONFIG_LINUX
+    static const char message[] = "READY=1";
+    static const char sock_env[] = "NOTIFY_SOCKET";
+
+    struct sockaddr_un sun;
+    int sock;
+    const char *sock_path;
+
+    sock_path = getenv(sock_env);
+    if (!sock_path ||
+        (*sock_path != '/' && *sock_path != '@') ||
+        strlen(sock_path) >= sizeof(sun.sun_path)) {
+        return;
+    }
+
+    memset(&sun, 0, sizeof(sun));
+    sun.sun_family = AF_UNIX;
+    strcpy(sun.sun_path, sock_path);
+    if (*sock_path == '@') {
+        sun.sun_path[0] = '\0';
+    }
+
+    sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+    if (sock >= 0) {
+        /* ignore errors */
+        sendto(sock, message, sizeof(message) - 1, 0,
+               (struct sockaddr *)&sun, sizeof(sun));
+        close(sock);
+    }
+    unsetenv(sock_env);
+#endif
+}
+
 void os_setup_post(void)
 {
     int fd = 0;
@@ -297,6 +332,7 @@ void os_setup_post(void)
         }
     }
 
+    sd_notify_ready();
     change_root();
     change_process_uid();
 
-- 
2.47.3


