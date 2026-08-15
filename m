Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F8C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8p-0008OQ-UA; Sat, 15 Aug 2026 16:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8n-0008MI-TO
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-0008Jy-KX
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:05 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2543359a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826269; x=1787431069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=muFszflukBNrDWeTZu5ckN3N8yKHDXEtfeifw3cDVsA=;
 b=A+/MqSitwXTXeu6Mo//yHR4EDNg5oH7cR/EcGXF+JjGDRcNzkX4Pd33Pmp7Us1xyyB
 53Eub4Ba+09AXqWl+3r7vqM+mplp84Z7Pkw8X3n6U0nYuL3s5XyIF6k+Qpgo+OupYZ2J
 SuBkD8cROYpbWA0QbR4OXi9OmvlEZv/wgY0FjCD5+wKC6AZ92BRmSjZ5QygvSGhtc9Hp
 j7WbIhGJfJWRoudGwzecmwV34+XvHqwmdaD5Rg3imfYbksNN7n4D9L6wUJMrFANyzK6X
 m2jFfwLriWO0HwkhYfFbmT3ybpV6TWjvhJg4xq8a1OypLfSEG5TjK1ktBJr1tctM3FT1
 Ooew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826269; x=1787431069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=muFszflukBNrDWeTZu5ckN3N8yKHDXEtfeifw3cDVsA=;
 b=fAcXICHzSE7nNNK3I2J4Csd71LzbtPJCNO2/xDsa/zGWWBeEPW/oadQFAxZN9Ww0Vh
 6hTa7VCLwOYN54+mhRcAuq0XWcu6nWbeqvYQrAsq6+J/Uw59v99vB8lJYgMhXo1WRuSD
 pa9rBwOpGNANNXMnolZKfTu6sm5q9DtQqaoyvPmKb8qJJKM2M2cqWvJS3Awep/8sdTnl
 GnZdl0G0t6Qfqzfbr/tbgCWN1m70PxoRqu8HsGSbmhUbVjHOilDNYiKP2QjHc4IRF8kp
 aXiCn33C8nKRraaxJu6W4CtZD8iA6N8JFTmrbFl9zWgSox0eK15IUcoA6nmKwDqP5vvf
 inGw==
X-Gm-Message-State: AOJu0YzNc7UPl2TtO3yZF1FjKgW8N1msSuK3N1Y5V/old4cs+JA7UOi+
 yFCxZh+mQrreUROPYHe8nr7WId340es2eU3QMIaOMYS+qn+HZwQlzx8EQoupuDFjM78bD66Os9Q
 5hA0w
X-Gm-Gg: AR+sD11eqNHCmmEJ8x73ON4HCRPazUJ/HFZl8Zq5VikG0icje9dX27ek/T08gkjmk37
 9v8L8iR6Z06i202Kgh0Ux8MZ27Y5d4xgyKANKBqNsyl59AmPkluzXfhB9zKQBLgoHq69gptZcWY
 jumqUdvtSPuASbUPeYR/UudRnJV5MiluHObr8njUECYnv+gEdO9tB/f09eZzr0HQUzpPjtmBZG1
 EGxJ4Q1UslseSuo6Qa2zu5RtjqL6wk0pc7kQu5VVvtDO8zfHRM5gEHN/gqUOUavBSA+cF7omOd1
 q7WE3LW2dU69CQKxgfVY7hiNrmtfZ+Qw37m2tUs0irXWL3VIjeDXolZpq4BxpG6SZl2Bk/IlF0d
 bQJmCug742e5r9sEhi14YBkzYNE48DALHvX5DxQhtz5u62N31N2S/MmIxYWERjsILoqzmMjs9Qn
 GFfu/rRLscT1+bAqGLGMoCGWSN6GZvO34uuQNVAVTJWBJSlS2teiliNMn3LAS0A8dV+QmMemdZi
 wh8B5GxHDXFWFQQxCacGk4sr0Y6SUY=
X-Received: by 2002:a17:90b:5450:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-3933ed23db1mr15936016a91.19.1786826268942; 
 Sat, 15 Aug 2026 13:37:48 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 12/18] accel/tcg: Replace size with first/last in
 TCGCPUOps.tlb_fill*
Date: Sat, 15 Aug 2026 13:37:24 -0700
Message-ID: <20260815203730.1468365-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Expand the interfaces to allow an address within a range to be tested.
Additionally, where was an edge case of size == 0 which was ambiguous,
and is now eliminated.

Only change the functional interface.  Where required by the callee,
rebuild "size = last - addr + 1" locally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h          | 16 ++++++++++++----
 target/alpha/cpu.h                   |  2 +-
 target/arm/internals.h               |  5 +++--
 target/avr/cpu.h                     |  2 +-
 target/hppa/cpu.h                    |  5 +++--
 target/i386/tcg/helper-tcg.h         |  2 +-
 target/loongarch/tcg/tcg_loongarch.h |  2 +-
 target/m68k/cpu.h                    |  2 +-
 target/microblaze/cpu.h              |  2 +-
 target/mips/tcg/tcg-internal.h       |  2 +-
 target/or1k/cpu.h                    |  2 +-
 target/ppc/internal.h                |  2 +-
 target/riscv/cpu.h                   |  2 +-
 target/s390x/s390x-internal.h        |  2 +-
 target/sh4/cpu.h                     |  2 +-
 target/sparc/cpu.h                   |  2 +-
 target/tricore/cpu.h                 |  2 +-
 target/xtensa/cpu.h                  |  2 +-
 accel/tcg/cputlb.c                   |  7 +++----
 target/alpha/helper.c                |  2 +-
 target/arm/tcg/tlb_helper.c          |  5 +++--
 target/avr/helper.c                  |  2 +-
 target/hexagon/cpu.c                 |  8 +++++---
 target/hppa/mem_helper.c             |  6 ++++--
 target/i386/tcg/system/excp_helper.c |  2 +-
 target/loongarch/tcg/tlb_helper.c    |  3 ++-
 target/m68k/helper.c                 |  3 ++-
 target/microblaze/helper.c           |  2 +-
 target/mips/tcg/system/tlb_helper.c  |  2 +-
 target/or1k/mmu.c                    |  2 +-
 target/ppc/mmu_helper.c              |  2 +-
 target/riscv/tcg/cpu_helper.c        |  3 ++-
 target/rx/cpu.c                      |  2 +-
 target/s390x/tcg/excp_helper.c       |  2 +-
 target/sh4/helper.c                  |  2 +-
 target/sparc/mmu_helper.c            |  4 ++--
 target/tricore/helper.c              |  2 +-
 target/xtensa/helper.c               |  2 +-
 38 files changed, 68 insertions(+), 51 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3ff6e6810e..4f162ae5b0 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -196,13 +196,20 @@ struct TCGCPUOps {
      * @cpu: cpu context
      * @out: output page properties
      * @addr: virtual address
+     * @first: beginning of virtual address range
+     * @last: end of virtual address range
      * @access_type: read, write or execute
      * @mmu_idx: mmu context
      * @memop: memory operation for the access
-     * @size: memory access size, or 0 for whole page
      * @probe: test only, no fault
      * @ra: host return address for exception unwind
      *
+     * The access in progress is [@first, @last], where @addr is somewhere
+     * in that range.  Normally @addr == @first, but some targets have
+     * accesses which are forcibly aligned after an initial fault for an
+     * inaccessible page (e.g. Arm DC_ZVA, where [@first, @last] will be
+     * the bounds of the cacheline containing @addr).
+     *
      * If the access is valid, fill in @out and return true.
      * Otherwise if probe is true, return false.
      * Otherwise raise an exception and do not return.
@@ -213,9 +220,10 @@ struct TCGCPUOps {
      * Zero may be passed for @memop to skip any alignment check
      * for non-memory-access operations such as probing.
      */
-    bool (*tlb_fill_align)(CPUState *cpu, CPUTLBEntryFull *out, vaddr addr,
+    bool (*tlb_fill_align)(CPUState *cpu, CPUTLBEntryFull *out,
+                           vaddr addr, vaddr first, vaddr last,
                            MMUAccessType access_type, int mmu_idx,
-                           MemOp memop, int size, bool probe, uintptr_t ra);
+                           MemOp memop, bool probe, uintptr_t ra);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
@@ -223,7 +231,7 @@ struct TCGCPUOps {
      * if the access is invalid and probe is true, return false;
      * otherwise raise an exception and do not return.
      */
-    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
+    bool (*tlb_fill)(CPUState *cpu, vaddr addr, vaddr first, vaddr last,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
     /**
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d94..1ee3a6855e 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -450,7 +450,7 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
 void alpha_cpu_record_sigbus(CPUState *cs, vaddr address,
                              MMUAccessType access_type, uintptr_t retaddr);
 #else
-bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 G_NORETURN void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4026f67579..6457fa06ee 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1011,9 +1011,10 @@ void arm_cpu_record_sigsegv(CPUState *cpu, vaddr addr,
 void arm_cpu_record_sigbus(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, uintptr_t ra);
 #else
-bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                            vaddr addr, vaddr first, vaddr last,
                             MMUAccessType access_type, int mmu_idx,
-                            MemOp memop, int size, bool probe, uintptr_t ra);
+                            MemOp memop, bool probe, uintptr_t ra);
 #endif
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a818db753b..e40367b832 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -233,7 +233,7 @@ static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
     env->sregI = (sreg >> 7) & 0x01;
 }
 
-bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f453444d7f..bbf44ea220 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -391,9 +391,10 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 void hppa_ptlbe(CPUHPPAState *env);
 hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr);
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
-bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                             vaddr addr, vaddr first, vaddr last,
                              MMUAccessType access_type, int mmu_idx,
-                             MemOp memop, int size, bool probe, uintptr_t ra);
+                             MemOp memop, bool probe, uintptr_t ra);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d..ba0a4da322 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -78,7 +78,7 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
 void x86_cpu_record_sigbus(CPUState *cs, vaddr addr,
                            MMUAccessType access_type, uintptr_t ra);
 #else
-bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 7fb627f2d6..1d43dbc751 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -12,7 +12,7 @@
 extern const TCGCPUOps loongarch_tcg_ops;
 void loongarch_csr_translate_init(void);
 
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108..08bdf27c7e 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -585,7 +585,7 @@ enum {
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
 
-bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool m68k_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
 #ifndef CONFIG_USER_ONLY
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b9602f72b9..08d2a8f843 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -413,7 +413,7 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
 #if !defined(CONFIG_USER_ONLY)
-bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
 
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f..de179d0d5f 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -63,7 +63,7 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                     MemTxResult response, uintptr_t retaddr);
 void cpu_mips_tlb_flush(CPUMIPSState *env);
 
-bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool mips_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
 
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index fc4387ce7a..8a6293c030 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -298,7 +298,7 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 #ifndef CONFIG_USER_ONLY
 hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
-bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                            MMUAccessType access_type, int mmu_idx,
                            bool probe, uintptr_t retaddr);
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a3bb12afd9..3a80719a16 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -292,7 +292,7 @@ void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
                             bool maperr, uintptr_t ra);
 #else
-bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 G_NORETURN void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e980b5964d..ed712761d5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -659,7 +659,7 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
-bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 35d1e34ef4..559a8d9201 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -271,7 +271,7 @@ void s390_cpu_record_sigsegv(CPUState *cs, vaddr address,
 void s390_cpu_record_sigbus(CPUState *cs, vaddr address,
                             MMUAccessType access_type, uintptr_t retaddr);
 #else
-bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
 G_NORETURN void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 3302702376..be377d4178 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -252,7 +252,7 @@ void sh4_translate_code(CPUState *cs, TranslationBlock *tb,
 
 #if !defined(CONFIG_USER_ONLY)
 hwaddr superh_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool superh_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
 void superh_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de..13ec3f4a3a 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -596,7 +596,7 @@ G_NORETURN void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t);
 /* cpu_init.c */
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 /* mmu_helper.c */
-bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 12e497d2a7..880c5e0067 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -260,7 +260,7 @@ void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
-bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool tricore_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                           MMUAccessType access_type, int mmu_idx,
                           bool probe, uintptr_t retaddr);
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1b..46660a7dad 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -581,7 +581,7 @@ struct XtensaCPUClass {
 };
 
 #ifndef CONFIG_USER_ONLY
-bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 95db2c22e2..d559ce1ef6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1241,12 +1241,11 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, vaddr first, vaddr last,
                            bool probe, uintptr_t ra)
 {
     const TCGCPUOps *ops = cpu->cc->tcg_ops;
-    int size = last - addr + 1;
     CPUTLBEntryFull full;
 
     if (ops->tlb_fill_align) {
-        if (ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
-                                memop, size, probe, ra)) {
+        if (ops->tlb_fill_align(cpu, &full, addr, first, last, type, mmu_idx,
+                                memop, probe, ra)) {
             tlb_set_page_full(cpu, mmu_idx, addr, &full);
             return true;
         }
@@ -1255,7 +1254,7 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, vaddr first, vaddr last,
         if (addr & ((1u << memop_alignment_bits(memop)) - 1)) {
             ops->do_unaligned_access(cpu, addr, type, mmu_idx, ra);
         }
-        if (ops->tlb_fill(cpu, addr, size, type, mmu_idx, probe, ra)) {
+        if (ops->tlb_fill(cpu, addr, first, last, type, mmu_idx, probe, ra)) {
             return true;
         }
     }
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafd..d24b206388 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -307,7 +307,7 @@ hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     return (fail >= 0 ? -1 : phys);
 }
 
-bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4c3f16dc2a..826daf6772 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -353,9 +353,10 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
 
-bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                            vaddr address, vaddr first, vaddr last,
                             MMUAccessType access_type, int mmu_idx,
-                            MemOp memop, int size, bool probe, uintptr_t ra)
+                            MemOp memop, bool probe, uintptr_t ra)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GetPhysAddrResult res = {};
diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d904..b5cbdc7b2c 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -113,7 +113,7 @@ hwaddr avr_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     return addr; /* I assume 1:1 address correspondence */
 }
 
-bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0ddd898e6e..bfcd9b6159 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -666,11 +666,13 @@ static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
 static const char *mmu_idx_names[] = { "MMU_USER_IDX", "MMU_GUEST_IDX",
                                        "MMU_KERNEL_IDX" };
 
-static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
-                             MMUAccessType access_type, int mmu_idx, bool probe,
-                             uintptr_t retaddr)
+static bool hexagon_tlb_fill(CPUState *cs, vaddr address,
+                             vaddr first, vaddr last,
+                             MMUAccessType access_type, int mmu_idx,
+                             bool probe, uintptr_t retaddr)
 {
     CPUHexagonState *env = cpu_env(cs);
+    int size = last - address + 1;
     int slot = 0;
     hwaddr phys;
     int prot = 0;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 01e6149c81..0427fd0917 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -435,11 +435,13 @@ void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     }
 }
 
-bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                             vaddr addr, vaddr first, vaddr last,
                              MMUAccessType type, int mmu_idx,
-                             MemOp memop, int size, bool probe, uintptr_t ra)
+                             MemOp memop, bool probe, uintptr_t ra)
 {
     CPUHPPAState *env = cpu_env(cs);
+    int size = last - addr + 1;
     int prot, excp, a_prot;
     hwaddr phys;
 
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index d7ea77c855..fd21287a8b 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -610,7 +610,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
     return true;
 }
 
-bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a4b90beca6..08c992d774 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -630,7 +630,8 @@ static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
     update_tlb_index(env, context, index);
 }
 
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address,
+                            vaddr first, vaddr last,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
 {
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f5..c15fb1bc05 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -954,11 +954,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
     }
 }
 
-bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                        MMUAccessType qemu_access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
     CPUM68KState *env = cpu_env(cs);
+    int size = last - address + 1;
     hwaddr physical;
     int prot;
     int access_type;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 05a90f5ecb..65c73951ca 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -85,7 +85,7 @@ static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
     }
 }
 
-bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr)
 {
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 4398c6f80b..a54a98dd08 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -906,7 +906,7 @@ refill:
 }
 #endif
 
-bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 3fc56e1b77..a3c0fd7089 100644
--- a/target/or1k/mmu.c
+++ b/target/or1k/mmu.c
@@ -104,7 +104,7 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, vaddr address,
     cpu->env.lock_addr = -1;
 }
 
-bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                            MMUAccessType access_type, int mmu_idx,
                            bool probe, uintptr_t retaddr)
 {
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ac60705402..0edaeab045 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1358,7 +1358,7 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
 }
 
 
-bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, vaddr first, vaddr last,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..11f2654da1 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1649,12 +1649,13 @@ static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
     riscv_pmu_incr_ctr(cpu, pmu_event_type);
 }
 
-bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    int size = last - address + 1;
     vaddr im_address;
     hwaddr pa = 0;
     int prot, prot2, prot_pmp;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 20b188c24c..5d955c3763 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -185,7 +185,7 @@ static void rx_cpu_disas_set_info(const CPUState *cpu, disassemble_info *info)
     info->print_insn = print_insn_rx;
 }
 
-static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, vaddr first, vaddr last,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
 {
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index d952bb20cf..d9f68e1afc 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -145,7 +145,7 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
     }
 }
 
-bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b6b057f104..1fe1fe0275 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -798,7 +798,7 @@ bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
 {
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 07ba25dfce..cab476006a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -211,7 +211,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
 }
 
 /* Perform address translation */
-bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
@@ -776,7 +776,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
 }
 
 /* Perform address translation */
-bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 273713a147..5a6fb6c6c9 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -67,7 +67,7 @@ static void raise_mmu_exception(CPUTriCoreState *env, vaddr address,
 {
 }
 
-bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                           MMUAccessType rw, int mmu_idx,
                           bool probe, uintptr_t retaddr)
 {
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5a0e865514..a99956614b 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -264,7 +264,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                   addr);
 }
 
-bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
 {
-- 
2.43.0


