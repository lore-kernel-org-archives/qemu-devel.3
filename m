Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC960CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uJx-00036s-S6; Sun, 28 Sep 2025 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJu-00036D-Dd
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJi-0005yG-U7
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:18 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-269af38418aso48484615ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759077119; x=1759681919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldEtWW0ceL1Qi6i+lol9hJF8fiaAV8bH+OpsdGd9wvE=;
 b=ayoSsM3bJI6UybxLclQmGTu9pBJZaha8+Z02Y+y6NH5NE0mBFK3nELvS5x02nqcKQW
 C6AdW/Bhpf4sTHFGDmo5ESHns/vjvSjRubZdwUI885HlO+Xt+57HFpV8BhfXiUi5LMzI
 5neSl/p79HL0Qs+x+RBhXqPHNfQ9M7m4oWmGHmA+hn4W4Z3yFjRs9c+2unQEgZw1jC9F
 Y+hnqCBBl5IRAfWfkXqBimtc0YfCHP0cm4Gf4Wtx7RVsP9IDQeH1vyf/TGOQl4ibhtA9
 lXggCHcnSfrjOVA9FTeQvATQShktcioezOc6vLZJIG9aEiROV/KSwos7EFC7l+RuWqL0
 7rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759077119; x=1759681919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldEtWW0ceL1Qi6i+lol9hJF8fiaAV8bH+OpsdGd9wvE=;
 b=a+bVyH3oLAvJ7Ceh0f+d7xORYwG8grTO5CjgmC63qTurOO5t0GaSpz7X2R7X0LDusZ
 emrlPBELFBHBF0DnnNWEarAGK/C1ES/MqqtABPXwbvIc9yLrmUec3dJLZpaOBSwcGupq
 9v9pJnfh92eO50m/dDyYEjRd9Dv9+4UjPRz/E2TeOEPGfepP+XxqcH17aysK0DFocHLo
 luf5fB9fE40DrTMqVDDVqaH/BGQ3+pYBCTKtYV4r+RQNR0HLD3Qy1yIXtZ9vHf2GZSrw
 E3yZQ6yIx7ZWuUSop+9wJ42JJfP6juNo48cO3sfoc+Gv/cJgMm2Bpi5kwhEZJWo/Wifo
 raMQ==
X-Gm-Message-State: AOJu0Yz5pLDk1AMKx9BQoe+Bk0TF8vM5FHu7fpXKCsc69oL1MkcrRMXu
 CVvADfvKGa3ofPS2BZqJ7ZJw+OBtn6MTFoEkA5NCtOPXU4v8AdmyudYYwMfRN02iMrp8SnCcw0f
 rST8JNWA=
X-Gm-Gg: ASbGncseyABVEk6wKic3sL8XcOj8Dhqvj3s2mW/PkYCIYTjHGfvwKvETeMYQA8umUWO
 pVXnWGsZHfCaDg+UD8JCMXltoPx6vsWVbYC2eFr3DwAWz7ZY63dtx0EcHtLV5b7cRiNLhVJ7Qc8
 IVpc/eDF1Y7yukRuvl2btEMHQNsPz+S3YJA1fiC0EoFa1cvtSe1rFmfFfcSQAnRp1lWH4oCSl84
 ttM3qYLZglBipOBXVstkLbGv3nCE0GtuIYNe6Zwel6b7/w7lvRqAnSCf/q0eSoyXUiD0vGMjYsn
 Ieu1lD88xkFofzp54Wh8ZGv5FHhHo0bqtk80Os2l+UaPMky0zjcqsE+444wBYUPqRYPsLIa0eby
 deNEgolVf2KWKLM1hTDxgP7YrmIVn
X-Google-Smtp-Source: AGHT+IGVKLXBh0JC0FhujuuL/hCUET6N/d+yG2dD+NOssEVUHJWI5n8nF02iHS8IOJS/MNw3kGLU0w==
X-Received: by 2002:a17:903:1a2b:b0:24c:ea17:e322 with SMTP id
 d9443c01a7336-27ed49df28dmr162570745ad.3.1759077119503; 
 Sun, 28 Sep 2025 09:31:59 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6996963sm107236335ad.104.2025.09.28.09.31.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 09:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] tcg: Expand missing rotri with extract2
Date: Sun, 28 Sep 2025 09:31:54 -0700
Message-ID: <20250928163155.1472914-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928163155.1472914-1-richard.henderson@linaro.org>
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
 tcg/tcg-op.c | 70 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4caf77da1e..3e10a3ad16 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -834,23 +834,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
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
 
@@ -878,7 +867,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
+    if (arg2 == 0) {
+        tcg_gen_mov_i32(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2417,23 +2415,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
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
 
@@ -2461,7 +2448,32 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
+    if (arg2 == 0) {
+        tcg_gen_mov_i64(ret, arg1);
+    } else if (TCG_TARGET_REG_BITS == 32) {
+        TCGv_i32 rl = tcg_temp_ebb_new_i32();
+        TCGv_i32 rh = TCGV_HIGH(ret);
+        TCGv_i32 t0, t1;
+
+        if (arg2 & 32) {
+            t0 = TCGV_HIGH(arg1);
+            t1 = TCGV_LOW(arg1);
+        } else {
+            t0 = TCGV_LOW(arg1);
+            t1 = TCGV_HIGH(arg1);
+        }
+        tcg_gen_extract2_i32(rl, t0, t1, arg2 & 31);
+        tcg_gen_extract2_i32(rh, t1, t0, arg2 & 31);
+        tcg_gen_mov_i32(TCGV_LOW(ret), rl);
+        tcg_temp_free_i32(rl);
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


