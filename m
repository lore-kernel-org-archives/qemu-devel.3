Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58216CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPh-0005C5-4r; Wed, 12 Nov 2025 23:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOx-0004lP-H7; Wed, 12 Nov 2025 23:57:43 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOs-0001c6-K6; Wed, 12 Nov 2025 23:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009859; x=1794545859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zX1b/fem+6Jay0PpoUE7oh0H74VaN7d+HT2mFzMS8QA=;
 b=JSW5tEzMifHC2dr/Zn1gNtnx/b8Xm0gNndPVUhOnipXW72re5eFUN6aR
 NSwztqL+9S9OEwXwPx25gX5rkwVNQGaT6JShH0uiO9TZEGRpp6R/znXUt
 /CS6PyPjQWxEGMcDXUw2NpxW4cryMPsx7BYBhrZT83wrdhei98+ws1bqa
 2soXkJlDfXSoVN6sS4pnuO05pEq8MIH81IX473dtMbY0vasBD9eyQrw3o
 Bq7qRUGem5RfulmZmAuK7PfT/wOzMRcH+FC+b3HfIEZZ9Fl2rLE6TgLkn
 HeSLCBUJ+GcgXiRciLcLWMaKqbi/vFOgXzLyHVI/inn5y8bsLAvBcZdWU Q==;
X-CSE-ConnectionGUID: 4QgGMFKOS5K6H4dnZ/i9Mg==
X-CSE-MsgGUID: LRcxAtDCRbqAWVvEO9+nhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682079"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208,217";a="67682079"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:34 -0800
X-CSE-ConnectionGUID: HAwCeUqDTg2mOu5CSWUuFQ==
X-CSE-MsgGUID: Y4wtPsrZT++8QW+/HdOE8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
 d="scan'208,217";a="193663241"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:32 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/22] rust/memory: Add enable_lockless_io binding
Date: Thu, 13 Nov 2025 13:19:21 +0800
Message-Id: <20251113051937.4017675-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113051937.4017675-1-zhao1.liu@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

Directly wrap the memory_region_enable_lockless_io() in
MemoryRegion::enable_lockless_io.

Although memory_region_enable_lockless_io() just sets 2 fields at C
side, it's not necessary to totally implement it at Rust side, instead,
simply wrap and reuse existing C interfaces.

This will save some effort when modifying the interface in the future
(changes are likely to occur, as there is a TODO in the C code).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/system/src/memory.rs | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 4b3316bf767f..e4bfbed1febe 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -12,7 +12,9 @@
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 use qom::prelude::*;
 
-use crate::bindings::{self, device_endian, memory_region_init_io};
+use crate::bindings::{
+    self, device_endian, memory_region_enable_lockless_io, memory_region_init_io,
+};
 pub use crate::bindings::{hwaddr, MemTxAttrs};
 
 pub struct MemoryRegionOps<T>(
@@ -172,6 +174,17 @@ pub fn init_io<T: IsA<Object>>(
             );
         }
     }
+
+    /// Enable lockless (BQL free) acceess.
+    ///
+    /// Enable BQL-free access for devices that are well prepared to handle
+    /// locking during I/O themselves: either by doing fine grained locking or
+    /// by providing lock-free I/O schemes.
+    pub fn enable_lockless_io(&self) {
+        // SAFETY: MemoryRegion is wrapped by Opaque<>, it's safe to get a
+        // raw pointer as *mut MemoryRegion.
+        unsafe { memory_region_enable_lockless_io(self.as_mut_ptr()) }
+    }
 }
 
 unsafe impl ObjectType for MemoryRegion {
-- 
2.34.1


