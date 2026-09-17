Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87A2C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kG-0003HQ-6n; Thu, 17 Sep 2026 00:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k6-0003Cm-Gb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:04 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006o5-I5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:02 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea4c7a0so193788a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619331; x=1790224131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oogL5M0LRU/7QsuBliPckFPoTq3H08Xfq5xmzOdRTQU=;
 b=oLalCN4Wt2BnONbZPopdnmCn5D+n8BdaI82qXVTXFvEJZ63OjFJC/izXFXHuJqtdlh
 XvsaWHhtIq/A00rHqYsfS5JL5BVcfpncOY4tppoKX62ZVSI+1spadu6TiiZD4apPaFBL
 rTo7mLGko6VpBd1MxNhCt4uh9lLFvZ8JqLE6WsUT8ChkJ6b7LfZtM5WRwVuQ1wCJEc6r
 k/VENLBZQIqYdEQkRvC9u46BmfaTDR8H4XA6/rYA2wgBAgMbBGk3s7sEyGdRCnL8NzOa
 KZtBEytrNpRGG3p3mOJRdMue2zJM/3KOyfy6U5fWPWZMcjARuFsvVFVTBzwxfe7DX4uJ
 4FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619331; x=1790224131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oogL5M0LRU/7QsuBliPckFPoTq3H08Xfq5xmzOdRTQU=;
 b=z+JSu2DDc0WjevpHY5/aVizm9eJuVltVFS+Yor+pUoTSzTaahgpY7bPOXi0Wj+R7Dz
 ZS5Beody8n24TxWwIAgyNzQlf7eYfTLiJgvrHpqI0Fw1S/I9n7Obiptf+NM6XBnNwmgJ
 KvTqdp+zmgik55umSv5XjbCrT0AGTME+5cpFnhNR5iZUOZeNnFZ87xMjAqh34zf2HTsu
 jSpQ0CNVDNqdKg24UmOUJTnGGVuRDuSkCXOtErIaSSB3som0Jg/WqT2Rp6yzaIRiHVvV
 rChDeYd7OgXTFUUyyIiBGQg/FuyDIeQ8T9C7tFB2BMKI6b26oGeXITjsI3y3YvAGflyW
 d/dA==
X-Gm-Message-State: AFuF++nz+5VQTagZSGe5INcj6o672kUvuW/a+Q9BLhEej2zd3aWitq/C
 ohjJjUYsJvm9oF/GKx3HNOwv6iuafDklFDLVCigk6QXFLzjbLLESh7XOKu6ycvRCsGaQTD6NL5k
 ES7pBSiQ=
X-Gm-Gg: AYBFou3pWlN6QZI3cMgYfipKZxACHceVLRBvqk6o/WbWpXcwe6KyIDwrlNpM8EoeErX
 7Luz5wBCGBONMRmveuGfd1XCqmZIOtgTRPUx0RfDcUh9JARSRwRnqaMVXa/7voBt8nxA0TB0Y+P
 bjJl72Ibg2ueyDPtlNtDTemizYh7uui4ccIX/RkiGg6fH7YISbXzzkbaWTb86cKbg2TQMc9EPwF
 P98rRhfjZ08iXMysBcGmvvaMsNvJDUei8Ykr7ls9C26ff9XPsPDQ1f2eg3ny0M/NIoLhusGjwwC
 8G3zTFfvY/3xOKIWw318UXyUb0jnwBAM6jzFuuYYAKzA2PKhPsaLoGwsQU8ld/UxmYl5cpUL0Rf
 s03UqtEAcKm58VQxJNxi/+bCHfuvKyg72owNvIF0O4LymOFhpQFuZJ+DHmpzimN1I3o/j22FQ9z
 irYe6nkmbr0o6yy7Atr86oO4+pbwfNM2h3tSIGNMw2d/d6AxazUY+yjdtq7rPfgW0fGxeOzxk4N
 POO4Ms=
X-Received: by 2002:a05:6a21:1343:b0:3da:f32e:b3bf with SMTP id
 adf61e73a8af0-3dd5f5df79fmr13096084637.17.1789619331181; 
 Wed, 16 Sep 2026 21:28:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 023/101] tcg: Generic expansion of tcg_gen_sar_*
Date: Wed, 16 Sep 2026 18:27:05 -1000
Message-ID: <20260917042823.542588-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9bb5dd22496..eff7bf11d6f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -312,7 +311,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3f928d4cb8f..247d35bdc14 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6f6ab0a0e5e..c7e95dba241 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,6 +443,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -564,11 +569,6 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-- 
2.53.0


