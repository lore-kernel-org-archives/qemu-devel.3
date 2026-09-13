Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3602C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7f-0008SG-S7; Sat, 12 Sep 2026 22:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7N-0008P4-UT
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:58 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7J-0000yz-Lj
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:55 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1081691a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267132; x=1789871932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+8MQSnyMlYG9slzqZhuIISG7vwQW8e7wly87+e/kvFg=;
 b=xH/Dl79Cyfv0NSckaSIYsutKYQrKN99AqLh/fswbaaU6ddUUttKbFoI2PUl9tjkK24
 Ufd9yCBDo1PhQYBA5KgGmtEmEG/MB85N+qo84aN0k+te+zmShTpfDHPPfbgM1WWMBHvF
 bHfCAKoMwEZS+onAUhj5ZhucMb+upHlpFimohNhkLlHrOTvsFi1SIaJ5y3k7H/I3stIP
 GHU2V38254oB4NaQjNMqEKZJPXDjIXXDqe2/lQsWLYzlDhs2AmzsLBsCmNq4OtGcpZJ2
 aogkG0eKmfbgViGUKZw0BejKSEuuuudkMWRXJ9EhoPRrjTQQm40hFEWIYwNrs2RMG/SD
 ggYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267132; x=1789871932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+8MQSnyMlYG9slzqZhuIISG7vwQW8e7wly87+e/kvFg=;
 b=juI86f0NB8vifv9KcYrxs76xZEPOLgMa4wdWLLb218XdabIk4ibwykzldGNGM+5Zsy
 yhrYgvcZkHZDuOIaETObv6d+na6Nl7Av1H4yIkzJrVtWfq5VIN2FAFGIUJ/4rfQ64wdG
 cHGQFHeW/SvKDkxEHf8Y/L26TMvJgPo753vIYr3Hszl0KsshUnm1CJQOkyImkUAOoLf0
 wS9cHdCtYAe3phpvmU1DSNvKnVD55lGFVkKfxmhCSWeCuMopD3r+2IZwOb22uaS3D2e1
 cvqF6a7SAcGU7bkrOgTeqg7jbpRmW2sMLr24dtpLsmkRI0OonPEpt1O8cBYZsEgD7V5f
 vWWQ==
X-Gm-Message-State: AFuF++llzauBECxbZQ9nywNkUJN/LCKprjRhfswqZKQaCGfDjHHpWcJe
 mgIsgi26S+PaLhpTkk6O20Vki5G4FOaxzDIZHvrga1kmpg5jUhZZhZBDBudMnvn0O3ZsvhRrf+w
 d7rIXRV8=
X-Gm-Gg: AYBFou0x3jcYB/dcRB06EhZeGmCZREdUPX7uczhMTWYR4B6FMh4RkjL6+gJzPkdVU/h
 fKXoYWFbgiRmi1JFd9MIvFGn6kDEdhMG8zMzTJvA5tbIPwMtRQyvg3ptjq+cu4Z+uaHAcdgEp+C
 RllM4Ki5rg+TkNMSr/IxVuHoInZMfFGoMx5q/CM0PMTh8dmStyfhUW4yGY9e8cDhalGYhOy3OAN
 xOQKhLVWYkuSv8Sky6KPb9ZjfggWk0/VSwjNKKc6+tN2vXUmIqEoWjRi7iA/AVOzFzU24C71hoe
 bI9ExwbgrujfZduQl4e80F9rjG3tD9Pd7fxo4FJVjbLDpF2SF7T/op3EqJ2TZwGi8X9VhTqN4li
 ASprSutyCCPiikUSijapQc7u75yOGAY4zwhLqfc1kgVf7b4bFpziMphHrW43psXXfTsY2MMWqQs
 CSyt5MyioVfme9p8VLeKeZ0aRO1qjaG+PJHgHWlghz63xmVKY3TmCkiIiJb8Ouc1LlYssxRPw1b
 Qi6wO0=
X-Received: by 2002:a17:90b:3147:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39d9bee5d69mr19539872a91.10.1789267132150; 
 Sat, 12 Sep 2026 19:38:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/86] tcg: Generic expansion of tcg_gen_subfi_*
Date: Sat, 12 Sep 2026 16:37:22 -1000
Message-ID: <20260913023837.741866-12-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 21 ++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e47b9ff913e..4fb6f5f6e14 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -222,7 +221,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 77b1260a292..9084171d6fc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,3 +8,4 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aea89088a1e..6ebf7fff4fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,17 +443,17 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
+static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
+    if (src1 == 0) {
+        gen_neg(type, dst, src2);
     } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
+        gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1562,15 +1562,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


