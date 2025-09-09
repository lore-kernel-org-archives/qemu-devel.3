Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B268CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvymE-00014F-8K; Tue, 09 Sep 2025 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvym3-0000rw-Sm
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvym0-0005JQ-4k
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIsHtaQlgXfLkS5HKdPLt+l5JS4O5Na0D0OeFnQct3Y=;
 b=dwE8ckSHWEyFJ2sAkT4s6KCgQG9cFw2LeiAu19C1woCz+uQ4B7mbW/I6jJw7KHYgq9D7SF
 SiZyu+QkhZ9RBHohV3stP602dqaBsN0/x0tLiHtwzX+knrIZc9YjEqh6+9esJbUMVnI6vI
 uoNrSRXacqkJlCupEOEXbqY3N0+pFDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-GxfqwBO_NE2MD6owdqkoOQ-1; Tue,
 09 Sep 2025 09:52:35 -0400
X-MC-Unique: GxfqwBO_NE2MD6owdqkoOQ-1
X-Mimecast-MFC-AGG-ID: GxfqwBO_NE2MD6owdqkoOQ_1757425954
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B4151956089; Tue,  9 Sep 2025 13:52:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46C2F18003FC; Tue,  9 Sep 2025 13:52:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 19/23] tests/functional: add vm param to cmd.py helpers
Date: Tue,  9 Sep 2025 15:51:43 +0200
Message-ID: <20250909135147.612345-20-thuth@redhat.com>
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

Extend the "vm" parameter of wait_for_console_pattern() to all the other
utility functions; this allows them to be used on a VM other than
test.vm.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250903201931.168317-3-john.levon@nutanix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/cmd.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index c19dfc577ff..8069c89730b 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -144,7 +144,8 @@ def _console_interaction(test, success_message, failure_message,
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-                                                interrupt_string='\r'):
+                                                interrupt_string='\r',
+                                                vm=None):
     """
     Keep sending a string to interrupt a console prompt, while logging the
     console output. Typical use case is to break a boot loader prompt, such:
@@ -164,12 +165,13 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
     return _console_interaction(test, success_message, failure_message,
-                                interrupt_string, True)
+                                interrupt_string, True, vm=vm)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -181,6 +183,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
@@ -188,7 +191,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     return _console_interaction(test, success_message, failure_message,
                                 None, vm=vm)
 
-def exec_command(test, command):
+def exec_command(test, command, vm=None):
     """
     Send a command to a console (appending CRLF characters), while logging
     the content.
@@ -196,14 +199,16 @@ def exec_command(test, command):
     :param test: a test containing a VM.
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
+    :param vm: VM to use
     :type command: str
 
     :return: The collected output (in bytes form).
     """
-    return _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r', vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
+                                      success_message, failure_message=None,
+                                      vm=None):
     """
     Send a command to a console (appending CRLF characters), then wait
     for success_message to appear on the console, while logging the.
@@ -215,13 +220,14 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
 
     return _console_interaction(test, success_message, failure_message,
-                                command + '\r')
+                                command + '\r', vm=vm)
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.51.0


