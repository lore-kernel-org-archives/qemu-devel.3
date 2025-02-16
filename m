Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A484DC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxB-0005Yd-9M; Sun, 16 Feb 2025 18:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwS-00040z-Mg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:54 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwO-0006QD-LP
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:52 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso4497192a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748046; x=1740352846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CB2oGF7+mkCgVqQqak2Dgqbht0NQB3xJAd/VrTCedxU=;
 b=OY2EN09avKYgRxlzmwrUQeuL+60EmcCu5gOv1M+YLiTxgyV0qT//wOH04hH8zIWTlh
 7BCZ2rjr8bdbO//J6NuRPCVd/jxBrjI7rIsKEPRKtqURJ9s2uZI5vsqQ5JXArFsWo38X
 zON02GMYIopENDSSFr3eEZYL0OVgOrsoEOA0WWPYmijrEVrUWYa+R34tJGq+rhMUgvSv
 aKk2HixDD1fHTSsWzxqJ1QW5E/iVpl7CjIQrGHBCRZ1M8/VHy+tP0dwm+SzeaJg+M9VF
 Rt3HK10riG0l10zjNtEnKZn7OTHkBIx0BykOwv0O3C7GAdXESI0ETLJoqaX8knU6i7n6
 Vx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748046; x=1740352846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB2oGF7+mkCgVqQqak2Dgqbht0NQB3xJAd/VrTCedxU=;
 b=MZwK+rwWLsFajxbXsecpSd/89ZkkE21Y+kGUeyXG+uxwBACb58+wqf0FqerNvA5ZdU
 5PqIM3/MCumD3eAi9mhFj47Cl8ZkNj3MJf1FCCpGFg81ZHHQ5CQWZpdpFILMUpfeDJC3
 S5tnL5MU1geI2H36IyFs8j+Wixa9+9+I+yUtBnN7Dx1MlGydFjVvgs17bfQGhRcJdsz6
 gJJL+Cx5GzVVKDKfKWhIRmUaBvbwSXHfW57kJRWZOtD4flchcNQCx1G6uEBnHxEhLO7c
 2jDTG+7KAca+8rbTCztfrBp11MGu35wsd336KhflWDzKhMCZRxnDfAZ1m9IioYesG0ir
 AYtQ==
X-Gm-Message-State: AOJu0YyUrkgrtMrQZ/tchEsmR6uD8NHSlV3wOMPFPEIiel62WgSXDq74
 DDYNpKlKvcb804BrtC/mu4s3o9R86wxRjbXLI5QW+yfv5JJFV2ljPaC8ELNlXKCvAyx6vHyIiMA
 y
X-Gm-Gg: ASbGncvjaqQ+Ni9nita9wXmK1vNv+F1gYmjBln+eBGiDgngtfFwODikLhd5gwrxG2Xz
 7AjsUPxdsKspQg7HimAuDxHC8dizg1Gcc/4dBGV0bDb75H2UdZ5qklJNPae0FV9LNSn4jyCGUIJ
 pMi/S9O9+wLGycSaSqLaP5uYAIT3kfMZMArp+AaU3Rfeom2aIwRQjPlO5P5ONBKRruZDyCe8uLz
 hGHyIh4VtHdUr1e605WKHljrF+QP+QAj1nLG5yISK+9T6y967yFIWd/MktqUcQQVF+bZlacL6u6
 QyTU2jZEF/a/s/igXfOMHkyiDrRLzbdXOsqFcXrK3eoil1Y=
X-Google-Smtp-Source: AGHT+IHDfbMH3vxT+VyZjSJAEXiC9pdYbzOsKiXO9Q9Cu6QknB0zTC3J5A/r4b6+LfvGut3//GmwMw==
X-Received: by 2002:a17:90b:3ec5:b0:2fa:20f4:d27a with SMTP id
 98e67ed59e1d1-2fc40d12e34mr13070283a91.7.1739748045915; 
 Sun, 16 Feb 2025 15:20:45 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 122/162] tcg: Add tcg_gen_addcio_{i32,i64,tl}
Date: Sun, 16 Feb 2025 15:09:31 -0800
Message-ID: <20250216231012.2808572-123-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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


