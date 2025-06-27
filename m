Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F27DC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 18:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVDQQ-0005bC-CE; Fri, 27 Jun 2025 14:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVDQO-0005Zv-Hn
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:03:44 -0400
Received: from che.mayfirst.org ([162.247.75.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uVDQM-0006kU-Hn
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:03:44 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; s=2019;
 t=1751047420; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=dynow+ibnkbDlpWO3xp9SEdYoeWiYC+RVdASpIyqFho=;
 b=btMpreM/gr9OIomkLmY5Zw/d/02NZQqgbbbX1uobDWt4Q7OWSunDiHO9k4XoL/o153htM
 uNMPEPD3OUAaGjCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net;
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1751047420; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=dynow+ibnkbDlpWO3xp9SEdYoeWiYC+RVdASpIyqFho=;
 b=hVpJobVG4NmDUwXhWLy4CKT4QtkUXOekn4370Vk0tPWe6/JQmdVJXfT0LU11t00Wl4rOB
 dOQjee7acYZ+XPjuf006qGpYSQdYd8Vmtrsf98qqViuoCr61CGZQ4yFoMUPmmXU0p9DjoOP
 fXgUuce9iE7RXZrrwOwuYSiWi+gWM7VF8t1jFX3z6iDdXlfh1uiau9QAziRnA7k6ffUbuyI
 LQnBzSbumBxb7s5cMtXXPyA3iWQU4vVWCwSsur+ibhw1QiaSPPWnWeZARmQtGXcStdqXaWa
 ipyelZX8umcqQam0OJ+ob1FEt0aEfvzWPZOnLaFS/Ie9PNZy/p2nYH4QUBmg==
Received: from fifthhorseman.net (lair.fifthhorseman.net [108.58.6.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by che.mayfirst.org (Postfix) with ESMTPSA id 414FEF9B1;
 Fri, 27 Jun 2025 14:03:40 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
 id 6CBA913F6BF; Fri, 27 Jun 2025 14:03:31 -0400 (EDT)
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: qemu-devel@nongnu.org
Cc: dkg@fifthhorseman.net
Subject: [PATCH 3/3] Socket activation: enable spice listener.
Date: Fri, 27 Jun 2025 14:03:31 -0400
Message-ID: <20250627180331.1370235-3-dkg@fifthhorseman.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627180331.1370235-1-dkg@fifthhorseman.net>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.247.75.118;
 envelope-from=dkg@fifthhorseman.net; helo=che.mayfirst.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Enable qemu to be socket-activated based on a spice connection.

Note that this depends on un-deprecating
spice_server_set_listen_socket_fd, see
https://gitlab.freedesktop.org/spice/spice/-/merge_requests/240

This partially addresses
https://gitlab.com/qemu-project/qemu/-/issues/3011

Signed-off-by: Daniel Kahn Gillmor <dkg@fifthhorseman.net>

More fixup for spice systemd socket activation
---
 qemu-options.hx |  7 +++++--
 ui/spice-core.c | 47 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a6..d17c5bc5ff 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2270,6 +2270,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,x509-cert-file=<file>][,x509-cacert-file=<file>]\n"
     "       [,x509-dh-key-file=<file>][,addr=addr]\n"
     "       [,ipv4=on|off][,ipv6=on|off][,unix=on|off]\n"
+    "       [,socket-activated=<str>]\n"
     "       [,tls-ciphers=<list>]\n"
     "       [,tls-channel=[main|display|cursor|inputs|record|playback]]\n"
     "       [,plaintext-channel=[main|display|cursor|inputs|record|playback]]\n"
@@ -2297,8 +2298,10 @@ SRST
         Set the IP address spice is listening on. Default is any
         address.
 
-    ``ipv4=on|off``; \ ``ipv6=on|off``; \ ``unix=on|off``
-        Force using the specified IP version.
+    ``ipv4=on|off``; \ ``ipv6=on|off``; \ ``unix=on|off`` ; \ ``socket-activated=<str>``
+        Force using the specified IP version.  Or, use a unix-domain socket.
+        Or, listen using the passed file descriptor from systemd-style socket
+        activation associated with FileDescriptorName ``str``.
 
     ``password-secret=<secret-id>``
         Set the ID of the ``secret`` object containing the password
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 0326c63bec..1f817142f0 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -38,6 +38,7 @@
 #include "migration/misc.h"
 #include "hw/pci/pci_bus.h"
 #include "ui/spice-display.h"
+#include "qemu/systemd.h"
 
 /* core bits */
 
@@ -433,6 +434,9 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "unix",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "socket-activated",
+            .type = QEMU_OPT_STRING,
 #endif
         },{
             .name = "password-secret",
@@ -736,18 +740,37 @@ static void qemu_spice_init(void)
     }
 
     spice_server = spice_server_new();
-    spice_server_set_addr(spice_server, addr ? addr : "", addr_flags);
-    if (port) {
-        spice_server_set_port(spice_server, port);
-    }
-    if (tls_port) {
-        spice_server_set_tls(spice_server, tls_port,
-                             x509_cacert_file,
-                             x509_cert_file,
-                             x509_key_file,
-                             x509_key_password,
-                             x509_dh_file,
-                             tls_ciphers);
+    str = qemu_opt_get(opts, "socket-activated");
+    if (str) {
+        int fd = socket_activated_fd_by_label(str);
+        if (fd == -1) {
+            error_report("socket-activated spice failed: No FD found with label '%s'",
+                         str);
+            exit(1);
+        }
+
+        if (addr || addr_flags) {
+            error_report("When spice is socket-activated, do not set addr or ipv4 or ipv6 or unix");
+            exit(1);
+        }
+        if (spice_server_set_listen_socket_fd(spice_server, fd) == -1) {
+            error_report("spice_server_set_listen_socket_fd failed!");
+            exit(1);
+        }
+    } else {
+        spice_server_set_addr(spice_server, addr ? addr : "", addr_flags);
+        if (port) {
+            spice_server_set_port(spice_server, port);
+        }
+        if (tls_port) {
+            spice_server_set_tls(spice_server, tls_port,
+                                 x509_cacert_file,
+                                 x509_cert_file,
+                                 x509_key_file,
+                                 x509_key_password,
+                                 x509_dh_file,
+                                 tls_ciphers);
+        }
     }
     if (password) {
         qemu_spice.set_passwd(password, false, false);
-- 
2.47.2


