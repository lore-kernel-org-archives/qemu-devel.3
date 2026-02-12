Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1E2EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvl-0006uA-IV; Thu, 12 Feb 2026 09:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvU-00066p-Sw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvS-0006H9-Gc
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=819F/zJSma8yNTF8JsRD8z0SEcfHEtbcMUCeyum8ozo=;
 b=bfbqkSc/9xrmFSSykAIi9biTnFgMBv1nt7H6dsEOyhLD4U9jCsSSCHWMj6sscN5TTBQaLN
 lcazT1xwce740v2JAcH+FmWvozDd5DsTb2ROgEzF76msAPDPHGXFCUnAZqsrxyiPVsXhDg
 WqtW9aFEKnN4t52GcZFYSiAbJQnrwAU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-yRNGo4JwPgGwaZtbRHkyEg-1; Thu, 12 Feb 2026 09:44:03 -0500
X-MC-Unique: yRNGo4JwPgGwaZtbRHkyEg-1
X-Mimecast-MFC-AGG-ID: yRNGo4JwPgGwaZtbRHkyEg_1770907442
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836e35292cso2661415e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907441; x=1771512241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=819F/zJSma8yNTF8JsRD8z0SEcfHEtbcMUCeyum8ozo=;
 b=KM1rGL9nBhbV32ukjLR5peTAVAIsMkYbBXX0y3Z4GOty4uKpLnmhmroGk7bA2LdBnm
 jERo56sxpLlXKiAPj+dSwKiy0jQ8c9L7ZDvUV6zf/3HvAWC/TB6kGOsG4zjgYopJJEws
 d/IK05X835A6alVJKO8u0bu+gc934eZ1Us4QEAg8ZpcgGTQPn6mWG+7sXsR1yavzB5fO
 B+oyGqgPrYpU1mo4tmBVZ+vim2hrVFtzR1cCAwlZplk9n23UqUd+whpDFqX6M0/WwUb2
 2QqTBNKZry3cwGb8fsOh9GLjwRGSgY0F3hTiyu2uLcRsNaa94sCko5p2xAw8Hx7tSZje
 9zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907441; x=1771512241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=819F/zJSma8yNTF8JsRD8z0SEcfHEtbcMUCeyum8ozo=;
 b=aRqpL4zrJMS2cPiAN76m77clu88Upa4V4JMt9iC1NY9626VjO5E5lFF2eDYSVHOOVb
 7mhokFtXzcChhtCIAlcx6P30nzyUAUEpv2bMUVc06ZhLXRWjpdzAQ18Y7xAx1jA3uAVa
 bE7c7eneQKlfYhHg+giiXnoCMhbtVw4+ib97vMZJtMSNWZPdYnJ+F0PSlcRrP0HzFEKw
 rFieh5jUFD3KBj4opgVFgqZziVqSWreoX6qAOEsxeE00sgGof6ztP8HVJPWzTArVSflf
 Xd85IN2tbo2wa3V5ayvwWYsGpmLdpVWreDwErpHze6xihLbyZJ5FO2dsO62vTYXcOzNO
 NkLA==
X-Gm-Message-State: AOJu0Yys3FObmH9IVuhSX+BvecwIyupgYPvmSjVIgC4iD7bbNW29k6Kf
 d/nP8BKVfb5nDH9gzIGxLt3hcdWsNO3IGnQ/DelXguF9XokKahRFITuuT2ggQ78VaogkbugXoze
 r9kpHLJNA0ZjEwhzSzZoxuQf3oJtO4BLi+twe8kky3VaOHTVfhkyZN/IfKY1IaWlvqATTbgyTLs
 7vAGIea5jcWUfMhYk0nNM3zuF439O5+LB2Z97h7upL
X-Gm-Gg: AZuq6aJ6TywkhtIaz1nq8pScQL6V1ZWU05jBY+JkktQ9XFXA/qBx+AfEny5F9xspj6m
 Xypk/1i+5/1JpE7u/5Ml+7Y3Ed02ubL2HyMPUFEGCbVrSEIu1I/FEqPGyYiG/M1i2NLeEocfveB
 vhVyNO4KlWaj4Wnq8sv8O2fVLOSnP67mRKU6ztAQWN7tJN45NNhDY49rePy8csQ3QaZpB6V1fQ6
 tMs9YrgFhri78GqAII4w2hGN5kb95BdTRZnSV3dPO/8LBKDygL249ZDEvKehXfZqNZjDgA7Uqda
 rasdGcg7bKrL6jwWJvrtOoRAJUp5AAJzSjyqfm1xH17Ecudvpo4YUCTv2nhVLf0Jrsd8Xivqa/b
 qbb5WRPmBqmCdVfyLumwzSCpoA7RoFchuVjOgTxw7/q4XBIsv1Gg8sObXP2nmu8Kl7VOcaWjZfz
 MDR4NzDjCPWiLnNVV8WY2Ob3FtxiMpMp84AVTgVdkpJldP5MVQOl4=
X-Received: by 2002:a05:600c:a09:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4836570d0e7mr36033025e9.20.1770907441173; 
 Thu, 12 Feb 2026 06:44:01 -0800 (PST)
X-Received: by 2002:a05:600c:a09:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4836570d0e7mr36032495e9.20.1770907440600; 
 Thu, 12 Feb 2026 06:44:00 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d8334a8sm204725265e9.12.2026.02.12.06.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 33/41] target/i386/kvm: reset AMD PMU registers during VM reset
Date: Thu, 12 Feb 2026 15:42:35 +0100
Message-ID: <20260212144244.22579-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dongli Zhang <dongli.zhang@oracle.com>

QEMU uses the kvm_get_msrs() function to save Intel PMU registers from KVM
and kvm_put_msrs() to restore them to KVM. However, there is no support for
AMD PMU registers. Currently, pmu_version and num_pmu_gp_counters are
initialized based on cpuid(0xa), which does not apply to AMD processors.
For AMD CPUs, prior to PerfMonV2, the number of general-purpose registers
is determined based on the CPU version.

To address this issue, we need to add support for AMD PMU registers.
Without this support, the following problems can arise:

1. If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
running "perf top", the PMU registers are not disabled properly.

2. Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
does not handle AMD PMU registers, causing some PMU events to remain
enabled in KVM.

3. The KVM kvm_pmc_speculative_in_use() function consistently returns true,
preventing the reclamation of these events. Consequently, the
kvm_pmc->perf_event remains active.

4. After a reboot, the VM kernel may report the following error:

[    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)

5. In the worst case, the active kvm_pmc->perf_event may inject unknown
NMIs randomly into the VM kernel:

[...] Uhhuh. NMI received for unknown reason 30 on CPU 0.

To resolve these issues, we propose resetting AMD PMU registers during the
VM reset process.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260109075508.113097-5-dongli.zhang@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  12 +++
 target/i386/kvm/kvm.c | 168 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f2be42d7f65..cf02472fc79 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -506,6 +506,14 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
+#define MSR_K7_EVNTSEL0                 0xc0010000
+#define MSR_K7_PERFCTR0                 0xc0010004
+#define MSR_F15H_PERF_CTL0              0xc0010200
+#define MSR_F15H_PERF_CTR0              0xc0010201
+
+#define AMD64_NUM_COUNTERS              4
+#define AMD64_NUM_COUNTERS_CORE         6
+
 #define MSR_MC0_CTL                     0x400
 #define MSR_MC0_STATUS                  0x401
 #define MSR_MC0_ADDR                    0x402
@@ -1737,6 +1745,10 @@ typedef struct {
 #endif
 
 #define MAX_FIXED_COUNTERS 3
+/*
+ * This formula is based on Intel's MSR. The current size also meets AMD's
+ * needs.
+ */
 #define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
 
 #define NB_OPMASK_REGS 8
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8faba7e471e..7ebb96c66f2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2095,7 +2095,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid)
+static void kvm_init_pmu_info_intel(struct kvm_cpuid2 *cpuid)
 {
     struct kvm_cpuid_entry2 *c;
 
@@ -2128,6 +2128,89 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid)
     }
 }
 
+static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
+{
+    struct kvm_cpuid_entry2 *c;
+    int64_t family;
+
+    family = object_property_get_int(OBJECT(cpu), "family", NULL);
+    if (family < 0) {
+        return;
+    }
+
+    if (family < 6) {
+        error_report("AMD performance-monitoring is supported from "
+                     "K7 and later");
+        return;
+    }
+
+    pmu_version = 1;
+    num_pmu_gp_counters = AMD64_NUM_COUNTERS;
+
+    c = cpuid_find_entry(cpuid, 0x80000001, 0);
+    if (!c) {
+        return;
+    }
+
+    if (!(c->ecx & CPUID_EXT3_PERFCORE)) {
+        return;
+    }
+
+    num_pmu_gp_counters = AMD64_NUM_COUNTERS_CORE;
+}
+
+static bool is_host_compat_vendor(CPUX86State *env)
+{
+    char host_vendor[CPUID_VENDOR_SZ + 1];
+
+    host_cpu_vendor_fms(host_vendor, NULL, NULL, NULL);
+
+    /*
+     * Intel and Zhaoxin are compatible.
+     */
+    if ((g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
+         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
+         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) &&
+        (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+        return true;
+    }
+
+    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
+           IS_AMD_CPU(env);
+}
+
+static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    /*
+     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
+     * disable the AMD PMU virtualization.
+     *
+     * Assume the user is aware of this when !cpu->enable_pmu. AMD PMU
+     * registers are not going to reset, even they are still available to
+     * guest VM.
+     */
+    if (!cpu->enable_pmu) {
+        return;
+    }
+
+    /*
+     * It is not supported to virtualize AMD PMU registers on Intel
+     * processors, nor to virtualize Intel PMU registers on AMD processors.
+     */
+    if (!is_host_compat_vendor(env)) {
+        error_report("host doesn't support requested feature: vPMU");
+        return;
+    }
+
+    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
+        kvm_init_pmu_info_intel(cpuid);
+    } else if (IS_AMD_CPU(env)) {
+        kvm_init_pmu_info_amd(cpuid, cpu);
+    }
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -2318,7 +2401,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
-    kvm_init_pmu_info(&cpuid_data.cpuid);
+    kvm_init_pmu_info(&cpuid_data.cpuid, cpu);
 
     if (x86_cpu_family(env->cpuid_version) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
@@ -4093,7 +4176,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
-        if (pmu_version > 0) {
+        if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
             if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4124,6 +4207,38 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                                   env->msr_global_ctrl);
             }
         }
+
+        if (IS_AMD_CPU(env) && pmu_version > 0) {
+            uint32_t sel_base = MSR_K7_EVNTSEL0;
+            uint32_t ctr_base = MSR_K7_PERFCTR0;
+            /*
+             * The address of the next selector or counter register is
+             * obtained by incrementing the address of the current selector
+             * or counter register by one.
+             */
+            uint32_t step = 1;
+
+            /*
+             * When PERFCORE is enabled, AMD PMU uses a separate set of
+             * addresses for the selector and counter registers.
+             * Additionally, the address of the next selector or counter
+             * register is determined by incrementing the address of the
+             * current register by two.
+             */
+            if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
+                sel_base = MSR_F15H_PERF_CTL0;
+                ctr_base = MSR_F15H_PERF_CTR0;
+                step = 2;
+            }
+
+            for (i = 0; i < num_pmu_gp_counters; i++) {
+                kvm_msr_entry_add(cpu, ctr_base + i * step,
+                                  env->msr_gp_counters[i]);
+                kvm_msr_entry_add(cpu, sel_base + i * step,
+                                  env->msr_gp_evtsel[i]);
+            }
+        }
+
         /*
          * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
          * only sync them to KVM on the first cpu
@@ -4628,7 +4743,8 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
-    if (pmu_version > 0) {
+
+    if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4644,6 +4760,35 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
+    if (IS_AMD_CPU(env) && pmu_version > 0) {
+        uint32_t sel_base = MSR_K7_EVNTSEL0;
+        uint32_t ctr_base = MSR_K7_PERFCTR0;
+        /*
+         * The address of the next selector or counter register is
+         * obtained by incrementing the address of the current selector
+         * or counter register by one.
+         */
+        uint32_t step = 1;
+
+        /*
+         * When PERFCORE is enabled, AMD PMU uses a separate set of
+         * addresses for the selector and counter registers.
+         * Additionally, the address of the next selector or counter
+         * register is determined by incrementing the address of the
+         * current register by two.
+         */
+        if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
+            sel_base = MSR_F15H_PERF_CTL0;
+            ctr_base = MSR_F15H_PERF_CTR0;
+            step = 2;
+        }
+
+        for (i = 0; i < num_pmu_gp_counters; i++) {
+            kvm_msr_entry_add(cpu, ctr_base + i * step, 0);
+            kvm_msr_entry_add(cpu, sel_base + i * step, 0);
+        }
+    }
+
     if (env->mcg_cap) {
         kvm_msr_entry_add(cpu, MSR_MCG_STATUS, 0);
         kvm_msr_entry_add(cpu, MSR_MCG_CTL, 0);
@@ -4974,6 +5119,21 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
             break;
+        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + AMD64_NUM_COUNTERS - 1:
+            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] = msrs[i].data;
+            break;
+        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + AMD64_NUM_COUNTERS - 1:
+            env->msr_gp_counters[index - MSR_K7_PERFCTR0] = msrs[i].data;
+            break;
+        case MSR_F15H_PERF_CTL0 ...
+             MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
+            index = index - MSR_F15H_PERF_CTL0;
+            if (index & 0x1) {
+                env->msr_gp_counters[index] = msrs[i].data;
+            } else {
+                env->msr_gp_evtsel[index] = msrs[i].data;
+            }
+            break;
         case HV_X64_MSR_HYPERCALL:
             env->msr_hv_hypercall = msrs[i].data;
             break;
-- 
2.52.0


