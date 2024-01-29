Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63670C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb64-0005ai-7j; Mon, 29 Jan 2024 18:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5Z-0005Nv-IL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:54 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5W-0004zb-Cj
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:53 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d75ea3a9b6so27842535ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571048; x=1707175848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VYyzIUWRsc7VsyfprRoxo5eU/xZxME+ff6QkAtBu6y8=;
 b=A6OM/jJzrP8TVEWao+A2KMVPhM95iuQ6/zyjseAvcC4922YVM5jNEovo9yvwU3lpSB
 MMpHFB4ARF0yB4UREo9Zw1L1SYPNTVZ+XOBukDH4BPUpvN0Lgb93gusD+0Uf/lS658uL
 9Kpve3SfkE6tw2N6xP5GTnSpHjNZs5U0LEm4VlnUC/TKUcdWJYzD2MSz0ouJ23U7l/pz
 dyrI047aPjm+8lGKemxfq8RF6OWNsTgjCJk5F8WOVyJ7P3ea47gMLJphmk8+43bF1HZQ
 9aaWxoGUqHSByQTgDex80J8E6S8sCsvQtC4Qbi/QHVFyudFUMKpsiWAsrOjI7r4eymeZ
 LgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571048; x=1707175848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VYyzIUWRsc7VsyfprRoxo5eU/xZxME+ff6QkAtBu6y8=;
 b=EttlkE0VV+wQPwckGe3vtAoX1lTtNKKquJ65fW8Q5ZlEBa4+G4BnNkM9vgQRVlFTf+
 w2HQv87h2iTHQdpiYmoUsnd7XXiv8cBu0w/nOI10eBPqmRhDUBZhdRgMBV3MZNHJl3fA
 n4ZlSGu92WE4aOqUpJLaLWSiNzv3to2SsgJEfScZIId4RBvTW23dZY31tcsFOsyUw8z3
 hbbpOMZBMlhRxiDn0BKGZ33/savb70qilF825xESlMxZUqoNJfL1sQReZvbS1M/zuZuz
 91GcT2J0eD0hJC6Cepf1SuLEZzXy3JfUjmTltR9s+GzIb4r4xAJDIGiCcMsuYp01KrHF
 6Wxw==
X-Gm-Message-State: AOJu0YwEMlQQs1FDZuUQ//3nj1wUVp7TN4OgEDRM2vVWg2SXSzc94Bt5
 1W93xpV50qimoMue11T407jxh6YHDUyqjMznEicL5JcTEARJvQ7CnS0ibPRxi7tH1JIhQ5zjmGs
 LfGs=
X-Google-Smtp-Source: AGHT+IG3DQF4CAc/V6GMEtdK1GIZJd6tP6kRdRPvFRPhAOv2ga3UrlcsHIvgmQDJDEA+fRjwM3nHIg==
X-Received: by 2002:a17:902:a383:b0:1d8:aada:a7f5 with SMTP id
 x3-20020a170902a38300b001d8aadaa7f5mr5162184pla.11.1706571048013; 
 Mon, 29 Jan 2024 15:30:48 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:30:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 00/33] hw/core: Introduce CPUClass hook for mmu_index
Date: Tue, 30 Jan 2024 09:30:10 +1000
Message-Id: <20240129233043.34558-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While the primary use of mmu_index is for the softmmu index for
system-mode tcg, it has a secondary use in encoding cpu state for
the page table walker, and thus depending on the target may also
be used by memory_rw_debug with kvm et al.

This is why I placed the hook in CPUClass not TCGCPUOps.


r~


Richard Henderson (33):
  include/hw/core: Add mmu_index to CPUClass
  target/alpha: Split out alpha_env_mmu_index
  target/alpha: Populate CPUClass.mmu_index
  target/arm: Split out arm_env_mmu_index
  target/arm: Populate CPUClass.mmu_index
  target/avr: Populate CPUClass.mmu_index
  target/cris: Cache mem_index in DisasContext
  target/cris: Populate CPUClass.mmu_index
  target/hppa: Populate CPUClass.mmu_index
  target/i386: Populate CPUClass.mmu_index
  target/loongarch: Populate CPUClass.mmu_index
  target/loongarch: Rename MMU_IDX_*
  target/m68k: Populate CPUClass.mmu_index
  target/microblaze: Populate CPUClass.mmu_index
  target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill
  target/mips: Split out mips_env_mmu_index
  target/mips: Populate CPUClass.mmu_index
  target/nios2: Populate CPUClass.mmu_index
  target/openrisc: Populate CPUClass.mmu_index
  target/ppc: Split out ppc_env_mmu_index
  target/ppc: Populate CPUClass.mmu_index
  target/riscv: Rename riscv_cpu_mmu_index to riscv_env_mmu_index
  target/riscv: Replace cpu_mmu_index with riscv_env_mmu_index
  target/riscv: Populate CPUClass.mmu_index
  target/rx: Populate CPUClass.mmu_index
  target/s390x: Split out s390x_env_mmu_index
  target/s390x: Populate CPUClass.mmu_index
  target/sh4: Populate CPUClass.mmu_index
  target/sparc: Populate CPUClass.mmu_index
  target/tricore: Populate CPUClass.mmu_index
  target/xtensa: Populate CPUClass.mmu_index
  include/exec: Implement cpu_mmu_index generically
  include/exec: Change cpu_mmu_index argument to CPUState

 include/exec/cpu-all.h                        |  4 ++
 include/exec/cpu-common.h                     | 18 ++++++++
 include/hw/core/cpu.h                         |  3 ++
 target/alpha/cpu.h                            |  2 +-
 target/arm/cpu.h                              | 13 ------
 target/arm/internals.h                        |  5 +++
 target/avr/cpu.h                              |  7 ----
 target/cris/cpu.h                             |  4 --
 target/hexagon/cpu.h                          |  9 ----
 target/hppa/cpu.h                             | 13 ------
 target/i386/cpu.h                             |  7 ----
 target/loongarch/cpu.h                        | 18 ++------
 target/m68k/cpu.h                             |  4 --
 target/microblaze/cpu.h                       | 15 -------
 target/mips/cpu.h                             |  6 ++-
 target/nios2/cpu.h                            |  6 ---
 target/openrisc/cpu.h                         | 12 ------
 target/ppc/cpu.h                              |  2 +-
 target/riscv/cpu.h                            |  4 +-
 target/rx/cpu.h                               |  5 ---
 target/s390x/cpu.h                            |  2 +-
 target/sh4/cpu.h                              | 10 -----
 target/sparc/cpu.h                            | 30 +------------
 target/tricore/cpu.h                          |  5 ---
 target/xtensa/cpu.h                           |  5 ---
 accel/tcg/cputlb.c                            | 22 ++++++----
 semihosting/uaccess.c                         |  2 +-
 target/alpha/cpu.c                            |  6 +++
 target/alpha/translate.c                      |  2 +-
 target/arm/cpu.c                              |  6 +++
 target/arm/helper.c                           |  2 +-
 target/arm/tcg/helper-a64.c                   |  4 +-
 target/arm/tcg/mte_helper.c                   | 18 ++++----
 target/arm/tcg/sve_helper.c                   |  8 ++--
 target/arm/tcg/tlb_helper.c                   |  2 +-
 target/avr/cpu.c                              |  6 +++
 target/cris/cpu.c                             |  6 +++
 target/cris/translate.c                       | 14 +++----
 target/hppa/cpu.c                             | 12 ++++++
 target/hppa/mem_helper.c                      |  2 +-
 target/hppa/op_helper.c                       |  8 ++--
 target/i386/cpu.c                             | 10 +++++
 target/i386/tcg/translate.c                   |  2 +-
 target/loongarch/cpu.c                        | 11 +++++
 target/loongarch/tcg/tlb_helper.c             |  8 ++--
 target/loongarch/tcg/translate.c              |  2 +-
 target/m68k/cpu.c                             |  6 +++
 target/m68k/op_helper.c                       |  2 +-
 target/microblaze/cpu.c                       | 18 +++++++-
 target/microblaze/helper.c                    |  3 +-
 target/microblaze/mmu.c                       |  2 +-
 target/microblaze/translate.c                 |  2 +-
 target/mips/cpu.c                             |  6 +++
 target/mips/sysemu/physaddr.c                 |  2 +-
 target/mips/tcg/msa_helper.c                  | 10 ++---
 target/mips/tcg/sysemu/cp0_helper.c           |  2 +-
 target/mips/tcg/sysemu/special_helper.c       |  2 +-
 target/mips/tcg/sysemu/tlb_helper.c           | 34 +++++++--------
 target/nios2/cpu.c                            |  7 ++++
 target/nios2/translate.c                      |  2 +-
 target/openrisc/cpu.c                         | 13 ++++++
 target/openrisc/translate.c                   |  2 +-
 target/ppc/cpu_init.c                         |  8 +++-
 target/ppc/mem_helper.c                       | 10 ++---
 target/ppc/mmu_common.c                       |  4 +-
 target/riscv/cpu.c                            |  6 +++
 target/riscv/cpu_helper.c                     |  6 +--
 target/riscv/op_helper.c                      |  4 +-
 target/riscv/vector_helper.c                  |  9 ++--
 target/rx/cpu.c                               |  6 +++
 target/s390x/cpu.c                            |  6 +++
 target/s390x/tcg/mem_helper.c                 | 34 ++++++++-------
 target/sh4/cpu.c                              | 16 +++++++
 target/sparc/cpu.c                            | 29 +++++++++++++
 target/sparc/ldst_helper.c                    |  2 +-
 target/sparc/mmu_helper.c                     |  2 +-
 target/tricore/cpu.c                          |  6 +++
 target/tricore/helper.c                       |  2 +-
 target/tricore/translate.c                    |  2 +-
 target/xtensa/cpu.c                           |  6 +++
 target/xtensa/mmu_helper.c                    |  2 +-
 accel/tcg/ldst_common.c.inc                   | 42 ++++++++++++-------
 target/cris/translate_v10.c.inc               |  6 +--
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 84 files changed, 377 insertions(+), 308 deletions(-)

-- 
2.34.1


