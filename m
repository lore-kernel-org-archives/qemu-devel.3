Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AFDCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo37-0007O1-OQ; Tue, 26 May 2026 05:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo34-0007Lh-BF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2z-00073q-Oo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY8mlBhBGEKNFGowfTH7/khG7dYr2XbHpJdlPwV+L9c=;
 b=O98IGbbbNEJfzH77yAZO7AnFtOWwrYnSOiVn+nLz1oqeEqNDJYjxjRDwtnx6EEtnXgAo5R
 H/p7l1Mz1SCSyQ0W7rFrrYNJVzxnE7OL1pjLPVCond7XpSrfJQseNSD3BQQdPiqZsLCeC+
 lyFWKewH6EhGPjGknO0vIGRyOmdm9hE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-dCPm2O9SOk6Q58gVof5g3A-1; Tue, 26 May 2026 05:25:59 -0400
X-MC-Unique: dCPm2O9SOk6Q58gVof5g3A-1
X-Mimecast-MFC-AGG-ID: dCPm2O9SOk6Q58gVof5g3A_1779787558
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso9499587f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787558; x=1780392358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TY8mlBhBGEKNFGowfTH7/khG7dYr2XbHpJdlPwV+L9c=;
 b=Tb7ln1tS0n5+PN72y1R0QNsTLsJ2q3F2dEQxN5eMopSCqBANLPnwGNjZpEyJcDS6Bj
 GQSitGeCwA/cZvWFpSu4y1euqbiF1V6ooZzPzIerQGKk1njk/5ASDb8spG+aaeqOKysO
 /SGGb49fAEx3yOMx2a0I6zqUeS2olBgqDEM/1g4RU9mIoWX/JyuQKjf06dbEZ19e/iIH
 KqRXVDJNozmnbNvixI/zng/tW42q/iDsSJWvqhE5zWb/zcOF0YfyDueG/EKmMZWojkU+
 B7cwJS0BKwViumDJqo6WSL/en7O8dTOkdixNYPwRGPPKEUd9AWtzanC1HKeZs6P2x/y+
 7aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787558; x=1780392358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TY8mlBhBGEKNFGowfTH7/khG7dYr2XbHpJdlPwV+L9c=;
 b=WHBA01dQXH0gUiHlxnJUxTvQ5HxQ4l0e8cVJ/zmrRjv8M7qeGzmx0gyLg2qnrifCuo
 1Tc1Yv6S+rZaWJA3LC0Yhs8e6OHeRrrgV9DpVXWP4qIrlN4aDt74obVzBPReoH6fYFLq
 edEt9hhLFKezDbInnhPUszjEGFc3w6Mn2xv1bxnKjcAgw/G4l3YA4DuH+r+xxYq3thJD
 OiWZhBkhhTpxFAmSKrKUvgomXIgiR3Wyat5wAT/nQgYu08rjckF7ytO8VsJmO1MBFrmI
 JI4yGSMT2G9vIJUDqqF77OhgJB034HUsPjByARbXhDpYM2DQ4/3YSSnDyaWp+1ozczoe
 CPTQ==
X-Gm-Message-State: AOJu0YzSiyjbIw6mU8uMHmBcZbTyORbR+O1RUbaky0HOqPgKfHy6YkW0
 wr5I2vu63i9ImBIyCd4zZk9YSqp+d2VAJoCWXXgYs3YOBNrO+JayMsfgOQR5tlUR/vY4D0GUmmf
 0/7xTNVRzIMqJMpH84f4AtlSS2QPyLDMf8SYj0ocL+UHQFjhscm4BRCRiIwJCV7JjuRenrJiqa0
 dGzi3obXYZ1rNlCO1n29RpnP+fau4lrN/YTYJCDBEc
X-Gm-Gg: Acq92OHDwNU95nBqlS6GNlmtRIIMur6zYCfcViraemPLuSnlJ0KJaDxHBTdplz+1WLo
 NJqFqd3u6xGzjaBiCthWO++P8Rj5HuOKetMq35AQszoReTk9M5XrSXgCuHgPHhPNOWowBVhl9ph
 KsVd35Pr/kMWW9FmM+rlSZ049M6yAmdoNE8EywjOEf/tD9WAvBuptKCqjoZ6XML+RqVD/kX1WBT
 hxK0U1b7NO0d+lw4VooxPkImly/Cb5FR8vocSopwKKkxknJ4gQsxEYt+kk6oMVZeHU5ydoVKzOK
 0o7MgHDYA5ETPWK8QJ9ng7US2c09gKjEj452P2J1dk23lNfY+xOJ4jkLK0jiDaTRZ6kOzl+GmIh
 XcW1yx5FBNS9CtJK5VjJoMVN9X+Db4X3Sx1mV1rFLESSBhXCArmIItlEgbAwO8Af+IeW7lpi6fR
 W2jGlwQXv8o1y6lVYQ2aLHSDOinFc=
X-Received: by 2002:a05:600c:1553:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-49058efcf6amr197894225e9.22.1779787557821; 
 Tue, 26 May 2026 02:25:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-49058efcf6amr197893245e9.22.1779787557013; 
 Tue, 26 May 2026 02:25:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9de2dsm32643768f8f.4.2026.05.26.02.25.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] rust: use meson automatic parsing of Cargo.toml
Date: Tue, 26 May 2026 11:25:44 +0200
Message-ID: <20260526092546.149241-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
References: <20260526092546.149241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Finally, automatic parsing of Cargo.toml is also possible for QEMU's own
crates, not just for subprojects.  This removes the need to list the
dependencies and language editions in both Cargo.toml and meson.build
files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                             |  7 +------
 rust/bindings/chardev-sys/meson.build   | 11 ++++-------
 rust/bindings/hwcore-sys/meson.build    | 11 ++++-------
 rust/bindings/migration-sys/meson.build | 11 ++++-------
 rust/bindings/qom-sys/meson.build       | 11 ++++-------
 rust/bindings/system-sys/meson.build    | 11 ++++-------
 rust/bindings/util-sys/meson.build      | 11 ++++-------
 rust/bits/meson.build                   |  7 ++-----
 rust/bql/meson.build                    | 13 +++----------
 rust/chardev/meson.build                |  8 ++------
 rust/common/meson.build                 | 10 +++-------
 rust/hw/char/pl011/meson.build          | 22 +---------------------
 rust/hw/core/meson.build                | 10 ++--------
 rust/hw/timer/hpet/meson.build          | 17 +----------------
 rust/meson.build                        | 13 ++-----------
 rust/migration/meson.build              |  8 ++------
 rust/qemu-macros/meson.build            | 12 ++----------
 rust/qom/meson.build                    |  8 ++------
 rust/system/meson.build                 |  8 ++------
 rust/trace/meson.build                  |  9 +++------
 rust/util/meson.build                   |  7 ++-----
 21 files changed, 54 insertions(+), 171 deletions(-)

diff --git a/meson.build b/meson.build
index 91d74fa198c..17c8751f92d 100644
--- a/meson.build
+++ b/meson.build
@@ -134,12 +134,7 @@ if have_rust
 
   rustfmt = find_program('rustfmt', required: false)
 
-  rustc_lint_args = run_command(rustc_args, '--lints',
-     capture: true, check: true).stdout().strip().splitlines()
-  if get_option('strict_rust_lints')
-    rustc_lint_args += ['-Dwarnings', '-Funknown_lints']
-  endif
-
+  rustc_lint_args = get_option('strict_rust_lints') ?  ['-Dwarnings', '-Funknown_lints'] : []
   add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
       native: false, language: 'rust')
   add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
diff --git a/rust/bindings/chardev-sys/meson.build b/rust/bindings/chardev-sys/meson.build
index 458075b8060..7af5d74dd51 100644
--- a/rust/bindings/chardev-sys/meson.build
+++ b/rust/bindings/chardev-sys/meson.build
@@ -1,12 +1,9 @@
 _bindgen_chardev_rs = rust.bindgen(
   args: bindgen_args_common + bindgen_args_data['chardev-sys'].split(),
   kwargs: bindgen_kwargs)
-_chardev_sys_rs = static_library(
-  'chardev_sys',
-  structured_sources(['lib.rs', _bindgen_chardev_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [glib_sys_rs, common_rs, qom_sys_rs, util_sys_rs],
-)
+
+_chardev_sys_rs = cargo_ws.package('chardev-sys').library(
+  structured_sources(['lib.rs', _bindgen_chardev_rs]))
+cargo_ws.package('chardev-sys').override_dependency(declare_dependency(link_with: _chardev_sys_rs))
 
 chardev_sys_rs = declare_dependency(link_with: [_chardev_sys_rs])
diff --git a/rust/bindings/hwcore-sys/meson.build b/rust/bindings/hwcore-sys/meson.build
index 3d51947b4a4..6b8d218f691 100644
--- a/rust/bindings/hwcore-sys/meson.build
+++ b/rust/bindings/hwcore-sys/meson.build
@@ -1,12 +1,9 @@
 _bindgen_hwcore_rs = rust.bindgen(
   args: bindgen_args_common + bindgen_args_data['hwcore-sys'].split(),
   kwargs: bindgen_kwargs)
-_hwcore_sys_rs = static_library(
-  'hwcore_sys',
-  structured_sources(['lib.rs', _bindgen_hwcore_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [common_rs, glib_sys_rs, qom_sys_rs, util_sys_rs, migration_sys_rs, chardev_sys_rs],
-)
+
+_hwcore_sys_rs = cargo_ws.package('hwcore-sys').library(
+  structured_sources(['lib.rs', _bindgen_hwcore_rs]))
+cargo_ws.package('hwcore-sys').override_dependency(declare_dependency(link_with: _hwcore_sys_rs))
 
 hwcore_sys_rs = declare_dependency(link_with: [_hwcore_sys_rs])
diff --git a/rust/bindings/migration-sys/meson.build b/rust/bindings/migration-sys/meson.build
index 9243acba300..91f2967c9b3 100644
--- a/rust/bindings/migration-sys/meson.build
+++ b/rust/bindings/migration-sys/meson.build
@@ -1,12 +1,9 @@
 _bindgen_migration_rs = rust.bindgen(
   args: bindgen_args_common + bindgen_args_data['migration-sys'].split(),
   kwargs: bindgen_kwargs)
-_migration_sys_rs = static_library(
-  'migration_sys',
-  structured_sources(['lib.rs', _bindgen_migration_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [glib_sys_rs, common_rs, util_sys_rs],
-)
+
+_migration_sys_rs = cargo_ws.package('migration-sys').library(
+  structured_sources(['lib.rs', _bindgen_migration_rs]))
+cargo_ws.package('migration-sys').override_dependency(declare_dependency(link_with: _migration_sys_rs))
 
 migration_sys_rs = declare_dependency(link_with: [_migration_sys_rs])
diff --git a/rust/bindings/qom-sys/meson.build b/rust/bindings/qom-sys/meson.build
index 8f8ae7d1bc8..540e55eea88 100644
--- a/rust/bindings/qom-sys/meson.build
+++ b/rust/bindings/qom-sys/meson.build
@@ -1,12 +1,9 @@
 _bindgen_qom_rs = rust.bindgen(
   args: bindgen_args_common + bindgen_args_data['qom-sys'].split(),
   kwargs: bindgen_kwargs)
-_qom_sys_rs = static_library(
-  'qom_sys',
-  structured_sources(['lib.rs', _bindgen_qom_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [glib_sys_rs, util_sys_rs],
-)
+
+_qom_sys_rs = cargo_ws.package('qom-sys').library(
+  structured_sources(['lib.rs', _bindgen_qom_rs]))
+cargo_ws.package('qom-sys').override_dependency(declare_dependency(link_with: _qom_sys_rs))
 
 qom_sys_rs = declare_dependency(link_with: [_qom_sys_rs])
diff --git a/rust/bindings/system-sys/meson.build b/rust/bindings/system-sys/meson.build
index aa5e8801149..b1f4770499c 100644
--- a/rust/bindings/system-sys/meson.build
+++ b/rust/bindings/system-sys/meson.build
@@ -1,12 +1,9 @@
 _bindgen_system_rs = rust.bindgen(
   args: bindgen_args_common + bindgen_args_data['system-sys'].split(),
   kwargs: bindgen_kwargs)
-_system_sys_rs = static_library(
-  'system_sys',
-  structured_sources(['lib.rs', _bindgen_system_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [common_rs, glib_sys_rs, hwcore_sys_rs, migration_sys_rs, qom_sys_rs, util_sys_rs],
-)
+
+_system_sys_rs = cargo_ws.package('system-sys').library(
+  structured_sources(['lib.rs', _bindgen_system_rs]))
+cargo_ws.package('system-sys').override_dependency(declare_dependency(link_with: _system_sys_rs))
 
 system_sys_rs = declare_dependency(link_with: [_system_sys_rs])
diff --git a/rust/bindings/util-sys/meson.build b/rust/bindings/util-sys/meson.build
index c37f50a94bd..5a9db6152e1 100644
--- a/rust/bindings/util-sys/meson.build
+++ b/rust/bindings/util-sys/meson.build
@@ -1,12 +1,9 @@
 _bindgen_util_rs = rust.bindgen(
   args: bindgen_args_common + bindgen_args_data['util-sys'].split(),
   kwargs: bindgen_kwargs)
-_util_sys_rs = static_library(
-  'util_sys',
-  structured_sources(['lib.rs', _bindgen_util_rs]),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [glib_sys_rs],
-)
+
+_util_sys_rs = cargo_ws.package('util-sys').library(
+  structured_sources(['lib.rs', _bindgen_util_rs]))
+cargo_ws.package('util-sys').override_dependency(declare_dependency(link_with: _util_sys_rs))
 
 util_sys_rs = declare_dependency(link_with: [_util_sys_rs])
diff --git a/rust/bits/meson.build b/rust/bits/meson.build
index c0094ffcf38..c64a17ba154 100644
--- a/rust/bits/meson.build
+++ b/rust/bits/meson.build
@@ -1,8 +1,5 @@
-_bits_rs = static_library(
-  'bits',
-  'src/lib.rs',
-  dependencies: [qemu_macros],
-)
+_bits_rs = cargo_ws.package('bits').library()
+cargo_ws.package('bits').override_dependency(declare_dependency(link_with: _bits_rs))
 
 bits_rs = declare_dependency(link_with: _bits_rs)
 
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index de295d2983e..8bdc9b53a2c 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -1,17 +1,10 @@
-_bql_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
-  capture: true, check: true).stdout().strip().splitlines()
-
+_bql_cfg = []
 if get_option('debug_mutex')
   _bql_cfg += ['--cfg', 'feature="debug_cell"']
 endif
 
-_bql_rs = static_library(
-  'bql',
-  'src/lib.rs',
-  rust_args: _bql_cfg,
-  dependencies: [glib_sys_rs, util_sys_rs],
-)
+_bql_rs = cargo_ws.package('bql').library(rust_args: _bql_cfg)
+cargo_ws.package('bql').override_dependency(declare_dependency(link_with: _bql_rs))
 
 bql_rs = declare_dependency(link_with: [_bql_rs],
   dependencies: [qemuutil])
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 7b267fd23ae..f3462e9209e 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -1,8 +1,4 @@
-_chardev_rs = static_library(
-  'chardev',
-  'src/lib.rs',
-  link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [glib_sys_rs, common_rs, qemu_macros, chardev_sys_rs],
-)
+_chardev_rs = cargo_ws.package('chardev').library()
+cargo_ws.package('chardev').override_dependency(declare_dependency(link_with: _chardev_rs))
 
 chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
diff --git a/rust/common/meson.build b/rust/common/meson.build
index 57091b18fc4..43afe417dcd 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -1,13 +1,9 @@
 _common_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  '--config-headers', config_host_h, files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
-_common_rs = static_library(
-  'common',
-  'src/lib.rs',
-  rust_args: _common_cfg,
-  dependencies: [libc_rs, qemu_macros],
-)
+_common_rs = cargo_ws.package('common').library(rust_args: _common_cfg)
+cargo_ws.package('common').override_dependency(declare_dependency(link_with: _common_rs))
 
 common_rs = declare_dependency(link_with: [_common_rs])
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 1a1a09e5083..92b7d375f75 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -8,8 +8,7 @@ _libpl011_bindings_inc_rs = rust.bindgen(
   kwargs: bindgen_kwargs,
 )
 
-_libpl011_rs = static_library(
-  'pl011',
+_libpl011_rs = cargo_ws.package('pl011').library(
   structured_sources(
     [
       'src/lib.rs',
@@ -19,25 +18,6 @@ _libpl011_rs = static_library(
     ],
     {'.' : _libpl011_bindings_inc_rs},
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  link_with: [
-    _util_rs,
-    _migration_rs,
-    _bql_rs,
-    _qom_rs,
-    _chardev_rs,
-    _system_rs,
-    _hwcore_rs,
-    _trace_rs
-  ],
-  dependencies: [
-    bilge_rs,
-    bilge_impl_rs,
-    bits_rs,
-    common_rs,
-    glib_sys_rs,
-  ],
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 6d1bfd4d204..da0f13d3149 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -1,11 +1,5 @@
-_hwcore_rs = static_library(
-  'hwcore',
-  'src/lib.rs',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [glib_sys_rs, qemu_macros, common_rs, hwcore_sys_rs],
-)
+_hwcore_rs = cargo_ws.package('hwcore').library()
+cargo_ws.package('hwcore').override_dependency(declare_dependency(link_with: _hwcore_rs))
 
 hwcore_rs = declare_dependency(link_with: [_hwcore_rs],
   dependencies: [qom_rs, hwcore])
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 3bb7ce2a6ca..419e8f40b70 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -1,19 +1,4 @@
-_libhpet_rs = static_library(
-  'hpet',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  link_with: [
-    _util_rs,
-    _migration_rs,
-    _bql_rs,
-    _qom_rs,
-    _system_rs,
-    _hwcore_rs,
-    _trace_rs,
-  ],
-  dependencies: [common_rs],
-)
+_libhpet_rs = cargo_ws.package('hpet').library()
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
   link_whole: [_libhpet_rs],
diff --git a/rust/meson.build b/rust/meson.build
index d580c7cbeef..266c2add358 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -5,19 +5,10 @@ else
 endif
 
 cargo_ws = import('rust').workspace()
-anyhow_rs = cargo_ws.subproject('anyhow').dependency()
-bilge_rs = cargo_ws.subproject('bilge').dependency()
-bilge_impl_rs = cargo_ws.subproject('bilge-impl').dependency()
-foreign_rs = cargo_ws.subproject('foreign').dependency()
-glib_sys_rs = cargo_ws.subproject('glib-sys').dependency()
-libc_rs = cargo_ws.subproject('libc').dependency()
-probe_rs = cargo_ws.subproject('probe').dependency()
+
+# used by QAPI tests, which are still not handled via cargo_ws
 serde_rs = cargo_ws.subproject('serde').dependency()
 serde_derive_rs = cargo_ws.subproject('serde_derive').dependency()
-quote_rs_native = cargo_ws.subproject('quote').dependency()
-syn_rs_native = cargo_ws.subproject('syn').dependency()
-proc_macro2_rs_native = cargo_ws.subproject('proc-macro2').dependency()
-attrs_rs_native = cargo_ws.subproject('attrs').dependency()
 
 genrs = []
 
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 96266897770..b9ba82989e3 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -1,9 +1,5 @@
-_migration_rs = static_library(
-  'migration',
-  'src/lib.rs',
-  link_with: [_util_rs, _bql_rs],
-  dependencies: [common_rs, glib_sys_rs, qemu_macros, migration_sys_rs],
-)
+_migration_rs = cargo_ws.package('migration').library()
+cargo_ws.package('migration').override_dependency(declare_dependency(link_with: _migration_rs))
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
   dependencies: [bql_rs, migration, qemuutil])
diff --git a/rust/qemu-macros/meson.build b/rust/qemu-macros/meson.build
index cdea5bf439e..7b25ccefe35 100644
--- a/rust/qemu-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -1,13 +1,5 @@
-_qemu_macros_rs = rust.proc_macro(
-  'qemu_macros',
-  files('src/lib.rs'),
-  dependencies: [
-    attrs_rs_native,
-    proc_macro2_rs_native,
-    quote_rs_native,
-    syn_rs_native,
-  ],
-)
+_qemu_macros_rs = cargo_ws.package('qemu_macros').proc_macro()
+cargo_ws.package('qemu_macros').override_dependency(declare_dependency(link_with: _qemu_macros_rs))
 
 qemu_macros = declare_dependency(
   link_with: _qemu_macros_rs,
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 9865da280cf..6736cfb24c2 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -1,9 +1,5 @@
-_qom_rs = static_library(
-  'qom',
-  'src/lib.rs',
-  link_with: [_bql_rs, _migration_rs],
-  dependencies: [common_rs, glib_sys_rs, qemu_macros, qom_sys_rs],
-)
+_qom_rs = cargo_ws.package('qom').library()
+cargo_ws.package('qom').override_dependency(declare_dependency(link_with: _qom_rs))
 
 qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom, qemuutil])
 
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 89c1f2b84d1..b1edcd6bbe7 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -1,9 +1,5 @@
-_system_rs = static_library(
-  'system',
-  'src/lib.rs',
-  link_with: [_bql_rs, _hwcore_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [glib_sys_rs, common_rs, qemu_macros, system_sys_rs],
-)
+_system_rs = cargo_ws.package('system').library()
+cargo_ws.package('system').override_dependency(declare_dependency(link_with: _system_rs))
 
 system_rs = declare_dependency(link_with: [_system_rs],
   dependencies: [hwcore])
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
index 0071a49cf72..b049f73b542 100644
--- a/rust/trace/meson.build
+++ b/rust/trace/meson.build
@@ -7,11 +7,8 @@ lib_rs = configure_file(
     'MESON_BUILD_ROOT': meson.project_build_root(),
   })
 
-_trace_rs = static_library(
-  'trace',             # Library name,
-  lib_rs,
-  trace_rs_targets,         # List of generated `.rs` custom targets
-  dependencies: [libc_rs, probe_rs],
-)
+_trace_rs = cargo_ws.package('trace').library(
+  structured_sources([lib_rs, trace_rs_targets]))
+cargo_ws.package('trace').override_dependency(declare_dependency(link_with: _trace_rs))
 
 trace_rs = declare_dependency(link_with: _trace_rs)
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 3edd8245bfc..427427f1915 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -1,8 +1,5 @@
-_util_rs = static_library(
-  'util',
-  'src/lib.rs',
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, serde_rs, util_sys_rs],
-)
+_util_rs = cargo_ws.package('util').library()
+cargo_ws.package('util').override_dependency(declare_dependency(link_with: _util_rs))
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
 
-- 
2.54.0


