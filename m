Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EDFCCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsGq-0003l8-AC; Mon, 03 Nov 2025 05:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGn-0003kL-Le
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGl-0004B6-1y
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgK7d3BIEFcYpQw9mKYN0KzotxKf5QOsInjiFYzG/0E=;
 b=AL494f4O5/E5BlsFKvq/Qow9CgyHy4Hz7/YaPSY8Azvsy8oGiHlNTOQYwSSqLddNH356oT
 0AsYVWEEDj0IGgG3vFyGela2hSyllyG0Bb1N9jmJEILH7BaScxZYw6d64zF4QIKeBhrq5X
 TVfw6tidUtyvIAmmcjt1W706BXbudeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-g0P2mG6CPqyWaxcSf_rq9Q-1; Mon,
 03 Nov 2025 05:58:34 -0500
X-MC-Unique: g0P2mG6CPqyWaxcSf_rq9Q-1
X-Mimecast-MFC-AGG-ID: g0P2mG6CPqyWaxcSf_rq9Q_1762167513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A4B7180A221; Mon,  3 Nov 2025 10:58:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D83D430001A1; Mon,  3 Nov 2025 10:58:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/22] tests/functional: Fix problems in decorators.py reported
 by pylint
Date: Mon,  3 Nov 2025 11:58:00 +0100
Message-ID: <20251103105824.322039-4-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

The documentation strings should follow the function definition
lines, not precede them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251015095454.1575318-3-thuth@redhat.com>
---
 tests/functional/qemu_test/decorators.py | 176 +++++++++++------------
 1 file changed, 87 insertions(+), 89 deletions(-)

diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index b2392958041..807418359ab 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -10,136 +10,134 @@
 
 from .cmd import which
 
-'''
-Decorator to skip execution of a test if the provided
-environment variables are not set.
-Example:
 
-  @skipIfMissingEnv("QEMU_ENV_VAR0", "QEMU_ENV_VAR1")
-'''
 def skipIfMissingEnv(*vars_):
+    '''
+    Decorator to skip execution of a test if the provided
+    environment variables are not set.
+    Example:
+
+      @skipIfMissingEnv("QEMU_ENV_VAR0", "QEMU_ENV_VAR1")
+    '''
     missing_vars = []
     for var in vars_:
-        if os.getenv(var) == None:
+        if os.getenv(var) is None:
             missing_vars.append(var)
 
-    has_vars = True if len(missing_vars) == 0 else False
+    has_vars = len(missing_vars) == 0
 
     return skipUnless(has_vars, f"Missing env var(s): {', '.join(missing_vars)}")
 
-'''
-
-Decorator to skip execution of a test if the list
-of command binaries is not available in $PATH.
-Example:
-
-  @skipIfMissingCommands("mkisofs", "losetup")
-'''
 def skipIfMissingCommands(*args):
+    '''
+    Decorator to skip execution of a test if the list
+    of command binaries is not available in $PATH.
+    Example:
+
+      @skipIfMissingCommands("mkisofs", "losetup")
+    '''
     has_cmds = True
     for cmd in args:
-         if not which(cmd):
-             has_cmds = False
-             break
+        if not which(cmd):
+            has_cmds = False
+            break
 
     return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
                                 ", ".join(args))
 
-'''
-Decorator to skip execution of a test if the current
-host operating system does match one of the prohibited
-ones.
-Example
-
-  @skipIfOperatingSystem("Linux", "Darwin")
-'''
 def skipIfOperatingSystem(*args):
+    '''
+    Decorator to skip execution of a test if the current host
+    operating system does match one of the prohibited ones.
+    Example:
+
+      @skipIfOperatingSystem("Linux", "Darwin")
+    '''
     return skipIf(platform.system() in args,
                   'running on an OS (%s) that is not able to run this test' %
                   ", ".join(args))
 
-'''
-Decorator to skip execution of a test if the current
-host machine does not match one of the permitted
-machines.
-Example
-
-  @skipIfNotMachine("x86_64", "aarch64")
-'''
 def skipIfNotMachine(*args):
+    '''
+    Decorator to skip execution of a test if the current
+    host machine does not match one of the permitted machines.
+    Example:
+
+      @skipIfNotMachine("x86_64", "aarch64")
+    '''
     return skipUnless(platform.machine() in args,
                       'not running on one of the required machine(s) "%s"' %
                       ", ".join(args))
 
-'''
-Decorator to skip execution of flaky tests, unless
-the $QEMU_TEST_FLAKY_TESTS environment variable is set.
-A bug URL must be provided that documents the observed
-failure behaviour, so it can be tracked & re-evaluated
-in future.
+def skipFlakyTest(bug_url):
+    '''
+    Decorator to skip execution of flaky tests, unless
+    the $QEMU_TEST_FLAKY_TESTS environment variable is set.
+    A bug URL must be provided that documents the observed
+    failure behaviour, so it can be tracked & re-evaluated
+    in future.
 
-Historical tests may be providing "None" as the bug_url
-but this should not be done for new test.
+    Historical tests may be providing "None" as the bug_url
+    but this should not be done for new test.
 
-Example:
+    Example:
 
-  @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")
-'''
-def skipFlakyTest(bug_url):
+      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")
+    '''
     if bug_url is None:
         bug_url = "FIXME: reproduce flaky test and file bug report or remove"
     return skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'),
                       f'Test is unstable: {bug_url}')
 
-'''
-Decorator to skip execution of tests which are likely
-to execute untrusted commands on the host, or commands
-which process untrusted code, unless the
-$QEMU_TEST_ALLOW_UNTRUSTED_CODE env var is set.
-Example:
-
-  @skipUntrustedTest()
-'''
 def skipUntrustedTest():
+    '''
+    Decorator to skip execution of tests which are likely
+    to execute untrusted commands on the host, or commands
+    which process untrusted code, unless the
+    $QEMU_TEST_ALLOW_UNTRUSTED_CODE env var is set.
+    Example:
+
+      @skipUntrustedTest()
+    '''
     return skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'),
                       'Test runs untrusted code / processes untrusted data')
 
-'''
-Decorator to skip execution of tests which need large
-data storage (over around 500MB-1GB mark) on the host,
-unless the $QEMU_TEST_ALLOW_LARGE_STORAGE environment
-variable is set
+def skipBigDataTest():
+    '''
+    Decorator to skip execution of tests which need large
+    data storage (over around 500MB-1GB mark) on the host,
+    unless the $QEMU_TEST_ALLOW_LARGE_STORAGE environment
+    variable is set
 
-Example:
+    Example:
 
-  @skipBigDataTest()
-'''
-def skipBigDataTest():
+      @skipBigDataTest()
+    '''
     return skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'),
                       'Test requires large host storage space')
 
-'''
-Decorator to skip execution of tests which have a really long
-runtime (and might e.g. time out if QEMU has been compiled with
-debugging enabled) unless the $QEMU_TEST_ALLOW_SLOW
-environment variable is set
+def skipSlowTest():
+    '''
+    Decorator to skip execution of tests which have a really long
+    runtime (and might e.g. time out if QEMU has been compiled with
+    debugging enabled) unless the $QEMU_TEST_ALLOW_SLOW
+    environment variable is set
 
-Example:
+    Example:
 
-  @skipSlowTest()
-'''
-def skipSlowTest():
+      @skipSlowTest()
+    '''
     return skipUnless(os.getenv('QEMU_TEST_ALLOW_SLOW'),
                       'Test has a very long runtime and might time out')
 
-'''
-Decorator to skip execution of a test if the list
-of python imports is not available.
-Example:
-
-  @skipIfMissingImports("numpy", "cv2")
-'''
 def skipIfMissingImports(*args):
+    '''
+    Decorator to skip execution of a test if the list
+    of python imports is not available.
+    Example:
+
+      @skipIfMissingImports("numpy", "cv2")
+    '''
     has_imports = True
     for impname in args:
         try:
@@ -151,15 +149,15 @@ def skipIfMissingImports(*args):
     return skipUnless(has_imports, 'required import(s) "%s" not installed' %
                                    ", ".join(args))
 
-'''
-Decorator to skip execution of a test if the system's
-locked memory limit is below the required threshold.
-Takes required locked memory threshold in kB.
-Example:
-
-  @skipLockedMemoryTest(2_097_152)
-'''
 def skipLockedMemoryTest(locked_memory):
+    '''
+    Decorator to skip execution of a test if the system's
+    locked memory limit is below the required threshold.
+    Takes required locked memory threshold in kB.
+    Example:
+
+      @skipLockedMemoryTest(2_097_152)
+    '''
     # get memlock hard limit in bytes
     _, ulimit_memory = resource.getrlimit(resource.RLIMIT_MEMLOCK)
 
-- 
2.51.0


