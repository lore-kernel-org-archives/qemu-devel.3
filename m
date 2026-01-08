Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A13D185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpn1-0007Ws-Ra; Thu, 08 Jan 2026 08:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpn0-0007Vx-Eg
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:10:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpmy-0007y5-82
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAEznkDRO4+UCmKzsUCKS74cgfmdVqQv4A3+zQl8jFo=;
 b=ArpuZLN0Jisd+mxDvBSUvlCLwYc1fLClzQApwmvd6QCs594EzJYWYbv6id+57LoNFVETHV
 sXCGHZnbT59le/XciSK5D9+l7qPGWK2bWbb1MrqhFhFpDMptg6++sTiLMfIveNZxb9nd7/
 0w14ebDZLz5OuGMmTb8sw5Sns9bol10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-bH1Q87k-PbOe_1q-CP-TlA-1; Thu, 08 Jan 2026 08:10:53 -0500
X-MC-Unique: bH1Q87k-PbOe_1q-CP-TlA-1
X-Mimecast-MFC-AGG-ID: bH1Q87k-PbOe_1q-CP-TlA_1767877853
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso21652115e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877852; x=1768482652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAEznkDRO4+UCmKzsUCKS74cgfmdVqQv4A3+zQl8jFo=;
 b=fTQNpgvX1D/KGpTE/7XfUM/7mL/4dqn1OwL4UlzUlARHHZfKLLIK/BbWIiyDt8eRyx
 yiEzadyCsZGQZ92GpWq3xCr7hNeGRf2LHNt4UV5B7foh+JUykwHqe2YCLRjLErZmPPFN
 evzozyhVR9zllsj3HcFHDij2Q2OLirtcGjR/UExLNNg1SMMprpOkgT+5hg92IDcaVXHk
 pZ13WzawZMG2fMfPb6lb+kovrvX6cqsz15qH6KBaTxgjYshGODx7/YfnRq45j6eQp4fv
 3nTXp0iJ2FoS8snDbaOdJ4U2yA90dswO1DoJNTEXqiQTw57LlrKN2BAo+hsdYNQmNymJ
 s2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877852; x=1768482652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YAEznkDRO4+UCmKzsUCKS74cgfmdVqQv4A3+zQl8jFo=;
 b=huoSXLeDXslefHKoCst5p42UFm2Czgv+qGKgeuZS8dScp86JRyjKgN5qnoCxxuGQk6
 y2Xn6Ewr3Ep2M7UutHKLSoDv5QgEtDhDUyBqPXWSWEVIvWSXFWebEIxIW4SfCCdt3obo
 Rem6sAb5RbMMgAk0napho+R7uUF15eF62Waqf/ei9/t1jMC3pfLSR9IhUwPvUGOXWm9H
 FKfX7OeN0plwSWTFmhj81KHRmgv9XqD4YUflmujZuDjE8rUQ2XAv4b+UABj65wfqC4Jc
 pbz8VkJUi6hek8Nm7CljXUhlBmEr/A8Qs/rADEbBrSfLn1NT3tYM4+HXM2Idc0lsQAEp
 0K/Q==
X-Gm-Message-State: AOJu0YzI/HSg5wuxKxLBJHwk2vIIetWRXO8wQQL0tJTGcqdXLYc9bDkf
 GI6Rs+IRN0+Ro7JuX0pN/esFRZBio10dgsZfTnyLMadI754Cy3wrkMkkwCI2FQgPPAYHRbBoDrj
 9yINu8WdusfR7SsgkS8ZxJJYHr5omL1bH8eZRcSpgia4i0K43xgfG7RtHUJSRfSOXpTk3NMTJFL
 7OD38oE53X8dBp9cDhijDsH2lOi0LmMHGDRdMH+wgZ
X-Gm-Gg: AY/fxX75pO18gqpuen9EllClD/CFtt/oPmQ7okdnFUhNRs5cokQpSupohoaO+6fmc2g
 9wxt+I1Bq+5ZBO9iGOQnDODD3azu97A8hAK1eI9gbHYc7XVvujsW7Zk+l5WeF3Ez5Go+LvLX+YG
 k5+7Gvh9Wj6PBSIvuOcMgBbgVKy7lA3rihS6E9H962Y4Pw3PvXtRRdv59YK2OxAZEisWAZElyB8
 WPwv+x6DekNzic+OLa4DU1cqKPA3MGxPkYpDU/2UBqDGN6+6Lb+YYBkKXks1sQZziJit3QiUwRw
 GEz6O9V7+qFRwLQONS90bB2JDS/8Q3f1L4YOsOann25ESsuEvWxDZs/Xf1WKOTtMDtGISOkNA1w
 thf9Fu5r2IxKWTosBezYObDUSv5rtwx0a2TpF7zOpMqKLMIRpuLt5otevOTuass7WpfAl4S4tq/
 1yIxDxCZ7G24AwlQ==
X-Received: by 2002:a05:600c:4ed4:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47d84b40ae5mr76149255e9.26.1767877851635; 
 Thu, 08 Jan 2026 05:10:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYOicKeSLeYefTCpWT9Z2NpiRDd1XevMjr6Fzfg1sOcJ/hvgudOOyThEjDc9TERUfGj6LuGw==
X-Received: by 2002:a05:600c:4ed4:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47d84b40ae5mr76148835e9.26.1767877851090; 
 Thu, 08 Jan 2026 05:10:51 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c78sm160551165e9.11.2026.01.08.05.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:10:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 02/16] subprojects: add serde
Date: Thu,  8 Jan 2026 14:10:29 +0100
Message-ID: <20260108131043.490084-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml                               |  2 ++
 rust/meson.build                              |  4 +++
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
 14 files changed, 184 insertions(+), 1 deletion(-)
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
index ace0baf9bd7..45ebfa693a4 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -20,6 +20,8 @@ anyhow = "~1.0"
 foreign = "~0.3.1"
 libc = "0.2.162"
 glib-sys = { version = "0.21.2", features = ["v2_66"] }
+serde = "1.0.226"
+serde_derive = "1.0.226"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
diff --git a/rust/meson.build b/rust/meson.build
index bacb7879102..bd995e2b955 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -11,6 +11,8 @@ subproject('foreign-0.3-rs', required: true)
 subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 subproject('probe-0.5-rs', required: true)
+subproject('serde-1-rs', required: true)
+subproject('serde_derive-1-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
@@ -19,6 +21,8 @@ foreign_rs = dependency('foreign-0.3-rs')
 glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
 probe_rs = dependency('probe-0.5-rs')
+serde_rs = dependency('serde-1-rs')
+serde_derive_rs = dependency('serde_derive-1-rs', native: true)
 
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index a37acab524e..ae768cf99f6 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -46,6 +46,9 @@ subprojects=(
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
index 5f54b0e7939..23fef08bcf3 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -44,7 +44,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  serde-1-rs serde_core-1-rs serde_derive-1-rs syn-2-rs unicode-ident-1-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 011ce4dc3b7..2cdb0a6a910 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -21,6 +21,9 @@
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
index 00000000000..775e0120f24
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
+meson.override_dependency('serde-1-rs', serde_dep)
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
index 00000000000..79c36f6b70e
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
+meson.override_dependency('serde_core-1-rs', serde_core_dep)
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
2.52.0


