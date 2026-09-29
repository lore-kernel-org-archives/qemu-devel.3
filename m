Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EF0CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfG-0007bJ-FJ; Tue, 29 Sep 2026 06:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfD-0007Wn-2j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:19 -0400
Received: from mail-ej2-x0e.google.com ([2a00:1450:4864:34::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfB-0008EI-1N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:18 -0400
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2bf3cc16baso381077266b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676135; x=1791280935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyMP4Wg/N8/4DMM0YLzH4qlYHmshLLG5W4qdXGDdncE=;
 b=O+m/KOHW1zsPSAZLLLqpmgDzukEcg6LDInKQAqfa1sWOrsIAk1qneX2jKA8pYe0v2Y
 RYjEuzR99jTFPoq319eN2LihFqE1jaqJXb4caiDC+BiSGafsAIq9yEEXAzntaWrcU8G/
 +hCZIqTD1xBhBdvV83tY0+r1xQNlCFr8yhZPE0VDqRNvtSRG0xSjZB9vRBE+VpIP48RK
 mmkOpEI7Y/phhfoH25/P12ofetB2G7TabyTVYSDSRRuCrFNA+RtNw6jUb4tWgSNFu6v0
 FEeR6BinQHEM37R8EpkGDu8FiXMgTrmEujf4ur2BzEpEzBvf4RKDu7EyZW8Rx8Fmb0j4
 jPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676135; x=1791280935;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZyMP4Wg/N8/4DMM0YLzH4qlYHmshLLG5W4qdXGDdncE=;
 b=MgmMFSTVrJOKxxmSbFKoxm8/XdrPW5BjqP9Hra3q3xyF0bq7rjOZCKO97b45exf5N9
 3Ax6XjFacGnYpW44U+CyrBdcQPRzPMwUqFei9ScUM6fHoPjNFvp9ENMs5stesXBL2erN
 Qm0ZK8nAQc+QBWNhlJBKVQ3uReq5nxUUDndf72MGcW7JxHDqxm5yCeRclh4E9e+M/a6O
 YHtFYZcA7K99uIGmcapGZyIaukBFAR0b+oR+V3VMmaobYSK7PEh2c4ndP/3B1sRz04lM
 6GjOLzOdVNjLjfOj2QaXm8x8GJWfPEpW+sQW1MnfOsVOJqB/7qZNLvHVkobxtBoSs7wc
 rUwg==
X-Gm-Message-State: AFuF++lDXwdYK6PQFtVNLzyCu0dYLjnRGW8F6G/xOmr1/gZ2TNDQHm/S
 6noIwjYVgeYpLJK2ZTL8NI7n8VXurDGma+ik5db1tZiKzGRDnDuQit0cnQn1n8Poi23IlfIGPgY
 VfWI6
X-Gm-Gg: AYBFou1AcQZRc1pIaW3iYnBrkOQkrdLDwcbUYppo+TMvgvpDl1NsYwQ5iLknxReBPzU
 CpPppWOolmX8My1L2hMVB4ptbGW4XLnz3y95LI2zN6mjsqa+4xwMwwofXCeS838yRZQPUR93F7o
 lMsuufMSJjVYJ6TFA3YoRMjK64sWQhNGGFhflyQm/fnK8Hf6IsVS+lw2fSjl9b4mAi0uIv3iSqJ
 d1VlcLciXD2GKXGIpsQLgyu7Xu7w4HgaPtDOivr5d43+YAk+AHY0SziKWJdYnkPVYcNBeQ3rpOA
 RWzMadtOuye2EpRggtf3zVNL2stMNL3KqXxHlSuPORkFV5icNRsTtNGXw6Cs3kSCoF2GmP+5RMk
 bXY9Kc+KEzObl8bInJmxzC7mULnBYqCadNhoQ6bYVvznhUqUghk1g4xem3nqSQNZH/pjNtzYNpE
 tfvob5J4/wdbF7MndTiRc8xuMkB/wTYIrKNcfMdMNsdXSkdQlDLsEbDhgJpxqjJBAOhM+rY+2BE
 B3+EHtxAQ3w5AQGR7VNc1d72Jfb45ABVPZoOd5HB+VKoqzEUVPLSWr/0fbCKe5ug3aYpWm2gn6y
 JUmY0K4593bZPg==
X-Received: by 2002:a17:907:a088:b0:c2d:fa4d:6640 with SMTP id
 a640c23a62f3a-c2dfa4d7909mr95929666b.44.1790676135094; 
 Tue, 29 Sep 2026 03:02:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/37] target/arm: Sort BE_DATA toward the top of
 rebuild_hflags_a64
Date: Tue, 29 Sep 2026 11:01:20 +0100
Message-ID: <20260929100133.2598676-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

This is the last of the "ANY" class of flags.  Sort to the top
with the other "ANY" flags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8da02ae1ecf..cf7d49be908 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -412,6 +412,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
+    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
+        DP_TBFLAG_ANY(flags, BE_DATA, 1);
+    }
+
     /* Get control bits for tagged addresses.  */
     tcr = regime_tcr(env, mmu_idx);
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
@@ -475,10 +479,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
-    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
-        DP_TBFLAG_ANY(flags, BE_DATA, 1);
-    }
-
     if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
         /*
          * In order to save space in flags, we record only whether
-- 
2.43.0


