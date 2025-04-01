Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C13CC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX3C-0001LA-IS; Tue, 01 Apr 2025 04:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX3A-0001Er-Ic
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX37-00012e-A6
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so2717421f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496363; x=1744101163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKdxbUTePWZ3FVX61R9hL0gE/d7nRzJ2vgYwdU9Zlp4=;
 b=pqr6/cNwS4P/eKPVs1eThWJQH5RZhOYXtbd6WAmCUYjx/WKS8dop6Y7EUAR6j4AKH4
 54C9ZCul3MS+pZmAqIhYwyx/g2jmGoQzVfJdD+tKCqp7jQEEzrpC2viIKC/xtYpYwRzt
 sG6A131avryABpPcKjLdzwTj8QaG3VcK4TVnYzCnp4YVllv4zXdkfzizCr9vTmhkTMgL
 7x2/ar+l4fGcGyvDaxJmIsgH1ss6h+sXHBZz8lQlFxFZFjB2QfWPRBgUriq9g+NVNZcx
 WE9vP8H7l4omP5PHzRjml4hmG5s7Hl34wydGjaFjw7abG5+iBarG+p9TgXuZ8K40ugjw
 G8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496363; x=1744101163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKdxbUTePWZ3FVX61R9hL0gE/d7nRzJ2vgYwdU9Zlp4=;
 b=xOqXFrTvuv6aP8Xz8fmPTReBK1SoGTB4+WgMIpjJ8H8Cn5u990d8XthAKNcx4pboUV
 VQVlvHCDsHiVoeyH17626BwaA+8f41TZNGVnxbzS/WO7opY/XJrRHyzjtE/4y7z7vMMw
 aabK5RuClM/ogXtL9s1ISmgUEBEnnB72TJFwBPkaErDF6qpHD3+1Am7lEQCO+3X9fSkQ
 CawsxmFhM74ksZr0YguPW5mXPYFx2b1T0lSFSO/F0qTaYib/x3EF1OI254kGe8TX7wbZ
 lQLj6f8niogb1sTxg4XQ0mbMRIrt0SsBwyZdaThMgl4TKriYEocNqwxIOqQO+72DYOud
 J6Uw==
X-Gm-Message-State: AOJu0YzTrBo5FHUAR24VcDkiPeHzwlEw/NYXbphpOcNBVkbzlVpBQ/W1
 yk6B3O2VaQobTQazh4DR7jPB4n6y9yNqNr9rcFNDlNfZiwOXrwd+41r8AnxnfBECmKROL0v0pqt
 Z
X-Gm-Gg: ASbGncv3f15IK+OS5PpkKgslDX+H68PHPyVv0RNHQ4qc+/BLwfHEPpIJQ/CDWw6ADah
 bA9D1RB2M0O1KPCpBNcw0BTpqLAg1/f7C6tPE/50UUIhqngM2pX6qnllpNYmho+uTBLnj/Mx1hZ
 yFqQfvxOru0J1/KMBIFjEc3mnhg58GnL7UGzPre2en9QR5gZw7+lSorxSOVCrwstyPvmDQ7qI7c
 sjrgTEhirkEYt4d5M9PKtITjIUiGZNsCG6egONNs25rwaZfZ8hufGGquja0m5LaygdZGfh9SNlX
 e6Fq5kiaM6eOP39OPEyYwvf1FYfUCPeffks99j6XFLayIB4QBEieAzA1fYVI0CJuCNHWM6TNQAu
 IGS8GQL4aMvOQG6Kvigo=
X-Google-Smtp-Source: AGHT+IEv99uFat1U6/JuCIMJyk7ACLyT/kg2O56QYr4hcF+I8KEv6GQsj30S7w57OiODXs9ByzVTnQ==
X-Received: by 2002:a05:6000:1786:b0:39a:c9b3:e1d7 with SMTP id
 ffacd0b85a97d-39c120e3b71mr7214963f8f.29.1743496362908; 
 Tue, 01 Apr 2025 01:32:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a3d66sm13361248f8f.81.2025.04.01.01.32.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:32:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/3] exec: Restrict 'cpu_ldst.h' to accel/tcg/
Date: Tue,  1 Apr 2025 10:32:31 +0200
Message-ID: <20250401083232.33773-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401083232.33773-1-philmd@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Mechanical change using:

  $ sed -i -e 's,exec/cpu_ldst,accel/tcg/cpu-ldst,' \
        $(git grep -l exec/cpu_ldst.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index c1c508281a8..244670dd24d 100644
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
index 74761ba5f30..f97a730703e 100644
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
index f52a680f42b..70608a11b60 100644
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
index 948de8431a5..0b19fa43e65 100644
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
index 4f159ec4adf..f2243daf370 100644
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
index 0de46903dd9..2cafd38d2af 100644
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
index 7f57d8f1aff..1b878ead7a7 100644
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
index 872955f5e74..a4d5adb40c6 100644
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
index 507dbc1a440..08d8f63ffea 100644
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
index f7354f3c6e0..37dc98dc35c 100644
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
index 888c6707547..7dc5fb776b3 100644
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
index 274003e2e5b..f9f67d1f88e 100644
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
index 71ba406782f..38d49cbb9d8 100644
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
index c4b143024f3..59bf27541dc 100644
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
index dcc48e43db3..96b84c37a2d 100644
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
index 32cbf179195..afa591470fe 100644
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
index 6da8db8ea5c..3f3d86db2b2 100644
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
index fe7858703c8..dd26801e647 100644
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
index beb8f88799e..2398ce2c648 100644
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
index 5a4721dcee1..0fdd587eddf 100644
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
index c1184ca2198..1cbadb14533 100644
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
index 3ef84e90d94..84a08152171 100644
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
index b942665adcf..a0f816dfae0 100644
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
index 9dfbc4208cd..3af902e0ec5 100644
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
index a563c9b35ea..93614aa3e54 100644
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
index 67896c8c875..9c3f5cc99b3 100644
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
index b07cc9f9b12..d4ea890c124 100644
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
index f9982b72d17..b27049b9ed1 100644
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
index c45f2ac2ba6..5692dd51953 100644
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
index cb96b17911a..4cc8e02f70b 100644
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
index 6a7a65c860b..2942d7feb81 100644
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
index a83acf64b08..fc3fd0561e3 100644
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
index b6916f53d20..e62170de3ce 100644
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
index b17208e5b96..94e3b28016a 100644
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
index 0d6c9844a6f..9a76a2a205f 100644
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
index eb1cb8c6872..ac4a0d85be5 100644
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
index 15bad5dd465..242aecccbbc 100644
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
index 88baeb6807a..d10ae0702ad 100644
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
index f6378030b7a..4624ce5b672 100644
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
index 4bb867c9695..7dcad6cf0d7 100644
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
index f92a923d7ad..2fb879fcbcc 100644
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
index 969dd34b3e6..14de4a71ff6 100644
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
index d239fa93536..e477ef812ae 100644
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
index 0967624afee..d7e8d678f4b 100644
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
index c90ceb7d60d..2138666122b 100644
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
index c422648cfdd..2b15e5f2f07 100644
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
index f3d26b6b957..5b0db2c45ab 100644
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
index 7de6cbae5cc..b8ae7044578 100644
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
index b433bda16dc..50d65f386c7 100644
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
index e8aabf40ffb..0640ab322b5 100644
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
index b3ed822dd11..a2f1f3824d9 100644
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
index 93aabd236f4..642c1b18c4c 100644
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
index 2af970f2c8b..253c0364157 100644
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
index d5eece4384b..0cdfd380ce4 100644
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
index e02f4438508..d5088493ead 100644
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
index dafc4c3582c..781ccc565bd 100644
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
index 99394b714c9..e7fcad3c1b7 100644
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
index f0266061023..39db4ffa70a 100644
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
index 10cc6f7835d..ca5a4d38ac2 100644
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
index a0d5a0da1df..ae559b69220 100644
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
index 5c7ed395caa..7cd26d8eaba 100644
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
2.47.1


