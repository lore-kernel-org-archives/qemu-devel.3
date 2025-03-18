Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D4C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS58-0002u1-S3; Tue, 18 Mar 2025 04:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4K-0002jR-B0; Tue, 18 Mar 2025 04:13:03 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4I-0001KN-3i; Tue, 18 Mar 2025 04:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285578; x=1773821578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AJ9pLJabRD2fMSQ7De1Zod0j1WnZ3dKpbCNMa8ACBf8=;
 b=nztAzNHDpOQ2y+fhjncFCot1B+xEu/gyT2xQwIGkt+SJzG2nPpERtvBs
 7OOSBhQ5f4GPSsxKd1ggCGOzrnQSkwY9zT7+a52nA0l8IkSWn9Mf9Ifa6
 ZJaIQQt4of/hJeBKZPFKa+Z8TkvxVVvPMNwEfTGcjw5B6VDM94wvv2Stl
 /PGSlv4ncZB3aEgewgAEzjSLBDS5g/AAQZbdO+0E0WaPDp/2aZVXvjVjn
 OS5dtsgZz4yyg/2HA3TlkM1/GqLw6SVZerGbRF52Aur3igy8HDw1uyuG7
 FK/NDNXqhQ4/pPE4whBqTIoNF2BjHPEuC1A4wLGFth3Jxp0tIo7yCeMj6 A==;
X-CSE-ConnectionGUID: od9aS6LQSz2GsDO7Q9OjOg==
X-CSE-MsgGUID: pYUHM/wYSAy0QOB17KIoUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621574"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621574"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:53 -0700
X-CSE-ConnectionGUID: T8W8bXsCTPmdA6eghVd8JQ==
X-CSE-MsgGUID: 03dyGbpqTKORauPejgK25A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363222"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:51 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 06/14] rust/vmstate: Fix "cannot infer type" error in
 vmstate_struct
Date: Tue, 18 Mar 2025 16:32:40 +0800
Message-Id: <20250318083248.1402990-7-zhao1.liu@intel.com>
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

Rust cannot infer the type (it should be VMStateField) after
Zeroable::ZERO, which cause the compiling error.

To fix this error, call with_varray_flag() after VMStateField's
initialization.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9d9cdda993ce..3be3a7260fe9 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -453,13 +453,15 @@ macro_rules! vmstate_struct {
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
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


