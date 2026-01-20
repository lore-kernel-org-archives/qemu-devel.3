Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CFED2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi72T-0005bZ-1v; Tue, 20 Jan 2026 03:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72R-0005X9-CO
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:35 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72P-00035D-Ik
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:35 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so3830180a91.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768897472; x=1769502272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+69Ad3lFG8QXRNC255LKiHQUR/HJ62o4vX0lEwMgoU=;
 b=jIsK3as1zSXKJL9ugKvIS12ZWKscJcdNfw+sKJnGnjYeyfWPZfcRc0H+NSezi6ZoGc
 JpoAZfZ1nOyqhOz0e0f8LdTqfzrdx0ELdeocU1Jk9n8WQ3m38ofNuh/B6joxgUXHcYfE
 wYkdN/fblx1eVq2v7/5KvBSCcC3KcUNY3aBFa9rURzkMBNNz3alQdBsngj20LyYZkHHv
 N4ic018rB2HlV4DBUFd3vitzY4Ib/9mwhoCgPS14dPOd65UMKMYDz+1VEOpf/pVS+ic5
 tM2BoFMxAWTk65IXyGMcPlSyF9z74KlzfTwRiLPLlGE8lT9o1eP8wNv5MrI5uCOqS6c4
 mBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897472; x=1769502272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C+69Ad3lFG8QXRNC255LKiHQUR/HJ62o4vX0lEwMgoU=;
 b=I10lUJG1SUcA2C594J/Ol+Co6l6Y+Bjve+L7GVTzAVxyGJgVdBZ93UoT5JFuktp+6b
 Wn9uXeR0gk3U/OKf/0o/GldHAOJB0i7ak1frdHjkpafxnHE95evqvL4HAgxidt6qGUQQ
 1U+v5ssWac5HE09QoEYaBa2EVsoWd0IPdXgsoQ24Hl4MB09gr9xsWSffcqNVNBU4MJ2z
 KKdCSMUCyQ9CRnlPGkZbpdzvSvt+RGq9ztV+ICejVw0WOGw/BMRZ1jqnZ/NEyXRaIA3a
 YArm1aHLBGxK0AQCITWp7+5m+IKrPl26wiIYAE253N+f0hNkOJrirkIvM9lcQUNl/T1q
 WPeQ==
X-Gm-Message-State: AOJu0YyMZ1sWLp6UfqaOyO59j1cOerTSmnZC1Pa8irMZetmJz84cCqvm
 RrdpiOH19BX77rW97eE/PLLX25fBowQKykUo4K2f1heFeOgvIjeBOrWgoAUZdkybnHHnMg==
X-Gm-Gg: AZuq6aK5NU2MkbTQoHKm8jqTobQI20Fl0QB9u4zoll9geJAwwBB/7fJEKko+mdCFLXE
 RFiSebNL+T3CBbbwwcy3jyeUVOuaQsOJsdabd9O6aQ7xGsfBHAUNMpZhZRBlrzxQhxGrVKbLZ9V
 x/Bpk4W/heSqop3PqZ2qqRlQDAe+uFlFlbv9RGEIY2pNS/c++7yt9pubK9UXZqGLhk+LClC0X/o
 0af/1ZrqKdqFsF9dJfKpeFAIx1KfRPrRz7JEMX3lGC8jaeCLSQ+eqXDEtTVBwyU7/ZEN58Jbm7v
 Kqponh1G6M7jXuwPu4yN2n7s2aYBCM1oFyiBUT6GJAieKvcIwh2fujdI6EdGWd/MmPG1Kb9cf6d
 Y8BJke9xCkcft2Xa/u/npC4ClbQB2LYd+yxfLjdaIUV/Vf6sfLphm6xZWyqLnYiz0bYHF1yAzm1
 xl/2mLgWwISjpzpIIJSPmN/P4qysKKvIW5Rsqqtg4dyJgbkTZw01Li8lHhfnKXEBAf4tfR
X-Received: by 2002:a17:90a:d44b:b0:34c:7d65:e4a with SMTP id
 98e67ed59e1d1-35272fc12f7mr10916544a91.31.1768897472269; 
 Tue, 20 Jan 2026 00:24:32 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35274573a7esm4273592a91.11.2026.01.20.00.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:24:31 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v2 5/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Tue, 20 Jan 2026 16:24:01 +0800
Message-ID: <18e13c6d64d88f53b7cc63387bdc50f280435916.1768892407.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
References: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1042.google.com
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

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  6 ++--
 target/riscv/op_helper.c                      | 36 +++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index af6f3f4fd5..bbfe7548d2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
 /* Hypervisor functions */
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index f8641b1977..377f551bb3 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,9 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
-        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
-                      offsetof(CPURISCVState, badaddr));
-        generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
     return true;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 99736bbebb..dfe5388ab7 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -470,6 +470,42 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+    bool enter_debug = false;
+
+    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
+        if (env->virt_enabled) {
+            if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKVS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKVU;
+            }
+        } else {
+            if (env->priv == PRV_M) {
+                enter_debug = env->dcsr & DCSR_EBREAKM;
+            } else if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKU;
+            }
+        }
+    }
+
+    env->badaddr = pc;
+
+    if (enter_debug) {
+        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
+        cs->exception_index = EXCP_DEBUG;
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.52.0


