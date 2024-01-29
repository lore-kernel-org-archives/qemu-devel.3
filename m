Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3012C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb69-0005k8-Gl; Mon, 29 Jan 2024 18:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb62-0005Vu-A9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5x-00054I-8o
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso15382085ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571075; x=1707175875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4Nk7Fr5V+E+EQgUKIfA2DtzakJRYTC/OjGjeS9cqxs=;
 b=ChLcQ+therHAPTHU8q1T/a/OQWcNjDVN/jyIfLb/dpEIPf+7Cd9ngCoArM/8Zs/lbg
 6NakEccwXyBaY6lpZACklkapZGPBpLuwqtAhUozbIUif/HAoGpyGLB2FNK+E/JTL1nKe
 21TumR4sd5u/H1w+17XSLj2ybccYffoyJNiPItXOvae9kMDQ9EzQWkksd4hwuuwtkFLZ
 Pp6PKU+nZP2JptQVkuacP/SPh+Qt6vHw7laRDXYXxpBCNfmvh4tqDWiy9usPl9Ht8OaN
 tIE2l3wFWNdYYnpOJ34MuXnlon/0TV+3RGzvs8QGgSFPGAPMegyNypvVCvVZq0dFDXXG
 7C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571075; x=1707175875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4Nk7Fr5V+E+EQgUKIfA2DtzakJRYTC/OjGjeS9cqxs=;
 b=kRUF+RqLzhOf9RmdasQey8tKIKq2TObNlBa/Yo5Gv8glL0cIzUaY147LSGQr8kjbjs
 rPE8EkMkiekyFa2reMNjnnF9/HbmJJNltBco7DO2Alw2FId/EgpmsK4Po9V2Q3SCGuxr
 AVcWN5Lf25XSiMtj5qhSCStj8i+z3u+012Wyz6DGkmjz3sH8jSu8pxh6xYgJHIzb0/LJ
 fEF5QZbGgeHg/kokT91bVfiIsgQWmkZrzqdt82TX6wul90QQdSaB/NDNv3IOxBQa0A+1
 MU+o5t2zBOqVURdQkEYNEc+J6g2XOKxarG7hQp49uHkayTzipqFMclX/gmreuby4ytat
 KfDQ==
X-Gm-Message-State: AOJu0YyStuRdqYpBoJxj/c91WDGztrEeTz58YD2Mzb5Viv1h4aAsgN4o
 zMaqUt9CTVoQhFw1rJlxJmyudbcx1o8Xpl+tIo9EhxaCWQnKK4tZqnTjdjObyKFI7r03JOcqE0T
 dj/U=
X-Google-Smtp-Source: AGHT+IEt+GQjSHnTK1lS6AoJLHBt3Vvc+uQaXlDE1FUa2Fbb0aUKdMH+2BgGBmPqg1+kv3lFYlTbvA==
X-Received: by 2002:a17:902:c115:b0:1d8:efa9:3b61 with SMTP id
 21-20020a170902c11500b001d8efa93b61mr2081216pli.36.1706571075675; 
 Mon, 29 Jan 2024 15:31:15 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 12/33] target/loongarch: Rename MMU_IDX_*
Date: Tue, 30 Jan 2024 09:30:22 +1000
Message-Id: <20240129233043.34558-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The expected form is MMU_FOO_IDX, not MMU_IDX_FOO.
Rename to match generic code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.h                                 | 8 ++++----
 target/loongarch/cpu.c                                 | 2 +-
 target/loongarch/tcg/tlb_helper.c                      | 4 ++--
 target/loongarch/tcg/translate.c                       | 2 +-
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5dfcfeb3a4..47fd110e81 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -404,15 +404,15 @@ struct LoongArchCPUClass {
  */
 #define MMU_PLV_KERNEL   0
 #define MMU_PLV_USER     3
-#define MMU_IDX_KERNEL   MMU_PLV_KERNEL
-#define MMU_IDX_USER     MMU_PLV_USER
-#define MMU_IDX_DA       4
+#define MMU_KERNEL_IDX   MMU_PLV_KERNEL
+#define MMU_USER_IDX     MMU_PLV_USER
+#define MMU_DA_IDX       4
 
 int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
-    return MMU_IDX_USER;
+    return MMU_USER_IDX;
 #else
     return loongarch_cpu_mmu_index(env_cpu(env), ifetch);
 #endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index cbecc63213..139acfe373 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -382,7 +382,7 @@ int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
         return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
     }
-    return MMU_IDX_DA;
+    return MMU_DA_IDX;
 }
 
 static void loongarch_la464_initfn(Object *obj)
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 449043c68b..65ffbef08e 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -188,8 +188,8 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
 {
-    int user_mode = mmu_idx == MMU_IDX_USER;
-    int kernel_mode = mmu_idx == MMU_IDX_KERNEL;
+    int user_mode = mmu_idx == MMU_USER_IDX;
+    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 235515c629..58674cb268 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -125,7 +125,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
         ctx->mem_idx = ctx->plv;
     } else {
-        ctx->mem_idx = MMU_IDX_DA;
+        ctx->mem_idx = MMU_DA_IDX;
     }
 
     /* Bound the number of insns to execute to those left on the page.  */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 01d457212b..7e4ec93edb 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -323,7 +323,7 @@ TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
-    if (ctx->mem_idx != MMU_IDX_DA) {
+    if (ctx->mem_idx != MMU_DA_IDX) {
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
         ctx->base.is_jmp = DISAS_EXIT;
     }
-- 
2.34.1


