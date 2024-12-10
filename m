Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED95DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26R-0004Kd-1R; Tue, 10 Dec 2024 10:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26D-0004IJ-SZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:34 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26C-0008Lf-FE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:33 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb790888c6so136009b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844271; x=1734449071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9xu0jLwH/Odo5uQpJNpb0qIENhC/6AEk3y7UkW2u1Sw=;
 b=Z0yuZDwomSdWfW0lfGNP2uBHegQLGLc80uhFaP28mknjUSNVA3nhww0hQnrHpwi3Dd
 ojDnYFz+vIQn2Y0LA/hDUY6aQpEOVvxOcPxbhdTWNDLpuu+U5bQQ9jv6Gj4wxxpUWmOH
 jUg7MVXHftoy/CxNajhFopKldELya5SkG6MtYw/mVlOsZPGV5+rRwtGaeSmkCX+YrQB7
 JDRV423265EsYG0Nl/yRnQtfMmYQo/ZLja1Cpho43i5/teQmXokqSZ6Kgn0ZuiNRwQlC
 diBP0Eyo+DoudZm1bxeIxrdIJzIwSY3ZVgMKAhTOf1+CsBBqtldKN/Lfbw+53B3lFn+X
 vvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844271; x=1734449071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xu0jLwH/Odo5uQpJNpb0qIENhC/6AEk3y7UkW2u1Sw=;
 b=QAuUmL6c2asVNmI92sjVulxf5aLjsl53ifR76afqtwn3MdXqI3q8r/8WY9R/SIZlHw
 AkZwscr8C3tYZ7ojRnxOiB1KHgVyVr6LaqG9npPbOha0T7wMgiT+Om3DoaGF3fqH+K0r
 HZjAyOK6pY8fwRcymq/xHlASKTnOQ3tbTMQ7W0CuolKCWEQy3/nLlWcOxFxXI8H9XpQl
 YtqyC7TytKIz9jwDcq5WFFDV5/bqRKaLhV4IvrEMhTTP/TNO3uND+5Q0qhpUeYUu2HMT
 Dr5ew3BFVB0mvk/ccU0k+4N7E0byJJKMJnLINNdhumJPddz9EhtIJBLEeITa3WTtABM+
 KTYQ==
X-Gm-Message-State: AOJu0YxL3p0ZfqHBgcIM2gY84SeH584sTAktwg0ObeS6oNrgVnXXb9O1
 p+ohvvn1ntQ6IiRXNF1yCYAJrm/lLEuBvF4h3YR2t3NmU4A12p4cIy5oaH92y4EPReJD6fUjrQU
 SHAyUbG4C
X-Gm-Gg: ASbGncuitiqe7QfPnGJyQjXwIwzDd4vx8SUwcHpJchggwFCu+5PLDpvPT+uRxVeIzqK
 JgWJAMbvpnRpRzyyNg6RkJsDnIryHzrMcAXNR5iwpIuhgmn6E1+IRVLda//IbeqnI9RG51vQ6xq
 UbtkliDTt1M+A4ncEXLTz79fiG917B2lFMA3MTx4jfmuqhvsSs7T+ljLbKH0/vTiXaS8hi7eAOF
 gjuba72ROqtF5+HZIHDa4fUEd8vM22+zADGkKpyfwdi+DJJO2+tMiZuT0D83w==
X-Google-Smtp-Source: AGHT+IEmW3zCNG7YNJxP6HNtD998j/wtoXqTvWG+sw7BGuuItL9SSXVMrj5jpYjqbC3orSGj+KhMrg==
X-Received: by 2002:a05:6808:344c:b0:3eb:5c27:f756 with SMTP id
 5614622812f47-3eb66e372fdmr3054364b6e.24.1733844271462; 
 Tue, 10 Dec 2024 07:24:31 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/46] tcg/optimize: Use fold_masks_zsa in fold_extu
Date: Tue, 10 Dec 2024 09:23:33 -0600
Message-ID: <20241210152401.1823648-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
 tcg/optimize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5d10e704a7..260e3ea072 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1804,7 +1804,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
+    uint64_t z_mask_old, z_mask, s_mask, a_mask = -1;
     bool type_change = false;
 
     if (fold_const1(ctx, op)) {
@@ -1835,12 +1835,12 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
 
-    ctx->z_mask = z_mask;
-    ctx->s_mask = smask_from_zmask(z_mask);
+    s_mask = smask_from_zmask(z_mask);
     if (!type_change) {
-        ctx->a_mask = z_mask_old ^ z_mask;
+        a_mask = z_mask_old ^ z_mask;
     }
-    return fold_masks(ctx, op);
+
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


