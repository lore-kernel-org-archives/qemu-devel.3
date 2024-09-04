Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0C3CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQo-0001su-Mj; Wed, 04 Sep 2024 06:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQm-0001lg-BQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQk-0000EA-Hp
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxiIghsuBv+oB91PfIdqqb1BiAQxhcqz1TejR2XIAtM=;
 b=T7GBhv8EPO7lb8T57UESMcf0Su99wM7rzDUhg9IwMWN/g2bn+ikTOZiU5njUCkyfU7dwHQ
 gWWTtcf5QUGLFWck8bpYKkNrXNwAIyol/nFmS/rrefWb7uZp7d1JAfPsxpbeGN0bTiMvHS
 UwgNeAyGSrOmaDiO9eZXmKVJePAFDoY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-6HOV89fPMOWn6IKk60tVCA-1; Wed,
 04 Sep 2024 06:40:02 -0400
X-MC-Unique: 6HOV89fPMOWn6IKk60tVCA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE0261944AAC; Wed,  4 Sep 2024 10:40:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2E66195605A; Wed,  4 Sep 2024 10:39:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/42] tests/functional: Prepare the meson build system for the
 functional tests
Date: Wed,  4 Sep 2024 12:38:46 +0200
Message-ID: <20240904103923.451847-12-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Provide a meson.build file for the upcoming python-based functional
tests, and add some wrapper glue targets to the tests/Makefile.include
file. We are going to use two "speed" modes for the functional tests:
The "quick" tests can be run at any time (i.e. also during "make check"),
while the "thorough" tests should only be run when running a
"make check-functional" test run (since these tests might download
additional assets from the internet).

The changes to the meson.build files are partly based on an earlier
patch by Ani Sinha.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-12-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include       | 11 +++++
 tests/functional/meson.build | 81 ++++++++++++++++++++++++++++++++++++
 tests/meson.build            |  1 +
 3 files changed, 93 insertions(+)
 create mode 100644 tests/functional/meson.build

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fbb1a4b211..66c8cc3123 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -9,6 +9,8 @@ check-help:
 	@echo "Individual test suites:"
 	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
 	@echo " $(MAKE) check-qtest              Run qtest tests"
+	@echo " $(MAKE) check-functional         Run python-based functional tests"
+	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
 	@echo " $(MAKE) check-unit               Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
 	@echo " $(MAKE) check-block              Run block tests"
@@ -152,6 +154,15 @@ check-acceptance-deprecated-warning:
 
 check-acceptance: check-acceptance-deprecated-warning | check-avocado
 
+FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
+.PHONY: $(FUNCTIONAL_TARGETS)
+$(FUNCTIONAL_TARGETS):
+	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
+
+.PHONY: check-functional
+check-functional:
+	@$(MAKE) SPEED=thorough check-func check-func-quick
+
 # Consolidated targets
 
 .PHONY: check check-clean get-vm-images
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
new file mode 100644
index 0000000000..052d2e8781
--- /dev/null
+++ b/tests/functional/meson.build
@@ -0,0 +1,81 @@
+# QEMU functional tests:
+# Tests that are put in the 'quick' category are run by default during
+# 'make check'. Everything that should not be run during 'make check'
+# (e.g. tests that fetch assets from the internet) should be put into
+# the 'thorough' category instead.
+
+# Most tests run too slow with TCI enabled, so skip the functional tests there
+if get_option('tcg_interpreter')
+  subdir_done()
+endif
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_timeouts = {
+}
+
+tests_generic_system = [
+]
+
+tests_generic_linuxuser = [
+]
+
+tests_generic_bsduser = [
+]
+
+tests_x86_64_system_quick = [
+]
+
+tests_x86_64_system_thorough = [
+]
+
+foreach speed : ['quick', 'thorough']
+  foreach dir : target_dirs
+
+    target_base = dir.split('-')[0]
+
+    if dir.endswith('-softmmu')
+      sysmode = 'system'
+      test_emulator = emulators['qemu-system-' + target_base]
+    elif dir.endswith('-linux-user')
+      sysmode = 'linuxuser'
+      test_emulator = emulators['qemu-' + target_base]
+    elif dir.endswith('-bsd-user')
+      sysmode = 'bsduser'
+      test_emulator = emulators['qemu-' + target_base]
+    else
+      continue
+    endif
+
+    if speed == 'quick'
+      suites = ['func-quick', 'func-' + target_base]
+      target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
+                     + get_variable('tests_generic_' + sysmode)
+    else
+      suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
+      target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
+    endif
+
+    test_deps = roms
+    test_env = environment()
+    if have_tools
+      test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 'qemu-img')
+      test_deps += [qemu_img]
+    endif
+    test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
+    test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
+    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
+                               meson.current_source_dir())
+
+    foreach test : target_tests
+      test('func-@0@/@1@'.format(target_base, test),
+           python,
+           depends: [test_deps, test_emulator, emulator_modules],
+           env: test_env,
+           args: [meson.current_source_dir() / 'test_' + test + '.py'],
+           protocol: 'tap',
+           timeout: test_timeouts.get(test, 60),
+           priority: test_timeouts.get(test, 60),
+           suite: suites)
+    endforeach
+  endforeach
+endforeach
diff --git a/tests/meson.build b/tests/meson.build
index 80dd3029cf..907a4c1c98 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -85,3 +85,4 @@ subdir('unit')
 subdir('qapi-schema')
 subdir('qtest')
 subdir('migration')
+subdir('functional')
-- 
2.46.0


