Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B83C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWHJ-0007wf-N6; Tue, 18 Mar 2025 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWGy-0007oN-J8; Tue, 18 Mar 2025 08:42:27 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWGu-0002we-9N; Tue, 18 Mar 2025 08:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301737; x=1773837737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4u5ylYM12of4QFCbfERzBFIVepVdhFlIVpqn5oTA2eM=;
 b=Lrg50e9khAGT8PEQYOhfFsqXTqCubICmdeEqyz01Jt0uTAknc5+ZBDRp
 NSzuZz1kRoY/whBBktq+xDe8F7mGRH4NRjz8BAIG4aWmnuJlZLflXrctY
 eYjaBG/kuyUP+yy+InhuwLac124hwW2FCLuwverDI53XRFxmyX9uWlsUp
 jhUbTPPbLgacs/rSKAA86QuL9nne7ghL62h+Ad+Z9eO+wcHgCBKC8O2wg
 tJWSEPoLlOYbDfGKt8xzY0lMVDof1HCzR5EXpV0QnFN6I8wthaThxPMn7
 ee4NMGkDl1QF3NUhJ/Ue2puba5s7tBWqHUMx/gyvaBKgx0n59RLPYP9v/ A==;
X-CSE-ConnectionGUID: OJILAGQjTX6/I/mKniompA==
X-CSE-MsgGUID: HQNLxVaWTp65BtZjDMgeAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824555"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824555"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:10 -0700
X-CSE-ConnectionGUID: xUKSDz1qQEmhlrJrLMXW7w==
X-CSE-MsgGUID: WmdTw/BDRlCkuh5wWf9JfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980402"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:08 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 01/15] rust/vmstate: Remove unnecessary unsafe
Date: Tue, 18 Mar 2025 21:02:05 +0800
Message-Id: <20250318130219.1799170-2-zhao1.liu@intel.com>
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

Remove the `unsafe` block of vmsd, because vmsd (passed to
vmstate_struct) is defined in Rust side now, and it doesn't need
`unsafe`.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index f0510ae769d1..6698dfe7aeb8 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -447,7 +447,7 @@ macro_rules! vmstate_struct {
             },
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-            vmsd: unsafe { $vmsd },
+            vmsd: $vmsd,
             ..$crate::zeroable::Zeroable::ZERO $(
                 .with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
-- 
2.34.1


