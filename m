Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B59C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a83-0000uJ-9k; Sat, 12 Sep 2026 22:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7W-0008R5-Sm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:10 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7T-00010s-43
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:06 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1974796a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267140; x=1789871940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oKTjxaQ/P0ftw4XRaZqtG4OPU5tOi/1he0v8iSZ88tA=;
 b=WAVKrPEIoUkvJ4LIfH4ia1ZVjZ53miUl3SI0wzfm9BhPWmo6mZ4PT2e01H+4PpoCyR
 yOgKsrT5t88vMeZgGNc1VP82VRthqgBNTCGxcodVIAHSUW8a7BOZPvtEQBPhst4qHU/C
 zqGhpiBUa7DlRoSnTt9Ps6oV2UZyF+GEtz/1bDnQvfOcbl3i/qQeAJ5BjK3K7D4FSLR6
 gkz6OKfvaFvhpRvjqAqu78grP3D4FBpgxv106wb1+vwxnYdm4VRC2Xc3GcL9ye8W4rd+
 whyREI0F4Z0PCVomJ4j6SuNUjh5ooIdCxHUjyAeT2fhA/ui3vE0S2zUPmTQZQ24MQCOU
 74GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267140; x=1789871940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oKTjxaQ/P0ftw4XRaZqtG4OPU5tOi/1he0v8iSZ88tA=;
 b=omuINWORpurDhl2QZxWVZniqQgCzeuW7wIUSNsVtMtFtL++66zUyDoeF55cN8m+AJc
 Pj1tVRZRoOmB/dG/+iHuRghm2IrX6wCpTTOu0hpVgQD5xUd7855bi5FOQTUdyiPxsCR4
 6neeVR4+KX1lX0ke/osJRXKEVKYcffLSUIw6WkAB2vJJvB40kBr2PbmHmjwuZxooYBXG
 GcXuDRu6lZd/vIqIvJLkzAH+kfbd4IJIt/CWurnd5wZLEXXvCgcm9svDPwpKfPx7h1hS
 vm1r7G7b80CZA0vjkPk3YkWXtsJ5FHVD45AkYePqllUxg0B/3jz6hzd+qjrG6pTj2eR3
 5MGw==
X-Gm-Message-State: AFuF++le1uKJn5dVGj/G4YmUuTuBlFNpnq/lqt8bS/sNjIsJx8sl1tqE
 p7sHIQZZR/RKn0juqeRjIHx/E77cd4dq4PXayAj5IKohz/47igH/gxpcYYLrKZt2pxJSzOzvlHo
 /gjuielg=
X-Gm-Gg: AYBFou059GG41oWviF9824rBU12vl82bsvXdHGWq4fI7mwXzWrFFCEgmmO8cHIWkZce
 Y9vMbf0nAKQEStm53nHD8mW3pGV/KCr7R0lyH98pr/Mr4Zlat5ACeXBSoFJb1ADfZ1nAEFBkhk8
 HdXfLZkHI+nobIkzY5N+du+iMTtSOguHyTUGuWBmCRZrzRftL4pYYcTUPJd0wKm6PzmXnPj85fN
 As4WnYgFjSZKSJdf9VYmo99o18O73R9cPxn4dXP5IlM5WczJToe95nAyBywvpuEK413pzUFNjKQ
 h5EvbcFv1unzh3ruqHJ/w6mHCzlf8i2/NcptSnaDC2/qEHDIsN4ytZ+lhVarb9OSyN4zdovNs/1
 9QeM5tbSOYGlrqTjW3b01PJhXHJ4GJBcoOV2na9JUsVmG3i5G1haV4O8/q3lAqqtmOPR80xgDu6
 Kp82i9kGZI9oUDpSnuFJoaGpT/SwE/tLOr/UmN3YqoKo0cISikbT8uzJ2fvmYFDLx1NIrMcbekc
 aCmKV4=
X-Received: by 2002:a17:90b:4b83:b0:396:b98b:a3c2 with SMTP id
 98e67ed59e1d1-39d9bd67a22mr19147034a91.8.1789267139447; 
 Sat, 12 Sep 2026 19:38:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/86] tcg: Generic expansion of tcg_gen_sar_*
Date: Sat, 12 Sep 2026 16:37:28 -1000
Message-ID: <20260913023837.741866-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
index 1120cd45e66..69d02396a5a 100644
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
index 8bf3d40971d..91e7f488738 100644
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


