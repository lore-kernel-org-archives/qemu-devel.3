Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7725410F996C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXhc-0000zA-Pc; Wed, 08 Apr 2026 14:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAXhH-0000Sx-Ur
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAHnI-0006Ys-CC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:33:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so30553985ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775612002; x=1776216802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAhS4MlZiUixeL5RoVk+cyKrBGfLpW045m/lFXD5jrg=;
 b=tV5OZ+l8A+p8T6BSUeeN22cD6OzurUz/xRfs+WSODX260JkqTgP6OTZrjR+NzeR/K1
 zkmZznuUdmvM8BKJ1X2zjgMiobYi9/mDiqm0cu70bLNHgbGrcWl7weGKX4KH6/if3rUt
 7VZf9HhBrAK8LuvX5I28rkNCSFS7kGd9BfZGWUTZ1hjhiC9hxGJVI2MgezpRWXmZVUcN
 pTg/ueoCXxv1ZsOVzSVs4qQ6o0M0X3KMxvp/VMSlAaP2iakq2Y5MtXUoSnZlWzdfI4Ho
 gq91RTV6HLc/fkFmJTQ55XKqF9hzMh0rEhe1nrGQbsCDHqybzFeU6p1sJbsyhcIu6th0
 pvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775612002; x=1776216802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iAhS4MlZiUixeL5RoVk+cyKrBGfLpW045m/lFXD5jrg=;
 b=ETpq/0llz6/ytQjUnb6N4me0PHqIcmebQ/AgkHzTMf/UG349bonjN9Lw4nlNyz5Uxd
 WIt1/zAs9wgdkb1QTiATUqLy9HG5ZFwG+HFEJvrJeozZnGqDCc+wKKs09kkbLZYPjtsJ
 rHR7b5M14KLu71EuQZUt8HpRX6p96wiykcTcbJlz1kMVndsh7LdooG2wMZEZFookMuuo
 wwQ12N2ASXYVEHEhuZ/WOZF8LP4YTrr8ppK09AOIIXh4nUj073F2wM3M0UKQB1HUlv7e
 o8PLIJi7k5Un5gb52xyI0QRE0rvojmAHkPOk8g8KsNvn0RZ9OFryIx0UYHnHbhI8Xcw3
 VXGw==
X-Gm-Message-State: AOJu0YzIfXN7oSP1IRdk2xVGvPoPnQYJZ1QoPlkmTgANWWNpT0PUzW/8
 170efS5L7yZe+Pgu0peRZ6uoXw8uqjd5m/dz/+Y+qeXReNBuJde1kEHIe1r1y0LtkyxXnbGbwAB
 mABYCfaU=
X-Gm-Gg: AeBDietEhs1hY68q+cL2y9Xc5adwEI9Dw163LgaO6fVe5hbZ4RDaFCT3zQX6+MzkqSK
 F31+LrJdbvZ2TJnmEUK17IXu6mk0+rbuquy0wK8Q+7XAZ5tcIpCHWSYC2cO3KKrG/Boh5mhmR91
 SSzxi2DWn5G6LgwZTuAFBj3gwwxLTfwjnk5R1GTL7CJ+lkJfMBz65nXx4FY9mYLEbCG3uk8n9gl
 rjl35RYJ9mwUIqPnX8VZ8wfMHJzkISPJNrCVtarcEGpLcDhshX/U/1rWdHTWx/rKixfIqetHMX9
 oFudtAn9OGVACzD/aTbcvMXvkNOwDU19lFsNYI76u4JT6z8iEb4TyoMvIypIvSEMIqF5XM9mnzA
 RhzpZ9zuTyqf8qIxisgahr6S7COCD2kCHLI+k2ADEr7rS2iXGYkE3daVcMOYuZRTE+Ck6iRZeRW
 xDpRqGHmSNnV5QFe2aTQ+obj3rGbmnyT+Y5JAU9qG38GFswKd6fw+dsybA
X-Received: by 2002:a17:903:3886:b0:2b0:c45a:bc2 with SMTP id
 d9443c01a7336-2b2816bd61fmr216591655ad.16.1775612001972; 
 Tue, 07 Apr 2026 18:33:21 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm238277395ad.0.2026.04.07.18.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 18:33:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 2/2] target/arm: Remove bswap_code
Date: Wed,  8 Apr 2026 11:33:09 +1000
Message-ID: <20260408013309.56122-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408013309.56122-1-richard.henderson@linaro.org>
References: <20260408013309.56122-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This function is no loner used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..917e9919e8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2568,22 +2568,6 @@ static inline int sme_vq(CPUARMState *env)
     return EX_TBFLAG_A64(env->hflags, SVL) + 1;
 }
 
-static inline bool bswap_code(bool sctlr_b)
-{
-#ifdef CONFIG_USER_ONLY
-    /* BE8 (SCTLR.B = 0, TARGET_BIG_ENDIAN = 1) is mixed endian.
-     * The invalid combination SCTLR.B=1/CPSR.E=1/TARGET_BIG_ENDIAN=0
-     * would also end up as a mixed-endian mode with BE code, LE data.
-     */
-    return TARGET_BIG_ENDIAN ^ sctlr_b;
-#else
-    /* All code access in ARM is little endian, and there are no loaders
-     * doing swaps that need to be reversed
-     */
-    return 0;
-#endif
-}
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
-- 
2.43.0


