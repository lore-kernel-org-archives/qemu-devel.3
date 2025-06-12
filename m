Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D132AC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPiEW-0005Mn-GZ; Thu, 12 Jun 2025 09:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uPiER-0005LQ-Ty
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:44:40 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uPiEP-0000og-Ng
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749735877; x=1781271877;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n3YvyYwqdlI8cLdKSwV1RnMfVu09BAcB8TUPZVUs/J8=;
 b=KUlHLBI7Qa6EXE1/Y3EO5/h6vBi04TEz8+rvzf72IHUVYs7IQm/Lb9gL
 6JLs7jafei8DflCqtXUaHgteyP6bWv/J1Id2x9UWpJRFGGhA13B4nofU8
 aXSWQUstByH2fpMUPro/r17WPuCoPJqXFkBmdG65cizrx9u3AHg7zQRR8
 phSRWSgDhxtnfz39y0zGSItBGYu/zL1vwgl15QvUev9u3PybDLbFGvDl3
 wiJE5H00JVagCWAoDVa8sZaWQagdpWDFN0YJOE7ips2lbo0Q8ZaCcWgx9
 S91xsUwfce0I0Uz9DRsdxid+xpuOS+sj36AQWsrZ8FgPl2+TXw3hn5Dji w==;
X-CSE-ConnectionGUID: XG5vk66nSqyRbK01bLFdNA==
X-CSE-MsgGUID: sajucKG+TeKwVu2QgXhxsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52062787"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="52062787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 06:44:32 -0700
X-CSE-ConnectionGUID: fmZgCLHhSomVx5CayMvWfg==
X-CSE-MsgGUID: KA+wyFJSQ0q16BOFnn+eTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="147410247"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 06:44:31 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org
Subject: [PATCH] i386/tdx: Error and exit when named cpu model is requested
Date: Thu, 12 Jun 2025 09:38:01 -0400
Message-ID: <20250612133801.2238342-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, it gets below error when requesting any named cpu model with
"-cpu" to boot a TDX VM:

  qemu-system-x86_64: KVM_TDX_INIT_VM failed: Invalid argument

It misleads people to think it's the bug of KVM or QEMU. It is just that
current QEMU doesn't support named cpu model for TDX.

To support named cpu models for TDX guest, there are opens to be
finalized and needs a mount of additional work.

For now, explicitly check the case when named cpu model is requested.
Error report a hint and exit.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 820ca3614e27..2b52de9d71bc 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -739,8 +739,14 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
 
 static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
 {
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     X86CPU *x86cpu = X86_CPU(cpu);
 
+    if (xcc->model) {
+        error_report("Named cpu model is not supported for TDX yet!");
+        exit(1);
+    }
+
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
 
     /* invtsc is fixed1 for TD guest */

base-commit: d9ce74873a6a5a7c504379857461e4ae64fcf0cd
-- 
2.43.0


