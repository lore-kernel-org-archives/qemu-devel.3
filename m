Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrwi-0006Sg-Ir; Wed, 18 Dec 2024 06:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwf-0006SW-Kh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwd-00053Q-Ri
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54Sxn9ovfDx7Dc90LI1noSDad7pCE8hZjpZ3/maPDHU=;
 b=cuLLG8WiarOqCRcuYJEDyC8XfGJIdVuyQtyyo10V73kG6/cOiE+pFK7PayqhrWFhtcS0Tr
 uzuDdMW1cdPQOLSgpbI2i5j1kqKG+nWy6jkN1nlpuMvHyS6U9Qn4h7X/cS4iOKhTrdW4y8
 baXa0kyJNN94lWPzx4B8K/NIB+Ql0ko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-TXaORHRkMKClneKa5zvHPA-1; Wed,
 18 Dec 2024 06:10:20 -0500
X-MC-Unique: TXaORHRkMKClneKa5zvHPA-1
X-Mimecast-MFC-AGG-ID: TXaORHRkMKClneKa5zvHPA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C84881956089
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B337B19560AD; Wed, 18 Dec 2024 11:10:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 07/38] tests/functional: introduce some helpful decorators
Date: Wed, 18 Dec 2024 12:09:27 +0100
Message-ID: <20241218110958.226932-8-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Reduce repeated boilerplate with some helper decorators:

 @skipIfNotPlatform("x86_64", "aarch64")

  => Skip unless the build host platform matches

 @skipIfMissingCommands("mkisofs", "losetup")

  => Skips unless all listed commands are found in $PATH

 @skipIfMissingImports("numpy", "cv2")

  => Skips unless all listed modules can be imported

 @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")

  => Skips unless env var requests flaky tests with the
     reason documented in the referenced gitlab bug

 @skipBigData

  => Skips unless env var permits tests creating big data files

 @skipUntrustedTest

  => Skips unless env var permits tests which are potentially
     dangerous to the host

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-8-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py   |   3 +
 tests/functional/qemu_test/decorators.py | 107 +++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tests/functional/qemu_test/decorators.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 8fddddbe67..7dee3522f2 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -13,3 +13,6 @@
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
 from .linuxkernel import LinuxKernelTest
+from .decorators import skipIfMissingCommands, skipIfNotMachine, \
+    skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
+    skipIfMissingImports
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
new file mode 100644
index 0000000000..df088bc090
--- /dev/null
+++ b/tests/functional/qemu_test/decorators.py
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Decorators useful in functional tests
+
+import os
+import platform
+from unittest import skipUnless
+
+from .cmd import which
+
+'''
+Decorator to skip execution of a test if the list
+of command binaries is not available in $PATH.
+Example:
+
+  @skipIfMissingCommands("mkisofs", "losetup")
+'''
+def skipIfMissingCommands(*args):
+    def has_cmds(cmdlist):
+        for cmd in cmdlist:
+            if not which(cmd):
+                return False
+        return True
+
+    return skipUnless(lambda: has_cmds(args),
+                      'required command(s) "%s" not installed' %
+                      ", ".join(args))
+
+'''
+Decorator to skip execution of a test if the current
+host machine does not match one of the permitted
+machines.
+Example
+
+  @skipIfNotMachine("x86_64", "aarch64")
+'''
+def skipIfNotMachine(*args):
+    return skipUnless(lambda: platform.machine() in args,
+                        'not running on one of the required machine(s) "%s"' %
+                        ", ".join(args))
+
+'''
+Decorator to skip execution of flaky tests, unless
+the $QEMU_TEST_FLAKY_TESTS environment variable is set.
+A bug URL must be provided that documents the observed
+failure behaviour, so it can be tracked & re-evaluated
+in future.
+
+Historical tests may be providing "None" as the bug_url
+but this should not be done for new test.
+
+Example:
+
+  @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")
+'''
+def skipFlakyTest(bug_url):
+    if bug_url is None:
+        bug_url = "FIXME: reproduce flaky test and file bug report or remove"
+    return skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'),
+                      f'Test is unstable: {bug_url}')
+
+'''
+Decorator to skip execution of tests which are likely
+to execute untrusted commands on the host, or commands
+which process untrusted code, unless the
+$QEMU_TEST_ALLOW_UNTRUSTED_CODE env var is set.
+Example:
+
+  @skipUntrustedTest()
+'''
+def skipUntrustedTest():
+    return skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'),
+                      'Test runs untrusted code / processes untrusted data')
+
+'''
+Decorator to skip execution of tests which need large
+data storage (over around 500MB-1GB mark) on the host,
+unless the $QEMU_TEST_ALLOW_LARGE_STORAGE environment
+variable is set
+
+Example:
+
+  @skipBigDataTest()
+'''
+def skipBigDataTest():
+    return skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'),
+                      'Test requires large host storage space')
+
+'''
+Decorator to skip execution of a test if the list
+of python imports is not available.
+Example:
+
+  @skipIfMissingImports("numpy", "cv2")
+'''
+def skipIfMissingImports(*args):
+    def has_imports(importlist):
+        for impname in importlist:
+            try:
+                import impname
+            except ImportError:
+                return False
+        return True
+
+    return skipUnless(lambda: has_imports(args),
+                      'required import(s) "%s" not installed' %
+                      ", ".join(args))
-- 
2.47.1


