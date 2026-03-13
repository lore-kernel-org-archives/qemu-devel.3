Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9B103E305
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w14e8-0003nn-1u; Fri, 13 Mar 2026 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w14dy-0003nD-TZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 11:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w14dm-0006UM-TH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 11:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773416488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rRfVL8WQk5sYDmtLKRjDyqwhsn+u76QHfv0CsMogpec=;
 b=BFsEp+VnFddqy8NUD17OIQly3nASrbWw9dlrNNlyP3JUEGgqkpvJI1P8y/KMw9rN2lvELd
 gkLrT5Q1q7Rk2tev2n9bXQV4i+ZtSdKUn77qOxacgp6SKeOCE8hm26EyKt9hWCJ2WpyojB
 1gON7LLtWuP1R+VvOdzzWxe8vJlmv04=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-PGdV3Q0FMgK-abXr6j56Lw-1; Fri,
 13 Mar 2026 11:41:27 -0400
X-MC-Unique: PGdV3Q0FMgK-abXr6j56Lw-1
X-Mimecast-MFC-AGG-ID: PGdV3Q0FMgK-abXr6j56Lw_1773416486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EC131977693; Fri, 13 Mar 2026 15:41:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D03AC1800351; Fri, 13 Mar 2026 15:41:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org (open list:Rust-related patc...)
Subject: [PATCH] rust: fix build when --disable-rust and meson < 1.9
Date: Fri, 13 Mar 2026 19:41:19 +0400
Message-ID: <20260313154119.583396-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit e65030ed50ee moved rust_std and build.rust_std from per-target
override_options into the project's default_options, in order to avoid
repetition.  However, default_options are validated unconditionally at
project initialization, even when Rust is disabled.  This breaks builds
with meson < 1.9.0 which does not know about "build.rust_std":

  meson.build:1:0: ERROR: Unknown option: "build.rust_std".

Move the options back to per-target override_options, using a
rust_default_options variable defined in the top-level meson.build to
avoid the repetition that the original commit was trying to eliminate.

Fixes: e65030ed50ee ("rust: remove unnecessary repetitive options")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build                             | 13 ++++++++++---
 rust/bindings/chardev-sys/meson.build   |  2 +-
 rust/bindings/hwcore-sys/meson.build    |  2 +-
 rust/bindings/migration-sys/meson.build |  2 +-
 rust/bindings/qom-sys/meson.build       |  2 +-
 rust/bindings/system-sys/meson.build    |  2 +-
 rust/bindings/util-sys/meson.build      |  2 +-
 rust/bits/meson.build                   |  1 +
 rust/bql/meson.build                    |  1 +
 rust/chardev/meson.build                |  1 +
 rust/common/meson.build                 |  1 +
 rust/hw/char/pl011/meson.build          |  2 +-
 rust/hw/core/meson.build                |  4 ++--
 rust/hw/timer/hpet/meson.build          |  2 +-
 rust/migration/meson.build              |  1 +
 rust/qemu-macros/meson.build            |  1 +
 rust/qom/meson.build                    |  1 +
 rust/system/meson.build                 |  1 +
 rust/tests/meson.build                  |  1 +
 rust/trace/meson.build                  |  1 +
 rust/util/meson.build                   |  1 +
 21 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index 11139f540b0..92664ad4cf0 100644
--- a/meson.build
+++ b/meson.build
@@ -1,7 +1,6 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
-                          'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
-                          'rust_std=2021', 'build.rust_std=2021'],
+                          'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
 
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
@@ -141,6 +140,12 @@ if have_rust
       native: true, language: 'rust')
 endif
 
+# move this back to projet() default_options, after meson > 1.9 required
+rust_default_options = []
+if have_rust
+  rust_default_options = ['rust_std=2021', 'build.rust_std=2021']
+endif
+
 dtrace = not_found
 stap = not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3919,7 +3924,8 @@ foreach d, list : modules
       module_ss.add(modulecommon)
       module_ss = module_ss.apply(config_all_devices, strict: false)
       sl = static_library(d + '-' + m, [genh, module_ss.sources()],
-                          dependencies: module_ss.dependencies(), pic: true)
+                          dependencies: module_ss.dependencies(),
+                          override_options: rust_default_options, pic: true)
       if d == 'block'
         block_mods += sl
       else
@@ -4443,6 +4449,7 @@ foreach target : target_dirs
     emulator = executable(exe_name, exe['sources'],
                install: true,
                c_args: c_args,
+               override_options: rust_default_options,
                dependencies: arch_deps + exe['dependencies'],
                objects: lib.extract_all_objects(recursive: true),
                link_depends: [block_syms, qemu_syms],
diff --git a/rust/bindings/chardev-sys/meson.build b/rust/bindings/chardev-sys/meson.build
index 458075b8060..698281e5e85 100644
--- a/rust/bindings/chardev-sys/meson.build
+++ b/rust/bindings/chardev-sys/meson.build
@@ -4,7 +4,7 @@ _bindgen_chardev_rs = rust.bindgen(
 _chardev_sys_rs = static_library(
   'chardev_sys',
   structured_sources(['lib.rs', _bindgen_chardev_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   dependencies: [glib_sys_rs, common_rs, qom_sys_rs, util_sys_rs],
 )
diff --git a/rust/bindings/hwcore-sys/meson.build b/rust/bindings/hwcore-sys/meson.build
index 3d51947b4a4..4efe86f3a9b 100644
--- a/rust/bindings/hwcore-sys/meson.build
+++ b/rust/bindings/hwcore-sys/meson.build
@@ -4,7 +4,7 @@ _bindgen_hwcore_rs = rust.bindgen(
 _hwcore_sys_rs = static_library(
   'hwcore_sys',
   structured_sources(['lib.rs', _bindgen_hwcore_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   dependencies: [common_rs, glib_sys_rs, qom_sys_rs, util_sys_rs, migration_sys_rs, chardev_sys_rs],
 )
diff --git a/rust/bindings/migration-sys/meson.build b/rust/bindings/migration-sys/meson.build
index 9243acba300..c0a27f54fc8 100644
--- a/rust/bindings/migration-sys/meson.build
+++ b/rust/bindings/migration-sys/meson.build
@@ -4,7 +4,7 @@ _bindgen_migration_rs = rust.bindgen(
 _migration_sys_rs = static_library(
   'migration_sys',
   structured_sources(['lib.rs', _bindgen_migration_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   dependencies: [glib_sys_rs, common_rs, util_sys_rs],
 )
diff --git a/rust/bindings/qom-sys/meson.build b/rust/bindings/qom-sys/meson.build
index 8f8ae7d1bc8..2d53a9200ad 100644
--- a/rust/bindings/qom-sys/meson.build
+++ b/rust/bindings/qom-sys/meson.build
@@ -4,7 +4,7 @@ _bindgen_qom_rs = rust.bindgen(
 _qom_sys_rs = static_library(
   'qom_sys',
   structured_sources(['lib.rs', _bindgen_qom_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   dependencies: [glib_sys_rs, util_sys_rs],
 )
diff --git a/rust/bindings/system-sys/meson.build b/rust/bindings/system-sys/meson.build
index aa5e8801149..c15b925d4ee 100644
--- a/rust/bindings/system-sys/meson.build
+++ b/rust/bindings/system-sys/meson.build
@@ -4,7 +4,7 @@ _bindgen_system_rs = rust.bindgen(
 _system_sys_rs = static_library(
   'system_sys',
   structured_sources(['lib.rs', _bindgen_system_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   dependencies: [common_rs, glib_sys_rs, hwcore_sys_rs, migration_sys_rs, qom_sys_rs, util_sys_rs],
 )
diff --git a/rust/bindings/util-sys/meson.build b/rust/bindings/util-sys/meson.build
index c37f50a94bd..b00278904ad 100644
--- a/rust/bindings/util-sys/meson.build
+++ b/rust/bindings/util-sys/meson.build
@@ -4,7 +4,7 @@ _bindgen_util_rs = rust.bindgen(
 _util_sys_rs = static_library(
   'util_sys',
   structured_sources(['lib.rs', _bindgen_util_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   dependencies: [glib_sys_rs],
 )
diff --git a/rust/bits/meson.build b/rust/bits/meson.build
index c0094ffcf38..826503a1773 100644
--- a/rust/bits/meson.build
+++ b/rust/bits/meson.build
@@ -1,6 +1,7 @@
 _bits_rs = static_library(
   'bits',
   'src/lib.rs',
+  override_options: rust_default_options,
   dependencies: [qemu_macros],
 )
 
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index de295d2983e..2666a9f0090 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -9,6 +9,7 @@ endif
 _bql_rs = static_library(
   'bql',
   'src/lib.rs',
+  override_options: rust_default_options,
   rust_args: _bql_cfg,
   dependencies: [glib_sys_rs, util_sys_rs],
 )
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 7b267fd23ae..5062e97e93c 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -1,6 +1,7 @@
 _chardev_rs = static_library(
   'chardev',
   'src/lib.rs',
+  override_options: rust_default_options,
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, common_rs, qemu_macros, chardev_sys_rs],
 )
diff --git a/rust/common/meson.build b/rust/common/meson.build
index 57091b18fc4..2889e3093cd 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -5,6 +5,7 @@ _common_cfg = run_command(rustc_args,
 _common_rs = static_library(
   'common',
   'src/lib.rs',
+  override_options: rust_default_options,
   rust_args: _common_cfg,
   dependencies: [libc_rs, qemu_macros],
 )
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 1a1a09e5083..4432fac9ecb 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -19,7 +19,7 @@ _libpl011_rs = static_library(
     ],
     {'.' : _libpl011_bindings_inc_rs},
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   link_with: [
     _util_rs,
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 6d1bfd4d204..24971105caf 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -1,7 +1,7 @@
 _hwcore_rs = static_library(
   'hwcore',
   'src/lib.rs',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, qemu_macros, common_rs, hwcore_sys_rs],
@@ -14,7 +14,7 @@ test('rust-hwcore-rs-integration',
     executable(
         'rust-hwcore-rs-integration',
         files('tests/tests.rs'),
-        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        override_options: rust_default_options,
         rust_args: ['--test'],
         install: false,
         dependencies: [chardev_rs, common_rs, hwcore_rs, bql_rs, migration_rs, util_rs]),
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 3bb7ce2a6ca..0559be07766 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -1,7 +1,7 @@
 _libhpet_rs = static_library(
   'hpet',
   files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  override_options: rust_default_options,
   rust_abi: 'rust',
   link_with: [
     _util_rs,
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 96266897770..efd814a9f9b 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -1,6 +1,7 @@
 _migration_rs = static_library(
   'migration',
   'src/lib.rs',
+  override_options: rust_default_options,
   link_with: [_util_rs, _bql_rs],
   dependencies: [common_rs, glib_sys_rs, qemu_macros, migration_sys_rs],
 )
diff --git a/rust/qemu-macros/meson.build b/rust/qemu-macros/meson.build
index cdea5bf439e..c38e5f49d61 100644
--- a/rust/qemu-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -1,6 +1,7 @@
 _qemu_macros_rs = rust.proc_macro(
   'qemu_macros',
   files('src/lib.rs'),
+  override_options: rust_default_options,
   dependencies: [
     attrs_rs_native,
     proc_macro2_rs_native,
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 9865da280cf..9ea68fb4c94 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -1,6 +1,7 @@
 _qom_rs = static_library(
   'qom',
   'src/lib.rs',
+  override_options: rust_default_options,
   link_with: [_bql_rs, _migration_rs],
   dependencies: [common_rs, glib_sys_rs, qemu_macros, qom_sys_rs],
 )
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 89c1f2b84d1..bcec283ad37 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -1,6 +1,7 @@
 _system_rs = static_library(
   'system',
   'src/lib.rs',
+  override_options: rust_default_options,
   link_with: [_bql_rs, _hwcore_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, common_rs, qemu_macros, system_sys_rs],
 )
diff --git a/rust/tests/meson.build b/rust/tests/meson.build
index 3c5020490b0..3a51efe1b19 100644
--- a/rust/tests/meson.build
+++ b/rust/tests/meson.build
@@ -2,6 +2,7 @@ test('rust-integration',
     executable(
         'rust-integration',
         files('tests/vmstate_tests.rs'),
+        override_options: rust_default_options,
         rust_args: ['--test'],
         install: false,
         dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs]),
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
index 0071a49cf72..4d360af063d 100644
--- a/rust/trace/meson.build
+++ b/rust/trace/meson.build
@@ -11,6 +11,7 @@ _trace_rs = static_library(
   'trace',             # Library name,
   lib_rs,
   trace_rs_targets,         # List of generated `.rs` custom targets
+  override_options: rust_default_options,
   dependencies: [libc_rs, probe_rs],
 )
 
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 6d175ae0b0f..0b004919893 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -1,6 +1,7 @@
 _util_rs = static_library(
   'util',
   'src/lib.rs',
+  override_options: rust_default_options,
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, util_sys_rs],
 )
 
-- 
2.53.0


