Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E635E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26S-0004Of-HG; Tue, 10 Dec 2024 10:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26B-0004Hf-4y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:32 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL269-0008L9-Qt
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:30 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb45232717so1258062b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844269; x=1734449069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mv5I27XDUr/tfBisfmpYfU0bdTaxze+ILHd73sKmTag=;
 b=YlxofX+I0oVK554RHoLxBVnnbTeQD7jOsvriG7fRg0i64QbqQdezbj725VfTjMByvf
 JywSIAKrVv4z6JaajLrM5QURXgQAYrqXMKrrB3fI6ICxYlR/AkaxpqTu3oZE6ITyUiqf
 mX9p402FI2I3CP80BXWzmNiIWVUUlUJkSiCmgXXyCoUNr9nGO59SAAs9Q1nIVS04t5GF
 3YwpGKYBuQju02ZbBI4KyvTUSWNSwTo8FuEYcdjytg1vA8tvYv0XAwW9yKn2VBzhIUcg
 8NRt5f+t+KouBZosar3VkP86TJFF1f/wMul1GtoEafJkjou9WMUexpWp2giET/09tf0v
 LEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844269; x=1734449069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mv5I27XDUr/tfBisfmpYfU0bdTaxze+ILHd73sKmTag=;
 b=JUXfUi9DIQIazs9DH9I5BdbEtJi1RuLWVlmUfRCrP3hIJ6IyhQvjVPVeH2oTVGSu8P
 YFaruYCsoOQOr35xmo35YTB1R9MtX+VBEi+31b2ZJ69mqB4gXVAOFX4HsNJAE8EU4d5T
 NNNHauVTNQRCaW9ToeW7T9ptKWyPGl+LdVsg9UOp7lKdqaO0i7+h+wQ4D3Dma6UffXfW
 +8yol8/cSWj0SIxkf0wr5AES6OjRq8+9Je+S8woCnDl2qehIBKGLQ2uySpU3NscVYViJ
 yR3NgYG5GbOw9Wea1p97U6mr47Ys2F5Ak75n0nQFs5HZHb175VumtbALeXrc2fFAFqhb
 XV+w==
X-Gm-Message-State: AOJu0YzIOUcthg+xMljtu8VNdVUBaZVRCBSVTSKlYx6/MfS7VcLBxyXd
 YPiVB+2c/kuk3Iun6wqTRG0lnab5d9WmrsebWn3+DHqDZAXnHtKcfr91CqaOR4HK/lrhMnsk//R
 ZM+Flc42V
X-Gm-Gg: ASbGncs+5mr5gwMAXjQdDamFyB0dJolbILj/nlcycL90MRBB8tscEwGYHE3yFXHrmcT
 SmrFZpdn1nS+1kmK1KeDVXdR6wmnIxRLFvnj3yqRoAO+rTi7HUgt873m86iO719E1E1ZKPfezz7
 4boDVP4kSvJli2kAafrqDD3UDnUhGBVj6+h09IXrTJVEmgxoGRDg/zwzMlxgEjZp7Pr44mIKuXu
 stsUix1sm91i3T7E3nZH9ILbg6tk4NDQd+SlP3bBbS1FtiA9AtEP37UrNi9YQ==
X-Google-Smtp-Source: AGHT+IFyvcXAStET9jiD8+LeEWKFx0FWGQwmO6nuslqsdJfJqac2odROhMJ4SrwwlgVJr3qZQxCz0w==
X-Received: by 2002:a05:6808:14d6:b0:3eb:75b2:1e1d with SMTP id
 5614622812f47-3eb75b21f28mr1206598b6e.12.1733844268900; 
 Tue, 10 Dec 2024 07:24:28 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/46] tcg/optimize: Use finish_folding in fold_extract2
Date: Tue, 10 Dec 2024 09:23:31 -0600
Message-ID: <20241210152401.1823648-17-richard.henderson@linaro.org>
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
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 955151f4cf..a0ccf7f3f2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1754,7 +1754,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


