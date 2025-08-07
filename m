Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC05C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzUj-0006x5-Bx; Thu, 07 Aug 2025 08:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSq-0004yg-4i; Thu, 07 Aug 2025 08:11:29 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSh-0005Bp-HS; Thu, 07 Aug 2025 08:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568671; x=1786104671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jN3evfjR5JAhw4apUNC93dHaq2BAAIYH0p23ThxZVjo=;
 b=GsKrB7+63/Z4Y7iBz5YCJC/AfVAvJ0cvB0wUxU5etLMKvcXlro5lD7Oh
 nymbZf25JJe67hAZHTfK/adq41x7DSj6X6rUHZS8hutee3B0jlrQOHmD6
 PYx35Z7iqsBoGp3HnL1tl5Csqzjd1Ms69pD9g2g/dtu7nj9YkzD7Xo8bY
 zV8SlaTfl6NneL2u+d5efYdifDodDutzUz5HCp1P9d47oufln5MYyD7HY
 RRG9k9vn2W9+vQCyN+i4dlrm4m0Bzw1oFAgu2hoaYqbwR/6qPoim0B/CW
 KFJ8G17h+Z3naK+LtdGKnwrc3uXY+CvrW3K/S10NrTQm31hkPl5lQfafI w==;
X-CSE-ConnectionGUID: xemCJoOATNy+jLpf6E7ypg==
X-CSE-MsgGUID: rFF3pVwNQAaFxZJlcxd4cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036918"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:30 -0700
X-CSE-ConnectionGUID: TEg37fmSRGSdceh1NUe7xw==
X-CSE-MsgGUID: 5bLf66UzTlmtIkV+Jq2tVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701391"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:27 -0700
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
Subject: [RFC 26/26] rust/hpet: Use safe binding to access address space
Date: Thu,  7 Aug 2025 20:30:27 +0800
Message-Id: <20250807123027.2910950-27-zhao1.liu@intel.com>
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

Currently, HPET uses unsafe address_space_stl_le() to store MSI message.

Considerring HPET is used for x86 machines, and they're little endian.
So address_space_stl_le() equals to address_space_stl(), which makes it
possible to replace address_space_stl_le() with AddressSpace::store().

Therefore, use the safe binding - AddressSpace::store(), to access
address space.

Since then, the last unsafe piece of HPET has been filled in.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 9fd75bf096e4..e7d5b57f2fe2 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -6,19 +6,17 @@
     ffi::{c_int, c_void, CStr},
     mem::MaybeUninit,
     pin::Pin,
-    ptr::{addr_of_mut, null_mut, NonNull},
+    ptr::NonNull,
     slice::from_ref,
 };
 
 use qemu_api::{
-    bindings::{
-        address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_usize,
-    },
+    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
     memory::{
-        hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+        hwaddr, GuestAddress, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder,
+        ADDRESS_SPACE_MEMORY,
     },
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -327,17 +325,12 @@ fn set_irq(&mut self, set: bool) {
 
         if set && self.is_int_enabled() && self.get_state().is_hpet_enabled() {
             if self.is_fsb_route_enabled() {
-                // SAFETY:
-                // the parameters are valid.
-                unsafe {
-                    address_space_stl_le(
-                        addr_of_mut!(address_space_memory),
-                        self.fsb >> 32,  // Timer N FSB int addr
-                        self.fsb as u32, // Timer N FSB int value, truncate!
-                        MEMTXATTRS_UNSPECIFIED,
-                        null_mut(),
-                    );
-                }
+                ADDRESS_SPACE_MEMORY
+                    .store(
+                        GuestAddress(self.fsb >> 32), // Timer N FSB int addr
+                        self.fsb as u32,              // Timer N FSB int value, truncate!
+                    )
+                    .expect("Failed to store into ADDRESS_SPACE_MEMORY.");
             } else if self.is_int_level_triggered() {
                 self.get_state().irqs[route].raise();
             } else {
-- 
2.34.1


