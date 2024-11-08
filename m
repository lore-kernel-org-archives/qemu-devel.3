Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36AED5E13F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I3o-0003mL-I5; Fri, 08 Nov 2024 01:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3m-0003l7-HW; Fri, 08 Nov 2024 01:01:30 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3j-00082P-34; Fri, 08 Nov 2024 01:01:30 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so15017661fa.0; 
 Thu, 07 Nov 2024 22:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731045684; x=1731650484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqt1YZpYM6fhvXOwO7x3UgS+qYsZ0GvmSq4sEGnuQRI=;
 b=Qk1dfmM1Go3P53BJJ6j96IneVwuZyStZjMqLPzo1zvD/ATJRNWrWuYj3pV7pfTIHkV
 qqHOxautyeHxR1KprQ/hxGbtQY2xfPeT1npsQDTptLNFZ0CDZNiSWXUdqJqzYA8/wJsa
 Q/kg4R2c+J7Fk/R2szNlEPTAbtrU8kUb18QiqZjiolmyyr10ZwV3uSIvprxm9gwlE+rA
 paCtHpIzzWOsjnKQJBVBglypliIpfAKfgAjMNb/7f6PCW7XbSIJJo6Gfhxtb9NxXnsgd
 qGd2lYwwX5pR8yvGwuRSjCyo2yQ+1gppa3mQj1lYncx4kWptgNduSAkaY81I4nzDpFTo
 oImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045684; x=1731650484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqt1YZpYM6fhvXOwO7x3UgS+qYsZ0GvmSq4sEGnuQRI=;
 b=w31LT7/wNqRpuQr0dAqUBt9fi63zIFabzZ+GVje3Cs9X6/sbWvfjfUs5QokYvrKS5s
 596BMniQDUjgx68v4ma4hiUXhbkRgG97rUPbzLK3tKsbNLKdT73Pavkas1xFmO3mMQdc
 pqnMr3BlZd9QyvwyozQk2L3J3dx2SQoNW7x7YHEPckR5BmAUMVm8pkv6DCosQ3jzneh1
 jiNHZ8aZ8jMk9dl30+bnKOfyQh2DM2IRUWZDLmQD+96ShSpsZRJlWXj9nCS/cjuNthlj
 f3T4T0rZI/7+o9TxmhKLaJq7qBgeWc0+QrrLIlRVHpdTGYTc5yKs6UHWk0j0Yi7C4VNb
 xPKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3NPwcUECOrWEJLnBvtIBzarZa5pqtE+5ra98DrR+/zqDBMSf0C7Igd9pm4iix75n1t4ADvzTjiwmxRw==@nongnu.org,
 AJvYcCWorR5lcVTIUBZ9/rl4gksfYR044MNyuAd+25V/Wm/wdRxjDLojVjwX3a/PHUiv7GLPj2AhTnv61tcQ@nongnu.org
X-Gm-Message-State: AOJu0YyIqyl/wQ9uMN17DiQBfGfLaEpIlzrRD0vnCz89aDw0hntHquqY
 vU6UQDTVDK2xesA3P8urMiizfE6Hp/6Ns9Egakkv1nPT96VCfTmg
X-Google-Smtp-Source: AGHT+IEQ4Ye41NONQQ0jy6Rg+liw8tuf1ePuLar1Ad/1UBC3eMqWN84+caqLbmmReXPf5a7SduFzKg==
X-Received: by 2002:a2e:8905:0:b0:2fb:3a12:a582 with SMTP id
 38308e7fff4ca-2ff202808bfmr5078211fa.23.1731045683177; 
 Thu, 07 Nov 2024 22:01:23 -0800 (PST)
Received: from hades.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178ee325sm5159001fa.27.2024.11.07.22.01.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Nov 2024 22:01:21 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/7] target/riscv: Remove obsolete pointer masking extension
 code.
Date: Fri,  8 Nov 2024 09:01:10 +0300
Message-Id: <20241108060116.37397-2-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108060116.37397-1-baturo.alexey@gmail.com>
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Zjpm extension is finally ratified. And it's much simplier compared to the experimental one.
The newer version doesn't allow to specify custom mask or base for pointer masking.
Instead it allows only certain options for masking top bits.

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
---
 target/riscv/cpu.c           |  13 +-
 target/riscv/cpu.h           |  33 +---
 target/riscv/cpu_bits.h      |  87 ----------
 target/riscv/cpu_helper.c    |  52 ------
 target/riscv/csr.c           | 326 -----------------------------------
 target/riscv/machine.c       |  17 +-
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  28 +--
 target/riscv/vector_helper.c |   2 +-
 9 files changed, 19 insertions(+), 544 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..4e80dcd2e6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -42,7 +42,7 @@
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
-                              RVC, RVS, RVU, RVH, RVJ, RVG, RVB, 0};
+                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
 
 /*
  * From vector_helper.c
@@ -793,13 +793,6 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             CSR_MSCRATCH,
             CSR_SSCRATCH,
             CSR_SATP,
-            CSR_MMTE,
-            CSR_UPMBASE,
-            CSR_UPMMASK,
-            CSR_SPMBASE,
-            CSR_SPMMASK,
-            CSR_MPMBASE,
-            CSR_MPMMASK,
         };
 
         for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
@@ -985,8 +978,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         }
         i++;
     }
-    /* mmte is supposed to have pm.current hardwired to 1 */
-    env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
 
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
@@ -1018,7 +1009,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->ssp = 0;
 
     env->xl = riscv_cpu_mxl(env);
-    riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
@@ -1406,7 +1396,6 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVS, "s", "Supervisor-level instructions"),
     MISA_EXT_INFO(RVU, "u", "User-level instructions"),
     MISA_EXT_INFO(RVH, "h", "Hypervisor"),
-    MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
     MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b112821..e11264231d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -71,7 +71,6 @@ typedef struct CPUArchState CPURISCVState;
 #define RVS RV('S')
 #define RVU RV('U')
 #define RVH RV('H')
-#define RVJ RV('J')
 #define RVG RV('G')
 #define RVB RV('B')
 
@@ -451,24 +450,11 @@ struct CPUArchState {
     /* True if in debugger mode.  */
     bool debugger;
 
-    /*
-     * CSRs for PointerMasking extension
-     */
-    target_ulong mmte;
-    target_ulong mpmmask;
-    target_ulong mpmbase;
-    target_ulong spmmask;
-    target_ulong spmbase;
-    target_ulong upmmask;
-    target_ulong upmbase;
-
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
     uint64_t henvcfg;
 #endif
-    target_ulong cur_pmmask;
-    target_ulong cur_pmbase;
 
     /* Fields from here on are preserved across CPU reset. */
     QEMUTimer *stimer; /* Internal timer for S-mode interrupt */
@@ -624,19 +610,19 @@ FIELD(TB_FLAGS, XL, 16, 2)
 /* If PointerMasking should be applied */
 FIELD(TB_FLAGS, PM_MASK_ENABLED, 18, 1)
 FIELD(TB_FLAGS, PM_BASE_ENABLED, 19, 1)
-FIELD(TB_FLAGS, VTA, 20, 1)
-FIELD(TB_FLAGS, VMA, 21, 1)
+FIELD(TB_FLAGS, VTA, 18, 1)
+FIELD(TB_FLAGS, VMA, 19, 1)
 /* Native debug itrigger */
-FIELD(TB_FLAGS, ITRIGGER, 22, 1)
+FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 /* Virtual mode enabled */
-FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
-FIELD(TB_FLAGS, PRIV, 24, 2)
-FIELD(TB_FLAGS, AXL, 26, 2)
+FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
+FIELD(TB_FLAGS, PRIV, 22, 2)
+FIELD(TB_FLAGS, AXL, 24, 2)
 /* zicfilp needs a TB flag to track indirect branches */
-FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
-FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+FIELD(TB_FLAGS, FCFI_ENABLED, 26, 1)
+FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 27, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
-FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
+FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -772,7 +758,6 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
-void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 385a2c67c2..2a6aff63ed 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -497,37 +497,6 @@
 #define CSR_MHPMCOUNTER30H  0xb9e
 #define CSR_MHPMCOUNTER31H  0xb9f
 
-/*
- * User PointerMasking registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_UMTE            0x4c0
-#define CSR_UPMMASK         0x4c1
-#define CSR_UPMBASE         0x4c2
-
-/*
- * Machine PointerMasking registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_MMTE            0x3c0
-#define CSR_MPMMASK         0x3c1
-#define CSR_MPMBASE         0x3c2
-
-/*
- * Supervisor PointerMaster registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_SMTE            0x1c0
-#define CSR_SPMMASK         0x1c1
-#define CSR_SPMBASE         0x1c2
-
-/*
- * Hypervisor PointerMaster registers
- * NB: actual CSR numbers might be changed in future
- */
-#define CSR_VSMTE           0x2c0
-#define CSR_VSPMMASK        0x2c1
-#define CSR_VSPMBASE        0x2c2
 #define CSR_SCOUNTOVF       0xda0
 
 /* Crypto Extension */
@@ -758,11 +727,6 @@ typedef enum RISCVException {
 #define VS_MODE_INTERRUPTS ((uint64_t)(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP))
 #define HS_MODE_INTERRUPTS ((uint64_t)(MIP_SGEIP | VS_MODE_INTERRUPTS))
 
-/* General PointerMasking CSR bits */
-#define PM_ENABLE       0x00000001ULL
-#define PM_CURRENT      0x00000002ULL
-#define PM_INSN         0x00000004ULL
-
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_LPE                        BIT(2) /* zicfilp */
@@ -801,57 +765,6 @@ typedef enum RISCVException {
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
 
-/* Offsets for every pair of control bits per each priv level */
-#define XS_OFFSET    0ULL
-#define U_OFFSET     2ULL
-#define S_OFFSET     5ULL
-#define M_OFFSET     8ULL
-
-#define PM_XS_BITS   (EXT_STATUS_MASK << XS_OFFSET)
-#define U_PM_ENABLE  (PM_ENABLE  << U_OFFSET)
-#define U_PM_CURRENT (PM_CURRENT << U_OFFSET)
-#define U_PM_INSN    (PM_INSN    << U_OFFSET)
-#define S_PM_ENABLE  (PM_ENABLE  << S_OFFSET)
-#define S_PM_CURRENT (PM_CURRENT << S_OFFSET)
-#define S_PM_INSN    (PM_INSN    << S_OFFSET)
-#define M_PM_ENABLE  (PM_ENABLE  << M_OFFSET)
-#define M_PM_CURRENT (PM_CURRENT << M_OFFSET)
-#define M_PM_INSN    (PM_INSN    << M_OFFSET)
-
-/* mmte CSR bits */
-#define MMTE_PM_XS_BITS     PM_XS_BITS
-#define MMTE_U_PM_ENABLE    U_PM_ENABLE
-#define MMTE_U_PM_CURRENT   U_PM_CURRENT
-#define MMTE_U_PM_INSN      U_PM_INSN
-#define MMTE_S_PM_ENABLE    S_PM_ENABLE
-#define MMTE_S_PM_CURRENT   S_PM_CURRENT
-#define MMTE_S_PM_INSN      S_PM_INSN
-#define MMTE_M_PM_ENABLE    M_PM_ENABLE
-#define MMTE_M_PM_CURRENT   M_PM_CURRENT
-#define MMTE_M_PM_INSN      M_PM_INSN
-#define MMTE_MASK    (MMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | MMTE_U_PM_INSN | \
-                      MMTE_S_PM_ENABLE | MMTE_S_PM_CURRENT | MMTE_S_PM_INSN | \
-                      MMTE_M_PM_ENABLE | MMTE_M_PM_CURRENT | MMTE_M_PM_INSN | \
-                      MMTE_PM_XS_BITS)
-
-/* (v)smte CSR bits */
-#define SMTE_PM_XS_BITS     PM_XS_BITS
-#define SMTE_U_PM_ENABLE    U_PM_ENABLE
-#define SMTE_U_PM_CURRENT   U_PM_CURRENT
-#define SMTE_U_PM_INSN      U_PM_INSN
-#define SMTE_S_PM_ENABLE    S_PM_ENABLE
-#define SMTE_S_PM_CURRENT   S_PM_CURRENT
-#define SMTE_S_PM_INSN      S_PM_INSN
-#define SMTE_MASK    (SMTE_U_PM_ENABLE | SMTE_U_PM_CURRENT | SMTE_U_PM_INSN | \
-                      SMTE_S_PM_ENABLE | SMTE_S_PM_CURRENT | SMTE_S_PM_INSN | \
-                      SMTE_PM_XS_BITS)
-
-/* umte CSR bits */
-#define UMTE_U_PM_ENABLE    U_PM_ENABLE
-#define UMTE_U_PM_CURRENT   U_PM_CURRENT
-#define UMTE_U_PM_INSN      U_PM_INSN
-#define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_INSN)
-
 /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
 #define ISELECT_IPRIO0                     0x30
 #define ISELECT_IPRIO15                    0x3f
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..696a17461b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -210,61 +210,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
-    if (env->cur_pmmask != 0) {
-        flags = FIELD_DP32(flags, TB_FLAGS, PM_MASK_ENABLED, 1);
-    }
-    if (env->cur_pmbase != 0) {
-        flags = FIELD_DP32(flags, TB_FLAGS, PM_BASE_ENABLED, 1);
-    }
 
     *pflags = flags;
 }
 
-void riscv_cpu_update_mask(CPURISCVState *env)
-{
-    target_ulong mask = 0, base = 0;
-    RISCVMXL xl = env->xl;
-    /*
-     * TODO: Current RVJ spec does not specify
-     * how the extension interacts with XLEN.
-     */
-#ifndef CONFIG_USER_ONLY
-    int mode = cpu_address_mode(env);
-    xl = cpu_get_xl(env, mode);
-    if (riscv_has_ext(env, RVJ)) {
-        switch (mode) {
-        case PRV_M:
-            if (env->mmte & M_PM_ENABLE) {
-                mask = env->mpmmask;
-                base = env->mpmbase;
-            }
-            break;
-        case PRV_S:
-            if (env->mmte & S_PM_ENABLE) {
-                mask = env->spmmask;
-                base = env->spmbase;
-            }
-            break;
-        case PRV_U:
-            if (env->mmte & U_PM_ENABLE) {
-                mask = env->upmmask;
-                base = env->upmbase;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-#endif
-    if (xl == MXL_RV32) {
-        env->cur_pmmask = mask & UINT32_MAX;
-        env->cur_pmbase = base & UINT32_MAX;
-    } else {
-        env->cur_pmmask = mask;
-        env->cur_pmbase = base;
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 
 /*
@@ -786,7 +735,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
     env->xl = cpu_recompute_xl(env);
-    riscv_cpu_update_mask(env);
 
     /*
      * Clear the load reservation - otherwise a reservation placed in one
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9846770820..941c9691da 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -531,16 +531,6 @@ static RISCVException hgatp(CPURISCVState *env, int csrno)
     return hmode(env, csrno);
 }
 
-/* Checks if PointerMasking registers could be accessed */
-static RISCVException pointer_masking(CPURISCVState *env, int csrno)
-{
-    /* Check if j-ext is present */
-    if (riscv_has_ext(env, RVJ)) {
-        return RISCV_EXCP_NONE;
-    }
-    return RISCV_EXCP_ILLEGAL_INST;
-}
-
 static RISCVException aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
@@ -1648,7 +1638,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         env->xl = cpu_recompute_xl(env);
     }
 
-    riscv_cpu_update_mask(env);
     return RISCV_EXCP_NONE;
 }
 
@@ -4351,302 +4340,6 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-/*
- * Functions to access Pointer Masking feature registers
- * We have to check if current priv lvl could modify
- * csr in given mode
- */
-static bool check_pm_current_disabled(CPURISCVState *env, int csrno)
-{
-    int csr_priv = get_field(csrno, 0x300);
-    int pm_current;
-
-    if (env->debugger) {
-        return false;
-    }
-    /*
-     * If priv lvls differ that means we're accessing csr from higher priv lvl,
-     * so allow the access
-     */
-    if (env->priv != csr_priv) {
-        return false;
-    }
-    switch (env->priv) {
-    case PRV_M:
-        pm_current = get_field(env->mmte, M_PM_CURRENT);
-        break;
-    case PRV_S:
-        pm_current = get_field(env->mmte, S_PM_CURRENT);
-        break;
-    case PRV_U:
-        pm_current = get_field(env->mmte, U_PM_CURRENT);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    /* It's same priv lvl, so we allow to modify csr only if pm.current==1 */
-    return !pm_current;
-}
-
-static RISCVException read_mmte(CPURISCVState *env, int csrno,
-                                target_ulong *val)
-{
-    *val = env->mmte & MMTE_MASK;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_mmte(CPURISCVState *env, int csrno,
-                                 target_ulong val)
-{
-    uint64_t mstatus;
-    target_ulong wpri_val = val & MMTE_MASK;
-
-    if (val != wpri_val) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s" TARGET_FMT_lx " %s"
-                      TARGET_FMT_lx "\n", "MMTE: WPRI violation written 0x",
-                      val, "vs expected 0x", wpri_val);
-    }
-    /* for machine mode pm.current is hardwired to 1 */
-    wpri_val |= MMTE_M_PM_CURRENT;
-
-    /* hardwiring pm.instruction bit to 0, since it's not supported yet */
-    wpri_val &= ~(MMTE_M_PM_INSN | MMTE_S_PM_INSN | MMTE_U_PM_INSN);
-    env->mmte = wpri_val | EXT_STATUS_DIRTY;
-    riscv_cpu_update_mask(env);
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_smte(CPURISCVState *env, int csrno,
-                                target_ulong *val)
-{
-    *val = env->mmte & SMTE_MASK;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_smte(CPURISCVState *env, int csrno,
-                                 target_ulong val)
-{
-    target_ulong wpri_val = val & SMTE_MASK;
-
-    if (val != wpri_val) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s" TARGET_FMT_lx " %s"
-                      TARGET_FMT_lx "\n", "SMTE: WPRI violation written 0x",
-                      val, "vs expected 0x", wpri_val);
-    }
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-
-    wpri_val |= (env->mmte & ~SMTE_MASK);
-    write_mmte(env, csrno, wpri_val);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_umte(CPURISCVState *env, int csrno,
-                                target_ulong *val)
-{
-    *val = env->mmte & UMTE_MASK;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_umte(CPURISCVState *env, int csrno,
-                                 target_ulong val)
-{
-    target_ulong wpri_val = val & UMTE_MASK;
-
-    if (val != wpri_val) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s" TARGET_FMT_lx " %s"
-                      TARGET_FMT_lx "\n", "UMTE: WPRI violation written 0x",
-                      val, "vs expected 0x", wpri_val);
-    }
-
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-
-    wpri_val |= (env->mmte & ~UMTE_MASK);
-    write_mmte(env, csrno, wpri_val);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_mpmmask(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->mpmmask;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_mpmmask(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    env->mpmmask = val;
-    if ((cpu_address_mode(env) == PRV_M) && (env->mmte & M_PM_ENABLE)) {
-        env->cur_pmmask = val;
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_spmmask(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->spmmask;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_spmmask(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->spmmask = val;
-    if ((cpu_address_mode(env) == PRV_S) && (env->mmte & S_PM_ENABLE)) {
-        env->cur_pmmask = val;
-        if (cpu_get_xl(env, PRV_S) == MXL_RV32) {
-            env->cur_pmmask &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_upmmask(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->upmmask;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_upmmask(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->upmmask = val;
-    if ((cpu_address_mode(env) == PRV_U) && (env->mmte & U_PM_ENABLE)) {
-        env->cur_pmmask = val;
-        if (cpu_get_xl(env, PRV_U) == MXL_RV32) {
-            env->cur_pmmask &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_mpmbase(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->mpmbase;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_mpmbase(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    env->mpmbase = val;
-    if ((cpu_address_mode(env) == PRV_M) && (env->mmte & M_PM_ENABLE)) {
-        env->cur_pmbase = val;
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_spmbase(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->spmbase;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_spmbase(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->spmbase = val;
-    if ((cpu_address_mode(env) == PRV_S) && (env->mmte & S_PM_ENABLE)) {
-        env->cur_pmbase = val;
-        if (cpu_get_xl(env, PRV_S) == MXL_RV32) {
-            env->cur_pmbase &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException read_upmbase(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
-{
-    *val = env->upmbase;
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException write_upmbase(CPURISCVState *env, int csrno,
-                                    target_ulong val)
-{
-    uint64_t mstatus;
-
-    /* if pm.current==0 we can't modify current PM CSRs */
-    if (check_pm_current_disabled(env, csrno)) {
-        return RISCV_EXCP_NONE;
-    }
-    env->upmbase = val;
-    if ((cpu_address_mode(env) == PRV_U) && (env->mmte & U_PM_ENABLE)) {
-        env->cur_pmbase = val;
-        if (cpu_get_xl(env, PRV_U) == MXL_RV32) {
-            env->cur_pmbase &= UINT32_MAX;
-        }
-    }
-    env->mmte |= EXT_STATUS_DIRTY;
-
-    /* Set XS and SD bits, since PM CSRs are dirty */
-    mstatus = env->mstatus | MSTATUS_XS;
-    write_mstatus(env, csrno, mstatus);
-    return RISCV_EXCP_NONE;
-}
-
 #endif
 
 /* Crypto Extension */
@@ -5316,25 +5009,6 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
 
-    /* User Pointer Masking */
-    [CSR_UMTE]    =    { "umte",    pointer_masking, read_umte,  write_umte },
-    [CSR_UPMMASK] =    { "upmmask", pointer_masking, read_upmmask,
-                         write_upmmask                                      },
-    [CSR_UPMBASE] =    { "upmbase", pointer_masking, read_upmbase,
-                         write_upmbase                                      },
-    /* Machine Pointer Masking */
-    [CSR_MMTE]    =    { "mmte",    pointer_masking, read_mmte,  write_mmte },
-    [CSR_MPMMASK] =    { "mpmmask", pointer_masking, read_mpmmask,
-                         write_mpmmask                                      },
-    [CSR_MPMBASE] =    { "mpmbase", pointer_masking, read_mpmbase,
-                         write_mpmbase                                      },
-    /* Supervisor Pointer Masking */
-    [CSR_SMTE]    =    { "smte",    pointer_masking, read_smte,  write_smte },
-    [CSR_SPMMASK] =    { "spmmask", pointer_masking, read_spmmask,
-                         write_spmmask                                      },
-    [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase,
-                         write_spmbase                                      },
-
     /* Performance Counters */
     [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
     [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 99f0af5077..e40dc73994 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -152,25 +152,15 @@ static const VMStateDescription vmstate_vector = {
 
 static bool pointermasking_needed(void *opaque)
 {
-    RISCVCPU *cpu = opaque;
-    CPURISCVState *env = &cpu->env;
-
-    return riscv_has_ext(env, RVJ);
+    return false;
 }
 
 static const VMStateDescription vmstate_pointermasking = {
     .name = "cpu/pointer_masking",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pointermasking_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.mmte, RISCVCPU),
-        VMSTATE_UINTTL(env.mpmmask, RISCVCPU),
-        VMSTATE_UINTTL(env.mpmbase, RISCVCPU),
-        VMSTATE_UINTTL(env.spmmask, RISCVCPU),
-        VMSTATE_UINTTL(env.spmbase, RISCVCPU),
-        VMSTATE_UINTTL(env.upmmask, RISCVCPU),
-        VMSTATE_UINTTL(env.upmbase, RISCVCPU),
 
         VMSTATE_END_OF_LIST()
     }
@@ -266,7 +256,6 @@ static int riscv_cpu_post_load(void *opaque, int version_id)
     CPURISCVState *env = &cpu->env;
 
     env->xl = cpu_recompute_xl(env);
-    riscv_cpu_update_mask(env);
     return 0;
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..179428f3f0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1086,7 +1086,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVS, true),
     MISA_CFG(RVU, true),
     MISA_CFG(RVH, true),
-    MISA_CFG(RVJ, false),
     MISA_CFG(RVV, false),
     MISA_CFG(RVG, false),
     MISA_CFG(RVB, false),
@@ -1373,8 +1372,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     CPURISCVState *env = &cpu->env;
     const RISCVCPUMultiExtConfig *prop;
 
-    /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVJ | RVV);
+    /* Enable RVG and RVV that are disabled by default */
+    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bccaf8e89a..018be5504f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -41,9 +41,6 @@ static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
-/* globals for PM CSRs */
-static TCGv pm_mask;
-static TCGv pm_base;
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -105,9 +102,6 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
-    /* PointerMasking extension */
-    bool pm_mask_enabled;
-    bool pm_base_enabled;
     /* Ztso */
     bool ztso;
     /* Use icount trigger for native debug */
@@ -591,14 +585,9 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (ctx->pm_mask_enabled) {
-        tcg_gen_andc_tl(addr, addr, pm_mask);
-    } else if (get_address_xl(ctx) == MXL_RV32) {
+    if (get_address_xl(ctx) == MXL_RV32) {
         tcg_gen_ext32u_tl(addr, addr);
     }
-    if (ctx->pm_base_enabled) {
-        tcg_gen_or_tl(addr, addr, pm_base);
-    }
 
     return addr;
 }
@@ -610,14 +599,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (ctx->pm_mask_enabled) {
-        tcg_gen_andc_tl(addr, addr, pm_mask);
-    } else if (get_xl(ctx) == MXL_RV32) {
+    if (get_xl(ctx) == MXL_RV32) {
         tcg_gen_ext32u_tl(addr, addr);
     }
-    if (ctx->pm_base_enabled) {
-        tcg_gen_or_tl(addr, addr, pm_base);
-    }
+
     return addr;
 }
 
@@ -1245,8 +1230,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->pm_mask_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_MASK_ENABLED);
-    ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
@@ -1385,9 +1368,4 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
                              "load_val");
-    /* Assign PM CSRs to tcg globals */
-    pm_mask = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, cur_pmmask),
-                                 "pmmask");
-    pm_base = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, cur_pmbase),
-                                 "pmbase");
 }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ccb32e6122..4af8d2f035 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -107,7 +107,7 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
-    return (addr & ~env->cur_pmmask) | env->cur_pmbase;
+    return addr;
 }
 
 /*
-- 
2.39.5


