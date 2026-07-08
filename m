Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4A1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwE-0004Xz-AU; Wed, 08 Jul 2026 03:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvj-0003xF-Tr; Wed, 08 Jul 2026 03:42:55 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvg-0004UJ-Nx; Wed, 08 Jul 2026 03:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496569; x=1815032569;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KUfCRaamEYV5a3lI5DD5JS0zaQQGj0vcpTApyu88ye0=;
 b=TOvojrTEpcnncWo3Z/E1DIxpJWXb+yEUlaSlx49C6ap0IJT2a6Ep+ybW
 UYD9mgfOKcXCcwakOrgMlLaQ9Zdaegn8USgaxOqlRJvbOpCE62QH1VpFU
 RTn/TUqNrl6QSply9HJvC5NkDTLIGS9ruWiYlM/c78VWhIv4bIZIwfuhN
 v7ZE5a0dGBhaZjip5U+SU1PKeC840pj37VSr5gUbPqKakyPl16E05kiou
 Kgx+2uIvuIyIxHW9t1mgeFi13J9ZW9uiu/WklPYc6OfOWfPHjZeYkspqz
 75E3uvMdeCURJcQu5JpHN6jTP4FBYxJ7BIhTu0uZ1bz3veOgXMde/1zpY g==;
X-CSE-ConnectionGUID: h3TuAV9HT923HB6+JqbLLA==
X-CSE-MsgGUID: n0h2PwlVSliIWje7fdk2bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343233"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:46 -0700
X-CSE-ConnectionGUID: cmd3wgbWS4aOyV0JUExX+w==
X-CSE-MsgGUID: 1/9q94cKR6m3G5qGwmAkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555927"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:41 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 05/26] subprojects: Add vm-memory crate
Date: Wed,  8 Jul 2026 16:10:31 +0800
Message-Id: <20260708081052.2276617-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Use vm-memory v0.18.0 for QEMU.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Upgrade vm-memory to v0.18.0 then we don't need extra patch for
   vm-memory subproject in QEMU.
---
 scripts/archive-source.sh                     |  1 +
 scripts/make-release                          |  3 ++-
 subprojects/.gitignore                        |  1 +
 .../vm-memory-0.18-rs/meson.build             | 27 +++++++++++++++++++
 subprojects/vm-memory-0.18-rs.wrap            | 10 +++++++
 5 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/packagefiles/vm-memory-0.18-rs/meson.build
 create mode 100644 subprojects/vm-memory-0.18-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 2f3987fc0fea..a876ec2d3480 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -49,6 +49,7 @@ subprojects=(
   syn-2-rs
   thiserror-1-rs
   thiserror-impl-1-rs
+  vm-memory-0.18-rs
   unicode-ident-1-rs
 )
 sub_deinit=""
diff --git a/scripts/make-release b/scripts/make-release
index a5488e226298..c0077aab3643 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -44,7 +44,8 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs"
+  syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
+  vm-memory-0.18-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index d7cf421bff07..29d8e26960d5 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -25,6 +25,7 @@
 /thiserror-*
 /thiserror-impl-*
 /unicode-ident-*
+/vm-memory-*
 
 # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues/14948
 /.wraplock
diff --git a/subprojects/packagefiles/vm-memory-0.18-rs/meson.build b/subprojects/packagefiles/vm-memory-0.18-rs/meson.build
new file mode 100644
index 000000000000..2e5d9c50f839
--- /dev/null
+++ b/subprojects/packagefiles/vm-memory-0.18-rs/meson.build
@@ -0,0 +1,27 @@
+project('vm-memory-0.18-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version : '0.18.0',
+  license : 'Apache-2.0 or BSD-3-Clause',
+  default_options: [])
+
+all_deps = []
+
+subproject('thiserror-1-rs', required: true)
+all_deps += dependency('thiserror-1-rs')
+
+_vm_memory_rs = static_library(
+  'vm_memory',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options : ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi : 'rust',
+  rust_args: ['--cap-lints', 'allow'],
+  dependencies: all_deps,
+  native: true,
+)
+
+dep = declare_dependency(
+  link_with : _vm_memory_rs,
+)
+
+meson.override_dependency('vm-memory-0.18-rs', dep, native: true)
diff --git a/subprojects/vm-memory-0.18-rs.wrap b/subprojects/vm-memory-0.18-rs.wrap
new file mode 100644
index 000000000000..299b54d8f799
--- /dev/null
+++ b/subprojects/vm-memory-0.18-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = vm-memory-0.18.0
+source_url = https://crates.io/api/v1/crates/vm-memory/0.18.0/download
+source_filename = vm-memory-0.18.0.tar.gz
+source_hash = 9b55e753c7725603745cb32b2287ef7ef3da05c03c7702cda3fa8abe25ae0465
+#method = cargo
+patch_directory = vm-memory-0.18-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.34.1


