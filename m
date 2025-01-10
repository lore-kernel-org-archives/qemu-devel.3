Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2744BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEXh-0004Gb-R4; Fri, 10 Jan 2025 07:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXT-00049E-NW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXN-0000yN-OZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:54:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1280673f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736513691; x=1737118491;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HUWbMWiJsodZ0h+IpbBBVfmT0eew1n8LHYvYIP+aD5w=;
 b=sq76M+6mtyBjIlCkhNXBKvT/KBp41xq3WQOfBlsSWHZ/UrgRfIo61T81AnSzTU8DT3
 xiol5hUM84q50VsEHnRdGWT25JleYpWdFtF4MfAKl1dR3j2I4VPNp/RFzVv+LC83ksag
 66UntjGy+nTRcPEgGsMp4kaBNZdKiurttDzaVF3GRQfJ8YS7WeZ6fE7KUiBzkreaHDGl
 +0b4r9yWKE8A/suEJS9ZaY5+relleLil8v9J/FNidF53fl/JruenjEAS2tGpM9VwrD7l
 VACA05Cs4BNAEu5iOXgDpNaLYy81JJB6FrsLnJsxEWL8qqo6x0t3/s2c1JGjg1kNQIQb
 nj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513691; x=1737118491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUWbMWiJsodZ0h+IpbBBVfmT0eew1n8LHYvYIP+aD5w=;
 b=mPpSYwh/pv1eFA60h+vFWQ9oifv7qYPvH2ZFAdOmGfdZJVKyouaeImy8fApAJYCl2e
 PVVSUWzBowooSNmBqlB1m9zdyXPIkm80SC20a2RrsF6VxgiPeAPiMiibpudAG70lnSIN
 TgkoKjQXyWXXgyDLqMH1rC3OrFHFFvjaooOIYKGO2zYoKtYYptPcpTTUe+OnehBeS+Ga
 I4F1pI6I3VaVG1VONJMYLdxR0IuUVONJnKd3c7jsRhK/5wtFWgU2kuNAlVA2m0CtumNd
 uxVLeUPgGLFPXVfEG/o0JGgaL/1UvZoxEt3Rd1qSCLbWsbSOq17kHg4N4Aoz9LKQwdod
 k9Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLuRgqhdqEJymKn2KVoPW/yCgChb+cfvRJ/I+KHD7N2nG6VoV9csuLXpACY4k3v5wMGclNTcTWnu7C@nongnu.org
X-Gm-Message-State: AOJu0YxW6y7h/4AcXW+s4n8VvGc2oo/aNxCtY+oUqVAcshXr9mkgqcv6
 DFXJ1dQ1tpQ9C0lZreuL6PxOA9Tr5tdAS5t43ezg9yDgYm2xeDwJx7BwNszr974=
X-Gm-Gg: ASbGnctEO74+nvk3oHPElDp6luE/k33I0MUF+jBH5GPLOLKpiMtDdQEkVNCSb8zE7T6
 Xljv9+zJPRnl7nbSHOmWn7WBtGSiet3EhXLLt+7/pvrpwdN6J19xevBUa8cKW3AaBCJAfX4jHdJ
 I5GrG36s7bhXtrsc3E5KAfXkIdqhWrzqWsio27hn6QuiNAc/UrzaxUahr3eFIYGDW9iXWkX0vuE
 s5Y5vafCzODeADbUHQFXeSNAuM18nk+h7C0AuqZMDfk4M46BqiWNItdEg==
X-Google-Smtp-Source: AGHT+IEZaMZmTSHnrzRUem7j96IFmX89gzeo4iCvb76dVlVDaHaMFTZkdwcAWWPuHo7r9tm4WPZ/tw==
X-Received: by 2002:a05:6000:154f:b0:386:32ca:7b5e with SMTP id
 ffacd0b85a97d-38a8b0e5092mr5787408f8f.16.1736513691444; 
 Fri, 10 Jan 2025 04:54:51 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm4548921f8f.97.2025.01.10.04.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:54:50 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 0/9] target/riscv: Add support for Smdbltrp and Ssdbltrp
 extensions
Date: Fri, 10 Jan 2025 13:54:31 +0100
Message-ID: <20250110125441.3208676-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x432.google.com
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
extensions [1]. It is based on the Smrnmi series [5].

Ssdbltrp can be tested using qemu[2], opensbi (master branch), linux[3] and
kvm-unit-tests[4]. Assuming you have a riscv environment available and
configured (CROSS_COMPILE), it can be built for riscv64 using the
following instructions:

Qemu:
  $ git clone https://github.com/rivosinc/qemu.git
  $ cd qemu
  $ git switch -C dbltrp_v8 dev/cleger/dbltrp_v8
  $ mkdir build && cd build
  $ ../configure --target-list=riscv64-softmmu
  $ make

OpenSBI:
  $ git clone https://github.com/rivosinc/opensbi.git
  $ cd opensbi
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
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v8 [2]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [3]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_v1 [4]
Link: https://lore.kernel.org/qemu-riscv/20241217062440.884261-1-frank.chang@sifive.com/ [5]

---

V8:
 - Rebased on top of Atish counter_delegation_v4 series

V7:
 - Rebased on riscv-to-apply.next, on top of snrmi v10 series

V6:
 - Simplify and fix write_henvcfg() masking by assigning the written
   value to henvcfg and mask the value to be written as well as clearing
   the upper part of henvcfgh upon writing.
 - Rebased on RNMI v9 series.

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
  target/riscv: Fix henvcfg potentially containing stale bits
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
 target/riscv/cpu_helper.c | 116 +++++++++++++++++++++++++++++++-------
 target/riscv/csr.c        |  94 +++++++++++++++++++++++++-----
 target/riscv/op_helper.c  |  47 ++++++++++++++-
 7 files changed, 240 insertions(+), 37 deletions(-)

-- 
2.47.1


