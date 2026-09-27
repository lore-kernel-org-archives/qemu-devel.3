Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234AFC9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpt-0000rT-SN; Sun, 27 Sep 2026 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoF-0005Pk-LM
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoD-0007hu-T6
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1441863a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499872; x=1791104672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rEkPXMSWXNoSRGoSWGDfDahVE4EYg98Vs5PGaNTxmfM=;
 b=uAHZBYfzO1ruB49zbI3T/dYXEK14QZ0OV/Q+inZwUgc0CzwuGhcqXV3rMjdI4fITqe
 NCpIT02UpoJY4LNZz1xOOfFzTpcDeisfJ92yQEyzPKIslppPdz3xppnhVAQ3JTZi/TAo
 zfLIItDBIPY8ooS7KaUtR5OUO5jkxbGzsbzPvfZLNyErCBaaR2IynGsCYyyI8Ik5359J
 1lqMWf4Z/MaFgH6JcGZtd2UVfLgHEkJn0QPfR1gl9fKiEFv5K+Zo2dZcBI/0ZLJvzYwn
 rqBeftzeAxp6BIzv9x2g4Y14+r8sUzRFChGZtZIfOsfX0vD06O7/LeG0LItrW+kX7FYV
 FcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499872; x=1791104672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rEkPXMSWXNoSRGoSWGDfDahVE4EYg98Vs5PGaNTxmfM=;
 b=eC/LnTtlb3ABKfHFPMXY40M+xQ4vqXepzAoQPNiQMy0GLuQbu0f3jVFoUEYcO8f5cD
 OZNfH+7fBiKq9xWSDv8Bbb9C0TA2iQbaQ8pUxSLeiDA6a8ynbtVP42csiUigEv9mEY/b
 tXuY7S4U6FjRn6Q/9qS6srNedCrda9zb6fI7UpCCN4rSDQotshDNjNzOt76R+/2NsovF
 IrWKS5sizp14qUXEwjfyH/DebrcEKxk4CAcM7MXb7Z+OoKh2C66Tl/c/PpzJubytOPzH
 yMyOwojYsmyarHJMyoUX6gIJR5fX3garv+zRUB1XgkZ29ZOZDeWZo438nfwY/dd0ilab
 RSkA==
X-Gm-Message-State: AFq9FYK8fjT71ike9FuAuCsYecz3Ji0sPD78AGU3sstwUG55hibs+coz
 EU5EF37HokxIH5V9/jgsIV+l6/4pDn7iFlICAAvEmvQhJZzwvp0aYEbz3n2CZ/KgdqB+xXoauAn
 mVX23
X-Gm-Gg: AYBFou01W26qWNnwFtYrXhZSzUqkBKqNRKsSNXUH4J/XA5vNILtAbyctillaUZk15Fy
 dQ8uQCPd86oUMFUbwlizACV1t09qBOcvS1mYdCmU3T0vAMe0TXS4xTqRR0TiR9G9ByLB+v7cBCQ
 KtXyuI4pxOpdgWDuUuUr6jaM6OU1M7B+HIX7L70ERGXLo8NKdfFCcJ8wmiQ2s2KUZYjV1m17Eg9
 gYrVT2wAFw5lrU3cQcczPV+7pFsb/83f8LLMzZeYogYCJhj0ph6O4z3819eX9dB8j6tEg7+ZsG8
 zUnDkvsO6ZbXCNkly7Fvw2pBpo+9wQER8saLuWqFwEc54BUiKMbpD6qZkkHdZSz/jV3E0wMHf2C
 1BlwCvqKQAj5ugYVVin/SV1TTPu+gokxUJ8X+UrbCYSDCx+qhjnkMVeHZ9LwW7QBQl8+7HNl/P1
 tjzsexMwSuppBnMeivH6PeEOO22GCODIGmAt+ZH54LIyCP9o2ZdkRw2jEw64xhE+Wo33tanaKsK
 rEfExPHMRz+qjqGmXrzS8GOgu7Tww==
X-Received: by 2002:a17:90b:2b45:b0:39e:6a7f:1dce with SMTP id
 98e67ed59e1d1-3a098db96a8mr8902831a91.42.1790499872470; 
 Sun, 27 Sep 2026 02:04:32 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 074/101] tcg: Generic expansion of tcg_gen_umax_*
Date: Sun, 27 Sep 2026 01:59:44 -0700
Message-ID: <20260927090011.10724-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
index 79a2716e29a..18130617966 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -186,7 +185,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d1035a8c84..3c93c207044 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -60,6 +60,7 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 904c3ed0e1a..d16830c8dca 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1052,6 +1052,15 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1358,15 +1367,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -1871,15 +1871,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


