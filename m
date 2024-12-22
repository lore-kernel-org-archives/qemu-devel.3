Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69937E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlt-0002vD-Mz; Sun, 22 Dec 2024 11:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlI-0002Zl-Hi
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:01 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlH-0002yf-6H
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:00 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso31420735ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884697; x=1735489497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsMsu+KnHNOz8xxBzxsDdOwYFyA0SvaPufxN7cNRIvc=;
 b=HbJXVLZbywVN0IfF/7pwqWvL8hlFVs7n8yceDmJtLrS6cQWK0hL8+0Xdo8IBL1+l7t
 gSErmt3TAy4xQZENlOo+0GpGLdylIPyO28myESGh/CIEn/rOlgjHsJx9WaIvvw15GUcP
 DG3IDJFMtXHSaa2vBK/3DYMqnTVD6HlwD1DAsTm3coKM/UDKuV+5mN+AivKPo58OtM6f
 4NAwnhW53TEvs2u3pTjmajuwgK2l1x5/IJUGKkJFKniETiuODmaXJtoCaADryoDYhV+Q
 SlEGcKBpD5Xop2iHQXY2FGzQFn3P9h9jgn2I+PE5O1QWyPGbvwnnyva53cnwE04PGB7J
 2ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884697; x=1735489497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsMsu+KnHNOz8xxBzxsDdOwYFyA0SvaPufxN7cNRIvc=;
 b=WlzQwvWC/oSyYBv2zbVrwBPtyVAiRTbZvdmOPneVvhXW6oNg9pG217+db5/uv/fyMH
 NYhWFsAnfL/rqLz2gA9iYRd7Uf1jE/TOXTBsQXD6PgSsgZnu/dT/1KtuB0KPWY0NCvKR
 uxALWl5uttWTDO0CM3+F7nAyQl8nPT/lSTg0xxVqEURjUwapSdN0WHdaPlcgPQEXBoF1
 IYB4K/CA4frJLmVJzC09sZbZ7Nr2BDbpFtgg3czxXGXrMDufTmPptSMeIaz0H33XyIy6
 u5Z4wTgeSCPqUopgHKMRKoEV4QM2NNJY1KJRTir1zwR90mlnYgHtkxXGvZJHG65ZgUjG
 eYrA==
X-Gm-Message-State: AOJu0YzLu81ukUgdXl23QM13yBy+Rs6MLsh2ZsPIw2lKqUk095MOMk7m
 ttMKUjVen3oPDv6svEW4ytqT4kmVNS133VPX5DyI/Hdi4z4xwuqYtna0iw/YUpTpZSrEbIVotL0
 IYhc=
X-Gm-Gg: ASbGncupVhNO6drPlKT4SswP08P97vmFofGmbbbZL9NN45+1iPNtV3VTxl316jgNrc8
 tfM3+0mPQh2aGyyi5swOKX+ODK05cWdzBYMScx8Lpjoih8sGJiw/WRwbX3ErOMAe+YDYH7kxmtm
 JVueyAU/UGBXu5M+yrKczq05cQxtJImFMCQVqjZ8jqG1ZaobMu+8py0vQMurcoANXHR0h10M0Mf
 WeALS4xSq9udy2gmRUjB0+Rkv4n5PVRhBd9cYsvgLQUG6CDq9Hj1qXobvWoKFA=
X-Google-Smtp-Source: AGHT+IHQz23cjw0h5HqEzc1qsGoJnUuhLf1HqqkNLMafCn69E5DqUEn2ejrIBxpDh6MkQKwLhzi0WQ==
X-Received: by 2002:a17:903:234b:b0:216:527b:5413 with SMTP id
 d9443c01a7336-219e6eb6273mr150857265ad.26.1734884697312; 
 Sun, 22 Dec 2024 08:24:57 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 15/51] tcg/optimize: Use finish_folding in fold_divide
Date: Sun, 22 Dec 2024 08:24:10 -0800
Message-ID: <20241222162446.2415717-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index b6a0bfe64e..0a617bac71 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1671,7 +1671,7 @@ static bool fold_divide(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup(OptContext *ctx, TCGOp *op)
-- 
2.43.0


