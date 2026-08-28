Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096DDC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jl-00010U-Si; Fri, 28 Aug 2026 18:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jk-0000zg-Ng
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:00 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jh-0004Lw-Vq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:00 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1044266a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957096; x=1788561896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYvarEEdb6XBxTioqC3HXw5cDxJfIpanUat8jD+q0TQ=;
 b=IoU8QmXa84SZZC++sj+P1TT/L9L1RaXAQV2+ww2Z6OcJYFZ9Oj1bODKf5lL2bpjjsS
 vdxaoZUuJIiHTIJJ/ZtWvbIWxkRHO3nM+pugaqfAKKQ636Z2QMCigl4sdtEVQbemxcGs
 HbOyh54LU1vpm2cq0q57EF8C26T6oD3ygpXIqmSV12u0AZtg/ISpShnmKlFQrUQgm7tj
 SoVEUIMlsErV5/sb4qkCWzIxQvbdOINh3uGeKG22pWGEHyuRyX1xv+i9ZBSv5MWEZQw6
 Dbj1lyVJZzTybuNk6Jdg4erkKiJjyjjOYcro4MZxGIbnPMgBeEu0YDRyhya3S1nwecCG
 hpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957096; x=1788561896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RYvarEEdb6XBxTioqC3HXw5cDxJfIpanUat8jD+q0TQ=;
 b=YG5Txe2hV1IW+/NMBjuwcK8p4HxTRPqHPT/Mm+ByybaKdVXjzt87puWNfZnvsxhxvB
 lA2LWdLj4KNWa2+enLcd50d4C8D1HUO2jm3QZq7EhX9BLpzS0VkeNyxZvqdwEU3gPLlv
 ApBTw87gmP/iRGnEkcDPLaHeuhvWojF8co8CyzLqsa8vH5gfxBDjkGtBSo15Kpvh+0EK
 1pjZl5FMRZnd7i4ZoEE2AfGnLMci9/9P8QGVb54Z2wAlMX0TLsmXgGxaGsQZg1r+2gzm
 x1I8JP7Gleggqy1NTBi0Y1+aJnzHfs+lVNQMPl5TdRl1DuuHMLWzNvz5cKrOwOaKsxLH
 QTSA==
X-Gm-Message-State: AFuF++kV5kDPP9YOAsasapRDRdM0gEp92AbZETz/rYM5icmxaqrE52kK
 Q1DhrRnvyOS2IgkVqAywLICKnSjj1QEomO4OE8sBtuFHIa2854wKUDbpv4TpP2WcvpSPuDAg7nl
 IDhH0
X-Gm-Gg: AYBFou30u/H2dxdJpbfi6SrmncyNpfzb9hZQTRvETrlEVZB88caKGaym1/UMgbeu+3g
 1Wor44ef+vEVM9s1PpaiiA1rAedyX7YUSvhuZhA4Sl34am3VYWiNr/iX+Zo5NzEAvW3nOd1+Qou
 2AqijbM7quCA3BLuN7PwmzAU7x3+G15pZp6zaD2pcsPtjzoceJf0aAqwE6SMUegNUBU+DxKcr2f
 dvPHRtY7Q/OFJ1MG6IsWDA5NW+zhtLYPGqWHEOmEaLNUT2FQuMgdb/qeDZBQ8dGiq6ErwfWxIQG
 KKSTgqrbDnBOT95tMHgXJftxI+zV7XXAnrjG65dPN6BBkWC6laYmNRREspTe8odsNir8p2JPAF5
 3NqavbGy6vYBubj6/fZQCxQWteFG6svcbbgZqae7mFuZGBTy9Nt+KmgyQ+1Wk6hJGr/lqw2bssd
 MPeYnQJDYDpyM/geF5ZDPw8KxQ4mk68GS1I9cXcaMBrOF9spLEiYlSnK5l4k/GmCEg9HpGzqPz3
 lIYp6EalqnppGUj1dVf
X-Received: by 2002:a17:90b:17c3:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-396d0ea9ce7mr14115103a91.2.1787957095856; 
 Fri, 28 Aug 2026 15:44:55 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 03/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
Date: Fri, 28 Aug 2026 15:44:38 -0700
Message-ID: <20260828224451.1564072-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 include/tcg/tcg-op-common.h |  4 ++
 include/tcg/tcg-op.h        |  2 +
 tcg/tcg-op.c                | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9b321f959c0..b06445b8031 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -167,6 +167,8 @@ void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_lea_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b,
+                     int32_t sh, int32_t imm);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
@@ -282,6 +284,8 @@ void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_lea_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b,
+                     int64_t sh, int64_t imm);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 37211642365..a7d001c959c 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -83,6 +83,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i64
 #define tcg_gen_sar_tl tcg_gen_sar_i64
 #define tcg_gen_sari_tl tcg_gen_sari_i64
+#define tcg_gen_lea_tl tcg_gen_lea_i64
 #define tcg_gen_brcond_tl tcg_gen_brcond_i64
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
@@ -209,6 +210,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_shri_tl tcg_gen_shri_i32
 #define tcg_gen_sar_tl tcg_gen_sar_i32
 #define tcg_gen_sari_tl tcg_gen_sari_i32
+#define tcg_gen_lea_tl tcg_gen_lea_i32
 #define tcg_gen_brcond_tl tcg_gen_brcond_i32
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c88f4f7ca9..fb5fef9422d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -498,6 +498,51 @@ void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+void tcg_gen_lea_i32(TCGv_i32 ret, TCGv_i32 a1, TCGv_i32 a2,
+                     int32_t sh, int32_t imm)
+{
+    TCGv_i32 t = tcg_temp_ebb_new_i32();
+
+    if (imm != 0) {
+        if (TCG_TARGET_lea_imm_valid(TCG_TYPE_I32, imm)) {
+            /*
+             * The immediate is non-zero and valid.
+             * If the shift is out of range, perform the shift first
+             * so that we can still emit (a1 + t + imm) as one insn.
+             */
+            if (!TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {
+                tcg_gen_shli_i32(t, a2, sh);
+                a2 = t;
+                sh = 0;
+            }
+            tcg_gen_op5ii_i32(INDEX_op_lea, ret, a1, a2, sh, imm);
+            goto done;
+        }
+
+        /*
+         * If we can make the immediate smaller by folding it
+         * into a2 before the shift, do so.
+         */
+        if (sh != 0 && imm == (imm >> sh) << sh) {
+            tcg_gen_addi_i32(t, a2, imm >> sh);
+            a2 = t;
+            imm = 0;
+        }
+    }
+
+    if (sh == 0) {
+        tcg_gen_add_i32(ret, a1, a2);
+    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {
+        tcg_gen_op5ii_i32(INDEX_op_lea, ret, a1, a2, sh, 0);
+    } else {
+        tcg_gen_shli_i32(t, a2, sh);
+        tcg_gen_add_i32(ret, a1, t);
+    }
+    tcg_gen_addi_i32(ret, ret, imm);
+ done:
+    tcg_temp_free_i32(t);
+}
+
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1623,6 +1668,51 @@ void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
+void tcg_gen_lea_i64(TCGv_i64 ret, TCGv_i64 a1, TCGv_i64 a2,
+                     int64_t sh, int64_t imm)
+{
+    TCGv_i64 t = tcg_temp_ebb_new_i64();
+
+    if (imm != 0) {
+        if (TCG_TARGET_lea_imm_valid(TCG_TYPE_I64, imm)) {
+            /*
+             * The immediate is non-zero and valid.
+             * If the shift is out of range, perform the shift first
+             * so that we can still emit (a1 + t + imm) as one insn.
+             */
+            if (!TCG_TARGET_lea_sh_valid(TCG_TYPE_I64, sh)) {
+                tcg_gen_shli_i64(t, a2, sh);
+                a2 = t;
+                sh = 0;
+            }
+            tcg_gen_op5ii_i64(INDEX_op_lea, ret, a1, a2, sh, imm);
+            goto done;
+        }
+
+        /*
+         * If we can make the immediate smaller by folding it
+         * into a2 before the shift, do so.
+         */
+        if (sh != 0 && imm == (imm >> sh) << sh) {
+            tcg_gen_addi_i64(t, a2, imm >> sh);
+            a2 = t;
+            imm = 0;
+        }
+    }
+
+    if (sh == 0) {
+        tcg_gen_add_i64(ret, a1, a2);
+    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I64, sh)) {
+        tcg_gen_op5ii_i64(INDEX_op_lea, ret, a1, a2, sh, 0);
+    } else {
+        tcg_gen_shli_i64(t, a2, sh);
+        tcg_gen_add_i64(ret, a1, t);
+    }
+    tcg_gen_addi_i64(ret, ret, imm);
+ done:
+    tcg_temp_free_i64(t);
+}
+
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


