Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8763C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoF-00057U-R2; Mon, 28 Apr 2025 16:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoE-00057A-Fw
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoC-0000bb-Ab
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso7135945b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871030; x=1746475830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZstQx0xoB7jIoONMjyreiTAoGKvxvGwP2tm8dTefAWo=;
 b=Gsks/igplDbtvbN3QVvAxJ8QahXGed5eP0blDsDxHYqLOu1umqA16BLDeNnjRKYG+r
 GJ5c7r2+kdYo5PFAsTyJVSydoyJMzU7OngugOxU3xSGsJPh1ytuAyk+aiX8B2LO2aFfB
 oZYnxkNlh0pdUlbGqwIZCuWe9tjNmroEys6sPovBaEk0SUXg2sA0LopIIZ5eL++fvy6r
 GNqGWCmRw8FbC+e9mR4BxW7yNaLxbpdUOFoAUpItHCEBiaGUrStgMC9LhjQvpsYgLb0X
 HlmkjVadEoiiqzRse3DiSchF65eO1tDwZ17rCRvuOpgZtmSLl8glSJMVAIJ8OQrKgJKX
 /cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871030; x=1746475830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZstQx0xoB7jIoONMjyreiTAoGKvxvGwP2tm8dTefAWo=;
 b=P9p+dzhPk5xuTkR38qjDtCj7Pd97DxpigzEwqpha8q6NpBdSeQuWUe3STanI6/T+vu
 rIdE7T2N1nzSk4ZHIwF4DUadL2qFUM0TaGk0KTEUJC9CsFFhD8jalk0GZFiC128EmkOU
 vCA3IFkvchzpmR6y0CfJCBNn7hSYYae4C79x/rg/+x10exe1QkU/VvHVWEq0ylDVQur2
 CTiV2mhO0pO8BoWidUL9intkwxlVU6ncO1FCW1dp/Rf5pksoK9+12p+hAMjMXopf54GM
 1GudRSrPyCP5F0MpFD/pjkcyD4Nt3yCwApThw+6w0ZPKAN7d+Bn4n+SikNxRmBrFY1oL
 6w3w==
X-Gm-Message-State: AOJu0YyAbMGyaSYGDGydbiQNObv08yT1pBrcfxO1VlMyW+ApTDh5czsS
 5IbiS82XREU3qY4Lnp6lz4odsqrQnJIHzWwmpbohy2ix9akDB7g+B4BOcp7wymg33c00kRaae5v
 3
X-Gm-Gg: ASbGncuJDoBIM5zvPcCOumfhlZAHBiKn+neQUbgXJT/J8t1v2NZiq4hb7he4Zm8tX2A
 7MQ4Tjc8WRAbq4BPeemoFe0MoWilkdFewYT5d3aD0MS4n+99N3xXJEjjkQT43UX9dhm8Dnwrx+E
 xZyx36euHZhNL/FHwcFslAGcgZ9PlhNPdAQgfAHcYsNS2+gQ9swxY52qEAIwhpnNPgfyU9wyRZW
 MWqWUO+vMmBuyI/0h1wTbLk/39Q2FM8EYt9GzR+BB9IcgWMK02nEAOmA1c+o8YP3SiX5zN3jVp9
 MdRuKNIgz8W/UHe3a+i8NCOvm3MpXLVRaKxl9GGCAw3pPI21Le+wQlNF+x6N+fUynFRYxRs0saE
 =
X-Google-Smtp-Source: AGHT+IEYYJIbVfKVYbgNcefR5Vq8buIxa1A+Kj+iCTakVB4sKMNUUIiG/W3EmxdBCyLUISWjFJC6jQ==
X-Received: by 2002:aa7:888c:0:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-740292a2faamr527096b3a.14.1745871030072; 
 Mon, 28 Apr 2025 13:10:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 00/10] accel/tcg: Compile cpu-exec.c twice
Date: Mon, 28 Apr 2025 13:10:18 -0700
Message-ID: <20250428201028.1699157-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

More work toward single-binary.

r~

Richard Henderson (10):
  accel/tcg: Generalize fake_user_interrupt test
  accel/tcg: Unconditionally use CPU_DUMP_CCOP in log_cpu_exec
  accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
  target/i386: Split out x86_cpu_exec_reset
  accel/tcg: Hoist cpu_get_tb_cpu_state decl to accl/tcg/cpu-ops.h
  target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
  accel/tcg: Return TCGTBCPUState from cpu_get_tb_cpu_state
  accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
  accel/tcg: Split out accel/tcg/helper-retaddr.h
  accel/tcg: Compile cpu-exec.c twice

 accel/tcg/internal-common.h        |   6 ++
 include/accel/tcg/cpu-ldst.h       |  34 ----------
 include/accel/tcg/cpu-ops.h        |  14 ++++
 include/accel/tcg/helper-retaddr.h |  43 ++++++++++++
 include/qemu/typedefs.h            |   1 +
 target/alpha/cpu.h                 |  11 ---
 target/arm/cpu.h                   |   3 -
 target/arm/internals.h             |   1 +
 target/avr/cpu.h                   |  18 -----
 target/hexagon/cpu.h               |  15 -----
 target/hppa/cpu.h                  |   3 -
 target/i386/cpu.h                  |  14 ----
 target/loongarch/cpu.h             |  12 ----
 target/m68k/cpu.h                  |  16 -----
 target/microblaze/cpu.h            |   8 ---
 target/mips/cpu.h                  |   9 ---
 target/openrisc/cpu.h              |  10 ---
 target/ppc/cpu.h                   |  13 ----
 target/ppc/internal.h              |   2 +
 target/riscv/cpu.h                 |   3 -
 target/rx/cpu.h                    |   9 ---
 target/s390x/cpu.h                 |   9 ---
 target/sh4/cpu.h                   |  15 -----
 target/sparc/cpu.h                 |   3 -
 target/tricore/cpu.h               |  12 ----
 target/xtensa/cpu.h                |  68 -------------------
 accel/tcg/cpu-exec.c               | 103 +++++++++++------------------
 accel/tcg/translate-all.c          |   8 +--
 accel/tcg/user-exec.c              |   1 +
 target/alpha/cpu.c                 |  17 ++++-
 target/arm/cpu.c                   |   2 +
 target/arm/helper.c                |  17 +++--
 target/arm/tcg/cpu-v7m.c           |   2 +
 target/arm/tcg/helper-a64.c        |   1 +
 target/arm/tcg/sme_helper.c        |   1 +
 target/arm/tcg/sve_helper.c        |   1 +
 target/avr/cpu.c                   |  20 +++++-
 target/hexagon/cpu.c               |  20 +++++-
 target/hppa/cpu.c                  |  15 +++--
 target/i386/tcg/tcg-cpu.c          |  33 ++++++++-
 target/loongarch/cpu.c             |  19 +++++-
 target/m68k/cpu.c                  |  23 ++++++-
 target/microblaze/cpu.c            |  16 ++++-
 target/mips/cpu.c                  |  13 ++++
 target/openrisc/cpu.c              |  17 ++++-
 target/ppc/cpu_init.c              |   3 +-
 target/ppc/helper_regs.c           |  19 +++---
 target/ppc/mem_helper.c            |   1 +
 target/riscv/cpu_helper.c          |  97 ---------------------------
 target/riscv/tcg/tcg-cpu.c         | 100 ++++++++++++++++++++++++++++
 target/rx/cpu.c                    |  16 ++++-
 target/s390x/cpu.c                 |  17 +++--
 target/s390x/tcg/mem_helper.c      |   1 +
 target/sh4/cpu.c                   |  28 +++++++-
 target/sparc/cpu.c                 |  19 ++++--
 target/tricore/cpu.c               |  15 ++++-
 target/xtensa/cpu.c                |  75 ++++++++++++++++++++-
 accel/tcg/meson.build              |   2 +-
 58 files changed, 561 insertions(+), 513 deletions(-)
 create mode 100644 include/accel/tcg/helper-retaddr.h

-- 
2.43.0


