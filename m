Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73650C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 18:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVDQT-0005cU-C0; Fri, 27 Jun 2025 14:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVDQP-0005av-S3
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:03:45 -0400
Received: from che.mayfirst.org ([2001:470:1:116::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVDQM-0006kV-Tc
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:03:45 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; s=2019;
 t=1751047420; h=from : to : cc : subject : date : message-id :
 mime-version : content-transfer-encoding : from;
 bh=YC0JwlsNMTtvx1kttMqBE+p9QGUV2YD78aqRMGVIo84=;
 b=3mzPT7NqSNQIA/e85OIxcCiWfAufpop1LD7mt91NnwrTccD4nCzLfRT4nZf0juKCI//53
 /usiPQoBEe5bjZmBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net;
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1751047420; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=YC0JwlsNMTtvx1kttMqBE+p9QGUV2YD78aqRMGVIo84=;
 b=RLzm5qxVETickh28vIM1ne4OsrzJN9OxjgWn9ny/aJyIveP2T5qC44rvJYU7v19dIDqkk
 GuOEHlk1/jaEUEBB8MfnaJwrrUviAyoAWQx0OQ9czDU67nrzfgKMNgQoHGxlZExOAt1sZl9
 rN5oQ9ZcDnAhcV1A1036wY38Mp6H6zk2n9Cz+cjRTba5bHkKQP4pdXvDUVSMj6dIxaLIe3Z
 t2uUeRhRjQH5X7xlCfm957jQH56QfakoUtjaT7P2zphjFzJl7G2d624NIpfyBw38KaJT7sk
 5ykAOKa1Zk9/Z3GL0r0o3oK7TwP/cJOMyGptp7oojIalIcvjAdqqpNcDRG/A==
Received: from fifthhorseman.net (lair.fifthhorseman.net [108.58.6.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by che.mayfirst.org (Postfix) with ESMTPSA id 55A9DF9B3;
 Fri, 27 Jun 2025 14:03:40 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
 id 67B8213F6B3; Fri, 27 Jun 2025 14:03:31 -0400 (EDT)
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: qemu-devel@nongnu.org
Cc: dkg@fifthhorseman.net
Subject: [PATCH 1/3] Socket Activation: stash $LISTEN_FDNAMES
Date: Fri, 27 Jun 2025 14:03:29 -0400
Message-ID: <20250627180331.1370235-1-dkg@fifthhorseman.net>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:470:1:116::7;
 envelope-from=dkg@fifthhorseman.net; helo=che.mayfirst.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

By recording a copy of LISTEN_FDNAMES, we make it possible to learn
mappings from file descriptor labels (e.g., as set by
FileDescriptorName= in systemd.socket(5)).

This also makes it possible to invoke check_socket_activation() more
than once and have it return the same value each time.

This is one step toward addressing
https://gitlab.com/qemu-project/qemu/-/issues/3011

Since we can't count on the buffer returned from getenv
persisting (getenv is documented as non-re-entrant), we need to keep a
copy of it around in case multiple subsystems want to interrogate it.

This proposed implementation uses a static buffer, and breaks socket
activation with a visible error_report if LISTEN_FDNAMES is too large.
Another approach would be to g_strdup the value returned by getenv,
which would have failure modes on heap exhaustion, and would introduce
a memory leak as there's no clear opportunity to g_free the copy.

Signed-off-by: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
---
 util/systemd.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/util/systemd.c b/util/systemd.c
index ced518f771..1eca2bd69f 100644
--- a/util/systemd.c
+++ b/util/systemd.c
@@ -16,37 +16,62 @@
 #include "qemu/error-report.h"
 
 #ifndef _WIN32
+static char fdnames[256];
+
 unsigned int check_socket_activation(void)
 {
+    static unsigned int nr_fds = -1;
     const char *s;
     unsigned long pid;
-    unsigned long nr_fds;
+    unsigned long nr_fdsl;
     unsigned int i;
     int fd;
     int f;
     int err;
 
+    if (nr_fds != -1) {
+        return nr_fds;
+    }
     s = getenv("LISTEN_PID");
     if (s == NULL) {
+        nr_fds = 0;
         return 0;
     }
     err = qemu_strtoul(s, NULL, 10, &pid);
     if (err) {
+        nr_fds = 0;
         return 0;
     }
     if (pid != getpid()) {
+        nr_fds = 0;
         return 0;
     }
 
     s = getenv("LISTEN_FDS");
     if (s == NULL) {
+        nr_fds = 0;
         return 0;
     }
-    err = qemu_strtoul(s, NULL, 10, &nr_fds);
+    err = qemu_strtoul(s, NULL, 10, &nr_fdsl);
     if (err) {
+        nr_fds = 0;
         return 0;
     }
-    assert(nr_fds <= UINT_MAX);
+    assert(nr_fdsl <= UINT_MAX);
+    nr_fds = (unsigned int) nr_fdsl;
+    s = getenv("LISTEN_FDNAMES");
+    if (s != NULL) {
+        size_t fdnames_len = strlen(s);
+        if (fdnames_len + 1 > sizeof(fdnames)) {
+            error_report("LISTEN_FDNAMES is larger than %ldu bytes, "
+                         "ignoring socket activation.",
+                         sizeof(fdnames));
+            nr_fds = 0;
+            return 0;
+        } else {
+            memcpy(fdnames, s, fdnames_len + 1);
+        }
+    }
 
     /* So these are not passed to any child processes we might start. */
     unsetenv("LISTEN_FDS");
@@ -69,7 +94,7 @@ unsigned int check_socket_activation(void)
         }
     }
 
-    return (unsigned int) nr_fds;
+    return nr_fds;
 }
 
 #else /* !_WIN32 */
-- 
2.47.2


