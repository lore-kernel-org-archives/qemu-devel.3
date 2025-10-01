Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F53CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmQ-0005jG-Ix; Wed, 01 Oct 2025 04:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmH-0005hA-6m
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rlw-00061I-Rg
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siQmyM+WRkJFh0csNHWp9mRD1uFWOtvlTB1cv598DCM=;
 b=WOUcBJDA4HM8SRvjIcs4jtW7PNGgomot8KnroSbbleiBiKuyZAh9lsDc9uxVkzxoAKTRx0
 c61p4zMOxdSJ+GWamNcYwbaE51DqJD6KI+y/tp1GF7IoMPAXzbu8Q8UQ7nkKNuj9fWNfVi
 12F9pKfoVCxVlfmAHT1Dh2/i/+A2RGs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-TlJACe5nNwmc-qysxFHOKA-1; Wed, 01 Oct 2025 04:01:02 -0400
X-MC-Unique: TlJACe5nNwmc-qysxFHOKA-1
X-Mimecast-MFC-AGG-ID: TlJACe5nNwmc-qysxFHOKA_1759305661
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-63049fca047so9047348a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305660; x=1759910460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siQmyM+WRkJFh0csNHWp9mRD1uFWOtvlTB1cv598DCM=;
 b=DDC1g/Wxjk5t1xWS6qQaK8FeDH2yuwJmuEP8pmdQRZiWCYCJR/TTb2Js1QHg4ZfKG6
 PNA2Dq9pxtqCPRgYt0j6Bor9YKaHcFBGfiEAspEXRV8vC2KGaV5xLZGYZ2R2ZOfQggUT
 e0nXfKssJ7o4Ha4PBgNy2zltfI3vElZLQzdHkyZ34h8PzXNrpJIXyOLOkYeVDTLE3ajl
 mAhfuVknTc6noK6dyRbRD6L7lZMtBTb0+qMN1652jx2V9anflusRdpfhpsnaNILN+s/Z
 jdQyC0QAGfr7siWHjlJhmEcyRZER6+0pqmgHMS2IHOE+Doezena6TpyRAtmRm+m861xv
 SVYg==
X-Gm-Message-State: AOJu0YzHxT+YS33TNMi4OqvQa8L8CYQdbDs+S+NYu+vxLrd+dYq6MZtu
 CmwtBsqOzZ+OkyYmZfcfSI89+GtClHV+6BujgqEF3xveYrSBIkLWbRoc/owwSXg2H55m9N27wK6
 8NeK7PMCHyxPPVbgoo17akRLkT2Q7MCfm8XBdloQFKZXux8LGgnpnmQwzKStXq7C3CZ8qD2iy8r
 RLVa9/lxeB8CbolJRGcWhJavNQsbzMFpwGJvyXHg7A
X-Gm-Gg: ASbGncsSVVypurIj+G2oR/TX+qPMrxJ7AIuqrdTZGfV0DA7vXl+Onfx5c01wsQlYVwo
 BvzW61esPUpnc+zxrm9YLQW9By+SEBTJ5ZfkHubl19kWO+dw/daVM9px/g2iKUr9+HYWDaaotZg
 cnu+UPb4kqIo3/MxgaaQBH6eiDg21sRw5WT/gnyWkK/FwSyT285MIbpsaY41ixC/+HcfHlYLdOt
 rY7BBmr0M4/7nXBHQUTnYbsDn3/mJV2QI6elYg/NRZ0C0t5eXIxqYyotpA3q7Jlog12T4x8ZXc0
 wGgt/Nsc7JGH2gv/FQspHxt9N732LDWO4eHz2ejQVT+dLNqNiA+azgaqXQW6m2hr5H8ttWwWdaK
 xVLVAL5OGzrC9sBMAMNtzggLaYOf+YwAodmT/FTI93U0yCRzsXAU=
X-Received: by 2002:a05:6402:2812:b0:634:a8fb:b91d with SMTP id
 4fb4d7f45d1cf-63678a9a5damr3089593a12.0.1759305659376; 
 Wed, 01 Oct 2025 01:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEUAp3qPfbIVXRNP2hxJ9E9d1om2PBgiK/gUZP5wZU8/9Z5Cm4rx5hEEi+UhStgzIDdBxWPQ==
X-Received: by 2002:a05:6402:2812:b0:634:a8fb:b91d with SMTP id
 4fb4d7f45d1cf-63678a9a5damr3089545a12.0.1759305658737; 
 Wed, 01 Oct 2025 01:00:58 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3339b63sm11082944a12.0.2025.10.01.01.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:00:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 03/14] subprojects: add serde
Date: Wed,  1 Oct 2025 10:00:40 +0200
Message-ID: <20251001080051.1043944-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml                               |  2 ++
 rust/meson.build                              |  2 ++
 scripts/archive-source.sh                     |  3 ++
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  3 ++
 .../packagefiles/serde-1-rs/meson.build       | 36 +++++++++++++++++++
 .../packagefiles/serde-1.0.226-include.patch  | 16 +++++++++
 .../packagefiles/serde_core-1-rs/meson.build  | 25 +++++++++++++
 .../serde_core-1.0.226-include.patch          | 15 ++++++++
 .../serde_derive-1-rs/meson.build             | 35 ++++++++++++++++++
 .../serde_derive-1.0.226-include.patch        | 11 ++++++
 subprojects/serde-1-rs.wrap                   | 11 ++++++
 subprojects/serde_core-1-rs.wrap              | 11 ++++++
 subprojects/serde_derive-1-rs.wrap            | 11 ++++++
 14 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde-1.0.226-include.patch
 create mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde_core-1.0.226-include.patch
 create mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde_derive-1.0.226-include.patch
 create mode 100644 subprojects/serde-1-rs.wrap
 create mode 100644 subprojects/serde_core-1-rs.wrap
 create mode 100644 subprojects/serde_derive-1-rs.wrap

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 783e626802c..a512fb142e2 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -30,6 +30,8 @@ anyhow = "~1.0"
 foreign = "~0.3.1"
 libc = "0.2.162"
 glib-sys = { version = "0.21.2", features = ["v2_66"] }
+serde = "1.0.226"
+serde_derive = "1.0.226"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
diff --git a/rust/meson.build b/rust/meson.build
index 76e10699b37..fd2ca40ef90 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -4,6 +4,7 @@ subproject('bilge-impl-0.2-rs', required: true)
 subproject('foreign-0.3-rs', required: true)
 subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
+subproject('serde-1-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
@@ -11,6 +12,7 @@ bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 foreign_rs = dependency('foreign-0.3-rs')
 glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
+serde_rs = dependency('serde-1-rs')
 
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 8f97b19a088..3ed0429d806 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -45,6 +45,9 @@ subprojects=(
   proc-macro-error-attr-1-rs
   proc-macro2-1-rs
   quote-1-rs
+  serde-1-rs
+  serde_core-1-rs
+  serde_derive-1-rs
   syn-2-rs
   unicode-ident-1-rs
 )
diff --git a/scripts/make-release b/scripts/make-release
index bc1b43caa25..eb5808b83ec 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -44,7 +44,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  serde-1-rs serde_core-1-rs serde_derive-1-rs syn-2-rs unicode-ident-1-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index c00c8478372..697d1ef3bdb 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -20,6 +20,9 @@
 /proc-macro-error-attr-*
 /proc-macro*
 /quote-*
+/serde-*
+/serde_core-*
+/serde_derive-*
 /syn-*
 /unicode-ident-*
 
diff --git a/subprojects/packagefiles/serde-1-rs/meson.build b/subprojects/packagefiles/serde-1-rs/meson.build
new file mode 100644
index 00000000000..6cb2b59a147
--- /dev/null
+++ b/subprojects/packagefiles/serde-1-rs/meson.build
@@ -0,0 +1,36 @@
+project('serde-1-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.226',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('serde_core-1-rs', required: true)
+subproject('serde_derive-1-rs', required: true)
+
+serde_core_dep = dependency('serde_core-1-rs')
+serde_derive_dep = dependency('serde_derive-1-rs')
+
+_serde_rs = static_library(
+  'serde',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'feature="alloc"',
+    '--cfg', 'feature="std"',
+    '--cfg', 'feature="derive"',
+  ],
+  dependencies: [
+    serde_core_dep,
+    serde_derive_dep,
+  ]
+)
+
+serde_dep = declare_dependency(
+  link_with: _serde_rs,
+  dependencies: serde_derive_dep,
+)
+
+meson.override_dependency('serde-1-rs', serde_dep, native: true)
diff --git a/subprojects/packagefiles/serde-1.0.226-include.patch b/subprojects/packagefiles/serde-1.0.226-include.patch
new file mode 100644
index 00000000000..92878136878
--- /dev/null
+++ b/subprojects/packagefiles/serde-1.0.226-include.patch
@@ -0,0 +1,16 @@
+--- a/src/lib.rs	2025-09-23 13:41:09.327582205 +0200
++++ b/src/lib.rs	2025-09-23 13:41:23.043271856 +0200
+@@ -241,7 +241,12 @@
+ #[doc(hidden)]
+ mod private;
+ 
+-include!(concat!(env!("OUT_DIR"), "/private.rs"));
++#[doc(hidden)]
++pub mod __private_MESON {
++    #[doc(hidden)]
++    pub use crate::private::*;
++}
++use serde_core::__private_MESON as serde_core_private;
+ 
+ // Re-export #[derive(Serialize, Deserialize)].
+ //
diff --git a/subprojects/packagefiles/serde_core-1-rs/meson.build b/subprojects/packagefiles/serde_core-1-rs/meson.build
new file mode 100644
index 00000000000..e917d9337f6
--- /dev/null
+++ b/subprojects/packagefiles/serde_core-1-rs/meson.build
@@ -0,0 +1,25 @@
+project('serde_core-1-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.226',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+_serde_core_rs = static_library(
+  'serde_core',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'feature="alloc"',
+    '--cfg', 'feature="result"',
+    '--cfg', 'feature="std"',
+  ],
+)
+
+serde_core_dep = declare_dependency(
+  link_with: _serde_core_rs,
+)
+
+meson.override_dependency('serde_core-1-rs', serde_core_dep, native: true)
diff --git a/subprojects/packagefiles/serde_core-1.0.226-include.patch b/subprojects/packagefiles/serde_core-1.0.226-include.patch
new file mode 100644
index 00000000000..d1321dfe272
--- /dev/null
+++ b/subprojects/packagefiles/serde_core-1.0.226-include.patch
@@ -0,0 +1,15 @@
+--- a/src/lib.rs	2025-09-23 13:32:40.872421170 +0200
++++ b/src/lib.rs	2025-09-23 13:32:52.181098856 +0200
+@@ -263,7 +263,11 @@
+     pub use core::result::Result;
+ }
+ 
+-include!(concat!(env!("OUT_DIR"), "/private.rs"));
++#[doc(hidden)]
++pub mod __private_MESON {
++    #[doc(hidden)]
++    pub use crate::private::*;
++}
+ 
+ #[cfg(all(not(feature = "std"), no_core_error))]
+ mod std_error;
diff --git a/subprojects/packagefiles/serde_derive-1-rs/meson.build b/subprojects/packagefiles/serde_derive-1-rs/meson.build
new file mode 100644
index 00000000000..6c1001a844a
--- /dev/null
+++ b/subprojects/packagefiles/serde_derive-1-rs/meson.build
@@ -0,0 +1,35 @@
+project('serde_derive-1-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.226',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('quote-1-rs', required: true)
+subproject('syn-2-rs', required: true)
+subproject('proc-macro2-1-rs', required: true)
+
+quote_dep = dependency('quote-1-rs', native: true)
+syn_dep = dependency('syn-2-rs', native: true)
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+
+rust = import('rust')
+
+_serde_derive_rs = rust.proc_macro(
+  'serde_derive',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: [
+    '--cap-lints', 'allow',
+  ],
+  dependencies: [
+    quote_dep,
+    syn_dep,
+    proc_macro2_dep,
+  ],
+)
+
+serde_derive_dep = declare_dependency(
+  link_with: _serde_derive_rs,
+)
+
+meson.override_dependency('serde_derive-1-rs', serde_derive_dep)
diff --git a/subprojects/packagefiles/serde_derive-1.0.226-include.patch b/subprojects/packagefiles/serde_derive-1.0.226-include.patch
new file mode 100644
index 00000000000..81d65564d29
--- /dev/null
+++ b/subprojects/packagefiles/serde_derive-1.0.226-include.patch
@@ -0,0 +1,11 @@
+--- a/src/lib.rs	2025-09-23 13:51:51.540191923 +0200
++++ b/src/lib.rs	2025-09-23 13:52:07.690060195 +0200
+@@ -98,7 +98,7 @@
+ impl private {
+     fn ident(&self) -> Ident {
+         Ident::new(
+-            concat!("__private", env!("CARGO_PKG_VERSION_PATCH")),
++            "__private_MESON",
+             Span::call_site(),
+         )
+     }
diff --git a/subprojects/serde-1-rs.wrap b/subprojects/serde-1-rs.wrap
new file mode 100644
index 00000000000..56746dd0f43
--- /dev/null
+++ b/subprojects/serde-1-rs.wrap
@@ -0,0 +1,11 @@
+[wrap-file]
+directory = serde-1.0.226
+source_url = https://crates.io/api/v1/crates/serde/1.0.226/download
+source_filename = serde-1.0.226.0.tar.gz
+source_hash = 0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd
+#method = cargo
+diff_files = serde-1.0.226-include.patch
+patch_directory = serde-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v1
diff --git a/subprojects/serde_core-1-rs.wrap b/subprojects/serde_core-1-rs.wrap
new file mode 100644
index 00000000000..3692e754935
--- /dev/null
+++ b/subprojects/serde_core-1-rs.wrap
@@ -0,0 +1,11 @@
+[wrap-file]
+directory = serde_core-1.0.226
+source_url = https://crates.io/api/v1/crates/serde_core/1.0.226/download
+source_filename = serde_core-1.0.226.0.tar.gz
+source_hash = ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4
+#method = cargo
+diff_files = serde_core-1.0.226-include.patch
+patch_directory = serde_core-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v1
diff --git a/subprojects/serde_derive-1-rs.wrap b/subprojects/serde_derive-1-rs.wrap
new file mode 100644
index 00000000000..00c92dc79cf
--- /dev/null
+++ b/subprojects/serde_derive-1-rs.wrap
@@ -0,0 +1,11 @@
+[wrap-file]
+directory = serde_derive-1.0.226
+source_url = https://crates.io/api/v1/crates/serde_derive/1.0.226/download
+source_filename = serde_derive-1.0.226.0.tar.gz
+source_hash = 8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33
+#method = cargo
+diff_files = serde_derive-1.0.226-include.patch
+patch_directory = serde_derive-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v1
-- 
2.51.0


