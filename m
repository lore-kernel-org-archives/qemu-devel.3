Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE15AC87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRD-0007t1-1M; Thu, 07 Aug 2025 08:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQn-0007Rn-3b; Thu, 07 Aug 2025 08:09:15 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQk-00054a-Bd; Thu, 07 Aug 2025 08:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568550; x=1786104550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I+BnrSmaOgS4QOTYt1Xg56BqMt16d9NeDnkZ1ZXGGos=;
 b=JTdWse8H1M48Nnjk1vXHS+9JmyxIEAn/oZO6xnuqgw3gqVAqafv2mFJ2
 HorT7mQ5ZzzOtAn5IEb/9KqILAJo16PONO+4oo8WWrcr2mbGMaJ7Mf3Ws
 pahy/0mZ87uZ9zAInrfrXzOB9Qsf7xdWwkLCSnAR0wmeSWfIJmJZEWgZo
 GrihLz9KGd6Xw5J/nwar//AVUhoAHglq3hfGiguYxaekZxHMDoFVYdtHz
 a52KfxDOXnadsAY115OD/XVx23xeBRXX/IWeVjAbeQDupLIxAx/LG68/8
 TBLbSpYMWkHbszIOrP8AMTnzOdC06nYCZdcucHLeIhHoRZWlVRolFdsTd g==;
X-CSE-ConnectionGUID: my+/uoYAT/S+DA+k04NqAQ==
X-CSE-MsgGUID: /92FSpEwTWy7xD9+YBNiOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036705"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:07 -0700
X-CSE-ConnectionGUID: PcNirZzsQiSQjyHfgaY9pQ==
X-CSE-MsgGUID: CORasR4+QHCEFVLsCCqYew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701039"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:04 -0700
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
Subject: [RFC 02/26] rust/cargo: Add the support for vm-memory
Date: Thu,  7 Aug 2025 20:30:03 +0800
Message-Id: <20250807123027.2910950-3-zhao1.liu@intel.com>
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
 rust/Cargo.lock          | 52 ++++++++++++++++++++++++++++++++++++++++
 rust/qemu-api/Cargo.toml | 11 +++++++++
 2 files changed, 63 insertions(+)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b785c718f315..7aedae239f66 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -133,6 +133,7 @@ dependencies = [
  "foreign",
  "libc",
  "qemu_api_macros",
+ "vm-memory",
 ]
 
 [[package]]
@@ -164,6 +165,26 @@ dependencies = [
  "unicode-ident",
 ]
 
+[[package]]
+name = "thiserror"
+version = "1.0.65"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5d11abd9594d9b38965ef50805c5e469ca9cc6f197f883f717e0269a3057b3d5"
+dependencies = [
+ "thiserror-impl",
+]
+
+[[package]]
+name = "thiserror-impl"
+version = "1.0.65"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ae71770322cbd277e69d762a16c444af02aa0575ac0d174f0b9562d3b37f8602"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
@@ -175,3 +196,34 @@ name = "version_check"
 version = "0.9.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+
+[[package]]
+name = "vm-memory"
+version = "0.16.1"
+source = "git+https://github.com/rust-vmm/vm-memory.git?rev=5eb996a060d7ca3844cbd2f10b1d048c0c91942f#5eb996a060d7ca3844cbd2f10b1d048c0c91942f"
+dependencies = [
+ "thiserror",
+ "winapi",
+]
+
+[[package]]
+name = "winapi"
+version = "0.3.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+dependencies = [
+ "winapi-i686-pc-windows-gnu",
+ "winapi-x86_64-pc-windows-gnu",
+]
+
+[[package]]
+name = "winapi-i686-pc-windows-gnu"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+
+[[package]]
+name = "winapi-x86_64-pc-windows-gnu"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db7000dee441..bbed3d2de514 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -19,6 +19,17 @@ anyhow = "~1.0"
 libc = "0.2.162"
 foreign = "~0.3.1"
 
+[dependencies.vm-memory]
+# The latest v0.16.2 didn't contain Paolo's commit 5f59e29c3d30
+# ("guest_memory: let multiple regions slice one global bitmap").
+# Once a new release has that change, switch to crates.io.
+git = "https://github.com/rust-vmm/vm-memory.git"
+rev = "5eb996a060d7ca3844cbd2f10b1d048c0c91942f"
+# Note "rawfd" (as the only default feature) is disabled by default in
+# meson. It cause compilation failure on Windows and fortunately, we
+# don't need it either.
+default-features = false
+
 [features]
 default = ["debug_cell"]
 allocator = []
-- 
2.34.1


