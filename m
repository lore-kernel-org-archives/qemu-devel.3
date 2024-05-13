Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A02C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QQZ-00044x-UZ; Mon, 13 May 2024 03:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPM-0002s8-7p
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:41 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPK-0001OI-70
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:39 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e564cad1f1so27617141fa.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586456; x=1716191256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGbM1QCCaY0habo7FurSh8Ry2LOjgiLMoIY76d5RmZs=;
 b=GwM6d7VGKld7qgtHSzt9mLE+XqqXtmwM03laBUqFTelr3fx76C4QjmZn0dYD5e41tt
 h3Lfcxi3S66NKH7Ng+446ccd94g7TqJXFXuAIfv6iINiwWrTm8jYj5HdC96ffooE3ACW
 OJ/6VfzfHKsDPwrkTV6rt9QdcccbxsTaEvKRwwKVEFxxvzLCRHYTlNubpCk2Tf3WHMk9
 EBJcGSbc/ouGaWHqvXx6U0Uy7UiPjZSc4vTVsNJp9ZZdVFBt9c7TijtrwVOPviQZX7wj
 EbE+clMHH6b/ok99QRPDzEZNx95/zljn5KoqPRBqTOJ/nEXQ7rGtuI/1CJYJXnz/Jxjy
 1a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586456; x=1716191256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGbM1QCCaY0habo7FurSh8Ry2LOjgiLMoIY76d5RmZs=;
 b=CzS2FIw5OfXv/eU/5DFBuqLBy0k6exZVPEN0jGe6mX782iAMl0PxSDZlcgtvcADKCr
 ijnK81MTHWy74kB2Ow0KQVK0PHPqXy8W8fxrP7COGkhImd/lw2nqo29Apizathxtjt+B
 xHHEKL59vhtJ6nKGpRpvJeKKhglBuI4q3SwWWiU7+64F6ZWbcqxqFXytX7gbadJDV5e7
 4kDADm9b4Y19QAhy4+6fJL7s0hbedTsD81uAY5vsQTt0txRw8yraiGVGP25R45nmTch6
 ISdJv8pk/abDxvvxhKSCGwP0GqTb5CMF2gJXMzSrGMpeBEaOwshG4q7BhQs4IPhVrtyY
 zWzQ==
X-Gm-Message-State: AOJu0Ywl+foV+bcz+cBqUPScD9a0NQ9WFPc7UJ4kjsIBQvsqgD2yEa8a
 T07vNP7+FRcsynlsYnZ2uF0RhLHuvkRj1dIRrTPJfyoa5izlGanW+SGdfzidCthUIaFdJ5eN2Z5
 2o5o=
X-Google-Smtp-Source: AGHT+IEawTTXsIyuqmsOku9Y5c3IBsS0twtuhnLrHfPN8lJ1/VilS9m1BsZXXU6Wmdo7J278KWLZVw==
X-Received: by 2002:a05:6512:1086:b0:51c:d528:c333 with SMTP id
 2adb3069b0e04-5220fc7d748mr6546336e87.20.1715586456335; 
 Mon, 13 May 2024 00:47:36 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 24/45] target/hppa: Use TCG_COND_TST* in trans_bb_imm
Date: Mon, 13 May 2024 09:46:56 +0200
Message-Id: <20240513074717.130949-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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
 target/hppa/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 47f4b23d1b..d8973a63df 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3515,18 +3515,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
 static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
-    TCGv_i64 tmp, tcg_r;
     DisasCond cond;
-    int p;
+    int p = a->p | (a->d ? 0 : 32);
 
     nullify_over(ctx);
-
-    tmp = tcg_temp_new_i64();
-    tcg_r = load_gpr(ctx, a->r);
-    p = a->p | (a->d ? 0 : 32);
-    tcg_gen_shli_i64(tmp, tcg_r, p);
-
-    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
+    cond = cond_make_vi(a->c ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                        load_gpr(ctx, a->r), 1ull << (63 - p));
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-- 
2.34.1


