Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B23AC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKd-0002n3-Or; Wed, 16 Sep 2026 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK2-0001mC-2p
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:10 -0400
Received: from mail-oo2-x14.google.com ([2607:f8b0:4864:31::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJz-0000WE-NB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:09 -0400
Received: by mail-oo2-x14.google.com with SMTP id
 46e09a7af769-805bf8c2661so661819a34.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563906; x=1790168706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hqIvAs01/tzFxnPBUZbWfplwXnefzCiy3X4W6ix8rE8=;
 b=zp2lFmCZZ3tcigInJk4chxONPZh6zt3jgizQ+U98eGwLoQSjG+8oZsJwHjIlJQbmBH
 9/n0aoVR3wbF6kzB0/wWNiLJ+NqmH1UmgPts6t5fjdR8j12znHO5q8qd72dgp0E40CSP
 gu6/ENBZEibLpx02LtyGnTEiQlt2fv4bS/Y5LejyAYoBjo5SU3jXhQs0HyN2O87ruyYD
 JDXqQuOx9YflbnQ0BFwQ7Ak5TsHbKYkdPzQy+3zZ699vES4funM7JgRbrHt6wVnQzcnB
 gK8b00Yp6WxDWIo7rHWXafuFo6t3AJiJHPOmz5Z5KjAyAzl7f/2Se3lzUToEF7IwgXP3
 cdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563906; x=1790168706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hqIvAs01/tzFxnPBUZbWfplwXnefzCiy3X4W6ix8rE8=;
 b=RyMN1g38s2tIimQ5lFkJnmyGiSKmfOkLXJhn0MKJS0yG/4A4b+i0Gzg4+bDY964C/i
 TgtfQDBa6YVJZxKbmA3KdrhMnXy6oJDRIoyUtsBruZhlGCZNDiR0qO0b6nRGvksJzuFy
 B0h9F4b8bBRDCjtvvVfSiHCZyG6itXRQwxqtFNlUuNvB39mLw5LmJAMOYZaC32u3ZYU4
 2hzOT0zblYjBRYPQOIQjKUTzyBGwwc0Jv6p5VVhjMMhfItTYf35caSnTbpk/j9i9Gh0w
 nqdu1Bn+er+bOLxF1mmi2YOeIxm/qgGL7Ml//QENhoX+RlXv++D9HaxKkcFiwEa8HxGx
 sLUA==
X-Gm-Message-State: AFuF++kEtlKb+K4OPaFVeL0hVrcTvvPPg4us9Qr0CPLruGkg1H52KE1N
 oOy4rbrx3dhaJ5bW8BhuqCcMYqoMI1ADLaQ5krYB0XUHZjQyn8d6bp2Y2YWq+b+UQkYAWpLhwRe
 ArI12cqc=
X-Gm-Gg: AYBFou3el3t0z93OgXtMN0INsiSU4vHiA4tR3iokIRSgV3/FOnkLbsHLkwBNE8wC0gq
 wVm7HwN2AXNmstCK6cuv/SWPAY4SnqW3O1UnIoqSlh/jKuiqKTEXCUwX5SDQZwDXjn/mNyqtpqw
 5UzgUn6Xk0ugjL/kWFmpsYTm0pjBuBv2+R6mXuevPOy+AqtayK8wgVGWSMinST+d0OakjidswC/
 tE9qWrd1MtJspM7nFio9RQ1E/pZYs9g9cXScZdiOLVcCwLEGF91A3OFb3zNmkJP3P/uXF7gz5V2
 FzXczHr2prN/yPOtmLcJ+Lz8uyGVO56knoqyyBPBB1CxJjyabvsWExl7TC3BV9EfvyCvNZj06H+
 3/SHAxkVy/oKYWDZic5KjZ4xedCu+UjT2h9XpEOhZFkFcoKqk1MobvxrZDrLQCazzF50F7OGB/X
 Bg6o0JRC6SNZ4Wg8UjYKY2vnDninBcLLTlhERUen/H1ZGhNfyn35ZKtX9KQTEI8m92rNSUuKy1/
 HM2xB0=
X-Received: by 2002:a05:6820:820:b0:6b7:46fa:16a7 with SMTP id
 006d021491bc7-6c7d4cf4cd5mr2324675eaf.60.1789563905823; 
 Wed, 16 Sep 2026 06:05:05 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 34/92] tcg: Generic expansion of tcg_gen_remu_*
Date: Wed, 16 Sep 2026 03:03:09 -1000
Message-ID: <20260916130409.3382710-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::14;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x14.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 75 ++++++++++--------------------------
 3 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 05b4bee34ce..f0572df01cf 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -202,7 +201,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e67f11176d8..cffbb4d08a8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -16,6 +16,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(rem, TCGV, TCGV, TCGV)
+DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cf6904623f0..94cdf7a3c75 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -236,20 +236,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                        tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
-}
-
-static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -571,6 +557,27 @@ static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            TCGTemp *zero = tcg_constant_internal(type, 0);
+            gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1, zero, src2);
+        } else {
+            g_assert_not_reached();
+        }
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -710,26 +717,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
@@ -1590,26 +1577,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


