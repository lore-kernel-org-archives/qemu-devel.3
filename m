Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1D3C624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnZ-0000BG-Cj; Sun, 22 Feb 2026 13:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnT-0008UB-RH
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:11 -0500
Received: from qs-2007k-snip4-11.eps.apple.com ([57.103.84.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnR-0000ST-NU
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:11 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 05B501800515; Sun, 22 Feb 2026 18:03:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783388; x=1774375388;
 bh=Dk5eX2jOjF2PyRgCzPtgTVz6QNza9g8+ul+O0rRzATI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Myp6hZGl9sPpWEm246cti/+zzY+WPBlOClwk5jHSDFjvZ7+8PSsvB+qmFyuqegSSOwygNvrMgmTLGmoGrU0WXPrd0JaJBtX5n/hHssmsJCNjgyjL0ar0ZImWOZv58IU0ESvmwWYKgGUidqWcB/QUiHAQfh6EVQk16FiKmso79mIxnsir1so+e8rdryYvuO2Jae90HtsT21mvkW5LzB4fuED5wvUWdJlrZc5zEWjzEL8WDdFyIWHbG4sBEwXcIxYkD8jmFA5J8U5btIs69FcVM0cEEJ1BmlMTbmmPQVna0cMnLX1Gvv+I8zvCRJcYMuHwrC4FkQ/2vLcIEv7gsxl5Nw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 89D29180011A; Sun, 22 Feb 2026 18:03:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 10/16] whpx: i386: switch over from winhvemulation to
 target/i386/emulate
Date: Sun, 22 Feb 2026 19:02:34 +0100
Message-ID: <20260222180241.14621-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX2KX30trLnHJg
 3tU3AsYuJjUrhk7Er2t8BrCBSCBAZJGwdnRS6I3LJ5B36VmKEr4mm0uRl+Uwaxy4PMlEKhmX+xd
 0MWdsVWCFHtZPSI4PpZHN+btmKZQ12obSGcxblDMGlCXUvgHBGUUn7s0B/goIQi13CGTWOwUvmI
 nWcBe1tihCDAdtxVr2qUr2s7NJZw4ZeAbpZEUKJN7lgqqIklAgRhSV+M2q9IdWaRgua1tKt4IMW
 b4wrw1zgOleM/E5o0/kmRX6d9W1x+uHByhjwTpfQ3v7c201sSPkFvqXdR1fWQEJyG/kIBFgnsy4
 4yHIzhluCXX9tl9U1glmCoa/rGcGJT8+pO+tP8vecD4+iCfzP/67wxFMjTltas=
X-Proofpoint-ORIG-GUID: B94xUE-mEAUZyzJmLDsyOSqG-jSHie0x
X-Proofpoint-GUID: B94xUE-mEAUZyzJmLDsyOSqG-jSHie0x
X-Authority-Info-Out: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=699b44db
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=1q5U6jd5_WdO0fZ7RH8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABD2UdlTRNeGVdH2faaIxp0QYeHpVshbqfqE4XnPcruf1JjI76fIx9mKtAzKznz1SCXAgZh/2GSMd+3XFegOkGZEyrkaE8zDOOmhabynTLepSYmjIfzKAeSlIGCL+LwoeMsU61kGcmsZwtvw/JsRq0T3xmtS+nLOzTSEVG0pqDds8rqBtjFOO+TpUjdz76v/lyzJVpfNKERbl3XuErIKDAjswWEcXTZaEOiQFlc/w+pdjO1zt1ttfZvTp1Zv+TTGJzYWpuWUZLQt3yO7+tdTtPG3ZXDKh0H1cgJYLwJgpEbPHTZscDxRF6jCWyy722i1ur03oPWxrWIfmTxvi/TP0OH1ETrmbf0BCozs2HhOFFUjvGlW/4YhJEYq+u5YrKO6lcC8MR85xC6q5GA74vaXDen0Py0omCo2Nie73UloPMw9F9Gi0ZLIeVd2l+MsU66EP1v7GL4rD0uTqPxy5WJ1o8olkm1Kb+CULyVF3xm6CxpPuDVgOdT4GZhN7vLK0/bGxSd4Ax4BjAQMbfUtsH6Hf2zlzGI3+E1Lak3+2jG8pN8GWPDLnxTxeQkBuXdkE56BoGk6z3/p+6vjvmisgqPXlQuBLpvdbQrh6F+95X3vEe7TuTJV4SmEs11ddZLVYpajQDBQfw1S990sJS41uXBQD11f6+erngXgdjlIt3NoFEbNJjIujFLnftlRnUpxzidI4SaHG3uAOQqivz8KTun1QX4kigYSMIRKG+cQuw1CNhWxxrp364EtWvwwxjylclsm3wUfpxxF7brZB+RsWlRq98hd5Kc73DP8JgBdoeNPoLtuQ=
Received-SPF: pass client-ip=57.103.84.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Using the mshv backend as a base, move away from winhvemulation
to using common QEMU code used by the HVF and mshv backends.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 250 ++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 136 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cdcaebbe16..eb6076d2f4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -15,6 +15,7 @@
 #include "gdbstub/helpers.h"
 #include "qemu/accel.h"
 #include "accel/accel-ops.h"
+#include "system/memory.h"
 #include "system/whpx.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
@@ -36,8 +37,12 @@
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
 
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "emulate/x86_flags.h"
+#include "emulate/x86_mmu.h"
+
 #include <winhvplatform.h>
-#include <winhvemulation.h>
 
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 
@@ -756,158 +761,138 @@ void whpx_get_registers(CPUState *cpu)
     x86_update_hflags(env);
 }
 
-static HRESULT CALLBACK whpx_emu_ioport_callback(
-    void *ctx,
-    WHV_EMULATOR_IO_ACCESS_INFO *IoAccess)
+static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t insn_len)
 {
-    MemTxAttrs attrs = { 0 };
-    address_space_rw(&address_space_io, IoAccess->Port, attrs,
-                     &IoAccess->Data, IoAccess->AccessSize,
-                     IoAccess->Direction);
-    return S_OK;
-}
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+    x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-static HRESULT CALLBACK whpx_emu_mmio_callback(
-    void *ctx,
-    WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
-{
-    CPUState *cs = (CPUState *)ctx;
-    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+    whpx_get_registers(cpu);
+    decode_instruction_stream(env, &decode, &stream);
+    exec_instruction(env, &decode);
+    whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
 
-    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
-                     ma->Data, ma->AccessSize, ma->Direction);
-    return S_OK;
+    return 0;
 }
 
-static HRESULT CALLBACK whpx_emu_getreg_callback(
-    void *ctx,
-    const WHV_REGISTER_NAME *RegisterNames,
-    UINT32 RegisterCount,
-    WHV_REGISTER_VALUE *RegisterValues)
+static int whpx_handle_mmio(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
-    HRESULT hr;
-    struct whpx_state *whpx = &whpx_global;
-    CPUState *cpu = (CPUState *)ctx;
+    WHV_MEMORY_ACCESS_CONTEXT *ctx = &exit_ctx->MemoryAccess;
+    int ret;
 
-    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
-        whpx->partition, cpu->cpu_index,
-        RegisterNames, RegisterCount,
-        RegisterValues);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to get virtual processor registers,"
-                     " hr=%08lx", hr);
+    ret = emulate_instruction(cpu, ctx->InstructionBytes, ctx->InstructionByteCount);
+    if (ret < 0) {
+        error_report("failed to emulate mmio");
+        return -1;
     }
 
-    return hr;
+    return 0;
 }
 
-static HRESULT CALLBACK whpx_emu_setreg_callback(
-    void *ctx,
-    const WHV_REGISTER_NAME *RegisterNames,
-    UINT32 RegisterCount,
-    const WHV_REGISTER_VALUE *RegisterValues)
+static void handle_io(CPUState *env, uint16_t port, void *buffer,
+                  int direction, int size, int count)
 {
-    HRESULT hr;
-    struct whpx_state *whpx = &whpx_global;
-    CPUState *cpu = (CPUState *)ctx;
+    int i;
+    uint8_t *ptr = buffer;
 
-    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-        whpx->partition, cpu->cpu_index,
-        RegisterNames, RegisterCount,
-        RegisterValues);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set virtual processor registers,"
-                     " hr=%08lx", hr);
+    for (i = 0; i < count; i++) {
+        address_space_rw(&address_space_io, port, MEMTXATTRS_UNSPECIFIED,
+                         ptr, size,
+                         direction);
+        ptr += size;
     }
-
-    /*
-     * The emulator just successfully wrote the register state. We clear the
-     * dirty state so we avoid the double write on resume of the VP.
-     */
-    cpu->vcpu_dirty = false;
-
-    return hr;
 }
 
-static HRESULT CALLBACK whpx_emu_translate_callback(
-    void *ctx,
-    WHV_GUEST_VIRTUAL_ADDRESS Gva,
-    WHV_TRANSLATE_GVA_FLAGS TranslateFlags,
-    WHV_TRANSLATE_GVA_RESULT_CODE *TranslationResult,
-    WHV_GUEST_PHYSICAL_ADDRESS *Gpa)
+static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
-    HRESULT hr;
-    struct whpx_state *whpx = &whpx_global;
-    CPUState *cpu = (CPUState *)ctx;
-    WHV_TRANSLATE_GVA_RESULT res;
-
-    hr = whp_dispatch.WHvTranslateGva(whpx->partition, cpu->cpu_index,
-                                      Gva, TranslateFlags, &res, Gpa);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to translate GVA, hr=%08lx", hr);
-    } else {
-        *TranslationResult = res.ResultCode;
-    }
-
-    return hr;
+    WHV_REGISTER_VALUE reg;
+    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
+    reg.Reg64 = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+    whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
 
-static const WHV_EMULATOR_CALLBACKS whpx_emu_callbacks = {
-    .Size = sizeof(WHV_EMULATOR_CALLBACKS),
-    .WHvEmulatorIoPortCallback = whpx_emu_ioport_callback,
-    .WHvEmulatorMemoryCallback = whpx_emu_mmio_callback,
-    .WHvEmulatorGetVirtualProcessorRegisters = whpx_emu_getreg_callback,
-    .WHvEmulatorSetVirtualProcessorRegisters = whpx_emu_setreg_callback,
-    .WHvEmulatorTranslateGvaPage = whpx_emu_translate_callback,
-};
-
-static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
+static int whpx_handle_portio(CPUState *cpu,
+                              WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
-    HRESULT hr;
-    AccelCPUState *vcpu = cpu->accel;
-    WHV_EMULATOR_STATUS emu_status;
-
-    hr = whp_dispatch.WHvEmulatorTryMmioEmulation(
-        vcpu->emulator, cpu,
-        &vcpu->exit_ctx.VpContext, ctx,
-        &emu_status);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to parse MMIO access, hr=%08lx", hr);
-        return -1;
-    }
+    WHV_X64_IO_PORT_ACCESS_CONTEXT *ctx = &exit_ctx->IoPortAccess;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    int ret;
 
-    if (!emu_status.EmulationSuccessful) {
-        error_report("WHPX: Failed to emulate MMIO access with"
-                     " EmulatorReturnStatus: %u", emu_status.AsUINT32);
+    if (!ctx->AccessInfo.StringOp && !ctx->AccessInfo.IsWrite) {
+        uint64_t val = 0;
+        WHV_REGISTER_VALUE reg;
+
+        whpx_get_reg(cpu, WHvX64RegisterRax, &reg);
+        handle_io(cpu, ctx->PortNumber, &val, 0, ctx->AccessInfo.AccessSize, 1);
+        if (ctx->AccessInfo.AccessSize == 1) {
+            reg.Reg8 = val;
+        } else if (ctx->AccessInfo.AccessSize == 2) {
+            reg.Reg16 = val;
+        } else if (ctx->AccessInfo.AccessSize == 4) {
+            reg.Reg64 = (uint32_t)val;
+        } else {
+            reg.Reg64 = (uint64_t)val;
+        }
+        whpx_bump_rip(cpu, exit_ctx);
+        whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        return 0;
+    } else if (!ctx->AccessInfo.StringOp && ctx->AccessInfo.IsWrite) {
+        RAX(env) = ctx->Rax;
+        handle_io(cpu, ctx->PortNumber, &RAX(env), 1, ctx->AccessInfo.AccessSize, 1);
+        whpx_bump_rip(cpu, exit_ctx);
+        return 0;
+    }
+
+    ret = emulate_instruction(cpu, ctx->InstructionBytes, exit_ctx->VpContext.InstructionLength);
+    if (ret < 0) {
+        error_report("failed to emulate I/O port access");
         return -1;
     }
 
     return 0;
 }
 
-static int whpx_handle_portio(CPUState *cpu,
-                              WHV_X64_IO_PORT_ACCESS_CONTEXT *ctx)
+static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
 {
-    HRESULT hr;
-    AccelCPUState *vcpu = cpu->accel;
-    WHV_EMULATOR_STATUS emu_status;
+    vmx_write_mem(cpu, addr, data, bytes);
+}
 
-    hr = whp_dispatch.WHvEmulatorTryIoEmulation(
-        vcpu->emulator, cpu,
-        &vcpu->exit_ctx.VpContext, ctx,
-        &emu_status);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to parse PortIO access, hr=%08lx", hr);
-        return -1;
-    }
+static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    vmx_read_mem(cpu, data, addr, bytes);
+}
 
-    if (!emu_status.EmulationSuccessful) {
-        error_report("WHPX: Failed to emulate PortIO access with"
-                     " EmulatorReturnStatus: %u", emu_status.AsUINT32);
-        return -1;
+static void read_segment_descriptor(CPUState *cpu,
+                                    struct x86_segment_descriptor *desc,
+                                    enum X86Seg seg_idx)
+{
+    bool ret;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    SegmentCache *seg = &env->segs[seg_idx];
+    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
+
+    ret = x86_read_segment_descriptor(cpu, desc, sel);
+    if (ret == false) {
+        error_report("failed to read segment descriptor");
+        abort();
     }
+}
 
-    return 0;
+
+static const struct x86_emul_ops whpx_x86_emul_ops = {
+    .read_mem = read_mem,
+    .write_mem = write_mem,
+    .read_segment_descriptor = read_segment_descriptor,
+    .handle_io = handle_io
+};
+
+static void whpx_init_emu(void)
+{
+    init_decoder();
+    init_emu(&whpx_x86_emul_ops);
 }
 
 /*
@@ -1279,8 +1264,9 @@ bool whpx_arch_supports_guest_debug(void)
 
 void whpx_arch_destroy_vcpu(CPUState *cpu)
 {
-    AccelCPUState *vcpu = cpu->accel;
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    g_free(env->emu_mmio_buf);
 }
 
 /* Returns the address of the next instruction that is about to be executed. */
@@ -1639,11 +1625,11 @@ int whpx_vcpu_run(CPUState *cpu)
 
         switch (vcpu->exit_ctx.ExitReason) {
         case WHvRunVpExitReasonMemoryAccess:
-            ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx.MemoryAccess);
+            ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx);
             break;
 
         case WHvRunVpExitReasonX64IoPortAccess:
-            ret = whpx_handle_portio(cpu, &vcpu->exit_ctx.IoPortAccess);
+            ret = whpx_handle_portio(cpu, &vcpu->exit_ctx);
             break;
 
         case WHvRunVpExitReasonX64InterruptWindow:
@@ -1990,22 +1976,11 @@ int whpx_init_vcpu(CPUState *cpu)
 
     vcpu = g_new0(AccelCPUState, 1);
 
-    hr = whp_dispatch.WHvEmulatorCreateEmulator(
-        &whpx_emu_callbacks,
-        &vcpu->emulator);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to setup instruction completion support,"
-                     " hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
-    }
-
     hr = whp_dispatch.WHvCreateVirtualProcessor(
         whpx->partition, cpu->cpu_index, 0);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create a virtual processor,"
                      " hr=%08lx", hr);
-        whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
         ret = -EINVAL;
         goto error;
     }
@@ -2067,6 +2042,8 @@ int whpx_init_vcpu(CPUState *cpu)
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
 
+    env->emu_mmio_buf = g_new(char, 4096);
+
     return 0;
 
 error:
@@ -2256,6 +2233,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     whpx_memory_init();
+    whpx_init_emu();
 
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
-- 
2.50.1 (Apple Git-155)


