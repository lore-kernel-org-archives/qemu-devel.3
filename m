Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA736C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 00:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWM-0007o2-8u; Wed, 26 Jun 2024 19:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWK-0007ms-OD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWI-0005XU-NJ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70675977d0eso3686919b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446264; x=1720051064;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mTWjU6qZpbsY/NAdHVA4r9+MI5HJUzE0yl/WBRgqzHs=;
 b=c0ljIHIHeZD+koKbRcMlF9yU9RmuI7vAxVnWLK+Dx/5eWm8bk1aollW93lgB4/nZVs
 4YPMVI1LA8q/nn/53c4Fo8w0J95+Ig5wZEY1JqX2Z/VqNkIe5xaRvXgpjpshspnPoskl
 G/c4H6FgDJxmM+Vclg2fcPO/51H7DHsSxFixdlslceh02jO2aaVMe/HT22VLffLRfbTj
 Z2yMbaxy7x3/qWOqRA2adNwwwAbHFZ8eRj5LkkvBP8Zz/egeDKEoKscgUp1ClPS82D4P
 9L9rLVkOJFTqIoaCHYwjgJjcMnEZZULsZR7LyOyolApyOfL/iFjeK9d4QGENy4aBIHez
 exCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446264; x=1720051064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTWjU6qZpbsY/NAdHVA4r9+MI5HJUzE0yl/WBRgqzHs=;
 b=aDo4Fke+sZHpaIUPi2QsVvr0d2tr3B8Zje5/I7+n0kQDXN7s90AZo/dzUK1e7dcnEi
 tkyYnsoaraZjUa7zURrV8IrhGYoJfOZzomBKObL9MxJA0sWIKqisuWQYVvdpNVxsT+x/
 03hR5Jyt77TI9XxUxQn/7YBIhJT01u9+IPmW/4JyTSyoJGL9IwFse3hhD0gUGg/Oxi0Q
 J90xJxSLiE/o8iOtB8GHpI1lP3uQ2TFzSoGe/c77sHNSPtlmjonah1vPJ/cm8tdPd158
 O5BRS2ts5ywtD46NBbQrsfIEhm77dnaKMzVud1WIlPmFsya6ztsV9lbyQXaWRSfozmj4
 zwNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlGk5pmpMd69sBuZHgV0QbaCnuud5hFWuQCrjl+my6nUEEJkhqrcGpLh0fCZ1/Io//5GYdFZ9IX+RkyY3PNfoA0OksUi8=
X-Gm-Message-State: AOJu0YxjR5Tb61+R6Vuc1DeQfR+jz1tTWxilcnPYI6paB9yyufQJP8Oc
 fWS2JmB+4UTTKlhfFPJjTqpC2N99Fcn934GDdCIoRo5aWyCXkVuKHsO+DiepYLU=
X-Google-Smtp-Source: AGHT+IHxL4TEA/2BqbOOa55499cFfIwl21VlwLpHycHdYmHiH5Rgk4OQh9W623iKHDwiu/BwJ87odg==
X-Received: by 2002:a05:6a20:af8f:b0:1b5:fd58:30e8 with SMTP id
 adf61e73a8af0-1bcf7ead900mr9466689637.18.1719446264215; 
 Wed, 26 Jun 2024 16:57:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 16:57:27 -0700
Subject: [PATCH v7 07/11] target/riscv: Save counter values during
 countinhibit update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-smcntrpmf_v7-v7-7-bb0f10af7fa9@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42c.google.com
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

Currently, if a counter monitoring cycle/instret is stopped via
mcountinhibit we just update the state while the value is saved
during the next read. This is not accurate as the read may happen
many cycles after the counter is stopped. Ideally, the read should
return the value saved when the counter is stopped.

Thus, save the value of the counter during the inhibit update
operation and return that value during the read if corresponding bit
in mcountihibit is set.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h     |  1 -
 target/riscv/csr.c     | 34 ++++++++++++++++++++++------------
 target/riscv/machine.c |  5 ++---
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d56d640b06be..91fe2a46ba35 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -153,7 +153,6 @@ typedef struct PMUCTRState {
     target_ulong mhpmcounter_prev;
     /* Snapshort value of a counter in RV32 */
     target_ulong mhpmcounterh_prev;
-    bool started;
     /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
     target_ulong irq_overflow_left;
 } PMUCTRState;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c292d036bcb2..e4adfa324efe 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1062,17 +1062,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
-         * Counter should not increment if inhibit bit is set. We can't really
-         * stop the icount counting. Just return the counter value written by
-         * the supervisor to indicate that counter was not incremented.
+         * Counter should not increment if inhibit bit is set. Just return the
+         * current counter value.
          */
-        if (!counter->started) {
-            *val = ctr_val;
-            return RISCV_EXCP_NONE;
-        } else {
-            /* Mark that the counter has been stopped */
-            counter->started = false;
-        }
+         *val = ctr_val;
+         return RISCV_EXCP_NONE;
     }
 
     /*
@@ -2114,9 +2108,25 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
 
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
-        if (!get_field(env->mcountinhibit, BIT(cidx))) {
             counter = &env->pmu_ctrs[cidx];
-            counter->started = true;
+        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
+            /*
+             * Update the counter value for cycle/instret as we can't stop the
+             * host ticks. But we should show the current value at this moment.
+             */
+            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
+                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
+                counter->mhpmcounter_val =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false) -
+                                           counter->mhpmcounter_prev +
+                                           counter->mhpmcounter_val;
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    counter->mhpmcounterh_val =
+                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) -
+                                                counter->mhpmcounterh_prev +
+                                                counter->mhpmcounterh_val;
+                }
+            }
         }
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 76f2150f78b5..492c2c6d9d79 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -320,15 +320,14 @@ static bool pmu_needed(void *opaque)
 
 static const VMStateDescription vmstate_pmu_ctr_state = {
     .name = "cpu/pmu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmu_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
-        VMSTATE_BOOL(started, PMUCTRState),
         VMSTATE_END_OF_LIST()
     }
 };

-- 
2.34.1


