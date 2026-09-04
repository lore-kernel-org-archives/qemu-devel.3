Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CA7C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJM-0006Bp-R5; Fri, 04 Sep 2026 08:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ9-00067P-Rl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ5-0006nN-96
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so11151755e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525970; x=1789130770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xf02Z7MjN/uTSye2Ksb/ujP8/tPJPYv/wSoKUIQa3fo=;
 b=O8yxfowavQg04lkQZRxJotrX3DpnsF+w9MA9x/l2D7twtKC2/bmZPsMkUBmJVvxZnA
 iDewfUyb45QA5vIi9kLugMdVvvZlsxyEnj+Qk0ga5b66ru4ixNnc+YBMVVttdIFj6WjG
 oUP5yuAyvS2WtDZfS39Z6xuI/jkco0zBUPrWZ5hY8V7E9pb3KKnV84KwhknTnd3Nzdm8
 W4gEYZGr7enYNuCb5gegHr6L5viixtNGmR8TUMwXcwS0sP19L4GIhO0KqvVreSmybBsd
 Pix6maRQ52fi3Nk2kn8lDbnjItJaHD6RWG4XphlchLLFmPyAU2bXF3iOutn+EpedJu78
 StNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525970; x=1789130770;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xf02Z7MjN/uTSye2Ksb/ujP8/tPJPYv/wSoKUIQa3fo=;
 b=eutQ1FPbrRetX+imX/L5IeyqRSFQXZj8QcEvpStiIUu+kgQwMyjFyeRd7Ox+NZcdft
 Y1f7C2oNZXWeEygwqXLw3NbchfZxfKuJi/1hoT3E/7Re6kYSfDkr6w0U9kWzG+R4wTf0
 cJ9YAkOB26tH+wOC/dJ26c+5kHPhdaT80auysummU0vf9Jhdwv0wUMkndczSMyYSWJXG
 t0g1r2qkMiXHjnj9QJ7+n29rii4e+/TqvyX0nsIMfdYiL741leyuKs3hUVD1NeGrEt16
 gLpWBl51MJVrbOwkED4gT5J9IDkzH9rBkVzroXWK8jwrG8P1ngOD6XvNBzD8SaEXclIR
 3SdQ==
X-Gm-Message-State: AFuF++nLa05Qb+WQlrrQlmElLFgelgVRNGYTkFKr3AuHx2j14IMxM38I
 vY36laY8dF0dgiTCpmnld8nNAbXgeOTXj+1f1KA/XjrGf+9NtcvL2/NnQy27EvxNqGk=
X-Gm-Gg: AYBFou3k5xWfHn8t9incPZp4qdsPt+o4tY8cXyr6DmP/ovgYiSEWJC01GIGIftEqyl5
 3hlE8GpOwCMmobo7xh2+7FSE0vq+/hBQPJsbIrYBsWwZo4LVu10s45dRIyjlpJcneI7ppoVUOZT
 Js2pIzUI6rtaWB3/n5St+VldKhs34TtR1BJ1tdGwGwkI4RbOtXu2YD3kJSTPK1fnhrExc9qdutM
 90cS9ooWc5sKWbc4soP9xjRLiZvJIpjkWQ4Fj3D280IvndCv0hjsN98yhMDjFZUJDEjLWjno2Nh
 aPMZmeHC1a2lm7fLQ7R6mF8SiUn1fS1GBToMFCttrHb5XRgXITK8c8hwJz6NX5HLDp1hlfVkGSo
 WSlnTnTsCHdlMlT5uWi/u8uvLloiYJHhqg4TVwI0aLBLy1Al3/N1/jDRA69g72jEoENq+xgI6n+
 1ZZop/EdMJkBzCpzknFvtjJp0JocESs43DnGhNdGboLE6bIX8AVE5jmoIsQFKC5mmwCeRaLTBjW
 A==
X-Received: by 2002:a05:600c:34c9:b0:49c:f729:d757 with SMTP id
 5b1f17b1804b1-49cf824f757mr65176235e9.11.1788525969593; 
 Fri, 04 Sep 2026 05:46:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm398591165e9.0.2026.09.04.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB6D06006B;
 Fri, 04 Sep 2026 13:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 005/105] tests/tcg: introduce meson.build
Date: Fri,  4 Sep 2026 13:44:19 +0100
Message-ID: <20260904124604.2207440-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Every target declare its tests, and add them in global tcg_tests
dictionary, indexed by target name. See comment for full description.

We make sure that if a user repeats a test several time it won't result
in duplicated executables or tests. In next commits, we'll introduce
what's needed to deal with that.

A test is compiled from a single source file (and later, a single set of
compile flags). We make sure dependencies are correctly handled by
generating a depfile.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-6-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/meson.build b/tests/meson.build
index 9ba04bbedd3..5877d2f60b1 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -74,7 +74,7 @@ subdir('decode')
 
 if 'CONFIG_TCG' in config_all_accel
   subdir('fp')
-  subdir('tcg/plugins')
+  subdir('tcg')
 endif
 
 subdir('audio')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
new file mode 100644
index 00000000000..5758c7cc0b7
--- /dev/null
+++ b/tests/tcg/meson.build
@@ -0,0 +1,96 @@
+env = find_program('env')
+
+tcg_tests = {}
+# tcg_tests is a dictionary with following structure:
+#
+# {
+#   'name_of_target': {
+#     'cc': cross_compiler,
+#     'folder': 'folder_for_test_src_files',
+#     'qemu': emulators['qemu-...'],
+#     'tests': [
+#       {
+#         'src_file': {
+#         }
+#       },
+#       ...
+#     ]
+#   }
+# }
+#
+# Every test executable, is built only once.
+# Tests for a given src use the same executable by default, and their definition
+# is guaranteed to be unique also.
+# Default name is derived from src.
+
+# plugins come first, as we need to build the list
+subdir('plugins')
+
+# Finally, we can create all test executables and test targets
+foreach target, plan: tcg_tests
+  # Detect duplicated executables/tests, and report an error to force user to
+  # choose how to deal with it.
+  built_tests = {}
+  added_tests = {}
+
+  # return a clear error if user misspell a target entry
+  foreach key, _ : plan
+    allowed = ['cc', 'folder', 'qemu', 'tests']
+    if key not in allowed
+      error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
+            ' (possible: [' + ', '.join(allowed) + '])')
+    endif
+  endforeach
+
+  cc = plan['cc']
+  folder = plan['folder']
+  qemu = plan['qemu']
+  tests = plan['tests']
+
+  foreach t : tests
+    foreach src, setup: t
+      # meson '/' operator drops left operand if right is an absolute path
+      src = folder / src
+      file = files(src)
+      exe_name = fs.stem(src)
+
+      exe_name = target + '-' + exe_name
+      test_name = exe_name
+
+      if test_name in added_tests
+        error('test ' + test_name + ' was already added: ' +
+              'specify a different \'test_name\'')
+      endif
+
+      # build executable if needed
+      if exe_name not in built_tests
+        exe = custom_target(exe_name,
+                            input: file,
+                            command: [cc, '@INPUT@',
+                                      '-o', '@OUTPUT@', '-static',
+                                      '-MMD', '-MF', '@DEPFILE@',
+                                      '-Wall', '-Werror',
+                                      '-O0', '-g', '-fno-strict-aliasing',
+                                      ],
+                            depfile: exe_name + '.d',
+                            output: exe_name + '.test',
+                            build_by_default: false)
+        built_tests += {exe_name: exe}
+      endif
+
+      depends = []
+
+      exe = built_tests[exe_name]
+      cmd = [qemu, exe]
+
+      # some tests expect QEMU env var to be set
+      cmd = ['QEMU=' + qemu.full_path(), cmd]
+
+      test(test_name, env, args: cmd,
+           depends: depends,
+           timeout: 120,
+           suite: ['tcg', 'tcg-' + target])
+      added_tests += {test_name: true}
+    endforeach
+  endforeach
+endforeach
-- 
2.47.3


