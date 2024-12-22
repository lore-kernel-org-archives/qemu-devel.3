Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A820E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOpF-0005H0-S3; Sun, 22 Dec 2024 11:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoY-0004tg-6v
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:23 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoW-0003jh-M9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:21 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725dc290c00so3427392b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884899; x=1735489699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zVWcITCeVJyEn34BQ871RDWCXs0aBbyojaqRkW2N2M=;
 b=y5POr8X1p3NIkJNRgI7xISqANSS51bGyhBk72u7fmDzNwpRjJMd7bIxSmZyYFHzF9Z
 9QgctC54l6aDlmrRvDA795ES4/DDx0q57j9PnQzSX7Pj+aA5OaC8B3vcQUGWZsXYiRYO
 SSAbRKRdgN97Mmcn4AEpzKe/JelbunFSYT+cC5pSVUIIoC4uYHVeNd3x+HSi3FHYSy3Y
 HqgVhnjAvcZjmUg/synDow0rHt8qrFVd7Qwgahosw4eM15xWs4d3TzZ+pi8YUzuMAaYf
 UEAc7+CNDPht4u6QHhAceVQlHCV9eCuUnaaAlVsEK86qcBfEoLV/SWDdDENsFQB6TsSm
 cq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884899; x=1735489699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zVWcITCeVJyEn34BQ871RDWCXs0aBbyojaqRkW2N2M=;
 b=P42st92SGobY6hOJtIJPdcPbnhaFGcRFTBQZIb+0aQqweIvRh6YDsx5gtxtMVTHH2H
 0CP0rpob2vCTCIAC6w1EFwSY5asCme4+4w0b2padIuyQ0fTsoFKyg+YnfnMjyKOt7T0X
 tejvt8Czv6mJdwjPL63ulc4kNvjov23JqKN9uJ8V0hgUsfdCraMYs0Px1Uliq7S+OhmH
 IQ5IXIEh+Mw5aBSfQGE3I5ko6zDtLa8X/a1h/cwwTuUNnXS/cIan+NEzvafRl9I02PLm
 pG6ZbWVzOlPhGVs+g+7xze4LMmv1VSr2/Dv6TSzWa3ZvXDuZHP2b79mrpzyj6m8T70aC
 9f7A==
X-Gm-Message-State: AOJu0Yx9AMlrY59QqTorTssFVvD0XN8DI+9Dj1vZKKj8VsfDNFuBZ5qk
 z9CGkS4tbNoafJISPVc2EiyZy6fnK8w2HpWCvWJJK3kNXGGCNk4jJmo85qApXjuFn+MckYN6Woo
 xZIs=
X-Gm-Gg: ASbGncsyZhrGAV5M7bWPk62Scbjp0JGutnx+6jkCKJdQbctx020b9xEMW8WBX1SWTkw
 ZwkQ+lTLuSVM5RvUSo68E6rvryAkHqjR46T6oIVnTvYXjrZ7PcxG+9Hy2/xuf4VP1GlZjb/4njF
 zVqXlJsIFUEmHbbkc2INbm7679JmS385ZIg3mwK5mE+dlwe0SYZwfoZHU2F5BBu9bhLeH5e9Gpw
 gITyq42yuGjvEZmJD9Ter/GbbURJ0cOqXXsSo1X7ghexM7ruECfA4arXCVkoF8=
X-Google-Smtp-Source: AGHT+IGfX6H9NhqGRq3Z26rznESHhyQP6YFOmP4g7CXhD6tKf+/PDZxNRVlO3a3SouJ8yTScbljN0Q==
X-Received: by 2002:a05:6a20:7290:b0:1e1:b062:f408 with SMTP id
 adf61e73a8af0-1e5c6fd3cd5mr17190220637.17.1734884899122; 
 Sun, 22 Dec 2024 08:28:19 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 46/51] tcg/optimize: Use finish_folding in fold_bitsel_vec
Date: Sun, 22 Dec 2024 08:24:41 -0800
Message-ID: <20241222162446.2415717-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0cdbd1e262..3bb208d6e9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2816,7 +2816,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_orc(ctx, op);
         }
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0


