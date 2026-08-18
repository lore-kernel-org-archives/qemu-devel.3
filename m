Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82F7C5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCO-0007Le-Iw; Tue, 18 Aug 2026 13:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCN-0007L6-A6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCL-0004cN-G9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1056634b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072520; x=1787677320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UIM0s5lWODAxHFxh/yWxa09GnkzpjD0dC8DHL+7U4bw=;
 b=tD9fPbqoPfLue/avhRcXliLMYUc7AOysWTI5a8xs+8XGDKoACUzUtrVkNYKo3TPBsD
 xOZMoXhPUXZKQCTq2bLZ/T42AVSQAzlcPOeXFz64XZssmCDMGC+wB7dc9zB35QQDaaiu
 qPj4Bm8KvUE/FfIYz4gshu1dJ8AraZT2vAFJKD8EI8cagsTkv7arRHJt6Q681SOvk8TR
 CAGCImsObmx5qWfk1DAF3tZl5P5JVvIm1YJvQGJpCqtXXfZehsohgNDgZs15ZsutMEBW
 iFPXpPvQH2OKsXGlM46Jume4ZYedJ5TSM96hhfI344ARa2HVcOynFEy39R+S64ogNQVb
 3Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072520; x=1787677320;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UIM0s5lWODAxHFxh/yWxa09GnkzpjD0dC8DHL+7U4bw=;
 b=lKWaup8ig3M1NriePsZl62nw8ARaaD4K2pDaiUjo+mtzrnIEXYlOp4VIa6/zkwKiRl
 N0ReXERB+8QMILd+XcRBDbUF9nNgSr04IO+pYsls6nbNBbw1LyT4UShPMiJecx5z/1Ki
 /2Mw9JBNIVZ7azw0z5FNvQNd2qfzZb6X5vboMg8qsf+BnRsnm1YC1K3G/LCs/fnxbQMc
 NKz0QJSBuZ7eM3VGFiqXwgeVPUgAZNdzmjIsTp7h7DwAKIJPg4i2AEjj3Sa+7++rrPPE
 JSW1dzBigZ7D07i+b9E2CIyfw50iXpxBNUZYCn7PMOv/acC5RQ6W6epAqCBkJi6e55Dd
 Yn1A==
X-Gm-Message-State: AOJu0Yz06FYoIFGwPkVbshwNheKq4RZksx4+PM3WztNbOp5uD7QWBg4A
 JzW0tEufQmue8h2h7YltdbftRSf9QDMw/CqdjmIH5AP9CvdIzWpfFOMB2AkMaN+P0K1sEO7TWxZ
 6cKiZH0A=
X-Gm-Gg: AR+sD125zGpkhjFInfSr7rJihqKvKQvcXCu/gYHht+YLgD2riaVv3zLBTCImS6si38i
 z/WKl6oSd7Z4YmS8xP4EMPQrhUZcKoATk35ZgFIsJ+A6hQw56I2iEj1tVt6Dzjexm/teHPgAmtU
 dHqlk+eQT8Ah+XXdjmTnJS6SPbMJqi4C0Qylor4fhD3CD0VuZngYyOH3arDJ2P06y48fWaQjiFZ
 dgyrq5boM+DG7o1rC1Z5SSJpoL3dVoWG/Xgnq0teKXPnKJbEBPsFeDPT0VM92syLfwfTsrHAxs+
 dry0eHWkVS2YTJt2443fr86BPrPHWFTaMR2EohBvYUK9VVMKpgntr+ZHU+14oPpX0cHY8PEcBB6
 Ng6pqqAVNwZJK852NdTnamd5eEISZxS6FuooN9o/BSljtxqhFryWRRL9+R3Q82mEKn3cNvu9aiF
 cB5uAwxDOF2m7PNByUyYBwPXApW2GQ6NMfmMrgE/r1treZA7ux8254QwBqfNrLUm8Lv27bbxLdv
 nc9idW7aH5F/cWOBokCY9XXXV0xH9TlcWo=
X-Received: by 2002:a05:6a00:b93:b0:848:4c3a:a359 with SMTP id
 d2e1a72fcca58-851bc426186mr6962710b3a.19.1787072519950; 
 Tue, 18 Aug 2026 10:01:59 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:01:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 01/38] tcg/optimize: INDEX_op_mul is commutative
Date: Tue, 18 Aug 2026 10:01:18 -0700
Message-ID: <20260818170155.1907006-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc: qemu-stable@nongnu.org
Fixes: 7a2f7084525 ("tcg/optimize: Sink commutative operand swapping into fold functions")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index fcdef25bee..ed2ff32ed2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2152,7 +2152,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
 {
-    if (fold_const2(ctx, op) ||
+    if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 1)) {
         return true;
-- 
2.43.0


