Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33FAF3ED4A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkS0-0004Dk-Fc; Sat, 11 Apr 2026 22:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRw-0004DL-VE
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:26 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRt-0008GT-L3
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:24 -0400
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8a08fa355a1so49657916d6.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960481; x=1776565281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vVCl9oFeB3SQLBVtH9GYT4ioHX7OL/vziaYxhp85Ro=;
 b=dRfa+4jyZqQLHv/o1zI2rEiPh3WseNaM8vouc/eAN3tbPOKfOYTDmm6npw9ENNTIgd
 /RYsQ5pNz3ohs+DKqX1uf7fVnCkSDQORHdnB9H8HEuzsEIpgQS6IaggK24TvCt3ScGsn
 Bb8g3m8Dh6gnxpj70wAhsXm8sP/aIOLfyS8J5NjfAh7PuPPT+9//Mbq+cez52Hnv+xDf
 iRX8LP1krrrx84pJWpQn6lAc/CMgVv4ydiYvMxIuoYRJHeCucYlWOSvAlDBxS/YVqDXf
 t63dCWy3WpgYhfv5tyIHox1x3zUebtahRgB1ccv+C85UG0Uw/mBJ04ArfEdRPGZZ0xLe
 VW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960481; x=1776565281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7vVCl9oFeB3SQLBVtH9GYT4ioHX7OL/vziaYxhp85Ro=;
 b=ZBfV13zfNhjxWSoot1KbWynQYArktwjxG5cZGPPBDjxnDo5Yh+rbZVf8gMCrQTELos
 D2ZDbE3RzawHpHoN7xRQUSJtQ2yHpoooQrLMr2p4veeBWy3Fjr03nHK+1/Y8WtdOL+mg
 0g75YUMzTwqMKZAMsxKx301Q/ZKPNbTOvJ0v8iZZys+4gZnUQhL0Y9lPuQLbwknI+P40
 IRPNt7cd8D2ZW1KpiNIyD4xrWy3dVNJE0xZ+KCZu41q7ixK1WFjnBKvH05WZ8BdbDgu3
 wvlPZmmVb3miDuLNsxuKTCuDSqzFcrko5o5D7pCqa5xQd4DLun+YqMAdAsjXTEnpxlwf
 0KfQ==
X-Gm-Message-State: AOJu0YwoYdSAFeEVmBFYJPz31hJ8RjalmdEVaqhjg94fQfxYUTKA4bHa
 2QIiQCj6dfGTDLFkKwfprQpr6diQ3R83KOJqe+vMUc+jc+04GxqmZC0j
X-Gm-Gg: AeBDieu8LKjtJ4+ZYWtRz0NFv7/Ie1yTeqqkzGpORMweRkQV+TtFpoK87qIIdRmmoO3
 Lm7ngMd2L9KxiBPbubmJYCgPQdBUAwNcevKN5dUzF9UoIL0tpgI/haFTnG0x5PKJsmES1x3yFbP
 vkvpSOGsehuKVoGWOruemaoE3f2gCtNZ6STcvGIrNj77eXj3SskRg7P31V2gmS/kI6Xcxbzce4B
 g4nGRvM5FaVZud8Zw5ncYlWA/ZcVX7rxVJEF0QTlzmyj1iIas/m8Ej0+FzuG55nzOnpy55V9LfH
 q4pV92l7IN0nZFEcIFsVo0FqgtxmXHMsgoe8TuTQ8haPTyMDuzLDDCBBMCJ1tPBQxvN14JscUBC
 150t965q44/iJr61Vqb+XC82KxY1Crxtm1ksK9HHR82IUykU5B3DxrYIRzE8vSjUKyYFE5bArNz
 D8t6XygpmbjEclyvvB+kA5xbd1UC7Tx1oPDQuY9p0tIyEgA/Fn4CYz0A1/fVRPQfUmYceI
X-Received: by 2002:a05:6214:19e2:b0:89c:6ba4:e306 with SMTP id
 6a1803df08f44-8ac862c8eaamr150741326d6.43.1775960480548; 
 Sat, 11 Apr 2026 19:21:20 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:20 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 3/7] target/riscv: add sdext Debug Mode helpers
Date: Sun, 12 Apr 2026 10:20:20 +0800
Message-ID: <99be0e0e0d43c77389dd076d079b195844817076.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf41.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
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
index 659150c646..0ff11a45de 100644
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
index 0613450691..4b17fbb611 100644
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


