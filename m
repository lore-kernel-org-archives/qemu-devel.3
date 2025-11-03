Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4B4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOr-0007tI-RI; Sun, 02 Nov 2025 22:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOX-0006ju-5J
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:13 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOT-0000HW-PP
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:12 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-340bcc92c7dso1314887a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141086; x=1762745886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VE850w2VZune3Rv7P2/wxE5A/k0uSV6iC0KR5YZXuw=;
 b=T1wlE6MXZ2eULCFhaXIlCkpQ7HJQqXVVlkRKfTxK3ws1ljwlE/9ut/Rk9MBo3YbRXB
 MX3yO1tVKqwE9t0+cA6GV6hfXnYGUmsdqrLJPOTc2+zUxw2tNQPf8oWLpv+5BgH8jmRF
 B2KwCdpmJqOzlxAj7ZDi8KCI25xm3S9ouZ404bOAsUEllqEMyUBDTkXnjt8zpHvDJW2G
 stDqWdiCqqye+ZgGFrgwQTxX0lrpvUYWzO+8PAACQZtV+MYw6/psPml29A8JdXUCTgpa
 SNCcP9q4NiMQzIAthnjsz/Yc2a+dyMg89m3hEGen1wdM1Udz876H8Ap9WZSm8eqALPH7
 QweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141086; x=1762745886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VE850w2VZune3Rv7P2/wxE5A/k0uSV6iC0KR5YZXuw=;
 b=qNaWh9LlPjYyXLQLqtyABOHv6sNpJkWaKY6zFIDRl0asDCW/mYyyEaHvVVAg2ry3+e
 rDY5/ggjynThaKc8FiY3GCuKKhUhxY2ubdvK5w8tHGiEg558evmcGvSMvMuFI8GZQTjT
 joezi2FPBcaLKQ5QdKk8rxzlJDc8jSUKmJMk9z+grQWrmasN/+ivyJ0sqN2kQOJ3BWZT
 BPf4c/Z+BcUTkCRtikRo/Cq3QaYlcR9/RptlwKHkMRQUDinVmlX6nlaLFj5lPAqKw/40
 YwCKLHyRRXuEBDG1A8YNSj2oT+np5I5wlv4ue9wDAQgPQ/oCJY42vuQeJUmqsVXtsnWH
 nheg==
X-Gm-Message-State: AOJu0YyQ2XuuzJa7gyQARxXmDmIrxhpgN4r6zJHQ7zkfPg1UqNQHbHIP
 E9xybhgCvctQylihaPuyS5zgh1txdY2cDo/KkQaJISrmedQiJSngU/3CwVcFvA==
X-Gm-Gg: ASbGncuYqxBtQ/7DQODdyIbK9LcVN9B97EVihvf4V7U+slwqzQNM6Ofb1tMHRLsvQ/l
 P/XNsg+QtJO4Ukrq6i3IOrFPy0MDTnlkZeahOHMCFF2yYVWYglufsJ8czwU/oY8eVrbINQYhX4z
 WZzMnRP+rFTFnZ/CImu/ODFjeNqOV9sh34wdwjGhew1YS4oGMP9pexGQqcD0Isu8PpyYmTBF55H
 PWP9/Fd5o62dWr/DZNpMBCe5WYKwTlC1yPBd8F2i+rinwm5Ih9fd/4sTDCnQvNr6Hi6gtEyD2M9
 5bNpTZnRg+7Og4j3cTKTIByd31LuLwHC4RvSZBIVRRwhp2QLV0SpWfvZH+jlfS9kGKS8Antg8fW
 Sb040KTl+xZpjBFnTJv0oJ7WPiuj2oVAVklI0Nh3V1TabYp4ZgDQxesoOB3qIzS1bFU6UkLJMc7
 mYWuGkC4cNx+JCMYeQec/lfWvEr4rc+N3KFy3hVw4qmyBcY3OVbHzA+qY7V7YkkJR32eQfzi9JM
 YSGIvNP
X-Google-Smtp-Source: AGHT+IFMTbs0/nlT0HXj+vTpNSiDWNDlEdVJWi4wvMaqREgM3GJkrVBpH9D9T1g7AEqIZU6+INn+SQ==
X-Received: by 2002:a17:90b:6cd:b0:340:e8ce:7569 with SMTP id
 98e67ed59e1d1-340e8ce7685mr5024939a91.12.1762141086419; 
 Sun, 02 Nov 2025 19:38:06 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:38:05 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 7/8] target/riscv: Combine mhpmcounter and mhpmcounterh
Date: Mon,  3 Nov 2025 13:37:12 +1000
Message-ID: <20251103033713.904455-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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
mhpmconter is a 64-bit register and mhpmcounterh refers to the top
32 bits of this register when XLEN == 32.  No real advantage is
gained by keeping them separate, and combining allows for slight
simplification.

Note, the cpu/pmu VMSTATE version is bumped breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251027181831.27016-9-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  10 ++--
 target/riscv/csr.c     |  76 ++++++++++++++--------------
 target/riscv/machine.c |  10 ++--
 target/riscv/pmu.c     | 111 +++++++++++------------------------------
 4 files changed, 73 insertions(+), 134 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d41105ca5..2e0b86e68d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -196,13 +196,9 @@ FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
-    target_ulong mhpmcounter_val;
-    /* Current value of a counter in RV32 */
-    target_ulong mhpmcounterh_val;
-    /* Snapshot values of counter */
-    target_ulong mhpmcounter_prev;
-    /* Snapshort value of a counter in RV32 */
-    target_ulong mhpmcounterh_prev;
+    uint64_t mhpmcounter_val;
+    /* Snapshot value of a counter */
+    uint64_t mhpmcounter_prev;
     /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
     target_ulong irq_overflow_left;
 } PMUCTRState;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9bff118e2c..8de89a1a6b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1302,24 +1302,27 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t mhpmctr_val = val;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    int deposit_size = rv32 ? 32 : 64;
+    uint64_t ctr;
+
+    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                         0, deposit_size, val);
 
-    counter->mhpmcounter_val = val;
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                ctr_idx, false);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, false);
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              0, deposit_size, ctr);
         if (ctr_idx > 2) {
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                mhpmctr_val = mhpmctr_val |
-                              ((uint64_t)counter->mhpmcounterh_val << 32);
-            }
-            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
+            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
      } else {
         /* Other counters can keep incrementing from the given value */
-        counter->mhpmcounter_prev = val;
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              0, deposit_size, val);
+
     }
 
     return RISCV_EXCP_NONE;
@@ -1329,21 +1332,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t mhpmctr_val = counter->mhpmcounter_val;
-    uint64_t mhpmctrh_val = val;
+    uint64_t ctrh;
 
-    counter->mhpmcounterh_val = val;
-    mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
+    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                         32, 32, val);
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                                 ctr_idx, true);
+        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, true);
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              32, 32, ctrh);
         if (ctr_idx > 2) {
-            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
+            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
     } else {
-        counter->mhpmcounterh_prev = val;
+        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                              32, 32, val);
     }
 
     return RISCV_EXCP_NONE;
@@ -1366,13 +1370,19 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                         bool upper_half, uint32_t ctr_idx)
+                                  bool upper_half, uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    target_ulong ctr_prev = upper_half ? counter->mhpmcounterh_prev :
-                                         counter->mhpmcounter_prev;
-    target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
-                                        counter->mhpmcounter_val;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    int start = upper_half ? 32 : 0;
+    int length = rv32 ? 32 : 64;
+    uint64_t ctr_prev, ctr_val;
+
+    /* Ensure upper_half is only set for XLEN == 32 */
+    g_assert(rv32 || !upper_half);
+
+    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
+    ctr_val  = extract64(counter->mhpmcounter_val, start, length);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
@@ -2996,6 +3006,7 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
     target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
     uint64_t mhpmctr_val, prev_count, curr_count;
+    uint64_t ctrh;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
     env->mcountinhibit = val & present_ctrs;
@@ -3014,17 +3025,13 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
             counter->mhpmcounter_prev =
                 riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
             if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_prev =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+                ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+                counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
+                                                      32, 32, ctrh);
             }
 
             if (cidx > 2) {
-                mhpmctr_val = counter->mhpmcounter_val;
-                if (riscv_cpu_mxl(env) == MXL_RV32) {
-                    mhpmctr_val = mhpmctr_val |
-                            ((uint64_t)counter->mhpmcounterh_val << 32);
-                }
-                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
+                riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cidx);
             }
         } else {
             curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
@@ -3036,18 +3043,11 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
                     riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
 
                 curr_count = curr_count | (tmp << 32);
-                mhpmctr_val = mhpmctr_val |
-                    ((uint64_t)counter->mhpmcounterh_val << 32);
-                prev_count = prev_count |
-                    ((uint64_t)counter->mhpmcounterh_prev << 32);
             }
 
             /* Adjust the counter for later reads. */
             mhpmctr_val = curr_count - prev_count + mhpmctr_val;
             counter->mhpmcounter_val = mhpmctr_val;
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                counter->mhpmcounterh_val = mhpmctr_val >> 32;
-            }
         }
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6146124229..09c032a879 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -335,14 +335,12 @@ static bool pmu_needed(void *opaque)
 
 static const VMStateDescription vmstate_pmu_ctr_state = {
     .name = "cpu/pmu",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = pmu_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
-        VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
+        VMSTATE_UINT64(mhpmcounter_val, PMUCTRState),
+        VMSTATE_UINT64(mhpmcounter_prev, PMUCTRState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 273822e921..708f2ec7aa 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -101,82 +101,6 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
-static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    target_ulong max_val = UINT32_MAX;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool virt_on = env->virt_enabled;
-
-    /* Privilege mode filtering */
-    if ((env->priv == PRV_M &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
-        (env->priv == PRV_S && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
-        (env->priv == PRV_U && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
-        (env->priv == PRV_S && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
-        (env->priv == PRV_U && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
-        return 0;
-    }
-
-    /* Handle the overflow scenario */
-    if (counter->mhpmcounter_val == max_val) {
-        if (counter->mhpmcounterh_val == max_val) {
-            counter->mhpmcounter_val = 0;
-            counter->mhpmcounterh_val = 0;
-            /* Generate interrupt only if OF bit is clear */
-            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-            }
-        } else {
-            counter->mhpmcounterh_val++;
-        }
-    } else {
-        counter->mhpmcounter_val++;
-    }
-
-    return 0;
-}
-
-static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t max_val = UINT64_MAX;
-    bool virt_on = env->virt_enabled;
-
-    /* Privilege mode filtering */
-    if ((env->priv == PRV_M &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
-        (env->priv == PRV_S && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
-        (env->priv == PRV_U && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
-        (env->priv == PRV_S && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
-        (env->priv == PRV_U && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
-        return 0;
-    }
-
-    /* Handle the overflow scenario */
-    if (counter->mhpmcounter_val == max_val) {
-        counter->mhpmcounter_val = 0;
-        /* Generate interrupt only if OF bit is clear */
-        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-        }
-    } else {
-        counter->mhpmcounter_val++;
-    }
-    return 0;
-}
-
 /*
  * Information needed to update counters:
  *  new_priv, new_virt: To correctly save starting snapshot for the newly
@@ -275,8 +199,10 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
-    int ret;
     CPURISCVState *env = &cpu->env;
+    uint64_t max_val = UINT64_MAX;
+    bool virt_on = env->virt_enabled;
+    PMUCTRState *counter;
     gpointer value;
 
     if (!cpu->cfg.pmu_mask) {
@@ -293,13 +219,34 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
         return -1;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        ret = riscv_pmu_incr_ctr_rv32(cpu, ctr_idx);
+    /* Privilege mode filtering */
+    if ((env->priv == PRV_M &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
+        (env->priv == PRV_S && virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
+        (env->priv == PRV_U && virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
+        (env->priv == PRV_S && !virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
+        (env->priv == PRV_U && !virt_on &&
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
+        return 0;
+    }
+
+    /* Handle the overflow scenario */
+    counter = &env->pmu_ctrs[ctr_idx];
+    if (counter->mhpmcounter_val == max_val) {
+        counter->mhpmcounter_val = 0;
+        /* Generate interrupt only if OF bit is clear */
+        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
+            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
+            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
+        }
     } else {
-        ret = riscv_pmu_incr_ctr_rv64(cpu, ctr_idx);
+        counter->mhpmcounter_val++;
     }
 
-    return ret;
+    return 0;
 }
 
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
@@ -470,8 +417,6 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
         curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
-        ctr_val = ctr_val |
-                ((uint64_t)counter->mhpmcounterh_val << 32);
     }
 
     /*
-- 
2.51.1


