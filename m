Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33D0E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26U-0004SD-LG; Tue, 10 Dec 2024 10:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26H-0004J0-4x
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:40 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26F-0008MS-Ri
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:36 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb687d96e9so650058b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844274; x=1734449074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ddv1A+UA3jhxGq4Ts2W1/w/Q/jka2wneect7JrRWJKw=;
 b=FlFbqG71IoS05/IPV52kUMRiipDDjXPRT7YlZGcfIg3DBqh+XDLVoF7X7Z6OSH2cM+
 gRgYUHoFyLomxRyAweByPzxZOHeAFJQ0ov8zBNun3OnyudoEP3nZF5iFPlK1HZW9qlWa
 OLwIJgwl1Y9dQUFkvPoA0cCryq1gPPnT+iAWH1/m2v0enlx4r9RWP/JhL+ptMC6FqF5d
 hVNcvvFGr6dtGvInv/5iVndepIyf70Fk5zoBpeawyUq8dnNQJKzcA5wF+UGdQhJLkjdV
 wz8fL/dSD+DbmWrJPxxMOkFU5dGzIk2q+a9w6BNPVMP0TBmApYHnsek/A+ASD2ECoZr1
 Nwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844274; x=1734449074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddv1A+UA3jhxGq4Ts2W1/w/Q/jka2wneect7JrRWJKw=;
 b=rJ08b3Qp1pHOHXJn1k0G4LA19WRgC8x0kHuLMdCTwUmDSJbhh6BanYCDeDJPe9Ohqo
 hnGUpLEvhaoQgK5Wc3gnCBnOIN2FNce52ygn+FMl8ToNblY/hL27golc8zqDT3NCWScK
 3SNBdazcsOnJvh4XAmhEOp5Scak4+kERyfyOo4vLNQ02pge9RRYFqgO+bo4MkohbmcZB
 mQ7A4WNsLOjdoaMDvMCyX2m0wGE6CKMRAyNg0R/MssSR4SrOjzy61br515p3G6xd1zUl
 vtUyPUGdSLE2trdJ+ET0mm6LmUDa5LLP7rRQ+7T8H5LhwZYuT8ydRI3fDccAPU7duB5f
 ntCA==
X-Gm-Message-State: AOJu0YzyIQP3wkWRHLsWV6U3+ROR7i+XAoi6+wwybyObOsNI6SdGq3j4
 oVF0BsUIUve1cj4igP6AGNeNvbK5Cs/v/BUIkHXpbVyy8PnhmrUsl/BXbxYQX/Mw1FWIzxsxT1z
 BAM45nUAc
X-Gm-Gg: ASbGncuPZfLmtIeZe2AKhEuB5zwoNKdzwBC1ebK4u2H/eUQFcJPOE6JME477unOoDYx
 OhU9NpZ45nF4lB6gKmoelBDOlhHIL4oAObmaCe///90pimesdCsvCqS0OD/LYI35JAcroRXIWca
 h1UW/WXeKa1tJt1hsNa2TZkpb9Nr6Qqazrn90Jm+biXzHqAreIUbDsUgLl0j8atxrMiL6oo0aEx
 2tbp+OUhqezF0bE3UKwExEBWp3StUWAddtjV71dYU3UVdhpgUvhsF63DnvZng==
X-Google-Smtp-Source: AGHT+IH4BknxdLgb0L3k0s0OEDTzNWRhgg/0iA1PvhrMJHjjL326ZISCXIQEJ5eiafw9wMsvT5fMpQ==
X-Received: by 2002:a05:6808:2388:b0:3eb:394b:83f5 with SMTP id
 5614622812f47-3eb66e0801dmr2837757b6e.16.1733844274153; 
 Tue, 10 Dec 2024 07:24:34 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/46] tcg/optimize: Use finish_folding in fold_mul*
Date: Tue, 10 Dec 2024 09:23:35 -0600
Message-ID: <20241210152401.1823648-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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
 tcg/optimize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6d2d55f053..111969c2e3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1952,7 +1952,7 @@ static bool fold_mul(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
@@ -1961,7 +1961,7 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
         fold_xi_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
@@ -2006,7 +2006,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         tcg_opt_gen_movi(ctx, op2, rh, h);
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
-- 
2.43.0


