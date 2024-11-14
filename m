Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF2D637CF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOQU-0007Qy-0T; Wed, 13 Nov 2024 20:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOQS-0007Q6-IA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:13:36 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOQP-0001t5-66
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:13:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso873685e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546809; x=1732151609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1EwqjnIRPctj4Nq1APqJi9S66/euonofsINQc3qIQuI=;
 b=CMYWPodBUiuAkKDJphMyENCBE+S04FzAN6K4E8EUifPUl5QAX6gTn1ZYU6Wmlw+G/X
 lTmQaoPCPWNiMNxrYiGUDw93rhLmazQaGUAQaF9DUURyghguM5IZ92FTXr5e0a4GpIoR
 PRaQdP4PJQItJc4wLYkj6lbsWsnKrFTI39AVduumu2WtXBzo32YiGGYsiTXCBk757lx6
 e7o1OS2uuobZ1vYiBUCEckl1yJcK/5Qydzqh39ZbuzfRkSwdk63YN816hv7o7GI4dnTd
 uIKtZEQ4LlfEdKDAMyx2dTSyg2jeecbxun2MJ6jPtVAOezh0rnCYKDM028A9gKdTsthO
 DWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546809; x=1732151609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EwqjnIRPctj4Nq1APqJi9S66/euonofsINQc3qIQuI=;
 b=FW7dU331nGitXWYv2Fy6s3zou4jm8r/slKfPBNkqsSC7TV2HaLOL0HqCztNhCNW4Nf
 FVDLhQvGn6Or4g04nZa3yPBT8VNzc1gqyplgjCTJuJc7srq7/pRl5PU1h7iJtJ3wrkmH
 F8h+ja4Dw6rpdetPlCaqmCogLUo9WsXFoflSzvepxtFTw0eSriXZSm9BISRfaT8pZENP
 KTLBgmPjmbTSNs43Fzw/UhGQ2j4ZFLBaYZZWwEZKku1i82KfZH9m9uevQdu5k5rNKUPZ
 OINH3wvjrkXwYcEeFIi7C3234kNcPcVsLbP2fczIy2FGgNgA2YxxITmLqLU8LOFkx0jj
 Xzzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrFd1wOeB2PTazt6eBO0+G5Jg2e/Gg6JjOl4iYTSiGAAaT31JLMUZe4ZL9hI2qwCgCtaq2KJQK45dy@nongnu.org
X-Gm-Message-State: AOJu0YxOy8PECPGwBuojNU5lioq9L6P4MGF0gVInvBWIViSIFu9860NH
 H0J8UTW5ewLGSHsx/8xfgqnlVgnQ4W27PwjIt6+yajmg1JqtOckJe6b4ST5PmV0=
X-Google-Smtp-Source: AGHT+IGZ4mtQztDulS9O9dxe4sHklabKWPOdh+RwHBXIF1ImFkUSMTktTv3L7h4tm6Iw0lzhApxUAQ==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id
 ffacd0b85a97d-381f1883bc1mr18783646f8f.47.1731546809627; 
 Wed, 13 Nov 2024 17:13:29 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda13780sm19409085f8f.109.2024.11.13.17.13.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:13:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/24] exec: Build up 'cputlb.h' and 'ram_addr.h' headers
Date: Thu, 14 Nov 2024 02:12:45 +0100
Message-ID: <20241114011310.3615-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi,

"exec/exec-all.h" and "exec/cpu-all.h" both contains a mess
of unrelated APIs. More importantly, they contain target
specific declarations, making any file including them to
become target specific, thus not buildable in common meson
sets.

This series first extract the CPU TLB API scattered in various
headers, then similarly strengthen the ram_addr_t API. Doing
so we figured extracting "user/guest-host.h" was necessary.

Before we have to include various missing headers to avoid
compilation breakage when refactoring.

The relevant part of the diff-stat is:

 include/exec/cpu-all.h        |  59 +-------------------
 include/exec/cpu-common.h     |  56 +------------------
 include/exec/cpu_ldst.h       |  73 +------------------------
 include/exec/exec-all.h       | 259 ------------------------------------------
 include/exec/ram_addr.h       | 56 ++-----------------
 include/sysemu/ram_addr.h     | 129 ++++++++++++++++++++++++++++++++++++++
 include/exec/cputlb.h         | 310 ++++++++++++++++++++++++++++++++++++++++++
 include/user/guest-host.h     |  87 +++++++++++++++++++++++++++++

Hoping it makes sense!

Please review,

Phil.

Philippe Mathieu-Daudé (24):
  exec/cpu-all: Include missing 'exec/cpu-defs.h' header
  exec/cpu-defs: Remove unnecessary headers
  exec/translation-block: Include missing 'exec/vaddr.h' header
  accel/tcg: Include missing 'exec/translation-block.h' header
  target/i386/helper: Include missing 'exec/translation-block.h' header
  target/rx/cpu: Include missing 'exec/translation-block.h' header
  system/watchpoint: Include missing 'exec/cpu-all.h' header
  linux-user/aarch64/mte: Include missing 'user/abitypes.h' header
  target/arm/mte: Restrict 'exec/ram_addr.h' to system emulation
  target/arm/cpu: Restrict cpu_untagged_addr() to user emulation
  exec: Introduce 'user/guest-host.h' header
  accel/tcg: Have tlb_vaddr_to_host() use vaddr type
  exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
  exec: Declare tlb_init/destroy() in 'exec/cputlb.h'
  exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
  exec: Declare tlb_set_page_with_attrs() in 'exec/cputlb.h'
  exec: Declare tlb_set_page() in 'exec/cputlb.h'
  exec: Declare tlb_flush*() in 'exec/cputlb.h'
  exec: Declare tlb_hit*() in 'exec/cputlb.h'
  exec: Declare tlb_vaddr_to_host() in 'exec/cputlb.h'
  exec: Extract CPU physical memory API to 'sysemu/physmem-target.h'
  exec/cpu-common: Move ram_addr_t related methods to 'exec/ram_addr.h'
  exec/memory: Move qemu_map_ram_ptr() declaration to 'exec/ram_addr.h'
  exec: Move 'ram_addr.h' header under sysemu/ namespace

 MAINTAINERS                                   |   3 +-
 include/exec/cpu-all.h                        |  59 +---
 include/exec/cpu-common.h                     |  56 +---
 include/exec/cpu-defs.h                       |   8 -
 include/exec/cpu_ldst.h                       |  73 +----
 include/exec/cputlb.h                         | 310 +++++++++++++++++-
 include/exec/exec-all.h                       | 259 ---------------
 include/exec/memory.h                         |   2 +-
 include/exec/translation-block.h              |   3 +-
 .../ram_addr.h => sysemu/physmem-target.h}    |  56 +---
 include/sysemu/ram_addr.h                     | 129 ++++++++
 include/user/guest-host.h                     |  87 +++++
 linux-user/aarch64/mte_user_helper.h          |   2 +
 target/arm/cpu.h                              |   5 +-
 accel/kvm/kvm-all.c                           |   3 +-
 accel/tcg/cpu-exec.c                          |   1 +
 accel/tcg/cputlb.c                            |  28 +-
 accel/tcg/tcg-accel-ops.c                     |   2 +
 accel/tcg/translate-all.c                     |   3 +-
 cpu-target.c                                  |   1 +
 hw/intc/armv7m_nvic.c                         |   2 +-
 hw/ppc/spapr.c                                |   3 +-
 hw/ppc/spapr_caps.c                           |   3 +-
 hw/ppc/spapr_nested.c                         |   1 +
 hw/ppc/spapr_pci.c                            |   3 +-
 hw/remote/memory.c                            |   3 +-
 hw/remote/proxy-memory-listener.c             |   3 +-
 hw/s390x/s390-stattrib-kvm.c                  |   3 +-
 hw/s390x/s390-stattrib.c                      |   3 +-
 hw/s390x/s390-virtio-ccw.c                    |   3 +-
 hw/sh4/sh7750.c                               |   1 +
 hw/vfio/common.c                              |   3 +-
 hw/vfio/container.c                           |   3 +-
 hw/vfio/iommufd.c                             |   3 +-
 hw/vfio/migration.c                           |   3 +-
 hw/vfio/spapr.c                               |   3 +-
 hw/virtio/virtio-mem.c                        |   3 +-
 migration/ram.c                               |   3 +-
 plugins/api.c                                 |   3 +-
 system/memory.c                               |   3 +-
 system/physmem.c                              |   4 +-
 system/watchpoint.c                           |   3 +-
 target/alpha/helper.c                         |   2 +-
 target/alpha/sys_helper.c                     |   2 +-
 target/arm/helper.c                           |   1 +
 target/arm/tcg/helper-a64.c                   |   1 +
 target/arm/tcg/mte_helper.c                   |   5 +-
 target/avr/helper.c                           |   2 +-
 target/hppa/mem_helper.c                      |   1 +
 target/i386/helper.c                          |   2 +
 target/i386/machine.c                         |   2 +-
 target/i386/tcg/fpu_helper.c                  |   2 +-
 target/i386/tcg/misc_helper.c                 |   2 +-
 target/i386/tcg/sysemu/excp_helper.c          |   2 +-
 target/i386/tcg/sysemu/misc_helper.c          |   2 +-
 target/i386/tcg/sysemu/svm_helper.c           |   2 +-
 target/loongarch/tcg/csr_helper.c             |   2 +-
 target/loongarch/tcg/tlb_helper.c             |   2 +-
 target/m68k/helper.c                          |   2 +-
 target/microblaze/helper.c                    |   2 +-
 target/microblaze/mmu.c                       |   2 +-
 target/mips/sysemu/cp0.c                      |   2 +-
 target/mips/tcg/sysemu/cp0_helper.c           |   2 +-
 target/mips/tcg/sysemu/tlb_helper.c           |   2 +-
 target/openrisc/mmu.c                         |   2 +-
 target/openrisc/sys_helper.c                  |   1 +
 target/ppc/helper_regs.c                      |   2 +-
 target/ppc/kvm.c                              |   3 +-
 target/ppc/mem_helper.c                       |   1 +
 target/ppc/misc_helper.c                      |   1 +
 target/ppc/mmu_helper.c                       |   1 +
 target/riscv/cpu_helper.c                     |   2 +-
 target/riscv/csr.c                            |   1 +
 target/riscv/op_helper.c                      |   1 +
 target/riscv/pmp.c                            |   2 +-
 target/rx/cpu.c                               |   3 +-
 target/s390x/gdbstub.c                        |   2 +-
 target/s390x/kvm/kvm.c                        |   3 +-
 target/s390x/sigp.c                           |   2 +-
 target/s390x/tcg/excp_helper.c                |   1 +
 target/s390x/tcg/mem_helper.c                 |   1 +
 target/s390x/tcg/misc_helper.c                |   1 +
 target/sh4/helper.c                           |   2 +-
 target/sparc/ldst_helper.c                    |   1 +
 target/sparc/mmu_helper.c                     |   2 +-
 target/tricore/helper.c                       |   2 +-
 target/xtensa/helper.c                        |   2 +-
 target/xtensa/mmu_helper.c                    |   1 +
 88 files changed, 670 insertions(+), 566 deletions(-)
 rename include/{exec/ram_addr.h => sysemu/physmem-target.h} (88%)
 create mode 100644 include/sysemu/ram_addr.h
 create mode 100644 include/user/guest-host.h

-- 
2.45.2


