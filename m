Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC1CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tAf-0007Vf-DQ; Thu, 24 Apr 2025 05:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAb-0007S9-Ay
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAY-0002YB-Kb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so3424175e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488015; x=1746092815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/TneLXTs9GAIHkLeC29GRDGEMVjCisO4HaTrvT1mEOQ=;
 b=RlCh7hagZt624H5F17ATOW6KeKNHgcla9FF70ECDoV9YVI3f3zIw5UQ3Xib7q0TyM3
 YnyezRCwjbN4I1EGSvUdrtfpGBCIOPT2jREQ81OQTFyUXkgsmQLqKimKMy7Ye7Rxcbo/
 g8QVSJAVcUsw6897awXA16PkGpz2QCfP7uqw6E+d+EPeW8bZdv88XOMkCiZqz/GCvxmO
 wWmSFmLDOcA1aJHokCHw6WSPu8tgagh9ymi/HIRR73XS/aeJ6fuZiZdwn+k9mn2t4iAi
 6CQunc0W1SWxazZbDaIrcvypGTbPv+n9mhfNJ90PuylbShumSKXUcakWODh36S7G36Qr
 XAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488015; x=1746092815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TneLXTs9GAIHkLeC29GRDGEMVjCisO4HaTrvT1mEOQ=;
 b=EhRSTA2Rehagwo8Vllq4r2J7+H7vpagXTRwZQzc7i5iaDiLfvKQJLFD5/oFgZvJ6Em
 k3CA8j0snmLgYy46WXMTEy6xDfE+b4ZHJ8nwzfPcyDD92co21yOXWWN6RlGuglwoAbSK
 Kk3heGJW0X2kr1ZX/y9L1CAG+hQfwwStYHSNjeUmISqAHFd+dEiPFYBKGX1ucPr2jXJN
 f9Toe/mmduw6nwFpUbitBEOc5+v9M1xNeP05qtOcOh5OFifTF50sO7lup6KRFWNPjPQr
 2BYuxoxpCxy6MUvWk1lddjfiPLBuVTU2BOo0wRLuIjoqiq4W7i02scotPk3bpeo3PkSI
 /nkQ==
X-Gm-Message-State: AOJu0Yxrtb4uETCxIMchhuHlUrFaqDM/WPpFIBcl/5EkTkaUwttm55nd
 IrFomm9KsyclO1a0s+WFHzbpzLl6r8vojMqQO4h3POA7XQHZyQ4cbImY1fEXXG337S0xQApt1uj
 r
X-Gm-Gg: ASbGnctoaIJ/nv/M0fAAg0PS0QclAUAq/mGTk7y1Z6KIaB57EKW0krh6KPauQSBLk4c
 PiPxCZ75taJhHYecL/wEdZ7gl+NJlvPhrvV3mNdFD2JXFrV1baDgLBZdUDXmMebedMyUiFpqwea
 oIW8SBpb6u4N5gU50MSw157Up1MBKJ0zF/Y7MpdqBG05kKrw3oVlpxV8beKECkDjEvIUn+aagH2
 x2LHjJmW4aXuleRlOgEIzbmxEUbbFeeddVurT++AKFIa2s6kDxzu8FFsXcrV41U1H5UxNKf41A6
 yXzmtwbns4CSS+MnmCZ0s+87eoFP7+PF0Ajdn7pnogwJ1de0C6wscCfRBS7qkWSupBHsHObTv+l
 W0/OPc693zRf9Je+9Uhrf
X-Google-Smtp-Source: AGHT+IH/vqg+urPF76xggCMzkjqgYy1ZGdMMs7+kKlQWsRzf+kcbesWArAQRQp2VDHW91scsR9AouQ==
X-Received: by 2002:a05:600c:1c91:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-4409bd18185mr19981075e9.10.1745488015631; 
 Thu, 24 Apr 2025 02:46:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29bfc4sm14504775e9.8.2025.04.24.02.46.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:46:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/13] include: Remove "exec/exec-all.h"
Date: Thu, 24 Apr 2025 11:46:40 +0200
Message-ID: <20250424094653.35932-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
  physmem: Move TCG IOMMU methods around
  physmem: Restrict TCG IOMMU code to TCG accel
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
 .../{exec/exec-all.h => accel/tcg/probe.h}    | 60 +++---------------
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
 target/arm/ptw.c                              |  4 +-
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
 166 files changed, 170 insertions(+), 295 deletions(-)
 create mode 100644 include/accel/tcg/iommu.h
 rename include/{exec/exec-all.h => accel/tcg/probe.h} (65%)

-- 
2.47.1


