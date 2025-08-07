Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BBDC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRU-0000O4-5U; Thu, 07 Aug 2025 08:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzR5-0007ia-Fw; Thu, 07 Aug 2025 08:09:36 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzR3-00058G-Ac; Thu, 07 Aug 2025 08:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568569; x=1786104569;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/6Sn5bBqav7a/VOe4eY0q12wWkysC4c3gYyVvzV9Usk=;
 b=Qt+efbhmiXKaRCOrrb9VnuvvcnFhD1zKULjJDTVJFsE56o1Q76mXxCN9
 9MCrF40LzrKSK2h8ethDltRG9ATgAFqyVKezp7mHX+YiSYpjarJL5EH9H
 7q9WXskEzEwF2FKnwVdg1n+U5oSX64B+xVUtmAa8y6mn7Iv/t9fmKcqKv
 yZdNQM7/PqLHk2nNwTqBEtF/VGmcBmuQV5o9ypqUJwm6nIWfidlb/uDGv
 CacMftzlqJu6r1UIkNJYH9kIVHnH2nAaOicrbicb1804zREu011dfyaTI
 nIHI6b1AWL3ZUOy/jg1vMRiFG06Ul8gBBphPzm4x2xYxePhFX8N0egwj4 g==;
X-CSE-ConnectionGUID: GVCzBLPCTFiBeieLDvn1JA==
X-CSE-MsgGUID: 8luwCznERJ6zALQQSmTtQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036764"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036764"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:27 -0700
X-CSE-ConnectionGUID: uK0ipsbsSyqLIfgG7GPzKw==
X-CSE-MsgGUID: /RMVBElBQjGkelAahNAIxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701097"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:25 -0700
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
Subject: [RFC 08/26] subprojects: Add vm-memory crate
Date: Thu,  7 Aug 2025 20:30:09 +0800
Message-Id: <20250807123027.2910950-9-zhao1.liu@intel.com>
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
 .../vm-memory-0.16-rs/meson.build             | 35 +++++++++++++++++++
 subprojects/vm-memory-0.16-rs.wrap            | 12 +++++++
 5 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/meson.build
 create mode 100644 subprojects/vm-memory-0.16-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 99d0d898d010..41cf095ca33d 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -32,7 +32,7 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
-  winapi-0.3-rs winapi-i686-pc-windows-gnu-0.4-rs
+  vm-memory-0.16-rs winapi-0.3-rs winapi-i686-pc-windows-gnu-0.4-rs
   winapi-x86_64-pc-windows-gnu-0.4-rs"
 sub_deinit=""
 
diff --git a/scripts/make-release b/scripts/make-release
index c53dfa0a7f4f..115739d31623 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -45,7 +45,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
-  winapi-0.3-rs winapi-i686-pc-windows-gnu-0.4-rs
+  vm-memory-0.16-rs winapi-0.3-rs winapi-i686-pc-windows-gnu-0.4-rs
   winapi-x86_64-pc-windows-gnu-0.4-rs"
 
 src="$1"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index c42adaa928ec..518dd39199ab 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -22,6 +22,7 @@
 /thiserror-1.0.65
 /thiserror-impl-1.0.65
 /unicode-ident-1.0.12
+/vm-memory-0.16
 /winapi-0.3.9
 /winapi-i686-pc-windows-gnu-0.4.0
 /winapi-x86_64-pc-windows-gnu-0.4.0
diff --git a/subprojects/packagefiles/vm-memory-0.16-rs/meson.build b/subprojects/packagefiles/vm-memory-0.16-rs/meson.build
new file mode 100644
index 000000000000..f0d99bad5b7f
--- /dev/null
+++ b/subprojects/packagefiles/vm-memory-0.16-rs/meson.build
@@ -0,0 +1,35 @@
+project(
+  'vm-memory-0.16-rs',
+  'rust',
+  meson_version: '>=1.5.0',
+  #version : '0.2.0',
+  license : 'Apache-2.0 or BSD-3-Clause',
+)
+
+all_deps = []
+
+subproject('thiserror-1-rs', required: true)
+all_deps += dependency('thiserror-1-rs')
+
+if host_machine.system() == 'windows'
+  subproject('winapi-0.3-rs', required: true)
+  all_deps += dependency('winapi-0.3-rs')
+endif
+
+# Note "rawfd" (as the only default feature) is disabled by default in
+# meson. It cause compilation failure on Windows and fortunately, we
+# don't need it either.
+lib = static_library(
+  'vm_memory',
+  'src/lib.rs',
+  override_options : ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi : 'rust',
+  rust_args: ['--cap-lints', 'allow'],
+  dependencies: all_deps,
+)
+
+dep = declare_dependency(
+  link_with : [lib],
+)
+
+meson.override_dependency('vm-memory-0.16-rs', dep)
diff --git a/subprojects/vm-memory-0.16-rs.wrap b/subprojects/vm-memory-0.16-rs.wrap
new file mode 100644
index 000000000000..a057c8c9efc1
--- /dev/null
+++ b/subprojects/vm-memory-0.16-rs.wrap
@@ -0,0 +1,12 @@
+[wrap-git]
+directory = vm-memory-0.16
+# The latest v0.16.2 didn't contain Paolo's commit 5f59e29c3d30
+# ("guest_memory: let multiple regions slice one global bitmap").
+# Once a new release has that change, switch to crates.io.
+url = https://github.com/rust-vmm/vm-memory.git
+revision = 5eb996a060d7ca3844cbd2f10b1d048c0c91942f
+patch_directory = vm-memory-0.16-rs
+depth = 1
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.34.1


