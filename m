Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE70ECD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb8-000553-7V; Fri, 22 May 2026 14:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb5-0004vM-Ew
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb3-0005RQ-20
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2bea7176c72so17028715ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474463; x=1780079263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QD0lZ4gXN1fWzU8DAYp+qX7d5AOu5jrmEh8yc45jBSU=;
 b=VVZFOybEdLb0LvI4+5x3aHyL7uwIibDb37t9//PIvcstRs4ByiSt4na8ca4thWb9FP
 3KkAALGrBE92mN+q96ssYwLQpOFXByUco6ytJZlHRM0zchFYVCeW7vSm+T9VMns9yUYT
 nacMz28urhEVS/ISW6eOfXJSd2Jdi6we7sY9hSmNJ/GSs6e/9DKcuVymGBwmabS4bpKw
 Dc6L3AnVIU80GUkqEHxS6RU7LfP++WI19Wid/xUQuOOcZXlMMlhTA1ufLWzfqJCQugam
 AP8lpw1tuM2ODYmvvHt1sqGJBuxQYAy+GX/Ks8LVJ4dxvWUvLuPfYqQpAm0Q23+Ss0oE
 Cccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474463; x=1780079263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QD0lZ4gXN1fWzU8DAYp+qX7d5AOu5jrmEh8yc45jBSU=;
 b=Vg3sCEA7DS4jupO3Oa2T0+SCymDwAzKtqHf1Tl9oQEfRo58zAUyOp8xeI7JedwB5uZ
 kRpu8FjhRCZ7fLnsOlLGLzg/eeh75cWW0Oji8HswXxr97+TKu+KzceIa7YVCHATQp7M1
 NhuIMthF1S+xYY/SwOHHTgNasu91qhnYbK1zA+WBeHPtBPOWH0hxyTg+jyf8sdSaNFBc
 hrF3d8xZ4FoBuxc67LIQ3rTAHacTY36gsfMOtS3RtI6Oln0L+1fYb4Buo7VR9kzXs62W
 aY18tOr1pINGNGb4LbsKr1OTqpMUjLvNu/j3Euvbfi9FK6fn1NfAx43bhNyfs1mGxgAu
 nQvw==
X-Gm-Message-State: AOJu0YwSvVkVkZBQbmCzrB0VYXjp20JDzcb9Cv/RILha2Dau/l3vFs0Q
 bMgzr2c/m9dLOMeUF9RR3pk9vpAn5d4s5EhWOf6K9sgPtxsCjiZx9Rbszzldc34wZSE0hCm9+Rn
 T7qlu
X-Gm-Gg: Acq92OEj9NlkVu5Sq/afU7q0E2gRcHeL/SmFhe3xoVF1M6KgEgRMrGhKBaudPBQpIWl
 NMXlIgR3cX8nPSCWGjkW4b6Xk/Ua0Ey2QdzJshMt0LouQ0hQdLKAS0oG9nJqf0aFizAyjwe3wq7
 EpVAj9JxpU5kkJ/JxU72poYZMBWzC0FF/2wXsIdvQ/lnnxMh3vq1x42qsgVmSyCEDGIZ0lu3vv9
 ew8E2q+7QVr+nZO7qvGb7g8k7VJ7x23JsB4CGW5p3Av6/jTgcsZWgO3Sz4D2+0K4IkHotL/CEV/
 LFNNjkMKaDr3i3lM3X6tLJvpBH16KglyweM6u+cazbfP3R3i1wpjy6l9B1XIaJ+rXB/shQ7MlwH
 AoIZ/yH+mBXEy4oSUSORsfqEXPfm6MOaIN1YSXhX+aY+k80MyD3XmzsMht4sgWJTRFSqmY4wmyR
 DpdfIaOnmjW53wr+N5LkfJJb3BgXPD
X-Received: by 2002:a17:902:e845:b0:2ba:4f37:d3a7 with SMTP id
 d9443c01a7336-2beb06a63c6mr53161435ad.27.1779474463308; 
 Fri, 22 May 2026 11:27:43 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/30] fpu: Use get_float_3nan_prop_rule in
 partsN_pick_nan_muladd
Date: Fri, 22 May 2026 11:26:46 -0700
Message-ID: <20260522182658.184604-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index f40a950b41..7781e16122 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -163,7 +163,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
         ret = c;
     } else {
         const FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
-        Float3NaNPropRule rule = s->float_3nan_prop_rule;
+        Float3NaNPropRule rule = get_float_3nan_prop_rule(s);
 
         assert(rule != float_3nan_prop_none);
         if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
-- 
2.43.0


