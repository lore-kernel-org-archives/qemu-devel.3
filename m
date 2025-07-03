Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B176C8303C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9zi-0002c0-8O; Wed, 02 Jul 2025 22:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zg-0002bf-PA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:48:12 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zW-0007uj-Bm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510881; x=1783046881;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jGc1SEhOx3aErmclLmDyukz5nk+L1TqYMmTJmPp+//I=;
 b=KxqFXme3y9mNUn37ySE+oJR9UlbOKwtXWGOf4vvWUGXGzBW2gYqi/gpo
 R4bCpnxDSzxp6/XfMCYaScLD25BcTKsOnid/OeufSfScdkm+Lo5JdnOH5
 sswNgxBPyy7ryRXyV916Dh5UT44WJ0X0zmBm2yFgREuqcLO1AKxWyj3uL
 /c8m/N2VrK4gOrY9QDzLrf2GZfgDnlZYz3r+aR0wV5QT2dD3FR48xmjbg
 OdyvrpjGpLZp+ZZsR29IJy1VcXn1l58RHlIgUHpeE1gZNZfHiB3o7wOiV
 48AphlwmBj/ZJp1L6+/5Rx3iqhPtlFFxxkZm2Rk6g81v+0MJc1FIt4QIB A==;
X-CSE-ConnectionGUID: 9L6hRRtsTmGQkqtYsMtYng==
X-CSE-MsgGUID: RxIMz+LgRSOse/coqXfmVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57499455"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="57499455"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:47:56 -0700
X-CSE-ConnectionGUID: 2oX2/fo4TPyaeaY7InC+rA==
X-CSE-MsgGUID: 6uCgOZjYSi2Vkp4IFjFmlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153880369"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa007.fm.intel.com with ESMTP; 02 Jul 2025 19:47:56 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 3/4] i386/tdx: Set value of <GetTdVmCallInfo> based on
 capabilities of both KVM and QEMU
Date: Thu,  3 Jul 2025 10:40:19 +0800
Message-ID: <20250703024021.3559286-4-xiaoyao.li@intel.com>
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

KVM reports the supported TDVMCALL sub leafs in TDX capabilities.

one for kernel-supported
    TDVMCALLs (userspace can set those blindly) and one for user-supported
    TDVMCALLs (userspace can set those if it knows how to handle them)

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 8c661c3ecfdb..10dfb80d22e2 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1256,14 +1256,21 @@ out_free:
     g_free(task);
 }
 
+#define SUPPORTED_TDVMCALLINFO_1_R11    (0)
+#define SUPPORTED_TDVMCALLINFO_1_R12    (0)
+
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->tdx.get_tdvmcall_info.leaf != 1) {
         return;
     }
 
-    run->tdx.get_tdvmcall_info.r11 = 0;
-    run->tdx.get_tdvmcall_info.r12 = 0;
+    run->tdx.get_tdvmcall_info.r11 = (tdx_caps->user_tdvmcallinfo_1_r11 &
+                                      SUPPORTED_TDVMCALLINFO_1_R11) |
+                                      tdx_caps->kernel_tdvmcallinfo_1_r11;
+    run->tdx.get_tdvmcall_info.r12 = (tdx_caps->user_tdvmcallinfo_1_r12 &
+                                      SUPPORTED_TDVMCALLINFO_1_R12) |
+                                      tdx_caps->kernel_tdvmcallinfo_1_r12;
     run->tdx.get_tdvmcall_info.r13 = 0;
     run->tdx.get_tdvmcall_info.r14 = 0;
 
-- 
2.43.0


