Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDDCD374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rrr-0002Yb-2t; Thu, 17 Oct 2024 10:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rrp-0002VY-I9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:52:45 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rrm-0006rT-Pi
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:52:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea68af2f62so873607a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176761; x=1729781561;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VpUSykMdtg9H5ZNlOxxwAT2zsO6rMn5oUiqQd3/Atrw=;
 b=uGqeFK2Ge1n7W+JhxDiZstRoax6y+hZERf71xSGtQiERIAGyxcM60+pORarrpl4F5g
 oV91Uqw9fUulnA8kv8h3PyqB4u8nVxJK+2rB1SrFfjLT39wENo+/jtwgZ9Jp7UeBrbNI
 g7OvAMd1vgJdkI7/D8N5mdYwROdGczxT7zpzhH7JY4l+x3EbM2nXh3KNCI0j4LFWFO7z
 c1HB/Q62mcnJYrOEtjMSgAOUzXo8hTEtbkRJkMSgDXO/q164x42wiwSd/LdR4/fVUa5n
 0jktpN2rkEm+nqAeiNBnSBwXhWaSuOpK2Yp79wN1JSc6Ttft/qEZP3brvY7BVmoheBsR
 XqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176761; x=1729781561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VpUSykMdtg9H5ZNlOxxwAT2zsO6rMn5oUiqQd3/Atrw=;
 b=cKnXOVbVpxGpCXPRCdd72jZYgud+hhmOd0wzGBG8VEDISoP3Vt6EG0fF+1YOlnmIuP
 qUgz4XYS/XjrNr5OBiBNc44l1WbwlErVuFMOLyeM+vwo88FLmKgwOZX9m5aSR49LVivZ
 MVxtVqjiurVDuGh6Tnv+DobMxR1o8ibGj1rv7g23PoYnDYRFCiD9pfmsJdMfHpey7M70
 D8NrCR1hp3yrbhhHzHDnIBbft2sA/okvDn/Hdhhvx7iHqILyJV3do4taEd7wmK7t5iBm
 gMOQZ0LMZmV4lzDxoDAuIhPuYReATj5LEqEa1hZcXB12ise0CkzXs02DALJJPiqyE4Lj
 pCcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBK6uethEi9jDmb+y6RnyQBEvSd4Xl7HCZcVftXi67prUbFDu9FA5ipV/ybB3T+az5/Fpjo3CPMGxG@nongnu.org
X-Gm-Message-State: AOJu0YxT4xbF5qY9le6TqzESu9HciZtP1rFINzvvJRwqy9bv7NzrOVva
 q/FSs757HpL19NvmG9eSRI6HdxFcHf8QFccvEpdFb69gUm5TwFaVaToqCKLUS8A=
X-Google-Smtp-Source: AGHT+IEdF/xirij7wIy/xiTf/XIVcM4nGQTceUxWjCsuBGz9EktfqkZZxe+TQWT/902OeVy2hwp9wQ==
X-Received: by 2002:a05:6a20:9f4a:b0:1d8:b962:6087 with SMTP id
 adf61e73a8af0-1d8c9576f99mr27175719637.10.1729176761016; 
 Thu, 17 Oct 2024 07:52:41 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:52:40 -0700 (PDT)
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
Subject: [PATCH v4 0/9] target/riscv: Add support for Smdbltrp and Ssdbltrp
 extensions
Date: Thu, 17 Oct 2024 16:52:11 +0200
Message-ID: <20241017145226.365825-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x532.google.com
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
  $ git switch -C dbltrp_v4 dev/cleger/dbltrp_v4
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
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v4 [2]
Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/dbltrp_v3 [3]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [4]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_v1 [5]
Link: https://lore.kernel.org/all/20240902071358.1061693-1-tommy.wu@sifive.com/ [6]

---

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

 target/riscv/cpu.c        |   9 +++-
 target/riscv/cpu.h        |   1 +
 target/riscv/cpu_bits.h   |   8 +++
 target/riscv/cpu_cfg.h    |   2 +
 target/riscv/cpu_helper.c | 111 ++++++++++++++++++++++++++++++--------
 target/riscv/csr.c        |  98 ++++++++++++++++++++++++++++-----
 target/riscv/op_helper.c  |  47 +++++++++++++++-
 7 files changed, 239 insertions(+), 37 deletions(-)

-- 
2.45.2


