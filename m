Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E456C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbx-0006gb-1L; Wed, 17 Jul 2024 22:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbv-0006bI-Kw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbt-0003Tp-On
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fbe6f83957so2741475ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268668; x=1721873468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRhDrDpwlYWWyik+TFpeBeE6WrW74+aI/phXsI6QSuU=;
 b=nJbr/jD6gwvCoAY4XamM+2qAiW9QRyUb7GUcrlZxP9tAwpASEwzHzpAVl5rg4l+uKh
 ZfyEJWl02GHCbDQszzeAeX/BP5DJnus0xv04zSHIyOfajzb7LGi3S9aZ03kkHDzzZvsN
 yybxgP0Kj//82E5B5lgUWJUpksXA0BUATmZmpf0nyiBbgLQKuann8drja5Me/MEGJC0Q
 Eyi2CJC+DuKYxFRwndgLC6CqaH3ySeC97eJMa3OfBzXo28wx5CK7tMnJp4zXFfJvpHjS
 QXndQhCAwLkW/4rI2uS6/2F/mfNBz6dLP95RCM3/uKUBokruk4646+phWFcbagkrxbTX
 3ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268668; x=1721873468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRhDrDpwlYWWyik+TFpeBeE6WrW74+aI/phXsI6QSuU=;
 b=JnXzkajScoTG8MHA40BkKZ94lh9VBwGZQnVATEytWQT8OTOy7nNrmwq2T7JHZ0TVgK
 LOpNFvlU5VIGep/1QObbN1uADkT338dqakICW9LC6Hf1cxj4IyBmHc+0+2STHKZ6EGA+
 mumhVAgKofLEMQxneTPiCiqCbhAgmahS7H9HAfyTLmEDuyNJPNkPCE4uvNXvbr5eHCk1
 ia2Qhaf/LWab84UNHYdTBvsffSmDP2+oP14cavLDb/mVVt336AbO+HDCMOKupOhxIpxg
 92YPehKc3yKccWnC75bLx/rJZBLfWvVlqu14SAyF9Z8Y1C9izxwaBN1PRdk57emV+Le4
 1Zfg==
X-Gm-Message-State: AOJu0YzHPBd1/AFOncPmyjxWVT1O9qlfk4rqmHJWModvJsJXBFanbyqg
 DKjR+Q3g2c7DRi1CfRnBHtSH2r8+0DekoKM90Qrd/sqVdW/UcK2rr5pALzZ1
X-Google-Smtp-Source: AGHT+IGcnYIxJrBBKBx6Dhr91jOL+zFNTDW3fgxr4vTq7T432FzOGnhRUNEkvHtQAu8Bd6eKkIJ9Sg==
X-Received: by 2002:a17:903:1205:b0:1f7:123e:2c6f with SMTP id
 d9443c01a7336-1fc4e15ef13mr30277725ad.37.1721268668115; 
 Wed, 17 Jul 2024 19:11:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 15/30] target/riscv: Combine set_mode and set_virt functions.
Date: Thu, 18 Jul 2024 12:09:57 +1000
Message-ID: <20240718021012.2057986-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Combining riscv_cpu_set_virt_enabled() and riscv_cpu_set_mode()
functions. This is to make complete mode change information
available through a single function.

This allows to easily differentiate between HS->VS, VS->HS
and VS->VS transitions when executing state update codes.
For example: One use-case which inspired this change is
to update mode-specific instruction and cycle counters
which requires information of both prev mode and current
mode.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240711-smcntrpmf_v7-v8-1-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 +-
 target/riscv/cpu_helper.c | 57 +++++++++++++++++++--------------------
 target/riscv/op_helper.c  | 17 +++++-------
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..6520e0f5d5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -567,7 +567,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3..10d3fdaed3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -619,30 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
     env->geilen = geilen;
 }
 
-/* This function can only be called to set virt when RVH is enabled */
-void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
-{
-    /* Flush the TLB on all virt mode changes. */
-    if (env->virt_enabled != enable) {
-        tlb_flush(env_cpu(env));
-    }
-
-    env->virt_enabled = enable;
-
-    if (enable) {
-        /*
-         * The guest external interrupts from an interrupt controller are
-         * delivered only when the Guest/VM is running (i.e. V=1). This means
-         * any guest external interrupt which is triggered while the Guest/VM
-         * is not running (i.e. V=0) will be missed on QEMU resulting in guest
-         * with sluggish response to serial console input and other I/O events.
-         *
-         * To solve this, we check and inject interrupt after setting V=1.
-         */
-        riscv_cpu_update_mip(env, 0, 0);
-    }
-}
-
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
@@ -715,7 +691,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
     }
 }
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
@@ -736,6 +712,28 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
      * preemptive context switch. As a result, do both.
      */
     env->load_res = -1;
+
+    if (riscv_has_ext(env, RVH)) {
+        /* Flush the TLB on all virt mode changes. */
+        if (env->virt_enabled != virt_en) {
+            tlb_flush(env_cpu(env));
+        }
+
+        env->virt_enabled = virt_en;
+        if (virt_en) {
+            /*
+             * The guest external interrupts from an interrupt controller are
+             * delivered only when the Guest/VM is running (i.e. V=1). This
+             * means any guest external interrupt which is triggered while the
+             * Guest/VM is not running (i.e. V=0) will be missed on QEMU
+             * resulting in guest with sluggish response to serial console
+             * input and other I/O events.
+             *
+             * To solve this, we check and inject interrupt after setting V=1.
+             */
+            riscv_cpu_update_mip(env, 0, 0);
+        }
+    }
 }
 
 /*
@@ -1648,6 +1646,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool virt = env->virt_enabled;
     bool write_gva = false;
     uint64_t s;
 
@@ -1778,7 +1777,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
                 htval = env->guest_phys_fault_addr;
 
-                riscv_cpu_set_virt_enabled(env, 0);
+                virt = false;
             } else {
                 /* Trap into HS mode */
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV, false);
@@ -1799,7 +1798,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->htinst = tinst;
         env->pc = (env->stvec >> 2 << 2) +
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
-        riscv_cpu_set_mode(env, PRV_S);
+        riscv_cpu_set_mode(env, PRV_S, virt);
     } else {
         /* handle the trap in M-mode */
         if (riscv_has_ext(env, RVH)) {
@@ -1815,7 +1814,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             mtval2 = env->guest_phys_fault_addr;
 
             /* Trapping to M mode, virt is disabled */
-            riscv_cpu_set_virt_enabled(env, 0);
+            virt = false;
         }
 
         s = env->mstatus;
@@ -1830,7 +1829,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mtinst = tinst;
         env->pc = (env->mtvec >> 2 << 2) +
                   ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
-        riscv_cpu_set_mode(env, PRV_M);
+        riscv_cpu_set_mode(env, PRV_M, virt);
     }
 
     /*
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca..ec1408ba0f 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -264,7 +264,7 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
 target_ulong helper_sret(CPURISCVState *env)
 {
     uint64_t mstatus;
-    target_ulong prev_priv, prev_virt;
+    target_ulong prev_priv, prev_virt = env->virt_enabled;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -307,11 +307,9 @@ target_ulong helper_sret(CPURISCVState *env)
         if (prev_virt) {
             riscv_cpu_swap_hypervisor_regs(env);
         }
-
-        riscv_cpu_set_virt_enabled(env, prev_virt);
     }
 
-    riscv_cpu_set_mode(env, prev_priv);
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
     return retpc;
 }
@@ -347,16 +345,13 @@ target_ulong helper_mret(CPURISCVState *env)
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
     env->mstatus = mstatus;
-    riscv_cpu_set_mode(env, prev_priv);
-
-    if (riscv_has_ext(env, RVH)) {
-        if (prev_virt) {
-            riscv_cpu_swap_hypervisor_regs(env);
-        }
 
-        riscv_cpu_set_virt_enabled(env, prev_virt);
+    if (riscv_has_ext(env, RVH) && prev_virt) {
+        riscv_cpu_swap_hypervisor_regs(env);
     }
 
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
+
     return retpc;
 }
 
-- 
2.45.2


