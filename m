Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5E0C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxL-0007qM-Ur; Wed, 08 Jul 2026 03:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxH-0007Ib-4H; Wed, 08 Jul 2026 03:44:28 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxE-0005DU-D4; Wed, 08 Jul 2026 03:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496665; x=1815032665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3mIUIX/GoY0bywEAIUdiPwadX47LE75STcq2xZIplVk=;
 b=kEpX6iKaPWhcnneLYYDUhb/Nmx3OibT8twDa0pkd91SENweSdVRZwWeC
 yJKIJL677+QmIkw+dFWwCa6kWqy/1F6cYtv3Qjr+/FxeF/qioKZvyINII
 rBDSBUuSA5Jr3HVJlwl9d8vAQoOPLbInYdWUKFr8AKLwerxNhejX7s7ni
 maaWBQU0nifuhLNElwxi5F+/oc24Ge/WcgIKL2wJGJEq3RwUXQzOcaBf7
 XQjNbvBDf4iFVB42UuaIK/W058N8tV5DvcpjC6wtHC9017kSOMXyANOBg
 ZBdOAbT3lJjxaPcL61ERtCCckXiQHA6GdAUeKieCu6qmcFMBsGQJhDTrM A==;
X-CSE-ConnectionGUID: byqy8WhzSqeOS1hek0AgNg==
X-CSE-MsgGUID: O/I915z1RiqwAPIYCpY6dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343457"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343457"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:44:04 -0700
X-CSE-ConnectionGUID: QxBVCm0cQE2Sxm+mr94yag==
X-CSE-MsgGUID: o9OoWFB2ScmZ8bDya56pYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556101"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:59 -0700
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
Subject: [RFC v2 24/26] rust/hpet: Use safe binding to access address space
Date: Wed,  8 Jul 2026 16:10:50 +0800
Message-Id: <20260708081052.2276617-25-zhao1.liu@intel.com>
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

Currently, HPET uses unsafe address_space_stl_le() to store MSI message.

Therefore, use the safe binding - AddressSpace::store() with Le32, to
access address space.

Since then, the last unsafe piece of HPET has been filled in.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Explicitly specify endianness by Le32 and get rid of native
   endianness.
 * Drop expect() method to avoid abort() on error - consistent with the
   behavior on the C side.
---
 rust/hw/timer/hpet/src/device.rs | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 7c60cc0f10ab..e3a0fa25b14b 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -2,24 +2,14 @@
 // Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{
-    ffi::CStr,
-    mem::MaybeUninit,
-    pin::Pin,
-    ptr::{addr_of_mut, null_mut, NonNull},
-    slice::from_ref,
-};
+use std::{ffi::CStr, mem::MaybeUninit, pin::Pin, ptr::NonNull, slice::from_ref};
 
 use bql::prelude::*;
 use common::prelude::*;
 use hwcore::prelude::*;
 use migration::{self, prelude::*, ToMigrationStateShared};
 use qom::prelude::*;
-use system::{
-    bindings::{address_space_memory, address_space_stl_le},
-    prelude::*,
-    MEMTXATTRS_UNSPECIFIED,
-};
+use system::{prelude::*, GuestAddress, Le32, ADDRESS_SPACE_MEMORY};
 use util::prelude::*;
 
 use crate::fw_cfg::HPETFwConfig;
@@ -327,17 +317,10 @@ fn set_irq(&self, regs: &HPETRegisters, set: bool) {
 
         if set && tn_regs.is_int_enabled() && regs.is_hpet_enabled() {
             if tn_regs.is_fsb_route_enabled() {
-                // SAFETY:
-                // the parameters are valid.
-                unsafe {
-                    address_space_stl_le(
-                        addr_of_mut!(address_space_memory),
-                        tn_regs.fsb >> 32,  // Timer N FSB int addr
-                        tn_regs.fsb as u32, // Timer N FSB int value, truncate!
-                        MEMTXATTRS_UNSPECIFIED,
-                        null_mut(),
-                    );
-                }
+                let _ = ADDRESS_SPACE_MEMORY.store(
+                    GuestAddress(tn_regs.fsb >> 32), // Timer N FSB int addr
+                    Le32::from(tn_regs.fsb as u32),  // Timer N FSB int value, truncate!
+                );
             } else if tn_regs.is_int_level_triggered() {
                 self.get_state().irqs[route].raise();
             } else {
-- 
2.34.1


