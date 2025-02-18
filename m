Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0E9C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIo7-0000Gr-1t; Tue, 18 Feb 2025 03:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkIo4-0000G9-Jy; Tue, 18 Feb 2025 03:18:16 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkIo1-0000f8-GK; Tue, 18 Feb 2025 03:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739866694; x=1771402694;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ta7ruJQrhzCAITHV7W8qvhvnYjlScHvFo6LkCTQJ5nc=;
 b=m4yKmxKEhaTAAbcd5oPinfaqdHBBFrO7WOzMWRFgw4IDQnybeABJRHU3
 ZHP/yFDOZXpsZ7l4xW5xe0WVoVfLdP348+q4qhK6LKnmXTANPiFWKyrRm
 sZvHKEBE2CKDOYTiHc7nNlmLFfbwDYNqtpmnhwgZ+15I6poUQ+I7JHcAp
 P+ZSZ7BJktnWoQW/FcjIxoYUqWv7P5o5n1IQP7NsROlQf34B1l28ZkfT0
 1BIHgziU88sPgrJ8Q9s82kzO2ICxP7oTZL3RV6dcM5vz7q+FxR/iS2/d5
 FPnmlpNPjMZJUBcmVRVZEVYixtnV1hW01WO63dQyWV7TmT2QvgdFDh7wA w==;
X-CSE-ConnectionGUID: 7qri/VGSRMC5ZPjq6K6bfA==
X-CSE-MsgGUID: pRjQQXMWSlGrr+zEFmFl9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51957379"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="51957379"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:18:09 -0800
X-CSE-ConnectionGUID: BYDHgN5VQAa930+H1VTMfA==
X-CSE-MsgGUID: T4DrovEoTvq1QH/+NPKq5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114521691"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 18 Feb 2025 00:18:07 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust: Prefer link_with over link_whole
Date: Tue, 18 Feb 2025 16:37:34 +0800
Message-Id: <20250218083734.3345966-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The commit fccb744f41c6 ("gdbstub: Try unlinking the unix socket before
binding") causes the compilation of rust-qemu-api-integration to fail,
because rust-qemu-api-integration uses link_whole which meets the
duplicate symbol linker error.

Though it's not the issue of link_whole used by Rust side, there's no
need to use link_whole.

Use link_with, which may also bring some benefits, such as faster
linking or smaller output files.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/meson.build | 2 +-
 rust/hw/timer/hpet/meson.build | 2 +-
 rust/qemu-api/meson.build      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 547cca5a96f7..4ba9089fcf8e 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -18,7 +18,7 @@ _libpl011_rs = static_library(
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
-  link_whole: [_libpl011_rs],
+  link_with: [_libpl011_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
   dependencies: [bilge_impl_dep, qemu_api_macros],
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index c2d7c0532ca4..ce90cc4f021a 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -10,7 +10,7 @@ _libhpet_rs = static_library(
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
-  link_whole: [_libhpet_rs],
+  link_with: [_libhpet_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
   dependencies: [qemu_api_macros],
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2e9c1078b9b2..e825671b694b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -63,7 +63,7 @@ test('rust-qemu-api-integration',
         rust_args: ['--test'],
         install: false,
         dependencies: [qemu_api, qemu_api_macros],
-        link_whole: [rust_qemu_api_objs, libqemuutil]),
+        link_with: [rust_qemu_api_objs, libqemuutil]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
-- 
2.34.1


