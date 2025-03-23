Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F71C36008
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGZ-0005rO-BT; Sun, 23 Mar 2025 13:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGX-0005qA-QP
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:41 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGW-0002uR-6u
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224171d6826so46322045ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751459; x=1743356259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+vLIWb2Nw1GLPq2/BHeGFtpTQCooqKOLeKJY8lQCig=;
 b=DAkiNHvGRsS2k3c48YfAaog5bKI+lqpkPoryIG0abF8K0hIfyuBPUYvze1rHiMihYk
 V+KUSL4qCNR8gABd5ic4nL3jCnMLy1/NrBVuLaZah700RnTJwlSoq/8HibfqNeJKtsvH
 /3Mu5TVJRznBaAW0NtxJMYN4rIUR//Hv/98n6IecopfxtpXqhFpOsZodMWUmu95iqj7t
 06iEPfX/6heyW2gBNdFcjwBPC5mWuDbMg334GgAsVZ2GSkxKt0dkt461lpn/XevD33jQ
 DFRBAZIFpSn2iaO42+buW7nWAX6mC7J1/55uYBijfT6wZlcwa6Dm+jLwWebwYHTKEZPV
 RVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751459; x=1743356259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+vLIWb2Nw1GLPq2/BHeGFtpTQCooqKOLeKJY8lQCig=;
 b=LpTfP4rYRed+NS7JI/cSE6Cmu0lFbkbiDTP/1mvZbYA3SJ/dlLwISo9uIFWozpQxP1
 z1aQWIa0i/8G/lk0i1BJYYjB/TWmgNe++IGC4KOOXrpwUvpaFRFuDnJ1iR2MTVQXj4eM
 HmdUEBfkrpIF7w1Gs9aKW0K83fN+5A5ZD+QlZLFZaD1WK3RAAnA0J6NjAadg6SeOzL4Y
 uPTat+wLBGoeGr460QhH1pcCcKFi0akbCTDCBxHKcGC1Zgw64ocQIMpcOVFJwnaZxNZr
 Al/y6FfZye/U07LoDfYA/K2DUvj2c2zkS4obYtzLJClKLyXbFNK5y4hAcseC8QGqFA2j
 THKg==
X-Gm-Message-State: AOJu0YyJ16MCQTt5SzACrTBcKUGETw4rdDVaCr+nNFBhBOCC4/HsPT8c
 yXLvb/GDXRggZ/f9vv5V3kFO4fNZgfaizxwSNU8IAadBOXIeLyb/wHj1gUymErjvW/F0e5TAkKu
 /
X-Gm-Gg: ASbGnct4pW4DnLMYxKP75xbYSr2RUzwZL6A8tApSi3IREearOmuTs90Sy0qHwLDohR2
 gY8qlkWXcuCxXdR+JATZIJLw3JhJZGHdXBsBBNj4GnOOtHt1r3LWPdkOtmB2Lqkb7GC/meQGxYK
 Wc7r6FY+mCxFbnu9E203o+0AoZTKoVo9eC/YzLzVp9eqBQrQ/q4xSkhNSNxVzh5LDvQFu9Z088j
 FNQGp5z9vq55MtaX7850Q5QRLQvcImjLQxQXcILE55OSRGtI03lmi+WFEKKrhKW2jL3n8qPz5dX
 qZ3XiQyQgJ1+rFZXU7DPv6Y+/9fD9UO5uPgvxxlELCJc++a/4pmhkTZqRHfklleW7NwhS5x+0nQ
 c
X-Google-Smtp-Source: AGHT+IF0rn6volJhof4Cblgwxtyuw23K5pkcWeEqt9RzdZlH9qmfjGipBE1VOhJ4TECBUyJ5i0nJsA==
X-Received: by 2002:a17:903:2284:b0:220:cb6c:2e30 with SMTP id
 d9443c01a7336-22780e312bbmr174358795ad.49.1742751458814; 
 Sun, 23 Mar 2025 10:37:38 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 10/17] target/avr: Update cpu_sp after push and pop
Date: Sun, 23 Mar 2025 10:37:22 -0700
Message-ID: <20250323173730.3213964-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Not that AVR has memory paging traps, but it's better
form to allow the memory operation to finish before
updating the cpu register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 6bb4154dff..3446007be1 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -967,40 +967,38 @@ static void gen_push_ret(DisasContext *ctx, int ret)
     } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
         TCGv t0 = tcg_constant_i32(ret & 0x00ffff);
 
-        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
-        gen_data_store_raw(ctx, t0, cpu_sp, 0, MO_BEUW);
-        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+        gen_data_store_raw(ctx, t0, cpu_sp, -1, MO_BEUW);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
     } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
         TCGv lo = tcg_constant_i32(ret & 0x0000ff);
         TCGv hi = tcg_constant_i32((ret & 0xffff00) >> 8);
 
         gen_data_store_raw(ctx, lo, cpu_sp, 0, MO_UB);
-        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
-        gen_data_store_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
-        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+        gen_data_store_raw(ctx, hi, cpu_sp, -2, MO_BEUW);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 3);
+    } else {
+        g_assert_not_reached();
     }
 }
 
 static void gen_pop_ret(DisasContext *ctx, TCGv ret)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
+        gen_data_load_raw(ctx, ret, cpu_sp, 1, MO_UB);
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
-        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_UB);
     } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
-        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
-        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_BEUW);
-        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        gen_data_load_raw(ctx, ret, cpu_sp, 1, MO_BEUW);
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
     } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
-        TCGv lo = tcg_temp_new_i32();
         TCGv hi = tcg_temp_new_i32();
 
-        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
-        gen_data_load_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
+        gen_data_load_raw(ctx, hi, cpu_sp, 1, MO_BEUW);
+        gen_data_load_raw(ctx, ret, cpu_sp, 3, MO_UB);
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 3);
 
-        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
-        gen_data_load_raw(ctx, lo, cpu_sp, 0, MO_UB);
-
-        tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
+        tcg_gen_deposit_tl(ret, ret, hi, 8, 16);
+    } else {
+        g_assert_not_reached();
     }
 }
 
-- 
2.43.0


