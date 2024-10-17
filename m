Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4986AD374A1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RYB-0005QC-W2; Thu, 17 Oct 2024 10:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY8-0005NP-7r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:25 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY5-0003sf-DI
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:23 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FBA521D4F;
 Thu, 17 Oct 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIRM9LB7FwkHydC3GCwMPV0i8o72SEtPi5z7MK5aYuI=;
 b=WtZpEtpXatHHkdPNey7Gf6cvt/rSj6xSZ0tEYceBh9bwWIgyQnQDP2do/7rGFmzrnmoDbf
 VFxQjti3RnyUQ08bRxEZ0oynEqKMGGrGnBHO8M8D3q+CtpHQ7h4PE05/qqtLKGAu9Wp1Qn
 wmhUPWLurVe1h8FXOKiyeeQ5+wqNkdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIRM9LB7FwkHydC3GCwMPV0i8o72SEtPi5z7MK5aYuI=;
 b=vjHR2lQQObrZ8e918wyAyaSnTI1dUxfuiv5YYH7QPWqtsL/FQS1yNFLy+a1zZeShvogdkE
 RYIdDM0PqJ67xWAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WtZpEtpX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vjHR2lQQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIRM9LB7FwkHydC3GCwMPV0i8o72SEtPi5z7MK5aYuI=;
 b=WtZpEtpXatHHkdPNey7Gf6cvt/rSj6xSZ0tEYceBh9bwWIgyQnQDP2do/7rGFmzrnmoDbf
 VFxQjti3RnyUQ08bRxEZ0oynEqKMGGrGnBHO8M8D3q+CtpHQ7h4PE05/qqtLKGAu9Wp1Qn
 wmhUPWLurVe1h8FXOKiyeeQ5+wqNkdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIRM9LB7FwkHydC3GCwMPV0i8o72SEtPi5z7MK5aYuI=;
 b=vjHR2lQQObrZ8e918wyAyaSnTI1dUxfuiv5YYH7QPWqtsL/FQS1yNFLy+a1zZeShvogdkE
 RYIdDM0PqJ67xWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD32F13A42;
 Thu, 17 Oct 2024 14:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJN+JO8fEWcDKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 14:32:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/4] tests/qtest: Add check-migration
Date: Thu, 17 Oct 2024 11:32:08 -0300
Message-Id: <20241017143211.17771-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241017143211.17771-1-farosas@suse.de>
References: <20241017143211.17771-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FBA521D4F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Add two new targets, check-migration and check-migration-quick to
allow dividing migration tests into a quick set and a slow set. With
this it'll be possible to reduce the amount of migration tests that
run by default as part of 'make check'.

Keep under the 'migration-quick' suite only a few tests to serve as
sanity check for every build and move the rest under the 'migration'
suite.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 meson.build             |  6 +++---
 tests/Makefile.include  |  2 ++
 tests/qtest/meson.build | 47 +++++++++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 4ea1984fc5..92d38691f9 100644
--- a/meson.build
+++ b/meson.build
@@ -3,9 +3,9 @@ project('qemu', ['c'], meson_version: '>=1.1.0',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
 
-add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
-add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
-add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
+add_test_setup('quick', exclude_suites: ['slow', 'thorough', 'migration'], is_default: true)
+add_test_setup('slow', exclude_suites: ['thorough', 'migration-quick'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
+add_test_setup('thorough', exclude_suites: ['migration-quick'], env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
 
 meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 010369bd3a..79c1350bfb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -11,6 +11,8 @@ check-help:
 	@echo " $(MAKE) check-qtest              Run qtest tests"
 	@echo " $(MAKE) check-functional         Run python-based functional tests"
 	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
+	@echo " $(MAKE) check-migration-quick    Run a small set of migration tests"
+	@echo " $(MAKE) check-migration          Run all migration tests"
 	@echo " $(MAKE) check-unit               Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
 	@echo " $(MAKE) check-block              Run block tests"
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b207e38696..27a802474a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -406,14 +406,43 @@ foreach dir : target_dirs
         test: executable(test, src, dependencies: deps)
       }
     endif
-    test('qtest-@0@/@1@'.format(target_base, test),
-         qtest_executables[test],
-         depends: [test_deps, qtest_emulator, emulator_modules],
-         env: qtest_env,
-         args: ['--tap', '-k'],
-         protocol: 'tap',
-         timeout: slow_qtests.get(test, 60),
-         priority: slow_qtests.get(test, 60),
-         suite: ['qtest', 'qtest-' + target_base])
+
+    # The migration-test test runs several slow sub-tests. Add it to
+    # two separate targets, one for executing a few tests
+    # (migration-quick) and another for executing the full set
+    # (migration). This is done to reduce the amount of tests that run
+    # via make check.
+    if test == 'migration-test'
+      foreach opts : [
+        {
+          'test-args': ['--tap', '-k', '-m', 'slow'],
+          'test-suite': ['migration']
+        },
+        {
+          'test-args': ['--tap', '-k', '-m', 'quick'],
+          'test-suite': ['migration-quick']
+        }]
+
+        test(target_base,
+             qtest_executables[test],
+             depends: [test_deps, qtest_emulator, emulator_modules],
+             env: qtest_env,
+             args: opts['test-args'],
+             protocol: 'tap',
+             timeout: slow_qtests.get(test, 60),
+             priority: slow_qtests.get(test, 60),
+             suite: opts['test-suite'])
+      endforeach
+    else
+      test('qtest-@0@/@1@'.format(target_base, test),
+           qtest_executables[test],
+           depends: [test_deps, qtest_emulator, emulator_modules],
+           env: qtest_env,
+           args: ['--tap', '-k'],
+           protocol: 'tap',
+           timeout: slow_qtests.get(test, 60),
+           priority: slow_qtests.get(test, 60),
+           suite: ['qtest', 'qtest-' + target_base])
+    endif
   endforeach
 endforeach
-- 
2.35.3


