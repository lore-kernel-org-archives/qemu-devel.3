Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB5C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRr-0001UP-S2; Thu, 07 Aug 2025 08:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzR1-0007g0-KG; Thu, 07 Aug 2025 08:09:33 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQz-000545-7L; Thu, 07 Aug 2025 08:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568565; x=1786104565;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIyWt4frlWBRZfRYC5czZ1MuxO6aMa3aYBG309ggo+g=;
 b=AKT0nR7/6KF+lZnCFSEYmDi8KsyfYgSzk6NaChS70ROQBPsh4S/WRfaC
 +tZsxMIHuorf7wJx7/M1CJvzPXsGN8ZYQXAYG4JCgEdMTI3odI9Cd12by
 5ZVXo7R0NSpFUBkA48Uh9THpe+bo6JRt5HzadpQfMfchKQcyMct1VpNY8
 sWWM7+WPfCyn9vqaOb59aUU35RSSsgV+J3hrbqPlnpZCAi6AqFXSS8Uxj
 LUPy7ZC5j9ikKuBS0P371+TrBG1avS/rhD/Esy9UU4V0fcQMN69TQmas+
 AasZROKOX0rUS458RkpW/rKmwKXS+tWULLsgGHaxiJm3WvA4ar3dPg/JL A==;
X-CSE-ConnectionGUID: pbSJd+QqQ5unHkP1IUFxfw==
X-CSE-MsgGUID: KgXoTuIYRiWU/UbualkHNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036750"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036750"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:24 -0700
X-CSE-ConnectionGUID: 0O4Z1IR6SNC7izHb9utTTA==
X-CSE-MsgGUID: sGZdusAiQvOhxX02QszuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701086"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:21 -0700
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
Subject: [RFC 07/26] subprojects: Add winapi crate
Date: Thu,  7 Aug 2025 20:30:08 +0800
Message-Id: <20250807123027.2910950-8-zhao1.liu@intel.com>
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
 scripts/archive-source.sh                     |  3 +-
 scripts/make-release                          |  3 +-
 subprojects/.gitignore                        |  1 +
 .../packagefiles/winapi-0.3-rs/meson.build    | 46 +++++++++++++++++++
 subprojects/winapi-0.3-rs.wrap                | 10 ++++
 5 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/packagefiles/winapi-0.3-rs/meson.build
 create mode 100644 subprojects/winapi-0.3-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 4caf6078f1ac..99d0d898d010 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -32,7 +32,8 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
-  winapi-i686-pc-windows-gnu-0.4-rs winapi-x86_64-pc-windows-gnu-0.4-rs"
+  winapi-0.3-rs winapi-i686-pc-windows-gnu-0.4-rs
+  winapi-x86_64-pc-windows-gnu-0.4-rs"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index eb8b2446ad3a..c53dfa0a7f4f 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -45,7 +45,8 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs thiserror-1-rs thiserror-impl-1-rs unicode-ident-1-rs
-  winapi-i686-pc-windows-gnu-0.4-rs winapi-x86_64-pc-windows-gnu-0.4-rs"
+  winapi-0.3-rs winapi-i686-pc-windows-gnu-0.4-rs
+  winapi-x86_64-pc-windows-gnu-0.4-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index ed51f2012e2c..c42adaa928ec 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -22,5 +22,6 @@
 /thiserror-1.0.65
 /thiserror-impl-1.0.65
 /unicode-ident-1.0.12
+/winapi-0.3.9
 /winapi-i686-pc-windows-gnu-0.4.0
 /winapi-x86_64-pc-windows-gnu-0.4.0
diff --git a/subprojects/packagefiles/winapi-0.3-rs/meson.build b/subprojects/packagefiles/winapi-0.3-rs/meson.build
new file mode 100644
index 000000000000..e2cee17ec2d5
--- /dev/null
+++ b/subprojects/packagefiles/winapi-0.3-rs/meson.build
@@ -0,0 +1,46 @@
+project('winapi-0.3-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.3.9',
+  license: 'MIT OR Apache-2.0'
+)
+
+if host_machine.cpu_family() == 'x86_64'
+  winapi_arch = 'winapi-x86_64-pc-windows-gnu-0.4-rs'
+elif host_machine.cpu_family() == 'x86'
+  winapi_arch = 'winapi-i686-pc-windows-gnu-0.4-rs'
+else
+  error('Unsupported CPU family for winapi: ' + host_machine.cpu_family())
+endif
+
+subproject(winapi_arch, required: true)
+winapi_arch_dep = dependency(winapi_arch)
+
+winapi_features = [
+  '--cfg', 'feature="errhandlingapi"',
+  '--cfg', 'feature="sysinfoapi"',
+  '--cfg', 'feature="excpt"',
+  '--cfg', 'feature="minwinbase"',
+  '--cfg', 'feature="ntstatus"',
+  '--cfg', 'feature="winnt"',
+  '--cfg', 'feature="basetsd"',
+  '--cfg', 'feature="ktmtypes"',
+  '--cfg', 'feature="minwindef"',
+  '--cfg', 'feature="ntdef"',
+  '--cfg', 'feature="guiddef"',
+  '--cfg', 'feature="vcruntime"'
+]
+
+lib = static_library(
+  'winapi',
+  'src/lib.rs',
+  override_options : ['rust_std=2021'],
+  rust_abi : 'rust',
+  rust_args: ['--cap-lints', 'allow'] + winapi_features,
+  dependencies: [winapi_arch_dep]
+)
+
+dep = declare_dependency(
+  link_with: lib,
+)
+
+meson.override_dependency('winapi-0.3-rs', dep)
diff --git a/subprojects/winapi-0.3-rs.wrap b/subprojects/winapi-0.3-rs.wrap
new file mode 100644
index 000000000000..49a5954ec225
--- /dev/null
+++ b/subprojects/winapi-0.3-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = winapi-0.3.9
+source_url = https://crates.io/api/v1/crates/winapi/0.3.9/download
+source_filename = winapi-0.3.9.tar.gz
+source_hash = 5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419
+#method = cargo
+patch_directory = winapi-0.3-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.34.1


