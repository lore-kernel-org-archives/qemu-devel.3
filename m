Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01697C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfk-0007YA-Ak; Wed, 02 Jul 2025 08:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfg-0007WT-Rr
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:41 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfV-0000xG-1Z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:40 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-61208b86da2so89355eaf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459665; x=1752064465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GH6Ad5BaJtxdBkiinUY7/X5vKVIV/ggzsySF13b5Img=;
 b=SgKOKecxzCrwISsNROrq6jEF/PJaTZXmRt/PNtiBSYoxP+7IrF7LTakvps5HJdfybd
 wcxgjYw7j/kIZqJlgkn9K7jICauv3vG1lTC6LdPMk4tXansdB+PWOdovWJqRRMdNGdAZ
 RhP68Oiiuk5Xf6z3zYurpiuV61dAQEb2ZvigRV1UvBEQPb9fO+dFQ4j5kBXZEgYtCPGY
 LLBUZxU8P6iGBqHxBdI79ttY4XTlAwrf+gTgtfKddQM05W65V4dhnJt1rrBQjBxlq+1g
 nQIhkkUTl5vvC5rw2ByrueVHPK+gz/U/6MXgBXAbYl0AnmMrcAOJTnKbxEhl5ICu7QP9
 So5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459665; x=1752064465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GH6Ad5BaJtxdBkiinUY7/X5vKVIV/ggzsySF13b5Img=;
 b=pZJ3PzpWNe5bhgn7v4z2Lm9zv5kMXdcBxD6Swcny7LIVF5Nq4ANSGCGgB4CYuSAfyG
 npAj6WZAnHXO8kEdg9CQs7g8jISaCuMxL3FWh4yPrXGs12iST/UVW8nPcWLB95KwLGTG
 ded3kyn6LlMSO0uMqBe5pOjLPy7HMr5iZtdPvB33asNrUciTEtuD3anbB31tSqHgumIT
 goYJGaFiFT6ZMqd9fQbNIg0qRxqRHOGqljC3E7SQoO0nbfLvtof+i8IBBnl897vYrdVA
 VBfoUBJUt2ToJh6mjujv6Mcnh9R8730w90FyNLqP18Cn0DWt022q8UZru+l+N92X4Cbs
 iwrw==
X-Gm-Message-State: AOJu0YxISPRK8xIYGDKv/yq1iLpa49X6nsTl4J8wvg7Bky5PoXuUROqg
 3JwZl6PnxmcstbLcODptX95MkiW6yWMsfC+qbhhgFr9b0brSSCIZBi613eNanXVhTfqRQXlprUP
 bLCHDPDI=
X-Gm-Gg: ASbGncv0WdTRkOtdYJHgHtrKvSbW9mcTILUgyzFqK/skYQaInl+6LrTuXquLnh/rLrj
 W3BcypfzSEZUey/4AXn22J1AMhjZkTQSHXDZFYcywGPNjNrafO0eULBjWYDz1ih8lJNWuzqXtOK
 Aka1ZJxdrgzkfbkCPFDZy2zo6LsqgKMoRK8U/oxTS+0/99bYdLpQuNRlwi0ZDs2K1yqhanbN/HS
 JdOwLEKgANkPHohlz+wLyy0RlF7I1Eq/1hr/VSp4YmYWRlr8NgLLdKmN6Sqza9IrUXHc+qrwFfO
 LwAYhny5q78xzKmmUbkyT9JNnxyA9je9Z/u31yimLkNNoAo/5OGAQyv+OsuM5g7b6j3h/g==
X-Google-Smtp-Source: AGHT+IG3bakJjbvMH612WW1smrEjnW9KCsx79wZA82igEYybHVxfiKwKaxpF3jTvEaM2+50xgug7rw==
X-Received: by 2002:a05:6870:9581:b0:2d4:d07c:7cc5 with SMTP id
 586e51a60fabf-2f5a8a11816mr1960436fac.12.1751459665206; 
 Wed, 02 Jul 2025 05:34:25 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 10/97] target/arm: Implement SME2 MOVT
Date: Wed,  2 Jul 2025 06:32:43 -0600
Message-ID: <20250702123410.761208-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 target/arm/tcg/sme.decode      |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9f25273992..797035e289 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -210,6 +210,19 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
+                    void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    if (sme2_zt0_enabled_check(s)) {
+        func(cpu_reg(s, a->rt), tcg_env,
+             offsetof(CPUARMState, za_state.zt0) + a->off * 8);
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
+TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index cef49c3b29..83ca6a9104 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -39,6 +39,11 @@ MOVA            11000000 esz:2 00001 0 v:1 .. pg:3 0 za_imm:4 zr:5  \
 MOVA            11000000 11    00001 1 v:1 .. pg:3 0 za_imm:4 zr:5  \
                 &mova to_vec=1 rs=%mova_rs esz=4
 
+### SME Move into/from ZT0
+
+MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
+MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za_imm v:bool st:bool
-- 
2.43.0


