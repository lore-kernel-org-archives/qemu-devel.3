Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCACF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHt-0002U1-1u; Sun, 22 Sep 2024 08:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHG-0000vA-Ru
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:31 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHA-0002MO-LV
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:20 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so413727066b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006474; x=1727611274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qf6+jenRzI/cRzyRq8XapwCu9KrmtXXYElrtDEDayls=;
 b=Fle0AzM0yR4iMWMCNBy0ZFYkDqMzW0NYouw3N4rOuwxuHxuHhBCsfdLI7gCDPx0wjW
 ViOQqjpdHiz8QS+aJ+RkOzwYDF72IlE+1WXnLWBtDd5LX0ATAyIIaL6HQZsCE2fE4jJC
 1k6SRQAd8TxaKEs6Re27R0Yo0Vkth8pcO7kEiVSszffGoV3qeljSHqLKPSMdMwwYg5I3
 HRUHAfZyqZbmmDxcKdMyShuGnXvee55ssDouLNhnVg5DiOlnFc2FaxnNLInnWFhVxavx
 Ac+dN1uPXkDnniE+l4haqcXztuogNPuDRzN0npx4HMQILXVOV8RlESxNNFhyq/I+OfDW
 zdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006474; x=1727611274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qf6+jenRzI/cRzyRq8XapwCu9KrmtXXYElrtDEDayls=;
 b=KO/AMW2ukTxg51LlqZsdRlAlY/8AWgokDLV5YatWue4EldUlROLsWNI/ATmMh0wb1y
 BUB9fVu5WywefYW5uSfzBZXg5MAgvyNWAHlmhMQU8WGMUidgBo78uC8kNbHsrX8jNXpW
 49lVCPOWgCetRvzwyOlT4QvnkREvztoaMk8ukyLBDt7sRS1MXUakO+zfTVCMgkF21FuS
 ZbmkIhAx4WVGR/LdKVPsqpXTPLXMNFneWByULKlUGU92IRd6gZ/JBX6y1Xwiy15+cbtt
 XQAP93l5p8PbU3VmIt+2gGjTw0jOGv/+SVzdZkEe3TfsgisVLtofAkPDGuBbyTZL4D+c
 Y4EA==
X-Gm-Message-State: AOJu0YwFXOlNmTDFnF1wV88sqxWAkCaV4/e5Hv31VkbeDyq4Z5TFO9g5
 d0ll5QsvugC3DFCF8esrpjCipbUln4UvmeKmvUkjAunBV9ALPQLdTUVKUBvUFAJYtPYUE5FJB+I
 n2Yw=
X-Google-Smtp-Source: AGHT+IGdVszDFu2zRr/AzNy6nSnmo1EIuMHHnXhMg1OMTg8O7rPE2pKo5jpseBGYu+MpPdY2JxmIYg==
X-Received: by 2002:a17:907:708:b0:a8a:8c4c:3e2a with SMTP id
 a640c23a62f3a-a90d56db727mr873385366b.23.1727006473373; 
 Sun, 22 Sep 2024 05:01:13 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/31] tcg + linux-user patch queue
Date: Sun, 22 Sep 2024 14:00:41 +0200
Message-ID: <20240922120112.5067-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:

  Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240922

for you to fetch changes up to c4d80fa63e823dc8dbf094b29e39b6978a3073b6:

  linux-user: update syscall.tbl to Linux v6.11 (2024-09-22 09:30:18 +0200)

----------------------------------------------------------------
target/ppc: Fix lxvx/stxvx facility check
linux-user: update syscall_nr.h to Linux v6.10
linux-user: update syscall.tbl to Linux v6.11
tcg: Fix iteration step in 32-bit gvec operation
tcg: Propagate new TCGOp to add_as_label_use
tcg/*: Do not expand cmp_vec, cmpsel_vec early
tcg/optimize: Fold movcond with true and false values identical
tcg/optimize: Optimize cmp_vec and cmpsel_vec
tcg/optimize: Optimize bitsel_vec
tcg/i386: Optimize cmpsel with constant 0 operand 3.
tcg/i386: Implement cmp_vec with avx512 insns
tcg/i386: Implement cmpsel_vec with avx512 insns
tcg/i386: Implement vector TST{EQ,NE} for avx512
tcg/ppc: Implement cmpsel_vec and optimize with constant 0/-1 arguments
tcg/s390x: Implement cmpsel_vec and optimize with constant 0/-1 arguments

----------------------------------------------------------------
Fabiano Rosas (1):
      target/ppc: Fix lxvx/stxvx facility check

Laurent Vivier (9):
      linux-user: update syscall_nr.h to Linux v6.10
      linux-user, mips: update syscall-args-o32.c.inc to Linux v6.10
      linux-user: update syscall.tbl to Linux v6.10
      linux-user,aarch64: move to syscalltbl file
      linux-user,openrisc: move to syscalltbl file
      linux-user,riscv: move to syscalltbl file
      linux-user,hexagon: move to syscalltbl file
      linux-user,loongarch: move to syscalltbl file
      linux-user: update syscall.tbl to Linux v6.11

Richard Henderson (20):
      tcg: Return TCGOp from tcg_gen_op[1-6]
      tcg: Propagate new TCGOp to add_as_label_use
      tcg: Export vec_gen_6
      tcg/i386: Split out tcg_out_vex_modrm_type
      tcg/i386: Do not expand cmp_vec early
      tcg/i386: Do not expand cmpsel_vec early
      tcg/ppc: Do not expand cmp_vec early
      tcg/s390x: Do not expand cmp_vec early
      tcg/optimize: Fold movcond with true and false values identical
      tcg/optimize: Optimize cmp_vec and cmpsel_vec
      tcg/optimize: Optimize bitsel_vec
      tcg/i386: Optimize cmpsel with constant 0 operand 3.
      tcg/i386: Implement cmp_vec with avx512 insns
      tcg/i386: Add predicate parameters to tcg_out_evex_opc
      tcg/i386: Implement cmpsel_vec with avx512 insns
      tcg/i386: Implement vector TST{EQ,NE} for avx512
      tcg/ppc: Implement cmpsel_vec
      tcg/ppc: Optimize cmpsel with constant 0/-1 arguments
      tcg/s390x: Implement cmpsel_vec
      tcg/s390x: Optimize cmpsel with constant 0/-1 arguments

TANG Tiancheng (1):
      tcg: Fix iteration step in 32-bit gvec operation

 linux-user/aarch64/syscall_nr.h            | 314 +------------------
 linux-user/hexagon/syscall_nr.h            | 332 --------------------
 linux-user/loongarch64/syscall_nr.h        | 312 ------------------
 linux-user/openrisc/syscall_nr.h           | 334 --------------------
 linux-user/riscv/syscall32_nr.h            | 308 ------------------
 linux-user/riscv/syscall64_nr.h            | 314 -------------------
 linux-user/riscv/syscall_nr.h              |  15 -
 linux-user/syscall_defs.h                  |   7 +-
 tcg/i386/tcg-target-con-set.h              |   1 +
 tcg/i386/tcg-target-con-str.h              |   1 +
 tcg/i386/tcg-target.h                      |   4 +-
 tcg/i386/tcg-target.opc.h                  |   1 -
 tcg/ppc/tcg-target-con-set.h               |   1 +
 tcg/ppc/tcg-target.h                       |   2 +-
 tcg/s390x/tcg-target-con-set.h             |   2 +
 tcg/s390x/tcg-target-con-str.h             |   1 +
 tcg/s390x/tcg-target.h                     |   2 +-
 tcg/tcg-internal.h                         |  14 +-
 linux-user/riscv/cpu_loop.c                |   2 +-
 tcg/optimize.c                             |  99 ++++++
 tcg/tcg-op-gvec.c                          |   2 +-
 tcg/tcg-op-vec.c                           |   4 +-
 tcg/tcg-op.c                               |  86 ++---
 configs/targets/aarch64-linux-user.mak     |   2 +
 configs/targets/aarch64_be-linux-user.mak  |   2 +
 configs/targets/hexagon-linux-user.mak     |   2 +
 configs/targets/loongarch64-linux-user.mak |   2 +
 configs/targets/or1k-linux-user.mak        |   2 +
 configs/targets/riscv32-linux-user.mak     |   3 +
 configs/targets/riscv64-linux-user.mak     |   3 +
 linux-user/aarch64/meson.build             |   6 +
 linux-user/aarch64/syscall_64.tbl          | 405 ++++++++++++++++++++++++
 linux-user/aarch64/syscallhdr.sh           |  28 ++
 linux-user/alpha/syscall.tbl               |  28 +-
 linux-user/arm/syscall.tbl                 |  25 +-
 linux-user/hexagon/meson.build             |   6 +
 linux-user/hexagon/syscall.tbl             | 405 ++++++++++++++++++++++++
 linux-user/hexagon/syscallhdr.sh           |  28 ++
 linux-user/hppa/syscall.tbl                |  41 ++-
 linux-user/i386/syscall_32.tbl             |  35 ++-
 linux-user/loongarch64/meson.build         |   7 +
 linux-user/loongarch64/syscall.tbl         | 405 ++++++++++++++++++++++++
 linux-user/loongarch64/syscallhdr.sh       |  28 ++
 linux-user/m68k/syscall.tbl                |  22 +-
 linux-user/meson.build                     |   2 +
 linux-user/microblaze/syscall.tbl          |  22 +-
 linux-user/mips/syscall-args-o32.c.inc     |  20 ++
 linux-user/mips/syscall_o32.tbl            |  36 ++-
 linux-user/mips64/syscall_n32.tbl          |  32 +-
 linux-user/mips64/syscall_n64.tbl          |  20 +-
 linux-user/openrisc/meson.build            |   5 +
 linux-user/openrisc/syscall.tbl            | 405 ++++++++++++++++++++++++
 linux-user/openrisc/syscallhdr.sh          |  28 ++
 linux-user/ppc/syscall.tbl                 |  71 +++--
 linux-user/riscv/meson.build               |   6 +
 linux-user/riscv/syscall.tbl               | 405 ++++++++++++++++++++++++
 linux-user/riscv/syscallhdr.sh             |  28 ++
 linux-user/s390x/syscall.tbl               |  34 +-
 linux-user/sh4/syscall.tbl                 |  25 +-
 linux-user/sparc/syscall.tbl               |  40 ++-
 linux-user/x86_64/syscall_64.tbl           |  30 +-
 linux-user/xtensa/syscall.tbl              |  22 +-
 scripts/gensyscalls.sh                     | 103 ------
 scripts/update-syscalltbl.sh               |   5 +
 target/ppc/translate/vsx-impl.c.inc        |   2 +-
 tcg/i386/tcg-target.c.inc                  | 488 ++++++++++++++++++-----------
 tcg/ppc/tcg-target.c.inc                   | 254 +++++++++------
 tcg/s390x/tcg-target.c.inc                 | 195 ++++++------
 68 files changed, 3361 insertions(+), 2560 deletions(-)
 delete mode 100644 linux-user/hexagon/syscall_nr.h
 delete mode 100644 linux-user/loongarch64/syscall_nr.h
 delete mode 100644 linux-user/openrisc/syscall_nr.h
 delete mode 100644 linux-user/riscv/syscall32_nr.h
 delete mode 100644 linux-user/riscv/syscall64_nr.h
 delete mode 100644 linux-user/riscv/syscall_nr.h
 create mode 100644 linux-user/aarch64/syscall_64.tbl
 create mode 100644 linux-user/aarch64/syscallhdr.sh
 create mode 100644 linux-user/hexagon/meson.build
 create mode 100644 linux-user/hexagon/syscall.tbl
 create mode 100644 linux-user/hexagon/syscallhdr.sh
 create mode 100644 linux-user/loongarch64/syscall.tbl
 create mode 100644 linux-user/loongarch64/syscallhdr.sh
 create mode 100644 linux-user/openrisc/meson.build
 create mode 100644 linux-user/openrisc/syscall.tbl
 create mode 100644 linux-user/openrisc/syscallhdr.sh
 create mode 100644 linux-user/riscv/syscall.tbl
 create mode 100644 linux-user/riscv/syscallhdr.sh
 delete mode 100755 scripts/gensyscalls.sh

