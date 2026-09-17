Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A99C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73m7-0005fc-44; Thu, 17 Sep 2026 00:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k8-0003Cz-3D
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006np-Ix
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:03 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so203382a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619327; x=1790224127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eVb5akhAgJSlhXNrTi2U40ggtT1EL3qh8SU+BCGHO7o=;
 b=AcJ7Lkx4VK8e0CAG5inK20DlHFPnW3DbsWDw+Kb1IIDIWMHfHaKQyGc6SaHWWA+zOK
 rgatLdvsfqT3/tAuHzmFoCgr6uDZ/3Oju7tEOun45Of4gLSTVD49C2bToGL7TpU5FpkO
 9gUp3AWckQMIVB0HnJOL/tC0Wn2BvxyJOGp/Vw0dC5GxdC9n3rplEMJ6hrqV6N7paI4K
 abwEWEBXhSBqtY2uVv+RBWc0bOjPouqMdEa0sh7QPABohA1YuMvHD2VbfdOA6aOSJHGL
 lWAf3ylbSgqTngXR4Rtdz1FqpCzhoGSVfGa9CIWjNqB+Aog/2smjpiYYcjvhcfApqRP6
 Ey8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619327; x=1790224127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eVb5akhAgJSlhXNrTi2U40ggtT1EL3qh8SU+BCGHO7o=;
 b=DVg1oI3gz4YvCL9jZtZHmEUA+nI4b8jNquTOel1PFoY0DsvntpobZNc7tkX/GXgGO8
 1BH/3jqEBY3wPY4IuypcDDu1Q9R63IU5en9fjKetQI0rvd2B3w47b6NB4dfzfDpX4KUV
 Q6bpLK/Ggie7uJn9dXC38+fx5x7QjceZrjHqT82NBdB6ugIBFVXOgH3QD6wq8VkPXREw
 Q+Du3JsHv2LJrxVLJqfEscTq7Mn4dVMj5+B6GngLSgfac6XoFi9YFOPMTOCd1cpUjhbV
 ZkmF2hdmB0MSNc3g47HuqzR4PvUI7Fb1YJJQFC8NbmzONnrE/IMXuJ8KtpUyR48OycF2
 Er9Q==
X-Gm-Message-State: AFuF++lFNkmErAUckfbGywEktZ2zzj4Lpve21EIr9Mne2mhay+6Kvukr
 mszcL7opAomcsRnsAFUXXwAOdgAe241Pwp1DdgTTiAXQ3YyEdcXSlDWOUAtrx+DEeoLulbOqCo6
 Jito4avY=
X-Gm-Gg: AYBFou1e3rxQcQEwF5y8jubSkkB32knY86y3IngT/L8KIn6npVStBnh/JLxyCp9DIp2
 wVld08vgbzgxIHqirhxTZ7RtwQbBfRrY0d9K2rDpvvPZEXiQ84rws4cjouiCHsNoxcNBLQABktk
 mRjotR7Sl7n8vTDIBvwkAqa+Uag8NK9rdd+ZrKmOOHTDCS7KCsOzeKVZMDWpZNHforSGLiVywbL
 Svis58IaewrI0VMnumEUO4wFuHCXgTLJspem2yakjcD9wdhsbdAYnZLoWfehVlWBi14ElsNf74C
 W8O3fYKraif9sejc993lcBoJ4UepQe6kkElhxgz7QdpDlFOLNbXeJo1Eqx9xGTQiMFPr+esnwcM
 zS2PDqq7SxHG5BlFggqrw22RAyh6O9/pddlHgBg1VBb1BqnYK8F4o1rAWjp4bZZpSc0fLsDNW3l
 gUFlsg0RzX6nqyouhC31L9vKzZlVs9kcnbCuTkXPn3HOC0e7o5i0aJSlljCNAupdV1/7Pf8VaE0
 QGNzQU=
X-Received: by 2002:a17:90b:2f06:b0:39e:252:ae4d with SMTP id
 98e67ed59e1d1-39e1e4d3fe8mr11857122a91.17.1789619326569; 
 Wed, 16 Sep 2026 21:28:46 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 019/101] tcg: Generic expansion of tcg_gen_or_*
Date: Wed, 16 Sep 2026 18:27:01 -1000
Message-ID: <20260917042823.542588-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 80ee29ee4d3..4d61eaba122 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -316,7 +315,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a2ae864ac17..513505e35fa 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ad7a70b575f..0b7fe14c7a9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -438,6 +438,11 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -489,11 +494,6 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-- 
2.53.0


