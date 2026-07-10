Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FAEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Oy-0007GL-UY; Thu, 09 Jul 2026 22:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Ox-0007G0-L6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Ov-0008KD-7C
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8454160043aso381498b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652139; x=1784256939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=unzbCpk1EG10n2wNhWfoadQ/+TRGFkwmC8IHNABx2SE=;
 b=cSsbUuPWYZvfScQLWVydh9FEx+uDjx1AcI1Hy/ilQ74eOKgKJoyWLab0Iol+D8gzpd
 5EOFgoqlw/gKN6toxqixbqrulBzH75lxDb6lkz/IpD3yiwh6lXYz8eXiWmStCodbt+EP
 Uj/T5RquGMOrUo+J9RUrB8wcFM+7ONduISi8tL2nU+5ObVqrkF0HVBmuT4ysrDG/rnhi
 ziNjj75tVvhdnVehkSodmlL8Oa8Bt/iNdo8oIYakawTXOKhvKAEZH616ZC6ZY2dsHNYg
 C3WB/59tGOStpVOIla+aXfZgfyx8wC/FDqZ2Bp/NLFR50kdpVxkEDJ4HBVR1AqOJMJxh
 4D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652139; x=1784256939;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=unzbCpk1EG10n2wNhWfoadQ/+TRGFkwmC8IHNABx2SE=;
 b=YzmaFvNEpcG5WPLbtJ9GGIPkuAA576/Me6Y0b4zQ2tf7cSAZwjsjB0+X2xQH9Aqufr
 FRbr+7NDgeP6J+vZOMmevcMnNECJwX6+r4mzqBGkmHr1zaEcYV3CMjrxzgCHX23qO1HO
 zgFhNOU6NNPpR37b79b6krcOgowOf4ZlysCoWz4b6atKrjBXLnjcnJ/GMEgGgTbGU2xf
 XL9MlgBHludGjrzB7hdd+SGq7EJK1HNO+jlauqUMHyMussw4JQnZPH6Dljg26xuoMhTb
 5VSLBfM6HnCsSI5EeQ6Kow+FWbzagtBU+FOg+Z4dqk/vyVIUEeGpWg2Iyama6ofp+EXq
 6wSg==
X-Gm-Message-State: AOJu0Yw2g9RihDNHZkIhCRteeZyOGyykT95t20YVU5W9Q7sR78zmIgE1
 vVwydBjLxc/0VZjnarVaJscFiZa69WEuC8+4CZRvR40ovR55E38d1f3WliZUiA==
X-Gm-Gg: AfdE7cn+r+BpRa0jeqTuQ5IfNPGSEKuln9L3Kzk6KQPmwV2yfc5hdqpd7Mt9QfaSwv5
 Mk5Cd0EQ0tTSK5pdcuBz4Vii1Zo0ENDvWljYiiBUvK35PLwgeEB9W4ptRMsB0LhKFdCHjcfwBZw
 dO4RzTMnbnFI3XCXqcvEf0rrcjg6goyP8hhqli3YpWylZ9RSxIB6zEw8I8KwnjWlzDws5Rqyb+P
 2edxtxUT8ICJkYHdy0kJq94qYI5+3+YhK0xaozXyHGlZtBGMX1TC3eDxa+F+J0Yzp8sCK0S0YSO
 rCjbXROahkmjv89jw737c5Mxe6tUTUTk15Hu609JXXgfvSEpjiOXCxUr/ZC7T6Z/MB1UXxR9lX+
 O4RTbaKxcQLWA5S7B3bvb37x7nZV2BBL0Z45C8pu2FSb8wwdP/7+EQtbXm1pEeUApfoHN0MpevY
 EtGkJ8Ekvzq4quOir0AytMlA0Euqc1DmA=
X-Received: by 2002:a05:6a00:3486:b0:842:614e:cc94 with SMTP id
 d2e1a72fcca58-84842f303fcmr9270790b3a.26.1783652139416; 
 Thu, 09 Jul 2026 19:55:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/40] riscv-to-apply queue
Date: Fri, 10 Jul 2026 12:54:45 +1000
Message-ID: <20260710025525.1704417-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit f893c46c3931b3684d235d221bf8b7844ddbf1d7:

  Merge tag 'qemu-openbios-20260707' of https://github.com/mcayland/qemu into staging (2026-07-08 16:01:29 +0200)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260710

for you to fetch changes up to ec7d32428757d5813935cbe099449f6201980d80:

  tests: update SPCR loongarch64 and riscv64 test data (2026-07-09 16:21:52 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1

* Fix IOMMU fault type for spa_fetch() faults
* Check IOMMU for reserved PTE bits
* Fault when IOMMU !PTE_U and no priv access
* Fault IOMMU for non-user PTE in G_STAGE
* Check IOMMU reserved MSI PTE basic bits
* Record fault on IOMMU-generated MSI write
* Move RISC-V TCG files and fix --disable-tcg
* Check for misaligned IOMMU IOHGATP_PPN
* Update IOMMU ioval2 when faulting in spa_fetch()
* Forbid IOMMU GATE/SADE if caps.AMO_HWADD is zero
* Set IOMMU ftype and iova in riscv_iommu_ctx()
* Check PCIe DOE mailbox length for overflows
* Add extensions after v7.1-rc4 update
* Remove job building OpenSBI firmware binaries
* Correct ACPI field sequence in SPCR table

----------------------------------------------------------------
Alistair Francis (1):
      hw/pci/pcie_doe: Check mailbox length for overflows

Bin Meng (1):
      gitlab-ci: Remove job building OpenSBI firmware binaries

Daniel Henrique Barboza (32):
      hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
      hw/riscv/riscv-iommu.c: check for reserved PTE bits
      hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
      hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
      hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
      hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
      target/riscv: move valid_vm_* satp arrays to cpu.c
      hw/riscv, target/riscv: move pmu fdt function to fdt-common.c
      target/riscv: move TCG only files to tcg subdir
      target/riscv/machine.c: do not migrate pmp state with kvm
      target/riscv: move pmp files to tcg subdir
      target/riscv: tidy up riscv_sysemu_ops
      target/riscv: move debug.h to tcg subdir
      target/riscv: remove csr.h from kvm-cpu.c
      target/riscv: move csr.h to tcg subdir
      target/riscv: move custom_csrs logic to tcg-cpu.c
      target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
      target/riscv: move some irq helpers to cpu.c
      target/riscv: move riscv_cpu_claim_interrupts to cpu.c
      target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
      target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
      target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
      hw/riscv/riscv_hart.c isolate tcg only bits
      target/riscv/gdbstub.c: isolate TCG only checks
      target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
      target/riscv/tcg: remove unused riscv_cpu_get_geilen()
      target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
      target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
      hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
      hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
      hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
      hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()

Heinrich Schuchardt (3):
      tests: allow differences in SPCR
      hw/acpi: correct field sequence in SPCR table
      tests: update SPCR loongarch64 and riscv64 test data

Wang Yechao (1):
      target/riscv/kvm: add extensions after v7.1-rc4 update

Zephyr Li (2):
      target/riscv: Remove unused tcg/tcg.h include
      gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job

 MAINTAINERS                                        |   2 -
 hw/riscv/riscv-iommu-bits.h                        |   1 +
 hw/riscv/riscv-iommu.h                             |   1 +
 include/hw/riscv/fdt-common.h                      |   1 +
 target/riscv/cpu.h                                 |  24 +-
 target/riscv/{ => tcg}/csr.h                       |   6 +-
 target/riscv/{ => tcg}/debug.h                     |   0
 target/riscv/{ => tcg}/pmp.h                       |   0
 target/riscv/{ => tcg}/pmu.h                       |   0
 target/riscv/{ => tcg}/vector_internals.h          |   0
 tests/qtest/libqos/qos-riscv-iommu.h               |   4 +-
 hw/acpi/aml-build.c                                |   4 +-
 hw/intc/riscv_aclint.c                             |   8 +
 hw/intc/riscv_imsic.c                              |  24 ++
 hw/pci/pcie_doe.c                                  |  27 +-
 hw/riscv/fdt-common.c                              |  52 ++++
 hw/riscv/riscv-iommu-sys.c                         |  16 +-
 hw/riscv/riscv-iommu.c                             | 117 +++++++-
 hw/riscv/riscv_hart.c                              |   8 +-
 hw/riscv/tt_atlantis.c                             |   1 -
 hw/riscv/virt.c                                    |   1 -
 target/riscv/cpu.c                                 | 318 ++++++++++++++++++---
 target/riscv/gdbstub.c                             |  10 +-
 target/riscv/kvm/kvm-cpu.c                         |   4 +-
 target/riscv/machine.c                             |  15 +-
 target/riscv/monitor.c                             |   4 +-
 target/riscv/riscv-qmp-cmds.c                      |   2 +-
 target/riscv/{ => tcg}/bitmanip_helper.c           |   0
 target/riscv/{ => tcg}/cpu_helper.c                | 253 +---------------
 target/riscv/{ => tcg}/crypto_helper.c             |   0
 target/riscv/{ => tcg}/csr.c                       |  45 +--
 target/riscv/{ => tcg}/debug.c                     |   2 +-
 target/riscv/{ => tcg}/fpu_helper.c                |   0
 target/riscv/{ => tcg}/m128_helper.c               |   0
 target/riscv/{ => tcg}/mips_csr.c                  |   2 +-
 target/riscv/{ => tcg}/op_helper.c                 |   2 +-
 target/riscv/{ => tcg}/pmp.c                       |   2 +-
 target/riscv/{ => tcg}/pmu.c                       |  52 ----
 target/riscv/tcg/tcg-cpu.c                         |  30 +-
 target/riscv/{ => tcg}/th_csr.c                    |   2 +-
 target/riscv/{ => tcg}/translate.c                 |   0
 target/riscv/{ => tcg}/vcrypto_helper.c            |   0
 target/riscv/{ => tcg}/vector_helper.c             |   0
 target/riscv/{ => tcg}/vector_internals.c          |   0
 target/riscv/{ => tcg}/zce_helper.c                |   0
 target/riscv/time_helper.c                         |  33 ++-
 .../{ => tcg}/insn_trans/trans_privileged.c.inc    |   0
 target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc  |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc  |   0
 target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc |   0
 .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc      |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc   |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc   |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc   |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc |   0
 .../{ => tcg}/insn_trans/trans_rvzicfiss.c.inc     |   0
 .../{ => tcg}/insn_trans/trans_rvzicond.c.inc      |   0
 .../riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc |   0
 .../riscv/{ => tcg}/insn_trans/trans_svinval.c.inc |   0
 .../riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc   |   0
 .../riscv/{ => tcg}/insn_trans/trans_xmips.c.inc   |   0
 .../riscv/{ => tcg}/insn_trans/trans_xthead.c.inc  |   0
 .../insn_trans/trans_xventanacondops.c.inc         |   0
 .../riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc   |   0
 .gitlab-ci.d/crossbuilds.yml                       |   8 +
 .gitlab-ci.d/opensbi.yml                           |  88 ------
 .gitlab-ci.d/opensbi/Dockerfile                    |  34 ---
 .gitlab-ci.d/qemu-project.yml                      |   1 -
 target/riscv/meson.build                           |  17 --
 target/riscv/tcg/meson.build                       |  31 +-
 tests/data/acpi/loongarch64/virt/SPCR              | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR                  | Bin 90 -> 90 bytes
 84 files changed, 666 insertions(+), 586 deletions(-)
 rename target/riscv/{ => tcg}/csr.h (96%)
 rename target/riscv/{ => tcg}/debug.h (100%)
 rename target/riscv/{ => tcg}/pmp.h (100%)
 rename target/riscv/{ => tcg}/pmu.h (100%)
 rename target/riscv/{ => tcg}/vector_internals.h (100%)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/cpu_helper.c (92%)
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/csr.c (99%)
 rename target/riscv/{ => tcg}/debug.c (99%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/mips_csr.c (99%)
 rename target/riscv/{ => tcg}/op_helper.c (99%)
 rename target/riscv/{ => tcg}/pmp.c (99%)
 rename target/riscv/{ => tcg}/pmu.c (86%)
 rename target/riscv/{ => tcg}/th_csr.c (99%)
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.c (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
 delete mode 100644 .gitlab-ci.d/opensbi.yml
 delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile

