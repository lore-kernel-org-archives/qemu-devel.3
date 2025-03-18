Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD223C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWHI-0007vM-4a; Tue, 18 Mar 2025 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH2-0007pK-OB; Tue, 18 Mar 2025 08:42:27 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH0-0002wy-RJ; Tue, 18 Mar 2025 08:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301743; x=1773837743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sxgX16JKNTG+AY3C+How4ZUdjbZC9zSiCisbiIfnClo=;
 b=QbwP7DZcTKeIPrszzHj0Vd1+Gs5n2BW2oZ2D9OHOgTfv3itt04XgAFjY
 6MVPhefbvcvfvo2meVvhEqi3BFvJijjtHcgDXHEl9776hbcPZs/S/cGM5
 WLyjfgy+Dd6F1p51O5/zJrpHhNkcP9kTPDGQdYlf9jgo2ch2YRMYqRFTB
 uW1tUH14MuxC+Zb6YVAepnilGEFawkzHrcxreF5BB63HzD4M5/7BjHbPJ
 6x0b5eJwmNMEIPOXpHrkj2i9kdWOrq9xnT02PXiQCeFmOB1dBms1axdC4
 2VY0Ov9AkcG/jrr1H1cpYxHQcsYiht/bz1UgQKlUNWeqZRdNXX84Av+ie w==;
X-CSE-ConnectionGUID: auwceXN8R06Gz3jELn1NIw==
X-CSE-MsgGUID: UpFtt8/VTkqUur+cxsop/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824570"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824570"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:16 -0700
X-CSE-ConnectionGUID: D5k2mmKBTD+IsPgN09dfpQ==
X-CSE-MsgGUID: KgOkQz0NQEyvs7j7XDzTMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980441"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:14 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 05/15] rust/vmstate: Fix type check for varray in
 vmstate_struct
Date: Tue, 18 Mar 2025 21:02:09 +0800
Message-Id: <20250318130219.1799170-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318130219.1799170-1-zhao1.liu@intel.com>
References: <20250318130219.1799170-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

When pass a varray to vmstate_struct, the `type` parameter should be the
type of the element in the varray, for example:

vmstate_struct!(HPETState, timers, [0 .. num_timers], VMSTATE_HPET_TIMER,
		BqlRefCell<HPETTimer>).with_version_id(0)

But this breaks current type check, because it checks the type of
`field`, which is an array type (for the above example, type of timers
is [BqlRefCell<HPETTimer>; 32], not BqlRefCell<HPETTimer>).

But the current assert_field_type() can no longer be extended to include
new arguments, so a variant of it (a second macro containing the
`num = $num:ident` parameter) had to be added to handle array cases.

In this new macro, it not only checks the type of element, but also
checks whether the `num` (number of elements in varray) is out of range.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/assertions.rs | 15 +++++++++++++++
 rust/qemu-api/src/vmstate.rs    |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 104dec39774e..176060e32acd 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -91,6 +91,21 @@ fn types_must_be_equal<T, U>(_: T)
             }
         };
     };
+
+    ($t:ty, $i:tt, $ti:ty, num = $num:ident) => {
+        const _: () = {
+            #[allow(unused)]
+            fn assert_field_type(v: $t) {
+                fn types_must_be_equal<T, U>(_: T)
+                where
+                    T: $crate::assertions::EqType<Itself = U>,
+                {
+                }
+                let index: usize = v.$num.try_into().unwrap();
+                types_must_be_equal::<_, &$ti>(&v.$i[index]);
+            }
+        };
+    };
 }
 
 /// Assert that an expression matches a pattern.  This can also be
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index e2a1f7a97aae..9d9cdda993ce 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -447,7 +447,7 @@ macro_rules! vmstate_struct {
                 .as_ptr() as *const ::std::os::raw::c_char,
             $(num_offset: $crate::offset_of!($struct_name, $num),)?
             offset: {
-                $crate::assert_field_type!($struct_name, $field_name, $type);
+                $crate::assert_field_type!($struct_name, $field_name, $type $(, num = $num)?);
                 $crate::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<$type>(),
-- 
2.34.1


