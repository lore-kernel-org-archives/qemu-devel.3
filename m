Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FADDCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvym8-0000sv-7w; Tue, 09 Sep 2025 09:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvym2-0000rR-9D
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylx-0005J8-NS
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlAyXNhOFlV4rr059WvWve0poZ7dKneQ4EeRIY/5H/A=;
 b=giKALA8xYdjExSqP3K17C82KHmji+z4YjFnwMJGHIeKp9wLFSVnrCnYNTD8SXvLFfTFbmx
 hBPdJ/1q9haiI7JuOkFHPksnqHGQmH3nNw4ORBRJ0Y3jQWADWG4FR94vvi1Z3HCuwWjWPD
 qs2EO6nJkkbh0W8DOFwPv0fY262n98o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-gXDtBq9LNjuc0RzVtDO3Pg-1; Tue,
 09 Sep 2025 09:52:32 -0400
X-MC-Unique: gXDtBq9LNjuc0RzVtDO3Pg-1
X-Mimecast-MFC-AGG-ID: gXDtBq9LNjuc0RzVtDO3Pg_1757425951
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE1BB19560A2; Tue,  9 Sep 2025 13:52:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED8591800446; Tue,  9 Sep 2025 13:52:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 18/23] tests/functional: return output from cmd.py helpers
Date: Tue,  9 Sep 2025 15:51:42 +0200
Message-ID: <20250909135147.612345-19-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

Tests might want to look at the whole output from a command execution,
as well as just logging it. Add support for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250903201931.168317-2-john.levon@nutanix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/cmd.py | 53 +++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77d..c19dfc577ff 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -45,6 +45,9 @@ def is_readable_executable_file(path):
 # If end of line is seen, with neither @success or @failure
 # return False
 #
+# In both cases, also return the contents of the line (in bytes)
+# up to that point.
+#
 # If @failure is seen, then mark @test as failed
 def _console_read_line_until_match(test, vm, success, failure):
     msg = bytes([])
@@ -76,10 +79,23 @@ def _console_read_line_until_match(test, vm, success, failure):
     except:
         console_logger.debug(msg)
 
-    return done
+    return done, msg
 
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
+    """
+    Interact with the console until either message is seen.
+
+    :param success_message: if this message appears, finish interaction
+    :param failure_message: if this message appears, test fails
+    :param send_string: a string to send to the console before trying
+                        to read a new line
+    :param keep_sending: keep sending the send string each time
+    :param vm: the VM to interact with
+
+    :return: The collected output (in bytes form).
+    """
+
     assert not keep_sending or send_string
     assert success_message or send_string
 
@@ -101,6 +117,8 @@ def _console_interaction(test, success_message, failure_message,
     if failure_message is not None:
         failure_message_b = failure_message.encode()
 
+    out = bytes([])
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -113,11 +131,17 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        if _console_read_line_until_match(test, vm,
-                                          success_message_b,
-                                          failure_message_b):
+        done, line = _console_read_line_until_match(test, vm,
+                                                    success_message_b,
+                                                    failure_message_b)
+
+        out += line
+
+        if done:
             break
 
+    return out
+
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
                                                 interrupt_string='\r'):
@@ -140,10 +164,12 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message,
-                         interrupt_string, True)
+    return _console_interaction(test, success_message, failure_message,
+                                interrupt_string, True)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -155,9 +181,12 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, None, vm=vm)
+    return _console_interaction(test, success_message, failure_message,
+                                None, vm=vm)
 
 def exec_command(test, command):
     """
@@ -168,8 +197,10 @@ def exec_command(test, command):
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
     :type command: str
+
+    :return: The collected output (in bytes form).
     """
-    _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r')
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
@@ -184,9 +215,13 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, command + '\r')
+
+    return _console_interaction(test, success_message, failure_message,
+                                command + '\r')
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.51.0


