Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E658E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBE6-0002Vx-Ip; Tue, 24 Dec 2024 15:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDm-0000Df-G8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDi-00031X-IL
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:38 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso53770415ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070973; x=1735675773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQjeFmlwXi1lZLuV5C0dso81HNv2ocXCvP6mdxjNCCQ=;
 b=xKElD0MArl+oIbQFDe/mPSA6zVyDJ2lE5cZBxqg21hY7Sr5DwD6RAT48vyXO+y6YTe
 u81dqP5nK/qMAgfopmvvgVeFqRQGJEIUsZDK3B8bXazYYbldCFiJ+7EcRBvACDoxUM3Q
 yOe0iycTJdrpnrlB98tp11cC84zH8nlDugLXyFatKtNq8UxDylmOdF6GBJJCW8yH6JHM
 Q6qG+16VWjyrAsGYxBSeA2gHM/kQVe42rsXhiioS2BAr8T4WbuA/jsqts3l4XmcwuadL
 goF1OTg0AB7XckvRkoO5p/dDa4xHroTQdC7M9inLW6cUMKRNyGmkXfh5q4WUJKNs2lHL
 KSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070973; x=1735675773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQjeFmlwXi1lZLuV5C0dso81HNv2ocXCvP6mdxjNCCQ=;
 b=iyzI/27iZ3QfxFC48/sAl8ceyf6R2mjpKr9Uds/0ZqYh9yZ07t/wg0N+WZV7LssQ+9
 i1cNFhQaXPMs7qwdCxlR71NaafJ6O6/9nUMukg6F87LqDTgUrTrns+BIHy+h1HpDNt16
 INPay3t2LA0y/9nam3AaVrm5QxY2kduVHpnK4T5i2FkFR1PvVIUHup+vFyCDTkNmlvcx
 nycXRTbwQcwOCm974zjh7f7IPUC7MlYCgcRPMwVu2o4HvRDN+URnqRfrO3QPeE50jTDN
 EZCWexUWbyk0xm4qT4ct18pyo3aDqrojNMWescrHLWAmdpBlMyY9p7C786hDrPMR6lKA
 +tQA==
X-Gm-Message-State: AOJu0YyXhwNnf9rLwEraqZ1Nf2obXZqScKgppEXTJpQIpXE4qDYyVYpA
 eJ7XMD5bj4yxU5xzn1N4ki2HFqrUrxTEeFBr5tG7sAlzsGWwKUJ2geNpCDcQMe7UMZCq2MIor9t
 pl1M=
X-Gm-Gg: ASbGncs55qzkVXUZVz2P9ToMLipNPX+QiquGgwvK6g1oZa7pWEYjT2GS9RWAkVqW/xQ
 j+W/dGBdRZaNRsSeCFGmIHnltDm2KgDYE2P/HPoj0S6HBuo3HLUlBk3wHRkQK9OfCECaIogV9Ez
 v4URHeJ08bCu2poBzQybimaTYXYRnJnOlOyGqA+WffrcHFLTFdpTp9JupDC7Zr9HObJ7cmQSC2i
 GSjio71T+uVOyPfIH6jV0uhvKzuj22U0GR8LHZpMPEicE4BQTEwpTfMMaod0kdna+tzL4NdhmHF
 jqgZaaMiwnZN1nqYuKB60JmLUw==
X-Google-Smtp-Source: AGHT+IFkUNnQ3C5JVyAPUPcmeh/cd26qbyaXvHD2Fk07wyNgZpdFBF5brmRcBmM9cUntU6zsEKeHCA==
X-Received: by 2002:a05:6a21:100f:b0:1e0:d848:9e83 with SMTP id
 adf61e73a8af0-1e5e07a853amr28932876637.25.1735070973033; 
 Tue, 24 Dec 2024 12:09:33 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 72/72] accel/tcg: Move gen_intermediate_code to
 TCGCPUOps.translate_core
Date: Tue, 24 Dec 2024 12:05:21 -0800
Message-ID: <20241224200521.310066-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert all targets simultaneously, as the gen_intermediate_code
function disappears from the target.  While there are possible
workarounds, they're larger than simply performing the conversion.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h        | 14 --------------
 include/hw/core/tcg-cpu-ops.h    | 13 +++++++++++++
 target/alpha/cpu.h               |  2 ++
 target/arm/internals.h           |  2 ++
 target/avr/cpu.h                 |  2 ++
 target/hexagon/cpu.h             |  2 ++
 target/hppa/cpu.h                |  2 ++
 target/i386/tcg/helper-tcg.h     |  2 ++
 target/loongarch/internals.h     |  2 ++
 target/m68k/cpu.h                |  2 ++
 target/microblaze/cpu.h          |  2 ++
 target/mips/tcg/tcg-internal.h   |  2 ++
 target/openrisc/cpu.h            |  2 ++
 target/ppc/cpu.h                 |  2 ++
 target/riscv/cpu.h               |  3 +++
 target/rx/cpu.h                  |  2 ++
 target/s390x/s390x-internal.h    |  2 ++
 target/sh4/cpu.h                 |  2 ++
 target/sparc/cpu.h               |  2 ++
 target/tricore/cpu.h             |  2 ++
 target/xtensa/cpu.h              |  2 ++
 accel/tcg/cpu-exec.c             |  8 +++++---
 accel/tcg/translate-all.c        |  8 +++++---
 target/alpha/cpu.c               |  1 +
 target/alpha/translate.c         |  4 ++--
 target/arm/cpu.c                 |  1 +
 target/arm/tcg/cpu-v7m.c         |  1 +
 target/arm/tcg/translate.c       |  5 ++---
 target/avr/cpu.c                 |  1 +
 target/avr/translate.c           |  6 +++---
 target/hexagon/cpu.c             |  1 +
 target/hexagon/translate.c       |  4 ++--
 target/hppa/cpu.c                |  1 +
 target/hppa/translate.c          |  4 ++--
 target/i386/tcg/tcg-cpu.c        |  1 +
 target/i386/tcg/translate.c      |  5 ++---
 target/loongarch/cpu.c           |  1 +
 target/loongarch/tcg/translate.c |  4 ++--
 target/m68k/cpu.c                |  1 +
 target/m68k/translate.c          |  4 ++--
 target/microblaze/cpu.c          |  1 +
 target/microblaze/translate.c    |  4 ++--
 target/mips/cpu.c                |  1 +
 target/mips/tcg/translate.c      |  4 ++--
 target/openrisc/cpu.c            |  1 +
 target/openrisc/translate.c      |  4 ++--
 target/ppc/cpu_init.c            |  1 +
 target/ppc/translate.c           |  4 ++--
 target/riscv/tcg/tcg-cpu.c       |  1 +
 target/riscv/translate.c         |  4 ++--
 target/rx/cpu.c                  |  1 +
 target/rx/translate.c            |  4 ++--
 target/s390x/cpu.c               |  1 +
 target/s390x/tcg/translate.c     |  4 ++--
 target/sh4/cpu.c                 |  1 +
 target/sh4/translate.c           |  4 ++--
 target/sparc/cpu.c               |  1 +
 target/sparc/translate.c         |  4 ++--
 target/tricore/cpu.c             |  1 +
 target/tricore/translate.c       |  5 ++---
 target/xtensa/cpu.c              |  1 +
 target/xtensa/translate.c        |  4 ++--
 62 files changed, 121 insertions(+), 62 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 41e2a41180..d70942a10f 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -21,20 +21,6 @@
 #include "qemu/bswap.h"
 #include "exec/vaddr.h"
 
-/**
- * gen_intermediate_code
- * @cpu: cpu context
- * @tb: translation block
- * @max_insns: max number of instructions to translate
- * @pc: guest virtual program counter address
- * @host_pc: host physical program counter address
- *
- * This function must be provided by the target, which should create
- * the target-specific DisasContext, and then invoke translator_loop.
- */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc);
-
 /**
  * DisasJumpType:
  * @DISAS_NEXT: Next instruction in program order.
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 663efb9133..2e3f1690f1 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -24,6 +24,19 @@ struct TCGCPUOps {
      * Called when the first CPU is realized.
      */
     void (*initialize)(void);
+    /**
+     * @translate_code: Translate guest instructions to TCGOps
+     * @cpu: cpu context
+     * @tb: translation block
+     * @max_insns: max number of instructions to translate
+     * @pc: guest virtual program counter address
+     * @host_pc: host physical program counter address
+     *
+     * This function must be provided by the target, which should create
+     * the target-specific DisasContext, and then invoke translator_loop.
+     */
+    void (*translate_code)(CPUState *cpu, TranslationBlock *tb,
+                           int *max_insns, vaddr pc, void *host_pc);
     /**
      * @synchronize_from_tb: Synchronize state from a TCG #TranslationBlock
      *
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 3556d3227f..80562adfb5 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -431,6 +431,8 @@ enum {
 };
 
 void alpha_translate_init(void);
+void alpha_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc);
 
 #define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c3a5b1385f..863a84edf8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -357,6 +357,8 @@ void init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
+void arm_translate_code(CPUState *cs, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc);
 
 void arm_cpu_register_gdb_commands(ARMCPU *cpu);
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *,
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 4725535102..06f5ae4d1b 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,6 +183,8 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
 }
 
 void avr_cpu_tcg_init(void);
+void avr_cpu_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc);
 
 int cpu_avr_exec(CPUState *cpu);
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 14e6e819c2..79e60d4bfa 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -150,6 +150,8 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
+void hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e45ba50a59..22a6510e08 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -303,6 +303,8 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
 }
 
 void hppa_translate_init(void);
+void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
+                         int *max_insns, vaddr pc, void *host_pc);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 696d6ef016..54d845379c 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -59,6 +59,8 @@ static inline target_long lshift(target_long x, int n)
 
 /* translate.c */
 void tcg_x86_init(void);
+void x86_translate_code(CPUState *cs, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc);
 
 /* excp_helper.c */
 G_NORETURN void raise_exception(CPUX86State *env, int exception_index);
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 0655ac948b..ad9cf4fc7a 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -17,6 +17,8 @@
 #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
 
 void loongarch_translate_init(void);
+void loongarch_translate_code(CPUState *cs, TranslationBlock *tb,
+                              int *max_insns, vaddr pc, void *host_pc);
 
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5bbeedb7a..ddb0f29f4a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -193,6 +193,8 @@ int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void m68k_tcg_init(void);
+void m68k_translate_code(CPUState *cs, TranslationBlock *tb,
+                         int *max_insns, vaddr pc, void *host_pc);
 void m68k_cpu_init_gdb(M68kCPU *cpu);
 uint32_t cpu_m68k_get_ccr(CPUM68KState *env);
 void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c60..f6879eee35 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -398,6 +398,8 @@ static inline void mb_cpu_write_msr(CPUMBState *env, uint32_t val)
 }
 
 void mb_tcg_init(void);
+void mb_translate_code(CPUState *cs, TranslationBlock *tb,
+                       int *max_insns, vaddr pc, void *host_pc);
 
 #define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
 
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index aef032c48d..74fc1309a7 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -16,6 +16,8 @@
 #include "cpu.h"
 
 void mips_tcg_init(void);
+void mips_translate_code(CPUState *cs, TranslationBlock *tb,
+                         int *max_insns, vaddr pc, void *host_pc);
 
 void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 G_NORETURN void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c9fe9ae12d..b97d2ffdd2 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -301,6 +301,8 @@ void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
+void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
+                             int *max_insns, vaddr pc, void *host_pc);
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2ffac2ed03..0b8b4c0517 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1581,6 +1581,8 @@ extern const VMStateDescription vmstate_ppc_cpu;
 
 /*****************************************************************************/
 void ppc_translate_init(void);
+void ppc_translate_code(CPUState *cs, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc);
 
 #if !defined(CONFIG_USER_ONLY)
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b112821..252fdb8672 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -602,6 +602,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_translate_init(void);
+void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc);
+
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uint32_t exception, uintptr_t pc);
 
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index c53593d7aa..5ba1874bd7 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -139,6 +139,8 @@ int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void rx_translate_init(void);
+void rx_translate_code(CPUState *cs, TranslationBlock *tb,
+                       int *max_insns, vaddr pc, void *host_pc);
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 
 #include "exec/cpu-all.h"
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 4cc435042c..a750e7a343 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -399,6 +399,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
 
 /* translate.c */
 void s390x_translate_init(void);
+void s390x_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc);
 void s390x_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d928bcf006..d536d5d715 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -248,6 +248,8 @@ G_NORETURN void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                uintptr_t retaddr);
 
 void sh4_translate_init(void);
+void sh4_translate_code(CPUState *cs, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc);
 
 #if !defined(CONFIG_USER_ONLY)
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5c981234bb..dda811503b 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -609,6 +609,8 @@ int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 
 /* translate.c */
 void sparc_tcg_init(void);
+void sparc_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc);
 
 /* fop_helper.c */
 target_ulong cpu_get_fsr(CPUSPARCState *);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 220af69fc2..8e431d7922 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -252,6 +252,8 @@ FIELD(TB_FLAGS, PRIV, 0, 2)
 
 void cpu_state_reset(CPUTriCoreState *s);
 void tricore_tcg_init(void);
+void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc);
 
 static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 77e48eef19..0e6302c5bd 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -617,6 +617,8 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 void xtensa_collect_sr_names(const XtensaConfig *config);
 void xtensa_translate_init(void);
+void xtensa_translate_code(CPUState *cs, TranslationBlock *tb,
+                           int *max_insns, vaddr pc, void *host_pc);
 void **xtensa_get_regfile_by_name(const char *name, int entries, int bits);
 void xtensa_breakpoint_handler(CPUState *cs);
 void xtensa_register_core(XtensaConfigList *node);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b507049ddb..d48b82a932 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1088,11 +1088,13 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
-        assert(cpu->cc->tcg_ops->cpu_exec_halt);
-        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
+        assert(tcg_ops->cpu_exec_halt);
+        assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
-        cpu->cc->tcg_ops->initialize();
+        assert(tcg_ops->translate_code);
+        tcg_ops->initialize();
         tcg_target_initialized = true;
     }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 572a8a8797..453eb20ec9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -276,8 +276,10 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
 
     tcg_func_start(tcg_ctx);
 
-    tcg_ctx->cpu = env_cpu(env);
-    gen_intermediate_code(env_cpu(env), tb, max_insns, pc, host_pc);
+    CPUState *cs = env_cpu(env);
+    tcg_ctx->cpu = cs;
+    cs->cc->tcg_ops->translate_code(cs, tb, max_insns, pc, host_pc);
+
     assert(tb->size != 0);
     tcg_ctx->cpu = NULL;
     *max_insns = tb->icount;
@@ -364,7 +366,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             /*
              * Overflow of code_gen_buffer, or the current slice of it.
              *
-             * TODO: We don't need to re-do gen_intermediate_code, nor
+             * TODO: We don't need to re-do tcg_ops->translate_code, nor
              * should we re-do the tcg optimization currently hidden
              * inside tcg_gen_code.  All that should be required is to
              * flush the TBs, allocate a new TB, re-initialize it per
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 9fa506bff9..e1b898e575 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -224,6 +224,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 
 static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
+    .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 629ff3cde9..2156c02214 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2955,8 +2955,8 @@ static const TranslatorOps alpha_tr_ops = {
     .tb_stop            = alpha_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void alpha_translate_code(CPUState *cpu, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 019183c9ea..dcedadc89e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2682,6 +2682,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
     .initialize = arm_translate_init,
+    .translate_code = arm_translate_code,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 58e54578d6..03acdf83e0 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -234,6 +234,7 @@ static void cortex_m55_initfn(Object *obj)
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
     .initialize = arm_translate_init,
+    .translate_code = arm_translate_code,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 9ee761fc64..c16b59ab88 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -8093,9 +8093,8 @@ static const TranslatorOps thumb_translator_ops = {
     .tb_stop            = arm_tr_tb_stop,
 };
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 2dccb09c5e..8a126ff322 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -207,6 +207,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 
 static const TCGCPUOps avr_tcg_ops = {
     .initialize = avr_cpu_tcg_init,
+    .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
diff --git a/target/avr/translate.c b/target/avr/translate.c
index f13b997f8d..4ab71d8138 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2599,7 +2599,7 @@ static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
  *
  *    - translate()
  *    - canonicalize_skip()
- *    - gen_intermediate_code()
+ *    - translate_code()
  *    - restore_state_to_opc()
  *
  */
@@ -2795,8 +2795,8 @@ static const TranslatorOps avr_tr_ops = {
     .tb_stop            = avr_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void avr_cpu_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &avr_tr_ops, &dc.base);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c9817c7192..0b7fc98f6c 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -325,6 +325,7 @@ static void hexagon_cpu_init(Object *obj)
 
 static const TCGCPUOps hexagon_tcg_ops = {
     .initialize = hexagon_translate_init,
+    .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
 };
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 562105705a..fe7858703c 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1026,8 +1026,8 @@ static const TranslatorOps hexagon_tr_ops = {
     .tb_stop            = hexagon_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c9062e60b6..47d0160955 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -223,6 +223,7 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 
 static const TCGCPUOps hppa_tcg_ops = {
     .initialize = hppa_translate_init,
+    .translate_code = hppa_translate_code,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d13f80fe3e..dc04f9f3c0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4869,8 +4869,8 @@ static const TranslatorOps hppa_tr_ops = {
 #endif
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
+                         int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 231ecac37d..14ee038079 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -109,6 +109,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 static const TCGCPUOps x86_tcg_ops = {
     .initialize = tcg_x86_init,
+    .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
     .cpu_exec_enter = x86_cpu_exec_enter,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 903553dc88..834aea1e59 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3814,9 +3814,8 @@ static const TranslatorOps i386_tr_ops = {
     .tb_stop            = i386_tr_tb_stop,
 };
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void x86_translate_code(CPUState *cpu, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f5bc8720d1..58415ffe99 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -795,6 +795,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 static const TCGCPUOps loongarch_tcg_ops = {
     .initialize = loongarch_translate_init,
+    .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 1fca4afc73..68be999410 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -333,8 +333,8 @@ static const TranslatorOps loongarch_tr_ops = {
     .tb_stop            = loongarch_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void loongarch_translate_code(CPUState *cs, TranslationBlock *tb,
+                              int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9de8ce6707..41dfdf5804 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -551,6 +551,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 
 static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
+    .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 077151c62d..dec2967fce 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6118,8 +6118,8 @@ static const TranslatorOps m68k_tr_ops = {
     .tb_stop            = m68k_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void m68k_translate_code(CPUState *cpu, TranslationBlock *tb,
+                         int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &m68k_tr_ops, &dc.base);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index eba819378d..f114789abd 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -423,6 +423,7 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 
 static const TCGCPUOps mb_tcg_ops = {
     .initialize = mb_tcg_init,
+    .translate_code = mb_translate_code,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d53995c26d..24005f05b2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1779,8 +1779,8 @@ static const TranslatorOps mb_tr_ops = {
     .tb_stop            = mb_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void mb_translate_code(CPUState *cpu, TranslationBlock *tb,
+                       int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1b0cf6df9c..e3af02a4e6 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -547,6 +547,7 @@ static const Property mips_cpu_properties[] = {
 #include "hw/core/tcg-cpu-ops.h"
 static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
+    .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index bd1ef4e1fc..78b848a6d9 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15231,8 +15231,8 @@ static const TranslatorOps mips_tr_ops = {
     .tb_stop            = mips_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void mips_translate_code(CPUState *cs, TranslationBlock *tb,
+                         int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 7913a0c3e1..b7bab0d7ab 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -236,6 +236,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 
 static const TCGCPUOps openrisc_tcg_ops = {
     .initialize = openrisc_translate_init,
+    .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 028ba66631..7a6af183ae 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1646,8 +1646,8 @@ static const TranslatorOps openrisc_tr_ops = {
     .tb_stop            = openrisc_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
+                             int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0fcef630f1..c05c2dc42d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7431,6 +7431,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 
 static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
+  .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8ab87f42d6..80638ab535 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6669,8 +6669,8 @@ static const TranslatorOps ppc_tr_ops = {
     .tb_stop            = ppc_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void ppc_translate_code(CPUState *cs, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f0129811fd..8b89c99c0f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -135,6 +135,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 
 static const TCGCPUOps riscv_tcg_ops = {
     .initialize = riscv_translate_init,
+    .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a76f67c5dd..a992d4f3c6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1346,8 +1346,8 @@ static const TranslatorOps riscv_tr_ops = {
     .tb_stop            = riscv_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 558280c794..8c50c7a1bc 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -196,6 +196,7 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 
 static const TCGCPUOps rx_tcg_ops = {
     .initialize = rx_translate_init,
+    .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
     .tlb_fill = rx_cpu_tlb_fill,
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 4f43654bad..bbda703be8 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2258,8 +2258,8 @@ static const TranslatorOps rx_tr_ops = {
     .tb_stop            = rx_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void rx_translate_code(CPUState *cs, TranslationBlock *tb,
+                       int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 0a6847b027..97d41c23de 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -362,6 +362,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 
 static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
+    .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 81554f2ad9..00073c5560 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6481,8 +6481,8 @@ static const TranslatorOps s390x_tr_ops = {
     .disas_log          = s390x_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void s390x_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e9d3e12a62..24a22724c6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -251,6 +251,7 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 
 static const TCGCPUOps superh_tcg_ops = {
     .initialize = sh4_translate_init,
+    .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index f076da9bac..bcdd558818 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2318,8 +2318,8 @@ static const TranslatorOps sh4_tr_ops = {
     .tb_stop            = sh4_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void sh4_translate_code(CPUState *cs, TranslationBlock *tb,
+                        int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 373a335c39..fbd38ec334 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -996,6 +996,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 
 static const TCGCPUOps sparc_tcg_ops = {
     .initialize = sparc_tcg_init,
+    .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 465e20f4f3..7e5c7351cb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5819,8 +5819,8 @@ static const TranslatorOps sparc_tr_ops = {
     .tb_stop            = sparc_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void sparc_translate_code(CPUState *cs, TranslationBlock *tb,
+                          int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 95fb546666..95202fadbf 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -172,6 +172,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 
 static const TCGCPUOps tricore_tcg_ops = {
     .initialize = tricore_tcg_init,
+    .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .tlb_fill = tricore_cpu_tlb_fill,
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2b67395c09..0ef3743f3e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8460,9 +8460,8 @@ static const TranslatorOps tricore_tr_ops = {
     .tb_stop            = tricore_tr_tb_stop,
 };
 
-
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
+                            int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 0d4d79b58b..0910a3d290 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,6 +232,7 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 
 static const TCGCPUOps xtensa_tcg_ops = {
     .initialize = xtensa_translate_init,
+    .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 3c62c99b4f..4f02cefde3 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1228,8 +1228,8 @@ static const TranslatorOps xtensa_translator_ops = {
     .tb_stop            = xtensa_tr_tb_stop,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           vaddr pc, void *host_pc)
+void xtensa_translate_code(CPUState *cpu, TranslationBlock *tb,
+                           int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
     translator_loop(cpu, tb, max_insns, pc, host_pc,
-- 
2.43.0


