Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3038EE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYV-0002AH-L5; Wed, 11 Sep 2024 12:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYT-00021z-Bq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:57 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYR-0003eq-C2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:57 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso44836a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073454; x=1726678254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9crvsERH/myYSJkgKez5YbnhkNv578itQ81kZkhssYk=;
 b=Z3H0ie0Y/5S2XO/J2tqaomsBf9dDnAdkGTuhd8BBhvA51efiSADVVg+0ip34Z8y6al
 PNJQJoovdhurwRNTLzaOwKS+9Ns1CBATROdIBoI2LbcrewgeXzKp9XWLPPnxIVqf7EcK
 ghge81Xv7VqTtm0FkolJNanPYEQdmEgXqs+AcXj38VXhux7zxs5OgZRdEIQeDKLX2/TP
 jpqGDpQn4vIEJQI8ynijQgN4+BZ9hlaWm17tBrQD1W60BXAPzzN/T8F5JjpEJNtwOBbj
 OMDki8T4xb0ZsNCqjnm8Nbcw3kCuKtqXB6a78wuRZQRH20AqKO3eUK9StTKbcMgqTn2I
 oTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073454; x=1726678254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9crvsERH/myYSJkgKez5YbnhkNv578itQ81kZkhssYk=;
 b=m7/AWcmOiGsCsyIVa2D29M+jVU+vB4XtV8tLgSFbiEse4uvYdZ8g54p0moBnq2pEA7
 UJCtKIDkKPqcQc4qjBriF3eynANVbO5eBc8i/8a6aGliLSqvIQDXbuf1xvqLTQxy2eHe
 EFWZ+pBUDdAspayzp3ugjxHurKKlTjpRSixKs8C2FkhgjbTkrOPUiPAGKXprHaOW0P0a
 8j7N9XXicm6OT4H2Mf5KFFdgSBYRrJgHEkDc+d2XucipOlzLHbGfvY9HHDIIuNyKb097
 tFDbbtF/pT28UoYlqnbjYnyYgvU9se1y4LRPpxVa6fOMk4DXJZdc//Tkfa+IXi+83RSE
 I++g==
X-Gm-Message-State: AOJu0YxrkkJtR44rKw8/3cgYYubQQTp7+GRN1Q9x/8ddtI3gpKGW1pDO
 2AANCzg+A50/Hq/EYC9JU56/HXpP3jjnUkm6JwKcDOKrw0VRMI7DO6FOT8tbzbRIY7hr6lLJ+ly
 J
X-Google-Smtp-Source: AGHT+IGu+J62BcE1uGscyzU1511se5adC1H8xAkhtv3svJuPWSPxr10+fvKM+UCnUBaGX1mnx4RgNA==
X-Received: by 2002:a05:6a21:4a4c:b0:1c1:92f8:d3c6 with SMTP id
 adf61e73a8af0-1cf5e143e33mr7139906637.27.1726073453629; 
 Wed, 11 Sep 2024 09:50:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 05/18] tcg/ppc: Do not expand cmp_vec early
Date: Wed, 11 Sep 2024 09:50:34 -0700
Message-ID: <20240911165047.1035764-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Move expansion to opcode generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 169 +++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 79 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3553a47ba9..497e130581 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3567,12 +3567,13 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
         return vece <= MO_32;
-    case INDEX_op_cmp_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
     case INDEX_op_rotli_vec:
         return vece <= MO_32 || have_isa_2_07 ? -1 : 0;
+    case INDEX_op_cmp_vec:
+        return vece <= MO_32 || have_isa_2_07 ? 1 : 0;
     case INDEX_op_neg_vec:
         return vece >= MO_32 && have_isa_3_00;
     case INDEX_op_mul_vec:
@@ -3713,6 +3714,90 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static void tcg_out_not_vec(TCGContext *s, TCGReg a0, TCGReg a1)
+{
+    tcg_out32(s, VNOR | VRT(a0) | VRA(a1) | VRB(a1));
+}
+
+static bool tcg_out_cmp_vec_noinv(TCGContext *s, unsigned vece, TCGReg a0,
+                                  TCGReg a1, TCGReg a2, TCGCond cond)
+{
+    static const uint32_t
+        eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
+        gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
+        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD };
+    uint32_t insn;
+
+    bool need_swap = false, need_inv = false;
+
+    tcg_debug_assert(vece <= MO_32 || have_isa_2_07);
+
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_GT:
+    case TCG_COND_GTU:
+        break;
+    case TCG_COND_NE:
+        if (have_isa_3_00 && vece <= MO_32) {
+            break;
+        }
+        /* fall through */
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+        need_inv = true;
+        break;
+    case TCG_COND_LT:
+    case TCG_COND_LTU:
+        need_swap = true;
+        break;
+    case TCG_COND_GE:
+    case TCG_COND_GEU:
+        need_swap = need_inv = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (need_inv) {
+        cond = tcg_invert_cond(cond);
+    }
+    if (need_swap) {
+        TCGReg swap = a1;
+        a1 = a2;
+        a2 = swap;
+        cond = tcg_swap_cond(cond);
+    }
+
+    switch (cond) {
+    case TCG_COND_EQ:
+        insn = eq_op[vece];
+        break;
+    case TCG_COND_NE:
+        insn = ne_op[vece];
+        break;
+    case TCG_COND_GT:
+        insn = gts_op[vece];
+        break;
+    case TCG_COND_GTU:
+        insn = gtu_op[vece];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
+
+    return need_inv;
+}
+
+static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
+                            TCGReg a1, TCGReg a2, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, vece, a0, a1, a2, cond)) {
+        tcg_out_not_vec(s, a0, a0);
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3723,10 +3808,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
         mul_op[4] = { 0, 0, VMULUWM, VMULLD },
         neg_op[4] = { 0, 0, VNEGW, VNEGD },
-        eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
-        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
-        gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
-        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
         ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
         usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
         sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
@@ -3820,9 +3901,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = VANDC;
         break;
     case INDEX_op_not_vec:
-        insn = VNOR;
-        a2 = a1;
-        break;
+        tcg_out_not_vec(s, a0, a1);
+        return;
     case INDEX_op_orc_vec:
         insn = VORC;
         break;
@@ -3837,23 +3917,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_cmp_vec:
-        switch (args[3]) {
-        case TCG_COND_EQ:
-            insn = eq_op[vece];
-            break;
-        case TCG_COND_NE:
-            insn = ne_op[vece];
-            break;
-        case TCG_COND_GT:
-            insn = gts_op[vece];
-            break;
-        case TCG_COND_GTU:
-            insn = gtu_op[vece];
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
+        tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
+        return;
 
     case INDEX_op_bitsel_vec:
         tcg_out32(s, XXSEL | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
@@ -3921,56 +3986,6 @@ static void expand_vec_shi(TCGType type, unsigned vece, TCGv_vec v0,
               tcgv_vec_arg(v1), tcgv_vec_arg(t1));
 }
 
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
-{
-    bool need_swap = false, need_inv = false;
-
-    tcg_debug_assert(vece <= MO_32 || have_isa_2_07);
-
-    switch (cond) {
-    case TCG_COND_EQ:
-    case TCG_COND_GT:
-    case TCG_COND_GTU:
-        break;
-    case TCG_COND_NE:
-        if (have_isa_3_00 && vece <= MO_32) {
-            break;
-        }
-        /* fall through */
-    case TCG_COND_LE:
-    case TCG_COND_LEU:
-        need_inv = true;
-        break;
-    case TCG_COND_LT:
-    case TCG_COND_LTU:
-        need_swap = true;
-        break;
-    case TCG_COND_GE:
-    case TCG_COND_GEU:
-        need_swap = need_inv = true;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (need_inv) {
-        cond = tcg_invert_cond(cond);
-    }
-    if (need_swap) {
-        TCGv_vec t1;
-        t1 = v1, v1 = v2, v2 = t1;
-        cond = tcg_swap_cond(cond);
-    }
-
-    vec_gen_4(INDEX_op_cmp_vec, type, vece, tcgv_vec_arg(v0),
-              tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
-
-    if (need_inv) {
-        tcg_gen_not_vec(vece, v0, v0);
-    }
-}
-
 static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
                            TCGv_vec v1, TCGv_vec v2)
 {
@@ -4045,10 +4060,6 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     case INDEX_op_rotli_vec:
         expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_rotlv_vec);
         break;
-    case INDEX_op_cmp_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
-        break;
     case INDEX_op_mul_vec:
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_mul(type, vece, v0, v1, v2);
-- 
2.43.0


