Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935AEE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5D-00079L-By; Sun, 08 Dec 2024 17:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ59-000788-LN
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:55 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ58-0006DJ-2E
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:55 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f29e2e756bso246354eaf.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698133; x=1734302933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V0186xH70riO7Fn9lXQ499lIB9ZSqDTvKf2GBot8Cs=;
 b=h0SaTVpiQTkUcj6T2neyk+dcjkjmH0n9jxjzCZnbBqGI3/NWwVHxg3+JIizeOkAqYw
 FQiilBBZd0KHtpgCGJSTkfM+fk9blHj9jxolhsMT+o3pKe6yRe4UqMAS11GJyvdJ8nIy
 4uhcIxLOyjNtJIHXgAq0kKYPpqFgi7D9xSixEJxRQhnM20gvd/k6CWCasoq15WM+XUr7
 VqdS82FF+4HgVKGMFGPePz1E5NYpZmbmS+POfjOUggFGEDs0IMmjfy4GlQ+TFr4rbbnn
 C+Da3cMyLcIls2ISDLzJUvxYbZsF7RoQnNvx4c/LQw9Ne/5UKkVl5HsDDsQFnM/W+buj
 Gdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698133; x=1734302933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V0186xH70riO7Fn9lXQ499lIB9ZSqDTvKf2GBot8Cs=;
 b=ojr5/3BF2Dzfcy1u4TgN0jpLef5IdQwsXxJFPncV3b+ZNaDc4qrcJ3zuECVBA39wdC
 I7ztlJmESoQPOSls1kylxHIqs1fwkb0+BavY1+XsMc4H45L264JGKuw8dWIc17tx9zGm
 XgbYzJaCFfPAHqV+Q9ysfvfLABZOpV8pYWmoLaLWnJPiN2CWIEozqhMRv7RP6Ckgc8IQ
 rkdUiAi7879MXjvq/pVVVbMEJx6XDNNvzoSnOuSd9ujX4K3mbZM8SuinB50xR10bSEHS
 A02+BCMltHgtAiJGEE/pkokozK6LCIn6UD+HxBPoPmifhZY0mEexQhrggJ8m+2bFmAJJ
 0ZOg==
X-Gm-Message-State: AOJu0YwZXTkGID4vY4SDWI+v1YwwTwYGnvWwAV3ZctLlo7S7kTOCIvmZ
 +fljAsmJoRsrLNF+qnSL9sxX8bKRB2PFcGhkL+alMxV98bHz5J2AFkf6u4Taef4B6bLdJue9BkJ
 ixX+wKw==
X-Gm-Gg: ASbGncsIX1icSTGc4txMIcxTNUfpyyrAd0DJ95AlSYHQ8awHdA5bPJK6sXi6wUxtvtO
 K03WAGy6PF2s3UcaCZqJp0h+nwW5UdVY+2n3AB5VmnieAHjOufaipfAna1pS9w6h/VelrcoTZwj
 UJmLJyxNsK+COqtyb0BK2DtgEdnlEgoxYR0sqhikKf/gPvmi9/V2KGnXBq0TfHHbH757IUjfQp3
 gD2seGdHl43j+7jPuOPGVrOo6b6XIWrILyz8nyg3qMx+aN5p0VLWofBK+5uCIfOXEAXFyC1TbW9
 zFySA53xuee0IEse6PHrnsqujVvmmI2bqMvc
X-Google-Smtp-Source: AGHT+IHaMk+xh0LW+ojBEr5HAMS0YY/8kOmsTFBDQ5Ywoy8HuUjmROIkoobOgRaLNZZ9TaZ/TpoCLA==
X-Received: by 2002:a05:6820:1614:b0:5ee:d925:d6a4 with SMTP id
 006d021491bc7-5f28700e87cmr6880348eaf.3.1733698133017; 
 Sun, 08 Dec 2024 14:48:53 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 05/17] softfloat: Add float_round_nearest_even_max
Date: Sun,  8 Dec 2024 16:48:32 -0600
Message-ID: <20241208224844.570491-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

This rounding mode is used by Hexagon.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h | 2 ++
 fpu/softfloat-parts.c.inc     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8f39691dfd..c6429665ce 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -138,6 +138,8 @@ typedef enum __attribute__((__packed__)) {
     float_round_to_odd       = 5,
     /* Not an IEEE rounding mode: round to closest odd, overflow to inf */
     float_round_to_odd_inf   = 6,
+    /* Not an IEEE rounding mode: round to nearest even, overflow to max */
+    float_round_nearest_even_max = 7,
 } FloatRoundMode;
 
 /*
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5b5969725b..2b6adeef4c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -155,6 +155,9 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     int exp, flags = 0;
 
     switch (s->float_rounding_mode) {
+    case float_round_nearest_even_max:
+        overflow_norm = true;
+        /* fall through */
     case float_round_nearest_even:
         if (N > 64 && frac_lsb == 0) {
             inc = ((p->frac_hi & 1) || (p->frac_lo & round_mask) != frac_lsbm1
-- 
2.43.0


