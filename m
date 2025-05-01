Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5448C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLr-000138-B9; Thu, 01 May 2025 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLi-0000v2-7r
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:42 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLc-0001Wg-ER
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30820167b47so1484328a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134495; x=1746739295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZxdsuk2tjSm8+6tPF1Vj9VTRnXgE0dDbo5Gk3+nWRQ=;
 b=r1QRrHsIaWQCXg0cxfKo6pWB6DtKeQJp1SSmnSkLk8XxXuZ+hVZB9wQYfmEXa66ybM
 FPgQ9XAFqzLloFv9w3GuRv9M1BVwIqvJD5sc8nAt50uuzk/iM8TaI2wgyQ8K94rmRBnM
 TuyHgy732SNMhOJgGypC98iQ2HQ/fiCi/Qi7AHRd5g54nd+18rz4eBfUxjYjvWWgP7H3
 NEfZKc/Tg1nrlEYKaHteBonciAZ6XFK5m9MfDAQ/QmU0cUb+3UXZAz6/fiQzLacTDMyY
 KFpjz1md2TMiU4jbHesj3XkJzO0E3FpxAeWNcXz4ldTq3m7xhVnfF9WxxyEzvQHkOA/p
 9j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134495; x=1746739295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZxdsuk2tjSm8+6tPF1Vj9VTRnXgE0dDbo5Gk3+nWRQ=;
 b=QGtb+5k7cL6JB/8RtepCSqiXaXpMn7HMTOawbHv1L4E/EUANt90Olj84t4j/CAYJks
 BunMSIMhtvvfU1yBC2Uwm72pDqJJrW6riDXc66rA6E42FwXx3zz05ZUKNuiV84g6ASRC
 34wngv1T0exa0MkRYiS+/0K/b8fkKfe5aGlAWsyi4IAyi4Z6vpa/t0eNOAwt/fiO/6im
 IYpeEpOGsLxyITJSVLqYDkYGpwz//zh4VFA6ZWEvjyughKlZqfXsrxR+qNPAONgQIdaV
 iR0f4IYDnpFuxPuNTCShVP00DLZFzu6KzNyD5houObMjFSa4PKP3nAu+CChcDFz6vqn3
 y0Kg==
X-Gm-Message-State: AOJu0Yz1gZJe0FMV+4Kq8LJNCDzEad2OpNE9hB/yge+5GFdrgNvW/Unc
 sCbHIcw9zRHoJHiuB7e6NXYi9bvYU1gFWBT9eQszjOj74kKPegqSq/DsbnyLNkNJLhmLdH6tqP8
 N
X-Gm-Gg: ASbGncuM2s1Xo/0QHbD/hp1xxDxlJ8TtIQaVkwHjtSMDkTH7J0PloRfB39Cz1LXyBcb
 6AT3i9LzjpVGKdzESeYYOaCQ/ss4nYFqUUcXSqmM43dHDg72WRLmjCDqinlOGVjsJTxSRevbWGK
 88TV1zbjWDQ/kfTYhgLS6B/sp4frstfeji1+IRc2/CsFvRBNbLHq1RptV//Y2eAdle4DIvPAKkm
 pyP6k9c9GwSbY/gYFhREmmhuqEqI98rHpfP605AA2qt0cuzfYLSdnbXKJZGyQsjj2YID+CjPl+a
 gU0yYt501J/M0RuvkEEVW1syz/HEB40n+2k6GTALm9dNeAfNdscOORKxsNQkJCud47FkoVjQVBw
 =
X-Google-Smtp-Source: AGHT+IFPHOgMAV0RD6EORJhbMYWNELJ66i5932ZxzSVy9f/Nqy47StM/1LEHkl6lcg0414oj626TdQ==
X-Received: by 2002:a17:90b:4ec3:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-30a42e52f4fmr5406854a91.3.1746134494495; 
 Thu, 01 May 2025 14:21:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 23/59] include: Remove 'exec/exec-all.h'
Date: Thu,  1 May 2025 14:20:37 -0700
Message-ID: <20250501212113.2961531-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"exec/exec-all.h" is now fully empty, let's remove it.

Mechanical change running:

  $ sed -i '/exec\/exec-all.h/d' $(git grep -wl exec/exec-all.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-14-philmd@linaro.org>
---
 bsd-user/qemu.h                         |  1 -
 include/exec/exec-all.h                 | 23 -----------------------
 include/system/ram_addr.h               |  1 -
 linux-user/user-internals.h             |  1 -
 target/arm/tcg/translate.h              |  1 -
 target/i386/tcg/helper-tcg.h            |  1 -
 accel/hvf/hvf-accel-ops.c               |  1 -
 accel/tcg/cputlb.c                      |  1 -
 accel/tcg/translate-all.c               |  1 -
 accel/tcg/user-exec.c                   |  1 -
 bsd-user/main.c                         |  1 -
 hw/ppc/spapr_nested.c                   |  1 -
 hw/riscv/riscv-iommu-sys.c              |  1 -
 hw/sh4/sh7750.c                         |  1 -
 linux-user/main.c                       |  1 -
 semihosting/uaccess.c                   |  1 -
 system/physmem.c                        |  1 -
 target/alpha/cpu.c                      |  1 -
 target/alpha/fpu_helper.c               |  1 -
 target/alpha/int_helper.c               |  1 -
 target/alpha/mem_helper.c               |  1 -
 target/alpha/translate.c                |  1 -
 target/alpha/vax_helper.c               |  1 -
 target/arm/cpu.c                        |  1 -
 target/arm/debug_helper.c               |  1 -
 target/arm/helper.c                     |  1 -
 target/arm/ptw.c                        |  1 -
 target/arm/tcg/helper-a64.c             |  1 -
 target/arm/tcg/m_helper.c               |  1 -
 target/arm/tcg/mte_helper.c             |  1 -
 target/arm/tcg/mve_helper.c             |  1 -
 target/arm/tcg/op_helper.c              |  1 -
 target/arm/tcg/pauth_helper.c           |  1 -
 target/arm/tcg/sme_helper.c             |  1 -
 target/arm/tcg/sve_helper.c             |  1 -
 target/arm/tcg/tlb_helper.c             |  1 -
 target/arm/tcg/translate-a64.c          |  1 -
 target/avr/cpu.c                        |  1 -
 target/avr/translate.c                  |  1 -
 target/hexagon/cpu.c                    |  1 -
 target/hexagon/op_helper.c              |  1 -
 target/hppa/cpu.c                       |  1 -
 target/hppa/fpu_helper.c                |  1 -
 target/hppa/helper.c                    |  1 -
 target/hppa/mem_helper.c                |  1 -
 target/hppa/op_helper.c                 |  1 -
 target/hppa/sys_helper.c                |  1 -
 target/hppa/translate.c                 |  1 -
 target/i386/tcg/access.c                |  1 -
 target/i386/tcg/excp_helper.c           |  1 -
 target/i386/tcg/int_helper.c            |  1 -
 target/i386/tcg/mem_helper.c            |  1 -
 target/i386/tcg/mpx_helper.c            |  1 -
 target/i386/tcg/seg_helper.c            |  1 -
 target/i386/tcg/system/bpt_helper.c     |  1 -
 target/i386/tcg/translate.c             |  1 -
 target/i386/tcg/user/excp_helper.c      |  1 -
 target/i386/tcg/user/seg_helper.c       |  1 -
 target/loongarch/cpu.c                  |  1 -
 target/loongarch/tcg/fpu_helper.c       |  1 -
 target/loongarch/tcg/iocsr_helper.c     |  1 -
 target/loongarch/tcg/op_helper.c        |  1 -
 target/loongarch/tcg/tlb_helper.c       |  1 -
 target/loongarch/tcg/vec_helper.c       |  1 -
 target/m68k/fpu_helper.c                |  1 -
 target/m68k/helper.c                    |  1 -
 target/m68k/op_helper.c                 |  1 -
 target/m68k/translate.c                 |  1 -
 target/microblaze/cpu.c                 |  1 -
 target/microblaze/op_helper.c           |  1 -
 target/microblaze/translate.c           |  1 -
 target/mips/cpu.c                       |  1 -
 target/mips/system/physaddr.c           |  1 -
 target/mips/tcg/exception.c             |  1 -
 target/mips/tcg/fpu_helper.c            |  1 -
 target/mips/tcg/ldst_helper.c           |  1 -
 target/mips/tcg/msa_helper.c            |  1 -
 target/mips/tcg/op_helper.c             |  1 -
 target/mips/tcg/system/special_helper.c |  1 -
 target/mips/tcg/system/tlb_helper.c     |  1 -
 target/openrisc/cpu.c                   |  1 -
 target/openrisc/exception.c             |  1 -
 target/openrisc/exception_helper.c      |  1 -
 target/openrisc/fpu_helper.c            |  1 -
 target/openrisc/interrupt.c             |  1 -
 target/openrisc/interrupt_helper.c      |  1 -
 target/openrisc/sys_helper.c            |  1 -
 target/openrisc/translate.c             |  1 -
 target/ppc/excp_helper.c                |  1 -
 target/ppc/fpu_helper.c                 |  1 -
 target/ppc/machine.c                    |  1 -
 target/ppc/mem_helper.c                 |  1 -
 target/ppc/misc_helper.c                |  1 -
 target/ppc/mmu-hash32.c                 |  1 -
 target/ppc/mmu-hash64.c                 |  1 -
 target/ppc/mmu-radix64.c                |  1 -
 target/ppc/mmu_common.c                 |  1 -
 target/ppc/mmu_helper.c                 |  1 -
 target/ppc/power8-pmu.c                 |  1 -
 target/ppc/tcg-excp_helper.c            |  1 -
 target/ppc/timebase_helper.c            |  1 -
 target/ppc/translate.c                  |  1 -
 target/ppc/user_only_helper.c           |  1 -
 target/riscv/cpu.c                      |  1 -
 target/riscv/cpu_helper.c               |  1 -
 target/riscv/crypto_helper.c            |  1 -
 target/riscv/csr.c                      |  1 -
 target/riscv/debug.c                    |  1 -
 target/riscv/fpu_helper.c               |  1 -
 target/riscv/m128_helper.c              |  1 -
 target/riscv/op_helper.c                |  1 -
 target/riscv/tcg/tcg-cpu.c              |  1 -
 target/riscv/translate.c                |  1 -
 target/riscv/vcrypto_helper.c           |  1 -
 target/riscv/vector_helper.c            |  1 -
 target/riscv/zce_helper.c               |  1 -
 target/rx/op_helper.c                   |  1 -
 target/rx/translate.c                   |  1 -
 target/s390x/interrupt.c                |  1 -
 target/s390x/mmu_helper.c               |  1 -
 target/s390x/sigp.c                     |  1 -
 target/s390x/tcg/cc_helper.c            |  1 -
 target/s390x/tcg/crypto_helper.c        |  1 -
 target/s390x/tcg/excp_helper.c          |  1 -
 target/s390x/tcg/fpu_helper.c           |  1 -
 target/s390x/tcg/int_helper.c           |  1 -
 target/s390x/tcg/mem_helper.c           |  1 -
 target/s390x/tcg/misc_helper.c          |  1 -
 target/s390x/tcg/translate.c            |  1 -
 target/s390x/tcg/vec_fpu_helper.c       |  1 -
 target/s390x/tcg/vec_helper.c           |  1 -
 target/sh4/cpu.c                        |  1 -
 target/sh4/helper.c                     |  1 -
 target/sh4/op_helper.c                  |  1 -
 target/sh4/translate.c                  |  1 -
 target/sparc/cpu.c                      |  1 -
 target/sparc/fop_helper.c               |  1 -
 target/sparc/helper.c                   |  1 -
 target/sparc/ldst_helper.c              |  1 -
 target/sparc/machine.c                  |  1 -
 target/sparc/translate.c                |  1 -
 target/sparc/win_helper.c               |  1 -
 target/tricore/cpu.c                    |  1 -
 target/tricore/op_helper.c              |  1 -
 target/tricore/translate.c              |  1 -
 target/xtensa/dbg_helper.c              |  1 -
 target/xtensa/exc_helper.c              |  1 -
 target/xtensa/fpu_helper.c              |  1 -
 target/xtensa/mmu_helper.c              |  1 -
 target/xtensa/op_helper.c               |  1 -
 target/xtensa/translate.c               |  1 -
 target/xtensa/win_helper.c              |  1 -
 MAINTAINERS                             |  1 -
 153 files changed, 175 deletions(-)
 delete mode 100644 include/exec/exec-all.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 244670dd24..93388e7c34 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "qemu/units.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "exec/exec-all.h"
 
 #include "user/abitypes.h"
 #include "user/cpu_loop.h"
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
deleted file mode 100644
index 9ef7569a0b..0000000000
--- a/include/exec/exec-all.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * internal execution defines for qemu
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef EXEC_ALL_H
-#define EXEC_ALL_H
-
-#endif
diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index b4e4425acb..15a1b1a4fa 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -24,7 +24,6 @@
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "system/ramblock.h"
-#include "exec/exec-all.h"
 #include "system/memory.h"
 #include "exec/target_page.h"
 #include "qemu/rcu.h"
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 4aa253b566..691b9a1775 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -19,7 +19,6 @@
 #define LINUX_USER_USER_INTERNALS_H
 
 #include "user/thunk.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 
 extern char *exec_path;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 53e485d28a..1bfdb0fb9b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -4,7 +4,6 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
-#include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "exec/helper-gen.h"
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 54d845379c..6b3f19855f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -20,7 +20,6 @@
 #ifndef I386_HELPER_TCG_H
 #define I386_HELPER_TCG_H
 
-#include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 
 /* Maximum instruction code size */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 5375de7bcf..b8b6116bc8 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -51,7 +51,6 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/address-spaces.h"
-#include "exec/exec-all.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
 #include "system/accel-ops.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b346af942a..5b6d6f7975 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -22,7 +22,6 @@
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/iommu.h"
 #include "accel/tcg/probe.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 0408e2522a..31c7f9927f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -21,7 +21,6 @@
 
 #include "trace.h"
 #include "disas/disas.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 697fdf1824..70feee8df9 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -21,7 +21,6 @@
 #include "disas/disas.h"
 #include "cpu.h"
 #include "exec/vaddr.h"
-#include "exec/exec-all.h"
 #include "exec/tlb-flags.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index fdb160bed0..fa7645a56e 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -36,7 +36,6 @@
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "qemu/plugin.h"
-#include "exec/exec-all.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
 #include "tcg/startup.h"
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 820f752b9e..10cf634da1 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/target_long.h"
 #include "helper_regs.h"
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index be2e3944dc..74e76b94a5 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -26,7 +26,6 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "exec/exec-all.h"
 #include "trace.h"
 
 #include "riscv-iommu.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 41306fb600..300eabc595 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -36,7 +36,6 @@
 #include "sh7750_regnames.h"
 #include "hw/sh4/sh_intc.h"
 #include "hw/timer/tmu012.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "trace.h"
 
diff --git a/linux-user/main.c b/linux-user/main.c
index e2ec5970be..4af7f49f38 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -40,7 +40,6 @@
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
 #include "tcg/startup.h"
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index ebbb300f86..4554844e15 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "accel/tcg/probe.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "semihosting/uaccess.h"
diff --git a/system/physmem.c b/system/physmem.c
index f1ec0902c7..3f4fd69d9a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -32,7 +32,6 @@
 #include "accel/tcg/iommu.h"
 #endif /* CONFIG_TCG */
 
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 27e2008a4e..68414af8d3 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "fpu/softfloat.h"
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 6aefb9b851..30f3c7fd18 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index 5672696f6f..6bfe63500e 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index a4d5adb40c..2113fe33ae 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 7f3195a5dc..cebab0318c 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "system/cpus.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
index f94fb519db..c1d201e7b4 100644
--- a/target/alpha/vax_helper.c
+++ b/target/alpha/vax_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5e951675c6..7b801eb3aa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -33,7 +33,6 @@
 #endif /* CONFIG_TCG */
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 473ee2af38..de7999f6a9 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,7 +11,6 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2f039b2db3..8de4eb2c1f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -20,7 +20,6 @@
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/irq.h"
 #include "system/cpu-timers.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 87d707b592..1040a18962 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -10,7 +10,6 @@
 #include "qemu/log.h"
 #include "qemu/range.h"
 #include "qemu/main-loop.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index cfe5faba19..9cffda07cd 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -29,7 +29,6 @@
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include "exec/cpu-common.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "exec/target_page.h"
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 37dc98dc35..6614719832 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -15,7 +15,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 8fbdcc8fb9..13d7ac0097 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "internals.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/cpu_loop.h"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index f9f67d1f88..506d1c3475 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -23,7 +23,6 @@
 #include "vec_internal.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "crypto/clmul.h"
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index d50b8720ad..dc3f83c37d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 59bf27541d..c591c3052c 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 96b84c37a2..3226895cae 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -23,7 +23,6 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "exec/exec-all.h"
 #include "qemu/int128.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 50aca54eaa..9f20ecb51d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8841f039bc..5ea4d6590f 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -9,7 +9,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d9305f9d26..52cf47e775 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3f261c6fec..69fface7e9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "system/address-spaces.h"
 #include "cpu.h"
diff --git a/target/avr/translate.c b/target/avr/translate.c
index b9c592c899..804b0b21db 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -22,7 +22,6 @@
 #include "qemu/qemu-print.h"
 #include "tcg/tcg.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a5d31c33bd..c1bfa80252 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -19,7 +19,6 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "internal.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index dd726b4318..444799d3ad 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -17,7 +17,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b792cb247a..b083693b57 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -24,7 +24,6 @@
 #include "qemu/timer.h"
 #include "cpu.h"
 #include "qemu/module.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "fpu/softfloat.h"
diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index a62d9d3083..ddd0a343d6 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index ac7f58f0af..d7f8495d98 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -21,7 +21,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "hw/hppa/hppa_hardware.h"
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a5f73aedf8..9bdd0a6f23 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "accel/tcg/probe.h"
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 32207c1a4c..0458378abb 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 052a6a88a2..6e65fadcc7 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 88a7d339eb..7a81cfcb88 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index ee5b451459..97e3f0e756 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -5,7 +5,6 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "access.h"
 
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index de71e68f98..6fb8036d98 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "system/runstate.h"
 #include "exec/helper-proto.h"
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 1a02e9d843..46741d9f68 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "qapi/error.h"
diff --git a/target/i386/tcg/mem_helper.c b/target/i386/tcg/mem_helper.c
index 84a0815217..9e7c2d8029 100644
--- a/target/i386/tcg/mem_helper.c
+++ b/target/i386/tcg/mem_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/i386/tcg/mpx_helper.c b/target/i386/tcg/mpx_helper.c
index a0f816dfae..fa8abcc482 100644
--- a/target/i386/tcg/mpx_helper.c
+++ b/target/i386/tcg/mpx_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "helper-tcg.h"
 
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index e45d71fa1a..0ca081b286 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "exec/log.h"
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index 08ccd3f5e6..aebb5caac3 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "tcg/helper-tcg.h"
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8a641951cd..8c3023407d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -21,7 +21,6 @@
 #include "qemu/host-utils.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index b3bdb7831a..98fab4cbc3 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
 
 void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 5692dd5195..263f59937f 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "tcg/helper-tcg.h"
 #include "tcg/seg_helper.h"
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8ad45b453d..c083ad4fd9 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -15,7 +15,6 @@
 #include "system/kvm.h"
 #include "kvm/kvm_loongarch.h"
 #include "hw/qdev-properties.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "cpu.h"
 #include "internals.h"
diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index fc3fd0561e..fc9c64c20a 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 #include "internals.h"
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index e62170de3c..c155f48564 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -9,7 +9,6 @@
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 
 #define GET_MEMTXATTRS(cas) \
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 94e3b28016..16ac0d43bc 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -10,7 +10,6 @@
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "internals.h"
 #include "qemu/crc32c.h"
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index af208d75ae..dc48b0f4d2 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -13,7 +13,6 @@
 #include "internals.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/loongarch/tcg/vec_helper.c b/target/loongarch/tcg/vec_helper.c
index 3faf52cbc4..a270998e63 100644
--- a/target/loongarch/tcg/vec_helper.c
+++ b/target/loongarch/tcg/vec_helper.c
@@ -7,7 +7,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "internals.h"
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index ac4a0d85be..56012863c8 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "softfloat.h"
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 3b880dd4d9..15f110fa7a 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/gdbstub.h"
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 242aecccbb..f29ae12af8 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "semihosting/semihost.h"
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index b1266a7875..97afceb129 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "tcg/tcg-op.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 00a2730de4..2720e5c1d2 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -27,7 +27,6 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/gdbstub.h"
 #include "exec/translation-block.h"
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4624ce5b67..9e838dfa15 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 23f1037236..671b1ae4db 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d13361a150..96fe4da255 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -29,7 +29,6 @@
 #include "qemu/module.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
-#include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "fpu_helper.h"
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 505781d84c..b8e1a5ac98 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -18,7 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "../internal.h"
 
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 1a8902ea1b..d32bcebf46 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 
 target_ulong exception_resume_pc(CPUMIPSState *env)
diff --git a/target/mips/tcg/fpu_helper.c b/target/mips/tcg/fpu_helper.c
index 45d593de48..36af980802 100644
--- a/target/mips/tcg/fpu_helper.c
+++ b/target/mips/tcg/fpu_helper.c
@@ -24,7 +24,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 #include "fpu_helper.h"
 
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 2fb879fcbc..10319bf03a 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -23,7 +23,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/memop.h"
 #include "internal.h"
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index fde34a39e1..f554b3d10e 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "tcg/tcg.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 65403f1a87..b906d10204 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exec/memop.h"
 #include "fpu_helper.h"
 
diff --git a/target/mips/tcg/system/special_helper.c b/target/mips/tcg/system/special_helper.c
index 3ce3ae1e12..b54cbe88a3 100644
--- a/target/mips/tcg/system/special_helper.c
+++ b/target/mips/tcg/system/special_helper.c
@@ -22,7 +22,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "internal.h"
 
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index e477ef812a..eccaf3624c 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 2ec267efec..8c8165d666 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -21,7 +21,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
diff --git a/target/openrisc/exception.c b/target/openrisc/exception.c
index 8699c3dcea..e213be36b6 100644
--- a/target/openrisc/exception.c
+++ b/target/openrisc/exception.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exception.h"
 
 G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 1f5be4bed9..c2c9d13652 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 8b81d2f62f..dba997255c 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index b3b5b40577..486823094c 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index ab4ea88b69..1553ebc71b 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 void HELPER(rfe)(CPUOpenRISCState *env)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 92badf017f..951f8e247a 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
 #include "exec/helper-proto.h"
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index baadea4448..5ab3bc7021 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index da8b525a41..1efdc4066e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -24,7 +24,6 @@
 #include "system/system.h"
 #include "system/runstate.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "internal.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d93cfed17b..07b782f971 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "internal.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 98df5b4a3a..d72e5ecb94 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "helper_regs.h"
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 50f05a915e..aa1af44d22 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 46ae454afd..e7d9462518 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 5bd3efe70e..8b980a5aa9 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 3ba4810497..dd337558aa 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 4ab5f3bb92..33ac341290 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 394a0c9bb6..52d48615ac 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -24,7 +24,6 @@
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 2138666122..ac60705402 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -25,7 +25,6 @@
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index db9ee8e96b..2a7a5b493a 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "helper_regs.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 2b15e5f2f0..f835be5156 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/log.h"
 #include "target/ppc/cpu.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
 
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 73120323b4..7209b418fb 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -20,7 +20,6 @@
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 62dd008e36..27f90c3cc5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index a4d07a0d0d..ae210eb847 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "internal.h"
 
 void ppc_cpu_record_sigsegv(CPUState *cs, vaddr address,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e0604f4c78..d92874baa0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -24,7 +24,6 @@
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "internals.h"
-#include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 619c76cc00..f2e90a9889 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -24,7 +24,6 @@
 #include "internals.h"
 #include "pmu.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index bb084e00ef..a0fb54bc50 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1308643855..a32e1455c9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -24,7 +24,6 @@
 #include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/icount.h"
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 8564f0b371..5664466749 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/cpu-timers.h"
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 91b1a56d10..706bdfa61d 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "internals.h"
diff --git a/target/riscv/m128_helper.c b/target/riscv/m128_helper.c
index ec14aaa901..7d9b83b1b2 100644
--- a/target/riscv/m128_helper.c
+++ b/target/riscv/m128_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 target_ulong HELPER(divu_i128)(CPURISCVState *env,
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index abb1d284dc..05316f2088 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54ac54f2e1..2f757c2a5e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg-cpu.h"
 #include "cpu.h"
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cef61b5b29..85128f997b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg-op.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/target_page.h"
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index 1526de96f5..9a0d9b4f53 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -26,7 +26,6 @@
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "exec/memop.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "internals.h"
 #include "vector_internals.h"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5ccb294e31..8eea3e6df0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/bitops.h"
 #include "cpu.h"
 #include "exec/memop.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index 50d65f386c..55221f5f37 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -18,7 +18,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index a2f1f3824d..2b190a4b2c 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
diff --git a/target/rx/translate.c b/target/rx/translate.c
index bbda703be8..19a9584a82 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/bswap.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 4ae6e2ddea..1dca835c5d 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -11,7 +11,6 @@
 #include "cpu.h"
 #include "kvm/kvm_s390x.h"
 #include "s390x-internal.h"
-#include "exec/exec-all.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "hw/s390x/ioinst.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 0e133cb9a5..00946e9c0f 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,7 +23,6 @@
 #include "kvm/kvm_s390x.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index a3347f1236..5e95c4978f 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -16,7 +16,6 @@
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "system/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/target/s390x/tcg/cc_helper.c b/target/s390x/tcg/cc_helper.c
index b36f8cdc8b..6595ac763c 100644
--- a/target/s390x/tcg/cc_helper.c
+++ b/target/s390x/tcg/cc_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 642c1b18c4..4447bb66ee 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -17,7 +17,6 @@
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 
 static uint64_t R(uint64_t x, int c)
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 6cd813e1ab..e4c75d0ce0 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "exec/watchpoint.h"
 #include "s390x-internal.h"
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 5041c13962..1ba43715ac 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index 253c036415..fbda396f5b 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
-#include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 9e77cde81b..857005b120 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -25,7 +25,6 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu-common.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index d5088493ea..f7101be574 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -26,7 +26,6 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/target_page.h"
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a714f9c0c2..c7e8574438 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -31,7 +31,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
diff --git a/target/s390x/tcg/vec_fpu_helper.c b/target/s390x/tcg/vec_fpu_helper.c
index 1bbaa82fe8..744f800fb6 100644
--- a/target/s390x/tcg/vec_fpu_helper.c
+++ b/target/s390x/tcg/vec_fpu_helper.c
@@ -15,7 +15,6 @@
 #include "vec.h"
 #include "tcg_s390x.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 781ccc565b..46ec4a947d 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -17,7 +17,6 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "exec/exec-all.h"
 
 void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 57d7b5fbc8..1885e7d5b2 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -24,7 +24,6 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "migration/vmstate.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b41d14d5d7..fb7642bda1 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -21,7 +21,6 @@
 
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index e7fcad3c1b..557b1bf497 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 712117be22..bf8828fce8 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bc753d5f62..690e74f109 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -23,7 +23,6 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "accel/tcg/cpu-mmu-index.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index c25097d07f..a49334150d 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 7846ddd6f6..9163b9d46a 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4c5dba19d1..2c63eb9e03 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 222e5709c5..4dd75aff74 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "qemu/timer.h"
 
 #include "migration/cpu.h"
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 63dd90447b..b922e53bf1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -22,7 +22,6 @@
 
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 0c4b09f2c1..9ad9d01e8b 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "trace.h"
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 098cd06c54..9f19e903bc 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index ae559b6922..9910c13f4b 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -18,7 +18,6 @@
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ba36c9fcc8..3d0e7a10bd 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index c4f4298a50..3b91f7c38a 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -30,7 +30,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "exec/watchpoint.h"
 #include "system/address-spaces.h"
 
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index ca629f071d..b611c9bf97 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -32,7 +32,6 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/atomic.h"
-#include "exec/exec-all.h"
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 53fc7cfd2a..5358060c50 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -30,7 +30,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 
 enum {
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 182c6e35c1..71330fc84b 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -35,7 +35,6 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "accel/tcg/probe.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index c125fa4946..fc47ebaaf5 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -30,7 +30,6 @@
 #include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 #include "system/memory.h"
 #include "qemu/atomic.h"
 #include "qemu/timer.h"
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 2af83c07c2..34ae2f4e16 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -31,7 +31,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
index ec9ff44db0..4b25f8f4de 100644
--- a/target/xtensa/win_helper.c
+++ b/target/xtensa/win_helper.c
@@ -30,7 +30,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 
 static void copy_window_from_phys(CPUXtensaState *env,
                                   uint32_t window, uint32_t phys, uint32_t n)
diff --git a/MAINTAINERS b/MAINTAINERS
index f3f491c8c2..3706601ea5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -493,7 +493,6 @@ M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/exec/cpu*.h
-F: include/exec/exec-all.h
 F: include/exec/target_long.h
 F: include/qemu/accel.h
 F: include/system/accel-*.h
-- 
2.43.0


