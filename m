Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B997C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqS-00057z-D3; Mon, 17 Mar 2025 10:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpk-0004ue-3o; Mon, 17 Mar 2025 10:52:54 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpd-00061x-JM; Mon, 17 Mar 2025 10:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223166; x=1773759166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MCx0zDycZpOMc1w/byljIhWhqUJGEtnpHBLsQvLLbRU=;
 b=Tac3UTLsQJEogNcDb4mYiEx0ln19MK6HAYfslqd5TsQZYsBmUyx+/cHN
 M2gs4Vp7HibokjiM/V/BBU+eCTdYQvEVddQULM3T89KtvbqCv8cliFwPo
 vMIOgDLJcYCXZxtNR7i9NoFd/W+CCCMwBcxZc5/StmbvgPuOrjDVVMXA9
 lRvqgAmnwjex0QOX26cgzq4Da5AlTkrBfjy0+T8mAnRs6g/YM7hL4LmlS
 4P88sycAR1tvPpIUWu/ty8e7nF0scRn5enqTFiN5u3cxOmukJTgEEyS1A
 42tyoyJj977jvYOh+UMWC+fbx66vrZAK88hjLTPMXuGj+FAf4BXkx1ytD Q==;
X-CSE-ConnectionGUID: LSckWGriSoCpuyyCzVLE3A==
X-CSE-MsgGUID: P4U7CmS2QJm8Mg3SvE9NdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694599"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694599"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:33 -0700
X-CSE-ConnectionGUID: 3S69gOMgQ8eLaVj5SxAD6A==
X-CSE-MsgGUID: jOPVS7RITdydBcgB8SYVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988507"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:32 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/17] rust/vmstate: Fix num field when varray flags are set
Date: Mon, 17 Mar 2025 23:12:24 +0800
Message-Id: <20250317151236.536673-6-zhao1.liu@intel.com>
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

Array type vmstate has the VMStateField with `num` equals its length.

When the varray vmstate is built based a array type, the `num` field
should be cleaned to 0, because varray uses `num_offset` instead of
`num` to store elements number information.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 3f95d4825149..e877ee5e391d 100644
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


