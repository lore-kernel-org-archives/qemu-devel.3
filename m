Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C60C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1i-0005Cs-WA; Sat, 12 Sep 2026 06:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1O-0004oB-Us
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:51 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1N-0007I0-9u
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so2422251a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209104; x=1789813904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ktgOR3sto0pBJUBW1S0kol+3qf82aEqXt9eCMW4wkSI=;
 b=nUUS5x3Hb0eJYynyfibkZgkoE/7x5tmW2Yn2wcpGjaSMhauY7j45Iyc6fxwnf9quHG
 qsDuMCVMCSfoFAyAqEhvwXnK4ERNO/pNz9mhLhS/gwyo6vmkQZHyQesBgsbHQqqSUtoO
 tK63g3SkEy3KJRsxIRMc4/NHll7uSSAlJSI3j1NAqr9pyGbcY/RZ2qALYTGX7YsSz9CJ
 14iFFDpHtx+UQtgd+D4X0UKwvjhv/kSKT4qsmc9AO28uHScjacxCJ7UtWUss2FHz0Z9e
 uHCPjRDyeNYIsse19xJ3drT5uOiylEBqD1Si+5YHV1XG7v8O+A0JqXYcGcZX/E+eckfP
 sqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209104; x=1789813904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ktgOR3sto0pBJUBW1S0kol+3qf82aEqXt9eCMW4wkSI=;
 b=A6kiHDWIJNxyTXWQEG/PAv2C0uYzgnrfstoBP/e7gKeJIrehtcG2kO7E0+ADL6/uuC
 HVxKO8fy0zcda8cmMtBw1N0r+mNLoRQIzKsExD1gD5xEy4TZfuAnXVFTkWrrujc7Zex7
 ONVryXTqSS1ED1fGaPCRrG7SF4hMBtIiIx+7FqOJE6PFDSXjUHkymJbKA8LZaNfrcGAf
 ibW3QmfRLuxOVLWUAp1dIVyNGaahqkIK4bLtKvVt4+Zcdu7rV7b7Mvto1QqFRrqV5u49
 iIMX4GiMmoL5AYhvD/g/GC43wY4nCh94Kuvl7boSDuDV/ui8a6kJd6Z5zScBTLTrvfHm
 3+2g==
X-Gm-Message-State: AFuF++nvJjIfIRkLuWzW+NqPKybYUquouIy/kuyk/c7zlq1RjeCDXmdx
 LrdH4+s+H7PqM7nLt7lCVIfCF69cwqQ3M5moCAWYYHnAhElKBHd9qy2KH9AY/Ni9SH8k4yjGnAY
 LqDdHH8E=
X-Gm-Gg: AYBFou32+/sLRJ2gcb5XwS91eTtAUcbOFwLAWXp1DCq1xDes1DVCqB0BOO9cjMZwiEZ
 Wi3e6WgrNNMDBpUsIr8P5lKUj2z1LL/VJKHZyWpoeN4uJzgJYT3fMBXOhnoDaUsK6ulOTICy45R
 IE4Vpygo7pvsqbcjak1XKWdkn6h83PqrbCHolGDqgvwRO6rHQqpGeivG7aYGZjGi5ep0zFWIKD3
 G3cLX/uQGj87R2PQv8cpxsDARwPzGu7C+gni5/Qqeji0gYylA8Jwif2eixAREjkyJJHhltQRNJx
 ylImslzvq/NT2b2umO+Eo/au8Zg7g1KQFDT1HhniN51FPw6e5LwEEUyAIYtDBTo481/gcJMQYOW
 viVBT9257U8vIadhJG1jiwjt3drgFa93wAnL25ZOCQWBskume/yvnomuhFLJo76f4xybHOgNxxb
 9ebIzw2y0x88zVsI88baGUj7XX7uwL8FuK3O1EAwIkzWv/aj+Xbrw17OhGQPXLs+MpJB+8Xuds+
 uu39os=
X-Received: by 2002:a17:90b:4990:b0:396:4cbf:45a2 with SMTP id
 98e67ed59e1d1-39d9c0acc23mr14358070a91.14.1789209103922; 
 Sat, 12 Sep 2026 03:31:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/82] tcg: Generic expansion of tcg_gen_shr_*
Date: Sat, 12 Sep 2026 00:30:20 -1000
Message-ID: <20260912103126.598030-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 76c0519f26a..1e2d30b7125 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index f2c37dbdbe8..0c40df31fe4 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -11,5 +11,6 @@ DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(or)
 DEF_RRR(shl)
+DEF_RRR(shr)
 DEF_RRR(sub)
 DEF_RRR(xor)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 406bccd6066..7feec9c0cc5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -404,6 +404,11 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -542,11 +547,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-- 
2.53.0


