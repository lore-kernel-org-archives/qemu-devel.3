Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94477C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBO-0004Yo-Uu; Sat, 12 Sep 2026 22:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBJ-0003sO-9u
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:01 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBH-0001zq-MU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:01 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so637355a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267378; x=1789872178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1YNrn5G7onWh5f1lmKxsSbYO9/efUUkPGxPwjAksf6w=;
 b=DD25sSXrSt6eVAbiA5hWCuzxN8QG4kTo7evDFze8+mctBLbn+bLm4zANfOSRX4kMnJ
 UJW4+v1Ylx09tU5fL0fdjXfouxVfIrAOCiT7Wia5XinaKwPPhAXLy48OsijR+K9XWx0K
 nfWclIlbPtqVm8Z7p+PexYsE9k3KfF9wUHAav2EIIT432xAVVCWYQY64d3owh/jRbjI1
 oRj9dKTVADPSY2d9R9ZqTI2RDz+QD7cyzHtPZg6JUym1BHli9iFoAVnV3qm+u3sPdivY
 B/bZFMwZMf4705Q9juKRu0IShsBa4cxkav5PEO16Ee0fyOQ5DMeIfZnKzJvxomKOdbNh
 ufQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267378; x=1789872178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1YNrn5G7onWh5f1lmKxsSbYO9/efUUkPGxPwjAksf6w=;
 b=e0pG6YXf8tY2xXcfCw8J+6vaMxm0gQbofloGUX7irsKk1ubM6S/HTujuUhhndqEipS
 Azd0NfzSurVwDkcxIL7bPbAOHVat021uEeRT4PpLcI8MDN9Nrp7O32dAHF5mB5arpLEf
 /jb8R0sqYJwkah6aJdjBLDiLpU+HGtmohSUUbgEN+Qro1FMfssJ7bg37IJZo//FNloMq
 kB8ebfGoROUxM/Y7gj5d4oSwqZj95GfohTwnuNnDE5+u7sI8fXbhu4JIwcqxQKA960ep
 Id42QtPZta/IWSpIZHDid9XiJhMgOHlq4nnd+MHqcUxeOBfcnfI94n/IRzs4hWSV9FRt
 bKTw==
X-Gm-Message-State: AFuF++lTKUWRt5vCuoWChOsNHN/dV5hmIpL3gKyTxyisiZ3x2fQslk3q
 0Niyu1dj06QtSyjGt60J2jeC43ZQlOmHomKaqntEN5VlyvGAfEPmDbRdn7kFfCN97xDlDkp+vqL
 mgoRi
X-Gm-Gg: AYBFou2Bvn/Um7AWrB7arAZLWRNOVZ7qgsZoltoeVNgF/7AL6uvZDXzKsNXvBp0yjap
 KqS8SHcial49rJpB+G576yOfpqI8MfG6BcqZ2RUjR2/wBrUdXQwMF2rqDaV6qsZd7ijPDCZbHi+
 kuAvei6loPt8YrXkQsh5OA5MJVk/kUkhL9UKlfYp12ZiuhRfgPvuefIQONMLJ+qT+VLWjr6qXsW
 QBsR0TB5Er45C1VRQbCcZNKLQy4zXmqMpYz25jE6SYnsXb5QbwcccFwEbMwCZWpFevoUgCWL3nz
 sfz5Fp6D6j1Q+h5D/L6dEuIPXhac9RbDElLApoj7QfSvOW47yTpwPSx3SmJDO+k8LKrYEAMkQQH
 ZnvcuCJ0zY1buYEZ85tT6PaYNBfgqisN45DrLA95l28b00Hz5I4kGe+9OLiEyUjQkrR+T6BZV5/
 4FfkCfKZMg3Sf0lgk2D8Lxm4ws8vQpJvVU15p/rP1OS9bO39+tl3kyKv3f7Frdhx0SDTDReicpC
 TpF2q8U
X-Received: by 2002:a17:90b:5904:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-39dbc0cdea9mr8900758a91.10.1789267378208; 
 Sat, 12 Sep 2026 19:42:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 72/86] tcg: Generic expansion of tcg_gen_abs_*
Date: Sat, 12 Sep 2026 16:38:23 -1000
Message-ID: <20260913023837.741866-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 31 +++++++++++--------------------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e040ce444ef..60f3ac4dac4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -147,7 +147,6 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -186,7 +185,6 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1405dff32aa..69df7967c76 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 401c7a16f1d..467542a7ae0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -415,6 +415,17 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
  * are of the proper type.
  */
 
+static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+    int width = tcg_type_size(type) * 8;
+
+    gen_sari(type, tmp, src, width - 1);
+    gen_xor(type, dst, src, tmp);
+    gen_sub(type, dst, dst, tmp);
+    tcg_temp_free_internal(tmp);
+}
+
 static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1495,16 +1506,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-
-    tcg_gen_sari_i32(t, a, 31);
-    tcg_gen_xor_i32(ret, a, t);
-    tcg_gen_sub_i32(ret, ret, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1999,16 +2000,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-    tcg_gen_sari_i64(t, a, 63);
-    tcg_gen_xor_i64(ret, a, t);
-    tcg_gen_sub_i64(ret, ret, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


