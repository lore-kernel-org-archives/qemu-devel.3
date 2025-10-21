Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFE2CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEiV-0000nE-LB; Tue, 21 Oct 2025 11:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEiT-0000mm-P0
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:05 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEiP-0007jH-Gu
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3381f041d7fso36796a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761062159; x=1761666959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NjEoBN1DTzgzuVVkcp74eBzxIq+NAevdzIp3vJ9UjWw=;
 b=Ysw7Lb0709xWJLym631GnGpuvgWPP9geLq/FHQlwW8u5XCkdX27xvTMad9yXzyQGmi
 kzli5SaJsEb1AmfeiF2/iGOhmtmAxPEtiVcbrx4Zvvy8YMkMffz/SGAcYYWnF7Ra4wct
 2xSUf1UuHR4Dme+YkV3YMTFNqzcyAvZ6H685Jjm2s+HTaCvQYUYHiZvJ5N4M+TDgjyAK
 BNaYGWM2sncePPbcXWOLRRLFYLImB6P1buVkOs9NmFFqFR13n2Ad0x0TrfQECSay6FCl
 p+sTpc3xQ3vtmuhS9hF4UeVVj3qdpXuQtrozAh2pCS93C3BNOh2BAfPOkejiO7aIVy/i
 +WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062159; x=1761666959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NjEoBN1DTzgzuVVkcp74eBzxIq+NAevdzIp3vJ9UjWw=;
 b=IJ5tvwF0p7wSVoalw0Q//S1+/vpExdfFtlfQg2EwUZRxl3CTN/yZdadtluyD8Fm7/y
 krD6Q8zYlgnrBB8ImPYLzAO9jRQgjO6JDn1CdCo4bJyo2F402bJcC4SrwnR6Q9esQAKh
 4YyVPPZzyn6P4xv8itd1dRXP6mm1nrstu68Z9y+/5rPiCrL501LT3A8yn/1jGivfg7+9
 ypnMGVL/kwHwcAxV+zDeL7mgwb/xTkWn8gIn0iWJq+I3bpA89pMNTXp4/XGov/KrUNYF
 Rki394bsN1gJ8c7ldzW1gr+BICJwCJm+UXjGX1dHBYCrA6dVD+DB+44RI2gA2RnjnIg6
 FCDg==
X-Gm-Message-State: AOJu0Yz0hzE7SM8Vcn0oAQu7h2VT8fgvecTwAF7F/B6i64LzakL2aCfH
 DjRRRaSuHpPPFwnUyvKQdhzqdky49mXew47JctElOjGWN+k+ZIrXfXKr6PZ/PNsraGkIsr3nntU
 37YygywRd0dcMW7ZW27soB2lXMMhPXfnhCVb/w6rhcZW5Teobos2S406EuvQrLYOuOV9dxojE7F
 JjMhnqIeTxLS9ZYpS22y6TSE9yCWg9F+EWMslB1Q==
X-Gm-Gg: ASbGncu0szTgxoXcv+udOJC8WM9GvTFkmmOFWmU3SDJ7VvG+weLSNsAAM4iLq53pj3x
 7kYv1olSQI/YuDePpbW0etSjiczZ36SedkWK8iGOT/sSsN+hi/IznL5Xq8qKh5cN6lfT1OlQQ9A
 7zKQKpDT/34PdirdAo3SJPMFNAtNtp4I9MUyGJI2HfUTJEluTCUsk+msqa44L99AbQd09OO/aeb
 yIJNtuLThvre5ADR/PuDT/40ClX8i4hDewtjqVmnx9HsuBAx+AMwkOgLLL+6tIws7sV2ws3LfNF
 0MB9T759T1tboltnDpcjHkV8ndvgGH31IItLNo81EcAkrUntWi7SyUUWsV+UZL79L3DUVUQEDq0
 Hxl4vdX4F2zNG5Wr8MkTVoqS0cuUR1W8zpbV5ZfKyieo0BhBOiZ+CQMeItrdAp5F6QujebeZGEm
 VeQ5W2UYmLcaMFraaXTacSAg==
X-Google-Smtp-Source: AGHT+IF5iBeslKPUmm8kYDD8jZdc1Vf7lPHkZKo061V/Rwv44G4bttpUR7xNweajeAjUnsdc38R+Gg==
X-Received: by 2002:a17:90b:570e:b0:335:2d25:7a7a with SMTP id
 98e67ed59e1d1-33e21d8d38emr388409a91.10.1761062158403; 
 Tue, 21 Oct 2025 08:55:58 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de11392sm11490177a91.7.2025.10.21.08.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:55:57 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 00/18] Implements RISC-V WorldGuard extension v0.4
Date: Tue, 21 Oct 2025 23:55:30 +0800
Message-ID: <20251021155548.584543-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset implements Smwg/Smwgd/Sswg CPU extension and wgChecker
device defined in WorldGuard spec v0.4.

The WG v0.4 spec could be found here:
https://lists.riscv.org/g/security/attachment/711/0/worldguard_rvia_spec-v0.4.pdf

To enable WG in QEMU, pass "wg=on" as machine parameter to virt machine.
It enables both WG CPU CSRs to apply WID of CPU and wgCheckers on
the DRAM, FLASH, and UART to protect these resources.

This patchset contains 5 parts:

1. Commit  1 ~ 2: Bugfix of IOMMUMemoryRegion
2. Commit  3 ~ 4: Extend IOMMUMemoryRegion and MemTxAttr for WG support
3. Commit  5 ~ 13: Add WG global device and CPU extensions
4. Commit 14 ~ 17: Add WG checker device
5. Commit 18: Add WG support to the virt machine

QEMU code can be found at [1]

[1] https://github.com/cwshu/qemu/tree/riscv-wg-v3

Changed since v2:
- Fix the issues in v2 series as suggested by Daniel Henrique Barboza
  - Explain the changes of 'reserved' fields in MemTxAttr
  - Make isa_edata_arr in order
  - Replace qemu_get_cpu() with cpu_by_arch_id(). Do the clean exit when
    return NULL.
  - Simplify the machine option checking via 'object_property_get_bool'

- Add the minor fixes and improvements to the wgChecker:
  - Increase the maximum number of region of a wgchecker from 16 to 64
  - Clear the IRQ pending of wgchecker when writing to `errcause.ip`
  - Do the TLB flush when resetting the wgchecker
  - Improve the trace message

Changed since v1:
- Remove the assertion of 4k sections limitation. Remove
  iotlb_to_section() and rename 'xlat_section' to 'xlat'.
- Fix RST issue and typo in virt machine doc

Changed since RFCv1:
- Rebase to latest QEMU (v10.0.0-rc3)
- Add the description of HW config and CPU option of WG in the
  virt machine documentation
- Expose CPU options of WG after WG CPU code has been implemented
- Change 'mwid' and 'mwidlist' options to experimental options
- Change 'world_id' to unsigned int type + bit field.

Jim Shu (18):
  accel/tcg: Store section pointer in CPUTLBEntryFull
  system/physmem: Remove the assertion of page-aligned section number
  accel/tcg: memory access from CPU will pass access_type to IOMMU
  exec: Add RISC-V WorldGuard WID to MemTxAttrs
  hw/misc: riscv_worldguard: Add RISC-V WorldGuard global config
  target/riscv: Add CPU options of WorldGuard CPU extension
  target/riscv: Add hard-coded CPU state of WG extension
  target/riscv: Add defines for WorldGuard CSRs
  target/riscv: Allow global WG config to set WG CPU callbacks
  target/riscv: Implement WorldGuard CSRs
  target/riscv: Add WID to MemTxAttrs of CPU memory transactions
  target/riscv: Expose CPU options of WorldGuard
  hw/misc: riscv_worldguard: Add API to enable WG extension of CPU
  hw/misc: riscv_wgchecker: Implement RISC-V WorldGuard Checker
  hw/misc: riscv_wgchecker: Implement wgchecker slot registers
  hw/misc: riscv_wgchecker: Implement correct block-access behavior
  hw/misc: riscv_wgchecker: Check the slot settings in translate
  hw/riscv: virt: Add WorldGuard support

 accel/tcg/cputlb.c                   |   49 +-
 docs/system/riscv/virt.rst           |   20 +
 hw/misc/Kconfig                      |    3 +
 hw/misc/meson.build                  |    1 +
 hw/misc/riscv_wgchecker.c            | 1190 ++++++++++++++++++++++++++
 hw/misc/riscv_worldguard.c           |  277 ++++++
 hw/misc/trace-events                 |    9 +
 hw/riscv/Kconfig                     |    1 +
 hw/riscv/virt.c                      |  163 +++-
 include/accel/tcg/iommu.h            |   18 +-
 include/exec/cputlb.h                |   13 +-
 include/exec/memattrs.h              |    8 +-
 include/hw/core/cpu.h                |   12 +-
 include/hw/misc/riscv_worldguard.h   |  124 +++
 include/hw/riscv/virt.h              |   15 +-
 system/physmem.c                     |   47 +-
 target/alpha/helper.c                |    2 +-
 target/avr/helper.c                  |    2 +-
 target/hppa/mem_helper.c             |    1 -
 target/i386/tcg/system/excp_helper.c |    3 +-
 target/loongarch/tcg/tlb_helper.c    |    2 +-
 target/m68k/helper.c                 |   10 +-
 target/microblaze/helper.c           |    8 +-
 target/mips/tcg/system/tlb_helper.c  |    4 +-
 target/openrisc/mmu.c                |    2 +-
 target/ppc/mmu_helper.c              |    2 +-
 target/riscv/cpu.c                   |   17 +-
 target/riscv/cpu.h                   |   12 +
 target/riscv/cpu_bits.h              |    5 +
 target/riscv/cpu_cfg_fields.h.inc    |    6 +
 target/riscv/cpu_helper.c            |   69 +-
 target/riscv/csr.c                   |  107 +++
 target/riscv/tcg/tcg-cpu.c           |   11 +
 target/rx/cpu.c                      |    3 +-
 target/s390x/tcg/excp_helper.c       |    2 +-
 target/sh4/helper.c                  |    2 +-
 target/sparc/mmu_helper.c            |    6 +-
 target/tricore/helper.c              |    2 +-
 target/xtensa/helper.c               |    3 +-
 39 files changed, 2111 insertions(+), 120 deletions(-)
 create mode 100644 hw/misc/riscv_wgchecker.c
 create mode 100644 hw/misc/riscv_worldguard.c
 create mode 100644 include/hw/misc/riscv_worldguard.h

-- 
2.43.0


