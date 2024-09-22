Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CF1CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHx-0002jp-QR; Sun, 22 Sep 2024 08:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHJ-0000vl-JE
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:33 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHE-0002Mz-2m
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso465511166b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006478; x=1727611278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/08vmd3pJmcPxGI9Dvd5g1DO6IpTA5tvF/u1ewyB0/g=;
 b=SaSbg2XAvqY8xSeUpt2HSnkNVxUiEkJGUFf/pqQoYr013l68zn0Taeygz8nrxwcU1x
 d8CbhPgLKsQ0uXLtQ9nSvjvIVix5BnrrewId1aos2rqkrdz3diuuppsrPsx4we0GP1rX
 fdE4T5YGxOIIz7ox3c8emQMLFzRMiP+aE9ySwcCZX4fITjkcjcDNzvWw51kJB1R/r2kf
 Uf7uV3rTafE0cdav4aR2D3nth1OFldix98Iwxgzzy4GsV4neozrK20KuVJHUKZ8INu7H
 SVuEtWkTnvSYhP3n7W28cZmsnlydxx3fPcmgg9DifnjB/BPVg6yMeWfeT0GyN2PAzNZb
 dnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006478; x=1727611278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/08vmd3pJmcPxGI9Dvd5g1DO6IpTA5tvF/u1ewyB0/g=;
 b=So5gT4UsCwzVbvy53FPCowU7msUimrodrLDuIJuVb3IOh1xK0FvQA7dCtapzZX+agm
 UbmnGJyCN4BJjkBVatjlFwrKOgiVYOamC9cufjod36kcD6WZnRs6CitYIxUp8CpCQAea
 dC/pubqhIL6R1JxkVZCTmsRKewNnn+4dIHeQZM7Eba0bZDHC+UqkUqd+f2Abw0Hal9vH
 5di7mjQWhPGfjqtugsLMdN/xR3ny805xFTqDbRrZKilRniAMemMlcN8XkEIzaMfJqt4O
 T7ZPWMH/R94QRB2A0jBI8dY00na7IkTB8rdVlCyKGzB4mo/f1xsRt2mSTdc6u4hZsI2M
 A2dA==
X-Gm-Message-State: AOJu0YzT7NLZitktcgcnaarDmhYAwDfi1p6s/X6sYHLPLqWVWqwYKsT9
 YQK2QlIXnxK7LDeVEIe2glDy1cNZyjkYM1tzMygS8fSqd6U9dPiemC9ZZNSORtn/bNxSbAMxknh
 15PQ=
X-Google-Smtp-Source: AGHT+IGO1OVWVjckRxqbG1TK3n2GrGQmTm9/YXASMM+LviK15f4FB1BqSwSO2HheUmVZ891NILrb9A==
X-Received: by 2002:a17:907:d26:b0:a8a:cc5a:7f3a with SMTP id
 a640c23a62f3a-a90d51270f2mr859065366b.49.1727006477920; 
 Sun, 22 Sep 2024 05:01:17 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 07/31] tcg/i386: Do not expand cmpsel_vec early
Date: Sun, 22 Sep 2024 14:00:48 +0200
Message-ID: <20240922120112.5067-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

Expand during output instead of during opcode generation.
Remove x86_vpblendvb_vec opcode, this this removes the only user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  1 +
 tcg/i386/tcg-target.h         |  2 +-
 tcg/i386/tcg-target.opc.h     |  1 -
 tcg/i386/tcg-target.c.inc     | 84 +++++++++++++++++++++--------------
 4 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index e24241cfa2..da4411d96b 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -50,6 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
+C_O1_I4(x, x, x, x, x)
 C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2f67a97e05..342be30c4c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -223,7 +223,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
-#define TCG_TARGET_HAS_cmpsel_vec       -1
+#define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index b5f403e35e..4ffc084bda 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -25,7 +25,6 @@
  */
 
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
 DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
 DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 278e567b56..a04dc7d270 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3115,6 +3115,19 @@ static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
     }
 }
 
+static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
+                               TCGReg v0, TCGReg c1, TCGReg c2,
+                               TCGReg v3, TCGReg v4, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond)) {
+        TCGReg swap = v3;
+        v3 = v4;
+        v4 = swap;
+    }
+    tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, v0, v4, v3, type);
+    tcg_out8(s, (TCG_TMP_VEC - TCG_REG_XMM0) << 4);
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3320,6 +3333,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_cmp_vec(s, type, vece, a0, a1, a2, args[3]);
         break;
 
+    case INDEX_op_cmpsel_vec:
+        tcg_out_cmpsel_vec(s, type, vece, a0, a1, a2,
+                           args[3], args[4], args[5]);
+        break;
+
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
         tcg_out_vex_modrm_type(s, insn, a0, a2, a1, type);
@@ -3431,11 +3449,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out8(s, sub);
         break;
 
-    case INDEX_op_x86_vpblendvb_vec:
-        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, a0, a1, a2, type);
-        tcg_out8(s, args[3] << 4);
-        break;
-
     case INDEX_op_x86_psrldq_vec:
         tcg_out_vex_modrm(s, OPC_GRP14, 3, a0, a1);
         tcg_out8(s, a2);
@@ -3701,8 +3714,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I3(x, 0, x, x);
 
     case INDEX_op_bitsel_vec:
-    case INDEX_op_x86_vpblendvb_vec:
         return C_O1_I3(x, x, x, x);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(x, x, x, x, x);
 
     default:
         g_assert_not_reached();
@@ -4038,8 +4052,8 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     }
 }
 
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+static TCGCond expand_vec_cond(TCGType type, unsigned vece,
+                               TCGArg *a1, TCGArg *a2, TCGCond cond)
 {
     /*
      * Without AVX512, there are no 64-bit unsigned comparisons.
@@ -4047,46 +4061,50 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
      * All other swapping and inversion are handled during code generation.
      */
     if (vece == MO_64 && is_unsigned_cond(cond)) {
+        TCGv_vec v1 = temp_tcgv_vec(arg_temp(*a1));
+        TCGv_vec v2 = temp_tcgv_vec(arg_temp(*a2));
         TCGv_vec t1 = tcg_temp_new_vec(type);
         TCGv_vec t2 = tcg_temp_new_vec(type);
         TCGv_vec t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
 
         tcg_gen_sub_vec(vece, t1, v1, t3);
         tcg_gen_sub_vec(vece, t2, v2, t3);
-        v1 = t1;
-        v2 = t2;
+        *a1 = tcgv_vec_arg(t1);
+        *a2 = tcgv_vec_arg(t2);
         cond = tcg_signed_cond(cond);
     }
-
-    /* Expand directly; do not recurse.  */
-    vec_gen_4(INDEX_op_cmp_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
+    return cond;
 }
 
-static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
-                              TCGv_vec c1, TCGv_vec c2,
-                              TCGv_vec v3, TCGv_vec v4, TCGCond cond)
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGArg a0,
+                           TCGArg a1, TCGArg a2, TCGCond cond)
 {
-    TCGv_vec t = tcg_temp_new_vec(type);
+    cond = expand_vec_cond(type, vece, &a1, &a2, cond);
+    /* Expand directly; do not recurse.  */
+    vec_gen_4(INDEX_op_cmp_vec, type, vece, a0, a1, a2, cond);
+}
 
-    expand_vec_cmp(type, vece, t, c1, c2, cond);
-    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v4),
-              tcgv_vec_arg(v3), tcgv_vec_arg(t));
-    tcg_temp_free_vec(t);
+static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGArg a0,
+                              TCGArg a1, TCGArg a2,
+                              TCGArg a3, TCGArg a4, TCGCond cond)
+{
+    cond = expand_vec_cond(type, vece, &a1, &a2, cond);
+    /* Expand directly; do not recurse.  */
+    vec_gen_6(INDEX_op_cmpsel_vec, type, vece, a0, a1, a2, a3, a4, cond);
 }
 
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGArg a2;
-    TCGv_vec v0, v1, v2, v3, v4;
+    TCGArg a1, a2, a3, a4, a5;
+    TCGv_vec v0, v1, v2;
 
     va_start(va, a0);
-    v0 = temp_tcgv_vec(arg_temp(a0));
-    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a1 = va_arg(va, TCGArg);
     a2 = va_arg(va, TCGArg);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(a1));
 
     switch (opc) {
     case INDEX_op_shli_vec:
@@ -4122,15 +4140,15 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         break;
 
     case INDEX_op_cmp_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
+        a3 = va_arg(va, TCGArg);
+        expand_vec_cmp(type, vece, a0, a1, a2, a3);
         break;
 
     case INDEX_op_cmpsel_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        v3 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-        v4 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-        expand_vec_cmpsel(type, vece, v0, v1, v2, v3, v4, va_arg(va, TCGArg));
+        a3 = va_arg(va, TCGArg);
+        a4 = va_arg(va, TCGArg);
+        a5 = va_arg(va, TCGArg);
+        expand_vec_cmpsel(type, vece, a0, a1, a2, a3, a4, a5);
         break;
 
     default:
-- 
2.43.0


