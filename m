Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D9C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYk-0004mv-2e; Mon, 21 Jul 2025 09:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYA-000092-2y
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqY6-0005HA-K9
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so29201565e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104440; x=1753709240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LwC1K9V195wWZjVf3p1nnci+abzEyNkmArVrpz2qbkw=;
 b=Nulaz7X7/WH+YNzvLaheZRZg1my6QIbPP0DMf4cWBPTR5Kl1ZsZzzJ/jv2AZfXKROs
 jEsLqHbOhYVOvSsSf+fGtuU0dqW7Iyslh4Bosym5Jq/qO9qhWVxPltAGYei1iqhzy9RI
 rvKE+WQqgMQjgf239lLpbxufgk2ueVZjWTBgNBd5BipLBRuKkXGXkofpIk2hQKOXSj8f
 mzJkI8Jz0C9CkEQw5flTgrI1blaOuJbBg6nxlsYCNA3m11uV79tj1F+yjRPYok1U7HzZ
 xxfhiJ+XXywCWwQt7sh2BRXGFyJi9ZGieEiiHijzw69b/edfqZoQLjTlSUrZquvhxd4q
 HZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104440; x=1753709240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwC1K9V195wWZjVf3p1nnci+abzEyNkmArVrpz2qbkw=;
 b=dy59yxEUCnpof8ysp/nnUepdEcemdXQd4+AGA+j2i49TAedu2Tpo+oPhkrxm6PUJOz
 jsjYjzd5Lb1X3ZkePiuvxLOTCYGL1ZQ5HUxvkxWRX9vBBCrWmDc7xrMj0u3G7b29J2/8
 c7HhbtRGw72+l3n5hKRu/U5CFzOdNwzqATgJtdXiSE+ah5TTKaNLvkIRuLkcie5vGxnP
 bXR6juzaTDpXguaNfyPtc2gciNRnEEw1JIKnqu3hSCwhmLjPqZK8M8JRv/JK2DfUaeXR
 U9MC18HHDXLj3M4L9uEOY4iKZGd4Elo16t+VB+rUSCy1Ju3divnTzWtJLbox3AlgubyA
 EjSA==
X-Gm-Message-State: AOJu0YwlQfksEPSbhaM8J+caoyTXnZaUAVMQyP2yk9xD2zomHuhBjFYx
 dI24tr1sscsejrQCX5wiSCBXhrypxOGXAet/U7LA11Zxd2Yp18K3P9onX3IR3UTUA0RBAJ4j4Tz
 rpr6/
X-Gm-Gg: ASbGncsRj81V7njW7EPFMkS+URhz8tK0J5JSfLahahxc3Ftri+6a6htrsJyO0blbqCI
 VE66StUtTFR+6PxcSu50jICxvcpbwV3mmcVlfZNYvVcq2YH6gEjIrFLLVVG4TyTVWKECOJx7Zw4
 rGTCmsl8ivRK0yT1TvALeQfjR9LKY4cLz/E6oCPzAeuzV0GlJP1A/U8aVx8HPjxThakdCyEZT+k
 6fuiyM9G41T30wdjt8ICZwXIy3L8LRU5PLpNfDuUrWXeI128RswS4Y1KuPg27OdNSPW+xo/aPJf
 h7KH4OFrtwGp1KeWonfdDVZMpP6iH/+B2kLDmtxlsn88FEV9iFxgDl7REa/uYIRaHLHOmb0xrN/
 KWe7xr2aD41Par28DFlht9i71QzBX
X-Google-Smtp-Source: AGHT+IHBTF2K/ozSmQtsMAV8Epwk3G8Ni956C3UZCY4etWEkniOYoAJ8isr9a4y5rClaWjafRNnJJQ==
X-Received: by 2002:a05:600c:a00c:b0:455:de98:c504 with SMTP id
 5b1f17b1804b1-4562e2bd5a8mr223059145e9.0.1753104440033; 
 Mon, 21 Jul 2025 06:27:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Mon, 21 Jul 2025 14:26:57 +0100
Message-ID: <20250721132718.2835729-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi; here is a target-arm pullreq for rc0. It has various bugfixes; the
biggest bit here is adding a handful of bfloat16 instructions we
accidentally forgot to implement in the recent SVE2p1 feature.
I consider those to count under the "bugfix" heading because without
them we would UNDEF when we should not; plus this is still very early
in the release cycle.

thanks
-- PMM

The following changes since commit e82989544e38062beeeaad88c175afbeed0400f8:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-07-18 14:10:02 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250721

for you to fetch changes up to 7724ca9a772594b96939ff549c74f46e11d7870b:

  accel/hvf: Display executable bit as 'X' (2025-07-21 13:38:33 +0100)

----------------------------------------------------------------
target-arm queue:
 * hvf: arm: Remove $pc from trace_hvf_data_abort()
 * target/arm: Correct encoding of Debug Communications Channel registers
 * hw/misc/ivshmem-pci: Improve error handling
 * target/arm: Provide always-false kvm_arm_*_supported() stubs for usermode
 * host-utils: Drop workaround for buggy Apple Clang __builtin_subcll()
 * hw/misc/max78000_aes: Comment Internal Key Storage
 * docs: Fix Aspeed title
 * Implement a handful of missing FEAT_SVE_B16_B16 insns
 * Fix bugs in FMAXQV, FMINQV, etc
 * Fix assert in LD1Q decode
 * hvf: arm: Add permission check in GIC sysreg handlers
 * hvf: arm: Emulate ICC_RPR_EL1 accesses properly
 * accel/hvf: Display executable bit as 'X'

----------------------------------------------------------------
Cédric Le Goater (1):
      docs: Fix Aspeed title

Jackson Donaldson (1):
      hw/misc/max78000_aes: Comment Internal Key Storage

Peter Maydell (14):
      target/arm: Correct encoding of Debug Communications Channel registers
      hw/misc/ivshmem-pci: Improve error handling
      target/arm: Provide always-false kvm_arm_*_supported() stubs for usermode
      host-utils: Drop workaround for buggy Apple Clang __builtin_subcll()
      target/arm: Add BFADD, BFSUB, BFMUL (unpredicated)
      target/arm: Add BFADD, BFSUB, BFMUL, BFMAXNM, BFMINNM (predicated)
      target/arm: Add BFMIN, BFMAX (predicated)
      target/arm: Add BFMUL (indexed)
      target/arm: Add BFMLA, BFMLS (vectors)
      target/arm: Add BFMLA, BFMLS (indexed)
      target/arm: Correct sense of FPCR.AH test for FMAXQV and FMINQV
      target/arm: Don't nest H() macro calls in SVE DO_REDUCE
      target/arm: Honour FPCR.AH=1 default NaN value in FMAXNMQV, FMINNMQV
      target/arm: Make LD1Q decode and trans fn agree about a->u

Philippe Mathieu-Daudé (1):
      accel/hvf: Display executable bit as 'X'

Zenghui Yu (3):
      hvf: arm: Remove $pc from trace_hvf_data_abort()
      hvf: arm: Add permission check in GIC sysreg handlers
      hvf: arm: Emulate ICC_RPR_EL1 accesses properly

 docs/system/arm/aspeed.rst     |   1 +
 include/qemu/compiler.h        |  13 -----
 include/qemu/host-utils.h      |   2 +-
 target/arm/kvm_arm.h           |  35 +++++++++++++
 target/arm/tcg/helper-sve.h    |  32 ++++++++++++
 target/arm/tcg/helper.h        |   5 ++
 target/arm/tcg/sve.decode      |   5 +-
 accel/hvf/hvf-all.c            |   2 +-
 hw/misc/ivshmem-pci.c          |   9 +++-
 hw/misc/max78000_aes.c         |   6 +++
 target/arm/debug_helper.c      |  13 ++++-
 target/arm/hvf/hvf.c           |  10 +++-
 target/arm/tcg/sve_helper.c    | 109 ++++++++++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-sve.c |  97 ++++++++++++++++++++++++++----------
 target/arm/tcg/vec_helper.c    |   4 ++
 target/arm/hvf/trace-events    |   2 +-
 16 files changed, 285 insertions(+), 60 deletions(-)

