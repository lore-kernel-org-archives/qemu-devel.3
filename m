Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E685C44503
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMw0-00045O-3d; Wed, 08 Jul 2026 03:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvZ-0003tH-3P; Wed, 08 Jul 2026 03:42:41 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvW-0004UJ-LV; Wed, 08 Jul 2026 03:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496559; x=1815032559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EJsxws4yFvbKYlREJ5MdL8C6I0Dx6ZflapaTgDMsgJs=;
 b=TnVt7Q4ZKGbTzrwbUdsE9g5P62ENqGutACjKLZzHgxvUtUBxo/hGwaev
 DecvsRQNih7QkER4doXYTeQS+rbwEI5pnY13bWCz0bsWp3rikp+x/i66f
 wsx8YTV526GqS0ad39qhwTKeXSzE2JuRjozCzXB2oM3JmDnU2DU113hXp
 AuRdzWT+GCS1y+RZ9ugVyCCF8Z6ihQ+Ckph9oKGDnMIk4L0w9vowYGKkO
 ImHHQ8YvgDL03cWvNsktcgzLezUjcO+8eWvs96hXuuvUtsNmPP/qpy77w
 u9DkbbTEb5IMHcJofHaoZ0/DcUh+a/DUxcAg7xY4Xca+ZrYdt2e8IIvxV Q==;
X-CSE-ConnectionGUID: maKVqEcOQcSWQ3Yj310RvA==
X-CSE-MsgGUID: jO374/lwQX6caFz2pfSrWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343214"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343214"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:37 -0700
X-CSE-ConnectionGUID: 7KXKxiDhS0mTtKJlsvKG1g==
X-CSE-MsgGUID: BnhpTA1kSA24zktb48Nj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555916"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:33 -0700
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
Subject: [RFC v2 03/26] subprojects: Add thiserror-impl crate
Date: Wed,  8 Jul 2026 16:10:29 +0800
Message-Id: <20260708081052.2276617-4-zhao1.liu@intel.com>
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

Use thiserror-impl-1 v1.0.65 for QEMU.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/archive-source.sh                     |  1 +
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 .../thiserror-impl-1-rs/meson.build           | 41 +++++++++++++++++++
 subprojects/thiserror-impl-1-rs.wrap          | 10 +++++
 5 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/packagefiles/thiserror-impl-1-rs/meson.build
 create mode 100644 subprojects/thiserror-impl-1-rs.wrap

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index a37acab524e0..b7f678872036 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -47,6 +47,7 @@ subprojects=(
   proc-macro2-1-rs
   quote-1-rs
   syn-2-rs
+  thiserror-impl-1-rs
   unicode-ident-1-rs
 )
 sub_deinit=""
diff --git a/scripts/make-release b/scripts/make-release
index 5f54b0e7939d..0f33522f39ba 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -44,7 +44,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  syn-2-rs thiserror-impl-1-rs unicode-ident-1-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 011ce4dc3b77..816bc67111c9 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -22,6 +22,7 @@
 /proc-macro*
 /quote-*
 /syn-*
+/thiserror-impl-*
 /unicode-ident-*
 
 # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues/14948
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


