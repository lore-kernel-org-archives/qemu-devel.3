Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D77CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mxg-0004FO-Pw; Thu, 16 Oct 2025 08:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwr-0003HF-Pr
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwh-0008Uc-22
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso398643f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617138; x=1761221938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QCq6tp/1/pEpjwUbXRWq42VSh1hfKDqI/BGHhJ2wjl8=;
 b=Y/n150/SwHpeeC3zYBnp834F4GtHd630ujGKuilFJwrUWL8ucJu9cdiuL/3ArvyRMr
 Xbp9Oaup4tRrE2c/SsETpzOM3fHBwaNCLZfVlbiSuoYSJgu1AC9Pu4gmcLW3nrVdu0Kw
 b5HwtEGqJqJaxEVqa22lxxGg3BWQVrowxc3W6jDUys/wJd/MGcGA9TSfx6yTjwNb6Huc
 6YXPj9zmdkn/SGqWJA3ij8JczBlAmv/2lBtVGakNtSQ2ns1vbPS1+OUb/mg9DxlHOLt5
 5/ngMU4Rp3e25mbeQy9t4WZv8aIQxt31a370i60R9NuFK1RyTakoKd0v36VUk4Ec76IM
 xoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617138; x=1761221938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCq6tp/1/pEpjwUbXRWq42VSh1hfKDqI/BGHhJ2wjl8=;
 b=dKKr2xqdqX1ovD7Chp18RJBfWwJM4jMANc95RnuH07+0CA6I4duLwwlDCkJjiIACW4
 LeA/9rX+YPHGQOOusfajwxLv+7rJSmoK/eDbCE2XKVDWboms5taIXPvuVD4KZmr20P7q
 rRZ2+BllhbKsgYL/SYphGFkGPXWPWxMyWSrHlRZUsjAnojBwPDIIX3bQ3r9UxAQadhWh
 HWdfXUtm51WlmcNNeBrAZJyOIqMty1LE/pSm7BwJOfJTT7snLjvindiddyaK1+oni6Ga
 iN1ni7bVGZ0HqhqPmmZzlzYsKx+qaxqExkZDTEDh6k51xa0tiF7gdtg5PdYACAgSY4ag
 u4Nw==
X-Gm-Message-State: AOJu0YwL3F/voEjPBTkKOhfo7EQHMxKxTQYLU6bO44hHHIy3PNydaIUZ
 9zk3N8OSbG2jVIH+yy/a5La8/Xfb+Op9iHJA0usJIzYhYEXUWUwyGWoIbOG2BhxnL11kiutSyq5
 ImHkKxBI=
X-Gm-Gg: ASbGnctuIwsbWI+JdoVtY2J11AOnCqqaHTGKnUzQtQwYf8E/X8S9WJTi618xiTMQ1Zp
 vTJCSSW8PnPQ1li55LxZrQ1E0sGhq8xv0Exs3z4aS+k8IHXwCgLS6NJmJJtPrak3pKJvzu3XwWO
 g0q+C9ceDUAfIJdA9RrYYbuey7T1gmc08lIGQmLHLcWthVsldWFZxO4eVFoHW+Y1boswcnq42Eo
 5Bxy1HzUiXnrSZg1vFJP0Tu3utX5UijN8BcTRmu+9otxbqoUr3h0G96OGEKtroOZXrD+4G5QxE2
 LpWC91PWHAi6RXqvEAXObUzplIwpZSxXl3dvklQNTq4lpJeIrVuqF7ZdkMk3qdTaYicCxSq/TTJ
 KDgcO61oqrLvDJFbmfux0pcGmrzkR7pMM7NNL1MWY0caODzp04H/Xdm/je8mChTDexdXCO0YlXi
 FRUKTuO2tBM+bQtgYk5PFtPdV+WPd1/7NF70b5VMVKnWY462ij+JZPwA==
X-Google-Smtp-Source: AGHT+IETDYGZzoIKFHf3Tw1XUoU2op7CLGy6FsWyUPlbT0KUDBVtpGOKjzVkUuR1ljqeeFdgr+/zwA==
X-Received: by 2002:a05:6000:25eb:b0:426:dbee:3d06 with SMTP id
 ffacd0b85a97d-426dbee3d1bmr12629201f8f.22.1760617138354; 
 Thu, 16 Oct 2025 05:18:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm34158771f8f.42.2025.10.16.05.18.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/75] target/rx: Propagate DisasContext to generated helpers
Date: Thu, 16 Oct 2025 14:15:00 +0200
Message-ID: <20251016121532.14042-45-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009151607.26278-4-philmd@linaro.org>
---
 target/rx/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 744edd56afc..b314d94b018 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1894,7 +1894,7 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
     return true;
 }
 
-static void rx_bsetm(TCGv mem, TCGv mask)
+static void rx_bsetm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1903,7 +1903,7 @@ static void rx_bsetm(TCGv mem, TCGv mask)
     rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_bclrm(TCGv mem, TCGv mask)
+static void rx_bclrm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1912,7 +1912,7 @@ static void rx_bclrm(TCGv mem, TCGv mask)
     rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_btstm(TCGv mem, TCGv mask)
+static void rx_btstm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1922,7 +1922,7 @@ static void rx_btstm(TCGv mem, TCGv mask)
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static void rx_bnotm(TCGv mem, TCGv mask)
+static void rx_bnotm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1931,17 +1931,17 @@ static void rx_bnotm(TCGv mem, TCGv mask)
     rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_bsetr(TCGv reg, TCGv mask)
+static void rx_bsetr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     tcg_gen_or_i32(reg, reg, mask);
 }
 
-static void rx_bclrr(TCGv reg, TCGv mask)
+static void rx_bclrr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     tcg_gen_andc_i32(reg, reg, mask);
 }
 
-static inline void rx_btstr(TCGv reg, TCGv mask)
+static inline void rx_btstr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     TCGv t0;
     t0 = tcg_temp_new();
@@ -1950,7 +1950,7 @@ static inline void rx_btstr(TCGv reg, TCGv mask)
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static inline void rx_bnotr(TCGv reg, TCGv mask)
+static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     tcg_gen_xor_i32(reg, reg, mask);
 }
@@ -1963,7 +1963,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
         mem = tcg_temp_new();                                           \
         mask = tcg_constant_i32(1 << a->imm);                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
-        cat3(rx_, op, m)(addr, mask);                                   \
+        cat3(rx_, op, m)(ctx, addr, mask);                              \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
@@ -1971,7 +1971,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
     {                                                                   \
         TCGv mask;                                                      \
         mask = tcg_constant_i32(1 << a->imm);                           \
-        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
+        cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _rr)(DisasContext *ctx,              \
@@ -1982,7 +1982,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
         b = tcg_temp_new();                                             \
         tcg_gen_andi_i32(b, cpu_regs[a->rs], 31);                       \
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
-        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
+        cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _rm)(DisasContext *ctx,              \
@@ -1995,7 +1995,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
         mem = tcg_temp_new();                                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
-        cat3(rx_, op, m)(addr, mask);                                   \
+        cat3(rx_, op, m)(ctx, addr, mask);                              \
         return true;                                                    \
     }
 
-- 
2.51.0


