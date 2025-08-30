Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BCACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOGO-0003i3-0B; Sat, 30 Aug 2025 12:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUp-0008U8-MG
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUn-0005ii-GK
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-771f90a45easo2361347b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756533084; x=1757137884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUo2eLEQH3tvadRbtyXeqZmXKqgrSzHJmdQtpKn9Hto=;
 b=tGOOEv4ABUASuWiAsfrgXjG40kr1jLAN5L1NpAa5PDCA2g0RtjyDfw09aRcuq+PVFp
 SS0d9dy8F4SpXTkfKDXIwWVlYDFi9S/7xfQyxtYvbbFUtxhNGM+T0jNGInhJsqjPwyZt
 nDgWLE3S7jqNzEaPFLzpWCF4eCgzbyvANrLnHnY3FkwC3LJW6iR4bnqhccxaazERHe0K
 fpKP63kUAb8rPuLm6D9iwSq2gQhF0wmIsdEOZZjDDncB/Xb+96T062APH4MCJP7JRDpM
 7g1pbP1L0yz1aelMxaDP0cdsblhVjZGAJsX79xzwYAmlOvSvDS5oRBCE0AR90NPb63sE
 +sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756533084; x=1757137884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUo2eLEQH3tvadRbtyXeqZmXKqgrSzHJmdQtpKn9Hto=;
 b=FIVN0y+gRnFGZ/q6P/MVI1sFtUZxWMxhCVq0h5U6pQnN9isMdPHQYpPIpZLmBmANC0
 2VZ8XyJev3Z/Tn5ma5/GI6KO+v7x6Lye0UHTsUIbO5BwvW5e3HDT+ifM9yPh+ESYgZ7U
 cjX6hIRoPvohMt1NweNF4LBpYMpeq8DaE647CrkID+OxX56bqHhCMYP/6l9hh9SMhfOM
 ZdzS7LOcBrZSXNWVtJMZHEz3QIvhyHeWopm+51FjLsFGrllh8ZioPNSSTc1xYzJsO7yg
 O10Q+76OwqBkjhWDxjHtntA6UtDgCmN12Eg66dqL2L0wDki5tySMh8UY0Y3oeB1zj1o7
 l6Zg==
X-Gm-Message-State: AOJu0Yz8cjLzf2RBUfFhaccLF/jnc+k+A0iScRLJiYMQk3HfwUWK12pB
 Jp0B470BB01diO6RqAKcia2Gylfl/FRuEl6aqPg/LMebJUa3EwX+9F9q+ahh/UH+rn/xNOW6zbG
 QCZnqThc=
X-Gm-Gg: ASbGncvCD2/I/m5XV18jsyU7olCFUto7PLppBiFVsQqKJuGzP3C2MhK8/eIQ9B2nODR
 5Lm6duAlar8vGU67vzIEWj4BVeeTKaJgf1Pq+pxSzuBVg8PWNAG2JbQBtTKsKnLThxRvwlXo93G
 xN8zCk+FcFdqfgk5xEvBITaKCc42hIfAOV55wneMuF4n1vofWfFSEgvCrTm+AuoCAqn6rXR/cr9
 FvLiQtbI1yZdCvpOKfNIkeQn4gB67ufkm7ZHV0zhZwuDobmmmnYsb6H1sW+B3AeLL7eGbRgUq09
 r2/1UNyzPJClT0+Li8cmUJSJ6gHZRUnAppuEMIMFjff5NxI9xhT8pf312eeS600rqwqKEoantX+
 AWK/qfDuXqf+G1YU6XEhCD6/WH8EqG0KEL6a/wWGSC+6TO7VOq4TTp3+r4v0E
X-Google-Smtp-Source: AGHT+IGHPHpYMvEEG9zuAmwstHsI6ED8QCyZyzokxuKKz5xA+ohnxq/dWxVYswzt9+7JrRoACGEy7A==
X-Received: by 2002:a05:6a00:928b:b0:76b:f2d9:c760 with SMTP id
 d2e1a72fcca58-7723e21a73cmr1312092b3a.7.1756533084071; 
 Fri, 29 Aug 2025 22:51:24 -0700 (PDT)
Received: from stoup.. (122-150-204-64.dyn.ip.vocus.au. [122.150.204.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2b7d10sm4198475b3a.33.2025.08.29.22.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:51:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 80/84] linux-user/aarch64: Generate GCS signal records
Date: Sat, 30 Aug 2025 15:41:24 +1000
Message-ID: <20250830054128.448363-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Here we must push and pop a cap on the GCS stack as
well as the gcs record on the normal stack.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 138 ++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 6 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index ef97be3ac7..f7edfa249e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -22,6 +22,7 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 #include "target/arm/cpu-features.h"
+#include "gcs-internal.h"
 
 struct target_sigcontext {
     uint64_t fault_address;
@@ -152,6 +153,16 @@ struct target_zt_context {
 QEMU_BUILD_BUG_ON(TARGET_ZT_SIG_REG_BYTES != \
                   sizeof_field(CPUARMState, za_state.zt0));
 
+#define TARGET_GCS_MAGIC       0x47435300
+#define GCS_SIGNAL_CAP(X)      ((X) & TARGET_PAGE_MASK)
+
+struct target_gcs_context {
+    struct target_aarch64_ctx head;
+    uint64_t gcspr;
+    uint64_t features_enabled;
+    uint64_t reserved;
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -322,6 +333,35 @@ static void target_setup_zt_record(struct target_zt_context *zt,
     }
 }
 
+static bool target_setup_gcs_record(struct target_gcs_context *ctx,
+                                    CPUARMState *env, uint64_t return_addr)
+{
+    uint64_t mode = gcs_get_el0_mode(env);
+    uint64_t gcspr = env->cp15.gcspr_el[0];
+
+    if (mode & PR_SHADOW_STACK_ENABLE) {
+        /* Push a cap for the signal frame. */
+        gcspr -= 8;
+        if (put_user_u64(GCS_SIGNAL_CAP(gcspr), gcspr)) {
+            return false;
+        }
+
+        /* Push a gcs entry for the trampoline. */
+        if (put_user_u64(return_addr, gcspr - 8)) {
+            return false;
+        }
+        env->cp15.gcspr_el[0] = gcspr - 8;
+    }
+
+    __put_user(TARGET_GCS_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(gcspr, &ctx->gcspr);
+    __put_user(mode, &ctx->features_enabled);
+    __put_user(0, &ctx->reserved);
+
+    return true;
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -502,6 +542,64 @@ static bool target_restore_zt_record(CPUARMState *env,
     return true;
 }
 
+static bool target_restore_gcs_record(CPUARMState *env,
+                                      struct target_gcs_context *ctx,
+                                      bool *rebuild_hflags)
+{
+    TaskState *ts = get_task_state(env_cpu(env));
+    uint64_t cur_mode = gcs_get_el0_mode(env);
+    uint64_t new_mode, gcspr;
+
+    __get_user(new_mode, &ctx->features_enabled);
+    __get_user(gcspr, &ctx->gcspr);
+
+    /*
+     * The kernel pushes the value through the hw register:
+     * write_sysreg_s(gcspr, SYS_GCSPR_EL0) in restore_gcs_context,
+     * then read_sysreg_s(SYS_GCSPR_EL0) in gcs_restore_signal.
+     * Since the bottom 3 bits are RES0, this can (CONSTRAINED UNPREDICTABLE)
+     * force align the value.  Mirror the choice from gcspr_write().
+     */
+    gcspr &= ~7;
+
+    if (new_mode & ~(PR_SHADOW_STACK_ENABLE |
+                     PR_SHADOW_STACK_WRITE |
+                     PR_SHADOW_STACK_PUSH)) {
+        return false;
+    }
+    if ((new_mode ^ cur_mode) & ts->gcs_el0_locked) {
+        return false;
+    }
+    if (new_mode & ~cur_mode & PR_SHADOW_STACK_ENABLE) {
+        return false;
+    }
+
+    if (new_mode & PR_SHADOW_STACK_ENABLE) {
+        uint64_t cap;
+
+        /* Pop and clear the signal cap. */
+        if (get_user_u64(cap, gcspr)) {
+            return false;
+        }
+        if (cap != GCS_SIGNAL_CAP(gcspr)) {
+            return false;
+        }
+        if (put_user_u64(0, gcspr)) {
+            return false;
+        }
+        gcspr += 8;
+    } else {
+        new_mode = 0;
+    }
+
+    env->cp15.gcspr_el[0] = gcspr;
+    if (new_mode != cur_mode) {
+        *rebuild_hflags = true;
+        gcs_set_el0_mode(env, new_mode);
+    }
+    return true;
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -511,8 +609,10 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_za_context *za = NULL;
     struct target_tpidr2_context *tpidr2 = NULL;
     struct target_zt_context *zt = NULL;
+    struct target_gcs_context *gcs = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
+    bool rebuild_hflags = false;
     int sve_size = 0;
     int za_size = 0;
     int zt_size = 0;
@@ -582,6 +682,15 @@ static int target_restore_sigframe(CPUARMState *env,
             zt_size = size;
             break;
 
+        case TARGET_GCS_MAGIC:
+            if (gcs
+                || size != sizeof(struct target_gcs_context)
+                || !cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
+                goto err;
+            }
+            gcs = (struct target_gcs_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -612,6 +721,10 @@ static int target_restore_sigframe(CPUARMState *env,
         goto err;
     }
 
+    if (gcs && !target_restore_gcs_record(env, gcs, &rebuild_hflags)) {
+        goto err;
+    }
+
     /* SVE data, if present, overwrites FPSIMD data.  */
     if (sve && !target_restore_sve_record(env, sve, sve_size, &svcr)) {
         goto err;
@@ -631,6 +744,9 @@ static int target_restore_sigframe(CPUARMState *env,
     }
     if (env->svcr != svcr) {
         env->svcr = svcr;
+        rebuild_hflags = true;
+    }
+    if (rebuild_hflags) {
         arm_rebuild_hflags(env);
     }
     unlock_user(extra, extra_datap, 0);
@@ -701,7 +817,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0, esr_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -720,6 +836,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                        &layout);
     }
 
+    if (env->cp15.gcspr_el[0]) {
+        gcs_ofs = alloc_sigframe_space(sizeof(struct target_gcs_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -779,6 +900,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        return_addr = ka->sa_restorer;
+    } else {
+        return_addr = default_rt_sigreturn;
+    }
+
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
     if (esr_ofs) {
@@ -786,6 +913,10 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         /* Leave ESR_EL1 clear while it's not relevant. */
         env->cp15.esr_el[1] = 0;
     }
+    if (gcs_ofs &&
+        !target_setup_gcs_record((void *)frame + gcs_ofs, env, return_addr)) {
+        goto give_sigsegv;
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
@@ -811,11 +942,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     __put_user(env->xregs[29], &fr->fp);
     __put_user(env->xregs[30], &fr->lr);
 
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        return_addr = ka->sa_restorer;
-    } else {
-        return_addr = default_rt_sigreturn;
-    }
     env->xregs[0] = usig;
     env->xregs[29] = frame_addr + fr_ofs;
     env->xregs[30] = return_addr;
-- 
2.43.0


