Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AEAEB5961
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3BA-0005YR-7p; Wed, 11 Feb 2026 00:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B8-0005Xa-DI
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:22 -0500
Received: from p-west3-cluster1-host2-snip4-2.eps.apple.com ([57.103.73.143]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B6-0002ro-5W
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:22 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 52C511800189; Wed, 11 Feb 2026 05:54:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789259; x=1773381259;
 bh=BjBElD2Ry3fXf057R0RLxYOzOE9f1h3t5juRI+kKJTI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cI/cwTpLDLq90KB9/E9qEzAgVarQVSjVUGEJRA65Og9M/TBd3f9FeUxaamS6sD6ath1kw125CH8csNrPJJBbVQCFrFSG2NBVw+IU0X6UPo9vqtfFeM4GBsfFanKG/AtMYNg0sXRnUc/3l7cok8RCm/jsURCrSgVgizu2x9ofn9ymoxqb6HUc0/ofOSaWCXPymqIb4Q+1C/1KAbQv0V4ru3LUMIwQsspGRoWtXFVmv5iMwr5dBcpYuHVJEd+cZP0EAFHeVuC5y2jGE2wr7f5Cf/tLoKBtNZN5g/9hevEcSLVOEOOYdA1TIDKyW8695s52x7i4MVtX+wdjTAfI8Js1dA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 24C4118000B4; Wed, 11 Feb 2026 05:54:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/7] whpx: x86: switch over from winhvemulation to
 target/i386/emulate
Date: Wed, 11 Feb 2026 06:53:50 +0100
Message-ID: <20260211055356.44664-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=JvH8bc4C c=1 sm=1 tr=0 ts=698c198a
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=oThT452izoIBxcdC9S0A:9
X-Proofpoint-GUID: bM0a1dkFKOxCdir9hYMWRFsj6Movu8Sf
X-Proofpoint-ORIG-GUID: bM0a1dkFKOxCdir9hYMWRFsj6Movu8Sf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfX6AlDLF5BN4wZ
 yMjAkKiUSlArCqoSt9HU8282CbKpiyTtV5u/B3h4xbaTgmFTr0qNXUrTQCPnFL+u1IsHySoCkjB
 sinCbchPpQYp0oDB4MTqpSSzW9WEcrRi6gYpuxQaeVmCWCkoulhFj05rfLLpVJoshbDVy9CnlKu
 aGX6DoPRHCOhb/AVbLWmncJew8XoK4b4rWeSTeQeUHFHNDBwuLKBl7+nzlOnMzcn5kCSvbdf29g
 /UEXLVSsaAYl9HEkNAIw8iVuMteP4WAFywoNl56uoFLt9YO/qV95Pa0F0dF93A1k7rNFybYDduR
 JSbGzjnN8nBy9m68poFZhnJQn3IaCJi4O8B7Ll7ky6SPN2tdHYeFi7wa24Nsqc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 phishscore=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAAB6SOfVm9Fy36vNZli1jJYYSdYtH6YffJZKe0GE16FDliu6P1pel0iNNYQI/tQnkhh9a5EvB24NsSLeghfIkpgxKEDJIrIT7vrgyBt9/XIBfrwYTwKw+42WptAAdP1yE5oQVaEO890RLmAX/0zBsvB8jmK3nWQXx68JAC7QuflHiuv6ov8y4vnml9lTs3lPwgB7sH7FomPA6SOHa/lIPeRYhQ6rk23vLEbuF90bi6fmdBINVoL9fOsnCHfJxf7SW7jMX38absuiCrAqWhFF98OAcT8E+hEcFI7KP8iUoSdBzz9NdGWli9h/MzOItU3Y0EFC4oyca+2doqfQYj0yXRsCGj+bpLUR49XM4dW2TX6APj4PnyhNCCpsfnKF/1GQaHglRBf06u2y5ffqhE1WB40BRt8ZhY/hZVzTodAQAWL/zs16oWgwimEDY8GDDcsqD77M8+v7tVd6XIB82P52zMRECTeiNlwptLn0Mo9L4w/mbHCTd1CzfSOxGOzhtW06vHG9xD7qOsEhgSPe1dcvWXCW8U7ig63b5aKIDWKvPlw1BILcMXbfSV+uLmhPcrqvbLdKx9TN+Vgg8Go/+rPPzHZM4zZwzVBoave909GA0ALLDRu0Izlh567aOPxiOhXosgMC1gIIFBMM6AeCpzc/igyj4UM7oJa3NSBTJe1t2aGqnF99ZLfV80Lxd0J9RvV16hhHG7I0Yk9ZCG1HGNlxwMYtAJ6AUcdUt+TJaWqdpyb1rorwGyvJNINcTOIXHq5CgtyFxPixX9uSafUBIrxiSjwhkgv
Received-SPF: pass client-ip=57.103.73.143;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Using the mshv backend as a base, move away from winhvemulation
to using common QEMU code used by the HVF and mshv backends.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 299 ++++++++++++++++++++++--------------
 1 file changed, 180 insertions(+), 119 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cdcaebbe16..68ac9dd6ff 100644
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
@@ -36,8 +37,11 @@
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
 
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "emulate/x86_flags.h"
+
 #include <winhvplatform.h>
-#include <winhvemulation.h>
 
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 
@@ -756,160 +760,224 @@ void whpx_get_registers(CPUState *cpu)
     x86_update_hflags(env);
 }
 
-static HRESULT CALLBACK whpx_emu_ioport_callback(
-    void *ctx,
-    WHV_EMULATOR_IO_ACCESS_INFO *IoAccess)
+static int emulate_instruction(CPUState *cpu)
 {
-    MemTxAttrs attrs = { 0 };
-    address_space_rw(&address_space_io, IoAccess->Port, attrs,
-                     &IoAccess->Data, IoAccess->AccessSize,
-                     IoAccess->Direction);
-    return S_OK;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+
+    whpx_get_registers(cpu);
+    decode_instruction(env, &decode);
+    exec_instruction(env, &decode);
+    whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+
+    return 0;
 }
 
-static HRESULT CALLBACK whpx_emu_mmio_callback(
-    void *ctx,
-    WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
+static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
-    CPUState *cs = (CPUState *)ctx;
-    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+    int ret;
 
-    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
-                     ma->Data, ma->AccessSize, ma->Direction);
-    return S_OK;
+    ret = emulate_instruction(cpu);
+    if (ret < 0) {
+        error_report("failed to emulate mmio");
+        return -1;
+    }
+
+    return 0;
 }
 
-static HRESULT CALLBACK whpx_emu_getreg_callback(
-    void *ctx,
-    const WHV_REGISTER_NAME *RegisterNames,
-    UINT32 RegisterCount,
-    WHV_REGISTER_VALUE *RegisterValues)
+static void handle_io(CPUState *env, uint16_t port, void *buffer,
+                  int direction, int size, int count)
 {
-    HRESULT hr;
-    struct whpx_state *whpx = &whpx_global;
-    CPUState *cpu = (CPUState *)ctx;
+    int i;
+    uint8_t *ptr = buffer;
 
-    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
-        whpx->partition, cpu->cpu_index,
-        RegisterNames, RegisterCount,
-        RegisterValues);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to get virtual processor registers,"
-                     " hr=%08lx", hr);
+    for (i = 0; i < count; i++) {
+        address_space_rw(&address_space_io, port, MEMTXATTRS_UNSPECIFIED,
+                         ptr, size,
+                         direction);
+        ptr += size;
     }
+}
 
-    return hr;
+static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
+{
+    WHV_REGISTER_VALUE reg;
+    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
+    reg.Reg64 += exit_ctx->VpContext.InstructionLength;
+    whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
 
-static HRESULT CALLBACK whpx_emu_setreg_callback(
-    void *ctx,
-    const WHV_REGISTER_NAME *RegisterNames,
-    UINT32 RegisterCount,
-    const WHV_REGISTER_VALUE *RegisterValues)
+static int whpx_handle_portio(CPUState *cpu,
+                              WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
-    HRESULT hr;
-    struct whpx_state *whpx = &whpx_global;
-    CPUState *cpu = (CPUState *)ctx;
+    WHV_X64_IO_PORT_ACCESS_CONTEXT *ctx = &exit_ctx->IoPortAccess;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    int ret;
 
-    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-        whpx->partition, cpu->cpu_index,
-        RegisterNames, RegisterCount,
-        RegisterValues);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set virtual processor registers,"
-                     " hr=%08lx", hr);
+    if (!ctx->AccessInfo.StringOp && !ctx->AccessInfo.IsWrite) {
+        uint64_t val = 0;
+        WHV_REGISTER_VALUE reg;
+
+        whpx_get_registers(cpu);
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
+    ret = emulate_instruction(cpu);
+    if (ret < 0) {
+        error_report("failed to emulate I/O port access");
+        return -1;
     }
 
-    /*
-     * The emulator just successfully wrote the register state. We clear the
-     * dirty state so we avoid the double write on resume of the VP.
-     */
-    cpu->vcpu_dirty = false;
-
-    return hr;
+    return 0;
 }
 
-static HRESULT CALLBACK whpx_emu_translate_callback(
-    void *ctx,
-    WHV_GUEST_VIRTUAL_ADDRESS Gva,
-    WHV_TRANSLATE_GVA_FLAGS TranslateFlags,
-    WHV_TRANSLATE_GVA_RESULT_CODE *TranslationResult,
-    WHV_GUEST_PHYSICAL_ADDRESS *Gpa)
+static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
+                         WHV_TRANSLATE_GVA_FLAGS flags)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    CPUState *cpu = (CPUState *)ctx;
-    WHV_TRANSLATE_GVA_RESULT res;
+    WHV_TRANSLATE_GVA_RESULT translation_result;
+
+    /* perform the call */
+    hr = whp_dispatch.WHvTranslateGva(whpx->partition, cpu->cpu_index, gva, flags, &translation_result, gpa);
 
-    hr = whp_dispatch.WHvTranslateGva(whpx->partition, cpu->cpu_index,
-                                      Gva, TranslateFlags, &res, Gpa);
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to translate GVA, hr=%08lx", hr);
-    } else {
-        *TranslationResult = res.ResultCode;
+        error_report("Failed to translate gva (0x%llx) to gpa", gva);
+        return -1;
     }
 
-    return hr;
-}
+    if (translation_result.ResultCode != WHvTranslateGvaResultSuccess) {
+        error_report("Failed to translate gva (0x%llx) to gpa", gva);
+        return -1;
+    }
 
-static const WHV_EMULATOR_CALLBACKS whpx_emu_callbacks = {
-    .Size = sizeof(WHV_EMULATOR_CALLBACKS),
-    .WHvEmulatorIoPortCallback = whpx_emu_ioport_callback,
-    .WHvEmulatorMemoryCallback = whpx_emu_mmio_callback,
-    .WHvEmulatorGetVirtualProcessorRegisters = whpx_emu_getreg_callback,
-    .WHvEmulatorSetVirtualProcessorRegisters = whpx_emu_setreg_callback,
-    .WHvEmulatorTranslateGvaPage = whpx_emu_translate_callback,
-};
+    return 0;
+}
 
-static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
+static int guest_mem_read_with_gva(CPUState *cpu, uint64_t gva,
+                                   uint8_t *data, uintptr_t size,
+                                   bool fetch_instruction)
 {
-    HRESULT hr;
-    AccelCPUState *vcpu = cpu->accel;
-    WHV_EMULATOR_STATUS emu_status;
+    int ret;
+    uint64_t gpa;
+    AddressSpace *as = cpu_addressspace(cpu, MEMTXATTRS_UNSPECIFIED);
 
-    hr = whp_dispatch.WHvEmulatorTryMmioEmulation(
-        vcpu->emulator, cpu,
-        &vcpu->exit_ctx.VpContext, ctx,
-        &emu_status);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to parse MMIO access, hr=%08lx", hr);
+    ret = translate_gva(cpu, gva, &gpa, WHvTranslateGvaFlagValidateRead);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
         return -1;
     }
 
-    if (!emu_status.EmulationSuccessful) {
-        error_report("WHPX: Failed to emulate MMIO access with"
-                     " EmulatorReturnStatus: %u", emu_status.AsUINT32);
+    ret = address_space_rw(as, gpa, MEMTXATTRS_UNSPECIFIED, data, size, false);
+    if (ret < 0) {
+        error_report("failed to read from guest memory");
         return -1;
     }
 
     return 0;
 }
 
-static int whpx_handle_portio(CPUState *cpu,
-                              WHV_X64_IO_PORT_ACCESS_CONTEXT *ctx)
+static int guest_mem_write_with_gva(CPUState *cpu, uint64_t gva,
+                                    const uint8_t *data, uintptr_t size)
 {
-    HRESULT hr;
-    AccelCPUState *vcpu = cpu->accel;
-    WHV_EMULATOR_STATUS emu_status;
+    int ret;
+    uint64_t gpa;
+    AddressSpace *as = cpu_addressspace(cpu, MEMTXATTRS_UNSPECIFIED);
 
-    hr = whp_dispatch.WHvEmulatorTryIoEmulation(
-        vcpu->emulator, cpu,
-        &vcpu->exit_ctx.VpContext, ctx,
-        &emu_status);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to parse PortIO access, hr=%08lx", hr);
+    ret = translate_gva(cpu, gva, &gpa, WHvTranslateGvaFlagValidateWrite);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
         return -1;
     }
 
-    if (!emu_status.EmulationSuccessful) {
-        error_report("WHPX: Failed to emulate PortIO access with"
-                     " EmulatorReturnStatus: %u", emu_status.AsUINT32);
+    ret = address_space_rw(as, gpa, MEMTXATTRS_UNSPECIFIED, (void *)data, size, true);
+    if (ret < 0) {
+        error_report("failed to write to guest memory");
         return -1;
     }
 
     return 0;
 }
 
+static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    if (guest_mem_write_with_gva(cpu, addr, data, bytes) < 0) {
+        error_report("failed to write memory");
+        abort();
+    }
+}
+
+
+static void fetch_instruction(CPUState *cpu, void *data,
+                              target_ulong addr, int bytes)
+{
+    if (guest_mem_read_with_gva(cpu, addr, data, bytes, true) < 0) {
+        error_report("failed to fetch instruction");
+        abort();
+    }
+}
+
+static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    if (guest_mem_read_with_gva(cpu, addr, data, bytes, false) < 0) {
+        error_report("failed to read memory");
+        abort();
+    }
+}
+
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
+    }
+}
+
+
+static const struct x86_emul_ops whpx_x86_emul_ops = {
+    .fetch_instruction = fetch_instruction,
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
+}
+
 /*
  * Controls whether we should intercept various exceptions on the guest,
  * namely breakpoint/single-step events.
@@ -1279,8 +1347,9 @@ bool whpx_arch_supports_guest_debug(void)
 
 void whpx_arch_destroy_vcpu(CPUState *cpu)
 {
-    AccelCPUState *vcpu = cpu->accel;
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    g_free(env->emu_mmio_buf);
 }
 
 /* Returns the address of the next instruction that is about to be executed. */
@@ -1643,7 +1712,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
 
         case WHvRunVpExitReasonX64IoPortAccess:
-            ret = whpx_handle_portio(cpu, &vcpu->exit_ctx.IoPortAccess);
+            ret = whpx_handle_portio(cpu, &vcpu->exit_ctx);
             break;
 
         case WHvRunVpExitReasonX64InterruptWindow:
@@ -1990,22 +2059,11 @@ int whpx_init_vcpu(CPUState *cpu)
 
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
@@ -2067,6 +2125,8 @@ int whpx_init_vcpu(CPUState *cpu)
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
 
+    env->emu_mmio_buf = g_new(char, 4096);
+
     return 0;
 
 error:
@@ -2256,6 +2316,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     whpx_memory_init();
+    whpx_init_emu();
 
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
-- 
2.50.1 (Apple Git-155)


