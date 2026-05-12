Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A5CCD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjZy-0008JZ-Vu; Tue, 12 May 2026 05:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZw-0008IS-2d
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZt-0004nS-6r
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso2860560f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778578739; x=1779183539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2x1gTXoUQl7esPZgHPEC5mc0dO4FVec/dPz764aIyC0=;
 b=lpEhRVBLsSgidoY92X0KgDsSA+bhZ7SOsxknDzRrQHdVRqQq3ivBDWG/OiCFQMNWeI
 AJkrrwenR2AZQc+/tNxRt3cNcaiKNoAe5EoFx6V8109n3dNMnyWrUy+WiOWyh2ZrJ+4k
 GEgG2fuecJsaSc0kPulLOhy7kIOBlfMIwmso3P/1A+l3URtB6CIfQMjYrpv3pbxXyHE5
 MBt3K2dUeT4zAF96K6TZnvkkeQT493F1kcpHeRbt2Pn3OSLYGxPH7vGiuUWDAC2NkHT5
 iIEHf2pySPXmASSxilpTINU/nGXkZ5p2W7GEDJwSPPCWQnaVWNH6qYrzrVfYx5cdA6TQ
 SJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578739; x=1779183539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2x1gTXoUQl7esPZgHPEC5mc0dO4FVec/dPz764aIyC0=;
 b=YeGJRY32x5XEN/S8XyFJu8vmhMsBa0sUi6mV9CYS/7G3xDH66q6nU1SzqLWcPg9XjZ
 VX7EvNhp2NPizTzzo8JaoBj3ge8+ebHuCu3sPgMN9dw65Uci4ld7jefNQRwbd0obi+bp
 E4pp7SzkhbvycJzmsDGskfOotqbwmAG7eN/y5Yx4BC3C27bt7BhGVD0FaBdoDXJQwtYv
 84peVeh8Hc9TTvG7NgpLVsHWWSkvIBVn2oFk1Kk1whl6qPJEG8LH9/f5KNM3ZtCcnVZV
 OH8KUPod8DHIyEHAyBP+z5vJbFZluMU4FNnDbhqXW9yX5/ihMxvKmyVQ6Ys9XyEeDa4y
 xPjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/ryzSBLR9kEUme9h+26wFXQl/gyRxuqnB/R37ZNXQKr5SXObNmLtpwP+RuUH43ZE4aSVO6jY989Li@nongnu.org
X-Gm-Message-State: AOJu0YwTH9OJNf0YAHWoGExuK7Qozy+/CDRpwpv37BfYCnY+5tX5K60F
 DovyoVdEAbl2j4GMdJ43az2i1e/1iT9SuZLq5NS7mLGzR3hL8kNXId1+OV5vHBMwGlA=
X-Gm-Gg: Acq92OH+PIJpnFzcBSX/TBBZIZTAaGZOU9ll4FWKXaeizoSIhOHWkR7WK1M4rGf535h
 4aG4S2ziW7QtsWNUcIFPkgT+l0u/MR/whxH+Aj0qIA41drCT7yWlqJEJ6PupyVRyP+FKDEd3r1j
 9qNPNfROvDl7FgXN2N5X6D2UiAYoh/750h4KJwxXhOJ3TJFpDS1GqKOW8AMl2tXPVm/2HYwGNLj
 iZt5peVl54ScU5bnWjnBEZSGqD2sFIxlB5HNY1ZZCI9xRbYsH5OT0wocELxTWCIhHo7vjM4lYC6
 S5oVWwHCvzGGhKPdDQ0nTloobSpthoQHlkX0rugFW3SHfQ876iyi7CQ6kTeEPbQ68o7ChCovEtC
 gTMPuxLqESyf+n0MPFtcy9vXs3iflg1wsyPIuB4hFs6ehkk5z5Qw3dSo+XoRbAO8uONZ5qmyCTm
 1NB9yE2ekXp8KH5NxEzyVNm/8uT+TEwYVNT7qY1P/Sb3Jfmr3sCPFdUEzBKPNQ1Xal+h6wyr8TH
 2WGqGipNH8oPCBEMHr1m55f+lVntFY=
X-Received: by 2002:a05:6000:1acc:b0:43d:7883:87ce with SMTP id
 ffacd0b85a97d-45b1441c919mr3176486f8f.34.1778578739359; 
 Tue, 12 May 2026 02:38:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a6a64sm32805208f8f.6.2026.05.12.02.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:38:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/arm: GICv5 cpuif: Fix overflow in left shift
Date: Tue, 12 May 2026 10:38:53 +0100
Message-ID: <20260512093856.3197700-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512093856.3197700-1-peter.maydell@linaro.org>
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


