Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEB1C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWHV-0008Dw-0h; Tue, 18 Mar 2025 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH3-0007pX-Hh; Tue, 18 Mar 2025 08:42:26 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH1-0002wP-8a; Tue, 18 Mar 2025 08:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301744; x=1773837744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qhOop17qvvDdvVOFBqEwZ6YZDR32LRhdetUWxZsO20Y=;
 b=c7f8zoBWOPc3nuiBhF9F9CJQTa7bY5omquDpXgMLlPl1ngS9QLARkY6s
 Ga2mA+egca3aDQ0mFl3NLHJ8Ht00jqN5Tgd4M3oyL70YUVLrLfDbRdYLR
 XR9dhQZGafQbNUf8BRZpJ/c/bWI19j03rz3cmjuMp0xca2TtRNnG4W9nf
 5/zJ8BdiAoAhK3f64MRmu0U0SYv2UwLaOaQ8H9SFLBqqxPBITwEbMiYas
 GOZSeXqXqMBHgetqfs03wv/Hbwl1HmPEuDfg+5eszpDFI1HKl/I5qSjnJ
 oBfk1D/zAwuM1TONRftGBaZQZbxuvPyrWICQ80RhlK45i0n1M0kY2X/jA w==;
X-CSE-ConnectionGUID: rX+hcEGyQGiY+VJQ5in0dg==
X-CSE-MsgGUID: y9gbd896Rk2ugqMBBgP7Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824567"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824567"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:14 -0700
X-CSE-ConnectionGUID: axMfs3gbQPKTQu7sXBbZ5Q==
X-CSE-MsgGUID: w11beLlZQ6CrTKzq/H1JPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980434"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:13 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 04/15] rust/vmstate: Fix size field of VMStateField with
 VMS_ARRAY_OF_POINTER flag
Date: Tue, 18 Mar 2025 21:02:08 +0800
Message-Id: <20250318130219.1799170-5-zhao1.liu@intel.com>
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


