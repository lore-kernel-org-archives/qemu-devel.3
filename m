Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEF4E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOm1-000315-LB; Sun, 22 Dec 2024 11:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlX-0002eK-Mg
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0003DF-4M
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:15 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so2261254a91.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884710; x=1735489510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R53s1jpecraivE/LK2pORQ4hHiE79PLfdQdBIIfi/Eo=;
 b=b0ExlUkYkryloOYcqnIEuix0nKknc1SGNGQxBgHynMu9NN9ZgX36+dkDVr0z/d/clf
 Vv8cR3F9wjuPt8++XzjGtzKkolhyqV5eCX/0XrtJfSEFcjiJfpp/GT8B499/FAZY86iP
 cNd15wJmHNujkta5VYM9PHMG1DDTqcFacwux0Z3f5BSdUK0UYu5HK+s6bvYPek/HtmWX
 2ZTb646sVpTa4jxRLh2hXkd11Yjf4Sj8CzSaHOy7lGm86GlEYh0qfBptJm68iygxHCyc
 jVDq3/jIae4Qihm0VdQLAoObsRNTRJfywV90KHba5k8DlWuLqRPirRckhxmZ7zRk/U5V
 jNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884710; x=1735489510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R53s1jpecraivE/LK2pORQ4hHiE79PLfdQdBIIfi/Eo=;
 b=N4SXY3KI5KkNefjcMfm+B0pmwUTWLyxk+bqD2htf5kLfpJ0wQL/izyyMpNIPzXdjQe
 ByUCc1Gbh4mn7IOeW9GPwcAyOZEf4PPM2doA2GfMuG8MRVckMptnc3Ncy/qfJYxxiDcD
 kU4ygXQautnyNicStZTlywSd0Yok1Cqiilas1roBVHslHEulZWwgteG0sfUdJRtA2dEh
 gNgsv754epIpIghqeAx4vBtin4NvvR2JXVuOFkN4xjSQkHi31HimhtWuwyr0egY6+B1w
 dGFxI0ufXa7TtR2MluXg4njW19jYRr9/YHM9bKuPg/DI/WyUPO1RkNugRSr7OePYs1bw
 8InQ==
X-Gm-Message-State: AOJu0YzDbyTxDlhUGtYaKsJ3t+P+L1TS6XV4RZPCTonbB69AvGx4mp0W
 GHzQIPdJaEbcPnxagMRBW9t8+ugidkDrvSC9vHn03DmWCqmVoSgMeqoWJUe24MHDoIqWKo3p5QZ
 DGkQ=
X-Gm-Gg: ASbGncujbgu/urJAydA2hBw18nsb/tX0cgoE0HDY3ThaDhKWQ0T47GwMMdkw2ZixnZu
 /Do2SVr8D+xnJhfi0XzXU+PuuMPh7yQ/15tKP8w0msK0uxP909CB5kONoOQRpXzzxS9dO+2eOZx
 9QbbGIMlUOTzT4AsVFYrXevrpPxRHLxADvV/ot2ZKqFxHNAQzQJvB+YGQlg1cYcBXBskGhOsQv/
 u0yyNTEF1FH+MjJF3ODuKcZ/lFUIwqh9h+6UMxsPBd07AFVYt9TJVoMLZRuOB4=
X-Google-Smtp-Source: AGHT+IFcQ3mLT8yy5N3Lql3Fs4D84JyLSElzdDVsA43DPikiEB/5zpcfouiQq1sDZjbd6Av4xsLX0A==
X-Received: by 2002:a17:90b:538b:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2f452dfccf6mr14700662a91.4.1734884710547; 
 Sun, 22 Dec 2024 08:25:10 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 36/51] tcg/optimize: Use fold_masks_z in fold_setcond2
Date: Sun, 22 Dec 2024 08:24:31 -0800
Message-ID: <20241222162446.2415717-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 16c1192a91..e5c46dd6e2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2451,8 +2451,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
         return fold_setcond(ctx, op);
     }
 
-    ctx->z_mask = 1;
-    return false;
+    return fold_masks_z(ctx, op, 1);
 
  do_setcond_const:
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
-- 
2.43.0


