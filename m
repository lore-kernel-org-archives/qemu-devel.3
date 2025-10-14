Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4ADCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gDL-0006EV-Lf; Tue, 14 Oct 2025 10:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8gD8-0005ym-Ox; Tue, 14 Oct 2025 10:41:13 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8gD2-00017S-9C; Tue, 14 Oct 2025 10:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452864; x=1791988864;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BCIv9WvCeYChIqqBjpb0qOWf+C+747NLrXa02y3pa2s=;
 b=a0miDh1l3QVouojZuP813XO2dxMBxTbHGQnpqA9OSBUe0J+suVveB6vs
 1mh9P8lL9ouUUta/Be+41CGETJ/JtQ9ILEPvAO7hs7qtN0Pb1TEgrOvyp
 ViBaeKCQCLtfmorkLWVZKEt4IgkP5BJoh70QSabosShrM1ssDzQb1IwEe
 v0Dl8PAoF8ThFVtiHToAB173z8be3t6ZUoTA99T9/kbrUEX2chYGBKR8s
 S8WsSpGyq/LdSzpJ6fOfwJ40FQ4L9RpOTslIHVIReIaPlKjsfUepPVE41
 DvsZeLQwET7vjR8LPfyvBLc3a7dkrpj0VCiYSUuxNUomkxsZ7hfnssXj7 g==;
X-CSE-ConnectionGUID: t4w+Nkd4Swu/L+eOqNmzCA==
X-CSE-MsgGUID: M6EGkxhMRVaapk/3+9p0wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73214035"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="73214035"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:40:56 -0700
X-CSE-ConnectionGUID: kvfGcXhuRXSjUH4TrppoZQ==
X-CSE-MsgGUID: YaWuXDmTTgS27C/qkCf1kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="219042393"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 14 Oct 2025 07:40:55 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust/qemu-macros: Convert bit value to u8 within #[property]
Date: Tue, 14 Oct 2025 23:02:51 +0800
Message-Id: <20251014150251.2473680-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For bit property, make the type conversion within the #[property] macro
so that users do not need to handle the conversion.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 rust/qemu-macros/src/lib.rs      | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 86638c076666..23f2eefd1cd9 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -539,7 +539,7 @@ pub struct HPETState {
     // Internal state
     /// Capabilities that QEMU HPET supports.
     /// bit 0: MSI (or FSB) support.
-    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
+    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT, default = false)]
     flags: u32,
 
     /// Offset of main counter relative to qemu clock.
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 3e21b67b4719..2a7454da2416 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -271,7 +271,10 @@ macro_rules! str_to_c_str {
                 name: ::std::ffi::CStr::as_ptr(#prop_name),
                 info: #qdev_prop,
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
-                bitnr: #bitnr,
+                bitnr: {
+                    const { assert!(#bitnr >= 0 && #bitnr <= u8::MAX as _, "bit exceeds u8 range"); }
+                    #bitnr as u8
+                },
                 set_default: #set_default,
                 defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
                 ..::common::Zeroable::ZERO
-- 
2.34.1


