Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F66C531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0Cy-0005wu-Uf; Sun, 26 Jul 2026 10:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Co-0005te-LM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:51:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Cl-00060L-3t
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:51:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so23078465ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785077510; x=1785682310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FCW4PvYCh0nfjidNnYDFUOliq890MpmlX0B+4xSIUTs=;
 b=K+kjkcvyA495BUndzLI0vlEwUq9yLIDzRq/ELzy+35wVYXeXaAM4lYYIAsU9Yb4ngJ
 Ryd6JKwwAh2sA9iBBBOqwtSUbBM3Wj0ifotw+a4lChaync7Wka6/bIDlMTSJEZxeDfSI
 PYJcVjwEh1cMdxL4ColYotQ2L+X7+x4KPArSG8Llv9AMekuZHhYV5EUbYyHS3LtmlgWw
 s/fWT3hkfWw2UeRV8aFtwDZ3KPY+rclt/ggcckw7CPIh8xYZkZnIhMEvxnlidq3I0wuy
 AijolQWdoKyljFMh6f8xMTH6vYdg7N4RJQUXoGJ5hffIIi8PzusOLai9yKbFb0+i5J3o
 hqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785077510; x=1785682310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FCW4PvYCh0nfjidNnYDFUOliq890MpmlX0B+4xSIUTs=;
 b=UisHnrp3qz5tTie82y+MsX6zeQvgkAN3HZAu/VyYWaZgMNIbfrG5HPMfN9F80wVlpv
 e1eutDlsSFCjNubkpoPoC2m1knRhgb9CDdNJ+v3tG0kT8umCaokpjdYpQMCC5gfKLS5R
 Wl0xP/QKf4sFpmXoor0tmHIhlRvDj7dljzvgpk8VL/iGHrfuYv3oFtSneqa8VPES9DhQ
 Q8OEoCFwnUv1ISocajssQpmfPOxA4OA/K0aI1aJWLueC0I4OgYggW5qI/M8jdbn7cBjz
 h+jw24HuGlut8G023ZDdmEM9EgNGJHR5KoVR2bGdK1WSlKddPRm9F9VPWgoQTr6e0H/4
 +37w==
X-Gm-Message-State: AOJu0YyuFBqErYBGwsQJ1Av0WRu6PyufnwExMB7flvbcqCGBE5fGJL6o
 LVlXbL7zmOmMlfPysr03DIRjilkcQCMpbjKJcAjYPmGLIiMs/ziheNSjFKCQmQ==
X-Gm-Gg: AR+sD12oRUjIVF9mm3foNX5XcFEZn/4LRxrodoWiZmQnYVNmrmqaF1BtLzcqqKO/Hro
 3ylVG+ucPfXG4zL0H/MeUgcs+cQ6EHczWEPb3Vb46HTHKgeUUrGQ4r5qbrPKdOC30pn5XSYTZRB
 bvTVYJJw5ni6+Q12KA/vRGgOFw00KvrUeuLSIL0XjqBz6YBqJguRP0EBEKLs6pERl195pC1Cj/Q
 A9ElPh4/ZCJ5BpchlmDAnQhcLRmCZUJuyGqNGhXdrR28md3Oi7c1CPSONafAZzBIS7+TWj6TTBd
 G++d7puEU8wsVWh7V1uID915l4KPYi5M24ZROyuan8Gik5ox2S/XMxKnVyiCWscpW9NkE2foepj
 d41a4zIt7krNVZG8EDqEddXNLdJV9gbSMLVLR0JTGZG0Il9CdDIwgnvMmc22c2aDFegYeqFD6nn
 JGfGI8Z37McHaMDKKYPJQqpAa1
X-Received: by 2002:a17:902:cec3:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2cfde7aa806mr51642055ad.12.1785077509760; 
 Sun, 26 Jul 2026 07:51:49 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d7f5sm20934195ad.83.2026.07.26.07.51.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:51:48 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com,
 Jack Wang <163wangjack@gmail.com>
Subject: [RFC PATCH v1 2/5] rust: add hw/gpio crate to the workspace
Date: Sun, 26 Jul 2026 22:51:16 +0800
Message-ID: <20260726145119.19881-3-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726145119.19881-1-163wangjack@gmail.com>
References: <20260726145119.19881-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Register the new stm32f1xx_gpio crate in the Rust workspace and hook its
meson build and Kconfig into rust/hw so it is compiled into the softmmu
build when Rust is enabled.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 rust/Cargo.lock          | 17 ++++++++++++-
 rust/Cargo.toml          | 18 ++++++++++++++
 rust/hw/Kconfig          |  1 +
 rust/hw/gpio/Cargo.toml  | 28 +++++++++++++++++++++
 rust/hw/gpio/meson.build | 54 ++++++++++++++++++++++++++++++++++++++++
 rust/hw/meson.build      |  1 +
 6 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 rust/hw/gpio/Cargo.toml
 create mode 100644 rust/hw/gpio/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index cbb3ca15f7..2daadaaf15 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -184,7 +184,6 @@ dependencies = [
  "glib-sys",
  "migration-sys",
  "qom-sys",
- "system-sys",
  "util-sys",
 ]
 
@@ -387,6 +386,21 @@ version = "1.15.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
 
+[[package]]
+name = "stm32f1xx_gpio"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "common",
+ "glib-sys",
+ "hwcore",
+ "migration",
+ "qom",
+ "system",
+ "trace",
+ "util",
+]
+
 [[package]]
 name = "syn"
 version = "2.0.104"
@@ -431,6 +445,7 @@ version = "0.1.0"
 dependencies = [
  "common",
  "glib-sys",
+ "hwcore-sys",
  "migration-sys",
  "qom-sys",
  "util-sys",
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0d24eb84e1..7661205d3c 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -1,9 +1,27 @@
 [workspace]
 resolver = "2"
 members = [
+    "bindings/chardev-sys",
+    "bindings/hwcore-sys",
+    "bindings/migration-sys",
+    "bindings/qom-sys",
+    "bindings/system-sys",
+    "bindings/util-sys",
+    "bits",
+    "bql",
+    "chardev",
+    "common",
     "hw/char/pl011",
+    "hw/core",
+    "hw/gpio",
     "hw/timer/hpet",
+    "migration",
+    "qemu-macros",
+    "qom",
+    "system",
     "tests",
+    "trace",
+    "util",
 ]
 
 [workspace.package]
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
index 36f92ec028..ba1297ca2d 100644
--- a/rust/hw/Kconfig
+++ b/rust/hw/Kconfig
@@ -1,3 +1,4 @@
 # devices Kconfig
 source char/Kconfig
+source gpio/Kconfig
 source timer/Kconfig
diff --git a/rust/hw/gpio/Cargo.toml b/rust/hw/gpio/Cargo.toml
new file mode 100644
index 0000000000..5c6eade306
--- /dev/null
+++ b/rust/hw/gpio/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "stm32f1xx_gpio"
+version = "0.1.0"
+description = "STM32F1xx GPIO device model for QEMU"
+resolver = "2"
+publish = false
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+glib-sys.workspace = true
+
+# QEMU Rust foundations crate
+common = { path = "../../common" }
+util = { path = "../../util" }
+bql = { path = "../../bql" }
+migration = { path = "../../migration" }
+qom = { path = "../../qom" }
+system = { path = "../../system" }
+hwcore = { path = "../../hw/core" }
+trace = { path = "../../trace" }
+
+[lints]
+workspace = true
diff --git a/rust/hw/gpio/meson.build b/rust/hw/gpio/meson.build
new file mode 100644
index 0000000000..35da59991f
--- /dev/null
+++ b/rust/hw/gpio/meson.build
@@ -0,0 +1,54 @@
+_libstm32f1xx_gpio_rs = static_library(
+  'stm32f1xx_gpio',
+  files(
+    'src/lib.rs',
+    'src/gpio.rs',
+    'src/bindings.rs',
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _system_rs,
+    _hwcore_rs,
+    _trace_rs,
+  ],
+  dependencies: [
+    common_rs,
+    glib_sys_rs,
+  ],
+)
+
+rust_devices_ss.add(when: 'CONFIG_X_STM32F1XX_GPIO_RUST', if_true: [declare_dependency(
+  link_whole: [_libstm32f1xx_gpio_rs],
+  variables: {'crate': 'stm32f1xx_gpio'},
+)])
+
+# Dependency usable by the in-crate integration test below.
+stm32f1xx_gpio_rs = declare_dependency(link_with: [_libstm32f1xx_gpio_rs],
+  dependencies: [common_rs, qom_rs, hwcore_rs, bql_rs, migration_rs,
+                 system_rs, util_rs])
+
+# Native Rust unit tests for the pure register logic (GpioRegisters). These
+# need no qtest and no machine boot: they construct GpioRegisters directly and
+# only require the BQL mock (bql::start_test). Run with:
+#   meson test --suite rust rust-stm32f1xx-gpio-integration
+test('rust-stm32f1xx-gpio-integration',
+    executable(
+        'rust-stm32f1xx-gpio-integration',
+        files('tests/tests.rs'),
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [stm32f1xx_gpio_rs, common_rs, qom_rs, hwcore_rs,
+                       bql_rs, migration_rs, system_rs, util_rs]),
+    args: [
+        '--test', '--test-threads', '1',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
+
diff --git a/rust/hw/meson.build b/rust/hw/meson.build
index 9749d4adfc..d6b273170e 100644
--- a/rust/hw/meson.build
+++ b/rust/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('char')
+subdir('gpio')
 subdir('timer')
-- 
2.53.0


