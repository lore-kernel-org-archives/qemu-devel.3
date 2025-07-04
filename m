Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C24C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLe-0001tD-Oj; Fri, 04 Jul 2025 07:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLY-0001nC-TQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLU-0002YE-Mf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234c5b57557so8804725ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627562; x=1752232362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7kVqX7i2Q5mE5/XYi8yZYkv70bcetDYLM46qvs6C6w=;
 b=DvDmru+UZzbz8fuVagmTvp+FeEK7Ht2HjOJUdifc2uAYHgchd6eSWDdoNmAv3kExPn
 OyPZTM4FnqV8L41Tkb3Hs1SojF863bQezoauN/Vo2p2VHIMO0Q3KBiGi/VpfQxbmTxsH
 Im0Fy6X7SN7X9SxS1wxd+OWuT5mAGGfFXke0Y5DMMTb+hkTVKMczKmDNOnYpAyKxd7uZ
 yBGk5OxNKjsiIaaLp1HeEhuCVUiZv3Gh2csahYa57FNKqh/HBdOaA+BBR4K2zGN3uE8O
 6vyYkV/9MfIrA4bjFRwhzvo57uY3/Vl+7YI66bTjHiR+8m3QDF9KttYspdLWEx2028sK
 1HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627562; x=1752232362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7kVqX7i2Q5mE5/XYi8yZYkv70bcetDYLM46qvs6C6w=;
 b=pj1QAPsrV9PegUsZkpbiKtq4YB14fSMs0EcQQ1bwJlvEalIPPpLvhNk54lbPeAlzg7
 j3pv52EdygNLggxG+188kiZ+XmBFtB4HrUDi1/1i+7oNvIm95P+1l6TxghOkhwnTlCxG
 VtipqOV6+ija3CtlRbxQK5Qrc/V18UOsD2AQvgQLHBCr/R1gykUQnWxz7X0HvPbtqzG0
 +zMxVZ5WYqktGA2yYWV5J4s+BY+KGoHCg3gFXFzu3VkNIMlJAslsjsj8jMTIFGwLE+iS
 U1OfQNxqPqF/ix8DumWftxEuwOs1CdrZpzU41Q1R5HbFz/blNARTYfT+sH2ARkr5wrsT
 0KPA==
X-Gm-Message-State: AOJu0YyAWnMu7ht+xtaMWQ10KuU4Mn8E7ZYt/Nl4185sGAof/fSPKe8P
 SN1xSERBvT7Q5PAUK1N1Jd/5xrAwxlU2+j3hXGH7ni43CbmpxruekDGuq6uteg==
X-Gm-Gg: ASbGnctw9wXcarV7XTEAHQzyXA84CeZu9farLNXdGrE5z+UleOWO/EJJ4ye6E7MWYDU
 gK1R9xVVMPN9dZuSH/eUXHffEGyjPng+8GXKx1wTlgyC0miswGcbbFj1rrUthk4ZjCM7muF9gHn
 +qxhIs30q1RPWqi0VACNN2hdK7HXdIkqjO64ZmymnE2vKct+Xn4UXyCzPUcMxPS+4LlYNkMYKdG
 n52kssT3cznA2DKHs7cq7cmlKymnKvsZO5HdX1gFFCHmK6EgedKWdCk5KLBbrPNsyMTwxY9LBHs
 O9x/XaLn/oU8VXVBfNURMQHXr8PE6zaCht0GDrUvi1gO/rpkqgMGWDdzvcpZ8kNLECixbjbv3iN
 WJO9zxjzCPIa798MmJirBdzQDz+jqim08EFvWURBaEHavRh1d6Y0PilPLJA3uU9ozTb8=
X-Google-Smtp-Source: AGHT+IEqZ9t9gLCIEUtlypjOFw4OuB8ySGRHy3zwhutL5SAtVvLuG+JGs059VMoCjgZFuwIt3V3gOA==
X-Received: by 2002:a17:903:1b68:b0:235:27b6:a897 with SMTP id
 d9443c01a7336-23c85e9c18fmr38715885ad.34.1751627561973; 
 Fri, 04 Jul 2025 04:12:41 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/40] target/riscv: Enable/Disable S/VS-mode Timer when STCE
 bit is changed
Date: Fri,  4 Jul 2025 21:11:31 +1000
Message-ID: <20250704111207.591994-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

Updating STCE will enable/disable SSTC in S-mode or/and VS-mode, so we
also need to update S/VS-mode Timer and S/VSTIP bits in $mip CSR.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250519143518.11086-5-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.h |  1 +
 target/riscv/csr.c         | 46 ++++++++++++++++++++++++++++++++++++++
 target/riscv/time_helper.c | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

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
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d8102943dd..1151ebb6ad 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3181,6 +3181,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
                     MENVCFG_CBZE | MENVCFG_CDE;
+    bool stce_changed = false;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -3206,8 +3207,18 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
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
 
@@ -3230,12 +3241,23 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
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
 
@@ -3313,8 +3335,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
     RISCVException ret;
+    bool stce_changed = false;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
@@ -3340,6 +3364,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
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
@@ -3347,6 +3376,10 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         env->vsstatus &= ~MSTATUS_SDT;
     }
 
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -3368,19 +3401,32 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
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
-- 
2.50.0


