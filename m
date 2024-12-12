Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B257E7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 03:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLZpC-00061s-S7; Wed, 11 Dec 2024 22:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1tLZpB-00060C-0F
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:25:13 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1tLZp7-0002G1-7e
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733973909; x=1765509909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GLCRNHfklif14YZfFPd8l3g1BDbCi9VJi69RCLiwMqk=;
 b=AYa0bFYWUo1Ux1HUWdkyCSpynEgUdkOlD9W0NHm3HKfOeEkfywpq1njf
 EetuX+ugQ+JDSzd17SQAU1Qi3SjNHO7yPQTay/VJeVF8oK8eOi6k7S3Tb
 Jm87zStRe0Wxd6GaKOAgTsRWKRzelMS+/XpTMR8E13OI+tSwS8OFQxtlB
 HmLi32HufYUQncUAaGVuq+rMqVg7sliM9po2VpYZO0U7Yfsc/t0BMY0qS
 J9Bd8iokNkGtnNJOEkx9xHuwJKV+pdm3/O46CiJ7sSuRlZozbg85iaJ7e
 SHIdH8esHlOljqXEmrK+2neRyjDSrme8zCU2pY3M7z3Rij4LEkIJlBiEO A==;
X-CSE-ConnectionGUID: eJf44DZFQq+VVrDE1ZrOoA==
X-CSE-MsgGUID: CSWlqC0NS2mwAUfifrY/qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="45053237"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="45053237"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:25:06 -0800
X-CSE-ConnectionGUID: Dhxs3Hq1RQKSCK2qH1yG7w==
X-CSE-MsgGUID: rB0F80/pSSytv/L1/kcNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="96293296"
Received: from litbin-desktop.sh.intel.com ([10.239.156.93])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:24:59 -0800
From: Binbin Wu <binbin.wu@linux.intel.com>
To: pbonzini@redhat.com,
	xiaoyao.li@intel.com,
	qemu-devel@nongnu.org
Cc: seanjc@google.com, michael.roth@amd.com, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org,
 binbin.wu@linux.intel.com
Subject: [PATCH] i386/kvm: Set return value after handling KVM_EXIT_HYPERCALL
Date: Thu, 12 Dec 2024 11:26:28 +0800
Message-ID: <20241212032628.475976-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Userspace should set the ret field of hypercall after handling
KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.

Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
otherwise, TDX guest boot could fail.
A matching QEMU tree including this patch is here:
https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value

Previously, the issue was not triggered because no one would modify the ret
value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
value could be modified.
---
 target/i386/kvm/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3b..4bcccb48d1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
 
 static int kvm_handle_hypercall(struct kvm_run *run)
 {
+    int ret = -EINVAL;
+
     if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
-        return kvm_handle_hc_map_gpa_range(run);
+        ret = kvm_handle_hc_map_gpa_range(run);
+
+    run->hypercall.ret = ret;
 
-    return -EINVAL;
+    return ret;
 }
 
 #define VMX_INVALID_GUEST_STATE 0x80000021

base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7
-- 
2.46.0


