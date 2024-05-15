Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E088CC25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8L-0006aR-8c; Wed, 15 May 2024 05:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8C-0005u5-5g
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B88-0001fD-An
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34f0e55787aso5222119f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766058; x=1716370858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9OhN2bhF+NQyxnmoOaMAjar9BfNJg7nc8s21aZCk7Q=;
 b=IXUmDMZy8yak8CfHQWD1A1DKB11m9GK0aOwOtvj318nya/+vBeX90f5XHJ1mQwoe67
 vsRAta/dZqtZfJUsCcEvsZZJRPLUqe5zYG3YNRg9lntKZn5D5qoArLSY+/WIBvx2pqLZ
 GGju/RSgkipgK7RbQO5sHpzLCneb0l2JCEOcO7I1J+Vlbw6NpyaY84Nw+77lNMVPSSG8
 7IDeFGk3XGbkE5tgbF3h4gN9AcX0yvFO06r5DCK1VZGpS03wW6RrYeHfDWTYKtwYJutC
 zfMRnNhM7W6CNiYl6c/wHKIKExTJlsrpevjKiV0tokdCKLJXvRmQgEUQpfH2xUhHQ1y0
 PomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766058; x=1716370858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9OhN2bhF+NQyxnmoOaMAjar9BfNJg7nc8s21aZCk7Q=;
 b=Hk77BHEjvE33YSn1e7eeOl5CrJyqckri9cZtAHTPEjvnM29xB1u4PZ1hkSga8UZkqC
 axFAKG9TqevnSk1ha+uPxTlJqxr/ia5XAyJ11aw7XcakEQrj2UVx49wETGxHdo8n7biX
 R77WbdyG9Kh7l4tq7jmlNWAzm2dx++sH/A/vgA6AEATCtsStCNH+oUCnLV+mHRZ3+Krj
 6odyHKGHddd9xZhhtwxiowfXimhLk/GXV1Ymf8SXVLIiYReZ64kb+uz8ucYPz/lJ+u8T
 W10yE0kWHEHLD4+K0Dzr9cZDX1H49n2BhJ1IZFZWMpgQPhTtVwUPhLMIipOqts+LBlsG
 sbTQ==
X-Gm-Message-State: AOJu0Yyo/BGjImhEmmJECLfRBzBdmYSccpQN7+vCtYLU3pb6/t9LiRsw
 wymctRw1PHrc9htK/jnelJxALzsEPGYqrybj2XNSz+QQ6p77vw1fpMG+557yltza4726Saet6nm
 DZHY=
X-Google-Smtp-Source: AGHT+IGV3KE4YwS7eZquBaXQdmAMPkk5Sb53gZIwcs3Xs9vhs/4sxXVzVBJ42GVRLip3KWPW2hgb4A==
X-Received: by 2002:a5d:598c:0:b0:351:b0cf:99b4 with SMTP id
 ffacd0b85a97d-351b0cf9b16mr9474738f8f.4.1715766058713; 
 Wed, 15 May 2024 02:40:58 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 18/43] target/hppa: Use displacements in DisasIAQE
Date: Wed, 15 May 2024 11:40:18 +0200
Message-Id: <20240515094043.82850-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

This is a first step in enabling CF_PCREL, but for now
we regenerate the absolute address before writeback.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e0e4db75ee..de077e7a57 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -45,9 +45,9 @@ typedef struct DisasCond {
 typedef struct DisasIAQE {
     /* IASQ; may be null for no change from TB. */
     TCGv_i64 space;
-    /* IAOQ base; may be null for immediate absolute address. */
+    /* IAOQ base; may be null for relative address. */
     TCGv_i64 base;
-    /* IAOQ addend; absolute immedate address if base is null. */
+    /* IAOQ addend; if base is null, relative to ctx->iaoq_first. */
     int64_t disp;
 } DisasIAQE;
 
@@ -60,6 +60,9 @@ typedef struct DisasContext {
     /* IAQ_Next, for jumps, otherwise null for simple advance. */
     DisasIAQE iaq_j, *iaq_n;
 
+    /* IAOQ_Front at entry to TB. */
+    uint64_t iaoq_first;
+
     DisasCond null_cond;
     TCGLabel *null_lab;
 
@@ -640,7 +643,7 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
     uint64_t mask = gva_offset_mask(ctx->tb_flags);
 
     if (src->base == NULL) {
-        tcg_gen_movi_i64(dest, src->disp & mask);
+        tcg_gen_movi_i64(dest, (ctx->iaoq_first + src->disp) & mask);
     } else if (src->disp == 0) {
         tcg_gen_andi_i64(dest, src->base, mask);
     } else {
@@ -674,12 +677,8 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
     if (!link) {
         return;
     }
-    if (ctx->iaq_b.base) {
-        tcg_gen_addi_i64(cpu_gr[link], ctx->iaq_b.base,
-                         ctx->iaq_b.disp + 4);
-    } else {
-        tcg_gen_movi_i64(cpu_gr[link], ctx->iaq_b.disp + 4);
-    }
+    DisasIAQE next = iaqe_incr(&ctx->iaq_b, 4);
+    copy_iaoq_entry(ctx, cpu_gr[link], &next);
 #ifndef CONFIG_USER_ONLY
     if (with_sr0) {
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
@@ -731,7 +730,7 @@ static bool use_goto_tb(DisasContext *ctx, const DisasIAQE *f,
 {
     return (!iaqe_variable(f) &&
             (b == NULL || !iaqe_variable(b)) &&
-            translator_use_goto_tb(&ctx->base, f->disp));
+            translator_use_goto_tb(&ctx->base, ctx->iaoq_first + f->disp));
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
@@ -742,7 +741,8 @@ static bool use_nullify_skip(DisasContext *ctx)
 {
     return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
             && !iaqe_variable(&ctx->iaq_b)
-            && is_same_page(&ctx->base, ctx->iaq_b.disp));
+            && (((ctx->iaoq_first + ctx->iaq_b.disp) ^ ctx->iaoq_first)
+                & TARGET_PAGE_MASK) == 0);
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
@@ -2005,6 +2005,8 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
    aforementioned BE.  */
 static void do_page_zero(DisasContext *ctx)
 {
+    assert(ctx->iaq_f.disp == 0);
+
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
        next insn within the privileged page.  */
@@ -2024,11 +2026,11 @@ static void do_page_zero(DisasContext *ctx)
        non-sequential instruction execution.  Normally the PSW[B] bit
        detects this by disallowing the B,GATE instruction to execute
        under such conditions.  */
-    if (iaqe_variable(&ctx->iaq_b) || ctx->iaq_b.disp != ctx->iaq_f.disp + 4) {
+    if (iaqe_variable(&ctx->iaq_b) || ctx->iaq_b.disp != 4) {
         goto do_sigill;
     }
 
-    switch (ctx->iaq_f.disp & -4) {
+    switch (ctx->base.pc_first) {
     case 0x00: /* Null pointer call */
         gen_excp_1(EXCP_IMP);
         ctx->base.is_jmp = DISAS_NORETURN;
@@ -4619,8 +4621,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaq_f.disp = ctx->base.pc_first | ctx->privilege;
-    ctx->iaq_b.disp = ctx->base.tb->cs_base | ctx->privilege;
+    ctx->iaoq_first = ctx->base.pc_first | ctx->privilege;
+    ctx->iaq_b.disp = ctx->base.tb->cs_base - ctx->base.pc_first;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
@@ -4633,9 +4635,10 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     uint64_t iasq_f = cs_base & ~0xffffffffull;
     int32_t diff = cs_base;
 
-    ctx->iaq_f.disp = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
+    ctx->iaoq_first = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
+
     if (diff) {
-        ctx->iaq_b.disp = ctx->iaq_f.disp + diff;
+        ctx->iaq_b.disp = diff;
     } else {
         ctx->iaq_b.base = cpu_iaoq_b;
         ctx->iaq_b.space = cpu_iasq_b;
@@ -4668,9 +4671,9 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     tcg_debug_assert(!iaqe_variable(&ctx->iaq_f));
-    tcg_gen_insn_start(ctx->iaq_f.disp,
-                       iaqe_variable(&ctx->iaq_b) ? -1 : ctx->iaq_b.disp,
-                       0);
+    tcg_gen_insn_start(ctx->iaoq_first + ctx->iaq_f.disp,
+                       (iaqe_variable(&ctx->iaq_b) ? -1 :
+                        ctx->iaoq_first + ctx->iaq_b.disp), 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.34.1


