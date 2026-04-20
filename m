Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9299F5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm71-0008LP-5Q; Mon, 20 Apr 2026 06:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm70-0008Ko-6p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:18 -0400
Received: from p-west3-cluster4-host11-snip4-10.eps.apple.com ([57.103.74.221]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6w-0000m2-7s
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:17 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 251371800451; Mon, 20 Apr 2026 10:44:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681853; x=1779273853;
 bh=tbMliXtkqk8dPHBK0hLkGecREvcpTdLtake6KyI3WL8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V7XdVDc1+XTOwx6v5+f57H3xAUMNtmfBwphIFmv8pOhEmEaS3VOHBOTJSsrpaxAUdzwQdaEJqqEtgbl/3L+kCJ+qOXlbuxzfznTqfMLomzEAITFM7eJzEgGEhvaoHOLJC07l7/mbVymCgzqfcxy7Acfkva859Dp+6sjusij+lOcVgLF+6BLHKEjRLovxmnRzICOL/F//ffvmYFQa9b7vENBb8jECvYJ0wGGfeXtGrqFGVvddcvkr4VgxBOcmoHNMellPPzCTotMoiQfDdt0rioRXzGxlAH8UMrQiW4swZ1zVzenYu6wX5/xPhS/7lJUO6PalDSbBApTfG2j3ylkR8A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 9669D1800159; Mon, 20 Apr 2026 10:44:08 +0000 (UTC)
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
Subject: [PATCH v2 31/38] whpx: xsave support
Date: Mon, 20 Apr 2026 12:42:41 +0200
Message-ID: <20260420104248.86702-32-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bO-wrEJn44fpQzUefPwBq6egDJYePCFq
X-Proofpoint-GUID: bO-wrEJn44fpQzUefPwBq6egDJYePCFq
X-Authority-Info-Out: v=2.4 cv=cKftc1eN c=1 sm=1 tr=0 ts=69e6037b
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pIzSZyhXsI4QXQPOM_AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfXxELx/m+9X/Ic
 Q9UioB4ugv0c07Qj2JgxzQUo2Z4YKyEy7nycL/uX3WjK2YSzB3OGfJmr+hcO9xVnhLwsjOLcIIs
 m2vdwg2jcrun/33wLp3ImmdhNuIcT2K37wLIzGNjnu1ohal5ws6/2aJOZgZ9AZZSUwA0vp53pAA
 MHofpj2BzA4nkmXWSu8lTkGOtuNHIS2z2XTO/UxRKPs3ULb/ZItADrA1QEtbH16Eb/diBdUKNIQ
 +4qFlzlhhufIioUO5rd9SMC7155sRVR1P3KK0S/aIFQaLY5GNJqUhmymIXyDH05C1zoV6M1DSYa
 XxqVAB5UX5C6t9vgffnGvc1NpH6T+xNX5bAHc7jwszu0oE1s8o655zQ8XevM2Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1030
 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.221;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |  16 ++
 target/i386/whpx/whpx-all.c    | 379 ++++++++++++++++++++++++---------
 2 files changed, 292 insertions(+), 103 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 86639627b3..0aae83bd7c 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -99,6 +99,22 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvGetVirtualProcessorXsaveState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorXsaveState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
+  X(HRESULT, WHvGetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
   LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
 
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 045dbdfdc8..9b2488b801 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/typedefs.h"
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "gdbstub/helpers.h"
@@ -20,6 +21,7 @@
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
+#include "qemu/memalign.h"
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "hw/intc/i8259.h"
@@ -108,34 +110,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
      * WHvX64RegisterDr7,
      */
 
-    /* X64 Floating Point and Vector Registers */
-    WHvX64RegisterXmm0,
-    WHvX64RegisterXmm1,
-    WHvX64RegisterXmm2,
-    WHvX64RegisterXmm3,
-    WHvX64RegisterXmm4,
-    WHvX64RegisterXmm5,
-    WHvX64RegisterXmm6,
-    WHvX64RegisterXmm7,
-    WHvX64RegisterXmm8,
-    WHvX64RegisterXmm9,
-    WHvX64RegisterXmm10,
-    WHvX64RegisterXmm11,
-    WHvX64RegisterXmm12,
-    WHvX64RegisterXmm13,
-    WHvX64RegisterXmm14,
-    WHvX64RegisterXmm15,
-    WHvX64RegisterFpMmx0,
-    WHvX64RegisterFpMmx1,
-    WHvX64RegisterFpMmx2,
-    WHvX64RegisterFpMmx3,
-    WHvX64RegisterFpMmx4,
-    WHvX64RegisterFpMmx5,
-    WHvX64RegisterFpMmx6,
-    WHvX64RegisterFpMmx7,
-    WHvX64RegisterFpControlStatus,
-    WHvX64RegisterXmmControlStatus,
-
     /* X64 MSRs */
     WHvX64RegisterEfer,
 #ifdef TARGET_X86_64
@@ -182,6 +156,36 @@ static const WHV_REGISTER_NAME whpx_register_names_for_vmexit[] = {
     WHvX64RegisterR15,
 };
 
+static const WHV_REGISTER_NAME whpx_register_names_legacy_fp[] = {
+    /* X64 Floating Point and Vector Registers (non-xsave) */
+    WHvX64RegisterXmm0,
+    WHvX64RegisterXmm1,
+    WHvX64RegisterXmm2,
+    WHvX64RegisterXmm3,
+    WHvX64RegisterXmm4,
+    WHvX64RegisterXmm5,
+    WHvX64RegisterXmm6,
+    WHvX64RegisterXmm7,
+    WHvX64RegisterXmm8,
+    WHvX64RegisterXmm9,
+    WHvX64RegisterXmm10,
+    WHvX64RegisterXmm11,
+    WHvX64RegisterXmm12,
+    WHvX64RegisterXmm13,
+    WHvX64RegisterXmm14,
+    WHvX64RegisterXmm15,
+    WHvX64RegisterFpMmx0,
+    WHvX64RegisterFpMmx1,
+    WHvX64RegisterFpMmx2,
+    WHvX64RegisterFpMmx3,
+    WHvX64RegisterFpMmx4,
+    WHvX64RegisterFpMmx5,
+    WHvX64RegisterFpMmx6,
+    WHvX64RegisterFpMmx7,
+    WHvX64RegisterFpControlStatus,
+    WHvX64RegisterXmmControlStatus,
+};
+
 struct whpx_register_set {
     WHV_REGISTER_VALUE values[RTL_NUMBER_OF(whpx_register_names)];
 };
@@ -392,6 +396,123 @@ static int whpx_set_tsc(CPUState *cpu)
     return 0;
 }
 
+static bool whpx_is_xsave_enabled(CPUState *cpu)
+{
+    CPUX86State *env = &X86_CPU(cpu)->env;
+    return env->cr[4] & CR4_OSXSAVE_MASK;
+}
+
+static size_t whpx_get_xsave_max_len(void)
+{
+    return whpx_get_supported_cpuid(0xd, 0, R_ECX);
+}
+
+static int whpx_set_xsave_state(const CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    HRESULT hr;
+    void *xsavec_buf;
+    size_t page = qemu_real_host_page_size();
+    size_t xsavec_buf_len;
+
+    /* allocate and populate compacted buffer */
+    xsavec_buf_len = whpx_get_xsave_max_len();
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+
+    /* save registers to standard format buffer */
+    x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    /* store compacted version of xsave area in xsavec_buf */
+    compact_xsave_area(env, xsavec_buf, xsavec_buf_len);
+
+    if (!whpx_is_legacy_os()) {
+        hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            xsavec_buf,
+            xsavec_buf_len);
+    } else {
+        hr = whp_dispatch.WHvSetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            xsavec_buf,
+            xsavec_buf_len);
+    }
+
+    qemu_vfree(xsavec_buf);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
+                     hr);
+    }
+
+    return 0;
+}
+
+static void whpx_set_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct whpx_register_set vcxt;
+    HRESULT hr;
+    int idx = 0;
+    int i;
+    int idx_next;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    /* 16 XMM registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmm0);
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
+        vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
+        vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
+    }
+    idx = idx_next;
+
+    /* 8 FP registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpMmx0);
+    for (i = 0; i < 8; i += 1, idx += 1) {
+        vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
+        /* vcxt.values[idx].Fp.AsUINT128.High64 =
+               env->fpregs[i].mmx.MMX_Q(1);
+        */
+    }
+
+    /* FP control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpControlStatus);
+    vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
+    vcxt.values[idx].FpControlStatus.FpStatus =
+        (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
+    vcxt.values[idx].FpControlStatus.FpTag = 0;
+    for (i = 0; i < 8; ++i) {
+        vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
+    }
+    vcxt.values[idx].FpControlStatus.Reserved = 0;
+    vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
+    vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
+    idx += 1;
+
+    /* XMM control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmmControlStatus);
+    vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
+    vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
+    vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
+    idx += 1;
+
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names_legacy_fp,
+        idx,
+        &vcxt.values[0]);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
+                     hr);
+    }
+}
+
 void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -491,45 +612,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
          */
         whpx_set_xcrs(cpu);
 
-        /* 16 XMM registers */
-        assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-        idx_next = idx + 16;
-        for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
-            vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
-            vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
-        }
-        idx = idx_next;
-
-        /* 8 FP registers */
-        assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
-        for (i = 0; i < 8; i += 1, idx += 1) {
-            vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
-            /* vcxt.values[idx].Fp.AsUINT128.High64 =
-                       env->fpregs[i].mmx.MMX_Q(1);
-            */
-        }
-
-        /* FP control status register */
-        assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
-        vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
-        vcxt.values[idx].FpControlStatus.FpStatus =
-            (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
-        vcxt.values[idx].FpControlStatus.FpTag = 0;
-        for (i = 0; i < 8; ++i) {
-            vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
+        if (whpx_is_xsave_enabled(cpu)) {
+            whpx_set_xsave_state(cpu);
+        } else {
+            whpx_set_legacy_fp_registers(cpu, level);
         }
-        vcxt.values[idx].FpControlStatus.Reserved = 0;
-        vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
-        vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
-        idx += 1;
-
-        /* XMM control status register */
-        assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
-        vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
-        vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
-        vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
-        idx += 1;
-
         /* MSRs */
         assert(whpx_register_names[idx] == WHvX64RegisterEfer);
         vcxt.values[idx++].Reg64 = env->efer;
@@ -662,6 +749,110 @@ static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
     x86_update_hflags(env);
 }
 
+static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct whpx_register_set vcxt;
+    HRESULT hr;
+    int i;
+    int idx;
+    int idx_next;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names_legacy_fp,
+        RTL_NUMBER_OF(whpx_register_names_legacy_fp),
+        &vcxt.values[0]);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
+                     hr);
+    }
+
+    idx = 0;
+    /* 16 XMM registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmm0);
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
+        env->xmm_regs[i].ZMM_Q(0) = vcxt.values[idx].Reg128.Low64;
+        env->xmm_regs[i].ZMM_Q(1) = vcxt.values[idx].Reg128.High64;
+    }
+    idx = idx_next;
+
+    /* 8 FP registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpMmx0);
+    for (i = 0; i < 8; i += 1, idx += 1) {
+        env->fpregs[i].mmx.MMX_Q(0) = vcxt.values[idx].Fp.AsUINT128.Low64;
+        /* env->fpregs[i].mmx.MMX_Q(1) =
+               vcxt.values[idx].Fp.AsUINT128.High64;
+        */
+    }
+
+    /* FP control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpControlStatus);
+    env->fpuc = vcxt.values[idx].FpControlStatus.FpControl;
+    env->fpstt = (vcxt.values[idx].FpControlStatus.FpStatus >> 11) & 0x7;
+    env->fpus = vcxt.values[idx].FpControlStatus.FpStatus & ~0x3800;
+    for (i = 0; i < 8; ++i) {
+        env->fptags[i] = !((vcxt.values[idx].FpControlStatus.FpTag >> i) & 1);
+    }
+    env->fpop = vcxt.values[idx].FpControlStatus.LastFpOp;
+    env->fpip = vcxt.values[idx].FpControlStatus.LastFpRip;
+    idx += 1;
+
+    /* XMM control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmmControlStatus);
+    env->mxcsr = vcxt.values[idx].XmmControlStatus.XmmStatusControl;
+    idx += 1;
+}
+
+static int whpx_get_xsave_state(CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int ret;
+    HRESULT hr;
+    void *xsavec_buf;
+    const size_t page = qemu_real_host_page_size();
+    size_t xsavec_buf_len = whpx_get_xsave_max_len();
+    UINT32 bytes_written;
+
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+    memset(xsavec_buf, 0, xsavec_buf_len);
+
+    if (!whpx_is_legacy_os()) {
+        hr = whp_dispatch.WHvGetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            xsavec_buf,
+            xsavec_buf_len, &bytes_written);
+    } else {
+        hr = whp_dispatch.WHvGetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            xsavec_buf,
+            xsavec_buf_len, &bytes_written);
+    }
+    if (FAILED(hr) || bytes_written == 0) {
+        error_report("failed to get xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    qemu_vfree(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to decompact xsave area");
+        return ret;
+    }
+    x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    return 0;
+}
+
 void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -758,40 +949,11 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      */
     whpx_get_xcrs(cpu);
 
-    /* 16 XMM registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    idx_next = idx + 16;
-    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
-        env->xmm_regs[i].ZMM_Q(0) = vcxt.values[idx].Reg128.Low64;
-        env->xmm_regs[i].ZMM_Q(1) = vcxt.values[idx].Reg128.High64;
-    }
-    idx = idx_next;
-
-    /* 8 FP registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
-    for (i = 0; i < 8; i += 1, idx += 1) {
-        env->fpregs[i].mmx.MMX_Q(0) = vcxt.values[idx].Fp.AsUINT128.Low64;
-        /* env->fpregs[i].mmx.MMX_Q(1) =
-               vcxt.values[idx].Fp.AsUINT128.High64;
-        */
-    }
-
-    /* FP control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
-    env->fpuc = vcxt.values[idx].FpControlStatus.FpControl;
-    env->fpstt = (vcxt.values[idx].FpControlStatus.FpStatus >> 11) & 0x7;
-    env->fpus = vcxt.values[idx].FpControlStatus.FpStatus & ~0x3800;
-    for (i = 0; i < 8; ++i) {
-        env->fptags[i] = !((vcxt.values[idx].FpControlStatus.FpTag >> i) & 1);
+    if (whpx_is_xsave_enabled(cpu)) {
+        whpx_get_xsave_state(cpu);
+    } else {
+        whpx_get_legacy_fp_registers(cpu, level);
     }
-    env->fpop = vcxt.values[idx].FpControlStatus.LastFpOp;
-    env->fpip = vcxt.values[idx].FpControlStatus.LastFpRip;
-    idx += 1;
-
-    /* XMM control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
-    env->mxcsr = vcxt.values[idx].XmmControlStatus.XmmStatusControl;
-    idx += 1;
 
     /* MSRs */
     assert(whpx_register_names[idx] == WHvX64RegisterEfer);
@@ -1525,6 +1687,9 @@ void whpx_arch_destroy_vcpu(CPUState *cpu)
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
     g_free(env->emu_mmio_buf);
+    qemu_vfree(env->xsave_buf);
+    env->xsave_buf = NULL;
+    env->xsave_buf_len = 0;
 }
 
 /* Returns the address of the next instruction that is about to be executed. */
@@ -2393,6 +2558,9 @@ int whpx_init_vcpu(CPUState *cpu)
     Error *local_error = NULL;
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    X86XSaveHeader *header;
+    size_t page_size = qemu_real_host_page_size();
+    size_t xsave_len;
     UINT64 freq = 0;
     int ret;
 
@@ -2469,6 +2637,15 @@ int whpx_init_vcpu(CPUState *cpu)
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
 
     env->emu_mmio_buf = g_new(char, 4096);
+    /* Initialize XSAVE buffer page-aligned */
+    xsave_len = whpx_get_xsave_max_len();
+    env->xsave_buf = qemu_memalign(page_size, xsave_len);
+    env->xsave_buf_len = xsave_len;
+    memset(env->xsave_buf, 0, env->xsave_buf_len);
+
+    /* we need to set the compacted format bit in xsave header for Hyper-V */
+    header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
+    header->xcomp_bv = header->xstate_bv | (1ULL << 63);
 
     return 0;
 
@@ -2628,10 +2805,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         error_report("WHPX: Failed to query XSAVE capability, hr=%08lx", hr);
     }
 
-    if (!whpx_has_xsave()) {
-        printf("WHPX: Partition is not XSAVE capable\n");
-    }
-
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ProcessorCount = ms->smp.cpus;
     hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.50.1 (Apple Git-155)


