Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A48C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJj-00017H-B8; Wed, 16 Sep 2026 09:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJU-00010z-5l
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:36 -0400
Received: from mail-oo2-x2a.google.com ([2607:f8b0:4864:31::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJS-0000IJ-JP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:35 -0400
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-804e42309a5so340924a34.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563872; x=1790168672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zFSVA5B21DK4J9Z0Sb+FVIBRZ/HkG3ySKftoKO00ANg=;
 b=zCG/IHYa/lQpz7OD6rOBSBpPUNXWL7REvXRjcMeXUYF1efOynpUKD5iB5H47K6MNDW
 X4gZbbYnBjUB2hzZMuJo1otAuozqLvAvXZZi4q3jJt9AKw2dnFWa0kGrGyWTk9a6pvvj
 u7chkb2zq+AKtuBQjIorXDQNUtYWluJym3OV+pferD+iZIl5gutEbBRFnv0LWp4FRcGI
 KT2VHg6be5xHmPJxFpJJ3D2uo1RcAbZy1nJEC95wYs00sYraLzaaYUJk2oWvcrwpTxnP
 jG87cgk9jzWVkX0CZdCewmEapV9Z7f7ckPLstn9noicZsS0yjzTTIkrBuVTqIkcBeyKY
 yr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563872; x=1790168672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zFSVA5B21DK4J9Z0Sb+FVIBRZ/HkG3ySKftoKO00ANg=;
 b=x/2YvrIje5wvjNuyPuzK3v3it2hy/XVO9lm7s5j7wbfZ8Gz4Z4Nap7IGt4i1iEInWC
 iZ6/BuZ/zOQH4kSeElLu8wcse+SsMCI1gAKSDHhU5AYz2jqngoecohpM2yUxGTWZTzKK
 Ns1zIgYa/zu3KUWk5gXD5JM9R6hDo6gBw59qCXblHkQIaOvRk13u1kGa9RcKkT/s/189
 rokLrim3XzbtM9j4+MHxTCoIN1yMt5mjxTFrQDdRYnqBP/I97YgZasYR6iMM1oEDGpTv
 fR7lwM7kFV8SK4PX4ctpEhhZT2o+Dz/GBvxPKeTdyDSIXsiFAy/btmvOpXD4Kyg+Mm6l
 OCaQ==
X-Gm-Message-State: AFuF++kkYNqwpjRb1ZibInpmecfeK1yuXK1Vm+9XQWmITCLgY+KDRfZv
 a8w1fHyXN7DOF2Q4zl1TaaUlvvGz+SyM9nir5Airc+k4OBz7Lf9CzF33NbBePrv7yP3yZ2STDIj
 4wFUMVT4=
X-Gm-Gg: AYBFou33aMdtwKjWz2XA8ApTrXvh8G8L3zjUKlvde6dK/nlJUQ/IWvLKddCOT8esK7y
 Fws5tgE34Ac61J1Z7WJMQOz+9vjUryFh9OwwM+r8xY8Y2SQ0vXMFgd3jX1CfofcVQEXHVv+kaPG
 HwhE9oS95AQ4hAPUsXwRiIPUZga4UhlqTijJcFElPBn01Pz/wWwkOTUEO+iApL3QnJo6RixoBTL
 rn7+sS6P5mH1QXCDZ24RD3MIf8LlPI4BRWoFUlZVt9tE3j3iL+F8TQvM0LncvqkX5bXCH8uSs2V
 8qaCT7aPrzGR1Wvw5kyWAB2BecK7arWOrlk9wAOEisBkeNgclVPIaiHDOIUJGrZHzA6M86HoDbM
 QbpunwuSOlzQq5KHXcId3WZBpEdf3r3gcD8qHCUUfYzRd8hmEVggSIHxXbX0FMf8VUx3pEpZeXh
 X2fwNHikWHDf2Dh4ucWT5WxgHLBQQuDonn0woqGmRyKoqJWNkPa4UWNZvg2hE92owdZ4iFFwzja
 /DWNpU=
X-Received: by 2002:a05:6820:f06:b0:6b7:46e9:96fc with SMTP id
 006d021491bc7-6c7d39f9c02mr2420806eaf.44.1789563871781; 
 Wed, 16 Sep 2026 06:04:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/92] tcg: Generic expansion of tcg_gen_sub_*
Date: Wed, 16 Sep 2026 03:02:46 -1000
Message-ID: <20260916130409.3382710-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2a.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7e6e17b2316..6be93865326 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -212,7 +212,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,8 +314,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 31982e2dc6e..aac64105175 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,3 +5,4 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6a5081cf74e..be0db3195c2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,13 +428,13 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
-/* 32 bit ops */
-
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
+    gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+/* 32 bit ops */
+
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0) {
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-- 
2.53.0


