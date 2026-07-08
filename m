Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C280C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMvb-0003vS-JC; Wed, 08 Jul 2026 03:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvV-0003pD-B1; Wed, 08 Jul 2026 03:42:37 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvT-0004UJ-2a; Wed, 08 Jul 2026 03:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496555; x=1815032555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XmbGriJhJo3emug7dBCMlTqIP+4p9acUMe4lwLyzVTY=;
 b=M8LbQFuuP0ddNP7ZYOK0M+z0LbJOascZJJZl9hrQmeYqvLnWfpu3+4DJ
 /r46CRGilKD31guHjlxFVxEo18qcxS6+yS9rLaTJ5SWDJ7aqHDpH4AKIJ
 lY8sUNCCSsBOmwowYpY47t4jbwCFUyzXLPqm+fYf9G+L9/GQZUKoYPh9I
 g5d58ODz+0tmSJif8HExzOJ87egh2vxOpEMtBvTnIOlc1SQ/ri12YDnVa
 YCnUV1SXagGmxWNFWKgpZMeVx0oqfhjSCOTXADtoWY8adXsedijZc2vVe
 ZgSQ0W4BNGgdQ7ea1NwLUob2vOKbT54lbKRuWhYPbXOFgrJEk3rfTm5Gm A==;
X-CSE-ConnectionGUID: rctyn/6qTC683ZDfKNMgOg==
X-CSE-MsgGUID: MoM4ihgNQrWEygRMgqQl1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343196"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343196"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:33 -0700
X-CSE-ConnectionGUID: lxzCbgCdRYSi7+13s017FA==
X-CSE-MsgGUID: 5WGrFcp6Q2+4h8+Qvf2Aww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555910"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:29 -0700
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
Subject: [RFC v2 02/26] rust/cargo: Add the support for vm-memory
Date: Wed,  8 Jul 2026 16:10:28 +0800
Message-Id: <20260708081052.2276617-3-zhao1.liu@intel.com>
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

By the way, the dependency relationship for system-sys and hwcore-sys is
also updated in Cargo.lock.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Upgrade vm-memory dependency to v0.18.0
 * Update Cargo.lock.
---
 rust/Cargo.lock        | 33 ++++++++++++++++++++++++++++++++-
 rust/Cargo.toml        |  1 +
 rust/system/Cargo.toml |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index cbb3ca15f77f..6d4701930419 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -184,7 +184,6 @@ dependencies = [
  "glib-sys",
  "migration-sys",
  "qom-sys",
- "system-sys",
  "util-sys",
 ]
 
@@ -410,6 +409,7 @@ dependencies = [
  "qom",
  "system-sys",
  "util",
+ "vm-memory",
 ]
 
 [[package]]
@@ -431,6 +431,7 @@ version = "0.1.0"
 dependencies = [
  "common",
  "glib-sys",
+ "hwcore-sys",
  "migration-sys",
  "qom-sys",
  "util-sys",
@@ -456,6 +457,26 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "thiserror"
+version = "2.0.18"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
+dependencies = [
+ "thiserror-impl",
+]
+
+[[package]]
+name = "thiserror-impl"
+version = "2.0.18"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
 [[package]]
 name = "toml"
 version = "0.8.23"
@@ -535,6 +556,16 @@ version = "0.9.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 
+[[package]]
+name = "vm-memory"
+version = "0.18.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9b55e753c7725603745cb32b2287ef7ef3da05c03c7702cda3fa8abe25ae0465"
+dependencies = [
+ "libc",
+ "thiserror",
+]
+
 [[package]]
 name = "winnow"
 version = "0.7.13"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0d24eb84e1cd..cfc540a77335 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -20,6 +20,7 @@ anyhow = "~1.0"
 foreign = "~0.3.1"
 libc = "0.2.162"
 glib-sys = { version = "0.21.2", features = ["v2_66"] }
+vm-memory = "0.18.0"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index d62173703173..179c38ecc27f 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -21,6 +21,7 @@ migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
 glib-sys.workspace = true
+vm-memory.workspace = true
 
 [lints]
 workspace = true
-- 
2.34.1


