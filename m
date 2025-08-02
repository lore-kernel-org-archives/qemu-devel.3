Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFABC87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLwr-0003Q4-Mo; Sat, 02 Aug 2025 19:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLrv-0004Th-3h
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:33 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLrr-0006rq-CG
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:26 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e8e14cf9e2aso2812615276.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754178142; x=1754782942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phDl6U0/TZY10JtlMKITPjr54ln3Z6W42+gDjn37lAM=;
 b=tWCtX7LwASaP/BqLJ/VLgg2nEC+kHs2LjF1v3ytqcxU9gcW6KpOSJhypWK3U5ayXoT
 HoKE0iyiP8v1lkQhB0yHnvGA55zgkmjnZBn6N2YsPoEOskTd1hS+HdaS7WEGvs2Qa4er
 Pchc3til7wg1JK01/wuMwYOPHQi5xPG61eF+93e7jq7tMA7hgr6e+alau/p6L4XJRATJ
 XxnFSG5m8WQSu1mtiDIpPaY0SrXCXMD3hJlx4IdlK4A8utIJ596OvZgtAwTkPxC9JZH7
 ab5kX2U2AYVEfnXUO82qqOPzs4OGWxtRkEXY3lxKE1ysgICWrGRlkn7XTpa0hdzgSMtR
 h4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754178142; x=1754782942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phDl6U0/TZY10JtlMKITPjr54ln3Z6W42+gDjn37lAM=;
 b=GUaAZ4J3P29WNalGID6Z4CAPEOMyTSGtiBb7rqralQp5sy9hbH41b+qy/DuxQNuVCo
 xfLGtd2BZUamcQPYxvb5dlN7L1mcWuLcWS1DnfGsFpaYcKf+6zNkldHImboyrJWvRTgc
 eT9LGorQIFeoU73mvHm/f+mRbTzQD0ROSSafKBpZZx3TNyXvgctL1wkJK9kL9K1QJubA
 phcpqTubAJd3rYoF0jK79XoQ0KY70OIQ5uk3wmuW4LdlM3tjwwr4y7TRtsrOVH5OAxNq
 e+lHr+mop5Qy5EWhsJPccJhXcyWd4jf73AfSnj6YWGrRuB1gqO+raQQwV8KsmLuR2x+I
 +88g==
X-Gm-Message-State: AOJu0YwolvSZiOJhaeDf4T1rjrg7VMn/maG9Osn+s7cLtEKa+c3u1hAO
 ymmnsyfpo392LGcGCGbgbBzLFaMOaJ2pG/mnsLhK5uMBIC9chyVDMiFDFeJ1wHnfGm+uifr4Jo6
 yWGJSVpY=
X-Gm-Gg: ASbGncuWMSOHOKabnmdgeorQkLA+HtoRx8s8WjE4Cux5w3zQH5D02hSHziQLxDAPQ6v
 6Mb8gtUhxiD2wPTQo6u2YCtP9uMwxLA0E4XDzwwn8CopnQ11vA6ms3jClzEUguMXYwwTdxrs7mL
 BGE+Bv+e0xkGZiEpWbRnOXx+V9th/OidI9vi8mpCaZnp95rXgcllTfVLoRBbQfMtyAkzIZC0XkO
 LWeg042kzexxs31h1ufWLmmWQUk2mxoQ+aqEZd1MM0rpdy8E9ZO0vOczDcbJii5fihbI/HKMLIP
 VaQJfY2D7oxYoHmncgrgVV2UzeLfysYpBgQwdDAF8OrP0SmJGfFE2vguY3AagMf8YFp3BeOBwBs
 ZpkNm7BQrt+WJ8ZslQvz5vXjtw8iDPsPV15VPCv743pgVwv6mkIKe
X-Google-Smtp-Source: AGHT+IE3bDgsSnl3CeKolhCyxCECEKWFA/O0rIw8LtgXpByTX17bPwVucPiIzOCrCflSSg/Yzzgn7g==
X-Received: by 2002:a05:690c:4c12:b0:719:5664:87fd with SMTP id
 00721157ae682-71b7f8ca292mr57516807b3.37.1754178141977; 
 Sat, 02 Aug 2025 16:42:21 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a423f38sm18461527b3.40.2025.08.02.16.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:42:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 80/85] linux-user/aarch64: Generate GCS signal records
Date: Sun,  3 Aug 2025 09:29:48 +1000
Message-ID: <20250802232953.413294-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb35.google.com
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
 linux-user/aarch64/signal.c | 129 ++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index ef97be3ac7..a1957a330c 100644
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
@@ -502,6 +542,55 @@ static bool target_restore_zt_record(CPUARMState *env,
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
@@ -511,8 +600,10 @@ static int target_restore_sigframe(CPUARMState *env,
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
@@ -582,6 +673,15 @@ static int target_restore_sigframe(CPUARMState *env,
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
@@ -612,6 +712,10 @@ static int target_restore_sigframe(CPUARMState *env,
         goto err;
     }
 
+    if (gcs && !target_restore_gcs_record(env, gcs, &rebuild_hflags)) {
+        goto err;
+    }
+
     /* SVE data, if present, overwrites FPSIMD data.  */
     if (sve && !target_restore_sve_record(env, sve, sve_size, &svcr)) {
         goto err;
@@ -631,6 +735,9 @@ static int target_restore_sigframe(CPUARMState *env,
     }
     if (env->svcr != svcr) {
         env->svcr = svcr;
+        rebuild_hflags = true;
+    }
+    if (rebuild_hflags) {
         arm_rebuild_hflags(env);
     }
     unlock_user(extra, extra_datap, 0);
@@ -701,7 +808,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0, esr_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -720,6 +827,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
@@ -779,6 +891,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
@@ -786,6 +904,10 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
@@ -811,11 +933,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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


