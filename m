Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E09D358D6
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhZN-0004cZ-5G; Fri, 30 Jan 2026 01:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZL-0004Ys-Ap
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:23 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZJ-0000oT-MK
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:23 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a0834769f0so11547505ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 22:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752880; x=1770357680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFvnzx92PgL7+xgM0KCt+ExUTmfmTtdDt4IgVzTSlKk=;
 b=I00HhMZ+zEUHatZ2zmjTcSCQ1RXP2Kfkmx05IsBQTtxIhyvqizZwZuVM0Y8X/3u+e6
 2l1jKwY21kvgg0QRjyN2H++xPRnHgG8m0QB/DlXgYv8M+YKgyccrk5b4KNoFbUb+kDhu
 ytcK33C8spdFml0sZiLmLKVnoloHt6+MTPDKaZycY/n1BrMECGRWx+DKjUISxBHZn+qE
 w5rA8lHJ74xMiVkTgJ5LU4KMwb93ddWzoao6JCVDcbDzZZ68y+w+DNlQbzA74RGUl9yb
 3eNC34jJBvTybrvKxxa+g5BR9WfGtOCRVSdSmf88K44makOeLOjEhKdK9u0KCPaK0+WM
 guSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752880; x=1770357680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFvnzx92PgL7+xgM0KCt+ExUTmfmTtdDt4IgVzTSlKk=;
 b=gTxF0w98XgcKFjRm6PRdNQc/G5qEy7i69/0BC78mZYO9JyeeuA+aEHrB3ZV6gkHYBF
 oGUBjefjVpLYVT9csAUKksumapT7ZDqdPJ4HVrYJ31K+6mnE/lgsTVnfGlxFGiotbiJZ
 4cIGticlmbwti/abcGWNqO1Q6JsiOuN0D4K6uzpmdBn2M5FLJ8F6D7TnfqwEOtY+1JSJ
 MV28SuQbDBXTk6ctJGXSbpmB3wkk3JPWTNtcsmDYZLpTbTMHRYRumRO5KAnsO2cJk5Sa
 ThMMYy/5yfBAaiQshP+ODPeVNtmietjmDZHVhjmUIv86e66itWNNkjVe98lBmv/xBbMC
 1KKw==
X-Gm-Message-State: AOJu0Yx0TIf9EhR9NWhBo8JyTw8lQmAYPDkD4/BSpGdOZrQ6fhpNuz1t
 aYjR+V8bnSSlBNtH9/gvuAn7qmoXzdB2Sg9dqjYLE6MJMYx8qPKSJqCJDmTGFBOn
X-Gm-Gg: AZuq6aJPipu2EoVz7T70pi9kOfosf0NX82LCsFhhxymgZX5NjCOiA1NEUaF07R1kolU
 AcqtmxzT17DCfpMCzy0TwUwtTVi8OqtOC113AhIOswpimEKCXum4YPTM44hYWnwlgNDmRbg13hs
 TwBs/iGc/NMMYFoABq54Lnu9Pu10el2+zc7L/TLqaVsyzCsfl72n9x377HQrCqdSBjtNgzSKT4B
 93Um74qkwLE+Zjj+pUQNgG7NPBtezGcGlv8kBgVss06UGUj9Fyfr98lskkQqv2llcMLJ3ENlmIM
 Gh1Kv2BmLQ/5HDxEE+a7eTgwXvX4oaxNSqkNtBufMdbOhhAiQ26DAwR3wKsdBg5HvSIYGZn2UVw
 hzoGtQVvu5klw8Dv8/aSQprfVk2FyYMhP3TSLlXqXUcgcAxznkZsk1OKJ4R5mWSwsEoDkIPCyqk
 EWDnpCKrhfp8H2HT7C59xyqkuHGzvBd7R/FsW7q/5AVGoXiwR+VldLv4V+nIs=
X-Received: by 2002:a17:903:15c7:b0:2a7:f369:4de8 with SMTP id
 d9443c01a7336-2a8d99291ecmr18007995ad.42.1769752880378; 
 Thu, 29 Jan 2026 22:01:20 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3f6d77sm66274585ad.2.2026.01.29.22.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 22:01:19 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v4 5/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Fri, 30 Jan 2026 14:00:04 +0800
Message-ID: <92dad2c97a34c3d691919253a162ed5be5406e09.1769751489.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
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
 .../riscv/insn_trans/trans_privileged.c.inc   |  6 ++++
 target/riscv/op_helper.c                      | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6140b6340d..acff73051b 100644
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
index f8641b1977..84f0c77513 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+#ifndef CONFIG_USER_ONLY
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
+#else
         tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+#endif
     }
     return true;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 99736bbebb..b6417b4b0b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -470,6 +470,40 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
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
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.52.0


