Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFBDC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGod-00084j-Ot; Fri, 25 Jul 2025 07:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoV-0004lI-S3
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoO-0000Ma-R4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso12985255e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443723; x=1754048523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/d9t9PDc6oehK3A7Ja528kE6/uvu3m1U/O8BcSeYFMw=;
 b=sfKDQacf9zZ9H43NFeSlhccTfJR84XToaxK6FNQ0d0LUdhB6DqfGleRCuDRACseNek
 ZywGdjjsQs0dU6mLMsFKe8aQEoSeDrAfalQe/oYy/QDYeSCy/sMjge3vItJ2ppBgWIS/
 PKOnXdq3YsLC+bFJXMJ2f6gUjVa6omTnoiI3uFhF2K3P+GHeNA3Mc66tvqCVGsp1E2gF
 ZyDm/moxHXqLxdo/nH7AulZdK9WWrQQ/NH53YfsIB1V4A8MJrUFzGR7UqS2EdUgOuCcx
 S5X0iArgMwxN3fABJdkQHOQ5GmLBg/Val2CRmGGKCMaxn14rNdf218biWcppQLy4oCNm
 Z6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443723; x=1754048523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/d9t9PDc6oehK3A7Ja528kE6/uvu3m1U/O8BcSeYFMw=;
 b=R2vGiAGetO1ZfZuFZ5Mg0EyRG4IdI915JAo2RcE2K7BBD2WVvmbyUX00ouAfKRGa6A
 AtvOwPRXrLsfIj4e2XhgZpS4bifivFLku8qa+5OgvDjx2/ENFW8k0JfLCmUeMQeplYwJ
 Nng/i3C1krZFBbtUav4W2Vez+hcR3b5mAlumLUKE9uN0uSstnjnbk6qTbeTUHuAV6UvV
 VQ7Xjwi2orCa4OLJpHmXTDFnCAi8Clx7TEeBbC6f3BkLun4pc4wEZ79EA7fNFq5v33KA
 OtxxCKnU+U023ISi0BByZU5+hgwx5ZeJ/hcliFV80Qu90YCq2hizw1aBww7Iuf35aHK3
 wTGQ==
X-Gm-Message-State: AOJu0YyeBaGDY24WnVGVU9jqYv22Fk5BLGbhqGBYT6biB9a1oRwUJhBR
 Fn3YhnetX1iV8T/MrYgGDx8YC6wQrUETHsX/jqGp+ysIZpYZsBXuY6+f7sMs8hCxawzhls3P7+D
 17Pqv
X-Gm-Gg: ASbGncub5XAuA0TPavHozmOwEKfysZZL75YSkfb6Kr5gO+JG+aevIzXMFcKroIGuVrR
 foDPpfldWJAHdPhjVwnszkKLL3O53zayGQsWnZchVmKWGkwafDa7uSKXnlOjG88YrAx5MhDw1Qa
 GDGbmKCGhzln7VPDTh6v83tsnwYXQT5wx/sOOQsWioq/UzbjOW9KQQF1drAxrQ1QDM4ACeCX2KY
 EaX6yCC1Y0X3nJ8kyqlRdTfz2bnumgnL90jo9Odt4O3aJeQIw0dQh72+A1LaQZltjp+cHImqJf7
 79kVbylbweooSUcbfA/KwOM8IglmWtlOellCx99xVHLOYnCZZhBI+oIs191lHUABZ3imZEbqFY+
 e1INP583aiC2ULiV7nGp6vypmP0rYhyAAq0YoIgo=
X-Google-Smtp-Source: AGHT+IFOAbb0iIvX8vZdptA3syWeP0xDexxoqYSKmhsqZLl8+X3pQJA36D2P5TGOCLK0Nvk/m8EZjw==
X-Received: by 2002:a05:600c:64c7:b0:456:24db:2efb with SMTP id
 5b1f17b1804b1-4587631e23dmr15114785e9.15.1753443722147; 
 Fri, 25 Jul 2025 04:42:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.42.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] target/arm: Expand the descriptor for SME/SVE memory ops
 to i64
Date: Fri, 25 Jul 2025 12:41:51 +0100
Message-ID: <20250725114158.3703254-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

We have run out of room attempting to pack both the gvec
descriptor and the mte descriptor into 32 bits.
Here, change nothing except the parameter type, which
affects all declarations, the function typedefs, and the
type used with tcg expansion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250723165458.3509150-2-peter.maydell@linaro.org
---
 target/arm/tcg/helper-sme.h    |  144 ++--
 target/arm/tcg/helper-sve.h    | 1196 ++++++++++++++++----------------
 target/arm/tcg/translate-a64.h |    2 +-
 target/arm/tcg/sme_helper.c    |   16 +-
 target/arm/tcg/sve_helper.c    |   96 +--
 target/arm/tcg/translate-sme.c |    6 +-
 target/arm/tcg/translate-sve.c |   33 +-
 7 files changed, 747 insertions(+), 746 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 1fc756bec6e..c551797c6fa 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -48,87 +48,87 @@ DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2p1_movaz_zc_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1b_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1b_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_ld1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_ld1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1h_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_ld1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_ld1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1s_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_ld1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_ld1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1d_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_ld1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_ld1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_ld1q_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_st1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1b_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_st1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1b_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_st1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_st1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1h_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_st1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_st1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1s_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_st1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_st1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1d_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_5(sme_st1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sme_st1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
+DEF_HELPER_FLAGS_5(sme_st1q_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_5(sme_addha_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addva_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 5e4b7fd8cf4..c3541a8ca86 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1655,1015 +1655,1015 @@ DEF_HELPER_FLAGS_4(sve2_usubw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_usubw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_usubw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1squ_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1dqu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1squ_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1squ_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1dqu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1squ_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1hds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1sds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1squ_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1dqu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1squ_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1sds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ld1squ_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1dqu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1squ_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldff1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldff1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_ldnf1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_ldnf1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
+                   void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1hs_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hs_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hs_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1hd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1hs_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1sq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1sq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1dq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1dq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1sq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1dq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1dq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1hs_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hs_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hs_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1hd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1hs_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1hd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1sd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1sd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1sd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
-DEF_HELPER_FLAGS_4(sve_st1sq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1sq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1dq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1dq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1sq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1dq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
+DEF_HELPER_FLAGS_4(sve_st1dq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbss_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbss_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbds_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbds_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbds_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldqq_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldqq_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbss_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhsu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbss_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbds_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbds_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldbdu_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_lddd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldbds_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldhds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldqq_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldqq_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbss_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbss_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbss_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbss_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_ldffbdu_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffdd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffbds_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffhds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stqq_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stqq_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sths_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_6(sve_stbd_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_sthd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stsd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stqq_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 DEF_HELPER_FLAGS_6(sve_stqq_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+                   void, env, ptr, ptr, ptr, tl, i64)
 
 DEF_HELPER_FLAGS_4(sve2_sqdmull_zzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
@@ -3151,18 +3151,18 @@ DEF_HELPER_FLAGS_3(pmov_vp_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(pmov_vp_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(pmov_vp_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(sve2p1_ld1bb_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_ld1hh_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_ld1hh_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_ld1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_ld1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_ld1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_ld1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1bb_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_ld1hh_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_ld1hh_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_ld1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_ld1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_ld1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_ld1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
 
-DEF_HELPER_FLAGS_5(sve2p1_st1bb_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_st1hh_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_st1hh_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_st1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_st1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_st1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
-DEF_HELPER_FLAGS_5(sve2p1_st1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1bb_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_st1hh_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_st1hh_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_st1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_st1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_st1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
+DEF_HELPER_FLAGS_5(sve2p1_st1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i64)
diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 993dde61a4d..9c45f89305b 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -28,7 +28,7 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
 bool sve_access_check(DisasContext *s);
 bool sme_enabled_check(DisasContext *s);
 bool sme_enabled_check_with_svcr(DisasContext *s, unsigned);
-uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+uint64_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
                           uint32_t msz, bool is_write, uint32_t data);
 
 /* This function corresponds to CheckStreamingSVEEnabled. */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index bb8ed1ed0e2..0b55f13f8c5 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -691,28 +691,28 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
 
 #define DO_LD(L, END, ESZ)                                                 \
 void HELPER(sme_ld1##L##END##_h)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
+                                 target_ulong addr, uint64_t desc)         \
 {                                                                          \
     sme_ld1(env, za, vg, addr, desc, GETPC(), ESZ, 0, false,               \
             sve_ld1##L##L##END##_host, sve_ld1##L##L##END##_tlb,           \
             clear_horizontal, copy_horizontal);                            \
 }                                                                          \
 void HELPER(sme_ld1##L##END##_v)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
+                                 target_ulong addr, uint64_t desc)         \
 {                                                                          \
     sme_ld1(env, za, vg, addr, desc, GETPC(), ESZ, 0, true,                \
             sme_ld1##L##END##_v_host, sme_ld1##L##END##_v_tlb,             \
             clear_vertical_##L, copy_vertical_##L);                        \
 }                                                                          \
 void HELPER(sme_ld1##L##END##_h_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
+                                     target_ulong addr, uint64_t desc)     \
 {                                                                          \
     sme_ld1_mte(env, za, vg, addr, desc, GETPC(), ESZ, false,              \
                 sve_ld1##L##L##END##_host, sve_ld1##L##L##END##_tlb,       \
                 clear_horizontal, copy_horizontal);                        \
 }                                                                          \
 void HELPER(sme_ld1##L##END##_v_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
+                                     target_ulong addr, uint64_t desc)     \
 {                                                                          \
     sme_ld1_mte(env, za, vg, addr, desc, GETPC(), ESZ, true,               \
                 sme_ld1##L##END##_v_host, sme_ld1##L##END##_v_tlb,         \
@@ -876,25 +876,25 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
 
 #define DO_ST(L, END, ESZ)                                                 \
 void HELPER(sme_st1##L##END##_h)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
+                                 target_ulong addr, uint64_t desc)         \
 {                                                                          \
     sme_st1(env, za, vg, addr, desc, GETPC(), ESZ, 0, false,               \
             sve_st1##L##L##END##_host, sve_st1##L##L##END##_tlb);          \
 }                                                                          \
 void HELPER(sme_st1##L##END##_v)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
+                                 target_ulong addr, uint64_t desc)         \
 {                                                                          \
     sme_st1(env, za, vg, addr, desc, GETPC(), ESZ, 0, true,                \
             sme_st1##L##END##_v_host, sme_st1##L##END##_v_tlb);            \
 }                                                                          \
 void HELPER(sme_st1##L##END##_h_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
+                                     target_ulong addr, uint64_t desc)     \
 {                                                                          \
     sme_st1_mte(env, za, vg, addr, desc, GETPC(), ESZ, false,              \
                 sve_st1##L##L##END##_host, sve_st1##L##L##END##_tlb);      \
 }                                                                          \
 void HELPER(sme_st1##L##END##_v_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
+                                     target_ulong addr, uint64_t desc)     \
 {                                                                          \
     sme_st1_mte(env, za, vg, addr, desc, GETPC(), ESZ, true,               \
                 sme_st1##L##END##_v_host, sme_st1##L##END##_v_tlb);        \
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 803f0a094dc..9fc2c05879b 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6384,13 +6384,13 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
 
 #define DO_LD1_1(NAME, ESZ)                                             \
 void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,                 \
-                            target_ulong addr, uint32_t desc)           \
+                            target_ulong addr, uint64_t desc)           \
 {                                                                       \
     sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1, 0,            \
               sve_##NAME##_host, sve_##NAME##_tlb);                     \
 }                                                                       \
 void HELPER(sve_##NAME##_r_mte)(CPUARMState *env, void *vg,             \
-                                target_ulong addr, uint32_t desc)       \
+                                target_ulong addr, uint64_t desc)       \
 {                                                                       \
     sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1,           \
                   sve_##NAME##_host, sve_##NAME##_tlb);                 \
@@ -6398,25 +6398,25 @@ void HELPER(sve_##NAME##_r_mte)(CPUARMState *env, void *vg,             \
 
 #define DO_LD1_2(NAME, ESZ, MSZ)                                        \
 void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,              \
-                               target_ulong addr, uint32_t desc)        \
+                               target_ulong addr, uint64_t desc)        \
 {                                                                       \
     sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1, 0,             \
               sve_##NAME##_le_host, sve_##NAME##_le_tlb);               \
 }                                                                       \
 void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,              \
-                               target_ulong addr, uint32_t desc)        \
+                               target_ulong addr, uint64_t desc)        \
 {                                                                       \
     sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1, 0,             \
               sve_##NAME##_be_host, sve_##NAME##_be_tlb);               \
 }                                                                       \
 void HELPER(sve_##NAME##_le_r_mte)(CPUARMState *env, void *vg,          \
-                                   target_ulong addr, uint32_t desc)    \
+                                   target_ulong addr, uint64_t desc)    \
 {                                                                       \
     sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,            \
                   sve_##NAME##_le_host, sve_##NAME##_le_tlb);           \
 }                                                                       \
 void HELPER(sve_##NAME##_be_r_mte)(CPUARMState *env, void *vg,          \
-                                   target_ulong addr, uint32_t desc)    \
+                                   target_ulong addr, uint64_t desc)    \
 {                                                                       \
     sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,            \
                   sve_##NAME##_be_host, sve_##NAME##_be_tlb);           \
@@ -6450,13 +6450,13 @@ DO_LD1_2(ld1dqu, MO_64, MO_128)
 
 #define DO_LDN_1(N)                                                     \
 void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,                \
-                             target_ulong addr, uint32_t desc)          \
+                             target_ulong addr, uint64_t desc)          \
 {                                                                       \
     sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N, 0,           \
               sve_ld1bb_host, sve_ld1bb_tlb);                           \
 }                                                                       \
 void HELPER(sve_ld##N##bb_r_mte)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint64_t desc)      \
 {                                                                       \
     sve_ldN_r_mte(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,          \
                   sve_ld1bb_host, sve_ld1bb_tlb);                       \
@@ -6464,25 +6464,25 @@ void HELPER(sve_ld##N##bb_r_mte)(CPUARMState *env, void *vg,            \
 
 #define DO_LDN_2(N, SUFF, ESZ)                                          \
 void HELPER(sve_ld##N##SUFF##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N, 0,             \
               sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);         \
 }                                                                       \
 void HELPER(sve_ld##N##SUFF##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N, 0,             \
               sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);         \
 }                                                                       \
 void HELPER(sve_ld##N##SUFF##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,            \
                   sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ld##N##SUFF##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,            \
                   sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);     \
@@ -6750,25 +6750,25 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
 
 #define DO_LDFF1_LDNF1_1(PART, ESZ)                                     \
 void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint64_t desc)      \
 {                                                                       \
     sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_FIRST, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint64_t desc)      \
 {                                                                       \
     sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_NO, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_r_mte)(CPUARMState *env, void *vg,        \
-                                     target_ulong addr, uint32_t desc)  \
+                                     target_ulong addr, uint64_t desc)  \
 {                                                                       \
     sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
                       sve_ld1##PART##_host, sve_ld1##PART##_tlb);       \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r_mte)(CPUARMState *env, void *vg,        \
-                                     target_ulong addr, uint32_t desc)  \
+                                     target_ulong addr, uint64_t desc)  \
 {                                                                       \
     sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
@@ -6776,49 +6776,49 @@ void HELPER(sve_ldnf1##PART##_r_mte)(CPUARMState *env, void *vg,        \
 
 #define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ)                                \
 void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
                       sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
                       sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
                       sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
                       sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
@@ -7007,13 +7007,13 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
 
 #define DO_STN_1(N, NAME, ESZ)                                          \
 void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint64_t desc)      \
 {                                                                       \
     sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N, 0,            \
               sve_st1##NAME##_host, sve_st1##NAME##_tlb);               \
 }                                                                       \
 void HELPER(sve_st##N##NAME##_r_mte)(CPUARMState *env, void *vg,        \
-                                     target_ulong addr, uint32_t desc)  \
+                                     target_ulong addr, uint64_t desc)  \
 {                                                                       \
     sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
                   sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
@@ -7021,25 +7021,25 @@ void HELPER(sve_st##N##NAME##_r_mte)(CPUARMState *env, void *vg,        \
 
 #define DO_STN_2(N, NAME, ESZ, MSZ)                                     \
 void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
               sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);         \
 }                                                                       \
 void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint64_t desc)   \
 {                                                                       \
     sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
               sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);         \
 }                                                                       \
 void HELPER(sve_st##N##NAME##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
                   sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_st##N##NAME##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
+                                        target_ulong addr, uint64_t desc) \
 {                                                                       \
     sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
                   sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);     \
@@ -7204,13 +7204,13 @@ void sve_ld1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
 
 #define DO_LD1_ZPZ_S(MEM, OFS, MSZ) \
 void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                 void *vm, target_ulong base, uint32_t desc) \
+                                 void *vm, target_ulong base, uint64_t desc) \
 {                                                                            \
     sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 4, 1 << MSZ,          \
               off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }                                                                            \
 void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-     void *vm, target_ulong base, uint32_t desc)                             \
+     void *vm, target_ulong base, uint64_t desc)                             \
 {                                                                            \
     sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,         \
                   off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
@@ -7218,13 +7218,13 @@ void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
 
 #define DO_LD1_ZPZ_D(MEM, OFS, MSZ) \
 void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                 void *vm, target_ulong base, uint32_t desc) \
+                                 void *vm, target_ulong base, uint64_t desc) \
 {                                                                            \
     sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 8, 1 << MSZ,          \
               off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }                                                                            \
 void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-    void *vm, target_ulong base, uint32_t desc)                              \
+    void *vm, target_ulong base, uint64_t desc)                              \
 {                                                                            \
     sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,         \
                   off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
@@ -7418,14 +7418,14 @@ void sve_ldff1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
 #define DO_LDFF1_ZPZ_S(MEM, OFS, MSZ)                                   \
 void HELPER(sve_ldff##MEM##_##OFS)                                      \
     (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
+     void *vm, target_ulong base, uint64_t desc)                        \
 {                                                                       \
     sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), 0, MO_32, MSZ,    \
                 off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
 }                                                                       \
 void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
     (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
+     void *vm, target_ulong base, uint64_t desc)                        \
 {                                                                       \
     sve_ldff1_z_mte(env, vd, vg, vm, base, desc, GETPC(), MO_32, MSZ,   \
                     off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
@@ -7434,14 +7434,14 @@ void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
 #define DO_LDFF1_ZPZ_D(MEM, OFS, MSZ)                                   \
 void HELPER(sve_ldff##MEM##_##OFS)                                      \
     (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
+     void *vm, target_ulong base, uint64_t desc)                        \
 {                                                                       \
     sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), 0, MO_64, MSZ,    \
                 off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
 }                                                                       \
 void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
     (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
+     void *vm, target_ulong base, uint64_t desc)                        \
 {                                                                       \
     sve_ldff1_z_mte(env, vd, vg, vm, base, desc, GETPC(), MO_64, MSZ,   \
                     off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
@@ -7621,13 +7621,13 @@ void sve_st1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
 
 #define DO_ST1_ZPZ_S(MEM, OFS, MSZ)                                     \
 void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
-                                 void *vm, target_ulong base, uint32_t desc) \
+                                 void *vm, target_ulong base, uint64_t desc) \
 {                                                                       \
     sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 4, 1 << MSZ,     \
               off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
 }                                                                       \
 void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-    void *vm, target_ulong base, uint32_t desc)                         \
+    void *vm, target_ulong base, uint64_t desc)                         \
 {                                                                       \
     sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,    \
                   off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
@@ -7635,13 +7635,13 @@ void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
 
 #define DO_ST1_ZPZ_D(MEM, OFS, MSZ)                                     \
 void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
-                                 void *vm, target_ulong base, uint32_t desc) \
+                                 void *vm, target_ulong base, uint64_t desc) \
 {                                                                       \
     sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 8, 1 << MSZ,     \
               off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
 }                                                                       \
 void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-    void *vm, target_ulong base, uint32_t desc)                         \
+    void *vm, target_ulong base, uint64_t desc)                         \
 {                                                                       \
     sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,    \
                   off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
@@ -7995,7 +7995,7 @@ void sve2p1_ld1_c(CPUARMState *env, ARMVectorReg *zd, const vaddr addr,
 }
 
 void HELPER(sve2p1_ld1bb_c)(CPUARMState *env, void *vd, target_ulong addr,
-                            uint32_t png, uint32_t desc)
+                            uint32_t png, uint64_t desc)
 {
     sve2p1_ld1_c(env, vd, addr, png, desc, GETPC(), MO_8,
                  sve_ld1bb_host, sve_ld1bb_tlb);
@@ -8004,14 +8004,14 @@ void HELPER(sve2p1_ld1bb_c)(CPUARMState *env, void *vd, target_ulong addr,
 #define DO_LD1_2(NAME, ESZ)                                             \
 void HELPER(sve2p1_##NAME##_le_c)(CPUARMState *env, void *vd,           \
                                   target_ulong addr, uint32_t png,      \
-                                  uint32_t desc)                        \
+                                  uint64_t desc)                        \
 {                                                                       \
     sve2p1_ld1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);            \
 }                                                                       \
 void HELPER(sve2p1_##NAME##_be_c)(CPUARMState *env, void *vd,           \
                                   target_ulong addr, uint32_t png,      \
-                                  uint32_t desc)                        \
+                                  uint64_t desc)                        \
 {                                                                       \
     sve2p1_ld1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);            \
@@ -8154,7 +8154,7 @@ void sve2p1_st1_c(CPUARMState *env, ARMVectorReg *zd, const vaddr addr,
 }
 
 void HELPER(sve2p1_st1bb_c)(CPUARMState *env, void *vd, target_ulong addr,
-                           uint32_t png, uint32_t desc)
+                           uint32_t png, uint64_t desc)
 {
     sve2p1_st1_c(env, vd, addr, png, desc, GETPC(), MO_8,
                  sve_st1bb_host, sve_st1bb_tlb);
@@ -8163,14 +8163,14 @@ void HELPER(sve2p1_st1bb_c)(CPUARMState *env, void *vd, target_ulong addr,
 #define DO_ST1_2(NAME, ESZ)                                             \
 void HELPER(sve2p1_##NAME##_le_c)(CPUARMState *env, void *vd,           \
                                   target_ulong addr, uint32_t png,      \
-                                  uint32_t desc)                        \
+                                  uint64_t desc)                        \
 {                                                                       \
     sve2p1_st1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);            \
 }                                                                       \
 void HELPER(sve2p1_##NAME##_be_c)(CPUARMState *env, void *vd,           \
                                   target_ulong addr, uint32_t png,      \
-                                  uint32_t desc)                        \
+                                  uint64_t desc)                        \
 {                                                                       \
     sve2p1_st1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);            \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 65fc8bc9b2f..091c56da4f4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -387,7 +387,7 @@ TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
 
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
-    typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
+    typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i64);
 
     /*
      * Indexed by [esz][be][v][mte][st], which is (except for load/store)
@@ -415,7 +415,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     TCGv_ptr t_za, t_pg;
     TCGv_i64 addr;
-    uint32_t desc;
+    uint64_t desc;
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
@@ -440,7 +440,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     desc = make_svemte_desc(s, streaming_vec_reg_size(s), 1, a->esz, a->st, 0);
 
     fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
-                                      tcg_constant_i32(desc));
+                                      tcg_constant_i64(desc));
     return true;
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2ed440aff15..849151826e2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -31,9 +31,9 @@ typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
-typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i32);
+typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i64);
 typedef void gen_helper_gvec_mem_scatter(TCGv_env, TCGv_ptr, TCGv_ptr,
-                                         TCGv_ptr, TCGv_i64, TCGv_i32);
+                                         TCGv_ptr, TCGv_i64, TCGv_i64);
 
 /*
  * Helpers for extracting complex instruction fields.
@@ -4883,11 +4883,11 @@ static const uint8_t dtype_esz[19] = {
     4, 4, 4,
 };
 
-uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+uint64_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
                           uint32_t msz, bool is_write, uint32_t data)
 {
     uint32_t sizem1;
-    uint32_t desc = 0;
+    uint64_t desc = 0;
 
     /* Assert all of the data fits, with or without MTE enabled. */
     assert(nregs >= 1 && nregs <= 4);
@@ -4911,7 +4911,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                        gen_helper_gvec_mem *fn)
 {
     TCGv_ptr t_pg;
-    uint32_t desc;
+    uint64_t desc;
 
     if (!s->mte_active[0]) {
         addr = clean_data_tbi(s, addr);
@@ -4927,7 +4927,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc));
+    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
 }
 
 /* Indexed by [mte][be][dtype][nreg] */
@@ -5379,7 +5379,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
     int poff;
-    uint32_t desc;
+    uint64_t desc;
 
     /* Load the first quadword using the normal predicated load helpers.  */
     if (!s->mte_active[0]) {
@@ -5410,7 +5410,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
     desc = make_svemte_desc(s, 16, 1, dtype_msz(dtype), false, zt);
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc));
+    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
 
     /* Replicate that first quadword.  */
     if (vsz > 16) {
@@ -5453,7 +5453,7 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     unsigned vsz_r32;
     TCGv_ptr t_pg;
     int poff, doff;
-    uint32_t desc;
+    uint64_t desc;
 
     if (vsz < 32) {
         /*
@@ -5494,7 +5494,7 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     gen_helper_gvec_mem *fn
         = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
     desc = make_svemte_desc(s, 32, 1, dtype_msz(dtype), false, zt);
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc));
+    fn(tcg_env, t_pg, addr, tcg_constant_i64(desc));
 
     /*
      * Replicate that first octaword.
@@ -5828,14 +5828,14 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     TCGv_ptr t_zm = tcg_temp_new_ptr();
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
-    uint32_t desc;
+    uint64_t desc;
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
     tcg_gen_addi_ptr(t_zm, tcg_env, vec_full_reg_offset(s, zm));
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
 
     desc = make_svemte_desc(s, vec_full_reg_size(s), 1, msz, is_write, scale);
-    fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i32(desc));
+    fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i64(desc));
 }
 
 /* Indexed by [mte][be][ff][xs][u][msz].  */
@@ -8079,7 +8079,7 @@ static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
                        MemOp esz, bool is_write, int n, bool strided)
 {
     typedef void ldst_c_fn(TCGv_env, TCGv_ptr, TCGv_i64,
-                           TCGv_i32, TCGv_i32);
+                           TCGv_i32, TCGv_i64);
     static ldst_c_fn * const f_ldst[2][2][4] = {
         { { gen_helper_sve2p1_ld1bb_c,
             gen_helper_sve2p1_ld1hh_le_c,
@@ -8100,9 +8100,10 @@ static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
             gen_helper_sve2p1_st1dd_be_c, } }
     };
 
-    TCGv_i32 t_png, t_desc;
+    TCGv_i32 t_png;
+    TCGv_i64 t_desc;
     TCGv_ptr t_zd;
-    uint32_t desc, lg2_rstride = 0;
+    uint64_t desc, lg2_rstride = 0;
     bool be = s->be_data == MO_BE;
 
     assert(n == 2 || n == 4);
@@ -8132,7 +8133,7 @@ static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
     desc = n == 2 ? 0 : 1;
     desc = desc | (lg2_rstride << 1);
     desc = make_svemte_desc(s, vec_full_reg_size(s), 1, esz, is_write, desc);
-    t_desc = tcg_constant_i32(desc);
+    t_desc = tcg_constant_i64(desc);
 
     t_png = tcg_temp_new_i32();
     tcg_gen_ld16u_i32(t_png, tcg_env,
-- 
2.43.0


