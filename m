Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658FBCCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stg3U-00029M-W2; Thu, 26 Sep 2024 00:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1stg3S-00028N-RN
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:24:38 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1stg3P-0007c9-Kz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:24:37 -0400
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <gaoshiyuan@baidu.com>
Subject: [PATCH v1 1/1] x86: Add support save/load HWCR MSR
Date: Thu, 26 Sep 2024 12:08:08 +0800
Message-ID: <20240926040808.9158-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex10_2024-09-26 12:08:16:428
X-FEAS-Client-IP: 10.127.64.33
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Gao Shiyuan <gaoshiyuan@baidu.com>
From:  Gao Shiyuan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

KVM commit 191c8137a939 ("x86/kvm: Implement HWCR support")
introduced support for emulating HWCR MSR.

Add support for QEMU to save/load this MSR for migration purposes.

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
---
 target/i386/cpu.c     |  1 +
 target/i386/cpu.h     |  5 +++++
 target/i386/kvm/kvm.c | 12 ++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c0..339131a39a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7093,6 +7093,7 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
     env->a20_mask = ~0x0;
     env->smbase = 0x30000;
     env->msr_smi_count = 0;
+    env->hwcr = 0;
 
     env->idt.limit = 0xffff;
     env->gdt.limit = 0xffff;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 14edd57a37..a19b1ceda4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -539,6 +539,8 @@ typedef enum X86Seg {
 
 #define MSR_AMD64_TSC_RATIO_DEFAULT     0x100000000ULL
 
+#define MSR_K7_HWCR                     0xc0010015
+
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
 #define MSR_IA32_XFD                    0x000001c4
@@ -1859,6 +1861,9 @@ typedef struct CPUArchState {
     uint64_t msr_lbr_depth;
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
 
+    /* Hardware Configuration MSR */
+    uint64_t hwcr;
+
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ada581c5d6..215c13eb13 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -145,6 +145,7 @@ static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
 static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
+static bool has_msr_hwcr;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2554,6 +2555,8 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_PKRS:
                 has_msr_pkrs = true;
                 break;
+            case MSR_K7_HWCR:
+                has_msr_hwcr = true;
             }
         }
     }
@@ -3824,6 +3827,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
+    if (has_msr_hwcr) {
+        kvm_msr_entry_add(cpu, MSR_K7_HWCR, env->hwcr);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4308,6 +4314,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
         env->tsc_valid = !runstate_is_running();
     }
+    if (has_msr_hwcr) {
+        kvm_msr_entry_add(cpu, MSR_K7_HWCR, 0);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4827,6 +4836,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_K7_HWCR:
+            env->hwcr = msrs[i].data;
+            break;
         }
     }
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 39f8294f27..2db83acafa 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1543,6 +1543,25 @@ static const VMStateDescription vmstate_msr_xfd = {
     }
 };
 
+static bool msr_hwcr_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->hwcr != 0;
+}
+
+static const VMStateDescription vmstate_msr_hwcr = {
+    .name = "cpu/msr_hwcr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = msr_hwcr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.hwcr, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_X86_64
 static bool intel_fred_msrs_needed(void *opaque)
 {
@@ -1773,6 +1792,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_intel_sgx,
         &vmstate_pdptrs,
         &vmstate_msr_xfd,
+        &vmstate_msr_hwcr,
 #ifdef TARGET_X86_64
         &vmstate_msr_fred,
         &vmstate_amx_xtile,
-- 
2.34.1


