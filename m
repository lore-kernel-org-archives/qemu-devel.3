Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FB0C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCX-0007QX-QJ; Tue, 18 Aug 2026 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCV-0007PQ-UH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:11 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCT-0004gm-ER
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:11 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso181897b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072528; x=1787677328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EE1j6rW04O6psozert+WRAhkHT1L5kpmKbk1CXdOhMw=;
 b=j3DxfHu5BVPFRdVrIty6nZEGcC02v8I3V223PDyYS10gP8SXSmarOAb5TBmyYwFWFt
 Q7LGejwsLOat8sEIsb5a11XlrWieExYOf0X1vMZ6N0yMDoPwjb2S+KYcOWkqdCQkj0eN
 KRBZaQiEVClH3yqFncRKZfkV8Ejn9FwQ3gKivnVdnO2FoOmxIhDWoDWaPXXi8ia1C8zW
 tut9gj17IdYhaozoTaOhYf5Vyq8WP0q/mkP0Yet6cQ5dkCamBwlD8hjJ/EqQBQyGOEF5
 nUrQ6GhzHvB7jvc6ntzRZMIV7Ava+vNDwX5TybUlXY2qb2r7mMelmwwW4iPMKcUJ5V+T
 uc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072528; x=1787677328;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EE1j6rW04O6psozert+WRAhkHT1L5kpmKbk1CXdOhMw=;
 b=ifwvxMbPj/8797AoUwJYn3yWHvbXiPaPjHdR+x7JZlwDRmVUSHtCe0zqvLyQuLrobP
 KSNLjeUkoC0kfSnirl50v/hTEf+z7UCMZWVQ74lpFOQcTOF0levg2bNwgkP2GOAOv5/W
 V8ITyum4L40gr8Ys00PwKqkDMccCYQQMPTXUY5paOWAS2xCU6DNwzSJOII1HSWrVOHdi
 gN5wn/7RUTb4948vyZ5u6P25BB0KmyRzJZy3JX31DoAguvc0o4henwrZJtTAkPwDIvQd
 SD/RAhpUUFDlJycKOPP6SGMyUj8+Gi7O0nQN3g6efR9+V45UXEjBribKMt2Fy0+rSuly
 OJ5w==
X-Gm-Message-State: AOJu0Yx9+bsmXP3mlqF1rONO5LV1Eqm0znooXppT/AbMG9uhbuNs7Emp
 thXqpMe0y8cYxlqTRBRQNijSbTgBXMHV/dBFerK9hWwFnHacrOAIe8FnZ7OHsfWxa4Bfc1TlhW/
 jh2SZaWo=
X-Gm-Gg: AR+sD10NrB1DrluioibqW1G3k82pZPQYOllHvhMuxAkKXyZVcFWbkdSGudJl7vRIaep
 4ptuf6P4EpJhJoZ2w3c5ruwR0SU+2XGro0GKIJ+cu1Af4xNF/y5tKecJzm5j77Wp6s/k8xHj5sj
 rnL6ugAwzL1+AdG8/QZEuEPRHWrXHu6Xlmai+7DyrDP5AAszGB6oPy1esrAq5IBny8fzLdtlKHY
 yohHrblQOLmQ3W8OmUfLxBTFeVKeaNnzyOFdLcgwPRrInm1pgSVx7GIwoQII1qVaJEO4hZaUGdN
 K3WVMyS/Tx8xwd4beeyLmL+W0F24ohArNIKYRXqvT1nC4rYrAqHQ7xbKifXjIAPj9GYXkp4kfOk
 1/bxMsjKV/Vk9bscLUJmm3papKncv5TLxnQqqfodEXQ6hNXf59FfMpOcEjAKkopM7RG+coczjFL
 3/kpMrfSkRufVrOlgZIbOAG1sta8PBmtEHcUKc3uqPVadgPdsNzlYhcstBrbhgeFiVKwbHc+Rd7
 0VVd4R2UgDRSagNzT63g7ohgz/sYTLkghZSK1C1dPsLkg==
X-Received: by 2002:a05:6a00:6c88:b0:84e:24f:2677 with SMTP id
 d2e1a72fcca58-84fddfa7f2emr41459482b3a.4.1787072527801; 
 Tue, 18 Aug 2026 10:02:07 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 08/38] tcg: Add tcg_gen_revbit{8,32,64}
Date: Tue, 18 Aug 2026 10:01:25 -0700
Message-ID: <20260818170155.1907006-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Add generic expanders for reversing bits within a word.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  5 +++
 include/tcg/tcg-op.h        |  7 ++++
 tcg/tcg-op.c                | 76 +++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fe342db0d..f7b6aadb50 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -164,6 +164,8 @@ void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
+void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
@@ -275,6 +277,9 @@ void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
+void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 96a5af1a29..568b78fe81 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -115,6 +115,10 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_bswap_tl tcg_gen_bswap64_i64
 #define tcg_gen_hswap_tl tcg_gen_hswap_i64
 #define tcg_gen_wswap_tl tcg_gen_wswap_i64
+#define tcg_gen_revbit8_tl tcg_gen_revbit8_i64
+#define tcg_gen_revbit32_tl tcg_gen_revbit32_i64
+#define tcg_gen_revbit64_tl tcg_gen_revbit64_i64
+#define tcg_gen_revbit_tl tcg_gen_revbit64_i64
 #define tcg_gen_concat_tl_i64 tcg_gen_concat32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr32_i64
 #define tcg_gen_andc_tl tcg_gen_andc_i64
@@ -234,6 +238,9 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_bswap32_tl(D, S, F) tcg_gen_bswap32_i32(D, S)
 #define tcg_gen_bswap_tl tcg_gen_bswap32_i32
 #define tcg_gen_hswap_tl tcg_gen_hswap_i32
+#define tcg_gen_revbit8_tl tcg_gen_revbit8_i32
+#define tcg_gen_revbit32_tl(D, S, F) tcg_gen_revbit32_i32(D, S)
+#define tcg_gen_revbit_tl tcg_gen_revbit32_i32
 #define tcg_gen_concat_tl_i64 tcg_gen_concat_i32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr_i64_i32
 #define tcg_gen_andc_tl tcg_gen_andc_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bbcb510c76..3d28280785 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1160,6 +1160,45 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_extract_i32(ret, arg, 0, 16);
 }
 
+/*
+ * Internal helper for bit and byte reversal.
+ * Given a repeating matched block of 1's and 0's, swap the bits within
+ * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
+ * right 8 bits.
+ */
+static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
+{
+    TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+    int sh = cto32(mask);
+
+    tcg_gen_andi_i32(t0, arg, mask);
+    tcg_gen_shri_i32(t1, arg, sh);
+    tcg_gen_shli_i32(t0, t0, sh);
+    tcg_gen_andi_i32(t1, t1, mask);
+    tcg_gen_or_i32(ret, t0, t1);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+
+/* Similarly for 64-bit operands. */
+static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
+{
+    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    int sh = cto64(mask);
+
+    tcg_gen_andi_i64(t0, arg, mask);
+    tcg_gen_shri_i64(t1, arg, sh);
+    tcg_gen_shli_i64(t0, t0, sh);
+    tcg_gen_andi_i64(t1, t1, mask);
+    tcg_gen_or_i64(ret, t0, t1);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
 /*
  * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
  *
@@ -1244,6 +1283,19 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
+void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    gen_bitswap_i32(ret, arg, 0x55555555u);
+    gen_bitswap_i32(ret, ret, 0x33333333u);
+    gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
+}
+
+void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    tcg_gen_revbit8_i32(ret, arg);
+    tcg_gen_bswap32_i32(ret, ret);
+}
+
 void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
@@ -1869,6 +1921,30 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    gen_bitswap_i64(ret, arg, 0x55555555ull);
+    gen_bitswap_i64(ret, ret, 0x33333333ull);
+    gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
+    tcg_gen_bswap32_i64(ret, ret, flags | TCG_BSWAP_IZ);
+}
+
+void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
+    gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
+    gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
+}
+
+void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    tcg_gen_revbit8_i64(ret, arg);
+    tcg_gen_bswap64_i64(ret, ret);
+}
+
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-- 
2.43.0


