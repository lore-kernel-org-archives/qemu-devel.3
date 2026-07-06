Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggie-0007DD-Tn; Mon, 06 Jul 2026 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiJ-00071G-3e
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiH-0003Hh-9T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493b691cb44so19838245e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334288; x=1783939088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NrrPXpQHnc6Y4zWwDDuOjNrSPtslvAcCIqaUGcEI2EU=;
 b=kEe2GIU36NNEv+Pu6zm2M4zZqQKCi5lAKMQqFCL/qL6ejP9rxQISbvUVBdaLJQaLah
 OWoqHRjIFVjZxEw0tZ0MdVHNgF6QCse+7/XIL46YMe5ibznupIwOpPWDBVgpGbJS+Buh
 Nr4+jYZISeKDvsYRJ0dH2BVspfK/tHr3oJydcAn9QEivYGE5qfmi8YtNvBoDVTO7vCC8
 YHULl/mFkiFkxi4FagEEu+S7wUT/goy6CaRG81DZ1rKV5sNSJEByZkTxOaayZK4I987a
 AhTApYSfFJ0IOdQnq3e9iAstyDZWX2M99XxPsJpAssI3HvggN5yn5omn5/l53Al98Ema
 3Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334288; x=1783939088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NrrPXpQHnc6Y4zWwDDuOjNrSPtslvAcCIqaUGcEI2EU=;
 b=Wad81rI/IAyaxASdU/e9tK7vi1DN9/tYf0THz00GSBeWUKb+6dXrhz77rMtUEx/WoM
 kPo/2bzpgmOaCRBrsQUoC1p8BE/zi+mNEE2E5yljbMk9D+sIRVh2KaYMoYD25MEGaczw
 B0M48JIzo8B/LOvMmtCPV15JyDnVBxuAISksDja5TIPIfu/75Ub5y1lDy+kAEezzSqX9
 1Y9gU0HEsXYTR3pbQbg1QP7S3HNx4zTEZkO/EG3khZpQXHIiZ3u5DphON4hpU04TuOzI
 4K4/dHcZqrG8ITzr2HOsqijJ7kUxlztMg1LWnlzi2KIMMHfknXZQ0v6DTZ/7VRCVJogf
 6HvA==
X-Gm-Message-State: AOJu0YyinneZFa7fch/Bl+CtcVmMRHx3zGd/t+A2aYKzFg0CWEHxqWPq
 Y3CZsmNCFFXBRb5ZCOErW13bnH7FKMFsCro8nclBRY52h1fMpyGrizcBJ7wi6WSRWRWlgGpwp1k
 mZSSsppskkw==
X-Gm-Gg: AfdE7cmOTStL1j75MVPW45cj0s1zsJnk6sAk5wi9c53bZwAU6kQQ1g6nNQZoDzsvMWj
 Hy65GzgWIn9gORAc94DW0+JOskaWZ5KlG/KeW79/GFCkdO8gYu388lwY1Zz+jMoyL4Vxy88R/xH
 +rZZUC+CPS8D5g39wQIz6ckZH5ERH3coAS8zqFOPAYdeeK3qcKDcoAspQw9M+7aHwbqLUDHJ+/6
 ZxM2xihsiA6UIUTBTOMHzmNes1IU8HHH7+nApFqzWkVuaK0WWyFNbiOxhSfGawKar8uGeFoseCd
 IjKJMyap40KNHlbBI2CzZZe/06VDjy5krEmO4ujsbBjUAhXdJlygf6BE4QPu01qRFzNtXOZnOUn
 e1DIu+pnLHjnKN3mp19PgFaoyYuNuA6taVjzfU/tr/Hh0Q6OnaKXKJlOvqNTHCsb5ASoUtKrkxG
 IhprHM0KFrdxKeIMk9NEQloBRHlyF8YqpucoMI8qUwm5Y+RIrzZKXhAB0SgNzqJUCDBVYULwfLI
 KoGZ3ucGmJzkeSx2P2Kl/euhxy0miXf
X-Received: by 2002:a05:600c:63c3:b0:493:bc4a:fb56 with SMTP id
 5b1f17b1804b1-493d1203ee0mr85270445e9.39.1783334287648; 
 Mon, 06 Jul 2026 03:38:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/49] target/arm: ensure we create the wxft_timer for all modes
Date: Mon,  6 Jul 2026 11:37:17 +0100
Message-ID: <20260706103752.320511-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We don't want to just use it for timeouts as we will calculate which
will comes first. Remove the wxft feature test in favour of the
broader architecture checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260624103049.884930-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 +++++-
 target/arm/cpu.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 26bd21aa86..7143118708 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2273,7 +2273,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
+    /*
+     * We use the wfxt_timer for timeouts and event stream so we
+     * enable from V6K up. There is no event stream on M-profile.
+     */
+    if (tcg_enabled() && arm_feature(env, ARM_FEATURE_V6K)) {
         cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                        arm_wfxt_timer_cb, cpu);
     }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 84d33e87dc..03a30afcbe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -967,7 +967,7 @@ struct ArchCPU {
      * pmu_op_finish() - it does not need other handling during migration
      */
     QEMUTimer *pmu_timer;
-    /* Timer used for WFxT timeouts */
+    /* Timer used for WFxT timeouts OR event stream events */
     QEMUTimer *wfxt_timer;
 
     /* GPIO outputs for generic timer */
-- 
2.43.0


