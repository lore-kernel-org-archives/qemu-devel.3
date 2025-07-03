Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC5C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9zV-0002T1-NA; Wed, 02 Jul 2025 22:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zS-0002P0-RM
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:47:58 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zR-0007uj-3S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510876; x=1783046876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aggi/VVoEsa3JDXqyqBaYdGUcSP9MkQM0hUW7deY3Vo=;
 b=Q+CSYR9wXb1yw7V2SdjMKaejXj0GGK444v1Do9DI4+MPSL8TDDXAswXW
 9zb1EBtJTgtoJ9SqHrdFVeyzkxA/05Vrbp5PmmhQ6ffhhFQy8bO8vU3J7
 Z6JY+MtQtwgUyNriLCthNZ6WNybrW2W/+UV0c4KoOuIuMyZs+wt2QioeO
 AsPBEebtv79/CKAurJQan73qmIgsu7ZzpOtba3lVEnf41asQmviE/pBmt
 Wz86ohM6Mlw/ANe06iIFX+2yR5eYdUnsYojrBmUg20QIwyQbSRv43k57I
 zVdxzwcHbxy7I4dEoANc9spdmm43fjZ9pOSC1BiEH4SNAXgLuzH4K6lq3 g==;
X-CSE-ConnectionGUID: PipyiUgpQDCsjHkFSpNEqw==
X-CSE-MsgGUID: n3An80AWS3ydR4gZtxOHjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57499450"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="57499450"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:47:54 -0700
X-CSE-ConnectionGUID: TVVSVLO8T1C99mG6z91B4A==
X-CSE-MsgGUID: wFNQ01H+RPa0RYwA0bEPUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153880358"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa007.fm.intel.com with ESMTP; 02 Jul 2025 19:47:53 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 1/4] i386/tdx: Remove enumeration of GetQuote in
 tdx_handle_get_tdvmcall_info()
Date: Thu,  3 Jul 2025 10:40:17 +0800
Message-ID: <20250703024021.3559286-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703024021.3559286-1-xiaoyao.li@intel.com>
References: <20250703024021.3559286-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

GHCI is finalized with the <GetQuote> being one of the base VMCALLs, and
not enuemrated via <GetTdVmCallInfo>.

Adjust tdx_handle_get_tdvmcall_info() to match with GHCI.

Opportunistically fix the wrong indentation and explicitly set the
ret to TDG_VP_VMCALL_SUCCESS (in case KVM leaves unexpected value).

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 6 ++++--
 target/i386/kvm/tdx.h | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e809e4b2dfa2..8c661c3ecfdb 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1259,13 +1259,15 @@ out_free:
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->tdx.get_tdvmcall_info.leaf != 1) {
-	return;
+        return;
     }
 
-    run->tdx.get_tdvmcall_info.r11 = TDG_VP_VMCALL_SUBFUNC_GET_QUOTE;
+    run->tdx.get_tdvmcall_info.r11 = 0;
     run->tdx.get_tdvmcall_info.r12 = 0;
     run->tdx.get_tdvmcall_info.r13 = 0;
     run->tdx.get_tdvmcall_info.r14 = 0;
+
+    run->tdx.get_tdvmcall_info.ret = TDG_VP_VMCALL_SUCCESS;
 }
 
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 35a09c19c521..d439078a8761 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -32,8 +32,6 @@ typedef struct TdxGuestClass {
 #define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
 #define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
 
-#define TDG_VP_VMCALL_SUBFUNC_GET_QUOTE 0x0000000000000001ULL
-
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
-- 
2.43.0


