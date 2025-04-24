Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ACAC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u838l-00013D-3w; Thu, 24 Apr 2025 16:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u838Q-0000cM-WA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u838J-0005EM-UF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso10724615e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526318; x=1746131118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syDOnz80Hqm13S2ocYbs4DdGcFq66uebgm0GfT/bAw8=;
 b=z8sIDb80PsKOILyGk512WnUhTGgxYoglaMwSNHxzm2tyyN6C44S3P7zHJ48uq3DcK+
 IBnC48kU/08DtRFzalOIl6XQXjcYeHKuuLzEczCDfQ8cev2YTXITmgx1UYW2pYvKYrhl
 Kjck8eUB7EjuJ7+XrnlEWPzu1CulAy9vNafL9w84x0DmHODQatXvwKKi4KlRihhXBEd9
 6YS1MtST4YBNtoQF9TTxqmVg9qHdetJfkYBJN5U8HnTUMU0mGbJLHFp/umzZ5Id+XtY3
 RsWc9RDt0olpj8kZnqlDmfAEtfnAvtsH5efUBSGyxIdYKQu6NhTMhPPmyR7RdwUDURKl
 F7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526318; x=1746131118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syDOnz80Hqm13S2ocYbs4DdGcFq66uebgm0GfT/bAw8=;
 b=RFWiUn5q5CGtyz4qzhRxL6tHgwvICyWU2GsnWxtcXT2OQLa/IZaZBHL1ihPZEFnw6w
 ShIynLO8Ioten4wfAgnzMMhFd+JIOgRbDRpQAONPKYjcZwtppYFwCNCWwIBHN44cH2Ms
 cKPqdTAAYqOAUefepYDUpYpPcB7K66HxD/67xkd+oV3RJwHIC1XauI0k1P4eGB7T4Lp+
 lSdugCyTpOYZFta93ijSHEDT+zI+dp0d2Pnss3BVOlynFuv3hJwHYE6aj8e843S9gMfG
 iPh5z8slrFZ8vmS7EbCA8hJkys0iR7bNEB01YIItiCl9rDvjQrV5YIb7S7mmhxAErj4O
 dtbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrrkQqeAShZGh44zNBDFf3NiiKHtk9NjojreO48MxPBpD1qNDWsbOxeLKG1V+dLxT4deXHYuLiZ0V3@nongnu.org
X-Gm-Message-State: AOJu0YxA/6goPj1OvcUhg4d7reZ1JmUswxjgO+jJbTI2tzVwnBQD6XMO
 kW8RqWw41vrQ7dPEtB9XSFhmyXv6BKEpgIPoPe2+Z9YN3ZMdurrSGs0m8zX6KCo=
X-Gm-Gg: ASbGnctZ+DL4/8+6XTbu3Fe1iVHGk8K6DNvEBcKhvo33dV12TjSFMo3qhwl3fCpK+Tr
 U1aECNDSOecmwpuZn9CT4bbD8SUMa43CIUhBd3i3O/fIgOWc8bdvITNAiU+C1VOY3mvM2pSvvdb
 J9nOn/2bQ3P10MKWM9EHYUdjkBWvMnFZRY97Bu2NsCrvWyzKigki5d2U9iQxY5oX0NxSbK/BKMy
 AXlIeN18JB/evtpuUH6Y2VScqfaQvoZxE1QS7nXe/Bmej4WR6GP7MobpJeAA+DEMxA4TAlaJw+Q
 moxTe9QhBMo96veLKDkHRmunU56qKZPP97aw8djE7tSPukoWbv80iXZajzMiaIDyCPfNKLBc8JS
 8MVLN0rKUrzvlHKw=
X-Google-Smtp-Source: AGHT+IFM/p7lckw9y67kOrhsC+sdwJewWccuSiKS6tO4JJitsAmBKdmmsfoNnRg8PYyPclV8p0PiSw==
X-Received: by 2002:a05:600c:4447:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-440a3156265mr5853195e9.26.1745526317177; 
 Thu, 24 Apr 2025 13:25:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2aab65sm32484085e9.17.2025.04.24.13.25.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:25:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 13/13] include: Remove 'exec/exec-all.h'
Date: Thu, 24 Apr 2025 22:24:12 +0200
Message-ID: <20250424202412.91612-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

"exec/exec-all.h" is now fully empty, let's remove it.

Mechanical change running:

  $ sed -i '/exec\/exec-all.h/d' $(git grep -wl exec/exec-all.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 MAINTAINERS                             |  1 -
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
 153 files changed, 175 deletions(-)
 delete mode 100644 include/exec/exec-all.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a37cc73af7..9e677a26c52 100644
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
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 244670dd24d..93388e7c34e 100644
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
index 9ef7569a0b8..00000000000
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
index b4e4425acbb..15a1b1a4fa2 100644
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
index 4aa253b5663..691b9a1775f 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -19,7 +19,6 @@
 #define LINUX_USER_USER_INTERNALS_H
 
 #include "user/thunk.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 
 extern char *exec_path;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 53e485d28ac..1bfdb0fb9bb 100644
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
index 54d845379cd..6b3f19855f1 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -20,7 +20,6 @@
 #ifndef I386_HELPER_TCG_H
 #define I386_HELPER_TCG_H
 
-#include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 
 /* Maximum instruction code size */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 601c3bc0ac6..bbd774dbc94 100644
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
index b346af942a0..5b6d6f79751 100644
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
index 0408e2522a8..31c7f9927f2 100644
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
index 697fdf18241..70feee8df99 100644
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
index fdb160bed0f..fa7645a56ea 100644
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
index a79e398c132..9cc6083feee 100644
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
index 65b24fb07de..bbe839ed241 100644
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
index 41306fb6008..300eabc595d 100644
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
index e2ec5970bed..4af7f49f383 100644
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
index ebbb300f86a..4554844e15b 100644
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
index f1ec0902c78..3f4fd69d9a5 100644
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
index 35fb145d27f..cb3f382dc64 100644
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
index 6aefb9b851a..30f3c7fd185 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index 5672696f6f1..6bfe63500e0 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index a4d5adb40c6..2113fe33ae2 100644
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
index 7f3195a5dcc..cebab0318cf 100644
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
index f94fb519dbd..c1d201e7b4d 100644
--- a/target/alpha/vax_helper.c
+++ b/target/alpha/vax_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 377791c84dd..e149a462505 100644
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
index 473ee2af38e..de7999f6a94 100644
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
index 2f039b2db33..8de4eb2c1fa 100644
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
index 87d707b5923..1040a189627 100644
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
index ac86629432a..590717ecd8c 100644
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
index 37dc98dc35c..6614719832e 100644
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
index 8fbdcc8fb95..13d7ac00972 100644
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
index f9f67d1f88e..506d1c34757 100644
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
index d50b8720ad6..dc3f83c37dc 100644
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
index 59bf27541dc..c591c3052c3 100644
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
index 96b84c37a2d..3226895cae3 100644
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
index 50aca54eaa3..9f20ecb51d3 100644
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
index 8841f039bc6..5ea4d6590f2 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -9,7 +9,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 43408c71bbd..11053f083a0 100644
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
index 84f3b839c9b..86e53ef9f65 100644
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
index b9c592c899a..804b0b21dbd 100644
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
index 3c5191282ea..9f93c170092 100644
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
index dd726b43187..444799d3ade 100644
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
index 10e18c945ef..6acbf3de27a 100644
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
index a62d9d30831..ddd0a343d63 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index ac7f58f0afe..d7f8495d982 100644
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
index a5f73aedf82..9bdd0a6f23d 100644
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
index 32207c1a4c8..0458378abb2 100644
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
index 052a6a88a27..6e65fadcc7b 100644
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
index 14f38333222..156c3dedd18 100644
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
index ee5b4514597..97e3f0e7568 100644
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
index de71e68f986..6fb8036d988 100644
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
index 1a02e9d8434..46741d9f68a 100644
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
index 84a08152171..9e7c2d80293 100644
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
index a0f816dfae0..fa8abcc4820 100644
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
index e45d71fa1ad..0ca081b286d 100644
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
index 08ccd3f5e69..aebb5caac37 100644
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
index 1dcc35f5dfa..6eaa0457314 100644
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
index b3bdb7831a7..98fab4cbc3f 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
 
 void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 5692dd51953..263f59937fe 100644
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
index fe9462b3b7e..b6f89f0f392 100644
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
index fc3fd0561e3..fc9c64c20a8 100644
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
index e62170de3ce..c155f48564d 100644
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
index 94e3b28016a..16ac0d43bc9 100644
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
index 9a76a2a205f..1d5ba567b97 100644
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
index 3faf52cbc46..a270998e638 100644
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
index ac4a0d85be5..56012863c85 100644
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
index f73e0def234..5479acc5b99 100644
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
index 242aecccbbc..f29ae12af84 100644
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
index b1266a7875b..97afceb1297 100644
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
index edfb05758b3..658d3cb3d7b 100644
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
index 4624ce5b672..9e838dfa153 100644
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
index 7dcad6cf0d7..ad4a85407d0 100644
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
index 473cecdebca..26f4f038cde 100644
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
index 505781d84c1..b8e1a5ac98e 100644
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
index 1a8902ea1bc..d32bcebf469 100644
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
index 45d593de489..36af9808025 100644
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
index 2fb879fcbcc..10319bf03a6 100644
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
index 4d9a4468e53..fe4cd1c7b5f 100644
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
index 65403f1a87b..b906d10204b 100644
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
index 3ce3ae1e124..b54cbe88a38 100644
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
index e477ef812ae..eccaf3624cb 100644
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
index 6601e0c0666..d3c366dd86a 100644
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
index 8699c3dcea4..e213be36b6b 100644
--- a/target/openrisc/exception.c
+++ b/target/openrisc/exception.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exception.h"
 
 G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 1f5be4bed90..c2c9d136528 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 8b81d2f62f7..dba997255c6 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index b3b5b405779..486823094c8 100644
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
index ab4ea88b692..1553ebc71b0 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 void HELPER(rfe)(CPUOpenRISCState *env)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 92badf017f7..951f8e247a7 100644
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
index d4ce60188bd..3b6843768b0 100644
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
index da8b525a41b..1efdc4066eb 100644
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
index d93cfed17b4..07b782f971b 100644
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
index 98df5b4a3a2..d72e5ecb94b 100644
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
index 50f05a915ed..aa1af44d22a 100644
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
index 46ae454afd3..e7d94625185 100644
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
index 5bd3efe70e8..8b980a5aa90 100644
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
index 3ba4810497e..dd337558aa6 100644
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
index 4ab5f3bb920..33ac3412901 100644
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
index 394a0c9bb60..52d48615ac2 100644
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
index 2138666122b..ac607054027 100644
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
index db9ee8e96b0..2a7a5b493af 100644
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
index 2b15e5f2f07..f835be51563 100644
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
index 73120323b4e..7209b418fb6 100644
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
index 399107d319a..f2cd3308f80 100644
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
index a4d07a0d0dd..ae210eb8474 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "internal.h"
 
 void ppc_cpu_record_sigsegv(CPUState *cs, vaddr address,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2b830b33178..1b2a42141f0 100644
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
index 619c76cc001..f2e90a9889f 100644
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
index bb084e00efe..a0fb54bc50c 100644
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
index 13086438552..a32e1455c91 100644
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
index 7fc9e121e11..94f06b25737 100644
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
index 91b1a56d10a..706bdfa61d5 100644
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
index ec14aaa901a..7d9b83b1b2c 100644
--- a/target/riscv/m128_helper.c
+++ b/target/riscv/m128_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 target_ulong HELPER(divu_i128)(CPURISCVState *env,
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index abb1d284dce..05316f2088c 100644
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
index 426145c3b9f..916fd6fb43a 100644
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
index cef61b5b290..85128f997b7 100644
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
index 1526de96f53..9a0d9b4f536 100644
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
index 5ccb294e319..8eea3e6df03 100644
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
index 50d65f386c7..55221f5f375 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -18,7 +18,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index a2f1f3824d9..2b190a4b2cf 100644
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
index bbda703be86..19a9584a829 100644
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
index 4ae6e2ddeaa..1dca835c5d8 100644
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
index 0e133cb9a53..00946e9c0fe 100644
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
index a3347f12362..5e95c4978f9 100644
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
index b36f8cdc8b9..6595ac763c3 100644
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
index 642c1b18c4c..4447bb66eee 100644
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
index 6cd813e1abf..e4c75d0ce01 100644
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
index 5041c139627..1ba43715ac1 100644
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
index 253c0364157..fbda396f5b4 100644
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
index 9e77cde81bd..857005b1202 100644
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
index d5088493ead..f7101be5745 100644
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
index 00073c5560e..4fdb79f1747 100644
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
index 1bbaa82fe8a..744f800fb6c 100644
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
index 781ccc565bd..46ec4a947dd 100644
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
index 861fdd47f76..0a04f149d70 100644
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
index b41d14d5d7c..fb7642bda1b 100644
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
index e7fcad3c1b7..557b1bf4972 100644
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
index 5ce477d0add..f2877157b1c 100644
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
index f7d231c6f8b..c864217175b 100644
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
index c25097d07f5..a49334150d3 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 7846ddd6f62..9163b9d46ad 100644
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
index 4c5dba19d11..2c63eb9e036 100644
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
index 222e5709c55..4dd75aff74a 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "qemu/timer.h"
 
 #include "migration/cpu.h"
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index adebddf27b2..241378889c3 100644
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
index 0c4b09f2c14..9ad9d01e8b9 100644
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
index a4f93e7d910..bdbcaf0dfcc 100644
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
index ae559b69220..9910c13f4b5 100644
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
index 7cd26d8eaba..11496654e4b 100644
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
index c4f4298a50c..3b91f7c38ac 100644
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
index ca629f071d1..b611c9bf97c 100644
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
index 53fc7cfd2af..5358060c50a 100644
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
index 182c6e35c17..71330fc84b9 100644
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
index c125fa49464..fc47ebaaf50 100644
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
index 5ebd4a512c9..2ba4b1ae66d 100644
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
index ec9ff44db05..4b25f8f4de7 100644
--- a/target/xtensa/win_helper.c
+++ b/target/xtensa/win_helper.c
@@ -30,7 +30,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
 
 static void copy_window_from_phys(CPUXtensaState *env,
                                   uint32_t window, uint32_t phys, uint32_t n)
-- 
2.47.1


