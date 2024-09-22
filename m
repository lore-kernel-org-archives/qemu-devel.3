Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1D7CF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHv-0002cy-DW; Sun, 22 Sep 2024 08:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0000vr-LU
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHG-0002NB-IA
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:24 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so757456966b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006479; x=1727611279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9crvsERH/myYSJkgKez5YbnhkNv578itQ81kZkhssYk=;
 b=nEj1DJC1INVRdgnKT1men9mfrWfVQqpfhmbehp4ls69BkVzK60SYN40hpt+KV1WkP/
 ilnGluhNSJtiDbBTx+99GsxL0IuWf7NMRn/gG9f4vRWXBWAvp04oZWCABJBMzLErW7DD
 Qv3IqK6yoss1h+95olB4Zjo8GItNqJd2EXnkfpigXYR0gAo/X2Rzn2PkJ3U5QtkGaLJq
 5BpPQuTnT2e8HP8efnrU4+C30uBBOer8t+uzNWxTaG0P58+NckuyUocu6KfbosI1k0d1
 G5Nr4MeNYIEcttcqPbURlqxHTBz8SYFEpMi0THY9RnIM1toNUHV5UYoye43czqtDqsc2
 Iyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006479; x=1727611279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9crvsERH/myYSJkgKez5YbnhkNv578itQ81kZkhssYk=;
 b=LKCy8nose+sXM+FEux8vCk0wHpSlEgumWFeR/I+AZg/TOKXqaiCLl9bTCOdoCeCNDX
 YzRi9JWqH/SYhibgIKmLaGw/jwxTM3XmzoXE9lhIP9154RyM2Es1RHxLWcMfKOBQtzXN
 +jEYlRMbDtplk+zMAtFgKnTtXGZGiiirX/nBA5XEXplHi73X4adDNh/Eklks9F67BptN
 UWbrVQq5tmWEbGFPNrjBFAevqhlW4P3QQ1T86NMpHaybwfNVVpjMiJwkJ+oB2MATC4FP
 ntWhuvFbH/mFdvCms2pW2y9DEmp+VgmBWYBjaRvcmJfJv45ThgJo1nk6FP2mPpDr3j/t
 7UHw==
X-Gm-Message-State: AOJu0Yz9AH7sZoUFoIJAoG29p2eVSOwi4L6GD5NsYfkt/5+SjpNop6RC
 jLRL3JKsjuNpReY5x3vmKs0t9IsPyIGqnLkHXhI3BVqcDSG09PwNi2wdjr8svnW91xzrgdIWkGj
 e3bA=
X-Google-Smtp-Source: AGHT+IEmMDiLreua1cRIs6Dh31cOvWxeordWWO+dIZkXv3NLbB/cKlUv/3rqzwC5SkzS3Vxb972lhA==
X-Received: by 2002:a17:907:7288:b0:a8d:4c83:d85d with SMTP id
 a640c23a62f3a-a90c1c77fc6mr1486526666b.12.1727006478541; 
 Sun, 22 Sep 2024 05:01:18 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 08/31] tcg/ppc: Do not expand cmp_vec early
Date: Sun, 22 Sep 2024 14:00:49 +0200
Message-ID: <20240922120112.5067-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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


