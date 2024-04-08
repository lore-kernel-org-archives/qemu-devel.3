Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ED3CD129D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7t-0001xe-Vy; Mon, 08 Apr 2024 13:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7f-0001t6-RW
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7d-0003bj-Sg
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecf3f001c5so3908936b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598572; x=1713203372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9k9ndciImwZ4WkH8Un2QRbqbF4d943OAPd1HXXDTYZA=;
 b=Y2Ha7GgEg7iGj3qWpE0E6k5ivYLRJmm30c0P3opTpVaMwQ352XXFDrL3RXphHKE/jp
 SmF9dScvGg3ec+GsdtGH4AfGr5JMKtUY3lk6qnpOFwCz2+UEi9rnj7ZsS3e/8MHOtGea
 g7pDyFfC8yVDKWKax6Rd0XgN9Z0qq57Ti78RK4UpbvmCSegud5wBAdDwV3nNTH1MOrSw
 7/Y8AQtwk7msMsU5/e+wWgwF4VqJVt1A/sF2KCRCGuqYuB1b84ah3WcI3AzZupTrdPS4
 J4t0K4+MjbdjioCSTsQ3m0NK+CPKOCH9CFPPJ7VIEwx9DEteRhWh5Z+XugrpizL60vNM
 1MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598572; x=1713203372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9k9ndciImwZ4WkH8Un2QRbqbF4d943OAPd1HXXDTYZA=;
 b=JeBuHBTgkgUTWw6wiAnqBuEGYXzCGzLWLa0BuylD/Ioi7kalDb6FdqKtsSNbwZm0Ly
 094ny1LIPpygOV3CvV6qpZx6x8zOZPy9FfIc6N5xk96OSxBfZlBnNrRC3FmWzkb52841
 nl9XmBA0MFjFC9AFMyOvtLXRgL//fRiBYv/5qT5AAbDXoEy3W1bdkUCuZXZH2DtX0qoP
 LugnX0v4Y6efHvrAvS4A3GRW0XZFOp6f7GmgB19O5Mc3WSwz6SDRyNHnExU0fGaOiHqH
 4QH6wzM5OZCJunq+JPA4WRWGqy9uHURQbA0ajyuYJgTF6TXqmgOCinmeOD1bpBJZ2ms/
 Bs+Q==
X-Gm-Message-State: AOJu0YzBe/mBqpb66G+NC1E9KT0mvVRrlWZ+wVRU6ApPDEGZnUDgDboI
 gHHfQV64VjQ6Om6QOFvK+Jcp+kjoq4nC/4hwSO1c2YAUNr0nkmeUNvBbXBMEu76HNtZgxtVMbhE
 d
X-Google-Smtp-Source: AGHT+IGqqUNMDSBNhVJ9LDLq7xE1IIcNKKQzJ7C/sGyUoCM702Q7ECzkY6KiNwHgcVY276Om2OOBkg==
X-Received: by 2002:a05:6a20:5b19:b0:1a7:35b1:1894 with SMTP id
 kl25-20020a056a205b1900b001a735b11894mr7753989pzb.32.1712598572054; 
 Mon, 08 Apr 2024 10:49:32 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/35] misc patch queue
Date: Mon,  8 Apr 2024 07:48:54 -1000
Message-Id: <20240408174929.862917-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This started out to be tcg and linux-user only, but then added
a few target bug fixes, and the trolled back through my inbox
and picked up some other safe patch sets that got lost.


r~


The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:

  Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240408

for you to fetch changes up to 50dbeda88ab71f9d426b7f4b126c79c44860e475:

  util/bufferiszero: Simplify test_buffer_is_zero_next_accel (2024-04-08 06:27:58 -1000)

----------------------------------------------------------------
util/bufferiszero: Optimizations and cleanups, esp code removal
target/m68k: Semihosting for non-coldfire cpus
target/m68k: Fix fp accrued exception reporting
target/hppa: Fix IIAOQ, IIASQ for pa2.0
target/sh4: Fixes to mac.l and mac.w saturation
target/sh4: Fixes to illegal delay slot reporting
linux-user: Cleanups for do_setsockopt
linux-user: Add FITRIM ioctl
linux-user: Fix waitid return of siginfo_t and rusage
tcg/optimize: Do not attempt to constant fold neg_vec
accel/tcg: Improve can_do_io management, mmio bug fix

----------------------------------------------------------------
Alexander Monakov (5):
      util/bufferiszero: Remove SSE4.1 variant
      util/bufferiszero: Remove AVX512 variant
      util/bufferiszero: Reorganize for early test for acceleration
      util/bufferiszero: Remove useless prefetches
      util/bufferiszero: Optimize SSE2 and AVX2 variants

Keith Packard (3):
      target/m68k: Map FPU exceptions to FPSR register
      target/m68k: Pass semihosting arg to exit
      target/m68k: Support semihosting on non-ColdFire targets

Michael Tokarev (4):
      linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
      linux-user: do_setsockopt: make ip_mreq local to the place it is used and inline target_to_host_ip_mreq()
      linux-user: do_setsockopt: make ip_mreq_source local to the place where it is used
      linux-user: do_setsockopt: eliminate goto in switch for SO_SNDTIMEO

Michael Vogt (1):
      linux-user: Add FITRIM ioctl

Nguyen Dinh Phi (1):
      linux-user: replace calloc() with g_new0()

Richard Henderson (17):
      tcg/optimize: Do not attempt to constant fold neg_vec
      linux-user: Fix waitid return of siginfo_t and rusage
      target/hppa: Fix IIAOQ, IIASQ for pa2.0
      target/sh4: Merge mach and macl into a union
      target/m68k: Perform the semihosting test during translate
      tcg: Add TCGContext.emit_before_op
      accel/tcg: Add insn_start to DisasContextBase
      target/arm: Use insn_start from DisasContextBase
      target/hppa: Use insn_start from DisasContextBase
      target/i386: Preserve DisasContextBase.insn_start across rewind
      target/microblaze: Use insn_start from DisasContextBase
      target/riscv: Use insn_start from DisasContextBase
      target/s390x: Use insn_start from DisasContextBase
      accel/tcg: Improve can_do_io management
      util/bufferiszero: Improve scalar variant
      util/bufferiszero: Introduce biz_accel_fn typedef
      util/bufferiszero: Simplify test_buffer_is_zero_next_accel

Zack Buhman (4):
      target/sh4: mac.w: memory accesses are 16-bit words
      target/sh4: Fix mac.l with saturation enabled
      target/sh4: Fix mac.w with saturation enabled
      target/sh4: add missing CHECK_NOT_DELAY_SLOT

 include/exec/translator.h         |   4 +-
 include/qemu/cutils.h             |  32 +++-
 include/tcg/tcg.h                 |   6 +
 linux-user/ioctls.h               |   3 +
 linux-user/syscall_defs.h         |   1 +
 linux-user/syscall_types.h        |   5 +
 target/arm/tcg/translate.h        |  12 +-
 target/m68k/cpu.h                 |   5 +-
 target/m68k/helper.h              |   2 +
 target/sh4/cpu.h                  |  14 +-
 target/sh4/helper.h               |   4 +-
 accel/tcg/translator.c            |  47 ++---
 linux-user/main.c                 |   6 +-
 linux-user/syscall.c              |  95 +++++-----
 target/arm/tcg/translate-a64.c    |   2 +-
 target/arm/tcg/translate.c        |   2 +-
 target/hppa/int_helper.c          |  20 +-
 target/hppa/sys_helper.c          |  18 +-
 target/hppa/translate.c           |  10 +-
 target/i386/tcg/translate.c       |   3 +
 target/m68k/cpu.c                 |  12 +-
 target/m68k/fpu_helper.c          |  72 ++++++++
 target/m68k/helper.c              |   4 +-
 target/m68k/m68k-semi.c           |   4 +-
 target/m68k/op_helper.c           |  14 +-
 target/m68k/translate.c           |  54 +++++-
 target/microblaze/translate.c     |   8 +-
 target/riscv/translate.c          |  11 +-
 target/s390x/tcg/translate.c      |   4 +-
 target/sh4/op_helper.c            |  51 ++---
 target/sh4/translate.c            |   7 +-
 tcg/optimize.c                    |  17 +-
 tcg/tcg.c                         |  14 +-
 tests/tcg/aarch64/test-2150.c     |  12 ++
 tests/tcg/sh4/test-macl.c         |  67 +++++++
 tests/tcg/sh4/test-macw.c         |  61 ++++++
 util/bufferiszero.c               | 379 +++++++++++++++++---------------------
 tests/tcg/aarch64/Makefile.target |   2 +-
 tests/tcg/sh4/Makefile.target     |   8 +
 39 files changed, 696 insertions(+), 396 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2150.c
 create mode 100644 tests/tcg/sh4/test-macl.c
 create mode 100644 tests/tcg/sh4/test-macw.c

