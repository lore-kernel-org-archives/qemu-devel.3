Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75183CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4I-0002Kx-GS; Thu, 25 Sep 2025 20:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4F-0002K9-FU
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3x-0005Et-T9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2570bf6058aso22809315ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845502; x=1759450302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxjHHRJTw3hUZ1UsocmE5vCuaQ9siO6rI5yfDT7Lfcs=;
 b=LumKvdg7w+HUfzGqZL9wQIzlZsOOfbDgch1OBfAK0ng3asuFrXGgEJAfkVl4maFKDX
 4/3+PuBEEq2YHguIgACxvRiz2CY+1EW/MOMqEoglCp9flSGRauiyyDdoklojQTS70mOx
 mipxaRIjTCl+Bjz9ry1nUSP25KGfbSP2ljAD0OyIIRmQihI+DwRjiNp81f9Nj0rEH5Mb
 riSuuVN/2DFTz7wAivRFh26GirSFnbcIC8uLofThLRzj1ANDT1obCnuqc7Ha2iR3KFq6
 PU5HlrtAKUdGE+SJIqlZdophq4vlxTbRkh21B1ybSQFN+Eg54rcYTlZTm0KSYTXPRrRR
 GOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845502; x=1759450302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxjHHRJTw3hUZ1UsocmE5vCuaQ9siO6rI5yfDT7Lfcs=;
 b=oOkBF/4lSnxG+HWJ7ziJoBcZd5zvO8OI0mLxNFBIDV7ETI50i5ZQ4aLVrtunThlfov
 BSpNV/B+1A2PjItblLo4eHNs7WDglpuUyO/DpxAjz3jdbl4PwwUIYd7fgT6zlVya3Per
 ub9iXmoMcC6fhG6OG11zlU9sQz0HOsXA5324gR6PKwT2k7caV5rhX4wyFN7qlOKAvJ5B
 POOV2HJaaKf8xFqkoyjkbLSpG68YstoC4XfB4dxfooBYpkcxWat0zA5QG3fMF6Z84utW
 SAENOMirfHfmxru865XXPqumuYRwMCqa5tG3vsb6XzTRBu63NR4aB1VtZaYhbT03i6zQ
 6SEQ==
X-Gm-Message-State: AOJu0YwmqYTLzG+uIkuRN4QUPTAd10vdjJ+g99O0y1Ehig2mWRTjSMdr
 YXWL9eIPF6wazK/Wxj6ZYQ0dsExy4ScSTHVtnX2ZTZARPjjsZBGYhIXImjzxyqwPFO9WeLQEPDD
 hiGHN
X-Gm-Gg: ASbGnctJ2o23BGFR7ODC+tOQW5Q08iCucEuAs3moFc7UZJzlhHbpqZnW3+cw/bDoqP4
 J+TYNFQmkcoNK4JHxfYBeqm50gZT8NiSclcRHgS0wwnZw+q5mo2oNvgprAUrYUE++DkyJRl8K59
 wVy0SIz2+11FpxoUtLdSNlSf2dmNQL40YO2LaydCO0CuFP8N/Sw4wtnFWc6/mz0OVJybubjIawt
 Mfkxq8qqLjcwjbvy69GuI+79hV6yhB2sYxaMbaO3g9gE4PZBaUE0Ph30jquN8LaCmmyGgMzTcI8
 /M8a5UZ/FFnKYaEOxjt752kDb23vqFwiJ7hr4r1U8NFw8FAA1F9nqBuanRG+ZHOTlbErYK9vBJB
 VA0yf9yAZxEA84/qDcvO3LELj1S/zykXK23HoTCE=
X-Google-Smtp-Source: AGHT+IH8hWdSKitCkNzygpMbIA57pTpyDi3inMnTs1Upq/5V8hoVThD7ZRkaBq1nRsBMz2d/992+Hw==
X-Received: by 2002:a17:903:22cb:b0:269:8f2e:e38 with SMTP id
 d9443c01a7336-27ed49b9a40mr61514725ad.6.1758845502387; 
 Thu, 25 Sep 2025 17:11:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/10] target/arm: Implement APPSAA
Date: Thu, 25 Sep 2025 17:11:33 -0700
Message-ID: <20250926001134.295547-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

This bit allows all spaces to access memory above PPS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 236c3a9569..e03657f309 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -408,9 +408,10 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
      * GPC Priority 3: Secure, Realm or Root address exceeds PPS.
      * R_CPDSB: A NonSecure physical address input exceeding PPS
      * does not experience any fault.
+     * R_PBPSH: Other address spaces have fault suppressed by APPSAA.
      */
     if (paddress & ~pps_mask) {
-        if (pspace == ARMSS_NonSecure) {
+        if (pspace == ARMSS_NonSecure || FIELD_EX64(gpccr, GPCCR, APPSAA)) {
             return true;
         }
         goto fault_fail;
-- 
2.43.0


