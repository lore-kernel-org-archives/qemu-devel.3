Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94D9C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mRr-0008CG-4y; Wed, 16 Sep 2026 06:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRg-00087s-G2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:54 -0400
Received: from qs-2003c-snip6-11.eps.apple.com ([2a01:b747:3006:204::21]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRa-0005E4-Kv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:49 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 E071518009F1; Wed, 16 Sep 2026 10:00:40 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-5052-7ae2-a645-d6cbbd5d202d
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISxMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpeHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552844; x=1792144844;
 bh=Vd967nqTBhrEi2kDcB3CUx3ds/jf5dl62DCQCUC6cT0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KT9NiyAsRXVGsDjQJ0q2tsp2xM4DbdSzDbrEo2G5X/bmHVJqCWFBelSrpy2Z8kvANxjXG3UOC+n9SF6L/k2iibKjbS+fek/uT6jcRNgpCtwvtsevtTjsXtKstfY7X6Ocy8Hf5XEGVnQJglZDSL9jpSeJ8a4PEwQT7GUE6H3nEW0OxE1rwSBat2O6j7XaMFZPxfA7695pWPjcsoel23suqHxxSqnjAjlslwxRERDQqg+PruUSxzfbOBE/zn0HmvTojPICMBfvHj4BYWa8pfG1pnJ0LcUoGvqLjaeCawHKvsYr0fht6Qq9xbZ3kkZ721DjrN44IYDFZXOOLwIqCU38MQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 5A5BA180010A; Wed, 16 Sep 2026 10:00:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [RFC PATCH v8 04/10] target/arm/hvf,
 whpx: wire ISV=0 emulation for data aborts
Date: Wed, 16 Sep 2026 12:00:12 +0200
Message-ID: <20260916100021.73825-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX0MwwonVxIjHU
 /tr7zs1mZEGwdf99wTMHXFwj8+QhkwKVzCLCMNgRmVmKPleNY9/ImWwwY3T8V24MsaxWAlFYAGE
 dJkOTX/FZ+5N9ymwHyuq8dDreaCY8sJFxfOV44hUdgnF9XrzpmaSAAAajEgxYNZaVwdMFe5AgYT
 jUfwXR8wLSpCrB1E74iWDSvrA0m+XP2L2CbmVU6bRH5DK9e5tFCSu2K10F2aFvzySiSquU/fwuW
 bH0DyDg7mcZhhL8jDNcjrtRlYMjMXdBZqc8tbQCUb4upXbr//2ceAtk9GWVid/3UvZN8073BZGF
 9Ugkyi8ldGK+yWdbRrhN7oAQ/W9Ig+29WjWOmgOmT3IogMkInoCBOAVwAQt1P8=
X-Authority-Info-Out: v=2.4 cv=TaybdBQh c=1 sm=1 tr=0 ts=6aaa68ca
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=1-PEhprmmTEWANFiw-YA:9
X-Proofpoint-GUID: UQojr-6vxKyqjNhtfji93Z-vJNrclCBq
X-Proofpoint-ORIG-GUID: UQojr-6vxKyqjNhtfji93Z-vJNrclCBq
X-JNJ: AAAAAAABW0TIoUwbnb2/Y4BHNHHZJwYj3XHB1AE9bA1WaBE3owluuHG9gpFhgRkiDwqGwytzG34sg6AStCblyQk9S7MEF4yQsVgesR3jqFD/XqAuhnfOEj2MC90zSU0n5YfHh09voJ0C8MVODVhRLF0UofpVxP0WyD8Wym801CA6mXa9sHYZ5orlLQBQrc+y+OXVeQN5vkeSLBXaU/lLOSKumpSoo/GxHdc7LL4gogdQuTOgQ7LYk3NHmCHlJEqE+dLbCknyKYz0AO6hc3T5OJ9Sh07miUk+miCRdwiVUFtj+oQa6qgh+CJH45pLCL5mIumwH8ngjKdcBmGwfIuxdkmc0ODP1ziirHGXy9DyBDXrx7s5m/QeHJiAAZRlz+TLXdWzO2AhWZN6+jF4mDawxxyv6lYhVupQkdhUTgRWA/4ZHGicQTAfHqqj0BQIcTGTZTk2L+N4bDyQJHpUrlWgpka+E1LcgJKsmc6hlct+MBJubU475mdrnNRvKcpBuoSrbwJ+8SlQ3lZAP6l6E78ZwbxpyhzeL3wGAY8c5UbdZ+hs3C/8nuAB+HjisbFTyumtOs5Bs+ZCa6F/95zzCea8gf5jiVof5fH3QUIca1bxIJg+1NzAiEvMUZs7B1sI4o5Lb29++nBj6FkbbOpo/1B+ojO/21yQtygBgDj2/2WwqosjaghPUPNf3r8fVYgpDAAZZGEXYqRMArobfT3ZwTSgPOleqba9+Wn3YToOzFzqht0cJT0bvMeaA34/ZH6KwzXTJJMi4QN7RQAXbH5BvpUjstDhlFdmzmVFJGW7WvoGJ1Jq1IPlLLlsNooSyrJZZNfSV1nmUq9QiZB1P1VeKAQWs7EZel/4nj+U/BzlwvU=
Received-SPF: pass client-ip=2a01:b747:3006:204::21;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Lucas Amaral <lucaaamaral@gmail.com>

When a data abort with ISV=0 occurs during MMIO emulation, the
syndrome register does not carry the access size or target register.
Previously this hit an assert(isv) and killed the VM.

Replace the assert with instruction fetch + decode + emulate using the
shared library in target/arm/emulate/.  The faulting instruction is read
from guest memory via cpu_memory_rw_debug(), decoded by the decodetree-
generated decoder, and emulated against the vCPU register file.

Both HVF (macOS) and WHPX (Windows Hyper-V) use the same pattern:
  1. cpu_synchronize_state() to flush hypervisor registers
  2. Fetch 4-byte instruction at env->pc
  3. arm_emul_insn(env, insn)
  4. On success, advance PC past the emulated instruction

If the instruction is unhandled or a memory error occurs, a synchronous
external abort is injected into the guest via syn_data_abort_no_iss()
with fnv=1 and fsc=0x10, matching the syndrome that KVM uses in
kvm_inject_arm_sea().  The guest kernel's fault handler then reports
the error through its normal data abort path.

WHPX adds a whpx_inject_data_abort() helper and adjusts the
whpx_handle_mmio() return convention so the caller skips PC advancement
when an exception has been injected.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/hvf/hvf.c       | 46 ++++++++++++++++++++++++++--
 target/arm/whpx/whpx-all.c | 61 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b00a7e1a84..a087e920e9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -34,6 +34,7 @@
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
+#include "emulate/arm_emulate.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/trace.h"
@@ -2441,10 +2442,49 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         assert(!s1ptw);
 
         /*
-         * TODO: ISV will be 0 for SIMD or SVE accesses.
-         * Inject the exception into the guest.
+         * ISV=0: syndrome doesn't carry access size/register info.
+         * Fetch and emulate via target/arm/emulate/.
          */
-        assert(isv);
+        if (!isv) {
+            ARMCPU *arm_cpu = ARM_CPU(cpu);
+            CPUARMState *env = &arm_cpu->env;
+            uint32_t insn;
+            ArmEmulResult r;
+
+            cpu_synchronize_state(cpu);
+
+            if (cpu_memory_rw_debug(cpu, env->pc,
+                                    (uint8_t *)&insn, 4, false) != 0) {
+                bool same_el = arm_current_el(env) == 1;
+                uint32_t esr = syn_data_abort_no_iss(same_el,
+                    1, 0, 0, 0, iswrite, 0x10);
+
+                error_report("HVF: cannot read insn at pc=0x%" PRIx64,
+                             (uint64_t)env->pc);
+                env->exception.vaddress = excp->virtual_address;
+                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
+                break;
+            }
+
+            r = arm_emul_insn(env, insn);
+            if (r == ARM_EMUL_UNHANDLED || r == ARM_EMUL_ERR_MEM) {
+                bool same_el = arm_current_el(env) == 1;
+                uint32_t esr = syn_data_abort_no_iss(same_el,
+                    1, 0, 0, 0, iswrite, 0x10);
+
+                error_report("HVF: ISV=0 %s insn 0x%08x at "
+                             "pc=0x%" PRIx64 ", injecting data abort",
+                             r == ARM_EMUL_UNHANDLED ? "unhandled"
+                                                     : "memory error",
+                             insn, (uint64_t)env->pc);
+                env->exception.vaddress = excp->virtual_address;
+                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
+                break;
+            }
+
+            advance_pc = true;
+            break;
+        }
 
         /*
          * Emulate MMIO.
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d106400686..c916df35a7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -29,6 +29,7 @@
 #include "syndrome.h"
 #include "target/arm/cpregs.h"
 #include "internals.h"
+#include "emulate/arm_emulate.h"
 
 #include "system/whpx-internal.h"
 #include "system/whpx-accel-ops.h"
@@ -350,6 +351,27 @@ static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
     whpx_set_reg(cpu, reg, reg_val);
 }
 
+/*
+ * Inject a synchronous external abort (data abort) into the guest.
+ * Used when ISV=0 instruction emulation fails.  Matches the syndrome
+ * that KVM uses in kvm_inject_arm_sea().
+ */
+static void whpx_inject_data_abort(CPUState *cpu, bool iswrite)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    bool same_el = arm_current_el(env) == 1;
+    uint32_t esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, iswrite, 0x10);
+
+    cpu->exception_index = EXCP_DATA_ABORT;
+    env->exception.target_el = 1;
+    env->exception.syndrome = esr;
+
+    bql_lock();
+    arm_cpu_do_interrupt(cpu);
+    bql_unlock();
+}
+
 static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
@@ -365,7 +387,40 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 
     assert(syn_get_ec(syndrome) == EC_DATAABORT);
     assert(!cm);
-    assert(isv);
+
+    /*
+     * ISV=0: syndrome doesn't carry access size/register info.
+     * Fetch and decode the faulting instruction via the emulation library.
+     */
+    if (!isv) {
+        ARMCPU *arm_cpu = ARM_CPU(cpu);
+        CPUARMState *env = &arm_cpu->env;
+        uint32_t insn;
+        ArmEmulResult r;
+
+        cpu_synchronize_state(cpu);
+
+        if (cpu_memory_rw_debug(cpu, env->pc,
+                                (uint8_t *)&insn, 4, false) != 0) {
+            error_report("WHPX: cannot read insn at pc=0x%" PRIx64,
+                         (uint64_t)env->pc);
+            whpx_inject_data_abort(cpu, iswrite);
+            return 1;
+        }
+
+        r = arm_emul_insn(env, insn);
+        if (r == ARM_EMUL_UNHANDLED || r == ARM_EMUL_ERR_MEM) {
+            error_report("WHPX: ISV=0 %s insn 0x%08x at "
+                         "pc=0x%" PRIx64 ", injecting data abort",
+                         r == ARM_EMUL_UNHANDLED ? "unhandled"
+                                                 : "memory error",
+                         insn, (uint64_t)env->pc);
+            whpx_inject_data_abort(cpu, iswrite);
+            return 1;
+        }
+
+        return 0;
+    }
 
     if (iswrite) {
         val = whpx_get_gp_reg(cpu, srt);
@@ -451,6 +506,10 @@ int whpx_vcpu_run(CPUState *cpu)
             }
 
             ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx.MemoryAccess);
+            if (ret > 0) {
+                advance_pc = false;
+                ret = 0;
+            }
             break;
         case WHvRunVpExitReasonCanceled:
             cpu->exception_index = EXCP_INTERRUPT;
-- 
2.54.0 (Apple Git-157)


