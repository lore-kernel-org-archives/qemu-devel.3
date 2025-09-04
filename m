Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D8BCA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCBq-00050w-Kf; Thu, 04 Sep 2025 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBM-0004mN-8G
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:30 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBA-0008Qy-I9
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:25 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-545e265e2d0so1010431e0c.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757000833; x=1757605633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ly0Uw2HSTv1mCwT12MXqsgrBCGp5zOffCN0UNp08lAs=;
 b=doUvwRRFbiP/9f6zGeOpZkfxYnDqumJGx/fRxmbXe1QB8jWyecURAmFy/hVlleZJdU
 0nQXwRs2yolSp8JFnV631nP6HsSIMNAATXqPnlG0kS3XGFPERKDWpmqwpfqbW3EVB382
 ju3MSxDXmk3Pdi37WhQiyqrdNjRFa38eQzEBTopXpkElUPodf5M0lnabQV13+Q9tef4C
 fg7d93u/sYKSCAAY7xmdPH+w7ZH6J9NBHlqNN7qDluSY8HUXxyG44Dw8v+3UMiKbVP/G
 ITJN2AfKqSUV6gE+mQkK7tRTRi5VxrBekVt9hCxnlDKruU11L6OFBOItGVRS79XaGbuP
 zjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757000833; x=1757605633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ly0Uw2HSTv1mCwT12MXqsgrBCGp5zOffCN0UNp08lAs=;
 b=sFSpKEbM60L4vrLmP63tuTrqHjXHonBRkYG1/IZzXvOJMgZeA73vbmOy3WSReCfh21
 cXYWLgiA2fSaWFWnbMJXZigkUK5Sq//PZcAj6MP85lHgtqpwx8JWKBVs37ytn+u7Jb66
 hlKe725w221kHB1IbTrMAsDKBFdRf9hkiPBPNnAwtwde5m8uhfFRNdUbov2AV9ru9m0h
 J+LclDrRQwOiSasCS/uCTiBZxhnk9LP6j1GI4WRrRvAtjRSGXx/W/kAMlP7yGOm9bKWs
 AhH4KTUSwSJYBmTnafb0WHESPYF40v2b/A9uoMmf8p8+s+cHfBL9kBWh+XZtake06zIv
 VpOw==
X-Gm-Message-State: AOJu0YzZj8FUZf9WVFRWR72D+fRNOYwQzf0mCSOFCISDuZExoPI6foLJ
 sOvqIV6e1oOGfOuejM+8yIZGyyV2ZibTpYEBxkv5RNVyb7wOsBClYtQNCaNbiG7/ctB2MJMD78K
 FWTzfmtKHPQ==
X-Gm-Gg: ASbGncvXp5Sa4fjamdEztOUHfFKedsjxQQX69Bia36vCBwR1Sj6pg+Qs3NxApKTqytB
 3zYqrKM2x7maOyO+PfHl2xjMMlfmZGsxORG4AUKpbGuulVTceUtI/tLZ7rxMT4ju/JCj69L2MtH
 eIPpi/GACiPDiN/gmaCOz8iVn0MTuD+C/6ECIPry32jxRkK1v/N88r+ntov13ocjWHoKLrV7o93
 uXE0Zbu4bXYCL0skzUOZ6NmaaSOY6Xq01CF03S4o+Hai4fDe3nfPHYam+4V9datSc4ekKcOAen7
 LIiOYM3WSJCnZTrF8NM3rYKTWbfYmApoPtXSPz0P2V3Px3UOe/N3Cj+rkdJIevd7Yp3ZM6hExj7
 Siw1md7Mx0sMkb+ke5ug97/85qKA5
X-Google-Smtp-Source: AGHT+IHFjcODdw0kEcwKl4L5wi+0ipardMLyHLfTEl29Z2W0X38mLEXrv+P1oEoTZZCCFwtg/vsT2Q==
X-Received: by 2002:a05:6122:2022:b0:544:9414:105d with SMTP id
 71dfb90a1353d-5449ff8d510mr7461027e0c.0.1757000832746; 
 Thu, 04 Sep 2025 08:47:12 -0700 (PDT)
Received: from gromero0.. ([186.215.58.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a666da0csm6497022e0c.28.2025.09.04.08.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 08:47:12 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2 4/5] tests/functional: Support tests that require a runner
Date: Thu,  4 Sep 2025 15:46:39 +0000
Message-Id: <20250904154640.52687-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154640.52687-1-gustavo.romero@linaro.org>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add support for running tests that require a specific runner.

The test is specified via a tuple (name, runner, protocol), where name
is the test name as found in the tests/functional directory without the
'test_' prefix and the .py extension, runner is an array containing the
runner and any arguments required by the runner, and protocol is
the test protocol used by Meson to determine whether the test passed or
failed.

The test tuples are added to arrays that follow the current naming
logic but with the suffix '_with_runner' appended to their names. In
Meson it's not easy to select an element in an array at runtime based on
its type, so it's simpler to have a new array for these new test types
than use the current ones from the tests that don't require a runner,
and so avoid mixing strings and tuples in the same array.

Currently there is only one runner, the GDB runner, but more runners can
be defined and associated to a test via the tuple.

The GDB runner is only defined if GDB is detected. The probe is done
in 'configure' and the full path is passed to meson.build via the -Dgdb=
option.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configure                     |  2 ++
 meson.build                   |  4 +++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  2 ++
 tests/functional/meson.build  | 65 +++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+)

diff --git a/configure b/configure
index 274a778764..8e2e2cd562 100755
--- a/configure
+++ b/configure
@@ -1978,6 +1978,8 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
+  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
+
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
   }
diff --git a/meson.build b/meson.build
index 0d42de61ae..7e0afe8288 100644
--- a/meson.build
+++ b/meson.build
@@ -75,6 +75,10 @@ have_user = have_linux_user or have_bsd_user
 
 sh = find_program('sh')
 python = import('python').find_installation()
+# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly return the
+# site-packages dir in pyvenv, so it is built manually.
+python_ver = python.language_version()
+python_site_packages = meson.build_root() / 'pyvenv/lib/python' + python_ver / 'site-packages'
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
diff --git a/meson_options.txt b/meson_options.txt
index fff1521e58..5bb41bcbc4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -36,6 +36,8 @@ option('trace_file', type: 'string', value: 'trace',
 option('coroutine_backend', type: 'combo',
        choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
+option('gdb', type: 'string', value: '',
+       description: 'Path to GDB')
 
 # Everything else can be set via --enable/--disable-* option
 # on the configure script command line.  After adding an option
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0ebe6bc52a..f4bd21220e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -58,6 +58,7 @@ meson_options_help() {
   printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
+  printf "%s\n" '  --gdb=VALUE              Path to GDB'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
   printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
   printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
@@ -323,6 +324,7 @@ _meson_option_parse() {
     --disable-fuzzing) printf "%s" -Dfuzzing=false ;;
     --enable-gcrypt) printf "%s" -Dgcrypt=enabled ;;
     --disable-gcrypt) printf "%s" -Dgcrypt=disabled ;;
+    --gdb=*) quote_sh "-Dgdb=$2" ;;
     --enable-gettext) printf "%s" -Dgettext=enabled ;;
     --disable-gettext) printf "%s" -Dgettext=disabled ;;
     --enable-gio) printf "%s" -Dgio=enabled ;;
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 2a0c5aa141..febd31a263 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -9,6 +9,25 @@ if get_option('tcg_interpreter')
   subdir_done()
 endif
 
+# Define the GDB runner if GDB is available.
+gdb = get_option('gdb')
+if gdb != ''
+    gdb_runner_script =  meson.project_source_root() + '/tests/guest-debug/run-test.py'
+    gdb_runner = [gdb_runner_script, '--quiet', '--gdb', gdb, '--test']
+
+    message('GDB runner defined based on GDB found at: ', gdb)
+
+    # A test with a runner is a tuple (name, runner, protocol).
+    # The tests must be elements of an array named like:
+    #
+    # test_<arch>_<mode=[system|linuxuser|bsduser]>_<speed=[quick|thorough]>_with_runner = [
+    #      ['test0', gdb_runner, 'exitcode'],
+    #      ...
+    # ]
+else
+    message('GDB not found, skipping functional tests that rely on it.')
+endif
+
 subdir('aarch64')
 subdir('alpha')
 subdir('arm')
@@ -61,9 +80,11 @@ foreach speed : ['quick', 'thorough']
       suites = ['func-quick', 'func-' + target_base]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
                      + get_variable('tests_generic_' + sysmode)
+      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_quick_with_runner', [])
     else
       suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
+      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed + '_with_runner', [])
     endif
 
     test_deps = [roms, keymap_targets]
@@ -121,6 +142,50 @@ foreach speed : ['quick', 'thorough']
            priority: time_out,
            suite: suites)
     endforeach
+
+    # Prepare tests that require a specific runner.
+    foreach test : target_tests_r
+      testname = '@0@-@1@'.format(target_base, test[0])
+      testfile = target_base / 'test_' + test[0] + '.py'
+      testpath = meson.current_source_dir() / testfile
+      teststamp = testname + '.tstamp'
+      testrunner  = test[1]
+      testproto = test[2]
+
+      # python_site_packages, i.e., site packages from Python in pyvenv, is
+      # added to PYTHONPATH because some runners can run a program that has its
+      # own Python hooks that, by its turn, will search for modules based on
+      # PYTHONPATH independently of the Python used by the runner, like, for
+      # example, GDB using libpython.
+      test_r_precache_env = test_precache_env
+      test_r_precache_env.append('PYTHONPATH', python_site_packages)
+      # For similar reasons, PYTHONPATH must also include the path to the test
+      # scripts, otherwise unittest's introspection will failed.
+      test_r_precache_env.append('PYTHONPATH', meson.current_source_dir() / target_base)
+
+      precache = custom_target('func-precache-' + testname,
+                               output: teststamp,
+                               command: [testrunner, testpath],
+                               depend_files: files(testpath),
+                               build_by_default: false,
+                               env: test_r_precache_env)
+      precache_all += precache
+
+      # See comments above about PYTHONPATH in test_r_precache_env.
+      test_r_env = test_env
+      test_r_env.append('PYTHONPATH', python_site_packages)
+      test_r_env.append('PYTHONPATH', meson.current_source_dir() / target_base)
+
+      test('func-' + testname,
+           python,
+           depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
+           env: test_r_env,
+           args: [testrunner, testpath],
+           protocol: testproto,
+           timeout: time_out,
+           priority: time_out,
+           suite: suites)
+    endforeach
   endforeach
 endforeach
 
-- 
2.34.1


