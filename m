Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8E3E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBEU-0004Ux-0w; Tue, 24 Dec 2024 15:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDi-0007hJ-J8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDh-00031C-1E
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so64893235ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070972; x=1735675772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqH8fYhzwspoKRTd/2StonIkPkTT7XOo4RkleZm+9sc=;
 b=kVQpUWLD97v8QJGh8/M1Fp5P1mO3ne91LHuWaru6Xwpiep3Cjnd67WrieFH32PEGdx
 Jp0b5HA8D+dwllI99Zqw/dNDeOcl7o7H479WBkwqAHjTUoJBFDme9HS4jQPLedtvPSQ9
 8VPiBc5ZYz/ql4Cccb+pnbi7xtXvj14cvCa8A51SjeCjLof+MpyhlgE3JyB8PTrTTm/J
 AbamsRl2R8QJl5dOLoI6q+eORKpb7eNK3+boGGicqEJNUjqo4qVyRuX3DLkPmUX9VLI4
 zhqvSjgRdGFzidzMUjMg67MLbUJbvK/Zo9e4B6XpNoJCk9p7S1P+Qus7CXllQApj5t/X
 uiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070972; x=1735675772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqH8fYhzwspoKRTd/2StonIkPkTT7XOo4RkleZm+9sc=;
 b=gGn8DdWpbBTKL+O579BQ7pzptMzD3O2N+T4y75vzIeuE0WBt9vMY40j4JCaGbKTj6B
 INseUsUzVkPpnYfpTKkP1i0Q55nY2rCq8qZPWjaYIt+KcBpr++OBjna0MkgMi9QjZE9y
 8bjtl1UZMyp0WyyOu87HXzyiNmfo3Y7+RknjhN1nabYTafTsk2X/M5mvAFGICgKBlh0w
 MYxTTqm7lT0JOjL16CnxpJbt30KpV2mWh8WvOExBpNqVQQ6kLKle3diQ78Ht4T3JLmta
 DMDPP3tGd8Wl5k3zPC7VO29N0F+F/uqY9z3VrwQruLFRQ1BZj1k9eqHInURSOyQpLpKz
 HRnw==
X-Gm-Message-State: AOJu0YxV3ddDYnpijZVyj0eAXkwLhDFPe6tDEFqUOwEZwliysHbqCT0c
 y04eNtlzttiZ/ddoJwjL0hx3noCclQ6ASKK0hQHd4b4ls0YLTa6tUzYP5o5YvkJG6HAV53CVFon
 ymK0=
X-Gm-Gg: ASbGncvnu2ub1Wg7jDgx70w31yc5VGJse9EYo4QWnumkuwkymLlPhq/WSuC8tR579ZM
 /LBc5fMSAm+gLxbeLZyRJr1fc56Zx8uCH11VEI00usj9jZE2WcQ74vP+yhSjLEWhg2ROL8Eyq25
 4L/aTXPFPxFOi9VOzcALw+lNvnYwSs1GUCQbpEjXMRyghglHSdyt/tiFArhCJc9LsG9S/gwHPv7
 MAznHifrn2r8iyb4yYgRo94mzUemXs6barx3jgPrtPYwIlq6jvzvaoEPm5LHIdYhPdmR/JBHFRg
 /k2b6nDTDzucdhqAwgLrqAqBjA==
X-Google-Smtp-Source: AGHT+IEkhpbpdS6F6/H/Dk6m19VBJ62D+mKY1kOpUGgjIygAH3PNJO/cS4QPgNhjXKnw72o9OAxX5w==
X-Received: by 2002:a05:6a20:a122:b0:1e1:b220:63db with SMTP id
 adf61e73a8af0-1e5e1f56b34mr29072796637.16.1735070971709; 
 Tue, 24 Dec 2024 12:09:31 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 71/72] target/hexagon: Simplify internal_mpyhh setup
Date: Tue, 24 Dec 2024 12:05:20 -0800
Message-ID: <20241224200521.310066-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Initialize x with accumulated via direct assignment,
rather than multiplying by 1.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 07d2880776..c557141f11 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -455,7 +455,7 @@ float64 internal_mpyhh(float64 a, float64 b,
         float64_is_infinity(b)) {
         return float64_mul(a, b, fp_status);
     }
-    x.mant = int128_mul_6464(accumulated, 1);
+    x.mant = int128_make64(accumulated);
     x.sticky = sticky;
     prod = fGETUWORD(1, float64_getmant(a)) * fGETUWORD(1, float64_getmant(b));
     x.mant = int128_add(x.mant, int128_mul_6464(prod, 0x100000000ULL));
-- 
2.43.0


