Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361F8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY1-0008Jy-1W; Wed, 24 Apr 2024 20:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXi-0008Cc-DZ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXc-0006FB-FX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e8bbcbc2b7so3966315ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003243; x=1714608043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kIfEXtXX+JbLeMH/Uyj+dUGcwoopaLfipcBYLL0xhus=;
 b=jFquBBKXXH5WS6J5GQa4bC0BcweCPql1Jz48i/ErqZ1ELbkB0RIffCSz/qabWkj9ar
 THa5BML0kCr0red51BUTWlV8j7/3wEOfWk5BSifSQUQ7zqdPp6GBEKyEjQ3jk0nwR9qP
 DQT9o0tvBkKNPLXGJiuhX52F0KxnLOlMyEGnNX8B9iQn/rh/C+SMzks87LO4NIxVrhQa
 Ole0iAFLA+Y+MKWoaCZy0/7J5PqlPsQ4Svek8PsUxQW5tNWRqooUnan8oDKkv88bezE/
 4ukSi1ekd4CZ8323yoQpMoU261+AiZQ5kNv1QraNBInsdSTa8KcYcwAoiwZRmw4MKxsO
 TPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003243; x=1714608043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIfEXtXX+JbLeMH/Uyj+dUGcwoopaLfipcBYLL0xhus=;
 b=BmppAsbq+YDl0F8xT9bAmUuYg7eCmyqpYBj4dvzJlMszc1ihqe+nWKM1/J1nRyWy+P
 LmwR3KeTgGDAPVCyHY3n61ccxUegD4vRfAW6Im/e7MKkP7abbL3TJQx4V6Tx27/Q6fdC
 l0ueK79jtFtp1IoveFQ2uS0rBA5tcZWyvSWj7RCtZtUc/uOja+Vh9aa83pf9f9zYP+bX
 NYW6kwVTkHyAVVhnx0JnRisuIIOSJvrCtBTKJUxTFkq84QVqsHgHsspgx4b5ajOdJWSu
 +/4hT4FNWLWjmohzuhUdtQsL9tYXL5ryRZ23GrfoCgZbI5CTV1KdKhOeLu0XIZE5lDZg
 eLZw==
X-Gm-Message-State: AOJu0YzZ0iyuhrVUIHgMB9PY6pmWFhxfhPAMqAVGhEzjOmZxfyN4Tf02
 3/y/z8GmLfWNOUH8fMFC0qEt+OG7HhxjXgAsxwzVtT+Wq8GZ6idpDv9p0EA7K+4QqKMawaT+3SG
 S
X-Google-Smtp-Source: AGHT+IEZ3dHjqRsje0vDZou6YmM6/vWMvX/wreduPHSteWDosw+N/F2HE2l/mrtsKd+DKXwqGqFJZQ==
X-Received: by 2002:a17:903:11d1:b0:1e2:3cbe:adcc with SMTP id
 q17-20020a17090311d100b001e23cbeadccmr5633914plh.49.1714003242801; 
 Wed, 24 Apr 2024 17:00:42 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/45] target/hppa: Use displacements in DisasIAQE
Date: Wed, 24 Apr 2024 16:59:56 -0700
Message-Id: <20240425000023.1002026-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9d3bffb688..dd3921dbf9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,9 +44,9 @@ typedef struct DisasCond {
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
 
@@ -59,6 +59,9 @@ typedef struct DisasContext {
     /* IAQ_Next, for jumps, otherwise null for simple advance. */
     DisasIAQE iaq_j, *iaq_n;
 
+    /* IAOQ_Front at entry to TB. */
+    uint64_t iaoq_first;
+
     DisasCond null_cond;
     TCGLabel *null_lab;
 
@@ -639,7 +642,7 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
     uint64_t mask = gva_offset_mask(ctx->tb_flags);
 
     if (src->base == NULL) {
-        tcg_gen_movi_i64(dest, src->disp & mask);
+        tcg_gen_movi_i64(dest, (ctx->iaoq_first + src->disp) & mask);
     } else if (src->disp == 0) {
         tcg_gen_andi_i64(dest, src->base, mask);
     } else {
@@ -671,12 +674,8 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 {
     tcg_debug_assert(ctx->null_cond.c == TCG_COND_NEVER);
     if (link) {
-        if (ctx->iaq_b.base) {
-            tcg_gen_addi_i64(cpu_gr[link], ctx->iaq_b.base,
-                             ctx->iaq_b.disp + 4);
-        } else {
-            tcg_gen_movi_i64(cpu_gr[link], ctx->iaq_b.disp + 4);
-        }
+        DisasIAQE next = iaqe_incr(&ctx->iaq_b, 4);
+        copy_iaoq_entry(ctx, cpu_gr[link], &next);
 #ifndef CONFIG_USER_ONLY
         if (with_sr0) {
             tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
@@ -729,7 +728,7 @@ static bool use_goto_tb(DisasContext *ctx, const DisasIAQE *f,
 {
     return (!iaqe_variable(f) &&
             (b == NULL || !iaqe_variable(b)) &&
-            translator_use_goto_tb(&ctx->base, f->disp));
+            translator_use_goto_tb(&ctx->base, ctx->iaoq_first + f->disp));
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
@@ -740,7 +739,8 @@ static bool use_nullify_skip(DisasContext *ctx)
 {
     return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
             && !iaqe_variable(&ctx->iaq_b)
-            && is_same_page(&ctx->base, ctx->iaq_b.disp));
+            && (((ctx->iaoq_first + ctx->iaq_b.disp) ^ ctx->iaoq_first)
+                & TARGET_PAGE_MASK) == 0);
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
@@ -2003,6 +2003,8 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
    aforementioned BE.  */
 static void do_page_zero(DisasContext *ctx)
 {
+    assert(ctx->iaq_f.disp == 0);
+
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
        next insn within the privileged page.  */
@@ -2022,11 +2024,11 @@ static void do_page_zero(DisasContext *ctx)
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
@@ -4617,8 +4619,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4631,9 +4633,10 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4666,9 +4669,9 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
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


