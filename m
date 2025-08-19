Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F22CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOx8-0006Bg-J8; Tue, 19 Aug 2025 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eschwartz93@gmail.com>)
 id 1uoOap-0001cq-0t; Tue, 19 Aug 2025 11:49:47 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eschwartz93@gmail.com>)
 id 1uoOan-0003ht-4w; Tue, 19 Aug 2025 11:49:46 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4b289cdc86aso5917871cf.1; 
 Tue, 19 Aug 2025 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755618583; x=1756223383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xGc0RvBkXVmxTJct1RQl8OVv+1bQNUlhd5ux3jZAZGY=;
 b=QfUq3omz8XBUdw15x8Jr8xYgRZYx7A9LmchSJEu+5tSzeXiCH5Pw7joKpNLPooQXiH
 4Nb29R9yxj9zTI/4e0lZf3qDEPfODBWHyzfm8kNfYbRetg/Wbl+CE5jrrffpugQ0avJY
 fxNM7k2b00RxiCvZcdyDqypnjzsN/OxzNLiUvU3glEV8sHyqBzmwjyj+u7VMvski6Bt0
 tkntnDtEvQqXclSVYJ4yHHIe48MG66bJy8ntLZSC5lSBW9bRfYtcBGWAwL/MB0FxW7/N
 QCV/E8pL7OdGwZFax81M9/79vH2WlHgisvcKb7+hcgmPhErZF/PFXAczL8iIweO3Z81K
 uNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618583; x=1756223383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xGc0RvBkXVmxTJct1RQl8OVv+1bQNUlhd5ux3jZAZGY=;
 b=FBBN1+UtJSyYSfNSIN+va3cVYvFFU58YnP6jy0TWyqCNjDcno9vzIsUlQVpmQUThH4
 iRxIrpLJGja8ZLDOynQasIgNoMr68+7RSsREBQTEHoPzywHiRCpjnSfoRfsJk8ak3PPq
 62XmCjLV9t4bylBBGU0qxTNuZqVDHfSbHnodeZmB9W8ZdL69uUTzM4ESzCRZrTFC0MOS
 xnYej27LzijN97/uzfaKHfVvL12XBHZspwqvcepwlM5WLYAqk2arrhm6bcg8sDndzkQo
 ylKPzsA0LPlAug8F/1HKQxNJEJNlMjNDvrjs6QdL74vRkn+i4xP3F/G5cYFtp65p3BER
 2l4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYMKCdw3Wa1vsDyeIl5q9nHuYYVzq/g578l69e7FYBS7URhlQg8G2kxc9PsRTs4rwUCjlKZ6MnVz8=@nongnu.org
X-Gm-Message-State: AOJu0YxZODRVFKsGBJ8S5Q6q+F95TTsOTTZrGm/vkib4X7k92rf4rt6T
 ZpFc8Wlu+zLErswwSi8NUiGSBOvp3rXY6q7f12ZFsoYbyS/Jf0WdLw2NfbK9KuEC
X-Gm-Gg: ASbGnctx+mtD4ypzmhKR7wLkWme9FGYymZM12mkd1Kj820kZh2EtE3OMRX/L7SFjKbF
 n6j9LxlyZQeohlXMmqvBmHe4BModdQ4Up7xI1/nTFrjZmn9J/6X2fQwMGrHIO8l3g6ONBJ0Hqyd
 Ue44eAUDpqnmz7EDm3fI/YFVUkSqizbxh7AFcJ/zfTZbTyfLLfs11eHhuhK0zURYXtIkfmJzI/Q
 CQ94rYHw9/2SPQ0u/J3OhQnI8NSG+YJEcq+bBQlsJ+rfm/Sr1n9Y55I+LLGYUmbTVB8AAbZ2zlJ
 h2xtzk9A4y9mID8k1FOJ0pEDOVdRCfClY7pOZqsGWDH3mrqK29mWH75bdTS5kyO4ytLfDHpFKpw
 KtwR8ELE+qsMBJATUXj8=
X-Google-Smtp-Source: AGHT+IFaqStKKR4ZBqQXLz+Vola0yFtCBM/gfY0diEMkQRyiP3iwaFuzAcaLjSv0V5qtQaSkFjlJmQ==
X-Received: by 2002:a05:622a:4a89:b0:4b0:f8ee:9355 with SMTP id
 d75a77b69052e-4b286e21764mr34445081cf.30.1755618582564; 
 Tue, 19 Aug 2025 08:49:42 -0700 (PDT)
Received: from acleverhostname.lan ([2603:6011:3f0:cf90::12ac])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b11dc1827esm71258291cf.11.2025.08.19.08.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:49:42 -0700 (PDT)
From: Eli Schwartz <eschwartz93@gmail.com>
X-Google-Original-From: Eli Schwartz <eschwartz@gentoo.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org (open list:Rust-related patc...)
Subject: [PATCH] meson: set test programs to not build by default
Date: Tue, 19 Aug 2025 11:49:40 -0400
Message-ID: <20250819154940.2137965-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=eschwartz93@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Aug 2025 12:12:33 -0400
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

Rather, they are built when running `meson test`. This change is inert
unless building with meson 1.7, as previous versions of meson build all
`meson test` dependencies as part of `ninja all` as well.

See:
https://mesonbuild.com/Release-notes-for-1-7-0.html#test-targets-no-longer-built-by-default

An existing comment references this meson issue, with an included bug
reference, but was written before meson 1.7 fixed the bug. Update the
comment to change the advice from "if the bug gets fixed" to "when
bumping the minimum meson version".

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 qga/meson.build              | 1 +
 rust/qemu-api/meson.build    | 1 +
 tests/fp/meson.build         | 2 ++
 tests/functional/meson.build | 9 ++++-----
 tests/qtest/meson.build      | 2 +-
 tests/unit/meson.build       | 2 +-
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/qga/meson.build b/qga/meson.build
index 89a4a8f713..44175ccedd 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -197,6 +197,7 @@ if host_os != 'windows' and not get_option('fuzzing')
     i = i + 1
   endforeach
   qga_ssh_test = executable('qga-ssh-test', srcs,
+                            build_by_default: false,
                             dependencies: [qemuutil],
                             c_args: ['-DQGA_BUILD_UNIT_TEST'])
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a090297c45..fec38d6726 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -102,6 +102,7 @@ test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
         files('tests/tests.rs', 'tests/vmstate_tests.rs'),
+        build_by_default: false,
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 9059a24752..9c50452bf1 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -57,6 +57,7 @@ fpcflags = [
 fptest = executable(
   'fp-test',
   ['fp-test.c', '../../fpu/softfloat.c'],
+  build_by_default: false,
   dependencies: [qemuutil, libsoftfloat, libtestfloat, libslowfloat],
   c_args: fpcflags,
 )
@@ -149,6 +150,7 @@ executable(
 fptestlog2 = executable(
   'fp-test-log2',
   ['fp-test-log2.c', '../../fpu/softfloat.c'],
+  build_by_default: false,
   dependencies: [qemuutil, libsoftfloat],
   c_args: fpcflags,
 )
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 311c6f1806..6d7dc91954 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -408,11 +408,10 @@ foreach speed : ['quick', 'thorough']
       # Ideally we would add 'precache' to 'depends' here, such that
       # 'build_by_default: false' lets the pre-caching automatically
       # run immediately before the test runs. In practice this is
-      # broken in meson, with it running the pre-caching in the normal
-      # compile phase https://github.com/mesonbuild/meson/issues/2518
-      # If the above bug ever gets fixed, when QEMU changes the min
-      # meson version, add the 'depends' and remove the custom
-      # 'run_target' logic below & in Makefile.include
+      # broken in older versions of meson, with it running the
+      # pre-caching in the normal compile phase. When QEMU changes
+      # the min meson version to >=1.7, add the 'depends' and remove
+      # the custom 'run_target' logic below & in Makefile.include
       test('func-' + testname,
            python,
            depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..0a5309005f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -447,7 +447,7 @@ foreach dir : target_dirs
         deps += test_ss.all_dependencies()
       endif
       qtest_executables += {
-        test: executable(test, src, dependencies: deps)
+        test: executable(test, src, build_by_default: false, dependencies: deps)
       }
     endif
 
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..af9725a3f8 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -189,7 +189,7 @@ foreach test_name, extra: tests
     src += test_ss.all_sources()
     deps += test_ss.all_dependencies()
   endif
-  exe = executable(test_name, src, genh, dependencies: deps)
+  exe = executable(test_name, src, genh, build_by_default: false, dependencies: deps)
 
   test(test_name, exe,
        depends: test_deps.get(test_name, []),
-- 
2.49.1


