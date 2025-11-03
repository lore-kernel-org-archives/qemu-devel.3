Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02A9CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOe-0006yJ-6C; Sun, 02 Nov 2025 22:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOH-0006AZ-4G
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:37:59 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOC-0000FF-M6
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:37:56 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34003f73a05so4469564a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141070; x=1762745870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRRMIdbr8VR60+qJ99qyy+pOkbkh65bQtH7ZfjoHVsM=;
 b=Zyg3F6crsvc43Z7vXqXAD4Otfkt+9JacJStgJnQGX6j+fBlndZgp6B3xpEslzxU3I2
 3bE8rTJhDGyvxq50JhjPnTDr6sjKdCm6RoXky42IQL9PcTU0KcWBcys8oB0CrQvnDd2k
 joBgNSdJMrknLiX3QwJBaU5JleEmORcmzDXppR5uYHys/Wv1VCSqhqOJxOGsvTKcQYAA
 BDEkCrBCCvrkxjYY/uHG0AmZQz0qEz2qq+ehr0Fdk/4GvCuCSIUoavfXqGZ18GdZl6/T
 VICRh7w+PrgXhp8ZMu1IeNeSXASwU77F6SdL4d7tZtF8Ij5hmHKdrypvj4pZtAsV0SFn
 unCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141070; x=1762745870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRRMIdbr8VR60+qJ99qyy+pOkbkh65bQtH7ZfjoHVsM=;
 b=RCI/4VD8zMOhO0uBahUdwCjKgIn+gmhNR1xdS/z39F+28rdtfel3WAwXQurtkO9mq6
 vNWzGYLuVPEzjboE9n99kIUl/3JsyVL7Mws8nyvSiLcdOjT7Ah8V5QMBq6wO/6b5NQZc
 3yXjQSR+MYRaDUhxzw5RZD4tQPo64WwtH6r4GEI+4tCv9NWEYZGRHjPDJToBY8F5GOmJ
 xH/vNZub5rXoUsbZmAzxZM7ySQZk3rzYKMHJeizDCiLVnCmjNg8zv+sp3ahdVLgTneNu
 LxnMZk8RWas67EjfV2i4eZ4qwsOaavuqiMrH5W5TaP8LMtCie8p/qw0WDqn/k2ZWAtDl
 Lssg==
X-Gm-Message-State: AOJu0YxHuSfNOIpQDeIrBeMku8WPGH1hTzPqLlxN6Zf6ZDFcFYIcO7Nb
 JwvabtyJq5eUsxn21jFZ62UrJclVNazy+g78FzD73UfMeEq4m5gd5c6y7JMU+g==
X-Gm-Gg: ASbGncsu9YwX+gT7rgoqA9DhAUy49xBfbJZLjq8DfEUrM1wFb+ccGlFjMtoFOgh90ae
 67EC6dttyylMQeUVMh+RsGLawWVN+qwKxcjaM7AqQ2eTN7ZlyOUGbCbLSl0F8VllpyfMDpiQGd3
 AGK2Vzk9640d3lk+KxWZbm2yck/RnduEV4YKW6qT5tN8lejywMAuIBlHvOnZPrro76WfMLOseuQ
 RMt4ERE2azY6qOH2sXHnTdwK9eZ6evCDB1j7eC/QdZDoNt90z6yRUVTtAXco77ZqttvgDxxwWpf
 +2Ven32bhyRs7wm7m9hbiMnyhhK/2geGYtvYCaDfBx+bif0NCl/x+e3CO5MZWLcPqIE7G/5WOzW
 da2YdXXQQI7bFUEmj/+15TbNCBTZFzYpXUjvdpPoVhugolz73Ykj0NhUNcN9vvVxNo7YOf4+fNL
 G+AEXD7LizUlEnb7OFhUR/8sCoyHo5IsCeI6x9qSmFjyJJp+m2NnCUe7lkFZ2FO/HrQwfBrg5QL
 5Xdp8SD
X-Google-Smtp-Source: AGHT+IGqGnzhFoexy5SPgA4aKvHTsmb3d+ot8Yr7Ukfcug319DUbduHiNnMsZ9AHknfVpJWL1CJmuw==
X-Received: by 2002:a17:90a:d410:b0:340:b572:3b81 with SMTP id
 98e67ed59e1d1-340b5723cf2mr10174105a91.11.1762141070445; 
 Sun, 02 Nov 2025 19:37:50 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:37:49 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 4/8] target/riscv: Combine mhpmevent and mhpmeventh
Date: Mon,  3 Nov 2025 13:37:09 +1000
Message-ID: <20251103033713.904455-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the privileged specification,
mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
when XLEN == 32 and accesses the top 32 bits of the 64-bit
mhpmeventn registers. Combine the two arrays of target_ulong
mhpmeventh[] and mhpmevent[] to a single array of uint64_t.

This also allows for some minor code simplification where branches
handling either mhpmeventh[] or mhpmevent[] could be combined.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027181831.27016-6-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 10 +++----
 target/riscv/csr.c     | 67 +++++++++++++++---------------------------
 target/riscv/machine.c |  3 +-
 target/riscv/pmu.c     | 53 ++++++++-------------------------
 4 files changed, 42 insertions(+), 91 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index adeb36abc2..0791959fcd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -428,11 +428,11 @@ struct CPUArchState {
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
 
-    /* PMU event selector configured values. First three are unused */
-    target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
-
-    /* PMU event selector configured values for RV32 */
-    target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
+    /*
+     * PMU event selector configured values. First three are unused.
+     * For RV32 top 32 bits are accessed via the mhpmeventh CSR.
+     */
+    uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
 
     PMUFixedCtrState pmu_fixed_ctrs[2];
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b0917f27bb..6b53a61c5b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1167,8 +1167,9 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
 
-    *val = env->mhpmevent_val[evt_index];
+    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
 
     return RISCV_EXCP_NONE;
 }
@@ -1177,13 +1178,11 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
-    uint64_t mhpmevt_val = val;
+    uint64_t mhpmevt_val;
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mhpmevent_val[evt_index] = val;
-        mhpmevt_val = mhpmevt_val |
-                      ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
@@ -1193,9 +1192,9 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
         mhpmevt_val = val & inh_avail_mask;
-        env->mhpmevent_val[evt_index] = mhpmevt_val;
     }
 
+    env->mhpmevent_val[evt_index] = mhpmevt_val;
     riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
 
     return RISCV_EXCP_NONE;
@@ -1206,7 +1205,7 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
 
-    *val = env->mhpmeventh_val[evt_index];
+    *val = extract64(env->mhpmevent_val[evt_index], 32, 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -1215,8 +1214,6 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                                        target_ulong val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
-    uint64_t mhpmevth_val;
-    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
 
@@ -1227,11 +1224,10 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
-    mhpmevth_val = val & inh_avail_mask;
-    mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
-    env->mhpmeventh_val[evt_index] = mhpmevth_val;
+    env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
+                                              32, 32, val & inh_avail_mask);
 
-    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    riscv_pmu_update_event_map(env, env->mhpmevent_val[evt_index], evt_index);
 
     return RISCV_EXCP_NONE;
 }
@@ -1254,9 +1250,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
         cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
     } else {
-        cfg_val = upper_half ?
-                  ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
-                  env->mhpmevent_val[counter_idx];
+        cfg_val = env->mhpmevent_val[counter_idx];
         cfg_val &= MHPMEVENT_FILTER_MASK;
     }
 
@@ -1475,27 +1469,23 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
 
 static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
                             target_ulong *val, target_ulong new_val,
-                            target_ulong wr_mask)
+                            uint64_t wr_mask)
 {
-    uint64_t mhpmevt_val = new_val;
+    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
 
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        *val = env->mhpmevent_val[evt_index];
+        *val = mhpmevt_val;
         if (riscv_cpu_cfg(env)->ext_sscofpmf) {
             *val &= ~MHPMEVENT_BIT_MINH;
         }
     } else if (wr_mask) {
         wr_mask &= ~MHPMEVENT_BIT_MINH;
-        mhpmevt_val = (new_val & wr_mask) |
-                      (env->mhpmevent_val[evt_index] & ~wr_mask);
-        if (riscv_cpu_mxl(env) == MXL_RV32) {
-            mhpmevt_val = mhpmevt_val |
-                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
-        }
+        /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
+        mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
         env->mhpmevent_val[evt_index] = mhpmevt_val;
         riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
     } else {
@@ -1509,24 +1499,23 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
                              target_ulong *val, target_ulong new_val,
                              target_ulong wr_mask)
 {
-    uint64_t mhpmevth_val;
     uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+    uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
 
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        *val = env->mhpmeventh_val[evt_index];
+        *val = mhpmevth_val;
         if (riscv_cpu_cfg(env)->ext_sscofpmf) {
             *val &= ~MHPMEVENTH_BIT_MINH;
         }
     } else if (wr_mask) {
         wr_mask &= ~MHPMEVENTH_BIT_MINH;
-        env->mhpmeventh_val[evt_index] =
-            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
-        mhpmevth_val = env->mhpmeventh_val[evt_index];
-        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
+        mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
+        mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
+        env->mhpmevent_val[evt_index] = mhpmevt_val;
         riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
     } else {
         return -EINVAL;
@@ -1602,8 +1591,6 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
     int i;
     *val = 0;
-    target_ulong *mhpm_evt_val;
-    uint64_t of_bit_mask;
 
     /* Virtualize scountovf for counter delegation */
     if (riscv_cpu_cfg(env)->ext_sscofpmf &&
@@ -1613,19 +1600,11 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
         return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpm_evt_val = env->mhpmeventh_val;
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-    } else {
-        mhpm_evt_val = env->mhpmevent_val;
-        of_bit_mask = MHPMEVENT_BIT_OF;
-    }
-
     for (i = mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
         if ((get_field(env->mcounteren, BIT(i))) &&
-            (mhpm_evt_val[i] & of_bit_mask)) {
-                    *val |= BIT(i);
-            }
+            (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF)) {
+            *val |= BIT(i);
+        }
     }
 
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ab0bc32e1f..6146124229 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -477,8 +477,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
-        VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-        VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEVENTS),
+        VMSTATE_UINT64_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
         VMSTATE_UINT64(env.sscratch, RISCVCPU),
         VMSTATE_UINT64(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.stimecmp, RISCVCPU),
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a68809eef3..273822e921 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -110,15 +110,15 @@ static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
 
     /* Privilege mode filtering */
     if ((env->priv == PRV_M &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_MINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
         (env->priv == PRV_S && virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_VSINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
         (env->priv == PRV_U && virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_VUINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
         (env->priv == PRV_S && !virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_SINH)) ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
         (env->priv == PRV_U && !virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_UINH))) {
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
         return 0;
     }
 
@@ -128,8 +128,8 @@ static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
             counter->mhpmcounter_val = 0;
             counter->mhpmcounterh_val = 0;
             /* Generate interrupt only if OF bit is clear */
-            if (!(env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_OF)) {
-                env->mhpmeventh_val[ctr_idx] |= MHPMEVENTH_BIT_OF;
+            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
+                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
                 riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
             }
         } else {
@@ -420,41 +420,14 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
     return 0;
 }
 
-static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
-{
-    target_ulong mhpmevent_val;
-    uint64_t of_bit_mask;
-
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-     } else {
-        mhpmevent_val = env->mhpmevent_val[ctr_idx];
-        of_bit_mask = MHPMEVENT_BIT_OF;
-    }
-
-    return get_field(mhpmevent_val, of_bit_mask);
-}
-
 static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
 {
-    target_ulong *mhpmevent_val;
-    uint64_t of_bit_mask;
-
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-     } else {
-        mhpmevent_val = &env->mhpmevent_val[ctr_idx];
-        of_bit_mask = MHPMEVENT_BIT_OF;
-    }
-
-    if (!get_field(*mhpmevent_val, of_bit_mask)) {
-        *mhpmevent_val |= of_bit_mask;
+    if (!get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
+        env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
         return true;
+    } else {
+        return false;
     }
-
-    return false;
 }
 
 static void pmu_timer_trigger_irq(RISCVCPU *cpu,
@@ -479,7 +452,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     }
 
     /* Generate interrupt only if OF bit is clear */
-    if (pmu_hpmevent_is_of_set(env, ctr_idx)) {
+    if (get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
         return;
     }
 
@@ -538,7 +511,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 
     /* No need to setup a timer if LCOFI is disabled when OF is set */
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
-        pmu_hpmevent_is_of_set(env, ctr_idx)) {
+        get_field(env->mhpmevent_val[ctr_idx], MHPMEVENT_BIT_OF)) {
         return -1;
     }
 
-- 
2.51.1


