Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDADCC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB9-00035i-Ep; Sat, 12 Sep 2026 22:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB0-0002EU-11
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:42 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAx-0001uH-O6
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:41 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc4d64bcea5so996941a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267358; x=1789872158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a8JDBuoaLheLrEtzXvxl3vBgovMqyHLk+A70ZkdyngA=;
 b=ch0PKEY1xAEtSat2zR4aPwC1MGa493lmv/V8/keG+K86sobIKpqGLwi0LtrJvRjnlw
 tRkju6cbnMAA8zZCFjJtdB16FQGP3+YNFymI97NJ3A1okSJ7Y14A40J1oUtyg2Ri4kIb
 BfexulYhPDpF1sl1Gi4AjEKaNG3leKEpQ9iMZceRT7pc5ETFt2bjVTcZ7/Di9XSLxU//
 eDPouXXypPSuZu6iNAFUzMgPvJ1w7ISONsC12SAzKJGrk/NLqKr4rzQwRmsWsBjgKkQE
 1QfpBCg/lfHVZuerin6BXJqYumtUhHjkppGXFZZKa2JXuTg7wGy9VSkEUefERwPlvwDS
 wGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267358; x=1789872158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a8JDBuoaLheLrEtzXvxl3vBgovMqyHLk+A70ZkdyngA=;
 b=V63uM2PyyIN8s1DfADGn1rI3DyGUqwG8HDRdTCjuS5jhqTDcxaMFsbAy0R5NvHi58s
 VG5s0+ekbJeRJLJQBg0dQVD3yispO4VGCR1yMWlhLKRU7yj46LaQRAJgvCcSeCLfccGq
 uw01GdtB1YPsJDBT0Ob8ReWb2Be3E7vgd51wjhAPyM+68gQt91KTdWRTe9SCdaUlxhC9
 1IAD1obqIstzg+vyM1mbXbAI7RT33uoUuLfKqQYSRQObsYg0mMBz2lD2J+p6ADY15p8h
 vlU4Ju+FWNhF/XXYVz+7/om5fUdXahIzKV75gBHxegsdjwqPy/VetAD/fk2Q2VrDcHXA
 pb8g==
X-Gm-Message-State: AFuF++k61O8hvdd/IlWBNy0PYekVq98GTgiTkP7ZmisVRzOUmUkKjkB7
 hQh8i3ZmaLx+HqvKeCEmVHDqNTluuV0pKZZQDv89sFiAliboooP2naWPJ7aXaIiMbcaKpmA921G
 RAo3F244=
X-Gm-Gg: AYBFou3qAT9fGS3SYy+bf/W2M0cvr1pJTq1f+ZFbPFrtQ5/ZppARQe/CjydsdQM/jv2
 nyOj7VGdHXrXDesI18XWn51FKv6ARdy4gHeFwPBtbl1ZriYxnCgSxzd3qSS6qSmeCnmf+v1CxYB
 ARuqQA+dYLKnJBXPj80fd5kqUyqrmbA5njITGhvNugVfA//ec7uX0mf7mcVewfrleS8IICjT/sg
 zYVK+Wp+RvhfHeDkp/6izZE8R5vQrBd/MQVSXV9B+PkJf42EQcIrWFLsO+/DSdupvCOfTC5qQ9a
 eXJ4ZPYwmlv6/tceEBqM9FCOJBt7zqwEO6TLzi8TWcspmO2g4ECMdhE0qTKiiQHey9/10Voignf
 Ujib5t09g+BX7PeX5kTIcJbqFhNfP4T24rYMXpWKlIGWAfKe+VBqI2B5UEOodSNukaAA2EMygIv
 mg7OFZP1bqIdY3POtp5TrwG+NuiV/KN4JnC4AReEOf3SuXFdsa3++TuxSK4iLSnazRaBF08vRRY
 x0QbpQ=
X-Received: by 2002:a05:6a21:140a:b0:3d1:66cb:d49 with SMTP id
 adf61e73a8af0-3daed46b0e3mr20849057637.4.1789267358083; 
 Sat, 12 Sep 2026 19:42:38 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 52/86] tcg: Generic expansion of tcg_gen_ctz_*
Date: Sat, 12 Sep 2026 16:38:03 -1000
Message-ID: <20260913023837.741866-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 117 ++++++++++++++---------------------
 3 files changed, 49 insertions(+), 71 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 48889a8a108..3d03242cda7 100644
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
index 2de0aacd93c..47627a343d3 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
+DEF3(ctz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dfecf8abca2..e3dd351735d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -544,6 +544,54 @@ static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    TCGTemp *t1, *t2;
+
+    if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
+        gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
+        return;
+    }
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_addi(type, t1, src1, -1);
+        gen_andc(type, t1, t1, src1);
+        gen_ctpop(type, t1, t1);
+    } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        int width = tcg_type_size(type) * 8;
+
+        t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, t1, src1);
+        gen_and(type, t1, t1, src1);
+        gen_clzi(type, t1, t1, width);
+        gen_xori(type, t1, t1, width - 1);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+        return;
+    } else if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        gen_extu_i32_i64(t1, src1);
+        gen_extu_i32_i64(t2, src2);
+        gen_ctz(TCG_TYPE_I64, t1, t1, t2);
+        gen_extrl_i64_i32(dst, t1);
+        tcg_temp_free_internal(t1);
+        tcg_temp_free_internal(t2);
+        return;
+    } else {
+        gen_helper_ctz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+        return;
+    }
+
+    t2 = tcg_constant_internal(type, 0);
+    gen_movcond(type, TCG_COND_EQ, dst, src1, t2, src2, t1);
+    tcg_temp_free_internal(t1);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -876,46 +924,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1777,35 +1785,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


