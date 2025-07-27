Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B7C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufvx2-0001mJ-61; Sun, 27 Jul 2025 03:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvwy-0001XV-Tb
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvws-0000Qf-Nk
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24003ed822cso1859615ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753601853; x=1754206653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoDX6hlPhJpbPYJEoHdtEuOKXRrXAq3oOs7MkhVvpa0=;
 b=Gae6/77axf6tNMsVZqrB2uC6X9OK0V7s8G03K3muaTgNMgvKBVpZ8ARoP4W7pwL020
 yzZDWtyEdgw8DqjxgD7KGR1oqYzE4Xww6XjE9mRAftlF95j6IvUhtP3HeWQnfkc4JhgL
 aTCqa1aK6KQ+7xRz2wSwiXeYuLYLBL/Cw3LiPyCdDtExxeH7zvZFih7Nw+LfSddSZfBQ
 1vSuSQL3MXzQ+tzsFhplIc0WDoshxvqaVmZppZBLTOUFPSU/NTSlt6k2Uq1HdCZqw0xJ
 gUEH7ycNVfHuFeRrsFWsfYTVVuyo5sIv8OTUmm4B6l51GHPPLp4zaVcIilFf4lEMVqNq
 OG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753601853; x=1754206653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoDX6hlPhJpbPYJEoHdtEuOKXRrXAq3oOs7MkhVvpa0=;
 b=LXHiD6x0gfF9u7bwV1J/aGPB9hiT1Rqm/c69rtPoP9eVBEhS3OFGe+o5tcqLFjfMVa
 GnLDIHP0hjSzeQxBCL23KAnaokA7PDH6u6F8B32jKBi/D0IPm6oTmp/IDRSbhaUHA1H4
 o2VEfyHx/Xxap+hCft6do1dCcq5succP2KwBAOU4PjOkfBDFGMdZdP3C0mNNDlNGW/1t
 eMbIpcs5tEw52YEq1ynhswBvDx6bbhlmr2iupz+d3bUTdzAaAu42pdDzkSqtFW6GcJAB
 QvkJtzFI3tTWYMfsN8cKUMcbf3mR1Ls86l4b9S90BnMmMTzdtPa5D7DmyuDC1FIc2fql
 Sq2A==
X-Gm-Message-State: AOJu0YzOzGGYY6SXabTexFEi9oXdhhm8aBMXX0PLWDPT7rlebNY8KLYe
 H18YmmXDXj1jXsxq9rG7b5SjVWxQh9IqlyxDH6ClqyefMgDEfvpS/ZfwuXdK6GvPjy8CazMqXPK
 4cRfz
X-Gm-Gg: ASbGncuQBHKDOMS5sJZtFZSyb3jLDET7gEV6IZ01JnsPbFEw09whSpyy5VKVQQoHzYy
 a3pWOVKi2+mvzscGMInOL+dJVEg10GoTCzPEByajCG9eFrjP4crgRW282JUyPGZhqOzxe/hCELe
 SkGxTYL6o9ip3Q4Aou5etArhEVKZvrg7ZWfGg34ZadjRUjzDUC5l/c8D/wHlsX9UhFKbmTUnrLu
 LpFBYDMmAWEAhITVKqhlyfpHS4xqHgDZ6dJVyQfv9e/drP6iBMF7Czp65RpEQmp71zx0S5cKuZ+
 0KLH7Efams19fOGCgUPuMb7ve61wAnSasrkMljoVck9+jTWe77La0Lq1bzqx+9KNCfm4HVL21+z
 Fem5BCfmJxMfWynih83gseqOKPITBEujhS4TPJfCs9ghQ4t1sGpqU6LbP/iuuPU/q5MUj5dVNwj
 ozj2Kk6UbMjQ==
X-Google-Smtp-Source: AGHT+IGhQ+pFBTnFj5Z14tGkXVeVv25JYpbQh5wIQukFgRFVOAmfEencbQbpKcm66S3yWz2VIuVpqQ==
X-Received: by 2002:a17:902:c94f:b0:23f:f6e0:b3c7 with SMTP id
 d9443c01a7336-23ff6e0b6a4mr39168825ad.45.1753601852675; 
 Sun, 27 Jul 2025 00:37:32 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe327443sm29824635ad.44.2025.07.27.00.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:37:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 1/3] linux-user/aarch64: Clear TPIDR2_EL0 when delivering
 signals
Date: Sat, 26 Jul 2025 21:37:26 -1000
Message-ID: <20250727073728.82913-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727073728.82913-1-richard.henderson@linaro.org>
References: <20250727073728.82913-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

A recent change to the kernel (Linux commit b376108e1f88
"arm64/fpsimd: signal: Clear TPIDR2 when delivering signals") updated
the signal-handler entry code to always clear TPIDR2_EL0.

This is necessary for the userspace ZA lazy saving scheme to work
correctly when unwinding exceptions across a signal boundary.
(For the essay-length description of the incorrect behaviour and
why this is the correct fix, see the commit message for the
kernel commit.)

Make QEMU also clear TPIDR2_EL0 on signal entry, applying the
equivalent bugfix to our implementation.

Note that getting this unwinding to work correctly also requires
changes to the userspace code, e.g.  as implemented in gcc in
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b5ffc8e75a8

This change is technically an ABI change; from the kernel's
point of view SME was never enabled (it was hidden behind
CONFIG_BROKEN) before the change. From QEMU's point of view
our SME-related signal handling was broken anyway as we weren't
saving and restoring TPIDR2_EL0.

Cc: qemu-stable@nongnu.org
Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250725175510.3864231-2-peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50cab78d8..6514b73ad9 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -666,8 +666,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         env->btype = 2;
     }
 
-    /* Invoke the signal handler with both SM and ZA disabled. */
+    /*
+     * Invoke the signal handler with a clean SME state: both SM and ZA
+     * disabled and TPIDR2_EL0 cleared.
+     */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+    env->cp15.tpidr2_el0 = 0;
 
     if (info) {
         frame->info = *info;
-- 
2.43.0


