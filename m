Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46522C021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWRM-0005qK-MF; Mon, 24 Feb 2025 06:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR7-0005oE-0p
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR5-0001A7-91
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:44 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4399deda4bfso28555415e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395739; x=1741000539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/xq2A3p4R19qNhPGzZgnSRkmfAVMySHI9mTT7PkVAQ=;
 b=onBsQBQi2ckBFDTEBg3Vvxbc48MOr/v1HRLrUfww/uU6mJ4QV6vlM4y28keB2UlALC
 ftRV4GTyuLIvIEWB5ZIQOdEUe2R4Gof8Eb3TOSeQmvE1/OCoYekWLJ0dZUXgsxwXwrv4
 7IgZMAfnJwehdxT46G7ZD+0iU6G8l1iPR7yB3vcouaX0Qhv9LwRAi2RAmajp1rcDyBu8
 VIHlIelYQryqG9Vc9hbVL4el0DJmUwb9PORsWIczkIbAVPyavBpBC6qGrynSbmm6HcJ3
 MD3eLYy9o8EW9MxioFhrgMQLWAa5adb8KVb6Z7oZaatS7k+cwiu+ZdnSajcN34dN1DSN
 HXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395739; x=1741000539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/xq2A3p4R19qNhPGzZgnSRkmfAVMySHI9mTT7PkVAQ=;
 b=Dt+VvWI+Oht1cd34FCscfSFuT69FNsiebDQETmnGk9Oq9JBd0Hcz9ZNJI54ucLbjwx
 wgQuTDDEoVzOXepqJZXiOkfcU3vL+ersHDNR/DhO19WAKt1ML+BdT7mgTyt5eVLc9XMl
 P/rWpC5tIFFrA+BgGFfbwwiWM9NjF2h4HCd1SZQ6eA1FxVuBNRNSXvGUAU4n61/OxMCM
 qcgfbBI2QHLL3cL8BA5uc7T/Kru9DTg5flbm3+xuRXJCaJz0wLEeTSJLiDcFq3BqQr1f
 SQCMzrrXnefB8Xo7WI68NVpqE9toSKJjRK9J/3bXzyKpv7clKYyxHgJWMSPq2X/MVYbP
 t4AQ==
X-Gm-Message-State: AOJu0YwSpE4E0qQvcBKvoa6DauiPVJSgjglgpUKFP7jDBsuMUXCmHYwF
 H2N6Q329Gewiv+7M3GqTSLvd4H5yHrBs+zw9dOf0UgVzeuady7Z39vpWED0pjhP0hdYH+eoFedg
 F
X-Gm-Gg: ASbGncub6aQ2+EnDGvfK77cLQNYwOuFgY7G2Q4jOgWmS+Oz1XJxoMiQnaHk2VEObcvl
 W/uVL6mLjYwzcadeWydT50hmT/0FdCZ/zirgIJ0RbhGnUKDpZk5mu57gTcFoEWxDf4LKZtHx9RE
 2/0cbCXTcjCdB8Jws326F1kSSaTllFPc8W/3wfS+vdLgIJvTUa3AOw7Trvz3Dvxx9kg/N0S1UIw
 TJcqRYbO7DOtEIN0VbEVL+3hJlD0IxRcWZvWb5e45UBwYFXfzca1rBr6XNqMUw7cnVZ1XBs4LBb
 vaxkEpalT/z+P1VU2nfx6k5rSmLBDPdP
X-Google-Smtp-Source: AGHT+IErOKIMxJ7z8Prhwwcxg/G6mO/1mbw/q3xeCK5+GWToGSyXHyYG113tntOqe2KVodehdeY5KQ==
X-Received: by 2002:a05:600c:1c83:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-439ae21ce20mr83506775e9.24.1740395739490; 
 Mon, 24 Feb 2025 03:15:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/12] fpu: Don't compile-time disable hardfloat for PPC
 targets
Date: Mon, 24 Feb 2025 11:15:23 +0000
Message-ID: <20250224111524.1101196-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

We happen to know that for the PPC target the FP status flags (and in
particular float_flag_inexact) will always be cleared before a
floating point operation, and so can_use_fpu() will always return
false.  So we speed things up a little by forcing QEMU_NO_HARDFLOAT
to true on that target.

We would like to build softfloat once for all targets; that means
removing target-specific ifdefs.  Remove the check for TARGET_PPC;
this won't change behaviour because can_use_fpu() will see that
float_flag_inexact is clear and take the softfloat path anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250217125055.160887-10-peter.maydell@linaro.org
---
 fpu/softfloat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b299cfaf860..b38eea8d879 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,11 +220,9 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
  * the use of hardfloat, since hardfloat relies on the inexact flag being
  * already set.
  */
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)
 # if defined(__FAST_MATH__)
 #  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
     IEEE implementation
-# endif
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else
-- 
2.43.0


