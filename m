Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE26C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS5B-0002yN-V0; Tue, 18 Mar 2025 04:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4G-0002it-FF; Tue, 18 Mar 2025 04:13:00 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4D-0001JW-M2; Tue, 18 Mar 2025 04:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285574; x=1773821574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qhOop17qvvDdvVOFBqEwZ6YZDR32LRhdetUWxZsO20Y=;
 b=Qxtc//rdMgKIWaaA8NGwNneZeE0Bag3VdIsc0TrZJVfJvg+WJFRA1Rkq
 iwoKGBqIWsFHMX20teYz4QM+OvhBLqr0Dxp5lUeuexPBxe4pOsBo++5nJ
 6AloY5wWkyETkwA7TmgW2sudBa9berusbK7vKlvHv2ylxO1BNo1ZNvUfy
 +IJmhEoIc/qFn5lH8tR4TN+1SYGWYVL6OyKvZxqXmx3bwm8CERc9aeP02
 o5f4E36079xoJnNopsrRDRB3jYZVki+GRaxHKG+FNe+j/gxagMIltXrud
 G7P95NBNaHmClVQ99lEeJ3HFKFRG5hiCunOVyOckRU4k95dxPC2AleChy w==;
X-CSE-ConnectionGUID: QKYCeIUPRFukPSnUWVjYDA==
X-CSE-MsgGUID: lJbeaS0uRA60wsyAo5WNAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621564"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621564"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:50 -0700
X-CSE-ConnectionGUID: /KoGosO0QhKRqNcMhDgV7g==
X-CSE-MsgGUID: kGi+cZyNRqamdRQFp/XD/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363203"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:48 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 04/14] rust/vmstate: Fix size field of VMStateField with
 VMS_ARRAY_OF_POINTER flag
Date: Tue, 18 Mar 2025 16:32:38 +0800
Message-Id: <20250318083248.1402990-5-zhao1.liu@intel.com>
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
index e3233303f204..e2a1f7a97aae 100644
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


