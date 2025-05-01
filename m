Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA2C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVK2-0005i3-T1; Thu, 01 May 2025 10:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJy-0005gJ-EA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJw-0005Ub-DO
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227cf12df27so10358725ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111327; x=1746716127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fVyP76o6EOcJrt7iH7jc6aMX3NadFlFM45GV6fkbfLE=;
 b=BycKXzwagI0bVGVq8e7jJ+R2mglSALWkb10kKRADTMfCEUC9TF5E7PDXX6ntyRYjlw
 0nBTxE28TzvYCGgIA4rWZ+PPcLcQ1h9NB+V7zKw9+uxTqWtc4mQWLp9MnexNT3ntgRN9
 IsiryT8KBI6mUb246xhArSOE7eGCQNnKrccs+2fuAA+xRrkJqKY7KkOlkKY1t60p6Pp4
 Lu5jH0RvKIGSPthMA/NFK793KVlznTLGFOyn/JjoY5PK/1BhxKAZ8klobirIfjYM18cA
 SB7TCigExG0fActklIRYK+bJkWk50sawmeFPSZd0LYvwqskqkCihlpGObP6QJgzl9iGY
 jZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111327; x=1746716127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVyP76o6EOcJrt7iH7jc6aMX3NadFlFM45GV6fkbfLE=;
 b=qF4NEB6Q7q85CucUBi/AHWEMEbGmd+cmTw33Bju0f5kncjbBipK71uijklUCGOheKR
 5NnkPQ0QxbF6lgnKzI50xhgGSvBUymguyC+IbAxZXoyhxFlpYxbJm/Y0fnTEHO7c6ywD
 B8O8hpa6IyFmS64s6hA+c/Zr82U74C238lUxoV3dCfUP3YHXsU1ADOnJThiOYYjinTqn
 llJ/xVLFcS05FDld5N5OoLqk0y8dSq0Dj8s+UvJDmlMZCzkUesOy4bULoBtHLMslx1tm
 KB6IoDICmzKiApelW8qhgeXlK8xthc8dCxcvrCPqYJVJ+IQmT8mqN7hTkGSSflrmt5sx
 k5fA==
X-Gm-Message-State: AOJu0YwmqlEdFF4OmFi4CWlvfeOeBmZFFRC1qoA+3U/dt47SLZ51eojt
 EMkYSr3uJKyp+AVMVrAvAe1nBMGcjsuJAN2bGbNufHxOt6o5k+YA88PzKWErS85yPItsJboCyoJ
 G
X-Gm-Gg: ASbGncv7ldrekLlcaoRWx3gZn54vDKoTocXjIOuLhaY7Gv7TC99R7msZeSM3PWNQzdh
 VW58C1kFP9p/aSAo+VPe/yiqrAZI4gg+sJEbom2yGkRW4/iK+zD+knoxDueACmcH6MabWLMPz2T
 WnqVIycoINaq4/VfguQFyQSirpnTNypHoO7LK5kqZWUCY+RVioEtW5jPRRX4oQjxRq+UcmrgWmr
 2Tatd/ycj2v4bUpUr6Q+Kwr3sxHsJYn1f0DHli2/F51aBIR/asa1B8U/mg6ONZqupWv8WFTMdy/
 4dcn9UvzSshKMdah6OYvVlIemiupMVURx5Zmq9KOdVkqQJD2ih6z359kAuGyZooIRyfZZY1yUlg
 =
X-Google-Smtp-Source: AGHT+IFX9ATLOxHMw0h/lXi+fGjqm8u7aQeLw/DH2KWtQxDcTlm0NIBU5vO5Yk8Xa+KIgT5HKV/aBQ==
X-Received: by 2002:a17:903:41ce:b0:216:4676:dfb5 with SMTP id
 d9443c01a7336-22e087ff587mr39495885ad.21.1746111326809; 
 Thu, 01 May 2025 07:55:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] accel/tcg: Move TARGET_TAGGED_ADDRESSES to
 TCGCPUOps.untagged_addr
Date: Thu,  1 May 2025 07:55:16 -0700
Message-ID: <20250501145520.2695073-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


