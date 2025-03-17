Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781BCC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqS-000586-E7; Mon, 17 Mar 2025 10:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpv-0004y4-AG; Mon, 17 Mar 2025 10:53:10 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpm-00061r-VT; Mon, 17 Mar 2025 10:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223175; x=1773759175;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w7POmeU7VP6eIrAcsdWPqJZKF2jRdbcjZRS+bIqVuS8=;
 b=nZsAZnyk674/TcTHrAjNpvcaNM47GiZROv9kNj/FqJUtmSYX6IUMcKNJ
 /sa8yb77mjAN4VPhaXuiO5Vshh6Fv09V+HHnlfFGq5t1K07OcY87hI8ym
 RRKyPxnTk2hWa2+XdNXqMqkqcbSYDI7YahFdJoFI92FPE5Wlb/XAEoQaw
 fCHrVnXJjTl+Mk8l8TCIVoh6kkMms9G+ucUEd5cmbDyL397zvO5do75IB
 DBjBcaCYDziUbPjh9zLDEd7Qm5Sn3r4TM7MqDz1UiorbAZH8xDMEuliCf
 UZS/rT8axzGzjUaOD6IFRmPjwWC80yM5WJ6sEk7ENf8UC15J59YD2g+kx g==;
X-CSE-ConnectionGUID: MIxTDT6TRHOPE2lyeruqUQ==
X-CSE-MsgGUID: W89MJnHHRWWV/kHJijofxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694602"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694602"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:35 -0700
X-CSE-ConnectionGUID: m4cpMr+JSICYRJyoyWXW0g==
X-CSE-MsgGUID: RQ7T7ea1R4eoFvJLdnoJxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988512"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:34 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/17] rust/vmstate: Fix size field of VMStateField with
 VMS_ARRAY_OF_POINTER flag
Date: Mon, 17 Mar 2025 23:12:25 +0800
Message-Id: <20250317151236.536673-7-zhao1.liu@intel.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The `size` field of the VMStateField with VMS_ARRAY_OF_POINTER flag
should stores the size of pointer, which depends on platform.

Currently, `*const`, `*mut`, `NonNull`, `Box<>` and their wrapper are
supported, and they have the same size as `usize`.

Store the size (of `usize`) when VMS_ARRAY_OF_POINTER flag is set.

The size may be changed when more smart pointers are supported, but now
the size of "usize" is enough.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index e877ee5e391d..5af75b4777e9 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -256,6 +256,10 @@ pub const fn with_array_flag(mut self, num: usize) -> Self {
         if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
             self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
             self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
+            // VMS_ARRAY_OF_POINTER flag stores the size of pointer.
+            // FIXME: *const, *mut, NonNull and Box<> have the same size as usize.
+            //        Resize if more smart pointers are supported.
+            self.size = std::mem::size_of::<usize>();
         }
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
         self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
-- 
2.34.1


