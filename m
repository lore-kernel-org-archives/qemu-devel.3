Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8114CD374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rs5-0002dh-Cb; Thu, 17 Oct 2024 10:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rs3-0002bh-Du
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:52:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rs1-0006st-B1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:52:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso701696b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176776; x=1729781576;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czRbkhOcPFBL7pF3e6iqRgoPP7aY7BcmRIr8KGO8rUM=;
 b=PD/+5w7k7ZwP5c049uXf0BM9NGb25WIgSRsrcilFJOcRSrFch+ms73aVoS4zM9UuA9
 4HC045pcdb+a4cORITnb6iRz/sG2cCsvGX67f01OcsHoazYFaVJhpKeKVylhluXPNJmt
 33oyzqjqEag8EUD/jdzGHhj5Fz3R320mHqV7zfsGnusD7xzCStuYur0fA0vzT48j5O2y
 LPy4WAUw1ICGVcVYsTwyWcnRh8nXp63YVwK+kwXj0yMp1Y7j8L27hs1j7zW3LNzQg5pm
 AS5WcOhg2Z/CTJi6fzOnY4tzUMqtBurbunfcc3in0extOEQIggxTwSnvB9VaBkvG7g9K
 MJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176776; x=1729781576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czRbkhOcPFBL7pF3e6iqRgoPP7aY7BcmRIr8KGO8rUM=;
 b=UOUnXd4LmKrvfJLSr5F0YIRrepuAz3Zjf4ifAQJTnR3X+8qq+hqaa/ZStiQMAneNkQ
 ZU2fEKU1MJCyrkbMrDHqDjUIL0mqsPyjGfud8AlWhAhZWBtx/y7Ys/DhhHIDQqf8JKa0
 ojv2E53E1uFCM1VQOI4cx9Il9jMqukMI13G7DxM2dVSlDwnDzaIU4iDJO767nEI/LEIz
 uGkxlMHMfZPJP+OsyZG1eIA/kuOr+oUuob4JpdnYJoJ+mMHGcyhETjn8VBHYTzjujuDt
 7uhbhmTH9xYttEYan0PdbfbVJStOc0NvI41yBaSbWlJjOV7PGZbUSCQ80TiihQAHUNcL
 PwYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXExGgQ/AXHX1g78zarvm4TWxj72QRrQM1jHD0rOm6sVzppXczxKi1e8U/NhRF1Jx4gOB7lL0g+nY2H@nongnu.org
X-Gm-Message-State: AOJu0YyUNw1IbIllU9ep4wRuXemhW+VEeQV1qr8HtetzdynvVhXfIbB2
 r2kNygu1nkp1spB66C4n5s9AdosbQJEJmtrgXzcZ81vZLy+Rg8aGOllRo/IdXS0=
X-Google-Smtp-Source: AGHT+IHoTfIT2sGx/EgITjj7iMjAWw8yqG65aq7bfD4dc5xRv5RweceDz4dgjJe4tdJoB4f9NIy09Q==
X-Received: by 2002:a05:6a00:1806:b0:71e:6eb:786e with SMTP id
 d2e1a72fcca58-71e4c17b142mr26835909b3a.13.1729176775925; 
 Thu, 17 Oct 2024 07:52:55 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:52:55 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 2/9] target/riscv: Add Ssdbltrp CSRs handling
Date: Thu, 17 Oct 2024 16:52:13 +0200
Message-ID: <20241017145226.365825-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=cleger@rivosinc.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
{H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
presence of the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  6 ++++
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c | 17 ++++++++++
 target/riscv/csr.c        | 68 ++++++++++++++++++++++++++++++++++-----
 5 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 832556cc34..695de5667f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -553,6 +553,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 1a5200d1d5..08cc5b2e22 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -558,6 +558,7 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
+#define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 
@@ -588,6 +589,7 @@ typedef enum {
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
+#define SSTATUS_SDT         0x01000000
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -777,11 +779,13 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_DTE                        (1ULL << 59)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
 
 /* For RV32 */
+#define MENVCFGH_DTE                       BIT(27)
 #define MENVCFGH_ADUE                      BIT(29)
 #define MENVCFGH_PBMTE                     BIT(30)
 #define MENVCFGH_STCE                      BIT(31)
@@ -795,11 +799,13 @@ typedef enum RISCVException {
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_DTE                        MENVCFG_DTE
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
 
 /* For RV32 */
+#define HENVCFGH_DTE                        MENVCFGH_DTE
 #define HENVCFGH_ADUE                       MENVCFGH_ADUE
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 092744360e..518102d748 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -77,6 +77,7 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_ssdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 648d4ed833..b9f36e8621 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -63,6 +63,19 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
+    if (virt) {
+        return (env->henvcfg & HENVCFG_DTE) != 0;
+    } else {
+        return (env->menvcfg & MENVCFG_DTE) != 0;
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -562,6 +575,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 
     g_assert(riscv_has_ext(env, RVH));
 
+    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
+        mstatus_mask |= MSTATUS_SDT;
+    }
+
     if (current_virt) {
         /* Current V=1 and we are about to change to V=0 */
         env->vsstatus = env->mstatus & mstatus_mask;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9e832e0b39..9aa33611f7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -540,6 +540,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
     return hmode32(env, csrno);
 }
 
+static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException pmp(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->pmp) {
@@ -1600,6 +1609,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         mask |= MSTATUS_VS;
     }
 
+    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
+        mask |= MSTATUS_SDT;
+        if ((val & MSTATUS_SDT) != 0) {
+            val &= ~MSTATUS_SIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -2356,7 +2372,11 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
+        if ((val & MENVCFG_DTE) == 0) {
+            env->mstatus &= ~MSTATUS_SDT;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
     write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
@@ -2379,9 +2399,14 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
+    if ((valh & MENVCFG_DTE) == 0) {
+        env->mstatus &= ~MSTATUS_SDT;
+    }
+
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
     write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
@@ -2431,9 +2456,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
      * henvcfg.adue is read_only 0 when menvcfg.adue = 0
+     * henvcfg.dte is read_only 0 when menvcfg.dte = 0
      */
-    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                           env->menvcfg);
+    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                             HENVCFG_DTE) | env->menvcfg);
     return RISCV_EXCP_NONE;
 }
 
@@ -2451,10 +2477,16 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
+        if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+            menvcfg_mask |= HENVCFG_DTE;
+        }
         mask |= env->menvcfg & menvcfg_mask;
     }
 
     env->henvcfg = (env->henvcfg & ~menvcfg_mask) | (val & mask);
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
 
     return RISCV_EXCP_NONE;
 }
@@ -2469,8 +2501,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                            env->menvcfg)) >> 32;
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                              HENVCFG_DTE) | env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
 
@@ -2478,7 +2510,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t menvcfg_mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_ADUE);
+                                    HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t mask = env->menvcfg & menvcfg_mask;
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
@@ -2489,6 +2521,10 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
     }
 
     env->henvcfg = (env->henvcfg & ~menvcfg_mask) | (valh & mask);
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -2916,6 +2952,9 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
 
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
@@ -2928,6 +2967,9 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
     /* TODO: Use SXL not MXL. */
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
@@ -2943,6 +2985,9 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
             mask |= SSTATUS64_UXL;
         }
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
     target_ulong newval = (env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
@@ -4048,6 +4093,13 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
     }
+    if ((env->henvcfg & HENVCFG_DTE)) {
+        if ((val & SSTATUS_SDT) != 0) {
+            val &= ~SSTATUS_SIE;
+        }
+    } else {
+        val &= ~SSTATUS_SDT;
+    }
     env->vsstatus = (env->vsstatus & ~mask) | (uint64_t)val;
     return RISCV_EXCP_NONE;
 }
@@ -5255,7 +5307,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
-    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
+    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
-- 
2.45.2


