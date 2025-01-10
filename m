Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B5EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEYD-0004tG-Bu; Fri, 10 Jan 2025 07:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXT-00049F-OM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:00 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXP-0000yo-Us
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:54:58 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so1499105f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736513694; x=1737118494;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUIleJwNx8wYEcCo3C/4f8Irxx1dY2h05Jx+0bC8zts=;
 b=RojC/Gy8pcoDg30z80/LuPtei29bHk0QffDyPbjw7w2Hfl6KVoazyhwCH3ZGRm7dVf
 f1dG8hNoptHoAP6Wvd+kt6AROwB/ooqcMgwfmWvFW4lYe8Wiur6+czMWAhdTJ//3uIYQ
 cFKVzXidyGBIGvPypQ077vmViWfGTurRUOnqha2QlCDNpwEdqfCx5jxqqEI9HFNNanZp
 K5QtjopFR25EZTU8tg9I4ZCHpghsNVwNRqEFE7QSWZ8JBxLH86sruiGBNoMHdA51TamF
 LkFXwP/eeq1rzrmz5OIF83xng2jsU6E/Ps0mzba3eTy8wDcdFIMBPWrCVP2t2yVu7a5J
 TSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513694; x=1737118494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUIleJwNx8wYEcCo3C/4f8Irxx1dY2h05Jx+0bC8zts=;
 b=ik+EtoL8tk//uRO2qejzclmG2WLWJyQwWWYfn7kX0alwZ1sNYlCSa1JR/bKUiHRfdV
 kXCt37x+ZW+kST3bjg95fCSM7D4QNc4T/w8BdZkhNX6V+RDCZ/nKGY9MsKrAIAm9MNA6
 xD019dmzaEFzRuMvrBGhBJ0Ka7zElAXLGt+aHGI/AkoYYgnpmnoa/6umGXpzXA99NHbi
 Py1S9T7q1V9o/pepAcCm2jf3iv+GH9INyOko1DK30zk8hIEaQqfqxkpKj3isPui7p6HD
 vqZ2uXJgLmKBjZXGQbQu9e6jGy9zrzXn0GsbOGYdPnSaaxb3gPTmQmgbmT2wUl/CGx+V
 ZB4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjLlnrLz8kMJll0taf4tt3odXf+/YYQ2/UnThHaBCQ0vj9TiwUabF4QC6ubSabRNL0lbcpbwZBJA6e@nongnu.org
X-Gm-Message-State: AOJu0YzDBUaPyUDasi7/utsgEYYatyE3MppSVSJS1NNYCUzcPthOkvT4
 8gaqbVE7cKyei/6yoJmcYn5gQdyHO2JYt9yoA6Xc41pB0GBxTe1H+tQfmayXW5s=
X-Gm-Gg: ASbGncti3O3olRFPoE5dmZYzMdWWOjcHBQXnjbW7w34zHC/wCUVp3AaoS/2Tsuo6IGX
 PQ91w1hfvjPght8/wf/ViOvheOQ0nVGYfOhHIOno3PUhuDLA7OFXCNtSpI9H11CmoGaeZD5Im6I
 bkysOy1KELZTFnGwbE1z7WeEfAaWo1TuG0l99MZNLO0smwcBSNWjtSkmzx+iEroCAeX9n4x8B9N
 BMsC5Qq/lzAZ9EEvPBhPZTt5fz90Zj99poIxAG/XX61U/HRRz89qyK1+w==
X-Google-Smtp-Source: AGHT+IFP+OBJcALS+tTJhD47h1WbiTKMyL8R6orWNWhG4nCApMju0t/h5ILjg+WpKECntQuDSJ7GMg==
X-Received: by 2002:a05:6000:1f8d:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38a87305259mr9924822f8f.14.1736513693990; 
 Fri, 10 Jan 2025 04:54:53 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm4548921f8f.97.2025.01.10.04.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:54:53 -0800 (PST)
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
Subject: [PATCH v8 2/9] target/riscv: Add Ssdbltrp CSRs handling
Date: Fri, 10 Jan 2025 13:54:33 +0100
Message-ID: <20250110125441.3208676-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125441.3208676-1-cleger@rivosinc.com>
References: <20250110125441.3208676-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x436.google.com
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
 target/riscv/cpu_helper.c | 17 ++++++++++
 target/riscv/csr.c        | 71 ++++++++++++++++++++++++++++++++-------
 5 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a936300103..97713681cb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -564,6 +564,7 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
 bool cpu_get_bcfien(CPURISCVState *env);
+bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 73f7d37d80..0a56163d73 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -555,6 +555,7 @@
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
 #define MSTATUS_SPELP       0x00800000 /* zicfilp */
+#define MSTATUS_SDT         0x01000000
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
@@ -587,6 +588,7 @@ typedef enum {
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
 #define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
+#define SSTATUS_SDT         MSTATUS_SDT
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -782,12 +784,14 @@ typedef enum RISCVException {
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
 #define MENVCFG_PMM                        (3ULL << 32)
+#define MENVCFG_DTE                        (1ULL << 59)
 #define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
 
 /* For RV32 */
+#define MENVCFGH_DTE                       BIT(27)
 #define MENVCFGH_ADUE                      BIT(29)
 #define MENVCFGH_PBMTE                     BIT(30)
 #define MENVCFGH_STCE                      BIT(31)
@@ -808,11 +812,13 @@ typedef enum RISCVException {
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
 #define HENVCFG_PMM                        MENVCFG_PMM
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
index 561f5119b6..20e11a5bdd 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -83,6 +83,7 @@ struct RISCVCPUConfig {
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;
+    bool ext_ssdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3318ce440d..1eac0a0062 100644
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
@@ -691,6 +704,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 
     g_assert(riscv_has_ext(env, RVH));
 
+    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
+        mstatus_mask |= MSTATUS_SDT;
+    }
+
     if (current_virt) {
         /* Current V=1 and we are about to change to V=0 */
         env->vsstatus = env->mstatus & mstatus_mask;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 279293b86d..4aded3f00c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -680,6 +680,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
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
@@ -1938,6 +1947,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
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
@@ -2959,7 +2975,8 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
-                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
 
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
@@ -2973,6 +2990,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_smnpm &&
             get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
             mask |= MENVCFG_PMM;
+	}
+
+        if ((val & MENVCFG_DTE) == 0) {
+            env->mstatus &= ~MSTATUS_SDT;
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
@@ -2997,9 +3018,14 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                     (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
-                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
+                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
+                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
+    if ((valh & MENVCFG_DTE) == 0) {
+        env->mstatus &= ~MSTATUS_SDT;
+    }
+
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
     write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
@@ -3070,9 +3096,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
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
 
@@ -3088,7 +3115,8 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                                HENVCFG_DTE);
 
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= HENVCFG_LPE;
@@ -3108,6 +3136,9 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     env->henvcfg = val & mask;
+    if ((env->henvcfg & HENVCFG_DTE) == 0) {
+        env->vsstatus &= ~MSTATUS_SDT;
+    }
 
     return RISCV_EXCP_NONE;
 }
@@ -3122,8 +3153,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
-                            env->menvcfg)) >> 32;
+    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
+                              HENVCFG_DTE) | env->menvcfg)) >> 32;
     return RISCV_EXCP_NONE;
 }
 
@@ -3131,7 +3162,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_ADUE);
+                                    HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
@@ -3139,8 +3170,10 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
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
 
@@ -3594,6 +3627,9 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mask |= SSTATUS_SDT;
+    }
 
     if (env_archcpu(env)->cfg.ext_zicfilp) {
         mask |= SSTATUS_SPELP;
@@ -3614,7 +3650,9 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
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
@@ -3634,7 +3672,9 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
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
@@ -4751,6 +4791,13 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
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
@@ -5698,7 +5745,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
-    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
+    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
     [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
-- 
2.47.1


