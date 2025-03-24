Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D564CC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 07:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twbvZ-0008Gd-8v; Mon, 24 Mar 2025 03:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1twbvW-0008G9-05
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:08:50 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1twbvT-0008Ii-Hv
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742800128; x=1774336128;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RSPvGIZxsfM4bA/IY36Wq0EbC6TmhSvPF08yfS2Nt4k=;
 b=oCgY3wbDoNG85tEQf19EozkDsvlF1sQ6+BaWNlkHcAPaT1HXcUc5wONq
 7F2OMwUZLZSDa/tajoCmBC7sKVp8UBLRAE2G3S/D55J7Ke81xTWEMT5+/
 CahnvSQgsU5V49CB+8XOqUNoWrwvVkz8OoncYkoGbPfMaf5y0dR4yJB7P
 wQOuaCaZ4XsA+ksjskyeI9b160YrIBOm17kJHgA9suoiEt8//+T8NMOk3
 kAce0V75ORXhJ/YKh63u2lP+XiX6kr15fSZTbuRi3rCZpSOdnQ/isSLJA
 p5MxeuHSvW3wh+Ig519YYO5lzIgcl13InLfkejPSxe2GHQTD88F8jUmj+ A==;
X-CSE-ConnectionGUID: Kh6vU1fCRL60onHUco7K/g==
X-CSE-MsgGUID: wS/RfJwBQI6Nqs9UM0+AWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="31588466"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; d="scan'208";a="31588466"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 00:08:47 -0700
X-CSE-ConnectionGUID: h7j1ukYCQSqoT6dryF50Bw==
X-CSE-MsgGUID: 6xu+B54JQaiEpUbobTY1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; d="scan'208";a="123944393"
Received: from emr.sh.intel.com ([10.112.229.56])
 by fmviesa007.fm.intel.com with ESMTP; 24 Mar 2025 00:08:44 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/3] target/i386: Call KVM_CAP_PMU_CAPABILITY iotcl to
 enable/disable PMU
Date: Mon, 24 Mar 2025 12:37:11 +0000
Message-Id: <20250324123712.34096-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
References: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

After introducing mediated vPMU, mediated vPMU must be enabled by
explicitly calling KVM_CAP_PMU_CAPABILITY to enable. Thus call
KVM_CAP_PMU_CAPABILITY to enable/disable PMU base on user configuration.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 target/i386/kvm/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f41e190fb8..d3e6984844 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2051,8 +2051,25 @@ full:
     abort();
 }
 
+static bool pmu_cap_set = false;
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
+    KVMState *s = kvm_state;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+
+    if (!pmu_cap_set && kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY)) {
+        int r = kvm_vm_enable_cap(s, KVM_CAP_PMU_CAPABILITY, 0,
+                                  KVM_PMU_CAP_DISABLE & !x86_cpu->enable_pmu);
+        if (r < 0) {
+            error_report("kvm: Failed to %s pmu cap: %s",
+                         x86_cpu->enable_pmu ? "enable" : "disable",
+                         strerror(-r));
+            return r;
+        }
+
+        pmu_cap_set = true;
+    }
+
     return 0;
 }
 
-- 
2.40.1


