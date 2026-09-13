Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3C4C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a85-000111-1V; Sat, 12 Sep 2026 22:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7j-0008UV-P7
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:21 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7c-00013K-49
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:15 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso1153460a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267150; x=1789871950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jFX01ENVdcsSqsv5TxqyE3fYuH4S4Ov7GwQYoUBAIh4=;
 b=d4T9IM5dg9aB1XMDH0AX2HE9TbTLhyRKEBpLk2HRV+66yoGSyMf+rAwE9moWB0nJWQ
 hTqhimr80PAPsm3eMek9k7FxFFCMINsKuIbsnwqOkG+NctPCiR0aRtLF8/yyDwy2O+md
 cbZ4gEaZiZctSgX66P2mQNe9dyW4wUpAGnk9zUc0QRNS9kL6V3dypTh3lqPY4wUrgfzq
 tBV8o4XOOvv+UBPipBbiZ9kSU//Vu6Z0/bRWlq7f23qICVRB6fYiM3eBcBymCkwsIfmM
 34q3GL3sH7QsBLfC9H5IofjlYVzn3uyLGTb73HLnzVhuSsymDeN1fXYnFzxDa814488B
 2+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267150; x=1789871950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jFX01ENVdcsSqsv5TxqyE3fYuH4S4Ov7GwQYoUBAIh4=;
 b=Up8OvHDVNHjvhGS606F8NUEQY4Ne4wlFMr0yi2L6X9UlcK7ArD6Lmu2Q7eaSmjZHi8
 JKejlGpQwpLmiSzuJHe9XGo+y9rOYK8zvMmeKWl40U3Ptnte2G0HgZEEVV6kMnUSyiaQ
 cRMQcsbAQbMGjU6SdmxdNBHixxQE1BME8951qQ/odsaH/tu6qjSkpHfvjagg0pdEAjzf
 SGG92ftSZuMCQjJpKBdK2tm4YFoygKziO23PRxCj8RUPAhsuM2qK5uxJnhCd3OPJFLBT
 ZML7mKrKR0q2j08EUND+m7XXHl4Ul5l7anQUxgEyh9mYQMXr0Rn6AMiNsf0vL/tbX3PF
 YGvg==
X-Gm-Message-State: AFuF++moKTkQq/kfFw7hEu2CuCuO03xYOiHsmsuKnaiPjrcz3+ivZ7y1
 DIYYq0sJydb1rrfqRyMORkd0youih2f3D4+lrQsXz/exCkVRvh5NQECVRFJBnHk8OnVBtndhUP8
 TdKAxN2s=
X-Gm-Gg: AYBFou1fLM6M94xeNOJ4kYWs90e1+i3UCdoynbMhXLGb4OtIdkMvThlFBFlduDu3HvF
 /SZZDdbxq/Yg3rLZV3Eqo7seY4OrRnt6Mp/MzRt2GweyWmO5Jv9S4/G6vaAxkL6yJyyKkybRyYu
 IQFsoabSTs3najRLs6k5IvypeblsDt7zsaKwpJB0PO3SSxPpTmDbKzSGyG8QWqhrp+018b7l731
 8xVHv6En+zEY8ZtjBrJe37NBj9CaOKew4xhk8fwcNJM1BGMYQk4QRAfF+pepq6yuvxeys2xQzTf
 qf0iXnEWkOZnS1PTNXM99ZGRmr/mKjD8SviXzvvQaYUCMs+B1fW6AB5Z/mxZmZourqhqUXbGS1N
 GobGsBTVmVXBYo9nBszatnQaNsORM1QLUcgHQ50afm9DWvNnaFhv0/qsjIO4ep50axKdPumyXxq
 WzbaI2WTMFeCt8U0+hsq5VtKwtn389koc7qTxz251E/y+baoCPUDK40yTUpHPTVrDFK3Tq/Ljtb
 JtjFroDsohAAn+fhA==
X-Received: by 2002:a05:6a20:a128:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3daed19f362mr20957305637.9.1789267149535; 
 Sat, 12 Sep 2026 19:39:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/86] tcg: Generic expansion of tcg_gen_not_*
Date: Sat, 12 Sep 2026 16:37:37 -1000
Message-ID: <20260913023837.741866-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 28 ++++++++++------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fe3519305ef..f01d30f18ab 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -203,8 +203,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
-
 /* 64 bit ops */
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -258,7 +256,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8e97c1b37d8..20007c90680 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 352b73148ea..826553e4476 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -484,6 +484,16 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_not, type, 0)) {
+        gen_op_tt(INDEX_op_not, type, dst, src);
+    } else {
+        /* Do not recurse with gen_xori. */
+        gen_xor(type, dst, src, tcg_constant_internal(type, -1));
+    }
+}
+
 static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -583,15 +593,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1843,15 +1844,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i64(ret, arg, -1);
-    }
-}
-
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


