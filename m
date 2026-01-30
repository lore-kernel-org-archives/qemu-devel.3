Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4D2D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhZH-0004TC-PJ; Fri, 30 Jan 2026 01:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZE-0004Q7-Eu
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:17 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZC-0000n4-DZ
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:16 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c56188aef06so832679a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 22:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752873; x=1770357673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTEW3Gt4HBmUxzT4h3CgW0aMommJgfUgnjokWcVXusk=;
 b=UB9l6X066BYP6B0+f1DwOTAlsNbrrKaImpRjzA3wQXqF5Tvv07IVUHFLsXi1FjsH70
 Jw/gU6u/FdizuVB5CvrxN0rJ7NA9zU1MsfEwlM70rQRD6EH16k2QP+gV81LKqSR6hb2W
 Uf/2OsKBaqrCrKTyzsfEPWAFm4yz/IhVj+h4W4c+dXhUx9DGXVUjMfNro/JW/I3dRird
 yC56buGn3Ixbkp+HunOcGD2tXUaN/e6oHC6AykK83jxhvElxI7epKolJFrGXZHRIwyST
 6sgqALZqreHYtl7DkcIxcAimwIEFq/BAU2NWKkBLBR2aLbjCNPsBGIKCgy9fAAFIBbyY
 /RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752873; x=1770357673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qTEW3Gt4HBmUxzT4h3CgW0aMommJgfUgnjokWcVXusk=;
 b=MTUInhMLyMWYWXVN7Eh+5ARV7w10Bt0JHbVQJP7UMpbdi3EGYyqA2TtPNMEQMD7zBM
 /Q+ibn00nsk7Lv9O7KyeiOw/eYAxfOSMr3uGnR79s2rW3SHxJsnJtnklgepsKjiuWhpq
 NGwzQyqtYRDdzMdBzZ+YPpVFj5Qu2BoHPHYqnwmmvhmUAUq1TnzBzq/ajkQkFCadNff1
 Lw/TGry3BmgXLtprIwt1paJ2l1DGhctAWt/iIkgVpTdZ67N6vlMbVu7iQUNe884odmKq
 6DCmfNhyIe4cZKMNvDhaaKkIif8vxn7he/+I2cy+OFCjsNDnlXzG6QAQoXAxI1XsRuWF
 0w1w==
X-Gm-Message-State: AOJu0YxTv3KtnD3LulUkIlRHZT0TWADoVM7MITUk3SaPMMb/Pawdvp++
 YYIJ9Gq01babaZa+tTom2EjKodJsd4hXmHQidTaMuL3suTVfqIeGqZhO
X-Gm-Gg: AZuq6aLGGAwu5wwFsNCDg2KzdA5QuFx+FUXAjE+c2azJk6qYwOaTyCteV3EyUGz9hdp
 MH7QZph7AnWqIYgu97hpZTF3l+k7bwahOlCDFuW+m/cQABS/aqJyJW4UFEa4nD41Nn3ESEvtmSp
 Cn6ORQpvRc9TR5Yjn9UXCdkU4Vii0ekTyeJVURq268FIHFlAAAFm3nAFD3LOKN4wljm+fgjEPk3
 kcrnbEEhYUQdM+gjsVPzmB8Kvuf5x/DL4WgnKLMBKNq8WYSn6lSAcCgd1gdnpuLBAxRaGz9e+NK
 xC/Mk0VUPKsrAkrj6iBFitipkWqh9brvSeNabsNv+JwWZbZMNwFb8gF9gHZY0cIlFCdDu0yobSh
 OFM6vnlxhBFU8zUHnz/DZQRMdK/RdZHcO3yYE/b7eovFL0ws0nSwCXaDD8CbvmVzMTS7Fun7iTL
 PxboN4T+ALLkUeYpvT8044cS9c3kz4SevWwbfR7jxjNaFifBBrqN6Q5TvbJBw=
X-Received: by 2002:a17:903:11d0:b0:299:e215:f62d with SMTP id
 d9443c01a7336-2a8d959c86cmr17156275ad.5.1769752872880; 
 Thu, 29 Jan 2026 22:01:12 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3f6d77sm66274585ad.2.2026.01.29.22.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 22:01:12 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v4 3/7] target/riscv: add sdext Debug Mode helpers
Date: Fri, 30 Jan 2026 14:00:02 +0800
Message-ID: <e7bcdb91db6c5f51081a079ca4e8c593152a3f36.1769751489.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add helpers to enter/leave Debug Mode and to update dpc/dcsr.
Model resume without a Debug Module by leaving Debug Mode at
cpu_exec_enter and continuing from dpc.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.h         |  3 ++
 target/riscv/cpu_helper.c  | 84 ++++++++++++++++++++++++++++++++++++++
 target/riscv/debug.c       |  5 +++
 target/riscv/tcg/tcg-cpu.c | 14 +++++++
 4 files changed, 106 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2a265faae5..62732957a4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -624,6 +624,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause);
+void riscv_cpu_leave_debug_mode(CPURISCVState *env);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..0e266ff3a9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -136,6 +136,90 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool riscv_sdext_enabled(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdext;
+}
+#endif
+
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+
+    env->debug_mode = true;
+    env->dpc = pc & get_xepc_mask(env);
+    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
+    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
+    env->dcsr |= env->priv & DCSR_PRV_MASK;
+    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
+        env->dcsr |= DCSR_V;
+    }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        if (env->elp) {
+            env->dcsr |= DCSR_PELP;
+        } else {
+            env->dcsr &= ~DCSR_PELP;
+        }
+        env->elp = false;
+    }
+#endif
+}
+
+void riscv_cpu_leave_debug_mode(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+
+    target_ulong new_priv = env->dcsr & DCSR_PRV_MASK;
+    bool new_virt = riscv_has_ext(env, RVH) && (env->dcsr & DCSR_V);
+
+    if (new_priv > PRV_M) {
+        new_priv = PRV_M;
+    }
+    if (new_priv == PRV_M) {
+        new_virt = false;
+    }
+
+    if (new_priv == PRV_S && !riscv_has_ext(env, RVS)) {
+        new_priv = PRV_M;
+        new_virt = false;
+    } else if (new_priv == PRV_U && !riscv_has_ext(env, RVU)) {
+        new_priv = riscv_has_ext(env, RVS) ? PRV_S : PRV_M;
+        new_virt = false;
+    }
+
+    env->debug_mode = false;
+    riscv_cpu_set_mode(env, new_priv, new_virt);
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        env->elp = cpu_get_fcfien(env) && (env->dcsr & DCSR_PELP);
+        env->dcsr &= ~DCSR_PELP;
+    }
+
+    if (new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, 0);
+    }
+
+    if (env_archcpu(env)->cfg.ext_smdbltrp && new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+    }
+    if (env_archcpu(env)->cfg.ext_ssdbltrp && (new_priv == PRV_U || new_virt)) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_SDT, 0);
+        if (new_virt && new_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+#endif
+}
+
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466749..5877a60c50 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -927,6 +927,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    /* Triggers must not match or fire while in Debug Mode. */
+    if (env->debug_mode) {
+        return;
+    }
+
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
             do_trigger_action(env, DBG_ACTION_BP);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d9fbb5bf58..f80e3413f8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -266,6 +266,19 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
     }
     return extract64(result, 0, 64 - pm_len);
 }
+
+static void riscv_cpu_exec_enter(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (!cpu->cfg.ext_sdext || !env->debug_mode) {
+        return;
+    }
+    target_ulong pc = env->dpc;
+    riscv_cpu_leave_debug_mode(env);
+    env->pc = pc;
+}
 #endif
 
 const TCGCPUOps riscv_tcg_ops = {
@@ -282,6 +295,7 @@ const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
+    .cpu_exec_enter = riscv_cpu_exec_enter,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.52.0


