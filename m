Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8C4C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRc-0005w8-08; Fri, 04 Jul 2025 06:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRK-0005un-VY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRI-00067l-7e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so321265f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624077; x=1752228877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ex4O63sW1cGt77pstCPqttu2EkRGa6s1dyrnHgN3lsM=;
 b=N7Uuaq2u9Ab1hjIOP3jAwvNi08f7fkWFuARsVE46SzwR4dcOKnS24u2us1qGC+dAQm
 YTD8TgGIkI2aYRSmGcU3V67k84zG1hUt4Ux3xxICvzLUhI3BBpfc7tINL1aCJAXZ8++l
 UHhSutjlfoiLOX4yD3iP81M6FpY6d6ypXVXXA/xIo9TuRMH2yyO4QJJ00UBFj0aaRY0s
 dxontcE97iYUoo5dHPV+SJ26uh5cSlGOcwvcehBINmz8k3sJWyQNdH8iT8Q01XkVkDbc
 cB9sbopD7d8M6pHoB1v80S8eqUlDA4n2EqwLhbrD92On1d7SlMSqwNSQcPSrfZFuyqiT
 6QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624077; x=1752228877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ex4O63sW1cGt77pstCPqttu2EkRGa6s1dyrnHgN3lsM=;
 b=MrlX3uLI7tjAxVsWo5MFONiEewUPB4MU7avOgED8k08NGhXY6qL06JZyFm6UPSsPH0
 RYrv5eVoacQ0M9vQ6/1Q1C02XSO4rAz6CUZwSRwpeclCEWuvn8Pzf2lR2rrzKzQSCbyU
 Eu37Nu69/XnEDMk7rfDGfjlxrwTcskHGfB8NQ1XDP8+0o3yRmAdy9W7WqkPtCWUMcQmA
 2HEzCSz0ATocdy7iNXULUqY+C+g/nR/cYqWld2ClUdOfjUaTtiluDdxtlMLymFZX1ozk
 +/9eU7amcoFCbig0HvkdcJYercwTdrUWq9JLd+7uJVewb/5V1+Bk+VwT89Lm+tJd2YQo
 Nvpw==
X-Gm-Message-State: AOJu0YxxyHd0G+8OEi77mkjqjeRMmLVirQFcrEuGr660O3mB18fhJ5/i
 Og04kFOZxuXPfyCwkqvlSnJc9zDkchKwxVqXIQuH7q803r6hCY3OYkTdcXENwyVCN1f+QRP6a56
 OpVmdRHk=
X-Gm-Gg: ASbGnctCDjudv/mWpMSfYAKMMfySmzFt2A5PtI6Eh+GQd+XWvUblG9FxXEeNCYvo4Lv
 L2LfabrBFuA6+nzMKSzF2wjmja3gBnnUGpVMpfp6CJI05riXhPcKaU2vx7/nNYiN5a0a6Re74wH
 lHTVgZUqniWNeKoxmsll/URuP92WG2jOGnoLkOxRrpd4piV8b5leA36IrW9BIy7GAxzYKOVJZQZ
 BL3GV/ffo/cNfkpp0BHeF6cc4jgRjnZg4SwEbQ1UQGAmueAmq4cpbsvPUuvC7it2zoFWLFMzW84
 SqkQ5j1ImgCCTG6a6yqrDcEwt/COJmULegzRkJIpu5/1FARTu/4ftpgPPEQKfysr/nEFMO0yZZh
 Fe9m44a+qkzxF7ORZQEqwhctGlzq5e4XvWlAd
X-Google-Smtp-Source: AGHT+IE2XSvOyI8lWaYgiKHSEXhl0ZIacd2EgycI9NFXvOdKQYtQkjNRYStufeXWx1bpiIJcmxzU6w==
X-Received: by 2002:a5d:64ca:0:b0:3a4:e4ee:4ca9 with SMTP id
 ffacd0b85a97d-3b4964f5e08mr1775319f8f.23.1751624076664; 
 Fri, 04 Jul 2025 03:14:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97732sm2140903f8f.59.2025.07.04.03.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:14:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/31] Accelerators patches for 2025-07-04
Date: Fri,  4 Jul 2025 12:14:01 +0200
Message-ID: <20250704101433.8813-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The following changes since commit c77283dd5d79149f4e7e9edd00f65416c648ee59:

  Merge tag 'pull-request-2025-07-02' of https://gitlab.com/thuth/qemu into staging (2025-07-03 06:01:41 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20250704

for you to fetch changes up to d7fffb0c8a498cd0a184832e4e2c24251dbff7c0:

  hmp-cmds-target.c: add CPU_DUMP_VPU in hmp_info_registers() (2025-07-04 12:08:44 +0200)

----------------------------------------------------------------
Accelerators patches

- Generic API consolidation, cleanups (dead code removal, documentation added)
- Remove monitor TCG 'info opcount' and @x-query-opcount
- Have HVF / NVMM / WHPX use generic CPUState::vcpu_dirty field
- Expose nvmm_enabled() and whpx_enabled() to common code
- Have hmp_info_registers() dump vector registers

----------------------------------------------------------------

Daniel Henrique Barboza (1):
  hmp-cmds-target.c: add CPU_DUMP_VPU in hmp_info_registers()

Philippe Mathieu-Daudé (30):
  system/cpus: Assert interrupt handling is done with BQL locked
  accel/kvm: Remove kvm_init_cpu_signals() stub
  accel/kvm: Reduce kvm_create_vcpu() declaration scope
  accel/tcg: Remove 'info opcount' and @x-query-opcount
  accel/tcg: Remove profiler leftover
  accel/tcg: Factor tcg_dump_flush_info() out
  accel/tcg: Factor tcg_dump_stats() out for re-use
  accel/hvf: Restrict internal declarations
  accel/hvf: Move per-cpu method declarations to hvf-accel-ops.c
  accel/hvf: Move generic method declarations to hvf-all.c
  cpus: Document CPUState::vcpu_dirty field
  accel/hvf: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/whpx: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/kvm: Remove kvm_cpu_synchronize_state() stub
  accel/system: Document cpu_synchronize_state()
  accel/system: Document cpu_synchronize_state_post_init/reset()
  accel/nvmm: Expose nvmm_enabled() to common code
  accel/whpx: Expose whpx_enabled() to common code
  accel/dummy: Extract 'dummy-cpus.h' header from 'system/cpus.h'
  accel: Expose and register generic_handle_interrupt()
  accel: Keep reference to AccelOpsClass in AccelClass
  accel: Propagate AccelState to AccelClass::init_machine()
  accel/tcg: Prefer local AccelState over global current_accel()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/kvm: Directly pass KVMState argument to do_kvm_create_vm()
  accel: Directly pass AccelState argument to AccelClass::has_memory()
  accel: Remove unused MachineState argument of AccelClass::setup_post()
  accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
  MAINTAINERS: Add me as reviewer of overall accelerators section

 MAINTAINERS                       |   4 +
 qapi/machine.json                 |  18 --
 accel/dummy-cpus.h                |  14 ++
 accel/tcg/internal-common.h       |   2 +
 include/hw/core/cpu.h             |   3 +-
 include/qemu/accel.h              |  11 +-
 include/system/accel-ops.h        |  22 ++-
 include/system/cpus.h             |   5 -
 include/system/hvf.h              |  38 ----
 include/system/hvf_int.h          |  35 +++-
 include/system/hw_accel.h         |  21 +-
 include/system/kvm.h              |   8 -
 include/system/nvmm.h             |  23 +--
 include/system/whpx.h             |  27 +--
 accel/accel-common.c              |   2 +-
 accel/accel-system.c              |   7 +-
 accel/dummy-cpus.c                |   1 +
 accel/hvf/hvf-accel-ops.c         | 314 ++++--------------------------
 accel/hvf/hvf-all.c               | 277 ++++++++++++++++++++++++--
 accel/kvm/kvm-accel-ops.c         |   1 +
 accel/kvm/kvm-all.c               |  27 +--
 accel/qtest/qtest.c               |   4 +-
 accel/stubs/kvm-stub.c            |   9 -
 accel/stubs/nvmm-stub.c           |  12 ++
 accel/stubs/whpx-stub.c           |  12 ++
 accel/tcg/monitor.c               |  57 ++----
 accel/tcg/tcg-accel-ops.c         |   6 +-
 accel/tcg/tcg-all.c               |   6 +-
 accel/xen/xen-all.c               |   6 +-
 bsd-user/main.c                   |   2 +-
 linux-user/main.c                 |   2 +-
 monitor/hmp-cmds-target.c         |   4 +-
 system/cpus.c                     |  12 +-
 system/memory.c                   |   2 +-
 target/arm/hvf/hvf.c              |   4 +-
 target/i386/hvf/hvf.c             |   4 +-
 target/i386/hvf/x86hvf.c          |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c |   1 +
 target/i386/nvmm/nvmm-all.c       |  31 ++-
 target/i386/whpx/whpx-accel-ops.c |   1 +
 target/i386/whpx/whpx-all.c       |  32 ++-
 tests/qtest/qmp-cmd-test.c        |   1 -
 accel/stubs/meson.build           |   2 +
 hmp-commands-info.hx              |  14 --
 44 files changed, 551 insertions(+), 535 deletions(-)
 create mode 100644 accel/dummy-cpus.h
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c

-- 
2.49.0


