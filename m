Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E6FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsP-0007RN-9z; Fri, 07 Mar 2025 13:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsN-0007Qa-1D
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:51 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsL-0007kv-1W
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:50 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so1380656a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373807; x=1741978607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2S1HL/uh8HJg/YkrhsXfs/r9NeCmk67SG0CfqhKI+fA=;
 b=IbCpEvh++VMlJgmqddhzobnwkjovM4aZYpaGuqyncZidSg7W/F6eao4TeMWrZfR2H9
 iuoQjnq02wpNmSMeStyQA27t8YhB74KpxNQBlIzl83M7iBZZ4I8EcSGFP6rnldoNVNGT
 WBrWqgKvLzJh5C7aG/wZT978svnqmvvLxR1R9m+8yNsnEACjdnkZdaBdqCqcT3IDwze4
 iekg3KwVi3DeBwnFLTjiLuPYfo/LcazFJkHmkk4iy+ulqPo+e2RwFxx+B8MsL8N8jVoD
 P21Da4s98jY8oluRTYhirptFRXg/Md3EvEEZEw/KqW82uNAjQVAQIqcF8pyR1V5ipFEI
 p+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373807; x=1741978607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2S1HL/uh8HJg/YkrhsXfs/r9NeCmk67SG0CfqhKI+fA=;
 b=qqNvrfLX9U90G1fL9hq2255EGMmT8ZP4iX4TJ3DDv87DLR17fIEr9yVjSqibtMAKgI
 C/TOdZiA+LIuV4UvO//ZMDcs5ONcAyVxZQIujVbhP/EgHfUcddq7EyV/oeg4o6V7JYQf
 riGxNwPsFuYXLwdEvPp2IPWIjhEakG1f9szACeriMq3YLyYAJsNe1goBfoKqz8wxpYep
 1/fsy5MfAQHNogqfiJ/MaAK+PagFqPk5kbAN/iXD49CaFQiqeMF3DK9pmsT5EkrPFvgj
 T3LX9+CIt6cwNhZ++zWdzD1AUK1pVnfsAJJMcNs/WXHf5HtwJVyI26GOOb9ygenxG9WR
 ll2Q==
X-Gm-Message-State: AOJu0YxYpe9HqSompCHScNgwfsvO4hKSZGcOX22Dfnk7NtgX4Gua7tEP
 8bdSLcxmRPvtKGz0YOQGSlukBMTAsT0TrX5WUZ0VIj8a09i9mK2sHOY35nKd7pTrJauk+V0QdaI
 U
X-Gm-Gg: ASbGncudb6yuOSHWcAYpG0US7ANyfpoN0DLChnPqLnsD5OWLOpZT/npCtYpwdY/8HF/
 1jjb+5OAwCyZtw6rNkkQx76qRs3mITSQF7VkxRatZohUK8vra+X5eMNu1dM4hPy4J8CK+CzSmzM
 aZHfD4egKeleNLPzzMH3RUHqSDqLg7EPKkHNcncflSHiX9M/QV2PR8r2VqV4w14pYG6gyZyGnYT
 GOh+HyTrOr2m88Y2jeWa7lcH/QSwWBb2NggQls2KqSATfFHKlLSYrTAp1+YhsNDQEUcWKBafGM0
 hKFoheH8RuJEcICdcGaBaYhRq2GKGi6SRQeKgIqI6GYQupfCsAeS2ZpdcLcE69HT4lCXi+/l/7C
 K
X-Google-Smtp-Source: AGHT+IFUzMtEFm25y8Fe3nsa/NK/akH20Q5B0kyWy9lpoqJDO626uDeOmFWmDbKv1ulA4z7d8vuG0A==
X-Received: by 2002:a17:90b:4cc5:b0:2ff:71d2:ee8f with SMTP id
 98e67ed59e1d1-2ffbc1c8aa0mr1001164a91.13.1741373807316; 
 Fri, 07 Mar 2025 10:56:47 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 00/16] accel/tcg: Compile more files once
Date: Fri,  7 Mar 2025 10:56:28 -0800
Message-ID: <20250307185645.970034-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Take care of some easy cases in accel/tcg/.
From here it starts getting harder.  :-)


r~


Philippe Mathieu-Daudé (6):
  exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
  exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
  exec: Declare tlb_set_page_with_attrs() in 'exec/cputlb.h'
  exec: Declare tlb_set_page() in 'exec/cputlb.h'
  exec: Declare tlb_hit*() in 'exec/cputlb.h'
  exec: Declare tlb_flush*() in 'exec/cputlb.h'

Richard Henderson (10):
  include/exec: Split out exec/cpu-interrupt.h
  accel/tcg: Compile watchpoint.c once
  system: Build watchpoint.c once
  accel/tcg: Build tcg-accel-ops.c once
  accel/tcg: Build tcg-accel-ops-icount.c once
  accel/tcg: Build tcg-accel-ops-rr.c once
  accel/tcg: Build tcg-accel-ops-mttcg.c once
  include/exec: Split out helper-getpc.h
  accel/tcg: Build tcg-runtime.c once
  accel/tcg: Build tcg-runtime-gvec.c once

 accel/tcg/internal-common.h          |   2 +
 accel/tcg/tb-internal.h              |   2 -
 include/exec/cpu-all.h               |  76 +-------
 include/exec/cpu-interrupt.h         |  70 +++++++
 include/exec/cputlb.h                | 263 ++++++++++++++++++++++++++-
 include/exec/exec-all.h              | 262 +-------------------------
 include/exec/helper-getpc.h          |  31 ++++
 include/exec/poison.h                |  13 --
 include/exec/ram_addr.h              |   1 +
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
 67 files changed, 450 insertions(+), 405 deletions(-)
 create mode 100644 include/exec/cpu-interrupt.h
 create mode 100644 include/exec/helper-getpc.h

-- 
2.43.0


