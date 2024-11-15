Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAABBD68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8y-0003Ns-SK; Fri, 15 Nov 2024 10:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8x-0003NT-R7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:55 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8u-00049o-RW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:55 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53a097aa3daso2004099e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684110; x=1732288910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeQRT281dCHMdV0wKef8zCTDvxfHEabnq4IySE7RO9M=;
 b=UUod3XU19G3EXjnrhOu9lTYfIOTfUJzdBitmsIXaSiUv4KmzsYcCiEuYqEndV/kZ6H
 qOAgY0ajw6cHO5mMeXfPn4/qcqYYC4iklUi7Jbd4FbGzs5e7AyT8E79ilSu9hImbm1b0
 FZvnW0OAqxrVSZIyRCdHc/+NmFy0W/Hni4b008sCd350jSGq6qyYcq0VBbMeQNars/rx
 fKvLcjSQ9+S1CUhqjd3oV1xoVvcg117z7cKR0lotyEhl5wqsb3niIyJnaU7pc97OdiHn
 uVZb7xrwM2zj/3HjB9tCLbiX3ZBbnT9k4iMyhM8VHIb8fVsOpVewmYIwgDPDhMi5tyTR
 j6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684110; x=1732288910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yeQRT281dCHMdV0wKef8zCTDvxfHEabnq4IySE7RO9M=;
 b=CRx3XeXfE6wZqJEX8bBoQLfBBLQ3ZQpHZmvwhQzTbMZ0/HzDEViKPyrlwi0e1bJqMX
 /EJkgDkC1NxCQu/+XKqVdjrbYIWeCer/o9CHMAH2HIHdT///G1s71R1oaANU+JgTh5fN
 bx/5Ia9DFeGs4dafyX6PMvG5pUj/F6j1zgtytX8RUSuxFqJUmVnJL6DDSbBJRBms1RTl
 Y2Zdqsw8XHuCesI7m4qgzV9cCj7Al6uVqqf/g33M1EYm7+QVeJDEkQTUlmM2y3PB5JAA
 3w3kMzaMyQ0ZntANIG6dpRYw61dTp+9x39ZCEJJy9SbwgPZR/58qCPpjMMi/68iqaTAR
 nlyw==
X-Gm-Message-State: AOJu0Yyyg5MSClbuJsWClF2HtOjNPtwSKinxpI7GN4Qf9RY9l0lG+fxm
 zF3h9awbb+BVGJMC4M7KfxndUTh3qjfLeAv4UYR+F1Lbv9ONVdZRqsPpteWkzT30cCDcOsh1Mm6
 U
X-Google-Smtp-Source: AGHT+IHdzk/YaHETDLfjP+0X9ufMnLJE5XfZb9FRSFntTax8VaZewgJZiYoNDbYR2aFMWRWnf3Hvlg==
X-Received: by 2002:a05:6512:a84:b0:53d:a99e:b765 with SMTP id
 2adb3069b0e04-53dab2a2205mr1575519e87.27.1731684109572; 
 Fri, 15 Nov 2024 07:21:49 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78881sm56456745e9.13.2024.11.15.07.21.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/10] hw/core/cpu: Pass CPUArchState to cpu_dump_state()
 handler
Date: Fri, 15 Nov 2024 16:20:53 +0100
Message-ID: <20241115152053.66442-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

CPUClass::cpu_dump_state() handler is target specific.
Rather than passing a generic CPUState and forcing QOM casts,
we can directly pass the target CPUArchState, simplifying.

Only x86_cpu_dump_state() has to do an extra env_cpu() to
access the original CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h         |  2 +-
 target/alpha/cpu.h            |  2 +-
 target/hppa/cpu.h             |  2 +-
 target/i386/cpu.h             |  2 +-
 target/m68k/cpu.h             |  2 +-
 target/microblaze/cpu.h       |  2 +-
 target/openrisc/cpu.h         |  2 +-
 target/ppc/cpu.h              |  2 +-
 target/rx/cpu.h               |  2 +-
 target/s390x/s390x-internal.h |  2 +-
 target/sh4/cpu.h              |  2 +-
 target/tricore/cpu.h          |  2 +-
 target/xtensa/cpu.h           |  2 +-
 hw/core/cpu-common.c          |  2 +-
 target/alpha/helper.c         |  3 +--
 target/arm/cpu.c              | 14 ++++++--------
 target/avr/cpu.c              |  3 +--
 target/hexagon/cpu.c          |  9 ++-------
 target/hppa/helper.c          |  3 +--
 target/hppa/int_helper.c      |  2 +-
 target/hppa/sys_helper.c      |  6 ++----
 target/i386/cpu-dump.c        |  5 ++---
 target/loongarch/cpu.c        |  3 +--
 target/m68k/translate.c       |  3 +--
 target/microblaze/translate.c |  3 +--
 target/mips/cpu.c             |  3 +--
 target/openrisc/translate.c   |  3 +--
 target/ppc/cpu_init.c         |  5 ++---
 target/riscv/cpu.c            |  6 ++----
 target/rx/translate.c         |  3 +--
 target/s390x/cpu-dump.c       |  3 +--
 target/sh4/translate.c        |  3 +--
 target/sparc/cpu.c            |  3 +--
 target/tricore/translate.c    |  3 +--
 target/xtensa/translate.c     |  3 +--
 35 files changed, 45 insertions(+), 72 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 70f5f8c3bf..f647717add 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -155,7 +155,7 @@ struct CPUClass {
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
-    void (*dump_state)(CPUState *cpu, FILE *, int flags);
+    void (*dump_state)(CPUArchState *env, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
     bool (*cpu_persistent_status)(CPUState *cpu);
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 3556d3227f..e05bc70428 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -283,7 +283,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
-void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
+void alpha_cpu_dump_state(CPUAlphaState *env, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e45ba50a59..43bdcccb2f 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -358,7 +358,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
 
 int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
+void hppa_cpu_dump_state(CPUHPPAState *env, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
 void hppa_ptlbe(CPUHPPAState *env);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c239a6970..94c3d09fe3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2284,7 +2284,7 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
 
-void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
+void x86_cpu_dump_state(CPUX86State *env, FILE *f, int flags);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5bbeedb7a..7df68b8dbd 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -188,7 +188,7 @@ void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
-void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void m68k_cpu_dump_state(CPUM68KState *env, FILE *f, int flags);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c60..1571038979 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -375,7 +375,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                            MMUAccessType access_type,
                                            int mmu_idx, uintptr_t retaddr);
-void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void mb_cpu_dump_state(CPUMBState *env, FILE *f, int flags);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *buf, int reg);
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c9fe9ae12d..7bd7578eee 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -297,7 +297,7 @@ struct ArchCPU {
     CPUOpenRISCState env;
 };
 
-void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void openrisc_cpu_dump_state(CPUOpenRISCState *env, FILE *f, int flags);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 945af07a64..14da103db7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1554,7 +1554,7 @@ static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
 }
 #endif /* CONFIG_USER_ONLY */
 
-void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void ppc_cpu_dump_state(CPUPPCState *env, FILE *f, int flags);
 int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index c53593d7aa..b582304a48 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -134,7 +134,7 @@ void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
-void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void rx_cpu_dump_state(CPURXState *env, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 891e5f576c..9ae89b3d24 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -322,7 +322,7 @@ void s390_cpu_gdb_init(CPUState *cs);
 
 
 /* helper.c */
-void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void s390_cpu_dump_state(CPUS390XState *env, FILE *f, int flags);
 void do_restart_interrupt(CPUS390XState *env);
 #ifndef CONFIG_USER_ONLY
 void s390_cpu_recompute_watchpoints(CPUState *cs);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d928bcf006..f4f38a9ab2 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -240,7 +240,7 @@ struct SuperHCPUClass {
     uint32_t cvr;
 };
 
-void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void superh_cpu_dump_state(CPUSH4State *env, FILE *f, int flags);
 int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 G_NORETURN void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 220af69fc2..423589f609 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -76,7 +76,7 @@ struct TriCoreCPUClass {
 };
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void tricore_cpu_dump_state(CPUTriCoreState *env, FILE *f, int flags);
 
 FIELD(PCXI, PCPN_13, 24, 8)
 FIELD(PCXI, PCPN_161, 22, 8)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 77e48eef19..28ebba10e3 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -592,7 +592,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool xtensa_debug_check_breakpoint(CPUState *cs);
 #endif
-void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void xtensa_cpu_dump_state(CPUXtensaState *env, FILE *f, int flags);
 void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs);
 int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c7903594..bc608b38f5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -105,7 +105,7 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 
     if (cc->dump_state) {
         cpu_synchronize_state(cpu);
-        cc->dump_state(cpu, f, flags);
+        cc->dump_state(cpu_env(cpu), f, flags);
     }
 }
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f1000c99f..990b2edde4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -476,7 +476,7 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #endif /* !CONFIG_USER_ONLY */
 
-void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void alpha_cpu_dump_state(CPUAlphaState *env, FILE *f, int flags)
 {
     static const char linux_reg_names[31][4] = {
         "v0",  "t0",  "t1", "t2",  "t3", "t4", "t5", "t6",
@@ -484,7 +484,6 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
         "t10", "t11", "ra", "t12", "at", "gp", "sp"
     };
-    CPUAlphaState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c8e032d433..a7bb025c11 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1213,10 +1213,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 #ifdef TARGET_AARCH64
 
-static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void aarch64_cpu_dump_state(CPUARMState *env, FILE *f, int flags)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    ARMCPU *cpu = env_archcpu(env);
     uint32_t psr = pstate_read(env);
     int i, j;
     int el = arm_current_el(env);
@@ -1372,21 +1371,20 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 #else
 
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static inline void aarch64_cpu_dump_state(CPUARMState *env, FILE *f, int flags)
 {
     g_assert_not_reached();
 }
 
 #endif
 
-static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void arm_cpu_dump_state(CPUARMState *env, FILE *f, int flags)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    ARMCPU *cpu = env_archcpu(env);
     int i;
 
     if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, flags);
+        aarch64_cpu_dump_state(env, f, flags);
         return;
     }
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 19b6298a31..46a1ba3b3a 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -155,9 +155,8 @@ static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
     return object_class_by_name(cpu_model);
 }
 
-static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void avr_cpu_dump_state(CPUAVRState *env, FILE *f, int flags)
 {
-    CPUAVRState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "\n");
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 8038df1c82..58c627946b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -176,7 +176,7 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum)
     print_qreg(stdout, env, regnum, false);
 }
 
-static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
+static void hexagon_dump_state(CPUHexagonState *env, FILE *f, int flags)
 {
     HexagonCPU *cpu = env_archcpu(env);
 
@@ -235,14 +235,9 @@ static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
     }
 }
 
-static void hexagon_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    hexagon_dump(cpu_env(cs), f, flags);
-}
-
 void hexagon_debug(CPUHexagonState *env)
 {
-    hexagon_dump(env, stdout, CPU_DUMP_FPU);
+    hexagon_dump_state(env, stdout, CPU_DUMP_FPU);
 }
 
 static void hexagon_cpu_set_pc(CPUHexagonState *env, vaddr value)
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index d4b1a3cd5a..2456d36abe 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -100,7 +100,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     env->psw_cb = cb;
 }
 
-void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void hppa_cpu_dump_state(CPUHPPAState *env, FILE *f, int flags)
 {
 #ifndef CONFIG_USER_ONLY
     static const char cr_name[32][5] = {
@@ -115,7 +115,6 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     };
 #endif
 
-    CPUHPPAState *env = cpu_env(cs);
     target_ulong psw = cpu_hppa_get_psw(env);
     target_ulong psw_cb;
     char psw_c[20];
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 58695def82..8cb9defa50 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -254,7 +254,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             } else {
                 fprintf(logfile, "INT: cpu %d unknown %d\n", cs->cpu_index, i);
             }
-            hppa_cpu_dump_state(cs, logfile, 0);
+            hppa_cpu_dump_state(env, logfile, 0);
             qemu_log_unlock(logfile);
         }
     }
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 9b43b556fd..320d8ad995 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -98,10 +98,8 @@ void HELPER(rfi)(CPUHPPAState *env)
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
-            CPUState *cs = env_cpu(env);
-
-            fprintf(logfile, "RFI: cpu %d\n", cs->cpu_index);
-            hppa_cpu_dump_state(cs, logfile, 0);
+            fprintf(logfile, "RFI: cpu %d\n", env_cpu(env)->cpu_index);
+            hppa_cpu_dump_state(env, logfile, 0);
             qemu_log_unlock(logfile);
         }
     }
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index a72ed93bd2..9e4b8d6742 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -341,10 +341,9 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
 #define DUMP_CODE_BYTES_TOTAL    50
 #define DUMP_CODE_BYTES_BACKWARD 20
 
-void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void x86_cpu_dump_state(CPUX86State *env, FILE *f, int flags)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    CPUState *cs = env_cpu(env);
     int eflags, i, nb;
     static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 6962f4b6de..ae00d5e222 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -742,9 +742,8 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void loongarch_cpu_dump_state(CPULoongArchState *env, FILE *f, int flags)
 {
-    CPULoongArchState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ad3ce34501..aafc32aa48 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6136,9 +6136,8 @@ static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
     return u.d;
 }
 
-void m68k_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void m68k_cpu_dump_state(CPUM68KState *env, FILE *f, int flags)
 {
-    CPUM68KState *env = cpu_env(cs);
     int i;
     uint16_t sr;
     for (i = 0; i < 8; i++) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4beaf69e76..98404a3036 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1785,9 +1785,8 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base);
 }
 
-void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void mb_cpu_dump_state(CPUMBState *env, FILE *f, int flags)
 {
-    CPUMBState *env = cpu_env(cs);
     uint32_t iflags;
     int i;
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 506494f7e6..d631249216 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -78,9 +78,8 @@ static void fpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
     }
 }
 
-static void mips_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void mips_cpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
 {
-    CPUMIPSState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "pc=0x" TARGET_FMT_lx " HI=0x" TARGET_FMT_lx
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ca566847cb..3ca94f00b1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1654,9 +1654,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
                     &openrisc_tr_ops, &ctx.base);
 }
 
-void openrisc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void openrisc_cpu_dump_state(CPUOpenRISCState *env, FILE *f, int flags)
 {
-    CPUOpenRISCState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "PC=%08x\n", env->pc);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 95bf78a3b7..b8d859846f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7522,18 +7522,17 @@ static void ppc_cpu_register_types(void)
 #endif
 }
 
-void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void ppc_cpu_dump_state(CPUPPCState *env, FILE *f, int flags)
 {
 #define RGPL  4
 #define RFPL  4
 
-    CPUPPCState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
                  TARGET_FMT_lx " XER " TARGET_FMT_lx " CPU#%d\n",
                  env->nip, env->lr, env->ctr, cpu_read_xer(env),
-                 cs->cpu_index);
+                 env_cpu(env)->cpu_index);
     qemu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
                  "%08x iidx %d didx %d\n",
                  env->msr, env->spr[SPR_HID0], env->hflags,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dfaa9a9c1c..152f5c4e76 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -746,10 +746,8 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
-static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void riscv_cpu_dump_state(CPURISCVState *env, FILE *f, int flags)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
     int i, j;
     uint8_t *p;
 
@@ -865,7 +863,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                              csr_ops[csrno].name, val);
             }
         }
-        uint16_t vlenb = cpu->cfg.vlenb;
+        uint16_t vlenb = env_archcpu(env)->cfg.vlenb;
 
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s ", riscv_rvv_regnames[i]);
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9aade2b6e5..5747425345 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -131,9 +131,8 @@ static int bdsp_s(DisasContext *ctx, int d)
 /* Include the auto-generated decoder. */
 #include "decode-insns.c.inc"
 
-void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void rx_cpu_dump_state(CPURXState *env, FILE *f, int flags)
 {
-    CPURXState *env = cpu_env(cs);
     int i;
     uint32_t psw;
 
diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
index 69cc9f7746..c33d6b2855 100644
--- a/target/s390x/cpu-dump.c
+++ b/target/s390x/cpu-dump.c
@@ -25,9 +25,8 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
 
-void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void s390_cpu_dump_state(CPUS390XState *env, FILE *f, int flags)
 {
-    CPUS390XState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 53b092175d..b4eaafe2c4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -156,9 +156,8 @@ void sh4_translate_init(void)
                                               fregnames[i]);
 }
 
-void superh_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void superh_cpu_dump_state(CPUSH4State *env, FILE *f, int flags)
 {
-    CPUSH4State *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "pc=0x%08x sr=0x%08x pr=0x%08x fpscr=0x%08x\n",
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 83c86c03bd..bf37734efd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -616,9 +616,8 @@ static void cpu_print_cc(FILE *f, uint32_t cc)
 #define REGS_PER_LINE 8
 #endif
 
-static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void sparc_cpu_dump_state(CPUSPARCState *env, FILE *f, int flags)
 {
-    CPUSPARCState *env = cpu_env(cs);
     int i, x;
 
     qemu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4a12d2ca19..c9f96ef3ae 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -92,9 +92,8 @@ enum {
     MODE_UU = 3,
 };
 
-void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void tricore_cpu_dump_state(CPUTriCoreState *env, FILE *f, int flags)
 {
-    CPUTriCoreState *env = cpu_env(cs);
     uint32_t psw;
     int i;
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f4da4a40f9..6827f39492 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1235,9 +1235,8 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
                     &xtensa_translator_ops, &dc.base);
 }
 
-void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+void xtensa_cpu_dump_state(CPUXtensaState *env, FILE *f, int flags)
 {
-    CPUXtensaState *env = cpu_env(cs);
     xtensa_isa isa = env->config->isa;
     int i, j;
 
-- 
2.45.2


