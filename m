Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3090C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8U-0007bW-NQ; Wed, 15 May 2024 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B88-0005qD-ML
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B86-0001eW-GF
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3504f34a086so4158590f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766057; x=1716370857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfJJCi+4YxuFZhkV51ZJx0iiIuxKudoNy6Mn9JaLA38=;
 b=td2MOEQLmKJipAu4DJx0slGsS6HpEUXCfDJhvScBJe2HZFTcSiU0ApZejpnusJu/vI
 OR9zttRpo28JI2v1L5tztc/qCK06zGxoau+41cGAvFlLjaKMx0KpRRxis/544BiY+f9g
 XXswlfOx86d1g7Fug4PIqGIx9JSRZQ2/EsHht8lB2wnj9IjYSlMSP0iEGPpISCRLmhI2
 6++ozNMjABvmqbSh+dJ4CN5yyYyacfEfl4vky3XgFFCc1e5duYHxVTiexy908Prxr/wQ
 cvapKcxjWCgy0HlGeJTm4CIlNVwVjcAG4rWNjBiG96fPafAL9JlWgmS5G+vi4j/CAiOf
 30Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766057; x=1716370857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfJJCi+4YxuFZhkV51ZJx0iiIuxKudoNy6Mn9JaLA38=;
 b=HhY7qFKxUzquHwQJhO6Cb0U6lUvftDJqtnqsaOyMMfgUgrYD5l5Rbem/c3BXPDuOIG
 OYJwXA9f+yrNrzSDwsc0Zo47YG8yBbEEZ8Xg5WNNLXTy73aV0w6u7hKxjv9fkhYijEkn
 a//dXALO8lL6t4XjPL7+OPGo0lUpsw/LTTCCq6McydZEXlXR21sUgz8hUpCW7u+8N6Y0
 mrTZfnloRqd51VkKlQ4cd+ip5rSos/08mVjRFXH8S9qedbY9zarch5QIIa7wtewjEY3C
 YAdasDRe5bkHusIt/oggpl6+b+sFWHVgFFsmehQI10K1afNsGOWNmEnI2R4mkm9SxDgp
 qTYQ==
X-Gm-Message-State: AOJu0YyJmcIZVv/ZiXWZiWMa3xZzhNzoSW5rLjRW+YkCfN4xWNt6Cwp1
 niSHxBXgrm72yK7X3hbPql4ObclHheFrU/OT/aLHknN+6AEtmmvzUsiHFHRAUCWFdoi1amU0t0q
 cA4I=
X-Google-Smtp-Source: AGHT+IHfb5y1DZY80isIQ9DJ0Xzh2i6r+hkZa+FWiwjY19+uKMB2zQ1XuPeIvQJt7ujeNmBenQXbJg==
X-Received: by 2002:adf:f9ca:0:b0:347:2055:f49e with SMTP id
 ffacd0b85a97d-3504a73e7admr11495301f8f.33.1715766057003; 
 Wed, 15 May 2024 02:40:57 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/43] target/hppa: Always make a copy in do_ibranch_priv
Date: Wed, 15 May 2024 11:40:16 +0200
Message-Id: <20240515094043.82850-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

This simplifies callers, which might otherwise have
to make another copy.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e9ba792065..1ede4bd725 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1968,18 +1968,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
  */
 static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
 {
-    TCGv_i64 dest;
+    TCGv_i64 dest = tcg_temp_new_i64();
     switch (ctx->privilege) {
     case 0:
         /* Privilege 0 is maximum and is allowed to decrease.  */
-        return offset;
+        tcg_gen_mov_i64(dest, offset);
+        break;
     case 3:
         /* Privilege 3 is minimum and is never allowed to increase.  */
-        dest = tcg_temp_new_i64();
         tcg_gen_ori_i64(dest, offset, 3);
         break;
     default:
-        dest = tcg_temp_new_i64();
         tcg_gen_andi_i64(dest, offset, -4);
         tcg_gen_ori_i64(dest, dest, ctx->privilege);
         tcg_gen_umax_i64(dest, dest, offset);
-- 
2.34.1


