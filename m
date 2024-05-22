Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE3DC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jRO-0003Jx-Tx; Wed, 22 May 2024 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRN-0003Jb-Cu
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRK-0001gc-Jc
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f0537e39b3so8104645ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374601; x=1716979401;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AXNrOY6XSAN87LTQekwElWqie3wSpRJYxE+EDTNlm/M=;
 b=Ex1+qRRd+AL6BiGL2XIfMMoYm1eLjYj7QMX8kbimdPRda9t7yjsg5z0pfDXmD3IqfO
 u2SpyP7FPaA7Z0ilzLcui2i8P2dPO4dzRzfEKHowf9MEP4zd4iZiTEWod2GnqIy4OMWQ
 6gq0nmKWtiDbL+ySq+yygTEzoTwYCmSwemjqA7lzuPbeBTs7zgoPyDvT+TBp4hAXOfK7
 KRU+ixd2TmNrsWJkeFxfsW8ZPOa/ytXeE67lj0KXFUxtTNqTO/KN6ybqkPKCQLaMJuiX
 QohSC9MjnOdgoHlDCwgQ2uh/2RzB003WQZr8kWZH5iI7JO/jZk1dpXLUVBM8Ad0BpQwg
 9KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374601; x=1716979401;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXNrOY6XSAN87LTQekwElWqie3wSpRJYxE+EDTNlm/M=;
 b=AbE1Mh13uwjk0daHiZ+6BwNrzoqvuMiw84qIj+fU7N6h3kJHf+wQ93SQxvJsaUVraJ
 oeFfESWyaq+kE6ztBpIq6o9VZfn4e4k+4q6rPcH61Y6HvOcWdjew7K5DGs8Shg76h3oW
 UUnIrwZ4JrZDd8VNLZT56IFxx2PiMoBLvmnh9AzZy3LVsVs9b2XbDPMvE5Jt5VQTTcAo
 PtCF9IuQPa8UHyyd3qVr5oto2t6INDDZyvnPuqEomlCx4Sfn1o8j00iZ3XDK/6f6fJAu
 YgKl3sZL/JY9cO1nCd/X2Rcw+4ERpbwfaSWs/qqr8BwS4wz6WYAveS8BPt+BPIZ+Alrz
 Ux1g==
X-Gm-Message-State: AOJu0YzfuYcLAZvBAMdlbuvyX3DY+XrhVFOCX0ly9+O9GwliYogCp5Ak
 Gr0xSvMu+fzCgbKkltlgginlot9rukYMi38lxlwiQvDY4dKJozvRBB9zxS1/SeI=
X-Google-Smtp-Source: AGHT+IFGm67Cu7osmcWiLFenFZ/QeE2B2in9ubpDYMH5wkOseLmiIfGfBTfNJse+DF/vdZhSnsu8+w==
X-Received: by 2002:a17:902:f786:b0:1e8:9f46:c1af with SMTP id
 d9443c01a7336-1f31c9ecdeamr20353925ad.63.1716374601260; 
 Wed, 22 May 2024 03:43:21 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f0934f3abcsm135458665ad.153.2024.05.22.03.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:43:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 22 May 2024 19:43:04 +0900
Subject: [PATCH v2 3/3] meson: Drop the .fa library prefix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-xkb-v2-3-67b54fa7c98f@daynix.com>
References: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
In-Reply-To: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The non-standard .fa library prefix breaks the link source
de-duplication done by Meson so drop it.

The lack of link source de-duplication causes AddressSanitizer to
complain ODR violations, and makes GNU ld abort when combined with
clang's LTO.

Previously, the non-standard prefix was necessary for fork-fuzzing.
Meson wraps all standard-prefixed libraries with --start-group and
--end-group. This made a fork-fuzz.ld linker script wrapped as well and
broke builds. Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
scaffolding") dropped fork-fuzzing so we can now restore the standard
prefix.

The occurances of the prefix was detected and removed by performing
a tree-wide search with 'fa' and .fa (note the quotes and dot).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/build-system.rst         | 5 -----
 stubs/blk-exp-close-all.c           | 2 +-
 .gitlab-ci.d/buildtest-template.yml | 2 --
 .gitlab-ci.d/buildtest.yml          | 2 --
 gdbstub/meson.build                 | 2 --
 tcg/meson.build                     | 2 --
 tests/Makefile.include              | 2 +-
 tests/qtest/libqos/meson.build      | 1 -
 8 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 09caf2f8e199..5baf027b7614 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -236,15 +236,10 @@ Subsystem sourcesets:
   are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
-                                name_suffix: 'fa',
                                 build_by_default: false)
 
     chardev = declare_dependency(link_whole: libchardev)
 
-  As of Meson 0.55.1, the special ``.fa`` suffix should be used for everything
-  that is used with ``link_whole``, to ensure that the link flags are placed
-  correctly in the command line.
-
 Target-independent emulator sourcesets:
   Various general purpose helper code is compiled only once and
   the .o files are linked into all output binaries that need it.
diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
index 1c7131676392..2f68e06d7d05 100644
--- a/stubs/blk-exp-close-all.c
+++ b/stubs/blk-exp-close-all.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "block/export.h"
 
-/* Only used in programs that support block exports (libblockdev.fa) */
+/* Only used in programs that support block exports (libblockdev.a) */
 void blk_exp_close_all(void)
 {
 }
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 22045add8064..69e468a576ba 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -45,10 +45,8 @@
     exclude:
       - build/**/*.p
       - build/**/*.a.p
-      - build/**/*.fa.p
       - build/**/*.c.o
       - build/**/*.c.o.d
-      - build/**/*.fa
 
 .common_test_job_template:
   extends: .base_job_template
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfdff175c389..c156e6f1d90e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -178,10 +178,8 @@ build-previous-qemu:
     exclude:
       - build-previous/**/*.p
       - build-previous/**/*.a.p
-      - build-previous/**/*.fa.p
       - build-previous/**/*.c.o
       - build-previous/**/*.c.o.d
-      - build-previous/**/*.fa
   needs:
     job: amd64-opensuse-leap-container
   variables:
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index da5721d8452b..c91e398ae726 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -19,13 +19,11 @@ gdb_system_ss = gdb_system_ss.apply({})
 
 libgdb_user = static_library('gdb_user',
                              gdb_user_ss.sources() + genh,
-                             name_suffix: 'fa',
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
 libgdb_system = static_library('gdb_system',
                                 gdb_system_ss.sources() + genh,
-                                name_suffix: 'fa',
                                 build_by_default: false)
 
 gdb_user = declare_dependency(link_whole: libgdb_user)
diff --git a/tcg/meson.build b/tcg/meson.build
index 8251589fd4e9..f941413d5801 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -31,7 +31,6 @@ tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
-                             name_suffix: 'fa',
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
@@ -41,7 +40,6 @@ user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
-                                name_suffix: 'fa',
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c9d1674bd070..d39d5dd6a43e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -87,7 +87,7 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 .PHONY: check-venv check-avocado check-acceptance check-acceptance-deprecated-warning
 
 # Build up our target list from the filtered list of ninja targets
-TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
+TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
 
 TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 3aed6efcb8d1..45b81c83ade3 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -68,7 +68,6 @@ if have_virtfs
 endif
 
 libqos = static_library('qos', libqos_srcs + genh,
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qos = declare_dependency(link_whole: libqos)

-- 
2.45.1


