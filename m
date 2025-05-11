Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43C5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOy-0002qe-GY; Sun, 11 May 2025 16:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOv-0002dX-T5
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOu-0006Ks-2v
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so49971115ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995754; x=1747600554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk4EjQefaC29HViyknRVvmNGslUguEBFOQzXT/8c2wA=;
 b=f2u/68wdvkgnNKYyXRGD5KH1kdIe9VcyzRm3k9JJe4yAIkgi9fqBw4wkaoWee+8Ota
 5h1KRqfGbJ6SsPPrIbvI5VkHodXv0AJZrUui3CjYa0aTMamHyUS9Aj/oIuugKca4cwRS
 BxRP/utGPbCwYC5qc3TDWZhF9B5hfpSdDkEO1bG3aJWbhtIOfuIhfzHdWIUFZio059Qz
 V6DrfwC9SYCYiAMnHx4jnxt8ljFN1jDSfSHbwc9rKPiCQ9QVOTCwBlIskwCwUEFrCExK
 XbqE7qg5JOXxyX4TaLx9DMmLfzTGC9KKr89nJIp74nNUFGXSkiWW4AdcT8pb3u0TFqSV
 Gvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995754; x=1747600554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jk4EjQefaC29HViyknRVvmNGslUguEBFOQzXT/8c2wA=;
 b=H4fmx5LNJRB1gYnr5XL9fRuyTR8QBtSEI6+t2MkURySWIo34HBJDKuNvs8Ez8DKAxz
 jQvpFCRZDlu/rmC0iHv9lLStNW7O/6PpM5JLuu1modJlKW/BbRQDN9kkMYODeaD4TFGY
 6K3ZvhDUDkC2JAIK3oIZ/dEvVJPMtFHkM19kkgGmgBPsvU1w9E2dH61/tEUmMVB5ce4A
 bLkeNGkhG8Rw7TzNJS1mHX46boFpLHDWT11Wp+Auk42j8GQLWM64iSAvmF9GEiVkdQ2X
 E4UoWMJPrCRIGZ2/nhvQbPyHxeMBlmIKbqiNcMVy1yGZ2Dz+iEmXQGiHpLq8hDfLPyX8
 UdhA==
X-Gm-Message-State: AOJu0Ywy56T5nAc2lFAcpOy71ubPb9WJQL2DR3XM7lukWvoWmobPALk/
 4xbpN0hFlI2Emz80WvylTkpMtntKj5Lu3/FnLgkUtaWasft/3VPrpSibeX3/xqW8WSXAJRvZHtN
 j
X-Gm-Gg: ASbGncupA5ECRvr8nFNtP8LKJkLMkpySRFggBtmYu9m4eIQxhHVJta3G7SZybhS+Kxt
 veNU5HNh6KFn9hos0+6rTXm5EVInLvIJy4s+rtbynyc6gPMV5sUMJHkBqtyihcRyqvM2U/SWPtu
 ZY8HsvGsfcCp7aYMnok9G9Vy+FW4a2wFxvcjzwZ+3VsS+SX4wkqgruFwFI7w0CO/WozC4kKvB+b
 m2geaqQIzlZzuJ8haK0fL+E5CUakUAp396DY1+5luYPnK0SppEXxnHS4lq8Sfxs7ElxBytCyvoa
 ZvuMgkGjYC/8WSBea6fxFv6QXb1zNKKS1kyT0kO1UDJRVUIeb8A2re+01AHj89jwDcdyP65xwSS
 6f8U8Mq667Q==
X-Google-Smtp-Source: AGHT+IHbZYEls01FOEBAyHgDzuKukBMGTonDQtuCq5T+5aoAwsmH9nh5Ssxj6ULPtd1zzUAvZupE3g==
X-Received: by 2002:a17:903:2311:b0:21a:7e04:7021 with SMTP id
 d9443c01a7336-22fc93ef210mr149446695ad.24.1746995754055; 
 Sun, 11 May 2025 13:35:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 08/24] target/m68k: Use g_assert_not_reached in
 gen_lea_mode and gen_ea_mode
Date: Sun, 11 May 2025 13:35:30 -0700
Message-ID: <20250511203546.139788-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The mode argument is extracted from 3 bits, and all cases are covered.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index b9633e06da..f87eff3b10 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -768,8 +768,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         tcg_gen_movi_i32(tmp, offset);
         return tmp;
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
@@ -893,8 +892,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             return NULL_QREG;
         }
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv_ptr gen_fp_ptr(int freg)
-- 
2.43.0


