Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3D6C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUlG-0005se-Gc; Mon, 29 Jan 2024 11:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlD-0005rd-PN
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUl7-0003XS-S6
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so24284925e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546718; x=1707151518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vCVqY5ZcbrGcwmGrIjNGNkPRiID4RQmsjfpymlfmglw=;
 b=n2oI7NnPSMSf62bsvT5SUv6y1tg2Hnb22P6l5T8CkwS0t+mA4p34afqe8pqXdie5/p
 1vPghKC+ttJFMRNcImFZy8NYr8QbK3b8rXnihkX8gbhcznmZqWY/O+vQv++37re+mEwD
 YOANnZNTuaxdY3AHGKRoYv1ewQQJYsNxZXb32OK7ZmVVzZZOcEoKKdFU/CFPkinjysWJ
 k8mF0UTROi7GtVdRQvaYK9NTibqFBUCWeFT7ZEL2h5fW0vI6Q7qo3CUd2UZvN7n0vZtq
 cQt1CKiAhPQtz/t0L9RmthQ6UDZbav/ol70RpfwlGaFdfFW/bPAK4uZS+MG7dCcfYuPJ
 ePsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546718; x=1707151518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vCVqY5ZcbrGcwmGrIjNGNkPRiID4RQmsjfpymlfmglw=;
 b=dmzPpZ/9kliS/AIxdo//EiBr98DY8kLCtGghIyXaAyqJIp88QWvUqzLgi//Uu4sYZp
 a7ZnxrjLniuJnzGm1JvywYI7OIJJiG4G3OXptyamiVdDisSoKvWOIxN1mTxk9jNYC2lq
 q7V4SZFih4wVEvbxgFcpEicmRVxFO+c4gG0nnBn1aWxzYGkJPjsbgjuzZeDRYBgVAnDe
 kaLv0i4oR4bshfTtAvpMBsGv6NsrdfCl8cOMCU+hGAZUy0i34dYRf5DYX3CLprXFcx+g
 7aFsIhGHO/bfLdtSVS3q7VxJRXxQLhPLLmJ1BIOEOHgkybe5H77XMb2XgsgIMn52VDkS
 nadw==
X-Gm-Message-State: AOJu0Yw22k2H6KzCbAoKJdC/KXDBlmQHF+KRZK0W27yvYuazsgdh/neF
 I9+51BS8qXKarMy4a5L8cqFjkPURV0od586WvoJq4tKmVx6J71Hpt9phIsbWyAanQgghIRloGVf
 G
X-Google-Smtp-Source: AGHT+IHhp6C5OVMDIf8r+80qEOHVnusrR4T7FXJcHa2f0MC0ohvE1qSXt1co5kh/gD6LdYJXCRcWMA==
X-Received: by 2002:a05:6000:70c:b0:33a:eb5a:8d00 with SMTP id
 bs12-20020a056000070c00b0033aeb5a8d00mr3477025wrb.26.1706546718105; 
 Mon, 29 Jan 2024 08:45:18 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a5d6203000000b0033ae4df3cf4sm6096969wru.40.2024.01.29.08.45.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:45:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/29] hw,
 target: Prefer fast cpu_env() over slower CPU QOM cast macro
Date: Mon, 29 Jan 2024 17:44:42 +0100
Message-ID: <20240129164514.73104-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Patches missing review: 1, 2, 5, 6, 8, 11, 14, 15, 29

It will be simpler if I get the whole series via my hw-cpus
tree once fully reviewed.

Since v2:
- Rebased
- bsd/linux-user
- Preliminary clean cpu_reset_hold
- Add R-b

Since v1:
- Avoid CPU() cast (Paolo)
- Split per targets (Thomas)

Use cpu_env() -- which is fast path -- when possible.
Bulk conversion using Coccinelle spatch (script included).

Philippe Mathieu-Daudé (29):
  bulk: Access existing variables initialized to &S->F when available
  hw/core: Declare CPUArchId::cpu as CPUState instead of Object
  hw/acpi/cpu: Use CPUState typedef
  bulk: Call in place single use cpu_env()
  scripts/coccinelle: Add cpu_env.cocci script
  target: Replace CPU_GET_CLASS(cpu -> obj) in cpu_reset_hold() handler
  target/alpha: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/arm: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/avr: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/cris: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/hexagon: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/hppa: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/i386/hvf: Use CPUState typedef
  target/i386: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/loongarch: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/m68k: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/microblaze: Prefer fast cpu_env() over slower CPU QOM cast
    macro
  target/mips: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/nios2: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/openrisc: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/ppc: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/riscv: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/rx: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/s390x: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/sh4: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/sparc: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/tricore: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/xtensa: Prefer fast cpu_env() over slower CPU QOM cast macro
  user: Prefer fast cpu_env() over slower CPU QOM cast macro

 MAINTAINERS                             |   1 +
 scripts/coccinelle/cpu_env.cocci        | 100 ++++++++++++++++++++++++
 include/hw/acpi/cpu.h                   |   2 +-
 include/hw/boards.h                     |   2 +-
 target/i386/hvf/vmx.h                   |  13 +--
 target/i386/hvf/x86.h                   |  26 +++---
 target/i386/hvf/x86_descr.h             |  14 ++--
 target/i386/hvf/x86_emu.h               |   4 +-
 target/i386/hvf/x86_mmu.h               |   6 +-
 accel/tcg/cpu-exec.c                    |   3 +-
 bsd-user/signal.c                       |   3 +-
 hw/core/machine.c                       |   4 +-
 hw/display/ati.c                        |   2 +-
 hw/i386/fw_cfg.c                        |   3 +-
 hw/i386/vmmouse.c                       |   6 +-
 hw/i386/x86.c                           |   2 +-
 hw/i386/xen/xen-hvm.c                   |   3 +-
 hw/intc/arm_gicv3_cpuif.c               |   7 +-
 hw/intc/arm_gicv3_cpuif_common.c        |   5 +-
 hw/loongarch/virt.c                     |   2 +-
 hw/misc/macio/pmu.c                     |   2 +-
 hw/misc/pvpanic-pci.c                   |   2 +-
 hw/pci-bridge/cxl_root_port.c           |   2 +-
 hw/ppc/mpc8544_guts.c                   |   3 +-
 hw/ppc/pnv.c                            |  23 +++---
 hw/ppc/pnv_xscom.c                      |   5 +-
 hw/ppc/ppce500_spin.c                   |   3 +-
 hw/ppc/spapr.c                          |   8 +-
 hw/ppc/spapr_caps.c                     |   7 +-
 hw/s390x/s390-virtio-ccw.c              |   2 +-
 hw/virtio/vhost-user-gpio.c             |   8 +-
 hw/virtio/vhost-user-scmi.c             |   6 +-
 hw/virtio/virtio-pci.c                  |   2 +-
 hw/xen/xen_pt.c                         |   6 +-
 linux-user/i386/cpu_loop.c              |   4 +-
 linux-user/signal.c                     |   6 +-
 migration/multifd-zlib.c                |   2 +-
 target/alpha/cpu.c                      |  31 ++------
 target/alpha/gdbstub.c                  |   6 +-
 target/alpha/helper.c                   |  15 ++--
 target/alpha/mem_helper.c               |  11 +--
 target/alpha/translate.c                |   4 +-
 target/arm/cpu.c                        |  37 ++++-----
 target/arm/debug_helper.c               |   8 +-
 target/arm/gdbstub.c                    |   6 +-
 target/arm/gdbstub64.c                  |   6 +-
 target/arm/helper.c                     |   9 +--
 target/arm/hvf/hvf.c                    |  12 +--
 target/arm/kvm.c                        |   5 +-
 target/arm/machine.c                    |   6 +-
 target/arm/ptw.c                        |   3 +-
 target/arm/tcg/cpu32.c                  |   4 +-
 target/arm/tcg/translate.c              |   3 +-
 target/avr/cpu.c                        |  29 ++-----
 target/avr/gdbstub.c                    |   6 +-
 target/avr/helper.c                     |  10 +--
 target/avr/translate.c                  |   3 +-
 target/cris/cpu.c                       |  12 +--
 target/cris/gdbstub.c                   |   9 +--
 target/cris/helper.c                    |  12 +--
 target/cris/translate.c                 |   6 +-
 target/hexagon/cpu.c                    |  27 ++-----
 target/hexagon/gdbstub.c                |   6 +-
 target/hppa/cpu.c                       |   8 +-
 target/hppa/int_helper.c                |   8 +-
 target/hppa/mem_helper.c                |   6 +-
 target/hppa/translate.c                 |   3 +-
 target/i386/arch_dump.c                 |  11 +--
 target/i386/arch_memory_mapping.c       |   3 +-
 target/i386/cpu-dump.c                  |   3 +-
 target/i386/cpu.c                       |  51 +++++-------
 target/i386/helper.c                    |  42 +++-------
 target/i386/hvf/hvf.c                   |   8 +-
 target/i386/hvf/x86.c                   |  30 ++++---
 target/i386/hvf/x86_descr.c             |   8 +-
 target/i386/hvf/x86_emu.c               |   6 +-
 target/i386/hvf/x86_mmu.c               |  14 ++--
 target/i386/hvf/x86_task.c              |  10 +--
 target/i386/hvf/x86hvf.c                |  11 +--
 target/i386/kvm/kvm.c                   |   6 +-
 target/i386/kvm/xen-emu.c               |  32 +++-----
 target/i386/nvmm/nvmm-all.c             |   6 +-
 target/i386/tcg/sysemu/bpt_helper.c     |   3 +-
 target/i386/tcg/sysemu/excp_helper.c    |   3 +-
 target/i386/tcg/tcg-cpu.c               |  14 +---
 target/i386/tcg/user/excp_helper.c      |   6 +-
 target/i386/tcg/user/seg_helper.c       |   3 +-
 target/i386/whpx/whpx-all.c             |  18 ++---
 target/loongarch/cpu.c                  |  41 +++-------
 target/loongarch/gdbstub.c              |   6 +-
 target/loongarch/kvm/kvm.c              |  41 +++-------
 target/loongarch/tcg/tlb_helper.c       |   6 +-
 target/loongarch/tcg/translate.c        |   3 +-
 target/m68k/cpu.c                       |  37 +++------
 target/m68k/gdbstub.c                   |   6 +-
 target/m68k/helper.c                    |   8 +-
 target/m68k/m68k-semi.c                 |   6 +-
 target/m68k/op_helper.c                 |  11 +--
 target/m68k/translate.c                 |   3 +-
 target/microblaze/cpu.c                 |   6 +-
 target/microblaze/gdbstub.c             |   3 +-
 target/microblaze/helper.c              |   3 +-
 target/microblaze/translate.c           |   6 +-
 target/mips/cpu.c                       |  17 ++--
 target/mips/gdbstub.c                   |   6 +-
 target/mips/kvm.c                       |  27 +++----
 target/mips/sysemu/physaddr.c           |   3 +-
 target/mips/tcg/exception.c             |   3 +-
 target/mips/tcg/op_helper.c             |   8 +-
 target/mips/tcg/sysemu/special_helper.c |   3 +-
 target/mips/tcg/sysemu/tlb_helper.c     |   6 +-
 target/mips/tcg/translate.c             |   3 +-
 target/nios2/cpu.c                      |  17 +---
 target/nios2/helper.c                   |   3 +-
 target/nios2/nios2-semi.c               |   6 +-
 target/nios2/translate.c                |   3 +-
 target/openrisc/cpu.c                   |   8 +-
 target/openrisc/gdbstub.c               |   6 +-
 target/openrisc/interrupt.c             |   6 +-
 target/openrisc/translate.c             |   6 +-
 target/ppc/cpu_init.c                   |  23 +++---
 target/ppc/excp_helper.c                |   3 +-
 target/ppc/gdbstub.c                    |  12 +--
 target/ppc/kvm.c                        |  20 ++---
 target/ppc/ppc-qmp-cmds.c               |   3 +-
 target/ppc/user_only_helper.c           |   3 +-
 target/riscv/arch_dump.c                |   6 +-
 target/riscv/cpu.c                      |  19 ++---
 target/riscv/cpu_helper.c               |  19 ++---
 target/riscv/debug.c                    |   9 +--
 target/riscv/gdbstub.c                  |   6 +-
 target/riscv/kvm/kvm-cpu.c              |  11 +--
 target/riscv/tcg/tcg-cpu.c              |  10 +--
 target/riscv/translate.c                |   6 +-
 target/rx/cpu.c                         |   6 +-
 target/rx/gdbstub.c                     |   6 +-
 target/rx/helper.c                      |   6 +-
 target/rx/translate.c                   |   6 +-
 target/s390x/cpu-dump.c                 |   3 +-
 target/s390x/gdbstub.c                  |   6 +-
 target/s390x/helper.c                   |   3 +-
 target/s390x/kvm/kvm.c                  |   6 +-
 target/s390x/tcg/excp_helper.c          |  11 +--
 target/s390x/tcg/misc_helper.c          |   4 +-
 target/s390x/tcg/translate.c            |   3 +-
 target/sh4/cpu.c                        |  22 ++----
 target/sh4/gdbstub.c                    |   6 +-
 target/sh4/helper.c                     |  14 +---
 target/sh4/op_helper.c                  |   4 +-
 target/sh4/translate.c                  |   6 +-
 target/sparc/cpu.c                      |  21 ++---
 target/sparc/gdbstub.c                  |   3 +-
 target/sparc/int32_helper.c             |   3 +-
 target/sparc/int64_helper.c             |   3 +-
 target/sparc/ldst_helper.c              |   6 +-
 target/sparc/mmu_helper.c               |  15 ++--
 target/sparc/translate.c                |   9 +--
 target/tricore/cpu.c                    |  28 ++-----
 target/tricore/gdbstub.c                |   6 +-
 target/tricore/helper.c                 |   3 +-
 target/tricore/translate.c              |   3 +-
 target/xtensa/cpu.c                     |   9 +--
 target/xtensa/dbg_helper.c              |   3 +-
 target/xtensa/exc_helper.c              |   3 +-
 target/xtensa/gdbstub.c                 |   6 +-
 target/xtensa/helper.c                  |   9 +--
 target/xtensa/translate.c               |   6 +-
 167 files changed, 615 insertions(+), 998 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_env.cocci

-- 
2.41.0


