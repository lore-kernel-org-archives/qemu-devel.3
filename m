Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28E2C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpUZn-0005h6-Ca; Wed, 27 Mar 2024 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpUZc-0005g7-Jr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:48:17 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpUZZ-0007CC-9f
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:48:15 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a472f8c6a55so700906066b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711550889; x=1712155689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8w/mBlksrmJvpzXPaLwKFGcFca2NEenJ/Vc3d6zn4nw=;
 b=bzhjnYuPYFQ8yTs8rb9pysFjhGeBCZvxsHLE4ugBzERTZeR2SX3DzdxbSnvYZyofda
 8lmjbw65RfKHJ5PykBl7vAVtASCS06mV/IRg8mglBZFxD94ljwSG6x4XfrVSLWmNM2L5
 y+DlUDiwVgEiqXBNROYkflyNedW2sTBQyuKD0ry0j6Gg+W4u4IC1flEcQdK0HWTn8tVU
 geAR2ZnWKURLcJRS5Q+dmq1yYh7w3wlkn3g96Uz/dFeTjzLn1tJCrvsOpqwSijSMLa3l
 MS9b+deLXcyUVP6A5nl02N3OiNp8a0vC6ls2e9Q4CHTEf3bHFM3uc0cTc69LNorbQPTh
 Baaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711550889; x=1712155689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8w/mBlksrmJvpzXPaLwKFGcFca2NEenJ/Vc3d6zn4nw=;
 b=HMGUgQfwtVkBimvoE0VHl1Y92364Gxo6jhwOyewTrNlO8YGks9xJ9MK1T66QzXQZTR
 b4Qm48syVQdS+APth3Qu4diwm6Ytu/wWxCJpXIeszR0nHyic/sNmRIWRIySbTCrYpn90
 X0NKaZaQi1VsCYPmohWRs8oMM9Djw9Mp4wH1o2g8l/rwp/5k+zNTUd27hb6ZIBNE0+5G
 llOs1gwxfRy+f2zifJ2mXzRdbfiENfQRRs/UykYpFYHfQ9VU+LL5GLdZ9veCxFqfqFfm
 DkHpANcJjkPBNNO25cxLkn9/C3gPe9Pzbnji4RP9P9vEy0OhvzEi/a3g4ytLcNdmM6pG
 IBvg==
X-Gm-Message-State: AOJu0YyrjSwqatsLx5onhzr5i3nCJam8aHn6zeR083sEYr7E3nlZyFPI
 RlgBkI9k0FiZAVjKuX5pzbdhPGYvj5V6unwrPThzCcXUftDCYadGySx1DJYNVyBCq1PBC/mTvlQ
 l
X-Google-Smtp-Source: AGHT+IGtjZIshiKlCQESvL1mLZFwhKk928LYZmorWt5YK2cZIk2nU+fi/FkOK0j3aKOYKgLEsPTVEw==
X-Received: by 2002:a17:906:d0c8:b0:a46:cbf3:a674 with SMTP id
 bq8-20020a170906d0c800b00a46cbf3a674mr2026513ejb.21.1711550889586; 
 Wed, 27 Mar 2024 07:48:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a1709060fd300b00a45ff5a30cesm5548706ejk.183.2024.03.27.07.48.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 07:48:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, Laurent Vivier <laurent@vivier.eu>,
 Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 0/3] target/nios2: Remove the deprecated Nios II
 target
Date: Wed, 27 Mar 2024 15:48:03 +0100
Message-ID: <20240327144806.11319-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Since v1:
- Remove user emulation too
- Remove ALTERA_TIMER

Philippe Mathieu-Daudé (3):
  fpu/softfloat: Remove mention of TILE-Gx target
  target/nios2: Remove the deprecated Nios II target
  hw/timer: Remove the ALTERA_TIMER model

 MAINTAINERS                                   |   13 -
 docs/about/deprecated.rst                     |   11 -
 docs/about/emulation.rst                      |    7 -
 docs/about/removed-features.rst               |   14 +
 docs/system/replay.rst                        |    2 +-
 docs/user/main.rst                            |    4 -
 configure                                     |    2 -
 configs/devices/nios2-softmmu/default.mak     |    6 -
 configs/targets/nios2-linux-user.mak          |    1 -
 configs/targets/nios2-softmmu.mak             |    2 -
 meson.build                                   |    2 -
 qapi/machine.json                             |    2 +-
 hw/nios2/boot.h                               |   10 -
 include/disas/dis-asm.h                       |    5 -
 include/exec/poison.h                         |    2 -
 include/exec/user/abitypes.h                  |    3 +-
 include/hw/intc/nios2_vic.h                   |   66 -
 include/sysemu/arch_init.h                    |    1 -
 linux-user/nios2/sockbits.h                   |    1 -
 linux-user/nios2/syscall_nr.h                 |  333 --
 linux-user/nios2/target_cpu.h                 |   49 -
 linux-user/nios2/target_elf.h                 |   14 -
 linux-user/nios2/target_errno_defs.h          |    7 -
 linux-user/nios2/target_fcntl.h               |   11 -
 linux-user/nios2/target_mman.h                |   11 -
 linux-user/nios2/target_prctl.h               |    1 -
 linux-user/nios2/target_proc.h                |    1 -
 linux-user/nios2/target_resource.h            |    1 -
 linux-user/nios2/target_signal.h              |    9 -
 linux-user/nios2/target_structs.h             |    1 -
 linux-user/nios2/target_syscall.h             |   37 -
 linux-user/nios2/termbits.h                   |    1 -
 linux-user/syscall_defs.h                     |    4 +-
 target/nios2/cpu-param.h                      |   20 -
 target/nios2/cpu-qom.h                        |   18 -
 target/nios2/cpu.h                            |  301 --
 target/nios2/helper.h                         |   32 -
 target/nios2/mmu.h                            |   52 -
 tests/tcg/nios2/semicall.h                    |   28 -
 disas/nios2.c                                 | 3514 -----------------
 hw/intc/nios2_vic.c                           |  313 --
 hw/nios2/10m50_devboard.c                     |  181 -
 hw/nios2/boot.c                               |  234 --
 hw/nios2/generic_nommu.c                      |  101 -
 hw/timer/altera_timer.c                       |  244 --
 linux-user/elfload.c                          |   99 -
 linux-user/nios2/cpu_loop.c                   |  157 -
 linux-user/nios2/signal.c                     |  210 -
 target/nios2/cpu.c                            |  410 --
 target/nios2/helper.c                         |  371 --
 target/nios2/mmu.c                            |  216 -
 target/nios2/monitor.c                        |   35 -
 target/nios2/nios2-semi.c                     |  230 --
 target/nios2/op_helper.c                      |  119 -
 target/nios2/translate.c                      | 1107 ------
 tests/qtest/machine-none-test.c               |    1 -
 fpu/softfloat-specialize.c.inc                |    2 +-
 .gitlab-ci.d/buildtest.yml                    |    4 +-
 .gitlab-ci.d/crossbuild-template.yml          |    2 +-
 .gitlab-ci.d/crossbuilds.yml                  |    2 +-
 disas/meson.build                             |    1 -
 hw/Kconfig                                    |    1 -
 hw/intc/Kconfig                               |    3 -
 hw/intc/meson.build                           |    1 -
 hw/meson.build                                |    1 -
 hw/nios2/Kconfig                              |   13 -
 hw/nios2/meson.build                          |    6 -
 hw/timer/Kconfig                              |    4 -
 hw/timer/meson.build                          |    1 -
 qemu-options.hx                               |    8 +-
 scripts/coverity-scan/COMPONENTS.md           |    3 -
 scripts/gensyscalls.sh                        |    1 -
 scripts/probe-gdb-support.py                  |    1 -
 target/Kconfig                                |    1 -
 target/meson.build                            |    1 -
 target/nios2/Kconfig                          |    3 -
 target/nios2/meson.build                      |   17 -
 target/nios2/trace-events                     |   10 -
 tests/avocado/boot_linux_console.py           |    8 -
 tests/avocado/replay_kernel.py                |   11 -
 tests/docker/Makefile.include                 |    5 -
 .../debian-nios2-cross.d/build-toolchain.sh   |   87 -
 tests/tcg/nios2/10m50-ghrd.ld                 |   70 -
 tests/tcg/nios2/Makefile.softmmu-target       |   32 -
 tests/tcg/nios2/Makefile.target               |   11 -
 tests/tcg/nios2/boot.S                        |  218 -
 tests/tcg/nios2/intr.S                        |   31 -
 tests/tcg/nios2/test-shadow-1.S               |   40 -
 88 files changed, 28 insertions(+), 9198 deletions(-)
 delete mode 100644 configs/devices/nios2-softmmu/default.mak
 delete mode 100644 configs/targets/nios2-linux-user.mak
 delete mode 100644 configs/targets/nios2-softmmu.mak
 delete mode 100644 hw/nios2/boot.h
 delete mode 100644 include/hw/intc/nios2_vic.h
 delete mode 100644 linux-user/nios2/sockbits.h
 delete mode 100644 linux-user/nios2/syscall_nr.h
 delete mode 100644 linux-user/nios2/target_cpu.h
 delete mode 100644 linux-user/nios2/target_elf.h
 delete mode 100644 linux-user/nios2/target_errno_defs.h
 delete mode 100644 linux-user/nios2/target_fcntl.h
 delete mode 100644 linux-user/nios2/target_mman.h
 delete mode 100644 linux-user/nios2/target_prctl.h
 delete mode 100644 linux-user/nios2/target_proc.h
 delete mode 100644 linux-user/nios2/target_resource.h
 delete mode 100644 linux-user/nios2/target_signal.h
 delete mode 100644 linux-user/nios2/target_structs.h
 delete mode 100644 linux-user/nios2/target_syscall.h
 delete mode 100644 linux-user/nios2/termbits.h
 delete mode 100644 target/nios2/cpu-param.h
 delete mode 100644 target/nios2/cpu-qom.h
 delete mode 100644 target/nios2/cpu.h
 delete mode 100644 target/nios2/helper.h
 delete mode 100644 target/nios2/mmu.h
 delete mode 100644 tests/tcg/nios2/semicall.h
 delete mode 100644 disas/nios2.c
 delete mode 100644 hw/intc/nios2_vic.c
 delete mode 100644 hw/nios2/10m50_devboard.c
 delete mode 100644 hw/nios2/boot.c
 delete mode 100644 hw/nios2/generic_nommu.c
 delete mode 100644 hw/timer/altera_timer.c
 delete mode 100644 linux-user/nios2/cpu_loop.c
 delete mode 100644 linux-user/nios2/signal.c
 delete mode 100644 target/nios2/cpu.c
 delete mode 100644 target/nios2/helper.c
 delete mode 100644 target/nios2/mmu.c
 delete mode 100644 target/nios2/monitor.c
 delete mode 100644 target/nios2/nios2-semi.c
 delete mode 100644 target/nios2/op_helper.c
 delete mode 100644 target/nios2/translate.c
 delete mode 100644 hw/nios2/Kconfig
 delete mode 100644 hw/nios2/meson.build
 delete mode 100644 target/nios2/Kconfig
 delete mode 100644 target/nios2/meson.build
 delete mode 100644 target/nios2/trace-events
 delete mode 100755 tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
 delete mode 100644 tests/tcg/nios2/10m50-ghrd.ld
 delete mode 100644 tests/tcg/nios2/Makefile.softmmu-target
 delete mode 100644 tests/tcg/nios2/Makefile.target
 delete mode 100644 tests/tcg/nios2/boot.S
 delete mode 100644 tests/tcg/nios2/intr.S
 delete mode 100644 tests/tcg/nios2/test-shadow-1.S

-- 
2.41.0


