Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0359C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBB-0003HT-04; Sat, 12 Sep 2026 22:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB0-0002Fz-It
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:42 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAy-0001uw-NW
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:42 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so593179a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267359; x=1789872159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l5X9inQi+Iv8f6uhcC9UFt0VFWqETrWUNi2AeW8lIwE=;
 b=YF/+Ii3o7MzwAaeI+LAyY6ZiKz/01imIf3YhS4ZzrdeVPX5X065jYgl/fr4VBPhdBv
 B5Vr+LSJckVW3c2kd8XIKuLXgc0u+Tvrn6AR14ZzoOQfB0bpSrlC6XKISq9sU2Uf+5IS
 HWfUwxmg6We0PF6M+5a6mYd/5TWaXYiX/T4feVM3/gIRLKtpgRlWcseT+jp50j7a18Lm
 /G5ss5lQPqhqPAUNv5CuVs+dY9EoirvyIZVRpecSYiU32wKsMsCQ7H+R8Ch6bhu3JcIL
 UWOuOD6w/xBnINL1XZB5GdIYxAgqp9oCtAt4CxujUKfsDw8NZAFR4hsoZ1Xz+DYm+ZtY
 T/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267359; x=1789872159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l5X9inQi+Iv8f6uhcC9UFt0VFWqETrWUNi2AeW8lIwE=;
 b=p95AqLfdFyOyH/zHHhviaWkQgsu4Pc54FJMwuJj28B7hKV7tNVxwPDtE7JqQ1dWtvp
 IxpOcG+HU8wG+9GALmrPw2Gsb7gIGhsuxLxerbWZtZprsw3e5Nss5prCkFik4jPd2jPL
 PXw5gkRuwK6wV3kw6bYQ3McbHXk88njW89XPk8irWMrBAM/1FQKrly4iQrffBgEunbX4
 iWEEYZQXQA4hrA8+yNJKJ6l3pV+svAGSiCay6rdBRwvIU875ZRjyr8+VHoS3hWw1ZidV
 JlONs5256cDtNzBcSn1n+HoXwkACb3Q0MBxOG8Xn+HQKr4W6kaDSeRT4fmeeSUHz5KKQ
 0Ijw==
X-Gm-Message-State: AFuF++lqyZR1fz320qSbjcHUHCPpVMAMqi05CrMZNWrNz0YcSrJNuh0q
 VIpUJLkU9GxGNesJXMIiBf+Bzsw9yZ5+hIrkh2CYNNsja6CYQVd6QmxatDxDwXoC2OoAhu2D/TS
 KgXqp3mQ=
X-Gm-Gg: AYBFou03phSC6d8N3bByv1zX1RmD1JK9OqVteymny2fB3/DpBAe28JUxiH8+J0QYDcV
 y5n3vnWY8unkwiUlCNogjB2EG2o4aqEE/VtgKPPS7SJi8kaCKiZznrz4cykOJQnDREcwmsS3zML
 aA02BRN5FDso8KYExANK499KhIIX50BG21BVfFKQEeLk6e4HXQX2TncXKqEfKR+ElSfbi5LyISc
 xiGA8JQRM/Z/Uf5Xjnlw2pSH/iwiJOWrp/3K7PHe+B9s6qrtd+SWHcxzwLduAbt0E9U7pw4Ldrg
 wa1J7dIgS0ErgUfECwaO//p9ZVuGY5yyHFhrj4ec5wjnYVyFacZazTVLMmcMnsHQufUMQvh8igk
 hsRoO7EZuDEj+qdbp5MsEFmGNxXIDxcwhrjAKSZMJ1pHgZwNnhTkP7af2iHM8uqhC4aMYsK08/7
 67rLfvopzywdSET0YSUZd7dq3XON3R/jaYcq14icVGgXDoSyLjBz4h/t5cjtysNvY8/PcqwaOFu
 lb8sH0=
X-Received: by 2002:a17:90b:574c:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39dbbe8b90bmr9469883a91.1.1789267359162; 
 Sat, 12 Sep 2026 19:42:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 53/86] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Sat, 12 Sep 2026 16:38:04 -1000
Message-ID: <20260913023837.741866-54-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 46 ++++++++++--------------------------
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3d03242cda7..77fc1cdc3a8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -186,7 +185,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 47627a343d3..9968ca9516f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
+DEF3(ctzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e3dd351735d..053b4b8116d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -547,6 +547,7 @@ static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     TCGTemp *t1, *t2;
+    int width = tcg_type_size(type) * 8;
 
     if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
         gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
@@ -556,10 +557,14 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
         t1 = tcg_temp_new_internal(type, TEMP_EBB);
         gen_addi(type, t1, src1, -1);
         gen_andc(type, t1, t1, src1);
+        if (src2->kind == TEMP_CONST && src2->val == width) {
+            /* No fixup required. */
+            gen_ctpop(type, dst, t1);
+            tcg_temp_free_internal(t1);
+            return;
+        }
         gen_ctpop(type, t1, t1);
     } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
-        int width = tcg_type_size(type) * 8;
-
         t1 = tcg_temp_new_internal(type, TEMP_EBB);
         gen_neg(type, t1, src1);
         gen_and(type, t1, t1, src1);
@@ -592,6 +597,11 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_temp_free_internal(t1);
 }
 
+static void gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -924,22 +934,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 32
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(ret, t);
-        tcg_temp_free_i32(t);
-    } else {
-        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1785,22 +1779,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 64
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


