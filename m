Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9A7C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8c-0008Ph-H6; Wed, 15 May 2024 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8M-0006kK-FY
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8I-0001i2-Gh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34d99ec52e1so5124876f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766068; x=1716370868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJ/OU2GzKkfi9eg8xXZcP2KYs11/NjQ23m2qkET+jGw=;
 b=TTzYBRny+rB8hEc+0kw9ogaYPDvFaSl+gTOUWU2EHYGp+DLYXe+Ge3HgxdWGHURAbC
 NLGLDb71cfUbNiJY4aSwf55x0hnhid6caz6upUmbOFX8SQEzfCFC7G3wDQkjO5xaMisd
 LvZV0pF6SIdSY38ZTssVf4GBJ7MZegYpB4716m9m1a0xPfA87j4nz+ZhH9im+sUaL7AR
 rgLUZael3LfuPiVjZG1to7knTRl3LYd2dOuoxwQewk+snajYzfXf1Z6/Zy+7IQjyQlIA
 6DWieMXRpUwaWeGx1DqMI2/wMxIjk+H87JtwNlhoVYg1X0BqfEnAXP/8Wuqq11cwSCgJ
 x9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766068; x=1716370868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJ/OU2GzKkfi9eg8xXZcP2KYs11/NjQ23m2qkET+jGw=;
 b=NT+17dqvrwsrO7Znm4GAvXthXLL6CAmpVqUVKejtDfihzVXFQldY1eQ8u6u1Uu1nrU
 VSpHihVcIMBSJYh+wrDOAnGHCBwUg4G2stpM+9Xgn/to4ZDC59v+CEbCg6JP3aSr+I+Z
 Yq1N2x+D4lO45Cpv3tWzizPoah6E1hvEWKaMocnt7mivw/i26T4Cf1SEK/D1asabSfOs
 YYxgSqvEA7GY+kKFYXyc8xXdxosQWKFqkv9VY6Tat4IrQXpDNz3I1p4cGLDqlsNJ5J1W
 iuZQEDm/gX6i4SvaBBkHs2VoNEyXUg1kbh0N82ucEyoH+yeWY52FogHcyuUISM93vTbA
 78cg==
X-Gm-Message-State: AOJu0YzLUGLcw1NV2fsR0cXLIY1ppcJfUsBEIju1cAam3WGUzp84Nppb
 Pskr7PBC5az92TAGRdyAzTyTGhrQ/33+jZwj8bBn1K0H9ztzVEJPxwjcspdOLEeFyIaKpWxzDm/
 Ia7U=
X-Google-Smtp-Source: AGHT+IGGzQjvBTIUYhWmgJJ15qAoja+3tleVRF9AVL4avIdm/GQ/ls/CcBMnjavlmE9Q0Hcuq50KXQ==
X-Received: by 2002:a5d:550b:0:b0:34c:67d6:8dec with SMTP id
 ffacd0b85a97d-3504a62fec5mr12046340f8f.6.1715766068074; 
 Wed, 15 May 2024 02:41:08 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 32/43] target/hppa: Store full iaoq_f and page offset of iaoq_b
 in TB
Date: Wed, 15 May 2024 11:40:32 +0200
Message-Id: <20240515094043.82850-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation for CF_PCREL. store the iaoq_f in 3 parts: high
bits in cs_base, middle bits in pc, and low bits in priv.
For iaoq_b, set a bit for either of space or page differing,
else the page offset.

Install iaq entries before goto_tb. The change to not record
the full direct branch difference in TB means that we have to
store at least iaoq_b before goto_tb.  But since a later change
to enable CF_PCREL will require both iaoq_f and iaoq_b to be
updated before goto_tb, go ahead and update both fields now.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  2 ++
 target/hppa/cpu.c       | 72 ++++++++++++++++++-----------------------
 target/hppa/translate.c | 29 +++++++++--------
 3 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 5a1e720bb6..1232a4cef2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -341,6 +341,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_SR_SAME     PSW_I
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
+#define CS_BASE_DIFFPAGE    (1 << 12)
+#define CS_BASE_DIFFSPACE   (1 << 13)
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index a007de5521..003af63e20 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -48,36 +48,43 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+                          uint64_t *pcsbase, uint32_t *pflags)
 {
     uint32_t flags = env->psw_n * PSW_N;
+    uint64_t cs_base = 0;
+
+    /*
+     * TB lookup assumes that PC contains the complete virtual address.
+     * If we leave space+offset separate, we'll get ITLB misses to an
+     * incomplete virtual address.  This also means that we must separate
+     * out current cpu privilege from the low bits of IAOQ_F.
+     */
+    *pc = hppa_cpu_get_pc(env_cpu(env));
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    if (hppa_is_pa20(env)) {
+        cs_base = env->iaoq_f & MAKE_64BIT_MASK(32, 32);
+    }
+
+    /*
+     * The only really interesting case is if IAQ_Back is on the same page
+     * as IAQ_Front, so that we can use goto_tb between the blocks.  In all
+     * other cases, we'll be ending the TranslationBlock with one insn and
+     * not linking between them.
+     */
+    if (env->iasq_f != env->iasq_b) {
+        cs_base |= CS_BASE_DIFFSPACE;
+    } else if ((env->iaoq_f ^ env->iaoq_b) & TARGET_PAGE_MASK) {
+        cs_base |= CS_BASE_DIFFPAGE;
+    } else {
+        cs_base |= env->iaoq_b & ~TARGET_PAGE_MASK;
+    }
 
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
 #ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
 #else
     /* ??? E, T, H, L, B bits need to be here, when implemented.  */
     flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = hppa_cpu_get_pc(env_cpu(env));
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_long diff = env->iaoq_b - env->iaoq_f;
-        if (diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
     if ((env->sr[4] == env->sr[5])
         & (env->sr[4] == env->sr[6])
         & (env->sr[4] == env->sr[7])) {
@@ -85,6 +92,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     }
 #endif
 
+    *pcsbase = cs_base;
     *pflags = flags;
 }
 
@@ -93,25 +101,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
-    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
-
-#ifdef CONFIG_USER_ONLY
-    cpu->env.iaoq_f = tb->pc | PRIV_USER;
-    cpu->env.iaoq_b = tb->cs_base | PRIV_USER;
-#else
-    /* Recover the IAOQ values from the GVA + PRIV.  */
-    uint32_t priv = (tb->flags >> TB_FLAG_PRIV_SHIFT) & 3;
-    target_ulong cs_base = tb->cs_base;
-    target_ulong iasq_f = cs_base & ~0xffffffffull;
-    int32_t diff = cs_base;
-
-    cpu->env.iasq_f = iasq_f;
-    cpu->env.iaoq_f = (tb->pc & ~iasq_f) + priv;
-    if (diff) {
-        cpu->env.iaoq_b = cpu->env.iaoq_f + diff;
-    }
-#endif
-
+    /* IAQ is always up-to-date before goto_tb. */
     cpu->env.psw_n = (tb->flags & PSW_N) != 0;
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 12359bafb6..70df42f558 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -770,12 +770,11 @@ static bool use_nullify_skip(DisasContext *ctx)
 static void gen_goto_tb(DisasContext *ctx, int which,
                         const DisasIAQE *f, const DisasIAQE *b)
 {
+    install_iaq_entries(ctx, f, b);
     if (use_goto_tb(ctx, f, b)) {
         tcg_gen_goto_tb(which);
-        install_iaq_entries(ctx, f, b);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        install_iaq_entries(ctx, f, b);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -4576,6 +4575,7 @@ static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    uint64_t cs_base, iaoq_f, iaoq_b;
     int bound;
 
     ctx->cs = cs;
@@ -4585,29 +4585,30 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaoq_first = ctx->base.pc_first | ctx->privilege;
-    ctx->iaq_b.disp = ctx->base.tb->cs_base - ctx->base.pc_first;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->tb_flags & PSW_D
                     ? PRIV_P_TO_MMU_IDX(ctx->privilege, ctx->tb_flags & PSW_P)
                     : ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
+#endif
 
     /* Recover the IAOQ values from the GVA + PRIV.  */
-    uint64_t cs_base = ctx->base.tb->cs_base;
-    uint64_t iasq_f = cs_base & ~0xffffffffull;
-    int32_t diff = cs_base;
+    cs_base = ctx->base.tb->cs_base;
+    iaoq_f = cs_base & MAKE_64BIT_MASK(32, 32);
+    iaoq_f |= ctx->base.pc_first & MAKE_64BIT_MASK(2, 30);
+    iaoq_f |= ctx->privilege;
+    ctx->iaoq_first = iaoq_f;
 
-    ctx->iaoq_first = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
-
-    if (diff) {
-        ctx->iaq_b.disp = diff;
-    } else {
-        ctx->iaq_b.base = cpu_iaoq_b;
+    if (unlikely(cs_base & CS_BASE_DIFFSPACE)) {
         ctx->iaq_b.space = cpu_iasq_b;
+        ctx->iaq_b.base = cpu_iaoq_b;
+    } else if (unlikely(cs_base & CS_BASE_DIFFPAGE)) {
+        ctx->iaq_b.base = cpu_iaoq_b;
+    } else {
+        iaoq_b = (iaoq_f & TARGET_PAGE_MASK) | (cs_base & ~TARGET_PAGE_MASK);
+        ctx->iaq_b.disp = iaoq_b - iaoq_f;
     }
-#endif
 
     ctx->zero = tcg_constant_i64(0);
 
-- 
2.34.1


