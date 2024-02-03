Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F69C48297
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWC9X-0006DT-AS; Sat, 03 Feb 2024 04:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9V-0006D6-J9
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:33 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9T-0001VN-4i
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706951851; x=1738487851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=An89nTsf2RBLksmwt0+NzzeKNYWSam6kADPQj32WHLQ=;
 b=LmUrUZYhtyoLCsOtp8BYfUXtC9pxfMLnRwKi69QP0H7dEGCsxjz+b1Bv
 9LTdJJfAcbX5t4DY+u6cb/CQlPLUWP1ti/HXqgkpOtgn0UW1Cc3MZW6qv
 fhpKe6b/ttC8aTeeqMY6+smuLZYpkecNc91+aOYciQcpUGazICYreqixK
 k3Bs48WPGP+8PX41pSNpT/ZzHaa9fTf07O6SLG9YXMIQpgTv4h7WbPiDJ
 EpZXu5hhWzGIvIzMQN+6/1/ZV7ctC4ynXV2J///Sv3imvhl+VLxhGod+I
 8Hf3ljrM9LEBF6eNkhWPCJB7UJXqEfQ0qJWFLMqYglQpKiLniCzUKM4za A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="216352"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="216352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; d="scan'208";a="31378978"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2024 01:17:26 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 1/6] target/i386: Add support for save/load of ACPI thermal MSRs
Date: Sat,  3 Feb 2024 17:30:49 +0800
Message-Id: <20240203093054.412135-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
References: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

The CPUID_ACPI (CPUID.0x01.edx[bit 22]) feature bit has been
introduced as the TCG feature. Currently, based on KVM's ACPI emulation,
add related ACPI support in QEMU.

From SDM [1], ACPI feature means:

"The ACPI flag (bit 22) of the CPUID feature flags indicates the
presence of the IA32_THERM_STATUS, IA32_THERM_INTERRUPT,
IA32_CLOCK_MODULATION MSRs, and the xAPIC thermal LVT entry."

With the emulation of ACPI in KVM, add the support for save/load of ACPI
thermal MSRs: MSR_IA32_THERM_CONTROL, MSR_IA32_THERM_INTERRUPT and
MSR_IA32_THERM_STATUS.

[1]: SDM, vol. 3B, section 15.8.4.1, Detection of Software Controlled
     Clock Modulation Extension.

Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h     |  9 +++++++++
 target/i386/kvm/kvm.c | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b98f..e453b3f010e2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -526,6 +526,10 @@ typedef enum X86Seg {
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
 
+#define MSR_IA32_THERM_CONTROL          0x0000019a
+#define MSR_IA32_THERM_INTERRUPT        0x0000019b
+#define MSR_IA32_THERM_STATUS           0x0000019c
+
 #define MSR_IA32_VMX_BASIC              0x00000480
 #define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
 #define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
@@ -1758,6 +1762,11 @@ typedef struct CPUArchState {
     uint64_t msr_lbr_depth;
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
 
+    /* Per-VCPU thermal MSRs */
+    uint64_t therm_control;
+    uint64_t therm_interrupt;
+    uint64_t therm_status;
+
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76a66246eb72..3bf57b35bfcd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -138,6 +138,7 @@ static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
 static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
+static bool has_msr_therm;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2455,6 +2456,11 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_PKRS:
                 has_msr_pkrs = true;
                 break;
+            case MSR_IA32_THERM_CONTROL:
+            case MSR_IA32_THERM_INTERRUPT:
+            case MSR_IA32_THERM_STATUS:
+                has_msr_therm = true;
+                break;
             }
         }
     }
@@ -3302,6 +3308,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
+    if (has_msr_therm) {
+        kvm_msr_entry_add(cpu, MSR_IA32_THERM_CONTROL, env->therm_control);
+        kvm_msr_entry_add(cpu, MSR_IA32_THERM_INTERRUPT, env->therm_interrupt);
+        kvm_msr_entry_add(cpu, MSR_IA32_THERM_STATUS, env->therm_status);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -3774,6 +3785,11 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
         env->tsc_valid = !runstate_is_running();
     }
+    if (has_msr_therm) {
+        kvm_msr_entry_add(cpu, MSR_IA32_THERM_CONTROL, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_THERM_INTERRUPT, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_THERM_STATUS, 0);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4255,6 +4271,15 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_IA32_THERM_CONTROL:
+            env->therm_control = msrs[i].data;
+            break;
+        case MSR_IA32_THERM_INTERRUPT:
+            env->therm_interrupt = msrs[i].data;
+            break;
+        case MSR_IA32_THERM_STATUS:
+            env->therm_status = msrs[i].data;
+            break;
         }
     }
 
-- 
2.34.1


