Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376CDC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqk-0002eE-EW; Sun, 16 Feb 2025 18:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqD-000197-1f
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpz-0005S6-8N
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so78651555ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747639; x=1740352439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MsRbT8q2vGvbZSmPZB2g9AELNkUgtZB9YL8IhEg4Hx4=;
 b=J94B8LnaYPP+XjQQAgjK0BkJnXx6/jET3WH3CBOsV90CroWgqpZXI0TIYGtWSsR6hO
 SS2GTdWTQSZ5KTEMPNAByeYKjT8CESDPo7I0LPJCaM275nzX90ixXQlMEOdSsHfXijRe
 nsIkTjbuPi8mFpwrRHJV82Kcyrp3gRAlB5nyUU9Tm//RdNB0N1DkxBy+/kUuCSGOdE0X
 kRTx/TQkU4o48jRxPbBsiagdARORK5ZpVfRocg5d44gv1H40RYnvdNE/51GopzliDPzO
 vhVrNTr7huurYD6MOFjfzkW7CRriM/HYhxl/N00CsNxI4WiJzr7B8LFlmozHohX21+SY
 ewoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747639; x=1740352439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsRbT8q2vGvbZSmPZB2g9AELNkUgtZB9YL8IhEg4Hx4=;
 b=MJkkxr9hQQEnhkEO1sML19hvWpO8kKw6ENeecxqIS5Z1QmZcv1ZSZQ+kQvrJ8Iidy0
 2uAJShfSfa/9j9Re8sU/YgtPgoNJSBAVpeQjc3+4WfNfCj0oTU89PevwgPSY7rHot9DB
 ELFEMi7/BpsHwRh8gqugJWqksfdVNhgymGLMfAkSFYVRWzDvc1Fa//Nf86Qf/PghGNBZ
 JIOibW0FkDyFk4U5HFCgPhCHNmB0r0NDEo/xGlVRBSwPsWXjZS0vGP8XMyoA2//E5S8q
 5/xJXkaObQsrDGop/zyDWUdXScfrGKn9I0/gO62MpeGxIroirH79DzZitzfz7ipZhGyR
 /sZw==
X-Gm-Message-State: AOJu0YzmHQfw6dqhAjs6Mngwt/zOXCNb9o+5QwTevAWbEKZJ4UnnTx1T
 xz2/mFw+pzEsSbcEc2OVbRC2HAZFxlOmDxjBzTcax53r3R1FK9dhb6iFJStRcY3AMFRlhOeruCs
 9
X-Gm-Gg: ASbGncvdIlOQKqiY5JbmRfdS3V0QoIoSa6KF3xgewfAUr976T2FqvJwumz3Yiy0rttd
 uKd9WNxLK33CF41feQKikOOUYxdMSizBqy8NVAVkXM/YVGHqaq8m+TmITYQ4mettA1yHbi1oj1Q
 sNSMAWXRCss0R5HpPjODRFQOsM4sc2zJJeWFUR3zjP+5EYNVtgC5tltBsiytx4qwvNJlfCDzTls
 Yb4boHPrymk4hSBTcwOvDYmUx8ZwcX3I4PrnAuB0dSDMS2O/miY1oTtDTHrwvVXC7KZ8TlSL4SL
 s2uBQ5zEtvKrQhNPZGFfskpcLNVGZZ5rJteWB4ZqbRxHNCo=
X-Google-Smtp-Source: AGHT+IEbnqyKkY2Vl2IF57g0wAD61MRwp80On+ezeAYvFe4A7jhFMmPKSu1UnqgNpIFyFiaD+UCRLQ==
X-Received: by 2002:a17:902:d542:b0:215:f1c2:fcc4 with SMTP id
 d9443c01a7336-221040bc31bmr128366375ad.41.1739747638839; 
 Sun, 16 Feb 2025 15:13:58 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 058/162] tcg: Do not require both rotr and rotl from the
 backend
Date: Sun, 16 Feb 2025 15:08:27 -0800
Message-ID: <20250216231012.2808572-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Many host architectures do not implement both rotate right
and rotate left and require the compiler to negate the
shift count to rotate the opposite direction.  We have been
requiring the backend to perform this transformation.
Do this during opcode expansion so that the next patch
can drop support where possible in the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 98 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 44 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 43848ebc4f..8c8b9d179b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -829,15 +829,18 @@ void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i32) {
+    if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_neg_i32(t0, arg2);
+        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
+        tcg_temp_free_i32(t0);
     } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
         tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_subfi_i32(t1, 32, arg2);
+        tcg_gen_neg_i32(t1, arg2);
         tcg_gen_shr_i32(t1, arg1, t1);
         tcg_gen_or_i32(ret, t0, t1);
         tcg_temp_free_i32(t0);
@@ -851,12 +854,15 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (TCG_TARGET_HAS_rot_i32) {
-        tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_constant_i32(arg2);
+        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
+        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
     } else {
-        TCGv_i32 t0, t1;
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
         tcg_gen_shli_i32(t0, arg1, arg2);
         tcg_gen_shri_i32(t1, arg1, 32 - arg2);
         tcg_gen_or_i32(ret, t0, t1);
@@ -867,15 +873,18 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i32) {
+    if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_neg_i32(t0, arg2);
+        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
+        tcg_temp_free_i32(t0);
     } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
         tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_subfi_i32(t1, 32, arg2);
+        tcg_gen_neg_i32(t1, arg2);
         tcg_gen_shl_i32(t1, arg1, t1);
         tcg_gen_or_i32(ret, t0, t1);
         tcg_temp_free_i32(t0);
@@ -886,12 +895,7 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_rotli_i32(ret, arg1, 32 - arg2);
-    }
+    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2437,14 +2441,18 @@ void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i64) {
+    if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        tcg_gen_neg_i64(t0, arg2);
+        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_ebb_new_i64();
-        t1 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_subfi_i64(t1, 64, arg2);
+        tcg_gen_neg_i64(t1, arg2);
         tcg_gen_shr_i64(t1, arg1, t1);
         tcg_gen_or_i64(ret, t0, t1);
         tcg_temp_free_i64(t0);
@@ -2458,12 +2466,15 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (TCG_TARGET_HAS_rot_i64) {
-        tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_constant_i64(arg2);
+        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
+        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_ebb_new_i64();
-        t1 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_shli_i64(t0, arg1, arg2);
         tcg_gen_shri_i64(t1, arg1, 64 - arg2);
         tcg_gen_or_i64(ret, t0, t1);
@@ -2474,14 +2485,18 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i64) {
+    if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        tcg_gen_neg_i64(t0, arg2);
+        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_ebb_new_i64();
-        t1 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_subfi_i64(t1, 64, arg2);
+        tcg_gen_neg_i64(t1, arg2);
         tcg_gen_shl_i64(t1, arg1, t1);
         tcg_gen_or_i64(ret, t0, t1);
         tcg_temp_free_i64(t0);
@@ -2492,12 +2507,7 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_rotli_i64(ret, arg1, 64 - arg2);
-    }
+    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
 }
 
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-- 
2.43.0


