Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13074F34C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ8u-0005jU-Or; Mon, 13 Apr 2026 11:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8r-0005cs-4C
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:24:01 -0400
Received: from qs-2005i-snip4-4.eps.apple.com ([57.103.86.215]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8n-0000XI-33
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:24:00 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 A43AF18000A4; Mon, 13 Apr 2026 15:23:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776093835; x=1778685835;
 bh=M6AkUUrPcxLOfhXzaNmZevrpR2eORr3l/18/Pdjn4vI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g75zPbFX9Uvgk1RCyqoRQGzzd7WpkrEsb6FBVcpcD2lM3E8MjLQs1ba5EngMQC50k+j4rL+hRsOUyHZcrQckuGtCIrG6cRwODaBrjyod27Ugi7GlITtDYp/xO6+trRv3KK9JhLNUJ05hhbay4HLjwRQB1u6Gf/DNozBz60FNMx/X27RSrSJAffIxtWUuriNbGS2f+We7NMsjWsBHIuhCzfjMFOK9UzPjtpbMjDmGfu1PegL/us550QsYOmyCjK6LheMB669VkW2nTyJuymXO2ZwHLInBemNMYxR2ZJB2/NAwmyolDiWJpi4B64+TvBXnl6tOmrqPYgMWdpVMzyum4w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 61BB618001CB; Mon, 13 Apr 2026 15:23:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v10 14/14] whpx: i386: fix CPUID[1:EDX].APIC reporting
Date: Mon, 13 Apr 2026 17:23:26 +0200
Message-ID: <20260413152326.63738-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413152326.63738-1-mohamed@unpredictable.fr>
References: <20260413152326.63738-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OiZfWjie1kUd0v-0ycLxZjDwKG-_b6iz
X-Proofpoint-GUID: OiZfWjie1kUd0v-0ycLxZjDwKG-_b6iz
X-Authority-Info-Out: v=2.4 cv=QKdlhwLL c=1 sm=1 tr=0 ts=69dd0a89
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ljJ9V6m273jqBh-Cp98A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX91lA5Jj8GUiS
 Lhslujwaa4G3uuzmrF17qtjeT8sVFzEQdo9Hqpgm15W2/oy3vGlUuetkVqT4XGrP/5MME1ydRJ+
 KTjtR4itBHAv6PnPUOez3ELNAB3ixmIailNhJO+2dL2GM7xB0B2A8k+NiIZveI+fAhrIsUHMfT5
 +Dts1DqdyBj9eq7l0n6zFtubJujTnBj8toW+sLWX2QgJFHmO1OuqEPGfrZLIBRipm3GqRsQ4hz5
 kdDOSaNvogNBF0Ld6cedmE2O0nYt/aiAI+/vdCTH0JDqVajhSUPZiw1BgRuMqAMNi/79U4cko+K
 Oq8aFQqHc7F7CVtv9yRr9yj6qn0+3Fq9/Hoxjdoui3kKiT81XZOAxQdzvZ0xVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=856
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0
 bulkscore=0 clxscore=1030 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130151
Received-SPF: pass client-ip=57.103.86.215;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


