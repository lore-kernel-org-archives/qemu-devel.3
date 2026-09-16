Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAADAC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOL-0000Jq-0G; Wed, 16 Sep 2026 09:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNI-0006kH-O0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:39 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNE-0001RL-Vu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:30 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2258050a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564106; x=1790168906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d03CGrhOIEhMRaHaJDMgUqomQNEad0BRJ2NGs5rp1P8=;
 b=YyH9ckBziPnhRSRIyn+FiqiSwl9A7afD3lES1aExlZotwUwnisEdadAF3z4yqCaPCt
 iac4DNjnIXFuYTaiDvWlk3gRKI0fe2yn+K30ESHpSQPA6S1+4zaim7xw3Ceibpwsd32/
 K+FOz70kl+uTCSqTqvGlo1VXUrXOL990TVNK4cp/2+adAGm45y/S+yHbwvQnZo5bRU7Y
 KYzQAOwUS3bOB+V5fRURVW5BDxVaZVhbppf3S9LFzprb2f9akVxFNyQhoStEF9d/FU2G
 4lDXh8az4ST/MJ++SZNjm51KhgG9ObqoFfLLIhguFS1HSNCtlwtHvYtTX/ktL/LRzml5
 YLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564106; x=1790168906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d03CGrhOIEhMRaHaJDMgUqomQNEad0BRJ2NGs5rp1P8=;
 b=ag8FvGkVrv1jfnXLCoCNXkmu8Clsr6q4m0vPqpol/vKMfI/ucs9Q7Gw1vLe+RxLV3Y
 8JQpLDwCkmMvFi0vNCCNNXQaku0U+QFyrdMmvtVv+0AvHieU9deDJK2MRzRDUY0N+PV7
 O2kxv370XepI4cc2KqaDYfRzq6oMj6ye4kK9/562ee7hV/DDFCMqN/l4Z87dFOpVCzb9
 bPlwIcehDtDI2cBWo/AGWJeCigCJXgCTci6p9vO8XvyuOXcroDl0TzRf1lXbbPe9vuXD
 x4fxuf8HHS+cq73oefLQm7jeq3K2UoaOJHPrJXWpPBiPgXstVWowfHD8URqATMp7CW/Y
 /sGw==
X-Gm-Message-State: AFuF++mXZK+bDR10qjxMJDfNWsnDdc43qH4HETtCfxAxzAD+HNA48kf5
 bcqWm+Nm3EXEagqM74ZSxGzUXzWLbjG48IQYSO986L0fu5DLtw+RoC7MVx3G01/RlBtvNj6SuGj
 33XyjFg8=
X-Gm-Gg: AYBFou3wg9pHTXxjYk0WHnA08i2yAG7wNRpNfywq1m+H6yGnLHqJHSH04zo4UKmU05l
 NQtpsQ92AFyW4dEK4703Y7afyw8JWoWN9J3S51RyeOQ89r33Y88G9h2BSDEDYTossYg694fIdZk
 bXh1pfEYq5Wv6+/7IKZyPFxTPtH8yeQD2kZjFg02EN12PA+jAT4nE+SiJI2L4m3s4gpM3QLGpP5
 u/XEwXEZxh2bfSwfO2v895a4QPjhnUPAtR7vUYW1GQzA0bAE+TAQCc0vM/RItV9R6dVIfASMreN
 BkQZHRpachlc/YhicREgwHxGotJm6WWyMDfSSkKEJ6fM5GId5zgRwrKVl0AVqknqnWYFS65M1eQ
 /yXPRlG8jyNaHM8BdR/WbBF6CIbkXOa5G+X8RlP2vj5jDh1SRE1Y37cnA0+icF3QfcjSF7s00kk
 +ptp+s/58H3GiNEJtKMifGPJ7byvuCaMrYBV2XtpqPIIATmXAIyClj8ykBfETlP6hZgsg/wOaba
 DKO5dI=
X-Received: by 2002:a17:90b:2f08:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39dfdfd409amr9484983a91.5.1789564105964; 
 Wed, 16 Sep 2026 06:08:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 52/92] tcg: Use signed integer for tcg_gen_{clz, ctz}i_{i32,
 i64}
Date: Wed, 16 Sep 2026 03:03:27 -1000
Message-ID: <20260916130409.3382710-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

We use signed integers for all other functions, and the
sign of the second source is not meaningful here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h                | 8 ++++----
 tcg/tcg-op.c                               | 8 ++++----
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d882bf5d0fc..0e8203fd836 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,8 +130,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -190,8 +190,8 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 714e279a453..0a2e92d53d9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -853,7 +853,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
@@ -898,7 +898,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
@@ -1774,7 +1774,7 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
@@ -1808,7 +1808,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf2670..4e521e44bb5 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1551,7 +1551,7 @@ static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 }
 
 static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i32, TCGv_i32, uint32_t))
+                     void (*helper)(TCGv_i32, TCGv_i32, int32_t))
 {
     TCGv_i32 t = tcg_temp_new_i32();
 
@@ -1567,7 +1567,7 @@ static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
 
 #if defined(TARGET_PPC64)
 static bool do_cntzd(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i64, TCGv_i64, uint64_t))
+                    void (*helper)(TCGv_i64, TCGv_i64, int64_t))
 {
     helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
     if (unlikely(a->rc)) {
-- 
2.53.0


