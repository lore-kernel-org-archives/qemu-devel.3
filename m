Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C73CC44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxO-0008Au-AN; Wed, 08 Jul 2026 03:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxD-0007Au-Mi; Wed, 08 Jul 2026 03:44:25 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxB-0005DU-07; Wed, 08 Jul 2026 03:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496661; x=1815032661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CpnzLqapsE+LHZXah1BgbbxaZjcpTeszmqMzbM3efh4=;
 b=nj9pVGKQOpiZouI6B67YeHd9Jn1jPbenCeBvk4S9hpocAmowqncm78Ds
 /pVEIswVEYL+9HZw+Kd8R8Xg+ONlnTImgzy3PX4DU2Ec3bdut0sDgxVYt
 z/sozsgjTqg94ax3CEhz4eaStvBCSuARY77eWubt8fP2OT+ibndzeUq+U
 /wMiimJibEzEdhf7CttF8/fzhMg8jg3KtYta4m4zb/Dns9hrE2sNvTw0P
 8INbSB1AEh3NlxY1eBBg1iHgiJ8t9ckrwdFD2CHlo+j+7FnKB47qjmDQ3
 yFrI/KS/8vRKClALcyoq2AEdZ4kODvvZva4tzdIYlnEZtnc68xXCu9c2m A==;
X-CSE-ConnectionGUID: yZzVif98TlahbEODJmRNvw==
X-CSE-MsgGUID: I4Eh3B4cSuS1hkENQ9I33Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343422"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343422"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:51 -0700
X-CSE-ConnectionGUID: xohOf9VgThCbQgDTus1vIA==
X-CSE-MsgGUID: lZtf74GRSrSKOvtiQ+9Sbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556081"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:47 -0700
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
Subject: [RFC v2 21/26] rust/system/memory: Add an RAII guard to manage
 FlatView reference counts
Date: Wed,  8 Jul 2026 16:10:47 +0800
Message-Id: <20260708081052.2276617-22-zhao1.liu@intel.com>
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

Introduce FlatViewRefGuard to automatically manage the reference count
for FlatView on the Rust side using RAII.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/system/src/memory.rs | 65 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 721b054d778f..12f48f71900b 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -11,6 +11,7 @@
     marker::PhantomData,
     mem::size_of,
     ops::Deref,
+    ptr::NonNull,
     sync::atomic::Ordering,
 };
 
@@ -24,10 +25,10 @@
 };
 
 use crate::bindings::{
-    self, address_space_lookup_section, device_endian, flatview_translate_section,
-    memory_region_init_io, rust_section_load, rust_section_read_continue_step, rust_section_store,
-    rust_section_write_continue_step, section_access_allowed, section_covers_region_addr,
-    section_fuzz_dma_read, MemTxResult,
+    self, address_space_lookup_section, device_endian, flatview_ref, flatview_translate_section,
+    flatview_unref, memory_region_init_io, rust_section_load, rust_section_read_continue_step,
+    rust_section_store, rust_section_write_continue_step, section_access_allowed,
+    section_covers_region_addr, section_fuzz_dma_read, MemTxResult,
 };
 // FIXME: Convert hwaddr to GuestAddress
 pub use crate::bindings::{hwaddr, MemTxAttrs};
@@ -1143,3 +1144,59 @@ fn to_region_addr(&self, _addr: GuestAddress) -> Option<(&Self::R, MemoryRegionA
         unimplemented!()
     }
 }
+
+/// A RAII guard that provides temporary access to a `FlatView`.
+///
+/// Upon creation, this guard increments the reference count of the
+/// underlying `FlatView`.  When the guard goes out of of scope, it
+/// automatically decrements the count.
+///
+/// As long as the guard lives, the access to `FlatView` is valid.
+#[derive(Debug)]
+pub struct FlatViewRefGuard(NonNull<FlatView>);
+
+impl Drop for FlatViewRefGuard {
+    fn drop(&mut self) {
+        // SAFETY: the pointer is convertible.
+        unsafe {
+            flatview_unref(self.0.as_ref().as_mut_ptr());
+        }
+    }
+}
+
+impl FlatViewRefGuard {
+    /// Attempt to create a new RAII guard for the given `FlatView`.
+    ///
+    /// This may fail if the `FlatView`'s reference count is already zero.
+    pub fn new(flat: &FlatView) -> Option<Self> {
+        // SAFETY: the pointer is convertible.
+        if unsafe { flatview_ref(flat.as_mut_ptr()) } {
+            Some(FlatViewRefGuard(NonNull::from(flat)))
+        } else {
+            None
+        }
+    }
+}
+
+impl Deref for FlatViewRefGuard {
+    type Target = FlatView;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: the pointer and reference are convertible.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+
+impl Clone for FlatViewRefGuard {
+    /// Clone the guard, which involves incrementing the reference
+    /// count again.
+    ///
+    /// This method will **panic** if the reference count of the underlying
+    /// `FlatView` cannot be incremented (e.g., if it is zero, meaning the
+    /// object is being destroyed).  This can happen in concurrent scenarios.
+    fn clone(&self) -> Self {
+        FlatViewRefGuard::new(self.deref()).expect(
+            "Failed to clone FlatViewRefGuard: the FlatView may have been destroyed concurrently.",
+        )
+    }
+}
-- 
2.34.1


