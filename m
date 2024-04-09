Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ECAC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGN-0000Wk-FC; Tue, 09 Apr 2024 15:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGM-0000WN-3w
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGJ-0004cc-CK
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecff9df447so4779127b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691366; x=1713296166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tbc60AL4+SMOMTPsg2HiG0xE0AaTkxAWt2zpJ+2p98I=;
 b=LOlW6j7/OYze+rpM74nTZCnrBArM5mClp2sJ1ZHidZthORVUt6AI0rK44rbg2px1oq
 CREBBHE8SafoWKJSON9YmdW0fsaunZjGFBLGgeZtwreKv3q2/e5mQ7/4hYxFCPz+WLmq
 eN4tePXWXlD3G5+3t+vHnakbsGI0oVrt7OYXaWPuj6w8EtaAMGHv0swoVn8ZFwHijOoR
 7FxaaLOmZCYbv15jwRNVc5drO93SVLzwMmhyklo4rGGykdqw2daFsm0YoVbi/DNec3rH
 7jJOyvoiooIVZlhTJ7KVlWTDcP9iMey2LXUoa2s/h8/v4XU6RDaUKAxyPm0xoUSFboV3
 uplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691366; x=1713296166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tbc60AL4+SMOMTPsg2HiG0xE0AaTkxAWt2zpJ+2p98I=;
 b=ZExGtwdfVSQQvrL5zHDHGatbbdT8E7vbl8ieEh9Y62dHJec17/yp1Wj3WpicuPf/zB
 7mjCQL0i7c3xluLDAMryl35bQCbSYAZma0pbG2avORIy7Ly2ZmR1PAkf2cHWnuthE+1D
 vVJN2i5X0glwWPVXF8PvhdRJlN7cb99NA20jHYePCZBMpZe69FCIJ2dFx9Mdbo/BsNLP
 ocSRNxGtcqM08GK5HgyskOsP98b55dXV2QtyYtLglPuvqciO6bfyMpQoQ4Bf+pxlsYOK
 Phr20BxXnAw9jiCxSxLZbOGJzoN7acsxHFtQKFcm8w6ISuov68OBrQB7d2tIfSyPVsWc
 Yd5w==
X-Gm-Message-State: AOJu0YwwD/dLEADWgkeuNgJAw/KbGkzx0Mf6aI9W4t420PtB1ouwTmzy
 J5cBDYrK7kx931A7FI0ft5wr9sPQlyuKLfzCi1kfA4hGiOn4hxsPLPFvx+nK1EUK8fRO7jlyGDe
 /
X-Google-Smtp-Source: AGHT+IEyCO2tZ/OD/G3ctdUnXBdNjTywmaf85/am6rUm2MHak7C5P0kPJ3NrI8lsT0Z+ZykBFcNUiQ==
X-Received: by 2002:a05:6a20:2584:b0:1a7:aecd:997c with SMTP id
 k4-20020a056a20258400b001a7aecd997cmr982508pzd.0.1712691365966; 
 Tue, 09 Apr 2024 12:36:05 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/20] misc patch queue
Date: Tue,  9 Apr 2024 09:35:43 -1000
Message-Id: <20240409193603.1703216-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Defer 16 patches to 9.1; add fix for -strace.

r~


The following changes since commit bc0cd4ae881dff47e81581a8fea93a50b1d1dbe7:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-04-09 09:51:07 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240409

for you to fetch changes up to 143bcc1d59f174b6c6743bd4ca8f99415ed1aba2:

  linux-user: Preserve unswapped siginfo_t for strace (2024-04-09 07:47:11 -1000)

----------------------------------------------------------------
target/m68k: Fix fp accrued exception reporting
target/hppa: Fix IIAOQ, IIASQ for pa2.0
target/sh4: Fixes to mac.l and mac.w saturation
target/sh4: Fixes to illegal delay slot reporting
linux-user: Fix waitid return of siginfo_t and rusage
linux-user: Preserve unswapped siginfo_t for strace
tcg/optimize: Do not attempt to constant fold neg_vec
accel/tcg: Improve can_do_io management, mmio bug fix

----------------------------------------------------------------
Keith Packard (1):
      target/m68k: Map FPU exceptions to FPSR register

Nguyen Dinh Phi (1):
      linux-user: replace calloc() with g_new0()

Richard Henderson (14):
      tcg/optimize: Do not attempt to constant fold neg_vec
      linux-user: Fix waitid return of siginfo_t and rusage
      target/hppa: Fix IIAOQ, IIASQ for pa2.0
      target/sh4: Merge mach and macl into a union
      tcg: Add TCGContext.emit_before_op
      accel/tcg: Add insn_start to DisasContextBase
      target/arm: Use insn_start from DisasContextBase
      target/hppa: Use insn_start from DisasContextBase
      target/i386: Preserve DisasContextBase.insn_start across rewind
      target/microblaze: Use insn_start from DisasContextBase
      target/riscv: Use insn_start from DisasContextBase
      target/s390x: Use insn_start from DisasContextBase
      accel/tcg: Improve can_do_io management
      linux-user: Preserve unswapped siginfo_t for strace

Zack Buhman (4):
      target/sh4: mac.w: memory accesses are 16-bit words
      target/sh4: Fix mac.l with saturation enabled
      target/sh4: Fix mac.w with saturation enabled
      target/sh4: add missing CHECK_NOT_DELAY_SLOT

 include/exec/translator.h         |  4 ++-
 include/tcg/tcg.h                 |  6 ++++
 target/arm/tcg/translate.h        | 12 +++----
 target/m68k/cpu.h                 |  3 +-
 target/m68k/helper.h              |  2 ++
 target/sh4/cpu.h                  | 14 ++++++--
 target/sh4/helper.h               |  4 +--
 accel/tcg/translator.c            | 47 +++++++++++++------------
 linux-user/main.c                 |  6 +---
 linux-user/signal.c               | 12 +++++--
 linux-user/syscall.c              | 22 ++++++++----
 target/arm/tcg/translate-a64.c    |  2 +-
 target/arm/tcg/translate.c        |  2 +-
 target/hppa/int_helper.c          | 20 ++++++-----
 target/hppa/sys_helper.c          | 18 +++++-----
 target/hppa/translate.c           | 10 +++---
 target/i386/tcg/translate.c       |  3 ++
 target/m68k/cpu.c                 | 12 +++++--
 target/m68k/fpu_helper.c          | 72 +++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.c              |  4 +--
 target/m68k/translate.c           |  4 +--
 target/microblaze/translate.c     |  8 ++---
 target/riscv/translate.c          | 11 +++---
 target/s390x/tcg/translate.c      |  4 +--
 target/sh4/op_helper.c            | 51 +++++++++++++++------------
 target/sh4/translate.c            |  7 ++--
 tcg/optimize.c                    | 17 +++++----
 tcg/tcg.c                         | 14 ++++++--
 tests/tcg/aarch64/test-2150.c     | 12 +++++++
 tests/tcg/sh4/test-macl.c         | 67 ++++++++++++++++++++++++++++++++++++
 tests/tcg/sh4/test-macw.c         | 61 +++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/sh4/Makefile.target     |  8 +++++
 33 files changed, 412 insertions(+), 129 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2150.c
 create mode 100644 tests/tcg/sh4/test-macl.c
 create mode 100644 tests/tcg/sh4/test-macw.c

