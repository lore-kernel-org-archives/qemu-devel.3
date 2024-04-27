Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55143C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kQV-0002fT-Vm; Sat, 27 Apr 2024 11:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQU-0002eY-4Q
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQS-0005H5-7c
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34b64b7728cso2528460f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233438; x=1714838238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kPz5ZmzDAeE0PN5oHM69CBd011IphRdDefz84fnf7yU=;
 b=Nzlw0CnXuf57HhLMKXh3q9nrXcf3iGlV6ku/W4QYs/475D0/MxVm1ELuyqvJFtogti
 7IuhJbwOZY/Lz0bweXrUpxbz98wXUP8MMc19y4R32HPYe+9qPKccIyx30M0Y7PHiiARn
 HEpCDy5ddZIpmFMIu621zShmeL54nBF3R3JS+geznIxE45kyTtBnCpEYRtP/sno+1IzE
 UjFOkjh2wl/DQocWHtALmdcQMbncHlqxRDZJBpljV/Miu3re4y/B1VMb3nLPh1SZI3hJ
 u3dtCf2QIiHD4uh2uHJO9FqMKahdhraw/1qz8mLiT6i2lfnAko+1e5+jJW33feGXmVmG
 ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233438; x=1714838238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kPz5ZmzDAeE0PN5oHM69CBd011IphRdDefz84fnf7yU=;
 b=Z1knSQwDyUURFXPXjTuAbhhaQRcI+spcHmYSsGlLMSim/nWg/jbKxJFEefGQ6gGLpO
 f+QdErcVqeBr5Aw3Wffov4WZWira7debxk1MMCYbbewQRFhKV+4q6xLrDW7HZXLUPxoM
 rSikQ5PbX9RN+n7rf7knk79VlIqTCa/xr87pWEfSswD3qlDaM+M86LJq52wZtklmPltR
 onLsBwwEYlSr0xioxVxmQEC6bItFTV1ykTdCyqw8qdJsk+B/EjFhiXuI0tJuSbtBsM8X
 VtMdxfsJdi8TlZcoAdHdpgW5jBcekUCiVAhdJn5XNL89CUXB/ux+MxA6wLRR/VEMG2Jl
 pRqw==
X-Gm-Message-State: AOJu0Ywe+oZ7fr0kfMym6Jqk1lr1qKpfQbeZzB8unPJbFvIaK2hBKjqU
 Bw+vZhJy0opi1UzPBPrEKen8jBSO/U6ATTOkf7gBsDTBJDFzYV63Qv+qGNpEEnRHdHV78STBr7K
 fDFI=
X-Google-Smtp-Source: AGHT+IECCFpG1N52Vv+difLT4eR/Eq9cHLXq1YjhaotyKYHohxDBcoL9odzwLnOgLlZlgpVZqeoKdg==
X-Received: by 2002:adf:e305:0:b0:34b:19fd:4650 with SMTP id
 b5-20020adfe305000000b0034b19fd4650mr3969322wrj.60.1714233437481; 
 Sat, 27 Apr 2024 08:57:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 r30-20020adfb1de000000b00343e392829dsm25423797wra.97.2024.04.27.08.57.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/14] exec: Rework around CPUState user fields
Date: Sat, 27 Apr 2024 17:57:00 +0200
Message-ID: <20240427155714.53669-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi,

First batch of patches (I expect them to be non
controversial) related to extracting user specific
fields from CPUState.

Regards,

Phil.

Philippe Mathieu-Daudé (14):
  target/i386: Simplify get_memio_eip()
  plugins: Update stale comment
  plugins/api: Only include 'exec/ram_addr.h' with system emulation
  exec: Include missing license in 'exec/cpu-common.h'
  exec/cpu: Indent TARGET_PAGE_foo definitions
  exec/cpu: Remove obsolete PAGE_RESERVED definition
  exec/cpu: Remove duplicated PAGE_PASSTHROUGH definition
  exec/cpu: Extract page-protection definitions to page-prot-common.h
  RFC exec/cpu: Restrict user-specific page definitions
  exec/user: Restrict 'syscall-trace.h' to user emulation
  accel/tcg: Use cpu_loop_exit_requested() in cpu_loop_exec_tb()
  accel/tcg: Remove pointless initialization of cflags_next_tb
  accel/tcg: Reset TCG specific fields in tcg_cpu_reset_hold()
  accel/tcg: Access tcg_cflags with getter / setter

 accel/tcg/internal-common.h             |  3 +-
 bsd-user/bsd-mem.h                      |  1 +
 bsd-user/qemu.h                         |  1 +
 include/exec/cpu-all.h                  | 36 +++++++-----------
 include/exec/cpu-common.h               | 47 ++++++++----------------
 include/exec/exec-all.h                 |  3 --
 include/exec/page-prot-common.h         | 49 +++++++++++++++++++++++++
 include/semihosting/uaccess.h           |  1 +
 include/user/syscall-trace.h            |  4 ++
 target/arm/cpu.h                        |  1 +
 target/ppc/internal.h                   |  1 +
 target/ppc/mmu-radix64.h                |  2 +
 accel/tcg/cpu-exec.c                    | 17 +++++++--
 accel/tcg/cputlb.c                      |  1 +
 accel/tcg/tb-maint.c                    |  1 +
 accel/tcg/tcg-accel-ops.c               |  5 ++-
 accel/tcg/user-exec.c                   |  1 +
 bsd-user/mmap.c                         |  1 +
 bsd-user/signal.c                       |  1 +
 cpu-target.c                            |  1 +
 hw/core/cpu-common.c                    |  3 --
 hw/ppc/ppc440_bamboo.c                  |  1 +
 hw/ppc/sam460ex.c                       |  1 +
 hw/ppc/virtex_ml507.c                   |  1 +
 linux-user/arm/cpu_loop.c               |  1 +
 linux-user/elfload.c                    |  1 +
 linux-user/mmap.c                       |  9 +++--
 linux-user/signal.c                     |  1 +
 linux-user/syscall.c                    |  5 ++-
 plugins/api.c                           |  2 +-
 plugins/core.c                          |  2 +-
 system/physmem.c                        |  1 +
 target/alpha/helper.c                   |  1 +
 target/arm/cpu.c                        |  2 +-
 target/arm/ptw.c                        |  1 +
 target/arm/tcg/m_helper.c               |  1 +
 target/arm/tcg/mte_helper.c             |  1 +
 target/arm/tcg/sve_helper.c             |  1 +
 target/avr/cpu.c                        |  2 +-
 target/avr/helper.c                     |  1 +
 target/cris/mmu.c                       |  1 +
 target/hexagon/cpu.c                    |  2 +-
 target/hppa/cpu.c                       |  2 +-
 target/hppa/mem_helper.c                |  1 +
 target/hppa/translate.c                 |  1 +
 target/i386/cpu.c                       |  2 +-
 target/i386/helper.c                    |  8 ++--
 target/i386/tcg/sysemu/excp_helper.c    |  1 +
 target/loongarch/cpu.c                  |  2 +-
 target/loongarch/tcg/tlb_helper.c       |  1 +
 target/m68k/helper.c                    |  1 +
 target/microblaze/cpu.c                 |  2 +-
 target/microblaze/helper.c              |  1 +
 target/microblaze/mmu.c                 |  1 +
 target/mips/sysemu/physaddr.c           |  1 +
 target/mips/tcg/exception.c             |  2 +-
 target/mips/tcg/sysemu/special_helper.c |  2 +-
 target/mips/tcg/sysemu/tlb_helper.c     |  1 +
 target/openrisc/cpu.c                   |  2 +-
 target/openrisc/mmu.c                   |  1 +
 target/ppc/mmu-hash32.c                 |  1 +
 target/ppc/mmu-hash64.c                 |  1 +
 target/ppc/mmu-radix64.c                |  1 +
 target/ppc/mmu_common.c                 |  1 +
 target/ppc/mmu_helper.c                 |  1 +
 target/riscv/cpu_helper.c               |  1 +
 target/riscv/pmp.c                      |  1 +
 target/riscv/tcg/tcg-cpu.c              |  4 +-
 target/riscv/vector_helper.c            |  1 +
 target/rx/cpu.c                         |  3 +-
 target/s390x/mmu_helper.c               |  1 +
 target/s390x/tcg/mem_helper.c           |  1 +
 target/sh4/cpu.c                        |  4 +-
 target/sh4/helper.c                     |  1 +
 target/sparc/cpu.c                      |  2 +-
 target/sparc/ldst_helper.c              |  1 +
 target/sparc/mmu_helper.c               |  1 +
 target/tricore/cpu.c                    |  2 +-
 target/tricore/helper.c                 |  1 +
 target/xtensa/mmu_helper.c              |  1 +
 target/xtensa/op_helper.c               |  1 +
 81 files changed, 185 insertions(+), 96 deletions(-)
 create mode 100644 include/exec/page-prot-common.h

-- 
2.41.0


