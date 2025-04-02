Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8104C3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05YY-0007Kf-Ex; Wed, 02 Apr 2025 17:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05YU-0007G3-8F
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05YR-00043E-SS
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so176109f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629002; x=1744233802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TNclyoVTZj9QWCFqpem/jWtZmcUyuZfS4wDD9Dv6W+U=;
 b=f47uX3eECA/I8EeiCNNwMHvWqj++dRs9hTmtfdK+PBQieTKvSsho2MlUDh9VIpzzZH
 NN+E1pPsPMq9ZndM4tfsSJ+h/ki2stSYkox+5tDV5Ew47eWW+Os7ycp17RTNSeznnwtF
 fMm6dFOfrfEcySFqT20eBDlZo0hRt0ot9EJ/PFcSbDqvrW6/GTskrt2j2RWfv9XMEazN
 wqXRAzdoNKpntwNgG7JCXottBLpMvcrwmDQxpD+JWJMm1B/YlwVCZ35Yh2q7YXLsupoU
 D5h/i+fzHrT/h4Yi4GuMV+bDbddEC5z1t3wab83N3H+a7zhzZ8RrmXpVhyRmb9jhR/b9
 L8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629002; x=1744233802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TNclyoVTZj9QWCFqpem/jWtZmcUyuZfS4wDD9Dv6W+U=;
 b=XsATmm2FtL2xWtuSQaKLhLCC9loAJr3/SLByr0s7mvgmoy0I9DNuZU8TV2/9+Qx2tV
 hfhItoPdRZVtLLGPGZrSqLkcnLTd3ZU3rBXqOSuGScZeyEe3z8Q51noM2cpkZhhGIStN
 1qmvfTykbUKCD59O9phgpo6BF+k7LyLblA2onZS8UmJrkL2ZwK4m1iB0/8DyiPWDfHWS
 OJn5bpCh4uDga8hrU+leClHJy2bu8+ULlGYE5/EhFJsRYSp1KmHCQZst60nXLQsnBir3
 aRpx99r/NJJFKafmZw/ShzvKf7t449MoFExnxzl/sRINZq5y/6/q5wizfjPTRlLmXczU
 w4fg==
X-Gm-Message-State: AOJu0YzCrOmyfXB5/Vw4/lpbn7WiRkNvL6EMLkPV5GI9dIeIUKe2jiuu
 +994ZAnQoPaIk85xqLRCWev/OkJ1Ct8RdOfyL404DMuRSRciew0bK70BNp4f1hTwY8C6whjcgZZ
 k
X-Gm-Gg: ASbGncuUGSszDzatD6knILKN0G8XEtAU40Cv2iP7Na2fjEguTR3OocXdBFiG7xDZPUn
 6RIXLt3gN27rwUKuovao6fFYxuMFViSPiBpe1KbxDg+6Z4Ps+shdJKb4Q3iNA0gn5xrVHWydo1/
 YRHcRU95bIV0hbBMQn5qa7bhLak3TRTaA0QFcAGFl5FV3mgFyYE4DvRhi0WQykU9UxcNXdSydW/
 0RrRzGKlKb9TfzBGhMmoE0iyMrPUaMErbVbYqqbdS61Hqe8nB+iB9SeU/PSjopfVlblbVmPzh4V
 IfIzqGX+dXvN23EHvRpPUMYwVs5xjT7Q0PzAx3BMCleRDv06PRLf/W/PECAS4U2ecGOmiCItwqw
 WqPMtQWQ0sZR/9Qc8fTw=
X-Google-Smtp-Source: AGHT+IGqwljrCsjbCm2LNMyPRzefNO1a/3gZ8CvhCC3atxd1skHNiT6/v5O3BqEc3ooniFH8h0qhBw==
X-Received: by 2002:a5d:59a9:0:b0:397:8f09:600 with SMTP id
 ffacd0b85a97d-39c120dc885mr15742525f8f.13.1743629001810; 
 Wed, 02 Apr 2025 14:23:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a96dsm17725934f8f.44.2025.04.02.14.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:23:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v2 00/43] tcg: philmd's queue
Date: Wed,  2 Apr 2025 23:23:13 +0200
Message-ID: <20250402212319.58349-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Here is my patch queue based on your tcg-next tree.

Missing review: 38, 41, 43 (all news)

Thanks,

Phil.

Since v1:
- Deferred warning change and updated desc (patches 40 & 42)

(skipping patches 1-37 because identical of v1:
https://lore.kernel.org/qemu-devel/20250402210328.52897-1-philmd@linaro.org/)

Philippe Mathieu-Daudé (43):
  tcg: Declare TARGET_INSN_START_EXTRA_WORDS in 'cpu-param.h'
  tcg: Always define TARGET_INSN_START_EXTRA_WORDS
  hw/core/cpu: Update CPUClass::mmu_index docstring
  accel/tcg: Introduce TCGCPUOps::mmu_index() callback
  target/alpha: Restrict SoftMMU mmu_index() to TCG
  target/arm: Restrict SoftMMU mmu_index() to TCG
  target/avr: Restrict SoftMMU mmu_index() to TCG
  target/hppa: Restrict SoftMMU mmu_index() to TCG
  target/i386: Remove unused cpu_(ldub,stb)_kernel macros
  target/i386: Restrict cpu_mmu_index_kernel() to TCG
  target/i386: Restrict SoftMMU mmu_index() to TCG
  target/loongarch: Restrict SoftMMU mmu_index() to TCG
  target/m68k: Restrict SoftMMU mmu_index() to TCG
  target/microblaze: Restrict SoftMMU mmu_index() to TCG
  target/mips: Restrict SoftMMU mmu_index() to TCG
  target/openrisc: Restrict SoftMMU mmu_index() to TCG
  target/ppc: Restrict SoftMMU mmu_index() to TCG
  target/riscv: Restrict SoftMMU mmu_index() to TCG
  target/rx: Fix copy/paste typo (riscv -> rx)
  target/rx: Restrict SoftMMU mmu_index() to TCG
  target/s390x: Restrict SoftMMU mmu_index() to TCG
  target/sh4: Restrict SoftMMU mmu_index() to TCG
  target/sparc: Restrict SoftMMU mmu_index() to TCG
  target/tricore: Restrict SoftMMU mmu_index() to TCG
  target/xtensa: Restrict SoftMMU mmu_index() to TCG
  hw/core/cpu: Remove CPUClass::mmu_index()
  exec: Restrict cpu-mmu-index.h to accel/tcg/
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
  target/arm: Update comment around cpu_untagged_addr()

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
 accel/tcg/internal-common.h                   | 27 ++++++
 accel/tcg/internal-target.h                   | 35 --------
 bsd-user/qemu.h                               |  2 +-
 include/{exec => accel/tcg}/cpu-ldst-common.h |  6 +-
 .../{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} | 10 +--
 include/{exec => accel/tcg}/cpu-mmu-index.h   |  9 +-
 include/accel/tcg/cpu-ops.h                   | 19 +++++
 include/exec/exec-all.h                       |  3 -
 include/exec/poison.h                         |  1 -
 include/hw/core/cpu.h                         | 12 ---
 include/system/tcg.h                          |  8 ++
 include/tcg/insn-start-words.h                |  4 -
 include/tcg/tcg-op.h                          |  2 +-
 linux-user/qemu.h                             |  2 +-
 target/alpha/cpu-param.h                      |  3 +-
 target/arm/cpu-param.h                        |  8 +-
 target/arm/cpu.h                              |  8 +-
 target/arm/internals.h                        |  1 +
 target/arm/tcg/sve_ldst_internal.h            |  2 +-
 target/avr/cpu-param.h                        |  2 +-
 target/hexagon/cpu-param.h                    |  2 +
 target/hppa/cpu-param.h                       |  8 +-
 target/hppa/cpu.h                             |  2 -
 target/i386/cpu-param.h                       |  3 +-
 target/i386/cpu.h                             |  5 --
 target/i386/tcg/seg_helper.h                  | 10 +--
 target/i386/tcg/tcg-cpu.h                     |  2 +
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
 accel/tcg/cpu-exec.c                          |  2 +
 accel/tcg/cputlb.c                            | 23 ++---
 accel/tcg/tcg-all.c                           | 84 +++++++++++--------
 accel/tcg/translate-all.c                     |  6 +-
 accel/tcg/translator.c                        |  4 +-
 accel/tcg/user-exec.c                         | 23 ++---
 semihosting/uaccess.c                         |  2 +-
 target/alpha/cpu.c                            |  6 +-
 target/alpha/mem_helper.c                     |  2 +-
 target/arm/cpu.c                              | 17 ++--
 target/arm/gdbstub64.c                        |  2 +-
 target/arm/tcg/cpu-v7m.c                      |  5 ++
 target/arm/tcg/helper-a64.c                   |  2 +-
 target/arm/tcg/m_helper.c                     |  2 +-
 target/arm/tcg/mte_helper.c                   |  2 +-
 target/arm/tcg/mve_helper.c                   |  2 +-
 target/arm/tcg/op_helper.c                    |  2 +-
 target/arm/tcg/pauth_helper.c                 |  2 +-
 target/arm/tcg/sme_helper.c                   |  2 +-
 target/arm/tcg/sve_helper.c                   |  1 +
 target/avr/cpu.c                              |  4 +-
 target/avr/helper.c                           |  2 +-
 target/hexagon/cpu.c                          |  3 +
 target/hexagon/op_helper.c                    |  2 +-
 target/hexagon/translate.c                    |  2 +-
 target/hppa/cpu.c                             | 11 ++-
 target/hppa/mem_helper.c                      |  2 +-
 target/hppa/op_helper.c                       |  2 +-
 target/i386/cpu.c                             | 34 --------
 target/i386/tcg/access.c                      |  2 +-
 target/i386/tcg/fpu_helper.c                  |  2 +-
 target/i386/tcg/mem_helper.c                  |  2 +-
 target/i386/tcg/mpx_helper.c                  |  2 +-
 target/i386/tcg/seg_helper.c                  | 19 ++++-
 target/i386/tcg/system/excp_helper.c          |  2 +-
 target/i386/tcg/system/misc_helper.c          |  2 +-
 target/i386/tcg/system/seg_helper.c           |  2 +-
 target/i386/tcg/system/svm_helper.c           |  2 +-
 target/i386/tcg/tcg-cpu.c                     | 23 +++++
 target/i386/tcg/translate.c                   |  2 +-
 target/i386/tcg/user/seg_helper.c             |  2 +-
 target/loongarch/cpu.c                        |  7 +-
 target/loongarch/cpu_helper.c                 |  2 +-
 target/loongarch/tcg/csr_helper.c             |  2 +-
 target/loongarch/tcg/fpu_helper.c             |  2 +-
 target/loongarch/tcg/iocsr_helper.c           |  2 +-
 target/loongarch/tcg/op_helper.c              |  2 +-
 target/loongarch/tcg/tlb_helper.c             |  2 +-
 target/m68k/cpu.c                             |  6 +-
 target/m68k/fpu_helper.c                      |  2 +-
 target/m68k/op_helper.c                       |  2 +-
 target/microblaze/cpu.c                       |  8 +-
 target/microblaze/helper.c                    |  2 +-
 target/microblaze/mmu.c                       |  2 +-
 target/microblaze/op_helper.c                 |  2 +-
 target/microblaze/translate.c                 |  2 +-
 target/mips/cpu.c                             |  5 +-
 target/mips/tcg/ldst_helper.c                 |  2 +-
 target/mips/tcg/msa_helper.c                  |  2 +-
 target/mips/tcg/system/tlb_helper.c           |  2 +-
 target/openrisc/cpu.c                         |  5 +-
 target/openrisc/translate.c                   |  2 +-
 target/ppc/cpu_init.c                         |  5 +-
 target/ppc/mem_helper.c                       |  2 +-
 target/ppc/mmu_helper.c                       |  2 +-
 target/ppc/tcg-excp_helper.c                  |  2 +-
 target/riscv/cpu.c                            |  6 --
 target/riscv/op_helper.c                      |  2 +-
 target/riscv/tcg/tcg-cpu.c                    | 10 +++
 target/riscv/vector_helper.c                  |  2 +-
 target/riscv/zce_helper.c                     |  2 +-
 target/rx/cpu.c                               |  8 +-
 target/rx/helper.c                            |  2 +-
 target/rx/op_helper.c                         |  2 +-
 target/s390x/cpu.c                            |  9 +-
 target/s390x/tcg/crypto_helper.c              |  2 +-
 target/s390x/tcg/int_helper.c                 |  2 +-
 target/s390x/tcg/mem_helper.c                 |  2 +-
 target/s390x/tcg/misc_helper.c                |  2 +-
 target/s390x/tcg/vec_helper.c                 |  2 +-
 target/sh4/cpu.c                              |  6 +-
 target/sh4/op_helper.c                        |  2 +-
 target/sparc/cpu.c                            | 28 ++++++-
 target/sparc/int32_helper.c                   |  2 +-
 target/sparc/ldst_helper.c                    |  2 +-
 target/sparc/mmu_helper.c                     |  2 +-
 target/tricore/cpu.c                          |  5 +-
 target/tricore/helper.c                       |  2 +-
 target/tricore/op_helper.c                    |  2 +-
 target/tricore/translate.c                    |  2 +-
 target/xtensa/cpu.c                           |  6 +-
 target/xtensa/mmu_helper.c                    |  2 +-
 tcg/region.c                                  |  4 +-
 163 files changed, 472 insertions(+), 378 deletions(-)
 create mode 100644 accel/tcg/backend-ldst.h
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)
 rename include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} (99%)
 rename include/{exec => accel/tcg}/cpu-mmu-index.h (78%)

-- 
2.47.1


