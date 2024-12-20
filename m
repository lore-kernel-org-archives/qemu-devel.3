Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D64FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMV-0008Vt-Lu; Thu, 19 Dec 2024 23:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMJ-0008QD-Pf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:28 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMI-0006MI-Aj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:27 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-801c081a652so2049670a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667883; x=1735272683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYogLE2cJhonKzxn/dJxhdWBVbT5TGD35lyasdR9UTA=;
 b=zPxi7xfQrSJrOS68OxzZFZLwbAxMyUdtO1j+S0Kr9We6XhdhWLSJxg96WTx1ymYYdQ
 Vc9jYq51G3l7JT00AopT2M0LsdfU16sVzJMvxT9yRy63KJT1bo6N1FfypC67PmBvyZzJ
 mY0KZd80pdGa3FWMqmelyuZKehnNksk5T/Ke6mqSN6FaCnKJ56ASplORfve3107jR3l/
 /RNEAXtZ8WeEQcYZ5Yh9i339t8eVdXJjM3a5AgLJyTMPCIUVAlUTSzrJGfS0LOqp1j9x
 SQk0ug/CS/XcpetYWj1WKwfKbRXtzChn6vTR3t0g/ZwSOKdIU3YFQa32apJdZQh3PdZF
 J7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667883; x=1735272683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYogLE2cJhonKzxn/dJxhdWBVbT5TGD35lyasdR9UTA=;
 b=MTlCLSWe/8RcQLSGTEaZRkTWEjQc3KkQJs0Kxo/Snf7NybxCvSDrD6/z9TsG1ZaMmz
 VWDBOTbvxO9M3pvrkiqvWngHcQIkBrwBUEHWrLcciF2392fzEpNpt7of4XOQSYLuUqC/
 vVV8Mn5Fu1KdCalQf1rG3l98ealA7yAMT1o7bsanyRtyDDQIMvYA5G2gaGDhdqHGy1RW
 gj+uKSU1N9jaKT9EbNDAHLncZqc5sIBIZ/0NyAj5yiyno2uZIcPG50uwikLHNPQeDmUz
 lWQNdltPXDRr80cCMyjU3gpfaL+pP4/eml1bd8xu+yfvQCVYA/DhxcFERe2bwtJ95abT
 xh6A==
X-Gm-Message-State: AOJu0Yzoxhx9VR02Qe/V7cOuoxq9HpWkAFVmJuZyhZwpELq59u8pavoG
 TVbyv5sR9zxfnUiY1z560KzR2/OnQfFgZnxK5g5YgyMbUyur5zZFBviuX7cyMP5ejS1uygBDywf
 /
X-Gm-Gg: ASbGncus0e3g21/JB0Wg/mTYSKE4w/HlCqbHGEKITFdUdSHq5MQfNwqRMBlrzDpxcyK
 xqXowLvS5cFpHHelodOs0c0ZItjkueluh9kiPL4Tk2zyYFtML6pe1FFecYy/StVQ5CHUHaAxnIm
 f8u8ALpPs8QsrdFbUbfuuFhe6ijrJYHa55/EqNdXsyOiwkK3R79Fx5bOe57dUhHoJ6sPu9bInN8
 yCz0jpEp4467CybTAkw+ZvQ8NEaJbi1O25VJlcpU6dLXzU1kWcEL0H2A7+KofM=
X-Google-Smtp-Source: AGHT+IFM/1YsrxP2O5pY3oLmdWIbEbgeehzJceHG1PsImHy8r4ItsbGuJepipngSpmRedL5qWztk9w==
X-Received: by 2002:a17:90a:d502:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2f4438e4b30mr8648213a91.15.1734667883597; 
 Thu, 19 Dec 2024 20:11:23 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 26/51] tcg/optimize: Use fold_masks_s in fold_not
Date: Thu, 19 Dec 2024 20:10:38 -0800
Message-ID: <20241220041104.53105-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 tcg/optimize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 04f0f8b9d2..6af23f8512 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2090,12 +2090,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
     if (fold_const1(ctx, op)) {
         return true;
     }
-
-    ctx->s_mask = arg_info(op->args[1])->s_mask;
-
-    /* Because of fold_to_not, we want to always return true, via finish. */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_s(ctx, op, arg_info(op->args[1])->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


