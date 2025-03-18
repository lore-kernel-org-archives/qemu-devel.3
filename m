Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3F2C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS5G-00033e-9l; Tue, 18 Mar 2025 04:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4K-0002jS-BW; Tue, 18 Mar 2025 04:13:03 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4I-0001JW-3e; Tue, 18 Mar 2025 04:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285578; x=1773821578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oNTyY42WX481d5bX9cw8tiiWl2PH6jRFnI6SscTNaEc=;
 b=KOZsO38gU2psifA5Po+RfYLvduLZUocaOXq5uOhPfXIbA/NbH8RuYldX
 MdbO3UGx6bpHJxlF2QjuxRi2mEu52J7k3X3wSOWuBjA3glKoPCPiSMDaD
 5RKBt2sOo3wC05/u+XU9fuVYlVChUVWZDtT4L441ptk41iXmZBZoUgQ8+
 0BAUo5eNVuLhQgtGkidkauHw283ger+isf3U0ZkeNSIEZg/01utEz9EEL
 7Ep223TpQK1GwRGCKxxHW0XEb4mt3JB7hEpvgCaj+PJSq4z9iCJSqwsaL
 M6OsUP2RY0MaRCKIDHWzutsL+ji6HV6JYGYrNe2QLKVW/2dZRVoXfC0+T g==;
X-CSE-ConnectionGUID: +H1dYXGyRvO+ft+NT7YETA==
X-CSE-MsgGUID: 8ldR9YbqR2OWcmB6KUIMeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621579"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621579"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:54 -0700
X-CSE-ConnectionGUID: gsj8Hd5YSDuIVWmwK62PLw==
X-CSE-MsgGUID: GNF1P+x/RQ2+R3yw0i34dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363228"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/14] rust/vmstate: Fix unnecessary VMState bound of
 with_varray_flag()
Date: Tue, 18 Mar 2025 16:32:41 +0800
Message-Id: <20250318083248.1402990-8-zhao1.liu@intel.com>
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

The VMState type bound is not used in with_varray_flag().

And for vmstate_struct, Rust cannot infer the type of `num` from the
call_func_with_field(), so this causes the compiling error because it
complains "cannot satisfy `_: VMState`" in with_varray_flag().

Note Rust can infer the type in vmstate_of macro so that
with_varray_flag() can work at there. It is possible that the different
initialization ways in the two macros cause differences in Rust's
type inference.

But in fact, the VMState type bound is not used in with_varray_flag()
and vmstate_varray_flag() has already checked the VMState type, it's
safe to drop VMState bound of with_varray_flag(), which can fix the
above compiling error.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 3be3a7260fe9..792a74fdfc08 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,7 +275,7 @@ pub const fn with_pointer_flag(mut self) -> Self {
     }
 
     #[must_use]
-    pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMStateField {
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
-- 
2.34.1


