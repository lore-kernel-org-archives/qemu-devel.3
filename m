Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CB0C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzM9-0007BR-Au; Tue, 25 Feb 2025 13:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJG-0008Nq-GK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJA-0002Dc-OT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4398738217aso51922365e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506726; x=1741111526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eOxUDeB+TfG2CY+nV8lII4WevwTqc826MHvYAYe0tck=;
 b=piWpDqivr+bHCaI0vKewYinHtwh2HKy8vmqSM7mpU4QRG/CeEauBZRnsg6HApxjffs
 CYUT1cZjOtFyQ7YGWIYX0k7N8+4AraGiE8ceJsF87oaejPdQH2olmGQh9bWBD4UnL9+i
 s25vSCZSBZvryzXtY9a89EHaZV/Q16pPsGvc/xtc5TO+6NKsjU4ssv5pwHQdaQMjJrJC
 Wp7ZrUn4MWIckHpG3L8TQV7qeHR7fTrZV3XX9bjKkf+wGTZ4qQCTHj+oxKRgD/PLD6OB
 Wt/47YqslsYP1LGr1hzeVbL9Dl/HTPgDu4kkcJxStRlRVVI2AS7fTtv2+/SF4fu41TY4
 iuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506726; x=1741111526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOxUDeB+TfG2CY+nV8lII4WevwTqc826MHvYAYe0tck=;
 b=OZ+N3T8VFkrsh3NJfOgArJUNfXPKEQPps97AqbBFORJ9YFOO8aSXs1GwStomqLJ5J7
 apwzy+JmxjLWWz9vkMJ40I+z4jq9FBYJOtSxPYGkrusX4EwnSOemCNvFLxHIWfRRe1xC
 pqEmbENra5mSoH70qTp568aNthCUE/FYrg4iDBnDHBKDlUW57cAcSeZyWV3uGFuyFpoI
 awMtFIo7ld3ICm+eAddQlvdcj7qdGGWzOf10/Xb2Yxv/3WcIsjaSBADA39l36ZQNy6R7
 tLNifkDnNDc8i9CUTuPoc2CZKPmNkoQfyU/7LqvGVKVXO0S0vw0yF7UB7wsZiqGpBejG
 yHQQ==
X-Gm-Message-State: AOJu0Yxcv5SF/NpxYJV+WmuXuWkl1ZF5C24zCx7Uom3Nhq7YIadAzu7+
 zCup5yLpZAbpPJy8yAjFeQFTlU9AY1DalJvntD9omy1VTv+tIqPcwuLevY7AB8SpWTC1W+LQrcO
 t
X-Gm-Gg: ASbGncvgYf4NVysE+6GpWHUuegs+gdcjTzNOnkHy3gH5cknb3Vcq8ZlKI1lNibakOTv
 0XhoQrRl9JLbniSQY1GwQmARnPkwnDSbN6+NGOtRqS05Xz90Y1XagEvKxW7kL971vqyQ/KXBkzm
 af77itjgYF/QC2XzpsmoqBfD7PJgWFN+EUwyiteNQwS74dYcaODTeTHF1lhNbl3e0mRR90GR4iS
 DByqIzmZwW+D1CzPfBwkefIgLCPoBdnyu36EKUNGFJuRA+ntIUg4cO+thk2JBAFU6NcZ6+n+P/t
 DkMv/Dnm1L6Vee934oflOaaigYIWhmCV
X-Google-Smtp-Source: AGHT+IFh7VH9DwdKZmShGQAXycRPGLR+GxXpKcjR7E43Cz+TKBag3pVAALHwTzKRExMXLWcZZKeRmw==
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43ab8fd1f46mr4755695e9.4.1740506725738; 
 Tue, 25 Feb 2025 10:05:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/43] target/i386: Avoid using floatx80_infinity global const
Date: Tue, 25 Feb 2025 18:04:37 +0000
Message-ID: <20250225180510.1318207-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The global const floatx80_infinity is (unlike all the other
float*_infinity values) target-specific, because whether the explicit
Integer bit is set or not varies between m68k and i386.  We want to
be able to compile softfloat once for multiple targets, so we can't
continue to use a single global whose value needs to be different
between targets.

Replace the direct uses of floatx80_infinity in target/i386 with
calls to the new floatx80_default_inf() function. Note that because
we can ask the function for either a negative or positive infinity,
we don't need to change the sign of a positive infinity via
floatx80_chs() for the negative-Inf case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250224111524.1101196-4-peter.maydell@linaro.org
Message-id: 20250217125055.160887-4-peter.maydell@linaro.org
---
 target/i386/tcg/fpu_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f112c6c6737..741af09f908 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1832,7 +1832,7 @@ void helper_fxtract(CPUX86State *env)
     } else if (floatx80_is_infinity(ST0)) {
         fpush(env);
         ST0 = ST1;
-        ST1 = floatx80_infinity;
+        ST1 = floatx80_default_inf(0, &env->fp_status);
     } else {
         int expdif;
 
@@ -2358,9 +2358,8 @@ void helper_fscale(CPUX86State *env)
                 float_raise(float_flag_invalid, &env->fp_status);
                 ST0 = floatx80_default_nan(&env->fp_status);
             } else {
-                ST0 = (floatx80_is_neg(ST0) ?
-                       floatx80_chs(floatx80_infinity) :
-                       floatx80_infinity);
+                ST0 = floatx80_default_inf(floatx80_is_neg(ST0),
+                                           &env->fp_status);
             }
         }
     } else {
-- 
2.43.0


