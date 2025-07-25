Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAAEC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJKG-0000l4-KQ; Fri, 25 Jul 2025 10:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJv-0000Mo-RL
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufJJt-0006Rd-EH
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:22:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so1387169f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753453364; x=1754058164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykNmFy+pOc7x1JD04m7Jgyqi4BaE5vw5X8kVsc3ZDDI=;
 b=NRfrj/u6WOBAYCVNqaAWrvQ9q6spfYV/ytYcDcWXgsvBJCN4T+hFojwyvcrZN+/aO/
 Es89r1IKBxC9su4VGZcmKRcn+KiiFRa1z/IW/J0PfYTlz8hJuGnBHeSlRe8JT1P7hgm5
 rp+N3heU4fFwtC90iN54ha+b7Epvoqi9pa56AWBRjOQNrF/vuojelOPpGXNY3Khql0Xl
 C7kkNbxnoqPmsEK73/17QCT9j/+zPWPdTU3quivwt4bFthkT7Ouz1qafiXNNAOfaNt3m
 exD/WT0c4Pmjybyw3oomwP9XI9TiLrVxGSAlAtPKH0CEOAajOPVevh/b5DyTOji2yovt
 WRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753453364; x=1754058164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykNmFy+pOc7x1JD04m7Jgyqi4BaE5vw5X8kVsc3ZDDI=;
 b=kVyTapPTYZ6iUEVtSq0alof+PIOkOtG95kOBXkOHFcFn0oSuc9u/2NQgYeYAsM/3d4
 XIbRqTOfoXi4rgdWKNHsL3nGPLVw2o5jLKRHovod0QkTj1pFgmF2GjwpZ/ho/m5VRNOX
 rk2LY2xDwrLMaHmiwfMfR72SEBSl0cVoKk9QbenOf3G2e5rbP0ia4qXLsyuY6+beis4o
 LBYEt9BpLtyujZBXDHEuKiWyrLEQ19DBsBKFyro7fp3q1Gu2KDFFQg3A0QvlfT01w+yt
 qr61ZMSikIDcD1FkfxJMWutX+ZR4unvqbsZ74ZR7DBJmMrsRlvbPr/T+Tpe2NP6FNmLX
 fbIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHV0HR+fKd5pCkgLITiLjF+cDs/H3TYGtEwiRgNROScgGyMy9ru7Ey61sQScgnIkwNQuhoBAw9ZzQw@nongnu.org
X-Gm-Message-State: AOJu0YxV7z25PIbW+KglzugoaeIBcYbYBqYwv6v2sSmWWCI3jD2WUyI6
 vU1fhjH7hqsU52lyI5MhlgsQjD/Naw3vz+1f4YamO6G5VcdBEOpyPSvO2KQRhfSXNoo=
X-Gm-Gg: ASbGncsMUL738O5ZUvBvfpisx5BO0R7Gw1BoRhr784If9Ws7V4V+szJd8vSg1MQUBg0
 yeSsDP2dSXxncYWK64aqDQiPjZGrFhQpNigxPaBqIOIpLDwIUbaXfmOwWzsYD7PBAifvSwzUy3D
 CLJAZ76djgK0GhCAQFSuJxq6pXUgbxbCqaQC5uDLeE3/FAvgcEPXVsW4TOWMKV8ah2APbBg5XJy
 3QeaEV5uYUS1Bn04H3lntTXS+1cqG+FYtYqUDsXRNnYJWx0gnh7Mk/eAws4TFgC5iWj7y3kX59e
 52tJEte02QrogoV4am5Q0Kji8t5NyBY0f+r/9PlxeFadqjdFaNi+h27PkhtVTzwD8iC1mxN2yan
 F/MfV6CVw+/lPAOIekw01pkIIWrWH
X-Google-Smtp-Source: AGHT+IE5ha+ioBRABL/EzlXJGYoKgf5uPNcbCCSMyuv9hxhXtm6enS92ojhAlrs7TmkYBU/M6oT7NA==
X-Received: by 2002:a05:6000:40ca:b0:3b6:162a:8e08 with SMTP id
 ffacd0b85a97d-3b77123f244mr5341767f8f.12.1753453363895; 
 Fri, 25 Jul 2025 07:22:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eb2bccsm67065f8f.7.2025.07.25.07.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:22:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH for-10.1 1/3] linux-user/aarch64: Clear TPIDR2_EL0 when
 delivering signals
Date: Fri, 25 Jul 2025 15:22:38 +0100
Message-ID: <20250725142240.3760452-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725142240.3760452-1-peter.maydell@linaro.org>
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
---
 linux-user/aarch64/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50cab78d83..b4bab7c040d 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -668,6 +668,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     /* Invoke the signal handler with both SM and ZA disabled. */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+    if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+        env->cp15.tpidr2_el0 = 0;
+    }
 
     if (info) {
         frame->info = *info;
-- 
2.43.0


