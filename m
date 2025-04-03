Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52009C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sfk-0008AJ-Oy; Thu, 03 Apr 2025 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfj-00089x-9J
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfh-0003ik-1l
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso875356f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717862; x=1744322662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xbMz4QlTsswxFmDVubzItp5sarMx+/xbDzlb26CXOjk=;
 b=c+RCrN8GA6gvbAv1UucRMZnDF4EWKDond57R8zNCLFWcUvOkGaLomNN8R1xnHOH/1P
 EIwFtKVbDb6hcMJ+59wFf961r1IPslUbSNSaLri+7Qpz5WROd7yM+J2EaXBpf3W3PQEr
 lTZh4Lz8xa5xdCqvSdgMn/oBXi0xHjdEAEsJKlKz+DEcZY6xYU94a7UsGFuLQFDYdz8X
 S/qSGOLgcqhhCBiRqqnTJ1GGzoj3uEx4mY4pOV00KQQginyswKrNgeWkgqFPOfRsK0DQ
 6r7tqAAmePN06DIfqSWfVrc7Jqky/NrXrTqiujSAb0Sh8jzaYh8ilvi2UppZhM0aAZW+
 zFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717862; x=1744322662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbMz4QlTsswxFmDVubzItp5sarMx+/xbDzlb26CXOjk=;
 b=EI5pKp57Ndo6jjAwVKxVJ5ewqiQYjupa9E55WfumJNOv4a3w6TkQ7QiaUqniJNbj7f
 2/k+2nsSqQ6cyags/pUoONZSWle9EB+i76XK0SyBuPEdU3vS++0kf4RbyueydY5yYyih
 aFMEDm61p55dszvMjUHLvEyaqrF9AxQVHraF582gl196+M5R6cZTeQYu+SVQeWPydstq
 VgK+QmWT6os+i/v2wlMoo27Jk4QSuXa7+THzVjGIZry6HYosSfFnYNOnP45Ds7PwtveN
 g6v9S3xRgW99lOEz2d71llq+O4vxVCH/pfLaimcaLq3+H/GRqAxGK/hdttw5EAXOSfJZ
 5Lcg==
X-Gm-Message-State: AOJu0Yy4wVP8MKF/GKrEaZjbTSPFkjNx1MHNUTXmTOU1gkjquMdH+S/5
 QSmZp+2WgXwphbJAIhjQnbr9wyX+iHpXqHPm8DNuSMSWB52BRMZrp6jOZbdNvFtUNxneHKXbUxm
 J
X-Gm-Gg: ASbGncuBMom/kJhXvCoumihmh3rTpi2gTQzpYi1hIJ2u0/3YWTW4FFkbnPXDN+5iWlQ
 PaWZZbnTszLE6DajehTWgwmVp5QUA3dKZzQ6p8MN8TV/V+wbJNAuIjQkv6CkCSdtcWl0+6+cOyc
 MkckyPie7b7ue/AJfJ1AZYUW5erE7WBvwEAtt1u2zmxr3ZlUBX857MjDzT4USVLg37S6GkxQeOw
 ua3kjLpGFDQqd5b2aNcRgZPfTDVnFt8TGTPsb/rFwUox/OihUT3Z5Owgl8UmYCKqARnTlyeQUnH
 efOb+8DBINeg7k1R01xFC5Kikk+K+JkxUV9VY2wU7xi5BtuHFqll+xpA5NcFOGXsZR3rE5H9TyX
 uuCez++9x2uWy0n1lyJlpVoK3
X-Google-Smtp-Source: AGHT+IFLrJQvVvnYmQ4IPOMlbJd4MuzdSErBg8RUd3CN3UDGcQeZPYJWNi+mY3OPE2RjYjn3qOk6jQ==
X-Received: by 2002:a5d:6dac:0:b0:38f:2b77:a9f3 with SMTP id
 ffacd0b85a97d-39cba975b4dmr687281f8f.43.1743717862488; 
 Thu, 03 Apr 2025 15:04:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6608sm2782328f8f.23.2025.04.03.15.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:04:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 00/19] tcg: philmd's queue
Date: Fri,  4 Apr 2025 00:04:00 +0200
Message-ID: <20250403220420.78937-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Richard,

Here is my patch queue based on your tcg-next tree fixed.

You can find it as commit 511d57c091f on my repository:
https://gitlab.com/philmd/qemu/-/tree/tcg-next-fixed

Thanks,

Phil.

Since v1:
- Deferred warning change and updated desc (patches 40 & 42)
Since v2:
- Rebased & addressed review comments

Philippe Mathieu-Daudé (19):
  target/riscv: Do not expose rv128 CPU on user mode emulation
  tcg: Include missing 'cpu.h' in translate-all.c
  tcg: Declare TARGET_INSN_START_EXTRA_WORDS in 'cpu-param.h'
  tcg: Always define TARGET_INSN_START_EXTRA_WORDS
  exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
  exec: Restrict 'cpu_ldst.h' to accel/tcg/
  exec: Do not include 'accel/tcg/cpu-ldst.h' in 'exec-all.h'
  tcg: Always define TCG_GUEST_DEFAULT_MO
  tcg: Simplify tcg_req_mo() macro
  tcg: Define guest_default_memory_order in TCGCPUOps
  tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
  tcg: Propagate CPUState argument to cpu_req_mo()
  tcg: Have tcg_req_mo() use TCGCPUOps::guest_default_memory_order
  tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally
  tcg: Move cpu_req_mo() macro to target-agnostic 'backend-ldst.h'
  tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
  tcg: Convert TCGState::mttcg_enabled to TriState
  tcg: Factor mttcg_init() out
  tcg: Convert TARGET_SUPPORTS_MTTCG to TCGCPUOps::mttcg_supported field

 docs/devel/multi-thread-tcg.rst               |  6 +-
 configs/targets/aarch64-softmmu.mak           |  1 -
 configs/targets/alpha-softmmu.mak             |  1 -
 configs/targets/arm-softmmu.mak               |  1 -
 configs/targets/hppa-softmmu.mak              |  1 -
 configs/targets/i386-softmmu.mak              |  1 -
 configs/targets/loongarch64-softmmu.mak       |  1 -
 configs/targets/microblaze-softmmu.mak        |  1 -
 configs/targets/microblazeel-softmmu.mak      |  1 -
 configs/targets/mips-softmmu.mak              |  1 -
 configs/targets/mipsel-softmmu.mak            |  1 -
 configs/targets/or1k-softmmu.mak              |  1 -
 configs/targets/ppc64-softmmu.mak             |  1 -
 configs/targets/riscv32-softmmu.mak           |  1 -
 configs/targets/riscv64-softmmu.mak           |  1 -
 configs/targets/s390x-softmmu.mak             |  1 -
 configs/targets/sparc-softmmu.mak             |  1 -
 configs/targets/sparc64-softmmu.mak           |  1 -
 configs/targets/x86_64-softmmu.mak            |  1 -
 configs/targets/xtensa-softmmu.mak            |  1 -
 configs/targets/xtensaeb-softmmu.mak          |  1 -
 accel/tcg/backend-ldst.h                      | 41 +++++++++
 accel/tcg/internal-target.h                   | 35 --------
 bsd-user/qemu.h                               |  2 +-
 include/{exec => accel/tcg}/cpu-ldst-common.h |  6 +-
 .../{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} |  8 +-
 include/accel/tcg/cpu-ops.h                   | 16 ++++
 include/exec/exec-all.h                       |  3 -
 include/exec/poison.h                         |  1 -
 include/hw/core/cpu.h                         |  9 --
 include/system/tcg.h                          |  8 ++
 include/tcg/insn-start-words.h                |  6 +-
 include/tcg/tcg-op.h                          |  2 +-
 linux-user/qemu.h                             |  2 +-
 target/alpha/cpu-param.h                      |  3 +-
 target/arm/cpu-param.h                        |  8 +-
 target/arm/cpu.h                              |  6 --
 target/arm/tcg/sve_ldst_internal.h            |  2 +-
 target/avr/cpu-param.h                        |  2 +-
 target/hexagon/cpu-param.h                    |  2 +
 target/hppa/cpu-param.h                       |  8 +-
 target/hppa/cpu.h                             |  2 -
 target/i386/cpu-param.h                       |  3 +-
 target/i386/cpu.h                             |  2 -
 target/loongarch/cpu-param.h                  |  2 +-
 target/m68k/cpu-param.h                       |  2 +
 target/m68k/cpu.h                             |  2 -
 target/microblaze/cpu-param.h                 |  3 +-
 target/microblaze/cpu.h                       |  2 -
 target/mips/cpu-param.h                       |  2 +-
 target/mips/cpu.h                             |  2 -
 target/openrisc/cpu-param.h                   |  2 +-
 target/openrisc/cpu.h                         |  2 -
 target/ppc/cpu-param.h                        |  2 +-
 target/riscv/cpu-param.h                      | 10 ++-
 target/riscv/cpu.h                            |  6 --
 target/rx/cpu-param.h                         |  2 +
 target/s390x/cpu-param.h                      |  6 +-
 target/s390x/cpu.h                            |  2 -
 target/sh4/cpu-param.h                        |  2 +
 target/sh4/cpu.h                              |  2 -
 target/sparc/cpu-param.h                      | 23 +----
 target/sparc/cpu.h                            |  1 -
 target/tricore/cpu-param.h                    |  2 +
 target/xtensa/cpu-param.h                     |  3 +-
 accel/tcg/cpu-exec.c                          |  1 +
 accel/tcg/cputlb.c                            | 23 ++---
 accel/tcg/tcg-all.c                           | 84 +++++++++++--------
 accel/tcg/translate-all.c                     |  7 +-
 accel/tcg/translator.c                        |  2 +-
 accel/tcg/user-exec.c                         | 23 ++---
 target/alpha/cpu.c                            |  4 +
 target/alpha/mem_helper.c                     |  2 +-
 target/arm/cpu.c                              |  4 +
 target/arm/tcg/cpu-v7m.c                      |  4 +
 target/arm/tcg/helper-a64.c                   |  2 +-
 target/arm/tcg/m_helper.c                     |  2 +-
 target/arm/tcg/mte_helper.c                   |  2 +-
 target/arm/tcg/mve_helper.c                   |  2 +-
 target/arm/tcg/op_helper.c                    |  2 +-
 target/arm/tcg/pauth_helper.c                 |  2 +-
 target/arm/tcg/sme_helper.c                   |  2 +-
 target/arm/tcg/sve_helper.c                   |  1 +
 target/avr/cpu.c                              |  2 +
 target/avr/helper.c                           |  2 +-
 target/hexagon/cpu.c                          |  3 +
 target/hexagon/op_helper.c                    |  2 +-
 target/hexagon/translate.c                    |  2 +-
 target/hppa/cpu.c                             |  9 ++
 target/hppa/op_helper.c                       |  2 +-
 target/i386/tcg/access.c                      |  2 +-
 target/i386/tcg/fpu_helper.c                  |  2 +-
 target/i386/tcg/mem_helper.c                  |  2 +-
 target/i386/tcg/mpx_helper.c                  |  2 +-
 target/i386/tcg/seg_helper.c                  |  2 +-
 target/i386/tcg/system/excp_helper.c          |  2 +-
 target/i386/tcg/system/misc_helper.c          |  2 +-
 target/i386/tcg/system/seg_helper.c           |  2 +-
 target/i386/tcg/system/svm_helper.c           |  2 +-
 target/i386/tcg/tcg-cpu.c                     |  5 ++
 target/i386/tcg/user/seg_helper.c             |  2 +-
 target/loongarch/cpu.c                        |  5 +-
 target/loongarch/tcg/csr_helper.c             |  2 +-
 target/loongarch/tcg/fpu_helper.c             |  2 +-
 target/loongarch/tcg/iocsr_helper.c           |  2 +-
 target/loongarch/tcg/op_helper.c              |  2 +-
 target/loongarch/tcg/tlb_helper.c             |  2 +-
 target/m68k/cpu.c                             |  4 +
 target/m68k/fpu_helper.c                      |  2 +-
 target/m68k/op_helper.c                       |  2 +-
 target/microblaze/cpu.c                       |  6 +-
 target/microblaze/op_helper.c                 |  2 +-
 target/microblaze/translate.c                 |  2 +-
 target/mips/cpu.c                             |  3 +
 target/mips/tcg/ldst_helper.c                 |  2 +-
 target/mips/tcg/msa_helper.c                  |  2 +-
 target/mips/tcg/system/tlb_helper.c           |  2 +-
 target/openrisc/cpu.c                         |  3 +
 target/ppc/cpu_init.c                         |  2 +
 target/ppc/mem_helper.c                       |  2 +-
 target/ppc/mmu_helper.c                       |  2 +-
 target/ppc/tcg-excp_helper.c                  |  2 +-
 target/riscv/cpu.c                            | 10 +--
 target/riscv/op_helper.c                      |  2 +-
 target/riscv/tcg/tcg-cpu.c                    |  9 +-
 target/riscv/vector_helper.c                  |  2 +-
 target/riscv/zce_helper.c                     |  2 +-
 target/rx/cpu.c                               |  4 +
 target/rx/helper.c                            |  2 +-
 target/rx/op_helper.c                         |  2 +-
 target/s390x/cpu.c                            |  7 ++
 target/s390x/tcg/crypto_helper.c              |  2 +-
 target/s390x/tcg/int_helper.c                 |  2 +-
 target/s390x/tcg/mem_helper.c                 |  2 +-
 target/s390x/tcg/misc_helper.c                |  2 +-
 target/s390x/tcg/vec_helper.c                 |  2 +-
 target/sh4/cpu.c                              |  4 +
 target/sh4/op_helper.c                        |  2 +-
 target/sparc/cpu.c                            | 24 ++++++
 target/sparc/int32_helper.c                   |  2 +-
 target/sparc/ldst_helper.c                    |  2 +-
 target/tricore/cpu.c                          |  3 +
 target/tricore/op_helper.c                    |  2 +-
 target/tricore/translate.c                    |  2 +-
 target/xtensa/cpu.c                           |  4 +
 tcg/region.c                                  |  4 +-
 146 files changed, 357 insertions(+), 294 deletions(-)
 create mode 100644 accel/tcg/backend-ldst.h
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)
 rename include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} (99%)

-- 
2.47.1


