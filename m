Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94692C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkqk-0001gH-8A; Sun, 27 Sep 2026 05:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknu-0004ds-HX
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:14 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkns-0007eE-FN
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:14 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd53691be5so14197345ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499851; x=1791104651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x41GysWdsxkz4nzILMihHGD3RFvkb2qmv+rDm46YFHs=;
 b=da5/sYJcIOYVYiTIFG1spM/eCZroHIUMO16w+te8Phi6EMfMlx/NMfaCaAhP1iYK2z
 32RGa7YN9JXsifqarBH8ZytLV+w/b1W9nrW/S15QxFz3e87Cb2Jy5RBI8Maq9gxhQSwG
 blquO8vz7cVaXSwHWJKB3ml6NDKMIPyj+CeMeJZ0g8Jf7/fpwei+h1Q4ChT/tfM5Wuuw
 mhTVhInjvlzGg8HzE/kFKTEjTnbhZ8eAgHvm+BOSFGyeykuhrhfBiXoLXw4nINYR72W3
 pMWGHL6XBKNBiI8mEzekTsi5TB3DInV0zvNm5HsEbOPyfhjZp7HUlV7OE0+b2QUSlPNV
 +zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499851; x=1791104651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x41GysWdsxkz4nzILMihHGD3RFvkb2qmv+rDm46YFHs=;
 b=RVmGIub1wPO0YR7tq3m5Dvhz8z99J6xOytTyOWkEnn2JqIcEqfuyBZcYEr3BbOKuso
 /OydUEIKKXSVbssDjOp9CojvOaGJxNllvJD2XzSrDJH2s4+t4hDQw6a6x6TWQvIKudd5
 qHZP9iC4B0xZWNGAUJbuG7eCTkyWs/gGrlqWkHKU0M7mnYmsFiq8FPxZGlVJhWx3jned
 5WPZP2jyLqN3i8gFtAXP7rqszydHj276g0bC7yhOlmu6RAeBUQ+dSibz0FF6q4OeG8Ld
 VIeN6iDcvjziKrNKU0YeMF7BnbATX2b19TIUh4W8fM6lPUDv+dRVq5gVZcfNpCxMJQNi
 Cxaw==
X-Gm-Message-State: AFq9FYKpx3deQbp+n6y02W72NO9/tMEa8s25jpNAZZ9ERr5V6FRnOFH6
 A5pIObW05ds9e11ULbJp3VEx3s6l3fMNe+BMk25+Xk1dltaX2LP8NW5R4mvpOtiKYWzd97OOmSL
 YLWob
X-Gm-Gg: AYBFou3yv5Cr28ApS06IfBCP2HHf3ibpYc+V9080Yp1iTZRRpBUWRjx8b9iQAiV73+x
 +XTI77OeXs23IHuSvH2Dgn5XLMDGsSA4WE6HhQBNMY4A5IkT/5jFLHiXYQPOuE7mCRq5f8IPwmE
 qh1dR499aENHjDvryqenXSNiHVdQ7LvRgX2zOxRRAUUPOe4cbC7MBLiwoVYRU7wPieyWyhEOD3S
 2EHGwTkf+L56k8TSyyaMBozOVmzQWWROjI+e9aAno8POtaaj1qw3YRmLyEhAXEpDvxSPOktENzR
 PYXq6g/qrcK4/IciGLh+xHqfZ1xnvvrGRFcAO9A89IjT1gQP6Tlmm58aDw6I7/1VnBvgrh05SmR
 kRN4M/38TT7AF7J04ptL1x8Xb6J5pcqLPO9Xn8DJD+n7HB/7SK2C5GAp1u2LC8XfTByLM1LlFZU
 PyfdQ5hpFMtAQ9sPSpyZEi/K/lzmhDftroOckPOi14R7Kxex9c/m/YL1W428gdZREGK5U+lK1PO
 kCEncyQnUl25ml5KtHsleGppBntMg==
X-Received: by 2002:a17:90a:d445:b0:3a0:f0a4:a2c7 with SMTP id
 98e67ed59e1d1-3a0f0a4b04emr1992214a91.20.1790499850804; 
 Sun, 27 Sep 2026 02:04:10 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 055/101] tcg: Generic expansion of tcg_gen_ctz_*
Date: Sun, 27 Sep 2026 01:59:25 -0700
Message-ID: <20260927090011.10724-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 115 ++++++++++++++---------------------
 3 files changed, 47 insertions(+), 71 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7f977661b3d..94c2a3d1682 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -187,7 +186,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 66977cada1f..2436fea04dc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
+DEF3(ctz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 86dae114859..1c0c1566d92 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -467,6 +467,52 @@ void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    g_autoptr(TCGTemp) t1 = NULL;
+
+    if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
+        return;
+    }
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        t1 = tcg_temp_new_ebb(type);
+        tcg_gen_addi(type, t1, src1, -1);
+        tcg_gen_andc(type, t1, t1, src1);
+        tcg_gen_ctpop(type, t1, t1);
+    } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        int width = tcg_type_size(type) * 8;
+
+        t1 = tcg_temp_new_ebb(type);
+        tcg_gen_neg(type, t1, src1);
+        tcg_gen_and(type, t1, t1, src1);
+        tcg_gen_clzi(type, t1, t1, width);
+        tcg_gen_xori(type, t1, t1, width - 1);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+        return;
+    } else if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        tcg_gen_extu(t1, src1);
+        tcg_gen_extu(t2, src2);
+        tcg_gen_ctz(TCG_TYPE_I64, t1, t1, t2);
+        tcg_gen_extrl(dst, t1);
+        return;
+    } else {
+        gen_helper_ctz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+        return;
+    }
+
+    tcg_gen_movcond(type, TCG_COND_EQ, dst, src1,
+                    tcg_constant_internal(type, 0), src2, t1);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -775,46 +821,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    TCGv_i32 z, t;
-
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_ctz, ret, arg1, arg2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_ctz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        t = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t, arg1);
-        tcg_gen_and_i32(t, t, arg1);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_xori_i32(t, t, 31);
-    } else {
-        gen_helper_ctz_i32(ret, arg1, arg2);
-        return;
-    }
-
-    z = tcg_constant_i32(0);
-    tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
@@ -1676,35 +1682,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    TCGv_i64 z, t;
-
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        t = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t, arg1);
-        tcg_gen_and_i64(t, t, arg1);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_xori_i64(t, t, 63);
-    } else {
-        gen_helper_ctz_i64(ret, arg1, arg2);
-        return;
-    }
-
-    z = tcg_constant_i64(0);
-    tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
-    tcg_temp_free_i64(t);
-}
-
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
-- 
2.53.0


