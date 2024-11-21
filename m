Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335C0D78782
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Lo-0001mS-Vq; Thu, 21 Nov 2024 10:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lm-0001f1-Gb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lk-00014F-QC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9q1CNlKLymBgniZFYob84WFjVbexMweRa9IPrPskeE=;
 b=PGymHdRGbFBuNlHnlWSHlzyMtaFCHWXcwKe8xhTefkvqlVA42KqihSg1phnw5JNo1K6i9Q
 OlcuN9/RnFUi50b0t1k1LHp580nYHUr/TJqKP7efWyPH6PVyTY30EsT+m9rELWTgJ6pEmR
 2Errp7QGLqfmVqESYhS14ktOi9/AkHI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-T5rf3vgaPIiNYp2diMcpWw-1; Thu,
 21 Nov 2024 10:44:04 -0500
X-MC-Unique: T5rf3vgaPIiNYp2diMcpWw-1
X-Mimecast-MFC-AGG-ID: T5rf3vgaPIiNYp2diMcpWw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBED3197731D; Thu, 21 Nov 2024 15:44:03 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F32AB1956086; Thu, 21 Nov 2024 15:43:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 15/18] tests/functional: rewrite console handling to be
 bytewise
Date: Thu, 21 Nov 2024 15:42:15 +0000
Message-ID: <20241121154218.1423005-16-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The console interaction that waits for predicted strings uses
readline(), and thus is only capable of waiting for strings
that are followed by a newline.

This is inconvenient when needing to match on some things,
particularly login prompts, or shell prompts, causing tests
to use time.sleep(...) instead, which is unreliable.

Switch to reading the console 1 byte at a time, comparing
against the success/failure messages until we see a match,
regardless of whether a newline is encountered.

The success/failure comparisons are done with the python bytes
type, rather than strings, to avoid the problem of needing to
decode partially received multibyte utf8 characters.

Heavily inspired by a patch proposed by Cédric, but written
again to work in bytes, rather than strings.

Co-developed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/cmd.py | 79 +++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index f6c4e4dda1..11c8334a7c 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -78,6 +78,54 @@ def run_cmd(args):
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
 
+# @test: functional test to fail if @failure is seen
+# @vm: the VM whose console to process
+# @success: a non-None string to look for
+# @failure: a string to look for that triggers test failure, or None
+#
+# Read up to 1 line of text from @vm, looking for @success
+# and optionally @failure.
+#
+# If @success or @failure are seen, immediately return True,
+# even if end of line is not yet seen. ie remainder of the
+# line is left unread.
+#
+# If end of line is seen, with neither @success or @failure
+# return False
+#
+# If @failure is seen, then mark @test as failed
+def _console_read_line_until_match(test, vm, success, failure):
+    msg = bytes([])
+    done = False
+    while True:
+        c = vm.console_socket.recv(1)
+        if c is None:
+            done = True
+            test.fail(
+                f"EOF in console, expected '{success}'")
+            break
+        msg += c
+
+        if success in msg:
+            done = True
+            break
+        if failure and failure in msg:
+            done = True
+            vm.console_socket.close()
+            test.fail(
+                f"'{failure}' found in console, expected '{success}'")
+
+        if c == b'\n':
+            break
+
+    console_logger = logging.getLogger('console')
+    try:
+        console_logger.debug(msg.decode().strip())
+    except:
+        console_logger.debug(msg)
+
+    return done
+
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
     assert not keep_sending or send_string
@@ -85,11 +133,22 @@ def _console_interaction(test, success_message, failure_message,
 
     if vm is None:
         vm = test.vm
-    console = vm.console_file
-    console_logger = logging.getLogger('console')
+
     test.log.debug(
         f"Console interaction: success_msg='{success_message}' " +
         f"failure_msg='{failure_message}' send_string='{send_string}'")
+
+    # We'll process console in bytes, to avoid having to
+    # deal with unicode decode errors from receiving
+    # partial utf8 byte sequences
+    success_message_b = None
+    if success_message is not None:
+        success_message_b = success_message.encode()
+
+    failure_message_b = None
+    if failure_message is not None:
+        failure_message_b = failure_message.encode()
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -102,20 +161,10 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        try:
-            msg = console.readline().decode().strip()
-        except UnicodeDecodeError:
-            msg = None
-        if not msg:
-            continue
-        console_logger.debug(msg)
-        if success_message in msg:
+        if _console_read_line_until_match(test, vm,
+                                          success_message_b,
+                                          failure_message_b):
             break
-        if failure_message and failure_message in msg:
-            console.close()
-            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
-                    (failure_message, success_message)
-            test.fail(fail)
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-- 
2.46.0


