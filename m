Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61921C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73r2-0003zO-FV; Thu, 17 Sep 2026 00:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qq-0003Ng-21
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:00 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qn-0007va-Ss
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:59 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so335148a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619756; x=1790224556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DNKqOeXMHorxLMBLmo6QaCMfgwSxgQZDu3caW+N75eA=;
 b=xw4ZwfoeSctZeUWLTuA4is2L9FaxmTiQWlc4NYNEheTLd52wHOFd6zrlIyE9CHMfTn
 KHxK0buANWP6r36TSe+OP0Bp1dVQxH1Z03nJQ/cRBwQiaSLOK/3s3gh2VQVy6+c2/7fB
 DJtA8LLGu6GP4Iu4jaaus1M26ziQjPGSwkISunes6A5bAM7W5WM3oDob6egJa5VU/xw6
 kubPIwVW+oayHDzDAi9npZKNj30OKjx8iGiRQXDG5Ptuz1bpPsiqMG/PJbPCAUTLH1f/
 D+O7xkFq17f7Uxn+q1QTLpKZ/deHHGVNTDIlKoXk2rJ9iZMgDXlYrAUf06Za9tTJPjhP
 WNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619756; x=1790224556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DNKqOeXMHorxLMBLmo6QaCMfgwSxgQZDu3caW+N75eA=;
 b=qPclPFA5k9gt94vwdkofc7I2BLxHhvwnhnkUGpYx572yiH8HKqYwc8HsK+js8hDUxM
 a1j89OUzdmHdzVzzHLRqMm47pxRli0/DKyElJWN5f3RTbdiLSB4gF/WVjBpYz1SP+IUv
 qt9P7lxVOK7pb/9ED894WhzFVVV7cT5QgISM5Sr96Q1z8pXh+iE4CmXeyEiMwsqJTthE
 s6JsO5MjzSMv75rpHNbgDzS3N0q34HIFP6XaxdU1u+ahrUyH80n2bSSZqkloTnS1Fym3
 /LDnpSmORdBL+XLQF0UuMHHdB9wXpyQ9u4NjN24EURWEoZzMBJXgu7zCnkKA05XbkbXA
 dgnw==
X-Gm-Message-State: AFuF++liEKCSHQ915RH9gpUz7yQ0n3EMosQQOFmy0uuLzDUvGxKHZEff
 L9wPA0bUIVTXIKlSazuBQiAmdgtUajzmMojzCRTOSeBkeZ6aLmf30hCImQo5uza0lQZuJkUU5TB
 TFROQyiw=
X-Gm-Gg: AYBFou0jIZWYsjpp4qTv9nAo7dXzAegi/vqBvVgRO0CKDgV7K57WDxi2b5on3JNjkn2
 6etZ3UoqdNPvkjdcY+PnoFQcdv7NgfSMNQ318x2sV0SeD8FuNJgxM4nqGDmYqRl7RQ1j4aSqGMm
 jsFPEIs+eQthZS7mY7/VO2ge1U/dKvQTwu0Nr4ZZcvN8EupawO3vt5SPuEHNj+W9x3Z+2kIEO8T
 GzlSPXqm8CQgqnuZI2HDgfeH1sHRjcMEH6mP5k4azcN/sSksEiYN90JJhK9v2fevkHVCwSxttSr
 XP9j9Skt9zF9WK6M+FSeRR1PBqLKtSItuqxS2ekYcAM52L545W/VAYktPgMDT8bWIaJdF6R4Srk
 aUdP7YtFdqnEEuxilA1/XwIrw8X0xa6qPRyZUG3KTnC39T4HgDiRrAQPipfs3GsMzzu7D3c1yiw
 KCd3a5EI5wl0Pxoi8CatKYxc4euartA4/VmYpAFVGjiFIUSjTfFUax8f5O+2ciiCOv2FZKg3Eva
 O+XH+c=
X-Received: by 2002:a17:90a:10c1:b0:39e:1ec9:dc8d with SMTP id
 98e67ed59e1d1-39e1ec9e479mr7970017a91.24.1789619756086; 
 Wed, 16 Sep 2026 21:35:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 085/101] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Wed, 16 Sep 2026 18:28:07 -1000
Message-ID: <20260917042823.542588-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 79 +++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e5282af98d..3ad966b72c1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -157,7 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5a472a910c6..75ada0d0473 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4559af91358..5219140f5fb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -135,6 +135,13 @@ static TCGOp *gen_op_tttii(TCGOpcode opc, TCGType type,
                        temp_arg(t2), a3, a4);
 }
 
+static TCGOp *gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                          TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), temp_arg(t3));
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -882,6 +889,37 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                      TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
+        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        gen_mul(type, t, src1, src2);
+        gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
+        gen_mov(type, rl, t);
+    } else if (type == TCG_TYPE_I32) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        /* Simply extend and use host 64-bit multiply. */
+        gen_extu_i32_i64(t0, src1);
+        gen_extu_i32_i64(t1, src2);
+        gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        gen_extrl_i64_i32(rl, t0);
+        gen_extrh_i64_i32(rh, t0);
+    } else {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        gen_mov(TCG_TYPE_I64, rl, t);
+    }
+}
+
 static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nand, type, 0)) {
@@ -1289,28 +1327,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
@@ -1796,25 +1812,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


