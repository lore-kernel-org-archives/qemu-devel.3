Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AFEC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBQ-0004fD-45; Sat, 12 Sep 2026 22:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBH-0003h9-J2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:59 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBF-0001zG-JZ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:59 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so670851a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267376; x=1789872176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=be4Ohqq/4I6ywrk9oMZFbpAurRlw6l0Hv9verrAT4FA=;
 b=RqURcYtSiB0sG6NH8H9MRYKtkdkUQlWol8C6yzDsuOIiO4nVeagpCdZcXnHGxDjdPq
 nbaluq0/buy0U41k5tqy/geVb9fUsxQGz+08Iqw0NvYyo/EJG7RczKJxfA7EqluqfYKU
 O7LMFsEImOl4ZNQW4wWM/EXkKRjxDqa0HHGZAu9TG5/4eB8OvMxsQ7hFkRznUnpTN+dU
 e7cbblTTKLADvw1gcJxfUSq93ZxXmK4IbY/lXpOKGZJLloNliPSgqRW7hJm/ISZZHVXq
 lqgRuK7u4FCBTD2oUHLG2fGty5aZruUUE77DWV3nxWCzbE4jGAq1LCmUgfEfOFSyCHpq
 eO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267376; x=1789872176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=be4Ohqq/4I6ywrk9oMZFbpAurRlw6l0Hv9verrAT4FA=;
 b=oHH9ZDZeO+NZDLg+gQH3DWMH4tfcFb98F+k/ePAwVz7ha7lJWkSrZfd6XSEEgMZd4n
 3l6GaMbV+ikrH63IakO1bee9a/fbgZ+DPEFMZqhyjHZHX96Xs6kglO9NlniaPpf5xara
 +IiRtS4DpCKCw0M66KA2yknnzrET2DwG/P+TCn8dhKhrHiwRM9UYpkmgSgwnE5Yy8PWf
 04oCUsq86C1tb5IE0YIICR1Ttx3PrfLKZyNVRaPplc8MOwWTFNQMO+adn7tN2Q8wOY4w
 1tFyWptCDNpTCP7cEdLtBqkNKWzQeKAqhY27IEaUk67Xyi10aKWaCOsNByYrNpWNLYUW
 snDA==
X-Gm-Message-State: AFuF++lr021p02UvFB5JvtynKdgMCdkp+3xyaSg4iHWPQVqjoBLivHgB
 E7+By25KWmy4peZyB3oO5QtvwPhpFRVDkqbjtqFDCxAUv0nloueQZJC9204llEk5JOWt2HogccS
 PCquNzuc=
X-Gm-Gg: AYBFou32MUjTzxEIkY2Qdlbg92Zuy/MaD3a5ynbYBiyhu4zHzqJ4TPO2b00cIhAYgER
 uT7s5928Jsj9AYs/Ll1rHKsQ6R1ZCJxLnLNYYs6WhkWFjJu6dId3+ZtMiRczmkQyXGcjxzqSbsw
 f8fVe/zrABQymVZkwKlzhXzKJFVlLuP2bXUA+pMTNexlr1hah045rt/9zXMhrHlaSrjYKhkn4rn
 8hLcX7sMARJN1jFlqC2PMgwmZ5w6QbltLiMts5K8q3Ja6AkbXrnjNmPHCTxxggcyOrSkpM3SyON
 QdZFDPJTHDt7VIpMWk6lKV8nKuxJCvk2z+ScEgwHmLWCzB4bQqxsYxHPbj35zCGkzrpyW9ivbaS
 5AaT3107WJJ2VazLIbRSBiKMtwGKX7Ww7OHve1tdsln8ziM3wB0B/f9KYgZdpidApB+DnDA8Gr1
 fSBydNajn14LF8fmgdlsM5Hmr+bYkSmB5DuvCbWk29fQwGZ2QXkNByol97oDq9ookNIkmvfrymL
 6edIOE=
X-Received: by 2002:a05:6a20:3d02:b0:3d1:e510:905f with SMTP id
 adf61e73a8af0-3db0e10338dmr9037729637.1.1789267376240; 
 Sat, 12 Sep 2026 19:42:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 70/86] tcg: Generic expansion of tcg_gen_umin_*
Date: Sat, 12 Sep 2026 16:38:21 -1000
Message-ID: <20260913023837.741866-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e2785ca61c7..8ffd722d9a1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
@@ -187,7 +186,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a5330ab6a1d..70f1fc48a26 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -59,5 +59,6 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8dadba7ab95..dc472328300 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1170,6 +1170,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umin, type, 0)) {
+        gen_op_ttt(INDEX_op_umin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1467,15 +1476,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1989,15 +1989,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


