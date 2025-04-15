Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA54C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mBz-0001bq-Ri; Tue, 15 Apr 2025 15:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5k-0008Tg-KX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m4y-0004PI-Ne
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so6120978b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745761; x=1745350561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CB2oGF7+mkCgVqQqak2Dgqbht0NQB3xJAd/VrTCedxU=;
 b=fryICzIbFISazC8tZgcwpFSP1nM5+joaUECj5GN2aAAX8E/vv7pVkXJ6m4izu2LWZ0
 K3tZsMlE+tpjaMm6jR8E+WiLIDJvNVZu9dU9CpdQAvy+J/xjVVqgzG8Uyu1tGn+VCCfG
 vuqyscqkuJVHB52+z1W1DODMl6KJeDFT49M9DuYe3X8LI0xuhbT+VFJHxe8yerjwFTnq
 SQ5gH70QW1UgSQNrUWmE4Z74olaMmrc/5WMTBZAwNR7MvJBgsvCuvIwzDEsX5UZmhu3k
 /zwHe9r+sOVLJIZtxmDLof6qeNWFOlLBpGAm/GSU7JO0t3hmJ479AMl3gZQqn6J/qei8
 kZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745761; x=1745350561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB2oGF7+mkCgVqQqak2Dgqbht0NQB3xJAd/VrTCedxU=;
 b=JsoG5BXN5WaUnTQp8FYj7iRRREnC8IroHKZTZCtXKIb5c4kWNltlBJ0o3+rh0BIgGg
 6HjcZMBIpfrLXQIPAt5C0hyeh78+O48Hadh0Tx7vR6fVqxWb644Da9Ye5uFz8qQiu3tl
 6ufsuQXNisabRSGdaiaF/s+m3nXgQdtES9SrpcL3zqqT9HggRjpM6H1GnpFD+qf64Ro+
 rYEoADu2hfZVwe/mD3NMrTfwTJ0cVuyj0QL4XP/MGfvHQ6wlE+daaMN5Up5dBQGrKtBN
 g+IZ7y7Mwn7yjvxkJ4O1QUVTvCsnOnoPbb1O8JPH4+gkYqw3gT7EiRtrtgU/RNfHWHjU
 tUwQ==
X-Gm-Message-State: AOJu0YyLVTcxIJq3+RKf602NcqFe61EqaAJSX7OB1mnl8U1JxVzMPWU0
 mz5sJq7Iq/+CVpiIc692w2/f6bZ0J+IyyehHVtqCufNxfPi5fUKRLF2aA2cgyGBi9OKlB3oWEZz
 Q
X-Gm-Gg: ASbGncudDmSiU4Y/jhcHOGbczFFoDu0Z2DDJdcx5c1zcKGCQWJPgnSX3XNB4WaotdxI
 GYWKpec9/UX0bCWHOyEzI3lFZMms4EcMIsue3qxUQuIfPqspWRMyzNgV+MPDimQ/PzuA8bWO275
 9UbxOt7kYQJHm7w4UNEYeCB1ynqO2Ka/W3WU7JZBKmrO4kWv/+Zy0h5rCi/qy5i+2UusyT2cbaM
 RJLAfo4tMN7B6EAC9zO0TCLANfZf/YkMxbbenHjudLp5oNnI02WxICRuDwiEbKw3CR/gh/KhnF4
 XgMObuC9o3Rfzj5I6dyw7+msLzjcDVTNZx4zg5mnGa7eCp1u8Juzv/HmLPsDAP4A3pFfYLCL2KQ
 =
X-Google-Smtp-Source: AGHT+IFQMzf6ylCojHE03RasqZCHsmZY2n752QXGqLDvBVsMLCluenyS2TfeV53cFMsLl1oFS4maQA==
X-Received: by 2002:a05:6a00:23cc:b0:736:6d4d:ffa6 with SMTP id
 d2e1a72fcca58-73c1fafc857mr875210b3a.15.1744745760465; 
 Tue, 15 Apr 2025 12:36:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 123/163] tcg: Add tcg_gen_addcio_{i32,i64,tl}
Date: Tue, 15 Apr 2025 12:24:34 -0700
Message-ID: <20250415192515.232910-124-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Create a function for performing an add with carry-in
and producing carry out.  The carry-out result is boolean.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  4 ++
 include/tcg/tcg-op.h        |  2 +
 tcg/tcg-op.c                | 95 +++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 009e2778c5..b439bdb385 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,6 +135,8 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
+void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
+                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -238,6 +240,8 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
+void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
+                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583b..44914e9326 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -252,6 +252,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_movcond_tl tcg_gen_movcond_i64
 #define tcg_gen_add2_tl tcg_gen_add2_i64
 #define tcg_gen_sub2_tl tcg_gen_sub2_i64
+#define tcg_gen_addcio_tl tcg_gen_addcio_i64
 #define tcg_gen_mulu2_tl tcg_gen_mulu2_i64
 #define tcg_gen_muls2_tl tcg_gen_muls2_i64
 #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i64
@@ -370,6 +371,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_movcond_tl tcg_gen_movcond_i32
 #define tcg_gen_add2_tl tcg_gen_add2_i32
 #define tcg_gen_sub2_tl tcg_gen_sub2_i32
+#define tcg_gen_addcio_tl tcg_gen_addcio_i32
 #define tcg_gen_mulu2_tl tcg_gen_mulu2_i32
 #define tcg_gen_muls2_tl tcg_gen_muls2_i32
 #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 447b0ebacd..b0a29278ab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1123,6 +1123,33 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
+void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
+                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
+{
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 zero = tcg_constant_i32(0);
+        TCGv_i32 mone = tcg_constant_i32(-1);
+
+        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
+        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
+        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
+        tcg_temp_free_i32(t0);
+    } else {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+
+        tcg_gen_add_i32(t0, a, b);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
+        tcg_gen_add_i32(r, t0, ci);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
+        tcg_gen_or_i32(co, t0, t1);
+
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
+    }
+}
+
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -2868,6 +2895,74 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
+void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
+                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
+{
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+            TCGv_i64 discard = tcg_temp_ebb_new_i64();
+            TCGv_i64 zero = tcg_constant_i64(0);
+            TCGv_i64 mone = tcg_constant_i64(-1);
+
+            tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
+            tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
+            tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
+            tcg_temp_free_i64(discard);
+        } else {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+
+            tcg_gen_add_i64(t0, a, b);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
+            tcg_gen_add_i64(r, t0, ci);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
+            tcg_gen_or_i64(co, t0, t1);
+
+            tcg_temp_free_i64(t0);
+            tcg_temp_free_i64(t1);
+        }
+    } else {
+        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+            TCGv_i32 discard = tcg_temp_ebb_new_i32();
+            TCGv_i32 zero = tcg_constant_i32(0);
+            TCGv_i32 mone = tcg_constant_i32(-1);
+
+            tcg_gen_op3_i32(INDEX_op_addco, discard, TCGV_LOW(ci), mone);
+            tcg_gen_op3_i32(INDEX_op_addcio, discard, TCGV_HIGH(ci), mone);
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(r),
+                            TCGV_LOW(a), TCGV_LOW(b));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(r),
+                            TCGV_HIGH(a), TCGV_HIGH(b));
+            tcg_gen_op3_i32(INDEX_op_addci, TCGV_LOW(co), zero, zero);
+            tcg_temp_free_i32(discard);
+        } else {
+            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+            TCGv_i32 c0 = tcg_temp_ebb_new_i32();
+            TCGv_i32 c1 = tcg_temp_ebb_new_i32();
+
+            tcg_gen_or_i32(c1, TCGV_LOW(ci), TCGV_HIGH(ci));
+            tcg_gen_setcondi_i32(TCG_COND_NE, c1, c1, 0);
+
+            tcg_gen_add_i32(t0, TCGV_LOW(a), TCGV_LOW(b));
+            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_LOW(a));
+            tcg_gen_add_i32(TCGV_LOW(r), t0, c1);
+            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_LOW(r), c1);
+            tcg_gen_or_i32(c1, c1, c0);
+
+            tcg_gen_add_i32(t0, TCGV_HIGH(a), TCGV_HIGH(b));
+            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_HIGH(a));
+            tcg_gen_add_i32(TCGV_HIGH(r), t0, c1);
+            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_HIGH(r), c1);
+            tcg_gen_or_i32(TCGV_LOW(co), c0, c1);
+
+            tcg_temp_free_i32(t0);
+            tcg_temp_free_i32(c0);
+            tcg_temp_free_i32(c1);
+        }
+        tcg_gen_movi_i32(TCGV_HIGH(co), 0);
+    }
+}
+
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.43.0


