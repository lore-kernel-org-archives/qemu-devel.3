Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4B3F34C65
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKYL-0007i6-99; Mon, 13 Apr 2026 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXz-0007I8-1n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:54:07 -0400
Received: from p-west2-cluster1-host4-snip4-10.eps.apple.com ([57.103.68.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXu-0005e3-MV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:54:00 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 A0426180034A; Mon, 13 Apr 2026 16:53:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099237; x=1778691237;
 bh=M6AkUUrPcxLOfhXzaNmZevrpR2eORr3l/18/Pdjn4vI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OgLZx6IPu5x4SSSqvMQ1E5Du4H3PPhn+U1J/OqTruzTCFeOGa4RFgRWYTxZCpTdLFVDw2etRTgEWlvXCqYgSGYZEVoVa1INu7vqhVTRHWD+Cr6KxwPRlxUyCv8UzgZUzjvlKM8tcqJTf5AM89YdjKDSPYQZUiZZxHwjtfeTHAts+mvelmqhMIiNzSLSVByG+5aS+Dj0cDlqRQk1n7lR39HsxwX41gRO/jYaFAen+NrZS0YVzFrZTDjqCvxACybyeta0X3xY6E2ujlaDfLgl8NjQ+rvtTrkoQM7d8T5uyN6pPsumsYnUebBiIHmYZqXUohGUDfsnKvPRNWuQiCwtmaA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 BD38E1800194; Mon, 13 Apr 2026 16:53:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v11 15/15] whpx: i386: fix CPUID[1:EDX].APIC reporting
Date: Mon, 13 Apr 2026 18:52:17 +0200
Message-ID: <20260413165217.47105-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413165217.47105-1-mohamed@unpredictable.fr>
References: <20260413165217.47105-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PaMtK1GHS8JZ0iZKr6Stx4zKr--eHmql
X-Proofpoint-ORIG-GUID: PaMtK1GHS8JZ0iZKr6Stx4zKr--eHmql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX3nS9x2FJOIM+
 P+X/cl10PVZixRY+pd4yPdLPxti3eH6Rwp1Nh4u5m9K72pgs5LkhpEUSfVM4rKNxV2/9APZvE0R
 ZPsNBjel/GzJZS51UFBZGXyA9LFYsqzD6QcwjldW5RHb2nOY7E8t0JfXxmFnZDH7SVKaeAsa0am
 m4NV9InzePzTWTJM+1pHVM7tghAU4XPbB0ZANxERlAVeO7JgaZVK/hM8NxOyMBbisIeH+FKEJQ2
 zo7P1yQxYdcBhdk9sBoKzp8kGfvNQxb4n6olERydFhbk1hWigUaoc/7aerrYj2aW3ng3FTJ3yJZ
 Ja3EbiDkPMn+UyN1EcW0xAdiH/9YpFCA+jBrju/bOFlznQCUNVpWc/e8uCkPTM=
X-Authority-Info-Out: v=2.4 cv=fZqgCkQF c=1 sm=1 tr=0 ts=69dd1fa5
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ljJ9V6m273jqBh-Cp98A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=856
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0
 clxscore=1030 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.68.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hyper-V always has CPUID[1:EDX].APIC set, even when the APIC isn't enabled yet.

Work around this by also using the APICBASE trap for kernel-irqchip=on.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-common.h |  1 -
 target/i386/whpx/whpx-all.c  | 34 ++++++++---------
 target/i386/whpx/whpx-apic.c | 71 ++++++++++++++++++++++++++++++++++--
 3 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 3406c20fec..79710e2fb3 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -8,7 +8,6 @@ struct AccelCPUState {
     bool interruptable;
     bool ready_for_pic_interrupt;
     uint64_t tpr;
-    uint64_t apic_base;
     bool interruption_pending;
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8cd81fffee..9ce73261c2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -139,7 +139,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
 #endif
-    WHvX64RegisterApicBase,
     /* WHvX64RegisterPat, */
     WHvX64RegisterSysenterCs,
     WHvX64RegisterSysenterEip,
@@ -401,7 +400,6 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     r86 = !(env->cr[0] & CR0_PE_MASK);
 
     vcpu->tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
-    vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
     idx = 0;
 
@@ -519,9 +517,6 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
 
-        assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
-        vcxt.values[idx++].Reg64 = vcpu->apic_base;
-
         /* WHvX64RegisterPat - Skipped */
 
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
@@ -556,6 +551,12 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
                      hr);
     }
+
+    if (level >= WHPX_LEVEL_FULL_STATE) {
+        WHV_REGISTER_VALUE apic_base = {};
+        apic_base.Reg64 = cpu_get_apic_base(X86_CPU(cpu)->apic_state);
+        whpx_set_reg(cpu, WHvX64RegisterApicBase, apic_base);
+    }
 }
 
 static int whpx_get_tsc(CPUState *cpu)
@@ -647,7 +648,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     struct whpx_register_set vcxt;
-    uint64_t tpr, apic_base;
+    uint64_t tpr;
     HRESULT hr;
     int idx;
     int idx_next;
@@ -779,13 +780,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->kernelgsbase = vcxt.values[idx++].Reg64;
 #endif
 
-    assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
-    apic_base = vcxt.values[idx++].Reg64;
-    if (apic_base != vcpu->apic_base) {
-        vcpu->apic_base = apic_base;
-        cpu_set_apic_base(x86_cpu->apic_state, vcpu->apic_base);
-    }
-
     /* WHvX64RegisterPat - Skipped */
 
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
@@ -1997,8 +1991,7 @@ int whpx_vcpu_run(CPUState *cpu)
                 val = X86_CPU(cpu)->env.apic_bus_freq;
             }
 
-            if (!whpx_irqchip_in_kernel() &&
-                vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
@@ -2164,6 +2157,13 @@ int whpx_vcpu_run(CPUState *cpu)
                 } else {
                     reg_values[2].Reg32 &= CPUID_EXT_X2APIC;
                 }
+
+                /* CPUID[1:EDX].APIC is dynamic */
+                if (env->features[FEAT_1_EDX] & CPUID_APIC) {
+                    reg_values[3].Reg32 |= CPUID_APIC;
+                } else {
+                    reg_values[3].Reg32 &= ~CPUID_APIC;
+                }
             }
 
             /* Dynamic depending on XCR0 and XSS, so query DefaultResult */
@@ -2725,9 +2725,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.X64MsrExitBitmap.UnhandledMsrs = 1;
-    if (!whpx_irqchip_in_kernel()) {
-        prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
-    }
+    prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index f26ecaf6e8..65629ca45f 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -90,9 +90,70 @@ static void whpx_get_apic_state(APICCommonState *s,
     apic_next_timer(s, s->initial_count_load_time);
 }
 
-static int whpx_apic_set_base(APICCommonState *s, uint64_t val)
+static int apic_set_base_check(APICCommonState *s, uint64_t val)
 {
-    s->apicbase = val;
+    /* Enable x2apic when x2apic is not supported by CPU */
+    if (!cpu_has_x2apic_feature(&s->cpu->env) &&
+        val & MSR_IA32_APICBASE_EXTD) {
+        return -1;
+    }
+
+    /*
+     * Transition into invalid state
+     * (s->apicbase & MSR_IA32_APICBASE_ENABLE == 0) &&
+     * (s->apicbase & MSR_IA32_APICBASE_EXTD) == 1
+     */
+    if (!(val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from disabled mode to x2APIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from x2APIC to xAPIC */
+    if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        !(val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int apic_set_base(APICCommonState *s, uint64_t val)
+{
+    if (apic_set_base_check(s, val) < 0) {
+        return -1;
+    }
+
+    s->apicbase = (val & MSR_IA32_APICBASE_BASE) |
+        (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
+    if (!(val & MSR_IA32_APICBASE_ENABLE)) {
+        s->apicbase &= ~MSR_IA32_APICBASE_ENABLE;
+        cpu_clear_apic_feature(&s->cpu->env);
+    }
+
+    /* Transition from disabled mode to xAPIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_ENABLE)) {
+        s->apicbase |= MSR_IA32_APICBASE_ENABLE;
+        cpu_set_apic_feature(&s->cpu->env);
+    }
+
+    /* Transition from xAPIC to x2APIC */
+    if (cpu_has_x2apic_feature(&s->cpu->env) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        s->apicbase |= MSR_IA32_APICBASE_EXTD;
+    }
+
     return 0;
 }
 
@@ -235,6 +296,10 @@ static void whpx_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps whpx_apic_io_ops = {
     .read = whpx_apic_mem_read,
     .write = whpx_apic_mem_write,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -262,7 +327,7 @@ static void whpx_apic_class_init(ObjectClass *klass, const void *data)
 
     k->realize = whpx_apic_realize;
     k->reset = whpx_apic_reset;
-    k->set_base = whpx_apic_set_base;
+    k->set_base = apic_set_base;
     k->set_tpr = whpx_apic_set_tpr;
     k->get_tpr = whpx_apic_get_tpr;
     k->post_load = whpx_apic_post_load;
-- 
2.50.1 (Apple Git-155)


