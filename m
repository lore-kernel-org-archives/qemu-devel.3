Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BEBC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYa-00041G-HL; Fri, 24 Jan 2025 11:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMY7-0003ag-Ic
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMXz-0005Lv-P0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:47 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so24601625e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736122; x=1738340922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PuY6MWGhC3e5y5qwwUhsJwJ57vpQ+lSQf4tubMQ4Og4=;
 b=ZdpMs7wyNJwDFzy+2Mz+2SB1M3zfBODocyjyOJnrxbuwqsoham171a6h+2hctU8HPg
 eTrvpAIl1JktsOLPq3hj5B9DD+WPApYXG0wmQVp538HmCbU+DAShmc4k+mOvWPDtESUp
 XU8TLOPxIxx0V3jq5Hq1mhp4HsBetnQwFdu03Fy4dOcb5JdFd+6X/6tVGb0ybLYsFZSt
 MbY78l+KpCm863EwcphMSbuDQqz6KsoO5wOBeFzkZGk7LYyf1+XDn/7YsMQF4zjh6Gth
 L7US7JjQZTlWBE/DSTbV0pGXwFIK5qrMLTzHA9/qB0G9+vRtBXGukrm5jOnPKRArxUYH
 nfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736122; x=1738340922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PuY6MWGhC3e5y5qwwUhsJwJ57vpQ+lSQf4tubMQ4Og4=;
 b=nfRPp/0WMXrxY/tL0voCnIfTaCmkEd7FW+1h5D0+Obbhtc1UZvSoSixA8ksij3PAgU
 6B77bTgLEI4DnCKEHr/9caKrsuyY4sGo1PeAiXLw6r6oJud8jvY4XZFSqmSJY7Yd6o/0
 rJW4icBDzk7iUezSj4L7SNYL2xqBPFN38ylQkhgkHvcGEsXW1PQVD4TG06LZ2TeoYbsN
 SukRejVXSqiv5Adiyez0Se8/LThiCf3NBu8XG6f8wMG50vcJWbvRL9CGLX26xZ5BdY73
 uH3ZHLK9U/tC1/797NwjdGqsdIGIzg+9O37yzzJH+eT59lxfv5gxh8V2GQFQbipu2Fvk
 +qKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCVPzidgiFJXFNh8+NciZ1q4kswIhlPfmagI9lKzLpiPBCSfFWNqQGpbqsk3jhBmPrXZu17H+6+9uG@nongnu.org
X-Gm-Message-State: AOJu0YzUU1dNf1aE9NVJQlb6FumPcM7Fxysd4MW92jTUloMjQKW5Rh5h
 bjnrwRFd3xL3HAmYNP0l+4DPzbimRa8erjOYihFiYnQeE2AfSBJsQGM5AJ8oLA8wo2/JLXbr/M9
 f
X-Gm-Gg: ASbGncu7PyV8fMKNqV3k4sAk/+kTSA0niWgLyMypRWec6XnaMCr8TzsCZFMPllvXe1R
 jG2YU70qP9qebftZ0uqhuy8cbZD4mVy0ilH4l+0rmDpqTi0Tga3nIioinfHh1WTjp6pJl610mgU
 Gf0HUZYQ3yVV5o243w4PawLIwTbYF7Z72Ng3rM9/OIcbqg4RUTo0cTuM2tb2v2CmwKFpkloGG+7
 OM+slDBIHEMeWvvBS/crgqWo28GPaUNutcPOw73jhssCZYO/qj8t5eN4QtxpFvOBDftk1b/2xw9
 jH0E1IiCCHg=
X-Google-Smtp-Source: AGHT+IG7rFMA6iHr+eE8Tazka0VeW8tL7SIsnTANWo93WMdCLRGKiofx9UD3QhjC3nPyMeFYg1Xkjw==
X-Received: by 2002:a05:600c:1913:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-43891453fa7mr312500675e9.29.1737736122162; 
 Fri, 24 Jan 2025 08:28:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/76] target/arm: arm_reset_sve_state() should set FPSR,
 not FPCR
Date: Fri, 24 Jan 2025 16:27:23 +0000
Message-Id: <20250124162836.2332150-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The pseudocode ResetSVEState() does:
    FPSR = ZeroExtend(0x0800009f<31:0>, 64);
but QEMU's arm_reset_sve_state() called vfp_set_fpcr() by accident.

Before the advent of FEAT_AFP, this was only setting a collection of
RES0 bits, which vfp_set_fpsr() would then ignore, so the only effect
was that we didn't actually set the FPSR the way we are supposed to
do.  Once FEAT_AFP is implemented, setting the bottom bits of FPSR
will change the floating point behaviour.

Call vfp_set_fpsr(), as we ought to.

(Note for stable backports: commit 7f2a01e7368f9 moved this function
from sme_helper.c to helper.c, but it had the same bug before the
move too.)

Cc: qemu-stable@nongnu.org
Fixes: f84734b87461 ("target/arm: Implement SMSTART, SMSTOP")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 63997678513..40bdfc851a5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6413,7 +6413,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
-    vfp_set_fpcr(env, 0x0800009f);
+    vfp_set_fpsr(env, 0x0800009f);
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.34.1


