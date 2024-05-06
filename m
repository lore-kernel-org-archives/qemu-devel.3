Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EBEC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xbA-00013d-5W; Mon, 06 May 2024 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xb7-00012v-N8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:37:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xb4-0001uY-23
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:37:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34d7d04808bso1343574f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999052; x=1715603852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T3mtsCNF1pFHEwBhP2UU78x8C3aCyUIhvkSF8i0A2hU=;
 b=Ildi8pW4fdfZBTCarewIsFkXljqMDlZrdi/MDdebUn/lyNWIt03jiWMHHOWfzC7wR8
 GWyz2BCyhSXExoG04XJjR561zMyvbZaoA0GVyf/m2HDIzshMKZJ620u5caNXFcF+Ka0Q
 GEusz8PtEHLlEUVaqhRHJJ6y1Q8ax3uJgba6HuGh2tGCv2JWGiZMYvMMrvedbYaJVHgi
 6/YQCS4PKU9FXr40DwodU3cx8xbxVhevWIlwpr5sLUMSPhMPVlapkSMMF34lzh2XPPRL
 zSXfAY5iBDLkIBWQK3zRORzEvtwnjviWohXqpnkzxj9W1RdYzw6ec0dIf1zTbT1W5Q4G
 citA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999052; x=1715603852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3mtsCNF1pFHEwBhP2UU78x8C3aCyUIhvkSF8i0A2hU=;
 b=hlwggzWK7+7e5zNBA9vu4IY86sypg9FpIqCeQelCL7VS4R6usrTw9kTxEXE+8r0Lcr
 BeS1oXMaGvlndMcDTx88QeyQ3XW0A1qzdDOJKNmDXD4hKcRhEU5hIl3crKVUmIjkfU+9
 lRYNLOcK5nfGLVP0gCP8MFvoxttDIAeIBackYle8wDKwiZEe18zvhN5qYa8SMHXeeeYY
 +yw/ultzT4fmTK5C3LlAR/hHsC81UHsFYRzFBBZxROzrL/J0PGZigOPMDLD3fAKkYP6t
 jzg3VN2KgJIN2+cIh5zTK86Yy3LqR2HE7Q0GDCxGoP6iJZrl2YQrp14C1LWEhA9uX/i7
 JutA==
X-Gm-Message-State: AOJu0YzF95BK3Wc+cdthgdQuSlKQA8rWPPnV6fbPQfN8ejsEsjhWkVJ3
 6GRYe+XBsOQw9jm86fcjC3PeIhsJFxHX2/LauLYfyW6l9RS+1If9SaEYVVEcJBI5TPwk2S8c8aJ
 j
X-Google-Smtp-Source: AGHT+IGOeyDrgpjDMc9XDWmXqflCm3IQRN+lC75JeC8LiMleRQJbq7gLiqmZpyCZrTYheq8DQGspyA==
X-Received: by 2002:a5d:51c3:0:b0:34d:b40e:e65d with SMTP id
 n3-20020a5d51c3000000b0034db40ee65dmr8457386wrv.42.1714999051704; 
 Mon, 06 May 2024 05:37:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 s3-20020adfe003000000b0034e8a10039esm7554712wrh.10.2024.05.06.05.37.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:37:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/28] Accelerator patches for 2024-05-06
Date: Mon,  6 May 2024 14:37:00 +0200
Message-ID: <20240506123728.65278-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:

  Merge tag 'pull-axp-20240504' of https://gitlab.com/rth7680/qemu into staging (2024-05-04 08:39:46 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-next-20240506

for you to fetch changes up to c984d1d8916df8abac71325a5a135cd851b2106a:

  MAINTAINERS: Update my email address (2024-05-06 14:33:49 +0200)

----------------------------------------------------------------
Accelerator patches

- Extract page-protection definitions to page-protection.h
- Rework in accel/tcg in preparation of extracting TCG fields from CPUState
- More uses of get_task_state() in user emulation
- Xen refactors in preparation for adding multiple map caches (Juergen & Edgar)
- MAINTAINERS updates (Aleksandar and Bin)

----------------------------------------------------------------

Aleksandar Rikalo (1):
  MAINTAINERS: Update Aleksandar Rikalo email

BALATON Zoltan (1):
  exec/cpu: Rename PAGE_BITS macro to PAGE_RWX

Bin Meng (1):
  MAINTAINERS: Update my email address

Edgar E. Iglesias (9):
  xen: mapcache: Refactor lock functions for multi-instance
  xen: mapcache: Refactor xen_map_cache for multi-instance
  xen: mapcache: Refactor xen_remap_bucket for multi-instance
  xen: mapcache: Break out xen_ram_addr_from_mapcache_single
  xen: mapcache: Refactor xen_replace_cache_entry_unlocked
  xen: mapcache: Refactor xen_invalidate_map_cache_entry_unlocked
  xen: mapcache: Break out xen_invalidate_map_cache_single()
  xen: mapcache: Break out xen_map_cache_init_single()
  softmmu: Pass RAM MemoryRegion and is_write in xen_map_cache()

Juergen Gross (2):
  softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
  xen: let xen_ram_addr_from_mapcache() return -1 in case of not found
    entry

Philippe Mathieu-Daudé (14):
  exec/cpu: Indent TARGET_PAGE_foo definitions
  exec/cpu: Remove obsolete PAGE_RESERVED definition
  exec/cpu: Remove duplicated PAGE_PASSTHROUGH definition
  exec/cpu: Extract page-protection definitions to page-protection.h
  accel/tcg: Use cpu_loop_exit_requested() in cpu_loop_exec_tb()
  accel/tcg: Access tcg_cflags with getter / setter
  accel/tcg: Move user definition of cpu_interrupt() to user-exec.c
  accel/tcg: Update CPUNegativeOffsetState::can_do_io field
    documentation
  accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to TCG plugins
  accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG
  accel/tcg: Move @plugin_mem_cbs from CPUState to
    CPUNegativeOffsetState
  user: Forward declare TaskState type definition
  user: Declare get_task_state() once in 'accel/tcg/vcpu-state.h'
  user: Use get_task_state() helper

 MAINTAINERS                             |  19 ++-
 accel/tcg/internal-common.h             |  20 ++-
 accel/tcg/vcpu-state.h                  |  18 ++
 bsd-user/bsd-mem.h                      |   1 +
 bsd-user/qemu.h                         |  11 +-
 include/exec/cpu-all.h                  |  36 ++--
 include/exec/cpu-common.h               |  38 +----
 include/exec/exec-all.h                 |   3 -
 include/exec/page-protection.h          |  41 +++++
 include/hw/core/cpu.h                   |  38 ++---
 include/qemu/plugin.h                   |   2 +-
 include/qemu/typedefs.h                 |   1 +
 include/semihosting/uaccess.h           |   1 +
 include/sysemu/xen-mapcache.h           |  11 +-
 linux-user/qemu.h                       |  10 +-
 target/arm/cpu.h                        |   1 +
 target/ppc/internal.h                   |   1 +
 target/ppc/mmu-radix64.h                |   2 +
 accel/tcg/cpu-exec.c                    |  17 +-
 accel/tcg/cputlb.c                      |   1 +
 accel/tcg/plugin-gen.c                  |   6 +-
 accel/tcg/tb-maint.c                    |   1 +
 accel/tcg/tcg-accel-ops.c               |   2 +-
 accel/tcg/translate-all.c               |   9 -
 accel/tcg/user-exec.c                   |  11 +-
 bsd-user/mmap.c                         |   7 +-
 bsd-user/signal.c                       |   1 +
 cpu-target.c                            |   1 +
 gdbstub/gdbstub.c                       |   3 +-
 gdbstub/user-target.c                   |   4 +-
 hw/core/cpu-common.c                    |   4 +
 hw/ppc/ppc440_bamboo.c                  |   1 +
 hw/ppc/sam460ex.c                       |   1 +
 hw/ppc/virtex_ml507.c                   |   1 +
 hw/xen/xen-mapcache.c                   | 212 +++++++++++++-----------
 linux-user/arm/cpu_loop.c               |   1 +
 linux-user/elfload.c                    |   3 +-
 linux-user/mmap.c                       |  11 +-
 linux-user/signal.c                     |   1 +
 linux-user/syscall.c                    |   9 +-
 plugins/core.c                          |   2 +-
 system/physmem.c                        |  82 ++++-----
 target/alpha/helper.c                   |   1 +
 target/arm/cpu.c                        |   2 +-
 target/arm/ptw.c                        |   1 +
 target/arm/tcg/m_helper.c               |   1 +
 target/arm/tcg/mte_helper.c             |   1 +
 target/arm/tcg/sve_helper.c             |   1 +
 target/avr/cpu.c                        |   2 +-
 target/avr/helper.c                     |   1 +
 target/cris/mmu.c                       |   5 +-
 target/hexagon/cpu.c                    |   2 +-
 target/hppa/cpu.c                       |   2 +-
 target/hppa/mem_helper.c                |   1 +
 target/hppa/translate.c                 |   1 +
 target/i386/cpu.c                       |   2 +-
 target/i386/helper.c                    |   2 +-
 target/i386/tcg/sysemu/excp_helper.c    |   1 +
 target/loongarch/cpu.c                  |   2 +-
 target/loongarch/tcg/tlb_helper.c       |   1 +
 target/m68k/helper.c                    |   1 +
 target/microblaze/cpu.c                 |   2 +-
 target/microblaze/helper.c              |   3 +-
 target/microblaze/mmu.c                 |   1 +
 target/mips/sysemu/physaddr.c           |   1 +
 target/mips/tcg/exception.c             |   2 +-
 target/mips/tcg/sysemu/special_helper.c |   2 +-
 target/mips/tcg/sysemu/tlb_helper.c     |   1 +
 target/openrisc/cpu.c                   |   2 +-
 target/openrisc/mmu.c                   |   1 +
 target/ppc/mmu-hash32.c                 |   1 +
 target/ppc/mmu-hash64.c                 |   1 +
 target/ppc/mmu-radix64.c                |   1 +
 target/ppc/mmu_common.c                 |   1 +
 target/ppc/mmu_helper.c                 |   1 +
 target/riscv/cpu_helper.c               |   1 +
 target/riscv/pmp.c                      |   1 +
 target/riscv/tcg/tcg-cpu.c              |   4 +-
 target/riscv/vector_helper.c            |   1 +
 target/rx/cpu.c                         |   3 +-
 target/s390x/mmu_helper.c               |   1 +
 target/s390x/tcg/mem_helper.c           |   1 +
 target/sh4/cpu.c                        |   4 +-
 target/sh4/helper.c                     |   1 +
 target/sparc/cpu.c                      |   2 +-
 target/sparc/ldst_helper.c              |   1 +
 target/sparc/mmu_helper.c               |   1 +
 target/tricore/cpu.c                    |   2 +-
 target/tricore/helper.c                 |   1 +
 target/xtensa/mmu_helper.c              |   1 +
 target/xtensa/op_helper.c               |   1 +
 91 files changed, 421 insertions(+), 300 deletions(-)
 create mode 100644 accel/tcg/vcpu-state.h
 create mode 100644 include/exec/page-protection.h

-- 
2.41.0


