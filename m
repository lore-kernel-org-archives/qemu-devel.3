Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33AC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSTo-0001jl-Gw; Mon, 28 Jul 2025 14:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPK-0004q3-E4
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPG-0002o2-AW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-74b54af901bso3095747b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726619; x=1754331419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfGX3eeD+sHdn1VkUERVdzReu/X7JSfH2n6SpQNFaMI=;
 b=k5tNAe50nqq25UDxU+/jhZG1Z/Xp3ViMwd3rbiv1HeyXF83//yqGOALiEXbdptPiCR
 Q+BXLu/rU/i5tNPIw6gF1JJ1a2PoT/0/CcZ0zxptnguezRChBZzu9PF8S7oTxik9xpJt
 mziCh5+6AGr4hEO3ooC6Dny8TGWfl0Y60rX02j6vvT5qRDo6FzSMqnUjvO57go9fx1P1
 PKt5THK7RyPjhlrvisOUG2RUGY+IwmJtVfXdqt1yoBc/rP82cyMAa4D3GKoxIFDnE6dO
 /GtYEuq47JXOCHbeuMsuuqtRPK9fhJCKPburr8v0SvQNDzDavNwtp8ESgWKZkItqiesx
 Xvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726619; x=1754331419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfGX3eeD+sHdn1VkUERVdzReu/X7JSfH2n6SpQNFaMI=;
 b=rYRHfGPwvHNOGXevKRaQyq5hPNb2Itcp+JZuF8mmxmhObLIfen5751o/T6pvjJygl9
 qEG3H/hP2GAxsqGi6EtaNIaJXJ5kR0X4NsvPgl5HpLfk7lbUAstR+kN0o6TX+LfL4ukv
 iqL3NVCObVwzatB7ZXG4unw7h6bxlXgU2a1rHyJhEANibfnpVILFNklUJNYgtH9TEsIy
 2UT1iJhHAh8xd3bU8NtAug5lrxoMc9q2HPlGkNRw3QA5CG38JthGxW+o7tgeDl/OaBIs
 sh7CJZIK+SNu3dBOvYwE8XVAOV3ChGzoGz7gvh6D4MksNGoIEBtELtyYVWEtQbV13Tqq
 vyLQ==
X-Gm-Message-State: AOJu0YzI38WUOIpiwMmFjg6NSq/2sJ9rEMSZThraoHi/WpkZ/tCZp544
 jlSWzcpEfEUz7bKxRBWsSxAvGufi9PXXjwmK8ZIlGnxOD5UviPNJMnYxD0rQsfu45SHdUFiYhnV
 mXFDo
X-Gm-Gg: ASbGncv79x8EJ05CE5eorRqHKKmISUdP3yWj2I9BPiI5bGbteue/22IXnseZnGOUDU8
 pscvh+55Prf1cegYsYgOoSVxfUrEtSePCLwmDWqd2IQLfuyKS5l2SuP794mju1XVq0ES+SepbuP
 3/SNkUJzaOSnH88SIfbXGI3f5FkNNDzf0VGb4u3cTO3zj6ocDqgOkFybIZCX8bvs/+H8KsOwnT7
 sWVtvafWSAdI+iw1QXugiX2rDo8exsX1Y/IzWcza/kQsMTK5Tj+jrJEAt4X3BQ4nGxTTDFSx90X
 GBYwxYYQneXAm+e77z8olq8zHwMIl0gidGLIttrstfAfAO/DTyQok+B1QHUYHTnv6IYs+hGHJmY
 pF4sGgUMH+VJSQNf3B3D60BVuOTuWk3LRsEr3ANkWWy73kYPkBPgOxYQlV5umT1WtfmN94Xm1Cu
 P+bkWWlaphLA==
X-Google-Smtp-Source: AGHT+IFGsipwBhHXzC1vrqpj+DjfYa44HqBE4MA0F9Uxs11Sm7FoThCtaLAF6/w+XzXdlXcuc8vz2g==
X-Received: by 2002:a05:6a00:1305:b0:748:fb7c:bbe0 with SMTP id
 d2e1a72fcca58-7633965f00emr18858010b3a.24.1753726619259; 
 Mon, 28 Jul 2025 11:16:59 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:16:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/9] target/arm/sme: Reset SVE state in aarch64_set_svcr()
Date: Mon, 28 Jul 2025 08:16:45 -1000
Message-ID: <20250728181650.165114-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Move arm_reset_sve_state() calls to aarch64_set_svcr().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-5-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7f2a01e7368f960fadea38f437d0f6de7f249686)
---
 target/arm/cpu.h              |  1 -
 linux-user/aarch64/cpu_loop.c |  1 -
 linux-user/aarch64/signal.c   |  8 +-------
 target/arm/helper.c           | 13 +++++++++++++
 target/arm/sme_helper.c       | 10 ----------
 5 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8acfd3af4c..02a084c962 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1119,7 +1119,6 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask);
-void arm_reset_sve_state(CPUARMState *env);
 
 /*
  * SVE registers are encoded in KVM's memory in an endianness-invariant format.
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index d53742e10b..5e93d27d8f 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -96,7 +96,6 @@ void cpu_loop(CPUARMState *env)
             aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
             if (FIELD_EX64(env->svcr, SVCR, SM)) {
                 arm_rebuild_hflags(env);
-                arm_reset_sve_state(env);
             }
             ret = do_syscall(env,
                              env->xregs[8],
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b6e4dcb494..a326a6def5 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -665,14 +665,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         env->btype = 2;
     }
 
-    /*
-     * Invoke the signal handler with both SM and ZA disabled.
-     * When clearing SM, ResetSVEState, per SMSTOP.
-     */
+    /* Invoke the signal handler with both SM and ZA disabled. */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
-    if (FIELD_EX64(env->svcr, SVCR, SM)) {
-        arm_reset_sve_state(env);
-    }
     if (env->svcr) {
         arm_rebuild_hflags(env);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 86b97daf7e..94a6f431a9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6429,11 +6429,24 @@ static CPAccessResult access_esm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* ResetSVEState */
+static void arm_reset_sve_state(CPUARMState *env)
+{
+    memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
+    /* Recall that FFR is stored as pregs[16]. */
+    memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
+    vfp_set_fpcr(env, 0x0800009f);
+}
+
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
 {
     uint64_t change = (env->svcr ^ new) & mask;
 
     env->svcr ^= change;
+
+    if (change & R_SVCR_SM_MASK) {
+        arm_reset_sve_state(env);
+    }
 }
 
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 7717dab64f..56a8fbe691 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -29,22 +29,12 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
-/* ResetSVEState */
-void arm_reset_sve_state(CPUARMState *env)
-{
-    memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
-    /* Recall that FFR is stored as pregs[16]. */
-    memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
-    vfp_set_fpsr(env, 0x0800009f);
-}
-
 void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
 {
     if (i == FIELD_EX64(env->svcr, SVCR, SM)) {
         return;
     }
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-    arm_reset_sve_state(env);
     arm_rebuild_hflags(env);
 }
 
-- 
2.43.0


