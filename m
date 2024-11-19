Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDC2D44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDPo5-0006Bu-Mp; Tue, 19 Nov 2024 10:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnu-00063d-1F
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPns-0003m8-9p
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732028767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqtmXPrHCd5t584qGNMT8PaUQPkcPG7TWxttjVlkJI0=;
 b=iYSThqGhjsZPuTqcCLYht0ckSDD9u2kNhZxpTJnjfTzf1F0rvxbzYF3tD2RRHVsruJlBh4
 6sN8eVYvvMyvIIQgEWfIs/7m1ZOSKrXg4yez9qkKkHhQhuWWvXe+qIi+h1+aLoRkJJq0j3
 F1EPRHFFfCkHuTY8xOhe6ayjHetu8es=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-t34iqQQtMB2ye5UH5gVCzA-1; Tue,
 19 Nov 2024 10:06:04 -0500
X-MC-Unique: t34iqQQtMB2ye5UH5gVCzA-1
X-Mimecast-MFC-AGG-ID: t34iqQQtMB2ye5UH5gVCzA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723EC1953942; Tue, 19 Nov 2024 15:06:03 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35ACE195DF81; Tue, 19 Nov 2024 15:05:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 13/15] tests/functional: rewrite console handling to be
 bytewise
Date: Tue, 19 Nov 2024 15:05:17 +0000
Message-ID: <20241119150519.1123365-14-berrange@redhat.com>
In-Reply-To: <20241119150519.1123365-1-berrange@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 tests/functional/qemu_test/cmd.py | 63 +++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 76a48064cd..91267a087f 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -78,15 +78,58 @@ def run_cmd(args):
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
 
+def _console_readline(test, vm, success, failure):
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
+        if success is None or success in msg:
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
     if vm is None:
         vm = test.vm
-    console = vm.console_file
-    console_logger = logging.getLogger('console')
+
     test.log.debug(f"Console interaction success:'{success_message}' " +
                    f"failure:'{failure_message}' send:'{send_string}'")
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
@@ -99,20 +142,10 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        try:
-            msg = console.readline().decode().strip()
-        except UnicodeDecodeError:
-            msg = None
-        if not msg:
-            continue
-        console_logger.debug(msg)
-        if success_message is None or success_message in msg:
+        if _console_readline(test, vm,
+                             success_message_b,
+                             failure_message_b):
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


