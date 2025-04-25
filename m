Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5DEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4z-0004SY-KQ; Fri, 25 Apr 2025 17:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4K-0001lN-Vj
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:49 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4I-0000r7-3J
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3081f72c271so2748672a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618324; x=1746223124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53KVcTr8YqhVJdL3BIELGQ0wKYZHMhaPCUEVKYPokVs=;
 b=pQBosU9cJTR2qF95ro5tyElH56ln5JungVaGhtpfhKALYvidzKPYBDe58+3kn2oTih
 AE7eZp6M5zQhOiVx4AQuU/EoCDV3PGLuyGMehfCOBldOlnIWyQWvi3fJIJH28nw5H0YR
 v7HdjaGcxIpSpyU5Du6Tuf7eOEgrAgXxk6vJrSXzjG1kc7nubRZml7WSSUbq1wXk7+f0
 vdkUo3EaY6kx9MV8HZQRIPxvsE+GdtSe1GPOOdYvn+CV2a3vzZT2/wGRZ8gx+WTZMfTs
 WjFmbkBLXYZcs3iHiZ8v3qxg63yN/I9ODM8NEJ317goo4qgLILKs2ttV2u0Fi3d9H2RV
 Wx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618324; x=1746223124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53KVcTr8YqhVJdL3BIELGQ0wKYZHMhaPCUEVKYPokVs=;
 b=aMPrgW+GiVpk3OKyf3PvI0Wq4iw4Z4wcVWbcrh/oGZDVM2diMQ+ctJo301XZpLu2K/
 hwGyDt0FE5qvaACbS9T0UfbXqgn9guoPTDXTZoJ1ofWaDKBQnLvjaDilZ1XbL6SVbbof
 CkTT2t0XvezG5JdRl6ny8hAlFhUA4/dkgUN8lyyz+6UBxum+mtCbmhdYBd9owByNw9UM
 tkGkRapN30BM1ES+vVpdTDR1XRj1dait2sOyedVHSkxC1kvjyWjQxdH6CEzT9jhnapNF
 r9lPdN2aseamu7lWvhB+ei3kh3Ri7vXMIsY+PDHfkZdd6LM4bUrTZyORu61GRfnG60pm
 HFhw==
X-Gm-Message-State: AOJu0Yx/KWmcvqIaBDPV3yrFdJX/aYU/m5pnUabg57BZV2FRRX4wTYkl
 9RZx9GdI5kJg/Fy8+QWw7aRviSM1DedvVUqvHuh0TOhjaxuWIGatXwntDLQRHjG5YeCTqTE1/1z
 3
X-Gm-Gg: ASbGncvUpUu9USvSLPShL9pV6saam8zanbJw0SPpCSAamJZHkLFujYk4cxVIGtB0xiG
 GoBOWQSP758c6+Awj0QMBF9QHkdPTnAFbYTyJL2xYzDEAcfxvVQxTY27cwoysGzLz6tWGh9onfC
 5Wk8P3ko+2rOY/JPvHfFx4DLExnGdoIqmgXVx5DPgW0Qig+DiNEC3cNAPi02eZ9UjQg51lbE/6g
 7G8mCBxoUN/qHcz1/u2lYso52Q0p1h0E0O1SbxDL9bYljRppyfHwTAEopgN3liCqkcWk/uKmwX6
 shwoM/4KKI+GJHXzTauB6jqd1wuVN83dDevn/enRrG/6r7dNHz7sUCEl6ynuUC5vV/6dQM5hSPh
 +E39aoElZBA==
X-Google-Smtp-Source: AGHT+IFtRWLQ8HpZ6rSYDWjIjCVOlJV+avZIW4Ce1rBRa41zjBJ6rJE2nWcZe7afj3H9VxAU0ve5mw==
X-Received: by 2002:a17:90b:5870:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-30a013069f8mr1658031a91.9.1745618324318; 
 Fri, 25 Apr 2025 14:58:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 063/159] tcg: Do not require both rotr and rotl from the backend
Date: Fri, 25 Apr 2025 14:53:17 -0700
Message-ID: <20250425215454.886111-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


