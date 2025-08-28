Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101CBCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau4-0003Ly-NC; Thu, 28 Aug 2025 07:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau1-0003IV-3n
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratz-0005jH-CT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso5273055e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380885; x=1756985685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=we7y5/VDqLpIsOAURE4m8mL6SQ4y7Eow7HTKGCKn19g=;
 b=WdTBDHchOWnXT/9jelkThKKUGim9hTmAPesmYaoakl/cH6z644EJsVaVwYe+vbtO3V
 lQLeoqIn//h+K3MsdHSuWHAGJaKUvsv6hwXVmvQSWev7PWsNFetckMXJdfsgLsS3+MXo
 kchqqEA9qoS7UDlSXrgIUoVEYLmC1aIfx2qf4Dc+LzxZnzQ6yyYHF9HxYVCPWNM3JG+l
 HsduzyfUAqRqoPeqts0hRHybElHUxKQSwztztk2Z1dKi1XcxbdvdUuRlKPT8PhniJOsR
 KsYLVzme7Zd0d6qbxBy//HQWR0n1DZ2IRirmFpc1d5xyd1uTsQ7SCr6duBpZgEO4S+l/
 9fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380885; x=1756985685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we7y5/VDqLpIsOAURE4m8mL6SQ4y7Eow7HTKGCKn19g=;
 b=jYaYzcoR9PTol9NXDQAUErPMB+LzlSw96RitQU5rFLBB8BQ+24AdYssz/vV1PoGBLX
 HEH082hAWW2ynrdlBzpIx5UW0X+VVfdLQq0dzGb323/Vk2A/S9aUtxhtb8QfCrjA6wjI
 DlKKq0qBf6gOYnFzCTFdBs2TXT7Y1NhbqTnP3RPcy4GHCGddyUfdXVO5oRUsL0MJbwlk
 YJhfojI/Y2tnAuA6TWwH0HyI53VcF4aGQFa4iKUxxgql0pXVxotx2GkF4zdqkvgf7TAi
 Ur5v9UX6eaK4xjph48kaqZij9ssCLS/J3ZiID7GW49my5rDiBl/if/fqH7bAr+GMPeUV
 OWCg==
X-Gm-Message-State: AOJu0Yys69crx9gB9zNdKwJOOBrt+VDC05oFd/i+bsVdEPTRZCjZzsCo
 +03Lxi6HRJ/PafbfD0IBJRQ0If3jWjql0a67FL+4Gf+DdiZqF8pu9+DN9qt7Q5hFvBwvUs2o5aU
 siT7m
X-Gm-Gg: ASbGncsDkdHgpr1xUcjtk0tTwR85LwMWEljz5RiWg5WwZRqc2K12MlbFVnOpnszptaN
 j4Pxp3+LwJkK2pAaSP6JqoUU/isD7iprKyXE3bHEbeVKjOMRq0sq3A8upXWrdv1KLZvoIZF6v1A
 VF+5I7ane0Fd2DAUMvbqsBIL4vLnxey0jTaMAHiXHYIOa697zh2GsOgrFYmtTgCW7KN68MY8qHm
 thfbpaKEVUd8+lomAF1kkoVPCUawLQCpWx38UdvMYEZnSPFf+BkapE/Eev12RPh8br/9vEa9wiQ
 I6HaYEiuIjhK046K4LNJ8iISPT4ng04HG+497ZV7mXIBsquHQxCZlrrlyC0PRhf51dGkefuY64J
 rw05E98foJ59qQcckI6KLLTlabk+S
X-Google-Smtp-Source: AGHT+IH3UimZfMWvkNi3rlnHNjGxQu6JbaJnzOZB5o1B1tltyAI1wDez5GK4H2AcFyUnocVX1Rf1mA==
X-Received: by 2002:a05:600c:c48f:b0:459:dfa8:b854 with SMTP id
 5b1f17b1804b1-45b5fbee605mr125589405e9.5.1756380885212; 
 Thu, 28 Aug 2025 04:34:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] target/arm: Split out gen_wrap2_i32 helper
Date: Thu, 28 Aug 2025 12:34:08 +0100
Message-ID: <20250828113430.3214314-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Wrapper to extract the low 32 bits, perform an operation,
and zero-extend back to 64 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250803014019.416797-5-richard.henderson@linaro.org
[PMM: fixed wrong output-reg argument in callsites; add comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bb92bdc296a..c0fa9a44e7a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8231,13 +8231,22 @@ static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
     return true;
 }
 
+/*
+ * Perform 32-bit operation fn on the low half of n;
+ * the high half of the output is zeroed.
+ */
+static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t, n);
+    fn(t, t);
+    tcg_gen_extu_i32_i64(d, t);
+}
+
 static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    TCGv_i32 t32 = tcg_temp_new_i32();
-
-    tcg_gen_extrl_i64_i32(t32, tcg_rn);
-    gen_helper_rbit(t32, t32);
-    tcg_gen_extu_i32_i64(tcg_rd, t32);
+    gen_wrap2_i32(tcg_rd, tcg_rn, gen_helper_rbit);
 }
 
 static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
@@ -8293,11 +8302,7 @@ static void gen_clz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 
 static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    TCGv_i32 t32 = tcg_temp_new_i32();
-
-    tcg_gen_extrl_i64_i32(t32, tcg_rn);
-    tcg_gen_clrsb_i32(t32, t32);
-    tcg_gen_extu_i32_i64(tcg_rd, t32);
+    gen_wrap2_i32(tcg_rd, tcg_rn, tcg_gen_clrsb_i32);
 }
 
 TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
-- 
2.43.0


