Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D77C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsO-0005Ju-Ka; Tue, 01 Apr 2025 09:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsB-0005Dt-Fh
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:51 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbrt-0006XQ-77
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514889; x=1775050889;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KiV+cWPr+Rwl5eZVdUQlQ5BkSiOOBFLbtRW8w06bOqA=;
 b=S5Mb/tNIQen8z2mcztrdk/IcF5GMHMbKeXO/mPu0a9XFTKv69m9Lorii
 CEv5gCLgQu1mxUEp5LXOvvX2gtyjxqK5dLqmJT6wFIGJWUZ0gAfNhg7+S
 H92kSvIW8EKVXuOWgOP/30bv4sLnb/dZEwD5P8TCcSfJzvfZeT9buf+/H
 ZWUHgWmmmkpvGrtAG8qb+8lUTwS/8hN1LFDP0zLLEneU/yg1jIW0Kokcl
 bzJfKCTS4/Cw+c4dHbrZXncfPiLy2pzReORxIUQ30nTZntDpostGhG535
 8zLlfCK2vsnnAbp47HD6etHfzZV3KKpjkpJXlT1Wu2AUvEoOvaOScYPct Q==;
X-CSE-ConnectionGUID: hdU5/I1oRpmRMu0cZtvZjA==
X-CSE-MsgGUID: XkF7XnIeTZOAVPhhNw2rzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433181"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:28 -0700
X-CSE-ConnectionGUID: AbtUp1fcQ4W44D+htmLvow==
X-CSE-MsgGUID: I1Iyd6GrThCknAxOiPbjXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639920"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:25 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 07/55] kvm: Introduce kvm_arch_pre_create_vcpu()
Date: Tue,  1 Apr 2025 09:01:17 -0400
Message-Id: <20250401130205.2198253-8-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
work prior to create any vcpu. This is for i386 TDX because it needs
call TDX_INIT_VM before creating any vcpu.

The specific implemnet of i386 will be added in the future patch.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v7:
- Implement stub for all the ARCHes instead of defining it with weak
  attribute; (Philippe)

Changes in v3:
- pass @errp to kvm_arch_pre_create_vcpu(); (Per Daniel)
---
 accel/kvm/kvm-all.c        | 5 +++++
 include/system/kvm.h       | 1 +
 target/arm/kvm.c           | 5 +++++
 target/i386/kvm/kvm.c      | 5 +++++
 target/loongarch/kvm/kvm.c | 4 ++++
 target/mips/kvm.c          | 5 +++++
 target/ppc/kvm.c           | 5 +++++
 target/riscv/kvm/kvm-cpu.c | 5 +++++
 target/s390x/kvm/kvm.c     | 5 +++++
 9 files changed, 40 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa397..df9840e53a35 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -540,6 +540,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
+    ret = kvm_arch_pre_create_vcpu(cpu, errp);
+    if (ret < 0) {
+        goto err;
+    }
+
     ret = kvm_create_vcpu(cpu);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a551f..d7dfa25493a2 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -374,6 +374,7 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb2349..93f1a7245b3f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1874,6 +1874,11 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b4fa35405fe1..1a4dd19e24ab 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2050,6 +2050,11 @@ full:
     abort();
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 7f63e7c8fe51..5e82dacc677b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1071,7 +1071,11 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
             env->pv_features |= BIT(KVM_FEATURE_VIRT_EXTIOI);
         }
     }
+    return 0;
+}
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
     return 0;
 }
 
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index d67b7c1a8ecb..ec53acb51a1f 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -61,6 +61,11 @@ int kvm_arch_irqchip_create(KVMState *s)
     return 0;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 992356cb7593..20fabccecd54 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -479,6 +479,11 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4ffeeaa1c953..451c00f17c2f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1389,6 +1389,11 @@ static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
     return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4d56e653ddf6..1f592733f4e2 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -404,6 +404,11 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
-- 
2.34.1


