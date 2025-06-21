Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B4CC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82L-00025V-GK; Sat, 21 Jun 2025 19:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00022x-9e
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82C-0004va-5y
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so1747610b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550046; x=1751154846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MtIfDc/xWGnSFLtDOmfqXR6Bsd+isPEq7Dx6IryJmSQ=;
 b=MDevWNF6zQmF/SGf8SJAbYGAJcLrOs1OKU+DzuaXCnvtsNq3siZxg9TWJ75C6X1L0+
 C4rNJoBBRE5OqBv7DWIasbG+5LSwO8ziYHJRyTmEv6sFQYKZxpoI+OVKa8FAU6GlX9jo
 sKF2BNqc1DdyrJJTxLD7m8xnO3jIBW6Fl3YVdzYMYJ7P/RMAIDNG7d4Bik6eZbNmLm7Z
 uAP2qSuYiEB2vTqvHG7DtH1XEBtmogdWvGPzZRnfmyUxwM4zQHg1nzCyAwqmyVqcW7VF
 /goF4Izu0mTujF3GWF7bmjKmlTPkJDMBjJzJogElXPys+YCzUY1g22lvxabABQHgSOJw
 3OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550046; x=1751154846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtIfDc/xWGnSFLtDOmfqXR6Bsd+isPEq7Dx6IryJmSQ=;
 b=Xm4l1iC12ipysnHI2uOc32ON0fXexivZYUVx4m9Opv8Uxh0+0KB2z5OdRzLpu/BRjs
 jo5UnGKHrQ9eaiYGefx0coIqMB7Kjg27GrxI6YYRMliI2aTPHzInKPaIdFo3TgcxRrHv
 0JX0hynBkIyGBAgcGdXw9htSd0KhRAgpkfJ4A8SpRoscuaCjYoQCcJ3xEbgeeNiTkq6W
 pMDTZLPxVACCt06dLzW09uIkGMkwlGJQRcXnnbAi54TQ+wkH+ccr9HZGQtLeg/UdUOyR
 Fi47slwGEm7sna+zKT2zSQIAS/nd37ucRNqGqOWyJqMMZT/HI+XJ7mLTTM9luqhmTj6h
 8DWQ==
X-Gm-Message-State: AOJu0YyAVGNJ0/p2vYDhEri3ODhHWN9xAUpPJ1JxuuXnr4i6wvGB9Ayo
 qnJ3dDLkj8diBXY8Av2gIo1DEjWiIymFv/Z0Vl9lSEOT4PReML8zuvjad3MeWjp98BfSq4NRi1q
 ZiPs2BmA=
X-Gm-Gg: ASbGncuL+EtB/qoTGQ9U5o2KFkcLK1ryU7ZyDr/z2HITYfDMt4xX0W1v0f3Tt62fKgc
 Xwj2GaEaWYIECLlIBa6vtHNWlyLh9485B+akTZ5dZ4OdknR9F6bKV3HdRJzwNBbVFwt8K5HN9uG
 t+hfv4YbC5Lt3ogyrhYNa2Qbbxe3nJTkaC3kucqSjMU34hbj/Wl7KVP2U7+KEMOwie5T01GSyF5
 hVS3EiWmuEaIi1L254vEGoVy586KJXKS4XX0+bdP8J1GBaX/QKmXn4IjYOZc0baLc4HaDO35Ty6
 BIbbU7WWEJEn4z7BYXRcODaXMz1xY5ZQnBHjNwXO+Cc1lYMucOTMgX8QxiZbH3WFAYBNtGliN16
 ITbnWu+ttWFrq4NzazfbcnWtAe7Qq/x0=
X-Google-Smtp-Source: AGHT+IEN0eeVhl7nkS2Xvdoel/loLAxlFQuzpR7bm22Lmko8KvpS/gndbP4B9azPKlcaI5zfoeZSdA==
X-Received: by 2002:a05:6300:6e17:b0:220:4750:133a with SMTP id
 adf61e73a8af0-22047501489mr1527629637.25.1750550046402; 
 Sat, 21 Jun 2025 16:54:06 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 042/101] target/arm: Tighten USDOT (vectors) decode
Date: Sat, 21 Jun 2025 16:49:38 -0700
Message-ID: <20250621235037.74091-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
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

Rename to USDOT_zzzz_4s and force size=2 during decode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 target/arm/tcg/sve.decode      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 20b73cd572..29b6f09260 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7105,8 +7105,8 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
 TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
-TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
-           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
+TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_usdot_4b, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index bd06a1bdf0..7ed186c9bd 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1599,7 +1599,7 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
 ## SVE mixed sign dot product
 
-USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
+USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_e0
 
 ### SVE2 floating point matrix multiply accumulate
 BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
-- 
2.43.0


