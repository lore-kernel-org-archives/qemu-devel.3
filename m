Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ADDC982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ls-0004ym-W4; Thu, 17 Sep 2026 00:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k9-0003DF-Gf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:07 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006oN-KH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398a1676000so279146a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619335; x=1790224135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pBqAhA0+CdAZCUkJyOnIcW3nJZE20xi/oNfYr0M4rBM=;
 b=tCKxMyCmrulKu/0IKlaGfhCFNvwnW8gTFN+GBNwpNCfy10fPkSAQ+Oca+1AgI6+0qk
 sj9Au1MXAPHQu/Dc2GlPkE4/DC8O3NZiHFNeHKSSDXBPRHGwvsjcMxXig6XCvBsyWAQu
 y9o+WHz7QWy+BWe40+Wdk7sSDjPOdkVeXZOXqBZhXSPh/b1+ELGs6zOO8GBSEZlATDpP
 uwWG9nqYY+GdcmfV/PeIsuIW5oCPiy03RJWHotJxie3a11WV1Y1iKzkUwJUTgEdWhLks
 AS+OFE/pB7fjtomC5OjD0btsVw2LDYPCbdenNGr45kRRHT1b9iaImyVV4BkCGxsCJuDY
 j/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619335; x=1790224135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pBqAhA0+CdAZCUkJyOnIcW3nJZE20xi/oNfYr0M4rBM=;
 b=xWQPklYbUdEEwV8zvoKQ9phZO28puElUDi6bKE+jYZMi57jkN8C2IY6PxNjqbATHQZ
 pilSqcA0/SHjll26yJRWeJ0iH54fU6h4Pe6gj0M5TkNoXndIP+rV+wPzWEUg7s8yKiKs
 6O2Idv7k0te9bHcrYLZ1ZroytwKJ+art6Vx7FGf33jM75NZv9GDp4HwYM6kgKHQEE6+O
 7VxMFn+ZE7lErf+0zsmy5irKxEylOvUHx603hDkk7tasg+9UDg3jhMKgPlgND8WppK3q
 Ihyfvnvkxmnzcq140JHZP6I91GO6SnJ7ojtD+tn1gcuaCRqlWUE1P1zKcZbC6P+jzDIi
 Gffw==
X-Gm-Message-State: AFuF++ltf6uSBVrQ6kE29rid7ThsO5lBOLm0XNyKFVNh2SNo7USm9xYv
 4eMZQwpSXTmb+H2hGX0PjoD096DuQC+F16JRodJdp8nF4xfDDW2BHF/epoUFkmzQr/Wi4TrRIj8
 //IqR3jw=
X-Gm-Gg: AYBFou3e6tVpR+pnAQ0+VLxpjMfcgjlT65WxlUlNfXCcxIuS8RD1nUpUyMvXp6j3b7N
 0upNiaaJWFCoevjvopn6wG3BCvwoUyLwMbAdseTSuiUPKGoY/aYVOUh2jhipW9wP5ZbadfnWnw6
 5Gm/yCOv7/m5y2oYywZdHD5UEcXpWuKys5Bn3bWTbVc2yDtAV1vR27rBpPnkETQVcba+PZfDXa/
 7Ar4VSvt6Msj13SFPRTlpGEvctqQB4MVz9ddH3fhGY94oIcKGmbemA2oJuPLmGxOlFstx6iecHa
 ZEyGInC/7XHGGWUFyaDFaBcPXZxOzZ5vpBH/H8ycHYdaXFm+024VSr1i+lpz8GbME5c9Ds1jxTC
 8JPjgkqntCCSE0CyZPX1L46LYUMKWVNclgOXdXYZTsAkZb28k7MbpJI9B/xv7oC3G5wuknwHQne
 swr/fZU11QJ3S1HiiByJDlAu/SD55v58Gy2cb1Ido6m6KEDZF/j8O9pLblfbW69uhQhuejOqLCL
 16vbcU=
X-Received: by 2002:a17:90b:1d44:b0:39e:1693:c3c1 with SMTP id
 98e67ed59e1d1-39e1e4c8bb8mr11968397a91.17.1789619334464; 
 Wed, 16 Sep 2026 21:28:54 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 026/101] tcg: Generic expansion of tcg_gen_shri_*
Date: Wed, 16 Sep 2026 18:27:08 -1000
Message-ID: <20260917042823.542588-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 14f8dce347e..e8ed65d8c15 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +215,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b98e5bd80e9..b95e51a07dc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
+DEF3(shri, TCGV, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1546fc3c094..99b56361558 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -473,6 +473,16 @@ static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
 }
 
+static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shr(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -564,16 +574,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


