Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612FC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatt-0003B2-BO; Sun, 18 Jan 2026 17:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatf-0002Mb-AE
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:26 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatd-0000rW-3b
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:23 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-bc0d7255434so1445343a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773919; x=1769378719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyHPNybRY+NoN8XylpS1cgArMSCY+8ib77S0l59/9JY=;
 b=JvFNIAwJat2N+oRM3ASGdXZC9tj17NwBz3tVK67Wl4sNkrX7WoLzEjn2KKdkSgs0IL
 FhWf3nD2ASBvS5mz9pA/ajG9a81BmtLXDaAWOqvBvMoVjcg3KRUSfFz/BjCNJbB9np5i
 uA/F980md8vw6vcFCWg4NYiXcKlYFxNRWGqzIVAhgfkWoDulRCGfhVwvS/lwGHIDs0T/
 iDEbfToh4ST/0RJEvC6gQnMs2Cs42bUTUaBkMp9KLt9OwQKMtSe7/b+YsKTlLTbR9krI
 zNnjsoAuBsCgNuHca9UPxdkr8AiPDLy3BiSmRwBJrjT20yYcCbkTTtw8q7kerg15DKnx
 T5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773919; x=1769378719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lyHPNybRY+NoN8XylpS1cgArMSCY+8ib77S0l59/9JY=;
 b=UMlmA7+uwp03p/bnTRqO7wJUy/mSI2QETiByL7UGjDwInGbFGm7oRkpihCw4+1jNXE
 RcDEnbn/vedymLWqzUpwk6YCQ5057l0iRdNUncVjt1NApb4zhjIRla3pF3iayzOpVYfe
 huzbmZUdP5wChf0v7KmuKe0wjF1WnNGzbZjlvYWhwzKzVOq2hiaa+U9gCMd3f0pblkmU
 dkoSDCj74C8XkF9POa03BBvA6DU56rPF0Y8buXiIsVSUABFvlAF4T2ejJMwcdKsmVlJY
 bcnJoDvBMUvAkDLwSVpPjqkUBsug6pzBUHKk9q/XDzM0Ni7GFmothwSmtcUWfMHmV6uK
 Iqzg==
X-Gm-Message-State: AOJu0Yzc7B1XCUCaatK1l3vGr3sawot4vnQub7KJnJmVw0/gf6s7u3bo
 HgAAAMfsUuXXQ9tdv70ovENLas8OAzyOqBbqgcrStFvqyaAPGNUOSpnk1R1QGF3fr0I1APvSWpq
 KLV81KiL83g==
X-Gm-Gg: AY/fxX6Fm5o8syKYwGE4/qYJedXlaj0DDXmJuZijbmgoqsXbS/S0JKIzJOovVxoSHfE
 x3UmVShPHgJrX4lhP/AJTFjX0sG/aNcvGkOrVXisb4H23Dg1Xi/SR+A5esDlbc3yapsGJHnivZT
 XzZwVdS+7Mur+YGDqjkjonizXfDZlJwTOfmyHco/58PFpS4OQIpAdW4hGFqcmEhn/5jkSqI8v2Z
 IgvJWwkrhBnJa0YbLiKlyRkxBMxsMDm888B3jA8agPL4SKjp3QTb4gzQd+SgWVdwPDK8bfZ4SQh
 PdF5QxLvVVPcSvruzAgVNBbwGph4BniDlakgpOy2uze9WMEdxukx5Jtx0EI4j/hJv33QYcL8505
 L2bSDha+cZthWVgeZrAdSLZWB75FcDjUV3lEsIzb9saJk1oDOK2ssEvuAclCBKpZkgPbrBIUYm0
 Hbt5cndmPVYpBJdaZZWlteRViOVXOa
X-Received: by 2002:a05:6a21:9d48:b0:38b:ea2a:2843 with SMTP id
 adf61e73a8af0-38dfe56a081mr8894193637.10.1768773918947; 
 Sun, 18 Jan 2026 14:05:18 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/54] tcg: Remove INDEX_op_dup2_vec
Date: Mon, 19 Jan 2026 09:03:44 +1100
Message-ID: <20260118220414.8177-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This opcode was exclusively for 32-bit hosts.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h |  1 -
 tcg/optimize.c        | 18 ---------
 tcg/tcg-op-vec.c      | 14 +------
 tcg/tcg.c             | 94 -------------------------------------------
 4 files changed, 2 insertions(+), 125 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index fc1270f01e..28806057c5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -130,7 +130,6 @@ DEF(qemu_st2, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_INT
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
 DEF(dup_vec, 1, 1, 0, TCG_OPF_VECTOR)
-DEF(dup2_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
 DEF(ld_vec, 1, 1, 1, TCG_OPF_VECTOR)
 DEF(st_vec, 0, 2, 1, TCG_OPF_VECTOR)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d845c7eef2..801a0a2c68 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1716,21 +1716,6 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_dup2(OptContext *ctx, TCGOp *op)
-{
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t = deposit64(arg_const_val(op->args[1]), 32, 32,
-                               arg_const_val(op->args[2]));
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
-    }
-
-    if (args_are_copies(op->args[1], op->args[2])) {
-        op->opc = INDEX_op_dup_vec;
-        TCGOP_VECE(op) = MO_32;
-    }
-    return finish_folding(ctx, op);
-}
-
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, o_mask, s_mask;
@@ -2887,9 +2872,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_dup_vec:
             done = fold_dup(&ctx, op);
             break;
-        case INDEX_op_dup2_vec:
-            done = fold_dup2(&ctx, op);
-            break;
         case INDEX_op_eqv:
         case INDEX_op_eqv_vec:
             done = fold_eqv(&ctx, op);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 893d68e7d8..67e837174b 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -75,7 +75,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_xor_vec:
         case INDEX_op_mov_vec:
         case INDEX_op_dup_vec:
-        case INDEX_op_dup2_vec:
         case INDEX_op_ld_vec:
         case INDEX_op_st_vec:
         case INDEX_op_bitsel_vec:
@@ -228,20 +227,11 @@ void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
 {
     TCGArg ri = tcgv_vec_arg(r);
+    TCGArg ai = tcgv_i64_arg(a);
     TCGTemp *rt = arg_temp(ri);
     TCGType type = rt->base_type;
 
-    if (TCG_TARGET_REG_BITS == 64) {
-        TCGArg ai = tcgv_i64_arg(a);
-        vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
-    } else if (vece == MO_64) {
-        TCGArg al = tcgv_i32_arg(TCGV_LOW(a));
-        TCGArg ah = tcgv_i32_arg(TCGV_HIGH(a));
-        vec_gen_3(INDEX_op_dup2_vec, type, MO_64, ri, al, ah);
-    } else {
-        TCGArg ai = tcgv_i32_arg(TCGV_LOW(a));
-        vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
-    }
+    vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
 }
 
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec r, TCGv_i32 a)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b6a65fe224..2b3bcbe750 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2493,8 +2493,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_vec:
     case INDEX_op_cmp_vec:
         return has_type;
-    case INDEX_op_dup2_vec:
-        return has_type && TCG_TARGET_REG_BITS == 32;
     case INDEX_op_not_vec:
         return has_type && TCG_TARGET_HAS_not_vec;
     case INDEX_op_neg_vec:
@@ -5888,93 +5886,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 }
 
-static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
-{
-    const TCGLifeData arg_life = op->life;
-    TCGTemp *ots, *itsl, *itsh;
-    TCGType vtype = TCGOP_TYPE(op);
-
-    /* This opcode is only valid for 32-bit hosts, for 64-bit elements. */
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-    tcg_debug_assert(TCGOP_VECE(op) == MO_64);
-
-    ots = arg_temp(op->args[0]);
-    itsl = arg_temp(op->args[1]);
-    itsh = arg_temp(op->args[2]);
-
-    /* ENV should not be modified.  */
-    tcg_debug_assert(!temp_readonly(ots));
-
-    /* Allocate the output register now.  */
-    if (ots->val_type != TEMP_VAL_REG) {
-        TCGRegSet allocated_regs = s->reserved_regs;
-        TCGRegSet dup_out_regs = opcode_args_ct(op)[0].regs;
-        TCGReg oreg;
-
-        /* Make sure to not spill the input registers. */
-        if (!IS_DEAD_ARG(1) && itsl->val_type == TEMP_VAL_REG) {
-            tcg_regset_set_reg(allocated_regs, itsl->reg);
-        }
-        if (!IS_DEAD_ARG(2) && itsh->val_type == TEMP_VAL_REG) {
-            tcg_regset_set_reg(allocated_regs, itsh->reg);
-        }
-
-        oreg = tcg_reg_alloc(s, dup_out_regs, allocated_regs,
-                             output_pref(op, 0), ots->indirect_base);
-        set_temp_val_reg(s, ots, oreg);
-    }
-
-    /* Promote dup2 of immediates to dupi_vec. */
-    if (itsl->val_type == TEMP_VAL_CONST && itsh->val_type == TEMP_VAL_CONST) {
-        uint64_t val = deposit64(itsl->val, 32, 32, itsh->val);
-        MemOp vece = MO_64;
-
-        if (val == dup_const(MO_8, val)) {
-            vece = MO_8;
-        } else if (val == dup_const(MO_16, val)) {
-            vece = MO_16;
-        } else if (val == dup_const(MO_32, val)) {
-            vece = MO_32;
-        }
-
-        tcg_out_dupi_vec(s, vtype, vece, ots->reg, val);
-        goto done;
-    }
-
-    /* If the two inputs form one 64-bit value, try dupm_vec. */
-    if (itsl->temp_subindex == HOST_BIG_ENDIAN &&
-        itsh->temp_subindex == !HOST_BIG_ENDIAN &&
-        itsl == itsh + (HOST_BIG_ENDIAN ? 1 : -1)) {
-        TCGTemp *its = itsl - HOST_BIG_ENDIAN;
-
-        temp_sync(s, its + 0, s->reserved_regs, 0, 0);
-        temp_sync(s, its + 1, s->reserved_regs, 0, 0);
-
-        if (tcg_out_dupm_vec(s, vtype, MO_64, ots->reg,
-                             its->mem_base->reg, its->mem_offset)) {
-            goto done;
-        }
-    }
-
-    /* Fall back to generic expansion. */
-    return false;
-
- done:
-    ots->mem_coherent = 0;
-    if (IS_DEAD_ARG(1)) {
-        temp_dead(s, itsl);
-    }
-    if (IS_DEAD_ARG(2)) {
-        temp_dead(s, itsh);
-    }
-    if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
-    } else if (IS_DEAD_ARG(0)) {
-        temp_dead(s, ots);
-    }
-    return true;
-}
-
 static void load_arg_reg(TCGContext *s, TCGReg reg, TCGTemp *ts,
                          TCGRegSet allocated_regs)
 {
@@ -6939,11 +6850,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         case INDEX_op_mb:
             tcg_out_mb(s, op->args[0]);
             break;
-        case INDEX_op_dup2_vec:
-            if (tcg_reg_alloc_dup2(s, op)) {
-                break;
-            }
-            /* fall through */
         default:
         do_default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
-- 
2.43.0


