Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26522C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRU-0000O5-5C; Thu, 07 Aug 2025 08:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQr-0007YN-5u; Thu, 07 Aug 2025 08:09:18 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQn-000545-G1; Thu, 07 Aug 2025 08:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568553; x=1786104553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LptemJENmigDfQlxiacW2bd+EUXWgJL0UDSzTxRjZ+w=;
 b=FiPFlcKvy/zF8XfTeP9kPniEzc2QZw/mQ5eDUHJEcSAOWHSKYo+5BDTv
 ocYS0h2d8bHmpMyG/IPIclBYVzVt7l3Jw+lYAATO0KeXrHtep3SfZuYsw
 RTPodHCmZtVgjAz6T/tiXVtupmEvxIxWByv4bpCq8HUtsTRxxHULRg+04
 MWZwZkolmEg0PBWgDlM2LmnzmuwdEIBCwlljzje96U1/xryU+8h+OEPp9
 fLgS+hYoaPol73EChghdv5tuLHhOCPhcFl28IpWSPQtDkqZJf9NlV+ocs
 HInr9RoSc46vJDY/AVLHdPcREWrcLwRFDixOHgEKDXlENfQud8sxJapp7 Q==;
X-CSE-ConnectionGUID: EXwcMm82R3SXGIOPMTvUwA==
X-CSE-MsgGUID: yh2IKBxZRDWasciDbH5Psw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036711"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:10 -0700
X-CSE-ConnectionGUID: ry6T5C7MRO22Kt40Ze4ztw==
X-CSE-MsgGUID: G5kdBu2oTGCzFImRLwK+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701045"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:08 -0700
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
Subject: [RFC 03/26] subprojects: Add thiserror-impl crate
Date: Thu,  7 Aug 2025 20:30:04 +0800
Message-Id: <20250807123027.2910950-4-zhao1.liu@intel.com>
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
 .../thiserror-impl-1-rs/meson.build           | 41 +++++++++++++++++++
 subprojects/thiserror-impl-1-rs.wrap          | 10 +++++
 5 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/packagefiles/thiserror-impl-1-rs/meson.build
 create mode 100644 subprojects/thiserror-impl-1-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 035828c532e7..8d8a0d37ecdc 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -31,7 +31,7 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  syn-2-rs thiserror-impl-1-rs unicode-ident-1-rs"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index 4509a9fabf50..3d3d8d4a51bc 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -44,7 +44,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  syn-2-rs thiserror-impl-1-rs unicode-ident-1-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index f4281934ce11..e6ea570a2286 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -19,4 +19,5 @@
 /proc-macro2-1.0.84
 /quote-1.0.36
 /syn-2.0.66
+/thiserror-impl-1.0.65
 /unicode-ident-1.0.12
diff --git a/subprojects/packagefiles/thiserror-impl-1-rs/meson.build b/subprojects/packagefiles/thiserror-impl-1-rs/meson.build
new file mode 100644
index 000000000000..cc5546264035
--- /dev/null
+++ b/subprojects/packagefiles/thiserror-impl-1-rs/meson.build
@@ -0,0 +1,41 @@
+project('thiserror-impl-1-rs', 'rust',
+ meson_version: '>=1.5.0',
+ version: '1.0.65',
+ license: 'MIT OR Apache-2.0',
+ default_options: [])
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
+_thiserror_impl_rs = rust.proc_macro(
+  'thiserror_impl',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: [
+    '--cfg', 'feature="proc-macro"',
+    '--cfg', 'feature="clone-impls"',
+    '--cfg', 'feature="derive"',
+    '--cfg', 'feature="extra-traits"',
+    '--cfg', 'feature="full"',
+    '--cfg', 'feature="parsing"',
+    '--cfg', 'feature="printing"',
+  ],
+  dependencies: [
+    quote_dep,
+    syn_dep,
+    proc_macro2_dep
+  ],
+)
+
+thiserror_impl_dep = declare_dependency(
+  link_with: _thiserror_impl_rs,
+)
+
+meson.override_dependency('thiserror-impl-1-rs', thiserror_impl_dep)
diff --git a/subprojects/thiserror-impl-1-rs.wrap b/subprojects/thiserror-impl-1-rs.wrap
new file mode 100644
index 000000000000..0f2ca85b8590
--- /dev/null
+++ b/subprojects/thiserror-impl-1-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = thiserror-impl-1.0.65
+source_url = https://crates.io/api/v1/crates/thiserror-impl/1.0.65/download
+source_filename = thiserror-impl-1.0.65.tar.gz
+source_hash = ae71770322cbd277e69d762a16c444af02aa0575ac0d174f0b9562d3b37f8602
+#method = cargo
+patch_directory = thiserror-impl-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.34.1


