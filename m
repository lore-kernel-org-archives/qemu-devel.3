Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB6C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5L-0002OW-9U; Sat, 12 Sep 2026 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L58-0000uu-1V
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:38 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L56-0008Sd-9X
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:37 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so3645015ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209335; x=1789814135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7lFqiKrKjbt7dUifdYdfSfb9Z6MPEL1UJH7wZb4BeQw=;
 b=J+xeNETPZwc5H0P8DCS2lXrDKiCcyi4eulsCTOGgOkw7xBwyWo4/MzrSNJuGk6ZU18
 Ni6yj0St81E56nmMTNFiAzgvR8T2gGGZ33XNtIV7GofO6smsd9R9Vbo7MvyPXcxFsCfB
 G0KUIsYipmIJRM51WGAKr3PAXksOJmb3r5znX7zA798nGk5ZAFPVY4viyuyhKBrG6Cx3
 0zwsAY2yLoLDjJCtnsO/XF/ydrkNJcp9lbCol5L6AXzXOqOnl0WClXEpZbq7tjuvXvyG
 slCCWzMjjTuMcrdcN4T8tpU9XD/jydo95tQ50P04iGB6kN7g0x1yva44gdPP0Zw8KUPI
 sL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209335; x=1789814135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7lFqiKrKjbt7dUifdYdfSfb9Z6MPEL1UJH7wZb4BeQw=;
 b=MARLOXPhhRK4AWiEWZv3RBm9xKJ7Phc4WTPQXkP/BcSeJumpmfJSUTS9oTL/QdXKJJ
 Wb4EnHqGHKGVi0L8Ln4ZNkYCYDgFTxUnhRH52RhwDN6REgolzoOUCvcoKnFm288r8Kmq
 ptJfGUuep8qcN2bSnQH2XSBQFo4aCh6rmKcFcI81qYMkotFY8d8Z7gfBidBQJTzMEA/E
 tv+wFHDN9+rY6W//LBy0AHeMMPoeb92pM65XnphhBvTtqp969GMBmdek3q+71ioUOvpe
 wwKliQ+ETTDEWMAO8BGRT+WCoLwW3xeY1WfPBzFCMCG8Eyjvb6YTaYjN3Niq2ABc2cff
 JxjQ==
X-Gm-Message-State: AFuF++mvPDr+Mj8dOIQRlU6QcUz2UznB6mvqr31jb7Og8h/YBS+YVv+R
 tleO9O6g8MmFShVXSJiA729kem1uXQRLS0WG6O2Pb7BUi/J+4eiTwl1Wyqzv2fzCzcYV7Kuj5HQ
 ahwpJObc=
X-Gm-Gg: AYBFou2uffTGy3sJShXqt842veemLMtMrY3Ww5La0C/v51/ZbHdw7/QZu0LSQA3Hd4Y
 JlUsPobHs/0d7uXtp62OTNpnQp/FMeg1XnF268XPz1hSZg9tuLqTkqbfIIjfW/SZ5aiUwonu4Jf
 N3fxgQ4h5SiIcUwA0YvAnTMEzA9Jz8s6AGz6jDojqWy0GhzbLejBBJqaK3QoRre2NfyYMlNMo10
 ZsvrQa5Ur120HmaMHsunPhzGjdGeizAroRGK05MQYccm1qkHNU34mmdtTIkqnvuuTCF06sRK5//
 k5UkehHGyD5+jQnErdj84ushHqd3G8VgCbYx8VIwodwQEvnsFb1U7O4VT0OdIg1BKeb2FuWsp0P
 IWq0QmgXd1aK+rcweFb+dAVRbwqS57b4lxiYBERSwRX0l5wMetHfxCVf4D1Ta1oMtnSA5PtKPY9
 OXj7JmiYNXT0nV67a/toMGYJZX/ulPSN7pliicIkkVldVkQxKyKEF35exUBXfh4DSswmiRubdG1
 W+eOCQ=
X-Received: by 2002:a17:903:1a4c:b0:2d9:464f:d45f with SMTP id
 d9443c01a7336-2dd4bc33217mr40057915ad.5.1789209334871; 
 Sat, 12 Sep 2026 03:35:34 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 68/82] tcg: Generic expansion of tcg_gen_smin_*
Date: Sat, 12 Sep 2026 00:31:12 -1000
Message-ID: <20260912103126.598030-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 5dae5ce3b2a..f5c9248fc93 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -166,7 +166,6 @@ void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -210,7 +209,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index e4b338f5e64..f616e27a228 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -52,6 +52,7 @@ DEF_RRR(rotr)
 DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
+DEF_RRR(smin)
 DEF_RRR(sub)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5c6e3a75224..34f1ee060ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1073,6 +1073,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1487,15 +1496,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -2027,15 +2027,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
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


