Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6DEC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1bB-0001wE-6O; Mon, 19 May 2025 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uH1ay-0001sM-U1
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:36:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uH1as-0007Ri-Gg
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:36:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so3595704b3a.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1747665344; x=1748270144; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GbndAXV4v6g2dCc7mQwrcXqzsX47HXaqaJHhIk7YzPE=;
 b=OGVh8+qdSkvRuz5QEZrE9MNLtuS3wj8iELWigPiUjOsQx5V1J94PylcxYzo2m4Xp4R
 ZiVfWvi1KOZ2j3w/0Ids8UHiA4ksR4jSdbrxMJb1rZYB1PoVJRdmmxeshEA2iLyOB5Mh
 b/8b+Q4XU2OwDmCL9RV/7b+NO/4UDA2/vXkU4cXxh8JMTRnLeo4xodqXfN8sKC8r3N6e
 nal5Z5/XQf0YcQfJd+j0VEbH6WStvSlBb6Sjtk12h3Nd5166dlR7oQ4AN+i9ZJNF6NfA
 6xqyoMRyM1ineniabiic3Y/QAnKwk3dGwKcZA76Z/LqvTxf5LBnoT9ImmJIescG2tVdQ
 Av3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747665344; x=1748270144;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbndAXV4v6g2dCc7mQwrcXqzsX47HXaqaJHhIk7YzPE=;
 b=rnBwU4DeAbfi/N52P1+dVaXKFWVn97bpwiirIpX0/nXTolqYYI3V2QYkXFOkvGNFQ9
 3hWrQF0imxa6ZG1rbIV4MzW4UHFaDp0dZ0dEO0byaPKMoGfLtwUl1MxqnO28XSaI97KZ
 YsU2wG+TDNrHzZHTd+6Bvfp0CM3gV72SVZ61AHlBC7h5w2h+eILOzuyY7oksaRyqCpc5
 ce2XabPF6ldyW8goLL3H/zJdkaSSTBuRsjfld1zbfyo0EiKHA3ZXk4No4JcYCTh0BP4a
 QPbIO5OpeBNyZAX5O0RMGKWcTMSMEFjDs3kPpYTdgjB2IrvUQ8WAgZKQ1l4c1jnEbzF/
 YucQ==
X-Gm-Message-State: AOJu0Yy1yna80S5UvUDNY4jtaM2K98+X5tJxL+QIcrpkXAO4CBOAtdPx
 N1fQcE2j91YVeVp2TKaZwgs3yeguZCOAgh/PA4nJEmjZtxVNNS55rS+U7TrKUqdCJZWivbE257P
 Iuc5cGkrwz9cTiSHxwKGTVT5aBKLwpXc/ITCkDwnySy3+ohN0xtpLonjq7jjJuwD3sIcVuLUiob
 IMBk07kBEtQJkqBaCE8tMFLzKW9qPr/adRUo9GOQ==
X-Gm-Gg: ASbGncsuPpR2vBit/HDOIfzG/9nMScYkyXL/LC1ERAOIsY77YovQN/aKV+I2pJHaZ9W
 mu8k+3RLYVCf9gbXafmX31kLHzY0JZC4XJ01XyFwtUKnjlA7bDdxlbS7S/Vtkorw0w45qGprO/m
 5BF62GPKGdssDH03bXCk+Kjtu3txiYu3X3QzNfILi/9P62GCMkNGvXlM/hVlKtFYzx4GyXD3Ub2
 6NIeF2Yrk/Xv+x+qusbmFvPMaeI7/YxS85r2lV9B93H2wKlkR7hdyYAW9jHRdUGda5maMXNe/1/
 EKdHEjUmkTW1hiQ4rv1UiwKTT6HMap3S0X6we23reuLzpLDYn7T0R2NfuTWRPNmyT/+146KTlA=
 =
X-Google-Smtp-Source: AGHT+IFPKd/Iir7FJ48yhOkn6Nr9EhGdyZBWA8wkrUiHPZCDxm8xZ+EO33j1mWlq+MOHEoYJ5MWP5A==
X-Received: by 2002:a05:6a00:3e0b:b0:740:3830:4119 with SMTP id
 d2e1a72fcca58-742acd507b5mr17172144b3a.18.1747665344353; 
 Mon, 19 May 2025 07:35:44 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a32edsm6297683b3a.162.2025.05.19.07.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:35:43 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 4/4] target/riscv: Enable/Disable S/VS-mode Timer when STCE
 bit is changed
Date: Mon, 19 May 2025 22:35:18 +0800
Message-Id: <20250519143518.11086-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519143518.11086-1-jim.shu@sifive.com>
References: <20250519143518.11086-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x430.google.com
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

Updating STCE will enable/disable SSTC in S-mode or/and VS-mode, so we
also need to update S/VS-mode Timer and S/VSTIP bits in $mip CSR.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c         | 46 ++++++++++++++++++++++++++++++++++++++
 target/riscv/time_helper.c | 46 ++++++++++++++++++++++++++++++++++++++
 target/riscv/time_helper.h |  1 +
 3 files changed, 93 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 87c3c51f01..601699fdc1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3176,6 +3176,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
                     MENVCFG_CBZE | MENVCFG_CDE;
+    bool stce_changed = false;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -3201,8 +3202,18 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if ((val & MENVCFG_DTE) == 0) {
             env->mstatus &= ~MSTATUS_SDT;
         }
+
+        if (cfg->ext_sstc &&
+            ((env->menvcfg & MENVCFG_STCE) != (val & MENVCFG_STCE))) {
+            stce_changed = true;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, true, !!(val & MENVCFG_STCE));
+    }
+
     return write_henvcfg(env, CSR_HENVCFG, env->henvcfg, ra);
 }
 
@@ -3225,12 +3236,23 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                     (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
                     (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     uint64_t valh = (uint64_t)val << 32;
+    bool stce_changed = false;
+
+    if (cfg->ext_sstc &&
+        ((env->menvcfg & MENVCFG_STCE) != (valh & MENVCFG_STCE))) {
+        stce_changed = true;
+    }
 
     if ((valh & MENVCFG_DTE) == 0) {
         env->mstatus &= ~MSTATUS_SDT;
     }
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, true, !!(valh & MENVCFG_STCE));
+    }
+
     return write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32, ra);
 }
 
@@ -3308,8 +3330,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
     RISCVException ret;
+    bool stce_changed = false;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
@@ -3335,6 +3359,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
             get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
             mask |= HENVCFG_PMM;
         }
+
+        if (cfg->ext_sstc &&
+            ((env->henvcfg & HENVCFG_STCE) != (val & HENVCFG_STCE))) {
+            stce_changed = true;
+        }
     }
 
     env->henvcfg = val & mask;
@@ -3342,6 +3371,10 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         env->vsstatus &= ~MSTATUS_SDT;
     }
 
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -3363,19 +3396,32 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val, uintptr_t ra)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
                                     HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
+    bool stce_changed = false;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
+
+    if (cfg->ext_sstc &&
+        ((env->henvcfg & HENVCFG_STCE) != (valh & HENVCFG_STCE))) {
+        stce_changed = true;
+    }
+
     env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
     if ((env->henvcfg & HENVCFG_DTE) == 0) {
         env->vsstatus &= ~MSTATUS_SDT;
     }
+
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index aebf0798d0..400e917354 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -140,6 +140,52 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     timer_mod(timer, next);
 }
 
+/*
+ * When disabling xenvcfg.STCE, the S/VS Timer may be disabled at the same time.
+ * It is safe to call this function regardless of whether the timer has been
+ * deleted or not. timer_del() will do nothing if the timer has already
+ * been deleted.
+ */
+static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
+                                 uint32_t timer_irq)
+{
+    /* Disable S-mode Timer IRQ and HW-based STIP */
+    if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, MENVCFG_STCE)) {
+        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
+        timer_del(timer);
+        return;
+    }
+
+    /* Disable VS-mode Timer IRQ and HW-based VSTIP */
+    if ((timer_irq == MIP_VSTIP) &&
+        (!get_field(env->menvcfg, MENVCFG_STCE) ||
+         !get_field(env->henvcfg, HENVCFG_STCE))) {
+        env->vstime_irq = 0;
+        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
+        timer_del(timer);
+        return;
+    }
+}
+
+/* Enable or disable S/VS-mode Timer when xenvcfg.STCE is changed */
+void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable)
+{
+    if (enable) {
+        riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                  env->htimedelta, MIP_VSTIP);
+    } else {
+        riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
+    }
+
+    if (is_m_mode) {
+        if (enable) {
+            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+        } else {
+            riscv_timer_disable_timecmp(env, env->stimer, MIP_STIP);
+        }
+    }
+}
+
 void riscv_timer_init(RISCVCPU *cpu)
 {
     CPURISCVState *env;
diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
index cacd79b80c..af1f634f89 100644
--- a/target/riscv/time_helper.h
+++ b/target/riscv/time_helper.h
@@ -25,6 +25,7 @@
 void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
                                uint64_t timecmp, uint64_t delta,
                                uint32_t timer_irq);
+void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable);
 void riscv_timer_init(RISCVCPU *cpu);
 
 #endif
-- 
2.17.1


