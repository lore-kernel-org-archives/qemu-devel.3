Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B394CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mIE-0004rv-FT; Tue, 15 Apr 2025 15:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCa-00032y-VV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:17 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBc-0008EE-Jv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:12 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c0e135e953so622682885a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746187; x=1745350987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hFnYeJKgvTco35iIcxVFzyI3nrLlH/dm/A1BmcF8NhQ=;
 b=JpqkSkbppLkhj4C9QTEF2RporsoLUMpGy6ILhIin8aUlb/TOczb7KGCbMPergsAC+J
 2qwed08xRKudcyf541Eg5dGGm1JFkptPC7P9yEsDr3XnlZXfBw+pj9cnQPQ7R4kCVkM3
 gI4MIzA3JDkAawiv5pAwlGzj8+vLIP1k1GhE3y1YxZnNP5Mfw+dPsO1tM8GjulUAjHmR
 G7GGNyu3VXubWOjvdNqIOj7M4m/VIxl36sHBMQ5UUKlk4mjv9Oj3OhBZEWqP2WBByTR6
 I9TATSEDRJ0wnwN4HWf70vwrpN23NEFFCv8HMlu/8K7xS6zYU2EhvR4SD5IEMDu2TAp5
 t3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746187; x=1745350987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFnYeJKgvTco35iIcxVFzyI3nrLlH/dm/A1BmcF8NhQ=;
 b=See8nu0RnNzTgwSaoaqfCs1KDArvubp834dFQg11MfhVXnFpW7Y1L24lgOlFGiAVnu
 bPhbye1E8AV5EqJZmNr1BPWozmJzQhlC0bGDCFSsW+4HZIFhK2QdmX9jtHm+xgxx1Q5V
 WTyoBzy459o/uYxTEpPaPkCrajAq9IJj0AgeM5r5v0R8ZWbuIdWHDdhJrKu2HetxRtYo
 SJMz6uxL+4hS+JxTzdyfyIu/wB+tPFTewMAU6iMp/MRfF7+hiqqzn2U5LYojk5zGy5gE
 4Nvj5XMfsu7l+qeTn6mo/TgmF96VsR3KYTUZSgFutswgsTOXLtxzIm4+HcSrecVk0/DN
 3ceQ==
X-Gm-Message-State: AOJu0YwX6WEqtnF8629p3Z8bHClN0/jyDc8/WlUhosC0lJvbUYctytBP
 CLLdjY2DbakSusAuZJGjkfVRKT3JoWggGEdmHXkfwwpbW3cPTxgUd4KJ6Bro1u1G7vkLgnIAOQA
 Y
X-Gm-Gg: ASbGncu7892US/aWkSV3xk4+3o45IUGmvFVSD1IBaGtPwctQWdSglghMOumeCkIushp
 3WHBe9urfaNpH3GFcO2k/095jTrtAAj+NYRgZNwdoQrXE7gpe47RuZM7HwIAYXcBaxD5gcvcV3Y
 Nja/mIs3yMJ5TTKN4bVGqO8pjxv5FHmFd/BWHwo2tiKULW9w0L3Qj0QD8/0NXZhxM7B/elilUry
 QC8y5JTamhu1Q3w5zCHmzlo/7J9CACt9p+1iNPixQk8o12cueYh8zbbexURLqkZpAVfYQjHdjUL
 O3gHu5tzS5vFPYMj/lIOJfHTfVKu1TK+uLF5ATxsNya9ArujOfmtmnRHmWwmMzSmEQ7B9UcHc0s
 =
X-Google-Smtp-Source: AGHT+IGQzgTxvpui5IC++3PKWNbHCVrvTi8iQDwvg/GaqoeVa6KtGTCepsrH7t2RZcb+QGiRXL29LA==
X-Received: by 2002:a05:6a00:2e11:b0:736:52d7:daca with SMTP id
 d2e1a72fcca58-73c1fafc18dmr1126600b3a.18.1744745761169; 
 Tue, 15 Apr 2025 12:36:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 124/163] target/arm: Use tcg_gen_addcio_* for ADCS
Date: Tue, 15 Apr 2025 12:24:35 -0700
Message-ID: <20250415192515.232910-125-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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
index 934d66848a..99545a900d 100644
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
index d280018138..e5aa76d44a 100644
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


