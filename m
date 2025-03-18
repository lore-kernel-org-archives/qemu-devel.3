Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCD3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS59-0002u2-1l; Tue, 18 Mar 2025 04:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4M-0002jp-Hp; Tue, 18 Mar 2025 04:13:06 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4J-0001Jr-6o; Tue, 18 Mar 2025 04:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285579; x=1773821579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=usEhCMOmGCifjwNKm0zeYfxP5suOQmKgiIpvC4cOCps=;
 b=UorvicjYguEO/jZaotibT6CsIyy9HkzX4jc3OZZCRUN8htaWheDoYTlJ
 U5VcNPo3V+LMXTPTQlyOH6lyFwrM9oh99lKutrB5wsgQPThjY69mewMrt
 znEFOGL8+9JuKwRh3smtl5aSap7rphD0EyW6XMwyZl8dhdwAGdiETJWkz
 u6raUXojIvYyy0DkUcz1+5eVMQ8YgAJdV269zc1gzZEu/KufCXV4JazuF
 y4A27+p9F7Bm+yNO0q2Tzu37mNApCOK8eHcfkl6kTIB90UxXRq032l0uh
 kJVn1YwseH+dKCEez+IMyvIm3XrET4kDmAwutIazc6v1owJF9t/oZTxsm A==;
X-CSE-ConnectionGUID: G1vmXEDfRdSlrErdNlMQPQ==
X-CSE-MsgGUID: whLVyZn2Rp+RzPjOqy2Dqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621583"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621583"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:55 -0700
X-CSE-ConnectionGUID: pyl9JkQpQTOgmCYeRt/FfQ==
X-CSE-MsgGUID: g6y8gLOPQsGu5+W3bPagvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363234"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:54 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 08/14] rust/vmstate: Relax array check when build varray in
 vmstate_struct
Date: Tue, 18 Mar 2025 16:32:42 +0800
Message-Id: <20250318083248.1402990-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318083248.1402990-1-zhao1.liu@intel.com>
References: <20250318083248.1402990-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

The varry of structure created by vmstate_struct is different with
vmstate_of. This is because vmstate_struct uses the `vmsd` to traverse
the vmstates of structure's fields, rather than treating the structure
directly as a well-defined vmstate.

Therefore, there's no need to check array flag when building varray by
vmstate_struct.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 792a74fdfc08..0b5af1c90b11 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,14 +275,20 @@ pub const fn with_pointer_flag(mut self) -> Self {
     }
 
     #[must_use]
-    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> VMStateField {
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
         self.num = 0; // varray uses num_offset instead of num.
         self
     }
 
+    #[must_use]
+    #[allow(unused_mut)]
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+        self.with_varray_flag_unchecked(flag)
+    }
+
     #[must_use]
     pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
         assert!(num <= 0x7FFF_FFFFu32);
@@ -454,7 +460,7 @@ macro_rules! vmstate_struct {
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
             ..$crate::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag(
+         } $(.with_varray_flag_unchecked(
                   $crate::call_func_with_field!(
                       $crate::vmstate::vmstate_varray_flag,
                       $struct_name,
-- 
2.34.1


