Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECBECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7L-0000em-NC; Fri, 15 May 2026 06:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7C-0000c4-TW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7B-0001EN-C9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso58665475e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842195; x=1779446995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y4CnK/qfjf+jShgaVtl00CoGtL7EKPqfSzGBHgGf5sg=;
 b=p+GU+96HHNlBxCQSCOdZX0P5GD06Oiu3w1mB7F+hGCZxa7UyAI7qK3gLztmKS/VfKk
 86A1LDvoJfMTG7ramyBT8ZMCBePkCecc1zDMLSD+AFw4bDQT3CvbsIWrJgyT+4Vu3sfj
 3LkYqFHdUs4tdwSzCfjxDLg+XxW946mEAWELqWpqSUUSsI2W6i8/vNEs/3N5rb+9/MW8
 +tgxZVB+wziCzIlz5Y0OpbLUFaKtHghYDYY1GVog50JsteWX5NJwdTTMtP63M2HKmkl7
 5Ikhi3gJ2bZqSYpDtMPHGxfAoMmVvr6+1r0Hp/wvYqoP3QcCpv8edgIVon34c74dkgLG
 LJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842195; x=1779446995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y4CnK/qfjf+jShgaVtl00CoGtL7EKPqfSzGBHgGf5sg=;
 b=jLSrU6AR0tZ2/DUTILKO1IUE57CL85bhn+HjvIAG1IyNJx+uP/9cFjP1LUAuNN+ZpJ
 hRIDHeCJzi/QjEJHiv/sb+p6xP3VojFTFjdMdxiVdRRKT7P9YQBxBDF7r6HQlFbtrr2d
 hQ7z4Vo0ZQBY6dO3I0ij7b2fa/I6HYhucmrGUFhUDfj9yx0lvY1CWzkLskWPC0NEFtm6
 ddX0md8QBuUtnpx2wIjgC30CRjelVdozmbV+JQg77Hy3FWRTT2Nyvt8OZ3Oi9P6wqQ/x
 W++v9Y+kZ+kbrtll4FAZ09ayIfGb7Bd7D2ujqDhu/xR6ZZUInk0iiElVWHB+RyADmmXT
 3/DA==
X-Gm-Message-State: AOJu0YwjCDe/ajjhvLFfUqrYDiGyaZUMSFFwY3y9t3vrucsZ8Eb/yLal
 Buv43FXtpdpzo7Z8Ib4ntj4ymtSYFspsbpQI6HHavahaysGL+s2vTSgWLUwWC4UNxVr4Kfo166w
 MXqEN
X-Gm-Gg: Acq92OHQYzJ9m110F76HGSLwkeRdkMUv9qcvgvnTri3GMb24HyqL6EvyfY86PVs5n+N
 fwKuJEN/MlVjpmS4ap3GpaV1K+q72+mf42twvUCmHXT5B+ZHotao8la1tNWLGypfLnRLv1w2sJT
 UpIHT3Zop3vdQeCy3AYfIXaIjnLYb9R+hM+cLkIj1EJ7M6T04y/E+6B3DQrIOxNVYhCSR3svP6T
 aJK4WjCOF/r+Wb+aJGvi25b3zYDNlIni7I/Am9cZA2syMn+GjJakum3P/CXsuy2SBQ8Ck6Sfvzv
 1u1Q52RxBeqGplTR11vF6CVofVx9VWKVKFiNGAOnDGh71RA7Fb7Dnby/XQexyT5nCipMyoh6bka
 RaZKcm+YZzw8UWX+nglELJ0miSlLEpek6M46VETQSWr58qfPlJSIgJFn3Z4KJPgDKkAQB0XFg2t
 TMDCtUBod0H4y8QQT7uP9RkIy49aGg/qJIr6vUyiHfnpoZfPSYcxtH2IX3docyGcRog5XYNv98z
 9X+I6HZz20cd1eoa/I/PVIMEkZ5m71TNS0PbFpjqg==
X-Received: by 2002:a05:600c:a417:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48fe65168a7mr40065315e9.25.1778842195620; 
 Fri, 15 May 2026 03:49:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] target/arm: GICv5 cpuif: Fix overflow in left shift
Date: Fri, 15 May 2026 11:49:29 +0100
Message-ID: <20260515104945.4145203-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Coverity points out that we forgot the "ULL" suffix when shifting 1
right by a bitcount in various places, so for bit counts above 31 we
end up shifting off the end of the word.  Fix the three problems
Coverity noticed and one more of the same kind that it didn't.

CID: 1659588, 1659591, 1659559
Fixes: ce245ac6957 ("target/arm: GICv5 cpuif: Calculate the highest priority PPI")
Fixes: 3f79212abae ("target/arm: GICv5 cpuif: Implement GICR CDIA command")
Fixes: 49f4c98648c ("target/arm: GICv5 cpuif: Implement GIC CDDI")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260512093856.3197700-2-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index bc44a7fc11..98238ada19 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -275,7 +275,7 @@ static void gic_recalc_ppi_hppi(CPUARMState *env)
             int ppi;
             int bit = ctz64(en_pend_nact);
 
-            en_pend_nact &= ~(1 << bit);
+            en_pend_nact &= ~(1ULL << bit);
 
             ppi = i * 64 + bit;
             prio = extract64(env->gicv5_cpuif.ppi_priority[ppi / 8],
@@ -631,7 +631,7 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
      * gicv5_activate() cause a re-evaluation of HPPIs they use the
      * right (new) running priority.
      */
-    env->gicv5_cpuif.icc_apr[domain] |= (1 << hppi.prio);
+    env->gicv5_cpuif.icc_apr[domain] |= (1ULL << hppi.prio);
     switch (type) {
     case GICV5_PPI:
     {
@@ -639,7 +639,7 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
         assert(id < GICV5_NUM_PPIS);
         ppireg = id / 64;
-        ppibit = 1 << (id % 64);
+        ppibit = 1ULL << (id % 64);
 
         env->gicv5_cpuif.ppi_active[ppireg] |= ppibit;
         if (!(env->gicv5_cpuif.ppi_hm[ppireg] & ppibit)) {
@@ -707,7 +707,7 @@ static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
         }
 
         ppireg = id / 64;
-        ppibit = 1 << (id % 64);
+        ppibit = 1ULL << (id % 64);
 
         env->gicv5_cpuif.ppi_active[ppireg] &= ~ppibit;
         gic_recalc_ppi_hppi(env);
-- 
2.43.0


