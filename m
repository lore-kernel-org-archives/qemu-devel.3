Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9628CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ldX-0006m1-8n; Mon, 22 Sep 2025 14:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcP-0005JF-SO
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc6-0004UD-In
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:33 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77ee6e252e5so2905580b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567011; x=1759171811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzRq+g7qBeC/3U/opiG/f/Q7ctgJstcdudImAw6mqiY=;
 b=M6R7cgJzELv1fJT+lSxPWoL1Tq98lSS5fXW0aJTBDE91LrdGfi/Dg/adecyY4YLcMy
 eQFmAyvactcYQ6pAfcXalQeX6QbQ1CAytQZKGqQGc75MD9blEtUpzcYtvuGV9fdnqUyH
 EGaoQntB/2ADMu2XCqfzK1+VZ9RNp2BLieUx0aDeN717RjvNQjZMcSzelbuI/XOUdreS
 rRhuSSUDfqObQnMFQ4SmGJbcsrIdAR4E47mW7EfyV8Du1Knlc6OQEz1D3Mb6Li9uZIX2
 1cfXeTIFLk8SAzaCgDlnrF2CIFiWXy31qQHsyIrUUT1ld3xdaX5t7ywnc34UTRCcPKhv
 +hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567011; x=1759171811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzRq+g7qBeC/3U/opiG/f/Q7ctgJstcdudImAw6mqiY=;
 b=Fgtn3xvb8n8H4kip2kkXoksiKV/RQP0RLzIBWfVPWx842cvJaLSN+oBWvCY/hKB6tA
 up7F+IwE+wlyuvsdsvr4tjLrBaOHD0LzDeGx8xFW+CgxvnncLGznuBVJnkYjont2Cxv9
 4B3h9r6fVIk9U5Xi9bKdJtEAYAInSY01XqEbmYcEjoSJwhfYGjogpOUecTIS9kbR+dwY
 lygIUEaK25PwpudyZreblA7NJqmOJHiFMxryq76VHtGzbdD8FbjgDOqkOvN0DHu/sIYV
 MOJ09QHOg1bc5Ku0S+7VlvC4VU+I6aqC9odzypYzNskTPH1rZcIgGGpnyEXYHw7YVIhl
 PAOA==
X-Gm-Message-State: AOJu0Yw6JhLaPfVu52iNIS2EHfhW762ZbXLsSmcGcB/jFROOpvqjdsbB
 mSxUBTA7X4rXq8XPo2OVl62ciHDRg2uMxwtVF5K7B2o4XNtqs1F0KCwy+gQ48qsVyBn22pJVJ3q
 orHAA
X-Gm-Gg: ASbGncttA0F67Nni3EaJQ3MHQAjUtNOeEqO+xnEiPEY6BfhwFyG8+BgpYgspPohgTZv
 p/AyN/+WNBO3/ndz4dxFKU9oMxOUMuOo1+UyOJ26GyJPVQRli8qNQyOBnUxL3X7gLP18fqr9rhw
 5Z9+zOBJwqdgaoMPDTncTXPHb7skw71lzDNUnMsw592eJiqrEmJPQSPCZaA4LlW0uiLY+U0jkwH
 VniY7/wKYF3XXA96SJYTbE/04/H29j3hBOyzk6dGvJiR9AOe8lahgO/5IiOw72kU/vUFFfFvPTf
 fH2qCp5y/m7CppIr4VySVI16/NgOb7t9gdTY/RvTyUXUZq4w8ZZUtNzH2OJr3lBgpXohRSYdRYM
 enUYWlhIFyu8Kx0eb9Q6zghtMBuIU2okBLmwT/mQ=
X-Google-Smtp-Source: AGHT+IE7HL+cf2mZo8I2cW3KyeMmiIu4mkcR+lyvgPftZdhAAhwnklipFYpUn9fEqEFzdeJfnUPKzQ==
X-Received: by 2002:a05:6a00:2ea9:b0:776:12ea:c737 with SMTP id
 d2e1a72fcca58-77e4f48f20fmr14052063b3a.23.1758567011534; 
 Mon, 22 Sep 2025 11:50:11 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 39/76] target/arm: Expand pstate to 64 bits
Date: Mon, 22 Sep 2025 11:48:47 -0700
Message-ID: <20250922184924.2754205-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  8 ++--
 target/arm/tcg/translate.h  | 20 ++++-----
 target/arm/cpu.c            |  6 +--
 target/arm/gdbstub64.c      |  2 +
 target/arm/helper.c         | 11 ++---
 target/arm/machine.c        | 81 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-a64.c |  2 +-
 7 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6a214557ac..c79393d9c2 100644
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
 
@@ -1538,7 +1538,7 @@ static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handler)
  * interprocessing, so we don't attempt to sync with the cpsr state used by
  * the 32 bit decoder.
  */
-static inline uint32_t pstate_read(CPUARMState *env)
+static inline uint64_t pstate_read(CPUARMState *env)
 {
     int ZF;
 
@@ -1548,7 +1548,7 @@ static inline uint32_t pstate_read(CPUARMState *env)
         | env->pstate | env->daif | (env->btype << 10);
 }
 
-static inline void pstate_write(CPUARMState *env, uint32_t val)
+static inline void pstate_write(CPUARMState *env, uint64_t val)
 {
     env->ZF = (~val) & PSTATE_Z;
     env->NF = val;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 761edded52..943dfd45fe 100644
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
index aab7250399..731b4d5725 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1190,7 +1190,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    uint32_t psr = pstate_read(env);
+    uint64_t psr = pstate_read(env);
     int i, j;
     int el = arm_current_el(env);
     uint64_t hcr = arm_hcr_el2_eff(env);
@@ -1212,7 +1212,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     } else {
         ns_status = "";
     }
-    qemu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
+    qemu_fprintf(f, "PSTATE=%016" PRIx64 " %c%c%c%c %sEL%d%c",
                  psr,
                  psr & PSTATE_N ? 'N' : '-',
                  psr & PSTATE_Z ? 'Z' : '-',
@@ -1229,7 +1229,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      (FIELD_EX64(env->svcr, SVCR, SM) ? 'S' : '-'));
     }
     if (cpu_isar_feature(aa64_bti, cpu)) {
-        qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
+        qemu_fprintf(f, "  BTYPE=%d", (int)(psr & PSTATE_BTYPE) >> 10);
     }
     qemu_fprintf(f, "%s%s%s",
                  (hcr & HCR_NV) ? " NV" : "",
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 3bccde2bf2..65d6bbe65f 100644
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
@@ -75,6 +76,7 @@ int aarch64_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 8;
     case 33:
         /* CPSR */
+        /* pstate is now a 64-bit value; can we simply adjust the xml? */
         pstate_write(env, tmp);
         return 4;
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f32eb7a9d..37cfd2064c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8947,8 +8947,8 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
     vaddr addr = env->cp15.vbar_el[new_el];
-    unsigned int new_mode = aarch64_pstate_mode(new_el, true);
-    unsigned int old_mode;
+    uint64_t new_mode = aarch64_pstate_mode(new_el, true);
+    uint64_t old_mode;
     unsigned int cur_el = arm_current_el(env);
     int rt;
 
@@ -9096,7 +9096,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                  * If NV2 is disabled, change SPSR when NV,NV1 == 1,0 (I_ZJRNN)
                  * If NV2 is enabled, change SPSR when NV is 1 (I_DBTLM)
                  */
-                old_mode = deposit32(old_mode, 2, 2, 2);
+                old_mode = deposit64(old_mode, 2, 2, 2);
             }
         }
     } else {
@@ -9109,7 +9109,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
-    qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%x\n", old_mode);
+    qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%" PRIx64 "\n", old_mode);
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
@@ -9163,7 +9163,8 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
     env->pc = addr;
 
-    qemu_log_mask(CPU_LOG_INT, "...to EL%d PC 0x%" PRIx64 " PSTATE 0x%x\n",
+    qemu_log_mask(CPU_LOG_INT, "...to EL%d PC 0x%" PRIx64
+                  " PSTATE 0x%" PRIx64 "\n",
                   new_el, env->pc, pstate_read(env));
 }
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index ce20b46f50..44a0cf844b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -816,6 +816,80 @@ static const VMStateInfo vmstate_cpsr = {
     .put = put_cpsr,
 };
 
+static int get_pstate64(QEMUFile *f, void *opaque, size_t size,
+                        const VMStateField *field)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val = qemu_get_be64(f);
+
+    env->aarch64 = ((val & PSTATE_nRW) == 0);
+    if (is_a64(env)) {
+        pstate_write(env, val);
+    } else {
+        cpsr_write_from_spsr_elx(env, val);
+    }
+    return 0;
+}
+
+static int put_pstate64(QEMUFile *f, void *opaque, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val;
+
+    if (is_a64(env)) {
+        val = pstate_read(env);
+    } else {
+        val = cpsr_read_for_spsr_elx(env);
+    }
+    qemu_put_be64(f, val);
+    return 0;
+}
+
+static bool pstate64_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val;
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (is_a64(env)) {
+        val = pstate_read(env);
+    } else {
+        val = cpsr_read_for_spsr_elx(env);
+        if (val & PSTATE_SS) {
+            return true;
+        }
+    }
+    return val > UINT32_MAX;
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
+            .info = &(const VMStateInfo) {
+                .name = "pstate64",
+                .get = get_pstate64,
+                .put = put_pstate64,
+            },
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
@@ -1052,6 +1126,12 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
         VMSTATE_UINT64_ARRAY(env.xregs, ARMCPU, 32),
         VMSTATE_UINT64(env.pc, ARMCPU),
+        /*
+         * If any bits are set in the upper 32 bits of cpsr/pstate,
+         * or if the cpu is in aa32 mode and PSTATE.SS is set, then
+         * the cpu/pstate64 subsection will override this with the
+         * full 64 bit state.
+         */
         {
             .name = "cpsr",
             .version_id = 0,
@@ -1128,6 +1208,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
         &vmstate_syndrome64,
+        &vmstate_pstate64,
         NULL
     }
 };
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index eaea7859d3..08b7db7c46 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -620,7 +620,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
     unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
-    uint32_t spsr = env->banked_spsr[spsr_idx];
+    uint64_t spsr = env->banked_spsr[spsr_idx];
     int new_el;
     bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
 
-- 
2.43.0


