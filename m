Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1848AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsBe-00079n-BW; Mon, 21 Jul 2025 11:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1udsAj-0006FB-4v
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:11:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1udsAg-00043A-KS
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:11:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2349f096605so51473215ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753110675; x=1753715475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgRdvDymuUcz4ENig7Co8/7DUwWCH2GmvD/UEqjYk4w=;
 b=jqNKFTZLAx+h3pQ9Q2Zpn+dxRQ/cpz/tW8Ae0GObVJUrI7oHOxHeV7JXWchrKv/fNP
 Ww/hejDK5qv5/+4flaAiTaKXWqasKnZ6Kifqs588+4VWRh6iRqkpVQ3SZDN4w5NaGiZ1
 Qf32BmyTAeEI8IhYtwgSQUxV1o3tNDHdPHHc9F2tfdZpMLjSddX4Bn5M+2AIZYsUzBLC
 17v8ZKW3uiCttjL04JFusG6pWelLAFN9aTpRKPg3JDSR7AZCDqoa/TKSPHRhO5pmIbqH
 LottaWSmglmqZiESHqoLNNIkaZ8gqfkfB2d+NjzwsDDeqW2BjoqOhn6HCp62YCR2A4me
 Jv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753110675; x=1753715475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgRdvDymuUcz4ENig7Co8/7DUwWCH2GmvD/UEqjYk4w=;
 b=qH+3ICHk/mRbGLf9ewVv61uWOgMA0xtkkiIesv7n8/YAYEG6u6jUmkCSJIwAxtzp5K
 pQCrVvq4e1wXqIwGS7/69YU5xkeNCOzluLD2T/m40A8gHdeb1TnAWa7W4xk9g/CyJXC7
 UnisUY/nsu2IWt2Y5gx91AITxi135eSWxPzbFXNOj0FpbHVTN3fzdJ2ea6+04saIvMo5
 0cSDOPLT1OHESJwU0az0UvX8QVX+RLcXjXsbBDTd2xZAbd7pJwryaWwubOhVgn+/w84+
 EtzfZDarR280RXq1IhCRhMnmjf3QEgYPj1ymo8dJoClnL0lE6vjE5cXOXoTdUIMffE5T
 JPNg==
X-Gm-Message-State: AOJu0YwXN5S9N2sN+qXew7sSMg6oR2SevM01fB+ADFCxzv4RHTihLBrf
 8pZbbeOpXUy0ZPFJc9PFTP+rr2Ay+1chsr+xmdyJA8R9+9sMFWMCyD/C6JiAels0HSel4c3bNjZ
 kBd8i
X-Gm-Gg: ASbGncv+POp/DSU8wqjz/b8WFBzv/rEFq3NlZrghtMC35A1MV62n1yVhzBkZ3SQnwW+
 iRJQAjY9tJQX3FHyWHzdFMJTvwFaof12NbNOPsJCCnD3TBW6ul9BlZviTA/SoD1InI/3Yo97GCf
 SxU1bDATZeErNnnFwEOVthVifO8bwPtUMt8qmwwHmxvTE7c7o8wTYOBUnagia6840OuEoGjpimT
 EApskuRsKZD048cXnBE4Zx98ymXDI7IDn2pW1ZPLoNEQgiBi+1QzvbEUEl5X+Ayx3i966wWcxnj
 dooW37Gg6eL5xisgmhknkQmLG8+pEagQuDKIlpDj4gbwYfqhK6UCWeg815xBYv1adm+m8MraH1A
 CpkUxyJEzShHVF77afi0qC3/9lYDI
X-Google-Smtp-Source: AGHT+IEan6HRojTMb6idrRQA9Tlpbw0q7K28Mild/+RciS7tjcefqHdkAueQ7zbe9/FtOk2hQW5NnA==
X-Received: by 2002:a17:903:22c2:b0:234:b44c:d3c8 with SMTP id
 d9443c01a7336-23e2576478fmr260773835ad.37.1753110675489; 
 Mon, 21 Jul 2025 08:11:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e2e30sm59953485ad.2.2025.07.21.08.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:11:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] tcg/optimize: Don't fold INDEX_op_and_vec to extract
Date: Mon, 21 Jul 2025 08:11:13 -0700
Message-ID: <20250721151113.56372-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721151113.56372-1-richard.henderson@linaro.org>
References: <20250721151113.56372-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

There is no such thing as vector extract.

Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 62a128bc9b..3638ab9fea 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     a_mask = t1->z_mask & ~t2->o_mask;
 
     if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
-        if (ti_is_const(t2)) {
+        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
             /*
              * Canonicalize on extract, if valid.  This aids x86 with its
              * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-- 
2.43.0


