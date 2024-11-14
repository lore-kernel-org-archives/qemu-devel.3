Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A683BD65C60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVvK-0008K9-8r; Thu, 14 Nov 2024 04:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvA-0008H9-Ue
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:49 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVv8-0007fr-7X
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:48 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso334523e87.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575624; x=1732180424;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4X9GILCETkqzxose88E+msWvMEv5P8DgclS9o6F4vro=;
 b=YKm745pb6jmzR521se1nSWPlCCo/2XsCW7mU7tdNZvfTAz8AC75QtjXgAufwk89x2D
 sxmzC56bJHDV/gydcnZCiQJam3qwnw9CZAfOWYa/02TOLPXUc2bqczLTW4b16Nscyd2l
 7PJ3cJpiH3NV+uiiiOAjubWlEehKO193gNgvFhz2loR4Si0C50feOTZUMdHQQ0vCK2KQ
 7VLN0WCf4Qf6HNZFQ6UqZ9vdL7jSVYcB6XCPvV8q6zbKtMcG9Fy5ZY22ppb+YwjRg6gz
 n4n82y3HlOzyHhutUAr/MxDRU/gIZI7WCdHrGbon6FVs9Y0Qwurbje6ZPvRwUOnaDlfl
 X7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575624; x=1732180424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4X9GILCETkqzxose88E+msWvMEv5P8DgclS9o6F4vro=;
 b=cEl770R5qiKuvBiNg3htiVLsYZOuuxBn7h9dFK44CAG1iySnMx245acf06Na+a06Ml
 l8c17dBjlgiRwDu/k0q00r2BOQr3P88tgSBRL89Z1V+EUfae1WuSpVYV5vw6YU5lNvyB
 TIxS/CrmXggzCP5Glp7WfrbQrwkVLjB+nXQDHhG+ASO1ZDu0JRe8r9CGbz3mGzGlxwdV
 5DP96FYfwUhk7E4De37FqB+EHNIURdZYLL7Vwo3NW/dK56VZzuHKQNk0vM+RumgkPuuo
 XGkeTe8nzn/zNEDTRCuUQ6A7ms6+3BQiKNcCosoj8rkCfK2HBqMMUPxgm/hNF4RIXyqs
 +PyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Pg5bbKP6Oz5EaxCukz8vP7AfqiZfeB2IE6ryOe7EimOZjalv1h131ve7gyQcdhP87ergu32StQBJ@nongnu.org
X-Gm-Message-State: AOJu0YwxbLrbp38hd/heDZH4q9rM6aPcZw/cx7eXD/rFIBKl1ZXwrLhT
 28QdlgSvFx7ZdN100c8j/jNHPXLQ9+DB7C3cqlFQbUoqQdbnjdNHYgDTcMPCTkA=
X-Google-Smtp-Source: AGHT+IFUXenJPm5D4EFqN8cx2OHuNjDlWm6yK8o8og66AjOraSN5UebgSKoHcPU/MumyNRqxRTQc2Q==
X-Received: by 2002:ac2:4c53:0:b0:539:9f52:9e4 with SMTP id
 2adb3069b0e04-53d9fef25e3mr3091263e87.48.1731575623579; 
 Thu, 14 Nov 2024 01:13:43 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:42 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 0/9] target/riscv: Add support for Smdbltrp and Ssdbltrp
 extensions
Date: Thu, 14 Nov 2024 10:13:21 +0100
Message-ID: <20241114091332.108811-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=cleger@rivosinc.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

A double trap typically arises during a sensitive phase in trap handling
operations — when an exception or interrupt occurs while the trap
handler (the component responsible for managing these events) is in a
non-reentrant state. This non-reentrancy usually occurs in the early
phase of trap handling, wherein the trap handler has not yet preserved
the necessary state to handle and resume from the trap. The occurrence
of such event is unlikely but can happen when dealing with hardware
errors.

This series adds support for Ssdbltrp and Smdbltrp ratified ISA
extensions [1]. It is based on the Smrnmi series [6].

Ssdbltrp can be tested using qemu[2], opensbi[3], linux[4] and
kvm-unit-tests[5]. Assuming you have a riscv environment available and
configured (CROSS_COMPILE), it can be built for riscv64 using the
following instructions:

Qemu:
  $ git clone https://github.com/rivosinc/qemu.git
  $ cd qemu
  $ git switch -C dbltrp_v5 dev/cleger/dbltrp_v5
  $ mkdir build && cd build
  $ ../configure --target-list=riscv64-softmmu
  $ make

OpenSBI:
  $ git clone https://github.com/rivosinc/opensbi.git
  $ cd opensbi
  $ git switch -C dbltrp_v3 dev/cleger/dbltrp_v3
  $ make O=build PLATFORM_RISCV_XLEN=64 PLATFORM=generic

Linux:
  $ git clone https://github.com/rivosinc/linux.git
  $ cd linux
  $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
  $ export ARCH=riscv
  $ make O=build defconfig
  $ ./script/config --file build/.config --enable RISCV_DBLTRP
  $ make O=build

kvm-unit-tests:
  $ git clone https://github.com/clementleger/kvm-unit-tests.git
  $ cd kvm-unit-tests
  $ git switch -C dbltrp_v1 dev/cleger/dbltrp_v1
  $ ./configure --arch=riscv64 --cross-prefix=$CROSS_COMPILE
  $ make

You will also need kvmtool in your rootfs.

Run with kvm-unit-test test as kernel:
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,ssdbltrp=true,smdbltrp=true \
    -nographic \
    -serial mon:stdio \
    -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
    -kernel kvm-unit-tests-dbltrp/riscv/sbi_dbltrp.flat
  ...
  [OpenSBI boot partially elided]
  Boot HART ISA Extensions  : sscofpmf,sstc,zicntr,zihpm,zicboz,zicbom,sdtrig,svadu,ssdbltrp
  ...
  ##########################################################################
  #    kvm-unit-tests
  ##########################################################################

  PASS: sbi: fwft: FWFT extension probing no error
  PASS: sbi: fwft: FWFT extension is present
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
  INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !

  sbi_trap_error: hart0: trap0: double trap handler failed (error -10)

  sbi_trap_error: hart0: trap0: mcause=0x0000000000000010 mtval=0x0000000000000000
  sbi_trap_error: hart0: trap0: mtval2=0x0000000000000003 mtinst=0x0000000000000000
  sbi_trap_error: hart0: trap0: mepc=0x00000000802000d8 mstatus=0x8000000a01006900
  sbi_trap_error: hart0: trap0: ra=0x00000000802001fc sp=0x0000000080213e70
  sbi_trap_error: hart0: trap0: gp=0x0000000000000000 tp=0x0000000080088000
  sbi_trap_error: hart0: trap0: s0=0x0000000080213e80 s1=0x0000000000000001
  sbi_trap_error: hart0: trap0: a0=0x0000000080213e80 a1=0x0000000080208193
  sbi_trap_error: hart0: trap0: a2=0x000000008020dc20 a3=0x000000000000000f
  sbi_trap_error: hart0: trap0: a4=0x0000000080210cd8 a5=0x00000000802110d0
  sbi_trap_error: hart0: trap0: a6=0x00000000802136e4 a7=0x0000000046574654
  sbi_trap_error: hart0: trap0: s2=0x0000000080210cd9 s3=0x0000000000000000
  sbi_trap_error: hart0: trap0: s4=0x0000000000000000 s5=0x0000000000000000
  sbi_trap_error: hart0: trap0: s6=0x0000000000000000 s7=0x0000000000000001
  sbi_trap_error: hart0: trap0: s8=0x0000000000002000 s9=0x0000000080083700
  sbi_trap_error: hart0: trap0: s10=0x0000000000000000 s11=0x0000000000000000
  sbi_trap_error: hart0: trap0: t0=0x0000000000000000 t1=0x0000000080213ed8
  sbi_trap_error: hart0: trap0: t2=0x0000000000001000 t3=0x0000000080213ee0
  sbi_trap_error: hart0: trap0: t4=0x0000000000000000 t5=0x000000008020f8d0
  sbi_trap_error: hart0: trap0: t6=0x0000000000000000

Run with linux and kvm-unit-test test in kvm (testing VS-mode):
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,ssdbltrp=true,smdbltrp=true \
    -nographic \
    -serial mon:stdio \
    -bios opensbi/build/platform/generic/firmware/fw_jump.bin \
    -kernel linux/build/arch/riscv/boot/Image
  ...
  [Linux boot partially elided]
  [    0.735079] riscv-dbltrp: Double trap handling registered
  ...

  $ lkvm run -k sbi_dbltrp.flat -m 128 -c 2
  ##########################################################################
  #    kvm-unit-tests
  ##########################################################################

  PASS: sbi: fwft: FWFT extension probing no error
  PASS: sbi: fwft: FWFT extension is present
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 0
  PASS: sbi: fwft: dbltrp: Double trap disabled, trap first time ok
  PASS: sbi: fwft: dbltrp: Set double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Get double trap enable feature value == 1
  PASS: sbi: fwft: dbltrp: Trapped twice allowed ok
  INFO: sbi: fwft: dbltrp: Should generate a double trap and crash !
  [   51.939077] Guest double trap
  [   51.939323] kvm [93]: VCPU exit error -95
  [   51.939683] kvm [93]: SEPC=0x802000d8 SSTATUS=0x200004520 HSTATUS=0x200200180
  [   51.939947] kvm [93]: SCAUSE=0x10 STVAL=0x0 HTVAL=0x3 HTINST=0x0
  KVM_RUN failed: Operation not supported
  $

Testing Smbdbltrp can be done using gdb and trigger some trap. For
instance, interrupt M-mode firmware at some point, set mstatus.mdt = 1
and corrupt some register to generate a NULL pointer exception.

Link: https://github.com/riscv/riscv-isa-manual/commit/52a5742d5ab5a0792019033631b2035a493ad981 [1]
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v5 [2]
Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/dbltrp_v3 [3]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [4]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_v1 [5]
Link: https://lore.kernel.org/all/20240902071358.1061693-1-tommy.wu@sifive.com/ [6]

---

V5:
 - Use 0 instead of false to set MSTATUS_MDT in helper_mnret()
 - Added explicit comments about henvcfg write mask being tricky.
 - Fixed a invalid menvcfg_mask in write_henvcfgh

V4:
 - Remove DTE from sstatus_v1_10_mask variable and add specific if for
   DTE masking where it's used.
 - Use mstatus_hs.sdt field rather than setting DTE to 0 in
   riscv_do_cpu_interrupt().
 - Add a fix for henvcfg value which was incorrectly set after changing
   menvcfg
 - Remove useless ext_ssdbltrp check in
   riscv_env_smode_dbltrp_enabled().
 - Remove useless mstatus clear in write_mstatus().
 - Add proper handling of SDT writing to vsstatus.
 - Add clearing of vsstatus//mstatus SDT field when DTE is disabled.
 - Fix wrong value being written for MDT/MIE in write_mstatush().
 - Rebased on Frank Snrnmi v7

V3:
 - Fix spec version from 1.12 to 1.13 for Smdbltrp and Ssdbltrp
 - Add better comments for dte/sdt computation in
   riscv_cpu_do_interrupt().
 - Move some CSR related changes to the CSRs related commits.

V2:
 - Squashed commits that added ext_s{s|m}dbltrp as suggested by Daniel

Clément Léger (9):
  target/riscv: fix henvcfg potentially containing stale bits
  target/riscv: Add Ssdbltrp CSRs handling
  target/riscv: Implement Ssdbltrp sret, mret and mnret behavior
  target/riscv: Implement Ssdbltrp exception handling
  target/riscv: Add Ssdbltrp ISA extension enable switch
  target/riscv: Add Smdbltrp CSRs handling
  target/riscv: Implement Smdbltrp sret, mret and mnret behavior
  target/riscv: Implement Smdbltrp behavior
  target/riscv: Add Smdbltrp ISA extension enable switch

 target/riscv/cpu.c        |   9 ++-
 target/riscv/cpu.h        |   1 +
 target/riscv/cpu_bits.h   |   8 +++
 target/riscv/cpu_cfg.h    |   2 +
 target/riscv/cpu_helper.c | 111 ++++++++++++++++++++++++++++--------
 target/riscv/csr.c        | 117 ++++++++++++++++++++++++++++++++++----
 target/riscv/op_helper.c  |  47 ++++++++++++++-
 7 files changed, 258 insertions(+), 37 deletions(-)

-- 
2.45.2


