Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CBBC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMdh-0007zI-Dn; Fri, 25 Jul 2025 13:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMdb-0007l0-Ga
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:55:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMdY-0001lF-F9
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:55:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so2140204f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753466115; x=1754070915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cx/FbVm1MdKSCrBP/0m/5JMlptiQo4e2+krFmi0/nrw=;
 b=AbLkFLQKuRr4KntIwtOb/w/ltIe+kj4H76aMEXbr6ZZWHe6Mh6lnat/Ks2Ty3xOuRq
 fgWaKltTMMLHDsnuOfHIY4vDpkOGnSbSkeagUYLduFiTRQgxYKzbDWvMkTDYEoF/S08j
 gBiWtDz2zuT6vN2CfNI/Tp0XqEEElNGM/w7sCHporwKOKEJSaurQIKbxOG3lM9r6ACHU
 M8pCAxdopdYCCD8wdUgU/NLLBb63iQWQm/nyM8Yw4zlWAsuiO2rRqW+yH3xWRR7e9/xN
 xUxszHR+2eQHWEQ+jVm2I7vvW5gqU9nflKcSUke2GIOdOyqt0szhD3d70PWcoMqpAN6P
 QFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753466115; x=1754070915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cx/FbVm1MdKSCrBP/0m/5JMlptiQo4e2+krFmi0/nrw=;
 b=aNBp476LxV8qqjxU4Flx2kl5cpuuVGpsz+lWGVvvWYe0m9C7/NZsNF+X5RqrJ1jrNN
 JxOtiyg/rEBkPActBCqOPj5SXCVmlAyLgkt4BVf375mq0YpK7HCxJO8+Q1BIVbgh5NOc
 McGLqYKJ4H9D5Py6+lUx4T0ONO5p6tmudYUgctMc6lqMFQAYmp65Nbs8JYVZ7QCC+hbk
 P0QBCj1cim44f7+r2k5Yvpro2vjh6tB+iP/zQ55+77KoN/F0aneuMQClaKUgIOjcmo33
 HP6Z+TldWIff2GIrrX8i/Y9Bxsqmaj3q6kDwGgwzqkKvnQ0WkhJL9K4COlbCwLiUoDxe
 dD6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI4HD83CAS/Y25UkaHA4IlpUtNJWu/Icq9TT2xQSzsTFeO4aEIVYHz4TkTS5Ud8oPPSV9OXPfToCLC@nongnu.org
X-Gm-Message-State: AOJu0YwK6Rfx3tRQvQWja/G65QxU0eMMAx72WlqPZBprpKzB4mADQpg3
 4KsvvcfX/Kdd2FJV978gxOKU6NEMOHbjDsaKzxX58KLulXekxVnnTNUvRYcQ5CTmLcg=
X-Gm-Gg: ASbGncuoqDFH5ZTeS+FFJ3PZBsaoTDbf6ZAWcd7j+V8Z1J+qXcmV+0pBuPtN0SBQUdW
 UAzZEtQTuFjdh9YEzcCeKZgkrrAwOdsohGPIuVxrTH5fBNsG57ASe+OluY8TmSDzV+bAKf1QDqK
 VdR/cQjaPA44IOF4QbTjsKtdo3sj1/0GUhpyHPpPyVvxiNbkQANQgIF1kWEZko/PYi3VQMBfE//
 dJY56CCaTtow3iSjqRMxklKJha4ap8tY4GsIoqruPYYdjtK9xMttCw4F9y9d/4Vj2ha00KM0kyh
 DFIjiHxgtX7rSpg9uPl1Yb0HQ/QOXCUqzDyzCp3sxQcnbA0gC6cfu+ntWp2Mvhwxko/FGycZV6Y
 8JOUTs6ofkGjRF6FHmALGvA7jiqtVCBG2yHhBmVw=
X-Google-Smtp-Source: AGHT+IEiK5CMo80OC7n6T0I4IvROf2tZ6KsnL7fllzzYaEqX9+HqypsPftb3El2Xt8A5TFkOx5HsdQ==
X-Received: by 2002:a05:6000:401e:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b7765e6070mr2960761f8f.6.1753466114792; 
 Fri, 25 Jul 2025 10:55:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f16819sm499036f8f.67.2025.07.25.10.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 10:55:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 for-10.1 2/3] linux-user/aarch64: Support TPIDR2_MAGIC
 signal frame record
Date: Fri, 25 Jul 2025 18:55:09 +0100
Message-ID: <20250725175510.3864231-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725175510.3864231-1-peter.maydell@linaro.org>
References: <20250725175510.3864231-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

FEAT_SME adds the TPIDR2 userspace-accessible system register, which
is used as part of the procedure calling standard's lazy saving
scheme for the ZA registers:
 https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving-scheme

The Linux kernel has a signal frame record for saving
and restoring this value when calling signal handlers, but
we forgot to implement this. The result is that code which
tries to unwind an exception out of a signal handler will
not work correctly.

Add support for the missing record.

Cc: qemu-stable@nongnu.org
Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 42 +++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 6514b73ad98..f28ba807549 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -121,6 +121,13 @@ struct target_za_context {
 #define TARGET_ZA_SIG_CONTEXT_SIZE(VQ) \
     TARGET_ZA_SIG_ZAV_OFFSET(VQ, VQ * TARGET_SVE_VQ_BYTES)
 
+#define TARGET_TPIDR2_MAGIC 0x54504902
+
+struct target_tpidr2_context {
+    struct target_aarch64_ctx head;
+    uint64_t tpidr2;
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -253,6 +260,14 @@ static void target_setup_za_record(struct target_za_context *za,
     }
 }
 
+static void target_setup_tpidr2_record(struct target_tpidr2_context *tpidr2,
+                                       CPUARMState *env)
+{
+    __put_user(TARGET_TPIDR2_MAGIC, &tpidr2->head.magic);
+    __put_user(sizeof(struct target_tpidr2_context), &tpidr2->head.size);
+    __put_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -403,6 +418,12 @@ static bool target_restore_za_record(CPUARMState *env,
     return true;
 }
 
+static void target_restore_tpidr2_record(CPUARMState *env,
+                                         struct target_tpidr2_context *tpidr2)
+{
+    __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -410,6 +431,7 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_fpsimd_context *fpsimd = NULL;
     struct target_sve_context *sve = NULL;
     struct target_za_context *za = NULL;
+    struct target_tpidr2_context *tpidr2 = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     int sve_size = 0;
@@ -460,6 +482,14 @@ static int target_restore_sigframe(CPUARMState *env,
             za_size = size;
             break;
 
+        case TARGET_TPIDR2_MAGIC:
+            if (tpidr2 || size != sizeof(struct target_tpidr2_context) ||
+                !cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+                goto err;
+            }
+            tpidr2 = (struct target_tpidr2_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -497,6 +527,9 @@ static int target_restore_sigframe(CPUARMState *env,
     if (za && !target_restore_za_record(env, za, za_size, &svcr)) {
         goto err;
     }
+    if (tpidr2) {
+        target_restore_tpidr2_record(env, tpidr2);
+    }
     if (env->svcr != svcr) {
         env->svcr = svcr;
         arm_rebuild_hflags(env);
@@ -568,8 +601,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         .total_size = offsetof(struct target_rt_sigframe,
                                uc.tuc_mcontext.__reserved),
     };
-    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0;
-    int sve_size = 0, za_size = 0;
+    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
+    int sve_size = 0, za_size = 0, tpidr2_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -585,6 +618,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         sve_ofs = alloc_sigframe_space(sve_size, &layout);
     }
     if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+        tpidr2_size = sizeof(struct target_tpidr2_context);
+        tpidr2_ofs = alloc_sigframe_space(tpidr2_size, &layout);
         /* ZA state needs saving only if it is enabled.  */
         if (FIELD_EX64(env->svcr, SVCR, ZA)) {
             za_size = TARGET_ZA_SIG_CONTEXT_SIZE(sme_vq(env));
@@ -644,6 +679,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     if (za_ofs) {
         target_setup_za_record((void *)frame + za_ofs, env, za_size);
     }
+    if (tpidr2_ofs) {
+        target_setup_tpidr2_record((void *)frame + tpidr2_ofs, env);
+    }
 
     /* Set up the stack frame for unwinding.  */
     fr = (void *)frame + fr_ofs;
-- 
2.43.0


