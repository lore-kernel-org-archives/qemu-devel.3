Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823D5E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSw-00024H-CW; Wed, 11 Dec 2024 11:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSc-00017Y-5r
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:15 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSZ-0007rK-Te
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a766b475so66350645e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934070; x=1734538870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XpM+Fzv5WnqhGSvzHLutaRhswGeDxDx6i0Qnjz1mXt8=;
 b=PnNTz+YeLienfdHbuvWPM5mftwXfTWbwfo6jOyHx5L+88ZToN0ci6RKfdoC0vLbXpi
 nH7ObMZ3zdp2m3YiTBYVRWml7nFGXRmTjO37lR7z/VxGNZuAwNup39LhYMbPTCGceAeE
 yr02uqQbGr+6Wtfje1zkG4t3oJbSYvXBkPmC8RX9FNAHlIrEAMGSVQUu5dHe3SFDjb5R
 wDMFdRydveZcMV2pG5iIrt8LFiF5IbRpb8VL/Pi3NnjTev5N6upmS5VGCLkCWNXTi2oP
 7RRs3hbbD3Tv6VdFrNjBRQ2MUrEXCW9m81QzVjkDsyu1VIjUJ9SsTh6GQ2GLUKQZyHkx
 1SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934070; x=1734538870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpM+Fzv5WnqhGSvzHLutaRhswGeDxDx6i0Qnjz1mXt8=;
 b=X52QdD/ptpvhtRTMM/rrRQQgUHX9a9oNfeLXPkolYQAZuNBYOx7FreFfSr4NBh9kpS
 fNvkxzoM9+WXLR3l+FmZfePWyOCkTpo3nmKgR3abjL4jBFm7ffABc+8yI1g6DXDcYpnz
 hJ5Zpa3aNsQMbmmMnfTHHXGgK48tsNrY6e8IGwUGpQ93eNnEIBY8i9bEt/tkRAcMD0I/
 aGgdqZmFnTSog67/L3j1M65wKR86ioQ0i5cVd4mFm0kW/mQMkSSa3AmLfXPoTmv2VS9p
 TPN3KfEcaAkaUmtVeYkF/rCKgd2HpZExWyqd22ahJbt4+aEvHkuHxfDf14zdQ+Qtb0D0
 O0uQ==
X-Gm-Message-State: AOJu0YwR9iwbAO+E+0McTJ6+aNDd9DIwunfKiuDBZHcvxe7utwfxkZTv
 LUzw/7Unxtunin7zOIqtuZv1dZQMRd5VIMrc4lFsL7QtxibX0DmhIHJBbG3jFTq+WdOOXSZtzS7
 w
X-Gm-Gg: ASbGncsQqm+W/RHvwXzIb8HSM8r1vp95eHkm7zcajNstyDrfjeLJJgHo0HODuv5TG8V
 DQEXgAQXafptBSLofKJeowctUmGg99BCu7gy9bP9se6fIqOOxQ047PUBf58uWE+oa30YYwNGqjQ
 YPbeQ7DwtGsi/EqLwYjF3Nymk8umG7kj8zGzNWFR6MjtVunSpiQSX6/Q0GacmV+KIIXo/MCZu3H
 Cx5RtTB6HlRiR/H0aqafx/hHjJeW88sUOBfXTREz192Eo125xgnVmkqM3La
X-Google-Smtp-Source: AGHT+IG6jpYoL8nXZRFPcUDg27VSevSz8bvaJZWXLGwW9xicghk3Ie+thgAXNUNmhA1grjsjd7DDrQ==
X-Received: by 2002:a05:600c:1d20:b0:434:edcf:7461 with SMTP id
 5b1f17b1804b1-4361c42c97fmr31285685e9.30.1733934070547; 
 Wed, 11 Dec 2024 08:21:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/72] target/xtensa: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:48 +0000
Message-Id: <20241211162004.2795499-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Set the default NaN pattern explicitly for xtensa.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-51-peter.maydell@linaro.org
---
 target/xtensa/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 3163b758235..0d4d79b58b4 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -136,6 +136,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_no_signaling_nans(!dfpu, &env->fp_status);
+    /* Default NaN value: sign bit clear, set frac msb */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
     xtensa_use_first_nan(env, !dfpu);
 }
 
-- 
2.34.1


