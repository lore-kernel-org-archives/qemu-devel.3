Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C21D69114
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfGZ-00054H-Rc; Thu, 28 Nov 2024 09:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGN-00052H-3x
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:12:59 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGK-0005gl-IG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:12:58 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-214f6ed9f17so7418705ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803175; x=1733407975;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vQBFrlxc0zmdG1q2xmRwwDJvUCCXnMru7jm1Ysy8SpY=;
 b=t253npOGPc/qO/o0G0nO5TQRWCYMmTva7xoOOnbHQuQG+aa2WdqEtWeOuh2TfSYgHI
 7m4gRNS1UuykncUKb7Dy+34GaiGgOb9uU1bnNFlDuvqJX0YQ2GkS+f7Odzg2WB7ePc/r
 MlXnOY946Bc5svkiVx/aendMpJ2EJQb2YOnmn/ssstFv6EugCInhPX6fOU2vwDUq0NIJ
 2Xx4NdaSTbR/4BmLtUFEQkRe0fWv+6FaZnrS48YJq1rlKufSXy9WJjpmwVj41ANZuD/d
 qq0nrcsUsTslh7e1optslVJL5hGE8vLMxb53ncipkAAaQBuX68i1fw2Z6TWxQz1xhT0z
 XnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803175; x=1733407975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQBFrlxc0zmdG1q2xmRwwDJvUCCXnMru7jm1Ysy8SpY=;
 b=Mwep3Wrw4+Eb2TqCKbJ/egwlpi5AsDxQgxQja5ClsLVWJhv1OY7m/GZB8YsLfFWXrZ
 ul8cnwomEgTkN3u2oLm4/W7D8ww7tlx15KQ8n+IU/GUXIarr2F89J9iR6WKRJy7TrSbC
 bIFGD1vE1RRQ7vNxOLhFEZR00PF+zH0Fv1cyoi8h7OeaaKHxpUToVsMcEkswsw1Fqhpg
 BPPteTAkPNYuIEOZhRzS4sOhYDO4lsAOthc/3R0Hesi4IAj9q+nqvf/rbML76guEwFgX
 Y54qP96LfMZLS8m3AoQioeU6fEz1r1sVS3h/p9twr0yLo+i1UYWDc9qzRXW9sje4pP+d
 Tgmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV04761HVeW/DJ/zCXzuSFEg332V0hr6c3w4NR9BysGjvxJ5nQ39Fhp6nfd4F51wCwRG+e/IagxCoZc@nongnu.org
X-Gm-Message-State: AOJu0Ywk0TJzGOKrEYbmBvX4sEJ7q8PYjGkY6eX0yyIUj3C7vCvyS7wW
 feClFmAiEocDm32qP07nx9Deup3akfejWcYN4OukhCwrIOaRNDoyppg3nHL9yVY=
X-Gm-Gg: ASbGncs7D3O/ZEb7Q04gCXEYBOwZs825b0CMjgaz71k9LPc2TSFYLtt/HgopteE2uUw
 ASMjdwjmdUU3SV7q5eMOcTnT/0MKfjJP+dVHDGTCPO70Ma4c3INBkd7DsGSpjckz3a/FujUJ8VX
 UG92Z+Yc9myozRn1zifo73GiOf9+6LyfL7L4zltkvw5dyJQfGJsJvWid2QYkub39mFe+uMVXhKR
 PWIJ/TLeSnI91LtCWaEFucCE9oPdRbQelyOrU2ZztEbVE1gu64=
X-Google-Smtp-Source: AGHT+IGyoT7KmKn0ogYspFtflUt8G7/sjt3KmJlIqD2gNY1dOhfLAgvZsJmFBazlRnGOkVAjMYxdRg==
X-Received: by 2002:a17:902:ccd2:b0:212:e29:3b34 with SMTP id
 d9443c01a7336-21501f6fc6cmr87908325ad.55.1732803174765; 
 Thu, 28 Nov 2024 06:12:54 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:12:53 -0800 (PST)
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
Subject: [PATCH v6 0/9] target/riscv: Add support for Smdbltrp and Ssdbltrp
 extensions
Date: Thu, 28 Nov 2024 15:12:20 +0100
Message-ID: <20241128141230.284320-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x633.google.com
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
  $ git switch -C dbltrp_v6 dev/cleger/dbltrp_v6
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
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/dbltrp_v5 [2]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/dbltrp_v1 [3]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/dbltrp_v1 [4]
Link: https://lore.kernel.org/qemu-riscv/20241122032217.3816540-1-frank.chang@sifive.com/T/ [5]

---

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
 target/riscv/cpu_helper.c | 115 +++++++++++++++++++++++++++++++-------
 target/riscv/csr.c        |  95 ++++++++++++++++++++++++++-----
 target/riscv/op_helper.c  |  47 +++++++++++++++-
 7 files changed, 239 insertions(+), 38 deletions(-)

-- 
2.45.2


