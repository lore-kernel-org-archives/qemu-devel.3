Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C928CA0FF5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1rG-0000Ot-3x; Fri, 30 Aug 2024 09:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1rC-0000JF-NY
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1rA-0005QS-DN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJbQZJGwqu7BKGegMKr2BErsIPZVL+r3Bfkwsv4GRx8=;
 b=GzHtzrsn1vyuX5SG23Xk2GVoqu8jePd5JVpM5mXPKbf4f0pSOGB7i5+V3++zFyxB7/sgNL
 AkbVeK9hdB+HgXTc4qOD4enY8HKwgXd6z3WkhMcRQ2h4McGn6YOBAEefZXzNQBfz+a7MMo
 10JwNBn+jCgGVcNuyclTiIDN6wRn3K0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-Phv6HJwLNLuNO2Fk1YwucQ-1; Fri,
 30 Aug 2024 09:40:02 -0400
X-MC-Unique: Phv6HJwLNLuNO2Fk1YwucQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 832741955D4A; Fri, 30 Aug 2024 13:40:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 848C83001FC3; Fri, 30 Aug 2024 13:39:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 15/44] tests/functional: enable pre-emptive caching of
 assets
Date: Fri, 30 Aug 2024 15:38:09 +0200
Message-ID: <20240830133841.142644-16-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Many tests need to access assets stored on remote sites. We don't want
to download these during test execution when run by meson, since this
risks hitting test timeouts when data transfers are slow.

Add support for pre-emptive caching of assets by setting the env var
QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
instead of running the test, the assets will be downloaded and saved
to the cache, then the timestamp file created.

A meson custom target is created as a dependency of each test suite
to trigger the pre-emptive caching logic before the test runs.

When run in caching mode, it will locate assets by looking for class
level variables with a name prefix "ASSET_", and type "Asset".

At the ninja level

   ninja test --suite functional

will speculatively download any assets that are not already cached,
so it is advisable to set a timeout multiplier.

   QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional

will fail the test if a required asset is not already cached

   ninja precache-functional

will download and cache all assets required by the functional
tests

At the make level, precaching is always done by

   make check-functional

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
[thuth: Remove the duplicated "path = os.path.basename(...)" line]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include                 |  3 ++-
 tests/functional/meson.build           | 33 +++++++++++++++++++++++--
 tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
 tests/functional/qemu_test/testcase.py |  7 ++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 66c8cc3123..010369bd3a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -161,7 +161,8 @@ $(FUNCTIONAL_TARGETS):
 
 .PHONY: check-functional
 check-functional:
-	@$(MAKE) SPEED=thorough check-func check-func-quick
+	@$(NINJA) precache-functional
+	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
 # Consolidated targets
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f1f344f860..df79775df3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -39,6 +39,7 @@ tests_x86_64_system_quick = [
 tests_x86_64_system_thorough = [
 ]
 
+precache_all = []
 foreach speed : ['quick', 'thorough']
   foreach dir : target_dirs
 
@@ -78,11 +79,35 @@ foreach speed : ['quick', 'thorough']
                                meson.current_source_dir())
 
     foreach test : target_tests
-      test('func-@0@/@1@'.format(target_base, test),
+      testname = '@0@-@1@'.format(target_base, test)
+      testfile = 'test_' + test + '.py'
+      testpath = meson.current_source_dir() / testfile
+      teststamp = testname + '.tstamp'
+      test_precache_env = environment()
+      test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
+      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
+                                          meson.current_source_dir())
+      precache = custom_target('func-precache-' + testname,
+                               output: teststamp,
+                               command: [python, testpath],
+                               depend_files: files(testpath),
+                               build_by_default: false,
+                               env: test_precache_env)
+      precache_all += precache
+
+      # Ideally we would add 'precache' to 'depends' here, such that
+      # 'build_by_default: false' lets the pre-caching automatically
+      # run immediately before the test runs. In practice this is
+      # broken in meson, with it running the pre-caching in the normal
+      # compile phase https://github.com/mesonbuild/meson/issues/2518
+      # If the above bug ever gets fixed, when QEMU changes the min
+      # meson version, add the 'depends' and remove the custom
+      # 'run_target' logic below & in Makefile.include
+      test('func-' + testname,
            python,
            depends: [test_deps, test_emulator, emulator_modules],
            env: test_env,
-           args: [meson.current_source_dir() / 'test_' + test + '.py'],
+           args: [testpath],
            protocol: 'tap',
            timeout: test_timeouts.get(test, 60),
            priority: test_timeouts.get(test, 60),
@@ -90,3 +115,7 @@ foreach speed : ['quick', 'thorough']
     endforeach
   endforeach
 endforeach
+
+run_target('precache-functional',
+           depends: precache_all,
+           command: ['true'])
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index c0e675d847..b329ab7dbe 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -9,6 +9,8 @@
 import logging
 import os
 import subprocess
+import sys
+import unittest
 import urllib.request
 from pathlib import Path
 from shutil import copyfileobj
@@ -62,6 +64,9 @@ def fetch(self):
                            self.cache_file, self.url)
             return str(self.cache_file)
 
+        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
+            raise Exception("Asset cache is invalid and downloads disabled")
+
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
 
@@ -95,3 +100,32 @@ def fetch(self):
 
         self.log.info("Cached %s at %s" % (self.url, self.cache_file))
         return str(self.cache_file)
+
+    def precache_test(test):
+        log = logging.getLogger('qemu-test')
+        log.setLevel(logging.DEBUG)
+        handler = logging.StreamHandler(sys.stdout)
+        handler.setLevel(logging.DEBUG)
+        formatter = logging.Formatter(
+            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
+        handler.setFormatter(formatter)
+        log.addHandler(handler)
+        for name, asset in vars(test.__class__).items():
+            if name.startswith("ASSET_") and type(asset) == Asset:
+                log.info("Attempting to cache '%s'" % asset)
+                asset.fetch()
+        log.removeHandler(handler)
+
+    def precache_suite(suite):
+        for test in suite:
+            if isinstance(test, unittest.TestSuite):
+                Asset.precache_suite(test)
+            elif isinstance(test, unittest.TestCase):
+                Asset.precache_test(test)
+
+    def precache_suites(path, cacheTstamp):
+        loader = unittest.loader.defaultTestLoader
+        tests = loader.loadTestsFromNames([path], None)
+
+        with open(cacheTstamp, "w") as fh:
+            Asset.precache_suite(tests)
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index b2dd863c6e..18314be9d1 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -21,6 +21,7 @@
 from qemu.machine import QEMUMachine
 from qemu.utils import kvm_available, tcg_available
 
+from .asset import Asset
 from .cmd import run_cmd
 from .config import BUILD_DIR
 
@@ -58,6 +59,12 @@ def tearDown(self):
 
     def main():
         path = os.path.basename(sys.argv[0])[:-3]
+
+        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
+        if cache is not None:
+            Asset.precache_suites(path, cache)
+            return
+
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
         unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
-- 
2.46.0


