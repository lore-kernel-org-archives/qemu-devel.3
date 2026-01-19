Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC60C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhcoT-0001wJ-7J; Sun, 18 Jan 2026 19:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhcoH-0001rj-2M
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:07:57 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhcoF-00015n-DE
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:07:56 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a58f2e514eso23218425ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768781274; x=1769386074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVPzdCnFdmlrffK3fWEylRJxEnVHNoCcDL2ufRITdLk=;
 b=WTvli8KhBPtZ0h6otPyq8teGrxCOc7VQ2HJoLCBHftpVWkBE4MNg83QeLP/+3EVSkZ
 ZjGAnSI1y302wQcNHV74QsopMQiIfm2f2+vg43LFNiUnv5FEyBQPMlyqN0HswnVoY4cz
 ygDAbBaKZ7M6ZsciZF3MqwbgK8U0cdS4PDp4X5yPVafGLFHmO/obAMAW5VSQVQ3BhXmr
 KCNv59K2FS1l5125i+1eBCuwQ4kVAmu67YcUBFkuvFKHjPx18vOuwATzB2xxsqqEvI6h
 JN69JoBTyUMp6yRebxGcAhBj/rA7FfpagulHqCSusyvebYuw/7YTcUip2ys6GZ4E+UAE
 bm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768781274; x=1769386074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dVPzdCnFdmlrffK3fWEylRJxEnVHNoCcDL2ufRITdLk=;
 b=K6B+aQl3SFQrtKFqQAAY4WMiaPs0jJrf54ND8/80l1JOaO6QT03q23uk65tpTTPpwP
 YCw7VRxB4p9Fqdn9NCEzATcxMyrssc25S7I7qhq93mgLCqD9/mP/yZlHJ8AXBYFzI6BY
 Q8IAzO//rlmEH111ouXnnpseCpS/3tckT6QSXjjld8wLJPYNkcMUSN7m0XODuVkcRKyz
 k3ketRl5XVfoY9K5hbScrh/uuVNPSxP3h+PrO4sU0uGMmNPEQKRGMaWLgQBCHIxJNYWQ
 1jP9KY8M0wcVEZ/18TwhByVHsBywUqVAs/hwdDWeA+4zRHbPEV7w1QeSlearD4I6usMg
 DF/Q==
X-Gm-Message-State: AOJu0Yw8oBQFf0MTf1+zQjrusP0twlhCD7rVffBB+P3fT5GhusbwxTkh
 LRzeKzELRGPX4vtyMqEpj00mkVXkM13Gziap4USlvTJ2StqhU0xwZwmCW23Hnh0y4KjxSLqlP1q
 4MPggi1e/WQ==
X-Gm-Gg: AY/fxX6cJWWBjfHlnjC1oKOMy4/7H+J3CPlUe1yJs6ipBvkE/v0WyKryTCRVLKTYHGq
 6qlKPxEzrvlMdu9G3l1v0Ae8w9x1U8fuVC+kQChw8y0mI321wJmYX/q7I8PIOZ1Es+x3MjzE58U
 g0fWbksommwmZ+fqWOivuG+M7yyiamcRsL44bbFOx5fQ+DxsWLX3Pch0Ba7ulHv6p9AUSz3klOS
 g94O0UHiCtM5qz0oq4c2SH86eXriSX/j29yIOYKz0Qg/UpyX6znMUVi9VaNs5VXEd2H9gjVkCGi
 cdKbxJRe+J4REsRwxCusPiR7QHPlrU8ksDBNjUHRzhWBzyj6ViUVSApuhi4wa7fqS+0E5u7lzrY
 dFjLK1pNs2pG10f8forc+tjGutY1mSdYCzfYukkLiaO2oV8MhUGn+DFPzs8Chh+8WElJCuGeE4I
 fxrP9BYETA2GJLYbybaghp9HjYlw9L
X-Received: by 2002:a17:903:2bce:b0:29e:c2dd:85ea with SMTP id
 d9443c01a7336-2a71885a283mr83880435ad.11.1768781273617; 
 Sun, 18 Jan 2026 16:07:53 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eee39sm74872145ad.45.2026.01.18.16.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 16:07:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH 3/3] tcg: Expand missing rotri with extract2
Date: Mon, 19 Jan 2026 11:07:40 +1100
Message-ID: <20260119000740.50516-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119000740.50516-1-richard.henderson@linaro.org>
References: <20260119000740.50516-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use extract2 to implement rotri.  To make this easier,
redefine rotli in terms of rotri, rather than the reverse.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8a4fd14ad5..078adce610 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -826,23 +826,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shli_i32(t0, arg1, arg2);
-        tcg_gen_shri_i32(t1, arg1, 32 - arg2);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
     }
 }
 
@@ -870,7 +859,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
+    if (arg2 == 0) {
+        tcg_gen_mov_i32(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2042,23 +2040,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shli_i64(t0, arg1, arg2);
-        tcg_gen_shri_i64(t1, arg1, 64 - arg2);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
     }
 }
 
@@ -2086,7 +2073,16 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
+    if (arg2 == 0) {
+        tcg_gen_mov_i64(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-- 
2.43.0


