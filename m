Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C62C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGoV-0004cJ-Q0; Fri, 25 Jul 2025 07:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoP-0003J4-Cl
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoN-0000MO-8j
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4561607166aso15058865e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443721; x=1754048521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xi/u4YvcSw90IPNa7azE1CVcMLzOd2+c/FozQt04GG8=;
 b=O1TY7gAEXepidQ0/6Nodp4upRP7yNBReXdkMvHpFDwSOvVbbBd7U43nk7/Ss1y8Mxd
 mhWQ2az3Gugfyp9WxZERGxelDeK/pY+OSgg75fC5urQ6HZT91pkM+8SyGx87hLA3taJj
 dXrb2SM93XsqVMLjwk4rfufsl/BpYvMTTKRyQU302YuDSWmicpx+WaD0Vm5eSjJInRgZ
 bdJ1mbTNf+whTZlFCs7sM2pbNKfmLRGynEG1AOaPz55b9YHOXf7m9KpnvRKADixi+0nx
 +FPWUJ3zasU4i8Qw655z0o1sGNpyUa99WWvMFz0OXkZMc8myh1b7nx76TteRZRewkYpA
 8pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443721; x=1754048521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xi/u4YvcSw90IPNa7azE1CVcMLzOd2+c/FozQt04GG8=;
 b=skVf8WhEvBkaiyfXNEHQO52ukqEZ8SCJAuUeyn33KgYEXmruAOHALTZkrhlHZLMjxH
 75pKOtX+U/xrKnRHSf2E7g+Ua785FVkl1M0vubr2gP3rtaeMAGOHGDEZjRSQFKXTgvDH
 TX4/KAIQPXcTxKIp+1kf4yw1jCuhGbsX27q80kT2MfcnB8dqxAA0SapbMBwnmw9YKT+q
 RF3r1A1zcZsqBtC+yzSQsRqyCp4YZJBoPgxiu19EABkX9BIJT5+lERsIQTRfdsnOOSbB
 a94Y31fmvT5T3Bw+leA2lTh9Z5Z6AR0oeD9B20ckKoJ8izI2dCX9LRTuElH4HrH9NqKx
 HK/g==
X-Gm-Message-State: AOJu0YwnNzoo2U5wmgIkvUy+qHLcJ2wEkmgl9iyZqLoOYhDIVyDe3K1V
 J5m+kKgA7KOoaGeIDIN5rC2D7QM2nDHxs4fLnEj+mbgmbQIz2X0Zv1fo4W7SCcYjWv0KwmW6WL3
 pJkmz
X-Gm-Gg: ASbGncv6wg604dOzCCrgN+ABDWOaPcBqnW7TQg6wJAtwTrjPcSVcWfbvPLUNNQ/dgRW
 3/1g3pk7aibrJXzRwHZck/nwIRe9j+HM5CDptegDtFqwYoutEJcOQdbmr9rD/gBbjBUtNkO+UyH
 uRnjbzF5Ft0f9KEOpYJmyHLiJgJ8o22WiFCXXvDEWQ4Vvw3zaQICGSVTk8AA8ikHsuxD57aHl7t
 r45mqWuyqKBSFrafORbbTLA8wIsXcEpqQhxzGvR2aX4GnHYs51ZYwp5/PSmQzwPZm+rEmOqcnna
 UZwm66jYb9FlhT1R8YR12keU6oLfi/1BzdaN1hobIdhvXXydVUNQmw2x49bA3H06qMr7jB/i3Ah
 Q/Ae7l3G2yXuboKuscJyMIbJcvxFNcDBS0Ya7LhE=
X-Google-Smtp-Source: AGHT+IGxjeiwdjncwaXONxBkLJskQ2zzxNPkIljifXF30d/47l6Xi8zK8h/Ti1la5alwkJ/cFWA4Pw==
X-Received: by 2002:a05:600c:1c08:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-45876303d9cmr12095955e9.1.1753443720857; 
 Fri, 25 Jul 2025 04:42:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.41.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] target-arm queue
Date: Fri, 25 Jul 2025 12:41:50 +0100
Message-ID: <20250725114158.3703254-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Hi; here is the arm pullreq for rc1. The diffstate looks a bit big but
most of it is because we had to expand a descriptor value from 32 to
64 bits, which meant updating a lot of function prototypes and definitions
from uint32_t to uint64_t in a fairly mechanical way.

thanks
-- PMM

The following changes since commit 9e601684dc24a521bb1d23215a63e5c6e79ea0bb:

  Update version for the v10.1.0-rc0 release (2025-07-22 15:48:48 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250725

for you to fetch changes up to a7aa2af13e287e11cb2d73972353bfec161803a4:

  target/arm: hvf: stubbing reads to LORC_EL1 (2025-07-25 10:39:32 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix various bugs in SMEp/SVE2p1 load/store handling
 * hw/arm/smmu-common: Avoid using inlined functions with external linkage
 * target/arm: hvf: stubbing reads to LORC_EL1

----------------------------------------------------------------
JianChunfu (1):
      hw/arm/smmu-common: Avoid using inlined functions with external linkage

Mohamed Mediouni (1):
      target/arm: hvf: stubbing reads to LORC_EL1

Peter Maydell (3):
      target/arm: LD1Q, ST1Q are vector + scalar, not scalar + vector
      target/arm: Pass correct esize to sve_st1_z() for LD1Q, ST1Q
      target/arm: Fix LD1W, LD1D to 128-bit elements

Richard Henderson (3):
      target/arm: Expand the descriptor for SME/SVE memory ops to i64
      target/arm: Pack mtedesc into upper 32 bits of descriptor
      decodetree: Infer argument set before inferring format

 target/arm/internals.h          |    8 +-
 target/arm/tcg/helper-sme.h     |  144 ++---
 target/arm/tcg/helper-sve.h     | 1196 +++++++++++++++++++--------------------
 target/arm/tcg/translate-a64.h  |    2 +-
 target/arm/tcg/sve.decode       |   12 +-
 tests/decode/succ_infer1.decode |    4 +
 hw/arm/smmu-common.c            |    2 +-
 target/arm/hvf/hvf.c            |    4 +
 target/arm/tcg/sme_helper.c     |   30 +-
 target/arm/tcg/sve_helper.c     |  185 +++---
 target/arm/tcg/translate-sme.c  |    6 +-
 target/arm/tcg/translate-sve.c  |  103 ++--
 scripts/decodetree.py           |    7 +-
 tests/decode/meson.build        |    1 +
 14 files changed, 877 insertions(+), 827 deletions(-)
 create mode 100644 tests/decode/succ_infer1.decode

