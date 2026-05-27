Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C3DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBXC-0002VG-0w; Wed, 27 May 2026 06:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXA-0002Uk-5f
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:30:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBX8-0000RX-2e
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:30:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so6823367f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877840; x=1780482640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rt6h1Uj4mU1NjlkJ31k12U1Y1gI1H2BlvErbNjtXemo=;
 b=UYszPiwp09btuYQq5/kuqPO0Ni3FvOUMbaFBXvBbaU+xwh3bV3UBZ3tI7DZjlDTz2z
 ENy7oH8WxYu1otL3yTyyI05xAYweH6OKp0fu0qleVjcy9UOSyXkKNpvmxLBDeRcpGslO
 rjOKnUeE6SSABzYjreyPHgxrWCZ7Me2xr3Paq6fc0DeYj/svAVGfcKUVgJbim51FIQi0
 B1mq5bPUc0cjIqPBfzL3v+jdOui0MvhDq+2jOH5SVQLwo5OLJzS/SWZzfJ3lXvDRSQFl
 /k5XVWotJPGRlsHSFkAGIgUHOiG1bFOqgaG/HNCc44kKbKWBCyq6kbFZ7SOoS/UHEhSy
 Mx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877840; x=1780482640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rt6h1Uj4mU1NjlkJ31k12U1Y1gI1H2BlvErbNjtXemo=;
 b=ggV+logTKRcwjn3y6uyLr/4SQ/lUY4htY/dfznIUE/ybSYc87gTUpOUHSvHh7OJlMy
 edh163jpO9BQO0KNl0K3f1ubKyvA49Ck6eTvzmMDAlPrVn7rrk7KGT50X3llOYVd0EN1
 B7twqQUqeAYUHu7qmgeFUd5zKg1EFN1Nq8Jf8C8DDCtB5ETFvRIRzEH6UorcstwL3NCh
 TqR1MYSe4E7jdIld0DStn7a1fiJ1uqEd0YV4cisJPzU+Bk6t+L4ebEY6hb1+U5F7fJYr
 8QT4SU3VdR8/y3gpF5csyz+O/opiQuMhzZ77Og+XjqA9Kj+OqR8FHyjucgyjNSA9Kx88
 F1zg==
X-Gm-Message-State: AOJu0Yyh7ivHwe4Rao7LlXjnP1kK0eTE+WgYukJghDKCPy3q7JwF+Y3y
 oNKMbcYcVidt6uS4nAMjHm677+dlYvuXbWH53wk4mGluNj1U982mFmSr5ko2Kdxr6sjYtSudqbo
 4Nuxp4nWl0YZ8
X-Gm-Gg: Acq92OFceDAAq3K4CYcdZOIrPx4BxuG0q0Z/YAv4TQoBNHHVIIuobrxIl7gWZzvoJfG
 Ph0jWCYSQg2fQVliq8AfWKwN6eAqkokU8IEOUQiY0l4vD7dC19k4VR7jelR57zNVVs1M3CW76YE
 tlSeOsPAoT11+PcewwnpDifch58rVWYfzWNp1mmvV916uiXONY/AFlUR1UHIOpm1KrypFWnb3BF
 2ZRy84X8A8m/ttm5OUFHbhSsSb6ckshNmwlGcs7huEiVsCW1aXluGh9E1YPGz6UL0ZkTPimDO7G
 JVFCGq/ybJgCRxdZY7FaqPZ/osXdKPefGe7bCFDE/cfQinUO8Fk02XdX/c0o0gA2UG6bQYqyMxy
 ft+9Y+z6GEsSyYOjHVgZF8/8ycuLDBvtHfHFs24aVr7SZU1ucUU0hvFD1IXS3yl0xG9rfJCWTAK
 lXY9IfxRY6souvBbstQNoJy6J+6iVYqxKW09woObyy71zqIFKxwu4zJ33sDhRkZYJFaA==
X-Received: by 2002:a05:6000:26d1:b0:451:1143:7df5 with SMTP id
 ffacd0b85a97d-45eb38e041fmr39380475f8f.41.1779877839522; 
 Wed, 27 May 2026 03:30:39 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb548dfasm4820593f8f.4.2026.05.27.03.30.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:30:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] Single binary patches for 2026-05-27
Date: Wed, 27 May 2026 12:30:04 +0200
Message-ID: <20260527103037.4461-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

The following changes since commit 3f89b5de5b1ff16873bcda7d5f3ff5b9164f691e:

  Merge tag 'pull-target-arm-20260526' of https://gitlab.com/pm215/qemu into staging (2026-05-26 13:20:15 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260527

for you to fetch changes up to 5505e1cd0248fd87cbdbb16bb322a34db16d3e98:

  MAINTAINERS: Update PhilMD's email address (2026-05-27 12:27:22 +0200)

All following checkpatch.pl warnings ignored since files are covered:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

----------------------------------------------------------------
Various patches related to single binary effort:

- Preparatory patches to build RISCV machines once
- Build ARM machines once
- Build ARM 'max' CPU once
- Few MAINTAINERS updates
----------------------------------------------------------------

Anton Blanchard (1):
  target/riscv: Use float_raise

Anton Johansson (6):
  hw/riscv: Register generic riscv[32|64] QOM interfaces
  hw/riscv: Add macros and globals for simplifying machine definitions
  hw/core: Add riscv[32|64] to "none" machine
  hw/riscv: Filter machine types for qemu-system-riscv32/64 binaries
  configs/target: Implement per-binary TargetInfo structure for riscv
  target-info: Add target_riscv64()

Brian Cain (1):
  MAINTAINERS: update qualcomm git tree URL

Djordje Todorovic (1):
  target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit masks

Philippe Mathieu-Daudé (23):
  hw/riscv/spike: Use 'max' CPU type by default
  target/hppa: Use DisasContext::mo_align in system emulation
  target/hppa: Inline UNALIGN() macro
  hw/arm/raspi: Initialize 64-bit CPU types during DeviceRealize()
  hw/arm/raspi: Build objects once
  hw/arm/aspeed: Do not realize 64-bit CPU types under QTest
  hw/arm/aspeed: Build objects once
  hw/arm/meson: Remove now unused arm_ss[] source set
  target/arm: Introduce common system/user meson source set
  target/arm: Build gdbstub64.o as common object
  target/arm: Build cpu64.o as common object
  target/arm: Extract common code related to 'max' CPU
  target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU type
  target/arm: Implement DBGDEVID* registers in max AArch32 CPU
  target/arm: Only set %kvm_target when KVM is enabled
  target/arm: Factor aarch64_aa32_a57_init() out
  target/arm: Re-use common aarch64_aa32_a57_init() helper
  target/arm: Define 'max' CPU type in cpu-max.c
  target/arm: Build cpu32-system.o as common object
  target/arm: Build cpu-max.c once
  tests/tcg: Explicitly check for 64-bit z/Architecture
  MAINTAINERS: Remove PhilMD from firmware sections
  MAINTAINERS: Update PhilMD's email address

 MAINTAINERS                                |  67 +++---
 include/hw/riscv/machines-qom.h            |  46 ++++
 include/qemu/target-info.h                 |   7 +
 target/arm/internals.h                     |   2 +
 target/riscv/cpu_bits.h                    |   2 +
 tests/tcg/multiarch/nop_func.h             |   2 +-
 configs/targets/riscv32-softmmu.c          |  26 +++
 configs/targets/riscv64-softmmu.c          |  26 +++
 hw/arm/aspeed_ast27x0.c                    |  14 ++
 hw/arm/bcm2836.c                           |  14 +-
 hw/arm/raspi.c                             |   4 -
 hw/core/null-machine.c                     |   3 +
 hw/riscv/boston-aia.c                      |   3 +-
 hw/riscv/microblaze-v-generic.c            |   3 +-
 hw/riscv/microchip_pfsoc.c                 |   2 +
 hw/riscv/opentitan.c                       |   2 +
 hw/riscv/shakti_c.c                        |   2 +
 hw/riscv/sifive_e.c                        |   2 +
 hw/riscv/sifive_u.c                        |   2 +
 hw/riscv/spike.c                           |   4 +-
 hw/riscv/virt.c                            |   3 +
 hw/riscv/xiangshan_kmh.c                   |   2 +
 target-info-qom.c                          |   9 +
 target-info.c                              |   5 +
 target/arm/cpu-max.c                       | 241 +++++++++++++++++++++
 target/arm/cpu64.c                         |  80 +------
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 174 +--------------
 target/arm/tcg/stubs32.c                   |  10 +
 target/hppa/translate.c                    |  23 +-
 target/riscv/machine.c                     |  19 +-
 target/riscv/vector_helper.c               |  35 ++-
 .mailmap                                   |   7 +-
 configs/targets/meson.build                |   1 +
 contrib/gitdm/group-map-individuals        |   1 +
 hw/arm/meson.build                         |  15 +-
 target/arm/meson.build                     |  26 ++-
 target/arm/tcg/meson.build                 |  57 ++---
 37 files changed, 550 insertions(+), 391 deletions(-)
 create mode 100644 include/hw/riscv/machines-qom.h
 create mode 100644 configs/targets/riscv32-softmmu.c
 create mode 100644 configs/targets/riscv64-softmmu.c
 create mode 100644 target/arm/cpu-max.c
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (81%)

-- 
2.53.0


