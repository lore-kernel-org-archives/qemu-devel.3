Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F467CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lit-0001Tj-Sv; Mon, 22 Sep 2025 14:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgS-0006Au-UE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:49 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfU-00051b-60
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:44 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b54d23714adso3717502a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567217; x=1759172017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTzcUGGxZsq7kEwv6ih902moRlxo1N6PG0gX7nMiQJ4=;
 b=Vh6n8oCnixhDQzUJ1B3mrpzj5gmLOFbc44Q0/gTzdTTxOGBFYAXYRqvobe6kRuRLAg
 yvXVclC5K46OfP8+cuDclcKb5j2sO6bTgNDWMYD2NVZudQZijpf5vozCmZHxgQAWdAEM
 40kHAtdVn8siCz+ipAjQxUUN+OXuCM3MeYCRHwKSi2o7ueoZy3T9Ui21ltPSDmAEsmnq
 tbHEduwXsfxJU2NrKzdOpfq669HirAPKSBsk+CjrGEvGj4nbUARhUxvHT4okFaFA1G1G
 vO1AqVzSNCyTsaD5x5Vaw2M6xeIejGOyLiKcD3Gx20MPQj5yivPXHhabVNtUSYfXKnYi
 BeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567217; x=1759172017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTzcUGGxZsq7kEwv6ih902moRlxo1N6PG0gX7nMiQJ4=;
 b=wabNFWnOkX8Xn6S5MB0I/hpyr5bWM0NJzd6g6ctbplQd/o1JugmZ2ehLgpgpuqTMct
 wuVj3sPyPo0cixuy/PAC11Via/HuywRSkStGoCdfqVt4D6c4s05HX5yvZAI7d/gbZKK6
 P06Bp1SP2EfVi517pmLzf7RlZtVODLRSV8UqrgwDpkEbdZ8e+mQbCech2muSsm9TR679
 F3Mw8/HkKlAub1kU13Qyg2qqdLwPm9HJa3OwnMeZs86UsrXig4ABy1FXKGWkw43xqZXe
 H/eAYlXx47MWScp6OQ9xcO6qg8x2DRS972CVfXAT1WCDR+Q5rYAv5fZjTDJN+DqL8Uae
 60Qw==
X-Gm-Message-State: AOJu0YxvyteSKNyzZes1YHbL6GbmYt6szpy6izw0BeP9NuNLIxm0OslU
 GuEKb4pGeM5LccgWvcSHXtL4E2VYO5sCHDdU6g8+N/+R22H6Nho+Ne44pPhPzJ4s3lhzaJ1M0w+
 M15nz
X-Gm-Gg: ASbGncuTUX3VQ+v4espC3qWsGD+oBfnCWNWUtILfZgQir9OVvFWyMGTL8uhtPQES+Gi
 AlYZDFW+A0aUEZ/wmyaMKZ7fP/6ZfuoCCb37BDGFwaMGlCNq+uY6vFBJpz2Rc2WLrWkrqtnRFMN
 sPRQSx8egvkn0rG3GCnYxxc75mIOMNop/EoA3In8i6Q4wxBMVfjQd2YOYbnkAv3/9LtKIfC7V1C
 ly49qYI39ow1GgMM4eY2LSt17pyfkaDGekkcX0d3ryuQh6t+TAf8EOZXFsMRcvj3YPd6VnFcgvb
 /dcFgmtjBLUxwHIoxbK3gxHrz5sStqcFSKsDtMBj7H1D7rvNTTx95ga+gUESEvXoTfl84vB+DP2
 qMaWLwPd+6HrWMXfr+4Ajq89XKeleyXG2uZEslEo=
X-Google-Smtp-Source: AGHT+IH+FILoO9HJXDbPYVUlpSRBnLg4zA5CUTNLDJBhd8WgogoRfCUuu+0QBk/cDhb9S9Sd+CkV/w==
X-Received: by 2002:a17:902:fc8f:b0:267:fa8d:29a6 with SMTP id
 d9443c01a7336-269b9cc7179mr167918565ad.25.1758567217495; 
 Mon, 22 Sep 2025 11:53:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 66/76] linux-user/aarch64: Implement prctls for GCS
Date: Mon, 22 Sep 2025 11:49:14 -0700
Message-ID: <20250922184924.2754205-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index e4dca0c20f..8a0d240405 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -121,6 +121,11 @@ struct TaskState {
     abi_ulong child_tidptr;
 #ifdef TARGET_M68K
     abi_ulong tp_value;
+#endif
+#if defined(TARGET_AARCH64)
+    vaddr gcs_base;
+    abi_ulong gcs_size;
+    abi_ulong gcs_el0_locked;
 #endif
     int used; /* non zero if used */
     struct image_info *info;
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


