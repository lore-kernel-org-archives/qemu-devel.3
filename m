Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A6C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 20:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Vfu-0004XQ-LY; Tue, 21 May 2024 16:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongsheng.x.zhang@intel.com>)
 id 1s9Vfs-0004Wz-G6
 for qemu-devel@nongnu.org; Tue, 21 May 2024 16:01:28 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongsheng.x.zhang@intel.com>)
 id 1s9Vfn-0004AV-Jd
 for qemu-devel@nongnu.org; Tue, 21 May 2024 16:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716321684; x=1747857684;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5hRHTKyOiFHWSga18cyb+QOYsVtMlm2MGPirkcEPe8Q=;
 b=m2IkHSV5FEM9hd5rpz2ABDFnGMLZKFop5ShgTCL1NNdZP01VFt9avxy8
 YR3GcITUSUCw84lCk1taiWLujSj3yb3hpId5C63YGvJs2/pIwGZlW/i/A
 JR7f5DKD8EQ6UiOlqTCAPv4PAWwz+AOylpM9TEWfJYhzr/5SrTCkh0mvi
 bZXewiZKkmeHkDuxpw/2ATgNJuSSeEH59wb9r6FO8Yd4JWh1s86iP/ZBF
 u3DvokwkZTsq34UC7Wix1cF8MTS3zDj1q3CmsR0vn+I+nObpFlSpXDeJq
 DOm1qJ2dD1Wf0DJMgw6OJjxw1u2bJbT1LWfOtAUw5dSGr+x4QOWkyjZJm g==;
X-CSE-ConnectionGUID: 8EbRbke2RlOA83OwlGo2Ug==
X-CSE-MsgGUID: T63qj/QIQz2Kp34W5wXdcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12381643"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="12381643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 13:01:19 -0700
X-CSE-ConnectionGUID: 8cahG3s7QyKNXJpFU2yU3w==
X-CSE-MsgGUID: aKvHKE+uTB2ybJMEup5L9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="37531778"
Received: from gnr-001.sh.intel.com ([10.112.230.245])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 13:01:17 -0700
From: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
To: qemu-devel@nongnu.org
Cc: rkagan@amazon.de,
	pbonzini@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH] Hyperv: Correct kvm_hv_handle_exit return value
Date: Wed, 22 May 2024 04:01:14 +0800
Message-ID: <20240521200114.11588-1-dongsheng.x.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongsheng.x.zhang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: donsheng <dongsheng.x.zhang@intel.com>

This bug fix addresses the incorrect return value of kvm_hv_handle_exit for
KVM_EXIT_HYPERV_SYNIC, which should be EXCP_INTERRUPT.

Handling of KVM_EXIT_HYPERV_SYNIC in QEMU needs to be synchronous.
This means that async_synic_update should run in the current QEMU vCPU
thread before returning to KVM, returning EXCP_INTERRUPT to guarantee this.
Returning 0 can cause async_synic_update to run asynchronously.

One problem (kvm-unit-tests's hyperv_synic test fails with timeout error)
caused by this bug:

When a guest VM writes to the HV_X64_MSR_SCONTROL MSR to enable Hyper-V SynIC,
a VM exit is triggered and processed by the kvm_hv_handle_exit function of the
QEMU vCPU. This function then calls the async_synic_update function to set
synic->sctl_enabled to true. A true value of synic->sctl_enabled is required
before creating SINT routes using the hyperv_sint_route_new() function.

If kvm_hv_handle_exit returns 0 for KVM_EXIT_HYPERV_SYNIC, the current QEMU
vCPU thread may return to KVM and enter the guest VM before running
async_synic_update. In such case, the hyperv_synic test’s subsequent call to
synic_ctl(HV_TEST_DEV_SINT_ROUTE_CREATE, ...) immediately after writing to
HV_X64_MSR_SCONTROL can cause QEMU’s hyperv_sint_route_new() function to return
prematurely (because synic->sctl_enabled is false).

If the SINT route is not created successfully, the SINT interrupt will not be
fired, resulting in a timeout error in the hyperv_synic test.

Fixes: 267e071bd6d6 (“hyperv: make overlay pages for SynIC”)

Suggested-by: Chao Gao <chao.gao@intel.com>

Signed-off-by: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
---
 target/i386/kvm/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f2a3fe650a18..b94f12acc2c9 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -81,7 +81,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
 
-        return 0;
+        return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
         uint16_t code = exit->u.hcall.input & 0xffff;
         bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
-- 
2.43.0


