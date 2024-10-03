Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B0CCF34C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQeg-0007Lh-G7; Thu, 03 Oct 2024 14:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeA-0007Al-EA
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQe8-0004rn-BT
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e0a74ce880so1162208a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980431; x=1728585231;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ga7R1uOAlM8Z9Av05EldzmqrBkl0NtrIogEPK+RuKUk=;
 b=lBRT49IA3LXwEFnFocLNhZM3AT3f+EFVIrPTA3bGK+RDS6mGXagnRoFRqVXDudsK3K
 ZpxW4dDRmujHSd6T9OpEeZrG7EtuzNP6LtjYybYxcMgVZwlAA+KdII1xjs+vS7jy4zdn
 usNDjpJciXYQJyecTAdBv3mMbM+iwb/5ciTa/Xs+9Qp4+ECT10jk4TlmS08kxU4d6XD5
 nYfo909j6qaqOhWuCSQZ1aussKmdqrLjFGpBspHEKyAL5ZU302spkuctJM4SHZmygGRl
 WFlF6pSYx+2Iym3143sau/oA9PhvonnneVvBEA4BQEU2eUaaZuBT9TisKrDEC+CZ/Y/u
 pRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980431; x=1728585231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ga7R1uOAlM8Z9Av05EldzmqrBkl0NtrIogEPK+RuKUk=;
 b=gn2FNZOoGUE9PkpzqYMTC4xr/BGp6KhAm/ZBw98YNdljTwI29yb3naG/qMOj7LfWfW
 JmDCjBRoWSqNM3G+ojjmJEWNHeERMlzfT7ikNfdnc77rWC8cV/EO/tFq3y3QZJV9TZGW
 0AKMor0XLRL/0iZQGQBwyTYsU6/FuvLRrF2kctJaxVA7UvvPEDQxpehFnlTADO7WziZY
 Gpli6rz1FxcrM5hd4z4hNz0cHHOqdQyErvWqbhl8q1SvzLhwzLJKNR7dLIbLN+yqdDFt
 3ncAGjnWGYInsvHfdq+wz5FVBGH72NEwz9qVa7z3XzKc35KTsOw9uGyWqLaIP7rVhgom
 brcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfX7s4BGsPp3MrcLsUCC30Qs+AO58tL6KaFp0YpvB5uA8Ne0kQ2H0UquyyuoaJ/xnEeDdfSY5YumzN@nongnu.org
X-Gm-Message-State: AOJu0Yy/w448rwKm+0GERhD9IBSNfv05yz8vyCGre3/Mjk64brMteEz8
 pv41xssrKn1OZhylbXXkwmarj+CYKcziG4labFx4c59wqGteBNSZAPFl78TKe/0=
X-Google-Smtp-Source: AGHT+IF54j41JqIA1gur7GUMri/mExrvSeD7cCdSD1oE69Cle4dttu9c9CJNprDpld1dLKzt3DBedA==
X-Received: by 2002:a17:90a:43c4:b0:2c9:7ebd:b957 with SMTP id
 98e67ed59e1d1-2e1e621e54bmr46944a91.11.1727980431005; 
 Thu, 03 Oct 2024 11:33:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:33:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 03/21] target/riscv: Introduce elp state and enabling
 controls for zicfilp
Date: Thu,  3 Oct 2024 11:33:24 -0700
Message-ID: <20241003183342.679249-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102d.google.com
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

zicfilp introduces a new state elp ("expected landing pad") in cpu.
During normal execution, elp is idle (NO_LP_EXPECTED) i.e not expecting
landing pad. On an indirect call, elp moves LP_EXPECTED. When elp is
LP_EXPECTED, only a subsquent landing pad instruction can set state back
to NO_LP_EXPECTED. On reset, elp is set to NO_LP_EXPECTED.

zicfilp is enabled via bit2 in *envcfg CSRs. Enabling control for M-mode
is in mseccfg CSR at bit position 10.

On trap, elp state is saved away in *status.
Adds elp to the migration state as well.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c      |  3 +++
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  6 ++++++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 target/riscv/machine.c  | 19 +++++++++++++++++++
 target/riscv/pmp.c      |  5 +++++
 target/riscv/pmp.h      |  3 ++-
 7 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b7201a69df..05f727222e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1010,6 +1010,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->menvcfg = 0;
 #endif
 
+    /* on reset elp is clear */
+    env->elp = false;
+
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2623f6cf75..e9f26b5121 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -230,6 +230,8 @@ struct CPUArchState {
 
     target_ulong jvt;
 
+    /* elp state for zicfilp extension */
+    bool      elp;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7e3f629356..8df6043ef1 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -552,6 +552,8 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
+#define MSTATUS_SPELP       0x00800000 /* zicfilp */
+#define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 
@@ -582,6 +584,7 @@ typedef enum {
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
+#define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -754,6 +757,7 @@ typedef enum RISCVException {
 
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
+#define MENVCFG_LPE                        BIT(2) /* zicfilp */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -767,11 +771,13 @@ typedef enum RISCVException {
 #define MENVCFGH_STCE                      BIT(31)
 
 #define SENVCFG_FIOM                       MENVCFG_FIOM
+#define SENVCFG_LPE                        MENVCFG_LPE
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
+#define HENVCFG_LPE                        MENVCFG_LPE
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..57cef9e682 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1598,6 +1598,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    /* If cfi lp extension is available, then apply cfi lp mask */
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= (MSTATUS_MPELP | MSTATUS_SPELP);
+    }
+
     mstatus = (mstatus & ~mask) | (val & mask);
 
     env->mstatus = mstatus;
@@ -2344,6 +2349,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+
+        if (env_archcpu(env)->cfg.ext_zicfilp) {
+            mask |= MENVCFG_LPE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2396,6 +2405,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SENVCFG_LPE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2433,6 +2446,10 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+
+        if (env_archcpu(env)->cfg.ext_zicfilp) {
+            mask |= HENVCFG_LPE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -2897,6 +2914,10 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
         mask |= SSTATUS64_UXL;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
 }
@@ -2908,6 +2929,11 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     /* TODO: Use SXL not MXL. */
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
@@ -2923,6 +2949,11 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
             mask |= SSTATUS64_UXL;
         }
     }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     target_ulong newval = (env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 492c2c6d9d..c3a06c288d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -350,6 +350,24 @@ static const VMStateDescription vmstate_jvt = {
     }
 };
 
+static bool elp_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_zicfilp;
+}
+
+static const VMStateDescription vmstate_elp = {
+    .name = "cpu/elp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = elp_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(env.elp, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -422,6 +440,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_debug,
         &vmstate_smstateen,
         &vmstate_jvt,
+        &vmstate_elp,
         NULL
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9eea397e72..1111d08d08 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -598,6 +598,11 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
         val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
     }
 
+    /* M-mode forward cfi to be enabled if cfi extension is implemented */
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        val |= (val & MSECCFG_MLPE);
+    }
+
     env->mseccfg = val;
 }
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index f5c10ce85c..e0530a17a3 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -44,7 +44,8 @@ typedef enum {
     MSECCFG_MMWP  = 1 << 1,
     MSECCFG_RLB   = 1 << 2,
     MSECCFG_USEED = 1 << 8,
-    MSECCFG_SSEED = 1 << 9
+    MSECCFG_SSEED = 1 << 9,
+    MSECCFG_MLPE =  1 << 10,
 } mseccfg_field_t;
 
 typedef struct {
-- 
2.45.0


