Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D27AC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8E-0001ZM-Ly; Sat, 12 Sep 2026 22:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7c-0008Rr-Cp
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:13 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7Y-00012Z-Jv
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:11 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso2183871a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267146; x=1789871946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=12QbC3VW2aFSdfZKQgrWK7xgj1+wC0aEsdf6BOFl6/s=;
 b=Km5vKF0gr6SNnQSjc0VRxMvYKOeayWVLbEFUoQFQtE7ldiMxgZ35glQLJu7dv2jHmJ
 +R4sOyq0b6Kiuf83O9gD9LoIKo7hc2IQa7bCCHvfy+uX5WjGAOygrLBddPXuzFuq9OAc
 DsY9HBJ8b6fOQbgxTak79dM28bRfdGjdMAKn5amLqrIsxIgT6Gktn5NZfKZxUk84KVW8
 3btmA+fPWS1tu8L1qOuq0dW/1QUsDQF8kbuowJaUGRRWX8RlYnkcXB9d2ZROZ8WYmnqM
 vQExd8K/ARQl0/VD074cVqQsXgGfdu0gFFcGI677a1WYaTxUuY8ljgEyG6Str1vh87JN
 TLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267146; x=1789871946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=12QbC3VW2aFSdfZKQgrWK7xgj1+wC0aEsdf6BOFl6/s=;
 b=KNi0ecwUsCt3AXr4tUT7vN5RmJvRoq/u2+5HnS1X4JPsfeCNydp+6i5/1AGVj+lE9W
 C0Bny0F2AWc5XpAiarTU/DKlcIOzxXuMElk7qRONwolI+JQL9Q/fFlqTIEwa9PAO+CKF
 TLYc+QVzqIbuUuLL+JFip/atYB8kC6JaLAU9WPsl0AUWOX1P3qhhe0kcGKZZRlbvkkb4
 25qKQp1NJ0qiX/A9SA4AaXT5JIhvz0x2RreyEBpraUv/4mWSsNNt0Qb8psUi/jwH4kgz
 kY9YpYFmqEG0R4e2BsHmjT9RiAPIOMYFXYikaAz2FF0SYgI0TUwXEqgy4Ay9gxyLcvIJ
 3YNw==
X-Gm-Message-State: AFuF++m/g/sr60xWYsUEkk6Y4CGQSV8sHtPmJXY9boTD0zSGK7DdlETt
 Y0BMA+OdcIWHCGd5AWXbA+TmFXK3VYk8BNiqA0XQw2CKYQkyWTMogKZ/uhcTGiA3qEXGVHaQt4v
 HSThzBok=
X-Gm-Gg: AYBFou0jcgVW7mVZj1GiaDWf2QOxZHisKsJmzaXpNM5bGeM4gHVxgiiCrmgGJlcyAOT
 5wF72iWwc9am/LXPhG2I3oggu1Q78h/jwd2HF2mrL6OvM2M+eyCTMbH0jIuVtqYi3ujJCLREh0g
 hE1ZRcVIMzKBSFX4ExJcBt8oGTllJNJqG9c0sdr3o3PFuV4WInrk53aYBa7p1dVLVrr/zio3mUL
 NwHzScHYnU1149MCfXedevy3x76qcDmOf04vmGE15WB3oDSbEyOSSTF0KNGZoTlgpoOrZBGh0yJ
 0ejctYwbPZQkObsjJchkfsDW046KpcsVoV1AYCf9D1jIKkmMbN7P6ms5rzVetxuT93dvN1aH/hk
 ICQuWj2M8A2Bx7nuupyUUrMj4ii0k5TobWzNx1lwXGWoHZaN1vEdKcRw8Gi1x05fBsqqdkk4m7U
 e+e5OQpVTv1EOH+T3m8ZNEZAqrZoH7BhVLToXjiZXuXaFn7lX/OdL/+vbvqXzX96z4NAQHqf+0d
 t5qNDk=
X-Received: by 2002:a17:90b:4ac7:b0:398:9beb:a2b4 with SMTP id
 98e67ed59e1d1-39dd56bea5cmr876475a91.22.1789267146015; 
 Sat, 12 Sep 2026 19:39:06 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/86] tcg: Generic expansion of tcg_gen_ori_*
Date: Sat, 12 Sep 2026 16:37:34 -1000
Message-ID: <20260913023837.741866-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 tcg/tcg-op.c                 | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a932e975f27..cee21891451 100644
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
index dd1ef7f8c24..b2bd2f51e1a 100644
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


