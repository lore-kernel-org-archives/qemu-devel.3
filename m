Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9278DD39427
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILG-0008Lb-71; Thu, 02 Apr 2026 09:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8IKt-0006PC-LM; Thu, 02 Apr 2026 09:43:51 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8HYD-0008T4-GI; Thu, 02 Apr 2026 08:53:36 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6EAFE20B703B;
 Thu,  2 Apr 2026 05:53:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EAFE20B703B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775134385;
 bh=gPpAZwOHC73qULp/xwV5Y6sj58uM2Ujhph39FL6vbIY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GJVi4GKsF7ZRsEZxXG0o0f8J1FFKqovxzg+/9/7OuepNfw4AFA8SLlvC3wkem9jMk
 +GheysUG8BdDpp1hCCtbTYf1uXud9YfYfeTY+2aQEcsPxcWzNTTGFUjATBmIezmLnu
 3KkVAG7xJ/0eCQzsNvJHWCK7pyfcGVMD2YD0ATKE=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 02 Apr 2026 12:52:37 +0000
Subject: [PATCH v2 10/14] target/arm: extract MMIO emulation logic for HVF
 & WHPX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-mshv_accel_arm64_supp-v2-10-754895c15e9e@linux.microsoft.com>
References: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
In-Reply-To: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

- Move common MMIO emulation code from HVF and WHPX backend to
  arm_emulate_mmio() in helper.c.
- Update HVF and WHPX to use the new helper and shared types.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 target/arm/helper.c        | 60 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.h        |  5 ++++
 target/arm/hvf/hvf.c       | 64 ++++++++++++++++++++++++----------------------
 target/arm/syndrome.h      | 37 +++++++++++++++++++++++++++
 target/arm/whpx/whpx-all.c | 62 +++++++++++---------------------------------
 5 files changed, 150 insertions(+), 78 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c..c9457c8384 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,8 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/helper.h"
+#include "target/arm/syndrome.h"
 #include "qemu/plugin.h"
 
 static void switch_mode(CPUARMState *env, int mode);
@@ -9130,6 +9132,64 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     take_aarch32_exception(env, new_mode, mask, offset, addr);
 }
 
+/*
+ * Emulate a data abort syndrome for MMIO/guest memory access
+ */
+int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa)
+{
+    CPUARMState *env = &ARM_CPU(cpu)->env;
+    int ret;
+    IssDataAbort iss = { 0 };
+    iss.raw = syndrome.iss;
+
+    if (!(syndrome.ec == data_abort_lower || syndrome.ec == data_abort)) {
+        error_report("Unknown exception class 0x%x", syndrome.ec);
+        return -1;
+    }
+
+    if (!iss.isv) {
+        error_report("Cannot emulate MMIO. ISS not valid.");
+        return -1;
+    }
+
+    AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
+    uint64_t len = 1ULL << iss.sas;
+    bool sign_extend = iss.sse;
+    uint64_t reg_index = iss.srt;
+
+    if (iss.wnr) {
+        uint8_t data[8];
+        uint64_t val = reg_index < 31 ? env->xregs[reg_index] : 0ULL;
+        val = cpu_to_le64(val);
+        memcpy(data, &val, sizeof(val));
+        ret = address_space_write(as, gpa, MEMTXATTRS_UNSPECIFIED, data, len);
+        if (ret != MEMTX_OK) {
+            error_report("Failed to write guest memory");
+            return -1;
+        }
+    } else {
+        uint8_t data[8] = { 0 };
+        ret = address_space_read(as, gpa, MEMTXATTRS_UNSPECIFIED, data, len);
+        if (ret != MEMTX_OK) {
+            error_report("Failed to read guest memory");
+            return -1;
+        }
+        uint64_t val;
+        memcpy(&val, data, sizeof(val));
+        val = le64_to_cpu(val);
+        if (sign_extend) {
+            uint64_t shift = 64 - (len * 8);
+            val = (((int64_t)val << shift) >> shift);
+        }
+        if (!iss.sf) {
+            val &= 0xffffffff;
+        }
+        env->xregs[reg_index] = val;
+    }
+
+    return 0;
+}
+
 static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
 {
     /*
diff --git a/target/arm/helper.h b/target/arm/helper.h
index b1c26c180e..3bc22595fd 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -3,8 +3,13 @@
 #ifndef HELPER__H
 #define HELPER__H
 
+#include <stdint.h>
+#include <stdbool.h>
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
+#include "target/arm/syndrome.h"
+
+int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa);
 
 #define HELPER_H "tcg/helper-defs.h"
 #include "exec/helper-proto.h.inc"
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..9ecad6c222 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 
+#include "syndrome.h"
 #include "system/runstate.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
@@ -35,6 +36,7 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/trace.h"
+#include "target/arm/helper.h"
 #include "trace.h"
 #include "migration/vmstate.h"
 
@@ -2072,12 +2074,15 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 {
     CPUARMState *env = cpu_env(cpu);
     ARMCPU *arm_cpu = env_archcpu(env);
-    uint64_t syndrome = excp->syndrome;
-    uint32_t ec = syn_get_ec(syndrome);
+    uint64_t syndrome;
+    uint32_t ec;
     bool advance_pc = false;
     hv_return_t r;
     int ret = 0;
 
+    syndrome = excp->syndrome;
+    ec = syn_get_ec(syndrome);
+
     switch (ec) {
     case EC_SOFTWARESTEP: {
         ret = EXCP_DEBUG;
@@ -2123,29 +2128,22 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
-        uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
-        uint64_t val = 0;
+        EsrEl2 esr_el2 = { .raw = syndrome };
+        IssDataAbort iss = { .raw = esr_el2.iss };
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
 
-        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
-                             iswrite, s1ptw, len, srt);
+        trace_hvf_data_abort(excp->virtual_address, ipa, iss.isv,
+                             iss.wnr, iss.s1ptw, 1ULL << iss.sas, iss.srt);
 
-        if (cm) {
+        if (iss.cm) {
             /* We don't cache MMIO regions */
             advance_pc = true;
             break;
         }
 
         /* Handle dirty page logging for ram. */
-        if (iswrite) {
+        if (iss.wnr) {
             hwaddr xlat;
             MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
                                                        NULL, true,
@@ -2172,27 +2170,31 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
          * TODO: If s1ptw, this is an error in the guest os page tables.
          * Inject the exception into the guest.
          */
-        assert(!s1ptw);
-
-        /*
-         * TODO: ISV will be 0 for SIMD or SVE accesses.
-         * Inject the exception into the guest.
-         */
-        assert(isv);
+        assert(!iss.s1ptw);
 
         /*
          * Emulate MMIO.
          * TODO: Inject faults for errors.
          */
-        if (iswrite) {
-            val = hvf_get_reg(cpu, srt);
-            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
-        } else {
-            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
-            if (sse) {
-                val = sextract64(val, 0, len * 8);
-            }
-            hvf_set_reg(cpu, srt, val);
+        ret = hvf_arch_get_registers(cpu);
+        if (ret < 0) {
+            error_report("Failed to get registers for MMIO");
+                         esr_el2.raw, ipa);
+            return -1;
+        }
+
+        ret = arm_emulate_mmio(cpu, esr_el2, ipa);
+        if (ret < 0) {
+            error_report("Failed to emulate MMIO, syndrome=0x%llx, gpa=0x%llx",
+                         esr_el2.raw, ipa);
+            return -1;
+        }
+
+        ret = hvf_arch_put_registers(cpu);
+        if (ret < 0) {
+            error_report("Failed to set registers after MMIO emulation");
+                         esr_el2.raw, ipa);
+            return -1;
         }
         advance_pc = true;
         break;
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bff61f052c..777d4fb975 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -101,6 +101,43 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
+typedef union {
+    uint64_t raw;
+    struct {
+        uint32_t iss:25;
+        uint32_t il:1;
+        uint32_t ec:6;
+        uint32_t iss2:5;
+        uint32_t _rsvd:27;
+    } QEMU_PACKED;
+} EsrEl2;
+
+typedef union {
+    uint32_t raw;
+    struct {
+        uint32_t dfsc:6;
+        uint32_t wnr:1;
+        uint32_t s1ptw:1;
+        uint32_t cm:1;
+        uint32_t ea:1;
+        uint32_t fnv:1;
+        uint32_t set:2;
+        uint32_t vncr:1;
+        uint32_t ar:1;
+        uint32_t sf:1;
+        uint32_t srt:5;
+        uint32_t sse:1;
+        uint32_t sas:2;
+        uint32_t isv:1;
+        uint32_t _unused:7;
+    } QEMU_PACKED;
+} IssDataAbort;
+
+typedef enum {
+    data_abort_lower = 36,
+    data_abort = 37,
+} ExceptionClass;
+
 #define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1..b4daeaff4d 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -28,6 +28,8 @@
 
 #include "syndrome.h"
 #include "target/arm/cpregs.h"
+#include "target/arm/helper.h"
+#include "target/arm/syndrome.h"
 #include "internals.h"
 
 #include "system/whpx-internal.h"
@@ -330,59 +332,25 @@ static void whpx_set_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
     }
 }
 
-static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
-{
-    assert(rt <= 31);
-    if (rt == 31) {
-        return 0;
-    }
-    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
-    WHV_REGISTER_VALUE val;
-    whpx_get_reg(cpu, reg, &val);
-
-    return val.Reg64;
-}
-
-static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
-{
-    assert(rt < 31);
-    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
-    WHV_REGISTER_VALUE reg_val = {.Reg64 = val};
-
-    whpx_set_reg(cpu, reg, reg_val);
-}
-
 static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
-    uint64_t syndrome = ctx->Syndrome;
-
-    bool isv = syndrome & ARM_EL_ISV;
-    bool iswrite = (syndrome >> 6) & 1;
-    bool sse = (syndrome >> 21) & 1;
-    uint32_t sas = (syndrome >> 22) & 3;
-    uint32_t len = 1 << sas;
-    uint32_t srt = (syndrome >> 16) & 0x1f;
-    uint32_t cm = (syndrome >> 8) & 0x1;
-    uint64_t val = 0;
+    int ret = 0;
+    EsrEl2 esr = { .raw = ctx->Syndrome };
+    uint32_t cm = (esr.iss >> 8) & 0x1;
 
     assert(!cm);
-    assert(isv);
-
-    if (iswrite) {
-        val = whpx_get_gp_reg(cpu, srt);
-        address_space_write(&address_space_memory,
-                            ctx->Gpa,
-                            MEMTXATTRS_UNSPECIFIED, &val, len);
-    } else {
-        address_space_read(&address_space_memory,
-                           ctx->Gpa,
-                           MEMTXATTRS_UNSPECIFIED, &val, len);
-        if (sse) {
-            val = sextract64(val, 0, len * 8);
-        }
-        whpx_set_gp_reg(cpu, srt, val);
+
+    whpx_get_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
+
+    ret = arm_emulate_mmio(cpu, esr, ctx->Gpa);
+    if (ret < 0) {
+        error_report("WHPX: Failed to handle MMIO, syndrome=0x%llx, gpa=0x%llx",
+                     esr.raw, ctx->Gpa);
+        return -1;
     }
 
+    whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
+
     return 0;
 }
 

-- 
2.45.4


