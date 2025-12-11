Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52236D3E793
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZTW-0001xI-3O; Thu, 11 Dec 2025 00:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZTU-0001sv-DL
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:44:24 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZTS-0001ci-Hn
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765431863; x=1796967863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0PXAqnx+JyOHSOJTK7j77gOmPTGVLtFdsCoGZuQvp8=;
 b=BcPGqumFAIML4nopnGAqZZsv5/mgqR4rJ3snOUablxmIjEpai+J2H4+2
 0Mr8e6lnBTtCeJJlUh5nP5vzvd5G5FYoutce+x9FzZP2d/O9cw57vyoac
 n+9aF1v1+xld8RawRzTL41cpn9CgQoJHnHE5tueodDqFLcgBwKWJpkC4U
 3Q6aN9xRGU0T+UaWL0GZac49GoAOx8sMsfiRA6Qo8NsVf0D9m4HcwXg7Z
 K93GB8gwB36pkNOPQn9pveHlPBR1jKLrnO6rpCobekD9nnY+HwmW84AhC
 QdXPWXqUbVayDjcGgE7WgSMJBz/J32WWFM1WkCE3gyM+EgJ0lQjXWZVDD Q==;
X-CSE-ConnectionGUID: 0+OQqHm0TFC4bPMP0rrH0A==
X-CSE-MsgGUID: evE1vRvDRJada4Lp9jwPKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66409940"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66409940"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 21:44:22 -0800
X-CSE-ConnectionGUID: cj8B2o9eQB+/BzxTAyCSjg==
X-CSE-MsgGUID: aBTCTJaRSy2pG/QtWwlXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227366179"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 21:44:18 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v5 15/22] i386/kvm: Add save/restore support for
 KVM_REG_GUEST_SSP
Date: Thu, 11 Dec 2025 14:07:54 +0800
Message-Id: <20251211060801.3600039-16-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211060801.3600039-1-zhao1.liu@intel.com>
References: <20251211060801.3600039-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

CET provides a new architectural register, shadow stack pointer (SSP),
which cannot be directly encoded as a source, destination or memory
operand in instructions. But Intel VMCS & VMCB provide fields to
save/load guest & host's ssp.

It's necessary to save & restore Guest's ssp before & after migration.
To support this, KVM implements Guest's SSP as a special KVM internal
register - KVM_REG_GUEST_SSP, and allows QEMU to save & load it via
KVM_GET_ONE_REG/KVM_SET_ONE_REG.

Cache KVM_REG_GUEST_SSP in X86CPUState.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h     |  3 ++-
 target/i386/kvm/kvm.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 37cc218bf3a5..458775daaa3e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1979,7 +1979,7 @@ typedef struct CPUArchState {
     uint64_t fred_config;
 #endif
 
-    /* CET MSRs */
+    /* CET MSRs and register */
     uint64_t u_cet;
     uint64_t s_cet;
     uint64_t pl0_ssp; /* also used for FRED */
@@ -1989,6 +1989,7 @@ typedef struct CPUArchState {
 #ifdef TARGET_X86_64
     uint64_t int_ssp_table;
 #endif
+    uint64_t guest_ssp;
 
     uint64_t tsc_adjust;
     uint64_t tsc_deadline;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4eb58ca19d79..1ebe20f7fb57 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4292,6 +4292,35 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
     return kvm_buf_set_msrs(cpu);
 }
 
+static int kvm_put_kvm_regs(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int ret;
+
+    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+        ret = kvm_set_one_reg(CPU(cpu), KVM_X86_REG_KVM(KVM_REG_GUEST_SSP),
+                              &env->guest_ssp);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
+static int kvm_get_kvm_regs(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int ret;
+
+    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+        ret = kvm_get_one_reg(CPU(cpu), KVM_X86_REG_KVM(KVM_REG_GUEST_SSP),
+                              &env->guest_ssp);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
 
 static int kvm_get_xsave(X86CPU *cpu)
 {
@@ -5445,6 +5474,11 @@ int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
         error_setg_errno(errp, -ret, "Failed to set MSRs");
         return ret;
     }
+    ret = kvm_put_kvm_regs(x86_cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set KVM type registers");
+        return ret;
+    }
     ret = kvm_put_vcpu_events(x86_cpu, level);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to set vCPU events");
@@ -5517,6 +5551,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         error_setg_errno(errp, -ret, "Failed to get MSRs");
         goto out;
     }
+    ret = kvm_get_kvm_regs(cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get KVM type registers");
+        goto out;
+    }
     ret = kvm_get_apic(cpu);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to get APIC");
-- 
2.34.1


