Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80525C98315
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxuf-0000t9-VW; Fri, 16 Jan 2026 23:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuf-0000sd-1l
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:49 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxud-0001ak-BR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:48 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81e93c5961cso2218316b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624066; x=1769228866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZlK4YcDnVr4YoAAgIp9FWKl3ozqkLm1udk+dBRmk0A=;
 b=MvdJ+Quyy5Donthm6PGTaB06kmA+ZLhp+LXoln9N5mCjbyx+WrkfTEv3s8Mf/w/By4
 /quqQe4chd53W1NQJemga6023mCLwb22zNVse1ZZLxuOKm7RGhkHfpTzwlUPq5FOiEdd
 1DpsatxHZ5wA8PvG/CUSOiUZn7Bc1A+xYXfKDCFjLK5vv14wGmBa/kLA3M0WZAP/Wh5j
 Kv8TekLCvbEfRhwHJOPVVyF8jBC6LIJHxOZWNodqmOr0H/2l3d6OkdjzaYdDrPT7A7cT
 0i3LdA/4vAKsKFec8CbTZdPEXGH6qDXa6TrgVpcCcng5SFemmoIYZTRUuQJIwkwaubeG
 Dm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624066; x=1769228866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ZlK4YcDnVr4YoAAgIp9FWKl3ozqkLm1udk+dBRmk0A=;
 b=duUqzpzLGnHHZBHie4FwOEK68jA6dj5VlG3sjX24hMBPE5cH+SZBEvOAgHmt4KXzSl
 kj9nH870hV0+3v06b1xRx+mKyFjIGKpBuWwRWCSoYEQ8ubnrt3Lh2QftM70OW2nC53VB
 rI+OnPKJ++bojMhgP2Is0ohOkF4LE0JKA9vU5V/DAsuXoPgTzhb9LOe7GcQXaDfcJC4a
 ClEn7zUM5YhqLeBzkBOMs77YKcKuyU+UaO40f/n9lv2PlVwQQ3sx068fC4wlwK3T0d0Y
 F/i/SYFtrD6oAD/iMHCKwl7Tdd60ZJXAfMcJ8UYJC+k5TVYMaBpsobdU8d4BTcsoDvx2
 ZDwQ==
X-Gm-Message-State: AOJu0Yy4pJP1nmvjIOXnkrvuzb8u8LGZis+DNMcXOxlonKTIAnqpvWYj
 gPxCLl6YTrkO2GsrLeYYDqjDKyL7Rk1ehBDBi0Qzjb+XpqzHa8X3TZpU
X-Gm-Gg: AY/fxX71UAldL9GhuQ9q4fTxpBVbRS/TM+WqkI7Gt/qwZjcDn1WmfSSUmar1nOSsCDg
 5dry+bbU00fCHKLgypK4hxpeWY7C0vvBIhgzTDuaCv9JhiPoPRZqrkMCHD5PpoJBtkKUtpeEC7H
 mSJYmhUnUnLgPR3XKFrsYUn2DQxWWyzqNZQgpTA/gMafBe9JeQ7nYI1m3dkLWPAXjMIPfGkPu4Q
 4gsqlQTRQPRl6rR0WO3McgSPi+eX07m0zg+RmnrtBibagwpE7UljvBl3lkBople6Bogb+FkyDw0
 t+9Mbeochjx1UEM5jVxtHfh78D5TYPEGX0tcZVWYpIyaLO6et0/EQOLariPXYEHYnU82HW3vfFA
 HafAuMDOKoN9ks/RETmXIxrgwpCpiWS4vWogdGIyr22XLlFUBjSZ3gHucZyaNrqEuNeEGsZr3HN
 4wYQewSCtQLOwH+H9ZINsVzWHsEdecBZukDI6zgvOK9s7X4aOSHapWfCUA8B/pDQ==
X-Received: by 2002:a05:6a20:d80d:b0:2b1:c9dc:6da0 with SMTP id
 adf61e73a8af0-38dfe76e18amr5340653637.46.1768624065943; 
 Fri, 16 Jan 2026 20:27:45 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:45 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 3/8] riscv: add sdext Debug Mode helpers
Date: Sat, 17 Jan 2026 12:27:24 +0800
Message-ID: <8230a1b0633140c228d063602e93120f0963c3e6.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
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
---
 target/riscv/cpu.h         |  3 ++
 target/riscv/cpu_helper.c  | 87 ++++++++++++++++++++++++++++++++++++++
 target/riscv/debug.c       |  5 +++
 target/riscv/tcg/tcg-cpu.c | 14 ++++++
 4 files changed, 109 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 18ebac830a..ca861aa5f8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -630,6 +630,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause);
+void riscv_cpu_leave_debug_mode(CPURISCVState *env);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de..83d2aa1b75 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -136,6 +136,93 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
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
+#endif
+    env->debug_mode = true;
+    env->dpc = pc & get_xepc_mask(env);
+    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
+    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
+    env->dcsr |= env->priv & DCSR_PRV_MASK;
+    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
+        env->dcsr |= DCSR_V;
+    }
+#ifndef CONFIG_USER_ONLY
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
+#endif
+    target_ulong new_priv = env->dcsr & DCSR_PRV_MASK;
+    bool new_virt = riscv_has_ext(env, RVH) && (env->dcsr & DCSR_V);
+
+    if (new_priv > PRV_M) {
+        new_priv = PRV_M;
+    }
+    if (new_priv == PRV_M) {
+        new_virt = false;
+    }
+#ifndef CONFIG_USER_ONLY
+    if (new_priv == PRV_S && !riscv_has_ext(env, RVS)) {
+        new_priv = PRV_M;
+        new_virt = false;
+    } else if (new_priv == PRV_U && !riscv_has_ext(env, RVU)) {
+        new_priv = riscv_has_ext(env, RVS) ? PRV_S : PRV_M;
+        new_virt = false;
+    }
+#endif
+
+    env->debug_mode = false;
+    riscv_cpu_set_mode(env, new_priv, new_virt);
+
+#ifndef CONFIG_USER_ONLY
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        env->elp = cpu_get_fcfien(env) && (env->dcsr & DCSR_PELP);
+        env->dcsr &= ~DCSR_PELP;
+    }
+#endif
+
+    if (new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, 0);
+    }
+#ifndef CONFIG_USER_ONLY
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
index b5a26cf662..2b543ced07 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -261,6 +261,19 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
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
@@ -277,6 +290,7 @@ const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
+    .cpu_exec_enter = riscv_cpu_exec_enter,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.52.0


