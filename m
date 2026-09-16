Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C624C982CF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbH-0002TS-4I; Wed, 16 Sep 2026 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rac-00025L-Cu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:26 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raY-0001MV-58
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:24 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so6635345e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572621; x=1790177421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AJwEWFJNlhZhHGtBDzm5rjgGSC2PicgfXm/bmyyHSjI=;
 b=Lwbigcn2WKYLnBFPG/QIJw1p8T6pYbD7zGZIG/eeXt558H8M05MAcw0FebYGb70S+H
 up7m1GZVeLbHGtIayzsMcU79ohdu5ho6OEs1gfGdLqq9VUseRtbExjZpGUGsQ3mCzWpu
 Bj16FYhZMrM8SfeXilSgTZjUpUhMngqhy2ic4fbfoWiRHByCuW3F/vn6hMhBSc/Yh4bg
 nhOEAkFtpacLDr50tU0mz+tKupF/RwruErpu+ybPMbFuRkllITTnDikYXj0mWc1jhr/+
 TdFOvJCWfb5TLoD7D4v7u9CDrrfy/LJvhubjfz/ZU7Za54D+desDIOxs+Rj9ACE3ivZJ
 BP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572621; x=1790177421;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AJwEWFJNlhZhHGtBDzm5rjgGSC2PicgfXm/bmyyHSjI=;
 b=PvmIcH+s9OsUmgmp2HMS5ZXWf1qJel8UgYOkRytjxwYzROefL02DL5wY7q8y+QhWJi
 izBUaDRysYPbXzyHpIe1jEJDBX9aPBo6cpfsVg98J67V18NrHm/+XlJf1vlvlghUipQ2
 /AIEPGiwdrED/TfC0cUkItPcybS+LOyhzkPxCH6pTDzb1iH6Z/UTBuVxsh46zEXTXV4U
 rF4gyKn/i+otNzbVLzhDTM+wjjgzKGtywQ7/sZQp+MzTLtPYoov/6NPJCDketPKoMmSQ
 L0w4Qnt9Wh1MjnjmiV9aPXwHmywxgSlEIpYTtCWZc3qADJ/JAY9FbO/zMPqIfJMv1G9b
 IgZQ==
X-Gm-Message-State: AFuF++lARBZsFkGA+UzXWLvUzCHHOsj3NdZf+IJQFprnc/cPNW1LMPd9
 cUHyW/yyRXvMyt/tsFp8m4b/M+2ZfLD7YmYd+dbk5/1sAiTyv7jvorlPOuhlJ2as1YA=
X-Gm-Gg: AYBFou3zlx21VIdpRQW06oxs6S15odldri3VVG8uhQPcJzSCcp7YxyH390c2ZPVBstD
 +x1r0/erNl1lb0UIAajF+nFMVS8FW68IEEP94lR8XPcQAaXsF/KZ2/iy0Z5eprCsOP2Rw6CDl3v
 pLQ8PI4eQ4UDPJh3A7nGMBFPDBmw5sbmxqLQo2Iu3BiYKgZKT0l7Z+DVMiHuni8/D/e2DEck+tU
 yHRJOBEWeignEkWRuBYOT0GVXgoKL0sdnQ8czMHIODqoA071mkxFR3Qtmy1j1XOr48uxQCrcIUA
 TIFMRPQ3q39kejQjiVbJ5N/GJT5y629OIXWncZctfBrsBHh2YRzr5OowgvK93kRWo2mXM/+g+/w
 L3S96ozk4u1gltUsBa7260p57+Y+yMRLTGXCYf0SihmwAT6O0fGH9GC+6wk8JxEdcmhU+sKdu1C
 pX59J0nhABFssNqTxWoad5qM8vf+7P9IveUqxxCYaqkMBSeHx7P4Xu7G9Q6sKnLema3JjI8Po=
X-Received: by 2002:a05:600c:6085:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49eac45c06bmr36770935e9.2.1789572620516; 
 Wed, 16 Sep 2026 08:30:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0fef38sm1392095e9.9.2026.09.16.08.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 698AA618D2;
 Wed, 16 Sep 2026 16:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 02/19] Revert "tests/tcg/meson.build: implement ./configure
 -cross-cc-* options"
Date: Wed, 16 Sep 2026 16:29:55 +0100
Message-ID: <20260916153013.2134555-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

We want to keep configuring of the cross compiler within configure so
it can be used by the firmware.

This reverts commit 7e1d54da6faf10e1fc70f6b3d8247068b80b1597.
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - declare empty container_command/use_containers to avoid unref var
---
 configure             | 31 ++++++++-------
 meson_options.txt     | 89 -------------------------------------------
 tests/tcg/meson.build | 31 +++------------
 3 files changed, 23 insertions(+), 128 deletions(-)

diff --git a/configure b/configure
index 1973f023b1e..bedde58b8cf 100755
--- a/configure
+++ b/configure
@@ -172,6 +172,7 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
+container_command=""
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -227,6 +228,19 @@ for opt do
   ;;
   --extra-ldflags=*) EXTRA_LDFLAGS="$EXTRA_LDFLAGS $optarg"
   ;;
+  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
+  ;;
+  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-cflags-}; cc_arch=${cc_arch%%=*}
+                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
+  ;;
+  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
+                eval "cross_cc_${cc_arch}=\$optarg"
+  ;;
+  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
+  ;;
+  --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
+                    eval "cross_prefix_${cc_arch}=\$optarg"
+  ;;
   --without-default-features) default_feature="no"
   ;;
   --wasm64-32bit-address-limit) wasm64_memory64="2"
@@ -246,6 +260,7 @@ ninja=""
 python=
 download="enabled"
 skip_meson=no
+use_containers=""
 rust="disabled"
 rust_target_triple=""
 
@@ -618,19 +633,9 @@ for opt do
   ;;
   --extra-ldflags=*)
   ;;
-  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
-  ;;
-  --cross-cc-cflags-*) arch=${opt#--cross-cc-cflags-}; arch=${arch%%=*}
-                       meson_option_add "-Dtcg_tests_cross_cflags_${arch}=${optarg}"
-  ;;
-  --cross-cc-*) arch=${opt#--cross-cc-}; arch=${arch%%=*}
-                meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}"
-  ;;
-  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
+  --cross-cc-*)
   ;;
-  # cross-prefix is just used as a syntactic sugar for -cross-cc.
-  --cross-prefix-*) arch=${opt#--cross-prefix-}; arch=${arch%%=*}
-                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}gcc"
+  --cross-prefix-*)
   ;;
   --enable-docs) docs=enabled
   ;;
@@ -1273,7 +1278,7 @@ if test "$container_command" = ""; then
     container_command=$($python "$source_path"/tests/docker/docker.py probe)
     test "$container_command" = "no" && container_command=""
 fi
-if test $use_containers = "yes" && test "$container_command" != ""; then
+if test "$use_containers" = "yes" && test "$container_command" != ""; then
     docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
 fi
 
diff --git a/meson_options.txt b/meson_options.txt
index e3570a418aa..66d3689d14c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -393,92 +393,3 @@ option('containers', type: 'boolean', value: true,
        description: 'use containers to cross compile tcg tests')
 option('container_command', type: 'string',
        description: 'command to build/run containers')
-
-option('tcg_tests_cross_cc_aarch64', type: 'string',
-       description: 'cc for aarch64 tcg tests')
-option('tcg_tests_cross_cflags_aarch64', type: 'string',
-       description: 'cflags for aarch64 tcg tests')
-option('tcg_tests_cross_cc_aarch64_be', type: 'string',
-       description: 'cc for aarch64_be tcg tests')
-option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
-       description: 'cflags for aarch64_be tcg tests')
-option('tcg_tests_cross_cc_alpha', type: 'string',
-       description: 'cc for alpha tcg tests')
-option('tcg_tests_cross_cflags_alpha', type: 'string',
-       description: 'cflags for alpha tcg tests')
-option('tcg_tests_cross_cc_arm', type: 'string',
-       description: 'cc for arm tcg tests')
-option('tcg_tests_cross_cflags_arm', type: 'string',
-       description: 'cflags for arm tcg tests')
-option('tcg_tests_cross_cc_hexagon', type: 'string',
-       description: 'cc for hexagon tcg tests')
-option('tcg_tests_cross_cflags_hexagon', type: 'string',
-       description: 'cflags for hexagon tcg tests')
-option('tcg_tests_cross_cc_hppa', type: 'string',
-       description: 'cc for hppa tcg tests')
-option('tcg_tests_cross_cflags_hppa', type: 'string',
-       description: 'cflags for hppa tcg tests')
-option('tcg_tests_cross_cc_i386', type: 'string',
-       description: 'cc for i386 tcg tests')
-option('tcg_tests_cross_cflags_i386', type: 'string',
-       description: 'cflags for i386 tcg tests')
-option('tcg_tests_cross_cc_loongarch64', type: 'string',
-       description: 'cc for loongarch64 tcg tests')
-option('tcg_tests_cross_cflags_loongarch64', type: 'string',
-       description: 'cflags for loongarch64 tcg tests')
-option('tcg_tests_cross_cc_m68k', type: 'string',
-       description: 'cc for m68k tcg tests')
-option('tcg_tests_cross_cflags_m68k', type: 'string',
-       description: 'cflags for m68k tcg tests')
-option('tcg_tests_cross_cc_mips', type: 'string',
-       description: 'cc for mips tcg tests')
-option('tcg_tests_cross_cflags_mips', type: 'string',
-       description: 'cflags for mips tcg tests')
-option('tcg_tests_cross_cc_mips64', type: 'string',
-       description: 'cc for mips64 tcg tests')
-option('tcg_tests_cross_cflags_mips64', type: 'string',
-       description: 'cflags for mips64 tcg tests')
-option('tcg_tests_cross_cc_mips64el', type: 'string',
-       description: 'cc for mips64el tcg tests')
-option('tcg_tests_cross_cflags_mips64el', type: 'string',
-       description: 'cflags for mips64el tcg tests')
-option('tcg_tests_cross_cc_or1k', type: 'string',
-       description: 'cc for or1k tcg tests')
-option('tcg_tests_cross_cflags_or1k', type: 'string',
-       description: 'cflags for or1k tcg tests')
-option('tcg_tests_cross_cc_ppc64', type: 'string',
-       description: 'cc for ppc64 tcg tests')
-option('tcg_tests_cross_cflags_ppc64', type: 'string',
-       description: 'cflags for ppc64 tcg tests')
-option('tcg_tests_cross_cc_ppc64le', type: 'string',
-       description: 'cc for ppc64le tcg tests')
-option('tcg_tests_cross_cflags_ppc64le', type: 'string',
-       description: 'cflags for ppc64le tcg tests')
-option('tcg_tests_cross_cc_riscv64', type: 'string',
-       description: 'cc for riscv64 tcg tests')
-option('tcg_tests_cross_cflags_riscv64', type: 'string',
-       description: 'cflags for riscv64 tcg tests')
-option('tcg_tests_cross_cc_s390x', type: 'string',
-       description: 'cc for s390x tcg tests')
-option('tcg_tests_cross_cflags_s390x', type: 'string',
-       description: 'cflags for s390x tcg tests')
-option('tcg_tests_cross_cc_sh4', type: 'string',
-       description: 'cc for sh4 tcg tests')
-option('tcg_tests_cross_cflags_sh4', type: 'string',
-       description: 'cflags for sh4 tcg tests')
-option('tcg_tests_cross_cc_tricore', type: 'string',
-       description: 'cc for tricore tcg tests')
-option('tcg_tests_cross_cflags_tricore', type: 'string',
-       description: 'cflags for tricore tcg tests')
-option('tcg_tests_cross_cc_x86_64', type: 'string',
-       description: 'cc for x86_64 tcg tests')
-option('tcg_tests_cross_cflags_x86_64', type: 'string',
-       description: 'cflags for x86_64 tcg tests')
-option('tcg_tests_cross_cc_xtensa', type: 'string',
-       description: 'cc for xtensa tcg tests')
-option('tcg_tests_cross_cflags_xtensa', type: 'string',
-       description: 'cflags for xtensa tcg tests')
-option('tcg_tests_cross_cc_xtensaeb', type: 'string',
-       description: 'cc for xtensaeb tcg tests')
-option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
-       description: 'cflags for xtensaeb tcg tests')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d41a228fb3d..ce208e686ff 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -185,8 +185,6 @@ foreach target, plan: tcg_tests
     continue
   endif
 
-  cc_arch = target.replace('-linux-user', '').replace('-softmmu', '')
-
   # Detect duplicated executables/tests, and report an error to force user to
   # choose how to deal with it.
   built_tests = {}
@@ -204,35 +202,16 @@ foreach target, plan: tcg_tests
   endforeach
 
   cc = find_program(plan['cc'], required : false)
-  cc_cflags = []
-
-  check_flags = []
-  check_required = false
-  cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
-  if cross_cc != ''
-    # we make sure cross cc exists
-    cc = find_program(cross_cc, required: true)
-    check_required = true
-  endif
-  cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
-  if cross_cflags != ''
-    cc_cflags = cross_cflags.split()
-    # and that cross cc can compile programs
-    check_flags = cc_cflags
-    check_required = true
-  endif
-
   cc_from_system = cc.found()
   has_cc = cc.found()
   if has_cc
+    check_flags = ['-static']
     if target.endswith('softmmu')
-      check_flags += ['-nostdlib', '-ffreestanding', '-r']
-    else
-      check_flags += ['-static']
+      check_flags = ['-nostdlib', '-ffreestanding', '-r']
     endif
 
     cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
-                      check: check_required)
+                      check: false)
     has_cc = cmd.returncode() == 0
     cc_from_system = has_cc
   endif
@@ -368,9 +347,9 @@ foreach target, plan: tcg_tests
         endif
       endif
 
-      cflags = cc_cflags
+      cflags = []
       if 'cflags' in setup
-        cflags += setup['cflags']
+        cflags = setup['cflags']
       endif
 
       if 'cc_feat' in setup
-- 
2.47.3


