Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860FBC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEw-00026f-S6; Sun, 04 Feb 2024 16:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEr-00023r-3B
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEp-0003WE-IA
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:20 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so32846495ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082877; x=1707687677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flGmqvYthRKnWcX4jGxDQrsUCR7InVU8Hdnql3IBa7U=;
 b=f+Re3r5KhUFK/XfQHWLhvLWnl/cMGJqmLTnIsmlA+rZV9khswLsZohCLKoFxUH3vPP
 Xc40sQmwxcEO6ckkygohwBW1TSp1SeSJxqC7B077SL8nsKrROl1yP1PAnEjhqA8eRkKN
 pdOxYEkYWHASta6RNHpCfp+NZ/33pRBIak/cPPSohvz+dtgDUhdDZF+fEd1uUOUO4iet
 q5u3+2sA6FO9nCt+z53IP4QWIBm5Kn8KZe5v/GfCRmPewbNFQoByo4vCQ7lJRwV/JBrQ
 +4W7Byo9JAzbFDKWVAlLgWDKsf8Iv8Kpj04SXBDTqXxn9tlEfWt3JBYN4rPV5kOX4XGs
 rM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082877; x=1707687677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flGmqvYthRKnWcX4jGxDQrsUCR7InVU8Hdnql3IBa7U=;
 b=QRlMgGo1a1TEGr69pu2dnQWuPBGa8Rbkb0zcEfBq3wMkoveKWND+S0e9D0iwWmFS8D
 1jryfaozehOCoTr/5/CG2dGlNh3SaSKdMaJUHhGJgUkoGPEjwwdxqenJ7b7faGonEC8E
 tVZCHelFZFfCUwyYcO0336Ipv+9tuKSPSJHuYkUjCMm0iBUofMnNZqzanoKvMr5uDaL6
 F1H7kSmX3i+zGNvYfRvPLdVwntun3x8JDfokC9tie0H+1lzh2hUMzrmYzOFq69BH1nxg
 q/8l5hcWRms5VpLRm54aDjbRDt9ZV4J6XL1OMdspCySqBVVuvZJUN56uQyC8a1cjC0ds
 +/7A==
X-Gm-Message-State: AOJu0YzxiqBenCYvp2XkUhN5Ml3W1R4RgHRSimZWVQGyCbFKP5KqmAIO
 Eqe+9HacnJU1XkgaxGHfRF+IAvHD7igFa0Dp3gb5ob5v2DL7bdGGStu2YX4laCjRjFUFvniQAuL
 oO2w=
X-Google-Smtp-Source: AGHT+IG5HxryNPSWyVsLucNjuaR9qrHiivJzo4AozZs9re51VHbB+6IdpaC08lTc2YzlX2AxSjKtqQ==
X-Received: by 2002:a17:902:eb82:b0:1d9:8082:4573 with SMTP id
 q2-20020a170902eb8200b001d980824573mr9357779plg.2.1707082877528; 
 Sun, 04 Feb 2024 13:41:17 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/39] target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
Date: Mon,  5 Feb 2024 07:40:23 +1000
Message-Id: <20240204214052.5639-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 566adc4cd6..220eda2137 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1676,16 +1676,12 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x14:
             /* CMOVLBS */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_NE, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTNE, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x16:
             /* CMOVLBC */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_EQ, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTEQ, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x20:
-- 
2.34.1


