Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C7CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEg-0006AG-Dd; Tue, 14 Oct 2025 09:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEW-0005yX-5k
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fES-00018G-N5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3h9CREHD+hrW6wzadkBuc/EvwxUe2yLhbknJ1TxTLXA=;
 b=iplVChRAxuTnV4kuWWxb+0Uh66+1ZggSEVmy5k6tFo9WcIZc/9/zrQtjJMyIXoNq/TyfA+
 TduWb9PcG+xzDf0yDlWzEsVY4aTLPDDzqtMWMivz/1CjmMGWa5nmR9zayxu05GU6B0jf9D
 b5Thkjfkz7yRNbwu2to6IvascihaEew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-BJX1KTtsNB2uDEBMzUI7Hg-1; Tue, 14 Oct 2025 09:38:25 -0400
X-MC-Unique: BJX1KTtsNB2uDEBMzUI7Hg-1
X-Mimecast-MFC-AGG-ID: BJX1KTtsNB2uDEBMzUI7Hg_1760449104
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so30805625e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449102; x=1761053902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3h9CREHD+hrW6wzadkBuc/EvwxUe2yLhbknJ1TxTLXA=;
 b=gMWQlzz2AzyL0B19RWRFglKyuUyT575E5V/HSI/MUEal6LcEi+6FtKd5DvVzmgFoP7
 m3rRvLFkcVdInqXd+c23LC7oGqEz3M1LgaP2/j5e/XseFvyfW2czcvdmwt3V/bXPBQQH
 OpKebPL6KLdm6/6fYDQ+kll6U2X/0IHWPtoQQ32cvZXy5oCTJ1vCwIGOdRhbANPNps/z
 6Afa2bW3ltZUUJlQy0RRksNuX0BqF4ywwYwnv007Hko8/n8V4jkVOQTux5uEW6Ww7S/P
 Ncbnd0r/Bib49czOLCLl/eKZXefQs83EZyWmXh2nNynBlfdWpG+6ZBnJXgIFfqZJUr2g
 iLAw==
X-Gm-Message-State: AOJu0Yyhi//Q2Dc4b0yaDSYxxz/02ESH+8qq6z0l56KguN2FnQW/WD61
 /jrtSaAt0S55nsvOBxQDwmNyrlxnqMvri5e/GKSSSa3sIU1zVPXRX9Zs7QFnpbKysVMM226bwhU
 iYBLojVzAfPCQPrWi+W6EIPtvURXKJy8A5Vok6rs0QoHHOwy4UB0qC6DCayA5TjiKiTtel/BQyt
 e2f3GAuQ8io17/SLCkps/5g62jZkoNQc3uGrZUm/S7
X-Gm-Gg: ASbGnctt8GwLFtXxh0h3m3V2XxEKzSkiUYmKY2PD6HeuKSrrFlUat0pxr0yAYVvXmky
 W51TbPyWsr1eDTYtS9Ej83Yl7MtQVEjZ97foEMD/VEyX5GGRbw6FFfxGSJQkYDXHvhlirI4KTWv
 3tDhUJShFIBwXO9a5BepjymCd0P5OlsOdnv6hvH4TiZc1oT8AzcTO5H+MWmySzTb4nfdVobZIVi
 YrUm/U3R1GlyrH5M5uBk0alDaU2kozN2EYKTHvWU/C/0JE2MIzoGjwnZpiwyf0AF1OMnCd4aN8u
 8tVfJoIKUWMUEMykq1EoMsqW5BcBjDCTzzqELr6XPiotS0874/rL1Y+AjFmvyfFuYEJHnJ9G5kJ
 3AOjZm40YrBbPJt+Pnp/8UQyRNivD70ejTUdZ85YZmTU=
X-Received: by 2002:a05:600c:3e8d:b0:46d:3a07:73cd with SMTP id
 5b1f17b1804b1-46fb409ca81mr127678915e9.23.1760449102381; 
 Tue, 14 Oct 2025 06:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoS9vzCdmARSwdIzPe5BolLkwlUjOwzLaetbBRCGQ4qkcAzfQyfhAo/WzkSDK6omQ2+3hbmg==
X-Received: by 2002:a05:600c:3e8d:b0:46d:3a07:73cd with SMTP id
 5b1f17b1804b1-46fb409ca81mr127678645e9.23.1760449101797; 
 Tue, 14 Oct 2025 06:38:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489197dsm248535045e9.10.2025.10.14.06.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/28] rust: move VMState from bql to migration
Date: Tue, 14 Oct 2025 15:37:09 +0200
Message-ID: <20251014133713.1103695-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The high-level wrapper Migratable<T> will contain a BqlCell,
which would introduce a circular dependency betwen the bql and
migration crates.  Move the implementation of VMState for cells
to "migration", together with the implementation for std types.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock               | 2 +-
 rust/bql/Cargo.toml           | 1 -
 rust/bql/meson.build          | 1 -
 rust/bql/src/cell.rs          | 6 ------
 rust/meson.build              | 2 +-
 rust/migration/Cargo.toml     | 1 +
 rust/migration/meson.build    | 4 ++--
 rust/migration/src/vmstate.rs | 2 ++
 8 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 11085133490..5c2f8ea9240 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -59,7 +59,6 @@ name = "bql"
 version = "0.1.0"
 dependencies = [
  "glib-sys",
- "migration",
 ]
 
 [[package]]
@@ -198,6 +197,7 @@ checksum = "f52b00d39961fc5b2736ea853c9cc86238e165017a493d1d5c8eac6bdc4cc273"
 name = "migration"
 version = "0.1.0"
 dependencies = [
+ "bql",
  "common",
  "glib-sys",
  "util",
diff --git a/rust/bql/Cargo.toml b/rust/bql/Cargo.toml
index d5177e5f8e2..8fd81311028 100644
--- a/rust/bql/Cargo.toml
+++ b/rust/bql/Cargo.toml
@@ -13,7 +13,6 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
-migration = { path = "../migration" }
 glib-sys.workspace = true
 
 [features]
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index 22d7c9b8776..091372dd7b6 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -37,7 +37,6 @@ _bql_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _bql_cfg,
-  link_with: [_migration_rs],
   dependencies: [glib_sys_rs],
 )
 
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
index 6ba075c8c71..76e10699b37 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -29,8 +29,8 @@ subdir('qemu-macros')
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
index 94504f3625c..b995c4c8c88 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+bql = { path = "../bql" }
 common = { path = "../common" }
 util = { path = "../util" }
 glib-sys.workspace = true
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 18be65c92cf..845136239e8 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -37,12 +37,12 @@ _migration_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  link_with: [_util_rs],
+  link_with: [_util_rs, _bql_rs],
   dependencies: [common_rs, glib_sys_rs],
 )
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
-  dependencies: [migration, qemuutil])
+  dependencies: [bql_rs, migration, qemuutil])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 59e665f6c3a..445fe7fbc08 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -276,6 +276,8 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
     };
 }
 
+impl_vmstate_transparent!(bql::BqlCell<T> where T: VMState);
+impl_vmstate_transparent!(bql::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-- 
2.51.0


