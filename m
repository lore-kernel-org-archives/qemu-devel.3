Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022C8ECE579
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dV-0003ID-7l; Sat, 07 Sep 2024 22:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dS-00037c-W8
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dQ-00050T-UE
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:42 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d89229ac81so2563991a91.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762400; x=1726367200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/08vmd3pJmcPxGI9Dvd5g1DO6IpTA5tvF/u1ewyB0/g=;
 b=ZwcQSX6hYoooENeOkNk+rGAFIrHe7ICOmu/nwW3D5or/ppm73uzzz7eD6pjqnxgy2X
 kzPilsGxzaLFoOUh8+pQ2Guwnt31ODE4l9kCIv3zL0zk32WaWuP+SUrDgDkslOJUWmpH
 fD9AGwZQPXymsmhYeqQj3yq/2gh172xFKlQBeKeA44ENKjc06cwukRayXoMIecobB2R5
 b/sSfMD+8KWgHYbllzn4NNSlgrfaYHcs+uZlyeyVm/4SRhXBdXhZbjbkxHRQFJ/d2meb
 VenJFeSSUSekheNxkVM2J14uUy9nWp9shCe6qhjZLiiT+IOln14yK6rl5UrXOk1GB6gQ
 TyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762400; x=1726367200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/08vmd3pJmcPxGI9Dvd5g1DO6IpTA5tvF/u1ewyB0/g=;
 b=cncUt62AO07tEH4sAOamT/xYdBr++k/bKO7gUnWjbXNHHG4VD/eMCDnaKyh6yUHEt2
 Lgf9QheOw+1o98aOsSEOGgcrCaoCw4DmVmxyytsTe1xWk24m/+oJHDBEZmSKMZdnlgsU
 n2PRijNmXLBMIN78pGArI0/KZMXybeO4jn5563oSHeOdxdmjFImYzL6mlAFLQOqZu49e
 YLCwvTbrVPksM1W1YB9xDhN5Cu7xFZn3LFkEpPP2ZS6fEZza6SQaI6TWAQd4h8jsxMb+
 TuaWPW/66ttV+gUYHTSg02ysiCkEdnlH/c6khDWlFHiB1vkHxjKnTAbHfYhA+Dxz2r+b
 BCPw==
X-Gm-Message-State: AOJu0Yz8yH88ULAIHSFvq8qLoytKg2ZXcHcJ5K3U8zcMishurjfczPQB
 1ztaFF7gH1bzhRugDLyTLEvd1StWrgVh6axBiiN+pRABJdOYB9OMm5XBH8EWHfPpr7sWWgvkVPz
 B
X-Google-Smtp-Source: AGHT+IExLPw53HHUSVt5VYdyPs0TuPFN+qapmf43dDBeVnfCwItHNuWzkRH1oxbAmcG8oCNs+nr7CQ==
X-Received: by 2002:a17:90b:3b8f:b0:2cf:f3e9:d5c8 with SMTP id
 98e67ed59e1d1-2dad50d0d8amr8830659a91.31.1725762399523; 
 Sat, 07 Sep 2024 19:26:39 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 05/12] tcg/i386: Do not expand cmpsel_vec early
Date: Sat,  7 Sep 2024 19:26:25 -0700
Message-ID: <20240908022632.459477-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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


