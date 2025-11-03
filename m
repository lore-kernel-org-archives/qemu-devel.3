Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF78CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOr-0007st-RQ; Sun, 02 Nov 2025 22:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOp-0007l0-1z
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOc-0000I2-TQ
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:38:29 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so49629525ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141091; x=1762745891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESZmCOAL/v2snFTaG8vRNAqtzI3lQPV3ML5XBMQBy0E=;
 b=IHhELEsWayx6Q7bZ+xIa/edu1PDQPykoRA8nJZmVfq/vdfzs29w+pJTsUhujLN0sa9
 Di4UTn6301+mES4gpZ7dXSGpkhHmVHIO6emcTp0y7UHXCLiR2vLHb+qh+2wY8doiNyYg
 LTYPMlIT7o9ssk+YBDLCLqIz0bGZgOl9BIqS9oLDP69FxRNb8tYBG7s5NyRt2iIDNAgj
 ZS29dYkRLZYn3GO/b9WpF9pzv+4adph7TlAAh4ilRmC9B8Hi0zZcWggJLdnpPzD1gqiY
 zsvOTJhlkSBH7lzvs3moYmI6NC+Mlek+redQ+fjKkSFyJszXOne8nw9DkgHA11avBBmt
 64HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141091; x=1762745891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESZmCOAL/v2snFTaG8vRNAqtzI3lQPV3ML5XBMQBy0E=;
 b=d2y+wJp6n8Qok7L7yNNgcyVttA3h675xeYxlLei/wkWxqGBbVzb3mfsovLPkHYdaS7
 lQe7ZtqWDKunvU99Iotn1ZOgjE6KnkX1+wnKMhRxoPgNfB6PPNtwFZfJvExoyzGRrxMP
 c291HtJBrpTdmBaGPyRo5pet6uczsF/PKqEkpANZtjBwZ3skCh/CDP2zlXYE1EkoKbBk
 btVbQYGplO1Hl7io+UKgw206UCFN1OinVwj6U/0dHlsc7OvfT78SXahQHcdViNUIVoha
 tp/tLhN4GEQxfvxbq57oPLJ4vy6kgY75nO4SrkH8RB2lJyu1pnaW/dV6v/jsckDQA6hn
 vL1Q==
X-Gm-Message-State: AOJu0Yw+ejBScu16YS/kYjce9JBU5IpQgXyGJhdQBmq4IM0cQhD6igYT
 cpiIb2/VOlqnwrbOrv+iqeak8m33u5RH1hkOuHzkpMZOSw7W3E1r5dFyKBnuKg==
X-Gm-Gg: ASbGncvGKS53oiX/jR/s9pxmpxznowbN35NYJpMHDmA+9jBe81Zc2KbYnJqrkfAyDL4
 hiHgT+uVnMp8IZYQT5y8AuQVK2tmKF50CbkslGHFraYnpHgSVtH8HxtW1kJjB9dNhVBJu4Mgi6l
 ANKbIGBEX06iAKyL0o0hLe3bAS1mqE0WqmCD2M1pn1u1zT3GiQIMKp2kowg39WwqohaHM8g20kQ
 Eu4YgPdmbnBWvTgcksN8KfSPHobUJhjW0AMA9DAMrrPLLj1sQGeLoZ2OLEUByhCt0NQJXSlkGUF
 qcnH7Q0znjnx5J1LGj6p3YBsNHgZidGkLpdjA5mcYz9amGYwTZxLPwPbYcr7ApDc0vN9YK85mbv
 s1f/Olh1W6ZZVMaPBSf2XHgTZOAOf9cEo2BtE4tiloLwBEQZOOFoLipa6TIHqHa3TLjFVdkXYJE
 a5QxyQCWOy3Sajk/22NVmNxxdjEc3M4RruzMLLBuK4VARU3IGZy6Ho5UpsTqClv+x7jECxaNkoj
 NcoNh6idCX481z2x30=
X-Google-Smtp-Source: AGHT+IHksu4R11WPc80ZF4AYHZhuZOvFgh6XDokpUvx3DBw0MF+Nwg4RkEpwQQxHI4zfp+ZCzUOeqg==
X-Received: by 2002:a17:902:db09:b0:295:8c51:6505 with SMTP id
 d9443c01a7336-2958c516a0emr48593315ad.33.1762141091393; 
 Sun, 02 Nov 2025 19:38:11 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:38:10 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 8/8] target/riscv: Remove upper_half from
 riscv_pmu_ctr_get_fixed_counters_val
Date: Mon,  3 Nov 2025 13:37:13 +1000
Message-ID: <20251103033713.904455-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

Now that mhpmcounter is always a 64-bit value we can remove the
upper_half argument from riscv_pmu_ctr_get_fixed_counters_val() and
always return a 64-bit value.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8de89a1a6b..6e7b6d7019 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1235,14 +1235,12 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
-                                                         int counter_idx,
-                                                         bool upper_half)
+static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                     int counter_idx)
 {
     int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
     uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
     uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
-    target_ulong result = 0;
     uint64_t curr_val = 0;
     uint64_t cfg_val = 0;
 
@@ -1262,7 +1260,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
             curr_val = cpu_get_host_ticks();
         }
 
-        goto done;
+        return curr_val;
     }
 
     /* Update counter before reading. */
@@ -1288,14 +1286,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
         curr_val += counter_arr_virt[PRV_U];
     }
 
-done:
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        result = upper_half ? curr_val >> 32 : curr_val;
-    } else {
-        result = curr_val;
-    }
-
-    return result;
+    return curr_val;
 }
 
 static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
@@ -1312,7 +1303,7 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, false);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               0, deposit_size, ctr);
         if (ctr_idx > 2) {
@@ -1339,7 +1330,7 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, true);
+        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               32, 32, ctrh);
         if (ctr_idx > 2) {
@@ -1399,7 +1390,7 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
+        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
                                                     ctr_prev + ctr_val;
     } else {
         *val = ctr_val;
@@ -3006,7 +2997,6 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
     target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
     uint64_t mhpmctr_val, prev_count, curr_count;
-    uint64_t ctrh;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
     env->mcountinhibit = val & present_ctrs;
@@ -3022,28 +3012,16 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
         counter = &env->pmu_ctrs[cidx];
 
         if (!get_field(env->mcountinhibit, BIT(cidx))) {
-            counter->mhpmcounter_prev =
-                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-                counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                                      32, 32, ctrh);
-            }
+            counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
 
             if (cidx > 2) {
                 riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cidx);
             }
         } else {
-            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
 
             mhpmctr_val = counter->mhpmcounter_val;
             prev_count = counter->mhpmcounter_prev;
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                uint64_t tmp =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-
-                curr_count = curr_count | (tmp << 32);
-            }
 
             /* Adjust the counter for later reads. */
             mhpmctr_val = curr_count - prev_count + mhpmctr_val;
-- 
2.51.1


