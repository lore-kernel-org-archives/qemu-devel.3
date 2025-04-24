Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD33C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837N-0008BW-M4; Thu, 24 Apr 2025 16:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837L-0008BD-86
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837I-0004yf-SU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso896304f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526254; x=1746131054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zS9uaJb7OOhVajlERqcTljH9kQDvYp8Jj+1ZAW/GfMo=;
 b=quoL06qnP8n/qTqz8gfFeXWUobOiFS7K9SXDlxPOfaeClRJGMgUclYdt2yUs+6o3K5
 VJxvXkqn7Kgv5xdwrUjD4E+0i5+1r6+SJc+f9QMeMgGliIWhlEoGCHWs9C5UeC5PzaJf
 535A0jdZtJleFqvLdv0RQpQB8XRksnDhMYsqqmhYivSDgY5LWW4uWeVqwm21ZDlPPMpZ
 a/nc59q8iRIswMlPgsFlMyBXZsbAEsj6LD4jEag5bAix1D5aEtM0eI3Txo9PBz9HifQb
 oAcJpfg3C9vlIBLYsp++OLpl4td44HS3IZ+CvNMZIddq7uji8le8PSYt+yZZl/85DREr
 okzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526254; x=1746131054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zS9uaJb7OOhVajlERqcTljH9kQDvYp8Jj+1ZAW/GfMo=;
 b=QFKW+K7dK081/meBuPXBDNPYX86OBNaNnfK6G6hqupwbThf92Qu6V2Zn7K11haDon6
 Y+FpKlHrNnLfInUOWWlAsmlznaLPqyIiwdKIFAGjR2xTd1yGuiVrKusg8YOCN2UcK6a4
 pdU6WK2BptqJVc2UxtjX2If4hmHNqVjObi0aubtCwz8iqO1RSFUYsHDNODfvM4dhCOmY
 YN9iDMQh92ZUIJbmgFxc2pxb1b4AklIVK5ZJp/sA/h/FrjdZ2e6OVCJGz+YUJEDvJysn
 rjy3iIEZHtNfEXUoAt9CEpUNxUp0MHc3XijS14BgrJ6g83FrYMp6nJ1G7H+8A1jsOfkr
 kwjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB0iLgc4WWg4lsXJyWXvTafiPoQSQRKTuwMpa3hkvy0V8jygZysXuDpC9wR2XBF36vkYpgBhViViU1@nongnu.org
X-Gm-Message-State: AOJu0Yz8QkPuQYvTOP09aH52wCNw5mvqA/o4WpIX8pAsdQhAhGSesM99
 4mexY7xvw5oW0ESIDvFf7vWHbI04c8eNpsyZZxPFiKsvg49odzlQJRJyuF2W9xM=
X-Gm-Gg: ASbGncsSq3XpgH1EeJ4RQIzNA+uxDeTor1O7pyi9cU7dZ55PSi5hPM/1kw1nEXveRpq
 3uTtqSzNlnGzSZNLGDl/bsse/MzbM3TQoNfk6P4e/Eia387rh2FCeyrpG3g0cue+LuEpUCM1BGt
 8dJvBIbuQIqo5W//ij+RoBLyXALPgpS4623gp0+7MIJOubYNhtWNqpuPCRVvGxbFCGh6ckY5phy
 mBu7xNXPW7XmwgZ/0NtwJslgM4aCG5s6GYwvPOSsMA500M/cG+A0KdiC86m9PlUz8MOpH5RBqqe
 qo0znTyV3fIHq+CdS/37tEGhax6H7u4cq3vMnFYVXpoKZoQPBlER3y2fGtXGPqc/ptTcM5ygS40
 8uGTtkMOJBVWF6/Y=
X-Google-Smtp-Source: AGHT+IGHJDsQXJSGVs99PZUXHAdwP5VUOtsBJmiImYcEUs6PWvPbO4GtLy9YIHf4zVDAYfpQtLbLxQ==
X-Received: by 2002:a05:6000:186c:b0:39e:f9d8:e016 with SMTP id
 ffacd0b85a97d-3a06cfa7867mr3154216f8f.44.1745526254596; 
 Thu, 24 Apr 2025 13:24:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e461bfsm242685f8f.79.2025.04.24.13.24.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/13] include: Remove "exec/exec-all.h"
Date: Thu, 24 Apr 2025 22:23:59 +0200
Message-ID: <20250424202412.91612-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since v2:
- Removed CONFIG_TCG #ifdef'ry (rth)
- Added R-b/A-b tags

Trivial series moving declarations around, emptying
"exec/exec-all.h" to eventually remove it.

- Fix accel/stubs/tcg-stub.c headers
- Include "accel/tcg/getpc.h" where appropriate
- Extract TCG IOMMU API to "accel/tcg/iommu.h"
- Extract TCG probe API to "accel/tcg/probe.h"
- Remove "exec/exec-all.h"

It is based on "accel/tcg: Compile tb-maint.c twice".
I had to fix its patch #12, so I'm including patches
12-15 in this series.

Based-on: <20250424011918.599958-12-richard.henderson@linaro.org>

Philippe Mathieu-Daudé (9):
  accel/tcg: Correct list of included headers in tcg-stub.c
  include/exec: Include missing headers in exec-all.h
  target/riscv: Include missing 'accel/tcg/getpc.h' in csr.c
  target/hexagon: Include missing 'accel/tcg/getpc.h'
  accel/tcg: Include 'accel/tcg/getpc.h' in 'exec/helper-proto'
  physmem: Move TCG IOTLB methods around
  physmem: Restrict TCG IOTLB code to TCG accel
  accel/tcg: Extract probe API out of 'exec/exec-all.h'
  include: Remove 'exec/exec-all.h'

Richard Henderson (4):
  accel/tcg: Use vaddr for walk_memory_regions callback
  accel/tcg: Use vaddr in user/page-protection.h
  include/exec: Move tb_invalidate_phys_range to translation-block.h
  accel/tcg: Compile tb-maint.c twice

 MAINTAINERS                                   |  3 +-
 accel/tcg/tb-hash.h                           |  3 +-
 bsd-user/qemu.h                               |  1 -
 include/accel/tcg/iommu.h                     | 41 ++++++++++++
 .../{exec/exec-all.h => accel/tcg/probe.h}    | 58 ++---------------
 include/exec/helper-proto-common.h            |  2 +
 include/exec/translation-block.h              |  4 ++
 include/system/ram_addr.h                     |  1 -
 include/user/page-protection.h                | 22 +++----
 linux-user/user-internals.h                   |  1 -
 target/arm/tcg/translate.h                    |  1 -
 target/hexagon/macros.h                       |  1 +
 target/hexagon/mmvec/macros.h                 |  2 +
 target/i386/tcg/helper-tcg.h                  |  1 -
 accel/hvf/hvf-accel-ops.c                     |  1 -
 accel/stubs/tcg-stub.c                        |  3 +-
 accel/tcg/cputlb.c                            |  3 +-
 accel/tcg/tb-maint.c                          |  2 -
 accel/tcg/translate-all.c                     |  2 +-
 accel/tcg/user-exec.c                         | 63 +++++++++----------
 bsd-user/main.c                               |  1 -
 hw/ppc/spapr_nested.c                         |  1 -
 hw/riscv/riscv-iommu-sys.c                    |  1 -
 hw/sh4/sh7750.c                               |  1 -
 linux-user/elfload.c                          | 19 +++---
 linux-user/main.c                             |  1 -
 linux-user/syscall.c                          |  8 +--
 semihosting/uaccess.c                         |  2 +-
 system/physmem.c                              | 56 +++++++++--------
 target/alpha/cpu.c                            |  1 -
 target/alpha/fpu_helper.c                     |  1 -
 target/alpha/int_helper.c                     |  1 -
 target/alpha/mem_helper.c                     |  1 -
 target/alpha/translate.c                      |  1 -
 target/alpha/vax_helper.c                     |  1 -
 target/arm/cpu.c                              |  1 -
 target/arm/debug_helper.c                     |  1 -
 target/arm/helper.c                           |  2 +-
 target/arm/ptw.c                              |  2 +-
 target/arm/tcg/helper-a64.c                   |  2 +-
 target/arm/tcg/m_helper.c                     |  1 -
 target/arm/tcg/mte_helper.c                   |  2 +-
 target/arm/tcg/mve_helper.c                   |  1 -
 target/arm/tcg/op_helper.c                    |  2 +-
 target/arm/tcg/pauth_helper.c                 |  1 -
 target/arm/tcg/sme_helper.c                   |  1 -
 target/arm/tcg/sve_helper.c                   |  2 +-
 target/arm/tcg/tlb_helper.c                   |  1 -
 target/arm/tcg/translate-a64.c                |  1 -
 target/avr/cpu.c                              |  1 -
 target/avr/helper.c                           |  1 -
 target/avr/translate.c                        |  1 -
 target/hexagon/cpu.c                          |  1 -
 target/hexagon/op_helper.c                    |  2 +-
 target/hppa/cpu.c                             |  1 -
 target/hppa/fpu_helper.c                      |  1 -
 target/hppa/helper.c                          |  1 -
 target/hppa/mem_helper.c                      |  2 +-
 target/hppa/op_helper.c                       |  2 +-
 target/hppa/sys_helper.c                      |  1 -
 target/hppa/translate.c                       |  1 -
 target/i386/tcg/access.c                      |  2 +-
 target/i386/tcg/excp_helper.c                 |  1 -
 target/i386/tcg/int_helper.c                  |  1 -
 target/i386/tcg/mem_helper.c                  |  1 -
 target/i386/tcg/mpx_helper.c                  |  1 -
 target/i386/tcg/seg_helper.c                  |  2 +-
 target/i386/tcg/system/bpt_helper.c           |  1 -
 target/i386/tcg/system/excp_helper.c          |  1 +
 target/i386/tcg/translate.c                   |  1 -
 target/i386/tcg/user/excp_helper.c            |  1 -
 target/i386/tcg/user/seg_helper.c             |  1 -
 target/loongarch/cpu.c                        |  1 -
 target/loongarch/tcg/fpu_helper.c             |  1 -
 target/loongarch/tcg/iocsr_helper.c           |  1 -
 target/loongarch/tcg/op_helper.c              |  1 -
 target/loongarch/tcg/tlb_helper.c             |  1 -
 target/loongarch/tcg/vec_helper.c             |  1 -
 target/m68k/fpu_helper.c                      |  1 -
 target/m68k/helper.c                          |  1 -
 target/m68k/op_helper.c                       |  1 -
 target/m68k/translate.c                       |  1 -
 target/microblaze/cpu.c                       |  1 -
 target/microblaze/op_helper.c                 |  1 -
 target/microblaze/translate.c                 |  1 -
 target/mips/cpu.c                             |  1 -
 target/mips/system/physaddr.c                 |  1 -
 target/mips/tcg/exception.c                   |  1 -
 target/mips/tcg/fpu_helper.c                  |  1 -
 target/mips/tcg/ldst_helper.c                 |  1 -
 target/mips/tcg/msa_helper.c                  |  2 +-
 target/mips/tcg/op_helper.c                   |  1 -
 target/mips/tcg/system/special_helper.c       |  1 -
 target/mips/tcg/system/tlb_helper.c           |  1 -
 target/openrisc/cpu.c                         |  1 -
 target/openrisc/exception.c                   |  1 -
 target/openrisc/exception_helper.c            |  1 -
 target/openrisc/fpu_helper.c                  |  1 -
 target/openrisc/interrupt.c                   |  1 -
 target/openrisc/interrupt_helper.c            |  1 -
 target/openrisc/sys_helper.c                  |  1 -
 target/openrisc/translate.c                   |  1 -
 target/ppc/excp_helper.c                      |  1 -
 target/ppc/fpu_helper.c                       |  1 -
 target/ppc/machine.c                          |  1 -
 target/ppc/mem_helper.c                       |  2 +-
 target/ppc/misc_helper.c                      |  1 -
 target/ppc/mmu-hash32.c                       |  1 -
 target/ppc/mmu-hash64.c                       |  1 -
 target/ppc/mmu-radix64.c                      |  1 -
 target/ppc/mmu_common.c                       |  1 -
 target/ppc/mmu_helper.c                       |  1 -
 target/ppc/power8-pmu.c                       |  1 -
 target/ppc/tcg-excp_helper.c                  |  1 -
 target/ppc/timebase_helper.c                  |  1 -
 target/ppc/translate.c                        |  1 -
 target/ppc/user_only_helper.c                 |  1 -
 target/riscv/cpu.c                            |  1 -
 target/riscv/cpu_helper.c                     |  1 -
 target/riscv/crypto_helper.c                  |  1 -
 target/riscv/csr.c                            |  2 +-
 target/riscv/debug.c                          |  1 -
 target/riscv/fpu_helper.c                     |  1 -
 target/riscv/m128_helper.c                    |  1 -
 target/riscv/op_helper.c                      |  2 +-
 target/riscv/tcg/tcg-cpu.c                    |  1 -
 target/riscv/translate.c                      |  1 -
 target/riscv/vcrypto_helper.c                 |  1 -
 target/riscv/vector_helper.c                  |  2 +-
 target/riscv/zce_helper.c                     |  1 -
 target/rx/op_helper.c                         |  1 -
 target/rx/translate.c                         |  1 -
 target/s390x/interrupt.c                      |  1 -
 target/s390x/mmu_helper.c                     |  1 -
 target/s390x/sigp.c                           |  1 -
 target/s390x/tcg/cc_helper.c                  |  1 -
 target/s390x/tcg/crypto_helper.c              |  1 -
 target/s390x/tcg/excp_helper.c                |  1 -
 target/s390x/tcg/fpu_helper.c                 |  1 -
 target/s390x/tcg/int_helper.c                 |  1 -
 target/s390x/tcg/mem_helper.c                 |  2 +-
 target/s390x/tcg/misc_helper.c                |  1 -
 target/s390x/tcg/translate.c                  |  1 -
 target/s390x/tcg/vec_fpu_helper.c             |  1 -
 target/s390x/tcg/vec_helper.c                 |  1 -
 target/sh4/cpu.c                              |  1 -
 target/sh4/helper.c                           |  1 -
 target/sh4/op_helper.c                        |  1 -
 target/sh4/translate.c                        |  1 -
 target/sparc/cpu.c                            |  1 -
 target/sparc/fop_helper.c                     |  1 -
 target/sparc/helper.c                         |  1 -
 target/sparc/ldst_helper.c                    |  1 -
 target/sparc/machine.c                        |  1 -
 target/sparc/translate.c                      |  1 -
 target/sparc/win_helper.c                     |  1 -
 target/tricore/cpu.c                          |  1 -
 target/tricore/op_helper.c                    |  1 -
 target/tricore/translate.c                    |  1 -
 target/xtensa/dbg_helper.c                    |  1 -
 target/xtensa/exc_helper.c                    |  1 -
 target/xtensa/fpu_helper.c                    |  1 -
 target/xtensa/mmu_helper.c                    |  2 +-
 target/xtensa/op_helper.c                     |  1 -
 target/xtensa/translate.c                     |  1 -
 target/xtensa/win_helper.c                    |  1 -
 accel/tcg/meson.build                         |  2 +-
 167 files changed, 165 insertions(+), 297 deletions(-)
 create mode 100644 include/accel/tcg/iommu.h
 rename include/{exec/exec-all.h => accel/tcg/probe.h} (65%)

-- 
2.47.1


