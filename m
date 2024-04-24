Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2436CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmIU-000113-Ku; Wed, 24 Apr 2024 19:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIL-0000xw-TD
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIJ-00028c-Kh
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ab791bce6fso353442a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714002292; x=1714607092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xp7F1dpl/yWtxNJPPz/02BB7DaGLCNxpN0PiR1H7/z0=;
 b=RL+q2jVcPpK1DZ0QCjDMPQWq5B/GyoLqGgj4sodzK4KLEcgolf9Bwz7lmdTqzWrqsR
 cr09ubcOALFGJZvkhRQQO0VjwpFGqCJPR7Yly6Y8CW8w1xiaD6zv7yaTHRKubXD2+4WJ
 ohWFzLsroVvYOg684DFoyPQ9FhXd4VPqk1fs5LZYJbj/nCQAU4lkws2Y0ArZaVVBuU92
 U3/IVxCbV3hJc5Pz5gQX6nh4gl//7IJLA88EjBOY/m3FKi3VIcTUKTGpJTEj2mmY5YTF
 6miu47Q9YteWRQyH4ORVk5Q6zUWciMQkct5tIxEmZNTFlgTvk2Ntx4RHCOvZJ4mfCJ1u
 xRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714002292; x=1714607092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xp7F1dpl/yWtxNJPPz/02BB7DaGLCNxpN0PiR1H7/z0=;
 b=D4boA0bsjrgJxgCAEP6giCADwhAjeA22rHUP5jFnN32UjUKfrco0Jnkxy3Q4c11eik
 9xR8cmOaSuSzohZM24NRs3u+fpguoIrzbEwaZlyTfmkQnqXV+7WFHiS0Yh+IiO5HvDTd
 DIqVYO4pavtqpkmc/ybqouIiVGhpJzZr5mqQZt5wsQsxFhN6zEMMkV7NSgxlKvSmhvCj
 aZpb7cCuXMjgN01/xDJ274bxvyCu9GxdRi4GdZBer2LOeFONGjBJ83UN8t5uqoWirn5q
 AMHJPYRFLCbW6xaJqu2qoNpyZextRpW0tH8xOsKmLYMIwpuEsCej2GCaeJM0jt14NzJy
 ycdw==
X-Gm-Message-State: AOJu0Yz3mpKH8BRR+2XylJnb9XW+Sdu9xryNEkY4FbUf99gMHZPICTSQ
 6x61+p8GxqKYiTELv6dfSyPOIK+QZ8ajmy88MWbTxUrfiEQKX0bHOQmz92GrBnnbfP7dcq5UxvA
 d
X-Google-Smtp-Source: AGHT+IGHyAVgaOhMzh6RO0QMnw0+1t7p1Vd1R5NCPNx4Mk6Wbb7oScOzESs9/owxLAXHv7bFzCiwPA==
X-Received: by 2002:a17:90a:ee8f:b0:2aa:5c79:853c with SMTP id
 i15-20020a17090aee8f00b002aa5c79853cmr4241096pjz.21.1714002292302; 
 Wed, 24 Apr 2024 16:44:52 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f55100b001e49428f327sm12531642plf.176.2024.04.24.16.44.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:44:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/alpha: Hoist branch shift to initial decode
Date: Wed, 24 Apr 2024 16:44:33 -0700
Message-Id: <20240424234436.995410-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424234436.995410-1-richard.henderson@linaro.org>
References: <20240424234436.995410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a97cd54f0c..52c2e6248b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -432,7 +432,7 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + disp;
 
     if (ra != 31) {
         tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
@@ -455,7 +455,7 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, uint64_t imm, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
@@ -1382,7 +1382,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     real_islit = islit = extract32(insn, 12, 1);
     lit = extract32(insn, 13, 8);
 
-    disp21 = sextract32(insn, 0, 21);
+    disp21 = sextract32(insn, 0, 21) * 4;
     disp16 = sextract32(insn, 0, 16);
     disp12 = sextract32(insn, 0, 12);
 
-- 
2.34.1


