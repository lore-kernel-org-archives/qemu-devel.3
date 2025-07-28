Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD015C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSTr-00024A-P6; Mon, 28 Jul 2025 14:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPT-0004tS-LO
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPP-0002pQ-TE
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so3162498b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726627; x=1754331427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVSdrHVg+gZm9GUqSrLIm0OvO9Omr02nYyCD4B9AD/U=;
 b=cV3B1wTgbUERLhzxV2nC/bqVibrH93C0UUDqD+cis86vuKfxZyVmL0+0cvPgM+NAib
 +cTSDVyj3+b3rMGubsIlAYlKznJ3HUTu+oG0LUwWmKgEXlDoPYfbOdOvfjP6Vs6GdX2w
 IgJPUctjNvDpXRmjGLVpRytqGzavLxEEYv9noCogpwcJKdXPcV1KIlPRShO6d8GjzaRx
 EbG1ppwO0G8k7oTvS04CX866Sj/1rQylRwCcfmzqPMKYmQSlSm+J0knQdWH0B2HCmq+5
 FienY1y5pIcr7zNBpusMez7Bbey0fA9vDwiDkJLqlQmjpICb8ey49WTwcblgWsNpXWPD
 xsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726627; x=1754331427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVSdrHVg+gZm9GUqSrLIm0OvO9Omr02nYyCD4B9AD/U=;
 b=UNMko1BEJC07spbYH85RwddkY6TawOdYGIbE9nmEe5KEVeV9brDZqs4K7NMW6ZysKy
 CVXLB781QlhJSRj3lBySCA4S9mAxYDLVpdk/8ct2tnxWR2Tq+JwG0VXn1SYIA1hKxd6T
 tXNIcU50Byjvt2xDDrHLFSAR6U79WVaFUVtzmpgiAtX05QxkDfOPqPreoFhTRf432Kcf
 boBTXg8bBvy/GYL5IivNkYiaqBKr13dqkaKSGuiqinsWYDMLxthI6czRKQUOepcBvLc7
 kaunERfCJV0sxE2PzrTDdjgRsickxLRlunW0FgfqZuiL+lHFvs/Ij8KctWUVus4i/lOR
 Vl3g==
X-Gm-Message-State: AOJu0YyYdzxLLyTcXS0wY9Ow0n3xFXMF6ZMdbGX7gAjN987YK5YYloIN
 opTywRuPOS+AdzfI5iGlg7qpTokho90d1X1tbVAX6q/SR06b+kbAm+pS5RakBrXEiN5Xv8cLnIm
 2xgfq
X-Gm-Gg: ASbGncuV8kJ1GxMS9fukQJ5Z/HkA9Sn9fnc+4hgBjAacAHxb/uhQdCzkCkQLX5rkSwD
 lnTt+koLEDtNA1+wcUnAP4bc3rPcg+b79xz1J31zrUX/MleyXW7LfNmEvFWY5w8qY+1f9RWgswj
 oMgTybw/sp3scsHQUdExkHlzCrE8Lqx1eQN90wqrSSqCIjV5AHSyGTEE2BS457GpeLbRmeTVFUr
 99XXQ5YdUoJkAnvOajcDX3A8eZMOgp4wN4OKFR6MMcdi+0b2dJ18WZKgABdj6SAzHtGhk1VTKE9
 Ojfv/sgiaAErcz6BPAbyv+1BB4O7rjCo0qvu1JyjOV5a6raWOELd06sp+z5O0XKXf1vYylJA2RB
 84XRleuOjXmJXLgjgWrIpbI7n4DM4yR7ZSpGlpMr9e09hsvrddmtQVbVSBlWU/jMrWU78oRfVRU
 Ff8859+BAj/g==
X-Google-Smtp-Source: AGHT+IGCwBqKOYm16KITns4JMIF/GhzMF8ZAIPJUUGu+bAhbne3snjAJ0zgzkhQUvh9vZYCwT0Mfkw==
X-Received: by 2002:a05:6a20:4327:b0:23d:35f2:4e69 with SMTP id
 adf61e73a8af0-23d70151064mr20143935637.23.1753726627185; 
 Mon, 28 Jul 2025 11:17:07 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:17:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 9/9] linux-user/aarch64: Support TPIDR2_MAGIC signal frame
 record
Date: Mon, 28 Jul 2025 08:16:50 -1000
Message-ID: <20250728181650.165114-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
(cherry picked from commit 99870aff907b1c863cd32558b543f0ab0d0e74ba)
---
 linux-user/aarch64/signal.c | 42 +++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 85cb25ae91..34168c967a 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -120,6 +120,13 @@ struct target_za_context {
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
@@ -252,6 +259,14 @@ static void target_setup_za_record(struct target_za_context *za,
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
@@ -402,6 +417,12 @@ static bool target_restore_za_record(CPUARMState *env,
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
@@ -409,6 +430,7 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_fpsimd_context *fpsimd = NULL;
     struct target_sve_context *sve = NULL;
     struct target_za_context *za = NULL;
+    struct target_tpidr2_context *tpidr2 = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     int sve_size = 0;
@@ -459,6 +481,14 @@ static int target_restore_sigframe(CPUARMState *env,
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
@@ -496,6 +526,9 @@ static int target_restore_sigframe(CPUARMState *env,
     if (za && !target_restore_za_record(env, za, za_size, &svcr)) {
         goto err;
     }
+    if (tpidr2) {
+        target_restore_tpidr2_record(env, tpidr2);
+    }
     if (env->svcr != svcr) {
         env->svcr = svcr;
         arm_rebuild_hflags(env);
@@ -567,8 +600,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
@@ -584,6 +617,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         sve_ofs = alloc_sigframe_space(sve_size, &layout);
     }
     if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+        tpidr2_size = sizeof(struct target_tpidr2_context);
+        tpidr2_ofs = alloc_sigframe_space(tpidr2_size, &layout);
         /* ZA state needs saving only if it is enabled.  */
         if (FIELD_EX64(env->svcr, SVCR, ZA)) {
             za_size = TARGET_ZA_SIG_CONTEXT_SIZE(sme_vq(env));
@@ -643,6 +678,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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


