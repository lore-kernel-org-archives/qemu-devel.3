Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAECC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 03:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roadw-0001Oo-Bv; Sun, 24 Mar 2024 23:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roadt-0001Li-Ad
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roadr-0001t1-4F
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6b5432439so2911153b3a.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711335893; x=1711940693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRr5RGAyB8xudWpBYabctLeDWU/P34mdZOuJNR73ZqU=;
 b=N+98b+VORINW7YsicSyWdn4tiQB7n6oNJaMggSZXuk7F6/KwGIoSZg6+VYw3m8mXWz
 ppfeuu96UjpPXdPOQhVsLbBn7NzV4NDcBpCdMwvZhCEoJ3wJ6yks+dU6YydRPlfa5RjI
 vJaIdm3q8zGtrBO48hUX7h8+nFv2qIatclaCPOFJe/VEDKoclGb4CXf0AASAfyk2mqh/
 ahORwSsp2bESVn1jkg9KBEmettckbcTx3bP259hDKvylQ5eENGUKd9hME5o0xKr4zUZm
 Qvo59h0oWHW4HJD2t7auo/Xy7Bh5YWWMd8C7RDT9rir6CPsGlXi4rkn6zKm32yckvQqg
 pjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711335894; x=1711940694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRr5RGAyB8xudWpBYabctLeDWU/P34mdZOuJNR73ZqU=;
 b=J47Z0BMqEJd9XzqgF95UWDNRyXeJAskkbW+pjNkqq2uR8xT8Zj0zg12RzubQkyLgw+
 4yh6vVYsJsFQ0LkjZP3NeK0p4Zwd9dH/RQga3Ncenl0pmftmKDi/xnHTbnlShYP8awHg
 RjCnWLR792s+y8ttKQLO+SR74KatydhI6AVrXvf7v56cJf/mZ9RAylV92AVCYw0r2m/9
 LixdIANz3teng2D5J+8QjijIHXqSEXor8aQwh+mZ9nqjnSYNXnwKXVaUaqmR365/ecCU
 9QnDtn6Ye5dg8tvLaEH/sTsHnfeKKDap6gAtnaGh/QX6tA9YX9FFI5l6gczov0eAEGxP
 RCGQ==
X-Gm-Message-State: AOJu0Ywkdm9ljm49BfYK+bgOPtwRwqGUfFpqo2SCL5ZWhLuG3XFsVMUq
 2ByogYfPsRbq7QwSBO8C9m0TGjeuBf6pJqe0pJsBhUiiAZGemQly9MVoyGWdQlkwjtfzyv9pYB0
 D
X-Google-Smtp-Source: AGHT+IE/vrXJPa71F/bZfxXjAwF7pRPStvQxyYeemtMOq99oWsJuzYJ2St4bFUaNWy95eetUod5FTA==
X-Received: by 2002:a05:6a00:3a22:b0:6ea:7986:638a with SMTP id
 fj34-20020a056a003a2200b006ea7986638amr6056651pfb.28.1711335893648; 
 Sun, 24 Mar 2024 20:04:53 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q12-20020aa7982c000000b006e6b4c637b6sm3291880pfl.116.2024.03.24.20.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 20:04:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/3] target/hppa: Optimize UADDCM with no condition
Date: Sun, 24 Mar 2024 17:04:47 -1000
Message-Id: <20240325030448.52110-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325030448.52110-1-richard.henderson@linaro.org>
References: <20240325030448.52110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

With r1 as zero is by far the only usage of UADDCM, as the easiest
way to invert a register.  The compiler does occasionally use the
addition step as well, and we can simplify that to avoid a temp
and write directly into the destination.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a3f425d861..3fc3e7754c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2763,9 +2763,29 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
 {
     TCGv_i64 tcg_r1, tcg_r2, tmp;
 
-    if (a->cf) {
-        nullify_over(ctx);
+    if (a->cf == 0) {
+        tcg_r2 = load_gpr(ctx, a->r2);
+        tmp = dest_gpr(ctx, a->t);
+
+        if (a->r1 == 0) {
+            /* UADDCM r0,src,dst is the common idiom for dst = ~src. */
+            tcg_gen_not_i64(tmp, tcg_r2);
+        } else {
+            /*
+             * Recall that r1 - r2 == r1 + ~r2 + 1.
+             * Thus r1 + ~r2 == r1 - r2 - 1,
+             * which does not require an extra temporary.
+             */
+            tcg_r1 = load_gpr(ctx, a->r1);
+            tcg_gen_sub_i64(tmp, tcg_r1, tcg_r2);
+            tcg_gen_subi_i64(tmp, tmp, 1);
+        }
+        save_gpr(ctx, a->t, tmp);
+        cond_free(&ctx->null_cond);
+        return true;
     }
+
+    nullify_over(ctx);
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
     tmp = tcg_temp_new_i64();
-- 
2.34.1


