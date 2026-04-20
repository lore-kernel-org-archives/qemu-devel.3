Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155CBF5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm7C-00005n-2i; Mon, 20 Apr 2026 06:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm7A-0008Th-9c
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:28 -0400
Received: from p-west3-cluster4-host3-snip4-10.eps.apple.com ([57.103.74.161]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm78-0000oP-6A
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:28 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 953CA1800478; Mon, 20 Apr 2026 10:44:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681865; x=1779273865;
 bh=wP73mLT6dqDsimwGfoQspMT04K7Opz+I97Zfylk4p8A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KbY2Hv5Mtc2EhyarNqc5CXsWgTp/gLHopB7IL11jL+Duoz9fZvS/9IeDx9mNBw71JQ4dZMLvANDfZYUN1Wz8OPmATlOMnW3LUnM3unbytDnGr82ssI1fs6hDlhEwWeuM6FunAf8fOCk9P3sTJWN+cvcIYxW+nv2OjbBTt41IvdXfdOyhh8eIuHuzG0hnGM1yTwn2tBLs7LAAzHwOtYyjB24x/KM7bjIv63bhIcPzHn9CuGxQ18PNIA9s/z7uG+8BO7t7AEpbXUk7W7sr2YyUQxBiI8YjSu3afDk/WWz790slLGjTaCHQiSgJ0TtWgZuZAuZTSXCuAw0ZNvs3p16Pag==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 EAC7B18000A3; Mon, 20 Apr 2026 10:44:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 36/38] whpx: i386: add feature to intercept #GP MSR accesses
Date: Mon, 20 Apr 2026 12:42:46 +0200
Message-ID: <20260420104248.86702-37-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfXx2HLrfU447RX
 Hv6+Fz5zy9Lh/GI6mr55kEI+LjYP+e+G4/9hfLAGPbyfX12CCw1vqrxvUxSPSTyg2q6Vi7rsay3
 wOJZbbBQ1yhaAaM0LIRhIC7RinwhNgekRxkMoSuIv9RNMNdarXcFej/X1ubVn3HhqbMM/pBqjMA
 IwCXM9pAOG1eTgjPFYfP5q6dY4itFoRc+EFC5HD1E9NiKW2DpgxWIPO82Gj+QqnqgvLIERgAcS6
 2cBrT8m3J6/UGXNeTr51Jha76UzNL0DHbiif7WGVqUuCWhgRK7sWeQTngCwdDmM2XoSZY6gwBPP
 H1jlDydRct/iBO4dfUVBJ5n4iXoi6+qs4iNL7cNhYbVFBjxGtZ5lF9yVUkQcI0=
X-Proofpoint-GUID: H6ayxpqCdwk7575Kt4oLT4BlwuX-egpC
X-Proofpoint-ORIG-GUID: H6ayxpqCdwk7575Kt4oLT4BlwuX-egpC
X-Authority-Info-Out: v=2.4 cv=Ef3FgfmC c=1 sm=1 tr=0 ts=69e60388
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CoAbg4nstuYx8jGKVk0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 spamscore=0
 clxscore=1030 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It turns out they're not that uncommon, so have
a feature around to log those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       |  38 +++++++++
 include/system/whpx-internal.h |   1 +
 target/i386/whpx/whpx-all.c    | 146 ++++++++++++++++++++++++++++-----
 3 files changed, 166 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 706871f138..8f28b1d617 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -537,6 +537,38 @@ static void whpx_set_unknown_msr(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_intercept_msr_gp(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->intercept_msr_gp = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->intercept_msr_gp = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->intercept_msr_gp = false;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
@@ -575,6 +607,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "ignore-unknown-msr",
         "Configure unknown MSR behavior");
+    object_class_property_add(oc, "intercept-msr-gp", "OnOffAuto",
+        NULL, whpx_set_intercept_msr_gp,
+        NULL, NULL);
+    object_class_property_set_description(oc, "intercept-msr-gp",
+        "Intercept #GP to log erroring MSR accesses.");
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -590,6 +627,7 @@ static void whpx_accel_instance_init(Object *obj)
     /* Value determined at whpx_accel_init */
     whpx->hyperv_enlightenments_enabled = false;
     whpx->ignore_unknown_msr = true;
+    whpx->intercept_msr_gp = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 0aae83bd7c..15027a7d52 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -48,6 +48,7 @@ struct whpx_state {
     bool hyperv_enlightenments_enabled;
 
     bool ignore_unknown_msr;
+    bool intercept_msr_gp;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b0692935e7..bda8c484e2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1008,6 +1008,27 @@ static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t
     return 0;
 }
 
+static int emulate_msr_instruction(CPUState *cpu,
+            const uint8_t *insn_bytes, size_t insn_len)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+    x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
+
+    whpx_get_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
+    decode_instruction_stream(env, &decode, &stream);
+
+    if (decode.cmd != X86_DECODE_CMD_RDMSR
+        && decode.cmd != X86_DECODE_CMD_WRMSR) {
+        return 1;
+    }
+
+    exec_instruction(env, &decode);
+    whpx_set_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
+    return 0;
+}
+
 static int whpx_handle_mmio(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_MEMORY_ACCESS_CONTEXT *ctx = &exit_ctx->MemoryAccess;
@@ -1022,6 +1043,45 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
     return 0;
 }
 
+static int whpx_handle_msr_from_gpf(CPUState *cpu)
+{
+    WHV_VP_EXCEPTION_CONTEXT *ctx = &cpu->accel->exit_ctx.VpException;
+    int ret;
+
+    ret = emulate_msr_instruction(cpu, ctx->InstructionBytes, ctx->InstructionByteCount);
+    if (ret == 1) {
+        /* Not an MSR instruction */
+        return 1;
+    }
+
+    return 0;
+}
+
+static void whpx_inject_back_gpf(CPUState *cpu)
+{
+    WHV_VP_EXCEPTION_CONTEXT *ctx = &cpu->accel->exit_ctx.VpException;
+    WHV_REGISTER_VALUE reg = {};
+
+    if (ctx->ExceptionInfo.SoftwareException) {
+        /* TODO */
+        warn_report("Was asked to inject software exception.");
+        return;
+    }
+
+    if (ctx->ExceptionType != EXCP0D_GPF) {
+        warn_report("Was asked to inject exception other than GPF.");
+        return;
+    }
+
+    reg.ExceptionEvent.EventPending = 1;
+    reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+    reg.ExceptionEvent.DeliverErrorCode = ctx->ExceptionInfo.ErrorCodeValid;
+    reg.ExceptionEvent.Vector = ctx->ExceptionType;
+    reg.ExceptionEvent.ErrorCode = ctx->ErrorCode;
+    reg.ExceptionEvent.ExceptionParameter = ctx->ExceptionParameter;
+    whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+}
+
 static void handle_io(CPUState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
@@ -1210,13 +1270,54 @@ static target_ulong read_cr(CPUState *cpu, int cr)
     return val.Reg64;
 }
 
+static bool whpx_simulate_rdmsr(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint32_t msr = ECX(env);
+    uint64_t val = 0;
+
+    switch (msr) {
+    default:
+        error_report("WHPX: unknown msr 0x%x", msr);
+        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+        return 1;
+        break;
+    }
+
+    RAX(env) = (uint32_t)val;
+    RDX(env) = (uint32_t)(val >> 32);
+
+    return 0;
+}
+
+static bool whpx_simulate_wrmsr(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint32_t msr = ECX(env);
+    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
+
+    switch (msr) {
+    default:
+        error_report("WHPX: unknown msr 0x%x val %llx", msr, data);
+        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+        return 1;
+        break;
+    }
+
+    return 0;
+}
+
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io,
     .is_protected_mode = is_protected_mode,
     .is_long_mode = is_long_mode,
     .is_user_mode = is_user_mode,
-    .read_cr = read_cr
+    .read_cr = read_cr,
+    .simulate_rdmsr = whpx_simulate_rdmsr,
+    .simulate_wrmsr = whpx_simulate_wrmsr
 };
 
 static void whpx_init_emu(void)
@@ -1295,6 +1396,18 @@ uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     }
 }
 
+static UINT64 whpx_get_default_exceptions(void)
+{
+    struct whpx_state *whpx = &whpx_global;
+    UINT64 intercepts = 0;
+
+    if (whpx->intercept_msr_gp) {
+        intercepts |= 1UL << WHvX64ExceptionTypeGeneralProtectionFault;
+    }
+
+    return intercepts;
+}
+
 /*
  * Controls whether we should intercept various exceptions on the guest,
  * namely breakpoint/single-step events.
@@ -1317,7 +1430,7 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.X64CpuidExit = 1;
 
-    if (exceptions != 0) {
+    if (exceptions != 0 || whpx_get_default_exceptions() != 0) {
         prop.ExtendedVmExits.ExceptionExit = 1;
     }
 
@@ -1332,7 +1445,7 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
     }
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
-    prop.ExceptionExitBitmap = exceptions;
+    prop.ExceptionExitBitmap = exceptions | whpx_get_default_exceptions();
 
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
@@ -1342,6 +1455,8 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 
     if (SUCCEEDED(hr)) {
         whpx->exception_exit_bitmap = exceptions;
+    } else {
+        error_report("WHPX: Failed to set exception exit bitmap, hr=%08lx", hr);
     }
 
     return hr;
@@ -2477,6 +2592,15 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
         case WHvRunVpExitReasonException:
+            if (vcpu->exit_ctx.VpException.ExceptionType ==
+                WHvX64ExceptionTypeGeneralProtectionFault) {
+                if (whpx_handle_msr_from_gpf(cpu)) {
+                    whpx_inject_back_gpf(cpu);
+                }
+                ret = 0;
+                break;
+            }
+
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
             if ((vcpu->exit_ctx.VpException.ExceptionType ==
@@ -2985,22 +3109,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    /* Register for MSR and CPUID exits */
-    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
-    prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.X64CpuidExit = 1;
-
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeExtendedVmExits,
-            &prop,
-            sizeof(WHV_PARTITION_PROPERTY));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to enable extended VM exits, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
-    }
-
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.X64MsrExitBitmap.UnhandledMsrs = 1;
     prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
-- 
2.50.1 (Apple Git-155)


