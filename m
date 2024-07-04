Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E5EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEU-0006VW-Am; Thu, 04 Jul 2024 05:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJET-0006Ts-K6
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJER-00086j-L0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N0DGMBLdUJU6MGQY9/L+nCIIpSUEpfUpuzcsMB0WKM=;
 b=Dp5r/FZEdmnvEtbp2qzH+Xfyykh7V41OkAAYjTOyOfQUM0hI5/kRO0fSSL4Kh+qyAmh13M
 nPHWCacujaaT/XvfdVPGfh+yQYNW8+FyTMm4MXAlXthG/rsB39qq8vfuFFstiZBuXf0tmC
 47Zxoj3X/hqZiY2iqM5pMyD+OPl4DMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-h-WfUvmIMZW3PklneYv-9w-1; Thu, 04 Jul 2024 05:58:24 -0400
X-MC-Unique: h-WfUvmIMZW3PklneYv-9w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367988464ceso459301f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087102; x=1720691902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1N0DGMBLdUJU6MGQY9/L+nCIIpSUEpfUpuzcsMB0WKM=;
 b=Eobs/WQ/D8MLblwMRDm5ZQl0ZQ7HpJYnjaY/OWsE5DQaM0xaulWYIDlIsbtZSUxBWI
 zH7zuNmGBM8xKYFThrD3arxOtuXOFQkCXQqLnb4Q3ag8YJh6XZ5mpQH0Jso04gRYU7QB
 iewh54d+i5d/ECj5wRaqUjwXg0f+PO/1KtDo6AKQvH1DH8C8YBGvCWVqHcGrV3f1uK1C
 wLqT+dlZO6XZ8YGxJ45tHl/+6PHCoip+h0EaUgFfXCaAEvU45VhxaugJOYgZCBixrAii
 XGHoPCdcrCSqC7OEUYXAWevgbJuZBDKwO1H9QvBHM5MqfWzHVA+NzuQBmqoPVhlQJCNO
 wDGw==
X-Gm-Message-State: AOJu0YwEagxkMmsDhckR7vKniqMsBoUic9q1d8WVecj6dEuHcCmB6an2
 fzFVDJ1ICmp1/El4ecD7DORADlsBKo7foNbMUUyzqSgBer+o5jSgviVfzU11FC4TpUeC/f0i62T
 kbVYVNxXr8L5e2P5/YKZsrUJnyAaDvD4IcN5OxX0RXM2a8M52Fi8rCl0jiqr8sxoQMpVb/WzV9Z
 zxaASEb2gSaT344vWA7B2Axm1j10iegiKiCSyP
X-Received: by 2002:a5d:4a0f:0:b0:362:4f55:6c43 with SMTP id
 ffacd0b85a97d-3679db85d0fmr1208928f8f.0.1720087102338; 
 Thu, 04 Jul 2024 02:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6qY4ODdap4c8e5LMVSMHHUmgBnUr+8QIKFzKeYVMLXzCYK22f/OXAxkiE4Xges97ML8okVw==
X-Received: by 2002:a5d:4a0f:0:b0:362:4f55:6c43 with SMTP id
 ffacd0b85a97d-3679db85d0fmr1208913f8f.0.1720087101926; 
 Thu, 04 Jul 2024 02:58:21 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a112b3f0sm582326f8f.19.2024.07.04.02.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 06/16] meson: Drop the .fa library suffix
Date: Thu,  4 Jul 2024 11:57:56 +0200
Message-ID: <20240704095806.1780273-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The non-standard .fa library suffix breaks the link source
de-duplication done by Meson so drop it.

The lack of link source de-duplication causes AddressSanitizer to
complain ODR violations, and makes GNU ld abort when combined with
clang's LTO.

Fortunately, the non-standard suffix is not necessary anymore for
two reasons.

First, the non-standard suffix was necessary for fork-fuzzing.
Meson wraps all standard-suffixed libraries with --start-group and
--end-group. This made a fork-fuzz.ld linker script wrapped as well and
broke builds. Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
scaffolding") dropped fork-fuzzing so we can now restore the standard
suffix.

Second, the libraries are not even built anymore, because it is
possible to just use the object files directly via extract_all_objects().

The occurences of the suffix were detected and removed by performing
a tree-wide search with 'fa' and .fa (note the quotes and dot).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240524-xkb-v4-4-2de564e5c859@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst         |  5 -----
 meson.build                         | 17 ++---------------
 stubs/blk-exp-close-all.c           |  2 +-
 .gitlab-ci.d/buildtest-template.yml |  2 --
 .gitlab-ci.d/buildtest.yml          |  2 --
 gdbstub/meson.build                 |  2 --
 tcg/meson.build                     |  2 --
 tests/Makefile.include              |  2 +-
 tests/qtest/libqos/meson.build      |  1 -
 9 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 39a1934c63f..79eceb179de 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -235,16 +235,11 @@ Subsystem sourcesets:
   are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
-                                name_suffix: 'fa',
                                 build_by_default: false)
 
     chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false),
                                  dependencies: chardev_ss.dependencies())
 
-  As of Meson 0.55.1, the special ``.fa`` suffix should be used for everything
-  that is used with ``link_whole``, to ensure that the link flags are placed
-  correctly in the command line.
-
 Target-independent emulator sourcesets:
   Various general purpose helper code is compiled only once and
   the .o files are linked into all output binaries that need it.
diff --git a/meson.build b/meson.build
index 429899d8603..3a1ad4ddeb4 100644
--- a/meson.build
+++ b/meson.build
@@ -3467,7 +3467,6 @@ endif
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa',
                         build_by_default: false)
 qom = declare_dependency(objects: libqom.extract_all_objects(recursive: false),
                          dependencies: qom_ss.dependencies())
@@ -3475,7 +3474,6 @@ qom = declare_dependency(objects: libqom.extract_all_objects(recursive: false),
 event_loop_base = files('event-loop-base.c')
 event_loop_base = static_library('event-loop-base',
                                  sources: event_loop_base + genh,
-                                 name_suffix: 'fa',
                                  build_by_default: false)
 event_loop_base = declare_dependency(objects: event_loop_base.extract_all_objects(recursive: false),
                                      dependencies: [qom])
@@ -3728,7 +3726,6 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 authz = declare_dependency(objects: libauthz.extract_all_objects(recursive: false),
@@ -3737,7 +3734,6 @@ authz = declare_dependency(objects: libauthz.extract_all_objects(recursive: fals
 crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
-                           name_suffix: 'fa',
                            build_by_default: false)
 
 crypto = declare_dependency(objects: libcrypto.extract_all_objects(recursive: false),
@@ -3747,14 +3743,12 @@ io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
-                       name_suffix: 'fa',
                        build_by_default: false)
 
 io = declare_dependency(objects: libio.extract_all_objects(recursive: false),
                         dependencies: [io_ss.dependencies(), crypto, qom])
 
 libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
                               build_by_default: false)
 migration = declare_dependency(objects: libmigration.extract_all_objects(recursive: false),
                                dependencies: [qom, io])
@@ -3763,7 +3757,6 @@ system_ss.add(migration)
 block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 block = declare_dependency(objects: libblock.extract_all_objects(recursive: false),
@@ -3772,7 +3765,6 @@ block = declare_dependency(objects: libblock.extract_all_objects(recursive: fals
 blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
-                             name_suffix: 'fa',
                              build_by_default: false)
 
 blockdev = declare_dependency(objects: libblockdev.extract_all_objects(recursive: false),
@@ -3781,14 +3773,12 @@ blockdev = declare_dependency(objects: libblockdev.extract_all_objects(recursive
 qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qmp = declare_dependency(objects: libqmp.extract_all_objects(recursive: false),
                          dependencies: qmp_ss.dependencies())
 
 libchardev = static_library('chardev', chardev_ss.sources() + genh,
-                            name_suffix: 'fa',
                             dependencies: chardev_ss.dependencies(),
                             build_by_default: false)
 
@@ -3797,7 +3787,6 @@ chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive:
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
-                           name_suffix: 'fa',
                            build_by_default: false)
 hwcore = declare_dependency(objects: libhwcore.extract_all_objects(recursive: false))
 common_ss.add(hwcore)
@@ -3820,8 +3809,7 @@ common_all = static_library('common',
                             sources: common_ss.all_sources() + genh,
                             include_directories: common_user_inc,
                             implicit_include_directories: false,
-                            dependencies: common_ss.all_dependencies(),
-                            name_suffix: 'fa')
+                            dependencies: common_ss.all_dependencies())
 
 feature_to_c = find_program('scripts/feature_to_c.py')
 
@@ -3930,8 +3918,7 @@ foreach target : target_dirs
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
-                 build_by_default: false,
-                 name_suffix: 'fa')
+                 build_by_default: false)
 
   if target.endswith('-softmmu')
     execs = [{
diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
index 1c713167639..2f68e06d7d0 100644
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
index 278a5ea966d..8f7ebfaed8b 100644
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
index 0eec5703109..425fc6479ba 100644
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
index c56b54eae7e..dff741ddd4d 100644
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
 
 gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
diff --git a/tcg/meson.build b/tcg/meson.build
index 165e773abbe..69ebb4908a6 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -31,7 +31,6 @@ tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
-                             name_suffix: 'fa',
                              dependencies: tcg_ss.dependencies(),
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
@@ -42,7 +41,6 @@ user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
-                                name_suffix: 'fa',
                                 dependencies: tcg_ss.dependencies(),
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c9d1674bd07..d39d5dd6a43 100644
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
index 05fe57a4b97..1b2b2dbb22e 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -69,7 +69,6 @@ if have_virtfs
 endif
 
 libqos = static_library('qos', libqos_srcs + genh,
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qos = declare_dependency(objects: libqos.extract_all_objects(recursive: false))
-- 
2.45.2


