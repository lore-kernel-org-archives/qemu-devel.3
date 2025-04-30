Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA39C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcS-0004yz-V9; Wed, 30 Apr 2025 12:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcF-0004nd-AM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:48:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcD-0001su-EQ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:48:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso153607b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031736; x=1746636536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O4zYDJbdpR/FrzhrRg+fV3d8oWcQbVNqXLcCbboBlZ8=;
 b=yK5TL4QsGKuHTMdv9/PJWUIoPHpIpfENrdYwRHBeOD4JBKO1cKTTEN0qNw45R1RAkQ
 rMO3J4DbT/Eli701ZgrvjnVvV36TrrzwRmrecPGALWOk5YQwxJ34ZdUbv8XIzG6sXTqE
 yX1+HuiEzfZ6SfmAGINznXNGg92kz224KODM/gD0Teg2ysARYav4Zy7Vcq2pj9J028LU
 hBWz6OBrubzQQFZlHZ2Rktpwpe6s0EMn9s568jy5O3whIFaqRHxR8XOEeiP6yWW6Z1Eb
 kWGJL0bsdij9woLjsAWmI+WKwoGZ1qhRvKk2wzhwfkidJt26BGNLNWtIq7e0MCyRN8Mc
 x4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031736; x=1746636536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4zYDJbdpR/FrzhrRg+fV3d8oWcQbVNqXLcCbboBlZ8=;
 b=mZCEEEtFL+LykEBZVPsOVGCq625xw3OcXF+XTGFH/RiiR4OjBmIb48iK/XshyTsiXz
 95otzF5Bz54wg9dcErwmAaLEK7o0pndwPqKNbgwB1IiFOeoBvl48uYaih/XINUyCXjqO
 6rwUTgQ+frqMiGtsPa0JVPKlwaCqc5WcUS3mkKUk/Fdcm3U66dCVQGvPL0w/ijv+tS+O
 9l5NpA77mm3ISPGs9yEsKLz/E6tTv8a4lfBQeOenWj9ypDwnBhfzoOD4zYYVAvDzxHAF
 fEHhpDFQ0ClFT1tUoyZbQ96/dlLaxjNROyT/BGkoFyTVOl0GzrfpPtWVmn/vk65HzscI
 FGQA==
X-Gm-Message-State: AOJu0YyJe8y6vJ07l04bLgZuQ6KeE1URrEUq7mhLmGiqnBT8h0p/A65m
 OrkWeOkhkN0ifXlxcS3ySUW2H5mi9TOLeLMh9SAHaGCUer8VzLK8RxvF24VlsXsH3Z0fW6VebDs
 1
X-Gm-Gg: ASbGncu2QiJSR4/tc/Qq7Ghkz22+J01Kz22PcxtHGCWdm+qDkNoaPWYKuWheMxmAfSN
 id0G7xV74/4jfQcHGeTx0uWtjgqjI9iuEf4QuvR67kghGLoaZmPvYA19h99x2QqB05feUnRckk+
 +tCjSnjoPWqEYhS0kM9nn/3yxMlsTg1dqkgO/2gjSQUWyQi84d/uocLoQ3gfWwqbjTP06WeC/pk
 tUEbuxObwYPE5KsSAz90QJa010WLhm2opTEL9aVmMnbwWdfi5rOVsL01vOBiIk5Z8ti5IK1bnKc
 hAODsPEO5IzI2qS5PPPiHYyLbj60DQY2nlfJuLlcWH2TLXpbry4it+Stxd6Oh2ib7KfejXM1Lhw
 =
X-Google-Smtp-Source: AGHT+IH61rK3qZ2T/Tht3yNPmGDL/FgQ4FOe7tH4a0tIMcucjA8v+hIunm9KpS9Q6pq9SwghTDpEpA==
X-Received: by 2002:a05:6a20:12d5:b0:1f5:9961:c44 with SMTP id
 adf61e73a8af0-20a87647a7fmr5267695637.3.1746031735646; 
 Wed, 30 Apr 2025 09:48:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:48:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 00/16] accel/tcg: Compile cpu-exec.c twice
Date: Wed, 30 Apr 2025 09:48:38 -0700
Message-ID: <20250430164854.2233995-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

For v2, changes to TCGTBCPUState and pass it around more
within the accel/tcg/ subroutines.

r~

Richard Henderson (16):
  accel/tcg: Generalize fake_user_interrupt test
  accel/tcg: Unconditionally use CPU_DUMP_CCOP in log_cpu_exec
  accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
  target/i386: Split out x86_cpu_exec_reset
  accel/tcg: Hoist cpu_get_tb_cpu_state decl to accl/tcg/cpu-ops.h
  target/arm: Move cpu_get_tb_cpu_state to hflags.c
  target/arm: Unexport assert_hflags_rebuild_correctly
  target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
  accel/tcg: Return TCGTBCPUState from cpu_get_tb_cpu_state
  accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
  accel/tcg: Pass TCGTBCPUState to tb_lookup
  accel/tcg: Pass TCGTBCPUState to tb_htable_lookup
  accel/tcg: Use TCGTBCPUState in struct tb_desc
  accel/tcg: Pass TCGTBCPUState to tb_gen_code
  accel/tcg: Split out accel/tcg/helper-retaddr.h
  accel/tcg: Compile cpu-exec.c twice

 accel/tcg/internal-common.h        |   5 +-
 include/accel/tcg/cpu-ldst.h       |  34 ------
 include/accel/tcg/cpu-ops.h        |   9 ++
 include/accel/tcg/helper-retaddr.h |  43 ++++++++
 include/accel/tcg/tb-cpu-state.h   |  18 ++++
 target/alpha/cpu.h                 |  11 --
 target/arm/cpu.h                   |   3 -
 target/arm/internals.h             |   4 +-
 target/avr/cpu.h                   |  18 ----
 target/hexagon/cpu.h               |  15 ---
 target/hppa/cpu.h                  |   3 -
 target/i386/cpu.h                  |  14 ---
 target/loongarch/cpu.h             |  12 ---
 target/m68k/cpu.h                  |  16 ---
 target/microblaze/cpu.h            |   8 --
 target/mips/cpu.h                  |   9 --
 target/openrisc/cpu.h              |  10 --
 target/ppc/cpu.h                   |  13 ---
 target/ppc/internal.h              |   3 +
 target/riscv/cpu.h                 |   3 -
 target/rx/cpu.h                    |   9 --
 target/s390x/cpu.h                 |   9 --
 target/sh4/cpu.h                   |  15 ---
 target/sparc/cpu.h                 |   3 -
 target/tricore/cpu.h               |  12 ---
 target/xtensa/cpu.h                |  68 ------------
 accel/tcg/cpu-exec.c               | 163 ++++++++++++-----------------
 accel/tcg/translate-all.c          |  36 +++----
 accel/tcg/user-exec.c              |   1 +
 target/alpha/cpu.c                 |  17 ++-
 target/arm/cpu.c                   |   2 +
 target/arm/helper.c                | 109 -------------------
 target/arm/tcg-stubs.c             |   4 -
 target/arm/tcg/cpu-v7m.c           |   2 +
 target/arm/tcg/helper-a64.c        |   1 +
 target/arm/tcg/hflags.c            | 117 ++++++++++++++++++++-
 target/arm/tcg/sme_helper.c        |   1 +
 target/arm/tcg/sve_helper.c        |   1 +
 target/avr/cpu.c                   |  20 +++-
 target/hexagon/cpu.c               |  20 +++-
 target/hppa/cpu.c                  |  15 +--
 target/i386/tcg/tcg-cpu.c          |  33 +++++-
 target/loongarch/cpu.c             |  19 +++-
 target/m68k/cpu.c                  |  24 ++++-
 target/microblaze/cpu.c            |  16 ++-
 target/mips/cpu.c                  |  13 +++
 target/openrisc/cpu.c              |  17 ++-
 target/ppc/cpu_init.c              |   3 +-
 target/ppc/helper_regs.c           |  19 ++--
 target/ppc/mem_helper.c            |   1 +
 target/riscv/cpu_helper.c          |  97 -----------------
 target/riscv/tcg/tcg-cpu.c         | 100 ++++++++++++++++++
 target/rx/cpu.c                    |  16 ++-
 target/s390x/cpu.c                 |  17 +--
 target/s390x/tcg/mem_helper.c      |   1 +
 target/sh4/cpu.c                   |  28 ++++-
 target/sparc/cpu.c                 |  19 ++--
 target/tricore/cpu.c               |  15 ++-
 target/xtensa/cpu.c                |  79 +++++++++++++-
 accel/tcg/meson.build              |   2 +-
 60 files changed, 719 insertions(+), 676 deletions(-)
 create mode 100644 include/accel/tcg/helper-retaddr.h
 create mode 100644 include/accel/tcg/tb-cpu-state.h

-- 
2.43.0


