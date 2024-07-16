Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B236C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgKS-0000Pf-RR; Tue, 16 Jul 2024 07:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKR-0000Js-Fe
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKP-0003eb-Pl
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbeK7o2Avj9RP/nuuizYkz3rpCRVuPxR4fikDUeYbMw=;
 b=TPtuyzcDxmslnunUvtxPwUNLJHmljpJbXluohPTXgj8iqq7AHnZbsSZzjfZgG1kGE9V9oK
 OgDwnzMruZCYZye8b+hDTTESEtHge1Yq+mVBqW2oEeSngda1lP3DlSJLTGlE1+tHlFfY+c
 LEemwe5q6/tWbswkkHOG301EHTBagj0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-kUWn3jTQNauKBvXuQNwphw-1; Tue,
 16 Jul 2024 07:26:38 -0400
X-MC-Unique: kUWn3jTQNauKBvXuQNwphw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B83871944A9B; Tue, 16 Jul 2024 11:26:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E7101955F40; Tue, 16 Jul 2024 11:26:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 04/11] tests/functional: Add python-based tests to the meson
 build system
Date: Tue, 16 Jul 2024 13:26:07 +0200
Message-ID: <20240716112614.1755692-5-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Integrate the new python-based test framework with the meson build
system. Since these tests now require the pycotap module, make
sure that it gets installed in the venv.

The changes to the meson.build files are partly based on an earlier
patch by Ani Sinha (but heavily modified by Thomas Huth e.g. to use
pycotap for running the tests instead).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pythondeps.toml              |  3 +-
 tests/Makefile.include       | 18 ++++++++-
 tests/functional/meson.build | 75 ++++++++++++++++++++++++++++++++++++
 tests/meson.build            |  1 +
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 tests/functional/meson.build

diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd8..c018b4d74a 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -26,9 +26,10 @@ meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
 sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 
-[avocado]
+[tests]
 # Note that qemu.git/python/ is always implicitly installed.
 # Prefer an LTS version when updating the accepted versions of
 # avocado-framework, for example right now the limit is 92.x.
 avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
 pycdlib = { accepted = ">=1.11.0" }
+pycotap = { accepted = ">=1.1.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d39d5dd6a4..2bdf607977 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -9,6 +9,8 @@ check-help:
 	@echo "Individual test suites:"
 	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
 	@echo " $(MAKE) check-qtest            Run qtest tests"
+	@echo " $(MAKE) check-functional       Run python-based functional tests"
+	@echo " $(MAKE) check-functional-TARG  Run functional tests for a given target"
 	@echo " $(MAKE) check-unit             Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema      Run QAPI schema tests"
 	@echo " $(MAKE) check-block            Run block tests"
@@ -111,7 +113,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(MKVENV_ENSUREGROUP) $< avocado
+	$(MKVENV_ENSUREGROUP) $< tests
 	$(call quiet-command, touch $@)
 
 $(TESTS_RESULTS_DIR):
@@ -152,6 +154,20 @@ check-acceptance-deprecated-warning:
 
 check-acceptance: check-acceptance-deprecated-warning | check-avocado
 
+# Make sure that pycotap is installed before running any functional tests:
+ifneq ($(filter check-func%,$(MAKECMDGOALS))$(filter check,$(MAKECMDGOALS)),)
+do-meson-check: check-venv
+endif
+
+FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
+.PHONY: $(FUNCTIONAL_TARGETS)
+$(FUNCTIONAL_TARGETS):
+	@make SPEED=thorough $(subst -functional,-func,$@)
+
+.PHONY: check-functional
+check-functional:
+	@make SPEED=thorough check-func check-func-quick
+
 # Consolidated targets
 
 .PHONY: check check-clean get-vm-images
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
new file mode 100644
index 0000000000..11352b5bb5
--- /dev/null
+++ b/tests/functional/meson.build
@@ -0,0 +1,75 @@
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
+  'ppc_74xx' : 90,
+}
+
+tests_generic = [
+  'empty_cpu_model',
+  'info_usernet',
+  'version',
+]
+
+tests_ppc_quick = [
+  'ppc_74xx',
+]
+
+tests_x86_64_quick = [
+  'cpu_queries',
+  'mem_addr_space',
+  'pc_cpu_hotplug_props',
+  'virtio_version',
+]
+
+foreach speed : ['quick', 'thorough']
+  foreach dir : target_dirs
+    if not dir.endswith('-softmmu')
+      continue
+    endif
+
+    target_base = dir.split('-')[0]
+    test_emulator = emulators['qemu-system-' + target_base]
+
+    if speed == 'quick'
+      suites = ['func-quick', 'func-' + target_base]
+      target_tests = get_variable('tests_' + target_base + '_quick', []) + tests_generic
+    else
+      suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
+      target_tests = get_variable('tests_' + target_base + '_' + speed, [])
+    endif
+
+    test_deps = roms
+    test_env = environment()
+    if have_tools
+      test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 'qemu-img')
+      test_deps += [qemu_img]
+    endif
+    test_env.set('QEMU_TEST_QEMU_BINARY',
+                 meson.global_build_root() / 'qemu-system-' + target_base)
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
index acb6807094..3345ad2098 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -85,3 +85,4 @@ subdir('unit')
 subdir('qapi-schema')
 subdir('qtest')
 subdir('migration')
+subdir('functional')
-- 
2.45.2


