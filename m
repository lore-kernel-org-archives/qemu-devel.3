Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8BDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTY6-0008PM-Id; Tue, 17 Dec 2024 04:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXy-0008Jt-Dq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXu-0001W3-Eh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so54970925e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734426433; x=1735031233;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYpbcNDKidwUTaLq8aLaT90ICRuTp8bnHoMUPFgDtCc=;
 b=Gt1yP72T1I+VNef6unkSZYlKTrgXM75q7VMFVo9VqKX5hNji1/o4MUG2erDpl2DUKp
 3/jW89aQzvDuvF2NonZfogONzKLV5p8kiQUzrmghsRI+bIlBEMD3exbiKJx0ct5r0wFX
 2uD1z5oHApaALSWAlFVqeEv7d2u/Ri0bFX1UaSQS9xc+Evo37Skj2KTZ+Mvvtsy97PDx
 hs0lftUkoxSqJ5KGdsY7M+nyKa1v+LhRMuheUmp3zl9QHC3WTT0gJz6VhBOlS0S3ehIt
 eE1jj8cY4uoTYVT9O+p4+nrS5nVMxNXMwUhOV5uchdKopWkKHq5URSWLogyjpiC++YH+
 2W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426433; x=1735031233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYpbcNDKidwUTaLq8aLaT90ICRuTp8bnHoMUPFgDtCc=;
 b=Qu/iuuKQaXzz5P+vxLxq5gYMNeX/jxw0h+I53Q91ZLqe6BOeUbe4wFdgemI61sdY+r
 fcGvY68xJMTkWnrhJJkipskWI0vytiSDH6WcUh734GXU+ltRHEiMyixPO96KPtj7YqF1
 IxH9Y+4UgO7ctCgoeZ3MS36Kd8lh5dzrjVeVSStughkAyg90VFTjcmu3Ru/liwWm9XRn
 wLspj68aPcErnTOdTSDnOUX6o9aBxsFm2glLqDAV0ARdkyKkeQe6CErX7p5nP91uMydl
 bA9w/oOy8sxGviktLww3vwq2T32WOuSEx9ujDqumJy3Nf6zajhjGzSj6HhFE1AksaDax
 /cdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHT+ZEYvw8j4lPLTAs3NMiry2WRmakzUurfXhHtNymEt0EJtfD9EqaxyBwJQ21XESKebD8+PuhCEeb@nongnu.org
X-Gm-Message-State: AOJu0YzjQ1sKw7GWTuoOb74fd6ijuVj8aIBPt1UfO8hq7gPZUeSvOpgm
 ZNQArP8Bw2xN3sIVBs2WHvIamwVT9euI5AosbxCzrxuklSHuQxhXKW01dtSDGes=
X-Gm-Gg: ASbGncsxWTHhjquskTZTcHnBUt5Wops+h5EfK1wYWvFJBI4LOLJkumh8dgxZ+NHYP53
 +LQF6SITTjyLHKo8stowcZABkZsH92nEjQhF18DpVVUvJPNExflcgZEnPga1dsl+ZupxgUSKKsC
 1Uk4DbxZp7LzwWq7kctLnqTLUzy5nF3gePJw6N2snTd1tja5bIYMb5RXHw8CKHDiBZXouSsnuwR
 nc3Qumn7V366hDnESXCBO7rE0OwYg/L9Md77PzRpAXaOUU+BdkJrKRNqQ==
X-Google-Smtp-Source: AGHT+IGfn7WoQQJ/8Uu5l/MjCvU27PdikQ5MzuHRLeQafrD3BAkULmSRvrs8XfmFT6ZUF4v3KRUAFA==
X-Received: by 2002:a05:600c:3ba1:b0:434:a765:7f9c with SMTP id
 5b1f17b1804b1-4362aa13613mr136499835e9.6.1734426432924; 
 Tue, 17 Dec 2024 01:07:12 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm10704122f8f.71.2024.12.17.01.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 01:07:12 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 2/9] target/riscv: Add Ssdbltrp CSRs handling
Date: Tue, 17 Dec 2024 10:06:58 +0100
Message-ID: <20241217090707.3511160-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
References: <20241217090707.3511160-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x334.google.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  6 ++++
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c | 17 +++++++++
 target/riscv/csr.c        | 72 ++++++++++++++++++++++++++++++++-------
 5 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8dc5b4d002..02e502768e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -569,6 +569,7 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
 bool cpu_get_bcfien(CPURISCVState *env);
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index be9d0f5c05..b8acc11e65 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -562,6 +562,7 @@
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
 #define MSTATUS_SPELP       0x00800000 /* zicfilp */
+#define MSTATUS_SDT         0x01000000
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
@@ -594,6 +595,7 @@ typedef enum {
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
 #define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
+#define SSTATUS_SDT         MSTATUS_SDT
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -792,11 +794,13 @@ typedef enum RISCVException {
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
@@ -815,11 +819,13 @@ typedef enum RISCVException {
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
index 28b43932db..7638660651 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -79,6 +79,7 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_ssdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1fb1e31031..f284f94a04 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -120,6 +120,19 @@ bool cpu_get_bcfien(CPURISCVState *env)
     }
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
@@ -642,6 +655,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 
     g_assert(riscv_has_ext(env, RVH));
 
+    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
+        mstatus_mask |= MSTATUS_SDT;
+    }
+
     if (current_virt) {
         /* Current V=1 and we are about to change to V=0 */
         env->vsstatus = env->mstatus & mstatus_mask;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c2cec37d28..db87fd8726 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -559,6 +559,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
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
@@ -1633,6 +1642,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
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
@@ -2394,7 +2410,8 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
 
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
@@ -2403,6 +2420,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfiss) {
             mask |= MENVCFG_SSE;
         }
+
+        if ((val & MENVCFG_DTE) == 0) {
+            env->mstatus &= ~MSTATUS_SDT;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
     write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
@@ -2425,9 +2446,14 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
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
 
@@ -2492,9 +2518,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
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
 
@@ -2510,7 +2537,8 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                                HENVCFG_DTE);
 
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= HENVCFG_LPE;
@@ -2524,6 +2552,9 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     env->henvcfg = val & mask;
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
 
     return RISCV_EXCP_NONE;
 }
@@ -2538,8 +2569,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                            env->menvcfg)) >> 32;
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                              HENVCFG_DTE) | env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
 
@@ -2547,7 +2578,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_ADUE);
+                                    HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
@@ -2555,8 +2586,10 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
-
     env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
     return RISCV_EXCP_NONE;
 }
 
@@ -2984,6 +3017,9 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
 
     if (env_archcpu(env)->cfg.ext_zicfilp) {
         mask |= SSTATUS_SPELP;
@@ -3000,11 +3036,12 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
-
     if (env_archcpu(env)->cfg.ext_zicfilp) {
         mask |= SSTATUS_SPELP;
     }
-
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
     /* TODO: Use SXL not MXL. */
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
@@ -3024,7 +3061,9 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
     if (env_archcpu(env)->cfg.ext_zicfilp) {
         mask |= SSTATUS_SPELP;
     }
-
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
     target_ulong newval = (env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
@@ -4133,6 +4172,13 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
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
@@ -5343,7 +5389,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
-    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
+    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
-- 
2.45.2


