Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF8E87822
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFxJ-0004Xx-Cm; Tue, 03 Feb 2026 07:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxD-0004Wv-IP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:27 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxB-0003wB-NH
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:27 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso4494657b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770123384; x=1770728184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M90wMGk4h3GY5YVxBmIlu1BXQtHAUIoQs/agFdkxAIk=;
 b=b503CFttSQ7zTd79skZ7zRTak1AKrNgjelD6dwBBT4GwS3tX/fvhgkoxlWDU+AN5oJ
 +K4iO0YtmiMZc5EZfgdXGLPPqTs+2MsDXjjTAbX26mz/6rqICa4hy/yzxe7tGtQw2oXQ
 bcIqBme3WQjYJugFJ82A0G0TV0G5i3iGgm4RW37ap4vs8/voL+618l5391OXZn6oSOCK
 vLY7r4EsyUwI34E/MQqSk5SpvbAerkuh/NIvnW2KyoOCI6Yr++KUQvEC0ijeAj3FSTWK
 XU9fQmGdyCOmSrTbPbDXKI/wD0pqM4XFOoW88aRymkHgvcIsHEA9OrkR+XIzwsKG4NZz
 NQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123384; x=1770728184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M90wMGk4h3GY5YVxBmIlu1BXQtHAUIoQs/agFdkxAIk=;
 b=kgAMf0X4Rnw7puGOaafuynolNkFVBdE7WBJc/MJy591AyIIXkKvqi/WijuW0BzmOXS
 uQ+McUeZTAfLu/y7/f7C2iy9g+WhBg9qp8EMiUOw/Fvq+brlGR6jf+/xw/w+DNQEl3UQ
 jEkMevNo6drXZIasFYzaJZGzneKXs9Fw1cQfHkfUDfkWIjlJCcKgtHzPG9z8aK9wkYvz
 rGYVv16cmwNlKGbq6ZVeVBBPgGy7W+UL5tfK/yLjpYYMMFEKYTHR15ZMGyl07vrcd0tK
 ef7rL8JiqBI/PSNa8IrvsWUYkNQ1Yrz1uinuu5FtG1L8epnYppOqXzJOuY8suKyho6X5
 8Yhg==
X-Gm-Message-State: AOJu0YwL/R22+1RZELys3Te8cM7dZO57Wi5csg+ICHPAFp06mnLh1Gp0
 2KZ1lwIGuuHbdeE801ahcpWUE0VntcfpmRM40VOoDXq6zjWkh4N0TtZG
X-Gm-Gg: AZuq6aLxO66gN/L7i6ZLCQzD5tDFWsT6WrelrrxYXEqOCTPy3tQvHKBHTJEsea6GIF6
 U/Dpjqc2XXLpETa9XnKqn4XF4xc/WwQLnasHo/zoTfomU2Z6d9sfHIxr8xdbR7z0E48CmbaaDSa
 Y+G3KNZB1mbnxtv/avNSrFpID0jKaXvAceqzoskihJ+PGDFj9ue8bu/tPjVMllDkqS89PGBgPjk
 RuzNy9YEKwQkcSZUTOTsudHMXWEAZw/AJAymQFiRv1CGuyrdtKYcbgz9GMSosBVqHna0GWwdznA
 E0vlitLTr+rBMmAFg0YI5/T8MI9MM8GPHSZ64bFjGOAv+nypNeB3K9kGGXMD4jAI6Hvy8gJpz9V
 eGGtpQdtJAW3OxEfD4gL/7l3EZFThn6cwEIszCPEq3P2TYLD3JbEDDEST/Bx3/GAmFDOEDTxmQJ
 fT1cK6YY37SrSslNuJB2c6F4W22nQsoHEY5GoWgZcmDBsg26xwfoW06a28
X-Received: by 2002:a05:6a21:a98:b0:366:14ac:e1ec with SMTP id
 adf61e73a8af0-392e016e1f2mr14909595637.62.1770123384313; 
 Tue, 03 Feb 2026 04:56:24 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642aaf1308sm18214796a12.30.2026.02.03.04.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 04:56:23 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [RFC PATCH v5 3/7] target/riscv: add sdext Debug Mode helpers
Date: Tue,  3 Feb 2026 20:56:02 +0800
Message-ID: <7fd9deef21573daeeff53cea15d0e66417d4a8f3.1770104280.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x444.google.com
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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
2.53.0


