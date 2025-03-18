Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E07C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWI8-0000jL-GL; Tue, 18 Mar 2025 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH2-0007pJ-OF; Tue, 18 Mar 2025 08:42:26 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH0-0002we-BX; Tue, 18 Mar 2025 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301743; x=1773837743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LUL+hn75ZGvSzjYEjym7VQ6h20MqReeykwX/s9i5ZaA=;
 b=Mim5YvOOYjl79MoQCG/tFKtzUgTqqWXc1KkWNp95dhdBAFWz6bLPneTw
 EwI4+gvX0hZYRJdwAG7T6fIZTMrVCSOlDiRNrD88kHfftImqOzXN3HID8
 LTX41u/3veNVf5c90O7lTlK1RO8kXrBDw6T0f0NYn3+Vo7t+4HdBQHDT9
 2Mw92vpRWpGYTxjCPIOKukrpwW8v43C3p8yrZ/MQK8MhgbqyYJ2p4W3NC
 4OECUYSAlUQuCRVBa6yelRUvalG1GeiVXkf3lWWMH/TwPXei84dwt7j9h
 0ipTJzASBY4LyKTZ/0j3c5LTQxnlVeDhsV2NFzC0/lSSg3wkRVjL0EQxi Q==;
X-CSE-ConnectionGUID: uxzFT/22RNWL7mDm6pD4ag==
X-CSE-MsgGUID: tD9nZXQHRYOlLwEyNydVsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824563"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824563"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:13 -0700
X-CSE-ConnectionGUID: XsLaUSsMR8KqVla6hizd9A==
X-CSE-MsgGUID: ayLrs9s+T8yj6tfW3MLatw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980423"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 03/15] rust/vmstate: Fix num field when varray flags are set
Date: Tue, 18 Mar 2025 21:02:07 +0800
Message-Id: <20250318130219.1799170-4-zhao1.liu@intel.com>
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

Array type vmstate has the VMStateField with `num` equals its length.

When the varray vmstate is built based a array type, the `num` field
should be cleaned to 0, because varray uses `num_offset` instead of
`num` to store elements number information.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9533b1250fa5..e3233303f204 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,6 +275,7 @@ pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMSta
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
+        self.num = 0; // varray uses num_offset instead of num.
         self
     }
 
-- 
2.34.1


