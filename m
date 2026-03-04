Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AA9EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqlQ-0005dm-Mn; Wed, 04 Mar 2026 13:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxql6-0005T0-LT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:45 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkw-0004eH-4A
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648135; x=1804184135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nqn9+/IeRnwRhn8vdFZLmIj8U3Mq5+pWQSK7f2G+5Z4=;
 b=U/NaUJGrIB6avnUwWnhQ17QZK4NT3frZotnII5Q4pP/6VkQDKYCZoEfk
 bjXkNEwoFgKYEswjoQFkEFx7kmtQ+4gjHIaDAiC0N4x1zT5sJ+WNEhj2I
 d09Ye9xAmVQOUqfiYrmLgqd39609MdYbzsyEdgv8p5Pv1M/KGdQVEvmZX
 QYOJZv1ATZto6oW9lJyOP2GiGvG1O0BNk2mbeip/9kyoQetHI7ZNfn1kk
 pBTsn6ATwzs24rB11BufhlhR7uFIdsPrNNGrVZYBvah01bT7JXT+d5fgJ
 YlzCK1TTMGOz4hSOzbKr+JMuWCfW9GPUm1cxJLlk+etyNMjkDvqND4LgB Q==;
X-CSE-ConnectionGUID: ebYMsFALTSaXHrEffwyEpg==
X-CSE-MsgGUID: VMvQN8k3RzeAV4FOgqIlnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909392"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909392"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:24 -0800
X-CSE-ConnectionGUID: 1/HGIhLtRyuq3BW4KwY8DA==
X-CSE-MsgGUID: yWizD7/3QUyE4Fp3mytiCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542851"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:23 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
Date: Wed,  4 Mar 2026 10:07:10 -0800
Message-ID: <20260304180713.360471-12-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Similar to lbr-fmt, target/i386 does not support multi-bit CPU
properties, so the PEBS record format cannot be exposed as a
user-visible CPU feature.

Add a pebs-fmt option to allow users to specify the PEBS format via the
command line.  Since the PEBS state is part of the vmstate, this option
is considered migratable.

We do not support PEBS record format 0.  Although it is a valid format
on some very old CPUs, it is unlikely to be used in practice.  This
allows pebs-fmt=0 to be used to explicitly disable PEBS in the case of
migratable=off.

If PEBS is not enabled, mark it as unavailable in IA32_MISC_ENABLE and
clear the PEBS-related bits in IA32_PERF_CAPABILITIES.

If migratable=on on PEBS capable host and pmu is enabled:
- PEBS is disabled if pebs-fmt is not specified or pebs-fmt=0.
- PEBS is enabled if pebs-fmt is set to the same value as the host.

When migratable=off, the behavior is similar, except that omitting
the pebs-fmt option does not disable PEBS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- If DS is not available, make this option invalid.
- If pebs_fmt is 0, mark PEBS unavailable.
- Move MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL code from [patch v2 11/11] to
  this patch for tighter logic.
- Add option usage to commit message.

V2: New patch.
---
 target/i386/cpu.c         | 23 ++++++++++++++++++++++-
 target/i386/cpu.h         |  7 +++++++
 target/i386/kvm/kvm-cpu.c |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d5e00b41fb04..2e1dea65d708 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9170,6 +9170,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
         env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
     }
 
+    if (!(env->features[FEAT_1_EDX] & CPUID_DTS) ||
+	!(env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_FORMAT)) {
+        /* Mark PEBS unavailable and clear all PEBS related bits. */
+        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL;
+        env->features[FEAT_PERF_CAPABILITIES] &= ~0x34fc0ull;
+    }
+
     memset(env->dr, 0, sizeof(env->dr));
     env->dr[6] = DR6_FIXED_1;
     env->dr[7] = DR7_FIXED_1;
@@ -9784,10 +9791,17 @@ static bool x86_cpu_apply_lbr_pebs_fmt(X86CPU *cpu, uint64_t host_perf_cap,
         shift = PERF_CAP_LBR_FMT_SHIFT;
         name = "lbr";
     } else {
-        return false;
+        mask = PERF_CAP_PEBS_FMT_MASK;
+        shift = PERF_CAP_PEBS_FMT_SHIFT;
+        name = "pebs";
     }
 
     if (user_req != -1) {
+        if (!is_lbr_fmt && !(env->features[FEAT_1_EDX] & CPUID_DTS)) {
+            error_setg(errp, "vPMU: %s is unsupported without Debug Store", name);
+            return false;
+        }
+
         env->features[FEAT_PERF_CAPABILITIES] &= ~(mask << shift);
         env->features[FEAT_PERF_CAPABILITIES] |= (user_req << shift);
     }
@@ -9825,6 +9839,11 @@ static int x86_cpu_pmu_realize(X86CPU *cpu, Error **errp)
         return -EINVAL;
     }
 
+    if (!x86_cpu_apply_lbr_pebs_fmt(cpu, host_perf_cap,
+                                    cpu->pebs_fmt, false, errp)) {
+        return -EINVAL;
+    }
+
     return 0;
 }
 
@@ -10291,6 +10310,7 @@ static void x86_cpu_initfn(Object *obj)
 
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
+    object_property_add_alias(obj, "pebs_fmt", obj, "pebs-fmt");
 
     if (xcc->model) {
         x86_cpu_load_model(cpu, xcc->model);
@@ -10462,6 +10482,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT_MASK),
+    DEFINE_PROP_UINT64_CHECKMASK("pebs-fmt", X86CPU, pebs_fmt, PERF_CAP_PEBS_FMT_MASK),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_NOTIFY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a064bf8ab17e..6a9820c4041a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -422,6 +422,10 @@ typedef enum X86Seg {
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT_MASK           0x3f
 #define PERF_CAP_LBR_FMT_SHIFT          0x0
+#define PERF_CAP_PEBS_FMT_MASK          0xf
+#define PERF_CAP_PEBS_FMT_SHIFT         0x8
+#define PERF_CAP_PEBS_FORMAT            (PERF_CAP_PEBS_FMT_MASK << \
+                                         PERF_CAP_PEBS_FMT_SHIFT)
 #define PERF_CAP_FULL_WRITE             (1U << 13)
 #define PERF_CAP_PEBS_BASELINE          (1U << 14)
 
@@ -2410,6 +2414,9 @@ struct ArchCPU {
      */
     uint64_t lbr_fmt;
 
+    /* PEBS_FMT bits in IA32_PERF_CAPABILITIES MSR. */
+    uint64_t pebs_fmt;
+
     /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
      * disabled by default to avoid breaking migration between QEMU with
      * different LMCE configurations.
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 1d0047d037c7..60bf3899852a 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -231,6 +231,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
     }
 
     cpu->lbr_fmt = -1;
+    cpu->pebs_fmt = -1;
 
     kvm_cpu_xsave_init();
 }
-- 
2.53.0


