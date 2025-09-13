Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88397CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNO-0002i8-AI; Sat, 13 Sep 2025 04:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMg-0000ta-UF
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMc-0005Ck-OF
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Er0y421yFdGhHTiJqDqg2wnXxCk9uNzxTd4iS/AjYEs=;
 b=FU/7XbJOvIaoEytBj2IVRoPMi5QGe/8KYfQu15NyyfM7h8gwUtUUdMe3VNM4QKjDmZuSvP
 ydJSXTb0WHpuD1y8IrCkC57NN+t2WBR1LDxMVT/anTdWzERsgt376eHT4bgY7jiqHDWe9g
 cb0xqUMShuSr4QWGnXayrU+yQ/Ndfmw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-fa15fcfmO1-U6Mu9rdZQ-g-1; Sat, 13 Sep 2025 04:12:04 -0400
X-MC-Unique: fa15fcfmO1-U6Mu9rdZQ-g-1
X-Mimecast-MFC-AGG-ID: fa15fcfmO1-U6Mu9rdZQ-g_1757751123
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45cb4f23156so15626535e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751121; x=1758355921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er0y421yFdGhHTiJqDqg2wnXxCk9uNzxTd4iS/AjYEs=;
 b=NDek6ihMWuUVtacYrugDRbOKWlNqQE0C7sAVtatzBfxeVOV/o2Tlq2k79jYCdaqaeB
 1DsRzyl3JIyIO14zFrLl9D29DqL4TxRdK5s2yHrYLMlCW+4sPXpdHSsu4HV9EpUukEow
 nx49gDy5WdPH+IyGzvVKdfTKQ6y2a21SWsQHwBATa3YeZc8dbccyGzAH4K9AFoV80Xae
 HlJGzReiIh2LsYiJ+Gb0C0QwtQOCrSkr6cLDiwOhdp68BqrUlhfYsK3CdNFY7DO4ICXS
 nHW5kR+sF9l3O59vN73gW58mcogtnWeYjrneV5t2g/UknXO1uhDo+/CpJjpYZQfnjfaD
 2tDA==
X-Gm-Message-State: AOJu0YxRw5QLHYdJLDTXQtIXW27J8aNa/6Saj5TRzWymZQVTTJERzb0z
 49O8sB5mY4euuefEzeDF2CAYUEQRlnjmHoV65D0Irn5ZRpqe2oNwDjCzM7UaB9b5EYf1HJrVK4x
 UCxgoL+YitDtr0Znl4FzbLQXqYBoDHzBa971YWW+DaDhGzG4vqh3bYjeUM9zYfJZzPFDS5kx7S7
 VgtKlkihyao8GQpFPYjse2dQw9Bs2qdig7acOoh4Gi
X-Gm-Gg: ASbGncu7YCD6gaUmgywtroaY/1Uvxf6HbZbtEVQDUL6b/jJV81hpV4cS3C7t+cgtIhX
 PuHvOCjp+It77RviZlBGXfVstZTjA1JaiOBhhRFPcU06w6RYQp227YEfddnF4qOYnvU8zZSVFMX
 X3EsIvaNF712ERP9M6rgRRb7E3qwh37TQQo7FzY5eutDGJ0pTu6RxeZtvvjmoXWBJS8ZZyoEPU4
 sqZpRigkwOabnMJUlYIJEEB/QaInp64SNTlvXQL5OiDk6lJf5mduw7KAexypIF3RTt4QUWjq4pg
 iH+EfOUS39EmOs5dhtdLdL1G8mc0GjW3b2nJseDnlfGQ2/dpcgNctOHDfh+hW4oF3BcEfhzW45Y
 VXn0iUty+/dBdXTExrK641YDChQAagYy7k7laJBUdEY8=
X-Received: by 2002:a05:600c:3515:b0:45f:28ed:6e1e with SMTP id
 5b1f17b1804b1-45f28ed71c9mr6355835e9.16.1757751121406; 
 Sat, 13 Sep 2025 01:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECO6gazLVNKoRKlo7HCANk9o+l/EzDw0crNKUMP5vMxmtEla/Tm29thgBcgdeG5Frd/XkaQQ==
X-Received: by 2002:a05:600c:3515:b0:45f:28ed:6e1e with SMTP id
 5b1f17b1804b1-45f28ed71c9mr6355295e9.16.1757751120705; 
 Sat, 13 Sep 2025 01:12:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017b3137sm95001445e9.19.2025.09.13.01.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 49/61] rust: re-export qemu macros from common/qom/hwcore
Date: Sat, 13 Sep 2025 10:09:30 +0200
Message-ID: <20250913080943.11710-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This is just a bit nicer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-22-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                 | 2 +-
 rust/Cargo.lock                     | 8 +-------
 rust/chardev/Cargo.toml             | 1 -
 rust/chardev/meson.build            | 2 +-
 rust/chardev/src/chardev.rs         | 2 +-
 rust/common/Cargo.toml              | 1 +
 rust/common/meson.build             | 2 +-
 rust/common/src/lib.rs              | 2 ++
 rust/common/src/opaque.rs           | 4 +---
 rust/hw/char/pl011/Cargo.toml       | 1 -
 rust/hw/char/pl011/meson.build      | 1 -
 rust/hw/char/pl011/src/device.rs    | 4 ++--
 rust/hw/char/pl011/src/registers.rs | 2 +-
 rust/hw/core/Cargo.toml             | 2 +-
 rust/hw/core/meson.build            | 2 +-
 rust/hw/core/src/irq.rs             | 2 +-
 rust/hw/core/src/lib.rs             | 1 +
 rust/hw/core/src/qdev.rs            | 4 ++--
 rust/hw/core/src/sysbus.rs          | 2 +-
 rust/hw/core/tests/tests.rs         | 4 ++--
 rust/hw/timer/hpet/Cargo.toml       | 1 -
 rust/hw/timer/hpet/meson.build      | 1 -
 rust/hw/timer/hpet/src/device.rs    | 6 +++---
 rust/meson.build                    | 3 ++-
 rust/migration/Cargo.toml           | 1 -
 rust/qom/src/lib.rs                 | 2 ++
 rust/qom/src/qom.rs                 | 4 ++--
 rust/system/Cargo.toml              | 1 -
 rust/system/meson.build             | 2 +-
 rust/system/src/memory.rs           | 2 +-
 rust/tests/Cargo.toml               | 1 -
 rust/util/Cargo.toml                | 1 -
 rust/util/meson.build               | 2 +-
 rust/util/src/timer.rs              | 4 ++--
 34 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 20d15347def..29eb48af35b 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -278,7 +278,7 @@ a raw pointer, for use in calls to C functions.  It can be used for
 example as follows::
 
     #[repr(transparent)]
-    #[derive(Debug, qemu_api_macros::Wrapper)]
+    #[derive(Debug, common::Wrapper)]
     pub struct Object(Opaque<bindings::Object>);
 
 where the special ``derive`` macro provides useful methods such as
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index ac79c6a34a9..eea928621a7 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -58,7 +58,6 @@ dependencies = [
  "bql",
  "common",
  "migration",
- "qemu_macros",
  "qom",
  "util",
 ]
@@ -68,6 +67,7 @@ name = "common"
 version = "0.1.0"
 dependencies = [
  "libc",
+ "qemu_macros",
 ]
 
 [[package]]
@@ -93,7 +93,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -133,7 +132,6 @@ name = "migration"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_macros",
  "util",
 ]
 
@@ -149,7 +147,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -232,7 +229,6 @@ name = "system"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_macros",
  "qom",
  "util",
 ]
@@ -246,7 +242,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -266,7 +261,6 @@ dependencies = [
  "common",
  "foreign",
  "libc",
- "qemu_macros",
 ]
 
 [[package]]
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
index c1391773078..3e77972546e 100644
--- a/rust/chardev/Cargo.toml
+++ b/rust/chardev/Cargo.toml
@@ -18,7 +18,6 @@ bql = { path = "../bql" }
 migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index a2fa3268d21..370895c111f 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -38,4 +38,4 @@ _chardev_rs = static_library(
   dependencies: [common_rs, qemu_macros],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_macros, chardev, qemuutil])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index cb6f99398eb..2014479674f 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -26,7 +26,7 @@
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
-#[derive(qemu_macros::Wrapper)]
+#[derive(common::Wrapper)]
 pub struct Chardev(Opaque<bindings::Chardev>);
 
 pub type ChardevClass = bindings::ChardevClass;
diff --git a/rust/common/Cargo.toml b/rust/common/Cargo.toml
index 5e106427e80..0e1b4fc5050 100644
--- a/rust/common/Cargo.toml
+++ b/rust/common/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 libc.workspace = true
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/common/meson.build b/rust/common/meson.build
index 230a967760d..b805e0faf57 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -19,7 +19,7 @@ _common_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _common_cfg,
-  dependencies: [libc_rs],
+  dependencies: [libc_rs, qemu_macros],
 )
 
 common_rs = declare_dependency(link_with: [_common_rs])
diff --git a/rust/common/src/lib.rs b/rust/common/src/lib.rs
index 25216503aab..8311bf945da 100644
--- a/rust/common/src/lib.rs
+++ b/rust/common/src/lib.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use qemu_macros::{TryInto, Wrapper};
+
 pub mod assertions;
 
 pub mod bitops;
diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
index 3b3263acaa3..c941fb45462 100644
--- a/rust/common/src/opaque.rs
+++ b/rust/common/src/opaque.rs
@@ -192,7 +192,7 @@ pub unsafe fn new() -> Self {
 
 /// Annotates [`Self`] as a transparent wrapper for another type.
 ///
-/// Usually defined via the [`qemu_macros::Wrapper`] derive macro.
+/// Usually defined via the [`crate::Wrapper`] derive macro.
 ///
 /// # Examples
 ///
@@ -227,8 +227,6 @@ pub unsafe fn new() -> Self {
 /// ```
 ///
 /// They are not defined here to allow them to be `const`.
-///
-/// [`qemu_macros::Wrapper`]: ../../qemu_macros/derive.Wrapper.html
 pub unsafe trait Wrapper {
     type Wrapped;
 }
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 285d25c2178..b2418abc4bf 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -24,7 +24,6 @@ qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
-qemu_macros = { path = "../../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index a14993f6921..628a5238702 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -35,7 +35,6 @@ _libpl011_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_macros,
     qom_rs,
     chardev_rs,
     system_rs,
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 85626a969d4..1b4587d5f60 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -97,7 +97,7 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_macros::Object, qemu_macros::Device)]
+#[derive(qom::Object, hwcore::Device)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
@@ -683,7 +683,7 @@ pub fn post_load(&self, _version_id: u8) -> Result<(), migration::InvalidError>
 }
 
 #[repr(C)]
-#[derive(qemu_macros::Object, qemu_macros::Device)]
+#[derive(qom::Object, hwcore::Device)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index a1c41347ed5..0c3a4d7d214 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -16,7 +16,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug, Eq, PartialEq, qemu_macros::TryInto)]
+#[derive(Debug, Eq, PartialEq, common::TryInto)]
 pub enum RegisterOffset {
     /// Data Register
     ///
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index 0eb9ffee263..9a9aa517082 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+qemu_macros = { path = "../../qemu-macros" }
 common = { path = "../../common" }
 bql = { path = "../../bql" }
 qom = { path = "../../qom" }
@@ -20,7 +21,6 @@ chardev = { path = "../../chardev" }
 migration = { path = "../../migration" }
 system = { path = "../../system" }
 util = { path = "../../util" }
-qemu_macros = { path = "../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 67eacf854fe..81d8c77f9ad 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -71,7 +71,7 @@ test('rust-hwcore-rs-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_macros, util_rs]),
+        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, util_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
index d8d964cad27..e0d7784d97b 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -18,7 +18,7 @@
 
 /// An opaque wrapper around [`bindings::IRQState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct IRQState(Opaque<bindings::IRQState>);
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index c5588d9bc27..b40801eb843 100644
--- a/rust/hw/core/src/lib.rs
+++ b/rust/hw/core/src/lib.rs
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use qemu_macros::Device;
 pub use qom;
 
 pub mod bindings;
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index c9faf44a71d..71b9ef141c3 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -23,7 +23,7 @@
 
 /// A safe wrapper around [`bindings::Clock`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct Clock(Opaque<bindings::Clock>);
 
 unsafe impl Send for Clock {}
@@ -31,7 +31,7 @@ unsafe impl Sync for Clock {}
 
 /// A safe wrapper around [`bindings::DeviceState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct DeviceState(Opaque<bindings::DeviceState>);
 
 unsafe impl Send for DeviceState {}
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 92c7449b802..282315fce99 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -19,7 +19,7 @@
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
 
 unsafe impl Send for SysBusDevice {}
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 2f08b8f3bfe..247d812866d 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -17,7 +17,7 @@
     .build();
 
 #[repr(C)]
-#[derive(qemu_macros::Object, qemu_macros::Device)]
+#[derive(qom::Object, hwcore::Device)]
 pub struct DummyState {
     parent: ParentField<DeviceState>,
     #[property(rename = "migrate-clk", default = true)]
@@ -54,7 +54,7 @@ impl DeviceImpl for DummyState {
 }
 
 #[repr(C)]
-#[derive(qemu_macros::Object, qemu_macros::Device)]
+#[derive(qom::Object, hwcore::Device)]
 pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 08bf97af553..f781b28d8b3 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -17,7 +17,6 @@ migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
-qemu_macros = { path = "../../../qemu-macros" }
 hwcore = { path = "../../../hw/core" }
 
 [lints]
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 8ab26630d95..b6bb9477f0c 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -8,7 +8,6 @@ _libhpet_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_macros,
     qom_rs,
     system_rs,
     hwcore_rs,
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 07e0f639fc4..3cfbe9c32bb 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -97,7 +97,7 @@
 /// Timer N Interrupt Routing Capability (bits 32:63)
 const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
 
-#[derive(qemu_macros::TryInto)]
+#[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Timer registers, masked by 0x18
@@ -110,7 +110,7 @@ enum TimerRegister {
     ROUTE = 16,
 }
 
-#[derive(qemu_macros::TryInto)]
+#[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Global registers
@@ -520,7 +520,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_macros::Object)]
+#[derive(qom::Object)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
diff --git a/rust/meson.build b/rust/meson.build
index bd9b9cb83ea..c7bd6aba45f 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -20,8 +20,9 @@ proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
 genrs = []
 
-subdir('common')
 subdir('qemu-macros')
+
+subdir('common')
 subdir('bits')
 subdir('util')
 subdir('migration')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 66af81e0a35..708bfaaa682 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,7 +15,6 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 util = { path = "../util" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/qom/src/lib.rs b/rust/qom/src/lib.rs
index 204c6fea2ff..24c44fc2afb 100644
--- a/rust/qom/src/lib.rs
+++ b/rust/qom/src/lib.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use qemu_macros::Object;
+
 pub mod bindings;
 
 // preserve one-item-per-"use" syntax, it is clearer
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index 2cd1d850112..5808051cd77 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -112,7 +112,7 @@
 
 /// A safe wrapper around [`bindings::Object`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct Object(Opaque<bindings::Object>);
 
 unsafe impl Send for Object {}
@@ -173,7 +173,7 @@ fn as_ref(&self) -> &$parent {
 ///
 /// ```ignore
 /// #[repr(C)]
-/// #[derive(qemu_macros::Object)]
+/// #[derive(qom::Object)]
 /// pub struct MyDevice {
 ///     parent: ParentField<DeviceState>,
 ///     ...
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index d8338c8348d..7fd369b9e32 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -16,7 +16,6 @@ rust-version.workspace = true
 common = { path = "../common" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 9f88166f3d3..3ec140de018 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -39,4 +39,4 @@ _system_rs = static_library(
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
-  dependencies: [qemu_macros, hwcore])
+  dependencies: [hwcore])
diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 7312f809f51..02aa3af7b13 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -129,7 +129,7 @@ fn default() -> Self {
 
 /// A safe wrapper around [`bindings::MemoryRegion`].
 #[repr(transparent)]
-#[derive(qemu_macros::Wrapper)]
+#[derive(common::Wrapper)]
 pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
 
 unsafe impl Send for MemoryRegion {}
diff --git a/rust/tests/Cargo.toml b/rust/tests/Cargo.toml
index 8d106d896d7..d47dc3314d8 100644
--- a/rust/tests/Cargo.toml
+++ b/rust/tests/Cargo.toml
@@ -19,7 +19,6 @@ hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
-qemu_macros = { path = "../qemu-macros" }
 qom = { path = "../qom" }
 system = { path = "../system" }
 
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 18e6619ca06..1f6767ed9d1 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -17,7 +17,6 @@ anyhow = { workspace = true }
 foreign = { workspace = true }
 libc = { workspace = true }
 common = { path = "../common" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 197872c9b23..87a893673d2 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,7 +39,7 @@ _util_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, common_rs, qemu_macros, qom, qemuutil],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, common_rs, qom, qemuutil],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 622b6ee3097..c6b3e4088ec 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -15,14 +15,14 @@
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct Timer(Opaque<bindings::QEMUTimer>);
 
 unsafe impl Send for Timer {}
 unsafe impl Sync for Timer {}
 
 #[repr(transparent)]
-#[derive(qemu_macros::Wrapper)]
+#[derive(common::Wrapper)]
 pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
 
 unsafe impl Send for TimerListGroup {}
-- 
2.51.0


