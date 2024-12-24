Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8905DE7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAG-000308-FA; Tue, 24 Dec 2024 15:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9z-0002ne-W9
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9x-0002Zj-NW
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:42 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so64869895ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070740; x=1735675540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEBb6lgw9CBGrH+fdl+vxQW2dmf3GxJ+EO5jjQIVvNE=;
 b=A289RmNwd1/g8LiAnGRSsEqJ/ROtkw+Pb06Uq8Y0ru2e/I5y2UxHf95ZLJu9hKcbNn
 RCJVn/sOz0oxvJ6WiJLwBdbgDl6ozmJpdK+fxMErsz3RTFD/HOQCXSdirlvo6eGOg0M2
 uUfXaR2QD8plRFGxLtM5wbh3MqF3+GTW8+wvVlrT0W/wSJyQtZQC2EAgaMeF/2v+UDBd
 gZDHXjUyH3OxMdisXvZ4NaxuvWTeQQ8mmwBkBqi2SOoj2sr6tiIYuVX0rD+CDFpaoM52
 I4lkZ2qao3UIIi2ftK05h8EiG8o1S8kXRYMoNsaLub/VN5/7N2gWbArWjVaKMM6UTfmX
 mPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070740; x=1735675540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEBb6lgw9CBGrH+fdl+vxQW2dmf3GxJ+EO5jjQIVvNE=;
 b=PuhKCgrR+Egiwdqbb8b5RfYiVjr/3VXTz8sItUNfbgnoECvIiMidFz8YGbD66ivrXE
 gSWUKlxGYEnmYyC/Gg4ybIuXdsKdyQc+GYTa1DR+N2Xz5mZdZwCQMze5d5W6Pisn7535
 9tm+lOVEzLBlUVV+svb/rqrBwPqZVQKoyw3XmDE0O2U/O7pagNgFOQzCrzC3E6truD+n
 9KLfYytU16SK5pxY/LawkjOyhL4hQeCh3NNakoZK3+xZxPxTW+EloDvSbqrEvxlsk9g0
 PmgMn/gHpJtaVZkYLlOJMiCP+XOnsWVY6rV5xNxqod8Qw6KMtqZ0h5IuiSR8lDGJuK9B
 iyeg==
X-Gm-Message-State: AOJu0YwNNroz7YwjH8OPF+1eRqH3IoEausAKnsK3qJZaMv8k0InYgwIr
 Q3BzvJJ3mDAtvo28WlovSJf3dDI/Lkqi3+4RjHPuAaaLbTLvHmdadSmhxiz0C9u4+7nltMUDEnM
 aYH4=
X-Gm-Gg: ASbGncvjgO9JpVlHSenpj/tn/47mBGjWQUjjya24h/cuCQ+3hXX6J9swghLAOk6eyQz
 sKeum85r8YAh1kV8OaXjmRZZb5oCU7w8MmdHah58SJACzEZ3il9yukakD5FzP240xeKZRJVcnV2
 d0undYnF1zHSUKHC9H7n1pHHnpXekAU/90U08zQ/bn6NXNScRmLIZcK+Ohq263lFLgy0NHsyNg8
 ej+wOBd0DiLgbLSpnbXKFqe2YSBLO/Iis/gL7dbrbUHnQevBCA7dF1w4qOZKdWHMEQxZEpMav7F
 lM3GJarVNuisC0C139to6Dij5w==
X-Google-Smtp-Source: AGHT+IF769/wLqaT8oKggrRZotE5VDbVp5899g+acCjZ5TvoJ+07ohFpmDt42KG1Y1rhlF3DO6ar8w==
X-Received: by 2002:aa7:8d15:0:b0:72a:83ec:b1cb with SMTP id
 d2e1a72fcca58-72aa98f5b53mr29949932b3a.0.1735070740507; 
 Tue, 24 Dec 2024 12:05:40 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 19/72] tcg/optimize: Use finish_folding in fold_dup, fold_dup2
Date: Tue, 24 Dec 2024 12:04:28 -0800
Message-ID: <20241224200521.310066-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a68221a027..803bceb4bd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1698,7 +1698,7 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
         t = dup_const(TCGOP_VECE(op), t);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup2(OptContext *ctx, TCGOp *op)
@@ -1713,7 +1713,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
         op->opc = INDEX_op_dup_vec;
         TCGOP_VECE(op) = MO_32;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
-- 
2.43.0


