Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2130FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPH-0007lJ-Qm; Fri, 04 Jul 2025 09:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPF-0007l3-DV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:24:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPD-0004QR-Ba
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:24:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1359122f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635481; x=1752240281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kL7wBeUF81JHc+Pb8Y0CiYsIaIMOi8w6nzcygz8Z3us=;
 b=eNw3XL5OTPkU7PgACCTSdh83hCj1gi820jIxtc1MDKdGKisleyyYoaIiAvNcVJNPaT
 N0Wko05UTGA7Nfysd+iBMp0badp/166I1koXNoUQXp7X3tTyCZw1qvDj6vkhYUnXQAlQ
 iJCEygpnJlraCkRo+/KgDcHk2JNQe1JDYba1s4OZJ5lhKW0Dhtw1Y6NLj3mOGVRAss0L
 /mIEw2PhVGvi91ck5gQTz62LQ/m0ReXcPgoH1P4+vfRlaKP9owzqMeNcWP/XfvfqoPUN
 DEX8EiWKerN1Dr3Q1x78ados7XdxnV55/7RS+o/gnZb1+GUZUgkuAQ6XxXYJRGd9bw3e
 SG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635481; x=1752240281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kL7wBeUF81JHc+Pb8Y0CiYsIaIMOi8w6nzcygz8Z3us=;
 b=CbBdwNlbmq/e13neHeX13BAYUfke7JVah7wX1uyKO3FZ88ItU2+F0hR8P7NDDY90rj
 /QIZMW03rAnT6Ir14Ss+gf0UvEwAEtJsg5kH9Hkbl/OuYVgkOhrh2jbIIWcd3Q+Hsfca
 KuNm0UltyyC/bwRRssm7zzjrd/UICcW3k90LOR4iAlaP1yC1yqdZAirZXc6LKeDY42iN
 DaqInYVdQJ7Nev01QcMqTVXckkhXhYlbLFJIEcuFqVvz/ViZwKqVJ7/JrDx/Es3T15sP
 5uUFXw9k/O3C8iDHKbFZ82SScBp7JW5T7dRLHEllzub5cMK7Tmq/0caZd5T1oTKkHlgZ
 DCVg==
X-Gm-Message-State: AOJu0Ywnwh5cphlQ+Cd03i31Xow4T7AMOFHSSs84Sn99k3tlWt1L4J2t
 F/z02HfLxGovjm1k7xfVHitWYhCUuPh2/rtllISXLRBMcSC7WGbul5BApyjiaFb/3uh+2k802Ut
 qk2DQ
X-Gm-Gg: ASbGnctklgoawRk2YErfHkzaCPoE4dTmFKVrofwLfh9z6CkDJh2PnOQqLH/veHDGNnp
 a/cZRSZLR3m2TLAfpmxhprPsssH5hZu/yqd0LSaWnBZcD0MiCz8WVrDO1sgNFgtNeYEOP/g/vnS
 NV6mPSfloKBD0L9vRpKp+v1lhc+kqS4RylPBgiLWbkef3JHJsDTfhLAjnnbTROaltTO6H22jQgL
 lFc2OnCwhLzxcoaN3dHg+FYVueZWxSs1d7umkCjq/bKDWceJl03KPXhGlfUeuopcVsjsr5O6o+a
 gXzg9m3ZoGjmZ3D4GTGsSiuWBs0ZdQqb3j0gCyzYjEYS5VD6cTSnDEb+C3FvxeCb40WdV8LlJ87
 PqfjrXF+Ibo2iojHz8MSBRgCRWcUL0Y8rRu9h1gzXcdJGw6UUWaez
X-Google-Smtp-Source: AGHT+IG+jUIzZkc4cFbVz1Pij9dy2Xs3ZHiut/PjJHyV4MJ7JhZ7+CCOQ3pgwRyDcy4lGluKXAL+1w==
X-Received: by 2002:a05:6000:40cb:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3b4955752fbmr2686134f8f.15.1751635481026; 
 Fri, 04 Jul 2025 06:24:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1687488sm26640835e9.25.2025.07.04.06.24.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:24:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/36] Accelerators patches for 2025-07-04
Date: Fri,  4 Jul 2025 15:24:33 +0200
Message-ID: <20250704132439.25743-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

for you to fetch changes up to 569efc2cd64fd7a1f9112e200f2ada20ba1af087:

  MAINTAINERS: Add me as reviewer of overall accelerators section (2025-07-04 15:22:04 +0200)

----------------------------------------------------------------
Accelerators patches

- Generic API consolidation, cleanups (dead code removal, documentation added)
- Remove monitor TCG 'info opcount' and @x-query-opcount
- Have HVF / NVMM / WHPX use generic CPUState::vcpu_dirty field
- Expose nvmm_enabled() and whpx_enabled() to common code
- Report missing com.apple.security.hypervisor entitlement
- Have hmp_info_registers() dump vector registers

----------------------------------------------------------------

Daniel Henrique Barboza (1):
  monitor/hmp-cmds-target: add CPU_DUMP_VPU in hmp_info_registers()

Philippe Mathieu-Daudé (35):
  system/cpus: Assert interrupt handling is done with BQL locked
  accel/kvm: Remove kvm_init_cpu_signals() stub
  accel/kvm: Reduce kvm_create_vcpu() declaration scope
  accel/tcg: Remove 'info opcount' and @x-query-opcount
  accel/tcg: Remove profiler leftover
  accel/tcg: Factor tcg_dump_flush_info() out
  accel/tcg: Factor tcg_dump_stats() out for re-use
  accel/tcg: Clear exit_request once in tcg_cpu_exec()
  accel/tcg: Unregister the RCU before exiting RR thread
  accel/hvf: Restrict internal declarations
  accel/hvf: Move per-cpu method declarations to hvf-accel-ops.c
  accel/hvf: Move generic method declarations to hvf-all.c
  accel/hvf: Report missing com.apple.security.hypervisor entitlement
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
  accel/hvf: Re-use QOM allocated state
  accel/tcg: Prefer local AccelState over global current_accel()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/kvm: Directly pass KVMState argument to do_kvm_create_vm()
  accel: Directly pass AccelState argument to AccelClass::has_memory()
  accel: Remove unused MachineState argument of AccelClass::setup_post()
  accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
  accel/system: Convert pre_resume() from AccelOpsClass to AccelClass
  MAINTAINERS: Add me as reviewer of overall accelerators section

 MAINTAINERS                       |   4 +
 qapi/machine.json                 |  18 --
 accel/dummy-cpus.h                |  14 ++
 accel/tcg/internal-common.h       |   2 +
 include/hw/core/cpu.h             |   3 +-
 include/qemu/accel.h              |  14 +-
 include/system/accel-ops.h        |  23 ++-
 include/system/cpus.h             |   5 -
 include/system/hvf.h              |  38 ----
 include/system/hvf_int.h          |  35 +++-
 include/system/hw_accel.h         |  21 +-
 include/system/kvm.h              |   8 -
 include/system/nvmm.h             |  23 +--
 include/system/whpx.h             |  27 +--
 target/i386/whpx/whpx-accel-ops.h |   1 -
 accel/accel-common.c              |   2 +-
 accel/accel-system.c              |  16 +-
 accel/dummy-cpus.c                |   1 +
 accel/hvf/hvf-accel-ops.c         | 314 ++++--------------------------
 accel/hvf/hvf-all.c               | 280 ++++++++++++++++++++++++--
 accel/kvm/kvm-accel-ops.c         |   1 +
 accel/kvm/kvm-all.c               |  27 +--
 accel/qtest/qtest.c               |   4 +-
 accel/stubs/kvm-stub.c            |   9 -
 accel/stubs/nvmm-stub.c           |  12 ++
 accel/stubs/whpx-stub.c           |  12 ++
 accel/tcg/monitor.c               |  57 ++----
 accel/tcg/tcg-accel-ops-mttcg.c   |   1 -
 accel/tcg/tcg-accel-ops-rr.c      |   2 +
 accel/tcg/tcg-accel-ops.c         |   9 +-
 accel/tcg/tcg-all.c               |   6 +-
 accel/xen/xen-all.c               |   6 +-
 bsd-user/main.c                   |   2 +-
 linux-user/main.c                 |   2 +-
 monitor/hmp-cmds-target.c         |   4 +-
 system/cpus.c                     |  16 +-
 system/memory.c                   |   2 +-
 target/arm/hvf/hvf.c              |   4 +-
 target/i386/hvf/hvf.c             |   4 +-
 target/i386/hvf/x86hvf.c          |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c |   1 +
 target/i386/nvmm/nvmm-all.c       |  31 ++-
 target/i386/whpx/whpx-accel-ops.c |   2 +-
 target/i386/whpx/whpx-all.c       |  35 ++--
 tests/qtest/qmp-cmd-test.c        |   1 -
 accel/stubs/meson.build           |   2 +
 hmp-commands-info.hx              |  14 --
 47 files changed, 574 insertions(+), 543 deletions(-)
 create mode 100644 accel/dummy-cpus.h
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c

-- 
2.49.0


