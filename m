Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B76EC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqo-0005Mw-4o; Mon, 17 Mar 2025 10:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpq-0004wo-ND; Mon, 17 Mar 2025 10:53:09 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpd-00061l-5T; Mon, 17 Mar 2025 10:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223165; x=1773759165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4TIyXTGeVfXPKVICs8tufgXSV/mNTG13yPnR3wwuCn8=;
 b=TWoUuZ7TQz9P7HSybMMgT/xPa3aaTPh370U3zYcusWGEIEGmxS/s0ZoF
 GWqQ4CBm7ZZXziy7qomp8RhsfVEe3RD5t0LdeMTs2dmwWblEhoGkToG8B
 v/qA665DbM/nabi+fdbdvDI+nId8hphyuCBmPD5G0dyj+XL8ebMJ1+8M/
 Sf8WTh+jLI7yXLPTlE2a+snOPVjvwbAsufbwlvHlYBM5yaYa328co3xLM
 6bMytoaygWwPK4gWHLhnIy7J6UcKyDaPbM/EJH6wY3aVQq9PN8hP3hSN1
 9CkN3nq8k2eeMgQZszUq3g9AVAM0fZZRAEuNwhK7Lsnmjd/8djNUJ7LHU A==;
X-CSE-ConnectionGUID: NFOrYWv4RF+eoEFNNyQ4YA==
X-CSE-MsgGUID: fHONNYVfRkqIoMA5NbaAkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694596"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:32 -0700
X-CSE-ConnectionGUID: zxRuR8LMQzudoOrcMmYy/g==
X-CSE-MsgGUID: lKB02fK7Q22/VpzaZw2Uvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988504"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:31 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/17] rust/vmstate: Use ident instead of expr to parse vmsd
 in vmstate_struct macro
Date: Mon, 17 Mar 2025 23:12:23 +0800
Message-Id: <20250317151236.536673-5-zhao1.liu@intel.com>
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

When specify an array field in vmstate_struct macro, there will be an
error:

> local ambiguity when calling macro `vmstate_struct`: multiple parsing
> options: built-in NTs expr ('vmsd') or 1 other option.

This is because "expr" can't recognize the "vmsd" field correctly, so
that it gets confused with the previous array field.

To fix the above issue, use "ident" for "vmsd" field, and explicitly
refer to it in the macro.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/src/device_class.rs | 2 +-
 rust/qemu-api/src/vmstate.rs           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 0b2076ddaa0f..e43a5d6cd063 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -72,7 +72,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     post_load: Some(pl011_post_load),
     fields: vmstate_fields! {
         vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
+        vmstate_struct!(PL011State, regs, VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
     },
     subsections: vmstate_subsections! {
         VMSTATE_PL011_CLOCK
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 94efbd8bb735..3f95d4825149 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -435,7 +435,7 @@ macro_rules! vmstate_unused {
 #[doc(alias = "VMSTATE_STRUCT")]
 #[macro_export]
 macro_rules! vmstate_struct {
-    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
+    ($struct_name:ty, $field_name:ident $(, [0 .. $num:ident $(* $factor:expr)?])?, $vmsd:ident, $type:ty $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -447,7 +447,7 @@ macro_rules! vmstate_struct {
             },
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-            vmsd: $vmsd,
+            vmsd: &$vmsd,
             ..$crate::zeroable::Zeroable::ZERO $(
                 .with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
-- 
2.34.1


