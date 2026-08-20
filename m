Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CFCC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60M-00037q-Hc; Thu, 20 Aug 2026 12:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60K-0002o0-FH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60H-0005pc-KH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCHctzzDs3xln2aqmgC4aBI2BJIXOrhX3C8pfOImeTs=;
 b=I4OWX/N4SlNg01h6yqFMJvFPclSUs5pxRiTmUyK5y77a8N2fh2f+YNh73a0ovGXvWLddmJ
 vtDAniqMz3ytPyPOPlKf2x+YcMh0MioHwqk0kjkruRvFQB3ohL2LnMt66iD1E5L9FbZAn6
 u1GGfyhT/G4aPR//Ll+ojm/Im/BLdoI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-PeQ6FLkEOZqBsZ3yzudr2Q-1; Thu, 20 Aug 2026 12:52:31 -0400
X-MC-Unique: PeQ6FLkEOZqBsZ3yzudr2Q-1
X-Mimecast-MFC-AGG-ID: PeQ6FLkEOZqBsZ3yzudr2Q_1787244750
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49554715277so280675e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244750; x=1787849550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aCHctzzDs3xln2aqmgC4aBI2BJIXOrhX3C8pfOImeTs=;
 b=koaHMGXbbcTYdXv8FNcm4dehuklWE42bX0k71D4ftyZnArdFoJl0AmKsjAkI6tnyc5
 vfteptYZAU16zPkkp/Wv9gUVDXoZtSI5aMXFvJDKvDlDDOYsCyADjf+Ga3su12jg8x43
 KWziqDeb3QVE8Apm8i68wwCZD750mDBInx/BZi8rPhDxz2cwQ4+Bme3um0U7XWEttN/S
 U5tinSfJhrl2JKW7Mof/nTwdPESYuYXAuf0pUrxvbzjSRji4vq85Hox0NE3UzGnVFral
 0+aZcDBT8PBGXj7TUpzhSn1yJbpvEhH/hUvhVEYhYMd4aUi0qTlOQBHgci5g+uKoBs1n
 OYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244750; x=1787849550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aCHctzzDs3xln2aqmgC4aBI2BJIXOrhX3C8pfOImeTs=;
 b=I6P4MNXQXj86dZGs4BNwduM3XXBnc0I0j0b07QBp4bwEUjDhlhq5DsqEaCqOKh6Dhn
 q5taXDO4OMkSNtcV3Fr2nR540hbUjoy08riQHrAZvGAZ3g1KdH0l4XW51S/zjDklGEZa
 QfdutqEQfQCF8klTcl8yV37Xd0uSseVCRP8mSKjTY3SvqqLFAf4ASOPMNE7k0s9Garff
 +K9Ui8B9lYgRKb7mqDpTpnM6Ay5eDdR/JouSlpF8j1i/169pxYOhCdr+Y4mllHCZo0/l
 bhsOyhbjkGMyGhDf1DW9vZBRp94nB/uP7UnKv+0IRg4b1KoQFb7Yvf5oTBfLwvUXTk4r
 RMPQ==
X-Gm-Message-State: AOJu0Yw7TBhCHcXkeJmUtorqtnx1dE491MBMfY1GTKZtKZh5pw72caa3
 ndrvDu2H3L7TDFToBflZtbfqC2MwTUAk//UUtNDstMhQK9TC0zKhDt+bjZO34hLcNn89RYNYYrA
 3CwqjLH5R8czWmRJ1f7/U/hXiQbKzAA9DVrFdPHBQRhiZhcxyK31D4j1gu3uuVe20WzZpODxaJD
 TudpRNc/MoLz6JdRUAXDq21wFU3KCC12VMz1rXylno
X-Gm-Gg: AR+sD12R9P66MAIMv4Kuy1yAIYTL0XSwI7RGHs/jjsbMmT27z2bHhWGsm+dLR9pc/zI
 Taf6oIFWWr/2zk+oopsxh11fq8Rfm5h/Hopb8TD0ArPfN375ANXsi7OdTNWRTc0kDKcLamhTXNn
 hABW1T6bQS70mA/cGnnVGglt2bO4qCvwW8X/nTzCqo8bTl3rXzoxnHIja8OyQM0JRsKVLp71Gwg
 JtfgEWh+F5Wvf05sJuYEOvhEAErezcXgSa8A92gZrncoZZm3YQv8oltJuhGaV/ao949X94k6FHJ
 S22XpgZtarbZSuF0ka0LltKhlNrqh/diu6ogMvnGa+MuuOT0eQBZCD1g5zKs0JITPqOqMLyao20
 l8k2z9vOwpxHtPmCD4wRMbDfiOybVSCoQ2zKvOFe4Y3wZZfGZLx9rFdiJMaMOAiK/n8JrjmKKmD
 It6j4=
X-Received: by 2002:a05:600c:4e91:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499b83547e9mr2951385e9.13.1787244749683; 
 Thu, 20 Aug 2026 09:52:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4e91:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499b83547e9mr2950295e9.13.1787244749095; 
 Thu, 20 Aug 2026 09:52:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd3c9sm159273115e9.12.2026.08.20.09.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 53/53] rust: remove bilge crate
Date: Thu, 20 Aug 2026 18:49:56 +0200
Message-ID: <20260820164957.1895963-54-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It has just been replaced with bitfield-struct.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Cargo.lock                                    | 73 -------------------
 rust/migration/src/vmstate.rs                 | 45 +-----------
 scripts/archive-source.sh                     |  6 --
 scripts/make-release                          |  5 +-
 subprojects/.gitignore                        |  7 --
 subprojects/arbitrary-int-1-rs.wrap           |  9 ---
 subprojects/bilge-0.2-rs.wrap                 |  9 ---
 subprojects/bilge-impl-0.2-rs.wrap            |  9 ---
 subprojects/either-1-rs.wrap                  |  9 ---
 subprojects/itertools-0.11-rs.wrap            |  9 ---
 .../proc-macro-error-1-rs/meson/meson.build   |  3 -
 subprojects/proc-macro-error-1-rs.wrap        | 10 ---
 subprojects/proc-macro-error-attr-1-rs.wrap   |  9 ---
 13 files changed, 5 insertions(+), 198 deletions(-)
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap

diff --git a/Cargo.lock b/Cargo.lock
index 6f683e8bb1e..ad664a812d2 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -8,12 +8,6 @@ version = "1.0.98"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
 
-[[package]]
-name = "arbitrary-int"
-version = "1.2.7"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
-
 [[package]]
 name = "attrs"
 version = "0.2.9"
@@ -35,29 +29,6 @@ dependencies = [
  "syn",
 ]
 
-[[package]]
-name = "bilge"
-version = "0.2.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57"
-dependencies = [
- "arbitrary-int",
- "bilge-impl",
-]
-
-[[package]]
-name = "bilge-impl"
-version = "0.2.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8"
-dependencies = [
- "itertools",
- "proc-macro-error",
- "proc-macro2",
- "quote",
- "syn",
-]
-
 [[package]]
 name = "bits"
 version = "0.1.0"
@@ -114,12 +85,6 @@ dependencies = [
  "qemu_macros",
 ]
 
-[[package]]
-name = "either"
-version = "1.12.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
-
 [[package]]
 name = "equivalent"
 version = "1.0.2"
@@ -208,15 +173,6 @@ dependencies = [
  "hashbrown",
 ]
 
-[[package]]
-name = "itertools"
-version = "0.11.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
-dependencies = [
- "either",
-]
-
 [[package]]
 name = "libc"
 version = "0.2.162"
@@ -274,29 +230,6 @@ version = "0.5.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e"
 
-[[package]]
-name = "proc-macro-error"
-version = "1.0.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
-dependencies = [
- "proc-macro-error-attr",
- "proc-macro2",
- "quote",
- "version_check",
-]
-
-[[package]]
-name = "proc-macro-error-attr"
-version = "1.0.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
-dependencies = [
- "proc-macro2",
- "quote",
- "version_check",
-]
-
 [[package]]
 name = "proc-macro2"
 version = "1.0.95"
@@ -529,12 +462,6 @@ version = "0.2.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "852e951cb7832cb45cb1169900d19760cfa39b82bc0ea9c0e5a14ae88411c98b"
 
-[[package]]
-name = "version_check"
-version = "0.9.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
-
 [[package]]
 name = "winnow"
 version = "1.0.4"
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 63d78b4f275..7409b592a2c 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -11,8 +11,7 @@
 //!   migration format for a struct.  This is based on the [`VMState`] trait,
 //!   which is defined by all migratable types.
 //!
-//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward),
-//!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), and
+//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward) and
 //!   [`impl_vmstate_struct`](crate::impl_vmstate_struct), which help with the
 //!   definition of the [`VMState`] trait (respectively for transparent structs,
 //!   nested structs and `bilge`-defined types)
@@ -90,7 +89,7 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker:
 /// The contents of this trait go straight into structs that are parsed by C
 /// code and used to introspect into other structs.  Generally, you don't need
 /// to implement it except via macros that do it for you, such as
-/// `impl_vmstate_bitsized!`.
+/// `impl_vmstate_forward!`.
 pub unsafe trait VMState {
     /// The base contents of a `VMStateField` (minus the name and offset) for
     /// the type that is implementing the trait.
@@ -133,9 +132,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
-/// for them.  The macros [`impl_vmstate_forward`](crate::impl_vmstate_forward),
-/// [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), and
-/// [`impl_vmstate_struct`](crate::impl_vmstate_struct) help with this.
+/// for them.  The macros [`impl_vmstate_forward`](crate::impl_vmstate_forward)
+/// and [`impl_vmstate_struct`](crate::impl_vmstate_struct) help with this.
 ///
 /// [`BqlCell`]: ../../bql/cell/struct.BqlCell.html
 /// [`BqlRefCell`]: ../../bql/cell/struct.BqlRefCell.html
@@ -211,41 +209,6 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
 impl_vmstate_transparent!(common::Opaque<T> where T: VMState);
 impl_vmstate_transparent!(std::mem::ManuallyDrop<T> where T: VMState);
 
-#[macro_export]
-macro_rules! impl_vmstate_bitsized {
-    ($type:ty) => {
-        unsafe impl $crate::vmstate::VMState for $type {
-            const BASE: $crate::bindings::VMStateField =
-                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType
-                                         as $crate::vmstate::VMState>::BASE;
-            const VARRAY_FLAG: $crate::bindings::VMStateFlags =
-                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType
-                                         as $crate::vmstate::VMState>::VARRAY_FLAG;
-        }
-
-        impl $crate::migratable::ToMigrationState for $type {
-            type Migrated = <<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType;
-
-            fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), $crate::InvalidError> {
-                *target = Self::Migrated::from(*self);
-                Ok(())
-            }
-
-            fn restore_migrated_state_mut(
-                &mut self,
-                source: Self::Migrated,
-                version_id: u8,
-            ) -> Result<(), $crate::InvalidError> {
-                *self = Self::from(source);
-                Ok(())
-            }
-        }
-    };
-}
-
 // Scalar types using predefined VMStateInfos
 
 macro_rules! impl_vmstate_scalar {
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 5d52644df9c..399b2d99e83 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -32,19 +32,13 @@ subprojects=(
   attrs-0.2-rs
   berkeley-softfloat-3
   berkeley-testfloat-3
-  bilge-0.2-rs
-  bilge-impl-0.2-rs
   bitfield-0.9-rs
-  either-1-rs
   foreign-0.3-rs
   glib-sys-0.21-rs
-  itertools-0.11-rs
   keycodemapdb
   libc-0.2-rs
   libvfio-user
   probe-0.5-rs
-  proc-macro-error-1-rs
-  proc-macro-error-attr-1-rs
   proc-macro2-1-rs
   quote-1-rs
   syn-2-rs
diff --git a/scripts/make-release b/scripts/make-release
index fc0dc4bceb8..b5944d39286 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -41,10 +41,7 @@ fi
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
-  bilge-impl-0.2-rs bitfield-0.9-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
-  libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
-  proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
+  bitfield-0.9-rs foreign-0.3-rs libc-0.2-rs probe-0.5-rs proc-macro2-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
 src="$1"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 984f5865dc8..3559b2c758f 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -7,19 +7,12 @@
 /libvfio-user
 /slirp
 /anyhow-*
-/arbitrary-int-*
 /attrs-*
-/bilge-*
-/bilge-impl-*
 /bitfield-struct-*
-/either-*
 /foreign-*
 /glib-sys-*
-/itertools-*
 /libc-*
 /probe-*
-/proc-macro-error-*
-/proc-macro-error-attr-*
 /proc-macro*
 /quote-*
 /syn-*
diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
deleted file mode 100644
index 5cf4b11e4a3..00000000000
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = arbitrary-int-1.2.7
-source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
-source_filename = arbitrary-int-1.2.7.tar.gz
-source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
deleted file mode 100644
index cff10f6710d..00000000000
--- a/subprojects/bilge-0.2-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = bilge-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
-source_filename = bilge-0.2.0.tar.gz
-source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
deleted file mode 100644
index f8963eba73f..00000000000
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = bilge-impl-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
-source_filename = bilge-impl-0.2.0.tar.gz
-source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
deleted file mode 100644
index 51c97df1531..00000000000
--- a/subprojects/either-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = either-1.12.0
-source_url = https://crates.io/api/v1/crates/either/1.12.0/download
-source_filename = either-1.12.0.tar.gz
-source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
deleted file mode 100644
index e123ab389a2..00000000000
--- a/subprojects/itertools-0.11-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = itertools-0.11.0
-source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
-source_filename = itertools-0.11.0.tar.gz
-source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
deleted file mode 100644
index 52a244d2b16..00000000000
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
+++ /dev/null
@@ -1,3 +0,0 @@
-extra_args = [
-    '--cfg', 'use_fallback',
-]
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
deleted file mode 100644
index e57921bfadc..00000000000
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
-source_filename = proc-macro-error-1.0.4.tar.gz
-source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
-method = cargo
-patch_directory = proc-macro-error-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
deleted file mode 100644
index 456d2c2b6d4..00000000000
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-attr-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
-source_filename = proc-macro-error-attr-1.0.4.tar.gz
-source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
-- 
2.55.0


