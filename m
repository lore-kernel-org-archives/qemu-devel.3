Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AA4CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kbZ-0005gB-T9; Thu, 25 Sep 2025 07:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1kbX-0005fN-Dq
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:57:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1kbO-0003Sp-3K
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:57:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46cb53c5900so9862705e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758801446; x=1759406246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Sg4d6Xi4dn19c1xIRc0y4T4UNJGPBwgkBfHHYUi4ds=;
 b=gVpTvTTZE6LALtau23assPD3qukSD7XRokiR5GqRWN4eo95NOc0rryrjsjN0i77rSF
 7ZV0yrjm5Oy8he7v1dCFUiaSnH3MseyD8HisSbzXLU6s4CUABiN/E3oNb3AHr0/sYxsr
 wmQM2dqAJw9TQvgBLaJp2TFQUZrW4yNqeHmPELl7IOcLxBX1vauj5H9s6PGPIXgffgxc
 x43sY3q1ONI6+dfsTayebvxhITYdXrSZj0T9KDLDeoTMQcFlHObR+d9zXHHtw4YdeNL+
 2RcgI1no30Bc5Y2sDM4kBKOIlguQtRR8UcLQhFzEXy62+H8db9881AdebG9iR622rWDa
 zmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758801446; x=1759406246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Sg4d6Xi4dn19c1xIRc0y4T4UNJGPBwgkBfHHYUi4ds=;
 b=GV6pMnBfqp5Uy3Ro2AomH1N+PqBC4SNwMOEWvm05d7zv1sYbmGekX5wPynJxTVyu2y
 cBhb0TK6esbRJ5NDRI9T2dj55kfDKdiTv73sBK3caL7BEz9ckBp+EAflaAx2P2wXSjxj
 lT66alx4Y85LkAO8ncL99iT/HQUUDz5X8Jo4PoTMuodBFM/JY4+nLwR2+3uK7VTok9so
 7oWh4f8/IT3P9+aUVnWu+UkiulxLOFgjHTM04CRIo0TP9a1CdZgorMSQeTSjxREaeHar
 pDUCCE07ptPDoKysVLfmwRVeDQ9Beag7t6Jkw9ZxR8nuzXA0VGLANeMdTWCFynMTYVdW
 IarA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ9A657fXGmIP72kbUSix/4Bn9a6srKMgSRt9KqV4/vaMcofIZ8Y4kFJlFmvqdRiIdrq0FFOA3Wac9@nongnu.org
X-Gm-Message-State: AOJu0YxzMJpfTexou97DsTJm1LUKQcNU63rbp/fGIbyXGh9jMyCWgvLz
 sleN9ASvXnAipIx5WHLtVaR1dkymNH9TzMnhYmpMSrFF0C5p5nvxs7Uo3ViHuqGz2s4=
X-Gm-Gg: ASbGncsi5gKNfsucH9vlaCQolqiUrysAuUBBWe+/575vFrJ/Gb6tGx0YoZwCzssgHo1
 aMzea0vRrHceOGw5eabFeB6H5KOEkGgSdQL1pYBwKoxI5cgi6jnZbVLS48iSgHlfUBlCY2wBEcw
 cVRhOnRYzmiJd/hlTl5ntikBB1oOTEdNVu9twkH5hh++QPDUqEXx5ThIX4qOESdRLULTmuniS7X
 oJ7IOqQ57mg+nwyH+iw86vGgYBME14EjgFlRxNQETcZR9bYSUp9OZXNzG+iOwRwHOY/lZcDlFm7
 t0bN6pK9Q+Y+kWZhz47LmzmIcHL7H8SM9E4HfnAYqsE9fvlf7nSpMjRrcf9S0fImBZBlCqCkvyh
 4tHLVBcbEp5nMDabWuYndTMRu8EXA
X-Google-Smtp-Source: AGHT+IHvtrbtZH3UVf49CcEc89QNmXANmu1l0FtXAqaXFeQlriuvg/UzLYzVItzm1rU+Ksk7mVv98Q==
X-Received: by 2002:a05:600c:848f:b0:46e:2d8a:d1a1 with SMTP id
 5b1f17b1804b1-46e329b2d10mr37726465e9.10.1758801446115; 
 Thu, 25 Sep 2025 04:57:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33fede76sm28392215e9.14.2025.09.25.04.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 04:57:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Don't set HCR.RW for AArch32 only CPUs
Date: Thu, 25 Sep 2025 12:57:23 +0100
Message-ID: <20250925115723.1293233-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

In commit 39ec3fc0301 we fixed a bug where we were not implementing
HCR_EL2.RW as RAO/WI for CPUs where EL1 doesn't support AArch32.
However, we got the condition wrong, so we now set this bit even on
CPUs which have no AArch64 support at all.  This is wrong because the
AArch32 HCR register defines this bit as RES0.

Correct the condition we use for forcing HCR_RW to be set.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3128
Fixes: 39ec3fc0301 ("target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c44294711f8..ba1f7296dd0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3695,7 +3695,8 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     value &= valid_mask;
 
     /* RW is RAO/WI if EL1 is AArch64 only */
-    if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
+    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+        !cpu_isar_feature(aa64_aa32_el1, cpu)) {
         value |= HCR_RW;
     }
 
-- 
2.43.0


