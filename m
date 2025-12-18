Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AF0D6ACF5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 12:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWDCG-00044U-Sv; Thu, 18 Dec 2025 07:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWDCF-00043u-13
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:33:31 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWDCD-0001vu-58
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:33:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C68E35BD18;
 Thu, 18 Dec 2025 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766061206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZFrW/nMhlpNMuSoDmosJkjYMLHFTy66ZMnjAxpF7bfQ=;
 b=MHyjzylQuVsM0Q6v/42Y5uv2SOj9GKOtRIyS0lmbK5njXOdgk4nACNuYocSBGOMWi+W1YW
 BI5h1ptXPpcfmcPQa/RfzU7UZo4ZXU/JfQXRpABa2jbHujDslKnxq4IPlbfCKhe3xWUg01
 XT9FZTi2HN9TeRQni7PLHe+lNBXedxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766061206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZFrW/nMhlpNMuSoDmosJkjYMLHFTy66ZMnjAxpF7bfQ=;
 b=Y0tDtvBCKWOigV70bL1WcKJ3ywOOgZJKAM8O4GUAV6nsAI9I5ie6/SigrFCEWF0zKPrYMz
 SiPg8elN06jp9zAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jl5lgzBG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5nW01hLa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766061204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZFrW/nMhlpNMuSoDmosJkjYMLHFTy66ZMnjAxpF7bfQ=;
 b=jl5lgzBG4xSZ+wAtPgyPl164XdANi+UIUcne3LReyOxhoxmaOCC/5Y90CYClL37lr8pI1G
 caw5uwQ3Cf7Qn8OZM5zY09Ex5yKUc8pfYDdFJsPKoZwfyiziC+5JuEoWjZJNd8LXCoYMX5
 R4uLgeBTvnpf+Ggzy8dou5A9euYfisE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766061204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZFrW/nMhlpNMuSoDmosJkjYMLHFTy66ZMnjAxpF7bfQ=;
 b=5nW01hLaTNKCj50OrXdSrnEPpgFwvHwb3dwPQOeL6XCubWoTi15EEIZC8b6REqAF/Ts39J
 UMdrIg42KdkTLGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1053EA63;
 Thu, 18 Dec 2025 12:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h54LNZL0Q2kWdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Dec 2025 12:33:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] tests/functional: Allow tests to be run individually
Date: Thu, 18 Dec 2025 09:33:20 -0300
Message-ID: <20251218123320.31347-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C68E35BD18
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[test_pseries.py:url,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

../tests/functional/ppc64/test_pseries.py PseriesMachine.test_ppc64_linux_boot
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
v2: added docs
---
 docs/devel/testing/functional.rst      | 19 +++++++++++++++++--
 tests/functional/qemu_test/testcase.py |  7 +++----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index fdeaebaadc..4ccc7c3940 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -52,17 +52,32 @@ the following line will only run the tests for the x86_64 target:
 
   make check-functional-x86_64
 
-To run a single test file without the meson test runner, you can also
+To run the tests from a test file without the meson test runner, you can also
 execute the file directly by specifying two environment variables first,
 the PYTHONPATH that has to include the python folder and the tests/functional
 folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
 to the QEMU binary that should be used for the test. The current working
-directory should be your build folder. For example::
+directory should be your build folder. Like so::
 
   $ export PYTHONPATH=../python:../tests/functional
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
+
+With the above set, run all tests from a test file::
+
   $ pyvenv/bin/python3 ../tests/functional/test_file.py
 
+Run all tests from a test class::
+
+  $ pyvenv/bin/python3 ../tests/functional/test_file.py TestClass
+
+Or a single test::
+
+  $ pyvenv/bin/python3 ../tests/functional/test_file.py TestClass.test_name
+
+Filtering test names also works::
+
+  $ pyvenv/bin/python3 ../tests/functional/test_file.py -k pattern
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


