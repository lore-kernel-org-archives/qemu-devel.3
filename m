Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0EBCCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnho-0007Zp-8d; Fri, 31 Oct 2025 07:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhi-0007XO-Kb
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:54:03 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhX-0005xW-Aq
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:54:02 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso460105266b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911618; x=1762516418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JOuSiiYqzLFJt0ZlK3iLHRsXfFv3l4QDbV0ydr0oXM=;
 b=dGE+xw5yzsJthdZdC5/lnEWL38iNUbyMBr5Eo+PBSqMGMaiX9CQYrcB9OnRT/6jYLM
 lMn2gwzoZbqyBIVMpMZpUxAxK9rEkOwKt8uvvOK/dTxrCl55Qq3IJGhsuL4j3DFZUyf8
 6UgJZ0c/whk3wnt5g3ifdLyXoyhkr0yHjYuewK6lnYLEHkQ3GGIFuR1BeeinBLojqPXC
 Xxr266XT5RMtWZ7e1e/6Elsc/FPNJebMVoxpUUW2GFQ5F/Z2AYyjeoSQpWPz1GSToT4m
 qg3kHH379hiekMn2GwHxNU0CPc1E3wQ7ReMEq3fvqWeeLx2jkbQE2cjAfZj7+6i0tIwr
 VVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911618; x=1762516418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JOuSiiYqzLFJt0ZlK3iLHRsXfFv3l4QDbV0ydr0oXM=;
 b=mprVkT8rKK2Dtwan+ugsvRcV1wbVqMH3RerpvXNgGEOakHk3jk+wdJn69DJPQi8TFr
 kOMryqIbn3SyUHZ6iysp/YAscQQMYXbKYnS1WCfsHcpcNU3hyfpYbgP4HQQimI7SJcnX
 tY6nr2d0ML7ny7UCFLxLLSXy24GVP4zQcqfotRaPqvcnqWkSvMhPNvpo9A3rmmGcdeap
 op9QJJGTRFPyCZZRsB7G5T/nWccjR62ayZVj5D2oF/P5jvrKqnh1FW8omt5MD5H5zjlC
 eyjI521/hjBAaRxwSo9Tpcn9ysCS8xvZvUTzaCvlMCjMbyjJHrOnst2iy030PpD1X3ZL
 02JA==
X-Gm-Message-State: AOJu0YxeDIjDzbfjijWXmo2CpAetc+OBA/FJlrZoZ6KFhEITg7KvaeE3
 V0hofkvUyYUb0CcswtJ02LIitxeZjUZU5z2U2Ys+yQhvN/oqEh6PRzW5Wn9Dc3ijdtwHgNtKFwZ
 WPRVm/w8=
X-Gm-Gg: ASbGnctaxfqlihJ3anBomT2QuObDtkpNDU+aGctRJhyn9iuf6Y5yfm8OiByMwEjGyU0
 Tv76aQteFsuIKOYskBsyl5dH2EgJ6KoFyHY0Wm0HqyckuUFDQMIjK7nHbhPOYAKM4buRQ74q/iF
 t+L265DaEZAEVhyMpo9OqqE/iBXnsgEagmYZLnjS8gMYhXAaWMeE81ci0uJCYZGi+MaGnlu6Qta
 L+ozbfDygqZ2OXUzI73winSfIdPERCd6AVsAF+EtMNq1yfUwHpGSPJbGlfQetEInuuKImmJSkxT
 uog+HJnMxwGB1/p/Hnf6gsv+VCbmrBLIj61m7grdHM1IAK1k48F45RH5JQrlfktoS49KV8w3OG0
 HN63Me04GMejUx9yBgWkzXofmtDJfhIDO3cPPciHHHdVlSMY4vFKdrwkh0nLKkaE7M7HFEOPf01
 oOode1tdQOmxJjXwum/9sIu49Kagz7cAGEPVNGoPzh
X-Google-Smtp-Source: AGHT+IHv9U/EAacnEWzNalbXWTjmcKpCyK1/6+A1Q1BwuwEhK2I9voccvQpWhRZQEvAmZjIRqr0iKA==
X-Received: by 2002:a17:906:6a21:b0:b3c:bd91:28a4 with SMTP id
 a640c23a62f3a-b70701c77b9mr286131466b.28.1761911618016; 
 Fri, 31 Oct 2025 04:53:38 -0700 (PDT)
Received: from stoup.. (C3239BBB.static.ziggozakelijk.nl. [195.35.155.187])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077975dcbsm158078366b.14.2025.10.31.04.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:53:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 2/5] tcg: Simplify extract2 usage in tcg_gen_shifti_i64
Date: Fri, 31 Oct 2025 12:53:30 +0100
Message-ID: <20251031115334.368165-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031115334.368165-1-richard.henderson@linaro.org>
References: <20251031115334.368165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

The else after the TCG_TARGET_HAS_extract2 test is exactly
the same as what tcg_gen_extract2_i32 would emit itself.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dfa5c38728..ab7b409be6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1818,30 +1818,16 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-            tcg_gen_extract2_i32(TCGV_LOW(ret),
-                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
-        } else {
-            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
-                                TCGV_HIGH(arg1), 32 - c, c);
-        }
+        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
+                             TCGV_HIGH(arg1), c);
         if (arith) {
             tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         } else {
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-            tcg_gen_extract2_i32(TCGV_HIGH(ret),
-                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
-        } else {
-            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
-            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
-                                TCGV_HIGH(arg1), c, 32 - c);
-            tcg_temp_free_i32(t0);
-        }
+        tcg_gen_extract2_i32(TCGV_HIGH(ret), TCGV_LOW(arg1),
+                             TCGV_HIGH(arg1), 32 - c);
         tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
     }
 }
-- 
2.43.0


