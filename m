Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C602AC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1COs-0002vp-Mz; Sun, 28 Apr 2024 17:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COo-0002vT-Rw
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:30 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COm-00012c-B3
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:30 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e78970853so8244396a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340959; x=1714945759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DOmz00QdEF4UthPf0Q5PrUg597J7odFQxzjvleV3NEc=;
 b=zQh4jnsnTHSiEaLrD1BWusoDho7fju5YG6bawq2/E3vp1sbwO08ymNtV2TASqznLcj
 nCd2ROB2IsRq/Baj3a0QjE7mNhvLkexsG/psmersD88NES6SgKdma8XP9VWJitIkjppr
 wjH+W7D9+7WEw+21ojE0qJZ/h675/rdZywt9bE3+l4XWUAZCAx4/8mk1C9y7zD8fApNp
 Ip9XxtSNi+OBnbCu7gmCoMvdnSP6TSXALvHFWtaU1CROpvRFmGIdVhgcnVS17sL2UdUe
 0FwJji+hZCVUToMhwxAH3O5/9BL71dbVpUicVD6aupor6XihPIdl84B2Q4vP8qfQxyyS
 apEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340959; x=1714945759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOmz00QdEF4UthPf0Q5PrUg597J7odFQxzjvleV3NEc=;
 b=BH2x6niJ6Uu6eazYWgy7TVdkisyob4Ny32SmzurjuDziPfE+YBWt2B7j/uF7B7DNBu
 y9Md5lkT5KRFI58RZNZKFTEJEi6nl+5qIXo+Re8TugmrPexKmB/OYSCvuXsIP2YzJF+0
 V2MBqo2+wxnYbM6wbcpd4H4rRbkqQMQ0uo4XlRUsDiWyM1lrkhpbZluAVcjSdKZijh2/
 1gQV2tcKR4LghatCh5wTZ45um4Bcjv1JvBTq2lsfqPA7NEoyQHeYkEiBHO9tIIzJWwsd
 UOFifpnS3gUHK7lRyXdUkpGaRnGMWSdPPwqsjrWBaxgFrFM9ogS2nErJu/P0A9tXpJL/
 qQAA==
X-Gm-Message-State: AOJu0Yypfcdo/t92e8yNo6T9kE1bXYbjnaF2Wjj2XgD+g8KyDDkNVKDb
 zhLpDzvZhFKsA6igexxAm28nwE+vNIs4F67s7VOSPtjsc+AAPsYA0Z2I3/ACrKrlO5U9vM9j6x8
 0
X-Google-Smtp-Source: AGHT+IFyBKwxRjZ+CgwxpVNUfP9JtVZt8afHtDbqFmUFT254aHFWkKNHSW+ekbjUkYFA+azCVQ/EDQ==
X-Received: by 2002:a17:907:7f27:b0:a52:71d6:d605 with SMTP id
 qf39-20020a1709077f2700b00a5271d6d605mr9763363ejc.23.1714340959026; 
 Sun, 28 Apr 2024 14:49:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 jw9-20020a170906e94900b00a58f4eff37asm1393520ejb.200.2024.04.28.14.49.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/12] exec: Rework around CPUState user fields
Date: Sun, 28 Apr 2024 23:49:03 +0200
Message-ID: <20240428214915.10339-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Missing review: 8 & 9 (new)

v2:
- Addressed Richard review comments
- Renamed page-prot-common.h -> page-protection.h
- Removed wrong/unuseful patches
- New patch moving cpu_loop_exit_requested()

Hi,

First batch of patches (I expect them to be non
controversial) related to extracting user specific
fields from CPUState.

Regards,

Phil.

Philippe Mathieu-Daudé (12):
  plugins: Update stale comment
  plugins/api: Only include 'exec/ram_addr.h' with system emulation
  exec: Include missing license in 'exec/cpu-common.h'
  exec/cpu: Indent TARGET_PAGE_foo definitions
  exec/cpu: Remove obsolete PAGE_RESERVED definition
  exec/cpu: Remove duplicated PAGE_PASSTHROUGH definition
  exec/cpu: Extract page-protection definitions to page-protection.h
  accel/tcg: Use cpu_loop_exit_requested() in cpu_loop_exec_tb()
  accel/tcg: Restrict cpu_loop_exit_requested() to TCG
  accel/tcg: Remove pointless initialization of cflags_next_tb
  accel/tcg: Reset TCG specific fields in tcg_cpu_reset_hold()
  accel/tcg: Access tcg_cflags with getter / setter

 MAINTAINERS                             |  1 +
 accel/tcg/internal-common.h             |  3 +-
 bsd-user/bsd-mem.h                      |  1 +
 bsd-user/qemu.h                         |  1 +
 include/exec/cpu-all.h                  | 36 ++++++++-----------
 include/exec/cpu-common.h               | 47 ++++++++-----------------
 include/exec/exec-all.h                 | 20 -----------
 include/exec/page-protection.h          | 41 +++++++++++++++++++++
 include/exec/translate-all.h            | 20 +++++++++++
 include/semihosting/uaccess.h           |  1 +
 target/arm/cpu.h                        |  1 +
 target/ppc/internal.h                   |  1 +
 target/ppc/mmu-radix64.h                |  2 ++
 accel/tcg/cpu-exec.c                    | 17 ++++++---
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
 linux-user/mmap.c                       |  9 ++---
 linux-user/signal.c                     |  1 +
 linux-user/syscall.c                    |  5 +--
 plugins/api.c                           |  2 +-
 plugins/core.c                          |  2 +-
 system/physmem.c                        |  1 +
 target/alpha/helper.c                   |  1 +
 target/arm/cpu.c                        |  2 +-
 target/arm/ptw.c                        |  1 +
 target/arm/tcg/helper-a64.c             |  1 +
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
 target/i386/helper.c                    |  2 +-
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
 target/riscv/tcg/tcg-cpu.c              |  4 +--
 target/riscv/vector_helper.c            |  1 +
 target/rx/cpu.c                         |  3 +-
 target/s390x/mmu_helper.c               |  1 +
 target/s390x/tcg/mem_helper.c           |  2 ++
 target/sh4/cpu.c                        |  4 +--
 target/sh4/helper.c                     |  1 +
 target/sparc/cpu.c                      |  2 +-
 target/sparc/ldst_helper.c              |  1 +
 target/sparc/mmu_helper.c               |  1 +
 target/tricore/cpu.c                    |  2 +-
 target/tricore/helper.c                 |  1 +
 target/xtensa/mmu_helper.c              |  1 +
 target/xtensa/op_helper.c               |  1 +
 83 files changed, 193 insertions(+), 110 deletions(-)
 create mode 100644 include/exec/page-protection.h

-- 
2.41.0


