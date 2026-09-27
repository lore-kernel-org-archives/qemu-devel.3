Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB007C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpc-0008Pt-BS; Sun, 27 Sep 2026 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoE-0005M4-5X
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0007gs-Vy
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:33 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so842393a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499869; x=1791104669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P4zI6amx5vIuGOPoHhH4u+tC4e1lQvSyPyR7n0HW3co=;
 b=uRk/6AUmDo3hsFgn/Qy42KSASQlm3Mjzd+iE8ciHHSVEzxM2jeRFUPrZzekQrgT36q
 ZZLw4CzzSC7STDgJ99fyu99f7Npq13+DbLSxf75teKUmfKXW5C5U8B4UdAYeNG/Rd95H
 hlqWfamf8iejb/gpzOpYk6dJZX+cw7POJjE0LBMWu1gg9jesm/c2B6U2mWX594P+Kyq+
 oO7N8j+8bm4rvskpsoNs+Vb/XhGzUMpPYpTrwTBjM5hu7mT80iPBQkAfo4CQvWIaCKjK
 tQddXB2SOrcnVDg2HTRLPt8fzrqdHcYu3h6iZK6W6SsmtbJUNmjuVaZtlu8i5Z6y7xI0
 KJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499869; x=1791104669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P4zI6amx5vIuGOPoHhH4u+tC4e1lQvSyPyR7n0HW3co=;
 b=2uWcVvTprIGoz1BWq6hRPpbxCxgCpTOPwZuE0jr3W6BXHvgEbyYRk6UnW0PP8Bu2ob
 PwHRnazH3hx9hVRvc3Zpl5e9hU4qm8EaV2KtJBZlJZ270G66+884dvDtJXRm98PcN+l4
 xIyFc5LmRNuGfdNSyIbN3eD+wESF9Aj/HOEhDpJYIGZKHOT5IdaR0UBXx2/u87IcxXrx
 QMfgepEvWBsMDrsLYflBUUQ5g5OaeiL6YMKCKXG4FFB4cN+KDozV1skmLR5I8u/Bo6Ok
 48HvDBIBquqadvwTXy09TOxVBvbeBwbkQvzLtMM/g3vGqjTCVyNVspI3XbHykw55Tl27
 TpGg==
X-Gm-Message-State: AFq9FYK7UOnZYamPCPyt6FWWQ9vC/OI9tYtnX4ihSu83CNYyp615JW3M
 UjY6Kcv0VJ+CQS6YUOmubx/ybaDqUxZLKYqoX2QLQzH07zYgYsKfNM8w0GBSB+XqfSnR8i57Tjc
 izAmE
X-Gm-Gg: AYBFou3FA9YSVL3zO6Lqg2Ke5QgOp3ez1qbvycNmVFrddVvboZFMeuISwSfPcCzU4oM
 WdEgVGz3k6E6Ttss3Ca31jyevtxqThVxpRs1XX/fAIw+jhmgjg/oCmYeBkMl5FgP4JrjvvIwCQg
 gc0w/n2zNAcByYIKFk5rIpbumlRz3YtWyLMPNfJvuanurmge7Jo1BM+luiFx9rR/x1H41Id7v+v
 QqC1znMgpUuaZU7+ywOtHeQhqHsaOkouL08oF4k19/TMVE5zL/ZO8QyzawxuhlnsrV+04mTESFW
 l2taXiqBeOiYitLdGh9LesqTJKoaldK45kRxxB7yvm98D5eysdUs7SSD7AvikkJZ7iTFFLxa/Bp
 LKF1oq7E9rNpXaBMvbfXRUi2lh5D6hVbdcoKQzi7uvGRs9lY7/21RD1ZqoBAqQ0iNnPAfpm+Jtb
 8YW42JtDSosDResvHdMMM7hIDoFhxjZiJ9Tx9iT0o4qXMySMnoPyChOFVm3n5AriZHjReLXp0Fq
 CHZ19k1hPHyTXsVHDEmO+FqqlRwWg==
X-Received: by 2002:a17:90b:2681:b0:3a0:cc33:22b4 with SMTP id
 98e67ed59e1d1-3a0cc332593mr4169214a91.52.1790499869430; 
 Sun, 27 Sep 2026 02:04:29 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 071/101] tcg: Generic expansion of tcg_gen_smin_*
Date: Sun, 27 Sep 2026 01:59:41 -0700
Message-ID: <20260927090011.10724-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
index 383cd093863..3f463725d68 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -189,7 +188,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f9812c1f882..14860667283 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -55,6 +55,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 96675ef77b0..207a62450a1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1015,6 +1015,15 @@ void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1331,15 +1340,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
@@ -1871,15 +1871,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-- 
2.53.0


