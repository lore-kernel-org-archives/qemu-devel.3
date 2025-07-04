Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB504C83F0D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDw-0008Cz-2O; Fri, 04 Jul 2025 12:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDu-00089k-6I
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDo-0005s1-3m
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453643020bdso8239985e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646306; x=1752251106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=McuRTgqg5skS78YfFhw3GYQuhK9WPEG6vpPWpuJBgv4=;
 b=Y/5EN2WRFNpCEHd6DAKnAt2JD6vSpUDY3y8lbiOJ/Ox7ukqWn7Jz1yy0sYubgwgtct
 i8Jk+OUvdjgxme/mN1/iNmqqIpWIxmLIMMIc9iO/XO8v09icU9//4DM88ijDuwzsRQSk
 QlXeCHAqPgaeJLJ6IaKA5ZFbiZV4uKLX08za3Wo2Fhl3tZclMgODs3zp535WRbHg4P6L
 V5ctHoefLF4QljlGzcb47479Ncx+zuR4rVt0q6WXag46EPudedbWnSIuLlhKqkILWKVB
 zsAQcdYtcag/pWJZNIJePXupiy0kvACXNu51a+S8FMZk6xGe13AmMOorKLkff6Hsjy7Q
 6eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646306; x=1752251106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McuRTgqg5skS78YfFhw3GYQuhK9WPEG6vpPWpuJBgv4=;
 b=f5rD8HgUu6Ae856S/cc4Ln/Md552A0X2fmOTDdO5eqgO3C0aj/ChsAY/SGsf5SYxqI
 pXmj/nGYfKJpXr7F/nFH+dLIsKx8IdLiFeMk3MRkvh9nh5p/paPoFBoo+jWNORMnrlte
 DF0mpy80f6BQHGclahleAWYtF0KENoG5+3vU4HipTwyx+qyQ7dbA/F61ygD4olcTo+db
 P3FoeksFGtNabwMAvUD62r8COB4pUbiKZ2pgODOC+VQ6zFvZY63WF30x1qXkosWWGThh
 PhyMhj5UQWw7wUMAjfFPXcs4ZPL7dRvVNaFwAMJNYnPHGAk0q+UKCmfpOJBQolgh9SwE
 rWvg==
X-Gm-Message-State: AOJu0YzYjuup+cRUfDXwdsOj7NIpiR192lM+D0ey2Y5i8j63Mniiz9ph
 lnRjvm/rZ4n88OqOnp4aqaHcSzlVRwmM4Drt8bwkB9OYs5mB1g8ugwn5M0SQP/0E81E37D/byg3
 JeTQa
X-Gm-Gg: ASbGnctgFky+Xs9DV6IjWiV35L1F5Sa9Zy6KJnCVieahHYXzDFgcI8K90T/lu5MwCLF
 ty1TdNRGAuGIc1Ixa4ATtR1CZjDfpyJI6BX8YN8VhioL9en2Al+mOa9caQtpKKL7VAVhaUxUp+Q
 HOIUUjAhnUfieroA6wPBw4U7FGaShibvUKEq758FKonssMC3iChiS1IJwmMpkJWwRZ6sTuMRoDP
 ISn1X1l3hcwyLnBACw4QKjXuDNFYj0Blf5a+c/B4TupUYlUNERXObsimMb2hz173fpaK6zRSavo
 vMeaAZFkfI1bJOosOAwPbSzZXrlyYA5pac+epDMeRkkGHR2UD0chIP96eR18yMfnwH2L
X-Google-Smtp-Source: AGHT+IGS+Q159v9BHrddpqEbHczGaL/CU7cydj47YeKw1tmqWr5TRCeLtjccIbNimgYWy2Y1O/r2qw==
X-Received: by 2002:a05:600c:3151:b0:450:c210:a01b with SMTP id
 5b1f17b1804b1-454b3161c16mr39633685e9.17.1751646306290; 
 Fri, 04 Jul 2025 09:25:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 003/119] target/arm: Fix BLXNS helper store alignment checks
Date: Fri,  4 Jul 2025 17:23:03 +0100
Message-ID: <20250704162501.249138-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the store operations (when stacking the
return pc and psr) in the BLXNS instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-3-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 251e12edf9c..f342d934896 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -632,8 +632,11 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     }
 
     /* Note that these stores can throw exceptions on MPU faults */
-    cpu_stl_data_ra(env, sp, nextinst, GETPC());
-    cpu_stl_data_ra(env, sp + 4, saved_psr, GETPC());
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
+    cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
+    cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
 
     env->regs[13] = sp;
     env->regs[14] = 0xfeffffff;
-- 
2.43.0


