Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A9DC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqL-00054B-MH; Mon, 17 Mar 2025 10:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpY-0004t1-Pd; Mon, 17 Mar 2025 10:52:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpT-00061r-7k; Mon, 17 Mar 2025 10:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223155; x=1773759155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4u5ylYM12of4QFCbfERzBFIVepVdhFlIVpqn5oTA2eM=;
 b=EbtmY+kS6/pO6fG7WIK8WtHWJrhzLflule3hnYDdp2joJga1KLFqQAS6
 z4iRtAjS6mmeoerRBXId2HJ+C9HAyVbzwEuPeXTx6KlfbWfo2z2uYp23R
 t3z3EQQeNpHcsiLhig9O8QN5jHgeQWemoFVbR7LPKwpPFqpDj7jyzCrIS
 AcgbSO4mjmoPNlC1CoeqT/VRzjXs6ic+UedySEyv8ivUau6kTH2Ifg0aa
 vqBkoofucJygbExTDBqmoFWJZjFOwBksdEleEXy487G/l28P047VJJtLj
 40hhAnMqy73+ry9ZfhLV5qrQvvSrTGzJyV+P+lasNY37kjK7oowtzjenX g==;
X-CSE-ConnectionGUID: tY6OHbD1Rh27PvRHQVodvg==
X-CSE-MsgGUID: qaPciT7yTp243kO9JJWBmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694586"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694586"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:28 -0700
X-CSE-ConnectionGUID: qQw72Y/JQeKvdD1HA3K5YQ==
X-CSE-MsgGUID: YpQKTJ1DR1S3RbhbjENSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988486"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:27 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/17] rust/vmstate: Remove unnecessary unsafe
Date: Mon, 17 Mar 2025 23:12:20 +0800
Message-Id: <20250317151236.536673-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317151236.536673-1-zhao1.liu@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


