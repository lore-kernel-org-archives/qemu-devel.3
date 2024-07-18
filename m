Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9F9C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3m-0007u5-Ig; Thu, 18 Jul 2024 09:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3j-0007mk-If
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3h-0004Si-AC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266f344091so2727815e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308830; x=1721913630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iipzl/hVMG0pJW257EYsJCRNzadAUx3jZRMag1Eukug=;
 b=BgBIkhi/KIF77azVuB4XQJgQ9HHrhig3SLTDRNgF9wgJUYeDZBtoLRvKfS4McOX4fY
 AAfw4EowZOtt6Hyaw1K7URCZE02qSak/TQjp1En0XCCAlw0ceoYEJlb54/I44o25VYPt
 cPwmK1P0QPCeBKDUGqIH4fSQCZJy8Q52OwBUUBP4HaNxTmiK0STFFjX6gg9mflMSp7T+
 4867T/xpOY5/IuJYDwmVuTNeesJ+6w/s5NAGGPOBzVRq/EMwVgo7ZqvPbUNoJ2rkt6M0
 EHFEISTHb5PnJwADIwEykBO2Gl16283eHDXy5kRGCFWkipyCSJ6yM/u7d0REXswgcG8+
 vplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308830; x=1721913630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iipzl/hVMG0pJW257EYsJCRNzadAUx3jZRMag1Eukug=;
 b=jCAuYVAQhF6MHUzNtH7BO4qpisoxwYtUOa1PhRrZvorCD/2+y1T2lZtyiWkp+ltJXN
 l6UnCxZgOV2gF+ZWbKnGvbmQ6aYkdBxcXkmnHdN28mCjg7RqqV4DH/YnQxmkA1tb9bnh
 ba0xhbTAKx8wGC3nTJDnuyrhszRHYimudcki466n7tW+XqBC5PxGqaSeWRd0W2WIK6iA
 1yA/QAtq+7hUIuK4xuVfQkDmBcbE3VQVsmTJM8AsEGBGT4x95ZDYIYgWKDDrB1Qd76Gt
 fQVx6uk4PPlYas7I+30zm8qFvJDZJoF8W4PbWJZr/XPpKX51IRK/YFF7MOfc9iXpkobj
 Ck5Q==
X-Gm-Message-State: AOJu0Yx5F4ARh3vcq6tVgNT8IWNsw0fgd1TcVKcK1M78YwoMQYHu3kXO
 uoho04CaqydGrJEMTzyYtbr6yKImCSbFlLhym8387F2Q18bakFOZTCK7dwV2YVAtR7KbRVpELG2
 p
X-Google-Smtp-Source: AGHT+IHFu2LBnfoKZ7MMkenxZ43e9kKvHLbY/z726/Xi/2i+Unj4KCUIRZZ1M7N71/LNMQ9sm4Al8g==
X-Received: by 2002:a05:600c:b8e:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-427c2cb563bmr34354145e9.19.1721308830143; 
 Thu, 18 Jul 2024 06:20:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Thu, 18 Jul 2024 14:20:02 +0100
Message-Id: <20240718132028.697927-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Hi; hopefully this is the last arm pullreq before softfreeze.
There's a handful of miscellaneous bug fixes here, but the
bulk of the pullreq is Mostafa's implementation of 2-stage
translation in the SMMUv3.

thanks
-- PMM

The following changes since commit d74ec4d7dda6322bcc51d1b13ccbd993d3574795:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-07-18 10:07:23 +1000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240718

for you to fetch changes up to 30a1690f2402e6c1582d5b3ebcf7940bfe2fad4b:

  hvf: arm: Do not advance PC when raising an exception (2024-07-18 13:49:30 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix handling of LDAPR/STLR with negative offset
 * LDAPR should honour SCTLR_ELx.nAA
 * Use float_status copy in sme_fmopa_s
 * hw/display/bcm2835_fb: fix fb_use_offsets condition
 * hw/arm/smmuv3: Support and advertise nesting
 * Use FPST_F16 for SME FMOPA (widening)
 * tests/arm-cpu-features: Do not assume PMU availability
 * hvf: arm: Do not advance PC when raising an exception

----------------------------------------------------------------
Akihiko Odaki (2):
      tests/arm-cpu-features: Do not assume PMU availability
      hvf: arm: Do not advance PC when raising an exception

Daniyal Khan (2):
      target/arm: Use float_status copy in sme_fmopa_s
      tests/tcg/aarch64: Add test cases for SME FMOPA (widening)

Mostafa Saleh (18):
      hw/arm/smmu-common: Add missing size check for stage-1
      hw/arm/smmu: Fix IPA for stage-2 events
      hw/arm/smmuv3: Fix encoding of CLASS in events
      hw/arm/smmu: Use enum for SMMU stage
      hw/arm/smmu: Split smmuv3_translate()
      hw/arm/smmu: Consolidate ASID and VMID types
      hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
      hw/arm/smmuv3: Translate CD and TT using stage-2 table
      hw/arm/smmu-common: Rework TLB lookup for nesting
      hw/arm/smmu-common: Add support for nested TLB
      hw/arm/smmu-common: Support nested translation
      hw/arm/smmu: Support nesting in smmuv3_range_inval()
      hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
      hw/arm/smmu: Support nesting in the rest of commands
      hw/arm/smmuv3: Support nested SMMUs in smmuv3_notify_iova()
      hw/arm/smmuv3: Handle translation faults according to SMMUPTWEventInfo
      hw/arm/smmuv3: Support and advertise nesting
      hw/arm/smmu: Refactor SMMU OAS

Peter Maydell (2):
      target/arm: Fix handling of LDAPR/STLR with negative offset
      target/arm: LDAPR should honour SCTLR_ELx.nAA

Richard Henderson (1):
      target/arm: Use FPST_F16 for SME FMOPA (widening)

SamJakob (1):
      hw/display/bcm2835_fb: fix fb_use_offsets condition

 hw/arm/smmuv3-internal.h          |  19 +-
 include/hw/arm/smmu-common.h      |  46 +++-
 target/arm/tcg/a64.decode         |   2 +-
 hw/arm/smmu-common.c              | 312 ++++++++++++++++++++++---
 hw/arm/smmuv3.c                   | 467 +++++++++++++++++++++++++-------------
 hw/display/bcm2835_fb.c           |   2 +-
 target/arm/hvf/hvf.c              |   1 +
 target/arm/tcg/sme_helper.c       |   2 +-
 target/arm/tcg/translate-a64.c    |   2 +-
 target/arm/tcg/translate-sme.c    |  12 +-
 tests/qtest/arm-cpu-features.c    |  13 +-
 tests/tcg/aarch64/sme-fmopa-1.c   |  63 +++++
 tests/tcg/aarch64/sme-fmopa-2.c   |  56 +++++
 tests/tcg/aarch64/sme-fmopa-3.c   |  63 +++++
 hw/arm/trace-events               |  26 ++-
 tests/tcg/aarch64/Makefile.target |   5 +-
 16 files changed, 846 insertions(+), 245 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-fmopa-1.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-2.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-3.c

