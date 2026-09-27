Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0587AC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkky-0002by-En; Sun, 27 Sep 2026 05:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkI-0002Sc-Nx
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:30 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkH-0007QI-3d
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:30 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc791f087e3so614368a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499627; x=1791104427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zHTDtST93KYa/FyBIm9srRripfQSqnvvwzDwYhBxh/U=;
 b=Hs3goIdp4KUWBRqsfOwTyrrAh0sP2XQGAANxh92xpsSRE3s1xP+BN5GnsGJgb9aB+q
 HEvEHIYybftzHHHTFyA59MKl+ipGAYrut1/s8aTadhpEE3pbguqjtrWmzW1orQDQ2QDS
 GEJO+/fiYO6DsogMrCrwrFqR9ysK6OI2HHof23Q+6CMmZAYIF0Tx9LiB4kIDgUOxnbqG
 LT7Y8sWLwE7R2mZQiEEvqvYrBqflUWLuaJYCpefr0PvbhBvQzNmyu92+9oMwzsm9oYcB
 MGI9ZfdXPZDQREryJd8XmP1BLQrkV4EfCegwntDE1jIKHsqgjFjzFcpY5w7m0XkeiONd
 e42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499627; x=1791104427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zHTDtST93KYa/FyBIm9srRripfQSqnvvwzDwYhBxh/U=;
 b=kUuvAFnG4MsHHgPtUay0097yTJRzR9SZbFIKJ1aC3NaDoUF1V0kUyTRm9ycsuOJyLr
 YqqM5FKdEuZPqLgkOOV86PFei8n/S8Aqo22K6f0v/PVzydmQgkqCzIaXjbS9PPKkOhBF
 Shkky6kPE6qKifPvqdgPRQHIEmnQD/D1B648E2gruOv9nJjU0JxcisODeHZD0yQxu6Pu
 tBuMahcOyU5+URZq7iV8mh5MVURyLr2kdLqpvEBvfvy5Q5+zUivOl/8iZ1276QgjlTmG
 /FIufW793bKQysJdzi7o5F2daeL9/LFdnJmCi3FWheXQACnzCQDE+Rmx6fOkBcmenuIA
 U+Ow==
X-Gm-Message-State: AFq9FYLsMb9BigZFsqNIK1EMWshozLCFViTZ1ADnnKxNUqgbk+UCDk4K
 9NwvtJSttSQPAR99s8zXh84Ey2rm68efiblJQachWpSo1FUIutUXytckWfedVpiiSNzrho/kZNB
 TEmSw
X-Gm-Gg: AYBFou3HfE55cRlnhRHZ6yR2uCIKGE6KikIdrsxjjbokuURNllOpVpWYiwxci2qhB4R
 aE5D9WZT1ylllYWuckg9dyctbtIt2iJBBr3hD2w1Wb0eJbZ8c0k/k3VAEqlFwBbT5UZVpffr9Mz
 n8syY8LKpBkUpfeyk6EJkTxbFgLN1rvLKStmYrvwEyTXwWvHds3CmeUF3k2tgk3CY65V8atwIs4
 L6B4jGp7F161eD7ws31IhdrfGw4JGiswmHZxNLs3FDH6SbNRWRxvt4Lm3GvypLSXgR3fDhKQK6b
 1LxFczPbuCx2LeNGRMUayMoGaRSRj81zM237FWxdfOzXoBpp6JLZ7H1MB+9Bn83EAsKNNSAaii+
 TaQ7gT0GHTdbjFdn0yERGoxU9ikSS3RmdCPYsmHVy08+pudL2/9YUOUrLE0wCOfGCYlOdJGNLF7
 UrRKvUI133dMQqW3U29wF1R7MRmE1GG6brGRsMPBArJe+REgriBIFsKLC0ogCpw8Kpf+uBpqhPx
 E6pWhFi+sE5+P0qs0n0qrvjoWEv9g==
X-Received: by 2002:a17:90b:1f90:b0:39e:6c69:f47b with SMTP id
 98e67ed59e1d1-3a098d4085dmr8782520a91.58.1790499627397; 
 Sun, 27 Sep 2026 02:00:27 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 016/101] tcg: Generic expansion of tcg_gen_neg_*
Date: Sun, 27 Sep 2026 01:58:46 -0700
Message-ID: <20260927090011.10724-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ff15e3b88ae..bce6be377ca 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -218,7 +218,6 @@ void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -327,8 +326,6 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
-
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 55249c4dd6f..b5ede945115 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,5 +6,6 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9bcf79ccbfc..37135fcf4b3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,6 +394,11 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -415,11 +420,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


