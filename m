Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A217CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX26U-0001MX-Nu; Tue, 09 Jun 2026 15:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21q-0003YK-Aa
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21h-00040A-7A
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:23 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c85a2c012e5so2125072a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032875; x=1781637675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1USoF+ld0og+49mB5GQHpfwuEC2KNiIk/lt+yiqX4XM=;
 b=vFAha7YMDjNELUDFQgvam83IDu//DmzFBWfh/MmIENlHfC35iSKtgdFtJqJ9r4nDoU
 W/phREN5qdqrCLFSqgVcmxfbXTHaH568b4Vukqq+iSeG6W7yBf1JBzcau6VJj5kPUsq+
 WVGfx3uIwm7+BW8+g//1S1/cX0oUae1q4lGCchIFGQnuaJO+MDsWexdm3qIqaJ9H+ERX
 rAu99NfJN3360xauSRGuUtq04xhobRyQYNc8MLB5k0cQ6ayOxDoVSWPjewXpHIRQWWAp
 0n4MxEdEBTdvKyymVAmvHEZo5jZBM4U+CIMfRy0zAh5G4tHw3Dug2+9NoVFQ2f/2bQEQ
 bAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032875; x=1781637675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1USoF+ld0og+49mB5GQHpfwuEC2KNiIk/lt+yiqX4XM=;
 b=PlUvom8qYlee6xJ5hSNQ1Eq214GpTUoBfrOk+XO5uwMJcFEpznRsRWAprxwjLdsHVV
 zmiUPaCMCpHZtDx0T468FfAdWz40pxwxQ3FWqy16zF9I/ELoE4ooW6Yue11qpXTSYBow
 E+ig5PbWrWLiVOYIacNJ2QrHGrXR7phqBy+DfJ/f3uIW5YGNAIsCKQC+aYNsERjzajnz
 KkjxCfcWIb+UXAUhZP4O/7I65zKfTHz6/fu1KjCTWmeQIi64U8riaYfN/5C82K55gV+I
 UzjQqacDyN2haRadpp7XWqCHaWcLHAbZgK9tgqLkf4J0+HgYl0+LejbTwIcJWXZQn2Ta
 1Jww==
X-Gm-Message-State: AOJu0YwH0Ktnoi/xhZBydpbb1kjd3FaJUILJ97X0hdPzGrRtDI/WFTDR
 AMkdTg7AJ+I476VN2OXSRB3/qfHUGnMWKCWdnaCHrMFygFgt++iKiuP9iuuO9BmgynLamJBao+5
 TeWR302k=
X-Gm-Gg: Acq92OGx2dQqMsrGCeXiAnJ2WEx2VYxEjfLNT3ckuT61q/xTxFVmIQMyXm8sQZyszH7
 MwtSuyvKewOSKpuzYR+3fKG8btHLHbvRJ7mCTwFjjwwezUtsOCv4bI93hOb1qXyHIjQKBsZm74C
 Fz7NWRJ0coKAwTh+Rwk6xlxEzGjURHJW4H61JWIcZgKauCoaWiSoilmSAnSKArE81oqVj2cV4W0
 yG/hN3JaSfUhI3oGlt7NGnY3wI3NprFVV+8ZCk5O7i6edlRYYd+WVCDDt5EZfaZom9k8eh5ZHmQ
 q5aVgtdos+VP5llW2PwqZ/Z+yrNmLiC5bL/1ynrhxrJKDjmJbSE6nz7gc4ghwYo3/nGU+GGo4tL
 SVMFVTouUste8DfDUkdBrLe1DbVtv30imLHM5onvC9gm9VFyS0OOIpFNy0hfL0NPiSJvS9m91aV
 mFzwO2C64+qqwdRLTV/MYt+0HK7s/i0x9S+aZaUmM=
X-Received: by 2002:a17:903:987:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2c2a1be668cmr50234615ad.16.1781032875550; 
 Tue, 09 Jun 2026 12:21:15 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 06/45] target/arm: Set e4m3_nan_is_snan
Date: Tue,  9 Jun 2026 12:20:30 -0700
Message-ID: <20260609192110.752384-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

The unique e4m3 nan encoding is SNaN for Arm.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b75c6a6622..77133b8b4a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -308,6 +308,7 @@ static void arm_init_fp_status(float_status *s)
 {
     memset(s, 0, sizeof(*s));
     arm_set_default_fp_behaviours(s);
+    set_float_e4m3_nan_is_snan(true, s);
     /* We want 0 for all other settings. */
 }
 
-- 
2.43.0


