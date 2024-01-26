Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E91C48285
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJB-0006nu-6s; Fri, 26 Jan 2024 17:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJ8-0006l7-7b
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:18 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJ4-0003Gl-2H
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:16 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a8fb31fc2so728331a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306650; x=1706911450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tLDD+gX81/flexkUVsp4uo9ttE0hN1WJun7ndqYAwQ4=;
 b=onuuo5K3EB1q3NgZ5tIglUXtf4PnvZwWxbsVotd3mLqf7OJ5RrEKpVMI0SKhB8WCEN
 Mp9zzmKvuhpEbD5Sd//WUsiHeWp3VNiFm2PUekoayNFMao6yhnYSmcZhnEIGRoCHW2Ku
 E8MdXTuViLZ4aBo6YqnAr/s2nVnLIuieZvtE14Nr8s/AjHiFHw4psOsfhOfRNeHOJDGR
 zUPLnDaOJVx3vGCJWBUI1D5ALq9TW1v01svrIxROOEeNa4h5+h6o/HJBZbpKs0fgRVvw
 zZXF8Cgf1cKDqwER+l1CBsYF6YMpfaCtvJtXBGStdNcel1rNciHVSKw/mwbMwBSTx0WS
 srWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306650; x=1706911450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tLDD+gX81/flexkUVsp4uo9ttE0hN1WJun7ndqYAwQ4=;
 b=o7LAES+xTsdFJWLswb7IRmlmiNZJ3tDipUuGg5uICaTurvpxMImYuZpuMf87uAsuRX
 M/JZ0rrSH7FkPzTcDTDYJxT/LN6KNoISi5VAXQjQPegouOCOZdh3WLmuNr0Hb/SXDRx8
 elh6mcnyjt3Y/DSmm5epHjI0RZMm48WMC4Cx3u1WkDxbDJxSgZQMcyCsTvU1s4v1kyN7
 QyObJZuJ1JdHICJL0/UHtotCbPoJZbT5M9Ofw424goTMX3yCKX+CRi152mF17lJSIAJS
 dDctnvey3I9beNh6IxR4TlVwlCJX6EXnPH44S1GPmm6ZwPqxt236pkGSgtuhmagwTJow
 qlTQ==
X-Gm-Message-State: AOJu0YxIJSJLZ1+7zkYxYUwGaK/gbk0j2M4FY5/Dk0lkCq4Ztbu6yI+r
 0BQd8hDcpzuuf97vcEeQh3KPnlcPNMB6x7XNiB/7LcpM2SncmDuzCz1cgeH12HHSuAnpGzKJ4Fp
 V
X-Google-Smtp-Source: AGHT+IGWhZXaRIHB9nwyS9lCEMvqEDeCuORw5KmVreqBxAf4Gq4cXJxAPlMEFjgBo9HmOpkFYvI2/A==
X-Received: by 2002:aa7:dc0f:0:b0:55c:d474:56dc with SMTP id
 b15-20020aa7dc0f000000b0055cd47456dcmr203467edu.39.1706306650281; 
 Fri, 26 Jan 2024 14:04:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a056402032f00b0055ce4ea1c81sm1006182edw.89.2024.01.26.14.04.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/23] hw,
 target: Prefer fast cpu_env() over slower CPU QOM cast macro
Date: Fri, 26 Jan 2024 23:03:42 +0100
Message-ID: <20240126220407.95022-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use cpu_env() -- which is fast path -- when possible.
Bulk conversion using Coccinelle spatch (script included).

Since v1:
- Avoid CPU() cast (Paolo)
- Split per targets (Thomas)

Philippe Mathieu-Daudé (23):
  hw/acpi/cpu: Use CPUState typedef
  scripts/coccinelle: Add cpu_env.cocci_template script
  bulk: Call in place single use cpu_env()
  target/alpha: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/arm: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/avr: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/cris: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/hppa: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/i386/hvf: Use CPUState typedef
  target/i386: Prefer fast cpu_env() over slower CPU QOM cast macro
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
  target/tricore: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/xtensa: Prefer fast cpu_env() over slower CPU QOM cast macro
  target/sparc: Prefer fast cpu_env() over slower CPU QOM cast macro

 MAINTAINERS                               |  1 +
 include/hw/acpi/cpu.h                     |  2 +-
 target/i386/hvf/vmx.h                     | 13 +---
 target/i386/hvf/x86.h                     | 26 +++----
 target/i386/hvf/x86_descr.h               | 14 ++--
 target/i386/hvf/x86_emu.h                 |  4 +-
 target/i386/hvf/x86_mmu.h                 |  6 +-
 accel/tcg/cpu-exec.c                      |  3 +-
 hw/i386/vmmouse.c                         |  6 +-
 hw/i386/xen/xen-hvm.c                     |  3 +-
 hw/intc/arm_gicv3_cpuif_common.c          |  5 +-
 hw/ppc/mpc8544_guts.c                     |  3 +-
 hw/ppc/pnv.c                              |  3 +-
 hw/ppc/pnv_xscom.c                        |  5 +-
 hw/ppc/ppce500_spin.c                     |  3 +-
 hw/ppc/spapr.c                            |  3 +-
 hw/ppc/spapr_caps.c                       |  6 +-
 linux-user/i386/cpu_loop.c                |  4 +-
 target/alpha/cpu.c                        | 31 ++------
 target/alpha/gdbstub.c                    |  6 +-
 target/alpha/helper.c                     | 12 +--
 target/alpha/mem_helper.c                 | 11 +--
 target/arm/cpu.c                          | 19 ++---
 target/arm/debug_helper.c                 |  8 +-
 target/arm/gdbstub.c                      |  6 +-
 target/arm/gdbstub64.c                    |  6 +-
 target/arm/helper.c                       |  9 +--
 target/arm/hvf/hvf.c                      | 12 +--
 target/arm/kvm.c                          |  3 +-
 target/arm/ptw.c                          |  3 +-
 target/arm/tcg/cpu32.c                    |  3 +-
 target/avr/cpu.c                          | 27 ++-----
 target/avr/gdbstub.c                      |  6 +-
 target/avr/helper.c                       | 10 +--
 target/cris/cpu.c                         |  5 +-
 target/cris/gdbstub.c                     |  9 +--
 target/cris/helper.c                      | 12 +--
 target/cris/translate.c                   |  3 +-
 target/hppa/cpu.c                         |  8 +-
 target/hppa/int_helper.c                  |  8 +-
 target/hppa/mem_helper.c                  |  6 +-
 target/hppa/translate.c                   |  3 +-
 target/i386/arch_memory_mapping.c         |  3 +-
 target/i386/cpu-dump.c                    |  3 +-
 target/i386/cpu.c                         | 37 +++------
 target/i386/helper.c                      | 39 +++-------
 target/i386/hvf/hvf.c                     |  8 +-
 target/i386/hvf/x86.c                     | 30 ++++----
 target/i386/hvf/x86_descr.c               |  8 +-
 target/i386/hvf/x86_emu.c                 |  6 +-
 target/i386/hvf/x86_mmu.c                 | 14 ++--
 target/i386/hvf/x86_task.c                | 10 +--
 target/i386/hvf/x86hvf.c                  |  6 +-
 target/i386/kvm/kvm.c                     |  6 +-
 target/i386/kvm/xen-emu.c                 | 32 +++-----
 target/i386/nvmm/nvmm-all.c               |  6 +-
 target/i386/tcg/sysemu/bpt_helper.c       |  3 +-
 target/i386/tcg/tcg-cpu.c                 | 14 +---
 target/i386/tcg/user/excp_helper.c        |  3 +-
 target/i386/tcg/user/seg_helper.c         |  3 +-
 target/i386/whpx/whpx-all.c               | 18 ++---
 target/loongarch/tcg/translate.c          |  3 +-
 target/m68k/cpu.c                         | 30 +++-----
 target/m68k/gdbstub.c                     |  6 +-
 target/m68k/helper.c                      |  3 +-
 target/m68k/m68k-semi.c                   |  6 +-
 target/m68k/op_helper.c                   | 11 +--
 target/m68k/translate.c                   |  3 +-
 target/microblaze/helper.c                |  3 +-
 target/microblaze/translate.c             |  3 +-
 target/mips/cpu.c                         | 11 +--
 target/mips/gdbstub.c                     |  6 +-
 target/mips/kvm.c                         | 27 +++----
 target/mips/sysemu/physaddr.c             |  3 +-
 target/mips/tcg/exception.c               |  3 +-
 target/mips/tcg/op_helper.c               |  3 +-
 target/mips/tcg/sysemu/special_helper.c   |  3 +-
 target/mips/tcg/sysemu/tlb_helper.c       |  6 +-
 target/mips/tcg/translate.c               |  3 +-
 target/nios2/cpu.c                        | 15 +---
 target/nios2/helper.c                     |  3 +-
 target/nios2/nios2-semi.c                 |  6 +-
 target/openrisc/gdbstub.c                 |  3 +-
 target/openrisc/interrupt.c               |  6 +-
 target/openrisc/translate.c               |  3 +-
 target/ppc/cpu_init.c                     | 11 +--
 target/ppc/excp_helper.c                  |  3 +-
 target/ppc/gdbstub.c                      | 12 +--
 target/ppc/kvm.c                          |  6 +-
 target/ppc/ppc-qmp-cmds.c                 |  3 +-
 target/ppc/user_only_helper.c             |  3 +-
 target/riscv/arch_dump.c                  |  6 +-
 target/riscv/cpu.c                        | 17 ++---
 target/riscv/cpu_helper.c                 | 14 +---
 target/riscv/debug.c                      |  9 +--
 target/riscv/gdbstub.c                    |  6 +-
 target/riscv/kvm/kvm-cpu.c                |  6 +-
 target/riscv/tcg/tcg-cpu.c                |  9 +--
 target/riscv/translate.c                  |  3 +-
 target/rx/gdbstub.c                       |  6 +-
 target/rx/helper.c                        |  6 +-
 target/rx/translate.c                     |  6 +-
 target/s390x/cpu-dump.c                   |  3 +-
 target/s390x/gdbstub.c                    |  6 +-
 target/s390x/helper.c                     |  3 +-
 target/s390x/kvm/kvm.c                    |  6 +-
 target/s390x/tcg/excp_helper.c            | 11 +--
 target/s390x/tcg/translate.c              |  3 +-
 target/sh4/cpu.c                          | 15 ++--
 target/sh4/gdbstub.c                      |  6 +-
 target/sh4/helper.c                       | 11 +--
 target/sh4/op_helper.c                    |  4 +-
 target/sh4/translate.c                    |  3 +-
 target/sparc/cpu.c                        | 14 +---
 target/sparc/gdbstub.c                    |  3 +-
 target/sparc/int32_helper.c               |  3 +-
 target/sparc/int64_helper.c               |  3 +-
 target/sparc/ldst_helper.c                |  6 +-
 target/sparc/mmu_helper.c                 | 15 ++--
 target/sparc/translate.c                  |  3 +-
 target/tricore/cpu.c                      | 20 +----
 target/tricore/gdbstub.c                  |  6 +-
 target/tricore/helper.c                   |  3 +-
 target/tricore/translate.c                |  3 +-
 target/xtensa/dbg_helper.c                |  3 +-
 target/xtensa/exc_helper.c                |  3 +-
 target/xtensa/gdbstub.c                   |  6 +-
 target/xtensa/helper.c                    |  9 +--
 target/xtensa/translate.c                 |  3 +-
 scripts/coccinelle/cpu_env.cocci_template | 92 +++++++++++++++++++++++
 130 files changed, 432 insertions(+), 714 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_env.cocci_template

-- 
2.41.0


