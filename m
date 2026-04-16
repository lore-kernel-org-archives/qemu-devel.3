Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6481CF8D764
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPye-00068W-Eg; Thu, 16 Apr 2026 12:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyc-000681-5o
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyZ-0007Wc-LS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so75965655e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776358438; x=1776963238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Prv6XnWS1b0WHiNYlODggkmm/Lh0xfjDgprbZpOCctA=;
 b=efo5zqTFe4+GAMqTgiPN4xWErg3uxbTaCOCBHnXwuLSle5nT+pXHj3o6vCeAlMSUWC
 +2is3pHEK9Qz0cba94qNfCLTmckn2hJHWw5f74LUfZUzyBaS6xBXv9ctzkjBbb3m9bAy
 aHAtiLQLxGShnfWFYJPLlomFKY2zZm+mRXkKCDp63MTcAxU853hdCLD9KOnn1rvIg1Sq
 hLebaSWqPEqPE+S3is0bEUo+HPOjP6lRLNe3BpisxpaAMx4w3vmSgPb9KBHd5oBknu/1
 /X8iMHbN3c37HW+dOP2qZ5uI6QZlPlwkNKEUCqYX+rSE4I6LLWW8ybOXBpqdSRBkqHZk
 Nxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358438; x=1776963238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Prv6XnWS1b0WHiNYlODggkmm/Lh0xfjDgprbZpOCctA=;
 b=GrCx6eM0LgNFARuT7aLZO8E50w4Lnuvvu+4XHgKqoooqk6lmJrpXdwtEf8OBtp3jvw
 PKpECwyJmJr7ce0oy2p3dHMG/Rok4OHG0rAmBeG/xCTIC61hmO/6GiKV0fdGK+0migIY
 DXn+jjS0FdBvrsueR/hQZBYS+/9ApKZ4Kfit2FwQMDOxUY9HDiRSPlLpef6IeUzHwl6i
 +C7vre1Fsq6cSZKnVeO1Kg6WspUb4Sh/gEjLHJU/nD5IBgp1Bje0SoD9J1Ty4Q9b+7Ti
 Vu7UHX7UkA50dCYasccSbby/yfVLvhA6zwWJZjcQxMFwH9w2KtPXL2w/RGpCYvPQhzJF
 lezw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vefz7veN/9Q7USsDsOah+f7X60qSY/7oUQfE73V/vy7mCgxLfpKtIgCsQlC0IBFjv7NAe/rYdOmoD@nongnu.org
X-Gm-Message-State: AOJu0YyaUOmNPOkH4loOlY+dChwBeHWFg8g6Z5+b9V9hhflS/aiYvtCk
 P5zql2qCm3hwl6nWxU6ZNbMKczso957E+G0ZrrKGgsQy+5BdZPj8dkERY8ySW16EBoQ=
X-Gm-Gg: AeBDietOt9hmHGcfh6dEV3KExmWVP9s6sd8FNscTheHPzCpMXGV6vuZ+wK9x9i4VcBq
 WLx5BLDKCPO6vZrH38BGFQp6ETfaA6iHLb6L5YFh8ErcahnOs1Xk8stg3cGE5EAnuMqKPRtBBt1
 pjXppIfH+23ZoFE8i1n3zcoHyEiibgZxoHFvU8qnWh2q/+aMgnUvBiAkCgEsEaWesZJ1HW1aW6e
 5cdrgh474DDP/S3Y1G8aZi61oP9Xx/GhCNQAgK3KDmiR4DI78dIaQMea8UclMDL2t8wgcAzC/3t
 BY5dYken2II0VK/ZOL1LLhEpZaBx47JDaz0zhMauPVT/sw8LyA4b5uJYGfjKMTd1pwqhfAyEbVs
 EMzxWnLlv4D232gMuDBTrGbPgMqexglsCx/ezF9L/NxC7MDFIlFBe3TUzV0E9Ax6ssSw38Qkhly
 pMwgovP466IBfu6gf2+mufSVjPj9sSh4wvguYc/uxh886LpeoVY5XCgorORwPOLQAV86kW+Un39
 bYJ3dsvinhZkD1g0jpsl8j2ei/jRKF2H/OpFJcdkLdOtm9X+mRu
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-488d67b8d97mr321520695e9.2.1776358437763; 
 Thu, 16 Apr 2026 09:53:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fa79d476sm473035e9.1.2026.04.16.09.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:53:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 0/3] target/arm: Allow aarch64=off for TCG
Date: Thu, 16 Apr 2026 17:53:50 +0100
Message-ID: <20260416165353.589569-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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


This patchset relaxes our current constraint that we only permit
-cpu foo,aarch64=off on KVM CPUs, so that you can also use this
to run a TCG CPU with aarch64 disabled. This is useful because
currently if you want a 32-bit TCG CPU you're limited to either
'max' in qemu-system-arm or else the old v7-only CPUs like a15.

I sent out v1 back in October last year. The main changes
here are:
 - as I said we ought to do in a follow up to those patches
   https://lore.kernel.org/qemu-devel/CAFEAcA9KeO2r+jNont_2Jpvi5MgViH3nXO7TcbANe+3nS_PF-A@mail.gmail.com/
   I've switched to only clearing the AArch64 ID regs with
   TCG; we leave the KVM aarch64=off behaviour alone. (Clearing
   the regs didn't break KVM, but did leave us in the odd
   situation that QEMU and KVM didn't have the same idea about
   what the ID reg values were, which seems like it might lead
   to subtle problems later.)
 - I've added a simple functional test which boots one of
   the kernels we use for a 32-bit functional test using
   qemu-system-aarch64 and -cpu max,aarch64=off

I also made a tiny tweak to the docs wording.

Patches 1 and 3 need review.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Clear AArch64 ID regs from ARMISARegisters if AArch64
    disabled
  target/arm: Allow 'aarch64=off' to be set for TCG CPUs
  tests/functional/aarch64: Add basic test of TCG aarch64=off

 docs/system/arm/cpu-features.rst              | 10 +--
 target/arm/cpu-features.h                     |  5 ++
 target/arm/cpu.c                              | 71 +++++++++++++++++--
 target/arm/cpu.h                              |  3 +-
 tests/functional/aarch64/meson.build          |  1 +
 .../aarch64/test_virt_aarch64_off.py          | 37 ++++++++++
 tests/qtest/arm-cpu-features.c                |  8 +--
 7 files changed, 120 insertions(+), 15 deletions(-)
 create mode 100755 tests/functional/aarch64/test_virt_aarch64_off.py

-- 
2.43.0


