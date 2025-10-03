Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBF4CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLT-0007Fi-59; Fri, 03 Oct 2025 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKU-0005CA-8Y
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJu-0007hK-95
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso1859610b3a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511502; x=1760116302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UArNSBfDRY0R4yQf7I4KwaZGkKosB9HEkNsmXAhE3vY=;
 b=nvN54+IRbRSuI/Sl/wlHdJF7TAOqWakkQlHGhdS+ecCLlOazY9DOljovnWFuaeUwFy
 y8PvGtlrjFQEmnpZKJ9sEAVLM+8qYpZK+sxSWQW4mDHhcKQWd69hfnYowwTMTw40oXrj
 rEY0Jz9AW/KUsCSARz4ScWn9ZgZ7SBB/z9W9DhJii2ZFCuqa9JvfFLShbG+4zDOOTJXH
 0+ljoUSViGB3o3nwHFf6MJh6b31nNxqQ8nNTXmOthpTYyiCRKnkRr+Wg9FIsz++QTPQq
 i57c8tYGKo4tW691Yb6gQnlAbdmD2LN9/oqRz8BLKPJYVu7A0CdY5IZ6ahaLsirL1LkR
 qW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511502; x=1760116302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UArNSBfDRY0R4yQf7I4KwaZGkKosB9HEkNsmXAhE3vY=;
 b=qTOuy8SbSbrzjdW9ubKJAKkryph+7StPOGVe7h1d1WSu61cdHDKBMfcQc2eRc4wOAB
 bQwDvRK5KKsXIqzMO+jEqD/kyFvTSqAzVoYpgjrvyPG8XgflrwxraHnbZlsCxg9NTPsW
 ueO+ZcQ/K898gYHYNhA0lBwkMSAD3Ram9bBCTd3kauEAPEcZkk30DC2bJxYyOzIRGhoX
 qLD+SSAvWSfLeJ2HYLOFl9/GuHBbW2ftPZyWdmqc0XPWSaYZmYjoQIqh+92lb/lx1w9z
 z0bd/K0SaXKA5JcjON0YH9gVJosDopp6ZCAMOriRQvSqtUir0CyQHGbXTzsZZHk09sOZ
 tThg==
X-Gm-Message-State: AOJu0YxNhgOPGy0+NwJhZR4m07uqUnZisQKYGQzgnTfoyUo+2sB4nrap
 HgIYh2+hIZAimP0IxbgM4kGwq4AiGRY1TJ6vvdOVziyxW5YZ2UTV/16Eu8+wahuqlIxqp2mzh4u
 rVfWyA4Q=
X-Gm-Gg: ASbGncsxjycpUbOSXQbE9KNPy6x5gt0Rl4iAiKFW5Cbx9syogK4yiraDZRyi+L3NY67
 F4G0rbsktkthljLjYhOW8r3P1wRN+coHtIMdxkPDoggkw4kxbmsOgYM21la+CzsVO94ALbZWKk5
 BcLTT/vBZBnRkyWdJjhIuYNEr7f9EXrqE3pQg2H00Exfj4pR4Ja51Hjw5yMsp3p9JKe5537n1b+
 d9KA7liW21SnNs7ryBHMR775URA/3BLL23l/iNmOrsGHLKXH+yQ+oA0CdAAQ5zWPOb/xnMk1gdp
 dEHLsX3vTfbQ1cTBJYuSSR4M1NtMw84e1sumEWa8YaclwbcgzfJtSe1uWQM9QUH6vB8KI6Jkg0s
 larxmOXkzVqJIMBH2XcvE6yiUU/HoMtwxiDyD0UjIw8uuMkcSW43mcN1FBrEGGhIrtzc=
X-Google-Smtp-Source: AGHT+IFmUdzVlJvyzLPmXSzo2O0GXxtaEBghmUqeIYfw3vpGhpYkJRerYy++NRHyEpXYY0nO3BQxjQ==
X-Received: by 2002:a05:6a00:2e85:b0:772:4319:e7ed with SMTP id
 d2e1a72fcca58-78c98e072camr4814502b3a.29.1759511502171; 
 Fri, 03 Oct 2025 10:11:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 45/73] target/arm: Emit v7m LTPSIZE exception out of line
Date: Fri,  3 Oct 2025 10:07:32 -0700
Message-ID: <20251003170800.997167-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 57bc8ea4c5..3df0bbcb7f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5598,11 +5598,10 @@ static bool trans_LE(DisasContext *s, arg_LE *a)
 
     if (!a->tp && dc_isar_feature(aa32_mve, s) && fpu_active) {
         /* Need to do a runtime check for LTPSIZE != 4 */
-        DisasLabel skipexc = gen_disas_label(s);
+        TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
         tmp = load_cpu_field(v7m.ltpsize);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 4, skipexc.label);
-        gen_exception_insn(s, 0, EXCP_INVSTATE, syn_uncategorized());
-        set_disas_label(s, skipexc);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 4, fail);
     }
 
     if (a->f) {
-- 
2.43.0


