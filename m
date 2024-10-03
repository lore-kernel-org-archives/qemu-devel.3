Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD7BCF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQem-0007Qi-IG; Thu, 03 Oct 2024 14:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeD-0007BE-0v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:58 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQe9-0004sF-ET
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e0be1afa85so1168504a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980432; x=1728585232;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3fhINZSx5ghMlTitfFFmHEIn/w1CK0xQ5bZQ2eIF2c=;
 b=Apr8bT4vnS8iuU5qXN8Ji3jD+SLzi9vcegARpHMRJ8gem8BKfd+pas/j1oXYZjGyEV
 weJkB045VxR5m6akMqy/ImpNX6RIsJMPyMvG3tIgo8cm4cJcpD1dYp6T7bXyB6PPKDO5
 F2wNlMYmVeLUYkkTvTj4/ZHeLGXPypmRu/OhR174aph935WoH++3ST3Iy6JRJZTOJPZy
 HbKchIS66ZLxMEeWSPOJQJxaPF0isAvrXXEz/ml50mxn/JI4EKwzsMERb9rLXABtp+Cd
 xuV5PrmxJRrNzj2iG72DHd9tORbrsbzanP4OyGlFVh6bxd74pbf5434QA35JcgngBRIk
 MKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980432; x=1728585232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3fhINZSx5ghMlTitfFFmHEIn/w1CK0xQ5bZQ2eIF2c=;
 b=Rx/UNU3whveWOCrmS634GJ4js8b6dicRNAD3Ys/vzgIjdILbpIKnPOI3OESjHi4lUf
 4xOcTedVJPnhVjZ4SZOw0OyrXQiuGjQi2Boz9JfDzXzO/BmX8cbFUY2Rio6QCbJKMVgY
 R1Xs8jL288IDi6fB/olxuDWXAtwqFn6vHbYzUJOw/ByUNJOieJAWWHGGwwAlf4rWk9/+
 Mv8kzW4ApGsJFmaYqt/vtDCZvV5F6+rRNgczDbO272vBYtNs/ho5oTp64V5QssadjOHx
 cwwnKaILNAyyo8Q/24Kh58QOW9pFq7uBQPoCNUg+FEzavjdX0ZF/7cdafmA2rszKfxsm
 cfTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs5VP7IH+sk6v+iSrq/64Q28PBkJ5z3m3+LZZyXQ2dtPI+pPtTqVTEggwvETS01EAa5trbs8fOIjYG@nongnu.org
X-Gm-Message-State: AOJu0YxZ2QIB/TkaU1MZufxkDZD+H8VRQrJdNmB6ajdXyLNJzDd5Oadj
 RZKGn9rNhQSlgBmWNj77fq3+DUnRwd0VhouVCFqUH/hNZM1AVHaaRBU1YGmIRAU=
X-Google-Smtp-Source: AGHT+IHc4m1d/s+VJkUPzrQgGiJfqxKwxZHpi24Cp6RYYld2RHZDjDeBxR6J8TawDNEAlkjz7Hpc/w==
X-Received: by 2002:a17:90a:744a:b0:2d8:eba2:ac6e with SMTP id
 98e67ed59e1d1-2e1e631e32emr22906a91.29.1727980432199; 
 Thu, 03 Oct 2024 11:33:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:33:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v15 04/21] target/riscv: save and restore elp state on priv
 transitions
Date: Thu,  3 Oct 2024 11:33:25 -0700
Message-ID: <20241003183342.679249-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1036.google.com
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

elp state is recorded in *status on trap entry (less privilege to higher
privilege) and restored in elp from *status on trap exit (higher to less
privilege).

Additionally this patch introduces a forward cfi helper function to
determine if current privilege has forward cfi is enabled or not based on
*envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M).

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 54 +++++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c  | 17 ++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e9f26b5121..6c5e199e72 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -547,6 +547,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a935377b4a..d7b776c556 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -63,6 +64,33 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool cpu_get_fcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfilp) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            return env->senvcfg & SENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+#ifndef CONFIG_USER_ONLY
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_M:
+        return env->mseccfg & MSECCFG_MLPE;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -546,6 +574,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
     bool current_virt = env->virt_enabled;
 
+    /*
+     * If zicfilp extension available and henvcfg.LPE = 1,
+     * then apply SPELP mask on mstatus
+     */
+    if (env_archcpu(env)->cfg.ext_zicfilp &&
+        get_field(env->henvcfg, HENVCFG_LPE)) {
+        mstatus_mask |= SSTATUS_SPELP;
+    }
+
     g_assert(riscv_has_ext(env, RVH));
 
     if (current_virt) {
@@ -1760,6 +1797,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected)) {
         /* handle the trap in S-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
 
@@ -1808,6 +1850,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S, virt);
     } else {
         /* handle the trap in M-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             if (env->virt_enabled) {
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -1839,6 +1886,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M, virt);
     }
 
+    /*
+     * Interrupt/exception/trap delivery is asynchronous event and as per
+     * zicfilp spec CPU should clear up the ELP state. No harm in clearing
+     * unconditionally.
+     */
+    env->elp = false;
+
     /*
      * NOTE: it is not necessary to yield load reservations here. It is only
      * necessary for an SC from "another hart" to cause a load reservation
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 25a5263573..eddedacf4b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -309,6 +309,15 @@ target_ulong helper_sret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear spelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_SPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
+
     return retpc;
 }
 
@@ -349,6 +358,14 @@ target_ulong helper_mret(CPURISCVState *env)
     }
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mpelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_MPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
 
     return retpc;
 }
-- 
2.45.0


