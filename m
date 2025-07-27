Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D34C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufvx2-0001s3-F3; Sun, 27 Jul 2025 03:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvwz-0001bb-UW
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:41 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvwu-0000Qt-1H
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:41 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so2399752a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753601854; x=1754206654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DLT5kPT2st9uLIffRQa9ZE7Wu7o06Vv+AiBdjjBCGA=;
 b=ro12tOjRLjPVD8iIgR2erZyOOx/kVYmwOoKNmucu2xPzSH1jnOnX7giD0UFWu9MyV5
 rosfhZQ52FYmCd9U/tuJuBF6vc6cCjyuy+1bmX5UmkBTRPmCCkeP8644ThwerH3A8LqB
 UKtFWdDIwLzT/3qtD+dnom6ukEArEO3LVUZ1yqDGcn5SlJLeTSQV5JBRC0xiVI2HNxpx
 X9j1c4gegPKdfJZwxVljHFuY2FixyDmjYQvOHDxVKROYvSngFijWlUZbE0/rCQ2chEaz
 /hAnX4Cf3NlnKuOmWF+J6wTE6DYpJ3gVQLLPmDq1zfjMD2jB+wc0SNn1IkvNdwuObvsU
 sHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753601854; x=1754206654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DLT5kPT2st9uLIffRQa9ZE7Wu7o06Vv+AiBdjjBCGA=;
 b=EgKg7tykOpHx+2zSAs/MDsfAv2cBXymWbof6bTaSsUOYlts/nvP4QySeJASVf+eksF
 6ymkKZtjtdshMbIgiwjomuS0PDyRkSg8ZFjTzg9hV7mY0NBdBYS0xM6e7mh42FhMUyQu
 0E6WEnbrlK5HdqMs7XeB5uZPbcCBiHESwiZi0a3G58ndvrdSbdHMapKAuCogL92zybXz
 8rklgx8M5UGT6qRJcmv8jTgzH3ZNwtCGDiptRHt1wXADA+8mt7je4j4k3UCpqS9LOIAH
 j02Dr9+ReAeet9gEuot3RRWJhiuVU65VMgKj8QiE5RpiBC9++f2k/5blNaBD7FQXl+fG
 6GBA==
X-Gm-Message-State: AOJu0YwsZUlRz+zp/BwpVS0ukGcYgJQNnTMmzFF/hn2ZSNqkDvRvJaaj
 c8OALORXtuw+pGHh2SdHBbF7I07l9VrZDblggP3hTsxxnP8Au4FrevU2fp2hMFZn3KTCGZ7CF4F
 62pk9
X-Gm-Gg: ASbGncuoSRfV2FcAk6dZ+8omZE0Ma1Fhkl9dS01x3OXbZ1/Wdpu7s9u4ibhgqJNX5Qb
 nBDQGPv3BxMYjejwQP/UcjTa4yKUnG1YZmqnUyghp8FXr+rvb65ENcZKdftqepy7+dTZZuiqbvw
 782BGBEXEsVfYXJmJ2dzy5n6QlBa8TmT9q2ojSgK83IDZK2igvthlAMrzSTAWBMBbx24t/2kPra
 kVWV4aEismKOiFf1oO23WLp1dSuzaiFUMasM8JOcm/dg+iRN++3PKWgBk5Tk4CCJUwsEq2yhHC0
 DwZvN6q90Y8ksr0P0w+AsOP9cy92MbPnYsJrldLfguhOmEsQjGDYbDpHn9XnH9mSinbQxKx9ywf
 O88MK7knSEvyOp3hrrSbNag2JcA30kzq0n1/XZnMKt5gFjfu3QNFoSCgyPNoJKHqGVmaPztNofC
 mEb2gJ8WwhId7EHwbFKC4D
X-Google-Smtp-Source: AGHT+IFGHiB7Q5s86AukR0H5ftiP0DscZzZnoFX+By4Iu5OBY+p/awupF8lO7QSr6V3lRtOwFjtdWw==
X-Received: by 2002:a17:902:c78c:b0:23f:f39b:eae8 with SMTP id
 d9443c01a7336-23ff39bee2amr24259705ad.19.1753601854479; 
 Sun, 27 Jul 2025 00:37:34 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe327443sm29824635ad.44.2025.07.27.00.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:37:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 2/3] linux-user/aarch64: Support TPIDR2_MAGIC signal frame
 record
Date: Sat, 26 Jul 2025 21:37:27 -1000
Message-ID: <20250727073728.82913-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727073728.82913-1-richard.henderson@linaro.org>
References: <20250727073728.82913-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250725175510.3864231-3-peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 42 +++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 6514b73ad9..f28ba80754 100644
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


