Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E781C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJjx-00009D-Rl; Sun, 09 Feb 2025 21:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjw-00008x-Ur; Sun, 09 Feb 2025 21:41:40 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjv-00088s-9v; Sun, 09 Feb 2025 21:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155299; x=1770691299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y/muAhgS03tDvmIKU/5AGbd6xaeSngpnzqvwG7x9b6c=;
 b=Z/gwpjAMaoqE4/b/aN3bQbWB2E3GoMt/8bJsU1QNqPtLryis3ydjY/g0
 nhUESNrakE8psGccEWF3FPCJMCnexk5IYfyXpzuple41jNPmpcMtm+Juv
 vNtHF9ASoOQiaHPBa22JxIDbI8oKIXi+KxxvsdJ/3eCliRHJhH7T99OiR
 LD0edFm7QNaEqGnvCYkNUPNAHBEpio8KR8TIy6kTf7VOv2zmdZC6fse56
 UfqoB+wUUDg9uwlTusWuQL+GzBUF+nRxs6+N/XRnR5vFc5pIMD/nFpK9J
 j+mnBYQzShw/Z/zfV30ULyf0AUdMy06cSCr9BcdD5pGkyz0sxOB3sp3ES A==;
X-CSE-ConnectionGUID: ZomfTb0xQnSj8TjZTnksGg==
X-CSE-MsgGUID: TpvWQbM4T6imHz5KA9PK1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351261"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351261"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:38 -0800
X-CSE-ConnectionGUID: KscAoHMtTLOxiWvwwktlOA==
X-CSE-MsgGUID: 20ClY6PDQpaX+cKbz2A5mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938222"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:35 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 05/10] rust: add bindings for memattrs
Date: Mon, 10 Feb 2025 11:00:46 +0800
Message-Id: <20250210030051.2562726-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

The MemTxAttrs structure contains bitfield members, and bindgen is
unable to generate an equivalent macro definition for
MEMTXATTRS_UNSPECIFIED.

Therefore, manually define a global constant variable
MEMTXATTRS_UNSPECIFIED to support calls from Rust code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * With a boolean type unspecified field, no need to add once_cell.
 * Merge memattrs binding to memory.rs.
---
 rust/qemu-api/src/memory.rs   | 16 ++++++++++++++--
 rust/qemu-api/src/zeroable.rs |  1 +
 rust/wrapper.h                |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 963d689c27d4..fff92508c68f 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -2,7 +2,7 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Bindings for `MemoryRegion` and `MemoryRegionOps`
+//! Bindings for `MemoryRegion`, `MemoryRegionOps` and `MemTxAttrs`
 
 use std::{
     ffi::{CStr, CString},
@@ -11,7 +11,7 @@
     ptr::addr_of,
 };
 
-pub use bindings::hwaddr;
+pub use bindings::{hwaddr, MemTxAttrs};
 
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
@@ -189,3 +189,15 @@ unsafe impl ObjectType for MemoryRegion {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_MEMORY_REGION) };
 }
 qom_isa!(MemoryRegion: Object);
+
+/// A special `MemTxAttrs` constant, used to indicate that no memary
+/// attributes are specified.
+///
+/// Bus masters which don't specify any attributes will get this,
+/// which has all attribute bits clear except the topmost one
+/// (so that we can distinguish "all attributes deliberately clear"
+/// from "didn't specify" if necessary).
+pub const MEMTXATTRS_UNSPECIFIED: MemTxAttrs = MemTxAttrs {
+    unspecified: true,
+    ..Zeroable::ZERO
+};
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 304ad6698360..53dc90da31a1 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -103,3 +103,4 @@ fn default() -> Self {
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
 impl_zeroable!(crate::bindings::MemoryRegionOps);
+impl_zeroable!(crate::bindings::MemTxAttrs);
diff --git a/rust/wrapper.h b/rust/wrapper.h
index a9bc67af0d5f..54839ce0f510 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -62,3 +62,4 @@ typedef enum memory_order {
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
+#include "exec/memattrs.h"
-- 
2.34.1


