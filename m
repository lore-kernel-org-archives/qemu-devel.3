Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B04C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L20-0005zo-95; Sat, 12 Sep 2026 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1k-0005FA-OE
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:08 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1i-0007OC-SI
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:08 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so191946a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209125; x=1789813925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6NvcOui5YvS2MjJSiNzyvCLGdhE2S5tfKkY/psJIW2g=;
 b=wFWKAjC3YbsaIKlDzneHBYEgwE5vbvpPk4tjRpMHwHXRSR0yjHUAdrjG70n3W2ERIN
 da9sGPZJ0I1YcpVerkvwJ3mLuTkYUKqCtACRN8V8sgg7vYkYjdwYoHcGNWlG4sQENLPp
 qJdrl++uiyE9ZYKQJHfPC9W6fx83DbSj5n0XvVASpqXnW/RFw6M1TU6/eTMNMQF8lHRl
 gxTrEBvngxHqmSPBbL5LgSwZSTw4vpbE5NX5cGQTfO7WnogvxSl250kkpPUHtGEz7LJf
 LyXnHMwEmDS3gma16/dZYJ2hMXJG7Fwj8tNEVlHw3CTIZCZjzT+OJXg65Ub63ulUZogg
 qCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209125; x=1789813925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6NvcOui5YvS2MjJSiNzyvCLGdhE2S5tfKkY/psJIW2g=;
 b=TtO3TdSF0JKMxKr2wwc/Swe9r7d/B+TBss2ynPo47iO2yjvHeLNeoN23ui2h9ajBvD
 wK6njclcc2DcybStuGiQLa0dtEFnRCep8GUAzCevH2LhBIs6OKlIhvW9FGXKSErVNvbw
 vJzc0zPgiwDPXyB7Vlvabu3uwrLxnYUB8lDbuSXa/in56QJSJ314tFYtipX5OKHrKoO+
 yCdTmELtXKk0NyWyLt9P24dNZSaSHg2UyH1zhdduEgFACPnSE1soqsYAHFTG3oJ43aq2
 tEqNKD8mgNxr18IHjUqqmYMe6T9KUF41CUxIMcCh2C6QgSp46eM80wmwRfTLKM4/1eKD
 gR7w==
X-Gm-Message-State: AFuF++nwtI2ZZWhvG7m8OwkVuO/eHVZxPMVpGDTPSXurAtHBzPAunXrp
 ZcVR0KJC4Eime0QFaNSWeJTBvYf6Rh7O3oeb98mMuw/nAlg6v1GdGrYTrZmMNukO6JSdBuA57nC
 GdtQdTzk=
X-Gm-Gg: AYBFou3OGwfPC4n2Qo3Rz7vFVkFiMtLpRkdmc+Ez2w/BX0ziKJXDgwjEg5TWer41Mid
 4eZUBguZXshh9gU0Pw595ogenjHxX+UpfEYt0+6QVOJepfzXlCUS32p1b+SH+7YaAai+VFZdN1c
 9ByVCi0FXk2CtG5Yz0eWXJ6tIr558I6BPY0BpwRbDlre5R63Mcv7AsHmEgT+RHr75+4vgsnm7Kf
 w1u7YLeY2LELEci3uECBjtQIF0r4S80rhs6E4ZBqUdA0F2c5IiTuwPeKaYUca+hunTEACtGSi97
 eZk5wBPwJ3RsxukQvG70DSGdVezuoEWw4+DlKlcyAcHDl+CHuakNv7+Cp6Jj2CZRrd1czvS2wa5
 8blpv+Xh3Mw9ulZJj3wGXCTJppHVosBXXsBvkm3v6m30NyDwF1atWtl3OQCnFj4qkynGDalZZgn
 LIXtoC4lHWpaWyzaZqNLBJY/QeVXyYtKgzujez6dfhEXRrVeBJWkaDHiG0vhSu94kwWig1GNWIE
 A7xSGY=
X-Received: by 2002:a17:90b:3cc5:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-39d97ea3396mr7682241a91.2.1789209125354; 
 Sat, 12 Sep 2026 03:32:05 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.32.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/82] tcg: Generic expansion of tcg_gen_setcond_*
Date: Sat, 12 Sep 2026 00:30:43 -1000
Message-ID: <20260912103126.598030-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  8 +++---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 51 ++++++++++++++++++-----------------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b859af38355..9b01acb3128 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -116,6 +116,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_CRIL(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TINT c, TCGLabel *d);
 
+#define DEF_CRRR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TCGV d);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -126,6 +129,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_RIR
 #undef DEF_CRRL
 #undef DEF_CRIL
+#undef DEF_CRRR
 
 /* 32 bit ops */
 
@@ -149,8 +153,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -220,8 +222,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index da15a647e2e..560e7f0394e 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -2,6 +2,7 @@
 
 DEF_CRIL(brcondi)
 DEF_CRRL(brcond)
+DEF_CRRR(setcond)
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RIR(subfi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e1974aac41c..ee6099461f3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,12 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttti(TCGOpcode opc, TCGType type,
+                          TCGTemp *t0, TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -344,6 +350,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_CRIL(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, int64_t, TCGLabel *);
 
+#define DEF_CRRR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, TCGTemp *);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -354,6 +363,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_RIR
 #undef DEF_CRRL
 #undef DEF_CRIL
+#undef DEF_CRRR
 
 /*
  * Generic expansions for templated operations.
@@ -631,6 +641,18 @@ static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -735,6 +757,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
                                         TINT c, TCGLabel *d)            \
     { gen_##NAME(TYPE, a, TTMP(b), c, d); }
 
+#define DEF_CRRR(NAME)                                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TCGV d) \
+    { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), TTMP(d)); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -745,21 +771,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_RIR
 #undef DEF_CRRL
 #undef DEF_CRIL
+#undef DEF_CRRR
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1538,18 +1553,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


