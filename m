Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11706C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kwO-0003pI-Gn; Wed, 23 Apr 2025 20:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktc-0005vc-3d
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktY-00057S-CG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:54 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso4320575ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456210; x=1746061010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9HHGABI/+QZ6I/uzvzo64WoBmQeTxV0UDzCb6CtbrY=;
 b=JVZYPVzXqfHZttb/UHRuuajvrYnkHdC/wFZ+U33JQupBCxuZQPJPPUP5RmmFtaFsrf
 /WXACLpsp7SYvrN4Sz3vemm+oUs1kcRiSTLwpQ63yFA8TBhlnsV2axXVLMs66S4Z12oD
 JMNNZM9FlmXc36DWsvjng70emtjNDmjODAOETNA0402sDsEsBl+VzD31Jy4CkbXOcIY6
 KF3pEN9eu3Lvpf0NYSelyxj6BnLw/tekTqdsQVLplwIJaFO3CN/LyK7ckHrj7bhGb/1i
 p9FWHgNSvrqCaeygnhbRBxDvsrEoocqDqRavUEAF9bPfY9Kc30s8nxqsaMdb9IZ3yB9x
 Ytcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456210; x=1746061010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9HHGABI/+QZ6I/uzvzo64WoBmQeTxV0UDzCb6CtbrY=;
 b=JXXVemGRrH09XDYRCaxRthEfAxEKnzx3W/rYzd0PNu+9yDVGhJ/pqNveUMgihAfbLh
 uNMi0ERI/C835QtZIZZCaQ16Oi2VcMRg1twVqANAbThT8/Dn5/1YFfZTz9wvhXgBKXTo
 1TnUcn1WLzj3FAmrJXb/aeFvawSoqbL20PST4AEbhp8tRIj2XxzpbE0FzUjfONnPykh4
 iOMCUnbqiPEyEaBBY/oXslpde82BaMVmB7R9Zy1MluwucAuPUPW4X0iOt005Xx/Z3Kao
 KIU3SZirg+/MNMXoiwAyYWPSESiHzUhhfDS6/phGDxOUzievheJmb8iVdmTd9TmjShg1
 e4kQ==
X-Gm-Message-State: AOJu0YzZtOQ1r256uhes+OwGmzyqXrHsRAUOZaq9Sk2HG5X4OySCHNLg
 CVQxWEAMOvbPm976sfiPe2HL9fZqtGnLh4kiD5G1dGiYei/x50wBhveN1HtLBjaEoUk24uV2uk/
 q
X-Gm-Gg: ASbGncs5vTJW2OeO2Gdjnq3U9U4OyHUnsWca0I7Mw6+HZTrQ4ysc9mMYBFZyjn0Cw+J
 Vq5CEApTt/rLcHuAA8DYF8YwXVuCydoiO1Ux/N1cIJHHrqyJoFgAZH9QhfGTstg63LlrN72Hkr+
 Y/jt/C+/mcvXUjWAaaPsDorByj0B66jU/kWSVc3HsYY5xfcdZcQcL9314rTqeBbzRqKozyVKQBR
 l3/vzLQavgJh1vkW77zHZqXE4oNXofLsM2IbW26uYLUg8xEHoblWRJXIIM4OzrsU6qzOWuZ7EZ6
 9cpI0Dvw8S82RvpZaNXrqMO5VNLA3XmtnL/0kQdlZNGKdPrNuSDfelUsman6G3PyD15PTsIzzW8
 =
X-Google-Smtp-Source: AGHT+IFsEG1v+p8teMcmr92Ey4hNNkKCFbyzkT/zLXwMrrc6XQ23Z5Q+69yhYMlF30Af/UOV7ChEQA==
X-Received: by 2002:a17:903:184:b0:21f:6dcf:fd2b with SMTP id
 d9443c01a7336-22db47939aamr5882265ad.1.1745456210255; 
 Wed, 23 Apr 2025 17:56:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 103/148] exec/cpu-all: remove system/memory include
Date: Wed, 23 Apr 2025 17:48:48 -0700
Message-ID: <20250424004934.598783-104-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We include this header where needed. When includes set already have
ifdef CONFIG_USER_ONLY, we add it here, else, we don't condition the
include.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-5-pierrick.bouvier@linaro.org>
---
 hw/s390x/ipl.h                       | 1 +
 include/exec/cpu-all.h               | 5 -----
 target/arm/internals.h               | 1 +
 target/hppa/cpu.h                    | 1 +
 target/i386/hvf/vmx.h                | 1 +
 target/ppc/mmu-hash32.h              | 2 ++
 hw/ppc/spapr_ovec.c                  | 1 +
 target/alpha/helper.c                | 1 +
 target/arm/hvf/hvf.c                 | 1 +
 target/i386/arch_memory_mapping.c    | 1 +
 target/i386/helper.c                 | 1 +
 target/i386/tcg/system/misc_helper.c | 1 +
 target/i386/tcg/system/tcg-cpu.c     | 1 +
 target/m68k/helper.c                 | 1 +
 target/ppc/excp_helper.c             | 1 +
 target/ppc/mmu-book3s-v3.c           | 1 +
 target/ppc/mmu-hash64.c              | 1 +
 target/ppc/mmu-radix64.c             | 1 +
 target/riscv/cpu_helper.c            | 1 +
 target/sparc/ldst_helper.c           | 1 +
 target/sparc/mmu_helper.c            | 1 +
 target/xtensa/mmu_helper.c           | 1 +
 target/xtensa/op_helper.c            | 1 +
 23 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index c6ecb3433c..6557ac3be5 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -15,6 +15,7 @@
 
 #include "cpu.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "hw/qdev-core.h"
 #include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index be462c4410..399fcbb9d1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -26,11 +26,6 @@
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
-#ifndef CONFIG_USER_ONLY
-#include "system/memory.h"
-#endif
-
-
 #include "cpu.h"
 
 #endif /* CPU_ALL_H */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8756c24c08..01408e40a3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -28,6 +28,7 @@
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "system/memory.h"
 #include "syndrome.h"
 #include "cpu-features.h"
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8b36642b59..f6bf068776 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "system/memory.h"
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
 #include "hw/registerfields.h"
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 029516e5c0..26d6029fa5 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -34,6 +34,7 @@
 #include "system/hvf_int.h"
 
 #include "system/address-spaces.h"
+#include "system/memory.h"
 
 static inline uint64_t rreg(hv_vcpuid_t vcpu, hv_x86_reg_t reg)
 {
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 2838de031c..04c23ea75e 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -3,6 +3,8 @@
 
 #ifndef CONFIG_USER_ONLY
 
+#include "system/memory.h"
+
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible);
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 6d6eaf67cb..75ab4fe262 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,6 +16,7 @@
 #include "migration/vmstate.h"
 #include "qemu/bitmap.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include <libfdt.h>
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 57cefcba14..f6261a3a53 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -25,6 +25,7 @@
 #include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
+#include "system/memory.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 93a3f9b53d..34ca36fab5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -23,6 +23,7 @@
 #include <mach/mach_time.h>
 
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index ced199862d..a2398c2173 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "system/memory_mapping.h"
+#include "system/memory.h"
 
 /* PAE Paging or IA-32e Paging */
 static void walk_pte(MemoryMappingList *list, AddressSpace *as,
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c07b1b16ea..64d9e8ab9c 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -25,6 +25,7 @@
 #include "system/runstate.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "monitor/monitor.h"
 #include "kvm/kvm_i386.h"
 #endif
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 0555cf2604..67896c8c87 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "exec/cputlb.h"
 #include "tcg/helper-tcg.h"
 #include "hw/i386/apic.h"
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index ab1f3c7c59..0538a4fd51 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -24,6 +24,7 @@
 #include "system/system.h"
 #include "qemu/units.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 
 #include "tcg/tcg-cpu.h"
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 0bf574830f..8251272219 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -25,6 +25,7 @@
 #include "exec/page-protection.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
+#include "system/memory.h"
 #include "gdbstub/helpers.h"
 #include "fpu/softfloat.h"
 #include "qemu/qemu-print.h"
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c941c89806..da8b525a41 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "system/memory.h"
 #include "system/tcg.h"
 #include "system/system.h"
 #include "system/runstate.h"
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index a812cb5113..3865556310 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/memory.h"
 #include "cpu.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5ca4faee2a..3ba4810497 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -25,6 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "exec/log.h"
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 461eda4a3d..4ab5f3bb92 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -23,6 +23,7 @@
 #include "exec/page-protection.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
+#include "system/memory.h"
 #include "kvm_ppc.h"
 #include "exec/log.h"
 #include "internal.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0dd8645994..ca58094fb5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -26,6 +26,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "system/memory.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 45882e25db..8890d2b119 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -27,6 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
+#include "system/memory.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 249b1f6c4c..c5d82a0854 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -24,6 +24,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/tlb-flags.h"
+#include "system/memory.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
 
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 40b02f0a2c..1ce125794d 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -36,6 +36,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "system/memory.h"
 
 #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
 #define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 028d4e0a1c..c125fa4946 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -31,6 +31,7 @@
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "system/memory.h"
 #include "qemu/atomic.h"
 #include "qemu/timer.h"
 
-- 
2.43.0


