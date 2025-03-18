Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03180C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS5E-00032S-Uh; Tue, 18 Mar 2025 04:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4G-0002ir-EU; Tue, 18 Mar 2025 04:13:00 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4D-0001KN-Jz; Tue, 18 Mar 2025 04:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285574; x=1773821574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LUL+hn75ZGvSzjYEjym7VQ6h20MqReeykwX/s9i5ZaA=;
 b=gT5ZDByGw3JceMvKjqoW/Q3STg4GCUkHdPNTDCI/Sv+dlPLPZiW+5OUO
 t5X36tzifEWqGj7+Lnu7HYzmRxto1uNSGOMrslnhceBNpilF/MP3SbnC+
 9tj6NKfXh2jrbJXAram599OkfQo47byKSqG9tWpm4Wf/J04FwMQ1cDxYF
 NF7OzueoZWjQ1FYHgTHNey1hjSSY/XqMyBjz4cb79nvUL3r0DohDlkJb+
 t5Qs89HKJtaeOy654xGsC4IBmYigLt7qFJFvcdFttA41Jg2mFcRUO/AP4
 7dgrCiSS6IN0enoNyeGJvKvjTPPhq2zIftHCtjxSGv+Ybqf/N2Glf6Yoy Q==;
X-CSE-ConnectionGUID: FmcYFJGpTI28gF29uHXh0Q==
X-CSE-MsgGUID: Jw2lUip2RMeNQaAfk2qsLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621557"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621557"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:48 -0700
X-CSE-ConnectionGUID: Qd/0SpgdRJq+10apz68iBQ==
X-CSE-MsgGUID: 0NjZrmBsSdWsOPG6x9p6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363196"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:47 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 03/14] rust/vmstate: Fix num field when varray flags are set
Date: Tue, 18 Mar 2025 16:32:37 +0800
Message-Id: <20250318083248.1402990-4-zhao1.liu@intel.com>
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


