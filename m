Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F683E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMY-00005O-NH; Thu, 19 Dec 2024 23:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMS-0008UF-NF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:36 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMQ-0006PS-Ad
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:36 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-801986033f9so918232a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667893; x=1735272693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGsAjj2auqRYQ8ARQDokv7gEPzbvdUhWdANXEAlpLeo=;
 b=N6JOlDCXlccrffIAFdi3gWcNtjIkJxvDCVq8ysKMvl5v42but4zJBqmpkqbqKNqdcm
 An+QkpaW9zlGJNxZPzKaJTgU9tvpiHYAF0rbgxwxSHdticqxN6W11PcjqWso6ZmQ7yxL
 C4yRdrWZy2IjCDy5ZSY7XK018uiOy+6HYbb0GmwNGwNjA6FrCu6Xrgi+TV62Nx7ltU2h
 rpoAMYir/EbG+H2zlMjaYCPLrnrAj96wdvycYR2QUdoIFpTV7+0cK+sSBmoVKWUHOc6h
 7mULWAcBMJHg5MIE2EnzB+UFTVgjdJhVmiZqhkEVvj7M6tqgL6Hh9FvR2ZAinZIn5VvM
 9YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667893; x=1735272693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGsAjj2auqRYQ8ARQDokv7gEPzbvdUhWdANXEAlpLeo=;
 b=BVt/b95K24DCZAImAAx3LHo1u+PFky77FgOHgIZvKbHfG1Gs6jzTrW71cxXFsOHAEY
 eB6klqHDz+4PM87xaR1DJJeHVv2TZ/8F0L45+Vy4UXr6ChKoXyEcvdiEhYqTmv2C90Rh
 mVnsZDwRVrDa68f79yoc82LYnrTwXoVP4XiySuJ93+VABLvqcZqKoY+lJcfTOygS3LUJ
 LBp3YSr+IZQuiT7yEFefRY4CRgsAx5KHYJxzzaLyO6ddJ/CLzy1c9t8mmtF/FX0GhzyU
 lglIu3kvsSpdP4glA9YxIPuKVbnTTxTGy3CeOyo1CrncttYUTMnPgAKjMVpdPgWmRmTC
 NsCg==
X-Gm-Message-State: AOJu0YyIf/D6uScidJG5hzcX9NaqgKJhgW9NcUm5Y5r7krAJP+Kaa7By
 XERM43a6oSyBmF8SeiS8xdf2pXD3LZ2PiGT1AzimfOFYyqgYVtI+uPMCwAXxB8DYNuy9s7n0RCD
 M
X-Gm-Gg: ASbGncsLrSYqYfL0dEVjksR5P55flED32GxuK7VkDPn6xPYFTDXTMbOUK+tlYtI8XpQ
 3Xb1plzAJ5cZsg3OgHy89nNhAVlc/tkr1hjOz7tsc58xKEt6KvZ+ywGd0ir/uLA/73VB5QBSuzn
 IaDcpumpoKrMOizgnHx002WCYu3xkiviYXXxp4TBaZxgfkvN5QJUHLOAn8jzisof3qNoKyKYKHo
 Qj1wjiRwGgXtoY3VV831Xr7lsywIEgFsfN8XihtXuxqWXn6DtFO7s9SxtRvVS0=
X-Google-Smtp-Source: AGHT+IElEknO/Y1EH7zELwhpM6m2w5qYr7DWBN6o73tdFM949cGh0hVh2iOpsDpZa/wgpQEOtdYXzA==
X-Received: by 2002:a17:90a:d88d:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-2f452e4ace5mr2013631a91.21.1734667893134; 
 Thu, 19 Dec 2024 20:11:33 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 38/51] tcg/optimize: Use finish_folding in fold_cmpsel_vec
Date: Thu, 19 Dec 2024 20:10:50 -0800
Message-ID: <20241220041104.53105-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
index 9ce90eee7f..fae6a29685 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2518,7 +2518,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
         op->args[5] = tcg_invert_cond(op->args[5]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


