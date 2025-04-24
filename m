Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F47C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ky5-0007Id-V3; Wed, 23 Apr 2025 21:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kws-00057H-G7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwn-0005UG-TB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so400713b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456411; x=1746061211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kG36f6Jj9ZLzZg5DXZFQTfeIh+dt0yHtk/44qelrlg0=;
 b=a02W/ckAQUOW/ZD+17GRtbTVnO4eysijc4VS8aGU0nDRItoUkQZzDGkH4o/OJqm6OL
 nzAoYSCO+kK6lZxgQBPpSsCH6Ws3SNqF2R8Ps+MWhm/cmSg/HYZUvw9aXoPtd5OhrhKx
 zticAN2ATo6LoZHAxkUHbboulLrVbyikZ7RionSauJr69GRIyXS0LMHhmFiTecbxKqFx
 shhe0cWa2OXNq/zo5LqQX945u23FRZacteCzLrXgBS3E3HZoELIzNCmjxLo5kV/ff1V2
 IK+C0lLABg8MKGzVF332PjQb02luPP4q+VFbSScZhLeGhSgxcFo6clC2pdZSBnHZpqP+
 796g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456411; x=1746061211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kG36f6Jj9ZLzZg5DXZFQTfeIh+dt0yHtk/44qelrlg0=;
 b=tRqn8TuwHqOs5SK4a9Ycx+602rLvUNhB/tHyY7aXPvbWm/m4z0Sll1NWBWVCyksALw
 THjQCTHd6bhkqBm/mnuk4Fb7CglEtPRsWUOKpwk9YqvDwybCDm3GI8gZOiXJ2jp344EX
 XEDJbfZ+pjjycS6+/Si/yUpjPSXWhoMF+vw4GkRsrRh5NOJNGFG1uhs2OTPZPbF8c3p4
 c5QrieLDUlQ0OKqBnOqmIzOq3Hb4gU7memBWYLniLwVQewSfAcAuWBQ1yHsHVL1Amf09
 BE0xJHT4CuBzeM2RX67+ufuJHUlvhfP94J7oSdP5DLIPxRLldIJz7tWUtqEk3t7BbekN
 X/kQ==
X-Gm-Message-State: AOJu0YyUPMlyD4gGHQpptqL1ts8lNULvnW+aVOsYPXwpGDWHk9lAREbs
 fIqPUZLWpj7WdajJ62uNYi0Vt6GB9HX6uRM8z6sc8C2v+t9WZILWgsVFBWZhU4L+sJ/WObUj8hZ
 G
X-Gm-Gg: ASbGncsfu0YsttJQMyPQ61PRspPV+WAfedKPAQqbvbdblO96jftGvGDXddCayZ1tYYH
 TEK72REouMntoo1CYvV5V9g9XcNBw5WsuD/vyokfRb0h5P9IjwYVZ2YUUNaOTDHI5zN5+IsfpIo
 TypNeifEevJvI4ygrozUoYjQHFO19RegIkwGf/SB8DpCdRlcCRwi6qCxiVvLWEUIIryMunRnIdn
 xDdD1/9MVe/IJ31hFYk8t3N3HZu0aH8hou6MQf4ZKAvZHFlFKDvrRpZLt9KbPSnjCasaON8PYdy
 Wvj1TmQ1EXrYtr5kqEG8ZerOE+/oxX6yYZ/Ge8rehnrLB8nXa459CnAfWHU4LGsvYqp7UZ605t4
 =
X-Google-Smtp-Source: AGHT+IFNtJYn5lRSOoLrSqUaMHO+XMeOCbHd3y5HjByC6fXSzuFXZISK/ZD0y5w5HQraaz9eozi9Vw==
X-Received: by 2002:a05:6a21:3513:b0:1f5:5ca4:2744 with SMTP id
 adf61e73a8af0-20444e94cd7mr909233637.17.1745456410925; 
 Wed, 23 Apr 2025 18:00:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 131/148] exec: Restrict 'cpu_ldst.h' to accel/tcg/
Date: Wed, 23 Apr 2025 17:49:16 -0700
Message-ID: <20250424004934.598783-132-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Mechanical change using:

  $ sed -i -e 's,exec/cpu_ldst,accel/tcg/cpu-ldst,' \
        $(git grep -l exec/cpu_ldst.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h                                   | 2 +-
 include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} | 6 +++---
 include/exec/exec-all.h                           | 2 +-
 linux-user/qemu.h                                 | 2 +-
 target/arm/tcg/sve_ldst_internal.h                | 2 +-
 accel/tcg/cputlb.c                                | 2 +-
 accel/tcg/user-exec.c                             | 2 +-
 target/alpha/mem_helper.c                         | 2 +-
 target/arm/tcg/helper-a64.c                       | 2 +-
 target/arm/tcg/m_helper.c                         | 2 +-
 target/arm/tcg/mte_helper.c                       | 2 +-
 target/arm/tcg/mve_helper.c                       | 2 +-
 target/arm/tcg/op_helper.c                        | 2 +-
 target/arm/tcg/pauth_helper.c                     | 2 +-
 target/arm/tcg/sme_helper.c                       | 2 +-
 target/avr/helper.c                               | 2 +-
 target/hexagon/op_helper.c                        | 2 +-
 target/hexagon/translate.c                        | 2 +-
 target/hppa/op_helper.c                           | 2 +-
 target/i386/tcg/access.c                          | 2 +-
 target/i386/tcg/fpu_helper.c                      | 2 +-
 target/i386/tcg/mem_helper.c                      | 2 +-
 target/i386/tcg/mpx_helper.c                      | 2 +-
 target/i386/tcg/seg_helper.c                      | 2 +-
 target/i386/tcg/system/excp_helper.c              | 2 +-
 target/i386/tcg/system/misc_helper.c              | 2 +-
 target/i386/tcg/system/seg_helper.c               | 2 +-
 target/i386/tcg/system/svm_helper.c               | 2 +-
 target/i386/tcg/user/seg_helper.c                 | 2 +-
 target/loongarch/cpu.c                            | 2 +-
 target/loongarch/tcg/csr_helper.c                 | 2 +-
 target/loongarch/tcg/fpu_helper.c                 | 2 +-
 target/loongarch/tcg/iocsr_helper.c               | 2 +-
 target/loongarch/tcg/op_helper.c                  | 2 +-
 target/loongarch/tcg/tlb_helper.c                 | 2 +-
 target/m68k/fpu_helper.c                          | 2 +-
 target/m68k/op_helper.c                           | 2 +-
 target/microblaze/cpu.c                           | 2 +-
 target/microblaze/op_helper.c                     | 2 +-
 target/microblaze/translate.c                     | 2 +-
 target/mips/tcg/ldst_helper.c                     | 2 +-
 target/mips/tcg/msa_helper.c                      | 2 +-
 target/mips/tcg/system/tlb_helper.c               | 2 +-
 target/ppc/mem_helper.c                           | 2 +-
 target/ppc/mmu_helper.c                           | 2 +-
 target/ppc/tcg-excp_helper.c                      | 2 +-
 target/riscv/op_helper.c                          | 2 +-
 target/riscv/vector_helper.c                      | 2 +-
 target/riscv/zce_helper.c                         | 2 +-
 target/rx/helper.c                                | 2 +-
 target/rx/op_helper.c                             | 2 +-
 target/s390x/tcg/crypto_helper.c                  | 2 +-
 target/s390x/tcg/int_helper.c                     | 2 +-
 target/s390x/tcg/mem_helper.c                     | 2 +-
 target/s390x/tcg/misc_helper.c                    | 2 +-
 target/s390x/tcg/vec_helper.c                     | 2 +-
 target/sh4/op_helper.c                            | 2 +-
 target/sparc/int32_helper.c                       | 2 +-
 target/sparc/ldst_helper.c                        | 2 +-
 target/tricore/op_helper.c                        | 2 +-
 target/tricore/translate.c                        | 2 +-
 61 files changed, 63 insertions(+), 63 deletions(-)
 rename include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} (99%)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index c1c508281a..244670dd24 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -22,7 +22,7 @@
 #include "qemu/int128.h"
 #include "cpu.h"
 #include "qemu/units.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 
 #include "user/abitypes.h"
diff --git a/include/exec/cpu_ldst.h b/include/accel/tcg/cpu-ldst.h
similarity index 99%
rename from include/exec/cpu_ldst.h
rename to include/accel/tcg/cpu-ldst.h
index 74761ba5f3..f97a730703 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -59,8 +59,8 @@
  * The "mmu" suffix carries the full MemOpIdx, with both mmu_idx and the
  * MemOp including alignment requirements.  The alignment will be enforced.
  */
-#ifndef CPU_LDST_H
-#define CPU_LDST_H
+#ifndef ACCEL_TCG_CPU_LDST_H
+#define ACCEL_TCG_CPU_LDST_H
 
 #ifndef CONFIG_TCG
 #error Can only include this header with TCG
@@ -560,4 +560,4 @@ static inline void clear_helper_retaddr(void)
 #define clear_helper_retaddr()   do { } while (0)
 #endif
 
-#endif /* CPU_LDST_H */
+#endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f52a680f42..70608a11b6 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,7 +21,7 @@
 #define EXEC_ALL_H
 
 #if defined(CONFIG_USER_ONLY)
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 948de8431a..0b19fa43e6 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -2,7 +2,7 @@
 #define QEMU_H
 
 #include "cpu.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 #include "user/abitypes.h"
 #include "user/page-protection.h"
diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index 4f159ec4ad..f2243daf37 100644
--- a/target/arm/tcg/sve_ldst_internal.h
+++ b/target/arm/tcg/sve_ldst_internal.h
@@ -20,7 +20,7 @@
 #ifndef TARGET_ARM_SVE_LDST_INTERNAL_H
 #define TARGET_ARM_SVE_LDST_INTERNAL_H
 
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 /*
  * Load one element into @vd + @reg_off from @host.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0de46903dd..2cafd38d2a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "system/ram_addr.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7f57d8f1af..1b878ead7a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -26,7 +26,7 @@
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "user/cpu_loop.h"
 #include "qemu/main-loop.h"
 #include "user/page-protection.h"
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 872955f5e7..a4d5adb40c 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 507dbc1a44..08d8f63ffe 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -30,7 +30,7 @@
 #include "qemu/crc32c.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "qemu/int128.h"
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f7354f3c6e..37dc98dc35 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -18,7 +18,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "semihosting/common-semi.h"
 #endif
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 888c670754..7dc5fb776b 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -29,7 +29,7 @@
 #else
 #include "system/ram_addr.h"
 #endif
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 274003e2e5..f9f67d1f88 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -22,7 +22,7 @@
 #include "internals.h"
 #include "vec_internal.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 71ba406782..38d49cbb9d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -24,7 +24,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "cpregs.h"
 
 #define SIGNBIT (uint32_t)0x80000000
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c4b143024f..59bf27541d 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -22,7 +22,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index dcc48e43db..96b84c37a2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -22,7 +22,7 @@
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 #include "qemu/int128.h"
 #include "fpu/softfloat.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 32cbf17919..afa591470f 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -27,7 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 6da8db8ea5..3f3d86db2b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "cpu.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index fe7858703c..dd26801e64 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -23,7 +23,7 @@
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "internal.h"
 #include "attribs.h"
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index beb8f88799..2398ce2c64 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "qemu/timer.h"
 #include "trace.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index 5a4721dcee..0fdd587edd 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -3,7 +3,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "access.h"
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index c1184ca219..1cbadb1453 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "tcg-cpu.h"
 #include "exec/cputlb.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "fpu/softfloat-macros.h"
diff --git a/target/i386/tcg/mem_helper.c b/target/i386/tcg/mem_helper.c
index 3ef84e90d9..84a0815217 100644
--- a/target/i386/tcg/mem_helper.c
+++ b/target/i386/tcg/mem_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 #include "tcg/tcg.h"
diff --git a/target/i386/tcg/mpx_helper.c b/target/i386/tcg/mpx_helper.c
index b942665adc..a0f816dfae 100644
--- a/target/i386/tcg/mpx_helper.c
+++ b/target/i386/tcg/mpx_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "helper-tcg.h"
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 9dfbc4208c..3af902e0ec 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -23,7 +23,7 @@
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "helper-tcg.h"
 #include "seg_helper.h"
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index a563c9b35e..93614aa3e5 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 67896c8c87..9c3f5cc99b 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "exec/cputlb.h"
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index b07cc9f9b1..d4ea890c12 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -23,7 +23,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "tcg/helper-tcg.h"
 #include "../seg_helper.h"
 
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index f9982b72d1..b27049b9ed 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "tcg/helper-tcg.h"
 
 /* Secure Virtual Machine helpers */
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index c45f2ac2ba..5692dd5195 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "tcg/helper-tcg.h"
 #include "tcg/seg_helper.h"
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index cb96b17911..4cc8e02f70 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -29,7 +29,7 @@
 #include <linux/kvm.h>
 #endif
 #ifdef CONFIG_TCG
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "tcg/tcg.h"
 #endif
 
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 6a7a65c860..2942d7feb8 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -13,7 +13,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "hw/irq.h"
 #include "cpu-csr.h"
 
diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index a83acf64b0..fc3fd0561e 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -9,7 +9,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 #include "internals.h"
 
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index b6916f53d2..e62170de3c 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -10,7 +10,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index b17208e5b9..94e3b28016 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -11,7 +11,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 0d6c9844a6..9a76a2a205 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -16,7 +16,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "cpu-csr.h"
 
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index eb1cb8c687..ac4a0d85be 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "softfloat.h"
 
 /*
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 15bad5dd46..242aecccbb 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "semihosting/semihost.h"
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 88baeb6807..d10ae0702a 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,7 +28,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/gdbstub.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f6378030b7..4624ce5b67 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -24,7 +24,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4bb867c969..7dcad6cf0d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index f92a923d7a..2fb879fcbc 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -24,7 +24,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/memop.h"
 #include "internal.h"
 
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 969dd34b3e..14de4a71ff 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -22,7 +22,7 @@
 #include "internal.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "exec/target_page.h"
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index d239fa9353..e477ef812a 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -25,7 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 0967624afe..d7e8d678f4 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,7 +24,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c90ceb7d60..2138666122 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -37,7 +37,7 @@
 #include "mmu-radix64.h"
 #include "mmu-booke.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 /* #define FLUSH_ALL_TLBS */
 
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index c422648cfd..2b15e5f2f0 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "target/ppc/cpu.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f3d26b6b95..5b0db2c45a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -23,7 +23,7 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "trace.h"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7de6cbae5c..b8ae704457 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/memop.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index b433bda16d..50d65f386c 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -20,7 +20,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 {
diff --git a/target/rx/helper.c b/target/rx/helper.c
index e8aabf40ff..0640ab322b 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -20,7 +20,7 @@
 #include "qemu/bitops.h"
 #include "cpu.h"
 #include "exec/log.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "hw/irq.h"
 
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index b3ed822dd1..a2f1f3824d 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 93aabd236f..642c1b18c4 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -18,7 +18,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 static uint64_t R(uint64_t x, int c)
 {
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index 2af970f2c8..253c036415 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -25,7 +25,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index d5eece4384..0cdfd380ce 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -28,7 +28,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index e02f443850..d5088493ea 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -28,7 +28,7 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
 #include "tcg_s390x.h"
diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index dafc4c3582..781ccc565b 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -16,7 +16,7 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/exec-all.h"
 
 void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 99394b714c..e7fcad3c1b 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -20,7 +20,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index f026606102..39db4ffa70 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "trace.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "system/runstate.h"
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 3fa5e78816..4c5dba19d1 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -27,7 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "system/memory.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index a0d5a0da1d..ae559b6922 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,7 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include <zlib.h> /* for crc32 */
 
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5c7ed395ca..7cd26d8eab 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "qemu/qemu-print.h"
 
 #include "exec/helper-proto.h"
-- 
2.43.0


