Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF40BEE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYT-00021I-6d; Wed, 11 Sep 2024 12:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYR-0001wJ-K7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYP-0003eL-Ff
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71911585ac4so1699794b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073452; x=1726678252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnL0glGXZj+IRh5HnNxFKu2Xl8Anqsqr5rwYjln/1tc=;
 b=TChzLhdXqaZINMF4UoycKvqMxVIBIZMqRlpFnRkwO4JisUzLdXlqiRSY0JSLWYEot0
 gL6iKMO3t8/bnakxJ4kwzIxTAvlwWiSqyC+l6w4bXQo42G8P2U1CjgfAodUvNgxCoeF0
 vTuroKrkJ3V1KivbM9vMTA3sMSxhhAvn1Z1nWLJOnWDX7NtPYkUz5f4hYxlA1YP0elB1
 YnIEVzJCXzoDzMHB+KB+hPSBub4gBrPnYrzSu7wrMpiHIMAmzGjwAu7UyeoYnOZRZJx7
 00N4Zn/BUzSYNapZbrBtjcI1tvdLrF6vtZa/oD9dNTpJgQW8fb1+DIyWNugO48+5+TtG
 q1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073452; x=1726678252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnL0glGXZj+IRh5HnNxFKu2Xl8Anqsqr5rwYjln/1tc=;
 b=pGxIYzQ5M61JiTT7T/IaWl4f+3LT++zUYz+8+E7jkdCufr/WL9q8ircoQ94999PsJ6
 9EVb5vmub4W/mfzq32w12441sd78jDIph+FgVZOdfT8Ioygidx1hE2yqmHTTABoqowKT
 ds9zRjqg8qSp9mRn+yJkmOt7ZRx2GMP1s8BV7ZK3bM2OsSpDgkjbkZb4X6EZHjcAugvu
 7ZdE+zz8aES6H0RVUk3cvQresDJOZUIEAPxyGOlwE/fRNK6iLJfScYI6XS1JBSGrCsrr
 8WuOx2XhwCK369EQ+3cPcdaikIlWmmojcoIys8lRaFrM00XrVqrHFqcIvu7rTRf97zPs
 Lhew==
X-Gm-Message-State: AOJu0Yz7tckxQTaq5fkOSGFMgDGuPJBnorEGpp6NzrpKmom2F5lRJYPO
 jAiUSdow77ivbLnRcA0qc5Ol7m/fzHOK84QwZb2pdFQ8g/ffkoH2bypMzVpLat18OMVO/q5exIQ
 3
X-Google-Smtp-Source: AGHT+IENDTzTQo5JQkpteKRYdKoLdI6zdDF46E3WnrjkI34guG67n1zUR+hbaUidD9WncAFS9oFjBg==
X-Received: by 2002:a05:6a00:2381:b0:70d:21d9:e2ae with SMTP id
 d2e1a72fcca58-71926063653mr26411b3a.6.1726073451767; 
 Wed, 11 Sep 2024 09:50:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 03/18] tcg/i386: Do not expand cmp_vec early
Date: Wed, 11 Sep 2024 09:50:32 -0700
Message-ID: <20240911165047.1035764-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Move most of expansion to opcode generation, leaving the
conversion of unsigned to signed to be done in the early phase.
Small inefficiencies, but not incorrect results, are introduced
until cmpsel_vec is converted in the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 223 +++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 123 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index af71a397b1..278e567b56 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3029,6 +3029,92 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #undef OP_32_64
 }
 
+static int const umin_insn[4] = {
+    OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
+};
+
+static int const umax_insn[4] = {
+    OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_VPMAXUQ
+};
+
+static bool tcg_out_cmp_vec_noinv(TCGContext *s, TCGType type, unsigned vece,
+                                  TCGReg v0, TCGReg v1, TCGReg v2, TCGCond cond)
+{
+    static int const cmpeq_insn[4] = {
+        OPC_PCMPEQB, OPC_PCMPEQW, OPC_PCMPEQD, OPC_PCMPEQQ
+    };
+    static int const cmpgt_insn[4] = {
+        OPC_PCMPGTB, OPC_PCMPGTW, OPC_PCMPGTD, OPC_PCMPGTQ
+    };
+
+    enum {
+        NEED_INV  = 1,
+        NEED_SWAP = 2,
+        NEED_UMIN = 4,
+        NEED_UMAX = 8,
+        INVALID   = 16,
+    };
+    static const uint8_t cond_fixup[16] = {
+        [0 ... 15] = INVALID,
+        [TCG_COND_EQ] = 0,
+        [TCG_COND_GT] = 0,
+        [TCG_COND_NE] = NEED_INV,
+        [TCG_COND_LE] = NEED_INV,
+        [TCG_COND_LT] = NEED_SWAP,
+        [TCG_COND_GE] = NEED_SWAP | NEED_INV,
+        [TCG_COND_LEU] = NEED_UMIN,
+        [TCG_COND_GTU] = NEED_UMIN | NEED_INV,
+        [TCG_COND_GEU] = NEED_UMAX,
+        [TCG_COND_LTU] = NEED_UMAX | NEED_INV,
+    };
+    int fixup = cond_fixup[cond];
+
+    assert(!(fixup & INVALID));
+
+    if (fixup & NEED_INV) {
+        cond = tcg_invert_cond(cond);
+    }
+
+    if (fixup & NEED_SWAP) {
+        TCGReg swap = v1;
+        v1 = v2;
+        v2 = swap;
+        cond = tcg_swap_cond(cond);
+    }
+
+    if (fixup & (NEED_UMIN | NEED_UMAX)) {
+        int op = (fixup & NEED_UMIN ? umin_insn[vece] : umax_insn[vece]);
+
+        /* avx2 does not have 64-bit min/max; adjusted during expand. */
+        assert(vece <= MO_32);
+
+        tcg_out_vex_modrm_type(s, op, TCG_TMP_VEC, v1, v2, type);
+        v2 = TCG_TMP_VEC;
+        cond = TCG_COND_EQ;
+    }
+
+    switch (cond) {
+    case TCG_COND_EQ:
+        tcg_out_vex_modrm_type(s, cmpeq_insn[vece], v0, v1, v2, type);
+        break;
+    case TCG_COND_GT:
+        tcg_out_vex_modrm_type(s, cmpgt_insn[vece], v0, v1, v2, type);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return fixup & NEED_INV;
+}
+
+static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg v0, TCGReg v1, TCGReg v2, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, type, vece, v0, v1, v2, cond)) {
+        tcg_out_dupi_vec(s, type, vece, TCG_TMP_VEC, -1);
+        tcg_out_vex_modrm_type(s, OPC_PXOR, v0, v0, TCG_TMP_VEC, type);
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3058,12 +3144,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const shift_imm_insn[4] = {
         OPC_UD2, OPC_PSHIFTW_Ib, OPC_PSHIFTD_Ib, OPC_PSHIFTQ_Ib
     };
-    static int const cmpeq_insn[4] = {
-        OPC_PCMPEQB, OPC_PCMPEQW, OPC_PCMPEQD, OPC_PCMPEQQ
-    };
-    static int const cmpgt_insn[4] = {
-        OPC_PCMPGTB, OPC_PCMPGTW, OPC_PCMPGTD, OPC_PCMPGTQ
-    };
     static int const punpckl_insn[4] = {
         OPC_PUNPCKLBW, OPC_PUNPCKLWD, OPC_PUNPCKLDQ, OPC_PUNPCKLQDQ
     };
@@ -3082,12 +3162,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const smax_insn[4] = {
         OPC_PMAXSB, OPC_PMAXSW, OPC_PMAXSD, OPC_VPMAXSQ
     };
-    static int const umin_insn[4] = {
-        OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
-    };
-    static int const umax_insn[4] = {
-        OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_VPMAXUQ
-    };
     static int const rotlv_insn[4] = {
         OPC_UD2, OPC_UD2, OPC_VPROLVD, OPC_VPROLVQ
     };
@@ -3243,15 +3317,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_cmp_vec:
-        sub = args[3];
-        if (sub == TCG_COND_EQ) {
-            insn = cmpeq_insn[vece];
-        } else if (sub == TCG_COND_GT) {
-            insn = cmpgt_insn[vece];
-        } else {
-            g_assert_not_reached();
-        }
-        goto gen_simd;
+        tcg_out_cmp_vec(s, type, vece, a0, a1, a2, args[3]);
+        break;
 
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
@@ -3971,88 +4038,19 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     }
 }
 
-static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
-                                 TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
-    enum {
-        NEED_INV  = 1,
-        NEED_SWAP = 2,
-        NEED_BIAS = 4,
-        NEED_UMIN = 8,
-        NEED_UMAX = 16,
-    };
-    TCGv_vec t1, t2, t3;
-    uint8_t fixup;
+    /*
+     * Without AVX512, there are no 64-bit unsigned comparisons.
+     * We must bias the inputs so that they become signed.
+     * All other swapping and inversion are handled during code generation.
+     */
+    if (vece == MO_64 && is_unsigned_cond(cond)) {
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
+        TCGv_vec t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
 
-    switch (cond) {
-    case TCG_COND_EQ:
-    case TCG_COND_GT:
-        fixup = 0;
-        break;
-    case TCG_COND_NE:
-    case TCG_COND_LE:
-        fixup = NEED_INV;
-        break;
-    case TCG_COND_LT:
-        fixup = NEED_SWAP;
-        break;
-    case TCG_COND_GE:
-        fixup = NEED_SWAP | NEED_INV;
-        break;
-    case TCG_COND_LEU:
-        if (tcg_can_emit_vec_op(INDEX_op_umin_vec, type, vece)) {
-            fixup = NEED_UMIN;
-        } else {
-            fixup = NEED_BIAS | NEED_INV;
-        }
-        break;
-    case TCG_COND_GTU:
-        if (tcg_can_emit_vec_op(INDEX_op_umin_vec, type, vece)) {
-            fixup = NEED_UMIN | NEED_INV;
-        } else {
-            fixup = NEED_BIAS;
-        }
-        break;
-    case TCG_COND_GEU:
-        if (tcg_can_emit_vec_op(INDEX_op_umax_vec, type, vece)) {
-            fixup = NEED_UMAX;
-        } else {
-            fixup = NEED_BIAS | NEED_SWAP | NEED_INV;
-        }
-        break;
-    case TCG_COND_LTU:
-        if (tcg_can_emit_vec_op(INDEX_op_umax_vec, type, vece)) {
-            fixup = NEED_UMAX | NEED_INV;
-        } else {
-            fixup = NEED_BIAS | NEED_SWAP;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (fixup & NEED_INV) {
-        cond = tcg_invert_cond(cond);
-    }
-    if (fixup & NEED_SWAP) {
-        t1 = v1, v1 = v2, v2 = t1;
-        cond = tcg_swap_cond(cond);
-    }
-
-    t1 = t2 = NULL;
-    if (fixup & (NEED_UMIN | NEED_UMAX)) {
-        t1 = tcg_temp_new_vec(type);
-        if (fixup & NEED_UMIN) {
-            tcg_gen_umin_vec(vece, t1, v1, v2);
-        } else {
-            tcg_gen_umax_vec(vece, t1, v1, v2);
-        }
-        v2 = t1;
-        cond = TCG_COND_EQ;
-    } else if (fixup & NEED_BIAS) {
-        t1 = tcg_temp_new_vec(type);
-        t2 = tcg_temp_new_vec(type);
-        t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
         tcg_gen_sub_vec(vece, t1, v1, t3);
         tcg_gen_sub_vec(vece, t2, v2, t3);
         v1 = t1;
@@ -4060,26 +4058,9 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
         cond = tcg_signed_cond(cond);
     }
 
-    tcg_debug_assert(cond == TCG_COND_EQ || cond == TCG_COND_GT);
     /* Expand directly; do not recurse.  */
     vec_gen_4(INDEX_op_cmp_vec, type, vece,
               tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
-
-    if (t1) {
-        tcg_temp_free_vec(t1);
-        if (t2) {
-            tcg_temp_free_vec(t2);
-        }
-    }
-    return fixup & NEED_INV;
-}
-
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
-{
-    if (expand_vec_cmp_noinv(type, vece, v0, v1, v2, cond)) {
-        tcg_gen_not_vec(vece, v0, v0);
-    }
 }
 
 static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
@@ -4088,11 +4069,7 @@ static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
 {
     TCGv_vec t = tcg_temp_new_vec(type);
 
-    if (expand_vec_cmp_noinv(type, vece, t, c1, c2, cond)) {
-        /* Invert the sense of the compare by swapping arguments.  */
-        TCGv_vec x;
-        x = v3, v3 = v4, v4 = x;
-    }
+    expand_vec_cmp(type, vece, t, c1, c2, cond);
     vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
               tcgv_vec_arg(v0), tcgv_vec_arg(v4),
               tcgv_vec_arg(v3), tcgv_vec_arg(t));
-- 
2.43.0


