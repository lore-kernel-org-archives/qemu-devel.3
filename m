Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111A9E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlv-0002x5-SF; Sun, 22 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlY-0002fv-Qz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0003DS-9X
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:16 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21644e6140cso32702305ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884712; x=1735489512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsTmh1MyHGCEig3rcyfPdQfk7lv1k6OuIXFBy9oIfbw=;
 b=Sq6IRpgsEtaszmnsxknWR/KCPJFZdFKizhbziI5YzXB9t3KHtvPtoW+wi/+4ahaDTD
 w//DkbJtVga9WYLCSC1mFVESFqs3P/pAG137pYIXUQINDM2CRYuFOo4Wh+jaR4TN3JPz
 q9HmE6sJo/GWlnxZS4hf4mMA4rvbB45VBGDF7FxhRIDTO2yDmrURdetmjXM8cJaTvg6x
 32uKrlOgPZseuzG26mmn8WVBnHjHTsuleMCxTSjalLGHFlKKJziT/1Jjv2LfbaIfrMng
 Dfi5i+J3fPHzxaJR5TTyMdvx8CRhCzCI3o7DFCbusPJy2TxfWMw5Ei7JEmGjDX8yQYVz
 QPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884712; x=1735489512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsTmh1MyHGCEig3rcyfPdQfk7lv1k6OuIXFBy9oIfbw=;
 b=UjgmiipJS8k+bPUwDXxMtguuBSLAEei233lkanObUtstxUvxGvpWCRSGWRGe4Rk0Ba
 3zh2NkLQcS/UXj/bkIoJqRUszUvHt9TyHll8K+bc1ssTGchM1FS/nbD911eRwf1Y3/wT
 BtdYwu4ej/h+s3UGMPZVSM0nIcsc8ccEmFwwhF16yMQ9s5emchVx40rpPmbda+af4w5h
 h2VtVnEUP8aj1wce3pIPX736wpqJmdK2snHE+yLW9XAkF+iQcMWvzjYH4fSdN1p5mn4Z
 zIWQUXPoLRTNwgzlujVu67khUcJ110Cyse/NEjWSMX+cs7KzLD68sfmsEeGMoxcOKmGJ
 oOxQ==
X-Gm-Message-State: AOJu0Yzgbw3PEsModSax5UH+PlmM/PQpxucfEPp5M6EpXg4oQkfoFIns
 pwC9R3meyv2ZGwQIU2IG34QlkTcC+q67oElSdeTynBzXjavNnXg2BEjS5LHJSr9VR2xy6qM6a8d
 PH7s=
X-Gm-Gg: ASbGnctanpVlk1cCcal8gVV1r6Qxyh7bwAxO3rOie6E0uGXQSJd9mMAWvV18LJIXywu
 zdELkGAMl6B9FLVItvzbxW075/7BavAIEX0lhY0Z6H7QxWkcU4xCJdcCWmwctpS67+hVGPcRRWK
 yH1ONiUK9d8wjyaN9/NfIZNehWVFfplOOaDpjUQEsgiYFKh2LsXMqhx1TH5jsPYPNVFnk2kcJ6C
 DxkUlUIjHgJCc24EF9yzNHqBr32Iq9WLJEkYS9NvV0r2U6FVVXwzXqV9IeFYn8=
X-Google-Smtp-Source: AGHT+IErfQQWtx4eDt+bXh38P0mumkijc1Z+DEXT/eOekOIr7BZTKJRywreH1dhgzsVZkWGD8qKxog==
X-Received: by 2002:a17:902:dace:b0:216:3732:ade3 with SMTP id
 d9443c01a7336-219e6f25fd1mr128915725ad.35.1734884711877; 
 Sun, 22 Dec 2024 08:25:11 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 38/51] tcg/optimize: Use finish_folding in fold_cmpsel_vec
Date: Sun, 22 Dec 2024 08:24:33 -0800
Message-ID: <20241222162446.2415717-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index db26cc347d..3f601e43a7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2484,7 +2484,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
         op->args[5] = tcg_invert_cond(op->args[5]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


