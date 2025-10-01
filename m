Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45B9CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3re1-0006k8-VW; Wed, 01 Oct 2025 03:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdi-0006YO-Rm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdc-000379-Bt
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rd6GXZPpL5hdpSdATS9KIv+PMnWgt+YHLrvRSFSylso=;
 b=TxF46x78R9wYfuzbw2ps3Hky1xGl0zShlksN+nSmOX301P5DHghpg2J+ER4bJXIk0malX2
 eldkC0WYvDZKlKXFtqqggkM/wnGEOwhwqJZmZzviUq8O05BJCSecIt7CXgY243a3iN4yil
 p3WKfSJY6tM29WWbgsQ6htexF6Pv7kY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-XJH0LBr6Pe-BOkSv6CodOQ-1; Wed, 01 Oct 2025 03:52:26 -0400
X-MC-Unique: XJH0LBr6Pe-BOkSv6CodOQ-1
X-Mimecast-MFC-AGG-ID: XJH0LBr6Pe-BOkSv6CodOQ_1759305146
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-634c2fc71c9so6059475a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305145; x=1759909945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rd6GXZPpL5hdpSdATS9KIv+PMnWgt+YHLrvRSFSylso=;
 b=L09FM/6VtBFErj/CL03MNGvO3BHeP07WFl3aE5L6bccVwjU4TTnBb5vPHh91OgEYeN
 LzP9i7icSFepUWuXOvQGZZra7YpS6w8dlCO75o14L6xJ6zA3pizNiMtx9aA9wkgMKASW
 fq57s+zPU4t3af126MiGiU32DXqynYYjGcbI5CkMwoFrIkhgjovjorYf+4Mz6ttVBURl
 0NQmFCMwpd9wt+B4Y5/yhS6XEisRN4X+JSjqhKvr1GqWWBu2tdQCOgFoL3dpWyMQX3Cj
 qCG21oL+HXuYTuAh1w5PhhGRgjQOMpA+t9qUrRk025sfHs6v8WKg3t3f26uVkSQGlWg6
 yhLw==
X-Gm-Message-State: AOJu0YwLLf2nbHVDpH7lMkhYVeUqVOn+hbTRUF3HelvD23cFAEXol/Ts
 8G+xDvW/dLfsx7uU5XV8DmlANVUjm3N/YjNdkQfZhw9sruYITDijnHlHe1lYk6mEuSnSXBZGmpS
 t56JK9q/PseKQKIu8kQXpKuVVWGMg/5OCv3AerCDPx/uIFYyrlhRZXs6UmPu7glTBJG31ookT1l
 RHispnEXpyIB//mEdKFs55W+bCe/r0WW98kb7Gu4mU
X-Gm-Gg: ASbGnctXnC+9bOEEfZWVnmn1wrf26uBw2lFxYCFGFybqxA2f8falvtFhyVkViP+xPMA
 rdvOtte2fv60Q78k+iNvl3xBmcHQ/2GIgebSI62aaDnWn+oEobb3qYLdmiOunc8jZkac1mDOKhW
 sdVFYwIkhRnWPfWsVzL/3GHzByb4IOLa+r+q2VwSmaXGtrQaRFZHahleEEtDb/wopclxSq32KvW
 IWK5vWyqwOl+VnLuEXzf5KkdD7yuV0kVtaFVt0mjVOfr9DC6Bg47i+HTPMumrO0dzOzIxvChzX1
 PMkoAkvMKrrVMnmWn3+F+fhOr4sip68D8gBDX02lxzVdroTIF2N9uUZNFMFacM6ylRo0yVzhp7+
 RJAmvJIsQL/ErbYDStpab7sOdBXsPyURrx1HXW28dTLUSWBUwIVk=
X-Received: by 2002:a05:6402:358f:b0:631:d77a:57b2 with SMTP id
 4fb4d7f45d1cf-63678ba9b62mr3175896a12.3.1759305145323; 
 Wed, 01 Oct 2025 00:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOvevaKNxsm3jUZVq+/7HEGPJPEa3MvDlfhiEY2tG+zHPhDr4MhkVCth/MQdvZKuJYKtQe9g==
X-Received: by 2002:a05:6402:358f:b0:631:d77a:57b2 with SMTP id
 4fb4d7f45d1cf-63678ba9b62mr3175864a12.3.1759305144820; 
 Wed, 01 Oct 2025 00:52:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a367924esm11256914a12.23.2025.10.01.00.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/11] rust: move VMState from bql to migration
Date: Wed,  1 Oct 2025 09:52:05 +0200
Message-ID: <20251001075210.1042479-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

The high-level wrapper Migratable<T> will contain a BqlCell,
which would introduce a circular dependency betwen the bql and
migration crates.  Move the implementation of VMState for cells
to "migration", together with the implementation for std types.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock               | 4 +---
 rust/bql/Cargo.toml           | 3 ---
 rust/bql/meson.build          | 1 -
 rust/bql/src/cell.rs          | 6 ------
 rust/meson.build              | 2 +-
 rust/migration/Cargo.toml     | 1 +
 rust/migration/meson.build    | 4 ++--
 rust/migration/src/vmstate.rs | 2 ++
 8 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 444ef516a70..008d6ca4d62 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -57,9 +57,6 @@ dependencies = [
 [[package]]
 name = "bql"
 version = "0.1.0"
-dependencies = [
- "migration",
-]
 
 [[package]]
 name = "chardev"
@@ -141,6 +138,7 @@ checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
 name = "migration"
 version = "0.1.0"
 dependencies = [
+ "bql",
  "common",
  "util",
 ]
diff --git a/rust/bql/Cargo.toml b/rust/bql/Cargo.toml
index 1041bd4ea93..d87edf4c302 100644
--- a/rust/bql/Cargo.toml
+++ b/rust/bql/Cargo.toml
@@ -12,9 +12,6 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
-[dependencies]
-migration = { path = "../migration" }
-
 [features]
 default = ["debug_cell"]
 debug_cell = []
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index bc51c7f160b..fedb94da9fd 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -37,7 +37,6 @@ _bql_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _bql_cfg,
-  link_with: [_migration_rs],
 )
 
 bql_rs = declare_dependency(link_with: [_bql_rs],
diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 54cfe6145c5..8ade7db629c 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -151,8 +151,6 @@
     ptr::NonNull,
 };
 
-use migration::impl_vmstate_transparent;
-
 /// A mutable memory location that is protected by the Big QEMU Lock.
 ///
 /// # Memory layout
@@ -364,8 +362,6 @@ pub fn take(&self) -> T {
     }
 }
 
-impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
-
 /// A mutable memory location with dynamically checked borrow rules,
 /// protected by the Big QEMU Lock.
 ///
@@ -691,8 +687,6 @@ fn from(t: T) -> BqlRefCell<T> {
     }
 }
 
-impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
-
 struct BorrowRef<'b> {
     borrow: &'b Cell<BorrowFlag>,
 }
diff --git a/rust/meson.build b/rust/meson.build
index 695d5a62de9..7fd857215b0 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -27,8 +27,8 @@ subdir('qemu-macros')
 subdir('common')
 subdir('bits')
 subdir('util')
-subdir('migration')
 subdir('bql')
+subdir('migration')
 subdir('qom')
 subdir('system')
 subdir('chardev')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 708bfaaa682..f4a86275152 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+bql = { path = "../bql" }
 common = { path = "../common" }
 util = { path = "../util" }
 
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index ddf5c2f51d5..e381c76d3e8 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -37,12 +37,12 @@ _migration_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  link_with: [_util_rs],
+  link_with: [_util_rs, _bql_rs],
   dependencies: [common_rs],
 )
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
-  dependencies: [migration, qemuutil])
+  dependencies: [bql_rs, migration, qemuutil])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 2900ef1127a..2a29aff7cd6 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -275,6 +275,8 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
     };
 }
 
+impl_vmstate_transparent!(bql::BqlCell<T> where T: VMState);
+impl_vmstate_transparent!(bql::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-- 
2.51.0


