Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CB9C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kQ-0003Nt-Gt; Thu, 17 Sep 2026 00:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k9-0003DG-JL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:07 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k4-0006p0-Cv
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so4759285ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619338; x=1790224138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rE6Gp/rdILGcFkeRqaWTBtq7xL0npMobAFrbzizZRMI=;
 b=WJoFppg25F8W/YcTYzyNdigXZr2AMsmZ9EhSQH1zUlb0jt75wp3PePa8UJXmwfG1Sz
 V5JzGQflDBCHiqvMIGCF2qQFB5bUb+fFi5XuF5sdWlN1atHTKYmHSvNauE7aTT1SjWj4
 WoMpp3nZ+5WAOPkNn1lkugyF+nYR6mcA/JZWYRF9Tm7jfUVqxuwS9uaR/3PCnnKkhrJG
 LW04YVyElZvgR+/rMv6SVOeykDrmVD9yG7Rj4MOoDhAsITVn+DRBI6ONTYoP/QvhR/D4
 hB9/df3hsUIFM7ZF7QZvYL0jHKpQ++7WcAil6q6xRMu5L7sEsAFh9d7l0U01Yh5S3+e3
 2yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619338; x=1790224138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rE6Gp/rdILGcFkeRqaWTBtq7xL0npMobAFrbzizZRMI=;
 b=ZpfIxjsB1voCgjwda/OJEsPZjAdOg9ajwfnpHzmo8085a8WQuZ7toI1PPkkrf1JkIf
 mRjmqJ+b+zF9w+EbQGSpRL/z6XgQw2dsvobt7lvb9oE1mFDw0hWuQPFWT8VdwKDDju2h
 QtfTuVTsQQK3DZc7Qz6TIc8W5baNHoUNeZxlVf/tfMobH4SVNZJ72N66vIOYV4Ty9mCz
 +eJqaqaCCzPCwxK/dy49K1jpbaae8B5Xj84sqfOyVWkyg9h7U3SfOj+IHo368NH0VMeT
 TxfDVYtDBIpq2Brmju0AeKepZwxzDIz9S8E7lmW+aaIUCe0seeGGzyxzFuwbDAzQ0fbn
 fzkw==
X-Gm-Message-State: AFuF++nCSO8stE3izGm0Xyffb8A+5RIXlkoY76M6pMQFlV1p9xRcnkus
 BXbUOyd7gm05hKMU164gbY9FCPVoP94GSgJmLJ8hiHKdeYtysDa4sUkshR/fblEQSro6mKwh4f5
 DdCI0
X-Gm-Gg: AYBFou2SIzRa5bEqdoCcCAmYQ3IetxumsPzy6U607VJ5wVz3OCgHyVhwqnWbTTzxGym
 a151urOe70wd1153bQSDVk1pPtDOB/Vz3nm1eRuT1xfWt31z+FIDMhdyFjceQ+AiZYbMoZPef8m
 iCTdWGmAOygbm97socOlQSpxKQVQy6SRfsfF2noHkx7cPc2Tj0oAtcNfH6ycesrv7X0YAQ0pvdD
 Y9y7vY937sace0rTXnY481qRvm8QDRo5yjJaYdQDnUnb7y8ScK2D3PZrQZ+tkuz/gNarRS5HAGd
 5+H64qx5XsQnlZXW3fuhPl9wNZcI4H5Nkf12LFxOsCkCJ20BnayFf/9RcwMNcRctFNtGVNF5Hre
 aLDrFkJehMVii2zr5r36hi0Q6mnatdTM33vffKUcowN4H4u7mPkgOKhZ7tpYV1HjG719E9mKGK5
 4BwyLBFdWl4f6OGZFSMauKRa20EYCaQnjIlSMoJaio0iN8cNyqZj3yJP0yoRZr92Fh23JguEpSM
 JvD5SQ=
X-Received: by 2002:a17:90b:548f:b0:39d:f731:e5f3 with SMTP id
 98e67ed59e1d1-39e1e4d2ce0mr12565407a91.24.1789619338350; 
 Wed, 16 Sep 2026 21:28:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 030/101] tcg: Generic expansion of tcg_gen_xori_*
Date: Wed, 16 Sep 2026 18:27:12 -1000
Message-ID: <20260917042823.542588-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 34 +++++++++-------------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a30e9972b86..cd651d6e427 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -209,7 +208,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2c3604cc7ed..b620a314480 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,3 +21,4 @@ DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
+DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c7627e7cfc..e1338fcbc50 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -558,22 +558,20 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
+static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 {
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (src2 == -1 && tcg_op_supported(INDEX_op_not, type, 0)) {
+        /* Do not recurse with gen_not.  */
+        gen_op_tt(INDEX_op_not, type, dst, src1);
     } else {
-        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
+        gen_xor(type, dst, src1, tcg_constant_internal(type, src2));
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
@@ -1526,20 +1524,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


