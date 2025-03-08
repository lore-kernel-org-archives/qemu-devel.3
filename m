Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CC6C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqoXW-0001NW-Pw; Sat, 08 Mar 2025 02:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXP-0001Mx-23
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:23:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXL-0008K2-7o
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:23:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so20064595e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741418632; x=1742023432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8dbzpI2JdNfY9UXOT6YyYMBbVlgCVS6StPo6Zu5kvgg=;
 b=bRLRuaDWLkxY3pL2usR6BdsYEE2qutaaosaTtuCEmZ7cxFpagTa4MozliHs3WnjQBH
 1MEGMT5e0P10jKmcPhJqv8BXKHG9ELXi5M5O9FRj75+qNSEYlLGGaedZy3Nme3msSNjp
 j80tRTIGZel4WgQd2tYXYA5wpEfp69jHvESDqkTRb9ViBQ/A8eHuVEIwDbzG4Hqj9HjE
 lQ4QPB23TjwASh0EKYqeABtmunu6iweGwUlo5J8NofR1fBRnsrduJhIL2p4OzTd+bLiT
 pm0qLDzLhvR+RutdAzFK1d+DxhX2zs4EmlKdNFK79It+Cb/rUPZLnbI1yHYkOuUZxL+n
 2GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741418632; x=1742023432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dbzpI2JdNfY9UXOT6YyYMBbVlgCVS6StPo6Zu5kvgg=;
 b=Iel1hQ4lBNUFl8ufNwN2PfyPDPybiJQEePATzdXXhXF27AcNvgTKgrdPHIrS1bZLFo
 AmzzH0Jw77s3eewHK92DFcfa22YPeakJwpBaQDmCuQ7YvZgLZgl4ruhjEWAjhceE2NN4
 4QOdtawXGP0mvVmBSGPq9m1DefYrs3PuNmq3aYBRpLTMxB4MM47S3zjKsvP6k+Zn+ivA
 M4dL6xuJSwBMLAP00WEd8xJoit4/5oRIBjrIlLfD2oU31X43Ngt0XVs197d6jcpO5Jk6
 96rzBG/R38oAk16n22v5eZ6THug6CPxIdwMs8i8hvy+w/gdYpV70ZtSvbQFV1i0YcrlE
 w1gg==
X-Gm-Message-State: AOJu0Yz2x16FTJvKZRt2KDeM/HFVJayo51dzcl1WlIX02d+FEO1nTLjA
 lGTNBw6cFVW+GUHo31dAP9U9k0KblV5e8JNvNLB7kJWhHXZjUjzBa3xEoOwScRB5U7906H6PJic
 cmoQ=
X-Gm-Gg: ASbGncuVPAvakAdxMfsg6x+2ZFYALuJ3O/rwZPdqYG9+7fEayw2yZdsXKZ0hmPA6b+C
 KvHt8zujVUsxREqGTGJNkrm5IAFKkcrz7sWceqUp66QIPxVltc9wE0B0oDAtTe2Z3zI+wDcBOKe
 LO5x22Gz+pAPvPR8VNh/p77L//yjxs3yzbvBEWCxfyxfqM7UIds3/TFxJJkT7q9LSqiwP3Vkv/b
 FvF6ztqRiS3hjGiDfqbGrxp9yOWUAL+GoTSpLn1BCS+0OYVRcpSPSK67THbRpLimgjqmBskG5Fg
 iCQqsqU86a2gyRY0hwNGUt1GwZA9hICDZJcVVub0C+mfKxNk6F1Qs9bd3nevrAjcxJ9arWKqAoW
 HlEkDK3qddryfSoKUFxmSUdkaRAGAuQ==
X-Google-Smtp-Source: AGHT+IGTNCiLQ5612TPc8gFirc9DF3ZU7xSJyzEKNSSE0fF4Qm9PYgvIVq+q6tN47UsNRINqLCoyTw==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43c549dcc0amr47769875e9.0.1741418631612; 
 Fri, 07 Mar 2025 23:23:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103290sm7720467f8f.87.2025.03.07.23.23.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 23:23:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/18] accel/tcg: Compile more files once
Date: Sat,  8 Mar 2025 08:23:45 +0100
Message-ID: <20250308072348.65723-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Since v1:
- Patches 1-13,16 unmodified
- Restrict GETPC_ADJ()
- Rename accel/tcg/getpc.h
- Guard GETPC() within CONFIG_TCG

Take care of some easy cases in accel/tcg/.
From here it starts getting harder.  🙂

Philippe Mathieu-Daudé (7):
  exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
  exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
  exec: Declare tlb_set_page_with_attrs() in 'exec/cputlb.h'
  exec: Declare tlb_set_page() in 'exec/cputlb.h'
  exec: Declare tlb_hit*() in 'exec/cputlb.h'
  exec: Declare tlb_flush*() in 'exec/cputlb.h'
  accel/tcg: Restrict GETPC_ADJ() to 'tb-internal.h'

Richard Henderson (11):
  include/exec: Move TARGET_PAGE_{SIZE,MASK,BITS} to target_page.h
  include/exec: Split out exec/cpu-interrupt.h
  accel/tcg: Compile watchpoint.c once
  system: Build watchpoint.c once
  accel/tcg: Build tcg-accel-ops.c once
  accel/tcg: Build tcg-accel-ops-icount.c once
  accel/tcg: Build tcg-accel-ops-rr.c once
  accel/tcg: Build tcg-accel-ops-mttcg.c once
  accel/tcg: Split out getpc.h
  accel/tcg: Build tcg-runtime.c once
  accel/tcg: Build tcg-runtime-gvec.c once

 accel/tcg/internal-common.h          |   2 +
 accel/tcg/tb-internal.h              |  13 +-
 include/accel/tcg/getpc.h            |  24 +++
 include/exec/cpu-all.h               |  97 +---------
 include/exec/cpu-interrupt.h         |  70 +++++++
 include/exec/cputlb.h                | 263 ++++++++++++++++++++++++++-
 include/exec/exec-all.h              | 263 +--------------------------
 include/exec/poison.h                |  17 --
 include/exec/ram_addr.h              |   1 +
 include/exec/target_page.h           |  58 +++++-
 accel/tcg/cputlb.c                   |  23 +++
 accel/tcg/tcg-accel-ops-icount.c     |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c      |   1 -
 accel/tcg/tcg-accel-ops-rr.c         |   2 +-
 accel/tcg/tcg-accel-ops.c            |   2 +-
 accel/tcg/tcg-runtime-gvec.c         |   1 -
 accel/tcg/tcg-runtime.c              |   8 +-
 accel/tcg/watchpoint.c               |   5 +-
 cpu-target.c                         |   1 +
 hw/intc/armv7m_nvic.c                |   2 +-
 hw/ppc/spapr_nested.c                |   1 +
 hw/sh4/sh7750.c                      |   1 +
 page-target.c                        |  18 --
 page-vary-target.c                   |   2 -
 system/physmem.c                     |   1 +
 system/watchpoint.c                  |   3 +-
 target/alpha/helper.c                |   2 +-
 target/alpha/sys_helper.c            |   2 +-
 target/arm/helper.c                  |   1 +
 target/arm/tcg/tlb-insns.c           |   2 +-
 target/avr/helper.c                  |   2 +-
 target/hppa/mem_helper.c             |   1 +
 target/i386/helper.c                 |   2 +-
 target/i386/machine.c                |   2 +-
 target/i386/tcg/fpu_helper.c         |   2 +-
 target/i386/tcg/misc_helper.c        |   2 +-
 target/i386/tcg/system/excp_helper.c |   2 +-
 target/i386/tcg/system/misc_helper.c |   2 +-
 target/i386/tcg/system/svm_helper.c  |   2 +-
 target/loongarch/tcg/csr_helper.c    |   2 +-
 target/loongarch/tcg/tlb_helper.c    |   1 +
 target/m68k/helper.c                 |   1 +
 target/microblaze/helper.c           |   2 +-
 target/microblaze/mmu.c              |   2 +-
 target/mips/system/cp0.c             |   2 +-
 target/mips/tcg/system/cp0_helper.c  |   2 +-
 target/mips/tcg/system/tlb_helper.c  |   1 +
 target/openrisc/mmu.c                |   2 +-
 target/openrisc/sys_helper.c         |   1 +
 target/ppc/helper_regs.c             |   2 +-
 target/ppc/misc_helper.c             |   1 +
 target/ppc/mmu_helper.c              |   1 +
 target/riscv/cpu_helper.c            |   1 +
 target/riscv/csr.c                   |   1 +
 target/riscv/op_helper.c             |   1 +
 target/riscv/pmp.c                   |   2 +-
 target/rx/cpu.c                      |   2 +-
 target/s390x/gdbstub.c               |   2 +-
 target/s390x/sigp.c                  |   1 +
 target/s390x/tcg/excp_helper.c       |   1 +
 target/s390x/tcg/mem_helper.c        |   1 +
 target/s390x/tcg/misc_helper.c       |   1 +
 target/sh4/helper.c                  |   1 +
 target/sparc/ldst_helper.c           |   1 +
 target/sparc/mmu_helper.c            |   2 +-
 target/tricore/helper.c              |   2 +-
 target/xtensa/helper.c               |   2 +-
 target/xtensa/mmu_helper.c           |   1 +
 accel/tcg/meson.build                |  14 +-
 system/meson.build                   |   2 +-
 70 files changed, 508 insertions(+), 455 deletions(-)
 create mode 100644 include/accel/tcg/getpc.h
 create mode 100644 include/exec/cpu-interrupt.h

-- 
2.47.1


