Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B82C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydf-0001hk-HH; Wed, 05 Jun 2024 17:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEyde-0001hD-9N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydc-0003pf-G9
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:46 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-703ed15b273so255033b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624663; x=1718229463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhUXFhxALhRCHAx9BQm8y0zAn9EGdu513/wa3HnMCCc=;
 b=aogdC3sK0z3VUyKVvtNXPyh/i1kjhqfJwoTzvxslEFdMv3AgfWAqa+BP9l6BaZY39o
 3lltglJjNGMRBQTF/F/gP1Ikwij15/qJyqZcnX2iB8muOh6a2lsVnY4shaM/TtbQ0h2Y
 qJ03af3ZNPonQuo6dk75UjjfolCYRMwS+H24mH9yIW6oRO22nJom3Nm7JfHCTZvFCdmw
 xL0W4b1t6q0h63v/SSnp5hFW7/HTXTEwbFxxTriHQhrTVczfxc4GkW+RJoJU2QuSBlUl
 //p4MapXI9x4oC3Zbw7fzQ+4T0YCTC/PWAKvnFKJ7P3uptDeodDr4lUlYGL/kG3jg7O6
 r7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624663; x=1718229463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhUXFhxALhRCHAx9BQm8y0zAn9EGdu513/wa3HnMCCc=;
 b=tPysFby38D1j6s/VtArN/PvOq6b7qMHhUz0y3ikMSShLXuUIj43sVRBB1YyOAON5C0
 sJ5Q4fH2+6LreNjzB1c+bQcRmbTYPQ9GON0f4c21HOqFqbkQXKkNcZUrEZcib6cJF+AL
 pC+m1B4kl64tGeEh4sDaz3/rwBSZtuuRE32fApWthnCy/iLufsNxg56S/URAFYw4XMLA
 DnT0Z3/77On4TabUkhKIdW934ZuZ1YTjeNE21ReEj/g0HpttZoFXfvPYXfbiQJIjQMZF
 A2KIPSXzr/Hirc5dOjqkz4xqUyVNJuBdcoWx+IlhMGnlpuljiX8lN8PG7a0p/bKRe8lP
 D3Bw==
X-Gm-Message-State: AOJu0YzfS4gLWNhyVrLaHj+jEKR2a2BaifkGmwI5olWl/91WMAyv3RFZ
 ny0D64ifKmxgfQs8t6nbjol/c/JGswMU4sJuXWjKp5JvHGDR7trI11G3RBjhqbvjDxQ4f1btgqn
 s
X-Google-Smtp-Source: AGHT+IFdAdxzm74sB0nyzk4nfPBBtDCFhydAJekbgEXn+lJeEFejh3iSsWvYiIpo+zAPZDjziWMXAA==
X-Received: by 2002:a05:6a20:d80d:b0:1af:881c:e924 with SMTP id
 adf61e73a8af0-1b2b763736fmr4494091637.62.1717624662965; 
 Wed, 05 Jun 2024 14:57:42 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 02/10] target/s390x: Introduce gen_psw_addr_disp
Date: Wed,  5 Jun 2024 14:57:31 -0700
Message-Id: <20240605215739.4758-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

In preparation for TARGET_TB_PCREL, reduce reliance on absolute values.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index f25ae02a4e..bd4ad33802 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -167,6 +167,11 @@ static uint64_t inline_branch_hit[CC_OP_MAX];
 static uint64_t inline_branch_miss[CC_OP_MAX];
 #endif
 
+static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
+{
+    tcg_gen_movi_i64(dest, s->base.pc_next + disp);
+}
+
 static void pc_to_link_info(TCGv_i64 out, DisasContext *s, uint64_t pc)
 {
     if (s->base.tb->flags & FLAG_MASK_32) {
@@ -337,8 +342,7 @@ static void store_freg32_i64(int reg, TCGv_i64 v)
 
 static void update_psw_addr(DisasContext *s)
 {
-    /* psw.addr */
-    tcg_gen_movi_i64(psw_addr, s->base.pc_next);
+    gen_psw_addr_disp(s, psw_addr, 0);
 }
 
 static void per_branch(DisasContext *s, TCGv_i64 dest)
@@ -352,7 +356,7 @@ static void per_branch(DisasContext *s, TCGv_i64 dest)
 
 static void per_breaking_event(DisasContext *s)
 {
-    tcg_gen_movi_i64(gbea, s->base.pc_next);
+    gen_psw_addr_disp(s, gbea, 0);
 }
 
 static void update_cc_op(DisasContext *s)
@@ -1086,11 +1090,11 @@ static DisasJumpType help_goto_direct(DisasContext *s, int64_t disp)
     }
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(psw_addr, dest);
+        gen_psw_addr_disp(s, psw_addr, disp);
         tcg_gen_exit_tb(s->base.tb, 0);
         return DISAS_NORETURN;
     } else {
-        tcg_gen_movi_i64(psw_addr, dest);
+        gen_psw_addr_disp(s, psw_addr, disp);
         return DISAS_PC_CC_UPDATED;
     }
 }
@@ -1121,7 +1125,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
          * still need a conditional call to helper_per_branch.
          */
         if (c->cond == TCG_COND_ALWAYS
-            || (dest == s->pc_tmp &&
+            || (disp == s->ilen &&
                 !(s->base.tb->flags & FLAG_MASK_PER_BRANCH))) {
             return help_goto_direct(s, disp);
         }
@@ -1154,7 +1158,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
     /* Branch taken.  */
     per_breaking_event(s);
     if (is_imm) {
-        tcg_gen_movi_i64(psw_addr, dest);
+        gen_psw_addr_disp(s, psw_addr, disp);
     } else {
         tcg_gen_mov_i64(psw_addr, cdest);
     }
@@ -1170,7 +1174,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
     gen_set_label(lab);
 
     /* Branch not taken.  */
-    tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+    gen_psw_addr_disp(s, psw_addr, s->ilen);
     if (use_goto_tb(s, s->pc_tmp)) {
         tcg_gen_goto_tb(1);
         tcg_gen_exit_tb(s->base.tb, 1);
@@ -5758,7 +5762,8 @@ static TCGv gen_ri2(DisasContext *s)
 
     disas_jdest(s, i2, is_imm, imm, ri2);
     if (is_imm) {
-        ri2 = tcg_constant_i64(s->base.pc_next + (int64_t)imm * 2);
+        ri2 = tcg_temp_new_i64();
+        gen_psw_addr_disp(s, ri2, (int64_t)imm * 2);
     }
 
     return ri2;
@@ -6367,7 +6372,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
             s->base.is_jmp = DISAS_PC_CC_UPDATED;
             /* fall through */
         case DISAS_NEXT:
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+            gen_psw_addr_disp(s, psw_addr, s->ilen);
             break;
         default:
             break;
-- 
2.34.1


