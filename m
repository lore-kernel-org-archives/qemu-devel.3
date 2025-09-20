Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA53CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybU-0007Jr-SB; Sat, 20 Sep 2025 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybR-0007J0-SE
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybP-0005Sn-Db
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIs8xQFHDs7W4qQkqDiO7oV8jErY0TH0WVxlppzb/1s=;
 b=CyHu+uyBpD4YArI8lxO1NqAZ2EKEyYPAQf22BaZ5hOg+cuaVnPLwkA+zd2wW9A1eHKSZGR
 4FcDz7i9/ONXPBhWDwsrNfLbBasSIUcim7yUArBNNQghK1KOGPv4eh0q+sIU8SVbKJhqn3
 deOBMEBRMs6gYHsYlKApfWqVmS1H7R8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-wp8ER5C3MPOMpzWDW1Bm-w-1; Sat, 20 Sep 2025 10:30:12 -0400
X-MC-Unique: wp8ER5C3MPOMpzWDW1Bm-w-1
X-Mimecast-MFC-AGG-ID: wp8ER5C3MPOMpzWDW1Bm-w_1758378612
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2a1660fcso28088725e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378611; x=1758983411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIs8xQFHDs7W4qQkqDiO7oV8jErY0TH0WVxlppzb/1s=;
 b=atORjQ5TqFQRbbzWEaVOCOeVUTFE31NNg2mzzlYDcGQKGpmivP2n62FQXtHCRBFHfF
 3LWXHcJzOwlVtPAVR1IYWE4le4bBi+y1gX8CzR7zx48gwbtmOFywajJV3+SeTJ3h2V4B
 jVytb4m56ow4hVY16zgNx6ZioN00mdmmdPN1Sg+A8IlVymYSrc/tE0D7WLXM+dLcd+id
 Mm4+PLRq7iQ8SiAQQIp/Xr+rBNt+ETbH4VN4DRB51/+rOYlEMA+25VNonMCXmtytPoYp
 eGtHU8YEpoKL6JHflgp7Hu3w4Vs+E0MxC6Hph5Kat+dDqU/8Ucv4kdIQw6PMNA2V98Md
 Or4Q==
X-Gm-Message-State: AOJu0YxgEylchIzCfrXn3AH5ni6W51fbLq3tUbXRQRW6wCKg6mg8fXlU
 5RCR43cUx4nvcWkUa7cF0T69zjBgaO+mKcj594uHyheRQQBbsO3u12/yziacDtCtdX8XZi7DOKV
 xo0eKHmK6jMMFbikrfK4GEA8XZg/MkXEbUk2UE/YhIsUpvjgEc1rcesdhUi1hEHsoopVf8XVxoo
 vWEHGq6eVD4JGpXUfz5UItd6TLyhkjoJ/FHmS9YmgH
X-Gm-Gg: ASbGncvB5lGcZSZyRUFo8Pb2QtHY91mLl/vFqRjrC6ZwrcvTwIZ/b19wkF1+K/4SHIF
 1ogO3aJi9wN/qEUaY0729Qz4pZ396VHZgQnsXeisiI9A9G15RahrvMBQOoQIHoEfJw/h8sj92J4
 WDWPL5Uy5rhtEgPM6pfoqRSl6akgTbEYRPpMfzqIEIDy6S9IvgRjaM/qqMCgucLX4SDFNkKPobD
 z1Kds7L8mp+V48/zMApBgbzvsFzBYO7u/ryHEIA3HHkGI2UuXta1McS1PJruNrlo9/WR3xffQGy
 +on/sSOLolsbDIwTwwENCxKd5JIOXXnZsQhpf1jRzojvBjkflhav9hS8fG0ypwPy/DOu42JIBYu
 i08nDLnn4V73XqzOpJmQZNx+OOn1QJosSK0QzSQReH34=
X-Received: by 2002:a05:600c:45d2:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-467e6f36218mr68881545e9.12.1758378610612; 
 Sat, 20 Sep 2025 07:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6yAihBDDQWq6K/o0tKGfwu/bfeX3ARyU00Vs5xEdNClC2xOeX5XKAVt22ovDYOp0oxPHHJA==
X-Received: by 2002:a05:600c:45d2:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-467e6f36218mr68881255e9.12.1758378609964; 
 Sat, 20 Sep 2025 07:30:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-467fc818e00sm84311545e9.0.2025.09.20.07.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 4/7] rust: migration: add high-level migration wrappers
Date: Sat, 20 Sep 2025 16:29:55 +0200
Message-ID: <20250920142958.181910-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of dealing with pre/post callbacks, allow devices to
implement a snapshot/restore mechanism; this has two main
advantages:

- it can be easily implemented via procedural macros

- there can be generic implementations to deal with various
  kinds of interior-mutable containers, from BqlRefCell to Mutex,
  so that C code does not see Rust concepts such as Mutex<>.

Using it is easy; you can implement the snapshot/restore trait
ToMigrationState and declare your state like:

     regs: Migratable<Mutex<MyDeviceRegisters>>

Migratable<> allows dereferencing to the underlying object with
no run-time cost.

Note that Migratable<> actually does not accept ToMigrationState,
only the similar ToMigrationStateShared trait that the user will mostly
not care about.  This is required by the fact that pre/post callbacks
take a &self, and ensures that the argument is a Mutex or BqlRefCell
(including an array or Arc<> thereof).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                  |   1 +
 rust/migration/Cargo.toml        |   1 +
 rust/migration/meson.build       |   1 +
 rust/migration/src/lib.rs        |   3 +
 rust/migration/src/migratable.rs | 430 +++++++++++++++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 rust/migration/src/migratable.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 960f603cedb..32db90066f1 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -140,6 +140,7 @@ version = "0.1.0"
 dependencies = [
  "bql",
  "common",
+ "qemu_macros",
  "util",
 ]
 
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index f4a86275152..8efce7a72cb 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 [dependencies]
 bql = { path = "../bql" }
 common = { path = "../common" }
+qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
 
 [lints]
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 2f38da9220f..c258881790d 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -30,6 +30,7 @@ _migration_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
+      'src/migratable.rs',
       'src/vmstate.rs',
     ],
     {'.' : _migration_bindings_inc_rs},
diff --git a/rust/migration/src/lib.rs b/rust/migration/src/lib.rs
index 5f51dde4406..efe9896b619 100644
--- a/rust/migration/src/lib.rs
+++ b/rust/migration/src/lib.rs
@@ -2,5 +2,8 @@
 
 pub mod bindings;
 
+pub mod migratable;
+pub use migratable::*;
+
 pub mod vmstate;
 pub use vmstate::*;
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
new file mode 100644
index 00000000000..d09eeb35f11
--- /dev/null
+++ b/rust/migration/src/migratable.rs
@@ -0,0 +1,430 @@
+// Copyright 2025 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{
+    fmt,
+    mem::size_of,
+    ptr::{self, addr_of, NonNull},
+    sync::{Arc, Mutex},
+};
+
+use bql::{BqlCell, BqlRefCell};
+use common::Zeroable;
+
+use crate::{
+    bindings, vmstate_fields_ref, vmstate_of, InvalidError, VMState, VMStateDescriptionBuilder,
+};
+
+/// Enables QEMU migration support even when a type is wrapped with
+/// synchronization primitives (like `Mutex`) that the C migration
+/// code cannot directly handle. The trait provides methods to
+/// extract essential state for migration and restore it after
+/// migration completes.
+///
+/// On top of extracting data from synchronization wrappers during save
+/// and restoring it during load, it's also possible to use `ToMigrationState`
+/// to convert runtime representations to migration-safe formats.
+///
+/// # Examples
+///
+/// ```
+/// use bql::BqlCell;
+/// use migration::{InvalidError, ToMigrationState, VMState};
+/// # use migration::VMStateField;
+///
+/// # #[derive(Debug, PartialEq, Eq)]
+/// struct DeviceState {
+///     counter: BqlCell<u32>,
+///     enabled: bool,
+/// }
+///
+/// # #[derive(Debug)]
+/// #[derive(Default)]
+/// struct DeviceMigrationState {
+///     counter: u32,
+///     enabled: bool,
+/// }
+///
+/// # unsafe impl VMState for DeviceMigrationState {
+/// #     const BASE: VMStateField = ::common::Zeroable::ZERO;
+/// # }
+/// impl ToMigrationState for DeviceState {
+///     type Migrated = DeviceMigrationState;
+///
+///     fn snapshot_migration_state(
+///         &self,
+///         target: &mut Self::Migrated,
+///     ) -> Result<(), InvalidError> {
+///         target.counter = self.counter.get();
+///         target.enabled = self.enabled;
+///         Ok(())
+///     }
+///
+///     fn restore_migrated_state_mut(
+///         &mut self,
+///         source: Self::Migrated,
+///         _version_id: u8,
+///     ) -> Result<(), InvalidError> {
+///         self.counter.set(source.counter);
+///         self.enabled = source.enabled;
+///         Ok(())
+///     }
+/// }
+/// # bql::start_test();
+/// # let dev = DeviceState { counter: 10.into(), enabled: true };
+/// # let mig = dev.to_migration_state().unwrap();
+/// # assert!(matches!(*mig, DeviceMigrationState { counter: 10, enabled: true }));
+/// # let mut dev2 = DeviceState { counter: 42.into(), enabled: false };
+/// # dev2.restore_migrated_state_mut(*mig, 1).unwrap();
+/// # assert_eq!(dev2, dev);
+/// ```
+pub trait ToMigrationState {
+    /// The type used to represent the migrated state.
+    type Migrated: Default + VMState;
+
+    /// Capture the current state into a migration-safe format, failing
+    /// if the state cannot be migrated.
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError>;
+
+    /// Restores state from a migrated representation, failing if the
+    /// state cannot be restored.
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError>;
+
+    /// Convenience method to combine allocation and state capture
+    /// into a single operation.
+    fn to_migration_state(&self) -> Result<Box<Self::Migrated>, InvalidError> {
+        let mut migrated = Box::<Self::Migrated>::default();
+        self.snapshot_migration_state(&mut migrated)?;
+        Ok(migrated)
+    }
+}
+
+// Implementations for primitive types.  Do not use a blanket implementation
+// for all Copy types, because [T; N] is Copy if T is Copy; that would conflict
+// with the below implementation for arrays.
+macro_rules! impl_for_primitive {
+    ($($t:ty),*) => {
+        $(
+            impl ToMigrationState for $t {
+                type Migrated = Self;
+
+                fn snapshot_migration_state(
+                    &self,
+                    target: &mut Self::Migrated,
+                ) -> Result<(), InvalidError> {
+                    *target = *self;
+                    Ok(())
+                }
+
+                fn restore_migrated_state_mut(
+                    &mut self,
+                    source: Self::Migrated,
+                    _version_id: u8,
+                ) -> Result<(), InvalidError> {
+                    *self = source;
+                    Ok(())
+                }
+            }
+        )*
+    };
+}
+
+impl_for_primitive!(u8, u16, u32, u64, i8, i16, i32, i64, bool);
+
+impl<T: ToMigrationState, const N: usize> ToMigrationState for [T; N]
+where
+    [T::Migrated; N]: Default,
+{
+    type Migrated = [T::Migrated; N];
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        for (item, target_item) in self.iter().zip(target.iter_mut()) {
+            item.snapshot_migration_state(target_item)?;
+        }
+        Ok(())
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        for (item, source_item) in self.iter_mut().zip(source) {
+            item.restore_migrated_state_mut(source_item, version_id)?;
+        }
+        Ok(())
+    }
+}
+
+/// Extension trait for types that support migration state restoration
+/// through interior mutability.
+///
+/// This trait extends [`ToMigrationState`] for types that can restore
+/// their state without requiring mutable access. While user structs
+/// will generally use `ToMigrationState`, the device will have multiple
+/// references and therefore the device struct has to employ an interior
+/// mutability wrapper like [`Mutex`] or [`BqlRefCell`].
+///
+/// Anything that implements this trait can in turn be used within
+/// [`Migratable<T>`], which makes no assumptions on how to achieve mutable
+/// access to the runtime state.
+///
+/// # Examples
+///
+/// ```
+/// use std::sync::Mutex;
+///
+/// use migration::ToMigrationStateShared;
+///
+/// let device_state = Mutex::new(42);
+/// // Can restore without &mut access
+/// device_state.restore_migrated_state(100, 1).unwrap();
+/// assert_eq!(*device_state.lock().unwrap(), 100);
+/// ```
+pub trait ToMigrationStateShared: ToMigrationState {
+    /// Restores state from a migrated representation to an interior-mutable
+    /// object.  Similar to `restore_migrated_state_mut`, but requires a
+    /// shared reference; therefore it can be used to restore a device's
+    /// state even though devices have multiple references to them.
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError>;
+}
+
+impl<T: ToMigrationStateShared, const N: usize> ToMigrationStateShared for [T; N]
+where
+    [T::Migrated; N]: Default,
+{
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        for (item, source_item) in self.iter().zip(source) {
+            item.restore_migrated_state(source_item, version_id)?;
+        }
+        Ok(())
+    }
+}
+
+impl<T: ToMigrationStateShared> ToMigrationState for Arc<T> {
+    type Migrated = T::Migrated;
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        (**self).snapshot_migration_state(target)
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        (**self).restore_migrated_state(source, version_id)
+    }
+}
+
+impl<T: ToMigrationStateShared> ToMigrationStateShared for Arc<T> {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        (**self).restore_migrated_state(source, version_id)
+    }
+}
+
+// Interior-mutable types only require ToMigrationState for the inner type!
+
+impl<T: ToMigrationState> ToMigrationState for Mutex<T> {
+    type Migrated = T::Migrated;
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        self.lock().unwrap().snapshot_migration_state(target)
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.restore_migrated_state(source, version_id)
+    }
+}
+
+impl<T: ToMigrationState> ToMigrationStateShared for Mutex<T> {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.lock()
+            .unwrap()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+impl<T: ToMigrationState> ToMigrationState for BqlRefCell<T> {
+    type Migrated = T::Migrated;
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        self.borrow().snapshot_migration_state(target)
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.get_mut()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+impl<T: ToMigrationState> ToMigrationStateShared for BqlRefCell<T> {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.borrow_mut()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+/// A wrapper that enables QEMU migration for types with shared state.
+///
+/// `Migratable<T>` provides a bridge between Rust types that use interior
+/// mutability (like `Mutex<T>`) and QEMU's C-based migration infrastructure.
+/// It manages the lifecycle of migration state and provides automatic
+/// conversion between runtime and migration representations.
+///
+/// ```ignore
+/// # use std::sync::Mutex;
+/// # use migration::Migratable;
+///
+/// pub struct DeviceRegs {
+///     status: u32,
+/// }
+///
+/// pub struct SomeDevice {
+///     // ...
+///     registers: Migratable<Mutex<DeviceRegs>>,
+/// }
+/// ```
+#[repr(C)]
+pub struct Migratable<T: ToMigrationStateShared> {
+    /// Pointer to migration state, valid only during migration operations.
+    /// C vmstate does not support NULL pointers, so no `Option<Box<>>`.
+    migration_state: BqlCell<*mut T::Migrated>,
+
+    /// The runtime state that can be accessed during normal operation
+    runtime_state: T,
+}
+
+impl<T: ToMigrationStateShared> std::ops::Deref for Migratable<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.runtime_state
+    }
+}
+
+impl<T: ToMigrationStateShared> std::ops::DerefMut for Migratable<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.runtime_state
+    }
+}
+
+impl<T: ToMigrationStateShared> Migratable<T> {
+    /// Creates a new `Migratable` wrapper around the given runtime state.
+    ///
+    /// # Returns
+    /// A new `Migratable` instance ready for use and migration
+    pub fn new(runtime_state: T) -> Self {
+        Self {
+            migration_state: BqlCell::new(ptr::null_mut()),
+            runtime_state,
+        }
+    }
+
+    fn pre_save(&self) -> Result<(), InvalidError> {
+        let state = self.runtime_state.to_migration_state()?;
+        self.migration_state.set(Box::into_raw(state));
+        Ok(())
+    }
+
+    fn post_save(&self) -> Result<(), InvalidError> {
+        let state = unsafe { Box::from_raw(self.migration_state.take()) };
+        drop(state);
+        Ok(())
+    }
+
+    fn pre_load(&self) -> Result<(), InvalidError> {
+        self.migration_state
+            .set(Box::into_raw(Box::<T::Migrated>::default()));
+        Ok(())
+    }
+
+    fn post_load(&self, version_id: u8) -> Result<(), InvalidError> {
+        let state = unsafe { Box::from_raw(self.migration_state.take()) };
+        self.runtime_state
+            .restore_migrated_state(*state, version_id)
+    }
+}
+
+impl<T: ToMigrationStateShared + fmt::Debug> fmt::Debug for Migratable<T>
+where
+    T::Migrated: fmt::Debug,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let mut struct_f = f.debug_struct("Migratable");
+        struct_f.field("runtime_state", &self.runtime_state);
+
+        let state = NonNull::new(self.migration_state.get()).map(|x| unsafe { x.as_ref() });
+        struct_f.field("migration_state", &state);
+        struct_f.finish()
+    }
+}
+
+impl<T: ToMigrationStateShared + Default> Default for Migratable<T> {
+    fn default() -> Self {
+        Self::new(T::default())
+    }
+}
+
+impl<T: 'static + ToMigrationStateShared> Migratable<T> {
+    const FIELD: bindings::VMStateField = vmstate_of!(Self, migration_state);
+
+    const FIELDS: &[bindings::VMStateField] = vmstate_fields_ref! {
+        Migratable::<T>::FIELD
+    };
+
+    const VMSD: &'static bindings::VMStateDescription = VMStateDescriptionBuilder::<Self>::new()
+        .version_id(1)
+        .minimum_version_id(1)
+        .pre_save(&Self::pre_save)
+        .pre_load(&Self::pre_load)
+        .post_save(&Self::post_save)
+        .post_load(&Self::post_load)
+        .fields(Self::FIELDS.as_ptr())
+        .build()
+        .as_ref();
+}
+
+unsafe impl<T: 'static + ToMigrationStateShared> VMState for Migratable<T> {
+    const BASE: bindings::VMStateField = {
+        bindings::VMStateField {
+            vmsd: addr_of!(*Self::VMSD),
+            size: size_of::<Self>(),
+            flags: bindings::VMStateFlags::VMS_STRUCT,
+            ..Zeroable::ZERO
+        }
+    };
+}
-- 
2.51.0


