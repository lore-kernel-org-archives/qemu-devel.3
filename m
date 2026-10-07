Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA399CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENrf-0003GP-Bf; Wed, 07 Oct 2026 05:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9u-00017o-Rj; Wed, 07 Oct 2026 04:37:55 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9s-0006Vx-Fg; Wed, 07 Oct 2026 04:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=90kJrzXKeW2gQ5phrCgvAcOrYXMsIgBsYY/SG/YHEks=; b=it5oYwcCqJcYfad
 DOmrYShGDRAY1v8zropZgEYA1BD8Ca7UL+X/4szUHH4sISFr8Alsn8HUJn3uM1FvFMhCbXPdHAqiV
 bglsf7CxvHdUqHFEtWbTSAbUhak7M8AwlfCETu/Skwx9t+gQ6P+bqfeXTgR5Wpu+XmFwarEqqCsDB
 dA=;
Date: Wed, 07 Oct 2026 10:43:07 +0200
Subject: [PATCH v2 01/18] target/riscv: Make internals.h target agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-1-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362619; l=9261;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=J8KLZpcqlWHHQAJUXicA4FUB2Btk89ebiXNEFg/f3Wo=;
 b=qDEfJOMoT0oSTG+RhjIQFvStVt3FbC/waG1L98X7tooIUpLltC1j5wh9aOWKT2UkduWP6LjkD
 eyv2PnTnOPHDyng7UAOnueC8mdCC11aCG5IZP1WVIW3BoF24wYLmoJu
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces uses of target_ulong with fixed-size integers, this is a
prerequisite step to compiling cpu.c once for system-mode.

Note: the widening of target_long to int64_t in adjust_addr_body() is
safe as rv32 is ruled out earlier in the function via the check

  /* do nothing for rv32 mode */
  if (riscv_cpu_mxl(env) == MXL_RV32) {
      return addr;
  }

meaning target_long must be equal to int64_t anyway.

Duplicate includes between vector_helper.c and vector_internals.h are
removed.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/internals.h            | 31 +++++++++---------
 target/riscv/tcg/vector_internals.h |  5 +--
 target/riscv/tcg/vector_helper.c    | 64 +++++++++++++++++--------------------
 3 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 1ee7e99e98..c963fae321 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -20,7 +20,6 @@
 #define RISCV_CPU_INTERNALS_H
 
 #include "exec/cpu-common.h"
-#include "exec/target_long.h"
 #include "hw/core/registerfields.h"
 #include "fpu/softfloat-types.h"
 #include "target/riscv/cpu_bits.h"
@@ -98,10 +97,10 @@ FIELD(VDATA, NF, 7, 4)
 FIELD(VDATA, WD, 7, 1)
 
 /* float point classify helpers */
-target_ulong fclass_h_bf16(uint64_t frs1);
-target_ulong fclass_h(uint64_t frs1);
-target_ulong fclass_s(uint64_t frs1);
-target_ulong fclass_d(uint64_t frs1);
+uint16_t fclass_h_bf16(bfloat16 frs1);
+uint16_t fclass_h(float16 frs1);
+uint16_t fclass_s(float32 frs1);
+uint16_t fclass_d(float64 frs1);
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_riscv_cpu;
@@ -185,7 +184,7 @@ static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
     }
 }
 
-static inline target_ulong get_xepc_mask(CPURISCVState *env)
+static inline uint64_t get_xepc_mask(CPURISCVState *env)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -196,9 +195,9 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
     if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
         cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
         cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
-        return ~(target_ulong)1;
+        return ~1ull;
     } else {
-        return ~(target_ulong)3;
+        return ~3ull;
     }
 }
 
@@ -208,9 +207,9 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 /* Zjpm addr masking routine */
-static inline target_ulong adjust_addr_body(CPURISCVState *env,
-                                            target_ulong addr,
-                                            bool is_virt_addr)
+static inline uint64_t adjust_addr_body(CPURISCVState *env,
+                                        uint64_t addr,
+                                        bool is_virt_addr)
 {
     RISCVPmPmm pmm = PMM_FIELD_DISABLED;
     uint32_t pmlen = 0;
@@ -239,7 +238,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     /* sign/zero extend masked address by N-1 bit */
     if (signext) {
-        addr = (target_long)addr >> pmlen;
+        addr = (int64_t)addr >> pmlen;
     } else {
         addr = addr >> pmlen;
     }
@@ -247,14 +246,14 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
     return addr;
 }
 
-static inline target_ulong adjust_addr(CPURISCVState *env,
-                                       target_ulong addr)
+static inline uint64_t adjust_addr(CPURISCVState *env,
+                                   uint64_t addr)
 {
     return adjust_addr_body(env, addr, false);
 }
 
-static inline target_ulong adjust_addr_virt(CPURISCVState *env,
-                                            target_ulong addr)
+static inline uint64_t adjust_addr_virt(CPURISCVState *env,
+                                        uint64_t addr)
 {
     return adjust_addr_body(env, addr, true);
 }
diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
index 5681b81815..7e186add2d 100644
--- a/target/riscv/tcg/vector_internals.h
+++ b/target/riscv/tcg/vector_internals.h
@@ -20,10 +20,11 @@
 #define TARGET_RISCV_VECTOR_INTERNALS_H
 
 #include "qemu/bitops.h"
+#include "exec/target_long.h"
 #include "hw/core/registerfields.h"
-#include "cpu.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/internals.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "internals.h"
 
 #define VSTART_CHECK_EARLY_EXIT(env, vl) do { \
     if (env->vstart >= vl) {                  \
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 0d1e4e0964..b4a07dbe13 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/bitops.h"
-#include "cpu.h"
+#include "target/riscv/tcg/vector_internals.h"
 #include "exec/memop.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
@@ -29,8 +29,6 @@
 #include "exec/target_page.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "internals.h"
-#include "vector_internals.h"
 #include <math.h>
 
 static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
@@ -4852,77 +4850,73 @@ GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
 GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
 
 /* Vector Floating-Point Classify Instruction */
-target_ulong fclass_h_bf16(uint64_t frs1)
+uint16_t fclass_h_bf16(bfloat16 frs1)
 {
-    bfloat16 f = frs1;
-    bool sign = bfloat16_is_neg(f);
+    bool sign = bfloat16_is_neg(frs1);
 
-    if (bfloat16_is_infinity(f)) {
+    if (bfloat16_is_infinity(frs1)) {
         return sign ? 1 << 0 : 1 << 7;
-    } else if (bfloat16_is_zero(f)) {
+    } else if (bfloat16_is_zero(frs1)) {
         return sign ? 1 << 3 : 1 << 4;
-    } else if (bfloat16_is_zero_or_denormal(f)) {
+    } else if (bfloat16_is_zero_or_denormal(frs1)) {
         return sign ? 1 << 2 : 1 << 5;
-    } else if (bfloat16_is_any_nan(f)) {
+    } else if (bfloat16_is_any_nan(frs1)) {
         float_status s = { }; /* for snan_bit_is_one */
-        return bfloat16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+        return bfloat16_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
     } else {
         return sign ? 1 << 1 : 1 << 6;
     }
 }
 
-target_ulong fclass_h(uint64_t frs1)
+uint16_t fclass_h(float16 frs1)
 {
-    float16 f = frs1;
-    bool sign = float16_is_neg(f);
+    bool sign = float16_is_neg(frs1);
 
-    if (float16_is_infinity(f)) {
+    if (float16_is_infinity(frs1)) {
         return sign ? 1 << 0 : 1 << 7;
-    } else if (float16_is_zero(f)) {
+    } else if (float16_is_zero(frs1)) {
         return sign ? 1 << 3 : 1 << 4;
-    } else if (float16_is_zero_or_denormal(f)) {
+    } else if (float16_is_zero_or_denormal(frs1)) {
         return sign ? 1 << 2 : 1 << 5;
-    } else if (float16_is_any_nan(f)) {
+    } else if (float16_is_any_nan(frs1)) {
         float_status s = { }; /* for snan_bit_is_one */
-        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+        return float16_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
     } else {
         return sign ? 1 << 1 : 1 << 6;
     }
 }
 
-target_ulong fclass_s(uint64_t frs1)
+uint16_t fclass_s(float32 frs1)
 {
-    float32 f = frs1;
-    bool sign = float32_is_neg(f);
+    bool sign = float32_is_neg(frs1);
 
-    if (float32_is_infinity(f)) {
+    if (float32_is_infinity(frs1)) {
         return sign ? 1 << 0 : 1 << 7;
-    } else if (float32_is_zero(f)) {
+    } else if (float32_is_zero(frs1)) {
         return sign ? 1 << 3 : 1 << 4;
-    } else if (float32_is_zero_or_denormal(f)) {
+    } else if (float32_is_zero_or_denormal(frs1)) {
         return sign ? 1 << 2 : 1 << 5;
-    } else if (float32_is_any_nan(f)) {
+    } else if (float32_is_any_nan(frs1)) {
         float_status s = { }; /* for snan_bit_is_one */
-        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+        return float32_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
     } else {
         return sign ? 1 << 1 : 1 << 6;
     }
 }
 
-target_ulong fclass_d(uint64_t frs1)
+uint16_t fclass_d(float64 frs1)
 {
-    float64 f = frs1;
-    bool sign = float64_is_neg(f);
+    bool sign = float64_is_neg(frs1);
 
-    if (float64_is_infinity(f)) {
+    if (float64_is_infinity(frs1)) {
         return sign ? 1 << 0 : 1 << 7;
-    } else if (float64_is_zero(f)) {
+    } else if (float64_is_zero(frs1)) {
         return sign ? 1 << 3 : 1 << 4;
-    } else if (float64_is_zero_or_denormal(f)) {
+    } else if (float64_is_zero_or_denormal(frs1)) {
         return sign ? 1 << 2 : 1 << 5;
-    } else if (float64_is_any_nan(f)) {
+    } else if (float64_is_any_nan(frs1)) {
         float_status s = { }; /* for snan_bit_is_one */
-        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+        return float64_is_quiet_nan(frs1, &s) ? 1 << 9 : 1 << 8;
     } else {
         return sign ? 1 << 1 : 1 << 6;
     }

-- 
2.52.0


