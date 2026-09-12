Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A2DC88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5B-00014e-7g; Sat, 12 Sep 2026 06:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4x-0008Tv-0H
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:27 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4s-0008Lh-UH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:25 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f01363so2900035ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209320; x=1789814120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=35iG8eXomRV+hwa6hQxNxo6DUanLvlq2FcMxOZf02mY=;
 b=ZXr3w11NsKgSqonpIum6l2hR21dDHWVXQIq9qHqozNbV+A/Res5OOh7sQjCWHvCUOw
 IzJKgaiEnSpn1vYkwBTBbeGwGwHDExs6HZ/mPs6NHTt2jABJZCG23KUbP+uuyLB8qpCt
 QTYhHEqN/rD03MrjvJGsmf2S89JCRWEYGgcUrvEylXP061rLBNnG1fvyl9gT69lGOdHD
 g2lfXO2w/2StzE7c1SIneKOdkmibeAcJD3A949DWvO01ML8rMWEXMlb3yfMyO7oNzm8M
 4i/dUOjU65zN3r53TQeq9TcQ3hc5nOWoCSh1FuyODvsV41h9FdDDnenaYRVlWe+wTMQs
 g1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209320; x=1789814120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=35iG8eXomRV+hwa6hQxNxo6DUanLvlq2FcMxOZf02mY=;
 b=Np9lai1p6gt7IrV27VV3Tq515AaGW8wmKdmK/D0F8/3Yc+Rbb/nfwb1RM03rFRY+fP
 bmHAz7naLrjirlE3LswYQy+EghD7v+nlsP3YvWDa2S1/Q37nNrItnbn+5VWUO2ej6jd7
 /OsbMOKJupPdmLV+3LApuSgkrSFJt6ElHXnF2ZNo3zrR6OBJQC+r8CpfWLj0AQB+x+4y
 Nfm7MeA6uPT3sFBni56CbAfSGKJwrOLR/57DQRDhOJShMxX8/Keznu5mtxbsxmfWC47m
 xnXX7NiEsCjmo5yka33cjxnisFszQHscGdGhEmz1+HasGQrFD25bCGuMbbqB7CTvcUsE
 hRsA==
X-Gm-Message-State: AFuF++lu1dhlgMFeoU3pVDta/Lnzbl0QyqpirKmd0cXn6lMywv4opBlx
 lRg/zDjjnVUwALr84QCeTC4rgjMnUSI6piByuyzQiJKnlqzdb0cA1QT4ELqYcAad0I1y/66mhk5
 BNENGqGQ=
X-Gm-Gg: AYBFou2pTAIT+hZ5gJRQnZzxmBhZ0gKPCD7QC1OO9/rUre/lI1fU2T74Bcr4wmOr4iE
 cTBbddFFENkXHyjehtpIyUtydjl8Ab9JDrdnd7p1IWnWj+12EfT4XqEhH5U60ufyC8k8JIuqKKr
 Ai2f5XNSpfgAGNRiYvgqUMJGpEhz64P05VfQGeSQdyNP7LxgjBqGtHUeNein31sQAn0SFHufJ9y
 5kjtJXNfTiKn62kPik49NKPGOj8SyNwWNsnMbG/Kfg7BAj3HsnlW7xjR9VCOsl5qMAPkBvuu/mG
 ObAOFP+SZPYlYlIb84itzEsAxMi46RpVEHHGNoJFn8EtJfkw220vKNcLiN4VAGEtUl9v271j1bU
 Furnoj4yTP/LcxleRk+lAykiXoeko+Sh9vRlXvZTJx5b/NXXEGh+Q3UlzpXJsNXb502j09fhDxM
 h5CNcorNsqT23UwOsW3rAn7Wysn2+3LqVqYDvT7Hqc7pWQ5gdhhCjoTUXKy4zeOPG0jJb6HGlNT
 9qXfYl3UgmBDMSSJA==
X-Received: by 2002:a17:90b:4c0d:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-39dbc6a3e56mr4259188a91.13.1789209320456; 
 Sat, 12 Sep 2026 03:35:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 53/82] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Sat, 12 Sep 2026 00:30:57 -1000
Message-ID: <20260912103126.598030-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                  | 46 +++++++++--------------------------
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2a860d7a6c2..b5271751994 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index d0b1141dc10..209bb57b968 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -17,6 +17,7 @@ DEF_RR(not)
 DEF_RRI(addi)
 DEF_RRI(andi)
 DEF_RRI(clzi)
+DEF_RRI(ctzi)
 DEF_RRI(muli)
 DEF_RRI(ori)
 DEF_RRI(sari)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a33def70cad..3a61cfbc3bd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -502,6 +502,7 @@ static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     TCGTemp *t1, *t2;
+    int width = tcg_type_size(type) * 8;
 
     if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
         gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
@@ -511,10 +512,14 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -547,6 +552,11 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -944,22 +954,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1805,22 +1799,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


