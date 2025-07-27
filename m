Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAA7C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwQT-00064e-Uc; Sun, 27 Jul 2025 04:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPK-0001HJ-RI
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPI-0004jH-6c
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2400f746440so1203245ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603615; x=1754208415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxBCi6sSWmDnM4iJ4ormMiI3d1NPG8eHi+yGWtcyMy8=;
 b=TfrPpl1JwGA+1W55c6Q3Qay7ZmAGRiOxwbbrSqhCxvFCXKk4YR94LPuHrsOcemr6j1
 dsSVgCF32Lj/+nkEtyWLvSaTKI8JNFYoxjUwCFwCSe4u9iEUV2jZhDco/42YridlR2n4
 IAqvBdwzhwYePU1DarMLgkr3XONs9C/Zy94HqUGp/KYCe0dAxwaNN18UNMArqQ7U41zC
 w+Ew2RriXyJxrv01TSNM2zflyzTb6iN5PUnrRmiABWrxC4fq2iXGcBkRxbVrcpLSo7DA
 VAoTSlvwyarWh8gcwQVimsZawEjZ4jBvNHun168rn4p1/5E2XVqW7xNCg71dF/9poqu+
 6p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603615; x=1754208415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxBCi6sSWmDnM4iJ4ormMiI3d1NPG8eHi+yGWtcyMy8=;
 b=WneviyKgR7awA6CirxG8YyA718Gj0X9cYhm3YpUCQDHAfoVftX1+iFu3TCOlUFkGUQ
 MWR8XBHRZeAz5QOr5hOIVvu91R1vH4UoM8x76lhYrzwLPjZf8IG6EWKcpFjOv4qOIAS+
 4NF0nlZkAQBVLk4eWfYrGukf7JdSiE4DXLOn8ZykDtOhCFMZkRFmvxY/rtjFmb2iRhNX
 Yj52FBySk/hi2dpatAOc/nOZMKSDQRKbdBIf+FmZ+o2XHOOqcLcm/eoe3FiZAUf/UFUT
 AUxB2YTmc4PUdQcM3DB9lo1/nmMpRbj/kOM7bhbOg8Fay19t5WyCoEs/oWjUuYNFEoBU
 My8A==
X-Gm-Message-State: AOJu0YwihHuO91OrnFD82awMKsXTYl7Q+mNWePR0D+zZaLyJ602HheWx
 SZjYfdTNVTHxz9yrC+Cc9+p2YFq6A+AA9TiBrMtZIsvz5PAR7BJ3/Q+/SlJDx60xTG1W9luti7B
 cq+Zu
X-Gm-Gg: ASbGncsYehDAUlBTCeytVfjxmUnrJKRmc6T4XqH/NXWOl1gnFopr0gcsYJH8IjM9n2O
 ETTcKuHPdNSQeOBoIDY5GOKAkc8rdrRm8B//evE303NtK6uPbPk70RStPjTIh/QNkDyF88ynR6R
 3eU6qU+60NCwLGjR2K3FFaA18yJTQqAVGU5KOsEJ3yp56ZKOmpKHimk971zEKJnRotUJEzc+B6N
 OTwOL0ebfq8qQ/Iy1Hh8aZS4h/992ifArjWRsD56l0L1eMG8xRorBCNiFfcOUWGqTJXHCfAMkjF
 TXRe4q/l2LSN+egUsaRyUxO+PVCxfknyNd1ZUVQeUMjf9MkKkiPyx9LieiiC87+RV8+wfRgBF3i
 yv4ov3HB5nUFc5CIMgjeaS321Rsy9EyXGii9e7dmJEF/tLeHUxF4TnnAiDA2koeUs3/yXT4VMNF
 IORiUfM4To8bthWYdi3Sru
X-Google-Smtp-Source: AGHT+IHHJXTt10nz7F3w65yOPRkbceLMtVqmREy5ERgr/fyCAtvA772otsplnIfyqy0BXYS0riKUDg==
X-Received: by 2002:a17:903:1b05:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-23fb30e42a3mr127813815ad.38.1753603614630; 
 Sun, 27 Jul 2025 01:06:54 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 47/82] target/arm: Expand pstate to 64 bits
Date: Sat, 26 Jul 2025 22:02:19 -1000
Message-ID: <20250727080254.83840-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ARM now defines 36 bits in SPSR_ELx in aarch64 mode, so
it's time to bite the bullet and extend PSTATE to match.

Most changes are straightforward, adjusting printf formats,
changing local variable types.  More complex is migration,
where to maintain backward compatibility a new pstate64
record is introduced, and only when one of the extensions
that sets bits 32-35 are active.

The fate of gdbstub is left undecided for the moment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  8 +++---
 target/arm/tcg/translate.h  | 20 ++++++-------
 target/arm/cpu.c            |  6 ++--
 target/arm/gdbstub64.c      |  1 +
 target/arm/helper.c         | 11 ++++----
 target/arm/machine.c        | 56 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-a64.c |  2 +-
 7 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 98360b70b8..7769c4ae3c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -268,7 +268,7 @@ typedef struct CPUArchState {
     uint64_t xregs[32];
     uint64_t pc;
     /* PSTATE isn't an architectural register for ARMv8. However, it is
-     * convenient for us to assemble the underlying state into a 32 bit format
+     * convenient for us to assemble the underlying state into a 64 bit format
      * identical to the architectural format used for the SPSR. (This is also
      * what the Linux kernel's 'pstate' field in signal handlers and KVM's
      * 'pstate' register are.) Of the PSTATE bits:
@@ -280,7 +280,7 @@ typedef struct CPUArchState {
      *  SM and ZA are kept in env->svcr
      *  all other bits are stored in their correct places in env->pstate
      */
-    uint32_t pstate;
+    uint64_t pstate;
     bool aarch64; /* True if CPU is in aarch64 state; inverse of PSTATE.nRW */
     bool thumb;   /* True if CPU is in thumb mode; cpsr[5] */
 
@@ -1556,7 +1556,7 @@ static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handler)
  * interprocessing, so we don't attempt to sync with the cpsr state used by
  * the 32 bit decoder.
  */
-static inline uint32_t pstate_read(CPUARMState *env)
+static inline uint64_t pstate_read(CPUARMState *env)
 {
     int ZF;
 
@@ -1566,7 +1566,7 @@ static inline uint32_t pstate_read(CPUARMState *env)
         | env->pstate | env->daif | (env->btype << 10);
 }
 
-static inline void pstate_write(CPUARMState *env, uint32_t val)
+static inline void pstate_write(CPUARMState *env, uint64_t val)
 {
     env->ZF = (~val) & PSTATE_Z;
     env->NF = val;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e63dad2b6..1479f5bf74 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -378,27 +378,27 @@ static inline TCGv_i32 get_ahp_flag(void)
 }
 
 /* Set bits within PSTATE.  */
-static inline void set_pstate_bits(uint32_t bits)
+static inline void set_pstate_bits(uint64_t bits)
 {
-    TCGv_i32 p = tcg_temp_new_i32();
+    TCGv_i64 p = tcg_temp_new_i64();
 
     tcg_debug_assert(!(bits & CACHED_PSTATE_BITS));
 
-    tcg_gen_ld_i32(p, tcg_env, offsetof(CPUARMState, pstate));
-    tcg_gen_ori_i32(p, p, bits);
-    tcg_gen_st_i32(p, tcg_env, offsetof(CPUARMState, pstate));
+    tcg_gen_ld_i64(p, tcg_env, offsetof(CPUARMState, pstate));
+    tcg_gen_ori_i64(p, p, bits);
+    tcg_gen_st_i64(p, tcg_env, offsetof(CPUARMState, pstate));
 }
 
 /* Clear bits within PSTATE.  */
-static inline void clear_pstate_bits(uint32_t bits)
+static inline void clear_pstate_bits(uint64_t bits)
 {
-    TCGv_i32 p = tcg_temp_new_i32();
+    TCGv_i64 p = tcg_temp_new_i64();
 
     tcg_debug_assert(!(bits & CACHED_PSTATE_BITS));
 
-    tcg_gen_ld_i32(p, tcg_env, offsetof(CPUARMState, pstate));
-    tcg_gen_andi_i32(p, p, ~bits);
-    tcg_gen_st_i32(p, tcg_env, offsetof(CPUARMState, pstate));
+    tcg_gen_ld_i64(p, tcg_env, offsetof(CPUARMState, pstate));
+    tcg_gen_andi_i64(p, p, ~bits);
+    tcg_gen_st_i64(p, tcg_env, offsetof(CPUARMState, pstate));
 }
 
 /* If the singlestep state is Active-not-pending, advance to Active-pending. */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9318c5325..ec63297165 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1208,7 +1208,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    uint32_t psr = pstate_read(env);
+    uint64_t psr = pstate_read(env);
     int i, j;
     int el = arm_current_el(env);
     uint64_t hcr = arm_hcr_el2_eff(env);
@@ -1230,7 +1230,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     } else {
         ns_status = "";
     }
-    qemu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
+    qemu_fprintf(f, "PSTATE=%016" PRIx64 " %c%c%c%c %sEL%d%c",
                  psr,
                  psr & PSTATE_N ? 'N' : '-',
                  psr & PSTATE_Z ? 'Z' : '-',
@@ -1247,7 +1247,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      (FIELD_EX64(env->svcr, SVCR, SM) ? 'S' : '-'));
     }
     if (cpu_isar_feature(aa64_bti, cpu)) {
-        qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
+        qemu_fprintf(f, "  BTYPE=%d", (int)(psr & PSTATE_BTYPE) >> 10);
     }
     qemu_fprintf(f, "%s%s%s",
                  (hcr & HCR_NV) ? " NV" : "",
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 64ee9b3b56..3cef47281a 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 32:
         return gdb_get_reg64(mem_buf, env->pc);
     case 33:
+        /* pstate is now a 64-bit value; can we simply adjust the xml? */
         return gdb_get_reg32(mem_buf, pstate_read(env));
     }
     /* Unknown register.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f006ecabf3..e404ba0f71 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9185,8 +9185,8 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
     vaddr addr = env->cp15.vbar_el[new_el];
-    unsigned int new_mode = aarch64_pstate_mode(new_el, true);
-    unsigned int old_mode;
+    uint64_t new_mode = aarch64_pstate_mode(new_el, true);
+    uint64_t old_mode;
     unsigned int cur_el = arm_current_el(env);
     int rt;
 
@@ -9334,7 +9334,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                  * If NV2 is disabled, change SPSR when NV,NV1 == 1,0 (I_ZJRNN)
                  * If NV2 is enabled, change SPSR when NV is 1 (I_DBTLM)
                  */
-                old_mode = deposit32(old_mode, 2, 2, 2);
+                old_mode = deposit64(old_mode, 2, 2, 2);
             }
         }
     } else {
@@ -9347,7 +9347,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
-    qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%x\n", old_mode);
+    qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%" PRIx64 "\n", old_mode);
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
@@ -9401,7 +9401,8 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
     env->pc = addr;
 
-    qemu_log_mask(CPU_LOG_INT, "...to EL%d PC 0x%" PRIx64 " PSTATE 0x%x\n",
+    qemu_log_mask(CPU_LOG_INT, "...to EL%d PC 0x%" PRIx64
+                  " PSTATE 0x%" PRIx64 "\n",
                   new_el, env->pc, pstate_read(env));
 }
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8dbeca2867..9b00c14b4a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -836,6 +836,61 @@ static const VMStateInfo vmstate_cpsr = {
     .put = put_cpsr,
 };
 
+static int get_pstate64_1(QEMUFile *f, void *opaque, size_t size,
+                          const VMStateField *field)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val = qemu_get_be64(f);
+
+    env->aarch64 = ((val & PSTATE_nRW) == 0);
+    pstate_write(env, val);
+    return 0;
+}
+
+static int put_pstate64_1(QEMUFile *f, void *opaque, size_t size,
+                          const VMStateField *field, JSONWriter *vmdesc)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val = pstate_read(env);
+
+    qemu_put_be64(f, val);
+    return 0;
+}
+
+static const VMStateInfo vmstate_pstate64_1 = {
+    .name = "pstate64",
+    .get = get_pstate64_1,
+    .put = put_pstate64_1,
+};
+
+static bool pstate64_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return is_a64(env) && pstate_read(env) > UINT32_MAX;
+}
+
+static const VMStateDescription vmstate_pstate64 = {
+    .name = "cpu/pstate64",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pstate64_needed,
+    .fields = (const VMStateField[]) {
+        {
+            .name = "pstate64",
+            .version_id = 0,
+            .size = sizeof(uint64_t),
+            .info = &vmstate_pstate64_1,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int get_power(QEMUFile *f, void *opaque, size_t size,
                     const VMStateField *field)
 {
@@ -1119,6 +1174,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
+        &vmstate_pstate64,
         NULL
     }
 };
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 71c6c44ee8..f61adf1f80 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -639,7 +639,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
     unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
-    uint32_t spsr = env->banked_spsr[spsr_idx];
+    uint64_t spsr = env->banked_spsr[spsr_idx];
     int new_el;
     bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
 
-- 
2.43.0


