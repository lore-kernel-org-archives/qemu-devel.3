Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81ADCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnG-0007pz-GP; Wed, 24 Sep 2025 15:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ulu-0006v2-4J
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:26 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujo-0007mI-Ag
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-271067d66fbso1374755ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740467; x=1759345267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq7Mc7qQG5LC5Vy/bnzzuC6iXTTMlY2v77C6aXxf2YM=;
 b=t+LICImu4T1yX1DRel42qBeMGZPpKZU0EQxppl7AMTxUCZTZg3HTTnXQJvwKI+ebzg
 2TbNnLZN1/VMARvarHZoDVVvSnJ15ilNPzqgFHDcgNqmMEyFP/ymTzO8HJVnxXL0nDCz
 TFOTyd/WzhV6ZDo26GRi7eqDmLvT9jz3/WTsGgwByBEiJeQAKoy+xrUWKCTOCQtBojnY
 POmxnlbnWHUfG2zp4QTu36yyQ+U7Aq4Xc0z45gA1Qxz7XHFTav9ux7EX2qjRqOGp2Q3a
 2R2KES+tsnDRFxmvl1BLRVR//zRWPbW9uYtz6nfJtwavJQtO7lroaentGxnEYssJgkXt
 9rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740467; x=1759345267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq7Mc7qQG5LC5Vy/bnzzuC6iXTTMlY2v77C6aXxf2YM=;
 b=Kus5GodEQiHZNd3sDZcpefbiqseC8UAjqjA2cvRasbNDWRU1y0bS3eWR6R/oqCNQi0
 HmZKsuafEfMpJgyUu7DygAVQD4Hq4lr4a79dPw6TdxtbFsScH4Yd9WBQGIKJUL8AIWbL
 YpPS3fqlh1LAAFWhQPZq4ZfrNktqhWYQ1kOYeqUvCcYrT6cYi+lj81WwzNn2N520kFnk
 NjwlBo/qWDZjpjPtBPgmKPHi5s84LDRGMl+NKkjuxg9btOkX6D6KzXeISAm4MAytrF1k
 RGH2euPeIQsqjF3e+/ONMsVY8tN/vrB8BWi7ndQCVZwUGoZj2pgc3Fkl7kUxbgDUd6XL
 gw4A==
X-Gm-Message-State: AOJu0YzGUqpv+AWzglRkBCs8yMytF3VJetjqSUz9FDGiNNP4bWXEC0FO
 m330jy3wCNHZiRH4nh49g/SuWXl4Rgy4d6f+yfuizckK6hBMcy2Q15+kJ8af1EExRbnFQTYvdPL
 CJRJV
X-Gm-Gg: ASbGncsnTFfP+o9SzAR4FhB7WjXShyyFEoaRdOW9op18GSzD18ykTAWlgG6xolW3KXf
 2S0AzrgdCMOxqAGD8eIGSgEKQT/9ZoiprI8hD/uf2Hkx8PYLtMYdeEHq7UZ7SpweOXWW8Zu67q3
 unyX1h/zv26/9K3FyCtlK7TliHx1WQyCFKPI1vAgdy2hlBEJO6TqkyDsLwgCEAvE1f1dDF1KX54
 Cykl3i08yp/mbG7vii3MfljQNXI9SkZV8HDHdHDkE5PQ+Z7SgjHFASvfmJgeaSZDADU6h8bkMq6
 zdJhgSC1Qa+l3zqnxbvLoKT/nefkGodzm3cluKKaflbeEUDIXtrKG9l8UNAfhqeH50C/bjTiacM
 tVOZy63EP3MRspE+WoqhPPEerCf7a
X-Google-Smtp-Source: AGHT+IHG2CsFw+zN2Mn99CBvZFRd4i/PSx9ZfgidYYJxCHKnLqzw4nmwHaUVoM1lDuP5GwEurU94Gw==
X-Received: by 2002:a17:902:c950:b0:279:daa1:6780 with SMTP id
 d9443c01a7336-27ed4a86e0emr8282685ad.52.1758740467119; 
 Wed, 24 Sep 2025 12:01:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] misc patch queue (tcg, linux-user, sparc)
Date: Wed, 24 Sep 2025 12:00:33 -0700
Message-ID: <20250924190106.7089-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The following changes since commit ab8008b231e758e03c87c1c483c03afdd9c02e19:

  Merge tag 'pull-9p-20250918' of https://github.com/cschoenebeck/qemu into staging (2025-09-19 12:21:35 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20250924

for you to fetch changes up to f6f7fdd68e6fbfafae828e504de544b5659bc4bd:

  accel/tcg: Remove cpu_loop_exit_restore() stub (2025-09-24 10:29:43 -0700)

----------------------------------------------------------------
hw/pci-host/{dino,astro}: Don't call pci_register_root_bus() in init
target/sparc: Loosen various decode for v7
linux-user: Add syscall dispatch support
tcg/optimize: Fix folding of vector bitsel
include/hw/core/cpu: Introduce MMUIdxMap
include/hw/core/cpu: Introduce cpu_tlb_fast
include/hw/core/cpu: Invert the indexing into CPUTLBDescFast
accel/tcg: Remove dead mmap_unlock() call in invalidate_phys_page_range
accel/tcg: Remove cpu_loop_exit_restore() stub
accel/tcg: Properly unlink a TB linked to itself
accel/tcg: Introduce and use tb_flush__exclusive_or_serial

----------------------------------------------------------------
Arusekk (1):
      linux-user: Add syscall dispatch support

Peter Maydell (2):
      hw/pci-host/dino: Don't call pci_register_root_bus() in init
      hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init

Philippe Mathieu-Daudé (2):
      accel/tcg: Remove dead mmap_unlock() call in invalidate_phys_page_range
      accel/tcg: Remove cpu_loop_exit_restore() stub

Richard Henderson (26):
      linux-user: Create vdso_sigreturn_region_{start,end}
      linux-user: Populate sigreturn_region_{start,end} in all vdso.S
      linux-user: Populate vdso_sigreturn_region_{start,end} from sigtramp page
      target/sparc: Allow TRANS macro with no extra arguments
      target/sparc: Loosen decode of STBAR for v8
      target/sparc: Loosen decode of RDY for v7
      target/sparc: Loosen decode of RDPSR for v7
      target/sparc: Loosen decode of RDWIM for v7
      target/sparc: Loosen decode of RDTBR for v7
      target/sparc: Relax decode of rs2_or_imm for v7
      include/hw/core/cpu: Introduce MMUIdxMap
      include/hw/core/cpu: Introduce cpu_tlb_fast
      include/hw/core/cpu: Invert the indexing into CPUTLBDescFast
      target/hppa: Adjust mmu indexes to begin with 0
      accel/tcg: Properly unlink a TB linked to itself
      tests/tcg/multiarch: Add tb-link test
      gdbstub: Remove tb_flush uses
      target/alpha: Simplify call_pal implementation
      target/riscv: Record misa_ext in TCGTBCPUState.cs_base
      hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
      accel/tcg: Split out tb_flush__exclusive_or_serial
      accel/tcg: Move post-load tb_flush to vm_change_state hook
      plugins: Use tb_flush__exclusive_or_serial
      linux-user: Split out begin_parallel_context
      accel/tcg: Create queue_tb_flush from tb_flush
      accel/tcg: Improve buffer overflow in tb_gen_code

WANG Rui (1):
      tcg/optimize: Fix folding of vector bitsel

 include/exec/cpu-common.h           |   2 +-
 include/exec/cputlb.h               |  32 ++++++-------
 include/exec/tb-flush.h             |  30 ++++++++----
 include/hw/core/cpu.h               |  22 +++++++--
 linux-user/loader.h                 |   2 +
 linux-user/qemu.h                   |   5 ++
 linux-user/signal-common.h          |   7 +++
 linux-user/syscall_defs.h           |   6 +++
 linux-user/user-internals.h         |  16 +++++++
 target/alpha/helper.h               |   1 -
 target/hppa/cpu.h                   |  28 +++++------
 accel/stubs/tcg-stub.c              |   5 --
 accel/tcg/cputlb.c                  |  46 +++++++++---------
 accel/tcg/plugin-gen.c              |   4 +-
 accel/tcg/tb-maint.c                |  59 ++++++++++++++---------
 accel/tcg/tcg-all.c                 |  21 +++++++++
 accel/tcg/translate-all.c           |   6 ++-
 gdbstub/system.c                    |   5 --
 gdbstub/user.c                      |   3 --
 hw/core/cpu-system.c                |   9 ----
 hw/pci-host/astro.c                 |  27 +++++------
 hw/pci-host/dino.c                  |  90 ++++++++++++++++--------------------
 hw/ppc/spapr_hcall.c                |   4 +-
 linux-user/alpha/cpu_loop.c         |   5 --
 linux-user/elfload.c                |   7 +++
 linux-user/gen-vdso.c               |   6 +++
 linux-user/main.c                   |   2 +
 linux-user/mmap.c                   |  13 +-----
 linux-user/signal.c                 |   2 +
 linux-user/syscall.c                |  83 ++++++++++++++++++++++++++++++---
 plugins/core.c                      |   6 +--
 plugins/loader.c                    |   3 +-
 target/alpha/sys_helper.c           |   6 ---
 target/alpha/translate.c            |  21 +++------
 target/riscv/csr.c                  |   3 --
 target/riscv/tcg/tcg-cpu.c          |   3 +-
 target/sparc/translate.c            |  77 +++++++++++++++++-------------
 tcg/optimize.c                      |   3 +-
 tcg/tcg.c                           |   3 +-
 tests/tcg/multiarch/tb-link.c       |  67 +++++++++++++++++++++++++++
 linux-user/aarch64/vdso-be.so       | Bin 3224 -> 3320 bytes
 linux-user/aarch64/vdso-le.so       | Bin 3224 -> 3320 bytes
 linux-user/aarch64/vdso.S           |   2 +
 linux-user/arm/vdso-be32.so         | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso-be8.so          | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso-le.so           | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso.S               |   2 +
 linux-user/gen-vdso-elfn.c.inc      |   7 ++-
 linux-user/hppa/vdso.S              |   2 +
 linux-user/hppa/vdso.so             | Bin 2104 -> 2224 bytes
 linux-user/i386/vdso.S              |   2 +
 linux-user/i386/vdso.so             | Bin 2672 -> 2792 bytes
 linux-user/loongarch64/vdso.S       |   2 +
 linux-user/loongarch64/vdso.so      | Bin 3560 -> 3712 bytes
 linux-user/ppc/vdso-32.so           | Bin 3020 -> 3140 bytes
 linux-user/ppc/vdso-64.so           | Bin 3896 -> 4048 bytes
 linux-user/ppc/vdso-64le.so         | Bin 3896 -> 4048 bytes
 linux-user/ppc/vdso.S               |   2 +
 linux-user/riscv/vdso-32.so         | Bin 2980 -> 3124 bytes
 linux-user/riscv/vdso-64.so         | Bin 3944 -> 4104 bytes
 linux-user/riscv/vdso.S             |   2 +
 linux-user/s390x/vdso.S             |   2 +
 linux-user/s390x/vdso.so            | Bin 3464 -> 3616 bytes
 target/sparc/insns.decode           |  83 +++++++++++++++++++++------------
 tcg/aarch64/tcg-target.c.inc        |   2 +-
 tcg/arm/tcg-target.c.inc            |   2 +-
 tests/tcg/multiarch/Makefile.target |   2 +
 67 files changed, 549 insertions(+), 303 deletions(-)
 create mode 100644 tests/tcg/multiarch/tb-link.c

