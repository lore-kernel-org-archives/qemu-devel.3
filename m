Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF7CE9D48
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJu-0003ys-DB; Wed, 07 Jan 2026 07:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJj-0003uT-Iy
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJf-0002AK-IL
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZq0LLC7JeYGgO7WuiFS8x7Hr5gK4waAUzM5ybmy8y8=;
 b=GS489WhWTTfCKZ+ZlTROSv3xy/pyJcIO/fmD8Jr3wQiEPJ3xHrxP1YutlZMTkjWKoEonAe
 r9T2d6UrfhcTx+Rv3CbcrawIA04WzFcT1j8G2yiUdeA2CxKdafj/eEkkzi3TV9qPgxQTXu
 GFFf7LjcRu0FBfJVVsxoSWfGINFEElQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Ssigwt4aNdG5l8JSKSl0SQ-1; Wed,
 07 Jan 2026 07:07:03 -0500
X-MC-Unique: Ssigwt4aNdG5l8JSKSl0SQ-1
X-Mimecast-MFC-AGG-ID: Ssigwt4aNdG5l8JSKSl0SQ_1767787622
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69BD71800371; Wed,  7 Jan 2026 12:07:02 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6935A1956053; Wed,  7 Jan 2026 12:07:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 13/14] tests/functional: Allow tests to be run individually
Date: Wed,  7 Jan 2026 13:06:37 +0100
Message-ID: <20260107120638.56735-14-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The functional tests currently don't allow a single test to be
selected for execution by dotted name, e.g:

./build/run tests/functional/ppc64/test_pseries.py PseriesMachine.test_ppc64_linux_boot
                                          ^
The issue is that the testcase.py main function passes the test
module's name as the second argument to unittest.main(), which makes
it ignore all other positional arguments (presumably because the
module is already the superset of all tests).

After commit cac08383f0 ("tests/functional: expose sys.argv to
unittest.main"), the situation improves by passing the rest of the
argv from the command line invocation into unittest.main(), but it
still doesn't fix the issue. The short form options are now accepted,
so the -k option could be used to filter for a pattern, which is
useful, but not the same as listing the test names.

Fix this by passing the test module name via the "module" argument to
unittest.main() and stop touching argv. The ways of invoking tests are
now as per unittests documentation (-k still works):

  Examples:
    test_pseries.py                           - run default set of tests
    test_pseries.py MyTestSuite               - run suite 'MyTestSuite'
    test_pseries.py MyTestCase.testSomething  - run MyTestCase.testSomething
    test_pseries.py MyTestCase                - run all 'test*' test methods in MyTestCase

Note that ever since we've been programatically passing the module
name to unittest.main(), the usage 'test_pseries.py test_pseries' was
never valid. It used to "work" just the same as 'test_pseries.py
foobar' would. After this patch, that usage results in an error.

Also note that testcase.py:main() pertains to running the test module
that invoked it via QemuSystemTest.main(), i.e. module == __main__. So
the 'discover' usage of unittest doesn't apply here, the module is
already discovered because that's where this code was called from to
begin with. This patch could just as well call unittest.main() instead
of unittest.main(test_module), but the latter provides nicer error
messages prefixed with the module name.

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20260102181700.11886-1-farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst      | 15 +++++++++++++++
 tests/functional/qemu_test/testcase.py |  7 +++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 1978f96eba1..60a427d175d 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -60,8 +60,23 @@ Assuming the current working directory is the top level source checkout
 and the build directory is './build'::
 
   $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
+
+Run all tests from a test file::
+
   $ ./build/run tests/functional/x86_64/test_virtio_version.py
 
+Run all tests from a test class::
+
+  $ ./build/run tests/functional/x86_64/test_virtio_version.py VirtioVersionCheck
+
+Or a single test::
+
+  $ ./build/run tests/functional/x86_64/test_virtio_version.py VirtioVersionCheck.test_modern_only_devs
+
+Filtering test names also works::
+
+  $ ./build/run tests/functional/x86_64/test_virtio_version.py -k modern
+
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
 files around on disk by setting ``QEMU_TEST_KEEP_SCRATCH=1`` as an env
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 58f27401004..fa100d96320 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -249,17 +249,16 @@ def main():
         warnings.simplefilter("default")
         os.environ["PYTHONWARNINGS"] = "default"
 
-        path = os.path.basename(sys.argv[0])[:-3]
+        test_module = os.path.basename(sys.argv[0])[:-3]
 
         cache = os.environ.get("QEMU_TEST_PRECACHE", None)
         if cache is not None:
-            Asset.precache_suites(path, cache)
+            Asset.precache_suites(test_module, cache)
             return
 
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
-        res = unittest.main(module = None, testRunner = tr, exit = False,
-                            argv=[sys.argv[0], path] + sys.argv[1:])
+        res = unittest.main(test_module, testRunner = tr, exit = False)
         failed = {}
         for (test, _message) in res.result.errors + res.result.failures:
             if hasattr(test, "log_filename") and not test.id() in failed:
-- 
2.52.0


