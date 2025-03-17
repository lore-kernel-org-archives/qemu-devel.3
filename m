Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B4AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqd-0005Eg-7g; Mon, 17 Mar 2025 10:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBq6-00051x-RD; Mon, 17 Mar 2025 10:53:15 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBq3-00061x-C4; Mon, 17 Mar 2025 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223191; x=1773759191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ww3hkZiQiqJ1KeYMe4dC+I1LJZe0UZlFqW2pOLJh9fY=;
 b=gHFKA35bBUSa3rVrF+RDG2z2A+URC431fUM5buD5Uao07ujivhWviiW6
 PBZrpT5OyCQ7ZyRTchL4qePmb08hOkGlp1K2ka0c3TTxJUwmAlC/xyjg3
 xPF3wF4jxiweucOCLZsQQjj7XzCp8mo/QAkLTcdr5Wgq3YOK5XGZ4ChtM
 J9ehSkDmF0brXGbXf3EskWNfJ35D81KlfjmnVrT4tIyXubEsnTAFMa/Vc
 HLvz7yBstfhZ2lCQQwbjMlWG0ec5z0M6pactlj8V4srhY3A5Pg/A8yBAc
 EWqfZ/QmZbNHpMlHNOjiFaXE/5UmrH7+BLZNneDcNppyHce5+u3Zuj8Jx Q==;
X-CSE-ConnectionGUID: LhG7ibZZS1CJx7H2BaKfmQ==
X-CSE-MsgGUID: bh2T7u58QQSB6/3ew9pA+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694622"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:42 -0700
X-CSE-ConnectionGUID: M3vgR3RnRM6+HtKJ3LCEmQ==
X-CSE-MsgGUID: wCOi86+ETnOs5YoT2nrJqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988535"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:41 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 11/17] rust/vmstate: Re-implement VMState trait for timer
 binding
Date: Mon, 17 Mar 2025 23:12:30 +0800
Message-Id: <20250317151236.536673-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317151236.536673-1-zhao1.liu@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

At present, Rust side has a timer binding "timer::Timer", so the vmstate
for timer should base on that binding instead of the raw
"binding::QEMUTimer".

It's possible to apply impl_vmstate_transparent for cell::Opaque and
then impl_vmstate_forward for timer::Timer. But binding::QEMUTimer
shouldn't be used directly, so that vmstate for such raw timer type is
useless.

Thus, apply impl_vmstate_scalar for timer::Timer. And since Opaque<> is
useful, apply impl_vmstate_transparent for cell::Opaque as well.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 806d531b0c37..3d4c50ca86f9 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -27,12 +27,7 @@
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::{
-    bindings::{self, VMStateFlags},
-    prelude::*,
-    qom::Owned,
-    zeroable::Zeroable,
-};
+use crate::{bindings::VMStateFlags, prelude::*, qom::Owned, zeroable::Zeroable};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -344,6 +339,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
@@ -390,7 +386,7 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
 impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
-impl_vmstate_scalar!(vmstate_info_timer, bindings::QEMUTimer);
+impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
 
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
-- 
2.34.1


