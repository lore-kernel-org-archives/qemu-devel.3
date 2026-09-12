Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE9BC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1p-0005On-Lb; Sat, 12 Sep 2026 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1a-0004z0-EC
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:58 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Y-0007L0-GG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:58 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so261436a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209115; x=1789813915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N1UsKhc5H6HlCzOHCIISblviteinmdzflT8zjCFrbSA=;
 b=kkgswHHuwysQlq3WJlb7H1BnKC6mQqJriWHpSIHfNz4IM6okkAowUuv73aTfbYtbht
 otmiYcmMnR1mX8Q91qdNWP//u0dVk0aoD+0I4ZpZUrvT4dRTOJs/VMRl/nOPna8U0k5F
 qri9g3hNp2hKPKN7qI5lfBj8N7MN6FdtlEZ29/FNc2fGjNfmPETHuKh62+n6eRkDcwIX
 7DAmA9vpkXI03+rzoAi8fhkldtjzkdLNW/w0gz8wV7RcmcYvBRedbSMx5GOtY1hmqaG4
 oXOAo1KQgK/nuwpBQr87lok+Vp6Saj7x8KWn7uJ7foctNm70AuDJ2c8vziovtuJ6rvk5
 DQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209115; x=1789813915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N1UsKhc5H6HlCzOHCIISblviteinmdzflT8zjCFrbSA=;
 b=ZFgptefn9JIHee+46RFxkaCu1oauB4/k+pS4wYSp6a9Mc9iyjspDjPTUE19bqenj22
 hk0RuzXasXTlgTGem4606AyKMc0tDj2YtnHbgIFfO5XNzoXBHHO6KPdxRWiUYgG3GZSf
 WXZw7V1BYwEqwIzByKImvNZq7tVNuO2EDeV56tzFZN4TeMijkjlC+NY6f26hTEj6FHrP
 XMSXnVUOW/BvF0ROLwgdBXSAtRQpFr+jyLCsZoXTcXsg3QH4P4SfDrfhrmfxz8K9NGP7
 VjFh/wlVd0PgzW3dP2cpGZvfq/1Aw1wjS4oun5cG6d/PRO7Xz2WDpXpl5MLIUK4gDdYJ
 Vmtw==
X-Gm-Message-State: AFuF++lA35dQp75NUcJdywQHK5tQByCyqUFKRLQkojLfhvh8YTCIqPjP
 F66RLnNiFtkzUoscMwdSKHo9fXf4tmUTDxTEgOTlpFth44gFUDHPRCf71cyBITpV5BfHugIYitb
 BDcd2V3E=
X-Gm-Gg: AYBFou1m9Wdd6aPUmY7yuvl/FEWNMfxj3R6GJ6s/fmoP34xPpku7o8rZgJcDDUKNCHK
 DcLygL+UsOiKsJm8LB+HI/Uw4tPqJAvnSUVk9MHp+oGINaYfpa5GS4qotCU8CXr1QoYOjKJotd2
 RUEVs7WiXYE/sau9KSN2+GfsS+PDf1cdFzz17UNiiBEqDKCGFWUyZ8AKC3a5DcTTySPzwAy53RP
 lgWOJ0VxWVdlLZ+98W6ECH0FrcTGq0QvnUthcIcfgxwiuxzu48cjYvs2LMh20SBjzblIZUI4WMJ
 DOHvKeDF0kwm5E1pxNN6yqLQ+sFmj5uEerxiSDf2w0kTgkyKbnLelvm+1SqvmzyM16pHPsIeeAi
 i9WwX2QeQpcEHmQnuOBcnzDEHndd6h4I+7FcTDwQmA77+FNttrXfjQ69/QzONcv8CALkYppAimT
 tAacJ9upU6OmlR4W422A29RPGXcqYqGTylejNt+R2gPwgQQZkY7SF9yL2TxLPH3hg7L8rqh41JF
 UHv4N0=
X-Received: by 2002:a05:6a20:12c7:b0:3c3:7a0a:18a6 with SMTP id
 adf61e73a8af0-3db0e408702mr3963967637.18.1789209114993; 
 Sat, 12 Sep 2026 03:31:54 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/82] tcg: Generic expansion of tcg_gen_div_*
Date: Sat, 12 Sep 2026 00:30:32 -1000
Message-ID: <20260912103126.598030-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 52 ++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4476f9dbfb3..c5f1edd6218 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index e3935b850cb..9ee7db8b60e 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -17,6 +17,7 @@ DEF_RRI(subi)
 DEF_RRI(xori)
 DEF_RRR(add)
 DEF_RRR(and)
+DEF_RRR(div)
 DEF_RRR(mul)
 DEF_RRR(or)
 DEF_RRR(sar)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 26e1d441661..84f06b8593b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,14 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
+                           TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                           TCGTemp *t3, TCGTemp *t4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                       temp_arg(t3), temp_arg(t4));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -407,6 +415,22 @@ static void gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, tmp, src1, width - 1);
+        gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+        tcg_temp_free_internal(tmp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -642,20 +666,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
@@ -1570,20 +1580,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-- 
2.53.0


