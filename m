Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC485C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8J-0006Rf-M6; Wed, 15 May 2024 05:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8D-000606-H9
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:05 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8A-0001fh-80
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:05 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f12ccff5eso9109214e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766060; x=1716370860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc9+7FT9ewR5kS1vQGkFjz332Ns1o4RnoFgiZ7ZrChg=;
 b=ZxKitB7hhV68mhtrrdMBU8nm0iIjxQEEDu7t3BGytcy7cqxFDun2lNPVy/sLdRL4/O
 4Yb7RX9EencsQ1euoqRmfeu9ucbkB3XtdDrsEHQdEoWe0Bd/GIhauJVS/7dLUoDeiUNL
 VTtJsGzn92FKQMjrSKtjMu+MdxISlV+90JkaJfyNod3g+E5ObizOUNJs+5XQ0tB/xlbN
 +/WZ0OmTJwhh7P36OSkDF8OUZ3LZAnEJjert85Pc6OgS3XH4ODSIC0g66UFIf5x6AFl6
 KGbfu54Uw3n01vLJC8DJTLlWEK3mDi1Uzy9bMEqLS2vubE9sBBLY9g0F5Ar+MVKBD1RB
 47gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766060; x=1716370860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bc9+7FT9ewR5kS1vQGkFjz332Ns1o4RnoFgiZ7ZrChg=;
 b=wztr0+sIfhf2sihf6q5TiIRdULLAUJ/joKLWf0fjs1CwXaRwy6sb028nCt1ojYWScj
 4SSmNZgpfmyrMwcOMzZF1oGbn4zLIJlCFHk1YhpeuAzO/YRD+Pxb+6+4xYcm8yF9f7Ol
 uqN7tIXGq54wGPi5W5Mlgu+yGUJPNhKmsUTaO8TIsmz773Ya2/36XJrgzs2jpq1yo5iO
 ekEqHLOG9SE+lnnqmHkZLTuYIDbExGu6HcqnGFm2J/Gxw2lwv8Yc3EYqOsTE+rZC9tvz
 9EZqDpOVAMerCivDS9qqzeLqjOAW9HjzGwkwjzxOTekkfEZIovzHzK6DaTtbxLTYg9wO
 Kfjw==
X-Gm-Message-State: AOJu0YzpgOC3gI89sZgA7ZCzF1zcXmqd/zc7tZchHLVG6OCymUB16O0P
 6dYkxXdn9rUa/l7YZXj7PGdpO7qrOT05PucrDVwsPXzRukFySX74vGWI/L+fbOvd4+f/o+WKPPz
 BAzw=
X-Google-Smtp-Source: AGHT+IFzBKL+sJk+rta4rYWsxrHihZeTbMH2jWE0zsMAlvnu/yGPC3GK4ZUAHZrPTE7yNGHa+xa/FA==
X-Received: by 2002:a19:f004:0:b0:515:d038:5548 with SMTP id
 2adb3069b0e04-5221016e9aamr9515473e87.31.1715766060738; 
 Wed, 15 May 2024 02:41:00 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 21/43] target/hppa: Use TCG_COND_TST* in do_log_cond
Date: Wed, 15 May 2024 11:40:21 +0200
Message-Id: <20240515094043.82850-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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

We can directly test bits of a 32-bit comparison without
zero or sign-extending an intermediate result.
We can directly test bit 0 for odd/even.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 78 ++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 813f1571e9..62cc3c3117 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -915,65 +915,41 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
                              TCGv_i64 res)
 {
     TCGCond tc;
-    bool ext_uns;
+    uint64_t imm;
 
-    switch (cf) {
-    case 0:  /* never */
-    case 9:  /* undef, C */
-    case 11: /* undef, C & !Z */
-    case 12: /* undef, V */
-        return cond_make_f();
-
-    case 1:  /* true */
-    case 8:  /* undef, !C */
-    case 10: /* undef, !C | Z */
-    case 13: /* undef, !V */
-        return cond_make_t();
-
-    case 2:  /* == */
-        tc = TCG_COND_EQ;
-        ext_uns = true;
+    switch (cf >> 1) {
+    case 0:  /* never / always */
+    case 4:  /* undef, C */
+    case 5:  /* undef, C & !Z */
+    case 6:  /* undef, V */
+        return cf & 1 ? cond_make_t() : cond_make_f();
+    case 1:  /* == / <> */
+        tc = d ? TCG_COND_EQ : TCG_COND_TSTEQ;
+        imm = d ? 0 : UINT32_MAX;
         break;
-    case 3:  /* <> */
-        tc = TCG_COND_NE;
-        ext_uns = true;
+    case 2:  /* < / >= */
+        tc = d ? TCG_COND_LT : TCG_COND_TSTNE;
+        imm = d ? 0 : 1ull << 31;
         break;
-    case 4:  /* < */
-        tc = TCG_COND_LT;
-        ext_uns = false;
+    case 3:  /* <= / > */
+        tc = cf & 1 ? TCG_COND_GT : TCG_COND_LE;
+        if (!d) {
+            TCGv_i64 tmp = tcg_temp_new_i64();
+            tcg_gen_ext32s_i64(tmp, res);
+            return cond_make_ti(tc, tmp, 0);
+        }
+        return cond_make_vi(tc, res, 0);
+    case 7: /* OD / EV */
+        tc = TCG_COND_TSTNE;
+        imm = 1;
         break;
-    case 5:  /* >= */
-        tc = TCG_COND_GE;
-        ext_uns = false;
-        break;
-    case 6:  /* <= */
-        tc = TCG_COND_LE;
-        ext_uns = false;
-        break;
-    case 7:  /* > */
-        tc = TCG_COND_GT;
-        ext_uns = false;
-        break;
-
-    case 14: /* OD */
-    case 15: /* EV */
-        return do_cond(ctx, cf, d, res, NULL, NULL);
-
     default:
         g_assert_not_reached();
     }
-
-    if (!d) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-
-        if (ext_uns) {
-            tcg_gen_ext32u_i64(tmp, res);
-        } else {
-            tcg_gen_ext32s_i64(tmp, res);
-        }
-        return cond_make_ti(tc, tmp, 0);
+    if (cf & 1) {
+        tc = tcg_invert_cond(tc);
     }
-    return cond_make_vi(tc, res, 0);
+    return cond_make_vi(tc, res, imm);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
-- 
2.34.1


