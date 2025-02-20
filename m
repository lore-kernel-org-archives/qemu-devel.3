Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5389EC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J2-0006lX-JI; Thu, 20 Feb 2025 11:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J1-0006lK-Di
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iz-0008CC-Jb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4398e839cd4so13816285e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068500; x=1740673300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=en7uT4OZ0rV3VwFePcT/YjVIp6yux4AOL9OQy8j+qKg=;
 b=xpmFCaoi1ist+gQ4E1eOs2M85JgwIxLsng2BhUmABvqJFOepYShIn5SwTfgtAc6PMY
 hv3VLKy0xYrtKH3dawM0NHQN9endglXSWMuiExsVfmhMF+l6A9wcgo8p7L9Eh34GRBHB
 QCCF5vOFNSKDssy2n6d2CqGnkyoSzarVc9gyIiQwKU2j6aL2P6OBTlFaI24GUX+o8iuO
 G5MxcaWoigluOjgxesd27LDWBRscxJ2pHvt/ZDBlEFP8KGUpRVuu13cBUIxN88slNu+f
 HaTN/7TTbNNS01XlI9xHedagVz3BNsD/MMhn4CsQZzSFZoOFJZoVYjBpLVM02/7iDe41
 Q32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068500; x=1740673300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en7uT4OZ0rV3VwFePcT/YjVIp6yux4AOL9OQy8j+qKg=;
 b=aU9lafPSEk9y8a2L8/t+PLZp3nSVICDbotVMrXxrSTK6UQqoGwzaQ/BxJQ6RR80+ll
 PoyccyZcPm1egC/9TrOa3he2OdT5y/Gxl+Hyocinm3CDHH2L5er4dDEWrrEbxtgEUXP5
 B3zECQ7YNAE9BXQTdxSvXKf32gUiSFFRThVAM2z2kd/O0dv/tgTTkdedddbXQi2t36ma
 b0e1P+28n4IS0jGRoPwhBkVvy/7MGduj8Xk7LnyZjrjdiEzIXMjo67MvX/vCGsxXHA3G
 63lcs7ctwuvm0lLyYvMvrR2I/LuV0c6PyMftDuiqdZLdZ7WetGG41Emnh5mrAyfhX1pt
 Lyvg==
X-Gm-Message-State: AOJu0YzfOtphZ6fRaDVlK2cEVg7jPoMwz5p2yT1WsPfJqfF8zro1fG8m
 B9v+RTEvBBXRV/0OFl9bHsU2abpAuBOUsaquJRvMX8dd4/WcC8t1ndKQTv6mLwUZGpU/oxM0pD9
 c
X-Gm-Gg: ASbGncstxvqUl9qoHgsmzRmHAnJ/hIbTDobBhmfy4UXageyOPEncTmPHtzZjq4dlybC
 QMjZEJcim43R9Ya5pThJDAANbibItBf9XF7LjUKvMvBdH7nquv1ETIo2/NvaGBv8gaP5S6tQgUb
 Wk8o6aI0+mfINbLMcfWQ5ABx4Z9cvHAlbEYsATQETP5qoWakSS6JXhr+OuEOhCkxtZyVMo1eouR
 9aFmATMU8pI503Ae7KI4kZ75gZjUUyF+0XMU0v3/7tophxGtu836DYT2h7zTWXJYXdqnbtWlbUB
 MWS2lwCkWCwV5DHnThbm6w==
X-Google-Smtp-Source: AGHT+IEu9Ygj1OiFBu4xDpljXaTYJ9S1ZeVx6Mf79PAhioKW78SmYnwCc+9LteYb64+z6Q9LHuqBkQ==
X-Received: by 2002:a05:600c:4f93:b0:439:86c4:a8d7 with SMTP id
 5b1f17b1804b1-439a2fb6f92mr32038965e9.5.1740068499990; 
 Thu, 20 Feb 2025 08:21:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR traps
Date: Thu, 20 Feb 2025 16:20:52 +0000
Message-ID: <20250220162123.626941-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

On XScale CPUs, there is no EL2 or AArch64, so no syndrome register.
These traps are just UNDEFs in the traditional AArch32 sense, so
CP_ACCESS_TRAP_UNCATEGORIZED is more accurate than CP_ACCESS_TRAP.
This has no visible behavioural change, because the guest doesn't
have a way to see the syndrome value we generate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-12-peter.maydell@linaro.org
---
 target/arm/tcg/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c427118655d..c69d2ac643f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -764,7 +764,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
     if (arm_feature(env, ARM_FEATURE_XSCALE) && ri->cp < 14
         && extract32(env->cp15.c15_cpar, ri->cp, 1) == 0) {
-        res = CP_ACCESS_TRAP;
+        res = CP_ACCESS_TRAP_UNCATEGORIZED;
         goto fail;
     }
 
-- 
2.43.0


