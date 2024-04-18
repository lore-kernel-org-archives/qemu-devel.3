Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F29C04FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRz6-00051h-FK; Thu, 18 Apr 2024 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rxRz4-00050f-Ds
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:39:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rxRz1-00024X-QL
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:39:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-349a31b2babso103985f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713447561; x=1714052361;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sKxV4vNn0xVLc410qBTqaMzk14l2dMYNkauNboBT5Z8=;
 b=0q2OGmExz87jeQ4HwcgwOllcaMJ5PXJHBmkhMzid3sj25i/FihwjvwnJo3/Is88gz5
 Mz8/uO0MvFqsz7/hBqr37tJM/2M/OTv4xj/ABeyY/QUFcAVKVgABtQnebzFuFnR1Wt+S
 Z8zYrKnCZXWuzYpCvgN9ccB+jhksUrK9ras3blgt49VW1PD8gpR5032Vyl/fPPH16JxZ
 4qPJg70eY94M0R6R8hutz3ZtrhV3VBMgvEbBCU0wNxiWAc8bpPO8mvp3yvZaEgjgkZ2w
 xTNf2h8KFEo34tjMXlhvrZOmGIaYsbRUmxFfluMLBKXegcEeVXDf+pEThanwuEKXSZBy
 ZeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713447561; x=1714052361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKxV4vNn0xVLc410qBTqaMzk14l2dMYNkauNboBT5Z8=;
 b=syzHjWAemQ1ueieMe0KSC+R01JO9OJPd1Ptzx6hje+qinGV6FwtouPoyRID9rvcSmK
 lG27zEcz2XHSBf+uPPvce6PUos7iteI71laRq6W8cd0sPgybuizbWDBqYsG7XNywb554
 E9RTMDOnFRk4+ir5RTBS5Ss6Je6x4pZ8IASMa+uN1lFzTuZZcbCjH+EXzmShX1CewMrq
 khub30uJWy8qNIyyELzIAqxDEgmBlZ8l+AEk77uZZiLAnRbcc6SavJ6uD6m8PHUl47qT
 Xc2MXSR4E4L1lltN0yYgeg33TeXu2hxTsQaf9kxv1/6rM0wQ56XA45tfBSIkDX5+CUFF
 LmjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVil9acWIyloKV34+IKAWbm6nf9XXsA9FAo63RLgcyt0ggyRh1zNG42JAKTWCSrLjXMsvMZYRimfpR8f7tRS5kcNwwibcw=
X-Gm-Message-State: AOJu0YxK65sYDffkAKHEsWy4wIktx9tasDOOmTG85Vu6+e97VOw0Yo84
 4ucAvxG68FQsipAT4ti1PRbDkpz7spjfaWfp4Lk/VLZWK+hQj3+as1dnsF2a8Ik=
X-Google-Smtp-Source: AGHT+IEAtksLls6R2/VOFy5ElGOSBoW9A5aEfFFRvCMLDKrLaxGHniD3JTBxLlBS1tnOrSsp+XcOXg==
X-Received: by 2002:a05:600c:5101:b0:416:a773:7d18 with SMTP id
 o1-20020a05600c510100b00416a7737d18mr1956281wms.0.1713447561443; 
 Thu, 18 Apr 2024 06:39:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
 by smtp.gmail.com with ESMTPSA id
 je12-20020a05600c1f8c00b004183edc31adsm6554015wmb.44.2024.04.18.06.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 06:39:20 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] target/riscv: Add support for Smdbltrp and Ssdbltrp
 extensions
Date: Thu, 18 Apr 2024 15:39:12 +0200
Message-ID: <20240418133916.1442471-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series adds support for Ssdbltrp as well as Smdbltrp [1].

Ssdbltrp can be tested using qemu[1], opensbi[2], linux[3] and
kvm-unit-tests[5]. Assuming you have a riscv environment available and
configured (CROSS_COMPILE), it can be built for riscv64 using the
following instructions:

Qemu:
  $ git clone https://github.com/rivosinc/qemu.git
  $ cd qemu
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ mkdir build && cd build
  $ ../configure --target-list=riscv64-softmmu
  $ make

OpenSBI:
  $ git clone https://github.com/rivosinc/opensbi.git
  $ cd opensbi
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ make O=build PLATFORM_RISCV_XLEN=64 PLATFORM=generic

Linux:
  $ git clone https://github.com/rivosinc/linux.git
  $ cd linux
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ export ARCH=riscv
  $ make O=build defconfig
  $ ./script/config --file build/.config --enable RISCV_DBLTRP
  $ make O=build

kvm-unit-tests:
  $ git clone https://github.com/clementleger/kvm-unit-tests.git
  $ cd kvm-unit-tests
  $ git switch dev/cleger/dbltrp_rfc_v1
  $ ./configure --arch=riscv64 --cross-prefix=$CROSS_COMPILE
  $ make

You will also need kvmtool in your rootfs. One can build a buildroot
rootfs using the buildroot provided at [6] (which contains an update
of kvmtool with riscv support).

Run with kvm-unit-test test as kernel:
  $ qemu-system-riscv64 \
    -M virt \
    -cpu rv64,x-ssdbltrp=true,x-smdbltrp=true \
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
    -cpu rv64,x-ssdbltrp=true,x-smdbltrp=true \
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

Link: https://github.com/riscv/riscv-double-trap/releases/download/v0.56/riscv-double-trap.pdf [1]
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_rfc_v1 [2]
Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/dbltrp_rfc_v1 [3]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_rfc_v1 [4]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_rfc_v1 [5]
Link: https://github.com/clementleger/buildroot/tree/dev/cleger/kvmtool [6]

---

Clément Léger (3):
  target/riscv: change RISCV_EXCP_SEMIHOST exception number
  target/riscv: add Ssdbltrp extension support
  target/riscv: add Smdbltrp extension support

 target/riscv/cpu.c        |  9 +++++-
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   | 10 +++++-
 target/riscv/cpu_cfg.h    |  2 ++
 target/riscv/cpu_helper.c | 66 ++++++++++++++++++++++++++++++++++-----
 target/riscv/csr.c        | 56 +++++++++++++++++++++++++++------
 target/riscv/op_helper.c  | 14 +++++++++
 7 files changed, 139 insertions(+), 19 deletions(-)

-- 
2.43.0


