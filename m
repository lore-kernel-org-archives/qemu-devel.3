Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D204CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjS-0004g8-FC; Thu, 23 Oct 2025 10:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjR-0004fn-M0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjP-0005XO-K1
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so585335f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231357; x=1761836157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nO5iDkG4scHzF0lHzlP+JlsTMzs5477uiiHzsSdQ+FA=;
 b=HqgysYkFTUErHQyItjIIYmTJnBdh8hMFQiFCgqQyLQ4LHOH1EMQKBCraRnkfb9ijIa
 sQfgWCImHqtPoj6JXxPwpr7FP4ueMeVsnb+ZJol53KXXkpMvBWxkmzA2rP4PJzH/zrjq
 bQrO2n5cjYdYYQQpqvVdsArMahbazHwNV7Qo83Bg2yaN7/W5kF7r52AAdNlUTFKWvw+7
 tbv9DGW/GKPLv4PnOR6uXxvOmS4YnJJiXCAjJhOgtkvyv0ERAvb17ZOdPNjucW8eh4xs
 zyNNZajKjPoqorkxUjh3faD6NN854201rgszofag95z+ik7Wrx+1iVDTvnE8LQPcdW8E
 GJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231357; x=1761836157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nO5iDkG4scHzF0lHzlP+JlsTMzs5477uiiHzsSdQ+FA=;
 b=WaDIrlrieJcRlkw21nKwelpMH7878s2JUcBaas4x5jipYBA5oIAqJg7LpnVkb/i9mZ
 El5CG9sw7R7ALSNjp93X+DPp6je2dO+kSV+nRQZCHSJt3MjFLoSg6LcKgguT0AxsY/4V
 iTtq+WC8JhSlCs5B+O+HmTmMhtxfz5poMpw6Q2sNI/5MoGxJGFDmlZCqfhr8BTRrECtF
 Q60c4Zg1uYrZM9VZ76xj2kdfxXygrFdHamkU5o/28Qmu2RrYJYbjyZZBCPcXvW/P6sSl
 /jb5R7Wphspl1yf0y/GEoaOAWpmCVTERQYr+EjP0IhiEjdizUFGgNe4X9jvxQouwQ1Df
 kKiw==
X-Gm-Message-State: AOJu0YyIuYf2Sn08Lf84TC03E2tiN+lT3CLzPHSgHjPyJuHaNwVVP8H+
 O974Lc9/9b6+GYr+PjLU3USD/4vF9KvDkR11PitHwxWidbX+00OLBMABmFlq7z487rePipvGgUH
 yhes4
X-Gm-Gg: ASbGncsMRlI2EPEdfkx0fkKlblovfO6mIlOhHXEkScnG2WOCjcdobui/VGwWBq5HaEn
 m7HNN9sMS7xk/mFUerNUAMcujbXLbrjHdThhiVCGkR3oGR+7ojtrzWBwfx7uMI1iXoT+U+uno7C
 oupDMcYqmk8sNjfaZehlYIowvpN66NQDTOp/Q/8qqYQRfGDBQQ55T9AgfhJvo+fGvnes9Fsu0au
 nkAgtGfINHBltw7IQieROZfn99K/8UzQ6IzfU76lncV2BK6cJsZyFfQTZd3+D8uedlZLztWrlfw
 hzZJ5f1+EQHcCgaomeFBr2Y435fEPfMHpcyJjGKz92eijKv4BYHHovRbt51uPhz3y7Huy45iE0A
 Nt9o0RDy5qYFv7njF5iq1a0FU/+GUEcTJNKgahmYeFzT+HyTggtpL9TiH+OrQtfm5Rn8u4YmRNU
 kQWstHSg==
X-Google-Smtp-Source: AGHT+IFyUwVWSFcCrc9nu6jNAdzTuUvUO/jimtW7LCVe/8frk4AKZFuJ3wisYmpz6/3DYsJPyWdi4A==
X-Received: by 2002:a05:6000:612:b0:411:f07a:67fb with SMTP id
 ffacd0b85a97d-42704e0ed95mr15660086f8f.55.1761231356615; 
 Thu, 23 Oct 2025 07:55:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.55.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:55:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] target-arm queue
Date: Thu, 23 Oct 2025 15:55:38 +0100
Message-ID: <20251023145554.2062752-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi; here's a target-arm pullreq; nothing very
exciting in here.

thanks
-- PMM

The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:

  Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251023

for you to fetch changes up to 33eff5c84d52e7186e0882ea5ee9ac5501c3deea:

  hw/net/rocker: Don't overflow in of_dpa_mask2prefix() (2025-10-23 14:13:38 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Enable FEAT_AIE for -cpu max
 * target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
 * target/arm: Implement SME2 support in gdbstub
 * hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
 * hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from kernel in cpuif reset
 * MAINTAINERS: Claim the Arm XML in gdb-xml
 * hw/net/rocker: Don't overflow in of_dpa_mask2prefix()

----------------------------------------------------------------
Peter Maydell (9):
      hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
      hw/intc/arm_gicv3_kvm: Drop DPRINTF macro
      target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
      hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from kernel in cpuif reset
      MAINTAINERS: Claim the Arm XML in gdb-xml
      target/arm: Implement SME2 support in gdbstub
      target/arm: Implement org.gnu.gdb.aarch64.tls XML feature in gdbstub
      tests/tcg/aarch64: Add test case for SME2 gdbstub registers
      hw/net/rocker: Don't overflow in of_dpa_mask2prefix()

Richard Henderson (7):
      target/arm: Add isar feature test for FEAT_AIE
      target/arm: Implement MAIR2_ELx and AMAIR2_ELx
      target/arm: Add AIE to ARMVAParameters
      target/arm: Drop trivial assert vs attrindx
      target/arm: Use el local indexing mair_el
      target/arm: Honor param.aie in get_phys_addr_lpae
      target/arm: Enable FEAT_AIE for -cpu max

 MAINTAINERS                               |   2 +
 docs/system/arm/emulation.rst             |   1 +
 configs/targets/aarch64-bsd-user.mak      |   2 +-
 configs/targets/aarch64-linux-user.mak    |   2 +-
 configs/targets/aarch64-softmmu.mak       |   2 +-
 configs/targets/aarch64_be-linux-user.mak |   2 +-
 hw/intc/gicv3_internal.h                  |   1 +
 include/hw/intc/arm_gicv3_common.h        |   3 +
 target/arm/cpregs.h                       |   2 +
 target/arm/cpu-features.h                 |   5 ++
 target/arm/cpu.h                          |   6 +-
 target/arm/internals.h                    |   6 ++
 hw/intc/arm_gicv3_dist.c                  |   9 +++
 hw/intc/arm_gicv3_kvm.c                   |  62 +++++++++-------
 hw/net/rocker/rocker_of_dpa.c             |  11 +--
 target/arm/cpu.c                          |   3 +
 target/arm/gdbstub.c                      |  12 ++++
 target/arm/gdbstub64.c                    | 115 ++++++++++++++++++++++++++++++
 target/arm/helper.c                       |  94 +++++++++++++++++++++---
 target/arm/ptw.c                          |   5 +-
 target/arm/tcg/cpu64.c                    |   1 +
 gdb-xml/aarch64-sme2.xml                  |  14 ++++
 tests/tcg/aarch64/Makefile.target         |   9 ++-
 tests/tcg/aarch64/gdbstub/test-sme2.py    |  36 ++++++++++
 24 files changed, 350 insertions(+), 55 deletions(-)
 create mode 100644 gdb-xml/aarch64-sme2.xml
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

