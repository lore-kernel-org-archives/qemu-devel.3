Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC63C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWHq-00005G-9L; Tue, 18 Mar 2025 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH0-0007oZ-2d; Tue, 18 Mar 2025 08:42:26 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWGv-0002wy-EP; Tue, 18 Mar 2025 08:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301738; x=1773837738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZBH+gd9fwHUKnch2bJzVxP0eRmX4fWcxXMkXBj21ULs=;
 b=FSzwm7P4d5JWAu6n4AkQ4qxlgUROlenx6M+Plxta8xRY79SdjIc6grmY
 k0s9EkoQtkDdQohGwDUI5RZ26Fir5dY4HYFRSWHMjYgCY0lcIksY5NH0c
 jqZPsPkKrF7YHJoD7UwJtf0vU2NmI4elZjsXzMpfIQeMwpM+vGsYhOhw8
 wBoc+2s+64GsiAqM5gNTL9pRwoI/2tISJ+VGO2lkoeJgxk+Tmvh2dfncU
 fzxLa/qzFizb1goaaHs6nAz+mn8y0g//3BoCAtFvVIJ60CGXFQRxr94gI
 cD42SI1osw8UIPxJSO/QnfTj8W6d0N456HALt34m7TGNMzLdf7SjQovpj g==;
X-CSE-ConnectionGUID: /O8aSk6KQAKIwXl3edzFcg==
X-CSE-MsgGUID: O7PRu10wTE+uxOvIrdYjNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824557"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824557"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:11 -0700
X-CSE-ConnectionGUID: E8MNGaqaTSilw+a4Lvx7ug==
X-CSE-MsgGUID: ompBj+i5SHirWCb9xQ5STA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980413"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:09 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 02/15] rust/vmstate: Fix num_offset in vmstate macros
Date: Tue, 18 Mar 2025 21:02:06 +0800
Message-Id: <20250318130219.1799170-3-zhao1.liu@intel.com>
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

`num_offset` is a member of `VMStateField`, and there's no need to use
"." to access this field in a `VMStateField` instance.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 6698dfe7aeb8..9533b1250fa5 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -208,7 +208,7 @@ macro_rules! vmstate_of {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             offset: $crate::offset_of!($struct_name, $field_name),
-            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            $(num_offset: $crate::offset_of!($struct_name, $num),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
             info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
@@ -440,7 +440,7 @@ macro_rules! vmstate_struct {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
-            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            $(num_offset: $crate::offset_of!($struct_name, $num),)?
             offset: {
                 $crate::assert_field_type!($struct_name, $field_name, $type);
                 $crate::offset_of!($struct_name, $field_name)
-- 
2.34.1


