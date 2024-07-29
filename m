Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA071C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSI2-0002XB-Vi; Mon, 29 Jul 2024 11:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSI0-0002IH-Px
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHy-0008HY-UD
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-427ffae0b91so23137385e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266873; x=1722871673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PomybOz3qZzuYIDD9gWq6wUwpi3wx9FNYbcCkKRftw=;
 b=PLBRy+BCNiPaoGgO+Ue5aK/0LmvHunBVaaGrtNIXiv6hQ3/+m5czFc3y+ogjFohYTB
 EQdUT03eC4WN3gpzGt4Mln883y905rRRRM4Chs7ppgwfWuBqGcNtGLnNbv6ONSccM1MU
 Jvzti6mf8Tr3Z1DNzpqYC1FOJ8aYNcXgCfboIY8NRFSJBxl0AQSgdWoKaV4JvGlQAhdG
 g2HyAT52UUNkNrNCXqQ08TWtAodYxNaTxjYuc09dKfI2MLedc5QJWG1taiIsfBX6De42
 kY806aVbTZV7jlkXjGb49j+eZfXJFOEBpU+SfF3obVPYM+rRIZUwgWKXgop0lllpkx/5
 0H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266873; x=1722871673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PomybOz3qZzuYIDD9gWq6wUwpi3wx9FNYbcCkKRftw=;
 b=qI0BgLzJ3WQP5zsgPW1Eq3J5vuom8yYFnxIC8ArXVZiKg/IC+UTlZ99+Nwp8+WQA1/
 tkTSlj3TsD2ebC8Zq0WEr6yewR47G7EGUbw0lt5Geu4mSdGbwNawc55ClsfDIFOd0V53
 Bw+uTBnbZuUmlbZi8QBC9/Hkr3O3cQK6fcUojB2marb0NTrLnuGq9gr22trp2U0sLL90
 dzMd6Qo2BvY1V23eX9jEUA5x8t6cbq7zVdpgGCYqYdMtcuWrgEOoXBDb9GxdDt5daOco
 9dLpo3JKPp0CkzcpZtL4c15xlBJNxaVtta4cr2JNo8x6/85Bxe17UmJBCeL3GxCNnPGj
 YWFw==
X-Gm-Message-State: AOJu0YyJKjv9LSOEVgUX9F15GKTq/yIA4x0VggPxMvYCbTL6gnXGOnLu
 hZ40prONQBOhvdyaMqbTRars6LKujyRbs3WbYtzgpQvDF65U+60tvIe4L6d3LB25sxAmP51kovn
 r
X-Google-Smtp-Source: AGHT+IHFKZYr18oYKE5NkTFzDuhVyfo8chvEKOqkncINr0XX82DdFtfdy9qgT3xkNXpuVfOmwK+5GA==
X-Received: by 2002:a05:600c:a08:b0:426:62c5:4731 with SMTP id
 5b1f17b1804b1-42811dd43c9mr61447485e9.29.1722266873315; 
 Mon, 29 Jul 2024 08:27:53 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281807f701sm68443285e9.22.2024.07.29.08.27.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] tests/functional: Prepare the meson build system for the
 functional tests
Date: Mon, 29 Jul 2024 17:27:06 +0200
Message-ID: <20240729152714.10225-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Provide a meson.build file for the upcoming python-based functional
tests, and add some wrapper glue targets to the tests/Makefile.include
file. We are going to use two "speed" modes for the functional tests:
The "quick" tests can be run at any time (i.e. also during "make check"),
while the "thorough" tests should only be run when running a
"make check-functional" test run (since these tests might download
additional assets from the internet).

The changes to the meson.build files are partly based on an earlier
patch by Ani Sinha.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-5-thuth@redhat.com>
[PMD: Removed call to check-func target in check-functional rule]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/Makefile.include       | 11 ++++++
 tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
 tests/meson.build            |  1 +
 3 files changed, 78 insertions(+)
 create mode 100644 tests/functional/meson.build

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 167d8f29a4..9077d5c6f0 100644
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
+	@$(MAKE) SPEED=thorough check-func-quick
+
 # Consolidated targets
 
 .PHONY: check check-clean get-vm-images
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
new file mode 100644
index 0000000000..7fc9c4e513
--- /dev/null
+++ b/tests/functional/meson.build
@@ -0,0 +1,66 @@
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
+tests_generic = [
+]
+
+tests_x86_64_quick = [
+]
+
+tests_x86_64_thorough = [
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


