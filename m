Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89818C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kg-0003XL-Be; Thu, 17 Sep 2026 00:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k7-0003Cr-UL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006ow-Iq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:03 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 41be03b00d2f7-cc50d1b048eso295453a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619337; x=1790224137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sq8Yv+sp7tQR+JDzfb4K48KyhrUPcZRMabJqL0FAtTI=;
 b=ncmkNp4IcGySoLnIzkFikRmDH40kysXOXJHUNIgfQibr2kB/QzNaqW6xS/tODaVLUm
 R3EueKvzBadU//woVb/oir1pg27YS4G4vgbkaZ9wh1ddEha2Ztm8I4TXgJzy/rCeD1OX
 TDKYNNuI33QCi0fVJrSY6/eukbe5vh27ihJ4Uq2FP+vyA3K+SYq9usAUf77yv8cIGKCK
 g0b5NZiPPHndML1nKiWnWxlhiO+BNax9QqmMSrAFR8T+M8IZmSfaQ2d8DKsCFugptVhm
 5T8XtEQd+q8uThN3nmcCcDTlqE9MDBAQehvHYMeJvQDVh16kQk5nhYxMRcH95sh/43eo
 biDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619337; x=1790224137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sq8Yv+sp7tQR+JDzfb4K48KyhrUPcZRMabJqL0FAtTI=;
 b=EegE8y7CFXxIvVCrcGPbVXX5j68ljDPSZGB+t0AYFjjEVfUWafkJ3MhLuOXDljp0Bq
 9KlLXPr7WId9KhNtU/E0Kmik/vEDFaR3K1QW9pD7XVE2O2cxnAtA+sUIJCZ2tnLSi1eJ
 jYjhdfyvZBT1PeY3LOW2+6rV3Wi+xsZbkJXj5RvozTZpHFvf0s0XM1ShLPaE3lqpIybn
 /v1QO5cf21LlF1v7Dwed4iOnaw8WCiOjm00TU7XANCVveFE7j/RqstPG4nivgXN1BDvo
 jwXqQ4pjefcaxYhBb/j8mFkM4NaHMxAPvrRkBnsV8jhL2AjuMcv7e4+djUH83EbFzFpK
 40rg==
X-Gm-Message-State: AFuF++kHo93Ji9TqDdMsK1HYvswBCWBT9spkb3BALztx4RGOdq+XeemQ
 a+VvL75bvnHeg5mRDLuEgwDSzrDs0i3RG9A0HiHl2+M+Jyqst0o2nubg88kgL19YWSCxlP/YF6A
 Ojzk9Uj0=
X-Gm-Gg: AYBFou2lw3nZJmJxmpXZaohunwFaufDhDCSn+6DIHVt/PubC2V5MUU2FTGj0o9+yxe5
 uioMQyJ/b1dSeMZgOLIBK+9jS/BIX7v0Wf1rKtw3T4aBXG8cWoe6FhAiqhYw3/iCi2SStaSx4qd
 fpVCdi0lOY/01/rlHDiqbpyrNGM/wGc0HPoJ4r0jEbjtqpBT7KqWrmY3bdiVq4vzYZUr+UrF5pH
 QE1ipNTACpYuilVc56T3TJdm0oaGrV3kbzybhkO3/8OHWY2orQmPXmdkBw3Mxu3TjYBmeiuq2nI
 5hOIx6Y3lKpFwQG+fqNYZR96VRX6XCz0/K0Siv7jT2ajn5KuJM1H2h1FhhHIdqkQslNTPjsUdop
 IcbydzrBdFMMnqRdVrV9DXzPk54kkZI3NQaAgzyGOoni5iCoCnOrgZmR3K+cnqN3J06z8iE+KJp
 6ZPSBphpMQalJ1qCMhoF9z6LtzPxrwTDNDYZFh7xqbwn9MGXnmSGDbJf9FQy7bqgTHBPa8PHv+k
 birIDSE
X-Received: by 2002:a05:6a21:4a98:b0:3dd:5831:ef5c with SMTP id
 adf61e73a8af0-3dd5f5af371mr13862125637.17.1789619337353; 
 Wed, 16 Sep 2026 21:28:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 029/101] tcg: Generic expansion of tcg_gen_ori_*
Date: Wed, 16 Sep 2026 18:27:11 -1000
Message-ID: <20260917042823.542588-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
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
 tcg/tcg-op.c                 | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 57caf5f6631..a30e9972b86 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -210,7 +209,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 67056e9f730..2c3604cc7ed 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 198e1021ed1..2c7627e7cfc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -478,6 +478,17 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == -1) {
+        gen_movi(type, dst, -1);
+    } else if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_or(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -549,18 +560,6 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,18 +1526,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


