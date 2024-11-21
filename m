Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F3D78782
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Ls-00028B-Gr; Thu, 21 Nov 2024 10:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lg-0001FR-8F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Le-00012c-HS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShPcAkYpFIhe0//CqodvG2ShpbJoQ+YDIDMHBDSOIG0=;
 b=VhvPX5RnrQoTKrw0B+htCx48gqof/CAdeN5kIUWZ3w4XtFB7O+toEGbJS5X22X78tpHcZ4
 MVpZl06QMjdQ4CEOyf9wfobE9TFB9Foi1Ecnj7+RC7qZiVpwRgr6zFDvAJ276pI6VvZOFY
 /UWHo0BcNzV9kigD7AvO5xzr0wNDq1g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-dGVVZri8M3GeIJjEf8DOWQ-1; Thu,
 21 Nov 2024 10:43:58 -0500
X-MC-Unique: dGVVZri8M3GeIJjEf8DOWQ-1
X-Mimecast-MFC-AGG-ID: dGVVZri8M3GeIJjEf8DOWQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B7E21954226; Thu, 21 Nov 2024 15:43:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 364071956086; Thu, 21 Nov 2024 15:43:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 14/18] tests/functional: require non-NULL success_message
 for console wait
Date: Thu, 21 Nov 2024 15:42:14 +0000
Message-ID: <20241121154218.1423005-15-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When waiting for expected output, the 'success_message' is a mandatory
parameter, with 'failure_message' defaulting to None.

The code has logic which indicates it was trying to cope with
'success_message' being None and 'failure_message' being non-None but
it does not appear able to actually do anything useful. The check for
'success_message is None' will break out of the loop before any check
for 'failure_message' has been performed.

IOW, for practcal purposes 'success_message' must be non-None unless
'send_string' is set. Assert this expectation and simplify the loop
logic.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/cmd.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 98722a9cf6..f6c4e4dda1 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -81,6 +81,8 @@ def is_readable_executable_file(path):
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
     assert not keep_sending or send_string
+    assert success_message or send_string
+
     if vm is None:
         vm = test.vm
     console = vm.console_file
@@ -95,7 +97,7 @@ def _console_interaction(test, success_message, failure_message,
                 send_string = None # send only once
 
         # Only consume console output if waiting for something
-        if success_message is None and failure_message is None:
+        if success_message is None:
             if send_string is None:
                 break
             continue
@@ -107,7 +109,7 @@ def _console_interaction(test, success_message, failure_message,
         if not msg:
             continue
         console_logger.debug(msg)
-        if success_message is None or success_message in msg:
+        if success_message in msg:
             break
         if failure_message and failure_message in msg:
             console.close()
@@ -138,6 +140,7 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
     """
+    assert success_message
     _console_interaction(test, success_message, failure_message,
                          interrupt_string, True)
 
@@ -152,6 +155,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
+    assert success_message
     _console_interaction(test, success_message, failure_message, None, vm=vm)
 
 def exec_command(test, command):
@@ -180,6 +184,7 @@ def exec_command_and_wait_for_pattern(test, command,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
+    assert success_message
     _console_interaction(test, success_message, failure_message, command + '\r')
 
 def get_qemu_img(test):
-- 
2.46.0


