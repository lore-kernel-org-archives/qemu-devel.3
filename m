Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F08C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L21-00063V-Jd; Sat, 12 Sep 2026 06:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1W-0004tk-MX
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1T-0007Jh-Rf
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:53 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so573451a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209110; x=1789813910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bvT6V6fnAo3fTetyu1MZeI7Kqa60nquZJYS8444U2s0=;
 b=BE12snFF2ndWg7ndjM+Dtjf1unKiNzVJrfku4PYf39CBKCfRgfazh3+qmnVOsNoT9M
 YYUGGCEha7hVoI0vWmJ1IfRMdlLqXBwEOjCh9he3dwxG997rR7UmfmowRRHRjOeeUezC
 gtdV0poB/aGBYhHAU/ve+uhlLanOf29by0EpwVunImMst4KxHDbvjHRgqrnvOKvn98fc
 1h4TRtthy/YujuN/SNEMsB7enIKeQcunyNVmAZPwnMJo+5vb4IW8q/3K9c5wmUQIsrlL
 w7xn+3wIcBXq3X91u0OqAwuLYIt8cNvWbqeHqh36Eq3sEplnsRbyQWA76xjE10oz0YpH
 rYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209110; x=1789813910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bvT6V6fnAo3fTetyu1MZeI7Kqa60nquZJYS8444U2s0=;
 b=OrPu/QTA0P8X0bqUFT5SoPls634GP0fSmAvDr57+BCbS0/IbUo5ngEn08HRb1lGj0A
 5QKHQrBIZFxZXmrNdABka+UqljCneG4QlAA3GSwx4VOopL6+33o7Te44MCDcStKEh8SO
 BLumiNNGYcSnU3GbhbJynvZ4qGErVeHi93NDHUneGmqYfCYhNtM+4kWVTe8Hz8Aq0knb
 mzPGqkMSYRft67VNhU7D9KDLRBFL0vi73zZUXjVZbBVWyZG4MvQiQI8JadU/l3iHP3sT
 SRrMLcFgMNDql3cYQaIYoxkIU0MogVlxjU/H+7VJevxG0qtYqJnB3tHd11XeMFCaWcpR
 Jkmg==
X-Gm-Message-State: AFuF++nyarsM1gGM1hCwAEgP9uqdFbDJKU5vrn+WwXZgStmXxHUeutj/
 XJaL/MVoBVcQFPhEY8LXO1OLigP5EtRSN0oQKMNLOsAN2f1FWoJw+Ve9PenZo83KOGLKt685rgY
 GqBCR
X-Gm-Gg: AYBFou0bSwy5NUGBTPeBuTjFZwRd/zpt2eSIzoyD3JQNggroJZcOTi7Z/vAO0zXK8fe
 JRBLwsMK89sX5oneqFH3u3c5Af4zaQm92FZ6+gO7auaLxepVqnPwV4x9AmGqrxjLUql9p/PqNP1
 DHRdRq3MQl6dEPa8z1sEm162Aj249AU2d/8t2vra9+EbCJOOqT5jeDEGogs3yowkDLv4AnoEYCp
 Q4Yex3D73GiXRe4br5+nwvAFt8GNUdQktCsZhb9CIEj6PNHL8yqGxsog6TNSh7v5uYZFiz4uKjY
 u6mEKyq+iGx35ghBBDzFiM+BNSFtboupUFSjg1NgQ13avioAFotFOQSPXWg+0xYIBspqJsIE7Rv
 DAf63iNgm+T9R7Xy3axYHKJIXhRqDFri2jC0gVBvXQLDBdAB25Y3SjpmoTgLyIYJHyJX1kTxiVL
 PmYnZ9XrGhh0gFzkxWhIngMZVxbWLcvKDgwgf/r3JA6sLlYksnZkY5aucdX0qjKGHaBja5bTGFK
 Hwhf3zK6TeNRo+brw==
X-Received: by 2002:a17:90b:390f:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-39d9c0b7047mr13943650a91.12.1789209110329; 
 Sat, 12 Sep 2026 03:31:50 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/82] tcg: Generic expansion of tcg_gen_ori_*
Date: Sat, 12 Sep 2026 00:30:27 -1000
Message-ID: <20260912103126.598030-24-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                  | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3335e127083..b47d33d723f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -208,7 +207,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 898b77b00c2..07e1a9bedd9 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -7,6 +7,7 @@ DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
 DEF_RRI(andi)
+DEF_RRI(ori)
 DEF_RRI(sari)
 DEF_RRI(shli)
 DEF_RRI(shri)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c3e897d479e..ce358bbff26 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -434,6 +434,17 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == -1) {
+        gen_movi(type, dst, -1);
+    } else if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_or(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -542,18 +553,6 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1520,18 +1519,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


