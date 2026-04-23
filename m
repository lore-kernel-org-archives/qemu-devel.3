Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60AAF99363
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtS-0006K9-84; Thu, 23 Apr 2026 06:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtL-0006IO-A6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:39 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtG-0001ry-QC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bab8ae52954so247582866b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938552; x=1777543352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sh1zBqMoSmHsZ/gncYdBmokJ/fJZQVpRqjd4MxcIjaY=;
 b=sfzFD5xOSQGH+u9grypCJWilfgp913gduyg9ngFg0nwxmhlLkQweS6L43ZmWdmJSLf
 FCM+4ZKJFhfyA2V6LSFQp3r0ovkGRMKQrJLP5IPm2i4ZBrMvr4zeekw0EIAUMf4R44YO
 qUDuD/e3Sv7OhRoLNAhyL54Xwqard5fkGxekhdZggVFmRvUu0LDskNut/XyhnioLeEiM
 wGlRL/nsFpPShnWmj3DOvyjrl+Z0eDDTBind3Qv6XpSHHFrSpGk8ocVlbUwCr7I5cGLW
 ky/WExajr55lcRiKhjq4hU2mcC8adEc8a3LH1Q+7RkZwEwPev5fsEGCn8A7QKN/ROxxl
 1WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938552; x=1777543352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sh1zBqMoSmHsZ/gncYdBmokJ/fJZQVpRqjd4MxcIjaY=;
 b=ReSO99wJkdWcwDTxlLPMLY3h+u4yPV4mn9g4UYNYqScUKS28YFWBvT4FLIK5mdejSS
 RpOy4QAF5y0pxJbx2+CmJNx/8nbVDpTLGNbZHucyC9XREL/yiOikzUhDOflLc+m1a3uU
 HMyWJ6vWV3aMbhpWpaJZBHUEW6ECTONqEjnOXXC/HNyq9KBsSJEXwhIvFZPWERUGA/3c
 VN5k7BzEnKqeMADw3dPulNgsyU+7vqPAHOSzehC0V4Sb0oLi+lZep4d4McAC3LjoJl29
 eLJ6EdMk/R+mfdRj2sGnx+jndN4i6R/b/ENtN/Kdkof5lDPfyu3Zd+Y9kiDduQsxVZXU
 4U0w==
X-Gm-Message-State: AOJu0YxjXoJU1VT8pj5YYphgRogflf9JJNiDYc+xmjQLHvGnmFnE3WZ0
 nd6epxWeZMgPGrqeEqbe5Ge5S0nqS4fKThVlMsF7+j4CM8KeZEPSRbrBgcMwPR0LFhp1ElYzfqX
 BaV2T
X-Gm-Gg: AeBDievW6Ocn7cYLdvAQHPFQvBdIj0nqk4j53+ozJe7oMoCgUxCoC/uEM3CNVKqordu
 2ZBowiRXjNsiFb/JpDQRAcs4ez8ljX7nYz7xKPTxKC9iRozZjcfbWEmCZ0DWV5tgyc9EFOXemL/
 ql98dPekTLC2EMYhVRnbbb6iiyKQvpXjBIYaPof100Vc8OArJJHfSJWMBclpcYchYDsTy5nCm0X
 uaxwpi5mf3rbwgHS+fvLTBMrdx6S6b0JBI6jBMEUzVDYDwhK/8783d8GhK/pdpOQHGGm00ngv8S
 ttidTgbNlwr7CwPB+7t+k5jnkUmcoNWg9e1UBAct2LkxNeu0El1a2Xcn2r4uoVeO7chqwdByHIQ
 lO9N6DsETa/lfSMN0FG8i3imUNT+c2x2BZofMhsZpGH0UhH7NR6dvM0N1+OtM3Hmzl5uepX3V6o
 SVThWymC+6jV8vyGe6EMCaLAwgB4jFe+xfNP1rx9T1pdXYOuR+fv3IMH7sbVEOrIp4g4lF6Mhxr
 izRnhNx+Gsxn262r7W0gp8wn+v/Bbt7iNHg9uTA6g==
X-Received: by 2002:a17:906:9f85:b0:bad:ad5:300a with SMTP id
 a640c23a62f3a-bad0ad5341bmr9149066b.26.1776938551130; 
 Thu, 23 Apr 2026 03:02:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/59] target-arm queue
Date: Thu, 23 Apr 2026 11:01:30 +0100
Message-ID: <20260423100229.2941820-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

Hi; here's the first arm pullreq for the 11.1 cycle. One feature,
quite a bit of refactoring in target/arm, and also I have included
the patches to MAINTAINERS to remove people who aren't active
in the project any more.

thanks
-- PMM

The following changes since commit bb230769b4d01de714bed686161ad39a8f4f3fd1:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-04-22 14:30:04 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260423

for you to fetch changes up to 250c9de780448fd447056ea42c7ebfdb0b32ab92:

  MAINTAINERS: Remove Xie Changlong (2026-04-23 10:39:06 +0100)

----------------------------------------------------------------
target-arm queue:
 * virt: Allow user to specify cache topology
 * target/arm: Move OMAP CP15 register definitions to cpregs-omap.c
 * target/arm: cleanups for single-binary work
 * MAINTAINERS: remove people who are no longer active in the project

----------------------------------------------------------------
Alessandro Ratti (1):
      target/arm: Move OMAP CP15 register definitions to cpregs-omap.c

Alireza Sanaee (8):
      target/arm/tcg: increase cache level for cpu=max
      hw/core/machine: topology functions capabilities added
      hw/arm/virt: add cache hierarchy to device tree
      bios-tables-test: prepare to change ARM ACPI virt PPTT
      acpi: Add parameters to pass cache descriptions to ACPI build_pptt()
      hw/acpi: add cache hierarchy to pptt table
      tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
      Update the ACPI tables based on new aml-build.c

Peter Maydell (27):
      MAINTAINERS: Remove Ahmed Karaman
      MAINTAINERS: Remove Anup Patel
      MAINTAINERS: Remove Beniamino Galvani
      MAINTAINERS: Remove Jeff Cody
      MAINTAINERS: Remove Coiby Xu
      MAINTAINERS: Remove Damien Hedde
      MAINTAINERS: Remove Ed Maste
      MAINTAINERS: Remove Dongjiu Geng
      MAINTAINERS: Remove Huai-Cheng Kuo
      MAINTAINERS: Remove Bastian Koppelmann
      MAINTAINERS: Remove Mahmoud Mandour
      MAINTAINERS: Remove Magnus Damm
      MAINTAINERS: Remove Marcel Apfelbaum
      MAINTAINERS: Remove Aarushi Mehta
      MAINTAINERS: Remove Paul Burton
      MAINTAINERS: Remove Jia Liu
      MAINTAINERS: Remove Qiuhao Li
      MAINTAINERS: Remove Luigi Rizzo
      MAINTAINERS: Remove Ronnie Sahlberg
      MAINTAINERS: Remove Ryo ONODERA
      MAINTAINERS: Remove Shannon Zhao
      MAINTAINERS: Remove Su Hang
      MAINTAINERS: Remove Vijai Kumar K
      MAINTAINERS: Remove Yanan Wang
      MAINTAINERS: Remove Wen Congyang
      MAINTAINERS: Remove Xiao Guangrong
      MAINTAINERS: Remove Xie Changlong

Philippe Mathieu-Daudé (2):
      target/arm: Replace target_ulong -> vaddr in guarded_page_br()
      target/arm: Remove target_ulong use in hvf_handle_psci_call()

Pierrick Bouvier (21):
      include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
      target/arm/translate.h: remove tcg-op.h include
      target/arm/tcg/translate.h: remove tcg-op-gvec.h include
      target/arm/tcg/translate.h: remove TARGET_AARCH64
      target/arm/tcg/translate-vfp.c: make compilation unit common
      target/arm/tcg/translate-neon.c: make compilation unit common
      target/arm/tcg/translate-mve.c: make compilation unit common
      target/arm/tcg/translate-m-nocp.c: make compilation unit common
      target/arm/tcg/op_helper.c: make compilation unit common
      target/arm/tcg/gengvec.c: make compilation unit common
      target/arm/tcg/translate.c: remove MO_TE usage
      target/arm/tcg/translate.c: replace target_ulong with uint32_t
      target/arm/tcg/translate.c: extract aarch64_translate_code()
      tcg/translator: add parameter to translator_loop for current addr type
      target/arm/tcg/translate.c: replace TCGv with TCGv_va
      target/arm/tcg/translate-a64.c: use translator_ldl_end instead of arm_ldl_code
      target/arm/tcg/arm_ldst.h: merge in translate.c
      target/arm/tcg/translate.c: replace translator_ldl_swap with translator_ldl_end
      target/arm/cpu.c: simplify endianness handling in arm_disas_set_info
      target/arm/tcg/translate.c: remove target_ulong
      target/arm/tcg/translate.c: make compilation unit common

 MAINTAINERS                                |  52 +----
 accel/tcg/translate-all.c                  |   1 -
 accel/tcg/translator.c                     |   4 +-
 hw/acpi/aml-build.c                        | 203 ++++++++++++++++-
 hw/arm/virt-acpi-build.c                   |   8 +-
 hw/arm/virt.c                              | 335 ++++++++++++++++++++++++++++-
 hw/core/machine-smp.c                      |  52 +++++
 hw/loongarch/virt-acpi-build.c             |   4 +-
 include/exec/translator.h                  |   4 +-
 include/hw/acpi/aml-build.h                |   4 +-
 include/hw/acpi/cpu.h                      |  10 +
 include/hw/arm/virt.h                      |  17 +-
 include/hw/core/boards.h                   |   5 +
 include/hw/core/cpu.h                      |  12 ++
 include/tcg/tcg-op-mem.h                   | 126 +++++++++++
 include/tcg/tcg-op.h                       | 100 +--------
 target/alpha/translate.c                   |   3 +-
 target/arm/cpregs-omap-stub.c              |  10 +
 target/arm/cpregs-omap.c                   |  88 ++++++++
 target/arm/cpu.c                           |   6 +-
 target/arm/helper.c                        |  79 +------
 target/arm/hvf/hvf.c                       |   2 +-
 target/arm/internals.h                     |   4 +
 target/arm/meson.build                     |   2 +
 target/arm/tcg/arm_ldst.h                  |  47 ----
 target/arm/tcg/cpu64.c                     |  10 +
 target/arm/tcg/helper-a64-defs.h           |   2 +-
 target/arm/tcg/helper-a64.c                |   4 +-
 target/arm/tcg/meson.build                 |  57 +++--
 target/arm/tcg/op_helper.c                 |   1 -
 target/arm/tcg/stubs32.c                   |  24 +++
 target/arm/tcg/translate-a64.c             |  17 +-
 target/arm/tcg/translate-sme.c             |   1 +
 target/arm/tcg/translate-sve.c             |   1 +
 target/arm/tcg/translate.c                 |  73 ++++---
 target/arm/tcg/translate.h                 |  14 +-
 target/avr/translate.c                     |   3 +-
 target/hexagon/translate.c                 |   3 +-
 target/hppa/translate.c                    |   3 +-
 target/i386/tcg/translate.c                |   3 +-
 target/loongarch/tcg/translate.c           |   3 +-
 target/m68k/translate.c                    |   3 +-
 target/microblaze/translate.c              |   3 +-
 target/mips/tcg/translate.c                |   3 +-
 target/or1k/translate.c                    |   3 +-
 target/ppc/translate.c                     |   3 +-
 target/riscv/translate.c                   |   3 +-
 target/rx/translate.c                      |   3 +-
 target/s390x/tcg/translate.c               |   3 +-
 target/sh4/translate.c                     |   3 +-
 target/sparc/translate.c                   |   3 +-
 target/tricore/translate.c                 |   3 +-
 target/xtensa/translate.c                  |   3 +-
 tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 516 bytes
 tests/qtest/bios-tables-test.c             |   4 +
 55 files changed, 1071 insertions(+), 366 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/cpregs-omap-stub.c
 create mode 100644 target/arm/cpregs-omap.c
 create mode 100644 target/arm/tcg/stubs32.c

