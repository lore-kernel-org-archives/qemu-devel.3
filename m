Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3569C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwthu-0006qz-9F; Wed, 19 Aug 2026 23:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtht-0006qr-CA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:44:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwthq-0003bG-Sr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:44:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so17736725ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197481; x=1787802281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2MJ4e2NgvVSfrPUuR4/7kCiXzfeo7XJC1AHImznl2z4=;
 b=HFT4txTyOeoT/Q72PCmF8Y7oFkGtWlTx9CdQhUilE1NkHQ25tzir5u/TAVbcbsa4mB
 NzhSIjQaPoHBWcBosVegujXHMugyGp4fhnTOkyd0NRQy5x2Ku/paK0cQc2MeMergdNpT
 dEbkQ1TwxeuUOpTQH/vv/UeJI3XPMFo6+64Nf3jNUHTTRS1x+7lKabQw7WP4cH88zp1q
 O0TlH31bTjwVmcefC1HOHcxpF9yLy3dPka0p3w7GpCw6OdiK92PvhU8L1BfBY9NIbCo1
 D8QtXkpytWVSb4cPU2fLFJOgvtYy3vh5fE1BqhfnOZNykggL+Cu3ac4bfg5Of7Ag6syz
 ziLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197481; x=1787802281;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2MJ4e2NgvVSfrPUuR4/7kCiXzfeo7XJC1AHImznl2z4=;
 b=dTx0YB8wjeQQQISlz75+MMFdXS4SvOwUXUqkOaI9LKndgnJXmNAGV/1c+nga7Jv7P5
 xRp3ffg+WZVVZsz6ZC/d0Ph5qwjpXejU0eLUj//naYOUy1ZNshAvpTVcDzyCFv1Mghc2
 N2hzhsKR5WDh7X3/MWb4rMOsDm4goiLWNzs8eGHKhP5kjIZcbKMq0f0YkqJNKniPcX3H
 6FBu0r/iuXUg4LyK3eAIus8OV3KseZYkXSubmtVT6Yd6Z8RxNb7mYMKPDenHRAV/4D/d
 i5CnDs1rZEof+Ss9sMELLz6+uOcHKwIguLRY9XGMKtgsOO5FOgL9EAWEQpoMuhqFH++6
 +5gA==
X-Gm-Message-State: AFuF++n65SsaVJDwFc4xX6UeBkJIKQT8sHP+XZ+uqiC0p0qFC7TBft5h
 BS/zJfgsTpRlxaTAPs0g00wPMjSUN3uf5GVq4j1AjOp9+BasG4yEfC3t4WLt1Q==
X-Gm-Gg: AR+sD133beZlApjzmUkdhM04Xsxb8bmZRe5CKZYLfcydFWaUdy/7uaGEahB1uZoY7Ny
 WmF+CBhEMIqH+6Qc/NxhvGJYOcfHC6HJn4DJ2CGxe7OPw+276Ooz7DT4DZ7i5WJsLYMA+9+wOOD
 PQOcZ+c89PaViTw/Bh41qdSfu8sCFITVPakijavnGTus53SW9d9JlOjeGRczycchVichm9zDdd+
 6XtkQvrVI61EmUhTiRqZmaQqzhCTqxl5dby/j+vSWB497CerHh2kJHjky1+LePOOW4CI7RKrWmV
 pWz23pTeszfIWILfi73osHnkbFYrtS50qYxepEyhwrXkWqh4e8B6b45v3LOygKlPi9WLvjcdWDv
 ey2/wAMMAq4RZt6AjQo615jBD2pXrxw109CcAqT40VZmo7pQIYLiFTuIbITJ9b6sHiWPKi0Uw1q
 LnQkMYiklZyFRLkeH6Gz5f27ywgs4xJVHdb33LZj/ofpWIuMrLg3n9bOGqzsA5mYd//LN4vNvsp
 WLYFw==
X-Received: by 2002:a17:90b:2792:b0:395:5404:95 with SMTP id
 98e67ed59e1d1-3958108bb19mr19813871a91.12.1787197480646; 
 Wed, 19 Aug 2026 20:44:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:44:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/93] riscv-to-apply queue
Date: Thu, 20 Aug 2026 13:42:57 +1000
Message-ID: <20260820034430.1186695-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

The following changes since commit ae4f3443209ab154b48b706a146e5f557ab147cb:

  Merge tag 'qtest-20260819-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-08-19 08:21:57 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260820-1

for you to fetch changes up to b07529241a24a4417366f378755aa978783e49f9:

  target/riscv: Restore register dump zero padding (2026-08-20 13:32:46 +1000)

----------------------------------------------------------------
RISC-V PR

* Add K230 DDR controller and PHY models
* Add optional UART1 to virt machine
* Add gsdma and decomp_gzip to K230
* Synchronize KVM privilege mode
* Preserve KVM MP state across migration
* Fix PC sync in trans_sspopchk for CFI exception handling
* Use SXL instead of MXL for read_sstatus
* Fix memory leak in riscv_trigger_unrealize()
* Support the true Zicclsm extension
* Always send MRIF notice MSI
* Do not count ECALL in minstret
* Fix seed CSR sign extension
* Fix immediate decoding and extraction
* Fix U-bit check to apply only to leaf S/VS-stage PTEs for IOMMU
* Preserve requested perm in spa_fetch() for IOMMU
* Allow menvcfg/henvcfg LPE and SSE bits on RV32
* Reorganize the disassembler
* Dix reserved/illegal instruction encodings
* Remove trace output from k230 watchdog test
* Restore register dump zero padding

----------------------------------------------------------------
A-Shehab (1):
      target/riscv: allow menvcfg/henvcfg LPE and SSE bits on RV32

Abhigyan Kumar (1):
      target/riscv: use SXL instead of MXL for read_sstatus

Andrew Jones (2):
      hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage PTEs
      hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()

Chao Liu (1):
      tests/qtest: remove trace output from k230 watchdog test

Flavien Solt (3):
      hw/misc/iommu-testdev: support PCI MSI test writes
      hw/riscv/riscv-iommu.c: always send MRIF notice MSI
      tests/qtest: add RISC-V IOMMU MRIF notice tests

Frank Chang (7):
      target/riscv: Add Zicclsm CPU option and enable it for the eligible CPUs
      hw/riscv: sifive_u: Align ROM reset vector data
      target/riscv: Support raising misaligned exceptions for scalar loads/stores
      target/riscv: Support raising misaligned exceptions for floating-point loads/stores
      target/riscv: Support raising misaligned exceptions for vector loads/stores
      target/riscv: Expose Zicclsm as a CPU property and update RVA22U64 profile
      tests/tcg/riscv64: Add test for Zicclsm

Ivan Efremov (2):
      target/riscv: Fix seed CSR sign extension
      tests/qtest: Add seed CSR zero extension test

Joel Stanley (1):
      target/riscv: Restore register dump zero padding

Junze Cao (3):
      hw/misc: Add K230 DDR controller and PHY models
      hw/riscv: Connect K230 DDR controller and PHY models
      tests/qtest: Add K230 DDR controller tests

Max Chou (1):
      target/riscv: Fix PC sync in trans_sspopchk for CFI exception handling

Richard Henderson (52):
      disas/riscv: Move operand extractors earlier in file
      disas/riscv: Reduce rv_insn to uint32_t
      disas/riscv: Tidy dec initialization in disasm_inst
      disas/riscv: Pass rv_opcode_data pointer to decode_inst_operands
      disas/riscv: Pass rv_opcode_data pointer to/from decode_inst_decompress
      disas/riscv: Pass rv_opcode_data pointer to/from decode_inst_lift_pseudo
      disas/riscv: Pass rv_opcode_data pointer to format_inst
      disas/riscv: Tidy disasm_inst main loop
      disas/riscv: Set dec->opcode_data in decode function
      disas/riscv: Drop explicit zero of rv_opcode_data fields
      disas/riscv: Drop useless const in structures
      disas/riscv: Drop codec from rv_decode
      disas/riscv: Handle c.addi4spn imm != 0 during decode
      disas/riscv: Simplify c.addi
      disas/riscv: Handle c.lui imm != 0 during decode
      disas/riscv: Handle c.{srli,srai} imm during decode
      disas/riscv: Handle c.slli imm != 0 during decode
      disas/riscv: Do not recognize c.{addw, subw} with rv32
      disas/riscv: Remove rvcd_imm_nz
      disas/riscv: Unify decomp_rv{32,64,128}
      disas/riscv: Drop always true branch pseudos
      disas/riscv: Handle aliases of csrrw during decode
      disas/riscv: Handle aliases of csrrs during decode
      disas/riscv: Handle aliases of csrrwi during decode
      disas/riscv: Break pseudo loop for jal and jalr
      disas/riscv: Allow decode_inst_lift_pseudo to loop
      disas/riscv: Handle decompression via decode_inst_lift_pseudo
      disas/riscv: Drop format from DECOMP insns
      disas/riscv: Tidy rv_comp_data terminators
      disas/riscv: Chain "ret" pseudo off "jr" pseudo
      disas/riscv: Chain "nop" pseudo off "mv" pseudo
      disas/riscv: Use rv_codec_illegal for pseudos
      disas/riscv: Simplify some insn decompressions
      disas/riscv: Store op pointer in rv_comp_data
      disas/riscv: Return rv_opcode_data pointer from decoders
      disas/riscv: Skip post-processing of illegal insns
      disas/riscv: Reject all of OP-32 and OP-IMM-32 for RV32
      disas/riscv: Fix rv32 encoding of zext.h
      disas/riscv: Fix isa decoding of rev8
      disas/riscv: Fix typo in th.lbib format
      disas/riscv: Split ventana_opcode_data
      disas/riscv: Split xlrbr_opcode_data
      disas/riscv: Split xthead_opcode_data
      disas/riscv: Move rv_op_illegal to riscv.c
      disas/riscv: Split out riscv-op.c.inc
      disas/riscv: Merge all mop.r.n to one pattern
      disas/riscv: Merge all mop.rr.n to one pattern
      disas/riscv: Merge all c.mop.n to one pattern
      disas/riscv: Tidy decode of c.mop.n
      disas/riscv: Tidy decode of mop.r.n and mop.rr.n
      disas/riscv: Split rvi_opcode_data
      disas/riscv: Sort riscv-op.c.inc

TANG Tiancheng (5):
      disas/riscv: Fix th.srri decoding
      disas/riscv: Fix 6-bit immediate extraction
      disas/riscv: Use signed type for vector immediates
      disas/riscv: Decode unsigned vector immediates as unsigned
      disas/riscv: Use extract helpers for operand fields

Tao Ding (6):
      hw/dma: add K230 gsdma
      hw/riscv: k230: add gsdma in K230 board
      tests/qtest: add test for K230 gsdma
      hw/riscv: k230: add decomp gzip in K230 board
      tests/qtest: add test for K230 decomp gzip
      hw/riscv: k230: add a noc stub region in K230 board

Xie Bo (2):
      target/riscv/kvm: Synchronize privilege mode
      target/riscv/kvm: Preserve MP state across migration

Yanfeng Liu (1):
      riscv/virt: Add optional UART1

Zeng Chi (1):
      target/riscv: Fix memory leak in riscv_trigger_unrealize()

Zephyr Li (1):
      target/riscv: do not count ECALL in minstret

wangyang (3):
      target/riscv: honor zicbo* envcfg gating in linux-user mode
      target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
      target/riscv: enforce even register constraints for Zdinx fcvt pairs

 MAINTAINERS                                       |    9 +
 docs/system/riscv/k230.rst                        |    6 +
 docs/system/riscv/virt.rst                        |    5 +-
 disas/riscv-xlrbr.h                               |    4 +-
 disas/riscv-xthead.h                              |   24 +-
 disas/riscv-xventana.h                            |    4 +-
 disas/riscv.h                                     |   47 +-
 include/hw/dma/k230_gsdma.h                       |  130 +
 include/hw/misc/iommu-testdev.h                   |    1 +
 include/hw/misc/k230_ddr.h                        |   59 +
 include/hw/misc/k230_decomp_gzip.h                |   92 +
 include/hw/riscv/k230.h                           |    9 +
 include/hw/riscv/virt.h                           |    3 +
 target/riscv/cpu.h                                |    4 +
 target/riscv/cpu_bits.h                           |   10 +-
 target/riscv/kvm/kvm_riscv.h                      |    2 +-
 target/riscv/tcg/pmu.h                            |    1 +
 target/riscv/cpu_cfg_fields.h.inc                 |    2 +
 disas/riscv-xlrbr.c                               |   57 +-
 disas/riscv-xthead.c                              |  509 +-
 disas/riscv-xventana.c                            |   23 +-
 disas/riscv.c                                     | 5305 +++++++--------------
 hw/dma/k230_gsdma.c                               |  551 +++
 hw/misc/iommu-testdev.c                           |   14 +-
 hw/misc/k230_ddr.c                                |  556 +++
 hw/misc/k230_decomp_gzip.c                        |  511 ++
 hw/riscv/k230.c                                   |   57 +-
 hw/riscv/riscv-iommu.c                            |   77 +-
 hw/riscv/sifive_u.c                               |   11 +-
 hw/riscv/virt-acpi-build.c                        |   12 +-
 hw/riscv/virt.c                                   |   40 +-
 target/riscv/cpu.c                                |   27 +-
 target/riscv/kvm/kvm-cpu.c                        |   62 +-
 target/riscv/machine.c                            |   49 +-
 target/riscv/tcg/csr.c                            |   54 +-
 target/riscv/tcg/debug.c                          |    2 +-
 target/riscv/tcg/op_helper.c                      |   17 +-
 target/riscv/tcg/pmu.c                            |   44 +-
 target/riscv/tcg/vector_helper.c                  |   65 +-
 tests/qtest/iommu-riscv-test.c                    |  102 +
 tests/qtest/k230-ddr-test.c                       |  226 +
 tests/qtest/k230-decomp-gzip-test.c               |  200 +
 tests/qtest/k230-gsdma-test.c                     |  201 +
 tests/qtest/k230-wdt-test.c                       |    2 +-
 tests/qtest/riscv-csr-test.c                      |   26 +
 disas/riscv-op.c.inc                              |  913 ++++
 disas/riscv-xlrbr-op.c.inc                        |    8 +
 disas/riscv-xthead-op.c.inc                       |  125 +
 disas/riscv-xventana-op.c.inc                     |    2 +
 target/riscv/tcg/insn_trans/trans_rvd.c.inc       |    6 +
 target/riscv/tcg/insn_trans/trans_rvf.c.inc       |   12 +-
 target/riscv/tcg/insn_trans/trans_rvi.c.inc       |    6 +
 target/riscv/tcg/insn_trans/trans_rvv.c.inc       |   18 +-
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc     |    8 +
 target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc |    2 +-
 hw/dma/Kconfig                                    |    3 +
 hw/dma/meson.build                                |    1 +
 hw/dma/trace-events                               |    6 +
 hw/misc/Kconfig                                   |    3 +
 hw/misc/meson.build                               |    2 +
 hw/misc/trace-events                              |    4 +
 hw/riscv/Kconfig                                  |    2 +
 tests/qtest/meson.build                           |    3 +-
 tests/tcg/riscv64/Makefile.softmmu-target         |   26 +
 tests/tcg/riscv64/test-minstret-ecall.S           |   55 +
 tests/tcg/riscv64/test-zicclsm.S                  |  368 ++
 66 files changed, 6485 insertions(+), 4300 deletions(-)
 create mode 100644 include/hw/dma/k230_gsdma.h
 create mode 100644 include/hw/misc/k230_ddr.h
 create mode 100644 include/hw/misc/k230_decomp_gzip.h
 create mode 100644 hw/dma/k230_gsdma.c
 create mode 100644 hw/misc/k230_ddr.c
 create mode 100644 hw/misc/k230_decomp_gzip.c
 create mode 100644 tests/qtest/k230-ddr-test.c
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c
 create mode 100644 tests/qtest/k230-gsdma-test.c
 create mode 100644 disas/riscv-op.c.inc
 create mode 100644 disas/riscv-xlrbr-op.c.inc
 create mode 100644 disas/riscv-xthead-op.c.inc
 create mode 100644 disas/riscv-xventana-op.c.inc
 create mode 100644 tests/tcg/riscv64/test-minstret-ecall.S
 create mode 100644 tests/tcg/riscv64/test-zicclsm.S

