Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3D8C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1j-0005DN-3i; Sat, 12 Sep 2026 06:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Y-0004uD-2d
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1V-0007KE-Kv
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:55 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so347551a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209112; x=1789813912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PPvQr56N1JMqqNpI1tCgp19YiE6kvdfhS7ytUiOw4Cw=;
 b=MXPIAxS5HY7aUZmiKETSIzXMSZSk7/GxJB217uOxfcCPzX+tRQYOmMRZDZVWsIeljm
 VQDxSF8H73dVHNfntzYCGvsFdtWo6OxQIsUx9vPZyQfP9nG0U2nfjhbuIIa2wH2Zh75f
 Xvbl5diM/T4NC9sXY4+uQvdNJ8uD34zWZKoM+1TgXL3VlaZ3JgSQK5wmgqR68hhPQ/xr
 eecHo7s8mZTk6Pxfs9dvQ+/dg0/PvXi21SS3ErDzwJ9x7NT+oc5IW0Uiw03qHS9Yl62F
 IxebCtxbnNhw9rO1f0QD8clLjl/pt3Jl8E0tAE8j05isfG7UNnhKCa+3GLNgwxyUbR34
 v9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209112; x=1789813912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PPvQr56N1JMqqNpI1tCgp19YiE6kvdfhS7ytUiOw4Cw=;
 b=kaEV1XXVeDjxvNJf+tNTg2cEfR6vwZhfahcKb/Q0rC30QB7zc1JoXQdrCi3mYeNEQR
 rErGoqqewu1ywuFLidKlZGMBhgFi3D5LJWGpGxUqF311p89irOhMFjaCY3skpPhsxrZw
 Ds579xKbNhNY65UnnYWkYK1VTtCEbIK18uNfXNGCI3OPX27wwWQtwofby4DXmIoL3nsB
 5Cj8PdB/QS1PEsTXkYySpmxzuAxLT+Vfpv+yT/xLA8fGN7q7EycdFkeMo/H71SI0UmFa
 NQvI1GhADJVi4l+atH+FFQBKKHcuCMdHTixScMH6ywWAx0NsI6/5TwjSCSZM2hktlbEO
 sz2Q==
X-Gm-Message-State: AFuF++lNhCKqaZOMixmmPMDCVDlAX7C3AhVOP5Kgt0gK0mgB8OKl3axZ
 k2pg8BaZYQkt9I6FP6ROlcU6ZVsd/3wRFiEW1Rx3vDfnZTsCEL6PR5alS+VTqnUeSde8rwZa/vT
 0bRJfJQ8=
X-Gm-Gg: AYBFou1SDxGEJXZ/0xxEsgVoGiP8ilI2LnrKM9YSB5yE5x3xZ0a7G8Gp+pk01EpiXBp
 uet5C0DWOHgOh+KV0FfAwYSU4/wa8uORbKfpDtm+uaRjLyHdkx6XoUToWxxuFjQlXzBnK7puWIJ
 u62JgRoMQ7bHqDTZzVepIF8d4V4/RtRV+/mbPfrNcJ2IEv9EV5Q2yEfVzd4u20pSwZH1Xmw2Roc
 68t4vgK129PmCRYx3iaCKSikqP0B+fVlM8VKpvvSN9uKKA49Du3CB0dzDq3HaPiBICYRm8G9oUx
 I+NBeubNP445Vn40OzUSWWvJWMCUnRvaOjQ/d0WUhK3XN8dVc/wAVyUSIJxrZ7k4zjSYAXA9mGk
 s5c+SqHbfuJS4jxP8k1pACQzxOdNL8FasS+cyWUyGOOfAjZdRpVHyXgiglrBeFu3jRGMSjyddXk
 Lmf7Rc4rcKH7zA1ZYuybgmA+G9StF7oe6KNIBsXLzmQpw/t0WOwx5rjaZpL+dUxVVWKNC7FHYbL
 qAVTf8=
X-Received: by 2002:a17:90b:3b4f:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39dbbea461fmr4007014a91.4.1789209112131; 
 Sat, 12 Sep 2026 03:31:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/82] tcg: Generic expansion of tcg_gen_muli_*
Date: Sat, 12 Sep 2026 00:30:29 -1000
Message-ID: <20260912103126.598030-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                  | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 742af3665db..4cba6cc7448 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -206,7 +205,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 250ab78ec0e..247db4b15f7 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -7,6 +7,7 @@ DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
 DEF_RRI(andi)
+DEF_RRI(muli)
 DEF_RRI(ori)
 DEF_RRI(sari)
 DEF_RRI(shli)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 442c8e25927..3811b6721a2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -424,6 +424,17 @@ static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -630,17 +641,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i32(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
-    } else {
-        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
@@ -1569,17 +1569,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i64(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
-    } else {
-        tcg_gen_mul_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-- 
2.53.0


