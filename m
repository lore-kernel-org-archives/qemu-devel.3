Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB6C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkC-0005ZN-0E; Tue, 03 Jun 2025 04:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMk7-0005Gb-Ip
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMk1-0005rM-Gp
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a3758b122cso3504895f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938284; x=1749543084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tHAVSHiF/BVRJDZGSakF1c3dFxbLYF+WOUXWRiDRyY=;
 b=BDuNkshqWHvJaZbxjd+L33vcCzuwgllmzGRLkR9wEOSPLnQQBT63htT4WFTHqhWUGd
 62/v/TnKkQSyyWRyznfsmOZRo6yO3/q8rf3hWOJz2Aipofoy4gD+KhIW19SW4ddcVfwO
 p8tiX6m8El7bYNL/432JbBGl1DB0x7bZhaJGsdtSkE6PT+RJCYNNF6Cc8m4gQ7dt989B
 KePBtSYMZ4ruCfiEXwDFDU+f8jyQ5XEoFhceW8bMwiDcuQFuRov1beXnnzyxkQwL9J0w
 tdULu7xKSWRdMvJBCHLGsuB8VBu9XW4QnfBLOXyLp4FBwnjyjEjsTjxslhsMLV2DKARg
 7kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938284; x=1749543084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tHAVSHiF/BVRJDZGSakF1c3dFxbLYF+WOUXWRiDRyY=;
 b=FPjhrNFppMXUsgoWZhkpY8a8YAkGhIo4oEW7ST6JuoD1+G+4sZRL66nlK6ENue4Qqe
 oWB16joFg0tckXCIeXHMVupQ60HX7IkP/dQMBt0rV8tWyR0gL9/guj3Ws32Juj5ErqU0
 yaH9YVpZdIlkfw1EUbTVc5JMjOv8i1VZUz9UFMaSXFm/SZ2SQTg2iDq5RQU69X2VpfuM
 kFiE2vHucvdJXOEcY2C40HHZCU9yVNQuYu4v2UQvge9IaZpDe74J8l1rgT4NK5YGDcqf
 gqB1I98n0jid8/Fdh/MPjHPg+BdhynP+HInWctVo1kc/C9vDqD9thcPBCCXpdogKvhoK
 WMMg==
X-Gm-Message-State: AOJu0Yxd1Fy+0UjvacI4wUfUFlYOJlPq/wnrtHNO2MVtCIAwrh1Zgl7O
 q0uMY6rFaDoiKa/AoyyS5f4qy4XJwIAktI6KDPFg6a8CJ67Jsd82wX/4PYZWNuOoEwxbfUbAFoW
 yoKoOOk0=
X-Gm-Gg: ASbGncsZAsdANUtwlrhv9h7Z36GyzmES8bgc8To5wpni8QfN2uzYcyn1tPU974Xgf1Z
 M+Q7s1i/Hx8mXC00V4hNt014aNwOgQcUgLWK5N2WksuDUIHdUUVOJomDO3+bk3vaRBgYTaiwSbd
 odWg3G/zaewS/EuZxp0aUJ5c0AYZ1xXKGEsX/No8e2F2CuXI99xuxr4t9q//nW/pZ8I4DKOlT6P
 hZ1pg4bK315GfuLLnY3LJsUIMsyySDIAAqT4h92lx1Ltjt0gQ8WJw13S6nmuMGWjC8dTIebq0Rj
 dffLyd8mxRSDHrn7zfo+JmQ0rdSi6O2RW5IucTQU6s6jcl5KHd9UThkvcUqZDfnEVxO4HG/KxOy
 qkdlFgbvIPGzDbWZxHQ+e+rM=
X-Google-Smtp-Source: AGHT+IGriQ+xxQ9aeeWKUhlLTTeMHTRvJixovLpD7FHaeY4y1MMWlvi25KpGRdkWNg4yAra3TiWnBg==
X-Received: by 2002:a05:6000:4287:b0:3a4:e6bf:38b8 with SMTP id
 ffacd0b85a97d-3a4f7a6534cmr11264733f8f.30.1748938283683; 
 Tue, 03 Jun 2025 01:11:23 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 21/27] tcg/optimize: Build and use o_bits in fold_shift
Date: Tue,  3 Jun 2025 09:09:02 +0100
Message-ID: <20250603080908.559594-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 673849f07a..0b441bc611 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2675,7 +2675,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask;
+    uint64_t s_mask, z_mask, o_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2688,14 +2688,16 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     t2 = arg_info(op->args[2]);
     s_mask = t1->s_mask;
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
 
     if (ti_is_const(t2)) {
         int sh = ti_const_val(t2);
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
+        o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
-        return fold_masks_zs(ctx, op, z_mask, s_mask);
+        return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
     }
 
     switch (op->opc) {
-- 
2.43.0


