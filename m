Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C20CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPt5-0003kE-JD; Thu, 15 Oct 2026 14:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt1-0003jk-Oz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPsz-0000zZ-TB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so645595f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087740; x=1792692540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OG6efPduwzc7flBfkgotJgJwosIU2WvORdTx51g3yJw=;
 b=qUGHdPC/2y3nSaygq9lQawjIgRal7Hcfd3+JwbFfZHdTuuuPgCBFMAXepWo+CoAOvf
 19r7QVzg5zPDg0K09SV4FIa51fq3BBgnoiqHo5WiHWHm47OF0kqfZqSdfigGS+HydPhx
 K2Vegvb4w8ZjVlLbCxTn3bNauWn4eAxfPdjnzRsBPQ3/+RJC+GbHFK5O8BubFMUT7DVh
 Aceb1GaiwnQu/l2ejFVsx848S9gbyVmy3tXxovYrFIWo88SqD5zFMqHA02sWlnMob2X+
 MWyESRfGeRu3SU2mtg+bVk1HX+PqPaDUdhfzktNjW0PItAYMFKQ0N3ON/SmXv+fcdNmO
 wvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087740; x=1792692540;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OG6efPduwzc7flBfkgotJgJwosIU2WvORdTx51g3yJw=;
 b=mHGkU2iNOZgkrsl9xvy4V1XcfkWufrvc+IuGPk47tA8aLIByFXXP7xzqmVuANuhA5W
 QLLW8wLnr7Q6dMfoSjwpxP9WcxZOTI/poBWDVbM/XKzndAqi0skh880cRxJ66ZejS5rn
 MpH5mNoX4vU1qvk+Pdzquf9jyh/cdLksYsXozKFsc13ve1D3Ps1HQLbzyFScegCBcVhN
 RmUFvHEUUvSiyiUSs1OU+Jyrv9t4J8JOccl2mq899LvxEomwVm3XYjewHyALHi0taG8F
 z42vdYbbffoJAuNy8p3tPg347d3O7TkTDzplbutrNvS8dQRAl51JH+hxxYi8byKRYWv2
 yNKw==
X-Gm-Message-State: AFq9FYIIB6+/tKgQuK5a66DuoQuXYmEmp58rlhbXB8mMsfGC6DNxZji8
 hzUeuds23ZnJtzJviBDHNeB00AhCZHDjzheegk/ejhsB6lgv1n1mRQjYTh0OPJzi+CWQDB2ON18
 aw/u+DNY=
X-Gm-Gg: AYBFou1uCTFyfhZXmXyz6xhtlNJENqrBr7bjCpkCetTOrtHua8Q8bzjS43kH6ZFT7OP
 pSbNhgXiGh5TXrza/ro1ClbBdUworyB9Bi72uBZ4uAMxrY1kmRTfdZaI1u1POQHGxNOeJ0CkOJ+
 Od2tPIycySaEBsdVFE9/aWpHSR1LKqgRSmE/M19WcNYJj0jWUDdhlGAhEO9uT44itCDbfMqEtz3
 z6UgUy72rsu7CMNFOd6GfxAJGMvlbd34XJQ3bi8pr9qyBiYuIt0tHrzRj3Px5+q7tIhkj5SQwiO
 /PzLJYJu73iU2xdbQEwMsYpqmDb7B5V7W8KepwtkC9ZRoPNTNyFWUcidttqPm+m0wzqdaEEt262
 jPsMWRpmnM388XYRjrDp2qHaML1Vxq0trlMEWwMLIHkaVPoRdGL8cL82qfQailxdPj9E7irr7pe
 Zbrb8tSmRuPyhju5QCnmN6dFpe/lt3szLgdqeF6gdFQNLD/TwHCMrviaB1PEmw7AKB/mzTk3LxY
 1kMW365A3xtc4S0UPcvxmmK7bfJqzq5VM2tSt0IKoa7zNk7WHJMUropgs8qshPToulKBXRXQTrz
 +1o=
X-Received: by 2002:a5d:4e4c:0:b0:48b:10c8:2181 with SMTP id
 ffacd0b85a97d-48dbaaec6a7mr30590573f8f.27.1792087740027; 
 Thu, 15 Oct 2026 11:09:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.08.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:08:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] target-arm queue
Date: Thu, 15 Oct 2026 19:08:42 +0100
Message-ID: <20261015180858.1863407-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Smaller pullreq this time around; FEAT_IDTE3 plus a scattering
of bug fixes.

-- PMM

The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:

  Merge tag 'pull-aspeed-20261015' of https://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261015

for you to fetch changes up to c595a87dc3e318532460c654c36dea08e6ac993a:

  target/arm/tcg/gicv5-cpuif: Fix typo in ICC_PPI_SPENDR1_EL1 name (2026-10-15 17:38:38 +0100)

----------------------------------------------------------------
target-arm queue:
 * fix user-mode emulation of ID_AA64MMFR0_EL1
 * Fix handling of 52-bit TTBRs
 * Emulate FEAT_IDTE3
 * hw/arm/virt: Use TAG_GRANULE when creating tag memory
 * hw/timer/stm32f2xx_timer: fix periodic mode and CEN handling
 * hw/misc/stm32_rcc: Mirror clock ready and switch status bits
 * hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
 * target/arm/tcg/gicv5-cpuif: Fix typo in ICC_PPI_SPENDR1_EL1 name

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: fix user-mode emulation of ID_AA64MMFR0_EL1

Fuad Tabba (4):
      target/arm: Clear TTBR[5:0] from a 52-bit table base address
      tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
      target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
      tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA

Gustavo Romero (1):
      hw/arm/virt: Use TAG_GRANULE when creating tag memory

Manuele Conti (2):
      hw/timer/stm32f2xx_timer: fix periodic mode and CEN handling
      hw/misc/stm32_rcc: Mirror clock ready and switch status bits

Peter Maydell (2):
      hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
      target/arm/tcg/gicv5-cpuif: Fix typo in ICC_PPI_SPENDR1_EL1 name

Richard Henderson (6):
      target/arm: Rename isar_feature_aa64_idst
      target/arm: Enable writes to SCR_EL3.TID{3,5}
      target/arm: Squash accessfn in modify_arm_cp_regs_with_len
      target/arm: Implement SCR_EL3.TID3
      target/arm: Implement SCR_EL3.TID5
      target/arm: Enable FEAT_IDTE3 for -cpu max

 MAINTAINERS                           |   1 +
 docs/system/arm/emulation.rst         |   1 +
 include/hw/timer/stm32f2xx_timer.h    |   2 +-
 target/arm/cpu-features.h             |   7 +-
 target/arm/cpu.h                      |   2 +
 hw/arm/virt.c                         |   6 +-
 hw/intc/arm_gicv5.c                   |   1 +
 hw/misc/stm32_rcc.c                   |  19 ++++
 hw/timer/stm32f2xx_timer.c            |  73 +++++++++---
 target/arm/helper.c                   |  51 ++++++++-
 target/arm/ptw.c                      |  18 ++-
 target/arm/tcg/cpu64.c                |   4 +
 target/arm/tcg/gicv5-cpuif.c          |   2 +-
 target/arm/tcg/op_helper.c            |   2 +-
 target/arm/tcg/translate-a64.c        |   2 +-
 tests/qtest/stm32f405-rcc-test.c      |  62 ++++++++++
 tests/qtest/stm32f405-timer-test.c    | 136 ++++++++++++++++++++++
 tests/tcg/aarch64/sysregs.c           |  31 ++++-
 tests/tcg/aarch64/system/ttbr-baddr.c | 208 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build               |   2 +
 tests/tcg/aarch64/system/meson.build  |   6 +
 21 files changed, 596 insertions(+), 40 deletions(-)
 create mode 100644 tests/qtest/stm32f405-rcc-test.c
 create mode 100644 tests/qtest/stm32f405-timer-test.c
 create mode 100644 tests/tcg/aarch64/system/ttbr-baddr.c

