Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3158BC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pK8-0001oB-Kq; Wed, 16 Sep 2026 09:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJu-0001Ir-9z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:02 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJs-0000TT-H6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:02 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43ac6072so9270287b3.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563899; x=1790168699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EjC/hgEAHyg4QeR3ltbofy/cVH5NVRwoIGMREd1s2Ew=;
 b=rhfXux/IZyeXhUMIeFzzgql0PeylkF+K2FoTe2kkICIiJCiMPqgtuKgft2/XaDhc0E
 rUACCax9eUedu1JdDuFZ4MdumSOGMvS7PInvz1cf5Q46nnwwxcvROFtg7KXO/gyTbrx/
 2cmMB0/uQjbqnU81PUj0xSIZRSbE23bIf5qmpuNEKXolKLKjgmndPrgeK+e2OAqGlshP
 WbYwSxH8jChTHmg0kbXUbPCJyhkXajgFuqx8D/r16CpHABxnaJyMcarAB028HFvtWp+u
 UJ7aD3NMiYjFOX/qvLle5SmYrLGysC26aeT53XnMH8Bhy/1BO54Ne9XLKyxlaNyffkim
 46uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563899; x=1790168699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EjC/hgEAHyg4QeR3ltbofy/cVH5NVRwoIGMREd1s2Ew=;
 b=LhQT+n+wm3kpKiGnXgnz1hsSlyNJHHhVW8iRmU4U5oh7tc1CppKSnU45tafOpzIckv
 +y+5SoqxhoHF7zfHsJBNbow0l2+NTJ1z3XiYxapYM6bDLWZ8v3rGg2aMlry+rmkT/IuR
 GTpfMNRMERiVKr2IhO7Jo8RoieWwGHNcB+g5scDv8EM+4W7e8YNilvIObZGlerDAnWlA
 kaGWAfR0S+g1VZjDUdw0+v31Wi6WizRpwHXFOof+L4EP5g/ZomeJJ6ITutiGemk0McJo
 cbRUg8sxBgU8FVLrBlSqeE96/od2EK4I5ISjB49kN0XT+iCSJ6Sy6Z1W9S0Ej2wbhDMF
 KPYw==
X-Gm-Message-State: AFuF++kGPUHIY4MJRM9iEd80MYTzmFFToVW+u+MnKoh/8YQt7S2VX3LQ
 brkW09Cm+0Zn7L6LtOJNHsDjIy0p+AhRzLOj+VNsHWieHTb2u8PGP6WUsFYazv8XYNqqPF85lD6
 0URZj0SM=
X-Gm-Gg: AYBFou1sfKfHAu56pPAL66y5L1j82urrihmu6YsE/leUtbCmm6UI+NeytMvhrRgDqFY
 FynUVPAdeSgkobqCvxtiFhPM+kc0ZnVOnYzebg/T0xfyOGVV4BCyiOGarK3NRgQSJcbPnaKxEoh
 zc0BE/SW61MuBPog/l057xsvAQYhjiOctKGgUVoevN89+GhmeND7z0EAClSIg2MosS3LRoigKXo
 GAXbpazF82hCrgxC9HSc1aSSx4cbIV8QyfJlUcrZYydV8csnYcBY7ze2SztiyOP64x0JFvoP91G
 rm/PcCktB2aWCIldkMYlXZGv6rW7QcCnCV270NPYkEV+dGSAA/1hHIr+ITfm1ZKZFmXutt9xfcq
 VMhMfTghUgxFsRUr3b/jQA9rqKKr1uaBjJOuVlUfnOZBu/o/8CcRGNFeEKOFjByNmhkrqI67IRO
 JTQP7GjsLyAHV0aQcNLUs+wbUl3CLxfMmzEcvI1KMVCFSiVoMsWQajJpDGCHfMwGXwWI/Frd3E7
 RuQlO8NB6P2LoPXgA==
X-Received: by 2002:a05:690c:4f02:b0:873:5c7b:c0f4 with SMTP id
 00721157ae682-892247a988cmr5374467b3.44.1789563899273; 
 Wed, 16 Sep 2026 06:04:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 29/92] tcg: Generic expansion of tcg_gen_not_*
Date: Wed, 16 Sep 2026 03:03:04 -1000
Message-ID: <20260916130409.3382710-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx2-x10.google.com
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
index 25e8d27a54f..a8dffa7c5cb 100644
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
index db47364ce78..9a2626e9669 100644
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


