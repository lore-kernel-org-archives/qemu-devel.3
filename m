Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D48FA3728
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 18:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbji8-0001sb-7u; Fri, 02 Jan 2026 13:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vbji3-0001s0-7A
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 13:17:11 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vbji1-0000Pi-Dr
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 13:17:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30845336CC;
 Fri,  2 Jan 2026 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767377826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lLW7KtM15DzpIj6tfDWd+/fpdO8mgZk2O9d1zqSK3I=;
 b=PcnHTLjvaOiL4NPzEwKnzMe0N/aOymrudomE9lGj/6IuAVZzPm4IgAJb1/m9EsVZM66ALU
 a8u5W/pYrMmMxPNGDU0KOVHp2fTnEkWe2ahhQbld3m/t7DPpvJbYy4N7F5TQP1h/7v/JmF
 ntT2rBCOCwlWdaRt6Zpd0sx1n1m6W98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767377826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lLW7KtM15DzpIj6tfDWd+/fpdO8mgZk2O9d1zqSK3I=;
 b=0sZ9Vsmo5VA/XE8RBP4mDhXLrjw8Ghvk3vTduHkOYo8XUAk0jv8r8Ct8nXJSuN8zjV1OL/
 a26Yrd12wNZ6wKDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767377825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lLW7KtM15DzpIj6tfDWd+/fpdO8mgZk2O9d1zqSK3I=;
 b=LWdMfzFfRKOVUXC4BXQSmsIzMv5QBTrr4y9ST9uJzJSzvOlbG14oYI33NAW7PgOfWaVFvd
 PG2Xhe58RP3THNL1eLy64IFJuvs5YNJvQKaQ+JLRomnSfvRCjgwknqyaqDr8XXnm6axNTA
 zSa171UnlTiQWDaH2oRYBCkD89p4ns0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767377825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lLW7KtM15DzpIj6tfDWd+/fpdO8mgZk2O9d1zqSK3I=;
 b=vnuaBZhXukm1I9lUDJpllMYQ4wNtrMjLjIP+J1wKNnQRc3sYWCio5DUHGJgG8TzuIFw0Tf
 fW6yRK/RT/yL9VDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9215B3EA63;
 Fri,  2 Jan 2026 18:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id raM8FJ8LWGkhfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Jan 2026 18:17:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3] tests/functional: Allow tests to be run individually
Date: Fri,  2 Jan 2026 15:17:00 -0300
Message-ID: <20260102181700.11886-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,test_pseries.py:url,testcase.py:url];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
v3: rebased over ./build/run changes
v2: added docs
---
 docs/devel/testing/functional.rst      | 15 +++++++++++++++
 tests/functional/qemu_test/testcase.py |  7 +++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 1978f96eba..60a427d175 100644
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
index 58f2740100..fa100d9632 100644
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
2.51.0


