Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7057D6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo8-0003x8-9C; Thu, 18 Dec 2025 13:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWIn4-0003oA-1Y
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:54 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImz-0007M3-Ta
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:53 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-59431f57bf6so1018721e87.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082708; x=1766687508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9GTjMFaV7N8o4SrcAPpuEaFHzKRMNAJ0In4YQ733Ls=;
 b=Bc9I8WOi/lBR2SKfy4PWM1aEjcXQtxphH9Php1Qq2myuTXyUiqC7Nk54uzLefUCm5a
 yWfP1iRj10EckRUFwOnI0hfwKzHQGyQa056R+6QPfE8YdsM3Q3JO7c9xw6BGTZ43UfKp
 rLwWeNwNIqbUnK9BW1tXQHq+ClNV3IP0OjWBzr91b23k9y8z3Ht6BLhNEVZFu2wSxiQS
 21gwRLx3wofpCFm0wGDktgayCO6Flkvvvvxt8Frwu1JNyiTpLcarUzJ/U8zXLWcGkpAf
 fQUKGge7pwp7XCvPoSY52Mf9wZkOD39YrFa3xYVRTIG0dj514ZIAMXc1gfaBmJOpve+z
 FwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082708; x=1766687508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k9GTjMFaV7N8o4SrcAPpuEaFHzKRMNAJ0In4YQ733Ls=;
 b=VQ7UV1SABibMe2gcRzWBeQEZErIdWPIypfxR4HpUwHnlSLcJcQwSUfDR2d2Z14FHDr
 vVWezfnWLrYqQT4FJ1BaE5YXQ1AVUHBcZk9oIwiJ1u0NioAIUnXVOzFkt0rwNPzXpEzZ
 rdigF/ydSlOkzj8GTaGTUPc6fjXhfS8JcpnJj4VBs1V4c8PM/h4g0HgH7OVUKlWwY9m3
 zIFfF32pHKlU2Etv4rLmLSjpzkL7Vub7jOny43NYmY+nXGc1a7olvQAwqZKujcGmU0tJ
 mqQnFb6hDt44kwKlqwl7AwKAf2m42jApdexGksnWZjMbvs/JFxa5RBPfv+aQIw9Armxj
 Na8w==
X-Gm-Message-State: AOJu0YxvSX0UlJdyaVEY9z8mz2TOdzMWQxKNM1FVYjQgiyvoHH20U70m
 yKmSoSnU8gO3QKvflFVWG+l5J2Q2rOBAMhjgMEKPSxgK3KMBZKO6OgAXplUcjTiR
X-Gm-Gg: AY/fxX7PX4rW+dbLSIaVStqComwSq1j3hMyxLxVU/qMvCqqytUZ6rsG+7Z030VU82pz
 blefeldsOwEL6e3jugAYffThIwYIEy8svN/UMJZgFW+qxQzB8OuhxIbGa9qyjwpylJHWffXAwK4
 IJYQrG0hQI2eJeL/D+5RF04FpeTUk04bQ2VqhqPRsXg+QdGOlS8z/Y0gySXf/TsYk69n61ZA98X
 rtIJfjN+IlVYNbwGLxukzEL/KxPVyT17apIu+nvd7YxckxHw2LMtSHbvsxAOFzd09z87ESi+ZBI
 OC9dsvF2P96FkOxiMI6yfBPlTD7po5dYA1gDxZlslL5m+RN1m17sN324UYQaTYUoKY9av4Zh1nl
 YC7jsn0JJqaSNrc6HjWjPpP64fVu9VzuM4vOA0ixQPm1BHuJy530TER6nl3xHP9YCg4bbZ6BNxB
 VqWKnhrOlVDIR8
X-Google-Smtp-Source: AGHT+IH/Xkvfkl19cXASYaHkmb/CplFOkafM7L+4S4yJ7pVmEZ+0QLwwH6hjfRpo1zR72TP7ALqy1w==
X-Received: by 2002:a05:6512:220d:b0:59a:123e:69ac with SMTP id
 2adb3069b0e04-59a17d43b8fmr178736e87.27.1766082707364; 
 Thu, 18 Dec 2025 10:31:47 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:46 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 4/6] target/riscv: Rearrange custom hpm counter api
Date: Thu, 18 Dec 2025 21:31:19 +0300
Message-ID: <20251218183122.408690-5-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218183122.408690-1-sergeev0xef@gmail.com>
References: <20251218183122.408690-1-sergeev0xef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:45 -0500
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

Current counter api lacks extendability.
Vendor may want to implement some custom logic for the events
To do that, vendor must hardcode it right inside the general methods.
So if there are two different vendors with their own events,
they would write their code right beside each other.

The counter api was unified to make it extendable,
letting vendor fully customize the logic.

The counter is now described with 2 actions:
- read:
  returns the current value of the counter
- write:
  sets the value of the counter

All the logic for the counters, including inhibiting, filtering, etc,
is written in terms of read/write and completely determined by the vendor.
Vendor is up to choose how to use prev & val variables.
(including totally ignoring them), so we can't rely on any values in it.

Also 64bit variables are now used for prev & val,
avoiding manual handling of 32bit overflows
and making code a bit more clean & simple.

Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Alexei Filippov <halip0503@gmail.com>
---
 target/riscv/cpu.h        |  81 ++++++--
 target/riscv/cpu_helper.c |  11 +-
 target/riscv/csr.c        | 337 ++++++++++++---------------------
 target/riscv/machine.c    |   7 +-
 target/riscv/pmu.c        | 383 ++++++++++++++++++++++----------------
 target/riscv/pmu.h        |  17 +-
 6 files changed, 431 insertions(+), 405 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8ab5fa0afb..d8d20559d1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -194,28 +194,44 @@ FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 2)
 FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 
+/*
+ * Let the counter count some event E.
+ *
+ * Lets call a `raw` value of the counter some arbitrary value,
+ * which increases as event E happens.
+ * Lets also assume the `raw` value is read-only and can't be changed by us.
+ *
+ * Now we want to initialize the counter with some value X.
+ * For that lets add a few more variables:
+ * `val` would contain our initial value X,
+ * `prev` would contain the `raw` value of the counter at the moment of the write.
+ * `(raw - prev)` is `delta` -- the number of events,
+ *  which happened since the last write.
+ *
+ * So the current value of the counter can be calculated as
+ * `(delta + val) == (raw - prev + val)`.
+ *
+ * Each time you write X to the counter, just do:
+ * `val = X; prev = raw`
+ * We can also avoid manual usage of `raw` in code by doing:
+ * `val = X; prev += delta`
+ *
+ * We also want to inhibit our counter sometimes.
+ * If the counter is inhibited, just assume `delta == 0`.
+ *
+ * Text above describes the way builtin counters (mcycle, minstret)
+ * work. However, when implementing vendor events, you are
+ * free to use `prev` and `val` registers whatever you want.
+ */
 typedef struct PMUCTRState {
     /* Current value of a counter */
-    target_ulong mhpmcounter_val;
-    /* Current value of a counter in RV32 */
-    target_ulong mhpmcounterh_val;
+    uint64_t mhpmcounter_val;
     /* Snapshot values of counter */
-    target_ulong mhpmcounter_prev;
-    /* Snapshort value of a counter in RV32 */
-    target_ulong mhpmcounterh_prev;
-    /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
-    target_ulong irq_overflow_left;
+    uint64_t mhpmcounter_prev;
+    /* Is counter overflowed */
+    bool overflowed;
 } PMUCTRState;
 
-typedef struct PMUFixedCtrState {
-        /* Track cycle and icount for each privilege mode */
-        uint64_t counter[4];
-        uint64_t counter_prev[4];
-        /* Track cycle and icount for each privilege mode when V = 1*/
-        uint64_t counter_virt[2];
-        uint64_t counter_virt_prev[2];
-} PMUFixedCtrState;
-
 struct CPUArchState {
     target_ulong gpr[32];
     target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -434,8 +450,6 @@ struct CPUArchState {
     /* PMU event selector configured values for RV32 */
     target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
 
-    PMUFixedCtrState pmu_fixed_ctrs[2];
-
     target_ulong sscratch;
     target_ulong mscratch;
 
@@ -464,6 +478,35 @@ struct CPUArchState {
     uint64_t (*rdtime_fn)(void *);
     void *rdtime_fn_arg;
 
+    /*machine specific pmu callback */
+
+    /*
+     * Returns uint64 value of the counter `ctr_idx`.
+     *
+     * Should also set `PMUCTRState::overflowed`,
+     * if the counter overflows.
+     *
+     * See `riscv_pmu_ctr_read_general` for the example.
+     */
+    RISCVException (*pmu_ctr_read)(CPURISCVState *env, uint32_t ctr_idx,
+                                   uint64_t *value);
+    /*
+     * Writes value to the counter `ctr_idx`.
+     *
+     * Guarantied to be called for vendor events, when:
+     * - inhibiting/uninhibiting
+     * - switching cpu mode (to support filtering)
+     * - changing mhpmevent/mhpmeventh
+     *
+     * See `riscv_pmu_ctr_write_general` for the example.
+     */
+    RISCVException (*pmu_ctr_write)(CPURISCVState *env, uint32_t ctr_idx,
+                                    uint64_t value);
+    /*
+     * Returns true, if the event is supported by vendor.
+     */
+    bool (*pmu_vendor_support)(CPURISCVState *env, uint32_t ctr_idx);
+
     /* machine specific AIA ireg read-modify-write callback */
 #define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
     ((((__xlen) & 0xff) << 24) | \
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b3780cf8a8..2703279847 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1036,10 +1036,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
         if (icount_enabled()) {
             riscv_itrigger_update_priv(env);
         }
-
-        riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
 
+    /*
+     * Preserve pmu ctr values and
+     * restore them after the mode change.
+     */
+    riscv_pmu_preserved_ctrs_t preserved_ctrs;
+    riscv_pmu_preserve_ctrs(env, preserved_ctrs);
+
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
     env->xl = cpu_recompute_xl(env);
@@ -1075,6 +1080,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
             riscv_cpu_update_mip(env, 0, 0);
         }
     }
+
+    riscv_pmu_restore_ctrs(env, preserved_ctrs);
 }
 
 /*
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fb052725fe..72715d9b15 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1060,6 +1060,14 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    RISCVException excp;
+    uint64_t ctr_val;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         env->mcyclecfg = val;
@@ -1075,7 +1083,9 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
         env->mcyclecfg = val & inh_avail_mask;
     }
 
-    return RISCV_EXCP_NONE;
+    excp = riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
+
+    return excp;
 }
 
 static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
@@ -1090,6 +1100,14 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
 {
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                  MCYCLECFGH_BIT_MINH);
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    RISCVException excp;
+    uint64_t ctr_val;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
 
     /* Set xINH fields if priv mode supported */
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MCYCLECFGH_BIT_UINH : 0;
@@ -1100,7 +1118,10 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
                        riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
 
     env->mcyclecfgh = val & inh_avail_mask;
-    return RISCV_EXCP_NONE;
+
+    excp = riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
+
+    return excp;
 }
 
 static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
@@ -1114,6 +1135,14 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
                                         target_ulong val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    RISCVException excp;
+    uint64_t ctr_val;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         env->minstretcfg = val;
@@ -1127,7 +1156,10 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
                            riscv_has_ext(env, RVS)) ? MINSTRETCFG_BIT_VSINH : 0;
         env->minstretcfg = val & inh_avail_mask;
     }
-    return RISCV_EXCP_NONE;
+
+    excp = riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
+
+    return excp;
 }
 
 static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
@@ -1142,6 +1174,14 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
 {
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                  MINSTRETCFGH_BIT_MINH);
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    RISCVException excp;
+    uint64_t ctr_val;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
 
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFGH_BIT_UINH : 0;
     inh_avail_mask |= riscv_has_ext(env, RVS) ? MINSTRETCFGH_BIT_SINH : 0;
@@ -1151,7 +1191,10 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
                        riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
 
     env->minstretcfgh = val & inh_avail_mask;
-    return RISCV_EXCP_NONE;
+
+    excp = riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
+
+    return excp;
 }
 
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
@@ -1168,14 +1211,17 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
     uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
-
-    uint64_t mhpmevt_val = val;
     uint64_t inh_avail_mask;
+    RISCVException excp;
+    uint64_t ctr_val;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         env->mhpmevent_val[ctr_idx] = val;
-        mhpmevt_val = mhpmevt_val |
-                      ((uint64_t)env->mhpmeventh_val[ctr_idx] << 32);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
@@ -1184,11 +1230,12 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                            riscv_has_ext(env, RVU)) ? MHPMEVENT_BIT_VUINH : 0;
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
-        mhpmevt_val = val & inh_avail_mask;
-        env->mhpmevent_val[ctr_idx] = mhpmevt_val;
+        env->mhpmevent_val[ctr_idx] = val & inh_avail_mask;
     }
 
-    return RISCV_EXCP_NONE;
+    excp = riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
+
+    return excp;
 }
 
 static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
@@ -1205,10 +1252,15 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                                        target_ulong val, uintptr_t ra)
 {
     uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
-    uint64_t mhpmevth_val;
-    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
+    RISCVException excp;
+    uint64_t ctr_val;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
 
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : 0;
     inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENTH_BIT_SINH : 0;
@@ -1216,191 +1268,74 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                        riscv_has_ext(env, RVU)) ? MHPMEVENTH_BIT_VUINH : 0;
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
+    env->mhpmeventh_val[ctr_idx] = val & inh_avail_mask;
 
-    mhpmevth_val = val & inh_avail_mask;
-    mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
-    env->mhpmeventh_val[ctr_idx] = mhpmevth_val;
+    excp = riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
 
-    return RISCV_EXCP_NONE;
-}
-
-static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
-                                                         int counter_idx,
-                                                         bool upper_half)
-{
-    int inst = (counter_idx == HPM_MINSTRET_IDX);
-    uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
-    uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
-    target_ulong result = 0;
-    uint64_t curr_val = 0;
-    uint64_t cfg_val = 0;
-
-    if (counter_idx == 0) {
-        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
-                  env->mcyclecfg;
-    } else if (counter_idx == 2) {
-        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
-                  env->minstretcfg;
-    } else {
-        cfg_val = upper_half ?
-                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
-                  env->mhpmevent_val[counter_idx];
-        cfg_val &= MHPMEVENT_FILTER_MASK;
-    }
-
-    if (!cfg_val) {
-        if (icount_enabled()) {
-                curr_val = inst ? icount_get_raw() : icount_get();
-        } else {
-            curr_val = cpu_get_host_ticks();
-        }
-
-        goto done;
-    }
-
-    /* Update counter before reading. */
-    riscv_pmu_update_fixed_ctrs(env, env->priv, env->virt_enabled);
-
-    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
-        curr_val += counter_arr[PRV_M];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
-        curr_val += counter_arr[PRV_S];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
-        curr_val += counter_arr[PRV_U];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
-        curr_val += counter_arr_virt[PRV_S];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
-        curr_val += counter_arr_virt[PRV_U];
-    }
-
-done:
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        result = upper_half ? curr_val >> 32 : curr_val;
-    } else {
-        result = curr_val;
-    }
-
-    return result;
-}
-
-static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
-                                          uint32_t ctr_idx)
-{
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t mhpmctr_val = val;
-
-    counter->mhpmcounter_val = val;
-    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (ctr_idx == HPM_MCYCLE_IDX || ctr_idx == HPM_MINSTRET_IDX)) {
-        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                ctr_idx, false);
-        if (ctr_idx > 2) {
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                mhpmctr_val = mhpmctr_val |
-                              ((uint64_t)counter->mhpmcounterh_val << 32);
-            }
-            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
-        }
-     } else {
-        /* Other counters can keep incrementing from the given value */
-        counter->mhpmcounter_prev = val;
-    }
-
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
-                                          uint32_t ctr_idx)
-{
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t mhpmctr_val = counter->mhpmcounter_val;
-    uint64_t mhpmctrh_val = val;
-
-    counter->mhpmcounterh_val = val;
-    mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (ctr_idx == HPM_MCYCLE_IDX || ctr_idx == HPM_MINSTRET_IDX)) {
-        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                 ctr_idx, true);
-        if (ctr_idx > 2) {
-            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
-        }
-    } else {
-        counter->mhpmcounterh_prev = val;
-    }
-
-    return RISCV_EXCP_NONE;
+    return excp;
 }
 
 static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
                                         target_ulong val, uintptr_t ra)
 {
     uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    uint64_t ctr_val;
+    RISCVException excp;
 
-    return riscv_pmu_write_ctr(env, val, ctr_idx);
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+        if (excp != RISCV_EXCP_NONE) {
+            return excp;
+        }
+
+        ctr_val = deposit64(ctr_val, 0, 32, val);
+        return riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
+    } else {
+        return riscv_pmu_ctr_write(env, ctr_idx, val);
+    }
 }
 
 static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
                                          target_ulong val, uintptr_t ra)
 {
     uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    uint64_t ctr_val;
+    RISCVException excp;
 
-    return riscv_pmu_write_ctrh(env, val, ctr_idx);
-}
-
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                         bool upper_half, uint32_t ctr_idx)
-{
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    target_ulong ctr_prev = upper_half ? counter->mhpmcounterh_prev :
-                                         counter->mhpmcounter_prev;
-    target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
-                                        counter->mhpmcounter_val;
-
-    if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
-        /*
-         * Counter should not increment if inhibit bit is set. Just return the
-         * current counter value.
-         */
-         *val = ctr_val;
-         return RISCV_EXCP_NONE;
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
     }
 
-    /*
-     * The kernel computes the perf delta by subtracting the current value from
-     * the value it initialized previously (ctr_val).
-     */
-    if (ctr_idx == HPM_MCYCLE_IDX || ctr_idx == HPM_MINSTRET_IDX) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
-                                                    ctr_prev + ctr_val;
-    } else {
-        *val = ctr_val;
-    }
+    ctr_val = deposit64(ctr_val, 32, 32, val);
 
-    return RISCV_EXCP_NONE;
+    return riscv_pmu_ctr_write(env, ctr_idx, ctr_val);
 }
 
 static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
     uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
-    return riscv_pmu_read_ctr(env, val, false, ctr_idx);
+    uint64_t ctr_val;
+    RISCVException excp;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    *val = ctr_val;
+
+    return excp;
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-
     uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
-    return riscv_pmu_read_ctr(env, val, true, ctr_idx);
+    uint64_t ctr_val;
+    RISCVException excp;
+
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+    *val = ctr_val >> 32;
+
+    return excp;
 }
 
 static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
@@ -2935,63 +2870,39 @@ static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
 static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
                                           target_ulong val, uintptr_t ra)
 {
-    int cidx;
-    PMUCTRState *counter;
+    uint32_t cidx;
     RISCVCPU *cpu = env_archcpu(env);
     uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
     target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
-    uint64_t mhpmctr_val, prev_count, curr_count;
-
-    /* WARL register - disable unavailable counters; TM bit is always 0 */
-    env->mcountinhibit = val & present_ctrs;
+    uint64_t ctr_val;
+    bool inhibit_bit;
+    RISCVException excp;
 
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
-        if (!(updated_ctrs & BIT(cidx)) ||
-            (cidx != HPM_MCYCLE_IDX && cidx != HPM_MINSTRET_IDX)) {
+        if (!get_field(updated_ctrs, BIT(cidx))) {
             continue;
         }
 
-        counter = &env->pmu_ctrs[cidx];
+        excp = riscv_pmu_ctr_read(env, cidx, &ctr_val);
+        if (excp != RISCV_EXCP_NONE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Reading the counter %d value is failed "
+                          "while changing the inhibit bit",
+                          cidx);
+            continue;
+        }
 
-        if (!get_field(env->mcountinhibit, BIT(cidx))) {
-            counter->mhpmcounter_prev =
-                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_prev =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-            }
+        inhibit_bit = get_field(val & present_ctrs, BIT(cidx));
+        env->mcountinhibit = set_field(env->mcountinhibit, BIT(cidx), inhibit_bit);
 
-            if (cidx > 2) {
-                mhpmctr_val = counter->mhpmcounter_val;
-                if (riscv_cpu_mxl(env) == MXL_RV32) {
-                    mhpmctr_val = mhpmctr_val |
-                            ((uint64_t)counter->mhpmcounterh_val << 32);
-                }
-                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
-            }
-        } else {
-            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
-
-            mhpmctr_val = counter->mhpmcounter_val;
-            prev_count = counter->mhpmcounter_prev;
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                uint64_t tmp =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-
-                curr_count = curr_count | (tmp << 32);
-                mhpmctr_val = mhpmctr_val |
-                    ((uint64_t)counter->mhpmcounterh_val << 32);
-                prev_count = prev_count |
-                    ((uint64_t)counter->mhpmcounterh_prev << 32);
-            }
-
-            /* Adjust the counter for later reads. */
-            mhpmctr_val = curr_count - prev_count + mhpmctr_val;
-            counter->mhpmcounter_val = mhpmctr_val;
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_val = mhpmctr_val >> 32;
-            }
+        excp = riscv_pmu_ctr_write(env, cidx, ctr_val);
+        if (excp != RISCV_EXCP_NONE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Writing to the counter %d value is failed "
+                          "while changing the inhibit bit",
+                          cidx);
+            continue;
         }
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18d790af0d..5083bbb1f2 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -339,10 +339,9 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
     .minimum_version_id = 2,
     .needed = pmu_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
+        VMSTATE_UINT64(mhpmcounter_val, PMUCTRState),
+        VMSTATE_UINT64(mhpmcounter_prev, PMUCTRState),
+        VMSTATE_BOOL(overflowed, PMUCTRState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index c503fffde1..5109fd14bf 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -80,120 +80,18 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
 }
 
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    if (ctr_idx < 3 || ctr_idx >= RV_MAX_MHPMCOUNTERS ||
-        !(cpu->pmu_avail_ctrs & BIT(ctr_idx))) {
-        return false;
-    } else {
-        return true;
-    }
-}
-
-static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     CPURISCVState *env = &cpu->env;
 
-    if (riscv_pmu_counter_valid(cpu, ctr_idx) &&
-        !get_field(env->mcountinhibit, BIT(ctr_idx))) {
+    if (!RISCV_PMU_CTR_IS_HPM(ctr_idx)) {
         return true;
-    } else {
+    }
+
+    if (!(cpu->pmu_avail_ctrs & BIT(ctr_idx))) {
         return false;
     }
-}
 
-/*
- * Information needed to update counters:
- *  new_priv, new_virt: To correctly save starting snapshot for the newly
- *                      started mode. Look at array being indexed with newprv.
- *  old_priv, old_virt: To correctly select previous snapshot for old priv
- *                      and compute delta. Also to select correct counter
- *                      to inc. Look at arrays being indexed with env->priv.
- *
- *  To avoid the complexity of calling this function, we assume that
- *  env->priv and env->virt_enabled contain old priv and old virt and
- *  new priv and new virt values are passed in as arguments.
- */
-static void riscv_pmu_icount_update_priv(CPURISCVState *env,
-                                         target_ulong newpriv, bool new_virt)
-{
-    uint64_t *snapshot_prev, *snapshot_new;
-    uint64_t current_icount;
-    uint64_t *counter_arr;
-    uint64_t delta;
-
-    if (icount_enabled()) {
-        current_icount = icount_get_raw();
-    } else {
-        current_icount = cpu_get_host_ticks();
-    }
-
-    if (env->virt_enabled) {
-        g_assert(env->priv <= PRV_S);
-        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
-        snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
-    } else {
-        counter_arr = env->pmu_fixed_ctrs[1].counter;
-        snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
-    }
-
-    if (new_virt) {
-        g_assert(newpriv <= PRV_S);
-        snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
-    } else {
-        snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
-    }
-
-     /*
-      * new_priv can be same as env->priv. So we need to calculate
-      * delta first before updating snapshot_new[new_priv].
-      */
-    delta = current_icount - snapshot_prev[env->priv];
-    snapshot_new[newpriv] = current_icount;
-
-    counter_arr[env->priv] += delta;
-}
-
-static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
-                                        target_ulong newpriv, bool new_virt)
-{
-    uint64_t *snapshot_prev, *snapshot_new;
-    uint64_t current_ticks;
-    uint64_t *counter_arr;
-    uint64_t delta;
-
-    if (icount_enabled()) {
-        current_ticks = icount_get();
-    } else {
-        current_ticks = cpu_get_host_ticks();
-    }
-
-    if (env->virt_enabled) {
-        g_assert(env->priv <= PRV_S);
-        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
-        snapshot_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
-    } else {
-        counter_arr = env->pmu_fixed_ctrs[0].counter;
-        snapshot_prev = env->pmu_fixed_ctrs[0].counter_prev;
-    }
-
-    if (new_virt) {
-        g_assert(newpriv <= PRV_S);
-        snapshot_new = env->pmu_fixed_ctrs[0].counter_virt_prev;
-    } else {
-        snapshot_new = env->pmu_fixed_ctrs[0].counter_prev;
-    }
-
-    delta = current_ticks - snapshot_prev[env->priv];
-    snapshot_new[newpriv] = current_ticks;
-
-    counter_arr[env->priv] += delta;
-}
-
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
-                                 bool new_virt)
-{
-    riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
-    riscv_pmu_icount_update_priv(env, newpriv, new_virt);
+    return env->pmu_vendor_support && env->pmu_vendor_support(env, ctr_idx);
 }
 
 static int64_t pmu_icount_ticks_to_ns(int64_t value)
@@ -249,51 +147,23 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
 static void pmu_timer_trigger_irq(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     CPURISCVState *env = &cpu->env;
-    PMUCTRState *counter;
-    int64_t irq_trigger_at;
-    uint64_t curr_ctr_val, curr_ctrh_val;
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t ctr_val;
-
-    if (ctr_idx != HPM_MINSTRET_IDX &&
-        ctr_idx != HPM_MCYCLE_IDX) {
-        return;
-    }
-
-    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
-        return;
-    }
+    RISCVException excp;
 
     /* Generate interrupt only if OF bit is clear */
     if (pmu_hpmevent_is_of_set(env, ctr_idx)) {
         return;
     }
 
-    counter = &env->pmu_ctrs[ctr_idx];
-    if (counter->irq_overflow_left > 0) {
-        irq_trigger_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                        counter->irq_overflow_left;
-        timer_mod_anticipate_ns(cpu->pmu_timer, irq_trigger_at);
-        counter->irq_overflow_left = 0;
+    excp = riscv_pmu_ctr_read(env, ctr_idx, &ctr_val);
+
+    if (excp != RISCV_EXCP_NONE) {
         return;
     }
 
-    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
-    ctr_val = counter->mhpmcounter_val;
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
-        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
-        ctr_val = ctr_val |
-                ((uint64_t)counter->mhpmcounterh_val << 32);
-    }
-
-    /*
-     * We can not accommodate for inhibited modes when setting up timer. Check
-     * if the counter has actually overflowed or not by comparing current
-     * counter value (accommodated for inhibited modes) with software written
-     * counter value.
-     */
-    if (curr_ctr_val >= ctr_val) {
-        riscv_pmu_setup_timer(env, curr_ctr_val, ctr_idx);
+    if (!counter->overflowed) {
+        riscv_pmu_setup_timer(env, ctr_val, ctr_idx);
         return;
     }
 
@@ -302,6 +172,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu, uint32_t ctr_idx)
             riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
         }
     }
+    counter->overflowed = false;
 }
 
 /* Timer callback for instret and cycle counter overflow */
@@ -320,7 +191,7 @@ void riscv_pmu_timer_cb(void *priv)
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 {
     uint64_t overflow_delta, overflow_at, curr_ns;
-    int64_t overflow_ns, overflow_left = 0;
+    uint64_t overflow_ns;
     RISCVCPU *cpu = env_archcpu(env);
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
 
@@ -330,6 +201,11 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
         return -1;
     }
 
+    if (counter->overflowed) {
+        pmu_timer_trigger_irq(cpu, ctr_idx);
+        return 0;
+    }
+
     if (value) {
         overflow_delta = UINT64_MAX - value + 1;
     } else {
@@ -338,28 +214,11 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 
     /*
      * QEMU supports only int64_t timers while RISC-V counters are uint64_t.
-     * Compute the leftover and save it so that it can be reprogrammed again
-     * when timer expires.
      */
-    if (overflow_delta > INT64_MAX) {
-        overflow_left = overflow_delta - INT64_MAX;
-    }
-
-    if (ctr_idx == HPM_MCYCLE_IDX ||
-        ctr_idx == HPM_MINSTRET_IDX) {
-        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
-        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
-    } else {
-        return -1;
-    }
+    overflow_ns = pmu_icount_ticks_to_ns(overflow_delta);
     curr_ns = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    overflow_at =  curr_ns + overflow_ns;
-    if (overflow_at <= curr_ns)
-        overflow_at = UINT64_MAX;
-
-    if (overflow_at > INT64_MAX) {
-        overflow_left += overflow_at - INT64_MAX;
-        counter->irq_overflow_left = overflow_left;
+    if (uadd64_overflow(curr_ns, overflow_ns, &overflow_at) ||
+        overflow_at > INT64_MAX) {
         overflow_at = INT64_MAX;
     }
     timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
@@ -426,3 +285,201 @@ uint32_t riscv_pmu_csrno_to_ctr_idx(int csrno)
     #undef HPMCOUNTER_START
     #undef CASE_RANGE
 }
+
+static uint64_t get_ticks(bool instructions)
+{
+    if (icount_enabled()) {
+        if (instructions) {
+            return icount_get_raw();
+        } else {
+            return icount_get();
+        }
+    } else {
+        return cpu_get_host_ticks();
+    }
+}
+
+static bool riscv_pmu_general_ctr_is_running(CPURISCVState *env, uint32_t ctr_idx)
+{
+    #define PRIV_CASE(priv, nonvirt, nonvirth, virt, virth) { \
+        case (priv): \
+            if (env->virt_enabled) { \
+                mask = (target_ulong) (virt); \
+                maskh = (target_ulong) (virth); \
+            } else { \
+                mask = (target_ulong) (nonvirt); \
+                maskh = (target_ulong) (nonvirth); \
+            } \
+            break; \
+        }
+
+    target_ulong event;
+    target_ulong eventh;
+    target_ulong mask = 0;
+    target_ulong maskh = 0;
+
+    if (!riscv_pmu_counter_valid(env_archcpu(env), ctr_idx)) {
+        return false;
+    }
+
+    if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
+        return false;
+    }
+
+    if (RISCV_PMU_CTR_IS_HPM(ctr_idx) &&
+            (env->mhpmevent_val[ctr_idx] == 0) && (env->mhpmeventh_val[ctr_idx] == 0)) {
+        return false;
+    }
+
+    if ((riscv_cpu_cfg(env)->ext_smcntrpmf && !RISCV_PMU_CTR_IS_HPM(ctr_idx)) ||
+        (riscv_cpu_cfg(env)->ext_sscofpmf && RISCV_PMU_CTR_IS_HPM(ctr_idx))) {
+        if (ctr_idx == HPM_MCYCLE_IDX) {
+            event = env->mcyclecfg;
+            eventh = env->mcyclecfgh;
+        } else if (ctr_idx == HPM_MTIME_IDX) {
+            return true;
+        } else if (ctr_idx == HPM_MINSTRET_IDX) {
+            event = env->minstretcfg;
+            eventh = env->minstretcfgh;
+        } else {
+            event = env->mhpmevent_val[ctr_idx];
+            eventh = env->mhpmeventh_val[ctr_idx];
+        }
+
+        switch (env->priv) {
+        PRIV_CASE(PRV_U, MHPMEVENT_BIT_UINH, MHPMEVENTH_BIT_UINH,
+                         MHPMEVENT_BIT_VUINH, MHPMEVENTH_BIT_VUINH);
+        PRIV_CASE(PRV_S, MHPMEVENT_BIT_SINH, MHPMEVENTH_BIT_SINH,
+                         MHPMEVENT_BIT_VSINH, MHPMEVENTH_BIT_VSINH);
+        PRIV_CASE(PRV_M, MHPMEVENT_BIT_MINH, MHPMEVENTH_BIT_MINH,
+                         MHPMEVENT_BIT_MINH,  MHPMEVENTH_BIT_MINH);
+        }
+
+        bool match = !(event & mask);
+        bool matchh = !(eventh & maskh);
+        return riscv_cpu_mxl(env) == MXL_RV32 ? match && matchh : match;
+    } else {
+        return true;
+    }
+    #undef PRIV_CASE
+}
+
+static uint64_t riscv_pmu_ctr_delta_general(CPURISCVState *env, uint32_t ctr_idx)
+{
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    if (riscv_pmu_general_ctr_is_running(env, ctr_idx)) {
+        return get_ticks(ctr_idx == HPM_MINSTRET_IDX) - counter->mhpmcounter_prev;
+    } else {
+        /*
+         * We assume, what write() is called after each change of
+         * inhibited/filtered status.
+         *
+         * So if counter is inhibited or filtered now, the delta is zero.
+         * (By definition of `prev`).
+         *
+         * See documentation for PMUCTRState.
+         */
+        return 0;
+    }
+}
+
+RISCVException riscv_pmu_ctr_read_general(CPURISCVState *env, uint32_t ctr_idx,
+                                          uint64_t *value)
+{
+
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    int64_t delta = riscv_pmu_ctr_delta_general(env, ctr_idx);
+    uint64_t result;
+
+    counter->overflowed |=
+        uadd64_overflow(counter->mhpmcounter_val, delta, &result);
+    *value = result;
+    return RISCV_EXCP_NONE;
+}
+
+RISCVException riscv_pmu_ctr_read(CPURISCVState *env, uint32_t ctr_idx,
+                                  uint64_t *value)
+{
+    if (RISCV_PMU_CTR_IS_HPM(ctr_idx)) {
+        if (!env->pmu_ctr_read) {
+            *value = 0;
+            return RISCV_EXCP_NONE;
+        }
+
+        return env->pmu_ctr_read(env, ctr_idx, value);
+    } else {
+        return riscv_pmu_ctr_read_general(env, ctr_idx, value);
+    }
+}
+
+RISCVException riscv_pmu_ctr_write_general(CPURISCVState *env, uint32_t ctr_idx,
+                                           uint64_t value)
+{
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+
+    counter->mhpmcounter_prev +=
+        riscv_pmu_ctr_delta_general(env, ctr_idx);
+    counter->mhpmcounter_val = value;
+    return RISCV_EXCP_NONE;
+}
+
+RISCVException riscv_pmu_ctr_write(CPURISCVState *env, uint32_t ctr_idx,
+                                   uint64_t value)
+{
+    RISCVException excp;
+
+    if (RISCV_PMU_CTR_IS_HPM(ctr_idx)) {
+        if (!env->pmu_ctr_write) {
+            value = 0;
+            return RISCV_EXCP_NONE;
+        }
+
+        excp = env->pmu_ctr_write(env, ctr_idx, value);
+    } else  {
+        excp = riscv_pmu_ctr_write_general(env, ctr_idx, value);
+    }
+
+    if (excp != RISCV_EXCP_NONE) {
+        return excp;
+    }
+
+    riscv_pmu_setup_timer(env, value, ctr_idx);
+
+    return RISCV_EXCP_NONE;
+}
+
+void riscv_pmu_preserve_ctrs(CPURISCVState *env, riscv_pmu_preserved_ctrs_t data)
+{
+    RISCVException excp;
+
+    for (uint32_t ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
+        excp = riscv_pmu_ctr_read(env, ctr_idx, &data[ctr_idx]);
+
+        if (excp != RISCV_EXCP_NONE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Reading the counter %d value is failed "
+                          "while changing the privilige mode",
+                          ctr_idx);
+            continue;
+        }
+
+    }
+}
+
+void riscv_pmu_restore_ctrs(CPURISCVState *env, riscv_pmu_preserved_ctrs_t data)
+{
+    RISCVException excp;
+
+    for (uint32_t ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
+        excp = riscv_pmu_ctr_write(env, ctr_idx, data[ctr_idx]);
+
+        if (excp != RISCV_EXCP_NONE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Writing to the counter %d value is failed "
+                          "while changing the privilige mode",
+                          ctr_idx);
+            continue;
+        }
+
+    }
+}
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 97b167d8f2..283e311b04 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -22,15 +22,24 @@
 #include "cpu.h"
 #include "qapi/error.h"
 
+#define RISCV_PMU_CTR_IS_HPM(x) ((x) > HPM_MINSTRET_IDX)
+
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
-                                 bool new_virt);
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                  bool upper_half, uint32_t ctr_idx);
 uint32_t riscv_pmu_csrno_to_ctr_idx(int csrno);
+RISCVException riscv_pmu_ctr_read(CPURISCVState *env, uint32_t ctr_idx,
+                                  uint64_t *val);
+RISCVException riscv_pmu_ctr_write(CPURISCVState *env, uint32_t ctr_idx,
+                                   uint64_t val);
+RISCVException riscv_pmu_ctr_read_general(CPURISCVState *env, uint32_t ctr_idx,
+                                          uint64_t *val);
+RISCVException riscv_pmu_ctr_write_general(CPURISCVState *env, uint32_t ctr_idx,
+                                           uint64_t val);
+typedef uint64_t riscv_pmu_preserved_ctrs_t[RV_MAX_MHPMCOUNTERS];
+void riscv_pmu_preserve_ctrs(CPURISCVState *env, riscv_pmu_preserved_ctrs_t data);
+void riscv_pmu_restore_ctrs(CPURISCVState *env, riscv_pmu_preserved_ctrs_t data);
 
 #endif /* RISCV_PMU_H */
-- 
2.51.0


