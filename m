Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC69BC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a80-0000Xx-46; Sat, 12 Sep 2026 22:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7J-0008ON-Jq
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:53 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7H-0000yH-Mf
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2524135a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267129; x=1789871929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=shtfjlfCRmxS4a5SbhP3nQObfBjAyQ7lsSww9ThsUFc=;
 b=g64xuVpzUReSKSWBWxVHMU9P0J+Gy/hSRIfPoOpU6KR1y6ptaCSi0QSfjYjL0pWnlw
 lJGXgHP4dGZEU+6NxzUc8HR+rDZosR4tXGiTgN2jpONwrRF6E/GNfMZ+ewTGFTCt5KuX
 NUSFsWnUfXc4X/qW6HEKMfsZuZ9JOwj6X/eMl5oyB/OvaSntzccbBFRJsUdInifEFcI0
 UkrjUMZbHzp/kd2eAKRtdg/7T29uBN23uUkWD0/1Q2EmyulHetQLWYyrccy162ABieQ6
 tmDpEklwTf54xUmKxecbqqLmzg7egtLfNZRwQ3hj542llN0sVM+C9IIPmdck9FkJ3G3u
 zqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267129; x=1789871929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=shtfjlfCRmxS4a5SbhP3nQObfBjAyQ7lsSww9ThsUFc=;
 b=LBcyR665yB5t9XMM52HpsDlUsGYi+tIIq58meOmc6yu3Rmjj748/6VKkC3fpS61FN+
 hdfGNGIx+I1hkQncY2Pf5NA6wVcWG4xCgfy4uLggZiJ2MHBpb9vfDGcFDRUMfETlEtgo
 wt4619ozr6wbXK5leb00xo/vZJXQeXTNpxvs/kTbZX/OhV6lkA/uulCmDM55l8Gsoz2P
 5Pyt7bYQZMzGpQiu2dfwXSh67dJm/cfQZfPX7Kit3hs7AZcK/WWV49I42jqSQkhGdTzf
 aHKm61ojyfT7Rp6inMOULErpYVLsDa/NxImsiy+puplggSV2YGCJf9kQuiluIIWNncG8
 B9WA==
X-Gm-Message-State: AFuF++mqzeGmRkK519Vq/a16lKhHox33+GNz2wAibJVlosPipJtLzFcx
 OY/GQ1Pnq9mfHAOD1wNBnU+G8A4TF904/z+xtWQYtn5DMDB7ncegzG3hbhfunULYm+VaMbccGAa
 CZV9xMaQ=
X-Gm-Gg: AYBFou0vvFmo2Uaxfy7vciYeVq4va+7QURRgcSOSqXzDBzEDGKR00WhR9bmccBwgz73
 6em9AHw0Gpgkh0lJtAgU3aDoYmybvXxOElQpp6rbAhQNZpkwY18ezsSfbaKt8frCNAdhSYvpw4o
 7h35imVBk/VUvqk44sB1t253NZDt4vZxiAfya2CDblDcghszZJew2UQ11H3DBH2F2p+2HdN3j/3
 knpvrosB0heyZZ34ZwIg/bO5oudzZ9tLl1ubcjaCVH3Bb8weRLx4aVwgdLpi1kEHzhwSuW2SeIa
 5r5yviwoU+01vbZK1JSlsfT0qZVnT0jO0dG5dVoi/yLOcHbSfyAUFw8L4lJx5ptKdHC3kyZkBo5
 aPZJVp5vEDmBhg/jGH2xswuC7Htz0r2gO/u5KC3aBZHfH0CvyDvQERjuFn8X6NFduYFsGlFEyD8
 07K3Cj6p/vkzj50qXmbFmhD5S6Bst8eSd2i3QeUJTIaAHGIFulOmGEg51UhjuWZPvv/KOXL83nS
 VxVxzw15RJ5UYT34g==
X-Received: by 2002:a05:6a21:3b44:b0:3db:5b7:e9c2 with SMTP id
 adf61e73a8af0-3db26cc4b7amr657876637.4.1789267129386; 
 Sat, 12 Sep 2026 19:38:49 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/86] tcg: Generic expansion of tcg_gen_sub_*
Date: Sat, 12 Sep 2026 16:37:19 -1000
Message-ID: <20260913023837.741866-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 62487268a2f..787dc158c02 100644
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
index 548fe84b233..3168ac71638 100644
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


