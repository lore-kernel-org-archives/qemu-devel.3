Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6BAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBE4-0002Up-NR; Tue, 24 Dec 2024 15:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDP-00069m-52
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:16 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDN-0002ww-IM
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:14 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso57808145ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070952; x=1735675752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDeZA2lUoCCt2kMhRmtoiUVX1sDRebW38v5tmQ0pqH4=;
 b=yUnhNVkMCtSbF/42gO4KO70hOaVmjk4EF9oSuSjJgod+W9n9Sta4kjRGFt0LOFeWXf
 eY39VBCmLi2ue/Q7JR9JI+Qh/ZTIUMxZOLdsmij39XKhrCDiBmA4b7bOrPJvdQE72cZa
 z6c2x91PkJ55JrFT+ZqIPoZxbsak8PtFvar8Q3r2ZE0jx5LiuT4Az8Q2z2wCFii5MAEi
 FREQycjyW2RaImUOKP5Jo6RoCE12DmBZhWpTnVJ8m2OIkYDF1oL/2MUYlzKp1+3g7NVm
 Ww0ATmP8Y8IXTwYsDrEIjUm7z83Jepzpri9BHryP48FbGdHiijHgea0qGt4Bw5BjrJAF
 LmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070952; x=1735675752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDeZA2lUoCCt2kMhRmtoiUVX1sDRebW38v5tmQ0pqH4=;
 b=s1vbhp1kIwuaT/9lis1HUQrQm8mp8gIyICWkhXtH+21NSabcruamvQWwIQG7gmFCOW
 lXbBsW+LVj8+5057CdLn5nNu11+DbgSMtrkx1uThd7WfpeweAM5qxUyhODE6cV//imKg
 puBMuWCXkeGsc2WHti6aGg9V5pAazw0Ch3i4B2J7EnPi7zztE1CtUgJATaSfFgm5xVmY
 qy0iWMKKmSE+BKgfCkCM9/SUTFkZ+EkQC6/xES7i4qyGGEpb90MFqlm2NAbTCqElLuI8
 UbUAN7HQZMD5Jdwmex9H+nv2ryAwZOv3OqDChZDFNNj3lGvOqjRkx2AoJGSaVOyepplG
 tc4A==
X-Gm-Message-State: AOJu0YyKIv3r51rgHqmz/L+VvOTKBCtRQCI16svBr72h+JpioUXqJF1s
 UCwuBTqEddtkgDLych+Y8BT925pejn8/0ecxPeOrz32vRNZqUUSBoHJVQchmQZ3SZuEoMxI+iK7
 Ash0=
X-Gm-Gg: ASbGnctx+N1gTCui2xTRQ3mnx93CtUFJMceHFgt8zpcnCctQEekTfV2wLmeWL964M6p
 sQoYBFmjWkCSkPYnz+tXgh6mlL5JIvtebWO+/e1FYOv4shaZ0x8RGCsjUcinOIqWYfVk+No0F+S
 ++x9sbyiAUjd+LlIHnZGMTykoxvvAvBxjaWzGAUsRJz02xYyfnf8wgNm6DRWrG48UJ5BBK+zfk3
 FGUv/MZe02Xzbz19Fr4Cdkg5NpXvwzDYqiAZhXsGmr+8pHZwbA/CkKZEFjH6W89UIvL1e0Gdfb+
 1vxZzjZG4c54C8Vw5b1uHEf7iQ==
X-Google-Smtp-Source: AGHT+IFAdFm5yZsqESswZrfkxhtBhi4cg607Z2CxV3/pKsLS7dawYP2FKeE9VbRJUOY9TaoXzDKeZg==
X-Received: by 2002:a05:6a20:e68b:b0:1d9:2b51:3ccd with SMTP id
 adf61e73a8af0-1e5e044536fmr29456744637.7.1735070952378; 
 Tue, 24 Dec 2024 12:09:12 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 52/72] tcg/optimize: Re-enable sign-mask optimizations
Date: Tue, 24 Dec 2024 12:05:01 -0800
Message-ID: <20241224200521.310066-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

All instances of s_mask have been converted to the new
representation.  We can now re-enable usage.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 98b41975af..182be7e63c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1797,7 +1797,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
 
-    if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
@@ -2506,7 +2506,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
     s_mask = s_mask_old >> pos;
     s_mask |= -1ull << (len - 1);
 
-    if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-- 
2.43.0


