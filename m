Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF78D65C62
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVvh-0008Rv-Mj; Thu, 14 Nov 2024 04:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvE-0008IS-TS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVv9-0007g7-Ca
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4c1b1455so274186f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575626; x=1732180426;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLSaKTqtHeRWEFfzc/V24Z6g3ZeI+B7SMmaxUAKXCeg=;
 b=uhcYlTMq5tiUUaY5D2WiYHy0YbPG3IU3zKw8PUKkC1Hq4rz97DFDG6aG3DQFujFtgM
 Cc9kPPmQi+C/DFfefplv2S2xAx7yVAvXWKRO9Z5+V8zYcsdxMSFmqXHjz0DQBHewvIBE
 krTHaKzLyJhTwz/+8lmzzflenhVgPV5GQ8O2LJGjU3tg7zH8qah+Gx+U24auijHpKD71
 8cHDJ6QamNj4fFVBTbc7yL0Vvx5vcDacPpz+SzIO/OUIG5wCslp50D0WDVpZmIYy7u7Q
 1UAWKjyqpJTf7e9h/ZNXS7f0gIQXN44pbZBoOKI8crTmHfdk0d09UYr/hhhlz1M+JEJz
 hUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575626; x=1732180426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLSaKTqtHeRWEFfzc/V24Z6g3ZeI+B7SMmaxUAKXCeg=;
 b=iNjIdcpmgB97gWr7JiO1CPqPBwU8UJa5LNUos6pKfu0yrMKbmSy6YcnZeUIZdM9IC9
 oVF849/ZbWn/083WRrTXINIx5qh3+G7w/FfdAiT7hWmdnE4q/+rqRrJBrhFKi7MoCTzb
 ZqjhP2NWDU6pbRcXM9aIZX5doNameZ8UcQrb9++yEE4L4dqiFTUbJ6dw7ch3QljE+MCi
 r4hKNUPT/aJG2y253FFLGf6MMxxhoF2LqcePpb6G8UDdcKsztvVGW0BPwXM7MXQw8csA
 EcIkI5MXUuR6b0A61Q733uHmB5YhWzkhgyIZv+el0HapR5nCHEKAm9oCWe17tyB7CwMZ
 Txow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzraQmhvPusXcPE8NwERLKlR1TkKwDp927uCnQjm7JAAUfQ/+8Ks+jIyUa8yTIn72p7gKAQOtTxuaG@nongnu.org
X-Gm-Message-State: AOJu0YyMdgADY3WOKcFL6ubhIwogeDIWmYOapECk5xQuqqwGFNhuvWEq
 bMUnsxDxhiXMFmJuwu4R1D1Df0M6GwaIudvkVyHrBypyjGuFQl+q08RTT38TA9w=
X-Google-Smtp-Source: AGHT+IGL0Ngnb7Wv1HVh+wpPOX1LOVpalQtjfoO1I13mHU3H0UeHt5gkd8kw9Fz7SOLeicDDdBKKFg==
X-Received: by 2002:a5d:5f95:0:b0:37c:cc4b:d1ea with SMTP id
 ffacd0b85a97d-3820834a0d2mr7455493f8f.53.1731575625689; 
 Thu, 14 Nov 2024 01:13:45 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:45 -0800 (PST)
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
Subject: [PATCH v5 2/9] target/riscv: Add Ssdbltrp CSRs handling
Date: Thu, 14 Nov 2024 10:13:23 +0100
Message-ID: <20241114091332.108811-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42c.google.com
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
 target/riscv/csr.c        | 70 +++++++++++++++++++++++++++++++++------
 5 files changed, 85 insertions(+), 10 deletions(-)

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
index 73ac4d5449..054418ff54 100644
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
 
@@ -2457,7 +2483,8 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
          * keeping stale menvcfg bits in henvcfg value if a bit was enabled in
          * menvcfg and then disabled before updating henvcfg for instance.
          */
-        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
+        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                       HENVCFG_DTE;
         mask |= env->menvcfg & menvcfg_mask;
         henvcfg_mask |= menvcfg_mask;
     }
@@ -2468,6 +2495,9 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
      * menvcfg enabled bits only.
      */
     env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (val & mask);
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
 
     return RISCV_EXCP_NONE;
 }
@@ -2482,8 +2512,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                            env->menvcfg)) >> 32;
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                              HENVCFG_DTE) | env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
 
@@ -2495,7 +2525,8 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
      * clear all previous menvcfg bits before enabling some new one to avoid
      * stale menvcfg bits in henvcfg.
      */
-    uint64_t henvcfg_mask = (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+    uint64_t henvcfg_mask = (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                             HENVCFG_DTE);
     uint64_t mask = env->menvcfg & henvcfg_mask;
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
@@ -2504,12 +2535,15 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
-
     /*
      * 'henvcfg_mask' contains all menvcfg supported bits and 'mask' contains
      * menvcfg enabled bits only.
      */
     env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (valh & mask);
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -2937,6 +2971,9 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
 
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
@@ -2949,6 +2986,9 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
     /* TODO: Use SXL not MXL. */
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
@@ -2964,6 +3004,9 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
             mask |= SSTATUS64_UXL;
         }
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
     target_ulong newval = (env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
@@ -4069,6 +4112,13 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
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
@@ -5276,7 +5326,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
-    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
+    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
-- 
2.45.2


