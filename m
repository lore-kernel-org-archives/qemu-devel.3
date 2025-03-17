Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC966C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqY-0005Cc-Fv; Mon, 17 Mar 2025 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpw-0004yC-Mb; Mon, 17 Mar 2025 10:53:10 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBps-00061x-50; Mon, 17 Mar 2025 10:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223180; x=1773759180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XkUQGvhkrsZDhye+0haWDeMq4ZtNNxgQa6g30PUPTX0=;
 b=U3+mgOe2H3KJOWpesqXSvibD4cq9ZT9qrV1G7Cqf9W1yXX3ssRPlCHxM
 l6vBcYyCIfLre9IBk/LnUWuBo+95AAg/Ff9b+Q6aixTuYyst4XAEDFVHm
 axmbRH6QJWtnEF9BDdaMSEXSnDtbDAcAC99LN+KDWVS1kGjg5cIGNlJFt
 9ul9QeUy3mS2o+kTutD/PoleRq9mlYwTcoDb3hOzTa2v2oA9VSwH3k0IV
 OzvPSf3t277OQvXXuG/sughDswgC02mtOrCsxfsvbRnl8iZ9aGCAV/0jA
 8CDoGkZRSbFm3XNCuheCdCzFnoz5K2gLJ+6ST2NOgNHYjGRpNk7XUv0pK g==;
X-CSE-ConnectionGUID: r5mQa4qXR0GF4ocmZQ5+9w==
X-CSE-MsgGUID: 4QBMZ1rcRpiQf4ys8t9q+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694606"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694606"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:38 -0700
X-CSE-ConnectionGUID: a1Om4SiHT4yevf9oVp8Wjw==
X-CSE-MsgGUID: gtd/dUUWTcK5nUwWOM+xVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988520"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/17] rust/vmstate: Fix "cannot infer type" error in
 vmstate_struct
Date: Mon, 17 Mar 2025 23:12:27 +0800
Message-Id: <20250317151236.536673-9-zhao1.liu@intel.com>
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

Rust cannot infer the type (it should be VMStateField) after
Zeroable::ZERO, which cause the compiling error.

To fix this error, call with_varray_flag() after VMStateField's
initialization.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 8adef175634a..a9d97d9a856e 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -453,13 +453,15 @@ macro_rules! vmstate_struct {
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: &$vmsd,
-            ..$crate::zeroable::Zeroable::ZERO $(
-                .with_varray_flag($crate::call_func_with_field!(
-                    $crate::vmstate::vmstate_varray_flag,
-                    $struct_name,
-                    $num))
-               $(.with_varray_multiply($factor))?)?
-        }
+            ..$crate::zeroable::Zeroable::ZERO
+         } $(.with_varray_flag(
+                  $crate::call_func_with_field!(
+                      $crate::vmstate::vmstate_varray_flag,
+                      $struct_name,
+                      $num
+                  )
+              )
+           $(.with_varray_multiply($factor))?)?
     };
 }
 
-- 
2.34.1


