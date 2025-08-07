Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFEACA0EC1
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzS0-0002LP-0y; Thu, 07 Aug 2025 08:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQt-0007cF-1G; Thu, 07 Aug 2025 08:09:20 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQp-00056D-J6; Thu, 07 Aug 2025 08:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568555; x=1786104555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mZA5SSrz3FphXmaSjbWuWr8Dg8r0OVF1qFpqD5BZOaI=;
 b=h7HTzKQ0ISSmi7B5QxWgXOGrZW3Qwcceehcujxp4DaA/amXJfL1nOhKo
 3d3ymZLByRhAPksZPq0JTT2OV3y3qKhYJkvNS4ebJKJoY/cr+2WSlnedt
 CaJGOi3rW1XGlLoqKkGqPWQoLLxqZL+UoHxWF2LHXvHYPJ0idwMrOwIE5
 Y3+maWm5yB5ZcwqADeV+R+x/TEnjr4OFT8mn6BmF2VDVLemniw4i1ucTk
 lsArWMMU+sHNEwD3G7orWoUM/ITf4IUd2kw+9mdMlwpa12Ur0lfxN+lyS
 LhYJtd+eABndnzdvkLbdfqkAEJboSRngXKsSx8mtmKux6zM7zENH6kAAn A==;
X-CSE-ConnectionGUID: nEK8HqWqS56+fLHWDeTpTQ==
X-CSE-MsgGUID: KRGaXcxoT9uptnhkZpsemw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036716"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036716"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:14 -0700
X-CSE-ConnectionGUID: O1Bsg54tSM+YFD5GR7VkxQ==
X-CSE-MsgGUID: HrgiLHD/Q/G2lvjrfUWipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701053"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 04/26] subprojects: Add thiserror crate
Date: Thu,  7 Aug 2025 20:30:05 +0800
Message-Id: <20250807123027.2910950-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 .../packagefiles/thiserror-1-rs/meson.build   | 23 +++++++++++++++++++
 subprojects/thiserror-1-rs.wrap               | 10 ++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/packagefiles/thiserror-1-rs/meson.build
 create mode 100644 subprojects/thiserror-1-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 8d8a0d37ecdc..3ae064f65263 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -31,7 +31,7 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs thiserror-impl-1-rs unicode-ident-1-rs"
+  syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index 3d3d8d4a51bc..73a14c12bdeb 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -44,7 +44,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs thiserror-impl-1-rs unicode-ident-1-rs"
+  syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index e6ea570a2286..3b09ab42da08 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -19,5 +19,6 @@
 /proc-macro2-1.0.84
 /quote-1.0.36
 /syn-2.0.66
+/thiserror-1.0.65
 /thiserror-impl-1.0.65
 /unicode-ident-1.0.12
diff --git a/subprojects/packagefiles/thiserror-1-rs/meson.build b/subprojects/packagefiles/thiserror-1-rs/meson.build
new file mode 100644
index 000000000000..bfaf2f8d3eb8
--- /dev/null
+++ b/subprojects/packagefiles/thiserror-1-rs/meson.build
@@ -0,0 +1,23 @@
+project('thiserror-1-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.65',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('thiserror-impl-1-rs', required: true)
+thiserror_impl_rs = dependency('thiserror-impl-1-rs')
+
+_thiserror_rs = static_library(
+  'thiserror',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [thiserror_impl_rs],
+)
+
+thiserror_dep = declare_dependency(
+  link_with: _thiserror_rs,
+)
+
+meson.override_dependency('thiserror-1-rs', thiserror_dep)
diff --git a/subprojects/thiserror-1-rs.wrap b/subprojects/thiserror-1-rs.wrap
new file mode 100644
index 000000000000..0f9303bebf97
--- /dev/null
+++ b/subprojects/thiserror-1-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = thiserror-1.0.65
+source_url = https://crates.io/api/v1/crates/thiserror/1.0.65/download
+source_filename = thiserror-1.0.65.tar.gz
+source_hash = 5d11abd9594d9b38965ef50805c5e469ca9cc6f197f883f717e0269a3057b3d5
+#method = cargo
+patch_directory = thiserror-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.34.1


