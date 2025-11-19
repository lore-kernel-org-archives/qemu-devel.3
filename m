Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BEDCF58C9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmlK-0006qc-9H; Wed, 19 Nov 2025 13:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLmlH-0006pX-6s
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLmlE-0004bT-M0
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763576312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcOebe0Iu/lIHqeur69z3jxy/Az6bB+SgVoQoceCf5o=;
 b=K2yTtupO74w+be1Gxa/nekHy6vKQ/3x3uhlNocUcDY3l4WPGkbtPPz5EuRI8H46VFEigV5
 kvD+0gn4GNilLeBr/v3saXz9sLbUu8+CPKsSO/NSBWCKgMxQ4SzD0scO/FqiL4OKVMWNMT
 ePXuyVmySNhELwNkbAOYCaJoxtw7+sc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-sAFayJjzNBW_2tupfD9WEw-1; Wed,
 19 Nov 2025 13:18:27 -0500
X-MC-Unique: sAFayJjzNBW_2tupfD9WEw-1
X-Mimecast-MFC-AGG-ID: sAFayJjzNBW_2tupfD9WEw_1763576306
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1050219560A2; Wed, 19 Nov 2025 18:18:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.175])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA0F5180049F; Wed, 19 Nov 2025 18:18:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-rust@nongnu.org, Josh Stone <jistone@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] subprojects: add probe crate
Date: Wed, 19 Nov 2025 13:18:20 -0500
Message-ID: <20251119181821.154833-2-stefanha@redhat.com>
In-Reply-To: <20251119181821.154833-1-stefanha@redhat.com>
References: <20251119181821.154833-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The probe crate (https://crates.io/crates/probe) provides a probe!()
macro that defines SystemTap SDT probes on Linux hosts or does nothing
on other host OSes.

This crate will be used to implement DTrace support for Rust.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 rust/meson.build                              |  2 ++
 scripts/archive-source.sh                     |  1 +
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 .../packagefiles/probe-0.5-rs/meson.build     | 22 +++++++++++++++++++
 subprojects/probe-0.5-rs.wrap                 |  7 ++++++
 6 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 create mode 100644 subprojects/probe-0.5-rs.wrap

diff --git a/rust/meson.build b/rust/meson.build
index 76e10699b3..afbeeeb47a 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -4,6 +4,7 @@ subproject('bilge-impl-0.2-rs', required: true)
 subproject('foreign-0.3-rs', required: true)
 subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
+subproject('probe-0.5-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
@@ -11,6 +12,7 @@ bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 foreign_rs = dependency('foreign-0.3-rs')
 glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
+probe_rs = dependency('probe-0.5-rs')
 
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 8f97b19a08..a37acab524 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -41,6 +41,7 @@ subprojects=(
   keycodemapdb
   libc-0.2-rs
   libvfio-user
+  probe-0.5-rs
   proc-macro-error-1-rs
   proc-macro-error-attr-1-rs
   proc-macro2-1-rs
diff --git a/scripts/make-release b/scripts/make-release
index bc1b43caa2..5f54b0e793 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -42,7 +42,7 @@ fi
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
-  libc-0.2-rs proc-macro2-1-rs
+  libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index c00c847837..011ce4dc3b 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -16,6 +16,7 @@
 /glib-sys-*
 /itertools-*
 /libc-*
+/probe-*
 /proc-macro-error-*
 /proc-macro-error-attr-*
 /proc-macro*
diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subprojects/packagefiles/probe-0.5-rs/meson.build
new file mode 100644
index 0000000000..e6ea69533b
--- /dev/null
+++ b/subprojects/packagefiles/probe-0.5-rs/meson.build
@@ -0,0 +1,22 @@
+project('probe-0.5-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.5.2',
+  license: 'Apache-2.0 OR MIT',
+  default_options: [])
+
+_probe_rs = static_library(
+  'probe',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+  ],
+)
+
+probe_deps = declare_dependency(
+  link_with: _probe_rs,
+)
+
+meson.override_dependency('probe-0.5-rs', probe_deps)
diff --git a/subprojects/probe-0.5-rs.wrap b/subprojects/probe-0.5-rs.wrap
new file mode 100644
index 0000000000..73229ee1c2
--- /dev/null
+++ b/subprojects/probe-0.5-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = probe-0.5.2
+source_url = https://crates.io/api/v1/crates/probe/0.5.2/download
+source_filename = probe-0.5.2.tar.gz
+source_hash = 136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e
+#method = cargo
+patch_directory = probe-0.5-rs
-- 
2.51.1


