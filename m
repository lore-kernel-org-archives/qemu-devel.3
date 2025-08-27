Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A4ACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRW-0001NA-Sp; Wed, 27 Aug 2025 19:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRT-0001Jr-MC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:35 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRR-00046e-3e
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:35 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-32326793a85so321280a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336830; x=1756941630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JgN0wixuo3B714zP3DBru/DLsg5wsRxJkkctFO+r8ok=;
 b=Dnwonp+4pra/ANLoLo/pXj++8RFmmdk2RI8ZbTMPI7PKFEC4K0RGVSPTcZcOS/RL3/
 8f1kD0WDdnDOJExnhTwfMgM7M7XXDeUfX825znuGB4heIM2yqjLQ3aBXBb/Ys/nlNBOk
 FxGLSu8XhzuVNj8r8dZDKvtltpZF5h0xQdULNH2JSdGj8p6tQBmJ0JPnq8m7Tmduj5Be
 qgZofUZtfc6LUgpklCiy+D0NEqIMAP+mkIvA5L3IvFFG4i+kvyw8qLiNVM9h6f5rWsFs
 PAxMcFm6sz8Aewty1DRDaP2R/2/Lva1FAsPkOHE5nk2rq+Q+kQKlEhrqsIISfjaEQi7z
 E1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336830; x=1756941630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JgN0wixuo3B714zP3DBru/DLsg5wsRxJkkctFO+r8ok=;
 b=XnOq7yOHeQ8X5at/8VWLdrIbd8Je3KEc3MjZZqWajMUalgzUFQyPS+BEAIpRCeUuqN
 HFYSpU3yphwDCrZycsCqZyS/aycdS5DhwCmkKapvrWIQpUpmYg8yxCNjlX5uLtrFyWm7
 24UKE2jJvOD9ebPGBnGqqXGagrQWcfaD8xkPp3z/nS9m0fkpYvCXRdX1bb4RdSb5X3+q
 0iCYtOffGoxYEr4eqPv32z1+1eb7tZ9seS9aT/KtcZL+2hgil9La7V/N5WdLavVTh3N0
 jzIzLeK6woCu154IIVsIB7F8Nwnm8wp92K0mcHdD7D6LC7rf8P8vRSqQRyRiL4vQTPTs
 b/kA==
X-Gm-Message-State: AOJu0YxhGj3GaIdBL56zAdKu55V3t2l71wpDOWYAjNme6F4Qd9imL5m1
 QgZG6Y9VKM5bZEKAgY44lizCp109PeBrEm39337nthqUGtid2EEjn33ronCwD5tnGjQj+U/J6c7
 /vXNIwdM=
X-Gm-Gg: ASbGnctxDCIN/W7OvcrbFRwMsXbF+WGOdU8VP2AAFZDbOywxm6P4r+g24zUdvi6OLrb
 CPT447N+yDoscH3VqQZtwHGa8pDKT/OuZ+WdRgq7LwCDk6kVsp34Xk4CN3B2eGcADfAsnpZ5neG
 /wPc7aOoCaxHYTWgtg/Tv4j97Co8sCeMesI7TWb5zcgSMgWLAjiajRrUq6uCoSNk2/doyww1A2C
 irBTPzIpXnB7YDwaeiegBo4rKFf5whVvpw6TTgQ5kuNgmYkyJYicHgonzE0GCqM96IGHELLrfNm
 RPBUKC7yaX/3achpmy2oGZZNzfHaS6FkKXgaWBawb7YQiqvnaB/+UDPxZc9YbK1DWRWR064/BoH
 ojdeyzViBSUFvoJR0rjHTuQ0KmH/RMA2yObLC
X-Google-Smtp-Source: AGHT+IH+Tq6oTgrtMh1bSw+wIwkiq7TQHhsjXGUqmsx5IVoSwEZYuZKaZ+ePMCgjyG/Wj9FGDUW2uQ==
X-Received: by 2002:a17:90b:1b12:b0:327:9c6e:47f5 with SMTP id
 98e67ed59e1d1-3279c6e490cmr2432795a91.10.1756336830337; 
 Wed, 27 Aug 2025 16:20:30 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] linux-user patch queue
Date: Thu, 28 Aug 2025 09:19:37 +1000
Message-ID: <20250827232023.50398-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The following changes since commit 5fc03d4e28258fdf6a926a59c6b5e1edc23e6d5d:

  Merge tag 'pull-request-2025-08-27' of https://gitlab.com/thuth/qemu into staging (2025-08-27 19:11:08 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20250828

for you to fetch changes up to a5fbf1c617c5b51082d317601e0d4cf5eea5c140:

  linux-user: do not print IP socket options by default (2025-08-28 07:33:34 +1000)

----------------------------------------------------------------
linux-user: do not print IP socket options by default
linux-user: Add strace for rseq
linux-user: Move get_elf_cpu_model to target/elfload.c
linux-user: Move get_elf_hwcap to target/elfload.c
linux-user: Move get_elf_hwcap2 to target/elfload.c
linux-user: Move get_elf_platform to target/elfload.c
linux-user: Move get_elf_base_platform to target/elfload.c
linux-user: Create init_main_thread in target/cpu_loop.c
semihosting: Retrieve stack top from image_info
semihosting: Initialize heap once per process

----------------------------------------------------------------
Joel Stanley (1):
      linux-user: Add strace for rseq

Richard Henderson (44):
      semihosting: Retrieve stack top from image_info
      semihosting: Initialize heap once per process
      linux-user: Create target/elfload.c files
      linux-user: Move ppc uabi/asm/elf.h workaround to osdep.h
      linux-user: Move get_elf_cpu_model to target/elfload.c
      linux-user: Move get_elf_hwcap to {i386,x86_64}/elfload.c
      linux-user: Move hwcap functions to {arm,aarch64}/elfload.c
      linux-user: Move get_elf_hwcap to sparc/elfload.c
      linux-user: Move hwcap functions to ppc/elfload.c
      linux-user: Move get_elf_hwcap to loongarch64/elfload.c
      linux-user: Move get_elf_hwcap to mips/elfload.c
      linux-user: Move get_elf_hwcap to sh4/elfload.c
      linux-user: Move hwcap functions to s390x/elfload.c
      linux-user: Move get_elf_hwcap to riscv/elfload.c
      linux-user: Remove ELF_HWCAP
      linux-user: Remove ELF_HWCAP2
      linux-user: Move get_elf_platform to {i386,x86_64}/elfload.c
      linux-user/i386: Return const data from get_elf_platform
      linux-user: Move get_elf_platform to arm/elfload.c
      linux-user/loongarch64: Create get_elf_platform
      linux-user/hppa: Create get_elf_platform
      linux-user: Remove ELF_PLATFORM
      linux-user: Move get_elf_base_platform to mips/elfload.c
      linux-user: Move target_cpu_copy_regs decl to qemu.h
      linux-user: Create do_init_main_thread
      linux-user/i386: Create init_main_thread
      linux-user/arm: Create init_main_thread
      linux-user/arm: Remove a.out startup remenents
      linux-user/aarch64: Create init_main_thread
      linux-user/sparc: Create init_main_thread
      linux-user/ppc: Create init_main_thread
      linux-user/loongarch64: Create init_main_thread
      linux-user/mips: Create init_main_thread
      linux-user/microblaze: Create init_main_thread
      linux-user/openrisc: Create init_main_thread
      linux-user/sh4: Create init_main_thread
      linux-user/m68k: Create init_main_thread
      linux-user/alpha: Create init_main_thread
      linux-user/s390x: Create init_main_thread
      linux-user/riscv: Create init_main_thread
      linux-user/hppa: Create init_main_thread
      linux-user/xtensa: Create init_main_thread
      linux-user/hexagon: Create init_main_thread
      linux-user: Remove do_init_main_thread

Łukasz Stelmach (1):
      linux-user: do not print IP socket options by default

 include/qemu/osdep.h                |    8 +
 include/user/cpu_loop.h             |    4 -
 linux-user/aarch64/target_elf.h     |    9 +-
 linux-user/alpha/target_elf.h       |    5 +-
 linux-user/arm/target_elf.h         |    9 +-
 linux-user/arm/target_proc.h        |    4 +-
 linux-user/hexagon/target_elf.h     |   29 -
 linux-user/hppa/target_elf.h        |    7 +-
 linux-user/i386/target_elf.h        |    8 +-
 linux-user/loader.h                 |   17 +-
 linux-user/loongarch64/target_elf.h |    8 +-
 linux-user/m68k/target_elf.h        |    9 -
 linux-user/microblaze/target_elf.h  |    5 +-
 linux-user/mips/target_elf.h        |   14 +-
 linux-user/mips64/target_elf.h      |   30 +-
 linux-user/openrisc/target_elf.h    |    5 +-
 linux-user/ppc/target_elf.h         |   12 +-
 linux-user/qemu.h                   |    8 +-
 linux-user/riscv/target_elf.h       |    7 +-
 linux-user/s390x/target_elf.h       |    7 +-
 linux-user/s390x/target_proc.h      |    2 +-
 linux-user/sh4/target_elf.h         |    7 +-
 linux-user/sparc/target_elf.h       |   11 +-
 linux-user/x86_64/target_elf.h      |    8 +-
 linux-user/xtensa/target_elf.h      |    5 -
 hw/core/loader.c                    |    4 -
 linux-user/aarch64/cpu_loop.c       |   22 +-
 linux-user/aarch64/elfload.c        |  349 ++++++++++
 linux-user/alpha/cpu_loop.c         |   11 +-
 linux-user/alpha/elfload.c          |   11 +
 linux-user/arm/cpu_loop.c           |   75 ++-
 linux-user/arm/elfload.c            |  201 ++++++
 linux-user/elfload.c                | 1229 +----------------------------------
 linux-user/hexagon/cpu_loop.c       |    8 +-
 linux-user/hexagon/elfload.c        |   35 +
 linux-user/hppa/cpu_loop.c          |   18 +-
 linux-user/hppa/elfload.c           |   16 +
 linux-user/i386/cpu_loop.c          |   48 +-
 linux-user/i386/elfload.c           |   25 +
 linux-user/linuxload.c              |    6 +-
 linux-user/loongarch64/cpu_loop.c   |   11 +-
 linux-user/loongarch64/elfload.c    |   63 ++
 linux-user/m68k/cpu_loop.c          |   32 +-
 linux-user/m68k/elfload.c           |   18 +
 linux-user/main.c                   |   13 +-
 linux-user/microblaze/cpu_loop.c    |   39 +-
 linux-user/microblaze/elfload.c     |   11 +
 linux-user/mips/cpu_loop.c          |   16 +-
 linux-user/mips/elfload.c           |  124 ++++
 linux-user/mips64/elfload.c         |    1 +
 linux-user/openrisc/cpu_loop.c      |   11 +-
 linux-user/openrisc/elfload.c       |   11 +
 linux-user/ppc/cpu_loop.c           |   26 +-
 linux-user/ppc/elfload.c            |  131 ++++
 linux-user/riscv/cpu_loop.c         |   15 +-
 linux-user/riscv/elfload.c          |   23 +
 linux-user/s390x/cpu_loop.c         |   15 +-
 linux-user/s390x/elfload.c          |   68 ++
 linux-user/sh4/cpu_loop.c           |   10 +-
 linux-user/sh4/elfload.c            |   38 ++
 linux-user/sparc/cpu_loop.c         |   16 +-
 linux-user/sparc/elfload.c          |   42 ++
 linux-user/strace.c                 |   36 +-
 linux-user/x86_64/elfload.c         |   21 +
 linux-user/xtensa/cpu_loop.c        |   22 +-
 linux-user/xtensa/elfload.c         |   11 +
 semihosting/arm-compat-semi.c       |   28 +-
 linux-user/strace.list              |    3 +
 meson.build                         |    6 +-
 69 files changed, 1528 insertions(+), 1629 deletions(-)
 create mode 100644 linux-user/aarch64/elfload.c
 create mode 100644 linux-user/alpha/elfload.c
 create mode 100644 linux-user/arm/elfload.c
 create mode 100644 linux-user/hexagon/elfload.c
 create mode 100644 linux-user/hppa/elfload.c
 create mode 100644 linux-user/i386/elfload.c
 create mode 100644 linux-user/loongarch64/elfload.c
 create mode 100644 linux-user/m68k/elfload.c
 create mode 100644 linux-user/microblaze/elfload.c
 create mode 100644 linux-user/mips/elfload.c
 create mode 100644 linux-user/mips64/elfload.c
 create mode 100644 linux-user/openrisc/elfload.c
 create mode 100644 linux-user/ppc/elfload.c
 create mode 100644 linux-user/riscv/elfload.c
 create mode 100644 linux-user/s390x/elfload.c
 create mode 100644 linux-user/sh4/elfload.c
 create mode 100644 linux-user/sparc/elfload.c
 create mode 100644 linux-user/x86_64/elfload.c
 create mode 100644 linux-user/xtensa/elfload.c

