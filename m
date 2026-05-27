Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DF2CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS6OL-0001NP-5c; Wed, 27 May 2026 01:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OK-0001Mv-4H; Wed, 27 May 2026 01:01:16 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OH-0004E6-RD; Wed, 27 May 2026 01:01:15 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id BEA9320B7175;
 Tue, 26 May 2026 22:00:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEA9320B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779858041;
 bh=l13jBPla7LYedM0eeBCZ04xfKeLLY7LCqMZx2PSJOSU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NNHDh6rBKIem++H0Zdf+q1RFBTseuax3AAJhZxEXUImaw5HvDhGNsP5wB5mcEnnIC
 3vY22zy2ab/odHWgxcCN0CoQBeThSQsvFuqKWzUdVa7zXGsCvgkQk+kJPm4Tp322Tg
 LTsJ8DkuDM2/RL0jpvkVDWrNjiSbH7GBIetDTgho=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Wed, 27 May 2026 05:00:47 +0000
Subject: [PATCH v4 11/15] target/arm: extract MMIO emulation logic for HVF
 & WHPX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-mshv_accel_arm64_supp-v4-11-66d871dcdc53@linux.microsoft.com>
References: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
In-Reply-To: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

- Move common MMIO emulation code from HVF and WHPX backend to
  arm_emulate_mmio() in helper.c.
- Update HVF and WHPX to use the new helper and shared types.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 target/arm/helper.c        | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.h        | 16 ++++++++++++
 target/arm/hvf/hvf.c       | 57 +++++++++++++++++++-----------------------
 target/arm/syndrome.h      | 47 +++++++++++++++++++++++++++++++++++
 target/arm/whpx/whpx-all.c | 41 ++++++++++++------------------
 5 files changed, 167 insertions(+), 56 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8240f1b384..6e7b4591dc 100644
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
@@ -9097,6 +9099,66 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     take_aarch32_exception(env, new_mode, mask, offset, addr);
 }
 
+/*
+ * Emulate a data abort syndrome for MMIO/guest memory access
+ */
+int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa,
+                     const struct arm_emul_ops *ops)
+{
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
+        uint64_t val = reg_index < 31 ? ops->get_reg(cpu, reg_index) : 0ULL;
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
+        if (reg_index < 31) {
+            ops->set_reg(cpu, reg_index, val);
+        }
+    }
+
+    return 0;
+}
+
 static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
 {
     /*
diff --git a/target/arm/helper.h b/target/arm/helper.h
index b1c26c180e..503404112d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -3,8 +3,24 @@
 #ifndef HELPER__H
 #define HELPER__H
 
+#include <stdint.h>
+#include <stdbool.h>
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
+#include "target/arm/syndrome.h"
+
+/*
+ * Callback ops for per-register access during MMIO emulation.
+ * Each hypervisor backend provides its own implementation to avoid
+ * syncing the full CPU state for a single-register MMIO access.
+ */
+struct arm_emul_ops {
+    uint64_t (*get_reg)(CPUState *cpu, int reg);
+    void (*set_reg)(CPUState *cpu, int reg, uint64_t val);
+};
+
+int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa,
+                     const struct arm_emul_ops *ops);
 
 #define HELPER_H "tcg/helper-defs.h"
 #include "exec/helper-proto.h.inc"
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d88cbe7c82..18867795ab 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 
+#include "syndrome.h"
 #include "system/runstate.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
@@ -37,6 +38,7 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/trace.h"
+#include "target/arm/helper.h"
 #include "trace.h"
 #include "migration/vmstate.h"
 
@@ -2331,12 +2333,15 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
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
@@ -2382,29 +2387,22 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
-        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
-        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
-        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
-        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
-        uint32_t len = 1 << sas;
-        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
-        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
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
@@ -2431,28 +2429,25 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
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
+
+        static const struct arm_emul_ops hvf_arm_emul_ops = {
+            .get_reg = hvf_get_reg,
+            .set_reg = hvf_set_reg,
+        };
+
+        ret = arm_emulate_mmio(cpu, esr_el2, ipa, &hvf_arm_emul_ops);
+        if (ret < 0) {
+            error_report("Failed to emulate MMIO, syndrome=0x%llx, gpa=0x%llx",
+                         esr_el2.raw, ipa);
+            return -1;
         }
+
         advance_pc = true;
         break;
     }
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 4d1f1c529e..b1a55735ac 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,6 +106,53 @@ typedef enum {
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
+#define ARM_EL_EC_LENGTH 6
+#define ARM_EL_EC_SHIFT 26
+#define ARM_EL_IL_SHIFT 25
+#define ARM_EL_ISV_SHIFT 24
+#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
+#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
+
+/* In the Data Abort syndrome */
+#define ARM_EL_VNCR (1 << 13)
+
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c..c98450be99 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -28,6 +28,8 @@
 
 #include "syndrome.h"
 #include "target/arm/cpregs.h"
+#include "target/arm/helper.h"
+#include "target/arm/syndrome.h"
 #include "internals.h"
 
 #include "system/whpx-internal.h"
@@ -354,34 +356,23 @@ static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
 
 static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
-    uint64_t syndrome = ctx->Syndrome;
-
-    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
-    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
-    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
-    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
-    uint32_t len = 1 << sas;
-    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
-    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
-    uint64_t val = 0;
+    int ret = 0;
+    EsrEl2 esr = { .raw = ctx->Syndrome };
+    uint32_t cm = (esr.iss >> 8) & 0x1;
 
     assert(syn_get_ec(syndrome) == EC_DATAABORT);
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
+    static const struct arm_emul_ops whpx_arm_emul_ops = {
+        .get_reg = whpx_get_gp_reg,
+        .set_reg = whpx_set_gp_reg,
+    };
+
+    ret = arm_emulate_mmio(cpu, esr, ctx->Gpa, &whpx_arm_emul_ops);
+    if (ret < 0) {
+        error_report("WHPX: Failed to handle MMIO, syndrome=0x%llx, gpa=0x%llx",
+                     esr.raw, ctx->Gpa);
+        return -1;
     }
 
     return 0;

-- 
2.45.4


