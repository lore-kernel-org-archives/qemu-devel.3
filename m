Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898CBCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXek-0004V3-7L; Thu, 14 Aug 2025 09:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdy-0003QN-OA
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdm-0005ZY-00
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e34c4ce54so468485b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176706; x=1755781506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lflJ+SmP9/WjBOPLau+3bavo7afA8IIGWLBMr9HKB4c=;
 b=fKNciRcHYNuGPnX2FUaI1U/TZ82Hh4yYMRQ+S5QQfUHOkKvspvCqnj1UfPluexFNDi
 JPToCg7SWiQvEJoRMRmBpCa5+UrV+ZslweVFuEtL6sKQqUGPjEUPO56REr0zIXQHR2PE
 X/klhK0MsSlCJ4ihRXatvKRaGWSbXIouoyAy4Lp0nAkaEsMqttST+sPjC8ZKDO6ICIkj
 lNvWYXGqDQGh1CgINeW6deM8937+2XDOO2LnuqZcy9bHNHnXMI209vKighOdzdOGwaKP
 mrIOgktHiyS3z9aoVkFaBCacJ7HEOAqj+sw6tolwnEMj7SSmhAirLDMJvNfNx6aUT0FM
 OcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176706; x=1755781506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lflJ+SmP9/WjBOPLau+3bavo7afA8IIGWLBMr9HKB4c=;
 b=MMAAJnH1g7D4CRr3931hxqM3fgGbYzrtDe4ciFRcKVpShxptA71gW1gtBUFtyeo1a4
 SiLzCrkbAckZ0XA9GHsGALcB2Rj6IGNExI8zDv2MHXyUtsykDg+njgzFwRJ7uz2/Wz41
 3p+s8H0/APYnrEEnD4Wp29C4D61vT7n5O617JBcxw6trjQo3uNk1MjNp7jMd9sWb517W
 VspMubTudcjorupz3g120XSubZIqZ5U7ORyq8uyYp5bFvnxo+57CQsJ4xWR8BrqWdINh
 egOI5R3F8I/DmyyeYlUiid9MMAn/Hnj9BbgK2eArmyFS6jtTfmbQl7mHZjJW1FGLL2iX
 I09Q==
X-Gm-Message-State: AOJu0YxvAQ39B/GcGgIf/zN+u85DDDBOUEyoZLJO4yr3cIZx9Luu+SRe
 yEClpGo16okkSc+YTzO6uhwMECjy7GVh1btQahHr1/NfbIkDd/s04YnyE0gnCOREbIq7rQ3JTcg
 epXXUA4I=
X-Gm-Gg: ASbGncuPs1w6xbFxozEDqPmAlv8vDEeNP1GJzuniFxpWWYxwEEgosnn142rTHoUiM9W
 bTSd/Phg7+Ao8A5Y6OTd/+3orYmkM1MA5Lr+MKctKSfeUh0w/gDgxZwqHaXjKGCpu7tujg+PNOo
 9IJ+j/lsFUwhCtBsDjzvtAaaYoVsXd6wdKW3PquqYoBZ+9oWIeIC9f4VRGgz2ucRcYojnyx6mPQ
 ML+RG7N6kgYLZjp8/80RkjTGtRba9jLF0kTG0MwR/AtVjK92Xhp+6W2uzo6p87JKZ9pc+XNVwTB
 yyNjdn/VZD6C6aAhXvNQNG4aCU44IdKdEJOiylGU4dClyjqa6s5QEJqe2J5pc+hGPvdu+P17wu4
 XAXmZ4IUUqlwgTQ7LMj1StrfPtdCNKKgiNqEEo8Hk6mcRoLQ=
X-Google-Smtp-Source: AGHT+IGUzJhZb+srcyOhlpR9O+SnFPnKVKso9Y9tMrX2a8W5NPgaMZKm6+7aVvD8ZgLqjU9Ge3BQ2w==
X-Received: by 2002:a05:6a00:2e16:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-76e326f4f0bmr3626162b3a.6.1755176705228; 
 Thu, 14 Aug 2025 06:05:05 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 74/85] linux-user/aarch64: Implement prctls for GCS
Date: Thu, 14 Aug 2025 22:57:41 +1000
Message-ID: <20250814125752.164107-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

This is PR_GET_SHADOW_STACK_STATUS, PR_SET_SHADOW_STACK_STATUS,
and PR_LOCK_SHADOW_STACK_STATUS.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/gcs-internal.h | 38 ++++++++++++
 linux-user/aarch64/target_prctl.h | 96 +++++++++++++++++++++++++++++++
 linux-user/qemu.h                 |  5 ++
 linux-user/syscall.c              | 29 ++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 linux-user/aarch64/gcs-internal.h

diff --git a/linux-user/aarch64/gcs-internal.h b/linux-user/aarch64/gcs-internal.h
new file mode 100644
index 0000000000..e586c7e80e
--- /dev/null
+++ b/linux-user/aarch64/gcs-internal.h
@@ -0,0 +1,38 @@
+/*
+ * AArch64 gcs functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef AARCH64_GCS_INTERNAL_H
+#define AARCH64_GCS_INTERNAL_H
+
+#ifndef PR_SHADOW_STACK_ENABLE
+# define PR_SHADOW_STACK_ENABLE  (1U << 0)
+# define PR_SHADOW_STACK_WRITE   (1U << 1)
+# define PR_SHADOW_STACK_PUSH    (1U << 2)
+#endif
+
+static inline uint64_t gcs_get_el0_mode(CPUArchState *env)
+{
+    uint64_t cr = env->cp15.gcscr_el[0];
+    abi_ulong flags = 0;
+
+    flags |= cr & GCSCR_PCRSEL ? PR_SHADOW_STACK_ENABLE : 0;
+    flags |= cr & GCSCR_STREN ? PR_SHADOW_STACK_WRITE : 0;
+    flags |= cr & GCSCR_PUSHMEN ? PR_SHADOW_STACK_PUSH : 0;
+
+    return flags;
+}
+
+static inline void gcs_set_el0_mode(CPUArchState *env, uint64_t flags)
+{
+    uint64_t cr = GCSCRE0_NTR;
+
+    cr |= flags & PR_SHADOW_STACK_ENABLE ? GCSCR_RVCHKEN | GCSCR_PCRSEL : 0;
+    cr |= flags & PR_SHADOW_STACK_WRITE ? GCSCR_STREN : 0;
+    cr |= flags & PR_SHADOW_STACK_PUSH ? GCSCR_PUSHMEN : 0;
+
+    env->cp15.gcscr_el[0] = cr;
+}
+
+#endif
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index ed75b9e4b5..621be5727f 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -6,8 +6,10 @@
 #ifndef AARCH64_TARGET_PRCTL_H
 #define AARCH64_TARGET_PRCTL_H
 
+#include "qemu/units.h"
 #include "target/arm/cpu-features.h"
 #include "mte_user_helper.h"
+#include "gcs-internal.h"
 
 static abi_long do_prctl_sve_get_vl(CPUArchState *env)
 {
@@ -206,4 +208,98 @@ static abi_long do_prctl_get_tagged_addr_ctrl(CPUArchState *env)
 }
 #define do_prctl_get_tagged_addr_ctrl do_prctl_get_tagged_addr_ctrl
 
+static abi_long do_prctl_get_shadow_stack_status(CPUArchState *env,
+                                                 abi_long arg2)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -TARGET_EINVAL;
+    }
+    return put_user_ual(gcs_get_el0_mode(env), arg2);
+}
+#define do_prctl_get_shadow_stack_status do_prctl_get_shadow_stack_status
+
+static abi_long gcs_alloc(abi_ulong hint, abi_ulong size)
+{
+    /*
+     * Without softmmu, we cannot protect GCS memory properly.
+     * Make do with normal read/write permissions.  This at least allows
+     * emulation of correct programs which don't access the gcs stack
+     * with normal instructions.
+     */
+    return target_mmap(hint, size, PROT_READ | PROT_WRITE,
+                       MAP_PRIVATE | MAP_ANONYMOUS |
+                       (hint ? MAP_FIXED_NOREPLACE : 0), -1, 0);
+}
+
+static abi_ulong gcs_new_stack(TaskState *ts)
+{
+    /* Use guest_stack_size as a proxy for RLIMIT_STACK. */
+    abi_ulong size = MIN(MAX(guest_stack_size / 2, TARGET_PAGE_SIZE), 2 * GiB);
+    abi_ulong base = gcs_alloc(0, size);
+
+    if (base == -1) {
+        return -1;
+    }
+
+    ts->gcs_base = base;
+    ts->gcs_size = size;
+    return base + size - 8;
+}
+
+static abi_long do_prctl_set_shadow_stack_status(CPUArchState *env,
+                                                 abi_long new_mode)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    TaskState *ts = get_task_state(env_cpu(env));
+    abi_long cur_mode;
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -TARGET_EINVAL;
+    }
+    if (new_mode & ~(PR_SHADOW_STACK_ENABLE |
+                     PR_SHADOW_STACK_WRITE |
+                     PR_SHADOW_STACK_PUSH)) {
+        return -TARGET_EINVAL;
+    }
+
+    cur_mode = gcs_get_el0_mode(env);
+    if ((new_mode ^ cur_mode) & ts->gcs_el0_locked) {
+        return -TARGET_EBUSY;
+    }
+
+    if (new_mode & ~cur_mode & PR_SHADOW_STACK_ENABLE) {
+        abi_long gcspr;
+
+        if (ts->gcs_base || env->cp15.gcspr_el[0]) {
+            return -EINVAL;
+        }
+        gcspr = gcs_new_stack(ts);
+        if (gcspr == -1) {
+            return -TARGET_ENOMEM;
+        }
+        env->cp15.gcspr_el[0] = gcspr;
+    }
+
+    gcs_set_el0_mode(env, new_mode);
+    arm_rebuild_hflags(env);
+    return 0;
+}
+#define do_prctl_set_shadow_stack_status do_prctl_set_shadow_stack_status
+
+static abi_long do_prctl_lock_shadow_stack_status(CPUArchState *env,
+                                                  abi_long arg2)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    TaskState *ts = get_task_state(env_cpu(env));
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -EINVAL;
+    }
+    ts->gcs_el0_locked |= arg2;
+    return 0;
+}
+#define do_prctl_lock_shadow_stack_status do_prctl_lock_shadow_stack_status
+
 #endif /* AARCH64_TARGET_PRCTL_H */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 0b19fa43e6..6f0bfa83db 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -126,6 +126,11 @@ struct TaskState {
     /* Extra fields for semihosted binaries.  */
     abi_ulong heap_base;
     abi_ulong heap_limit;
+#endif
+#if defined(TARGET_AARCH64)
+    vaddr gcs_base;
+    abi_ulong gcs_size;
+    abi_ulong gcs_el0_locked;
 #endif
     abi_ulong stack_base;
     int used; /* non zero if used */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..2f1e881046 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6351,6 +6351,11 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SME_VL_LEN_MASK  0xffff
 # define PR_SME_VL_INHERIT   (1 << 17)
 #endif
+#ifndef PR_GET_SHADOW_STACK_STATUS
+# define PR_GET_SHADOW_STACK_STATUS  74
+# define PR_SET_SHADOW_STACK_STATUS  75
+# define PR_LOCK_SHADOW_STACK_STATUS 76
+#endif
 
 #include "target_prctl.h"
 
@@ -6397,6 +6402,15 @@ static abi_long do_prctl_inval1(CPUArchState *env, abi_long arg2)
 #ifndef do_prctl_sme_set_vl
 #define do_prctl_sme_set_vl do_prctl_inval1
 #endif
+#ifndef do_prctl_get_shadow_stack_status
+#define do_prctl_get_shadow_stack_status do_prctl_inval1
+#endif
+#ifndef do_prctl_set_shadow_stack_status
+#define do_prctl_set_shadow_stack_status do_prctl_inval1
+#endif
+#ifndef do_prctl_lock_shadow_stack_status
+#define do_prctl_lock_shadow_stack_status do_prctl_inval1
+#endif
 
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
@@ -6467,6 +6481,21 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
             return -TARGET_EINVAL;
         }
         return do_prctl_get_tagged_addr_ctrl(env);
+    case PR_GET_SHADOW_STACK_STATUS:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        return do_prctl_get_shadow_stack_status(env, arg2);
+    case PR_SET_SHADOW_STACK_STATUS:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        return do_prctl_set_shadow_stack_status(env, arg2);
+    case PR_LOCK_SHADOW_STACK_STATUS:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        return do_prctl_lock_shadow_stack_status(env, arg2);
 
     case PR_GET_UNALIGN:
         return do_prctl_get_unalign(env, arg2);
-- 
2.43.0


