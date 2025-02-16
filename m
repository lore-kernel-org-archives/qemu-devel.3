Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176CDC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnwo-0004OS-Gm; Sun, 16 Feb 2025 18:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwS-0003zP-1F
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:52 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwO-0006QI-2J
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:51 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220dc3831e3so52096675ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748046; x=1740352846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q9460XXacMlbRxt0X37CXzor/TkaMDe1Ygr/LeYKR8s=;
 b=u8NcovLsuX/4cHqQuUuPeJGtowduRCm7hJUo+PXOtCpLSZRQQxWii1iADuENax6EWo
 O32CEsW7WxawQFU7MMPRn9vbboF+m40VjSe4Rk8aBdsUBJF6yh2PchhHd4ZIhWi7fp+q
 HBBGdOPCvSryEJx6TLR2veBgVoP71d+2MXoWlY9+oZuJ0Gn/XSU2Mai0/zn/ItB/+LYe
 yo2IJZvDeDubIvWIR3VJVOE1SipwX9j+NOumMzmUJDbyppSlf4yveysbNUJa0ji5xA1Q
 7jUbU/w+7wwnkvgp6xPUlVIn2iQE20E/s5wCZJR1jfSujN2CdsyKnhRjK7SR1zFC5FxC
 G97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748046; x=1740352846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9460XXacMlbRxt0X37CXzor/TkaMDe1Ygr/LeYKR8s=;
 b=YkKcMbiwe69FNkG0lGTDcf5JQiGgyNJturUXvZCG5/ry/Zb560Ylp09u16gi2vduM1
 jR2CF4Y4Kn/569pORzTXG4aGlAIM3VK3eZzQenuO8B8Jlz0kW7PLsjZefPBfsSOduGlc
 kyDY7z2g/Xb4kpm1dv0FLOpUtHBwjErfqgTbJAn+PyspeksjF6QgDq6VK3+lkXC3uhJG
 KoHgcHO1v5jw+HXIr+lmsnTK4pHhSfoFDVGdoGeOfUz+2ZJik+YakSAbwRMCmdgR9QeJ
 Znywa2i8XNFgILjBRecH9zZto3BGfZy2+YWJIlMxb/UhdjIg8avzGUR+UeVa48BUbu4X
 lckQ==
X-Gm-Message-State: AOJu0YynOx0i6fZer8oJbeQj2x2GBory+SRpzn7we4prLiXMCDY2pI/o
 gko/rRZZ/aUBv/aS5W1BnWP2E5mDsfmtYejJDJ7znyvGJrt2jz1o8G9etN7TFY3wqzZFAheIFIc
 z
X-Gm-Gg: ASbGnct5BbLQkaHUVKpaAoiHIqCnQSYTKx8d1bSroczR/W2Ct2Ng0BSW5GzoJKv034b
 cgdayfkWDISohY+lbTq18so7GlPw2Betb79ebEz0nnhVwLZex8KUOPSkktg65rTDxp4/bKuEnIY
 T5jBilx+13AH9rRTTuSrk2wY9yoLW+ZOw1n1uxhd0GaJupyE1KO9uJG+JxIwdu4biHn5pFWl992
 Mhd8T4l6KXYEq1JepFRd0OrD2Weq5aEqIcFGKuouKgAxvGo9F03Px+QNDdJ3W/xCP6d+VsKlISM
 dADVsx9HV6n78EeBsfE34mzyHzJLtF1G6aLNZcelvZnXRtM=
X-Google-Smtp-Source: AGHT+IFojJFPPe/Tuyb4jkSPkT7zXREyFtUT2Ni9q0y40+OYAGFgmra9so58gqdAo7eJ7AOJMrTpiA==
X-Received: by 2002:a17:90b:1c11:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-2fc0f9542cbmr22624616a91.7.1739748046608; 
 Sun, 16 Feb 2025 15:20:46 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 123/162] target/arm: Use tcg_gen_addcio_* for ADCS
Date: Sun, 16 Feb 2025 15:09:32 -0800
Message-ID: <20250216231012.2808572-124-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c |  8 ++------
 target/arm/tcg/translate.c     | 17 +++--------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7587cad923..898382be85 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1076,11 +1076,9 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
         TCGv_i64 cf_64 = tcg_temp_new_i64();
         TCGv_i64 vf_64 = tcg_temp_new_i64();
         TCGv_i64 tmp = tcg_temp_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
 
         tcg_gen_extu_i32_i64(cf_64, cpu_CF);
-        tcg_gen_add2_i64(result, cf_64, t0, zero, cf_64, zero);
-        tcg_gen_add2_i64(result, cf_64, result, cf_64, t1, zero);
+        tcg_gen_addcio_i64(result, cf_64, t0, t1, cf_64);
         tcg_gen_extrl_i64_i32(cpu_CF, cf_64);
         gen_set_NZ64(result);
 
@@ -1094,12 +1092,10 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
         TCGv_i32 t0_32 = tcg_temp_new_i32();
         TCGv_i32 t1_32 = tcg_temp_new_i32();
         TCGv_i32 tmp = tcg_temp_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
 
         tcg_gen_extrl_i64_i32(t0_32, t0);
         tcg_gen_extrl_i64_i32(t1_32, t1);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0_32, zero, cpu_CF, zero);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1_32, zero);
+        tcg_gen_addcio_i32(cpu_NF, cpu_CF, t0_32, t1_32, cpu_CF);
 
         tcg_gen_mov_i32(cpu_ZF, cpu_NF);
         tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 68ac393415..cbfcbd9d79 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -493,20 +493,9 @@ static void gen_add_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 static void gen_adc_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    if (tcg_op_supported(INDEX_op_add2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_movi_i32(tmp, 0);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0, tmp, cpu_CF, tmp);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1, tmp);
-    } else {
-        TCGv_i64 q0 = tcg_temp_new_i64();
-        TCGv_i64 q1 = tcg_temp_new_i64();
-        tcg_gen_extu_i32_i64(q0, t0);
-        tcg_gen_extu_i32_i64(q1, t1);
-        tcg_gen_add_i64(q0, q0, q1);
-        tcg_gen_extu_i32_i64(q1, cpu_CF);
-        tcg_gen_add_i64(q0, q0, q1);
-        tcg_gen_extr_i64_i32(cpu_NF, cpu_CF, q0);
-    }
+
+    tcg_gen_addcio_i32(cpu_NF, cpu_CF, t0, t1, cpu_CF);
+
     tcg_gen_mov_i32(cpu_ZF, cpu_NF);
     tcg_gen_xor_i32(cpu_VF, cpu_NF, t0);
     tcg_gen_xor_i32(tmp, t0, t1);
-- 
2.43.0


