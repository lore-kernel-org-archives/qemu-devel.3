Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AF9C5472D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibfk-0008Ho-6c; Mon, 26 Aug 2024 11:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibfd-00086S-2N
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:30:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibfa-0003bn-O5
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:30:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7c691c8f8dcso2753422a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724686213; x=1725291013;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRQLflAmXFEQshk7wJA80BTXWF9mr3mMeQvq+HP93Dg=;
 b=FBm/WqftuE+iVzCvVjn2ghdVZjOnLS1iGE4zczSV2mwzUwE/LQQihWh7DaalN+mFcG
 Sm0FLeM4oGKLTXCmq+tG2g3F/i02RX5uPD+CQkMmnA5ytDjM52HJlUW9Y8mPSVZr2r8b
 Kr/UzYIzJz2jY7nHp5gToDoK+dqnv0gk+wsplDno2vrBcKrI/yZeh1MPwzj/yOUuoo2G
 cOA+b12mz+aLUvUfl2q9if+C7TT00p87ZpEddb9dZ8Lxz5fPhkIoqjAgdTqG29COF1Fs
 ewx4Gqca0/wZk55OZGaoh1df2Aq3NzKp+ZARvHMTr42pdUGjSk62lgqNL21QFle6SZsp
 ykxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686213; x=1725291013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRQLflAmXFEQshk7wJA80BTXWF9mr3mMeQvq+HP93Dg=;
 b=Hs7Swh82EUjXLs4eyLY/5U7tpWeeaS79y5Px5epCW4BHlU2f3XKjZOqBjHeQDwL5QP
 1SDhCxNp0/oqkEsVS9syjNMKL50VtMaQHVkSZ52MEQ0XfzizL8rceyWMUR5HxnyTB/nm
 ISg0HJyn42u/mul//C6nd7Ne3pMBWBMarXBePTlQkkA4LdfY87Ur01NgGIk/Ga/gEdWu
 QLddNlvEAM4nJu70wmSqK3tdn60ALyTqn8pompMBh+I6/A3/D4e4yqcotFvStUlq5Ghf
 SiuSCm6W/hzPWSQ/zT/XD4pRM437cXsgSD4iqbFytuYT1/32i0BODwpBRDcylHW3R6sC
 uzlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKQBCRJaRCaubUHh/kErW9M16cVFUtnDJYO28nrXd2R/q5oOroOmS62lAFI8ixe35fah4LpVwxRY+u@nongnu.org
X-Gm-Message-State: AOJu0Yx+L9W5zIjxjrXp0jRdtCPnssAbBNepQa+IyrbeOMampco4DHgd
 zcNsRrYeAPWr52sTlF/uLMBXBjKL2+vNPo7p5T62WLmil+O/clns8knwrEXqnSV74+8BSF/nL2b
 J
X-Google-Smtp-Source: AGHT+IGrSgB5Fv3T9b5iaE8TIEtji4beFQn+eBn/r5qxQBOnIyZuB4pivC2nR7NcykQqt1FVM+xxLw==
X-Received: by 2002:a05:6a20:9f8c:b0:1c4:bf4a:6c0e with SMTP id
 adf61e73a8af0-1cc89d7e451mr11545534637.26.1724686213021; 
 Mon, 26 Aug 2024 08:30:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422eaabsm7396525b3a.12.2024.08.26.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:30:12 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v9 02/17] target/riscv: Introduce elp state and enabling
 controls for zicfilp
Date: Mon, 26 Aug 2024 08:29:34 -0700
Message-ID: <20240826152949.294506-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826152949.294506-1-debug@rivosinc.com>
References: <20240826152949.294506-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 5dfb3f39ab..8e1f05e5b1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -994,6 +994,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
 
+    /* on reset elp is clear */
+    env->elp = false;
+
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
      * extension is enabled.
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..f966c36a31 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -222,6 +222,8 @@ struct CPUArchState {
 
     target_ulong jvt;
 
+    /* elp state for zicfilp extension */
+    bool      elp;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c257c5ed7d..b05ebe6f29 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -545,6 +545,8 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
+#define MSTATUS_SPELP       0x00800000 /* zicfilp */
+#define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 
@@ -575,6 +577,7 @@ typedef enum {
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
 #define SSTATUS_MXR         0x00080000
+#define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
 
 #define SSTATUS64_UXL       0x0000000300000000ULL
 
@@ -747,6 +750,7 @@ typedef enum RISCVException {
 
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
+#define MENVCFG_LPE                        BIT(2) /* zicfilp */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -760,11 +764,13 @@ typedef enum RISCVException {
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
index 432c59dc66..5771a14848 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1400,6 +1400,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    /* If cfi lp extension is available, then apply cfi lp mask */
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= (MSTATUS_MPELP | MSTATUS_SPELP);
+    }
+
     mstatus = (mstatus & ~mask) | (val & mask);
 
     env->mstatus = mstatus;
@@ -2101,6 +2106,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+
+        if (env_archcpu(env)->cfg.ext_zicfilp) {
+            mask |= MENVCFG_LPE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2153,6 +2162,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SENVCFG_LPE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2190,6 +2203,10 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+
+        if (env_archcpu(env)->cfg.ext_zicfilp) {
+            mask |= HENVCFG_LPE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -2654,6 +2671,10 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
         mask |= SSTATUS64_UXL;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= SSTATUS_SPELP;
+    }
+
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
 }
@@ -2665,6 +2686,11 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
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
@@ -2680,6 +2706,11 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
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
index 76f2150f78..873957c4ab 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -351,6 +351,24 @@ static const VMStateDescription vmstate_jvt = {
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
@@ -423,6 +441,7 @@ const VMStateDescription vmstate_riscv_cpu = {
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
2.44.0


