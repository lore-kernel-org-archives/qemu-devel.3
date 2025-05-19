Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038CEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs35-0000RX-CB; Mon, 19 May 2025 00:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmO-0004iS-Ku
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:09 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmM-00044N-BU
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:08 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b1fb650bdf7so2358518a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627624; x=1748232424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4G+l0DbMpv8SAPAsssm+mafD9DyX08mfxZX5Jp6Aba0=;
 b=hyBx6a1y8lnq63pNmVegwN68MRsrfRpmef01qqeYayIsrNhSdYrbEDT6Yy2NcpO3rv
 RICTYQQESGCSYL5UHLrrN0V1x9xDxoYy6a4RjrK0ezWPEN10R1iJb6DyANigDQmZqWQD
 BcJec8NP3XhoobMW/o8Bo8+qvwgHdfiUu3lOcJr7hNWMKS9ZdpjKnvQlYBfzNmEUh7nL
 w4uvTKgGp0RL9ZkVvDGHBIwmH3tpSOZsUx6uxAPlWHfii8cNXeDlXS9L0YnqzmPQBoh6
 a+3XX4ZUqMUiazhWCQq5eEYvqtXgqPY9mVKudB0q8HLmRLKSyw9NI4FNO1rkK1dTXBp4
 apvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627624; x=1748232424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4G+l0DbMpv8SAPAsssm+mafD9DyX08mfxZX5Jp6Aba0=;
 b=FTCJnrvl+0/1nefhqhLmJyYWDSa0e/B7crUUpgHAq7qAnHGnFeiA3qh32OZ+c9Bw3k
 DKtRcml8OJ5GF5IcvHHDkLkGqks1yXv2l9v6lMH6NvxQX2oBKfFuqiR/7fsGLBtYpaiY
 VmbUmfG5+8N+6hdsqPHtvH1oOAWWbHII+9I/YVodZp1P4tp7LkjHc3yEwUtQsYbR/lA2
 6VVgn31jCQCkCQOMnp3W9N65TZOW5BBvCx750m1SaDO224WMaV8L6CDA3r2tPT4xqZxU
 clPGhSiWcA1KXp9+YpAZMHX1OpRryTaAmiQ6wQxA+lclp0qsh5zceE8uREppCL7F6Tbr
 PXhw==
X-Gm-Message-State: AOJu0Yzd0XjfPhBx8UpRfwwHD2ptbDZxjcGJ2rnzNUx4OSLexNpEaG47
 uRv3gyZQp7q4rKKmgRrTXM0b7tk6X2UwRvvnAKdHFCWDrcsRx1PztOY6RYUhkw==
X-Gm-Gg: ASbGncuEzw3776KT4vNBmkBrEKeW6fdioYingqY/ktglKIjzc4dz5wILjDye6HPjqIG
 nvNMaak4RrqiF5wJKYmIm45QZg7tcDSp5uQz9wBItVrQ7wflSyqYnHPynu7JX5JxuX1W8sJZifs
 TKBNBmP3miOyO4g4kZNRi1DtAkCXKOKtNtrft0pLCyfvLHO64ZWw+wAwmkQZCTd4+vkQ7eRTr9z
 GT0ZxH3nCwySBDUn2pGQ1ro5uTkIIPDvW80n8DqwjYfbg4g5i2oUgoCYjn8uF8qcAHVvFbD618S
 yPO3M88rSBeoluNr2EZ9WG0XIL5Cp7tsR13YXGjmtc9sAs12djEIZMyELanscbME3/s644LwSJ9
 OgEtJcsRIRs/p4QVYvUzEUGoueNk+8pqN2IKyHhF5oS0iBKC7efegs6Om
X-Google-Smtp-Source: AGHT+IE+mv47iBYr6DY9tYl60zYaNMMb9Z+cH+Vz3kvrEHFMQM9TGzFX8rnVlVnwv46xsQWHVrl+mA==
X-Received: by 2002:a17:903:41c7:b0:223:53fb:e1dd with SMTP id
 d9443c01a7336-231de351565mr145460445ad.9.1747627624413; 
 Sun, 18 May 2025 21:07:04 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/56] riscv-to-apply queue
Date: Mon, 19 May 2025 14:04:57 +1000
Message-ID: <20250519040555.3797167-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 757a34115e7491744a63dfc3d291fd1de5297ee2:

  Merge tag 'pull-nvme-20250515' of https://gitlab.com/birkelund/qemu into staging (2025-05-15 13:42:27 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250519

for you to fetch changes up to e7cb99bfd1afc5cf2265a122bcfeab36eff7489a:

  hw/riscv/virt.c: remove 'long' casts in fmt strings (2025-05-19 13:42:56 +1000)

----------------------------------------------------------------
First RISC-V PR for 10.1

* Add support for RIMT to virt machine ACPI
* Don't allow PMP RLB to bypass rule privileges
* Fix checks on writes to pmpcfg in Smepmp MML mode
* Generate strided vector loads/stores with tcg nodes
* Improve Microchip Polarfire SoC customization
* Use tcg ops generation to emulate whole reg rvv loads/stores
* Expand the probe_pages helper function to handle probe flags
* Fix type conflict of GLib function pointers
* Fix endless translation loop on big endian systems
* Use tail pseudoinstruction for calling tail
* Fix some RISC-V vector instruction corner cases
* MAINTAINERS: Add common-user/host/riscv to RISC-V section
* Fix write_misa vs aligned next_pc
* KVM CSR fixes
* Virt machine memmap usage cleanup

----------------------------------------------------------------
Alistair Francis (1):
      MAINTAINERS: Add common-user/host/riscv to RISC-V section

Anton Blanchard (3):
      target/riscv: rvv: Source vector registers cannot overlap mask register
      target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
      target/riscv: Fix vslidedown with rvv_ta_all_1s

Daniel Henrique Barboza (18):
      target/riscv/kvm: minor fixes/tweaks
      target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
      target/riscv/kvm: turn u32/u64 reg functions into macros
      target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
      target/riscv/kvm: add kvm_csr_cfgs[]
      target/riscv/kvm: do not read unavailable CSRs
      target/riscv/kvm: add senvcfg CSR
      target/riscv/kvm: read/write KVM regs via env size
      target/riscv/kvm: add scounteren CSR
      hw/riscv/virt.c: enforce s->memmap use in machine_init()
      hw/riscv/virt.c: remove trivial virt_memmap references
      hw/riscv/virt.c: use s->memmap in virt_machine_done()
      hw/riscv/virt.c: add 'base' arg in create_fw_cfg()
      hw/riscv/virt.c: use s->memmap in create_fdt() path
      hw/riscv/virt.c: use s->memmap in create_fdt_sockets() path
      hw/riscv/virt.c: use s->memmap in create_fdt_virtio()
      hw/riscv/virt.c: use s->memmap in finalize_fdt() functions
      hw/riscv/virt.c: remove 'long' casts in fmt strings

Icenowy Zheng (1):
      common-user/host/riscv: use tail pseudoinstruction for calling tail

Loïc Lefort (5):
      target/riscv: pmp: don't allow RLB to bypass rule privileges
      target/riscv: pmp: move Smepmp operation conversion into a function
      target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode
      target/riscv: pmp: exit csr writes early if value was not changed
      target/riscv: pmp: remove redundant check in pmp_is_locked

Max Chou (8):
      target/riscv: rvv: Apply vext_check_input_eew to vrgather instructions to check mismatched input EEWs encoding constraint
      target/riscv: rvv: Apply vext_check_input_eew to OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
      target/riscv: rvv: Apply vext_check_input_eew to OPIVV/OPFVV(vext_check_sss) instructions
      target/riscv: rvv: Apply vext_check_input_eew to vector slide instructions(OPIVI/OPIVX)
      target/riscv: rvv: Apply vext_check_input_eew to vector integer extension instructions(OPMVV)
      target/riscv: rvv: Apply vext_check_input_eew to vector narrow/widen instructions
      target/riscv: rvv: Apply vext_check_input_eew to vector indexed load/store instructions
      target/riscv: Fix the rvv reserved encoding of unmasked instructions

Paolo Bonzini (1):
      hw/riscv: Fix type conflict of GLib function pointers

Paolo Savini (3):
      Generate strided vector loads/stores with tcg nodes.
      target/riscv: use tcg ops generation to emulate whole reg rvv loads/stores.
      Expand the probe_pages helper function to handle probe flags.

Richard Henderson (7):
      target/riscv: Pass ra to riscv_csr_write_fn
      target/riscv: Pass ra to riscv_csrrw_do64
      target/riscv: Pass ra to riscv_csrrw_do128
      target/riscv: Pass ra to riscv_csrrw
      target/riscv: Pass ra to riscv_csrrw_i128
      target/riscv: Move insn_len to internals.h
      target/riscv: Fix write_misa vs aligned next_pc

Sebastian Huber (6):
      hw/misc: Add MPFS system reset support
      hw/riscv: More flexible FDT placement for MPFS
      hw/riscv: Make FDT optional for MPFS
      hw/riscv: Allow direct start of kernel for MPFS
      hw/riscv: Configurable MPFS CLINT timebase freq
      hw/riscv: microchip_pfsoc: Rework documentation

Sunil V L (2):
      hw/riscv/virt: Add the BDF of IOMMU to RISCVVirtState structure
      hw/riscv/virt-acpi-build: Add support for RIMT

Ziqiao Kong (1):
      target/riscv: fix endless translation loop on big endian systems

 MAINTAINERS                                |   1 +
 docs/system/riscv/microchip-icicle-kit.rst | 124 ++----
 include/hw/riscv/microchip_pfsoc.h         |   1 +
 include/hw/riscv/virt.h                    |   1 +
 target/riscv/cpu.h                         |  16 +-
 target/riscv/internals.h                   |   5 +
 target/riscv/insn32.decode                 |  18 +-
 hw/misc/mchp_pfsoc_sysreg.c                |   7 +
 hw/riscv/microchip_pfsoc.c                 | 153 +++++--
 hw/riscv/riscv_hart.c                      |   9 +-
 hw/riscv/virt-acpi-build.c                 | 215 ++++++++++
 hw/riscv/virt.c                            | 273 ++++++------
 target/riscv/cpu_helper.c                  |   6 +-
 target/riscv/csr.c                         | 278 +++++++------
 target/riscv/kvm/kvm-cpu.c                 | 333 +++++++++------
 target/riscv/op_helper.c                   |  13 +-
 target/riscv/pmp.c                         | 147 ++++---
 target/riscv/translate.c                   |   5 -
 target/riscv/vector_helper.c               |  63 ++-
 target/riscv/insn_trans/trans_rvbf16.c.inc |   9 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 644 +++++++++++++++++++++++------
 common-user/host/riscv/safe-syscall.inc.S  |   4 +-
 22 files changed, 1570 insertions(+), 755 deletions(-)

