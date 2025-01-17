Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFE7C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1p-0003v5-VM; Fri, 17 Jan 2025 13:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1n-0003u9-5n
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:07 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1l-0007pK-1j
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21675fd60feso55032975ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138303; x=1737743103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKZ4GjtoygI38RsFhp13dWyLZZ39a3F3n4T5V19Yyos=;
 b=mFBE0gwYJ1gOrMfy+bt5OkhXgHST7Ou9OHgFTWIhCVNivUIohCyCA4iaDIAevOiRci
 qEA7q9kwmnVJsM0di5eYdoDJj5i8ty760FpJAWkBiuu4o1xz0QasJc6q3o/CPwXxL07K
 34yrBeIp8CsZhbTnN1I4kll+QEDibmSIX0RXRZDuFy0wuoXa6fEAI7W0xsZRxsOj6XfS
 wuYnhkpWc+Im4i5lVKegrEXOYslKB52qckVZtbUf5Z8+0QrOXBKk/H6Wa8Hh90ZCCtoY
 ostXcw8gH7ZZdI2iNvtydU7d1SsXWnlwKc9ouiJU6OCbpRSp6U40jlD1Fh3q9eW5Acny
 XATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138303; x=1737743103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKZ4GjtoygI38RsFhp13dWyLZZ39a3F3n4T5V19Yyos=;
 b=ftp9nHBVKuHPGRG1miwC503j5wnIbDIVXsKcO7SwTdVKQHyi7wrON9iORR+zBfKEYj
 cc2T+HQl7hdSAzsT2pqB1oW83HwoFM2K2RlwXVruruhRl6QispccBEmHFxlzWrbXtc7a
 Y6RZQfd3Ux633qvCrfa1hPOd7Tg0NGVlxw+MFWr4Ren0Q6d/n1mWkJpAg0BCFhAR7N/N
 zhoxqXYjZQb6S3BszZPMoDzAwf8U/xAXeaBHtT32Zst6//cO4N/6bF0EkcARu2Dzo5fk
 S7C17Zmk8AGisED8YwOikOLAU1o5odcsgFVhaNk/J8kSu9hzmMggwRDtpvdGalKqA66N
 CFfQ==
X-Gm-Message-State: AOJu0YxuBClhdmDshU07VR4NkwtxY2uRWZuU20PuHMweT72aPgj+Tl+B
 4TkX+8vUP8kgZEVC+RaoqoGeZu0wlyECgp536MLICwNV56idDPLBCYIFoblnuT+l/MpAvf4TbWl
 a
X-Gm-Gg: ASbGncvHWcMkOCojD8e97NR+DaDqBbcHqF/gZTaSggQIyHD2dfYV9rSUDjBVaBMFjYd
 ZufeQ4HSm83sUappac7EtyYYwAW9GNKt5YOAyaNhVCVWBZcTJnBLfpoIcFCVvBJ+g7tYEDIPMKy
 /MuywBkW3gqa2ZSORwjwS3btt3kG6M+KqRD0gqI1ZVWY3YxQJpnITUefDZRRFkVkZHfLC3ypXFS
 E+VpjMKGi9HjwoBJhLYZ/zZh8Nk6iIlG7IL2+Ht87NLGhAAy8nJRcaYfUB/hdZFlIA5IRhUTg+H
 e6jkIHR8B4t3A/Q=
X-Google-Smtp-Source: AGHT+IGhCzFTWOShjDnAq+SYcN4p+5rmEhQkzpk9b/VP3syDEsH2HI+1nqScyK5Y3S+5bWGTEB1U6A==
X-Received: by 2002:a17:903:2306:b0:216:4676:dfaf with SMTP id
 d9443c01a7336-21c355eeb01mr50560705ad.34.1737138303633; 
 Fri, 17 Jan 2025 10:25:03 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/68] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
Date: Fri, 17 Jan 2025 10:23:56 -0800
Message-ID: <20250117182456.2077110-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Rely on tcg-op-vec.c to expand the opcode if missing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 49d32fabc9..732453db6f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -596,14 +596,8 @@ static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
                           TCGv_vec m, TCGv_vec k)
 {
-    if (TCG_TARGET_HAS_bitsel_vec) {
-        tcg_gen_not_vec(vece, n, n);
-        tcg_gen_bitsel_vec(vece, d, k, n, m);
-    } else {
-        tcg_gen_andc_vec(vece, n, k, n);
-        tcg_gen_andc_vec(vece, m, m, k);
-        tcg_gen_or_vec(vece, d, n, m);
-    }
+    tcg_gen_not_vec(vece, n, n);
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
 }
 
 static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
@@ -640,14 +634,8 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 static void gen_bsl2n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
                           TCGv_vec m, TCGv_vec k)
 {
-    if (TCG_TARGET_HAS_bitsel_vec) {
-        tcg_gen_not_vec(vece, m, m);
-        tcg_gen_bitsel_vec(vece, d, k, n, m);
-    } else {
-        tcg_gen_and_vec(vece, n, n, k);
-        tcg_gen_or_vec(vece, m, m, k);
-        tcg_gen_orc_vec(vece, d, n, m);
-    }
+    tcg_gen_not_vec(vece, m, m);
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
 }
 
 static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
-- 
2.43.0


