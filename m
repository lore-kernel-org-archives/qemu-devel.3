Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FBFC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPq-00086Y-UZ; Thu, 01 May 2025 17:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOw-0005Ng-A6
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOt-0002Eb-1J
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so2106561b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134697; x=1746739497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0h/3+wci/wDkfnyuxg7Yp/2Pi7Vg2ehyC2gUBcQS+UI=;
 b=k2c13cSMZcZijRi6IwhBvq1pzFGQmEuI/cHRcNnR6PgNagmJw2IyCn7luKWN/ci+y6
 3S8WI9V5tSlOHZHik4F1jN2pOvzpGpUT2J6n+BrfnPL/76LCJ14XYo4MY4jYsBeoBteD
 436uqwJ6V327XiFVZAQpnOGrv/DMHDEqAtmX8PlHmgyyAWRfOutcjv75/kbrTMWDsCxr
 Y3j5ZoT2tTSib+1sDYwHYmxgBMGE9mC8krHmg1/yHDKFVPSJgqSLvWYCMpoJkGWHe2KV
 U76HzmgNXKeCvBCNY6bdtte6zPVgTPG0F3c74HYCXz3V2PpISsxnraoJSstGKYhH/msw
 h5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134697; x=1746739497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0h/3+wci/wDkfnyuxg7Yp/2Pi7Vg2ehyC2gUBcQS+UI=;
 b=apMi0VcbLJOmUQfxzcebebDE5mpFi5oEFLUVq7JNVLAcaCY5pHIVSc4Uwr8jVzBitA
 wFWRkafFGADwJOUH31FKIgPqFtLpS3fYxMv0Yj7K9tTm+1cqFPJqM5H2f4lQ7zTBsOrd
 jtBlEmMBPSJMRniVQ8T1ycGFNrV4YYUdgNK8qXAnRgmZIMlArnScS9VddqEK6zraMWzu
 hzsJa2aBQODTq/uvc88D5F7BzKaf/HwvFTIDp+LWgfI9AHyVd6rMCHuZzor5po9gKmQB
 mwIGQ3MSfxWur1Zwptc47o5ZR7OZIcmm2HwQyjmYnY/rbfXEdExCpKVa9m+SNwJJQwiX
 WPdQ==
X-Gm-Message-State: AOJu0YwwBgPTM26CtL/LC2n29yCDc+7a/t7XfeAS+djGuyb1z+hHaKgY
 toL3kS0QcY7pKKKpabjgnC3l7kUDlIidDU++qs6mndRlNJpdC8cpBVaZg2c2cl8JTeXRmWuqMV1
 r
X-Gm-Gg: ASbGnctjlJU3AbMTD+PYdCm0K6h20pwvvFw7NahxIRBcstGlFPlrVhPcctFiVo0A/T4
 53xy5Z080T91jZ6uPqgZsjiKQ7LXOvUCCuOMFYL1kW9P1F8S/eOKK2OhFhLltZ/GCHC9sxCxUDR
 XI/kCrKMJPlyW8qVJTjcs248zRwSTlG51i5wnTukkXFlJOMoZesRE+Z462pFM8n8EuTwT/dh5jw
 WpAO0NZ1PN94z+Ss26U3IhbbJ7HKvoLLJaQx+ejoyg4iNEflm/5vk4iYX0oDmBtA5KinnNyQjrw
 fZCsCwAgh56fV37hkYMxmniChucE0zKektJZZeBmBdUOr55IdPcDdOo6BTMSF1SzQiuP4eqcr/E
 =
X-Google-Smtp-Source: AGHT+IGYhCUJR/7h1UW2GfOf0gtg4jz+iNyKmET3vWT2HT2GLd8QzarRT8M3TWCFEDm7X41XLOOfeA==
X-Received: by 2002:a05:6a00:1c98:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-7405890a994mr741299b3a.3.1746134697434; 
 Thu, 01 May 2025 14:24:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 56/59] accel/tcg: Move TARGET_TAGGED_ADDRESSES to
 TCGCPUOps.untagged_addr
Date: Thu,  1 May 2025 14:21:10 -0700
Message-ID: <20250501212113.2961531-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  7 +++++++
 include/user/guest-host.h   |  8 +++++---
 target/arm/cpu-param.h      |  7 +------
 target/arm/cpu.h            | 32 +-------------------------------
 target/arm/cpu.c            | 27 ++++++++++++++++++++++++++-
 5 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 23cd6af0b2..cd22e5d5b9 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -157,6 +157,13 @@ struct TCGCPUOps {
      */
     void (*record_sigbus)(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra);
+
+    /**
+     * untagged_addr: Remove an ignored tag from an address
+     * @cpu: cpu context
+     * @addr: tagged guest address
+     */
+    vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
 #else
     /** @do_interrupt: Callback for interrupt handling.  */
     void (*do_interrupt)(CPUState *cpu);
diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 0656f2e356..8f7ef75896 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -10,7 +10,7 @@
 
 #include "exec/vaddr.h"
 #include "user/guest-base.h"
-#include "cpu.h"
+#include "accel/tcg/cpu-ops.h"
 
 /*
  * If non-zero, the guest virtual address space is a contiguous subset
@@ -29,12 +29,14 @@ extern unsigned long reserved_va;
  */
 extern unsigned long guest_addr_max;
 
-#ifndef TARGET_TAGGED_ADDRESSES
 static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
 {
+    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+    if (tcg_ops->untagged_addr) {
+        return tcg_ops->untagged_addr(cs, x);
+    }
     return x;
 }
-#endif
 
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
 static inline void *g2h_untagged(vaddr x)
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 5c5bc8a009..8b46c7c570 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -17,14 +17,9 @@
 #endif
 
 #ifdef CONFIG_USER_ONLY
-# ifdef TARGET_AARCH64
-#  define TARGET_TAGGED_ADDRESSES
-# ifdef __FreeBSD__
-#  define TARGET_PAGE_BITS 12
-# else
+# if defined(TARGET_AARCH64) && defined(CONFIG_LINUX)
 /* Allow user-only to vary page size from 4k */
 #  define TARGET_PAGE_BITS_VARY
-# endif
 # else
 #  define TARGET_PAGE_BITS 12
 # endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be4449ca06..23720b2b17 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -783,12 +783,9 @@ typedef struct CPUArchState {
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
-#endif /* CONFIG_USER_ONLY */
-
-#ifdef TARGET_TAGGED_ADDRESSES
     /* Linux syscall tagged address support */
     bool tagged_addr_enable;
-#endif
+#endif /* CONFIG_USER_ONLY */
 } CPUARMState;
 
 static inline void set_feature(CPUARMState *env, int feature)
@@ -3217,34 +3214,7 @@ extern const uint64_t pred_esz_masks[5];
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
 #ifdef CONFIG_USER_ONLY
-
 #define TARGET_PAGE_DATA_SIZE (TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1))
-
-#ifdef TARGET_TAGGED_ADDRESSES
-/**
- * cpu_untagged_addr:
- * @cs: CPU context
- * @x: tagged address
- *
- * Remove any address tag from @x.  This is explicitly related to the
- * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
- *
- * There should be a better place to put this, but we need this in
- * include/exec/cpu_ldst.h, and not some place linux-user specific.
- */
-static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
-{
-    CPUARMState *env = cpu_env(cs);
-    if (env->tagged_addr_enable) {
-        /*
-         * TBI is enabled for userspace but not kernelspace addresses.
-         * Only clear the tag if bit 55 is clear.
-         */
-        x &= sextract64(x, 0, 56);
-    }
-    return x;
-}
-#endif /* TARGET_TAGGED_ADDRESSES */
 #endif /* CONFIG_USER_ONLY */
 
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2020aec54a..45cb6fd7ee 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,7 +2671,31 @@ static const char *arm_gdb_get_core_xml_file(CPUState *cs)
     return "arm-core.xml";
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+/**
+ * aarch64_untagged_addr:
+ *
+ * Remove any address tag from @x.  This is explicitly related to the
+ * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
+ *
+ * There should be a better place to put this, but we need this in
+ * include/exec/cpu_ldst.h, and not some place linux-user specific.
+ *
+ * Note that arm-*-user will never set tagged_addr_enable.
+ */
+static vaddr aarch64_untagged_addr(CPUState *cs, vaddr x)
+{
+    CPUARMState *env = cpu_env(cs);
+    if (env->tagged_addr_enable) {
+        /*
+         * TBI is enabled for userspace but not kernelspace addresses.
+         * Only clear the tag if bit 55 is clear.
+         */
+        x &= sextract64(x, 0, 56);
+    }
+    return x;
+}
+#else
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
@@ -2702,6 +2726,7 @@ static const TCGCPUOps arm_tcg_ops = {
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
+    .untagged_addr = aarch64_untagged_addr,
 #else
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
-- 
2.43.0


