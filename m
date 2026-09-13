Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070ECC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a81-0000md-Kt; Sat, 12 Sep 2026 22:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7R-0008PW-9Z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7N-0000zn-MZ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:00 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so2293740a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267135; x=1789871935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=REvMROJaNuwKArWxHSrIlduaGoJ8M2pKQ7U3wRkbv04=;
 b=ka6d2Q1ZeYe7IRgQVL4Dmn3OHdC5QEILjw3J+IcLKok21RLFfochmQs+lu/Xj7Qpjt
 wfRQZhQyqfEr6wa9xbV01JOaNoSWYVTSEHMpsnDoB4EOxYzZgxfYLFp5BB5y6OM1J7G8
 V5Ibk6zMy9nGRgbPxW3hc7XL8kcXFUinRiNh8Sl/n5sBER8U0iVQWfBMYG90AYD5hCdp
 nXC+876GbSyhh3TBvE/8T17jnu9xx0yZJm1T5m6Ao4mH8lmvuQBSjBbplPPgzaFHgU00
 3ej1IT3FvcIJR/aVL4HRO/5A1lqOA93BQR53SdHXEN1W0axY54Gz8qmlMe9ps3VFDAsf
 TqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267135; x=1789871935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=REvMROJaNuwKArWxHSrIlduaGoJ8M2pKQ7U3wRkbv04=;
 b=OIV0Lt6J0nPnhZXkim3dGuDPlpFFJTy+0QWG3OJzvu0TKIMnKoNeabe7nosPfvBTZi
 +Yj6Z1vcZXJRlUVe1j4zdnK5ohSx8pkBnaM8PbQTsqAVkHKEMn9arLSm8C/VkImLt+/C
 s/Iivp/bf+VMs0d9qymeJOQ0+qYTvOkUHBS+l0OlMUm8ib042QCg2llZ7eawc/6D6u61
 R5kHA+F19pq538msebZIuf7rtB42cRkFD4iHsweff1A/svY9K8OOxlnz/Ne/TKX5hkqM
 CKYxssklEKZCGNWWOWtqoXFGY//b5scu/qUEYnhQCCmogU/EXlfhz4XnhQ1fNCthY4gf
 x89g==
X-Gm-Message-State: AFuF++nBGITVp5iYB7YnR+G+N8tZOSyPWEzg1MfLIMv1fLhj+UsfV0lj
 pc2nhlJEH2OLE+RSGxX1+ghHesMbgGZqA+OdOTyQulG6iN081Vyk8DKbC9sVD13UDKu7En7CN1I
 Yb2ESAAI=
X-Gm-Gg: AYBFou2VJc2xqIHJOOvALecdIcInIogB3+kH0SBlG43cFDLqOjwn0h63K1Pz3ydt9vT
 MhuEZCjA8EEHcPRGoZNVivJjsJiT2vQI9Rtn0vMSmXQb4QsfcRF219MigEw/SWqa3/XxjYLGu2L
 fufvwqI2wWK/cby9dYQhI5m4FD9IcolRJAyrGP3YfbIdID/07cHb+b/d8dR4p+AyGXblWr4enCY
 ps562QuXRUxIDUzaahPx8G+l5YJG+wRLK49qk1aVqNBijP4Ip0ST7sq47TUAF6Z4NwXasxWOs4Z
 DzEipb4Q3ebe9dMNqZfaqB3ve9AOHOdusn5tL9WlVJTyidI1ILzyNEsCXRRggkVhAgBI8lezVFV
 na2sxtO9GInR47B+QfxJZD5yPQd+2kowWMlbS61V9u1Kc2hFjVjk7U0dLOZJrNWObD5rIfg7MVb
 XOvZPlosPAGpQ+vDusBQYUJAuw0lUEAJG7/ychA8+BwWjQEjqHnGni9YS/86ZiYlFoGz5HLOKKb
 MO4a31boW22RkELZg==
X-Received: by 2002:a17:90b:582b:b0:398:c0ad:711c with SMTP id
 98e67ed59e1d1-39d9c1d1f85mr19661805a91.15.1789267135017; 
 Sat, 12 Sep 2026 19:38:55 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/86] tcg: Generic expansion of tcg_gen_or_*
Date: Sat, 12 Sep 2026 16:37:24 -1000
Message-ID: <20260913023837.741866-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
index 74a917f984b..1159bfa5233 100644
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
index 6e1b1c04fdd..34b3f9ba96b 100644
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


